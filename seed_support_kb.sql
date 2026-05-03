CREATE TABLE IF NOT EXISTS `crm_support_kb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `problem_key` varchar(100) NOT NULL,
  `problem_title_ar` varchar(255) NOT NULL,
  `solution_ar` text NOT NULL,
  `category` enum('video','account','payment','general') DEFAULT 'general',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_problem_key` (`problem_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `crm_support_kb` (`problem_key`, `problem_title_ar`, `solution_ar`, `category`) VALUES
('white_screen', 'شاشة بيضاء', 'اعمل تحديث للصفحة (Reload) واصبر شوية. أول مرة المنصة بتحتاج زمن بسيط لحدي ما تفتح.', 'general'),
('registration_help', 'كيفية التسجيل', 'اضغط على "تسجيل" بالعربي أو "Register" بالإنجليزي في الصفحة الرئيسية.', 'account'),
('account_exists', 'الحساب موجود مسبقاً', 'معناها عندك حساب أصلاً. اتواصل معانا في الواتساب وما تعمل حساب جديد: 0925777109 – 0967492783', 'account'),
('where_is_course', 'وين ألقى الدورة؟', 'لو ما دافع: لازم يدفع أول. لو دافع: بيلقى دورته في الرابط: https://afro-tech.net/#!/app/account/dashboard/', 'video'),
('video_not_working', 'الفيديو ما اشتغل معاي', 'استخدم متصفح Chrome (أندرويد/لابتوب) أو Safari (آيفون). تأكد أن المتصفح آخر إصدار.', 'video'),
('video_quality', 'جودة الفيديو ضعيفة', 'تحت الفيديو اضغط زر auto (أسفل يمين) واختر 480p لوضوح الكتابة.', 'video'),
('screen_size', 'الشاشة صغيرة', 'اضغط زر المربع أسفل الفيديو وفعّل تدوير الشاشة التلقائي في جهازك.', 'video'),
('forgot_password', 'نسيت كلمة السر', 'استخدم رابط "نسيت كلمة السر" في صفحة الدخول أو تواصل معنا في الواتساب: 0925777109.', 'account'),
('access_steps', 'طريقة الوصول للفيديوهات', '1. افتح الداشبورد | 2. اضغط اسم الدورة | 3. اضغط أيقونة الفيديوهات (رقم 2) | 4. استخدم زر Next.', 'video');
