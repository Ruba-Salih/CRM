const mysql = require('mysql2/promise');

async function fix() {
    const connection = await mysql.createConnection({
        host: 'localhost',
        user: 'lawyer_system',
        password: '1234',
        database: 'test4_atc'
    });
    
    console.log('Connected to DB.');
    
    const queries = [
        "ALTER TABLE crm_tickets ADD COLUMN sales_level_id int(11) DEFAULT NULL",
        "ALTER TABLE crm_tickets ADD COLUMN running_program_id int(11) DEFAULT NULL",
        "ALTER TABLE crm_tickets ADD COLUMN running_program_type enum('Course','Workshop') DEFAULT NULL",
        "ALTER TABLE crm_tickets ADD COLUMN last_timer_time timestamp NULL DEFAULT NULL",
        "ALTER TABLE crm_leads ADD COLUMN user_id_fk int(11) DEFAULT NULL",
        "CREATE TABLE IF NOT EXISTS crm_ticket_timers ( id int(11) NOT NULL AUTO_INCREMENT, crm_ticket_id int(11) NOT NULL, timer_type enum('PRE_SALE_FOLLOWUP','POST_SALE_FOLLOWUP','TECHNICAL_SUPPORT_FOLLOWUP','COMPLAINT_FOLLOWUP') NOT NULL, sequence_no tinyint(3) DEFAULT 1, scheduled_at timestamp NOT NULL, executed_at timestamp NULL DEFAULT NULL, status enum('pending','executed','cancelled','skipped') DEFAULT 'pending', created timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (id) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
        "CREATE TABLE IF NOT EXISTS crm_platforms ( id int(11) NOT NULL AUTO_INCREMENT, code varchar(50) NOT NULL, name varchar(100) NOT NULL, created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (id), UNIQUE KEY code (code) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
        "INSERT IGNORE INTO crm_platforms (code, name) VALUES ('facebook', 'Facebook'), ('instagram', 'Instagram'), ('whatsapp', 'WhatsApp'), ('tiktok', 'TikTok'), ('sms', 'SMS');",
        "ALTER TABLE crm_ticket_messages ADD COLUMN platform_id int(11) DEFAULT NULL, ADD COLUMN interaction_type enum('message', 'comment') DEFAULT 'message', ADD COLUMN router_value varchar(50) DEFAULT NULL"
    ];

    for (let q of queries) {
        try {
            await connection.query(q);
            console.log('Processed query successfully');
        } catch(err) {
            console.log('Skipped/Failed query: ', err.message);
        }
    }

    await connection.end();
}

fix();
