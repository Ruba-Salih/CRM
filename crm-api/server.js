const express = require('express');
const mysql = require('mysql2/promise');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '.env') });

const { initJobs } = require('./jobs');

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(morgan('dev'));

const OLLAMA_MODEL = process.env.OLLAMA_MODEL || 'qwen2.5:latest';

// Helper function to call local Ollama for classification and intent scoring
async function classifyMessage(text, pool) {
    try {
        // Fetch official courses catalog
        let catalogText = "None (No courses in catalog)";
        try {
            if (pool) {
                const DB_ATC = process.env.DB_NAME_ATC || 'system_atc';
                const [courses] = await pool.query(`SELECT name, name_ar FROM \`${DB_ATC}\`.courses`);
                if (courses.length > 0) {
                    catalogText = courses.map(c => `- ${c.name} (${c.name_ar})`).join('\n');
                }
            }
        } catch (dbErr) {
            console.error('⚠️ Failed to pull courses for classification context:', dbErr.message);
        }

        console.log(`🤖 Prompting local Ollama to classify and score: "${text}"`);
        const response = await fetch('http://localhost:11434/api/generate', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                model: OLLAMA_MODEL,
                prompt: `You are an AI classifier for a training center CRM.
Based on the customer message below, perform THREE tasks:

1. Classify into EXACTLY ONE code:
   PERSONAL_OFFLINE_COURSES   — individual wants in-person/offline courses
   PERSONAL_ONLINE_COURSES    — individual wants online/remote courses OR does not specify delivery method
   CORPORATION_OFFLINE_COURSES — company wants in-person/offline courses
   CORPORATION_ONLINE_COURSES  — company wants online/remote courses OR company does not specify
   COMPLAINT
   TECHNICAL_SUPPORT
   GENERAL_ENQUIRY

   RULE A: If the user or their company mentions any specific course topic (e.g., Python, AI, Sales, Marketing, Mobile), classify as the matching COURSES code. NEVER use GENERAL_ENQUIRY for course-related messages.
   RULE B: Company/organization keywords ("شركة", "موظفين", "مؤسسة", "corporation", "employees", "enterprise") → use CORPORATION_* codes.
   RULE C: If delivery not mentioned → default to ONLINE variant.
   RULE D: Pure small talk or completely unrelated questions → GENERAL_ENQUIRY.

2. Hotness Score 0-100: how eager/ready is the customer to buy or enroll. Small talk = 0.

3. Extract or map to the official course name.
   Below is the OFFICIAL COURSE CATALOG of the center:
   ${catalogText}

   - If the user mentions or asks about a course or a topic that corresponds to one of the courses in the catalog above (even if they use synonyms, related terms, dialects, or indirect phrasings, e.g. "hacking/protection" -> "Cyber Security Professional", or "برمجة المواقع" -> "Web Development"), you MUST output the EXACT official English name of the matched course from the catalog.
   - If they ask generally without naming a course, output null.
   - If the request does not correspond to any course in the catalog, output the specific topic they requested as a fallback (e.g., "Mobile App Development").

Respond ONLY with a valid JSON object in this EXACT format (no markdown, no extra text):
{"code": "SELECTED_CODE", "score": SCORE_NUMBER, "course_name": "EXACT OFFICIAL COURSE NAME OR fallback string OR null"}

Customer Message: "${text}"`,
                stream: false
            })
        });

        const data = await response.json();
        let rawText = data.response.trim();

        // Remove reasoning/thinking tags from qwen3 models
        if (rawText.includes('</THINK>')) {
            const parts = rawText.split('</THINK>');
            rawText = parts[parts.length - 1].trim();
        }

        // Parse JSON
        let resultJson = { code: 'GENERAL_ENQUIRY', score: 50, course_name: null };
        try {
            const jsonStart = rawText.indexOf('{');
            const jsonEnd = rawText.lastIndexOf('}') + 1;
            if (jsonStart !== -1 && jsonEnd !== -1) {
                resultJson = JSON.parse(rawText.substring(jsonStart, jsonEnd));
            }
        } catch (e) {
            console.log('⚠️ Failed to parse classification JSON, defaulting');
            const match = rawText.match(/(PERSONAL_OFFLINE_COURSES|PERSONAL_ONLINE_COURSES|CORPORATION_OFFLINE_COURSES|CORPORATION_ONLINE_COURSES|COMPLAINT|TECHNICAL_SUPPORT|GENERAL_ENQUIRY)/);
            if (match) resultJson.code = match[1];
        }

        // Normalise course_name: treat string "null" or empty string as JS null
        if (!resultJson.course_name || resultJson.course_name === 'null' || resultJson.course_name.trim() === '') {
            resultJson.course_name = null;
        }

        console.log(`🤖 Ollama response:`, resultJson);
        return resultJson;
    } catch (error) {
        console.error('⚠️ Ollama classification failed:', error.message);
        return { code: 'GENERAL_ENQUIRY', score: 20, course_name: null };
    }
}

/**
 * Resolves a base COURSES code to the correct tier:
 *   - Course found in DB AND currently running  → keep base code (available)
 *   - Course found in DB but NOT running         → OUT_OF_PLAN_<suffix>
 *   - Course NOT found in DB at all              → NEW_COURSE_REQUEST_<suffix>
 * For non-course codes or missing course_name it passes through unchanged.
 */
async function resolveTicketCode(baseCode, courseName, pool) {
    // Only resolve base COURSES codes; leave others (COMPLAINT, GENERAL_ENQUIRY, etc.) untouched
    const BASE_COURSES = [
        'PERSONAL_ONLINE_COURSES',
        'PERSONAL_OFFLINE_COURSES',
        'CORPORATION_ONLINE_COURSES',
        'CORPORATION_OFFLINE_COURSES'
    ];
    if (!BASE_COURSES.includes(baseCode) || !courseName) return baseCode;

    try {
        const normalizedInput = courseName.replace(/[\s-]/g, '').toLowerCase();

        const DB_ATC = process.env.DB_NAME_ATC || 'system_atc';
        const [rows] = await pool.query(`
            SELECT
                c.id,
                (
                    SELECT COUNT(*)
                    FROM \`${DB_ATC}\`.running_courses rc
                    WHERE rc.course_id = c.id
                      AND rc.start_time > NOW()
                      AND rc.cancelled = 0
                ) AS active_runs
            FROM \`${DB_ATC}\`.courses c
            WHERE REPLACE(REPLACE(LOWER(c.name), ' ', ''), '-', '') LIKE CONCAT('%', ?, '%')
               OR REPLACE(REPLACE(LOWER(c.name_ar), ' ', ''), '-', '') LIKE CONCAT('%', ?, '%')
            LIMIT 1
        `, [normalizedInput, normalizedInput]);

        if (rows.length === 0) {
            // Completely unknown course → NEW_COURSE_REQUEST
            const resolved = `NEW_COURSE_REQUEST_${baseCode}`;
            console.log(`📋 Course "${courseName}" not in DB → ${resolved}`);
            return resolved;
        } else if (rows[0].active_runs === 0) {
            // Known course but no active running instance → OUT_OF_PLAN
            const resolved = `OUT_OF_PLAN_${baseCode}`;
            console.log(`📋 Course "${courseName}" exists but not running → ${resolved}`);
            return resolved;
        } else {
            // Course exists and is currently running → keep base code
            console.log(`📋 Course "${courseName}" is actively running → keep ${baseCode}`);
            return baseCode;
        }
    } catch (err) {
        console.error('⚠️ resolveTicketCode DB lookup failed:', err.message);
        return baseCode; // Safe fallback
    }
}
// ─── Scoring Helpers ────────────────────────────────────────────────────────

// Gap #1: enforce per-criterion caps before summing
function capScore(value, max) { return Math.min(Math.max(value, 0), max); }

// Gap #2: fetch historical baseline for a lead (once per ticket creation)
async function getHistoricalBaseline(leadId, pool) {
    try {
        // Fetch all ticket IDs for this lead first — avoid empty IN() which crashes MySQL
        const [allTkts] = await pool.query(`SELECT id, closed, sales_level_id FROM crm_tickets WHERE crm_lead_id = ?`, [leadId]);
        if (allTkts.length === 0) return 0; // cold lead — no history at all

        const tIds = allTkts.map(t => t.id);
        const tPH  = tIds.map(() => '?').join(',');

        // Count past successful sales
        const [soldLevels] = await pool.query(`SELECT id FROM crm_sales_ticket_levels WHERE code IN ('SOLD','POST_SALE','COMPLETED')`);
        if (soldLevels.length > 0) {
            const lvIds = soldLevels.map(r => r.id);
            const salesCount = allTkts.filter(t => t.closed === 1 && lvIds.includes(t.sales_level_id)).length;
            if (salesCount >= 3) return 60;
            if (salesCount >= 1) return 40;
        }

        // Chronic window shopper: 5+ closed tickets that never converted
        const [preSaleRow] = await pool.query(`SELECT id FROM crm_sales_ticket_levels WHERE code = 'PRE_SALE' LIMIT 1`);
        const preSaleId = preSaleRow.length > 0 ? preSaleRow[0].id : null;
        const closedNoSale = allTkts.filter(t => t.closed === 1 && (!t.sales_level_id || t.sales_level_id === preSaleId)).length;
        if (closedNoSale >= 5) return -30;

        // Refund / high-maintenance
        const [refunds] = await pool.query(
            `SELECT COUNT(*) as cnt FROM crm_ticket_messages WHERE crm_ticket_id IN (${tPH}) AND message_text LIKE ?`,
            [...tIds, '%استرداد%']
        );
        if (refunds[0].cnt > 0) return -50;

        // Discount seeker — last 3 ticket IDs
        const recentIds = tIds.slice(-3);
        const rPH = recentIds.map(() => '?').join(',');
        const [discMsgs] = await pool.query(
            `SELECT COUNT(*) as cnt FROM crm_ticket_messages WHERE crm_ticket_id IN (${rPH}) AND message_text LIKE ?`,
            [...recentIds, '%خصم%']
        );
        if (discMsgs[0].cnt >= 2) return -15;

        return 0;
    } catch (e) {
        console.error('⚠️ Historical baseline error:', e.message);
        return 0;
    }
}

// Gap #3: timing/velocity criterion based on last_interaction_time
async function getTimingScore(leadId, intentScore, pool) {
    try {
        const [rows] = await pool.query(
            `SELECT TIMESTAMPDIFF(MINUTE, last_interaction_time, NOW()) as mins_since FROM crm_leads WHERE id = ?`,
            [leadId]
        );
        if (!rows[0] || rows[0].mins_since === null) return 0;
        const mins = rows[0].mins_since;
        const isBuyingIntent = intentScore >= 25; // price/payment signals

        if (mins < 10)  return capScore(isBuyingIntent ? 25 : 10, 25);
        if (mins < 60)  return capScore(isBuyingIntent ? 15 : 5,  25);
        if (mins < 360) return capScore(isBuyingIntent ? 5  : 2,  25);
        if (mins < 720) return capScore(isBuyingIntent ? 2  : 0,  25);
        return -10; // > 24h cumulative penalty handled by timer decay
    } catch (e) {
        console.error('⚠️ Timing score error:', e.message);
        return 0;
    }
}

// Determine lead status label from ticket score
function getLeadStatus(score) {
    if (score >= 165) return 'CONFIRMED';
    if (score >= 100) return 'HOT';
    if (score >= 50)  return 'WARM';
    return 'COOL';
}

// Check if message is an instructor join request (Gap #6)
function isInstructorRequest(text) {
    const triggers = ['أنا مدرب', 'عايز أنزل ورشة', 'عندكم نظام تعاون', 'أقدم كورس عندكم', 'ورشة عمل', 'مدرب وعايز', 'أفيدكم بورش'];
    return triggers.some(t => text && text.includes(t));
}

// Check if message is a fallback / trust-loss signal (Gap #5 & Case 1)
function isTrustLoss(text) {
    const triggers = ['أنت روبوت', 'كلامك ده محفوظ', 'أديني زول', 'أتفاهم معاهو', 'ما فهمت', 'نفس الكلام'];
    return triggers.some(t => text && text.includes(t));
}

async function generateAiReply(text, classification, courseContext = "", requirementsContext = "", ticketScore = 0) {
    try {
        console.log(`🤖 Prompting local Ollama to generate a conversational response (Ticket Score: ${ticketScore})...`);
        const response = await fetch('http://localhost:11434/api/generate', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                model: OLLAMA_MODEL,
                prompt: `You are a customer service specialist at Afro-Tech Training Center. Respond naturally and helpfully — never reveal you are an AI or a bot.

Customer Message: "${text}"
Classification: ${classification}
Lead Status: ${getLeadStatus(ticketScore)} (Score: ${ticketScore})

${courseContext ? `=== AVAILABLE COURSES CATALOG ===\n${courseContext}\n================================` : ''}
${requirementsContext ? `=== CENTER POLICIES & FAQ ===\n${requirementsContext}\n================================` : ''}

BEHAVIOR BY LEAD STATUS:
- COOL (0-49): Answer factually. Do NOT mention payment or push enrollment.
- WARM (50-99): Highlight course benefits. Mention start date/deadline if available.
- HOT (100-164): Gently encourage payment. Mention Bankak or Fawry from registration_methods. Ask for WhatsApp number naturally to send payment link.
- CONFIRMED (165): Thank them warmly. Confirm enrollment steps.

STRICT RULES:
1. You ARE the support. Never say "contact support" — solve it yourself.
2. Technical issues: use الدعم الفني وحلول المشاكل التقنية from context.
3. Registration: use registration_methods steps exactly.
4. Refunds: quote refund_policy data exactly — do not paraphrase.
5. Course details: only use CATALOG data. Never invent prices or dates.
6. Language: Arabic only. Sudanese dialect when appropriate.
7. Never reveal you are AI or a bot.`,
                stream: false
            })
        });

        const data = await response.json();
        let reply = data.response.trim();
        // Strip thinking tags from models that emit them
        if (reply.includes('</THINK>')) {
            const parts = reply.split('</THINK>');
            reply = parts[parts.length - 1].trim();
        }
        console.log(`🤖 Ollama reply: "${reply}"`);
        return reply;
    } catch (error) {
        console.error('⚠️ Ollama reply generation failed:', error.message);
        return 'شكراً لتواصلك معنا، سيتم تحويل طلبك للقسم المختص للرد فوراً.';
    }
}

// Configure DB connection
const pool = mysql.createPool({
    host: process.env.DB_HOST || '127.0.0.1',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME_TEST4 || 'test4_atc',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    multipleStatements: true,
    charset: 'utf8mb4'
});

// Start background jobs passing the DB pool
initJobs(pool);

app.post('/api/webhook/messenger', async (req, res) => {
    console.log(`📩 Incoming request from ${req.body.platform_user_id}: ${req.body.text}`);
    const startTime = Date.now();
    const {
        platform = 'facebook',
        interaction_type = 'message',
        platform_user_id,
        text,
        ai_score = 0,
        ai_ticket_type_code = 'GENERAL_ENQUIRY',
        ai_program_id = null,
        attachment_url = null
    } = req.body;

    let ticketCode = ai_ticket_type_code;
    let computedScore = ai_score || 0;
    let extractedCourseName = null;

    if (ticketCode === 'GENERAL_ENQUIRY' || ticketCode === 'AUTO') {
        const classificationResult = await classifyMessage(text, pool);
        ticketCode = classificationResult.code;
        computedScore = classificationResult.score;
        extractedCourseName = classificationResult.course_name || null;

        // Promote PERSONAL_*/CORPORATION_* base codes to OUT_OF_PLAN_* or NEW_COURSE_REQUEST_*
        // depending on whether the requested course exists/runs in the DB
        ticketCode = await resolveTicketCode(ticketCode, extractedCourseName, pool);
    }

    let courseContext = "";
    // Fetch rich course context for any course-related classification OR for general enquiries
    // (so follow-up questions like "نعم ماذا متاح؟" still get real data)
    const needsCourseContext = ticketCode.includes('COURSES') || ticketCode === 'GENERAL_ENQUIRY';
    const DB_ATC = process.env.DB_NAME_ATC || 'system_atc';

    // Fetch dynamic requirements (policies, registration, etc.) and Support KB
    let requirementsContext = "";
    try {
        const [reqs] = await pool.query(`SELECT key_name, content_ar FROM crm_dynamic_requirements`);
        if (reqs.length > 0) {
            requirementsContext += "=== سياسات ومعلومات المركز ===\n" +
                reqs.map(r => `🔹 ${r.key_name}: ${r.content_ar}`).join("\n\n") + "\n\n";
        }

        const [supportKbs] = await pool.query(`SELECT problem_title_ar, solution_ar FROM crm_support_kb`);
        if (supportKbs.length > 0) {
            requirementsContext += "=== الدعم الفني وحلول المشاكل التقنية (استخدمها لحل مشاكل المنصة والفيديوهات والحسابات) ===\n" +
                supportKbs.map(s => `🔹 مشكلة (${s.problem_title_ar}): ${s.solution_ar}`).join("\n\n") + "\n\n";
        }
    } catch (reqErr) {
        console.error('⚠️ Failed to pull dynamic requirements or support kb:', reqErr.message);
    }

    if (needsCourseContext) {
        try {
            // Fetch all upcoming active courses with FULL details from both tables
            const [courses] = await pool.query(`
                SELECT
                    c.id,
                    c.name                                                      AS name_en,
                    COALESCE(c.name_ar, c.name)                                 AS name_ar,
                    COALESCE(c.descr_ar, c.descr)                               AS description,
                    COALESCE(c.short_descr_ar, c.short_descr)                   AS short_description,
                    rc.price_sdg,
                    rc.price_usd,
                    rc.discount,
                    rc.tot_seats,
                    rc.alias                                                     AS group_alias,
                    rc.reg_deadline,
                    rc.tot_hours                                                 AS total_hours,
                    DATE_FORMAT(rc.start_time,  '%Y-%m-%d')                     AS start_date,
                    DATE_FORMAT(rc.finish_time, '%Y-%m-%d')                     AS end_date,
                    IF(rc.room_id IS NULL, 'أونلاين', 'حضورياً في المركز')     AS delivery_method,
                    COALESCE(u.descr_ar, u.descr)                               AS trainer_description
                FROM \`${DB_ATC}\`.running_courses rc
                JOIN \`${DB_ATC}\`.courses c ON rc.course_id = c.id
                LEFT JOIN \`${DB_ATC}\`.users u ON rc.trainer_id = u.id
                WHERE rc.start_time > NOW() AND rc.cancelled = 0
                ORDER BY rc.start_time ASC
                LIMIT 10
            `);

            for (let c of courses) {
                c.outcomesList = [];
                c.outlinesList = [];
            }

            if (courses.length > 0) {
                courseContext = "=== الدورات المتاحة حالياً ===\n" +
                    courses.map(c => {
                        const discountNote = parseFloat(c.discount) > 0 ? ` (خصم ${c.discount}%)` : '';
                        const regNote = c.reg_deadline ? ` | آخر موعد للتسجيل: ${c.reg_deadline}` : '';
                        const seatsNote = c.tot_seats ? ` | المقاعد المتاحة: ${c.tot_seats}` : '';
                        const hoursNote = c.total_hours ? ` | إجمالي الساعات: ${c.total_hours} ساعة` : '';

                        let info = `\n📘 دورة: ${c.name_ar} (${c.name_en})`;
                        info += `\n   طريقة التقديم: ${c.delivery_method}`;
                        info += `\n   السعر: ${parseFloat(c.price_sdg).toLocaleString('ar-EG')} جنيه سوداني / ${parseFloat(c.price_usd).toLocaleString('ar-EG')} دولار أمريكي${discountNote}`;
                        info += `\n   تاريخ البداية: ${c.start_date}`;
                        if (c.end_date)   info += ` | تاريخ النهاية: ${c.end_date}`;
                        info += hoursNote + seatsNote + regNote;
                        if (c.group_alias) info += `\n   المجموعة: ${c.group_alias}`;
                        if (c.description) info += `\n   الوصف: ${c.description}`;
                        if (c.short_description) info += `\n   ملخص: ${c.short_description}`;
                        if (c.outcomesList && c.outcomesList.length > 0) {
                            info += `\n   ماذا ستتعلم:\n     • ` + c.outcomesList.join('\n     • ');
                        }
                        if (c.outlinesList && c.outlinesList.length > 0) {
                            info += `\n   المحاور الرئيسية:\n     • ` + c.outlinesList.join('\n     • ');
                        }
                        if (c.trainer_description) {
                            // Trim and clean up the description for the AI
                            let cleanTrainerDesc = c.trainer_description.replace(/<[^>]+>/g, '').replace(/\n+/g, ' ').trim();
                            info += `\n   معلومات المدرب: ${cleanTrainerDesc}`;
                        }
                        return info;
                    }).join("\n\n");
                courseContext += "\n\n=== نهاية قائمة الدورات ===";
            } else {
                courseContext = "لا توجد دورات متاحة حالياً في قاعدة البيانات.";
            }
        } catch (dbErr) {
            console.error('⚠️ Failed to pull courses for context:', dbErr.message);
        }
    }

    if (!platform_user_id || !text) {
        return res.status(400).json({ error: 'Missing platform_user_id or text payload.' });
    }

    try {
        // 1. Fetch Timer Configurations
        const [configRows] = await pool.query(`SELECT title, value FROM atc_config WHERE title LIKE 'crm_%timer%'`);
        const timerConfig = {};
        configRows.forEach(row => {
            timerConfig[row.title] = parseInt(row.value);
        });

        const preSaleMinutes = timerConfig['crm_pre_sale_timer_minutes'] || 1435;
        const complaintMinutes = timerConfig['crm_complaint_timer_minutes'] || 240;
        const technicalMinutes = timerConfig['crm_technical_timer_minutes'] || 240;

        // 2. Resolve or Create Lead
        let [leads] = await pool.query(
            'SELECT id FROM crm_leads l WHERE EXISTS (SELECT 1 FROM crm_lead_social_profiles lsp WHERE l.id = lsp.crm_lead_id AND lsp.platform = ? AND lsp.platform_user_id = ?) LIMIT 1',
            [platform, platform_user_id]
        );

        let leadId;
        if (leads.length === 0) {
            const [leadResult] = await pool.query('INSERT INTO crm_leads (created) VALUES (NOW())');
            leadId = leadResult.insertId;
            await pool.query(
                'INSERT INTO crm_lead_social_profiles (crm_lead_id, platform, platform_user_id, display_name) VALUES (?, ?, ?, ?)',
                [leadId, platform, platform_user_id, `Unknown_${platform_user_id}`]
            );
        } else {
            leadId = leads[0].id;
        }

        // Update last interaction time for Lead
        await pool.query('UPDATE crm_leads SET last_interaction_time = NOW() WHERE id = ?', [leadId]);

        // 3. Fetch All Open Tickets for the Lead
        let [openTickets] = await pool.query(`
            SELECT t.id, t.score, t.crm_ticket_type_id, t.sales_level_id, t.running_program_id, tt.code as ticket_type_code
            FROM crm_tickets t
            JOIN crm_ticket_types tt ON t.crm_ticket_type_id = tt.id
            WHERE t.crm_lead_id = ? AND t.closed = 0
            ORDER BY t.created DESC
        `, [leadId]);

        // Find existing ticket types
        const salesTicket = openTickets.find(t => (t.crm_ticket_type_id >= 1 && t.crm_ticket_type_id <= 24) || t.ticket_type_code.startsWith('PERSONAL') || t.ticket_type_code.startsWith('CORPORATION'));
        const complaintTicket = openTickets.find(t => t.ticket_type_code === 'COMPLAINT' || t.crm_ticket_type_id === 26);
        const techTicket = openTickets.find(t => t.ticket_type_code === 'TECHNICAL_SUPPORT' || t.crm_ticket_type_id === 25);
        const postSaleTicket = openTickets.find(t => t.ticket_type_code === 'POST_SALE_FOLLOWUP');

        // ── SCORING ENGINE (6 Criteria with per-criterion caps) ─────────────────
        let transferToHuman = false;
        let forceClose = false;
        let ticketScoreZero = false;
        let currentTicketScore = 0;

        // === Human Handover Detection (must run first, before scoring) ===
        // Case 1: Trust loss / anger
        if (isTrustLoss(text)) { transferToHuman = true; }
        // Case 2: B2B / Corporation
        if (ticketCode.includes('CORPORATION') || (text && (text.includes('شركتنا') || text.includes('موظفين') || text.includes('عرض سعر رسمي')))) { transferToHuman = true; }
        // Case 4: Instructor join request
        if (isInstructorRequest(text)) { transferToHuman = true; }

        // === Criterion 1: Platform Score (max 25) ===
        let platformPts = 0;
        const platStr = (platform || '').toLowerCase();
        if (platStr === 'whatsapp' || platStr === 'telegram' || platStr === 'pstn') platformPts = 25;
        else if (interaction_type === 'message') platformPts = 15;  // DM on FB/IG/TT
        else platformPts = 10;  // comment
        platformPts = capScore(platformPts, 25);

        // === Criterion 2: Intent Score (max 50) — mapped from AI raw 0-100 ===
        // buying signal phrases override AI score
        const BUYING_SIGNALS   = ['رقم الحساب', 'ادفع كيف', 'رابط التسجيل', 'بنكك', 'خلاص سجلني', 'اعتمد'];
        const CONFIRM_SIGNALS  = ['خلاص تمام', 'سجلني', 'موافق', 'حجز'];
        const PRICE_SIGNALS    = ['بكم', 'السعر', 'خصم', 'كود', 'تقسيط', 'طرق الدفع', 'في خصم'];
        const VALID_SIGNALS    = ['طيب جميل', 'واضح', 'ممتاز', 'التسجيل', 'الرابط'];
        const LOGISTICS_SIGNALS = ['متى يبدأ', 'كم المدة', 'حضوري', 'أونلاين', 'منو المدرب', 'أيام الكورس'];

        let intentPts = 0;
        if (BUYING_SIGNALS.some(s => text && text.includes(s)))   intentPts = 50;
        else if (CONFIRM_SIGNALS.some(s => text && text.includes(s)))  intentPts = 25;
        else if (PRICE_SIGNALS.some(s => text && text.includes(s)))    intentPts = 25;
        else if (VALID_SIGNALS.some(s => text && text.includes(s)))    intentPts = 15;
        else if (LOGISTICS_SIGNALS.some(s => text && text.includes(s))) intentPts = 5;
        else intentPts = Math.round((computedScore / 100) * 10); // fallback: map AI score to max 10
        intentPts = capScore(intentPts, 50);

        // === Criterion 3: Timing/Velocity (max 25) ===
        const timingPts = capScore(await getTimingScore(leadId, intentPts, pool), 25);

        // === Criterion 4: Historical Baseline (max ±60) ===
        const historyPts = await getHistoricalBaseline(leadId, pool);

        // === Criterion 5: Reaction (max ±5) ===
        let reactionPts = 0;
        if (interaction_type === 'reaction') {
            if (['❤️', '👍', '😲', '😍'].includes(text)) reactionPts = capScore(5, 5);
            if (['😡', '😢', '👎', '😠'].includes(text)) reactionPts = -5;
        }

        // === Criterion 6: Deductions ===
        let deductionPts = 0;
        if (text) {
            if (text.includes('غالي') || text.includes('ما عندي ميزانية') || text.includes('أرخص'))  deductionPts -= 15;
            if (text.includes('سأرد لاحقاً') || text.includes('بشوف'))  deductionPts -= 30;
            if (text.includes('ما عايز') || text.includes('لا اريد') || text.includes('لا أريد') || text.includes('غير مهتم') || text.includes('احذف رقمي')) {
                ticketScoreZero = true;
                forceClose = true;
            }
        }

        // === Final Score (natural sum, floor 0) ===
        let messageScoreDelta = platformPts + intentPts + timingPts + reactionPts + deductionPts;
        // NOTE: historyPts is baseline applied once at ticket creation, not per-message

        console.log(`📊 Score breakdown → Platform:${platformPts} Intent:${intentPts} Timing:${timingPts} History:${historyPts} Reaction:${reactionPts} Deductions:${deductionPts}`);

        let ticketId = null;
        let actionTaken = '';
        let timerType = null;
        let timerMinutes = 1435;

        // === Case 3: Fallback counter check (Gap #5) ===
        if (salesTicket && ticketCode === 'GENERAL_ENQUIRY') {
            await pool.query(`UPDATE crm_tickets SET fallback_count = fallback_count + 1, updated = NOW() WHERE id = ?`, [salesTicket.id]);
            const [fbRow] = await pool.query(`SELECT fallback_count FROM crm_tickets WHERE id = ?`, [salesTicket.id]);
            if (fbRow[0].fallback_count >= 3) { transferToHuman = true; } // Case 3: fallback loop
        }

        // 5. Ticket routing cases logic
        const isSaleCode = ticketCode.startsWith('DEEP_INFO') || ticketCode.startsWith('PERSONAL') || ticketCode.startsWith('CORPORATION');

        if ((salesTicket && ticketCode !== 'COMPLAINT' && ticketCode !== 'TECHNICAL_SUPPORT') || isSaleCode) {
            if (salesTicket) {
                ticketId = salesTicket.id;
                // Accumulate score on existing ticket (history already baked in from creation)
                let updatedScore = Math.max(0, (salesTicket.score || 0) + messageScoreDelta);
                if (ticketScoreZero) updatedScore = 0;

                currentTicketScore = updatedScore;

                let closeQuery = forceClose ? ', closed = 1' : '';
                await pool.query(`UPDATE crm_tickets SET score = ?, transfer_to_human = GREATEST(transfer_to_human, ?) ${closeQuery}, updated = NOW() WHERE id = ?`,
                    [updatedScore, transferToHuman ? 1 : 0, ticketId]);

                if (ai_program_id && salesTicket.running_program_id !== ai_program_id)
                    await pool.query(`UPDATE crm_tickets SET running_program_id = ?, updated = NOW() WHERE id = ?`, [ai_program_id, ticketId]);

                actionTaken = forceClose ? 'CLOSED_SALES_TICKET_REJECTION' : 'UPDATED_SALES_TICKET';

                const status = getLeadStatus(updatedScore);
                if (status === 'HOT' || status === 'CONFIRMED') console.log(`🔥 ${status} LEAD! Ticket:${ticketId} Score:${updatedScore}`);

            } else {
                // New sales ticket — apply history baseline to initial score
                const [typeRes] = await pool.query(`SELECT id FROM crm_ticket_types WHERE code = ? LIMIT 1`, [ticketCode]);
                const typeId = typeRes.length > 0 ? typeRes[0].id : 1;
                let [preSaleLevel] = await pool.query(`SELECT id FROM crm_sales_ticket_levels WHERE code = 'PRE_SALE' LIMIT 1`);
                const preSaleLevelId = preSaleLevel.length > 0 ? preSaleLevel[0].id : 1;

                let initialScore = Math.max(0, messageScoreDelta + historyPts);
                currentTicketScore = initialScore;

                const [newTicket] = await pool.query(
                    `INSERT INTO crm_tickets (crm_lead_id, crm_ticket_type_id, sales_level_id, title, running_program_id, running_program_type, score, transfer_to_human, closed, created, updated)
                     VALUES (?, ?, ?, ?, ?, 'Course', ?, ?, ?, NOW(), NOW())`,
                    [leadId, typeId, preSaleLevelId, `مبيعات — ${ticketCode}`, ai_program_id, initialScore, transferToHuman ? 1 : 0, forceClose ? 1 : 0]
                );
                ticketId = newTicket.insertId;
                actionTaken = 'CREATED_SALES_TICKET';
            }
            timerType = forceClose ? null : 'PRE_SALE_FOLLOWUP';
            timerMinutes = preSaleMinutes;

        } else if (ticketCode === 'COMPLAINT') {
            if (complaintTicket) {
                ticketId = complaintTicket.id;
                currentTicketScore = complaintTicket.score || 0;
                actionTaken = 'UPDATED_COMPLAINT_TICKET';
            } else {
                const initScore = Math.max(0, messageScoreDelta);
                const [newTicket] = await pool.query(
                    `INSERT INTO crm_tickets (crm_lead_id, crm_ticket_type_id, title, score, created, updated) VALUES (?, 26, ?, ?, NOW(), NOW())`,
                    [leadId, `شكوى — ${new Date().toISOString().slice(0,10)}`, initScore]
                );
                ticketId = newTicket.insertId;
                currentTicketScore = initScore;
                actionTaken = 'CREATED_COMPLAINT_TICKET';
            }
            timerType = 'COMPLAINT_FOLLOWUP';
            timerMinutes = complaintMinutes;

        } else if (ticketCode === 'TECHNICAL_SUPPORT') {
            if (techTicket) {
                ticketId = techTicket.id;
                currentTicketScore = techTicket.score || 0;
                actionTaken = 'UPDATED_TECH_TICKET';
            } else {
                const initScore = Math.max(0, messageScoreDelta);
                const [newTicket] = await pool.query(
                    `INSERT INTO crm_tickets (crm_lead_id, crm_ticket_type_id, title, score, created, updated) VALUES (?, 25, ?, ?, NOW(), NOW())`,
                    [leadId, `دعم فني — ${new Date().toISOString().slice(0,10)}`, initScore]
                );
                ticketId = newTicket.insertId;
                currentTicketScore = initScore;
                actionTaken = 'CREATED_TECH_TICKET';
            }
            timerType = 'TECHNICAL_SUPPORT_FOLLOWUP';
            timerMinutes = technicalMinutes;

        } else if (ticketCode.startsWith('OUT_OF_PLAN') || ticketCode.startsWith('NEW_COURSE_REQUEST')) {
            const [typeRes] = await pool.query(`SELECT id FROM crm_ticket_types WHERE code = ? LIMIT 1`, [ticketCode]);
            const typeId = typeRes.length > 0 ? typeRes[0].id : 46;

            const [newTicket] = await pool.query(
                `INSERT INTO crm_tickets (crm_lead_id, crm_ticket_type_id, title, created, updated) VALUES (?, ?, ?, NOW(), NOW())`,
                [leadId, typeId, `طلب — ${ticketCode}`]
            );
            ticketId = newTicket.insertId;
            actionTaken = 'CREATED_OUT_OF_PLAN_TICKET_NO_TIMER';

        } else {
            // For GENERAL_ENQUIRY: reflect existing ticket score so status is accurate
            if (salesTicket) {
                ticketId = salesTicket.id;
                currentTicketScore = salesTicket.score || 0;
            } else if (techTicket) {
                ticketId = techTicket.id;
                currentTicketScore = techTicket.score || 0;
            } else if (complaintTicket) {
                ticketId = complaintTicket.id;
                currentTicketScore = complaintTicket.score || 0;
            } else if (postSaleTicket) {
                ticketId = postSaleTicket.id;
            }

            actionTaken = ticketId ? 'LOGGED_TO_EXISTING_TICKET' : 'GENERAL_ENQUIRY_NO_TICKET';
        }

        // 5. Cancel Old Pending Timers and Create New One if needed
        if (ticketId && timerType) {
            await pool.query(`UPDATE crm_ticket_timers SET status = 'cancelled' WHERE crm_ticket_id = ? AND status = 'pending'`, [ticketId]);
            
            const scheduledAt = new Date(Date.now() + timerMinutes * 60 * 1000);
            await pool.query(
                `INSERT INTO crm_ticket_timers (crm_ticket_id, timer_type, sequence_no, scheduled_at, status) VALUES (?, ?, 1, ?, 'pending')`,
                [ticketId, timerType, scheduledAt]
            );
        }

        const aiReply = await generateAiReply(text, ticketCode, courseContext, requirementsContext, currentTicketScore);

        // 7. Log the Customer Message
        await pool.query(
            `INSERT INTO crm_ticket_messages (crm_ticket_id, platform, interaction_type, message_text, attachment_url, router_value, sender_type, created) 
             VALUES (?, ?, ?, ?, ?, ?, 'customer', NOW())`,
            [ticketId || 0, platform, interaction_type, text, attachment_url, ticketCode]
        );

        const duration = ((Date.now() - startTime) / 1000).toFixed(3);
        console.log(`⏱️ AI Processing took ${duration} seconds`);


        res.json({
            status: "SUCCESS",
            lead_id: leadId,
            ticket_id: ticketId,
            action: actionTaken,
            resolved_ticket_type: ticketCode,
            extracted_course_name: extractedCourseName || null,
            ticket_score: currentTicketScore,
            lead_status: getLeadStatus(currentTicketScore),
            transfer_to_human: transferToHuman,
            ai_reply: aiReply,
            timer_created: timerType ? true : false,
            message_logged: text
        });

    } catch (error) {
        console.error("Database Error: ", error);
        res.status(500).json({ error: 'Database transaction failed', details: error.message });
    }
});

app.listen(port, async () => {
    console.log(`✅ CRM Webhook Simulator with background jobs running on http://localhost:${port}`);

    // Automatically trigger ngrok tunnel exposure
    try {
        const ngrok = require('@ngrok/ngrok');
        const tunnel = await ngrok.forward({ addr: port, authtoken: process.env.NGROK_AUTHTOKEN });
        console.log(`🌍 ngrok tunnel opened at: ${tunnel.url()}`);
    } catch (err) {
        console.error('⚠️ Could not establish ngrok tunnel:', err.message);
    }
});
