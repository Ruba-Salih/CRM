const mysql = require('mysql2/promise');
require('dotenv').config();

async function populateKnowledgeBase() {
    const pool = mysql.createPool({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME_TEST4,
        charset: 'utf8mb4'
    });

    // Ensure table exists
    await pool.query(`
        CREATE TABLE IF NOT EXISTS crm_dynamic_requirements (
            id int(11) NOT NULL AUTO_INCREMENT,
            key_name varchar(100) NOT NULL,
            content_ar text NOT NULL,
            content_en text DEFAULT NULL,
            updated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (id),
            UNIQUE KEY idx_key_name (key_name)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
    `);

    const requirements = [
        {
            key: 'registration_methods',
            content: `خطوات التسجيل للدورات الأونلاين:
1. دفع الرسوم أولاً وإرسال إشعار الدفع لنا.
2. عمل حساب في الموقع (afro-tech.net) بالاسم الرباعي بالانجليزي.
3. إخطارنا برقم الهاتف لتفعيل الدورة في حسابك.
4. الدخول للدورة في يوم بدايتها.

وسائل الدفع المتاحة:
- كاش في المركز.
- تطبيق بنكك: حساب 3314917 باسم مركز أفروتك للتدريب فرع أركويت.
- تطبيق فوري: حساب 51476227 باسم عبدالله نورالدائم.
- تحويل BBAN: 04033149170002.
- تحويل بطاقة (بنك الخرطوم): 6392 5601 2406 5638.
- باي بال: smartnode.sd@gmail.com.
- ويسترن يونيون باسم: Abdullah Nouraldaim Fathalrhman Ahmed.`
        },
        {
            key: 'refund_policy',
            content: `سياسة الإلغاء والاسترجاع:
- إلغاء قبل أكثر من 72 ساعة من بداية الدورة: خصم 10% واسترجاع باقي المبلغ.
- إلغاء قبل أقل من 72 ساعة: خصم 25% (قيمة حجز مقعد) واسترجاع 75%.
- بعد بداية المحاضرات: لا يحق للدارس استرجاع الرسوم.
- استرجاع كامل: في حال عدم التزام المركز بتاريخ بداية الدورة المعلن فقط.
- التأجيل: يتطلب موافقة خاصة ودفع 35% رسوم تحويل للدورة الجديدة.`
        },
        {
            key: 'center_info',
            content: `بيانات المركز وموقعه:
- الموقع: أم درمان، حي الواحة، مربع 3.
- المعالم القريبة: مسجد الواحة الكبير، صيدلية النور، مدرسة الواحة بنات، طرمبة النيل للبترول، لافتة الصاروخ لخدمات السيارات.
- الإحداثيات: 15.705535, 32.512598.
- ساعات العمل: من السبت إلى الخميس، من 8:30 صباحاً إلى 4:30 عصراً (الجمعة عطلة).`
        },
        {
            key: 'certificate_info',
            content: `بيانات الشهادة:
- الشهادات معتمدة من المجلس القومي للتدريب وقابلة للتوثيق من وزارة الخارجية.
- يتم تسليم الشهادة بعد إكمال الامتحان أو المشروع المطلوب.
- يشترط حضور 75% من محاضرات الدورة على الأقل.`
        },
        {
            key: 'technical_support_faq',
            content: `حلول المشاكل التقنية:
1. شاشة بيضاء: عمل تحديث (Reload) للصفحة.
2. الفيديو لا يعمل: استخدم متصفح Chrome (للأندرويد واللابتوب) أو Safari (للآيفون).
3. نسيان كلمة السر: استخدم رابط "نسيت كلمة السر" في صفحة الدخول أو تواصل معنا لتصفيرها.
4. جودة الفيديو: اضغط على زر الترس (أو auto) أسفل الفيديو واختر 480p للوضوح.
5. تسجيل الدخول: تأكد من كتابة رقم الهاتف بدون مفتاح الدولة (للسودان) وكلمة المرور الصحيحة.`
        }
    ];

    for (let req of requirements) {
        await pool.query(
            "INSERT INTO crm_dynamic_requirements (key_name, content_ar) VALUES (?, ?) ON DUPLICATE KEY UPDATE content_ar = ?",
            [req.key, req.content, req.content]
        );
    }

    console.log("✅ Knowledge Base populated successfully.");
    process.exit(0);
}

populateKnowledgeBase();
