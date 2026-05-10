const fs = require('fs');
const file = 'e:/CRM/CRM System.json';
let wf = JSON.parse(fs.readFileSync(file, 'utf8'));

// 1. Execute a SQL query23
let q23 = wf.nodes.find(n => n.name === 'Execute a SQL query23');
if (q23) {
  q23.parameters.query = `INSERT INTO crm_leads(source_platform, first_interaction_type, first_interaction_time, last_interaction_time, lead_score, status) VALUES ("facebook","message",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,5,'new');

set @lead_id = LAST_INSERT_ID();

INSERT INTO crm_lead_social_profiles(crm_lead_id, platform, platform_user_id, gender, display_name, profile_pic, locale) VALUES (@lead_id, "facebook", '{{ $('Message Preparer6').item.json.sessionId }}','{{ $json.profile.gender }}','{{ $json.profile.display_name }}','{{ $json.profile.profile_pic }}','{{ $json.profile.locale }}');

INSERT INTO facebook_conversations(facebook_conversation_id, lead_id, message_count, last_message_time) VALUES ('{{ $json.conversation_id }}',@lead_id,1,'{{ new Date($('Message Preparer6').item.json.created_time).toISOString().slice(0, 19).replace('T', ' ') }}');

set @conversation_id = LAST_INSERT_ID();

INSERT INTO facebook_messages(facebook_message_id, facebook_conversation_id, conversation_id, lead_id, sender, message_text, reply_to_message_id, created_time) VALUES ('{{ $('Message Preparer6').item.json.message_id }}', '{{ $json.conversation_id }}', @conversation_id, @lead_id, 'user', '{{ $('Message Preparer6').item.json.chatInput }}', {{ $('Message Preparer6').item.json.replying_to_id ? "'" + $('Message Preparer6').item.json.replying_to_id + "'" : 'NULL'  }}, '{{ new Date($('Message Preparer6').item.json.created_time).toISOString().slice(0, 19).replace('T', ' ') }}');`;
}

// 2. Execute a SQL query24
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

// 3. Execute a SQL query25
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

// 4. Execute a SQL query40
let q40 = wf.nodes.find(n => n.name === 'Execute a SQL query40');
if (q40) {
  q40.parameters.query = `INSERT INTO crm_leads(source_platform, first_interaction_type, first_interaction_time, last_interaction_time, lead_score, status) VALUES ("facebook","message",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,5,'new');

set @lead_id = LAST_INSERT_ID();

INSERT INTO crm_lead_social_profiles(crm_lead_id, platform, platform_user_id, gender, display_name, profile_pic, locale) VALUES (@lead_id, "facebook", '{{ $('Comment Preparer1').item.json.sessionId }}','{{ $json.profile.gender }}','{{ $json.profile.display_name }}','{{ $json.profile.profile_pic }}','{{ $json.profile.locale }}');

INSERT INTO facebook_conversations(facebook_conversation_id, lead_id, message_count, last_message_time) VALUES ('{{ $json.conversation_id }}',@lead_id,1,'{{ new Date($('Comment Preparer1').item.json.created_time).toISOString().slice(0, 19).replace('T', ' ') }}');

INSERT INTO facebook_post_comments (
  facebook_comment_id, 
  facebook_post_id,
  lead_id,
  parent_comment_id, 
  message, 
  created_time
) 
SELECT 
  '{{ $('Comment Preparer1').item.json.comment_id }}',
  p.id,
  @lead_id, 
  '{{ $('Comment Preparer1').item.json.parent_comment_id }}',
  '{{ $('Comment Preparer1').item.json.message }}',
  FROM_UNIXTIME({{ $('Comment Preparer1').item.json.created_time }})
FROM facebook_posts p
WHERE p.facebook_id = '{{ $('Comment Preparer1').item.json.facebook_post_id}}'
LIMIT 1;`;
}

fs.writeFileSync(file, JSON.stringify(wf, null, 2));
console.log('Fixed SQL queries for facebook schema');
