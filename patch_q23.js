const fs = require('fs');
const file = 'e:/CRM/CRM System.json';
let wf = JSON.parse(fs.readFileSync(file, 'utf8'));

let q23 = wf.nodes.find(n => n.name === 'Execute a SQL query23');
if (q23) {
  q23.parameters.query = q23.parameters.query.replace(
    /VALUES \('\{\{ \$json\.conversation_id \}\}'/g,
    `VALUES (COALESCE(NULLIF(NULLIF('{{ $json.conversation_id }}', 'undefined'), ''), CONCAT('fb_', REPLACE(UUID(),'-','')))`
  );
  q23.parameters.query = q23.parameters.query.replace(
    /facebook_messages\(facebook_message_id, facebook_conversation_id, conversation_id, lead_id, sender, message_text, reply_to_message_id, created_time\) VALUES \('\{\{ \$\('Message Preparer6'\)\.item\.json\.message_id \}\}', '\{\{ \$json\.conversation_id \}\}'/g,
    `facebook_messages(facebook_message_id, facebook_conversation_id, conversation_id, lead_id, sender, message_text, reply_to_message_id, created_time) VALUES ('{{ $('Message Preparer6').item.json.message_id }}', COALESCE(NULLIF(NULLIF('{{ $json.conversation_id }}', 'undefined'), ''), CONCAT('fb_', REPLACE(UUID(),'-','')))`
  );
  fs.writeFileSync(file, JSON.stringify(wf, null, 2));
  console.log('Patched Execute a SQL query23 to handle undefined conversation IDs');
}
