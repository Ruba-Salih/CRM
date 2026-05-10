const fs = require('fs');
const file = 'e:/CRM/CRM System.json';
let wf = JSON.parse(fs.readFileSync(file, 'utf8'));

// 1. Execute a SQL query24 (Revert Auto-Heal to clean simple query)
let q24 = wf.nodes.find(n => n.name === 'Execute a SQL query24');
if (q24) {
  q24.parameters.query = `SELECT c.id, c.facebook_conversation_id, c.lead_id INTO @conversation_id, @fb_conv_id, @lead_id
FROM facebook_conversations c
JOIN crm_lead_social_profiles p ON p.crm_lead_id = c.lead_id
WHERE p.platform = 'facebook' AND p.platform_user_id = '{{ $('Message Preparer6').item.json.sessionId }}'
ORDER BY c.id DESC LIMIT 1;

INSERT INTO facebook_messages(facebook_message_id, facebook_conversation_id, conversation_id, lead_id, sender, message_text, reply_to_message_id, created_time)
VALUES ('{{ $('Message Preparer6').item.json.message_id }}', @fb_conv_id, @conversation_id, @lead_id, 'user', '{{ $('Message Preparer6').item.json.chatInput }}', {{ $('Message Preparer6').item.json.replying_to_id ? "'" + $('Message Preparer6').item.json.replying_to_id + "'" : 'NULL'  }}, '{{ new Date($('Message Preparer6').item.json.created_time).toISOString().slice(0, 19).replace('T', ' ') }}');`;
}

// 2. Execute a SQL query25 (Revert Auto-Heal to clean simple query)
let q25 = wf.nodes.find(n => n.name === 'Execute a SQL query25');
if (q25) {
  q25.parameters.query = `SELECT c.id, c.facebook_conversation_id, c.lead_id INTO @conversation_id, @fb_conv_id, @lead_id
FROM facebook_conversations c
JOIN crm_lead_social_profiles p ON p.crm_lead_id = c.lead_id
WHERE p.platform = 'facebook' AND p.platform_user_id = '{{ $('Message Preparer6').first().json.sessionId }}'
ORDER BY c.id DESC LIMIT 1;

INSERT INTO facebook_messages(facebook_message_id, facebook_conversation_id, conversation_id, lead_id, sender, message_text, reply_to_message_id, created_time)
VALUES ('{{ $json.message_id }}', @fb_conv_id, @conversation_id, @lead_id, 'agent', '{{ $('HTTP Request1').first().json.toString() }}', NULL, NOW());`;
}

fs.writeFileSync(file, JSON.stringify(wf, null, 2));
console.log('Reverted SQL queries to clean state');
