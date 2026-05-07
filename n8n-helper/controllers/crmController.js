const { query } = require('../utils/utils');
const { pool } = require("../db");
const crmService = require('../services/crmService');

module.exports = {

    /**
     * processMessage: The primary entry point for the CRM logic.
     * Triggered by n8n after a message is handled and an AI reply is generated.
     */
    processMessage: async (req, res) => {
        const { platform_user_id, text, ai_reply, router_value, source, course_info, attachment_url } = req.body;
        const platform = source === 'messenger' || source === 'facebook_comments' ? 'facebook' 
                       : source === 'whatsapp_messages' ? 'whatsapp' 
                       : source === 'instagram_messages' ? 'instagram' : 'facebook';

        console.log(`📩 [CRM] Processing message from ${platform_user_id} (${platform})`);

        try {
            // 1. Fetch Timer Configurations
            const [configRows] = await pool.query(`SELECT title, value FROM atc_config WHERE title LIKE 'crm_%timer%'`);
            const timerConfig = {};
            configRows.forEach(row => { timerConfig[row.title] = parseInt(row.value); });

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
                const [leadResult] = await pool.query('INSERT INTO crm_leads (created, source_platform, first_interaction_type) VALUES (NOW(), ?, ?)', [platform, 'message']);
                leadId = leadResult.insertId;
                await pool.query(
                    'INSERT INTO crm_lead_social_profiles (crm_lead_id, platform, platform_user_id, display_name) VALUES (?, ?, ?, ?)',
                    [leadId, platform, platform_user_id, `User_${platform_user_id}`]
                );
            } else {
                leadId = leads[0].id;
            }

            // Update lead interaction time
            await pool.query('UPDATE crm_leads SET last_interaction_time = NOW() WHERE id = ?', [leadId]);

            // 3. Ticket Type Resolution
            let ticketCode = router_value || 'GENERAL_ENQUIRY';
            
            // Priority 1: Use structured course_info if provided by n8n
            if (course_info && course_info.name) {
                const base = `${course_info.program_type === 'Workshop' ? 'PERSONAL_ONLINE_WORKSHOPS' : 'PERSONAL_ONLINE_COURSES'}`;
                ticketCode = await crmService.resolveTicketCode(base, course_info.name);
            } 
            // Priority 2: Fallback to text searching if n8n didn't extract course_info
            else {
                if (ticketCode === 'DEEP_INFO_PERSONAL') ticketCode = await crmService.resolveTicketCode('PERSONAL_ONLINE_COURSES', text);
                if (ticketCode === 'DEEP_INFO_CORPORATION') ticketCode = await crmService.resolveTicketCode('CORPORATION_ONLINE_COURSES', text);
            }

            // 4. Scoring
            let intentPts = (['رقم الحساب', 'ادفع كيف', 'بنكك', 'سجلني'].some(s => text && text.includes(s))) ? 50 : 20;
            const timingPts = await crmService.getTimingScore(leadId, intentPts);
            const historyPts = await crmService.getHistoricalBaseline(leadId);
            const platformPts = platform === 'whatsapp' ? 25 : 15;
            const messageScoreDelta = platformPts + intentPts + timingPts;

            // 5. Manage Tickets
            let [openTickets] = await pool.query(`
                SELECT t.id, t.score, t.updated, tt.code as ticket_type_code 
                FROM crm_tickets t 
                JOIN crm_ticket_types tt ON t.crm_ticket_type_id = tt.id 
                WHERE t.crm_lead_id = ? AND t.closed = 0
                ORDER BY t.created DESC
            `, [leadId]);

            const shouldCreateTicket = ticketCode.startsWith('PERSONAL') 
                || ticketCode.startsWith('CORPORATION') 
                || ticketCode === 'COMPLAINT' 
                || ticketCode === 'TECHNICAL_SUPPORT'
                || ticketCode === 'TRAINER_APPLICATION';

            const isTicketExpired = (ticket) => {
                const now = new Date();
                const updated = new Date(ticket.updated);
                const diffDays = (now - updated) / (1000 * 60 * 60 * 24);
                
                if (ticket.ticket_type_code.startsWith('PERSONAL') || ticket.ticket_type_code.startsWith('CORPORATION')) {
                    return diffDays > 14;
                }
                if (ticket.ticket_type_code === 'TECHNICAL_SUPPORT') return diffDays > 3;
                if (ticket.ticket_type_code === 'COMPLAINT') return diffDays > 2;
                if (ticket.ticket_type_code === 'TRAINER_APPLICATION') return diffDays > 21;
                
                return diffDays > 14; // Default limit
            };

            const activeTicket = openTickets.find(t => {
                if (isTicketExpired(t)) return false; // Ignore stale tickets
                return t.ticket_type_code === ticketCode 
                    || (ticketCode.startsWith('PERSONAL') && t.ticket_type_code.startsWith('PERSONAL'))
                    || (ticketCode.startsWith('CORPORATION') && t.ticket_type_code.startsWith('CORPORATION'));
            });
            let ticketId;
            let currentScore = 0;

            if (activeTicket) {
                ticketId = activeTicket.id;
                currentScore = Math.max(0, (activeTicket.score || 0) + messageScoreDelta);
                await pool.query(`UPDATE crm_tickets SET score = ?, updated = NOW() WHERE id = ?`, [currentScore, ticketId]);
            } else if (shouldCreateTicket) {
                const [typeRes] = await pool.query(`SELECT id FROM crm_ticket_types WHERE code = ? LIMIT 1`, [ticketCode]);
                const typeId = typeRes.length > 0 ? typeRes[0].id : 46; // 46 = GENERAL_ENQUIRY fallback
                currentScore = Math.max(0, messageScoreDelta + historyPts);
                const [newTicket] = await pool.query(
                    `INSERT INTO crm_tickets (crm_lead_id, crm_ticket_type_id, title, score, created, updated) VALUES (?, ?, ?, ?, NOW(), NOW())`,
                    [leadId, typeId, `${ticketCode} - Auto`, currentScore]
                );
                ticketId = newTicket.insertId;
            }

            // 6. Timers
            if (ticketId) {
                let timerMinutes = 1435;
                let timerType = 'PRE_SALE_FOLLOWUP';
                if (ticketCode === 'COMPLAINT') { timerMinutes = complaintMinutes; timerType = 'COMPLAINT_FOLLOWUP'; }
                if (ticketCode === 'TECHNICAL_SUPPORT') { timerMinutes = technicalMinutes; timerType = 'TECHNICAL_SUPPORT_FOLLOWUP'; }

                await pool.query(`UPDATE crm_ticket_timers SET status = 'cancelled' WHERE crm_ticket_id = ? AND status = 'pending'`, [ticketId]);
                await pool.query(`INSERT INTO crm_ticket_timers (crm_ticket_id, timer_type, scheduled_at, status) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL ? MINUTE), 'pending')`, [ticketId, timerType, timerMinutes]);
            }

            // 7. Log Messages (Duplicated for Dashboard)
            if (ticketId) {
                await pool.query(
                    `INSERT INTO crm_ticket_messages (crm_ticket_id, platform, interaction_type, message_text, attachment_url, sender_type, created) VALUES (?, ?, 'message', ?, ?, 'customer', NOW())`, 
                    [ticketId, platform, text, attachment_url || null]
                );
                await pool.query(
                    `INSERT INTO crm_ticket_messages (crm_ticket_id, platform, interaction_type, message_text, sender_type, created) VALUES (?, ?, 'message', ?, 'bot', NOW())`, 
                    [ticketId, platform, ai_reply]
                );
            }

            res.json({ status: "SUCCESS", lead_id: leadId, ticket_id: ticketId, ticket_score: currentScore, lead_status: crmService.getLeadStatus(currentScore) });

        } catch (error) {
            console.error("❌ [CRM Error]", error);
            res.status(500).json({ error: error.message });
        }
    },

    // Legacy stubs kept for compatibility
    createTicket: (req, res) => res.status(200).json({ message: "Deprecated. Use processMessage instead." }),
    handleComplaint: (req, res) => res.status(200).json({ message: "Deprecated. Use processMessage instead." })
};