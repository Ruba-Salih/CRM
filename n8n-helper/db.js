const mysql = require('mysql2/promise');
const path = require("path");
require('dotenv').config({ path: path.resolve(__dirname, '../.env') });

const pool = mysql.createPool({
    host: "127.0.0.1",
    user: "root",
    password: "smartnodefirstaicompanyinsudan",
    database: "test4_atc",
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    // socketPath: '/var/run/mysqld/mysqld.sock' // Keep if needed on Linux, but usually 127.0.0.1 works
});

console.log("ATC Database Pool Created!");

module.exports = { pool };

