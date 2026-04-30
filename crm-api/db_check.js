const mysql = require('mysql2/promise');
async function run() {
    const pool = mysql.createPool({host: 'localhost', user: 'lawyer_system', password: '1234', database: 'test4_atc'});
    async function desc(table) {
        const [rows] = await pool.query(`DESCRIBE ${table}`);
        console.log(`\n--- ${table} ---`);
        rows.forEach(r => console.log(r.Field, r.Type));
    }
    await desc('courses');
    await desc('course_outcomes');
    await desc('course_outlines');
    await desc('course_prerequisites');
    pool.end();
}
run();
