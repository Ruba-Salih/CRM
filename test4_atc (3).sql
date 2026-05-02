-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 02, 2026 at 09:37 AM
-- Server version: 5.7.42
-- PHP Version: 7.4.3-4ubuntu2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test4_atc`
--

-- --------------------------------------------------------

--
-- Table structure for table `crm_lead_social_profiles`
--

CREATE TABLE `crm_lead_social_profiles` (
  `id` int(11) NOT NULL,
  `crm_lead_id` int(11) NOT NULL,
  `platform` enum('facebook','whatsapp','instagram','pstn','sms','tiktok','telegram') NOT NULL,
  `platform_user_id` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `profile_pic` text,
  `profile_url` text,
  `locale` varchar(10) DEFAULT NULL,
  `timezone` varchar(10) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crm_lead_social_profiles`
--

INSERT INTO `crm_lead_social_profiles` (`id`, `crm_lead_id`, `platform`, `platform_user_id`, `username`, `gender`, `display_name`, `profile_pic`, `profile_url`, `locale`, `timezone`, `created`, `updated`) VALUES
(1, 1, 'facebook', '26283576554564724', NULL, 'Male', 'Abdullah NourAldaim', 'https://platform-lookaside.fbsbx.com/platform/profilepic/?eai=Aa3TzBdXv7VQS4EW_MA4v1N7Lb1Ben1gxaP2lGBNb_qVxwevBkXmjC2CNGl9XrTrLPzl4y4-DFWOaQ&psid=26283576554564724&width=1024&ext=1768950413&hash=AT9vQUP2L9gBdOeQipEPPvLl', NULL, 'en_US', NULL, '2025-12-21 21:06:53', '2025-12-21 21:06:53'),
(2, 2, 'instagram', '1553101339073395', NULL, 'Male', 'Najem', 'https://scontent-fra3-2.cdninstagram.com/v/t51.82787-19/608024093_17845491921657181_6870919307426230615_n.jpg?stp=dst-jpg_s206x206_tt6&_nc_cat=104&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy41MTIuQzMifQ%3D%3D&_nc_ohc=M_MyRzMrS7oQ7kNvwErx4Nv&_nc_oc=AdmugPATpGhpoZSwSjKSoSKD7HO0erIF5iz5YKAPM43tio_D-8XkXe8EUmqwEr1nvP0qG8oRHS8uaf6UCqBzxcNp&_nc_zt=24&_nc_ht=scontent-fra3-2.cdninstagram.com&edm=ALmAK4EEAAAA&_nc_gid=Sf7Yx9-85hlXMP00Mc68EA&oh=00_AfnYRq5pe672D_xmHZTeIc_GwM3mUAtq94JUMGYdf-DT3A&oe=6957EBA2', NULL, 'undefined', NULL, '2025-12-29 05:13:02', '2025-12-29 05:13:02'),
(49, 49, 'instagram', '1516048316353783', NULL, 'Male', 'Alzubair Mhmoud', 'https://scontent-fra3-1.cdninstagram.com/v/t51.82787-19/607202904_17842283946669555_3057057194187318747_n.jpg?stp=dst-jpg_s206x206_tt6&_nc_cat=105&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy4xMDI0LkMzIn0%3D&_nc_ohc=9hZhvwE22WoQ7kNvwFmdLZk&_nc_oc=AdlClaWFQMkasAI5wQ56Md3OapymtpN3oc6sFEWkVuOdwWpqiDqQd5KuFdyPB89tdeioqIGSja3s-t1-kaRNXO8n&_nc_zt=24&_nc_ht=scontent-fra3-1.cdninstagram.com&edm=ALmAK4EEAAAA&_nc_gid=6rIDBXUIvklwlBfrsJBBoA&oh=00_AfkRoaqXoCaCt2wMWwbuezlHVhEo_x0XQgZFnIBZiM59Ow&oe=695845DD', NULL, NULL, NULL, '2025-12-29 11:07:46', '2025-12-29 11:07:46'),
(50, 50, 'instagram', '1352116402899010', NULL, 'Male', 'Husam Mohamed', 'undefined', NULL, 'undefined', NULL, '2025-12-30 09:21:34', '2025-12-30 09:21:34'),
(51, 51, 'instagram', '888319847047209', NULL, 'Male', 'Mhmoud Musa', 'https://scontent-fra5-2.cdninstagram.com/v/t51.82787-19/608463948_17844479316665428_4093107470717577022_n.jpg?stp=dst-jpg_s206x206_tt6&_nc_cat=107&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy4xMDI0LkMzIn0%3D&_nc_ohc=hd6Eo-spWm0Q7kNvwECxHaO&_nc_oc=AdnuCZO0TPgM5pCkn_sppyomq6adoH6kqnVLllp20VxU82iMXBFjSFJTIDvuU9kE6m9r2OZfDwjORmK_c7p8beLN&_nc_zt=24&_nc_ht=scontent-fra5-2.cdninstagram.com&edm=ALmAK4EEAAAA&_nc_gid=ZuAwQDH-HU6ggvtTtUw9RQ&oh=00_Afkrb5JSC_SmcGbua-MfFUHwSYZC9DxOl_QLnluw_RhXMw&oe=69598C53', NULL, 'undefined', NULL, '2025-12-30 09:25:46', '2025-12-30 09:25:46'),
(52, 52, 'instagram', '1377151823861957', NULL, 'Male', 'mohammed', 'undefined', NULL, 'undefined', NULL, '2025-12-31 04:43:27', '2025-12-31 04:43:27');

-- --------------------------------------------------------

--
-- Table structure for table `crm_logs`
--

CREATE TABLE `crm_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `crm_type` varchar(1) NOT NULL COMMENT 'c for call, s for sms',
  `missed_call` tinyint(1) DEFAULT NULL,
  `prospective_customer_id` int(11) DEFAULT NULL,
  `service_type_id` int(11) DEFAULT NULL,
  `service_record_id` int(11) DEFAULT NULL,
  `subservice_record_id` int(11) DEFAULT NULL,
  `service_record` varchar(255) DEFAULT NULL,
  `details` text,
  `priority` int(11) DEFAULT NULL,
  `call_start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `call_finish_time` timestamp NULL DEFAULT NULL,
  `response` text,
  `response_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crm_sales_ticket_levels`
--

CREATE TABLE `crm_sales_ticket_levels` (
  `id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crm_sales_ticket_levels`
--

INSERT INTO `crm_sales_ticket_levels` (`id`, `code`, `name_en`, `name_ar`, `created`, `updated`) VALUES
(1, 'PRE_SALE', 'Pre Sale', 'قبل البيع', '2026-01-21 06:56:14', '2026-01-21 06:56:14'),
(2, 'SOLD', 'Sold', 'تم البيع', '2026-01-21 06:56:14', '2026-01-21 06:56:14'),
(3, 'POST_SALE_FOLLOW_UP', 'Post Sale Follow Up', 'متابعة ما بعد البيع', '2026-01-21 06:56:14', '2026-01-21 06:56:14'),
(4, 'SERVICE_COMPLETED', 'Service Fully Completed', 'اكتمال الخدمة كاملة', '2026-01-21 06:56:14', '2026-01-21 06:56:14'),
(5, 'RATED', 'Rated', 'تم التقييم', '2026-01-21 06:56:14', '2026-01-21 06:56:14');

-- --------------------------------------------------------

--
-- Table structure for table `crm_service_types`
--

CREATE TABLE `crm_service_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crm_service_types`
--

INSERT INTO `crm_service_types` (`id`, `name`) VALUES
(1, 'Offline Course'),
(2, 'Online Course'),
(3, 'Offline Workshop'),
(4, 'Online Workshop'),
(5, 'Certificate'),
(6, 'Complain'),
(7, 'Library'),
(8, 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `crm_tickets`
--

CREATE TABLE `crm_tickets` (
  `id` int(11) NOT NULL,
  `crm_lead_id` int(11) NOT NULL,
  `crm_ticket_type_id` int(11) NOT NULL,
  `sales_level_id` int(11) DEFAULT NULL,
  `running_program_id` int(11) DEFAULT NULL COMMENT 'ID of running_course or workshop',
  `running_program_type` enum('Course','Workshop') DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `transfer_to_human` tinyint(1) NOT NULL DEFAULT '0',
  `last_timer_time` timestamp NULL DEFAULT NULL COMMENT 'updated when the timer function get called',
  `evaluation` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crm_ticket_messages`
--

CREATE TABLE `crm_ticket_messages` (
  `id` int(11) NOT NULL,
  `crm_ticket_id` int(11) NOT NULL,
  `platform` varchar(50) DEFAULT NULL COMMENT 'Source platform name: whatsapp, facebook_post, facebook_message, tiktok, telegram, instagram, pstn, sms, etc.',
  `interaction_type` enum('message','comment','reaction','call') DEFAULT 'message' COMMENT 'Type of interaction for scoring and display',
  `external_id` varchar(255) DEFAULT NULL COMMENT 'The primary key ID from the source table (e.g., whatsapp_messages.id or crm_logs.id)',
  `message_text` text,
  `router_value` varchar(50) DEFAULT NULL,
  `sender_type` enum('customer','bot','human') DEFAULT 'customer',
  `score` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crm_ticket_timers`
--

CREATE TABLE `crm_ticket_timers` (
  `id` int(11) NOT NULL,
  `crm_ticket_id` int(11) NOT NULL,
  `timer_type` enum('PRE_SALE_FOLLOWUP','POST_SALE_FOLLOWUP','TECHNICAL_SUPPORT_FOLLOWUP','COMPLAINT_FOLLOWUP') NOT NULL,
  `sequence_no` tinyint(3) DEFAULT '1',
  `scheduled_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `executed_at` timestamp NULL DEFAULT NULL,
  `status` enum('pending','executed','cancelled','skipped') DEFAULT 'pending',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crm_ticket_types`
--

CREATE TABLE `crm_ticket_types` (
  `id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crm_ticket_types`
--

INSERT INTO `crm_ticket_types` (`id`, `code`, `name_en`, `name_ar`, `created`, `updated`) VALUES
(1, 'PERSONAL_OFFLINE_COURSES', 'Personal Offline Courses Sales', 'مبيعات الدورات التدريبية الشخصية الحضورية', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(2, 'PERSONAL_ONLINE_COURSES', 'Personal Online Courses Sales', 'مبيعات الدورات التدريبية الشخصية عبر الإنترنت', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(3, 'PERSONAL_OFFLINE_WORKSHOPS', 'Personal Offline Workshops Sales', 'مبيعات ورش العمل الشخصية الحضورية', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(4, 'PERSONAL_ONLINE_WORKSHOPS', 'Personal Online Workshops Sales', 'مبيعات ورش العمل الشخصية عبر الإنترنت', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(5, 'CORPORATION_OFFLINE_COURSES', 'Corporation Offline Courses Sales', 'مبيعات الدورات التدريبية للشركات الحضورية', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(6, 'CORPORATION_ONLINE_COURSES', 'Corporation Online Courses Sales', 'مبيعات الدورات التدريبية للشركات عبر الإنترنت', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(7, 'CORPORATION_OFFLINE_WORKSHOPS', 'Corporation Offline Workshops Sales', 'مبيعات ورش العمل للشركات الحضورية', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(8, 'CORPORATION_ONLINE_WORKSHOPS', 'Corporation Online Workshops Sales', 'مبيعات ورش العمل للشركات عبر الإنترنت', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(9, 'RECOMMENDATION_PERSONAL_OFFLINE_COURSES', 'Recommendation Personal Offline Courses Sales', 'مبيعات الدورات التدريبية الشخصية الحضورية (توصية)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(10, 'RECOMMENDATION_PERSONAL_ONLINE_COURSES', 'Recommendation Personal Online Courses Sales', 'مبيعات الدورات التدريبية الشخصية عبر الإنترنت (توصية)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(11, 'RECOMMENDATION_PERSONAL_OFFLINE_WORKSHOPS', 'Recommendation Personal Offline Workshops Sales', 'مبيعات ورش العمل الشخصية الحضورية (توصية)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(12, 'RECOMMENDATION_PERSONAL_ONLINE_WORKSHOPS', 'Recommendation Personal Online Workshops Sales', 'مبيعات ورش العمل الشخصية عبر الإنترنت (توصية)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(13, 'RECOMMENDATION_CORPORATION_OFFLINE_COURSES', 'Recommendation Corporation Offline Courses Sales', 'مبيعات الدورات التدريبية للشركات الحضورية (توصية)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(14, 'RECOMMENDATION_CORPORATION_ONLINE_COURSES', 'Recommendation Corporation Online Courses Sales', 'مبيعات الدورات التدريبية للشركات عبر الإنترنت (توصية)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(15, 'RECOMMENDATION_CORPORATION_OFFLINE_WORKSHOPS', 'Recommendation Corporation Offline Workshops Sales', 'مبيعات ورش العمل للشركات الحضورية (توصية)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(16, 'RECOMMENDATION_CORPORATION_ONLINE_WORKSHOPS', 'Recommendation Corporation Online Workshops Sales', 'مبيعات ورش العمل للشركات عبر الإنترنت (توصية)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(17, 'TRAINING_ADVISOR_PERSONAL_OFFLINE_COURSES', 'Training Advisor Personal Offline Courses Sales', 'مبيعات الدورات التدريبية الشخصية الحضورية (مستشار تدريب)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(18, 'TRAINING_ADVISOR_PERSONAL_ONLINE_COURSES', 'Training Advisor Personal Online Courses Sales', 'مبيعات الدورات التدريبية الشخصية عبر الإنترنت (مستشار تدريب)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(19, 'TRAINING_ADVISOR_PERSONAL_OFFLINE_WORKSHOPS', 'Training Advisor Personal Offline Workshops Sales', 'مبيعات ورش العمل الشخصية الحضورية (مستشار تدريب)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(20, 'TRAINING_ADVISOR_PERSONAL_ONLINE_WORKSHOPS', 'Training Advisor Personal Online Workshops Sales', 'مبيعات ورش العمل الشخصية عبر الإنترنت (مستشار تدريب)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(21, 'TRAINING_ADVISOR_CORPORATION_OFFLINE_COURSES', 'Training Advisor Corporation Offline Courses Sales', 'مبيعات الدورات التدريبية للشركات الحضورية (مستشار تدريب)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(22, 'TRAINING_ADVISOR_CORPORATION_ONLINE_COURSES', 'Training Advisor Corporation Online Courses Sales', 'مبيعات الدورات التدريبية للشركات عبر الإنترنت (مستشار تدريب)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(23, 'TRAINING_ADVISOR_CORPORATION_OFFLINE_WORKSHOPS', 'Training Advisor Corporation Offline Workshops Sales', 'مبيعات ورش العمل للشركات الحضورية (مستشار تدريب)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(24, 'TRAINING_ADVISOR_CORPORATION_ONLINE_WORKSHOPS', 'Training Advisor Corporation Online Workshops Sales', 'مبيعات ورش العمل للشركات عبر الإنترنت (مستشار تدريب)', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(25, 'TECHNICAL_SUPPORT', 'Technical Support', 'الدعم الفني', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(26, 'COMPLAIN', 'Complain', 'شكوى', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(27, 'OUT_OF_PLAN_COURSES', 'Out of Plan Courses Requests', 'طلبات دورات خارج الخطة', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(28, 'NEW_COURSES_WORKSHOPS_REQUESTS', 'New Courses and Workshops Requests', 'طلبات دورات وورش عمل جديدة', '2026-01-19 07:44:08', '2026-01-19 07:44:08'),
(29, 'OUT_OF_PLAN_PERSONAL_OFFLINE_COURSES', 'Out of Plan Personal Offline Courses', 'طلبات الدورات التدريبية الشخصية الحضورية خارج الخطة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(30, 'OUT_OF_PLAN_PERSONAL_ONLINE_COURSES', 'Out of Plan Personal Online Courses', 'طلبات الدورات التدريبية الشخصية عبر الإنترنت خارج الخطة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(31, 'OUT_OF_PLAN_PERSONAL_OFFLINE_WORKSHOPS', 'Out of Plan Personal Offline Workshops', 'طلبات ورش العمل الشخصية الحضورية خارج الخطة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(32, 'OUT_OF_PLAN_PERSONAL_ONLINE_WORKSHOPS', 'Out of Plan Personal Online Workshops', 'طلبات ورش العمل الشخصية عبر الإنترنت خارج الخطة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(33, 'OUT_OF_PLAN_CORPORATION_OFFLINE_COURSES', 'Out of Plan Corporation Offline Courses', 'طلبات الدورات التدريبية للشركات الحضورية خارج الخطة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(34, 'OUT_OF_PLAN_CORPORATION_ONLINE_COURSES', 'Out of Plan Corporation Online Courses', 'طلبات الدورات التدريبية للشركات عبر الإنترنت خارج الخطة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(35, 'OUT_OF_PLAN_CORPORATION_OFFLINE_WORKSHOPS', 'Out of Plan Corporation Offline Workshops', 'طلبات ورش العمل للشركات الحضورية خارج الخطة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(36, 'OUT_OF_PLAN_CORPORATION_ONLINE_WORKSHOPS', 'Out of Plan Corporation Online Workshops', 'طلبات ورش العمل للشركات عبر الإنترنت خارج الخطة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(37, 'NEW_COURSE_REQUEST_PERSONAL_OFFLINE_COURSES', 'New Course Request Personal Offline Courses', 'طلبات الدورات التدريبية الشخصية الحضورية الجديدة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(38, 'NEW_COURSE_REQUEST_PERSONAL_ONLINE_COURSES', 'New Course Request Personal Online Courses', 'طلبات الدورات التدريبية الشخصية عبر الإنترنت الجديدة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(39, 'NEW_COURSE_REQUEST_PERSONAL_OFFLINE_WORKSHOPS', 'New Course Request Personal Offline Workshops', 'طلبات ورش العمل الشخصية الحضورية الجديدة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(40, 'NEW_COURSE_REQUEST_PERSONAL_ONLINE_WORKSHOPS', 'New Course Request Personal Online Workshops', 'طلبات ورش العمل الشخصية عبر الإنترنت الجديدة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(41, 'NEW_COURSE_REQUEST_CORPORATION_OFFLINE_COURSES', 'New Course Request Corporation Offline Courses', 'طلبات الدورات التدريبية للشركات الحضورية الجديدة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(42, 'NEW_COURSE_REQUEST_CORPORATION_ONLINE_COURSES', 'New Course Request Corporation Online Courses', 'طلبات الدورات التدريبية للشركات عبر الإنترنت الجديدة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(43, 'NEW_COURSE_REQUEST_CORPORATION_OFFLINE_WORKSHOPS', 'New Course Request Corporation Offline Workshops', 'طلبات ورش العمل للشركات الحضورية الجديدة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(44, 'NEW_COURSE_REQUEST_CORPORATION_ONLINE_WORKSHOPS', 'New Course Request Corporation Online Workshops', 'طلبات ورش العمل للشركات عبر الإنترنت الجديدة', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(45, 'TRAINER_APPLICATION', 'Trainer Application', 'طلب تقديم مدرب جديد', '2026-04-26 08:24:02', '2026-04-26 08:24:02'),
(46, 'GENERAL_ENQUIRY', 'General / Unclassified', 'استفسار عام / غير مصنف', '2026-04-26 08:24:02', '2026-04-26 08:24:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `crm_lead_social_profiles`
--
ALTER TABLE `crm_lead_social_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_platform_user` (`platform`,`platform_user_id`),
  ADD KEY `lead_id` (`crm_lead_id`);

--
-- Indexes for table `crm_logs`
--
ALTER TABLE `crm_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prospective_customer_id` (`prospective_customer_id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `crm_sales_ticket_levels`
--
ALTER TABLE `crm_sales_ticket_levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `crm_service_types`
--
ALTER TABLE `crm_service_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `crm_tickets`
--
ALTER TABLE `crm_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ticket_sales_level` (`sales_level_id`);

--
-- Indexes for table `crm_ticket_messages`
--
ALTER TABLE `crm_ticket_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `crm_ticket_timers`
--
ALTER TABLE `crm_ticket_timers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_due` (`scheduled_at`,`status`),
  ADD KEY `idx_ticket` (`crm_ticket_id`);

--
-- Indexes for table `crm_ticket_types`
--
ALTER TABLE `crm_ticket_types`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `crm_lead_social_profiles`
--
ALTER TABLE `crm_lead_social_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `crm_logs`
--
ALTER TABLE `crm_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_sales_ticket_levels`
--
ALTER TABLE `crm_sales_ticket_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `crm_service_types`
--
ALTER TABLE `crm_service_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `crm_tickets`
--
ALTER TABLE `crm_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_ticket_messages`
--
ALTER TABLE `crm_ticket_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_ticket_timers`
--
ALTER TABLE `crm_ticket_timers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_ticket_types`
--
ALTER TABLE `crm_ticket_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `crm_tickets`
--
ALTER TABLE `crm_tickets`
  ADD CONSTRAINT `fk_ticket_sales_level` FOREIGN KEY (`sales_level_id`) REFERENCES `crm_sales_ticket_levels` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `crm_ticket_timers`
--
ALTER TABLE `crm_ticket_timers`
  ADD CONSTRAINT `fk_timer_ticket` FOREIGN KEY (`crm_ticket_id`) REFERENCES `crm_tickets` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
