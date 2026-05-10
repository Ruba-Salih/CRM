const fs = require('fs');
const file = 'e:/CRM/CRM System.json';
let wf = JSON.parse(fs.readFileSync(file, 'utf8'));

let count = 0;
wf.nodes.forEach(n => {
  if (n.name.startsWith('Has Old Messages') && n.parameters && n.parameters.conditions && n.parameters.conditions.conditions) {
    n.parameters.conditions.conditions.forEach(cond => {
      if (cond.leftValue === '={{ $json.profile }}') {
        cond.operator = {
          "type": "object",
          "operation": "notEmpty",
          "singleValue": true
        };
        count++;
      }
    });
  }
});

fs.writeFileSync(file, JSON.stringify(wf, null, 2));
console.log('Fixed ' + count + ' Has Old Messages nodes to check notEmpty instead of exists');
