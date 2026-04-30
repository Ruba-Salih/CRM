const mysql = require('mysql2/promise');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

async function migrate() {
    const connection = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: 'lawyer_system',
        password: '1234',
        database: process.env.DB_NAME_TEST4,
        multipleStatements: true
    });

    console.log('Connected to MySQL. Starting migration...');

    try {
        const sqlPath = path.join(__dirname, '..', 'migration_v1_ticketing_system.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');

        await connection.query(sql);
        console.log('Migration successful!');
    } catch (error) {
        console.error('Migration failed:', error);
    } finally {
        await connection.end();
    }
}

migrate();
