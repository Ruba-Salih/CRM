
SET FOREIGN_KEY_CHECKS = 0;
START TRANSACTION;

-- 4. Update crm_lead_social_profiles to align with enum logic
ALTER TABLE `crm_lead_social_profiles`
  MODIFY COLUMN `platform` varchar(50) NOT NULL,
  MODIFY COLUMN `gender` varchar(20) DEFAULT NULL;

-- 5. Create crm_ticket_timers Table
CREATE TABLE IF NOT EXISTS `crm_ticket_timers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_ticket_id` int(11) NOT NULL,
  `timer_type` enum('SALES','COMPLAINT','TECHNICAL','POST_SALE') NOT NULL,
  `target_time` timestamp NOT NULL,
  `is_triggered` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `crm_ticket_id` (`crm_ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Add Timer Settings to atc_config
-- Using INSERT IGNORE in case they already exist from a partial run
INSERT IGNORE INTO `atc_config` (`title`, `name`, `value`, `comment`) VALUES
('crm_pre_sale_timer_minutes', 'Sales Timer (minutes)', '1435', '23h55m للمبيعات'),
('crm_complaint_timer_minutes', 'Complaint Timer (minutes)', '240', '4h للشكاوى'),
('crm_technical_timer_minutes', 'Technical Timer (minutes)', '240', '4h للدعم الفني'),
('crm_followup_timer_minutes', 'Follow-up Timer (minutes)', '1435', '23h55m المتابعة التالية');

-- 7. Create crm_support_kb Table for Technical Support FAQ
CREATE TABLE IF NOT EXISTS `crm_support_kb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `problem_key` varchar(100) NOT NULL,
  `problem_title_ar` varchar(255) NOT NULL,
  `solution_ar` text NOT NULL,
  `category` enum('video','account','payment','general') DEFAULT 'general',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. Create crm_dynamic_requirements Table
CREATE TABLE IF NOT EXISTS `crm_dynamic_requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requirement_key` varchar(100) NOT NULL,
  `requirement_value` text NOT NULL,
  `category` varchar(50) DEFAULT 'general',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_key` (`requirement_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
