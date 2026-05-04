const mysql = require('mysql2/promise');
require('dotenv').config();

let pool;

async function initDb() {
    pool = mysql.createPool({
        host: process.env.DB_HOST || 'localhost',
        user: process.env.DB_USER || 'root',
        password: process.env.DB_PASSWORD || '',
        database: process.env.DB_NAME_TEST4 || 'test4_atc',
    });
}

async function post(userId, text, platform = 'facebook') {
    const r = await fetch('http://localhost:3000/api/webhook/messenger', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ platform, platform_user_id: userId, text, ai_ticket_type_code: 'AUTO' })
    });
    return r.json();
}

function fmt(d) {
    return `Status:${d.lead_status}(${d.ticket_score}) | Action:${d.action} | Human:${d.transfer_to_human}\n   🤖 ${(d.ai_reply||'').split('\n')[0].substring(0,120)}`;
}

async function printDbState(leadId, ticketId) {
    if (!pool) return;
    console.log(`\n   🔍 [Database State for Lead ${leadId} | Ticket ${ticketId}]`);
    
    // 1. Leads
    const [leads] = await pool.query('SELECT id, last_interaction_time FROM crm_leads WHERE id = ?', [leadId]);
    if (leads.length) console.log(`      - crm_leads: last_interaction_time = ${leads[0].last_interaction_time.toISOString()}`);
    
    // 2. Profiles
    const [profiles] = await pool.query('SELECT platform, platform_user_id FROM crm_lead_social_profiles WHERE crm_lead_id = ?', [leadId]);
    if (profiles.length) console.log(`      - crm_lead_social_profiles: platform = ${profiles[0].platform}, user_id = ${profiles[0].platform_user_id}`);

    // 3. Tickets
    if (ticketId) {
        const [tickets] = await pool.query('SELECT score, transfer_to_human, closed, title FROM crm_tickets WHERE id = ?', [ticketId]);
        if (tickets.length) {
            const t = tickets[0];
            console.log(`      - crm_tickets: title = "${t.title}", score = ${t.score}, human = ${t.transfer_to_human}, closed = ${t.closed}`);
        }

        // 4. Messages (Count and latest)
        const [msgs] = await pool.query('SELECT router_value, interaction_type FROM crm_ticket_messages WHERE crm_ticket_id = ? ORDER BY id DESC LIMIT 1', [ticketId]);
        const [msgCount] = await pool.query('SELECT COUNT(*) as c FROM crm_ticket_messages WHERE crm_ticket_id = ?', [ticketId]);
        if (msgs.length) {
            console.log(`      - crm_ticket_messages: total_messages = ${msgCount[0].c}, latest_router_value = ${msgs[0].router_value}`);
        }

        // 5. Timers
        const [timers] = await pool.query('SELECT timer_type, status FROM crm_ticket_timers WHERE crm_ticket_id = ? ORDER BY id DESC LIMIT 2', [ticketId]);
        if (timers.length) {
            console.log(`      - crm_ticket_timers: ` + timers.map(tm => `[${tm.timer_type} -> ${tm.status}]`).join(', '));
        }
    }
    console.log('');
}

async function run() {
    await initDb();
    const ts = Date.now();
    console.log('\n====== TEST 1: Cool Lead — Simple Inquiry ======');
    let r = await post(`cool_${ts}`, 'ما هي الكورسات اللي عندكم؟');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 2: Warm Lead — Logistics Questions ======');
    const warm = `warm_${ts}`;
    r = await post(warm, 'عندكم كورس بايثون؟ متى يبدأ وكم المدة؟');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);
    r = await post(warm, 'هل الكورس مناسب للمبتدئين؟');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 3: Hot Lead — Price + Payment Signals ======');
    const hot = `hot_${ts}`;
    r = await post(hot, 'مهتم بكورس بايثون، بكم السعر وطرق الدفع شنو؟', 'whatsapp');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);
    r = await post(hot, 'ممتاز! ادفع كيف؟ ورقم الحساب شنو؟', 'whatsapp');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 4: Deduction — Financial Objection ======');
    const ded = `ded_${ts}`;
    r = await post(ded, 'السعر غالي، ما عندي ميزانية كافية');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 5: Explicit Rejection → Ticket Closed ======');
    const rej = `rej_${ts}`;
    r = await post(rej, 'عايز كورس Python');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);
    r = await post(rej, 'لا أريد، غير مهتم');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 6: Human Handover — B2B ======');
    r = await post(`b2b_${ts}`, 'شركتنا تريد تدريب 20 موظف، هل عندكم عرض سعر رسمي؟');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 7: Human Handover — Instructor Request ======');
    r = await post(`inst_${ts}`, 'أنا مدرب وعايز أقدم كورس عندكم، الإجراءات شنو؟');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 8: WhatsApp Platform Bonus (25 pts) ======');
    r = await post(`wa_${ts}`, 'مهتم بكورس إكسل', 'whatsapp');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 9: Trust Loss → Human Handover (silent) ======');
    r = await post(`trust_${ts}`, 'أنت روبوت ولا زول حقيقي؟ كلامك ده محفوظ');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 10: Technical Support ======');
    const tech = `tech_${ts}`;
    r = await post(tech, 'الفيديو ما شغال معاي والشاشة بيضاء');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);
    r = await post(tech, 'طريقة الوصول للفيديوهات كيف؟');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 11: Complaint ======');
    const comp = `comp_${ts}`;
    r = await post(comp, 'الخدمة سيئة جدا والمدرب يتأخر دائما');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 12: Out of Plan Course Request ======');
    r = await post(`out_${ts}`, 'عايز كورس فوتوشوب متقدم');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\n====== TEST 13: Trainer Application Flow ======');
    const tr = `trainer_${ts}`;
    r = await post(tr, 'أنا مدرب جرافيك وعايز أقدم كورس عندكم');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);
    r = await post(tr, 'عندي خبرة 5 سنوات في أدوبي وأشتغلت في مراكز تدريب كتير');
    console.log(fmt(r));
    await printDbState(r.lead_id, r.ticket_id);

    console.log('\nDone.');
    if (pool) await pool.end();
}

run().catch(async (e) => {
    console.error(e);
    if (pool) await pool.end();
});
