const { sendToAi, query } = require('../utils/utils');
const axios = require('axios');

module.exports = {

// ============================================
// 1. Endpoint: الاستقبال العام للمحادثات 
// ============================================
createTicket: async (req, res) => {
    // return console.log(req.body)
    const { source, sessionId, chatInput, router_value, course_info } = req.body;

    let platform
    if(source=='messenger' || source=='facebook_comments')
     platform = 'facebook'
    else if(source=='whatsapp_messages')
     platform = 'whatsapp'
    else if(source=='instagram_messages' || source=='instagram_comments')
     platform = 'instagram'
    else if(source=='tiktok_comments' || source=='tiktok_messages')
     platform = 'tiktok'
    // 


    // Data Initialization
    let ticket_count = (await query(`SELECT count(*) as total from crm_tickets where closed = 0 and crm_lead_id = (SELECT lp.crm_lead_id from crm_lead_social_profiles lp where lp.platform_user_id=${sessionId} and lp.platform=${platform})`))[0].total;

    let deserve_ticket_router_values = [ "COMPLAINT", "TECHNICAL_SUPPORT", "DEEP_INFO_PERSONAL", "DEEP_INFO_CORPORATION" ]
    
    let add_more_score_types = [{"type":"LOCATION_DESCRIPTION","score":5},{"type":"CENTER_INFO","score":10}]


    // Main Ticket Creation Logic

    console.log(`✅ [DATA] Received from ${source}`);
    res.status(200).json(response);
},

// ==========================================================
// 2. Endpoint: معالج الشكاوى (Complaint Handler)
// ==========================================================
handleComplaint: async (req, res) => {
    const { source, sessionId, chatInput } = req.body;

    console.log(`⚠️ [COMPLAINT] Analyzing message from ${sessionId}...`);

    // برومبت مخصص للشكاوى
    const complaintPrompt = `أنت خبير خدمة عملاء. حلل الشكوى وارجع JSON: 
    { "summary": "ملخص"، "urgency": "High/Low"، "is_complaint": true }`;
    
    const analysis = await sendToAi(complaintPrompt, chatInput);

    // تجهيز الرد للـ n8n مع علم التحويل لموظف (To Human)
    const response = [{
        json: {
            source,
            sessionId,
            chatInput,
            intent: "COMPLAINT",
            handover_required: true, // إشارة لـ n8n لتحويلها لبشري
            analysis: analysis || { summary: "شكوى عامة", urgency: "Medium" },
            ai_reply: "نعتذر بشدة. تم إرسال شكواك للإدارة، وسيتواصل معك موظف الآن."
        }
    }];

    res.status(200).json(response);
}}