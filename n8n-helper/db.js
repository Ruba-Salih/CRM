const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
var mysql = require('mysql');
const path = require("path");
require('dotenv').config({path: path.resolve(__dirname, '../.env') });

var con = mysql.createConnection({
    host: "127.0.0.1",
    user: "root",
    password: "smartnodefirstaicompanyinsudan",
    database: "test4_atc",
    socketPath: '/var/run/mysqld/mysqld.sock'
});




con.connect(function(err) {
    if (err) throw err;
    console.log("ATC Connected!");
});




module.exports = {con};

