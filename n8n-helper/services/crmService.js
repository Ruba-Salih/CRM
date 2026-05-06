const { pool } = require("../db");

/**
 * Resolves a base COURSES code to the correct tier:
 *   - Course found in DB AND currently running  → keep base code (available)
 *   - Course found in DB but NOT running         → OUT_OF_PLAN_<suffix>
 *   - Course NOT found in DB at all              → NEW_COURSE_REQUEST_<suffix>
 */
async function resolveTicketCode(baseCode, courseName) {
    const BASE_COURSES = [
        'PERSONAL_ONLINE_COURSES',
        'PERSONAL_OFFLINE_COURSES',
        'CORPORATION_ONLINE_COURSES',
        'CORPORATION_OFFLINE_COURSES'
    ];
    if (!BASE_COURSES.includes(baseCode) || !courseName) return baseCode;

    try {
        const normalizedInput = courseName.replace(/[\s-]/g, '').toLowerCase();
        const DB_ATC = 'test4_atc'; // Courses are in test4_atc (migrated from system_atc)
        
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
            return `NEW_COURSE_REQUEST_${baseCode}`;
        } else if (rows[0].active_runs === 0) {
            return `OUT_OF_PLAN_${baseCode}`;
        } else {
            return baseCode;
        }
    } catch (err) {
        console.error('⚠️ resolveTicketCode failed:', err.message);
        return baseCode;
    }
}

async function getHistoricalBaseline(leadId) {
    try {
        const [allTkts] = await pool.query(`SELECT id, closed, sales_level_id FROM crm_tickets WHERE crm_lead_id = ?`, [leadId]);
        if (allTkts.length === 0) return 0;

        const tIds = allTkts.map(t => t.id);
        const tPH  = tIds.map(() => '?').join(',');

        const [soldLevels] = await pool.query(`SELECT id FROM crm_sales_ticket_levels WHERE code IN ('SOLD','POST_SALE','COMPLETED')`);
        if (soldLevels.length > 0) {
            const lvIds = soldLevels.map(r => r.id);
            const salesCount = allTkts.filter(t => t.closed === 1 && lvIds.includes(t.sales_level_id)).length;
            if (salesCount >= 3) return 60;
            if (salesCount >= 1) return 40;
        }

        const [preSaleRow] = await pool.query(`SELECT id FROM crm_sales_ticket_levels WHERE code = 'PRE_SALE' LIMIT 1`);
        const preSaleId = preSaleRow.length > 0 ? preSaleRow[0].id : null;
        const closedNoSale = allTkts.filter(t => t.closed === 1 && (!t.sales_level_id || t.sales_level_id === preSaleId)).length;
        if (closedNoSale >= 5) return -30;

        const [refunds] = await pool.query(
            `SELECT COUNT(*) as cnt FROM crm_ticket_messages WHERE crm_ticket_id IN (${tPH}) AND message_text LIKE ?`,
            [...tIds, '%استرداد%']
        );
        if (refunds[0].cnt > 0) return -50;

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

async function getTimingScore(leadId, intentScore) {
    try {
        const [rows] = await pool.query(
            `SELECT TIMESTAMPDIFF(MINUTE, last_interaction_time, NOW()) as mins_since FROM crm_leads WHERE id = ?`,
            [leadId]
        );
        if (!rows[0] || rows[0].mins_since === null) return 0;
        const mins = rows[0].mins_since;
        const isBuyingIntent = intentScore >= 25;

        if (mins < 10)  return Math.min(isBuyingIntent ? 25 : 10, 25);
        if (mins < 60)  return Math.min(isBuyingIntent ? 15 : 5,  25);
        if (mins < 360) return Math.min(isBuyingIntent ? 5  : 2,  25);
        if (mins < 720) return Math.min(isBuyingIntent ? 2  : 0,  25);
        return -10;
    } catch (e) {
        console.error('⚠️ Timing score error:', e.message);
        return 0;
    }
}

function getLeadStatus(score) {
    if (score >= 165) return 'CONFIRMED';
    if (score >= 100) return 'HOT';
    if (score >= 50)  return 'WARM';
    return 'COOL';
}

function isInstructorRequest(text) {
    const triggers = ['أنا مدرب', 'عايز أنزل ورشة', 'عندكم نظام تعاون', 'أقدم كورس عندكم', 'ورشة عمل', 'مدرب وعايز', 'أفيدكم بورش'];
    return triggers.some(t => text && text.includes(t));
}

function isTrustLoss(text) {
    const triggers = ['أنت روبوت', 'كلامك ده محفوظ', 'أديني زول', 'أتفاهم معاهو', 'ما فهمت', 'نفس الكلام'];
    return triggers.some(t => text && text.includes(t));
}

module.exports = {
    resolveTicketCode,
    getHistoricalBaseline,
    getTimingScore,
    getLeadStatus,
    isInstructorRequest,
    isTrustLoss
};
