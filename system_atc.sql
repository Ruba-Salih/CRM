-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 12, 2026 at 08:58 AM
-- Server version: 5.7.40
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `system_atc`
--

-- --------------------------------------------------------

--
-- Table structure for table `crm_leads`
--

DROP TABLE IF EXISTS `crm_leads`;
CREATE TABLE IF NOT EXISTS `crm_leads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `source_platform` enum('facebook','instagram','tiktok','whatsapp') NOT NULL,
  `first_interaction_type` enum('comment','reaction','message') NOT NULL,
  `first_interaction_time` timestamp NULL DEFAULT NULL,
  `last_interaction_time` timestamp NULL DEFAULT NULL,
  `lead_score` int(11) DEFAULT '0',
  `status` enum('new','contacted','qualified','converted','lost') DEFAULT 'new',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `source_platform` (`source_platform`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crm_leads`
--

INSERT INTO `crm_leads` (`id`, `user_id`, `source_platform`, `first_interaction_type`, `first_interaction_time`, `last_interaction_time`, `lead_score`, `status`, `created`, `updated`) VALUES
(1, NULL, 'facebook', 'message', '2025-12-21 23:06:53', '2025-12-21 23:06:53', 5, 'new', '2025-12-21 23:06:53', '2025-12-21 23:06:53'),
(2, NULL, 'facebook', 'message', '2025-12-29 07:13:02', '2025-12-29 07:13:02', 5, 'new', '2025-12-29 07:13:02', '2025-12-29 07:13:02'),
(3, NULL, 'facebook', 'message', '2025-12-29 07:17:36', '2025-12-29 07:17:36', 5, 'new', '2025-12-29 07:17:36', '2025-12-29 07:17:36'),
(4, NULL, 'facebook', 'message', '2025-12-29 07:21:05', '2025-12-29 07:21:05', 5, 'new', '2025-12-29 07:21:05', '2025-12-29 07:21:05'),
(6, NULL, 'instagram', 'message', '2025-12-29 07:32:16', '2025-12-29 07:32:16', 5, 'new', '2025-12-29 07:32:16', '2025-12-29 07:32:16'),
(7, NULL, 'instagram', 'message', '2025-12-29 07:38:33', '2025-12-29 07:38:33', 5, 'new', '2025-12-29 07:38:33', '2025-12-29 07:38:33'),
(8, NULL, 'instagram', 'message', '2025-12-29 07:40:57', '2025-12-29 07:40:57', 5, 'new', '2025-12-29 07:40:57', '2025-12-29 07:40:57'),
(10, NULL, 'instagram', 'message', '2025-12-29 07:44:53', '2025-12-29 07:44:53', 5, 'new', '2025-12-29 07:44:53', '2025-12-29 07:44:53'),
(11, NULL, 'instagram', 'message', '2025-12-29 07:46:48', '2025-12-29 07:46:48', 5, 'new', '2025-12-29 07:46:48', '2025-12-29 07:46:48'),
(12, NULL, 'instagram', 'message', '2025-12-29 07:53:13', '2025-12-29 07:53:13', 5, 'new', '2025-12-29 07:53:13', '2025-12-29 07:53:13'),
(13, NULL, 'instagram', 'message', '2025-12-29 07:53:53', '2025-12-29 07:53:53', 5, 'new', '2025-12-29 07:53:53', '2025-12-29 07:53:53'),
(14, NULL, 'instagram', 'message', '2025-12-29 07:57:45', '2025-12-29 07:57:45', 5, 'new', '2025-12-29 07:57:45', '2025-12-29 07:57:45'),
(15, NULL, 'instagram', 'message', '2025-12-29 08:02:03', '2025-12-29 08:02:03', 5, 'new', '2025-12-29 08:02:03', '2025-12-29 08:02:03'),
(16, NULL, 'instagram', 'message', '2025-12-29 08:08:21', '2025-12-29 08:08:21', 5, 'new', '2025-12-29 08:08:21', '2025-12-29 08:08:21'),
(17, NULL, 'instagram', 'message', '2025-12-29 08:08:34', '2025-12-29 08:08:34', 5, 'new', '2025-12-29 08:08:34', '2025-12-29 08:08:34'),
(18, NULL, 'instagram', 'message', '2025-12-29 08:11:38', '2025-12-29 08:11:38', 5, 'new', '2025-12-29 08:11:38', '2025-12-29 08:11:38'),
(19, NULL, 'instagram', 'message', '2025-12-29 08:11:52', '2025-12-29 08:11:52', 5, 'new', '2025-12-29 08:11:52', '2025-12-29 08:11:52'),
(20, NULL, 'instagram', 'message', '2025-12-29 08:12:37', '2025-12-29 08:12:37', 5, 'new', '2025-12-29 08:12:37', '2025-12-29 08:12:37'),
(21, NULL, 'instagram', 'message', '2025-12-29 08:12:52', '2025-12-29 08:12:52', 5, 'new', '2025-12-29 08:12:52', '2025-12-29 08:12:52'),
(22, NULL, 'instagram', 'message', '2025-12-29 08:13:06', '2025-12-29 08:13:06', 5, 'new', '2025-12-29 08:13:06', '2025-12-29 08:13:06'),
(23, NULL, 'instagram', 'message', '2025-12-29 08:15:20', '2025-12-29 08:15:20', 5, 'new', '2025-12-29 08:15:20', '2025-12-29 08:15:20'),
(24, NULL, 'instagram', 'message', '2025-12-29 08:22:53', '2025-12-29 08:22:53', 5, 'new', '2025-12-29 08:22:53', '2025-12-29 08:22:53'),
(25, NULL, 'instagram', 'message', '2025-12-29 08:30:40', '2025-12-29 08:30:40', 5, 'new', '2025-12-29 08:30:40', '2025-12-29 08:30:40'),
(26, NULL, 'instagram', 'message', '2025-12-29 08:31:06', '2025-12-29 08:31:06', 5, 'new', '2025-12-29 08:31:06', '2025-12-29 08:31:06'),
(27, NULL, 'instagram', 'message', '2025-12-29 08:43:00', '2025-12-29 08:43:00', 5, 'new', '2025-12-29 08:43:00', '2025-12-29 08:43:00'),
(28, NULL, 'instagram', 'message', '2025-12-29 08:45:13', '2025-12-29 08:45:13', 5, 'new', '2025-12-29 08:45:13', '2025-12-29 08:45:13'),
(29, NULL, 'instagram', 'message', '2025-12-29 08:48:14', '2025-12-29 08:48:14', 5, 'new', '2025-12-29 08:48:14', '2025-12-29 08:48:14'),
(30, NULL, 'instagram', 'message', '2025-12-29 08:50:25', '2025-12-29 08:50:25', 5, 'new', '2025-12-29 08:50:25', '2025-12-29 08:50:25'),
(31, NULL, 'instagram', 'message', '2025-12-29 09:07:10', '2025-12-29 09:07:10', 5, 'new', '2025-12-29 09:07:10', '2025-12-29 09:07:10'),
(32, NULL, 'instagram', 'message', '2025-12-29 11:28:37', '2025-12-29 11:28:37', 5, 'new', '2025-12-29 11:28:37', '2025-12-29 11:28:37'),
(33, NULL, 'instagram', 'message', '2025-12-29 11:33:04', '2025-12-29 11:33:04', 5, 'new', '2025-12-29 11:33:04', '2025-12-29 11:33:04'),
(34, NULL, 'instagram', 'message', '2025-12-29 11:33:52', '2025-12-29 11:33:52', 5, 'new', '2025-12-29 11:33:52', '2025-12-29 11:33:52'),
(35, NULL, 'instagram', 'message', '2025-12-29 11:34:49', '2025-12-29 11:34:49', 5, 'new', '2025-12-29 11:34:49', '2025-12-29 11:34:49'),
(36, NULL, 'instagram', 'message', '2025-12-29 11:44:28', '2025-12-29 11:44:28', 5, 'new', '2025-12-29 11:44:28', '2025-12-29 11:44:28'),
(37, NULL, 'instagram', 'message', '2025-12-29 11:47:39', '2025-12-29 11:47:39', 5, 'new', '2025-12-29 11:47:39', '2025-12-29 11:47:39'),
(38, NULL, 'instagram', 'message', '2025-12-29 11:49:34', '2025-12-29 11:49:34', 5, 'new', '2025-12-29 11:49:34', '2025-12-29 11:49:34'),
(39, NULL, 'instagram', 'message', '2025-12-29 11:52:04', '2025-12-29 11:52:04', 5, 'new', '2025-12-29 11:52:04', '2025-12-29 11:52:04'),
(40, NULL, 'instagram', 'message', '2025-12-29 11:53:57', '2025-12-29 11:53:57', 5, 'new', '2025-12-29 11:53:57', '2025-12-29 11:53:57'),
(41, NULL, 'instagram', 'message', '2025-12-29 11:54:26', '2025-12-29 11:54:26', 5, 'new', '2025-12-29 11:54:26', '2025-12-29 11:54:26'),
(42, NULL, 'instagram', 'message', '2025-12-29 11:54:31', '2025-12-29 11:54:31', 5, 'new', '2025-12-29 11:54:31', '2025-12-29 11:54:31'),
(43, NULL, 'instagram', 'message', '2025-12-29 11:59:29', '2025-12-29 11:59:29', 5, 'new', '2025-12-29 11:59:29', '2025-12-29 11:59:29'),
(44, NULL, 'instagram', 'message', '2025-12-29 12:03:12', '2025-12-29 12:03:12', 5, 'new', '2025-12-29 12:03:12', '2025-12-29 12:03:12'),
(45, NULL, 'instagram', 'message', '2025-12-29 12:03:29', '2025-12-29 12:03:29', 5, 'new', '2025-12-29 12:03:29', '2025-12-29 12:03:29'),
(46, NULL, 'instagram', 'message', '2025-12-29 12:04:52', '2025-12-29 12:04:52', 5, 'new', '2025-12-29 12:04:52', '2025-12-29 12:04:52'),
(47, NULL, 'instagram', 'message', '2025-12-29 12:05:03', '2025-12-29 12:05:03', 5, 'new', '2025-12-29 12:05:03', '2025-12-29 12:05:03'),
(48, NULL, 'instagram', 'message', '2025-12-29 12:09:41', '2025-12-29 12:09:41', 5, 'new', '2025-12-29 12:09:41', '2025-12-29 12:09:41'),
(49, NULL, 'instagram', 'message', '2025-12-29 13:07:46', '2025-12-29 13:07:46', 5, 'new', '2025-12-29 13:07:46', '2025-12-29 13:07:46'),
(50, NULL, 'instagram', 'message', '2025-12-30 11:21:34', '2025-12-30 11:21:34', 5, 'new', '2025-12-30 11:21:34', '2025-12-30 11:21:34'),
(51, NULL, 'instagram', 'message', '2025-12-30 11:25:46', '2025-12-30 11:25:46', 5, 'new', '2025-12-30 11:25:46', '2025-12-30 11:25:46'),
(52, NULL, 'instagram', 'message', '2025-12-31 06:43:27', '2025-12-31 06:43:27', 5, 'new', '2025-12-31 06:43:27', '2025-12-31 06:43:27');

-- --------------------------------------------------------

--
-- Table structure for table `crm_lead_social_profiles`
--

DROP TABLE IF EXISTS `crm_lead_social_profiles`;
CREATE TABLE IF NOT EXISTS `crm_lead_social_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_lead_id` int(11) NOT NULL,
  `platform` enum('facebook','instagram','tiktok','whatsapp') NOT NULL,
  `platform_user_id` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `profile_pic` text,
  `profile_url` text,
  `locale` varchar(10) DEFAULT NULL,
  `timezone` varchar(10) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_platform_user` (`platform`,`platform_user_id`),
  KEY `lead_id` (`crm_lead_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crm_lead_social_profiles`
--

INSERT INTO `crm_lead_social_profiles` (`id`, `crm_lead_id`, `platform`, `platform_user_id`, `username`, `gender`, `display_name`, `profile_pic`, `profile_url`, `locale`, `timezone`, `created`, `updated`) VALUES
(1, 1, 'facebook', '26283576554564724', NULL, 'Male', 'Abdullah NourAldaim', 'https://platform-lookaside.fbsbx.com/platform/profilepic/?eai=Aa3TzBdXv7VQS4EW_MA4v1N7Lb1Ben1gxaP2lGBNb_qVxwevBkXmjC2CNGl9XrTrLPzl4y4-DFWOaQ&psid=26283576554564724&width=1024&ext=1768950413&hash=AT9vQUP2L9gBdOeQipEPPvLl', NULL, 'en_US', NULL, '2025-12-21 23:06:53', '2025-12-21 23:06:53'),
(2, 2, 'instagram', '1553101339073395', NULL, 'Male', 'Najem', 'https://scontent-fra3-2.cdninstagram.com/v/t51.82787-19/608024093_17845491921657181_6870919307426230615_n.jpg?stp=dst-jpg_s206x206_tt6&_nc_cat=104&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy41MTIuQzMifQ%3D%3D&_nc_ohc=M_MyRzMrS7oQ7kNvwErx4Nv&_nc_oc=AdmugPATpGhpoZSwSjKSoSKD7HO0erIF5iz5YKAPM43tio_D-8XkXe8EUmqwEr1nvP0qG8oRHS8uaf6UCqBzxcNp&_nc_zt=24&_nc_ht=scontent-fra3-2.cdninstagram.com&edm=ALmAK4EEAAAA&_nc_gid=Sf7Yx9-85hlXMP00Mc68EA&oh=00_AfnYRq5pe672D_xmHZTeIc_GwM3mUAtq94JUMGYdf-DT3A&oe=6957EBA2', NULL, 'undefined', NULL, '2025-12-29 07:13:02', '2025-12-29 07:13:02'),
(49, 49, 'instagram', '1516048316353783', NULL, 'Male', 'Alzubair Mhmoud', 'https://scontent-fra3-1.cdninstagram.com/v/t51.82787-19/607202904_17842283946669555_3057057194187318747_n.jpg?stp=dst-jpg_s206x206_tt6&_nc_cat=105&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy4xMDI0LkMzIn0%3D&_nc_ohc=9hZhvwE22WoQ7kNvwFmdLZk&_nc_oc=AdlClaWFQMkasAI5wQ56Md3OapymtpN3oc6sFEWkVuOdwWpqiDqQd5KuFdyPB89tdeioqIGSja3s-t1-kaRNXO8n&_nc_zt=24&_nc_ht=scontent-fra3-1.cdninstagram.com&edm=ALmAK4EEAAAA&_nc_gid=6rIDBXUIvklwlBfrsJBBoA&oh=00_AfkRoaqXoCaCt2wMWwbuezlHVhEo_x0XQgZFnIBZiM59Ow&oe=695845DD', NULL, NULL, NULL, '2025-12-29 13:07:46', '2025-12-29 13:07:46'),
(50, 50, 'instagram', '1352116402899010', NULL, 'Male', 'Husam Mohamed', 'undefined', NULL, 'undefined', NULL, '2025-12-30 11:21:34', '2025-12-30 11:21:34'),
(51, 51, 'instagram', '888319847047209', NULL, 'Male', 'Mhmoud Musa', 'https://scontent-fra5-2.cdninstagram.com/v/t51.82787-19/608463948_17844479316665428_4093107470717577022_n.jpg?stp=dst-jpg_s206x206_tt6&_nc_cat=107&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy4xMDI0LkMzIn0%3D&_nc_ohc=hd6Eo-spWm0Q7kNvwECxHaO&_nc_oc=AdnuCZO0TPgM5pCkn_sppyomq6adoH6kqnVLllp20VxU82iMXBFjSFJTIDvuU9kE6m9r2OZfDwjORmK_c7p8beLN&_nc_zt=24&_nc_ht=scontent-fra5-2.cdninstagram.com&edm=ALmAK4EEAAAA&_nc_gid=ZuAwQDH-HU6ggvtTtUw9RQ&oh=00_Afkrb5JSC_SmcGbua-MfFUHwSYZC9DxOl_QLnluw_RhXMw&oe=69598C53', NULL, 'undefined', NULL, '2025-12-30 11:25:46', '2025-12-30 11:25:46'),
(52, 52, 'instagram', '1377151823861957', NULL, 'Male', 'mohammed', 'undefined', NULL, 'undefined', NULL, '2025-12-31 06:43:27', '2025-12-31 06:43:27');

-- --------------------------------------------------------

--
-- Table structure for table `crm_logs`
--

DROP TABLE IF EXISTS `crm_logs`;
CREATE TABLE IF NOT EXISTS `crm_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `response_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prospective_customer_id` (`prospective_customer_id`),
  KEY `admin_id` (`admin_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crm_sales_ticket_levels`
--

DROP TABLE IF EXISTS `crm_sales_ticket_levels`;
CREATE TABLE IF NOT EXISTS `crm_sales_ticket_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crm_sales_ticket_levels`
--

INSERT INTO `crm_sales_ticket_levels` (`id`, `code`, `name_en`, `name_ar`, `created`, `updated`) VALUES
(1, 'PRE_SALE', 'Pre Sale', 'قبل البيع', '2026-01-21 08:56:14', '2026-01-21 08:56:14'),
(2, 'SOLD', 'Sold', 'تم البيع', '2026-01-21 08:56:14', '2026-01-21 08:56:14'),
(3, 'POST_SALE_FOLLOW_UP', 'Post Sale Follow Up', 'متابعة ما بعد البيع', '2026-01-21 08:56:14', '2026-01-21 08:56:14'),
(4, 'SERVICE_COMPLETED', 'Service Fully Completed', 'اكتمال الخدمة كاملة', '2026-01-21 08:56:14', '2026-01-21 08:56:14'),
(5, 'RATED', 'Rated', 'تم التقييم', '2026-01-21 08:56:14', '2026-01-21 08:56:14');

-- --------------------------------------------------------

--
-- Table structure for table `crm_service_types`
--

DROP TABLE IF EXISTS `crm_service_types`;
CREATE TABLE IF NOT EXISTS `crm_service_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

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

DROP TABLE IF EXISTS `crm_tickets`;
CREATE TABLE IF NOT EXISTS `crm_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_lead_id` int(11) NOT NULL,
  `crm_ticket_type_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `transfer_to_human` tinyint(1) NOT NULL DEFAULT '0',
  `last_timer_time` timestamp NULL DEFAULT NULL COMMENT 'updated when the timer function get called',
  `evaluation` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crm_ticket_messages`
--

DROP TABLE IF EXISTS `crm_ticket_messages`;
CREATE TABLE IF NOT EXISTS `crm_ticket_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_ticket_id` int(11) NOT NULL,
  `facebook_comment_id` int(11) NOT NULL,
  `facebook_message_id` int(11) NOT NULL,
  `instagram_message_id` int(11) NOT NULL,
  `instagram_comment_id` int(11) NOT NULL,
  `tiktok_comment_id` int(11) NOT NULL,
  `tiktok_message_id` int(11) NOT NULL,
  `whatsapp_message_id` int(11) NOT NULL,
  `telegram_message_id` int(11) NOT NULL,
  `linkedin_comment_id` int(11) NOT NULL,
  `linkedin_message_id` int(11) NOT NULL,
  `pstn_call _id` int(11) NOT NULL,
  `pstn_sms_id` int(11) NOT NULL,
  `topic_chat_id` int(11) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crm_ticket_types`
--

DROP TABLE IF EXISTS `crm_ticket_types`;
CREATE TABLE IF NOT EXISTS `crm_ticket_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crm_ticket_types`
--

INSERT INTO `crm_ticket_types` (`id`, `code`, `name_en`, `name_ar`, `created`, `updated`) VALUES
(1, 'PERSONAL_OFFLINE_COURSES', 'Personal Offline Courses Sales', 'مبيعات الدورات التدريبية الشخصية الحضورية', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(2, 'PERSONAL_ONLINE_COURSES', 'Personal Online Courses Sales', 'مبيعات الدورات التدريبية الشخصية عبر الإنترنت', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(3, 'PERSONAL_OFFLINE_WORKSHOPS', 'Personal Offline Workshops Sales', 'مبيعات ورش العمل الشخصية الحضورية', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(4, 'PERSONAL_ONLINE_WORKSHOPS', 'Personal Online Workshops Sales', 'مبيعات ورش العمل الشخصية عبر الإنترنت', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(5, 'CORPORATION_OFFLINE_COURSES', 'Corporation Offline Courses Sales', 'مبيعات الدورات التدريبية للشركات الحضورية', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(6, 'CORPORATION_ONLINE_COURSES', 'Corporation Online Courses Sales', 'مبيعات الدورات التدريبية للشركات عبر الإنترنت', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(7, 'CORPORATION_OFFLINE_WORKSHOPS', 'Corporation Offline Workshops Sales', 'مبيعات ورش العمل للشركات الحضورية', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(8, 'CORPORATION_ONLINE_WORKSHOPS', 'Corporation Online Workshops Sales', 'مبيعات ورش العمل للشركات عبر الإنترنت', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(9, 'RECOMMENDATION_PERSONAL_OFFLINE_COURSES', 'Recommendation Personal Offline Courses Sales', 'مبيعات الدورات التدريبية الشخصية الحضورية (توصية)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(10, 'RECOMMENDATION_PERSONAL_ONLINE_COURSES', 'Recommendation Personal Online Courses Sales', 'مبيعات الدورات التدريبية الشخصية عبر الإنترنت (توصية)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(11, 'RECOMMENDATION_PERSONAL_OFFLINE_WORKSHOPS', 'Recommendation Personal Offline Workshops Sales', 'مبيعات ورش العمل الشخصية الحضورية (توصية)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(12, 'RECOMMENDATION_PERSONAL_ONLINE_WORKSHOPS', 'Recommendation Personal Online Workshops Sales', 'مبيعات ورش العمل الشخصية عبر الإنترنت (توصية)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(13, 'RECOMMENDATION_CORPORATION_OFFLINE_COURSES', 'Recommendation Corporation Offline Courses Sales', 'مبيعات الدورات التدريبية للشركات الحضورية (توصية)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(14, 'RECOMMENDATION_CORPORATION_ONLINE_COURSES', 'Recommendation Corporation Online Courses Sales', 'مبيعات الدورات التدريبية للشركات عبر الإنترنت (توصية)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(15, 'RECOMMENDATION_CORPORATION_OFFLINE_WORKSHOPS', 'Recommendation Corporation Offline Workshops Sales', 'مبيعات ورش العمل للشركات الحضورية (توصية)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(16, 'RECOMMENDATION_CORPORATION_ONLINE_WORKSHOPS', 'Recommendation Corporation Online Workshops Sales', 'مبيعات ورش العمل للشركات عبر الإنترنت (توصية)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(17, 'TRAINING_ADVISOR_PERSONAL_OFFLINE_COURSES', 'Training Advisor Personal Offline Courses Sales', 'مبيعات الدورات التدريبية الشخصية الحضورية (مستشار تدريب)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(18, 'TRAINING_ADVISOR_PERSONAL_ONLINE_COURSES', 'Training Advisor Personal Online Courses Sales', 'مبيعات الدورات التدريبية الشخصية عبر الإنترنت (مستشار تدريب)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(19, 'TRAINING_ADVISOR_PERSONAL_OFFLINE_WORKSHOPS', 'Training Advisor Personal Offline Workshops Sales', 'مبيعات ورش العمل الشخصية الحضورية (مستشار تدريب)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(20, 'TRAINING_ADVISOR_PERSONAL_ONLINE_WORKSHOPS', 'Training Advisor Personal Online Workshops Sales', 'مبيعات ورش العمل الشخصية عبر الإنترنت (مستشار تدريب)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(21, 'TRAINING_ADVISOR_CORPORATION_OFFLINE_COURSES', 'Training Advisor Corporation Offline Courses Sales', 'مبيعات الدورات التدريبية للشركات الحضورية (مستشار تدريب)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(22, 'TRAINING_ADVISOR_CORPORATION_ONLINE_COURSES', 'Training Advisor Corporation Online Courses Sales', 'مبيعات الدورات التدريبية للشركات عبر الإنترنت (مستشار تدريب)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(23, 'TRAINING_ADVISOR_CORPORATION_OFFLINE_WORKSHOPS', 'Training Advisor Corporation Offline Workshops Sales', 'مبيعات ورش العمل للشركات الحضورية (مستشار تدريب)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(24, 'TRAINING_ADVISOR_CORPORATION_ONLINE_WORKSHOPS', 'Training Advisor Corporation Online Workshops Sales', 'مبيعات ورش العمل للشركات عبر الإنترنت (مستشار تدريب)', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(25, 'TECHNICAL_SUPPORT', 'Technical Support', 'الدعم الفني', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(26, 'COMPLAIN', 'Complain', 'شكوى', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(27, 'OUT_OF_PLAN_COURSES', 'Out of Plan Courses Requests', 'طلبات دورات خارج الخطة', '2026-01-19 09:44:08', '2026-01-19 09:44:08'),
(28, 'NEW_COURSES_WORKSHOPS_REQUESTS', 'New Courses and Workshops Requests', 'طلبات دورات وورش عمل جديدة', '2026-01-19 09:44:08', '2026-01-19 09:44:08');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `crm_logs`
--
ALTER TABLE `crm_logs`
  ADD CONSTRAINT `admin_id_ikl` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `prospective_customer_id` FOREIGN KEY (`prospective_customer_id`) REFERENCES `prospective_customers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_yui` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
