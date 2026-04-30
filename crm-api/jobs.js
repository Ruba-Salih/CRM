const mysql = require('mysql2/promise');

function initJobs(pool) {
    console.log('🚀 CRM Background Jobs Initialized');

    // Job 1: Timer Runner (Runs every 1 minute)
    setInterval(async () => {
        try {
            await runTimerLogic(pool);
        } catch (error) {
            console.error('❌ Error in Timer Runner:', error);
        }
    }, 60 * 1000);

    // Job 2: Payment Verifier (Runs every 5 minutes)
    setInterval(async () => {
        try {
            await runPaymentVerifier(pool);
        } catch (error) {
            console.error('❌ Error in Payment Verifier:', error);
        }
    }, 5 * 60 * 1000);
}

async function runTimerLogic(pool) {
    const [timers] = await pool.query(`
        SELECT 
            t.id as timer_id,
            t.crm_ticket_id,
            t.timer_type,
            t.sequence_no,
            t.scheduled_at,
            tk.last_timer_time,
            l.id as lead_id,
            l.last_interaction_time,
            lsp.platform_user_id,
            lsp.platform,
            lsp.display_name
        FROM crm_ticket_timers t
        JOIN crm_tickets tk ON t.crm_ticket_id = tk.id
        JOIN crm_leads l ON tk.crm_lead_id = l.id
        JOIN crm_lead_social_profiles lsp ON l.id = lsp.crm_lead_id
        WHERE t.scheduled_at <= NOW()
          AND t.status = 'pending'
          AND tk.closed = 0
        LIMIT 50
    `);

    if (timers.length === 0) return;

    console.log(`⏱️ Processing ${timers.length} due timers...`);

    const [configRows] = await pool.query(`SELECT title, value FROM atc_config WHERE title LIKE 'crm_%timer%'`);
    const timerConfig = {};
    configRows.forEach(row => {
        timerConfig[row.title] = parseInt(row.value);
    });

    const followupMinutes = timerConfig['crm_followup_timer_minutes'] || 1435;

    for (const timer of timers) {
        const lastInteraction = new Date(timer.last_interaction_time);
        const lastTimerTime = timer.last_timer_time ? new Date(timer.last_timer_time) : new Date(0);
        const now = new Date();

        const customerReplied = lastInteraction > lastTimerTime;
        const windowOpen = (now - lastInteraction) < (24 * 60 * 60 * 1000);

        let decision = 'skip'; 
        let nextSeq = timer.sequence_no;
        let newScheduledAt = null;

        if (customerReplied) {
            // العميل رد -> إعادة جدولة الـ Timer
            decision = 'reschedule';
            const nextTime = new Date(lastInteraction.getTime() + followupMinutes * 60 * 1000);
            newScheduledAt = nextTime;
        } else if (timer.sequence_no === 1 && windowOpen) {
            // لم يرد والنافذة مفتوحة -> إرسال التذكير الأول
            decision = 'send';
            nextSeq = 2;
            const nextTime = new Date(now.getTime() + followupMinutes * 60 * 1000);
            newScheduledAt = nextTime;
        } else if (timer.sequence_no >= 2 || !windowOpen) {
            // لم يرد والنافذة أغلقت أو التذكير الثاني -> إغلاق التذكرة
            decision = 'close';
        }

        if (decision === 'reschedule') {
            await pool.query(
                `UPDATE crm_ticket_timers SET scheduled_at = ?, status = 'pending' WHERE id = ?`,
                [newScheduledAt, timer.timer_id]
            );
            console.log(`Timer ${timer.timer_id}: Rescheduled because user replied.`);
        } else if (decision === 'send') {
            // محاكاة إرسال الرسالة لفيسبوك
            console.log(`[SIMULATED FB SEND] To User ${timer.platform_user_id} (${timer.display_name}): Automated Follow-up seq ${timer.sequence_no} for ${timer.timer_type}`);
            
            await pool.query(
                `UPDATE crm_ticket_timers SET status = 'executed', executed_at = NOW() WHERE id = ?`,
                [timer.timer_id]
            );
            await pool.query(
                `INSERT INTO crm_ticket_timers (crm_ticket_id, timer_type, sequence_no, scheduled_at, status) VALUES (?, ?, ?, ?, 'pending')`,
                [timer.crm_ticket_id, timer.timer_type, nextSeq, newScheduledAt]
            );
            await pool.query(
                `UPDATE crm_tickets SET last_timer_time = NOW() WHERE id = ?`,
                [timer.crm_ticket_id]
            );
        } else if (decision === 'close') {
            await pool.query(`UPDATE crm_tickets SET closed = 1, updated = NOW() WHERE id = ?`, [timer.crm_ticket_id]);
            await pool.query(`UPDATE crm_ticket_timers SET status = 'skipped', executed_at = NOW() WHERE id = ?`, [timer.timer_id]);
            console.log(`Timer ${timer.timer_id}: Closed ticket ${timer.crm_ticket_id} due to no interaction.`);
        }
    }
}

async function runPaymentVerifier(pool) {
    // 1- البحث عن طلبات الدفع المؤكدة من Mbok
    // 2- ربطها بتذاكر الـ Pre-sale
    const [registrations] = await pool.query(`
        SELECT 
          cr.id as course_reg_id,
          cr.student_id,
          cr.running_course_id,
          rc.start_time as course_start_time,
          rc.finish_time as course_finish_time,
          u.id as user_id,
          l.id as lead_id,
          t.id as ticket_id,
          lsp.platform_user_id,
          c.name as course_name
        FROM courses_reg cr
        JOIN users u ON cr.student_id = u.id
        JOIN running_courses rc ON cr.running_course_id = rc.id
        JOIN courses c ON rc.course_id = c.id
        JOIN crm_leads l ON u.id = l.user_id_fk
        JOIN crm_lead_social_profiles lsp ON l.id = lsp.crm_lead_id
        JOIN crm_tickets t ON l.id = t.crm_lead_id
        LEFT JOIN crm_sales_ticket_levels sl ON t.sales_level_id = sl.id
        WHERE cr.can_attend = 1
          AND (sl.code IS NULL OR sl.code = 'PRE_SALE')
          AND t.closed = 0
          AND t.running_program_id = cr.running_course_id
        LIMIT 20
    `);

    if (registrations.length === 0) return;

    console.log(`💰 Verifying payments for ${registrations.length} student registrations...`);

    for (const reg of registrations) {
        // تحديث التذكرة لـ SOLD
        let [soldLevel] = await pool.query(`SELECT id FROM crm_sales_ticket_levels WHERE code = 'SOLD' LIMIT 1`);
        const soldLevelId = soldLevel.length > 0 ? soldLevel[0].id : 2;

        await pool.query(
            `UPDATE crm_tickets SET sales_level_id = ?, updated = NOW(), closed = 1 WHERE id = ?`,
            [soldLevelId, reg.ticket_id]
        );

        // إنشاء تذكرة Post Sale
        let [postSaleType] = await pool.query(`SELECT id FROM crm_ticket_types WHERE code = 'POST_SALE_FOLLOWUP' OR id = 3 LIMIT 1`);
        const postSaleTypeId = postSaleType.length > 0 ? postSaleType[0].id : 3;

        const [postSaleTicket] = await pool.query(
            `INSERT INTO crm_tickets (crm_lead_id, crm_ticket_type_id, title, running_program_id, running_program_type, created, updated)
             VALUES (?, ?, ?, ?, 'Course', NOW(), NOW())`,
            [reg.lead_id, postSaleTypeId, `متابعة مشترك — ${reg.course_name}`, reg.running_course_id]
        );

        // إنشاء Timer للـ Post Sale (يبدأ في تاريخ بداية الكورس)
        const scheduledTime = reg.course_start_time ? new Date(reg.course_start_time) : new Date();
        await pool.query(
            `INSERT INTO crm_ticket_timers (crm_ticket_id, timer_type, sequence_no, scheduled_at, status)
             VALUES (?, 'POST_SALE_FOLLOWUP', 1, ?, 'pending')`,
            [postSaleTicket.insertId, scheduledTime]
        );

        console.log(`Payment confirmed for User ${reg.platform_user_id}. Ticket updated to SOLD and Post-Sale tracking started.`);
    }
}

module.exports = { initJobs };
