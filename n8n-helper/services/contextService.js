const { pool } = require("../db");

async function getCourseContext() {
    try {
        const DB_ATC = 'test4_atc'; // Courses are in test4_atc (migrated from system_atc)
        const [courses] = await pool.query(`
            SELECT 
                c.id,
                c.name                                                      AS name_en,
                COALESCE(c.name_ar, c.name)                                 AS name_ar,
                COALESCE(c.descr_ar, c.descr)                               AS description,
                rc.price_sdg,
                rc.price_usd,
                rc.discount,
                DATE_FORMAT(rc.start_time,  '%Y-%m-%d')                     AS start_date,
                IF(rc.room_id IS NULL, 'أونلاين', 'حضورياً في المركز')     AS delivery_method
            FROM \`${DB_ATC}\`.running_courses rc
            JOIN \`${DB_ATC}\`.courses c ON rc.course_id = c.id
            WHERE rc.start_time > NOW() AND rc.cancelled = 0
            ORDER BY rc.start_time ASC
            LIMIT 10
        `);

        if (courses.length === 0) return "لا توجد دورات متاحة حالياً.";

        return "=== الدورات المتاحة حالياً ===\n" +
            courses.map(c => {
                const discountNote = parseFloat(c.discount) > 0 ? ` (خصم ${c.discount}%)` : '';
                return `\n📘 دورة: ${c.name_ar} (${c.name_en})
   طريقة التقديم: ${c.delivery_method}
   السعر: ${parseFloat(c.price_sdg).toLocaleString('ar-EG')} جنيه / ${parseFloat(c.price_usd).toLocaleString('ar-EG')} دولار${discountNote}
   تاريخ البداية: ${c.start_date}`;
            }).join("\n\n") + "\n\n=== نهاية قائمة الدورات ===";
    } catch (err) {
        console.error('⚠️ getCourseContext failed:', err.message);
        return "";
    }
}

async function getRequirementsContext() {
    try {
        const [reqs] = await pool.query(`SELECT key_name, content_ar FROM crm_dynamic_requirements`);
        if (reqs.length === 0) return "";
        return "=== سياسات ومعلومات المركز ===\n" +
            reqs.map(r => `🔹 ${r.key_name}: ${r.content_ar}`).join("\n\n") + "\n\n";
    } catch (err) {
        console.error('⚠️ getRequirementsContext failed:', err.message);
        return "";
    }
}

async function getSupportKbContext() {
    try {
        const [supportKbs] = await pool.query(`SELECT problem_title_ar, solution_ar FROM crm_support_kb`);
        if (supportKbs.length === 0) return "";
        return "=== الدعم الفني وحلول المشاكل التقنية ===\n" +
            supportKbs.map(s => `🔹 مشكلة (${s.problem_title_ar}): ${s.solution_ar}`).join("\n\n") + "\n\n";
    } catch (err) {
        console.error('⚠️ getSupportKbContext failed:', err.message);
        return "";
    }
}

module.exports = {
    getCourseContext,
    getRequirementsContext,
    getSupportKbContext
};
