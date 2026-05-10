const fs = require('fs');
const workflow = JSON.parse(fs.readFileSync('e:/CRM/CRM System.json', 'utf8'));

const nodesToCheck = ['HTTP Request1', 'If3', 'HTTP Request16', 'Code in JavaScript35', 'CRM Process Message'];

nodesToCheck.forEach(name => {
  const node = workflow.nodes.find(n => n.name === name);
  if (!node) { console.log(`❌ ${name}: NOT FOUND`); return; }
  
  console.log(`\n=== ${name} ===`);
  
  if (name === 'HTTP Request1') {
    console.log('  URL:', node.parameters.url);
    console.log('  Method:', node.parameters.method);
    console.log('  Header:', JSON.stringify(node.parameters.headerParameters));
    console.log('  Body (truncated):', (node.parameters.jsonBody || '').substring(0, 100));
  }
  if (name === 'If3') {
    const cond = node.parameters.conditions?.conditions?.[0];
    console.log('  Condition leftValue:', cond?.leftValue);
    console.log('  Condition operator:', cond?.operator?.operation);
  }
  if (name === 'HTTP Request16') {
    console.log('  jsonBody (truncated):', (node.parameters.jsonBody || '').substring(0, 150));
  }
  if (name === 'Code in JavaScript35') {
    const code = node.parameters.jsCode || '';
    console.log('  Has commas in course_info:', code.includes('attendance_type:'));
    console.log('  Has ai_reply:', code.includes('ai_reply'));
    console.log('  Has router_value fallback:', code.includes("|| 'GENERAL_ENQUIRY'"));
  }
  if (name === 'CRM Process Message') {
    console.log('  URL:', node.parameters.url);
    console.log('  Method:', node.parameters.method);
    console.log('  Body (truncated):', (node.parameters.jsonBody || '').substring(0, 200));
  }
});

// Check connection
const conn = workflow.connections['HTTP Request16'];
console.log('\n=== HTTP Request16 Connections ===');
console.log(JSON.stringify(conn, null, 2));

// Check Smart Router prompt  
const sr = workflow.nodes.find(n => n.name === 'Smart Router Input1');
console.log('\n=== Smart Router Input1 jsCode (first 200 chars) ===');
console.log((sr?.parameters?.jsCode || '').substring(0, 200));
