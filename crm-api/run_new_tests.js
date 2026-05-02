const fs = require('fs');
const path = require('path');

async function runNewTests() {
    const testCases = JSON.parse(fs.readFileSync(path.join(__dirname, 'test_cases.json'), 'utf8'));
    const newTests = testCases.slice(9); // Scenarios 10 to 13

    console.log(`🚀 Running ${newTests.length} New Knowledge Base Test Cases...\n`);

    for (const test of newTests) {
        console.log(`--------------------------------------------------`);
        console.log(`Scenario: ${test.scenario}`);
        console.log(`User Message: "${test.postman_payload.text}"`);
        
        try {
            const response = await fetch('http://localhost:3000/api/webhook/messenger', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(test.postman_payload)
            });
            const result = await response.json();
            
            console.log(`\n🤖 AI Reply:\n${result.ai_reply}`);
            console.log(`\n✅ Result: ${result.resolved_ticket_type === test.expected_ticket_type ? 'PASS' : 'FAIL (Type mismatch)'}`);
            console.log(`📌 Action Taken: ${result.action}`);
        } catch (error) {
            console.error(`❌ Test Failed: ${error.message}`);
        }
        console.log(`--------------------------------------------------\n`);
    }
}

runNewTests();
