const { pool } = require('./db.js');
async function test() {
  const sql = `
  SELECT c.id, c.facebook_conversation_id, c.lead_id INTO @conversation_id, @fb_conv_id, @lead_id FROM facebook_conversations c JOIN crm_lead_social_profiles p ON p.crm_lead_id = c.lead_id WHERE p.platform = 'facebook' AND p.platform_user_id = '26283576554564724' ORDER BY c.id DESC LIMIT 1; 

  SELECT crm_lead_id INTO @fallback_lead_id FROM crm_lead_social_profiles WHERE platform='facebook' AND platform_user_id='26283576554564724' LIMIT 1; 

  INSERT INTO facebook_conversations(facebook_conversation_id, lead_id, message_count, last_message_time) SELECT 'undefined', @fallback_lead_id, 1, '2026-05-10 09:00:11' WHERE @conversation_id IS NULL; 

  SELECT c.id, c.facebook_conversation_id, c.lead_id INTO @conversation_id, @fb_conv_id, @lead_id FROM facebook_conversations c JOIN crm_lead_social_profiles p ON p.crm_lead_id = c.lead_id WHERE p.platform = 'facebook' AND p.platform_user_id = '26283576554564724' ORDER BY c.id DESC LIMIT 1; 
  
  SELECT @conversation_id, @fallback_lead_id, @fb_conv_id, @lead_id;
  `;
  try {
    const [result] = await pool.query({sql, multipleStatements: true});
    console.log("Result:", result[result.length - 1]);
  } catch (e) {
    console.error("Error:", e);
  }
  process.exit(0);
}
test();
