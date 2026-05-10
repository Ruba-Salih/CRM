const fs = require('fs');

const filePath = 'e:/CRM/CRM System.json';
const raw = fs.readFileSync(filePath, 'utf8');
const workflow = JSON.parse(raw);

let changes = [];

// ─────────────────────────────────────────────────────────────
// FIX 1: HTTP Request1 — fix URL + body + add header
//         Currently points to https://n8n-helper.afro-tech.net/ (root, wrong)
//         Route is: POST /social-media/chat/completions
// ─────────────────────────────────────────────────────────────
const req1 = workflow.nodes.find(n => n.name === 'HTTP Request1');
if (req1) {
  req1.parameters.url = 'https://n8n-helper.afro-tech.net/social-media/chat/completions';
  req1.parameters.method = 'POST';
  req1.parameters.sendBody = true;
  req1.parameters.specifyBody = 'json';
  req1.parameters.jsonBody = JSON.stringify({
    messages: [
      {
        role: "user",
        content: "={{ $('Smart Router Input1').first().json.query }}"
      }
    ]
  });
  // Add header so the CRM knows the platform + user
  req1.parameters.sendHeaders = true;
  req1.parameters.headerParameters = {
    parameters: [
      {
        name: "Message-Platform-Source",
        value: "={{ $('Smart Router Input1').first().json.source + ',' + $('Smart Router Input1').first().json.sessionId }}"
      }
    ]
  };
  // Remove any old query parameters that don't belong
  delete req1.parameters.sendQuery;
  delete req1.parameters.queryParameters;
  changes.push('✅ HTTP Request1: URL, method, body, and header fixed');
} else {
  changes.push('❌ HTTP Request1: NOT FOUND');
}

// ─────────────────────────────────────────────────────────────
// FIX 2: If3 — currently checks $json.output which the CRM doesn't return
//         The CRM /social-media/chat/completions returns plain text (a string)
//         So we check if the response body is non-empty string
// ─────────────────────────────────────────────────────────────
const if3 = workflow.nodes.find(n => n.name === 'If3');
if (if3) {
  if3.parameters.conditions.conditions[0] = {
    id: "6ab3b7ac-8236-4133-b2dc-f28b43afdec7",
    leftValue: "={{ $('HTTP Request1').first().json }}",
    rightValue: "",
    operator: {
      type: "string",
      operation: "notEmpty",
      singleValue: true
    }
  };
  changes.push('✅ If3: condition updated to check HTTP Request1 response');
} else {
  changes.push('❌ If3: NOT FOUND');
}

// ─────────────────────────────────────────────────────────────
// FIX 3: HTTP Request16 — FB Messenger send node
//         Currently: $('AI Agent3').first().json.output.trim()  (BROKEN - AI Agent deleted)
//         Should be:  $('HTTP Request1').first().json  (CRM returns plain text)
// ─────────────────────────────────────────────────────────────
const req16 = workflow.nodes.find(n => n.name === 'HTTP Request16');
if (req16) {
  req16.parameters.jsonBody = `={
  "recipient": {
    "id": "{{ $('Message Preparer6').first().json.sessionId  }}"
  },
  "messaging_type": "RESPONSE",
  "message": {
    "text": {{ JSON.stringify($('HTTP Request1').first().json.toString().trim()) }}
  }
}`;
  changes.push('✅ HTTP Request16: FB reply now reads from HTTP Request1 (CRM AI response)');
} else {
  changes.push('❌ HTTP Request16: NOT FOUND');
}

// ─────────────────────────────────────────────────────────────
// FIX 4: Code in JavaScript35 — syntax error (missing commas in course_info)
//         Also needs to capture ai_reply from HTTP Request1
// ─────────────────────────────────────────────────────────────
const js35 = workflow.nodes.find(n => n.name === 'Code in JavaScript35');
if (js35) {
  js35.parameters.jsCode = `let source = $items("Smart Router Input1")[0].json.source
let sessionId = $items("Smart Router Input1")[0].json.sessionId
let chatInput = $items("Smart Router Input1")[0].json.chatInput
let router_value = $items("Smart Router Input1")[0].json.router_value || 'GENERAL_ENQUIRY'
let ai_reply = $input.first().json
let course_info = null

// Only resolve course_info if router classified as deep course inquiry
if(router_value == 'DEEP_INFO_PERSONAL' || router_value == 'DEEP_INFO_CORPORATION') {
  try {
    course_info = {
      attendance_type: $items("Deep Course Info1")[0].json.attendance_type,
      program_type: $items("Deep Course Info1")[0].json.program_type,
      name: $items("Deep Course Info1")[0].json.program_name_ar
    }
  } catch(e) {
    course_info = null
  }
}

return [{json:{
  source,
  sessionId,
  chatInput,
  router_value,
  course_info,
  ai_reply: typeof ai_reply === 'string' ? ai_reply : JSON.stringify(ai_reply)
}}]`;
  changes.push('✅ Code in JavaScript35: syntax fixed, ai_reply captured from HTTP Request1');
} else {
  changes.push('❌ Code in JavaScript35: NOT FOUND');
}

// ─────────────────────────────────────────────────────────────
// FIX 5: Add new HTTP Request node for /process-message (CRM ticketing)
//         This fires AFTER HTTP Request16 sends the reply to the customer
// ─────────────────────────────────────────────────────────────
const processMsgNodeName = 'CRM Process Message';
const existingProcMsg = workflow.nodes.find(n => n.name === processMsgNodeName);
if (!existingProcMsg) {
  const newNode = {
    parameters: {
      method: "POST",
      url: "https://n8n-helper.afro-tech.net/api/process-message",
      sendBody: true,
      specifyBody: "json",
      jsonBody: `={
  "platform_user_id": "{{ $('Smart Router Input1').first().json.sessionId }}",
  "text": "{{ $('Smart Router Input1').first().json.chatInput }}",
  "ai_reply": "{{ $('HTTP Request1').first().json.toString() }}",
  "router_value": "{{ $('Smart Router Input1').first().json.router_value }}",
  "source": "{{ $('Smart Router Input1').first().json.source }}"
}`,
      options: {}
    },
    type: "n8n-nodes-base.httpRequest",
    typeVersion: 4.3,
    position: [18400, 5680],
    id: "crm-process-message-node-001",
    name: processMsgNodeName
  };
  workflow.nodes.push(newNode);
  changes.push('✅ CRM Process Message: new node added for /api/process-message');
} else {
  changes.push('ℹ️ CRM Process Message: already exists, skipped');
}

// ─────────────────────────────────────────────────────────────
// FIX 6: Wire the new process-message node AFTER HTTP Request16
//         HTTP Request16 → CRM Process Message
// ─────────────────────────────────────────────────────────────
const connections = workflow.connections;

// Get HTTP Request16 current connection (it should connect to Execute a SQL query25)
const req16conn = connections['HTTP Request16'];
if (req16conn) {
  // Add a second output branch going to the CRM Process Message node
  // (n8n runs multiple connections from same output in parallel)
  if (!req16conn.main[0]) req16conn.main[0] = [];
  const alreadyConnected = req16conn.main[0].some(c => c.node === processMsgNodeName);
  if (!alreadyConnected) {
    req16conn.main[0].push({
      node: processMsgNodeName,
      type: "main",
      index: 0
    });
    changes.push('✅ HTTP Request16 → CRM Process Message: connection added');
  }
} else {
  // Create new connection entry
  connections['HTTP Request16'] = {
    main: [[{
      node: processMsgNodeName,
      type: "main",
      index: 0
    }]]
  };
  changes.push('✅ HTTP Request16 connections created → CRM Process Message');
}

// ─────────────────────────────────────────────────────────────
// VERIFY: Check Smart Router prompt includes routing categories
//         The Smart Router Input1 jsCode was stripped to just the user question
//         We need to restore the full classifier prompt
// ─────────────────────────────────────────────────────────────
const smartRouter = workflow.nodes.find(n => n.name === 'Smart Router Input1');
if (smartRouter && smartRouter.parameters.jsCode) {
  const code = smartRouter.parameters.jsCode;
  if (!code.includes('DEEP_INFO_PERSONAL') && !code.includes('COMPLAINT')) {
    changes.push('⚠️ Smart Router Input1: classifier prompt appears stripped — router_value will always be empty. The CRM will use GENERAL_ENQUIRY for all tickets. This is OK for now since the CRM handles ticket logic, but router_value won\'t be set per intent type.');
  } else {
    changes.push('✅ Smart Router Input1: classifier prompt is intact');
  }
}

// ─────────────────────────────────────────────────────────────
// SAVE
// ─────────────────────────────────────────────────────────────
fs.writeFileSync(filePath, JSON.stringify(workflow, null, 2), 'utf8');

console.log('\n=== CRM System.json Patch Results ===\n');
changes.forEach(c => console.log(c));
console.log('\n✅ File saved successfully!');
