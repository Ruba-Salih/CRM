const mysql = require('mysql2/promise');
require('dotenv').config();

async function test() {
    try {
        const pool = mysql.createPool({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME_TEST4
        });
        const [rows] = await pool.query('SELECT DATABASE() as db');
        console.log('Connected to:', rows[0].db);
        await pool.end();
    } catch (err) {
        console.error('Connection failed:', err.message);
    }
}
test();
