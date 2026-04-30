-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 12, 2026 at 11:08 AM
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
-- Table structure for table `accounting`
--

DROP TABLE IF EXISTS `accounting`;
CREATE TABLE IF NOT EXISTS `accounting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `details_id` int(11) DEFAULT NULL,
  `amount` float NOT NULL,
  `currency` varchar(1) NOT NULL DEFAULT 's',
  `payment_id` varchar(255) DEFAULT NULL,
  `payment_confirmed` tinyint(1) NOT NULL DEFAULT '1',
  `receipt` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `canceled` tinyint(1) DEFAULT '0',
  `cancel_time` timestamp NULL DEFAULT NULL,
  `account_warehouse_id` int(11) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `details` (`details`),
  KEY `payment_id` (`payment_id`),
  KEY `account_warehouse_id` (`account_warehouse_id`),
  KEY `type_id` (`type_id`),
  KEY `details_id` (`details_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `accounting_accounts`
--

DROP TABLE IF EXISTS `accounting_accounts`;
CREATE TABLE IF NOT EXISTS `accounting_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `accounting_types`
--

DROP TABLE IF EXISTS `accounting_types`;
CREATE TABLE IF NOT EXISTS `accounting_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accounting_account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sain` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `acounts_warehouses`
--

DROP TABLE IF EXISTS `acounts_warehouses`;
CREATE TABLE IF NOT EXISTS `acounts_warehouses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `descr` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
CREATE TABLE IF NOT EXISTS `ads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ads_type_id` int(11) DEFAULT NULL,
  `ads_record_id` int(11) DEFAULT NULL COMMENT 'the add type table id (ex: running_course_id)',
  `title` varchar(255) NOT NULL,
  `body` text,
  `sms` varchar(255) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ads_type_id_ati` (`ads_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ads_types`
--

DROP TABLE IF EXISTS `ads_types`;
CREATE TABLE IF NOT EXISTS `ads_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ads_views`
--

DROP TABLE IF EXISTS `ads_views`;
CREATE TABLE IF NOT EXISTS `ads_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seen` timestamp NULL DEFAULT NULL,
  `sms_sent` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `atc_config`
--

DROP TABLE IF EXISTS `atc_config`;
CREATE TABLE IF NOT EXISTS `atc_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `comment` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `auth_identity`
--

DROP TABLE IF EXISTS `auth_identity`;
CREATE TABLE IF NOT EXISTS `auth_identity` (
  `userId` varchar(36) DEFAULT NULL,
  `providerId` varchar(64) NOT NULL,
  `providerType` varchar(32) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`providerId`,`providerType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_provider_sync_history`
--

DROP TABLE IF EXISTS `auth_provider_sync_history`;
CREATE TABLE IF NOT EXISTS `auth_provider_sync_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `providerType` varchar(32) NOT NULL,
  `runMode` text NOT NULL,
  `status` text NOT NULL,
  `startedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `scanned` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `disabled` int(11) NOT NULL,
  `error` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
CREATE TABLE IF NOT EXISTS `blogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `head_img` text NOT NULL,
  `blog_department_id` int(11) DEFAULT NULL,
  `body` text NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `blog_department_id` (`blog_department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blogs_comments`
--

DROP TABLE IF EXISTS `blogs_comments`;
CREATE TABLE IF NOT EXISTS `blogs_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `blog_id` (`blog_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blogs_comments_replies`
--

DROP TABLE IF EXISTS `blogs_comments_replies`;
CREATE TABLE IF NOT EXISTS `blogs_comments_replies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `blog_comment_id` (`blog_comment_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blogs_subscribers`
--

DROP TABLE IF EXISTS `blogs_subscribers`;
CREATE TABLE IF NOT EXISTS `blogs_subscribers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blogs_views`
--

DROP TABLE IF EXISTS `blogs_views`;
CREATE TABLE IF NOT EXISTS `blogs_views` (
  `blog_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `blog_id` (`blog_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blog_departments`
--

DROP TABLE IF EXISTS `blog_departments`;
CREATE TABLE IF NOT EXISTS `blog_departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blog_images`
--

DROP TABLE IF EXISTS `blog_images`;
CREATE TABLE IF NOT EXISTS `blog_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blog_post_images`
--

DROP TABLE IF EXISTS `blog_post_images`;
CREATE TABLE IF NOT EXISTS `blog_post_images` (
  `blog_id` int(11) NOT NULL,
  `blog_image_id` int(11) NOT NULL,
  KEY `blog_id` (`blog_id`),
  KEY `blog_image_id` (`blog_image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blog_writers`
--

DROP TABLE IF EXISTS `blog_writers`;
CREATE TABLE IF NOT EXISTS `blog_writers` (
  `user_id` int(11) NOT NULL,
  `deprt_id` int(11) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `deprt_id` (`deprt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
CREATE TABLE IF NOT EXISTS `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `descr` text NOT NULL,
  `img` varchar(200) NOT NULL,
  `page_count` int(11) NOT NULL,
  `author` varchar(50) NOT NULL,
  `publish_date` date DEFAULT NULL,
  `file` varchar(200) NOT NULL,
  `free` tinyint(1) NOT NULL,
  `price` float NOT NULL,
  `book_department_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `book_department_id` (`book_department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `book_departments`
--

DROP TABLE IF EXISTS `book_departments`;
CREATE TABLE IF NOT EXISTS `book_departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `book_downloads`
--

DROP TABLE IF EXISTS `book_downloads`;
CREATE TABLE IF NOT EXISTS `book_downloads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `book_id` (`book_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `book_views`
--

DROP TABLE IF EXISTS `book_views`;
CREATE TABLE IF NOT EXISTS `book_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `book_id` (`book_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
CREATE TABLE IF NOT EXISTS `certificates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `certificate_type_id` int(11) DEFAULT NULL,
  `record_id` int(11) NOT NULL,
  `request_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `taken_time` timestamp NULL DEFAULT NULL,
  `is_free` tinyint(1) DEFAULT NULL,
  `payment_confirmed` tinyint(1) DEFAULT NULL,
  `certificate_print_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `certificate_print_id` (`certificate_print_id`),
  KEY `certificate_type_id` (`certificate_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `certificate_prints`
--

DROP TABLE IF EXISTS `certificate_prints`;
CREATE TABLE IF NOT EXISTS `certificate_prints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `download_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `print_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `certificate_types`
--

DROP TABLE IF EXISTS `certificate_types`;
CREATE TABLE IF NOT EXISTS `certificate_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ckeditor_images_tracking`
--

DROP TABLE IF EXISTS `ckeditor_images_tracking`;
CREATE TABLE IF NOT EXISTS `ckeditor_images_tracking` (
  `id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `image_table` varchar(255) NOT NULL,
  `image_column` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `contact_us`
--

DROP TABLE IF EXISTS `contact_us`;
CREATE TABLE IF NOT EXISTS `contact_us` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `descr` text NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `answer_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `sub_certs` text,
  `descr` text,
  `descr_ar` text,
  `img` varchar(25) DEFAULT NULL,
  `pre_req` text,
  `pre_req_ar` text,
  `total_parts` int(11) NOT NULL,
  `completed_parts` int(11) NOT NULL DEFAULT '0',
  `hash` varchar(255) NOT NULL,
  `level` int(2) DEFAULT NULL,
  `outcome` text,
  `outcome_ar` text,
  `line_descr` varchar(512) DEFAULT NULL,
  `line_descr_ar` varchar(512) DEFAULT NULL,
  `short_descr` text,
  `short_descr_ar` text,
  `outline` text,
  `logo` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `track_id` (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_attendance`
--

DROP TABLE IF EXISTS `courses_attendance`;
CREATE TABLE IF NOT EXISTS `courses_attendance` (
  `attendance_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_reg_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `running_course_id` int(11) NOT NULL,
  `selected_group` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  KEY `course_reg_id` (`course_reg_id`),
  KEY `running_course_id` (`running_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `courses_attendance`
--
DROP TRIGGER IF EXISTS `selected_group_adder`;
DELIMITER $$
CREATE TRIGGER `selected_group_adder` BEFORE INSERT ON `courses_attendance` FOR EACH ROW BEGIN

declare selected_group_var varchar(10);

SELECT selected_group into selected_group_var from courses_reg where id=NEW.course_reg_id;

set NEW.selected_group=selected_group_var;

end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `courses_chats`
--

DROP TABLE IF EXISTS `courses_chats`;
CREATE TABLE IF NOT EXISTS `courses_chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_lecture_id` int(11) NOT NULL,
  `course_reg_id` int(11) DEFAULT NULL,
  `body` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `course_lecture_id` (`course_lecture_id`),
  KEY `course_reg_id` (`course_reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_exams`
--

DROP TABLE IF EXISTS `courses_exams`;
CREATE TABLE IF NOT EXISTS `courses_exams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_course_id` int(11) NOT NULL,
  `title` varchar(254) COLLATE utf8mb4_bin NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `finish_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `shown` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `running_course_id` (`running_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `courses_exams_answers`
--

DROP TABLE IF EXISTS `courses_exams_answers`;
CREATE TABLE IF NOT EXISTS `courses_exams_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courses_exams_questions_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `answer` text NOT NULL,
  `degree` float DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `courses_exams_questions_id` (`courses_exams_questions_id`),
  KEY `course_reg_id` (`course_reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_exams_check`
--

DROP TABLE IF EXISTS `courses_exams_check`;
CREATE TABLE IF NOT EXISTS `courses_exams_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_exam_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `degree` float DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `courses_exams_id_for_check` (`course_exam_id`),
  KEY `course_reg_id` (`course_reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `courses_exams_check`
--
DROP TRIGGER IF EXISTS `check_student_exam`;
DELIMITER $$
CREATE TRIGGER `check_student_exam` AFTER INSERT ON `courses_exams_check` FOR EACH ROW BEGIN
    DECLARE finished,answer_id,loop_index,loop_count,correct_count INTEGER DEFAULT 0;
    DECLARE q_type varchar(255);
    DECLARE tot_degree,student_degree float DEFAULT 0;
    DECLARE student_answer text;
    DECLARE correct_answer text;

    DECLARE exam_cursor CURSOR FOR SELECT a.id,a.answer student_answer,q.answer correct_answer,type,q.degree
	FROM courses_exams_questions q
	LEFT JOIN courses_exams_answers a on q.id = a.courses_exams_questions_id and  a.course_reg_id=NEW.course_reg_id
	WHERE courses_exams_id= NEW.course_exam_id and (type='trueFalse' or type='circle' or type='output' or type='table');
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    set finished=0;
    open exam_cursor;
    checkAllAnswers:LOOP
		FETCH exam_cursor INTO answer_id,student_answer,correct_answer,q_type,tot_degree;
		
        IF finished = 1 THEN 
			LEAVE checkAllAnswers;
		END IF;
		
        IF q_type='trueFalse' or q_type='circle' or q_type='output' THEN
		update courses_exams_answers set degree=if(student_answer=correct_answer,tot_degree,0) where id=answer_id;
    ELSEIF q_type='table' THEN
       set loop_index=0;
       set correct_count=0;
       set loop_count=json_length(correct_answer);
       WHILE loop_index<loop_count DO
          if json_extract(student_answer,concat('$[',loop_index,']'))=json_extract(correct_answer,concat('$[',loop_index,']')) then
          set correct_count=correct_count+1;
          end if;
          set loop_index=loop_index+1;
       END WHILE;
       update courses_exams_answers set degree=(correct_count/loop_count)*tot_degree where id=answer_id;
    END IF;
        
	END LOOP checkAllAnswers;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `courses_exams_questions`
--

DROP TABLE IF EXISTS `courses_exams_questions`;
CREATE TABLE IF NOT EXISTS `courses_exams_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courses_exams_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `question` text NOT NULL,
  `answer` varchar(255) NOT NULL,
  `degree` float NOT NULL,
  `cancelled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `courses_exams_id` (`courses_exams_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_fourm_questions`
--

DROP TABLE IF EXISTS `courses_fourm_questions`;
CREATE TABLE IF NOT EXISTS `courses_fourm_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(255) NOT NULL,
  `images` text NOT NULL,
  `answer` text NOT NULL,
  `answer_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `answer_images` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `running_course_id` (`running_course_id`),
  KEY `student_id` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_lectures`
--

DROP TABLE IF EXISTS `courses_lectures`;
CREATE TABLE IF NOT EXISTS `courses_lectures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_course_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text,
  `is_offline` tinyint(1) NOT NULL DEFAULT '0',
  `trainer_socket_id` varchar(255) DEFAULT NULL,
  `tot_hours` int(11) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `finish_time` int(11) DEFAULT NULL,
  `concated` tinyint(1) NOT NULL DEFAULT '0',
  `process_level` int(11) NOT NULL DEFAULT '0',
  `processed` tinyint(1) DEFAULT '0',
  `concated_time` timestamp NULL DEFAULT NULL,
  `processed_time` timestamp NULL DEFAULT NULL,
  `streaming_statistics` text,
  `recording_parts` int(11) DEFAULT NULL,
  `recordings_array` text,
  `intercpting_lives` int(11) DEFAULT NULL,
  `trainer_notified` tinyint(1) NOT NULL DEFAULT '0',
  `token` varchar(512) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `running_course_id` (`running_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_materials`
--

DROP TABLE IF EXISTS `courses_materials`;
CREATE TABLE IF NOT EXISTS `courses_materials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_course_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `isFile` tinyint(1) NOT NULL DEFAULT '1',
  `size` varchar(25) DEFAULT NULL,
  `material_order` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `running_course_id` (`running_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_old_projects`
--

DROP TABLE IF EXISTS `courses_old_projects`;
CREATE TABLE IF NOT EXISTS `courses_old_projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `degree` float DEFAULT NULL,
  `cancelled` tinyint(4) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `finish_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `courses_points`
--

DROP TABLE IF EXISTS `courses_points`;
CREATE TABLE IF NOT EXISTS `courses_points` (
  `id` int(11) NOT NULL,
  `running_course_id` int(11) NOT NULL,
  `greaterThan` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  KEY `running_course_id` (`running_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_projects`
--

DROP TABLE IF EXISTS `courses_projects`;
CREATE TABLE IF NOT EXISTS `courses_projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_course_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `body` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `images` longtext COLLATE utf8mb4_bin NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `finish_time` timestamp NULL DEFAULT NULL,
  `degree` float NOT NULL,
  `cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `running_course_id` (`running_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `courses_projects_uploads`
--

DROP TABLE IF EXISTS `courses_projects_uploads`;
CREATE TABLE IF NOT EXISTS `courses_projects_uploads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courses_projects_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `file` varchar(255) NOT NULL,
  `size` varchar(255) NOT NULL,
  `degree` float DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `courses_projects_id` (`courses_projects_id`),
  KEY `course_reg_id` (`course_reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_reg`
--

DROP TABLE IF EXISTS `courses_reg`;
CREATE TABLE IF NOT EXISTS `courses_reg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `running_course_id` int(11) DEFAULT NULL,
  `reveiew` varchar(255) DEFAULT NULL,
  `stars` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `reg_type` varchar(255) DEFAULT NULL,
  `selected_group` varchar(15) DEFAULT NULL,
  `payment_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `delay_status` varchar(1) DEFAULT 'n',
  `transfered_answer` varchar(255) DEFAULT NULL,
  `transfered_course_reg_id` varchar(255) DEFAULT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_time` timestamp NULL DEFAULT NULL,
  `degree` varchar(25) DEFAULT NULL,
  `notification_service` tinyint(1) NOT NULL DEFAULT '1',
  `cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `track_id` int(11) DEFAULT NULL,
  `last_video_id` int(11) DEFAULT NULL,
  `watch_rate` float DEFAULT NULL,
  `cert_deserve` tinyint(1) DEFAULT NULL,
  `not_desrve_reason` varchar(1) DEFAULT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `generated_ad_id` int(11) DEFAULT NULL,
  `ref_amount` float DEFAULT NULL,
  `ref_paid` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `running_course_id` (`running_course_id`),
  KEY `student_id` (`student_id`),
  KEY `ref_id` (`ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `courses_registeration`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `courses_registeration`;
CREATE TABLE IF NOT EXISTS `courses_registeration` (
`courses_reg_id` int(11)
,`user_id` int(11)
,`student` varchar(255)
,`img` text
,`tel` varchar(25)
,`course` varchar(255)
,`alias` varchar(255)
,`course_type` int(11)
,`cert_deserve` tinyint(1)
,`not_desrve_reason` varchar(1)
,`watched_videos` int(11)
,`tot_videos` int(11)
,`attended_days` int(11)
,`tot_days` int(11)
,`running_course_id` int(11)
,`course_id` int(11)
,`paid` double
,`reveiew` varchar(255)
,`stars` int(11)
,`points` int(11)
,`reg_type` varchar(255)
,`delay_status` varchar(1)
,`transfered_answer` varchar(255)
,`transfered_course_reg_id` varchar(255)
,`completed` tinyint(1)
,`completed_time` timestamp
,`notification_service` tinyint(1)
,`cancelled` tinyint(1)
,`cancelled_time` timestamp
,`degree` varchar(25)
,`created` timestamp
,`selected_group` varchar(15)
,`payment_confirmed` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `courses_registeration_full`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `courses_registeration_full`;
CREATE TABLE IF NOT EXISTS `courses_registeration_full` (
`courses_reg_id` int(11)
,`user_id` int(11)
,`smart_user_id` int(11)
,`student` varchar(255)
,`img` text
,`tel` varchar(25)
,`course` varchar(255)
,`alias` varchar(255)
,`course_type` int(11)
,`cert_deserve` tinyint(1)
,`not_desrve_reason` varchar(1)
,`watched_videos` bigint(11)
,`tot_videos` bigint(11)
,`attended_days` bigint(11)
,`tot_days` bigint(11)
,`running_course_id` int(11)
,`course_id` int(11)
,`paid` double
,`reveiew` varchar(255)
,`stars` int(11)
,`points` int(11)
,`reg_type` varchar(255)
,`delay_status` varchar(1)
,`transfered_answer` varchar(255)
,`transfered_course_reg_id` varchar(255)
,`completed` tinyint(1)
,`completed_time` timestamp
,`notification_service` tinyint(1)
,`cancelled` tinyint(1)
,`cancelled_time` timestamp
,`degree` varchar(25)
,`created` timestamp
,`selected_group` varchar(15)
,`payment_confirmed` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `courses_specializations`
--

DROP TABLE IF EXISTS `courses_specializations`;
CREATE TABLE IF NOT EXISTS `courses_specializations` (
  `course_id` int(11) NOT NULL,
  `specialization_id` int(11) NOT NULL,
  KEY `course_id` (`course_id`),
  KEY `specialization_id` (`specialization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_trainers`
--

DROP TABLE IF EXISTS `courses_trainers`;
CREATE TABLE IF NOT EXISTS `courses_trainers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_course_id` int(11) NOT NULL,
  `trainer_id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `teacher_deserves` float NOT NULL DEFAULT '0',
  `deserves_whithdrawl` float NOT NULL DEFAULT '0',
  `teacher_deserves_usd` float DEFAULT '0',
  `deserves_whithdrawl_usd` float NOT NULL DEFAULT '0',
  `trainer_online_percent` float DEFAULT NULL,
  `trainer_offline_percent` float DEFAULT NULL,
  `created` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `running_course_id` (`running_course_id`),
  KEY `trainer_id` (`trainer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_videos`
--

DROP TABLE IF EXISTS `courses_videos`;
CREATE TABLE IF NOT EXISTS `courses_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isBonus` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `course_lecture_videos`
--

DROP TABLE IF EXISTS `course_lecture_videos`;
CREATE TABLE IF NOT EXISTS `course_lecture_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_lecture_id` int(11) NOT NULL,
  `course_video_id` int(11) NOT NULL,
  `video_order` int(11) DEFAULT NULL,
  `video_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `course_lecture_id` (`course_lecture_id`,`course_video_id`),
  KEY `course_video_id` (`course_video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_types`
--

DROP TABLE IF EXISTS `course_types`;
CREATE TABLE IF NOT EXISTS `course_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_views`
--

DROP TABLE IF EXISTS `course_views`;
CREATE TABLE IF NOT EXISTS `course_views` (
  `user_id` int(11) DEFAULT NULL,
  `running_course_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `running_course_id` (`running_course_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `credentials_entity`
--

DROP TABLE IF EXISTS `credentials_entity`;
CREATE TABLE IF NOT EXISTS `credentials_entity` (
  `name` varchar(128) NOT NULL,
  `data` text NOT NULL,
  `type` varchar(128) NOT NULL,
  `nodesAccess` json NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_07fde106c0b471d8cc80a64fc8` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crm_service_types`
--

DROP TABLE IF EXISTS `crm_service_types`;
CREATE TABLE IF NOT EXISTS `crm_service_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `discussion`
--

DROP TABLE IF EXISTS `discussion`;
CREATE TABLE IF NOT EXISTS `discussion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `question` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `running_course_id` (`running_course_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `discussion_comments`
--

DROP TABLE IF EXISTS `discussion_comments`;
CREATE TABLE IF NOT EXISTS `discussion_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discussion_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text,
  `audio` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `discussion_id` (`discussion_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `discussion_images`
--

DROP TABLE IF EXISTS `discussion_images`;
CREATE TABLE IF NOT EXISTS `discussion_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discussion_id` int(11) DEFAULT NULL,
  `file` text,
  PRIMARY KEY (`id`),
  KEY `discussion_id` (`discussion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_destinations`
--

DROP TABLE IF EXISTS `event_destinations`;
CREATE TABLE IF NOT EXISTS `event_destinations` (
  `id` varchar(36) NOT NULL,
  `destination` text NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `execution_data`
--

DROP TABLE IF EXISTS `execution_data`;
CREATE TABLE IF NOT EXISTS `execution_data` (
  `executionId` int(11) NOT NULL,
  `workflowData` json NOT NULL,
  `data` mediumtext,
  PRIMARY KEY (`executionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `execution_entity`
--

DROP TABLE IF EXISTS `execution_entity`;
CREATE TABLE IF NOT EXISTS `execution_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `finished` tinyint(4) NOT NULL,
  `mode` varchar(255) NOT NULL,
  `retryOf` varchar(255) DEFAULT NULL,
  `retrySuccessId` varchar(255) DEFAULT NULL,
  `startedAt` datetime NOT NULL,
  `stoppedAt` datetime DEFAULT NULL,
  `waitTill` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `workflowId` varchar(36) NOT NULL,
  `deletedAt` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_b94b45ce2c73ce46c54f20b5f9` (`waitTill`,`id`),
  KEY `IDX_8b6f3f9ae234f137d707b98f3bf43584` (`status`),
  KEY `idx_execution_entity_workflow_id_id` (`workflowId`,`id`),
  KEY `IDX_execution_entity_deletedAt` (`deletedAt`),
  KEY `IDX_execution_entity_stoppedAt` (`stoppedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `execution_metadata`
--

DROP TABLE IF EXISTS `execution_metadata`;
CREATE TABLE IF NOT EXISTS `execution_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `executionId` int(11) NOT NULL,
  `key` text NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6d44376da6c1058b5e81ed8a154e1fee106046eb` (`executionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `e_library`
--

DROP TABLE IF EXISTS `e_library`;
CREATE TABLE IF NOT EXISTS `e_library` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `file` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `facebook_conversations`
--

DROP TABLE IF EXISTS `facebook_conversations`;
CREATE TABLE IF NOT EXISTS `facebook_conversations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_user_id` varchar(255) NOT NULL,
  `facebook_conversation_id` varchar(255) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `message_count` int(11) DEFAULT '0',
  `unread_count` int(11) NOT NULL,
  `last_message_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `facebook_conversation_id` (`facebook_conversation_id`),
  KEY `lead_id` (`lead_id`),
  KEY `facebook_user_id` (`facebook_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `facebook_messages`
--

DROP TABLE IF EXISTS `facebook_messages`;
CREATE TABLE IF NOT EXISTS `facebook_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_message_id` varchar(255) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `sender` enum('user','page','agent') NOT NULL,
  `message_text` text,
  `reply_to_message_id` varchar(255) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_facebook_message` (`facebook_message_id`),
  KEY `idx_conversation` (`conversation_id`),
  KEY `idx_created_time` (`created_time`),
  KEY `reply_to_message_id` (`reply_to_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `facebook_message_attachments`
--

DROP TABLE IF EXISTS `facebook_message_attachments`;
CREATE TABLE IF NOT EXISTS `facebook_message_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_message_id` int(11) NOT NULL,
  `attachment_type` enum('image','video','audio','file') NOT NULL,
  `attachment_url` text,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `facebook_message_id` (`facebook_message_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `facebook_posts`
--

DROP TABLE IF EXISTS `facebook_posts`;
CREATE TABLE IF NOT EXISTS `facebook_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_id` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `post_time` timestamp NULL DEFAULT NULL,
  `content` text,
  `media_url` text,
  `permalink_url` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `facebook_id` (`facebook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `facebook_post_comments`
--

DROP TABLE IF EXISTS `facebook_post_comments`;
CREATE TABLE IF NOT EXISTS `facebook_post_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_comment_id` varchar(255) NOT NULL,
  `facebook_post_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `parent_comment_id` varchar(255) DEFAULT NULL,
  `message` text,
  `created_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `facebook_comment_id` (`facebook_comment_id`),
  KEY `facebook_post_id` (`facebook_post_id`),
  KEY `lead_id` (`lead_id`),
  KEY `parent_comment_id` (`parent_comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `facebook_post_courses`
--

DROP TABLE IF EXISTS `facebook_post_courses`;
CREATE TABLE IF NOT EXISTS `facebook_post_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_post_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `facebook_post_id` (`facebook_post_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `facebook_post_reactions`
--

DROP TABLE IF EXISTS `facebook_post_reactions`;
CREATE TABLE IF NOT EXISTS `facebook_post_reactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_post_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `reaction_type` enum('LIKE','LOVE','WOW','HAHA','SAD','ANGRY') DEFAULT NULL,
  `reacted_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `facebook_post_id` (`facebook_post_id`),
  KEY `lead_id` (`lead_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `facebook_post_workshops`
--

DROP TABLE IF EXISTS `facebook_post_workshops`;
CREATE TABLE IF NOT EXISTS `facebook_post_workshops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_post_id` int(11) NOT NULL,
  `workshop_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `facebook_post_id` (`facebook_post_id`),
  KEY `workshop_id` (`workshop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fav_courses`
--

DROP TABLE IF EXISTS `fav_courses`;
CREATE TABLE IF NOT EXISTS `fav_courses` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  KEY `course_id` (`course_id`),
  KEY `student_id` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `generated_ads`
--

DROP TABLE IF EXISTS `generated_ads`;
CREATE TABLE IF NOT EXISTS `generated_ads` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `running_course_id` int(11) NOT NULL DEFAULT '0',
  `note` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `given_points`
--

DROP TABLE IF EXISTS `given_points`;
CREATE TABLE IF NOT EXISTS `given_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `type` text NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_reg_id` (`course_reg_id`),
  KEY `student_id` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `instagram_conversations`
--

DROP TABLE IF EXISTS `instagram_conversations`;
CREATE TABLE IF NOT EXISTS `instagram_conversations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instagram_user_id` varchar(255) NOT NULL,
  `instagram_conversation_id` varchar(255) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `message_count` int(11) DEFAULT '0',
  `unread_count` int(11) NOT NULL,
  `last_message_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `instagram_messages`
--

DROP TABLE IF EXISTS `instagram_messages`;
CREATE TABLE IF NOT EXISTS `instagram_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instagram_message_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversation_id` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` enum('user','page','agent') COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_text` text COLLATE utf8mb4_unicode_ci,
  `reply_to_message_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_mid` (`instagram_message_id`),
  KEY `idx_reply` (`reply_to_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `instagram_post_comments`
--

DROP TABLE IF EXISTS `instagram_post_comments`;
CREATE TABLE IF NOT EXISTS `instagram_post_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instagram_comment_id` varchar(255) NOT NULL,
  `instagram_post_id` varchar(255) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `parent_comment_id` varchar(255) DEFAULT NULL,
  `message` text,
  `created_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `installed_nodes`
--

DROP TABLE IF EXISTS `installed_nodes`;
CREATE TABLE IF NOT EXISTS `installed_nodes` (
  `name` char(200) NOT NULL,
  `type` char(200) NOT NULL,
  `latestVersion` int(11) NOT NULL DEFAULT '1',
  `package` char(214) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `FK_73f857fc5dce682cef8a99c11dbddbc969618951` (`package`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `installed_packages`
--

DROP TABLE IF EXISTS `installed_packages`;
CREATE TABLE IF NOT EXISTS `installed_packages` (
  `packageName` char(214) NOT NULL,
  `installedVersion` char(50) NOT NULL,
  `authorName` char(70) DEFAULT NULL,
  `authorEmail` char(70) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`packageName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `live_lectures_cues`
--

DROP TABLE IF EXISTS `live_lectures_cues`;
CREATE TABLE IF NOT EXISTS `live_lectures_cues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lecture_id` int(11) NOT NULL,
  `cue_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lecture_id` (`lecture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `live_lecture_cues_watch`
--

DROP TABLE IF EXISTS `live_lecture_cues_watch`;
CREATE TABLE IF NOT EXISTS `live_lecture_cues_watch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `live_lecture_cue_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `course_reg_id` (`course_reg_id`),
  KEY `live_lecture_cue_id` (`live_lecture_cue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `live_participation_types`
--

DROP TABLE IF EXISTS `live_participation_types`;
CREATE TABLE IF NOT EXISTS `live_participation_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `descr` varchar(255) NOT NULL,
  `descr_ar` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `message_templates`
--

DROP TABLE IF EXISTS `message_templates`;
CREATE TABLE IF NOT EXISTS `message_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dest_type` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `running_course_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `body` text CHARACTER SET utf8mb4,
  `gateway` int(11) NOT NULL,
  `sign` text,
  `sms_sent` int(11) DEFAULT NULL,
  `seen` int(11) NOT NULL DEFAULT '0',
  `source` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `running_course_id` (`running_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `page_first_visit`
--

DROP TABLE IF EXISTS `page_first_visit`;
CREATE TABLE IF NOT EXISTS `page_first_visit` (
  `page` int(11) NOT NULL COMMENT '1="current_course",2="student_course_dashboard",3="student_account",4="registeration_modal"',
  `user_id` int(11) NOT NULL,
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `periodic_tasks`
--

DROP TABLE IF EXISTS `periodic_tasks`;
CREATE TABLE IF NOT EXISTS `periodic_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `descr` text NOT NULL,
  `period_type` varchar(255) NOT NULL COMMENT '{daily,weekly,bimonthly,monthly,biannualy,annualy',
  `start_date` datetime NOT NULL,
  `priority` int(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `placement_test_answers`
--

DROP TABLE IF EXISTS `placement_test_answers`;
CREATE TABLE IF NOT EXISTS `placement_test_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `placement_test_process_id` int(11) DEFAULT NULL,
  `placement_test_question_id` int(11) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `degree` decimal(3,2) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `placement_test_process_id` (`placement_test_process_id`),
  KEY `placement_test_question_id` (`placement_test_question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `placement_test_levels`
--

DROP TABLE IF EXISTS `placement_test_levels`;
CREATE TABLE IF NOT EXISTS `placement_test_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `score` decimal(6,2) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`),
  KEY `placement_test_levels_ibfk_3` (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `placement_test_processes`
--

DROP TABLE IF EXISTS `placement_test_processes`;
CREATE TABLE IF NOT EXISTS `placement_test_processes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `degree` decimal(6,2) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `track_id` (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `placement_test_questions`
--

DROP TABLE IF EXISTS `placement_test_questions`;
CREATE TABLE IF NOT EXISTS `placement_test_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `question` json DEFAULT NULL,
  `answer` varchar(266) DEFAULT NULL,
  `degree` decimal(3,2) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `track_id` (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `prospective_customers`
--

DROP TABLE IF EXISTS `prospective_customers`;
CREATE TABLE IF NOT EXISTS `prospective_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `tel` varchar(25) NOT NULL,
  `specialization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `tel` (`tel`),
  KEY `specialization_id` (`specialization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `related_courses`
--

DROP TABLE IF EXISTS `related_courses`;
CREATE TABLE IF NOT EXISTS `related_courses` (
  `course_id` int(11) NOT NULL,
  `related_course_id` int(11) NOT NULL,
  KEY `course_id` (`course_id`),
  KEY `related_course_id` (`related_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `related_workshops`
--

DROP TABLE IF EXISTS `related_workshops`;
CREATE TABLE IF NOT EXISTS `related_workshops` (
  `workshop_id` int(11) NOT NULL,
  `related_workshop_id` int(11) NOT NULL,
  KEY `workshop_id_ipj` (`related_workshop_id`),
  KEY `workshop_id_ipm` (`workshop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `remote_locations`
--

DROP TABLE IF EXISTS `remote_locations`;
CREATE TABLE IF NOT EXISTS `remote_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `addr` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `supervicer_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `remote_location_rooms`
--

DROP TABLE IF EXISTS `remote_location_rooms`;
CREATE TABLE IF NOT EXISTS `remote_location_rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remote_location_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `remote_location_id` (`remote_location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `remote_location_room_devices`
--

DROP TABLE IF EXISTS `remote_location_room_devices`;
CREATE TABLE IF NOT EXISTS `remote_location_room_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remote_location_room_id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `remote_location_room_id` (`remote_location_room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `scope` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_5b49d0f504f7ef31045a1fb2eb8` (`scope`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `seats` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `running_courses`
--

DROP TABLE IF EXISTS `running_courses`;
CREATE TABLE IF NOT EXISTS `running_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trainer_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `shown` tinyint(1) DEFAULT '0',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finish_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `isSaturday` tinyint(1) DEFAULT NULL,
  `isFriday` tinyint(1) DEFAULT NULL,
  `tot_hours` int(11) DEFAULT NULL,
  `lecture_hours` int(11) DEFAULT NULL,
  `price_sdg` float NOT NULL,
  `price_usd` float DEFAULT NULL,
  `cert_price` int(11) DEFAULT NULL,
  `reg_deadline` timestamp NULL DEFAULT NULL,
  `discount` int(11) DEFAULT '0',
  `groups` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `tot_seats` int(11) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `course_type` int(11) DEFAULT NULL,
  `live_participation_type_id` int(11) DEFAULT NULL,
  `room` int(11) DEFAULT NULL,
  `cancelled` tinyint(1) DEFAULT '0',
  `cancelled_time` timestamp NULL DEFAULT NULL,
  `calcualted` tinyint(1) NOT NULL DEFAULT '0',
  `calculated_time` timestamp NULL DEFAULT NULL,
  `teacher_deserves` float DEFAULT '0',
  `deserves_whithdrawl` float DEFAULT '0',
  `teacher_deserves_usd` float DEFAULT '0',
  `deserves_whithdrawl_usd` float DEFAULT '0',
  `trainer_online_percent` float DEFAULT NULL,
  `trainer_offline_percent` float DEFAULT NULL,
  `points` int(11) NOT NULL,
  `min_success` int(11) DEFAULT '50',
  `lecture_count` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `room_id` int(11) DEFAULT NULL,
  `descr` text,
  `pre_req` varchar(52) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trainer_id` (`trainer_id`),
  KEY `course_id` (`course_id`),
  KEY `live_participation_type_id` (`live_participation_type_id`),
  KEY `room_id` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `running_course_remote_locations`
--

DROP TABLE IF EXISTS `running_course_remote_locations`;
CREATE TABLE IF NOT EXISTS `running_course_remote_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_course_id` int(11) DEFAULT NULL,
  `remote_location_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `running_course_id` (`running_course_id`),
  KEY `remote_location_id` (`remote_location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `running_workshops`
--

DROP TABLE IF EXISTS `running_workshops`;
CREATE TABLE IF NOT EXISTS `running_workshops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workshop_id` int(11) DEFAULT NULL,
  `live_participation_type_id` int(11) DEFAULT NULL,
  `trainer_id` int(11) DEFAULT NULL,
  `trainer_socket_id` varchar(255) DEFAULT NULL,
  `workshop_type` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `price_usd` int(11) DEFAULT NULL,
  `cert_price` int(11) DEFAULT NULL,
  `cert_price_usd` int(11) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `finish_time` timestamp NULL DEFAULT NULL,
  `recording_parts` int(11) DEFAULT NULL,
  `recordings_array` text,
  `concated` tinyint(1) NOT NULL DEFAULT '0',
  `concated_time` timestamp NULL DEFAULT NULL,
  `process_level` int(11) DEFAULT '0',
  `processed` tinyint(1) NOT NULL DEFAULT '0',
  `processed_time` timestamp NULL DEFAULT NULL,
  `streaming_statistics` text,
  `intercpting_lives` int(11) DEFAULT NULL,
  `shown` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=not shown,1 = shown',
  `tot_hours` int(11) NOT NULL,
  `location` text NOT NULL,
  `canceled` tinyint(1) DEFAULT '0',
  `calculated` varchar(255) DEFAULT NULL,
  `calculated_time` timestamp NULL DEFAULT NULL,
  `teacher_deserves` float DEFAULT NULL,
  `teacher_withdrawl` float DEFAULT NULL,
  `deserves_whithdrawl` float DEFAULT NULL,
  `teacher_deserves_usd` float DEFAULT NULL,
  `descr` text,
  `pre_req` text,
  `tot_seats` int(11) DEFAULT NULL,
  `alias` varchar(100) NOT NULL,
  `trainer_online_percent` int(11) DEFAULT NULL,
  `trainer_offline_percent` int(11) DEFAULT NULL,
  `trainer_notified` tinyint(1) NOT NULL DEFAULT '0',
  `token` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `trainer_id` (`trainer_id`),
  KEY `workshop_id` (`workshop_id`),
  KEY `live_participation_type_id` (`live_participation_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `running_workshop_remote_locations`
--

DROP TABLE IF EXISTS `running_workshop_remote_locations`;
CREATE TABLE IF NOT EXISTS `running_workshop_remote_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_workshop_id` int(11) NOT NULL,
  `remote_location_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `remote_location_id_poi` (`remote_location_id`),
  KEY `running_workshop_id_klop` (`running_workshop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sent_messages`
--

DROP TABLE IF EXISTS `sent_messages`;
CREATE TABLE IF NOT EXISTS `sent_messages` (
  `id` int(11) NOT NULL,
  `text` int(11) DEFAULT NULL,
  `message_template_id` int(11) DEFAULT NULL,
  `tel` varchar(32) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finish_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `client` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `socket_id` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `lat` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client` (`client`),
  KEY `location` (`country`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `loadOnStartup` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shared_credentials`
--

DROP TABLE IF EXISTS `shared_credentials`;
CREATE TABLE IF NOT EXISTS `shared_credentials` (
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `roleId` int(11) NOT NULL,
  `userId` varchar(36) NOT NULL,
  `credentialsId` varchar(36) NOT NULL,
  PRIMARY KEY (`userId`,`credentialsId`),
  KEY `FK_c68e056637562000b68f480815a` (`roleId`),
  KEY `FK_484f0327e778648dd04f1d70493` (`userId`),
  KEY `idx_shared_credentials_id` (`credentialsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shared_workflow`
--

DROP TABLE IF EXISTS `shared_workflow`;
CREATE TABLE IF NOT EXISTS `shared_workflow` (
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `roleId` int(11) NOT NULL,
  `userId` varchar(36) NOT NULL,
  `workflowId` varchar(36) NOT NULL,
  `role` text,
  PRIMARY KEY (`userId`,`workflowId`),
  KEY `FK_3540da03964527aa24ae014b780x` (`roleId`),
  KEY `FK_82b2fd9ec4e3e24209af8160282x` (`userId`),
  KEY `idx_shared_workflow_workflow_id` (`workflowId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `smart_atc`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `smart_atc`;
CREATE TABLE IF NOT EXISTS `smart_atc` (
`id` int(11)
,`smart_user_id` int(11)
,`isAmbassador` tinyint(1)
,`isAdmin` tinyint(1)
,`adminLevel` int(11)
,`name` varchar(255)
,`user` varchar(255)
,`isTrainer` tinyint(1)
,`descr` text
,`descr_ar` text
,`specialization_id` int(11)
,`cv` text
,`atc_email` varchar(255)
,`points` int(11)
,`trainer_online_percent` float
,`trainer_offline_percent` float
,`stopped` tinyint(1)
,`online` tinyint(1)
,`socket_id` varchar(255)
,`signature` mediumtext
,`aff_percent` float
,`atc_created` timestamp
,`atc_updated` timestamp
,`pass` varchar(255)
,`tel` varchar(25)
,`email` varchar(255)
,`lng` double
,`lat` double
,`img` text
,`work` varchar(255)
,`smart_created` timestamp
,`gender` varchar(1)
,`university` varchar(255)
,`card_number` varchar(255)
,`card_exp` date
,`usd_card_number` varchar(25)
,`usd_card_type` varchar(2)
,`usd_card_exp` date
,`usd_card_cvc` varchar(5)
,`sd_balance` double
,`usd_balance` double
,`blocked` tinyint(1)
,`blocked_reason` text
,`code` varchar(6)
,`code_time` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `specializations`
--

DROP TABLE IF EXISTS `specializations`;
CREATE TABLE IF NOT EXISTS `specializations` (
  `name` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `img` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sub_tasks`
--

DROP TABLE IF EXISTS `sub_tasks`;
CREATE TABLE IF NOT EXISTS `sub_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `descr` text NOT NULL,
  `start_time` datetime NOT NULL,
  `suggested_finish_time` datetime DEFAULT NULL,
  `manager_review` text,
  `finish_time` datetime DEFAULT NULL,
  `accomplished` tinyint(1) NOT NULL DEFAULT '0',
  `emp_review` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tag_entity`
--

DROP TABLE IF EXISTS `tag_entity`;
CREATE TABLE IF NOT EXISTS `tag_entity` (
  `name` varchar(24) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_8f949d7a3a984759044054e89b` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `descr` text,
  `start_time` datetime NOT NULL,
  `suggested_finish_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `accomplished` tinyint(1) NOT NULL DEFAULT '0',
  `priority` int(16) DEFAULT NULL,
  `emp_review` text,
  `perodic_task_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_user_id_pop` (`admin_user_id`),
  KEY `perodic_task_id` (`perodic_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
CREATE TABLE IF NOT EXISTS `topics` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `descr` varchar(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `type` int(255) NOT NULL DEFAULT '0' COMMENT '0 = create_account, 1 = login, 2=register_for_course, 3=payment,4=videos,5=exams,6=project,7=certificates,99=other',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = open , 1 = close',
  `report` varchar(255) DEFAULT NULL,
  `admin_id` int(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `topic_chats`
--

DROP TABLE IF EXISTS `topic_chats`;
CREATE TABLE IF NOT EXISTS `topic_chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `chat` varchar(255) NOT NULL,
  `has_images` tinyint(1) NOT NULL DEFAULT '0',
  `source` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = user , 1 = admin',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `topic_id` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `topic_chat_images`
--

DROP TABLE IF EXISTS `topic_chat_images`;
CREATE TABLE IF NOT EXISTS `topic_chat_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topiChat_id` int(11) NOT NULL,
  `path` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `topiChat_id` (`topiChat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

DROP TABLE IF EXISTS `tracks`;
CREATE TABLE IF NOT EXISTS `tracks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `name_ar` varchar(255) DEFAULT NULL,
  `descr` text,
  `descr_ar` text,
  `line_descr` text,
  `line_descr_ar` text,
  `has_placement_test` tinyint(1) NOT NULL DEFAULT '0',
  `placement_test_price_sdg` decimal(20,3) NOT NULL DEFAULT '0.000',
  `placement_test_price_usd` decimal(20,3) NOT NULL DEFAULT '0.000',
  `placement_test_duration` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'in minutes',
  `img` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` varchar(36) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `firstName` varchar(32) DEFAULT NULL,
  `lastName` varchar(32) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `personalizationAnswers` json DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `settings` json DEFAULT NULL,
  `apiKey` varchar(255) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `mfaEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `mfaSecret` text,
  `mfaRecoveryCodes` text,
  `role` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_e12875dfb3b1d92d7d7c5377e2` (`email`),
  UNIQUE KEY `UQ_ie0zomxves9w3p774drfrkxtj5` (`apiKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smart_user_id` int(11) DEFAULT NULL,
  `user_creation_source_id` int(11) NOT NULL DEFAULT '1',
  `descr` text,
  `descr_ar` text,
  `specialization_id` int(11) DEFAULT NULL,
  `cv` text,
  `atc_email` varchar(255) DEFAULT NULL,
  `points` int(11) DEFAULT '0',
  `isTrainer` tinyint(1) NOT NULL DEFAULT '0',
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  `isAmbassador` tinyint(1) DEFAULT NULL,
  `adminLevel` int(11) DEFAULT NULL,
  `trainer_online_percent` float DEFAULT NULL,
  `trainer_offline_percent` float DEFAULT NULL,
  `stopped` tinyint(1) NOT NULL DEFAULT '0',
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `socket_id` varchar(255) DEFAULT NULL,
  `signature` mediumtext,
  `aff_percent` float DEFAULT NULL,
  `mdsHelper` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `smart_user_id` (`smart_user_id`),
  KEY `specialization_id` (`specialization_id`),
  KEY `user_creation_source_id_ucs` (`user_creation_source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_creation_sources`
--

DROP TABLE IF EXISTS `user_creation_sources`;
CREATE TABLE IF NOT EXISTS `user_creation_sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(255) NOT NULL,
  `source_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `variables`
--

DROP TABLE IF EXISTS `variables`;
CREATE TABLE IF NOT EXISTS `variables` (
  `key` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'string',
  `value` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `video_cues`
--

DROP TABLE IF EXISTS `video_cues`;
CREATE TABLE IF NOT EXISTS `video_cues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video_path_id` int(11) NOT NULL,
  `cue_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `video_path_id` (`video_path_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `video_cues_watch`
--

DROP TABLE IF EXISTS `video_cues_watch`;
CREATE TABLE IF NOT EXISTS `video_cues_watch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video_cue_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `course_reg_id` (`course_reg_id`),
  KEY `video_cue_id` (`video_cue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `video_cues_watch`
--
DROP TRIGGER IF EXISTS `prevent_duplicate_combinations`;
DELIMITER $$
CREATE TRIGGER `prevent_duplicate_combinations` BEFORE INSERT ON `video_cues_watch` FOR EACH ROW BEGIN
    -- Check if a duplicate combination already exists
    IF EXISTS (
        SELECT 1
        FROM video_cues_watch
        WHERE video_cue_id = NEW.video_cue_id
          AND course_reg_id = NEW.course_reg_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insert operation blocked: Duplicate combination of video_cue_id and course_reg_id.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `video_folders`
--

DROP TABLE IF EXISTS `video_folders`;
CREATE TABLE IF NOT EXISTS `video_folders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `video_pathes`
--

DROP TABLE IF EXISTS `video_pathes`;
CREATE TABLE IF NOT EXISTS `video_pathes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_video_id` int(11) NOT NULL,
  `length` time DEFAULT NULL,
  `lang` varchar(25) DEFAULT NULL,
  `hasSubtitle` tinyint(1) NOT NULL DEFAULT '0',
  `total_parts` int(11) NOT NULL,
  `completed_parts` int(11) DEFAULT '0',
  `procceeded` tinyint(1) NOT NULL DEFAULT '0',
  `bunnyUploaded` tinyint(1) NOT NULL DEFAULT '0',
  `video_folder_id` int(11) DEFAULT NULL,
  `hash` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `course_video_id` (`course_video_id`),
  KEY `video_folder_id_vfi` (`video_folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `video_pathes`
--
DROP TRIGGER IF EXISTS `createCues`;
DELIMITER $$
CREATE TRIGGER `createCues` AFTER UPDATE ON `video_pathes` FOR EACH ROW BEGIN
    DECLARE cues_count_var,old_cues_count,index_var int DEFAULT 0;

if NEW.completed_parts = NEW.total_parts then
    SELECT value into cues_count_var from atc_config where title='cues_count';
    SELECT count(*) into old_cues_count from video_cues where video_path_id = NEW.id;
    set index_var=0;
            while index_var<cues_count_var DO
            if old_cues_count = 0 then
               INSERT INTO video_cues(video_path_id,cue_time) values(NEW.id,floor(index_var*time_to_sec(NEW.length)/cues_count_var+rand()*time_to_sec(NEW.length)/cues_count_var));
               
               else
               update video_cues set cue_time=floor(index_var*time_to_sec(NEW.length)/cues_count_var+rand()*time_to_sec(NEW.length)/cues_count_var) WHERE id=
               (SELECT * from (SELECT id from video_cues where video_path_id=NEW.id limit 1 offset index_var) as tmp);
               end if;
               
               set index_var=index_var+1;
            end while;

end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `webhook_entity`
--

DROP TABLE IF EXISTS `webhook_entity`;
CREATE TABLE IF NOT EXISTS `webhook_entity` (
  `webhookPath` varchar(255) NOT NULL,
  `method` varchar(255) NOT NULL,
  `node` varchar(255) NOT NULL,
  `webhookId` varchar(255) DEFAULT NULL,
  `pathLength` int(11) DEFAULT NULL,
  `workflowId` varchar(36) NOT NULL,
  PRIMARY KEY (`webhookPath`,`method`),
  KEY `IDX_742496f199721a057051acf4c2` (`webhookId`,`method`,`pathLength`),
  KEY `fk_webhook_entity_workflow_id` (`workflowId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_black_list`
--

DROP TABLE IF EXISTS `whatsapp_black_list`;
CREATE TABLE IF NOT EXISTS `whatsapp_black_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `tel` int(11) NOT NULL,
  `is_start` tinyint(1) NOT NULL COMMENT '1,0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_groups`
--

DROP TABLE IF EXISTS `whatsapp_groups`;
CREATE TABLE IF NOT EXISTS `whatsapp_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whatsapp_app_id` int(11) DEFAULT NULL,
  `specialization_id` int(11) DEFAULT NULL,
  `group_creation_time` int(11) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(255) DEFAULT NULL,
  `invite_group` varchar(255) DEFAULT NULL,
  `lastMessage` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_group_members`
--

DROP TABLE IF EXISTS `whatsapp_group_members`;
CREATE TABLE IF NOT EXISTS `whatsapp_group_members` (
  `whatsapp_group_id` int(11) NOT NULL,
  `whatsapp_member_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_members`
--

DROP TABLE IF EXISTS `whatsapp_members`;
CREATE TABLE IF NOT EXISTS `whatsapp_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tel` varchar(25) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_messages`
--

DROP TABLE IF EXISTS `whatsapp_messages`;
CREATE TABLE IF NOT EXISTS `whatsapp_messages` (
  `id` int(11) NOT NULL,
  `message` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actual_send_time` timestamp NULL DEFAULT NULL,
  `send_type` varchar(255) NOT NULL COMMENT 'now, scheduled',
  `propsed_send_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_message_recipients`
--

DROP TABLE IF EXISTS `whatsapp_message_recipients`;
CREATE TABLE IF NOT EXISTS `whatsapp_message_recipients` (
  `id` int(11) NOT NULL,
  `whatsapp_message_id` int(11) NOT NULL,
  `recipient_type` varchar(1) NOT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `send_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_perodic_message`
--

DROP TABLE IF EXISTS `whatsapp_perodic_message`;
CREATE TABLE IF NOT EXISTS `whatsapp_perodic_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `periodic_type` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workflows_tags`
--

DROP TABLE IF EXISTS `workflows_tags`;
CREATE TABLE IF NOT EXISTS `workflows_tags` (
  `workflowId` varchar(36) NOT NULL,
  `tagId` varchar(36) NOT NULL,
  PRIMARY KEY (`workflowId`,`tagId`),
  KEY `idx_workflows_tags_workflow_id` (`workflowId`),
  KEY `fk_workflows_tags_tag_id` (`tagId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workflow_entity`
--

DROP TABLE IF EXISTS `workflow_entity`;
CREATE TABLE IF NOT EXISTS `workflow_entity` (
  `name` varchar(128) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `nodes` json NOT NULL,
  `connections` json NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `settings` json DEFAULT NULL,
  `staticData` json DEFAULT NULL,
  `pinData` json DEFAULT NULL,
  `versionId` char(36) DEFAULT NULL,
  `triggerCount` int(11) NOT NULL DEFAULT '0',
  `id` varchar(36) NOT NULL,
  `meta` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_workflow_entity_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workflow_history`
--

DROP TABLE IF EXISTS `workflow_history`;
CREATE TABLE IF NOT EXISTS `workflow_history` (
  `versionId` varchar(36) NOT NULL,
  `workflowId` varchar(36) NOT NULL,
  `authors` varchar(255) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `nodes` json NOT NULL,
  `connections` json NOT NULL,
  PRIMARY KEY (`versionId`),
  KEY `IDX_1e31657f5fe46816c34be7c1b4` (`workflowId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workflow_statistics`
--

DROP TABLE IF EXISTS `workflow_statistics`;
CREATE TABLE IF NOT EXISTS `workflow_statistics` (
  `count` int(11) DEFAULT '0',
  `latestEvent` datetime DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `workflowId` varchar(36) NOT NULL,
  PRIMARY KEY (`workflowId`,`name`),
  KEY `idx_workflow_statistics_workflow_id` (`workflowId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workshops`
--

DROP TABLE IF EXISTS `workshops`;
CREATE TABLE IF NOT EXISTS `workshops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `img` text NOT NULL,
  `pre_req` text NOT NULL,
  `pre_req_ar` text NOT NULL,
  `descr` text NOT NULL,
  `descr_ar` text NOT NULL,
  `total_parts` int(11) DEFAULT NULL,
  `completed_parts` int(11) NOT NULL DEFAULT '0',
  `hash` varchar(255) NOT NULL,
  `level` int(2) DEFAULT NULL,
  `outcome` text,
  `outcome_ar` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL,
  `short_descr_ar` text,
  `short_descr` text,
  `line_descr_ar` text,
  `line_descr` text,
  `logo` varchar(255) DEFAULT NULL,
  `outline` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `name_ar` (`name_ar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `workshops_reg`
--

DROP TABLE IF EXISTS `workshops_reg`;
CREATE TABLE IF NOT EXISTS `workshops_reg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_workshop_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `payment_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `cert_deserve` tinyint(1) DEFAULT NULL,
  `not_desrve_reason` varchar(1) DEFAULT NULL,
  `cert_issued` tinyint(1) NOT NULL DEFAULT '0',
  `reg_type` varchar(255) DEFAULT NULL,
  `offline_attended` tinyint(1) DEFAULT NULL,
  `selected_group` varchar(255) DEFAULT NULL,
  `cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `watch_rate` float DEFAULT NULL,
  `review` varchar(255) DEFAULT NULL,
  `stars` int(11) DEFAULT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `student_id_opp` (`student_id`),
  KEY `ref_id_ipk` (`ref_id`),
  KEY `running_workshop_id_ikf` (`running_workshop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `workshops_reg_view`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `workshops_reg_view`;
CREATE TABLE IF NOT EXISTS `workshops_reg_view` (
`workshop_reg_id` int(11)
,`student_id` int(11)
,`socket_id` varchar(255)
,`name` varchar(255)
,`img` text
,`title` varchar(255)
,`title_ar` varchar(255)
,`alias` varchar(100)
,`start_time` timestamp
,`finish_time` timestamp
,`trainer` varchar(255)
,`currency` varchar(1)
,`price` bigint(11)
,`paid` float
,`payment_id` varchar(255)
,`cert_price` bigint(11)
,`workshop_type` int(11)
,`level` int(2)
,`review` varchar(255)
,`stars` int(11)
,`ref_id` int(11)
,`created` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `workshops_specializations`
--

DROP TABLE IF EXISTS `workshops_specializations`;
CREATE TABLE IF NOT EXISTS `workshops_specializations` (
  `workshop_id` int(11) NOT NULL,
  `specialization_id` int(11) NOT NULL,
  KEY `workshop_id` (`workshop_id`),
  KEY `specialization_id` (`specialization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_chats`
--

DROP TABLE IF EXISTS `workshop_chats`;
CREATE TABLE IF NOT EXISTS `workshop_chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_workshop_id` int(11) NOT NULL,
  `workshop_reg_id` int(11) DEFAULT NULL,
  `body` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `running_workshop_id` (`running_workshop_id`),
  KEY `workshop_reg_id` (`workshop_reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_cues`
--

DROP TABLE IF EXISTS `workshop_cues`;
CREATE TABLE IF NOT EXISTS `workshop_cues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `running_workshop_id` int(11) NOT NULL,
  `cue_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `running_workshop_id` (`running_workshop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_cues_watch`
--

DROP TABLE IF EXISTS `workshop_cues_watch`;
CREATE TABLE IF NOT EXISTS `workshop_cues_watch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workshop_cue_id` int(11) NOT NULL,
  `workshop_reg_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `workshop_cue_id` (`workshop_cue_id`),
  KEY `workshop_reg_id` (`workshop_reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_types`
--

DROP TABLE IF EXISTS `workshop_types`;
CREATE TABLE IF NOT EXISTS `workshop_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_views`
--

DROP TABLE IF EXISTS `workshop_views`;
CREATE TABLE IF NOT EXISTS `workshop_views` (
  `user_id` int(11) DEFAULT NULL,
  `running_workshop_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `user_id` (`user_id`),
  KEY `running_workshop_id` (`running_workshop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure for view `courses_registeration`
--
DROP TABLE IF EXISTS `courses_registeration`;

DROP VIEW IF EXISTS `courses_registeration`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `courses_registeration`  AS   (select `courses_reg`.`id` AS `courses_reg_id`,`users`.`id` AS `user_id`,`smart_systems`.`smart_users`.`name` AS `student`,`smart_systems`.`smart_users`.`img` AS `img`,`smart_systems`.`smart_users`.`tel` AS `tel`,`courses`.`name` AS `course`,`running_courses`.`alias` AS `alias`,`running_courses`.`course_type` AS `course_type`,`courses_reg`.`cert_deserve` AS `cert_deserve`,`courses_reg`.`not_desrve_reason` AS `not_desrve_reason`,`get_watched_videos`(`courses_reg`.`id`) AS `watched_videos`,`get_total_videos`(`courses_reg`.`running_course_id`) AS `tot_videos`,`get_attended_lec`(`courses_reg`.`id`) AS `attended_days`,`get_course_days`(`courses_reg`.`running_course_id`,`courses_reg`.`id`) AS `tot_days`,`courses_reg`.`running_course_id` AS `running_course_id`,`running_courses`.`course_id` AS `course_id`,(select sum(`accounting`.`amount`) from `accounting` where ((`accounting`.`type_id` = 1) and (`accounting`.`details_id` = `courses_reg`.`id`) and (`accounting`.`canceled` = 0))) AS `paid`,`courses_reg`.`reveiew` AS `reveiew`,`courses_reg`.`stars` AS `stars`,`courses_reg`.`points` AS `points`,`courses_reg`.`reg_type` AS `reg_type`,`courses_reg`.`delay_status` AS `delay_status`,`courses_reg`.`transfered_answer` AS `transfered_answer`,`courses_reg`.`transfered_course_reg_id` AS `transfered_course_reg_id`,`courses_reg`.`completed` AS `completed`,`courses_reg`.`completed_time` AS `completed_time`,`courses_reg`.`notification_service` AS `notification_service`,`courses_reg`.`cancelled` AS `cancelled`,`courses_reg`.`cancelled_time` AS `cancelled_time`,`courses_reg`.`degree` AS `degree`,`courses_reg`.`created` AS `created`,`courses_reg`.`selected_group` AS `selected_group`,`courses_reg`.`payment_confirmed` AS `payment_confirmed` from ((((`courses_reg` join `running_courses` on((`running_courses`.`id` = `courses_reg`.`running_course_id`))) join `users` on((`users`.`id` = `courses_reg`.`student_id`))) join `courses` on((`courses`.`name` = (select `courses`.`name` from `courses` where (`courses`.`id` = `running_courses`.`course_id`))))) join `smart_systems`.`smart_users` on((`smart_systems`.`smart_users`.`id` = `users`.`smart_user_id`))) order by ((`courses_reg`.`id` <> 0) and (`courses_reg`.`created` <> 0)) desc)  ;

-- --------------------------------------------------------

--
-- Structure for view `courses_registeration_full`
--
DROP TABLE IF EXISTS `courses_registeration_full`;

DROP VIEW IF EXISTS `courses_registeration_full`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `courses_registeration_full`  AS SELECT `courses_reg`.`id` AS `courses_reg_id`, `users`.`id` AS `user_id`, `users`.`smart_user_id` AS `smart_user_id`, `smart_systems`.`smart_users`.`name` AS `student`, `smart_systems`.`smart_users`.`img` AS `img`, `smart_systems`.`smart_users`.`tel` AS `tel`, `courses`.`name` AS `course`, `running_courses`.`alias` AS `alias`, `running_courses`.`course_type` AS `course_type`, `courses_reg`.`cert_deserve` AS `cert_deserve`, `courses_reg`.`not_desrve_reason` AS `not_desrve_reason`, if((`courses_reg`.`reg_type` = 2),`get_watched_videos`(`courses_reg`.`id`),NULL) AS `watched_videos`, if((`courses_reg`.`reg_type` = 2),`get_total_videos`(`courses_reg`.`running_course_id`),NULL) AS `tot_videos`, if((`courses_reg`.`reg_type` = 1),`get_attended_lec`(`courses_reg`.`id`),NULL) AS `attended_days`, if((`courses_reg`.`reg_type` = 1),`get_course_days`(`courses_reg`.`running_course_id`,`courses_reg`.`id`),NULL) AS `tot_days`, `courses_reg`.`running_course_id` AS `running_course_id`, `running_courses`.`course_id` AS `course_id`, (select sum(`accounting`.`amount`) from `accounting` where ((`accounting`.`type_id` = 1) and (`accounting`.`details_id` = `courses_reg`.`id`) and (`accounting`.`canceled` = 0))) AS `paid`, `courses_reg`.`reveiew` AS `reveiew`, `courses_reg`.`stars` AS `stars`, `courses_reg`.`points` AS `points`, `courses_reg`.`reg_type` AS `reg_type`, `courses_reg`.`delay_status` AS `delay_status`, `courses_reg`.`transfered_answer` AS `transfered_answer`, `courses_reg`.`transfered_course_reg_id` AS `transfered_course_reg_id`, `courses_reg`.`completed` AS `completed`, `courses_reg`.`completed_time` AS `completed_time`, `courses_reg`.`notification_service` AS `notification_service`, `courses_reg`.`cancelled` AS `cancelled`, `courses_reg`.`cancelled_time` AS `cancelled_time`, `courses_reg`.`degree` AS `degree`, `courses_reg`.`created` AS `created`, `courses_reg`.`selected_group` AS `selected_group`, `courses_reg`.`payment_confirmed` AS `payment_confirmed` FROM ((((`courses_reg` join `running_courses` on((`running_courses`.`id` = `courses_reg`.`running_course_id`))) join `users` on((`users`.`id` = `courses_reg`.`student_id`))) join `courses` on((`courses`.`id` = `running_courses`.`course_id`))) join `smart_systems`.`smart_users` on((`smart_systems`.`smart_users`.`id` = `users`.`smart_user_id`))) ORDER BY `courses_reg`.`id` AS `DESCdesc` ASC  ;

-- --------------------------------------------------------

--
-- Structure for view `smart_atc`
--
DROP TABLE IF EXISTS `smart_atc`;

DROP VIEW IF EXISTS `smart_atc`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_atc`  AS   (select `users`.`id` AS `id`,`users`.`smart_user_id` AS `smart_user_id`,`users`.`isAmbassador` AS `isAmbassador`,`users`.`isAdmin` AS `isAdmin`,`users`.`adminLevel` AS `adminLevel`,`sm`.`name` AS `name`,`sm`.`user` AS `user`,`users`.`isTrainer` AS `isTrainer`,`users`.`descr` AS `descr`,`users`.`descr_ar` AS `descr_ar`,`users`.`specialization_id` AS `specialization_id`,`users`.`cv` AS `cv`,`users`.`atc_email` AS `atc_email`,`users`.`points` AS `points`,`users`.`trainer_online_percent` AS `trainer_online_percent`,`users`.`trainer_offline_percent` AS `trainer_offline_percent`,`users`.`stopped` AS `stopped`,`users`.`online` AS `online`,`users`.`socket_id` AS `socket_id`,`users`.`signature` AS `signature`,`users`.`aff_percent` AS `aff_percent`,`users`.`created` AS `atc_created`,`users`.`updated` AS `atc_updated`,`sm`.`pass` AS `pass`,`sm`.`tel` AS `tel`,`sm`.`email` AS `email`,`sm`.`lng` AS `lng`,`sm`.`lat` AS `lat`,`sm`.`img` AS `img`,`sm`.`work` AS `work`,`sm`.`created` AS `smart_created`,`sm`.`gender` AS `gender`,`sm`.`university` AS `university`,`sm`.`card_number` AS `card_number`,`sm`.`card_exp` AS `card_exp`,`sm`.`usd_card_number` AS `usd_card_number`,`sm`.`usd_card_type` AS `usd_card_type`,`sm`.`usd_card_exp` AS `usd_card_exp`,`sm`.`usd_card_cvc` AS `usd_card_cvc`,`sm`.`sd_balance` AS `sd_balance`,`sm`.`usd_balance` AS `usd_balance`,`sm`.`blocked` AS `blocked`,`sm`.`blocked_reason` AS `blocked_reason`,`sm`.`code` AS `code`,`sm`.`code_time` AS `code_time` from (`users` join `smart_systems`.`smart_users` `sm` on((`users`.`smart_user_id` = `sm`.`id`))))  ;

-- --------------------------------------------------------

--
-- Structure for view `workshops_reg_view`
--
DROP TABLE IF EXISTS `workshops_reg_view`;

DROP VIEW IF EXISTS `workshops_reg_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `workshops_reg_view`  AS SELECT `wr`.`id` AS `workshop_reg_id`, `wr`.`student_id` AS `student_id`, `sm`.`socket_id` AS `socket_id`, `sm`.`name` AS `name`, `sm`.`img` AS `img`, `w`.`name` AS `title`, `w`.`name_ar` AS `title_ar`, `rw`.`alias` AS `alias`, `rw`.`start_time` AS `start_time`, `rw`.`finish_time` AS `finish_time`, (select `smart_atc`.`name` from `smart_atc` where (`smart_atc`.`id` = `rw`.`trainer_id`)) AS `trainer`, `ac`.`currency` AS `currency`, if((`ac`.`currency` = 's'),`rw`.`price`,`rw`.`price_usd`) AS `price`, `ac`.`amount` AS `paid`, `ac`.`payment_id` AS `payment_id`, if(('s' = 's'),`rw`.`cert_price`,`rw`.`cert_price_usd`) AS `cert_price`, `rw`.`workshop_type` AS `workshop_type`, `w`.`level` AS `level`, `wr`.`review` AS `review`, `wr`.`stars` AS `stars`, `wr`.`ref_id` AS `ref_id`, `wr`.`created` AS `created` FROM ((((`workshops_reg` `wr` left join `accounting` `ac` on(((`ac`.`type_id` = 6) and (`ac`.`details_id` = `wr`.`id`)))) join `running_workshops` `rw` on((`rw`.`id` = `wr`.`running_workshop_id`))) join `workshops` `w` on((`rw`.`workshop_id` = `w`.`id`))) join `smart_atc` `sm` on((`sm`.`id` = `wr`.`student_id`)))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses` ADD FULLTEXT KEY `outcome` (`outcome`,`line_descr`,`short_descr`,`descr`,`pre_req`);
ALTER TABLE `courses` ADD FULLTEXT KEY `descr_ar` (`descr_ar`);
ALTER TABLE `courses` ADD FULLTEXT KEY `pre_req_ar` (`pre_req_ar`);
ALTER TABLE `courses` ADD FULLTEXT KEY `outcome_ar` (`outcome_ar`);
ALTER TABLE `courses` ADD FULLTEXT KEY `line_descr_ar` (`line_descr_ar`);
ALTER TABLE `courses` ADD FULLTEXT KEY `short_descr_ar` (`short_descr_ar`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounting`
--
ALTER TABLE `accounting`
  ADD CONSTRAINT `account_warehouse_id_ipk` FOREIGN KEY (`account_warehouse_id`) REFERENCES `acounts_warehouses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `type_id_ipk` FOREIGN KEY (`type_id`) REFERENCES `accounting_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `ads`
--
ALTER TABLE `ads`
  ADD CONSTRAINT `ads_type_id_ati` FOREIGN KEY (`ads_type_id`) REFERENCES `ads_types` (`id`);

--
-- Constraints for table `blogs`
--
ALTER TABLE `blogs`
  ADD CONSTRAINT `blog_department_id_iup` FOREIGN KEY (`blog_department_id`) REFERENCES `blog_departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_iop` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `blogs_comments`
--
ALTER TABLE `blogs_comments`
  ADD CONSTRAINT `blogs_comments_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_icr` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `blogs_comments_replies`
--
ALTER TABLE `blogs_comments_replies`
  ADD CONSTRAINT `blog_comment_id_opk` FOREIGN KEY (`blog_comment_id`) REFERENCES `blogs_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_ibr` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `blogs_subscribers`
--
ALTER TABLE `blogs_subscribers`
  ADD CONSTRAINT `department_id_ghj` FOREIGN KEY (`department_id`) REFERENCES `blog_departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_ilr` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `blogs_views`
--
ALTER TABLE `blogs_views`
  ADD CONSTRAINT `blog_id_uio` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_jkl` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `blog_images`
--
ALTER TABLE `blog_images`
  ADD CONSTRAINT `user_id_imp` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `blog_post_images`
--
ALTER TABLE `blog_post_images`
  ADD CONSTRAINT `blog_id_hjg` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `blog_image_id_iuy` FOREIGN KEY (`blog_image_id`) REFERENCES `blog_images` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `blog_writers`
--
ALTER TABLE `blog_writers`
  ADD CONSTRAINT `blog_department_id_igg` FOREIGN KEY (`deprt_id`) REFERENCES `blog_departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_ivp` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `book_department_ids` FOREIGN KEY (`book_department_id`) REFERENCES `book_departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `book_downloads`
--
ALTER TABLE `book_downloads`
  ADD CONSTRAINT `book_id_iop` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_nbr` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `book_views`
--
ALTER TABLE `book_views`
  ADD CONSTRAINT `book_id_ikp` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_ncr` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `certificate_print_id` FOREIGN KEY (`certificate_print_id`) REFERENCES `certificate_prints` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `certificate_type_id_ghj` FOREIGN KEY (`certificate_type_id`) REFERENCES `certificate_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `contact_us`
--
ALTER TABLE `contact_us`
  ADD CONSTRAINT `user_id_lfp` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `courses_attendance`
--
ALTER TABLE `courses_attendance`
  ADD CONSTRAINT `course_reg_id` FOREIGN KEY (`course_reg_id`) REFERENCES `courses_reg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `running_course_id` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_chats`
--
ALTER TABLE `courses_chats`
  ADD CONSTRAINT `course_lecture_id` FOREIGN KEY (`course_lecture_id`) REFERENCES `courses_lectures` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `course_reg_id_ipk` FOREIGN KEY (`course_reg_id`) REFERENCES `courses_reg` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `courses_exams`
--
ALTER TABLE `courses_exams`
  ADD CONSTRAINT `running_course_id_ikk` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_exams_answers`
--
ALTER TABLE `courses_exams_answers`
  ADD CONSTRAINT `course_reg_id_ipf` FOREIGN KEY (`course_reg_id`) REFERENCES `courses_reg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `courses_exams_questions_id` FOREIGN KEY (`courses_exams_questions_id`) REFERENCES `courses_exams_questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_exams_check`
--
ALTER TABLE `courses_exams_check`
  ADD CONSTRAINT `course_reg_id_iop` FOREIGN KEY (`course_reg_id`) REFERENCES `courses_reg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `courses_exams_id_for_check` FOREIGN KEY (`course_exam_id`) REFERENCES `courses_exams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_exams_questions`
--
ALTER TABLE `courses_exams_questions`
  ADD CONSTRAINT `courses_exams_id` FOREIGN KEY (`courses_exams_id`) REFERENCES `courses_exams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_fourm_questions`
--
ALTER TABLE `courses_fourm_questions`
  ADD CONSTRAINT `running_course_id_ikl` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_id_iok` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_lectures`
--
ALTER TABLE `courses_lectures`
  ADD CONSTRAINT `courses_lectures_ibfk_1` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_materials`
--
ALTER TABLE `courses_materials`
  ADD CONSTRAINT `running_course_id_ikz` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_points`
--
ALTER TABLE `courses_points`
  ADD CONSTRAINT `running_course_id_ikj` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_projects`
--
ALTER TABLE `courses_projects`
  ADD CONSTRAINT `running_course_id_ikf` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_projects_uploads`
--
ALTER TABLE `courses_projects_uploads`
  ADD CONSTRAINT `course_reg_id_iol` FOREIGN KEY (`course_reg_id`) REFERENCES `courses_reg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `courses_projects_id` FOREIGN KEY (`courses_projects_id`) REFERENCES `courses_projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_reg`
--
ALTER TABLE `courses_reg`
  ADD CONSTRAINT `courses_reg_ibfk_1` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ref_id` FOREIGN KEY (`ref_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `student_id` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `courses_specializations`
--
ALTER TABLE `courses_specializations`
  ADD CONSTRAINT `course_id_ipk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `specialization_id_ipk` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses_trainers`
--
ALTER TABLE `courses_trainers`
  ADD CONSTRAINT `running_course_id_ila` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trainer_id_ipk` FOREIGN KEY (`trainer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_lecture_videos`
--
ALTER TABLE `course_lecture_videos`
  ADD CONSTRAINT `course_lecture_id_oiklp` FOREIGN KEY (`course_lecture_id`) REFERENCES `courses_lectures` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `course_lecture_videos_ibfk_1` FOREIGN KEY (`course_video_id`) REFERENCES `courses_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_views`
--
ALTER TABLE `course_views`
  ADD CONSTRAINT `running_course_id_zcv` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_zvb` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `crm_logs`
--
ALTER TABLE `crm_logs`
  ADD CONSTRAINT `admin_id_ikl` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `prospective_customer_id` FOREIGN KEY (`prospective_customer_id`) REFERENCES `prospective_customers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_yui` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `discussion`
--
ALTER TABLE `discussion`
  ADD CONSTRAINT `user_id_jkkl` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `discussion_comments`
--
ALTER TABLE `discussion_comments`
  ADD CONSTRAINT `discussion_id_tyu` FOREIGN KEY (`discussion_id`) REFERENCES `discussion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_ilk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `discussion_images`
--
ALTER TABLE `discussion_images`
  ADD CONSTRAINT `discussion_id_jkl` FOREIGN KEY (`discussion_id`) REFERENCES `discussion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `execution_data`
--
ALTER TABLE `execution_data`
  ADD CONSTRAINT `execution_data_FK` FOREIGN KEY (`executionId`) REFERENCES `execution_entity` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `execution_entity`
--
ALTER TABLE `execution_entity`
  ADD CONSTRAINT `fk_execution_entity_workflow_id` FOREIGN KEY (`workflowId`) REFERENCES `workflow_entity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `execution_metadata`
--
ALTER TABLE `execution_metadata`
  ADD CONSTRAINT `execution_metadata_FK` FOREIGN KEY (`executionId`) REFERENCES `execution_entity` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `facebook_conversations`
--
ALTER TABLE `facebook_conversations`
  ADD CONSTRAINT `facebook_conversations_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `crm_leads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `facebook_messages`
--
ALTER TABLE `facebook_messages`
  ADD CONSTRAINT `facebook_messages_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `facebook_conversations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `facebook_post_courses`
--
ALTER TABLE `facebook_post_courses`
  ADD CONSTRAINT `facebook_post_courses_ibfk_1` FOREIGN KEY (`facebook_post_id`) REFERENCES `facebook_posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `facebook_post_courses_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `facebook_post_workshops`
--
ALTER TABLE `facebook_post_workshops`
  ADD CONSTRAINT `facebook_post_workshops_ibfk_1` FOREIGN KEY (`facebook_post_id`) REFERENCES `facebook_posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `facebook_post_workshops_ibfk_2` FOREIGN KEY (`workshop_id`) REFERENCES `workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `fav_courses`
--
ALTER TABLE `fav_courses`
  ADD CONSTRAINT `course_id_ipl` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_id_iol` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `given_points`
--
ALTER TABLE `given_points`
  ADD CONSTRAINT `course_reg_id_klo` FOREIGN KEY (`course_reg_id`) REFERENCES `courses_reg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_id_nbu` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `installed_nodes`
--
ALTER TABLE `installed_nodes`
  ADD CONSTRAINT `FK_73f857fc5dce682cef8a99c11dbddbc969618951` FOREIGN KEY (`package`) REFERENCES `installed_packages` (`packageName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `live_lectures_cues`
--
ALTER TABLE `live_lectures_cues`
  ADD CONSTRAINT `lecture_id_jkl` FOREIGN KEY (`lecture_id`) REFERENCES `courses_lectures` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `live_lecture_cues_watch`
--
ALTER TABLE `live_lecture_cues_watch`
  ADD CONSTRAINT `course_reg_id_kdt` FOREIGN KEY (`course_reg_id`) REFERENCES `courses_reg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `live_lecture_cue_id_hjk` FOREIGN KEY (`live_lecture_cue_id`) REFERENCES `live_lectures_cues` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `running_course_id_ill` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `page_first_visit`
--
ALTER TABLE `page_first_visit`
  ADD CONSTRAINT `user_id_jhg` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `placement_test_answers`
--
ALTER TABLE `placement_test_answers`
  ADD CONSTRAINT `placement_test_answers_ibfk_1` FOREIGN KEY (`placement_test_process_id`) REFERENCES `placement_test_processes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `placement_test_answers_ibfk_2` FOREIGN KEY (`placement_test_question_id`) REFERENCES `placement_test_questions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `placement_test_levels`
--
ALTER TABLE `placement_test_levels`
  ADD CONSTRAINT `placement_test_levels_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `placement_test_levels_ibfk_3` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `placement_test_processes`
--
ALTER TABLE `placement_test_processes`
  ADD CONSTRAINT `placement_test_processes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `placement_test_processes_ibfk_3` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `placement_test_questions`
--
ALTER TABLE `placement_test_questions`
  ADD CONSTRAINT `placement_test_questions_ibfk_2` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `prospective_customers`
--
ALTER TABLE `prospective_customers`
  ADD CONSTRAINT `specialization_id_hjk` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `related_courses`
--
ALTER TABLE `related_courses`
  ADD CONSTRAINT `course_id_ipj` FOREIGN KEY (`related_course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `course_id_ipm` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `remote_location_rooms`
--
ALTER TABLE `remote_location_rooms`
  ADD CONSTRAINT `remote_location_id_rlm` FOREIGN KEY (`remote_location_id`) REFERENCES `remote_locations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `remote_location_room_devices`
--
ALTER TABLE `remote_location_room_devices`
  ADD CONSTRAINT `remote_location_room_id_rlm` FOREIGN KEY (`remote_location_room_id`) REFERENCES `remote_location_rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `running_courses`
--
ALTER TABLE `running_courses`
  ADD CONSTRAINT `course_id` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `live_participation_type_id_kjh` FOREIGN KEY (`live_participation_type_id`) REFERENCES `live_participation_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `room_id_jhg` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `trainer_id` FOREIGN KEY (`trainer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `running_course_remote_locations`
--
ALTER TABLE `running_course_remote_locations`
  ADD CONSTRAINT `remote_location_id_rppm` FOREIGN KEY (`remote_location_id`) REFERENCES `remote_locations` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `running_course_id_mmlki` FOREIGN KEY (`running_course_id`) REFERENCES `running_courses` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `running_workshops`
--
ALTER TABLE `running_workshops`
  ADD CONSTRAINT `live_participation_type_id_hjk` FOREIGN KEY (`live_participation_type_id`) REFERENCES `live_participation_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `running_workshops_ibfk_1` FOREIGN KEY (`trainer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `workshop_id_ghj` FOREIGN KEY (`workshop_id`) REFERENCES `workshops` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `running_workshop_remote_locations`
--
ALTER TABLE `running_workshop_remote_locations`
  ADD CONSTRAINT `remote_location_id_poi` FOREIGN KEY (`remote_location_id`) REFERENCES `remote_locations` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `running_workshop_id_klop` FOREIGN KEY (`running_workshop_id`) REFERENCES `running_workshops` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `user_id_ime` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shared_credentials`
--
ALTER TABLE `shared_credentials`
  ADD CONSTRAINT `FK_484f0327e778648dd04f1d70493` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_c68e056637562000b68f480815a` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_shared_credentials_credentials_id` FOREIGN KEY (`credentialsId`) REFERENCES `credentials_entity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `shared_workflow`
--
ALTER TABLE `shared_workflow`
  ADD CONSTRAINT `FK_3540da03964527aa24ae014b780` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_82b2fd9ec4e3e24209af8160282` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_shared_workflow_workflow_id` FOREIGN KEY (`workflowId`) REFERENCES `workflow_entity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `admin_user_id_pop` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `perodic_task_id` FOREIGN KEY (`perodic_task_id`) REFERENCES `periodic_tasks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `topics`
--
ALTER TABLE `topics`
  ADD CONSTRAINT `admin_id_jkl` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_mnn` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `topic_chats`
--
ALTER TABLE `topic_chats`
  ADD CONSTRAINT `topic_id_njh` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `topic_chat_images`
--
ALTER TABLE `topic_chat_images`
  ADD CONSTRAINT `topic_ chat_id_jkl` FOREIGN KEY (`topiChat_id`) REFERENCES `topic_chats` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `smart_user_id_ipk` FOREIGN KEY (`smart_user_id`) REFERENCES `smart_systems`.`smart_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `specialization_id_hjp` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `user_creation_source_id_ucs` FOREIGN KEY (`user_creation_source_id`) REFERENCES `user_creation_sources` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `video_cues`
--
ALTER TABLE `video_cues`
  ADD CONSTRAINT `video_path_id_ipk` FOREIGN KEY (`video_path_id`) REFERENCES `video_pathes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `video_cues_watch`
--
ALTER TABLE `video_cues_watch`
  ADD CONSTRAINT `course_reg_id_jjj` FOREIGN KEY (`course_reg_id`) REFERENCES `courses_reg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `video_cue_id_iok` FOREIGN KEY (`video_cue_id`) REFERENCES `video_cues` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `video_pathes`
--
ALTER TABLE `video_pathes`
  ADD CONSTRAINT `course_video_id_kjj` FOREIGN KEY (`course_video_id`) REFERENCES `courses_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `video_folder_id_vfi` FOREIGN KEY (`video_folder_id`) REFERENCES `video_folders` (`id`);

--
-- Constraints for table `webhook_entity`
--
ALTER TABLE `webhook_entity`
  ADD CONSTRAINT `fk_webhook_entity_workflow_id` FOREIGN KEY (`workflowId`) REFERENCES `workflow_entity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `workflows_tags`
--
ALTER TABLE `workflows_tags`
  ADD CONSTRAINT `fk_workflows_tags_tag_id` FOREIGN KEY (`tagId`) REFERENCES `tag_entity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_workflows_tags_workflow_id` FOREIGN KEY (`workflowId`) REFERENCES `workflow_entity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `workflow_history`
--
ALTER TABLE `workflow_history`
  ADD CONSTRAINT `FK_1e31657f5fe46816c34be7c1b4b` FOREIGN KEY (`workflowId`) REFERENCES `workflow_entity` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `workflow_statistics`
--
ALTER TABLE `workflow_statistics`
  ADD CONSTRAINT `fk_workflow_statistics_workflow_id` FOREIGN KEY (`workflowId`) REFERENCES `workflow_entity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `workshops_reg`
--
ALTER TABLE `workshops_reg`
  ADD CONSTRAINT `ref_id_ipk` FOREIGN KEY (`ref_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `running_workshop_id_ikf` FOREIGN KEY (`running_workshop_id`) REFERENCES `running_workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_id_opp` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `workshops_specializations`
--
ALTER TABLE `workshops_specializations`
  ADD CONSTRAINT `specialization_id_ips` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `workshop_id_ipk` FOREIGN KEY (`workshop_id`) REFERENCES `workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `workshop_chats`
--
ALTER TABLE `workshop_chats`
  ADD CONSTRAINT `running_workshop_id_kjs` FOREIGN KEY (`running_workshop_id`) REFERENCES `running_workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `workshop_reg_id_kkl` FOREIGN KEY (`workshop_reg_id`) REFERENCES `workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `workshop_cues`
--
ALTER TABLE `workshop_cues`
  ADD CONSTRAINT `workshop_cues_ibfk_1` FOREIGN KEY (`running_workshop_id`) REFERENCES `running_workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `workshop_cues_watch`
--
ALTER TABLE `workshop_cues_watch`
  ADD CONSTRAINT `workshop_cue_id_ipk` FOREIGN KEY (`workshop_cue_id`) REFERENCES `workshop_cues` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `workshop_reg_id_lln` FOREIGN KEY (`workshop_reg_id`) REFERENCES `workshops_reg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `workshop_views`
--
ALTER TABLE `workshop_views`
  ADD CONSTRAINT `running_workshop_id_klj` FOREIGN KEY (`running_workshop_id`) REFERENCES `running_workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id_jsd` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
