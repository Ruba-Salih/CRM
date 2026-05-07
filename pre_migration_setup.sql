
-- Pre-migration setup: Adding missing CRM tables expected by Migration V3
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `crm_sales_ticket_levels`;
CREATE TABLE `crm_sales_ticket_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `crm_sales_ticket_levels` (`id`, `code`, `name_en`, `name_ar`) VALUES
(1, 'PRE_SALE', 'Pre Sale', 'قبل البيع'),
(2, 'SOLD', 'Sold', 'تم البيع'),
(3, 'POST_SALE_FOLLOW_UP', 'Post Sale Follow Up', 'متابعة ما بعد البيع'),
(4, 'SERVICE_COMPLETED', 'Service Fully Completed', 'اكتمال الخدمة كاملة'),
(5, 'RATED', 'Rated', 'تم التقييم');

DROP TABLE IF EXISTS `crm_tickets`;
CREATE TABLE `crm_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_lead_id` int(11) NOT NULL,
  `crm_ticket_type_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `transfer_to_human` tinyint(1) NOT NULL DEFAULT '0',
  `evaluation` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `crm_ticket_messages`;
CREATE TABLE `crm_ticket_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_ticket_id` int(11) NOT NULL,
  `facebook_comment_id` varchar(255) DEFAULT NULL,
  `facebook_message_id` varchar(255) DEFAULT NULL,
  `instagram_message_id` varchar(255) DEFAULT NULL,
  `instagram_comment_id` varchar(255) DEFAULT NULL,
  `tiktok_comment_id` varchar(255) DEFAULT NULL,
  `tiktok_message_id` varchar(255) DEFAULT NULL,
  `whatsapp_message_id` varchar(255) DEFAULT NULL,
  `telegram_message_id` varchar(255) DEFAULT NULL,
  `linkedin_comment_id` varchar(255) DEFAULT NULL,
  `linkedin_message_id` varchar(255) DEFAULT NULL,
  `pstn_call_id` varchar(255) DEFAULT NULL,
  `pstn_sms_id` varchar(255) DEFAULT NULL,
  `topic_chat_id` varchar(255) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `crm_ticket_types`;
CREATE TABLE `crm_ticket_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `crm_ticket_types` (`id`, `code`, `name_en`, `name_ar`) VALUES
(1, 'PERSONAL_OFFLINE_COURSES', 'Personal Offline Courses Sales', 'مبيعات الدورات التدريبية الشخصية الحضورية'),
(2, 'PERSONAL_ONLINE_COURSES', 'Personal Online Courses Sales', 'مبيعات الدورات التدريبية الشخصية عبر الإنترنت'),
(3, 'PERSONAL_OFFLINE_WORKSHOPS', 'Personal Offline Workshops Sales', 'مبيعات ورش العمل الشخصية الحضورية'),
(4, 'PERSONAL_ONLINE_WORKSHOPS', 'Personal Online Workshops Sales', 'مبيعات ورش العمل الشخصية عبر الإنترنت'),
(5, 'CORPORATION_OFFLINE_COURSES', 'Corporation Offline Courses Sales', 'مبيعات الدورات التدريبية للشركات الحضورية'),
(6, 'CORPORATION_ONLINE_COURSES', 'Corporation Online Courses Sales', 'مبيعات الدورات التدريبية للشركات عبر الإنترنت'),
(7, 'CORPORATION_OFFLINE_WORKSHOPS', 'Corporation Offline Workshops Sales', 'مبيعات ورش العمل للشركات الحضورية'),
(8, 'CORPORATION_ONLINE_WORKSHOPS', 'Corporation Online Workshops Sales', 'مبيعات ورش العمل للشركات عبر الإنترنت'),
(25, 'TECHNICAL_SUPPORT', 'Technical Support', 'الدعم الفني'),
(26, 'COMPLAIN', 'Complain', 'شكوى'),
(27, 'OUT_OF_PLAN_COURSES', 'Out of Plan Courses Requests', 'طلبات دورات خارج الخطة'),
(28, 'NEW_COURSES_WORKSHOPS_REQUESTS', 'New Courses and Workshops Requests', 'طلبات دورات وورش عمل جديدة');

SET FOREIGN_KEY_CHECKS = 1;
