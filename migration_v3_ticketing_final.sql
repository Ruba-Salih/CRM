-- ==========================================================
-- CRM Ticketing System Comprehensive Migration - Version 3.0
-- Description: Consolidates all changes from v1, v2, and the new requirements.
-- This script transforms the base 'system_atc' to the final CRM Ticketing structure.
-- ==========================================================

SET FOREIGN_KEY_CHECKS = 0;
START TRANSACTION;

-- 1. Modify crm_ticket_messages (Normalized & Direct Platform String)
-- Dropping old platform-specific message IDs (handled manually if errors occur)
ALTER TABLE `crm_ticket_messages`
  DROP COLUMN `facebook_comment_id`,
  DROP COLUMN `facebook_message_id`,
  DROP COLUMN `instagram_message_id`,
  DROP COLUMN `instagram_comment_id`,
  DROP COLUMN `tiktok_comment_id`,
  DROP COLUMN `tiktok_message_id`,
  DROP COLUMN `whatsapp_message_id`,
  DROP COLUMN `telegram_message_id`,
  DROP COLUMN `linkedin_comment_id`,
  DROP COLUMN `linkedin_message_id`,
  DROP COLUMN `pstn_call_id`,
  DROP COLUMN `pstn_sms_id`,
  DROP COLUMN `topic_chat_id`;

-- Adding new normalized columns
ALTER TABLE `crm_ticket_messages`
  ADD COLUMN `platform` varchar(50) DEFAULT NULL AFTER `crm_ticket_id` COMMENT 'Source platform name: whatsapp, facebook, tiktok, telegram, instagram, pstn, sms',
  ADD COLUMN `interaction_type` enum('message', 'comment', 'reaction', 'call') DEFAULT 'message' AFTER `platform`,
  ADD COLUMN `external_id` varchar(255) DEFAULT NULL AFTER `interaction_type` COMMENT 'The primary key ID from the source table',
  ADD COLUMN `message_text` text DEFAULT NULL AFTER `external_id`,
  ADD COLUMN `attachment_url` text DEFAULT NULL AFTER `message_text` COMMENT 'URL for image, audio, or document sent by user',
  ADD COLUMN `router_value` varchar(50) DEFAULT NULL AFTER `attachment_url`,
  ADD COLUMN `sender_type` enum('customer','bot','human') DEFAULT 'customer' AFTER `router_value`;

-- 2. Update crm_tickets with Sales Context and Timing
ALTER TABLE `crm_tickets`
  ADD COLUMN `sales_level_id` int(11) DEFAULT NULL AFTER `crm_ticket_type_id`,
  ADD COLUMN `running_program_id` int(11) DEFAULT NULL AFTER `sales_level_id` COMMENT 'ID of running_course or workshop',
  ADD COLUMN `running_program_type` enum('Course','Workshop') DEFAULT NULL AFTER `running_program_id`,
  ADD COLUMN `last_timer_time` timestamp NULL DEFAULT NULL AFTER `updated`,
  ADD CONSTRAINT `fk_ticket_sales_level` FOREIGN KEY (`sales_level_id`) REFERENCES `crm_sales_ticket_levels` (`id`) ON DELETE SET NULL;

-- 3. Update crm_leads and crm_lead_social_profiles to align with enum logic
ALTER TABLE `crm_leads`
  ADD COLUMN `user_id_fk` int(11) DEFAULT NULL AFTER `user_id` COMMENT 'Link to users.id after registration',
  MODIFY COLUMN `source_platform` varchar(50) NOT NULL,
  MODIFY COLUMN `first_interaction_type` enum('comment','reaction','message','call') NOT NULL;

ALTER TABLE `crm_lead_social_profiles`
  MODIFY COLUMN `platform` enum('facebook','whatsapp','instagram','pstn','sms','tiktok', 'telegram') NOT NULL;

-- 4. Create crm_ticket_timers Table
CREATE TABLE IF NOT EXISTS `crm_ticket_timers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_ticket_id` int(11) NOT NULL,
  `timer_type` enum('PRE_SALE_FOLLOWUP','POST_SALE_FOLLOWUP','TECHNICAL_SUPPORT_FOLLOWUP','COMPLAINT_FOLLOWUP') NOT NULL,
  `sequence_no` tinyint(3) DEFAULT 1,
  `scheduled_at` timestamp NOT NULL,
  `executed_at` timestamp NULL DEFAULT NULL,
  `status` enum('pending','executed','cancelled','skipped') DEFAULT 'pending',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_due` (`scheduled_at`, `status`),
  KEY `idx_ticket` (`crm_ticket_id`),
  CONSTRAINT `fk_timer_ticket` FOREIGN KEY (`crm_ticket_id`) REFERENCES `crm_tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Create crm_dynamic_requirements Table for AI Knowledge Base
CREATE TABLE IF NOT EXISTS `crm_dynamic_requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key_name` varchar(100) NOT NULL,
  `content_ar` text NOT NULL,
  `content_en` text DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_key_name` (`key_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed Dynamic Requirements Data
INSERT IGNORE INTO `crm_dynamic_requirements` (`key_name`, `content_ar`) VALUES
('registration_methods', 'طرق التسجيل المتاحة هي...'),
('refund_policy', 'سياسة الاسترجاع والتعويض تنص على...'),
('discount_policy', 'سياسات الخصم والعروض الحالية...'),
('center_info', 'بيانات المركز وموقعه...'),
('certificate_info', 'بيانات الشهادة واعتمادها...');

-- 6. Insert New Ticket Types
INSERT IGNORE INTO `crm_ticket_types` (`id`, `code`, `name_en`, `name_ar`) VALUES
-- 1. Out of Plan Requests (29-36)
(29, 'OUT_OF_PLAN_PERSONAL_OFFLINE_COURSES', 'Out of Plan Personal Offline Courses', 'طلبات الدورات التدريبية الشخصية الحضورية خارج الخطة'),
(30, 'OUT_OF_PLAN_PERSONAL_ONLINE_COURSES', 'Out of Plan Personal Online Courses', 'طلبات الدورات التدريبية الشخصية عبر الإنترنت خارج الخطة'),
(31, 'OUT_OF_PLAN_PERSONAL_OFFLINE_WORKSHOPS', 'Out of Plan Personal Offline Workshops', 'طلبات ورش العمل الشخصية الحضورية خارج الخطة'),
(32, 'OUT_OF_PLAN_PERSONAL_ONLINE_WORKSHOPS', 'Out of Plan Personal Online Workshops', 'طلبات ورش العمل الشخصية عبر الإنترنت خارج الخطة'),
(33, 'OUT_OF_PLAN_CORPORATION_OFFLINE_COURSES', 'Out of Plan Corporation Offline Courses', 'طلبات الدورات التدريبية للشركات الحضورية خارج الخطة'),
(34, 'OUT_OF_PLAN_CORPORATION_ONLINE_COURSES', 'Out of Plan Corporation Online Courses', 'طلبات الدورات التدريبية للشركات عبر الإنترنت خارج الخطة'),
(35, 'OUT_OF_PLAN_CORPORATION_OFFLINE_WORKSHOPS', 'Out of Plan Corporation Offline Workshops', 'طلبات ورش العمل للشركات الحضورية خارج الخطة'),
(36, 'OUT_OF_PLAN_CORPORATION_ONLINE_WORKSHOPS', 'Out of Plan Corporation Online Workshops', 'طلبات ورش العمل للشركات عبر الإنترنت خارج الخطة'),

-- 2. New Course Requests (37-44)
(37, 'NEW_COURSE_REQUEST_PERSONAL_OFFLINE_COURSES', 'New Course Request Personal Offline Courses', 'طلبات الدورات التدريبية الشخصية الحضورية الجديدة'),
(38, 'NEW_COURSE_REQUEST_PERSONAL_ONLINE_COURSES', 'New Course Request Personal Online Courses', 'طلبات الدورات التدريبية الشخصية عبر الإنترنت الجديدة'),
(39, 'NEW_COURSE_REQUEST_PERSONAL_OFFLINE_WORKSHOPS', 'New Course Request Personal Offline Workshops', 'طلبات ورش العمل الشخصية الحضورية الجديدة'),
(40, 'NEW_COURSE_REQUEST_PERSONAL_ONLINE_WORKSHOPS', 'New Course Request Personal Online Workshops', 'طلبات ورش العمل الشخصية عبر الإنترنت الجديدة'),
(41, 'NEW_COURSE_REQUEST_CORPORATION_OFFLINE_COURSES', 'New Course Request Corporation Offline Courses', 'طلبات الدورات التدريبية للشركات الحضورية الجديدة'),
(42, 'NEW_COURSE_REQUEST_CORPORATION_ONLINE_COURSES', 'New Course Request Corporation Online Courses', 'طلبات الدورات التدريبية للشركات عبر الإنترنت الجديدة'),
(43, 'NEW_COURSE_REQUEST_CORPORATION_OFFLINE_WORKSHOPS', 'New Course Request Corporation Offline Workshops', 'طلبات ورش العمل للشركات الحضورية الجديدة'),
(44, 'NEW_COURSE_REQUEST_CORPORATION_ONLINE_WORKSHOPS', 'New Course Request Corporation Online Workshops', 'طلبات ورش العمل للشركات عبر الإنترنت الجديدة'),

(45, 'TRAINER_APPLICATION', 'Trainer Application', 'طلب تقديم مدرب جديد'),
(46, 'GENERAL_ENQUIRY', 'General / Unclassified', 'استفسار عام / غير مصنف');

-- 7. Add Timer Settings to atc_config
INSERT IGNORE INTO `atc_config` (`title`, `value`) VALUES
('crm_pre_sale_timer_minutes', '1435'),
('crm_complaint_timer_minutes', '240'),
('crm_technical_timer_minutes', '240'),
('crm_followup_timer_minutes', '1435');

-- 8. Clean up old crm_platforms table (Since we now use strings)
DROP TABLE IF EXISTS `crm_platforms`;

COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
