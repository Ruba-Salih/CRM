const fs = require('fs');
let content = fs.readFileSync('e:/CRM/n8n-helper/utils/utils.js', 'utf8');
content = content.replace(/messages\.filter\(message=>message\.role=='user'\)\.at\(-3\)/g, "messages.filter(message=>message.role=='user')[messages.filter(message=>message.role=='user').length - 3]");
content = content.replace(/messages\.filter\(message=>message\.role=='user'\)\.at\(-4\)/g, "messages.filter(message=>message.role=='user')[messages.filter(message=>message.role=='user').length - 4]");
content = content.replace(/messages\.at\(-1\)/g, "messages[messages.length - 1]");
fs.writeFileSync('e:/CRM/n8n-helper/utils/utils.js', content);
console.log('Fixed .at() usage in utils.js');
