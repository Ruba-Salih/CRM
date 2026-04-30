/**
 * CRM Webhook — Automated Test Runner
 * Usage: node run_tests.js
 * Requires the server to be running on http://localhost:3000
 */

const fs   = require('fs');
const path = require('path');

const BASE_URL   = 'http://localhost:3000/api/webhook/messenger';
const CASES_FILE = path.join(__dirname, 'test_cases.json');
// Delay between requests to avoid hammering Ollama
const DELAY_MS   = 500;

// ── ANSI colour helpers ────────────────────────────────────────────────────────
const GREEN  = (s) => `\x1b[32m${s}\x1b[0m`;
const RED    = (s) => `\x1b[31m${s}\x1b[0m`;
const YELLOW = (s) => `\x1b[33m${s}\x1b[0m`;
const CYAN   = (s) => `\x1b[36m${s}\x1b[0m`;
const BOLD   = (s) => `\x1b[1m${s}\x1b[0m`;
const DIM    = (s) => `\x1b[2m${s}\x1b[0m`;

// ── Helpers ────────────────────────────────────────────────────────────────────
function sleep(ms) { return new Promise(r => setTimeout(r, ms)); }

/**
 * The server now returns `resolved_ticket_type` directly in all responses.
 * This function just reads it; inference fallback only needed if server is old.
 */
function deriveActualCode(response) {
    if (response.resolved_ticket_type) return response.resolved_ticket_type;
    const action = response.action || '';
    if (action === 'GENERAL_ENQUIRY_NO_TICKET' || action === 'LOGGED_TO_EXISTING_TICKET') return 'GENERAL_ENQUIRY';
    if (action === 'CREATED_COMPLAINT_TICKET'  || action === 'RESTARTED_COMPLAINT_TIMER')  return 'COMPLAINT';
    if (action === 'CREATED_TECH_TICKET'        || action === 'RESTARTED_TECH_TIMER')       return 'TECHNICAL_SUPPORT';
    if (action === 'CREATED_OUT_OF_PLAN_TICKET_NO_TIMER') return '(demand-ticket — see server log)';
    return `(action=${action} — see server log)`;
}

async function runTest(tc, idx, total) {
    const label = `[${idx}/${total}] ${BOLD(tc.scenario)}`;
    console.log(`\n${'─'.repeat(72)}`);
    console.log(label);
    console.log(DIM(`Expected: ${tc.expected_ticket_type}`));
    console.log(DIM(`Message : "${tc.postman_payload.text}"`));

    let response;
    const startMs = Date.now();
    try {
        const res = await fetch(BASE_URL, {
            method : 'POST',
            headers: { 'Content-Type': 'application/json' },
            body   : JSON.stringify(tc.postman_payload),
        });
        response = await res.json();
    } catch (err) {
        console.log(RED(`  ✗ REQUEST FAILED: ${err.message}`));
        return { passed: false, scenario: tc.scenario, error: err.message };
    }
    const elapsedSec = ((Date.now() - startMs) / 1000).toFixed(1);

    const actual   = deriveActualCode(response);
    const expected = tc.expected_ticket_type;
    const passed   = actual === expected;

    if (passed) {
        console.log(GREEN(`  ✔ PASS`) + `  (${elapsedSec}s)`);
        console.log(GREEN(`  Resolved: ${actual}`));
    } else {
        console.log(RED(`  ✗ FAIL`) + `  (${elapsedSec}s)`);
        console.log(RED(`  Got     : ${actual}`));
        console.log(RED(`  Expected: ${expected}`));
    }

    if (response.ai_reply) {
        // Wrap long reply at 70 chars
        const wrapped = response.ai_reply.replace(/(.{70})/g, '$1\n           ');
        console.log(CYAN(`  AI reply: "${wrapped}"`));
    }
    if (response.error) {
        console.log(RED(`  Server error: ${response.error} — ${response.details}`));
    }

    return { passed, scenario: tc.scenario, actual, expected, elapsedSec };
}

async function main() {
    // ── Preflight: check server is up ────────────────────────────────────────
    console.log(BOLD('\n🔍 CRM Webhook — Automated Test Runner'));
    console.log(`   Server : ${BASE_URL}`);
    try {
        await fetch(BASE_URL, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: '{}' });
    } catch {
        console.log(RED('\n❌ Server is not reachable at ' + BASE_URL));
        console.log(RED('   Start it with:  node server.js'));
        process.exit(1);
    }

    const cases = JSON.parse(fs.readFileSync(CASES_FILE, 'utf8'));
    console.log(`   Cases  : ${cases.length} loaded from test_cases.json\n`);

    const results = [];
    for (let i = 0; i < cases.length; i++) {
        const result = await runTest(cases[i], i + 1, cases.length);
        results.push(result);
        if (i < cases.length - 1) await sleep(DELAY_MS);
    }

    // ── Summary ──────────────────────────────────────────────────────────────
    const passed = results.filter(r => r.passed).length;
    const failed = results.length - passed;
    console.log(`\n${'═'.repeat(72)}`);
    console.log(BOLD('📊 RESULTS SUMMARY'));
    console.log(`   Total  : ${results.length}`);
    console.log(GREEN(`   Passed : ${passed}`));
    if (failed > 0) console.log(RED(`   Failed : ${failed}`));

    if (failed > 0) {
        console.log(YELLOW('\n⚠ Failed tests:'));
        results.filter(r => !r.passed).forEach(r => {
            console.log(RED(`   • ${r.scenario}`));
            console.log(`     got      → ${r.actual}`);
            console.log(`     expected → ${r.expected}`);
        });
    }

    console.log('');
    process.exit(failed > 0 ? 1 : 0);
}

main().catch(err => {
    console.error(RED('Unexpected error: ' + err.message));
    process.exit(1);
});
