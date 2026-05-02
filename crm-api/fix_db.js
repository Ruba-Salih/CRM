const mysql = require('mysql2/promise');
require('dotenv').config();

async function fix() {
    const pool = mysql.createPool({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME_ATC,
        charset: 'utf8mb4'
    });

    const descr = 'مدرب خبير في لغة بايثون وعلوم البيانات، حاصل على شهادة دكتوراه في الذكاء الاصطناعي مع خبرة تزيد عن 10 سنوات.';
    
    // Update Python course name too just in case
    await pool.query("UPDATE courses SET name_ar = 'أساسيات بايثون' WHERE id = 3");
    
    const [rows] = await pool.query("SELECT trainer_id FROM running_courses WHERE course_id = 3 LIMIT 1");
    if (rows.length > 0) {
        await pool.query("UPDATE users SET descr_ar = ? WHERE id = ?", [descr, rows[0].trainer_id]);
        console.log("✅ Database updated with proper Arabic text.");
    } else {
        console.log("❌ No running course found for ID 3.");
    }
    
    process.exit(0);
}

fix();
