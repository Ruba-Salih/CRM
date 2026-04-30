-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 26, 2026 at 11:54 AM
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
-- Table structure for table `accounting`
--

CREATE TABLE `accounting` (
  `id` int(11) NOT NULL,
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
  `details` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `accounting_accounts`
--

CREATE TABLE `accounting_accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `accounting_types`
--

CREATE TABLE `accounting_types` (
  `id` int(11) NOT NULL,
  `accounting_account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sain` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `acounts_warehouses`
--

CREATE TABLE `acounts_warehouses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `descr` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE `ads` (
  `id` int(11) NOT NULL,
  `ads_type_id` int(11) DEFAULT NULL,
  `ads_record_id` int(11) DEFAULT NULL COMMENT 'the add type table id (ex: running_course_id)',
  `title` varchar(255) NOT NULL,
  `body` text,
  `sms` varchar(255) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ads_types`
--

CREATE TABLE `ads_types` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ads_views`
--

CREATE TABLE `ads_views` (
  `id` int(11) NOT NULL,
  `ad_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seen` timestamp NULL DEFAULT NULL,
  `sms_sent` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `atc_config`
--

CREATE TABLE `atc_config` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `comment` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `head_img` text NOT NULL,
  `blog_department_id` int(11) DEFAULT NULL,
  `body` text NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blogs_comments`
--

CREATE TABLE `blogs_comments` (
  `id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blogs_comments_replies`
--

CREATE TABLE `blogs_comments_replies` (
  `id` int(11) NOT NULL,
  `blog_comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blogs_subscribers`
--

CREATE TABLE `blogs_subscribers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blogs_views`
--

CREATE TABLE `blogs_views` (
  `blog_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blog_departments`
--

CREATE TABLE `blog_departments` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blog_images`
--

CREATE TABLE `blog_images` (
  `id` int(11) NOT NULL,
  `path` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blog_post_images`
--

CREATE TABLE `blog_post_images` (
  `blog_id` int(11) NOT NULL,
  `blog_image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blog_writers`
--

CREATE TABLE `blog_writers` (
  `user_id` int(11) NOT NULL,
  `deprt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `book_departments`
--

CREATE TABLE `book_departments` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `book_downloads`
--

CREATE TABLE `book_downloads` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `book_views`
--

CREATE TABLE `book_views` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `id` int(11) NOT NULL,
  `certificate_type_id` int(11) DEFAULT NULL,
  `record_id` int(11) NOT NULL,
  `request_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `taken_time` timestamp NULL DEFAULT NULL,
  `is_free` tinyint(1) DEFAULT NULL,
  `payment_confirmed` tinyint(1) DEFAULT NULL,
  `certificate_print_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `certificate_prints`
--

CREATE TABLE `certificate_prints` (
  `id` int(11) NOT NULL,
  `download_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `print_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `certificate_types`
--

CREATE TABLE `certificate_types` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ckeditor_images_tracking`
--

CREATE TABLE `ckeditor_images_tracking` (
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

CREATE TABLE `contact_us` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `descr` text NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `answer_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_attendance`
--

CREATE TABLE `courses_attendance` (
  `attendance_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `running_course_id` int(11) NOT NULL,
  `selected_group` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `courses_attendance`
--
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

CREATE TABLE `courses_chats` (
  `id` int(11) NOT NULL,
  `course_lecture_id` int(11) NOT NULL,
  `course_reg_id` int(11) DEFAULT NULL,
  `body` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_exams`
--

CREATE TABLE `courses_exams` (
  `id` int(11) NOT NULL,
  `running_course_id` int(11) NOT NULL,
  `title` varchar(254) COLLATE utf8mb4_bin NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `finish_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `shown` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `courses_exams_answers`
--

CREATE TABLE `courses_exams_answers` (
  `id` int(11) NOT NULL,
  `courses_exams_questions_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `answer` text NOT NULL,
  `degree` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_exams_check`
--

CREATE TABLE `courses_exams_check` (
  `id` int(11) NOT NULL,
  `course_exam_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `degree` float DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `courses_exams_check`
--
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

CREATE TABLE `courses_exams_questions` (
  `id` int(11) NOT NULL,
  `courses_exams_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `question` text NOT NULL,
  `answer` varchar(255) NOT NULL,
  `degree` float NOT NULL,
  `cancelled` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_fourm_questions`
--

CREATE TABLE `courses_fourm_questions` (
  `id` int(11) NOT NULL,
  `running_course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(255) NOT NULL,
  `images` text NOT NULL,
  `answer` text NOT NULL,
  `answer_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `answer_images` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_lectures`
--

CREATE TABLE `courses_lectures` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_materials`
--

CREATE TABLE `courses_materials` (
  `id` int(11) NOT NULL,
  `running_course_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `isFile` tinyint(1) NOT NULL DEFAULT '1',
  `size` varchar(25) DEFAULT NULL,
  `material_order` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_old_projects`
--

CREATE TABLE `courses_old_projects` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `degree` float DEFAULT NULL,
  `cancelled` tinyint(4) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `finish_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `courses_points`
--

CREATE TABLE `courses_points` (
  `id` int(11) NOT NULL,
  `running_course_id` int(11) NOT NULL,
  `greaterThan` int(11) NOT NULL,
  `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_projects`
--

CREATE TABLE `courses_projects` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `courses_projects_uploads`
--

CREATE TABLE `courses_projects_uploads` (
  `id` int(11) NOT NULL,
  `courses_projects_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `file` varchar(255) NOT NULL,
  `size` varchar(255) NOT NULL,
  `degree` float DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_reg`
--

CREATE TABLE `courses_reg` (
  `id` int(11) NOT NULL,
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
  `ref_paid` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `courses_registeration`
-- (See below for the actual view)
--
CREATE TABLE `courses_registeration` (
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
CREATE TABLE `courses_registeration_full` (
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

CREATE TABLE `courses_specializations` (
  `course_id` int(11) NOT NULL,
  `specialization_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_trainers`
--

CREATE TABLE `courses_trainers` (
  `id` int(11) NOT NULL,
  `running_course_id` int(11) NOT NULL,
  `trainer_id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `teacher_deserves` float NOT NULL DEFAULT '0',
  `deserves_whithdrawl` float NOT NULL DEFAULT '0',
  `teacher_deserves_usd` float DEFAULT '0',
  `deserves_whithdrawl_usd` float NOT NULL DEFAULT '0',
  `trainer_online_percent` float DEFAULT NULL,
  `trainer_offline_percent` float DEFAULT NULL,
  `created` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `courses_videos`
--

CREATE TABLE `courses_videos` (
  `id` int(11) NOT NULL,
  `isBonus` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `course_lecture_videos`
--

CREATE TABLE `course_lecture_videos` (
  `id` int(11) NOT NULL,
  `course_lecture_id` int(11) NOT NULL,
  `course_video_id` int(11) NOT NULL,
  `video_order` int(11) DEFAULT NULL,
  `video_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_types`
--

CREATE TABLE `course_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_views`
--

CREATE TABLE `course_views` (
  `user_id` int(11) DEFAULT NULL,
  `running_course_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `crm_leads`
--

CREATE TABLE `crm_leads` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_id_fk` int(11) DEFAULT NULL COMMENT 'Link to users.id after registration',
  `source_platform` enum('facebook','instagram','tiktok','whatsapp') NOT NULL,
  `first_interaction_type` enum('comment','reaction','message') NOT NULL,
  `first_interaction_time` timestamp NULL DEFAULT NULL,
  `last_interaction_time` timestamp NULL DEFAULT NULL,
  `lead_score` int(11) DEFAULT '0',
  `status` enum('new','contacted','qualified','converted','lost') DEFAULT 'new',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crm_lead_social_profiles`
--

CREATE TABLE `crm_lead_social_profiles` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Table structure for table `crm_platforms`
--

CREATE TABLE `crm_platforms` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
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

-- --------------------------------------------------------

--
-- Table structure for table `crm_service_types`
--

CREATE TABLE `crm_service_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `platform_id` int(11) DEFAULT NULL,
  `interaction_type` enum('message','comment') DEFAULT 'message',
  `external_id` varchar(255) DEFAULT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `discussion`
--

CREATE TABLE `discussion` (
  `id` int(11) NOT NULL,
  `running_course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `question` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `discussion_comments`
--

CREATE TABLE `discussion_comments` (
  `id` int(11) NOT NULL,
  `discussion_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text,
  `audio` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `discussion_images`
--

CREATE TABLE `discussion_images` (
  `id` int(11) NOT NULL,
  `discussion_id` int(11) DEFAULT NULL,
  `file` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `e_library`
--

CREATE TABLE `e_library` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `file` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fav_courses`
--

CREATE TABLE `fav_courses` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `generated_ads`
--

CREATE TABLE `generated_ads` (
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

CREATE TABLE `given_points` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `type` text NOT NULL,
  `course_reg_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `live_lectures_cues`
--

CREATE TABLE `live_lectures_cues` (
  `id` int(11) NOT NULL,
  `lecture_id` int(11) NOT NULL,
  `cue_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `live_lecture_cues_watch`
--

CREATE TABLE `live_lecture_cues_watch` (
  `id` int(11) NOT NULL,
  `live_lecture_cue_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `live_participation_types`
--

CREATE TABLE `live_participation_types` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `descr` varchar(255) NOT NULL,
  `descr_ar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `message_templates`
--

CREATE TABLE `message_templates` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `page_first_visit`
--

CREATE TABLE `page_first_visit` (
  `page` int(11) NOT NULL COMMENT '1="current_course",2="student_course_dashboard",3="student_account",4="registeration_modal"',
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `periodic_tasks`
--

CREATE TABLE `periodic_tasks` (
  `id` int(11) NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `descr` text NOT NULL,
  `period_type` varchar(255) NOT NULL COMMENT '{daily,weekly,bimonthly,monthly,biannualy,annualy',
  `start_date` datetime NOT NULL,
  `priority` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `placement_tests`
--

CREATE TABLE `placement_tests` (
  `id` int(11) NOT NULL,
  `track_id` int(11) DEFAULT NULL,
  `duration` smallint(11) UNSIGNED DEFAULT NULL COMMENT 'in minutes',
  `title` varchar(255) DEFAULT NULL,
  `price_sdg` decimal(20,3) UNSIGNED DEFAULT '0.000',
  `price_usd` decimal(20,3) UNSIGNED NOT NULL DEFAULT '0.000',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `placement_test_answers`
--

CREATE TABLE `placement_test_answers` (
  `id` int(11) NOT NULL,
  `placement_test_process_id` int(11) DEFAULT NULL,
  `placement_test_question_id` int(11) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `degree` decimal(3,2) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `placement_test_levels`
--

CREATE TABLE `placement_test_levels` (
  `id` int(11) NOT NULL,
  `track_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `score` decimal(6,2) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `placement_test_processes`
--

CREATE TABLE `placement_test_processes` (
  `id` int(11) NOT NULL,
  `track_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `degree` decimal(6,2) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `placement_test_questions`
--

CREATE TABLE `placement_test_questions` (
  `id` int(11) NOT NULL,
  `track_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `question` text,
  `answer` varchar(266) DEFAULT NULL,
  `degree` decimal(3,2) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `prospective_customers`
--

CREATE TABLE `prospective_customers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `tel` varchar(25) NOT NULL,
  `specialization_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `related_courses`
--

CREATE TABLE `related_courses` (
  `course_id` int(11) NOT NULL,
  `related_course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `related_workshops`
--

CREATE TABLE `related_workshops` (
  `workshop_id` int(11) NOT NULL,
  `related_workshop_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `remote_locations`
--

CREATE TABLE `remote_locations` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `remote_location_rooms`
--

CREATE TABLE `remote_location_rooms` (
  `id` int(11) NOT NULL,
  `remote_location_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `remote_location_room_devices`
--

CREATE TABLE `remote_location_room_devices` (
  `id` int(11) NOT NULL,
  `remote_location_room_id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `seats` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `running_courses`
--

CREATE TABLE `running_courses` (
  `id` int(11) NOT NULL,
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
  `pre_req` varchar(52) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `running_course_remote_locations`
--

CREATE TABLE `running_course_remote_locations` (
  `id` int(11) NOT NULL,
  `running_course_id` int(11) DEFAULT NULL,
  `remote_location_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `running_workshops`
--

CREATE TABLE `running_workshops` (
  `id` int(11) NOT NULL,
  `workshop_id` int(11) DEFAULT NULL,
  `live_participation_type_id` int(11) DEFAULT NULL,
  `trainer_id` int(11) DEFAULT NULL,
  `trainer_socket_id` varchar(255) DEFAULT NULL,
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
  `workshop_type` int(11) NOT NULL,
  `pre_req` text,
  `tot_seats` int(11) DEFAULT NULL,
  `alias` varchar(100) NOT NULL,
  `trainer_online_percent` int(11) DEFAULT NULL,
  `trainer_offline_percent` int(11) DEFAULT NULL,
  `trainer_notified` tinyint(1) NOT NULL DEFAULT '0',
  `token` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `running_workshop_remote_locations`
--

CREATE TABLE `running_workshop_remote_locations` (
  `id` int(11) NOT NULL,
  `running_workshop_id` int(11) NOT NULL,
  `remote_location_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sent_messages`
--

CREATE TABLE `sent_messages` (
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

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL,
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
  `lat` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `smart_atc`
-- (See below for the actual view)
--
CREATE TABLE `smart_atc` (
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

CREATE TABLE `specializations` (
  `name` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `img` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sub_tasks`
--

CREATE TABLE `sub_tasks` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `descr` text NOT NULL,
  `start_time` datetime NOT NULL,
  `suggested_finish_time` datetime DEFAULT NULL,
  `manager_review` text,
  `finish_time` datetime DEFAULT NULL,
  `accomplished` tinyint(1) NOT NULL DEFAULT '0',
  `emp_review` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `descr` text,
  `start_time` datetime NOT NULL,
  `suggested_finish_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `accomplished` tinyint(1) NOT NULL DEFAULT '0',
  `priority` int(16) DEFAULT NULL,
  `emp_review` text,
  `perodic_task_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `id` int(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `descr` varchar(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `type` int(255) NOT NULL DEFAULT '0' COMMENT '0 = create_account, 1 = login, 2=register_for_course, 3=payment,4=videos,5=exams,6=project,7=certificates,99=other',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = open , 1 = close',
  `report` varchar(255) DEFAULT NULL,
  `admin_id` int(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `topic_chats`
--

CREATE TABLE `topic_chats` (
  `id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `chat` varchar(255) NOT NULL,
  `has_images` tinyint(1) NOT NULL DEFAULT '0',
  `source` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = user , 1 = admin',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `topic_chat_images`
--

CREATE TABLE `topic_chat_images` (
  `id` int(11) NOT NULL,
  `topiChat_id` int(11) NOT NULL,
  `path` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

CREATE TABLE `tracks` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `smart_user_id` int(11) DEFAULT NULL,
  `user_creation_source_id` int(11) NOT NULL DEFAULT '1',
  `descr` varchar(2048) DEFAULT NULL,
  `descr_ar` varchar(2048) DEFAULT NULL,
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
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_creation_sources`
--

CREATE TABLE `user_creation_sources` (
  `id` int(11) NOT NULL,
  `source` varchar(255) NOT NULL,
  `source_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `video_cues`
--

CREATE TABLE `video_cues` (
  `id` int(11) NOT NULL,
  `video_path_id` int(11) NOT NULL,
  `cue_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `video_cues_watch`
--

CREATE TABLE `video_cues_watch` (
  `id` int(11) NOT NULL,
  `video_cue_id` int(11) NOT NULL,
  `course_reg_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `video_cues_watch`
--
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

CREATE TABLE `video_folders` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `video_pathes`
--

CREATE TABLE `video_pathes` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `video_pathes`
--
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
-- Table structure for table `whatsapp_black_list`
--

CREATE TABLE `whatsapp_black_list` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `tel` int(11) NOT NULL,
  `is_start` tinyint(1) NOT NULL COMMENT '1,0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_groups`
--

CREATE TABLE `whatsapp_groups` (
  `id` int(11) NOT NULL,
  `whatsapp_app_id` int(11) DEFAULT NULL,
  `specialization_id` int(11) DEFAULT NULL,
  `group_creation_time` int(11) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(255) DEFAULT NULL,
  `invite_group` varchar(255) DEFAULT NULL,
  `lastMessage` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_group_members`
--

CREATE TABLE `whatsapp_group_members` (
  `whatsapp_group_id` int(11) NOT NULL,
  `whatsapp_member_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_members`
--

CREATE TABLE `whatsapp_members` (
  `id` int(11) NOT NULL,
  `tel` varchar(25) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_messages`
--

CREATE TABLE `whatsapp_messages` (
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

CREATE TABLE `whatsapp_message_recipients` (
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

CREATE TABLE `whatsapp_perodic_message` (
  `id` int(11) NOT NULL,
  `message` text NOT NULL,
  `periodic_type` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workshops`
--

CREATE TABLE `workshops` (
  `id` int(11) NOT NULL,
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
  `outline` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `workshops_reg`
--

CREATE TABLE `workshops_reg` (
  `id` int(11) NOT NULL,
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
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `workshops_reg_view`
-- (See below for the actual view)
--
CREATE TABLE `workshops_reg_view` (
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

CREATE TABLE `workshops_specializations` (
  `workshop_id` int(11) NOT NULL,
  `specialization_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_chats`
--

CREATE TABLE `workshop_chats` (
  `id` int(11) NOT NULL,
  `running_workshop_id` int(11) NOT NULL,
  `workshop_reg_id` int(11) DEFAULT NULL,
  `body` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_cues`
--

CREATE TABLE `workshop_cues` (
  `id` int(11) NOT NULL,
  `running_workshop_id` int(11) NOT NULL,
  `cue_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_cues_watch`
--

CREATE TABLE `workshop_cues_watch` (
  `id` int(11) NOT NULL,
  `workshop_cue_id` int(11) NOT NULL,
  `workshop_reg_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_types`
--

CREATE TABLE `workshop_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `name_ar` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_views`
--

CREATE TABLE `workshop_views` (
  `user_id` int(11) DEFAULT NULL,
  `running_workshop_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure for view `courses_registeration`
--
DROP TABLE IF EXISTS `courses_registeration`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `courses_registeration`  AS   (select `system_atc`.`courses_reg`.`id` AS `courses_reg_id`,`system_atc`.`users`.`id` AS `user_id`,`smart_systems`.`smart_users`.`name` AS `student`,`smart_systems`.`smart_users`.`img` AS `img`,`smart_systems`.`smart_users`.`tel` AS `tel`,`system_atc`.`courses`.`name` AS `course`,`system_atc`.`running_courses`.`alias` AS `alias`,`system_atc`.`running_courses`.`course_type` AS `course_type`,`system_atc`.`courses_reg`.`cert_deserve` AS `cert_deserve`,`system_atc`.`courses_reg`.`not_desrve_reason` AS `not_desrve_reason`,`get_watched_videos`(`system_atc`.`courses_reg`.`id`) AS `watched_videos`,`get_total_videos`(`system_atc`.`courses_reg`.`running_course_id`) AS `tot_videos`,`get_attended_lec`(`system_atc`.`courses_reg`.`id`) AS `attended_days`,`get_course_days`(`system_atc`.`courses_reg`.`running_course_id`,`system_atc`.`courses_reg`.`id`) AS `tot_days`,`system_atc`.`courses_reg`.`running_course_id` AS `running_course_id`,`system_atc`.`running_courses`.`course_id` AS `course_id`,(select sum(`system_atc`.`accounting`.`amount`) from `system_atc`.`accounting` where ((`system_atc`.`accounting`.`type_id` = 1) and (`system_atc`.`accounting`.`details_id` = `system_atc`.`courses_reg`.`id`) and (`system_atc`.`accounting`.`canceled` = 0))) AS `paid`,`system_atc`.`courses_reg`.`reveiew` AS `reveiew`,`system_atc`.`courses_reg`.`stars` AS `stars`,`system_atc`.`courses_reg`.`points` AS `points`,`system_atc`.`courses_reg`.`reg_type` AS `reg_type`,`system_atc`.`courses_reg`.`delay_status` AS `delay_status`,`system_atc`.`courses_reg`.`transfered_answer` AS `transfered_answer`,`system_atc`.`courses_reg`.`transfered_course_reg_id` AS `transfered_course_reg_id`,`system_atc`.`courses_reg`.`completed` AS `completed`,`system_atc`.`courses_reg`.`completed_time` AS `completed_time`,`system_atc`.`courses_reg`.`notification_service` AS `notification_service`,`system_atc`.`courses_reg`.`cancelled` AS `cancelled`,`system_atc`.`courses_reg`.`cancelled_time` AS `cancelled_time`,`system_atc`.`courses_reg`.`degree` AS `degree`,`system_atc`.`courses_reg`.`created` AS `created`,`system_atc`.`courses_reg`.`selected_group` AS `selected_group`,`system_atc`.`courses_reg`.`payment_confirmed` AS `payment_confirmed` from ((((`system_atc`.`courses_reg` join `system_atc`.`running_courses` on((`system_atc`.`running_courses`.`id` = `system_atc`.`courses_reg`.`running_course_id`))) join `system_atc`.`users` on((`system_atc`.`users`.`id` = `system_atc`.`courses_reg`.`student_id`))) join `system_atc`.`courses` on((`system_atc`.`courses`.`name` = (select `system_atc`.`courses`.`name` from `system_atc`.`courses` where (`system_atc`.`courses`.`id` = `system_atc`.`running_courses`.`course_id`))))) join `smart_systems`.`smart_users` on((`smart_systems`.`smart_users`.`id` = `system_atc`.`users`.`smart_user_id`))) order by ((`system_atc`.`courses_reg`.`id` <> 0) and (`system_atc`.`courses_reg`.`created` <> 0)) desc)  ;

-- --------------------------------------------------------

--
-- Structure for view `courses_registeration_full`
--
DROP TABLE IF EXISTS `courses_registeration_full`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `courses_registeration_full`  AS SELECT `system_atc`.`courses_reg`.`id` AS `courses_reg_id`, `system_atc`.`users`.`id` AS `user_id`, `system_atc`.`users`.`smart_user_id` AS `smart_user_id`, `smart_systems`.`smart_users`.`name` AS `student`, `smart_systems`.`smart_users`.`img` AS `img`, `smart_systems`.`smart_users`.`tel` AS `tel`, `system_atc`.`courses`.`name` AS `course`, `system_atc`.`running_courses`.`alias` AS `alias`, `system_atc`.`running_courses`.`course_type` AS `course_type`, `system_atc`.`courses_reg`.`cert_deserve` AS `cert_deserve`, `system_atc`.`courses_reg`.`not_desrve_reason` AS `not_desrve_reason`, if((`system_atc`.`courses_reg`.`reg_type` = 2),`get_watched_videos`(`system_atc`.`courses_reg`.`id`),NULL) AS `watched_videos`, if((`system_atc`.`courses_reg`.`reg_type` = 2),`get_total_videos`(`system_atc`.`courses_reg`.`running_course_id`),NULL) AS `tot_videos`, if((`system_atc`.`courses_reg`.`reg_type` = 1),`get_attended_lec`(`system_atc`.`courses_reg`.`id`),NULL) AS `attended_days`, if((`system_atc`.`courses_reg`.`reg_type` = 1),`get_course_days`(`system_atc`.`courses_reg`.`running_course_id`,`system_atc`.`courses_reg`.`id`),NULL) AS `tot_days`, `system_atc`.`courses_reg`.`running_course_id` AS `running_course_id`, `system_atc`.`running_courses`.`course_id` AS `course_id`, (select sum(`system_atc`.`accounting`.`amount`) from `system_atc`.`accounting` where ((`system_atc`.`accounting`.`type_id` = 1) and (`system_atc`.`accounting`.`details_id` = `system_atc`.`courses_reg`.`id`) and (`system_atc`.`accounting`.`canceled` = 0))) AS `paid`, `system_atc`.`courses_reg`.`reveiew` AS `reveiew`, `system_atc`.`courses_reg`.`stars` AS `stars`, `system_atc`.`courses_reg`.`points` AS `points`, `system_atc`.`courses_reg`.`reg_type` AS `reg_type`, `system_atc`.`courses_reg`.`delay_status` AS `delay_status`, `system_atc`.`courses_reg`.`transfered_answer` AS `transfered_answer`, `system_atc`.`courses_reg`.`transfered_course_reg_id` AS `transfered_course_reg_id`, `system_atc`.`courses_reg`.`completed` AS `completed`, `system_atc`.`courses_reg`.`completed_time` AS `completed_time`, `system_atc`.`courses_reg`.`notification_service` AS `notification_service`, `system_atc`.`courses_reg`.`cancelled` AS `cancelled`, `system_atc`.`courses_reg`.`cancelled_time` AS `cancelled_time`, `system_atc`.`courses_reg`.`degree` AS `degree`, `system_atc`.`courses_reg`.`created` AS `created`, `system_atc`.`courses_reg`.`selected_group` AS `selected_group`, `system_atc`.`courses_reg`.`payment_confirmed` AS `payment_confirmed` FROM ((((`system_atc`.`courses_reg` join `system_atc`.`running_courses` on((`system_atc`.`running_courses`.`id` = `system_atc`.`courses_reg`.`running_course_id`))) join `system_atc`.`users` on((`system_atc`.`users`.`id` = `system_atc`.`courses_reg`.`student_id`))) join `system_atc`.`courses` on((`system_atc`.`courses`.`id` = `system_atc`.`running_courses`.`course_id`))) join `smart_systems`.`smart_users` on((`smart_systems`.`smart_users`.`id` = `system_atc`.`users`.`smart_user_id`))) ORDER BY `system_atc`.`courses_reg`.`id` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `smart_atc`
--
DROP TABLE IF EXISTS `smart_atc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_atc`  AS   (select `system_atc`.`users`.`id` AS `id`,`system_atc`.`users`.`smart_user_id` AS `smart_user_id`,`system_atc`.`users`.`isAmbassador` AS `isAmbassador`,`system_atc`.`users`.`isAdmin` AS `isAdmin`,`system_atc`.`users`.`adminLevel` AS `adminLevel`,`sm`.`name` AS `name`,`sm`.`user` AS `user`,`system_atc`.`users`.`isTrainer` AS `isTrainer`,`system_atc`.`users`.`descr` AS `descr`,`system_atc`.`users`.`descr_ar` AS `descr_ar`,`system_atc`.`users`.`specialization_id` AS `specialization_id`,`system_atc`.`users`.`cv` AS `cv`,`system_atc`.`users`.`atc_email` AS `atc_email`,`system_atc`.`users`.`points` AS `points`,`system_atc`.`users`.`trainer_online_percent` AS `trainer_online_percent`,`system_atc`.`users`.`trainer_offline_percent` AS `trainer_offline_percent`,`system_atc`.`users`.`stopped` AS `stopped`,`system_atc`.`users`.`online` AS `online`,`system_atc`.`users`.`socket_id` AS `socket_id`,`system_atc`.`users`.`signature` AS `signature`,`system_atc`.`users`.`aff_percent` AS `aff_percent`,`system_atc`.`users`.`created` AS `atc_created`,`system_atc`.`users`.`updated` AS `atc_updated`,`sm`.`pass` AS `pass`,`sm`.`tel` AS `tel`,`sm`.`email` AS `email`,`sm`.`lng` AS `lng`,`sm`.`lat` AS `lat`,`sm`.`img` AS `img`,`sm`.`work` AS `work`,`sm`.`created` AS `smart_created`,`sm`.`gender` AS `gender`,`sm`.`university` AS `university`,`sm`.`card_number` AS `card_number`,`sm`.`card_exp` AS `card_exp`,`sm`.`usd_card_number` AS `usd_card_number`,`sm`.`usd_card_type` AS `usd_card_type`,`sm`.`usd_card_exp` AS `usd_card_exp`,`sm`.`usd_card_cvc` AS `usd_card_cvc`,`sm`.`sd_balance` AS `sd_balance`,`sm`.`usd_balance` AS `usd_balance`,`sm`.`blocked` AS `blocked`,`sm`.`blocked_reason` AS `blocked_reason`,`sm`.`code` AS `code`,`sm`.`code_time` AS `code_time` from (`system_atc`.`users` join `smart_systems`.`smart_users` `sm` on((`system_atc`.`users`.`smart_user_id` = `sm`.`id`))))  ;

-- --------------------------------------------------------

--
-- Structure for view `workshops_reg_view`
--
DROP TABLE IF EXISTS `workshops_reg_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `workshops_reg_view`  AS SELECT `wr`.`id` AS `workshop_reg_id`, `wr`.`student_id` AS `student_id`, `sm`.`socket_id` AS `socket_id`, `sm`.`name` AS `name`, `sm`.`img` AS `img`, `w`.`name` AS `title`, `w`.`name_ar` AS `title_ar`, `rw`.`alias` AS `alias`, `rw`.`start_time` AS `start_time`, `rw`.`finish_time` AS `finish_time`, (select `smart_atc`.`name` from `system_atc`.`smart_atc` where (`smart_atc`.`id` = `rw`.`trainer_id`)) AS `trainer`, `ac`.`currency` AS `currency`, if((`ac`.`currency` = 's'),`rw`.`price`,`rw`.`price_usd`) AS `price`, `ac`.`amount` AS `paid`, `ac`.`payment_id` AS `payment_id`, if(('s' = 's'),`rw`.`cert_price`,`rw`.`cert_price_usd`) AS `cert_price`, `rw`.`workshop_type` AS `workshop_type`, `w`.`level` AS `level`, `wr`.`review` AS `review`, `wr`.`stars` AS `stars`, `wr`.`ref_id` AS `ref_id`, `wr`.`created` AS `created` FROM ((((`system_atc`.`workshops_reg` `wr` left join `system_atc`.`accounting` `ac` on(((`ac`.`type_id` = 6) and (`ac`.`details_id` = `wr`.`id`)))) join `system_atc`.`running_workshops` `rw` on((`rw`.`id` = `wr`.`running_workshop_id`))) join `system_atc`.`workshops` `w` on((`rw`.`workshop_id` = `w`.`id`))) join `system_atc`.`smart_atc` `sm` on((`sm`.`id` = `wr`.`student_id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounting`
--
ALTER TABLE `accounting`
  ADD PRIMARY KEY (`id`),
  ADD KEY `details` (`details`),
  ADD KEY `payment_id` (`payment_id`),
  ADD KEY `account_warehouse_id` (`account_warehouse_id`),
  ADD KEY `type_id` (`type_id`),
  ADD KEY `details_id` (`details_id`);

--
-- Indexes for table `accounting_accounts`
--
ALTER TABLE `accounting_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `accounting_types`
--
ALTER TABLE `accounting_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `acounts_warehouses`
--
ALTER TABLE `acounts_warehouses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ads_type_id_ati` (`ads_type_id`);

--
-- Indexes for table `ads_types`
--
ALTER TABLE `ads_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ads_views`
--
ALTER TABLE `ads_views`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `atc_config`
--
ALTER TABLE `atc_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `blog_department_id` (`blog_department_id`);

--
-- Indexes for table `blogs_comments`
--
ALTER TABLE `blogs_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `blogs_comments_replies`
--
ALTER TABLE `blogs_comments_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_comment_id` (`blog_comment_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `blogs_subscribers`
--
ALTER TABLE `blogs_subscribers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `blogs_views`
--
ALTER TABLE `blogs_views`
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `blog_departments`
--
ALTER TABLE `blog_departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_images`
--
ALTER TABLE `blog_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `blog_post_images`
--
ALTER TABLE `blog_post_images`
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `blog_image_id` (`blog_image_id`);

--
-- Indexes for table `blog_writers`
--
ALTER TABLE `blog_writers`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `deprt_id` (`deprt_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_department_id` (`book_department_id`);

--
-- Indexes for table `book_departments`
--
ALTER TABLE `book_departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_downloads`
--
ALTER TABLE `book_downloads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `book_views`
--
ALTER TABLE `book_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificate_print_id` (`certificate_print_id`),
  ADD KEY `certificate_type_id` (`certificate_type_id`);

--
-- Indexes for table `certificate_prints`
--
ALTER TABLE `certificate_prints`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `certificate_types`
--
ALTER TABLE `certificate_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_us`
--
ALTER TABLE `contact_us`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);
ALTER TABLE `courses` ADD FULLTEXT KEY `outcome` (`outcome`,`line_descr`,`short_descr`,`descr`,`pre_req`);
ALTER TABLE `courses` ADD FULLTEXT KEY `descr_ar` (`descr_ar`);
ALTER TABLE `courses` ADD FULLTEXT KEY `pre_req_ar` (`pre_req_ar`);
ALTER TABLE `courses` ADD FULLTEXT KEY `outcome_ar` (`outcome_ar`);
ALTER TABLE `courses` ADD FULLTEXT KEY `line_descr_ar` (`line_descr_ar`);
ALTER TABLE `courses` ADD FULLTEXT KEY `short_descr_ar` (`short_descr_ar`);

--
-- Indexes for table `courses_attendance`
--
ALTER TABLE `courses_attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `course_reg_id` (`course_reg_id`),
  ADD KEY `running_course_id` (`running_course_id`);

--
-- Indexes for table `courses_chats`
--
ALTER TABLE `courses_chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_lecture_id` (`course_lecture_id`),
  ADD KEY `course_reg_id` (`course_reg_id`);

--
-- Indexes for table `courses_exams`
--
ALTER TABLE `courses_exams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_course_id` (`running_course_id`);

--
-- Indexes for table `courses_exams_answers`
--
ALTER TABLE `courses_exams_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `courses_exams_questions_id` (`courses_exams_questions_id`),
  ADD KEY `course_reg_id` (`course_reg_id`);

--
-- Indexes for table `courses_exams_check`
--
ALTER TABLE `courses_exams_check`
  ADD PRIMARY KEY (`id`),
  ADD KEY `courses_exams_id_for_check` (`course_exam_id`),
  ADD KEY `course_reg_id` (`course_reg_id`);

--
-- Indexes for table `courses_exams_questions`
--
ALTER TABLE `courses_exams_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `courses_exams_id` (`courses_exams_id`);

--
-- Indexes for table `courses_fourm_questions`
--
ALTER TABLE `courses_fourm_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_course_id` (`running_course_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `courses_lectures`
--
ALTER TABLE `courses_lectures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_course_id` (`running_course_id`);

--
-- Indexes for table `courses_materials`
--
ALTER TABLE `courses_materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_course_id` (`running_course_id`);

--
-- Indexes for table `courses_old_projects`
--
ALTER TABLE `courses_old_projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses_points`
--
ALTER TABLE `courses_points`
  ADD KEY `running_course_id` (`running_course_id`);

--
-- Indexes for table `courses_projects`
--
ALTER TABLE `courses_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_course_id` (`running_course_id`);

--
-- Indexes for table `courses_projects_uploads`
--
ALTER TABLE `courses_projects_uploads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `courses_projects_id` (`courses_projects_id`),
  ADD KEY `course_reg_id` (`course_reg_id`);

--
-- Indexes for table `courses_reg`
--
ALTER TABLE `courses_reg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_course_id` (`running_course_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `ref_id` (`ref_id`);

--
-- Indexes for table `courses_specializations`
--
ALTER TABLE `courses_specializations`
  ADD KEY `course_id` (`course_id`),
  ADD KEY `specialization_id` (`specialization_id`);

--
-- Indexes for table `courses_trainers`
--
ALTER TABLE `courses_trainers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_course_id` (`running_course_id`),
  ADD KEY `trainer_id` (`trainer_id`);

--
-- Indexes for table `courses_videos`
--
ALTER TABLE `courses_videos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_lecture_videos`
--
ALTER TABLE `course_lecture_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_lecture_id` (`course_lecture_id`,`course_video_id`),
  ADD KEY `course_video_id` (`course_video_id`);

--
-- Indexes for table `course_types`
--
ALTER TABLE `course_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_views`
--
ALTER TABLE `course_views`
  ADD KEY `running_course_id` (`running_course_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `crm_leads`
--
ALTER TABLE `crm_leads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `source_platform` (`source_platform`);

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
-- Indexes for table `crm_platforms`
--
ALTER TABLE `crm_platforms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_msg_platform` (`platform_id`);

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
-- Indexes for table `discussion`
--
ALTER TABLE `discussion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_course_id` (`running_course_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `discussion_comments`
--
ALTER TABLE `discussion_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discussion_id` (`discussion_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `discussion_images`
--
ALTER TABLE `discussion_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discussion_id` (`discussion_id`);

--
-- Indexes for table `e_library`
--
ALTER TABLE `e_library`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`);

--
-- Indexes for table `fav_courses`
--
ALTER TABLE `fav_courses`
  ADD KEY `course_id` (`course_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `given_points`
--
ALTER TABLE `given_points`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_reg_id` (`course_reg_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `live_lectures_cues`
--
ALTER TABLE `live_lectures_cues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lecture_id` (`lecture_id`);

--
-- Indexes for table `live_lecture_cues_watch`
--
ALTER TABLE `live_lecture_cues_watch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_reg_id` (`course_reg_id`),
  ADD KEY `live_lecture_cue_id` (`live_lecture_cue_id`);

--
-- Indexes for table `live_participation_types`
--
ALTER TABLE `live_participation_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message_templates`
--
ALTER TABLE `message_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `running_course_id` (`running_course_id`);

--
-- Indexes for table `page_first_visit`
--
ALTER TABLE `page_first_visit`
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `periodic_tasks`
--
ALTER TABLE `periodic_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `placement_tests`
--
ALTER TABLE `placement_tests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `placement_tests_ibfk_1` (`track_id`);

--
-- Indexes for table `placement_test_answers`
--
ALTER TABLE `placement_test_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `placement_test_process_id` (`placement_test_process_id`),
  ADD KEY `placement_test_question_id` (`placement_test_question_id`);

--
-- Indexes for table `placement_test_levels`
--
ALTER TABLE `placement_test_levels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `placement_test_levels_ibfk_3` (`track_id`);

--
-- Indexes for table `placement_test_processes`
--
ALTER TABLE `placement_test_processes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `track_id` (`track_id`);

--
-- Indexes for table `placement_test_questions`
--
ALTER TABLE `placement_test_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `track_id` (`track_id`);

--
-- Indexes for table `prospective_customers`
--
ALTER TABLE `prospective_customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `tel` (`tel`),
  ADD KEY `specialization_id` (`specialization_id`);

--
-- Indexes for table `related_courses`
--
ALTER TABLE `related_courses`
  ADD KEY `course_id` (`course_id`),
  ADD KEY `related_course_id` (`related_course_id`);

--
-- Indexes for table `related_workshops`
--
ALTER TABLE `related_workshops`
  ADD KEY `workshop_id_ipj` (`related_workshop_id`),
  ADD KEY `workshop_id_ipm` (`workshop_id`);

--
-- Indexes for table `remote_locations`
--
ALTER TABLE `remote_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `remote_location_rooms`
--
ALTER TABLE `remote_location_rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `remote_location_id` (`remote_location_id`);

--
-- Indexes for table `remote_location_room_devices`
--
ALTER TABLE `remote_location_room_devices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `remote_location_room_id` (`remote_location_room_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `running_courses`
--
ALTER TABLE `running_courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trainer_id` (`trainer_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `live_participation_type_id` (`live_participation_type_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `running_course_remote_locations`
--
ALTER TABLE `running_course_remote_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_course_id` (`running_course_id`),
  ADD KEY `remote_location_id` (`remote_location_id`);

--
-- Indexes for table `running_workshops`
--
ALTER TABLE `running_workshops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trainer_id` (`trainer_id`),
  ADD KEY `workshop_id` (`workshop_id`),
  ADD KEY `live_participation_type_id` (`live_participation_type_id`);

--
-- Indexes for table `running_workshop_remote_locations`
--
ALTER TABLE `running_workshop_remote_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `remote_location_id_poi` (`remote_location_id`),
  ADD KEY `running_workshop_id_klop` (`running_workshop_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client` (`client`),
  ADD KEY `location` (`country`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `specializations`
--
ALTER TABLE `specializations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `sub_tasks`
--
ALTER TABLE `sub_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_user_id_pop` (`admin_user_id`),
  ADD KEY `perodic_task_id` (`perodic_task_id`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `topic_chats`
--
ALTER TABLE `topic_chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topic_id` (`topic_id`);

--
-- Indexes for table `topic_chat_images`
--
ALTER TABLE `topic_chat_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topiChat_id` (`topiChat_id`);

--
-- Indexes for table `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `smart_user_id` (`smart_user_id`),
  ADD KEY `specialization_id` (`specialization_id`),
  ADD KEY `user_creation_source_id_ucs` (`user_creation_source_id`);

--
-- Indexes for table `user_creation_sources`
--
ALTER TABLE `user_creation_sources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `video_cues`
--
ALTER TABLE `video_cues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `video_path_id` (`video_path_id`);

--
-- Indexes for table `video_cues_watch`
--
ALTER TABLE `video_cues_watch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_reg_id` (`course_reg_id`),
  ADD KEY `video_cue_id` (`video_cue_id`);

--
-- Indexes for table `video_folders`
--
ALTER TABLE `video_folders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `video_pathes`
--
ALTER TABLE `video_pathes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_video_id` (`course_video_id`),
  ADD KEY `video_folder_id_vfi` (`video_folder_id`);

--
-- Indexes for table `whatsapp_black_list`
--
ALTER TABLE `whatsapp_black_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `whatsapp_groups`
--
ALTER TABLE `whatsapp_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `whatsapp_members`
--
ALTER TABLE `whatsapp_members`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `whatsapp_perodic_message`
--
ALTER TABLE `whatsapp_perodic_message`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workshops`
--
ALTER TABLE `workshops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `name_ar` (`name_ar`);

--
-- Indexes for table `workshops_reg`
--
ALTER TABLE `workshops_reg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id_opp` (`student_id`),
  ADD KEY `ref_id_ipk` (`ref_id`),
  ADD KEY `running_workshop_id_ikf` (`running_workshop_id`);

--
-- Indexes for table `workshops_specializations`
--
ALTER TABLE `workshops_specializations`
  ADD KEY `workshop_id` (`workshop_id`),
  ADD KEY `specialization_id` (`specialization_id`);

--
-- Indexes for table `workshop_chats`
--
ALTER TABLE `workshop_chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_workshop_id` (`running_workshop_id`),
  ADD KEY `workshop_reg_id` (`workshop_reg_id`);

--
-- Indexes for table `workshop_cues`
--
ALTER TABLE `workshop_cues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `running_workshop_id` (`running_workshop_id`);

--
-- Indexes for table `workshop_cues_watch`
--
ALTER TABLE `workshop_cues_watch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workshop_cue_id` (`workshop_cue_id`),
  ADD KEY `workshop_reg_id` (`workshop_reg_id`);

--
-- Indexes for table `workshop_types`
--
ALTER TABLE `workshop_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workshop_views`
--
ALTER TABLE `workshop_views`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `running_workshop_id` (`running_workshop_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounting`
--
ALTER TABLE `accounting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `accounting_accounts`
--
ALTER TABLE `accounting_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `accounting_types`
--
ALTER TABLE `accounting_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `acounts_warehouses`
--
ALTER TABLE `acounts_warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ads`
--
ALTER TABLE `ads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ads_types`
--
ALTER TABLE `ads_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ads_views`
--
ALTER TABLE `ads_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `atc_config`
--
ALTER TABLE `atc_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blogs_comments`
--
ALTER TABLE `blogs_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blogs_comments_replies`
--
ALTER TABLE `blogs_comments_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blogs_subscribers`
--
ALTER TABLE `blogs_subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_departments`
--
ALTER TABLE `blog_departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_images`
--
ALTER TABLE `blog_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `book_departments`
--
ALTER TABLE `book_departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `book_downloads`
--
ALTER TABLE `book_downloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `book_views`
--
ALTER TABLE `book_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificate_prints`
--
ALTER TABLE `certificate_prints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificate_types`
--
ALTER TABLE `certificate_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_us`
--
ALTER TABLE `contact_us`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_attendance`
--
ALTER TABLE `courses_attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_chats`
--
ALTER TABLE `courses_chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_exams`
--
ALTER TABLE `courses_exams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_exams_answers`
--
ALTER TABLE `courses_exams_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_exams_check`
--
ALTER TABLE `courses_exams_check`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_exams_questions`
--
ALTER TABLE `courses_exams_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_fourm_questions`
--
ALTER TABLE `courses_fourm_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_lectures`
--
ALTER TABLE `courses_lectures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_materials`
--
ALTER TABLE `courses_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_old_projects`
--
ALTER TABLE `courses_old_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_projects`
--
ALTER TABLE `courses_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_projects_uploads`
--
ALTER TABLE `courses_projects_uploads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_reg`
--
ALTER TABLE `courses_reg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_trainers`
--
ALTER TABLE `courses_trainers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses_videos`
--
ALTER TABLE `courses_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_lecture_videos`
--
ALTER TABLE `course_lecture_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_types`
--
ALTER TABLE `course_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_leads`
--
ALTER TABLE `crm_leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_lead_social_profiles`
--
ALTER TABLE `crm_lead_social_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_logs`
--
ALTER TABLE `crm_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_platforms`
--
ALTER TABLE `crm_platforms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_sales_ticket_levels`
--
ALTER TABLE `crm_sales_ticket_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_service_types`
--
ALTER TABLE `crm_service_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discussion`
--
ALTER TABLE `discussion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discussion_comments`
--
ALTER TABLE `discussion_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discussion_images`
--
ALTER TABLE `discussion_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `e_library`
--
ALTER TABLE `e_library`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `given_points`
--
ALTER TABLE `given_points`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `live_lectures_cues`
--
ALTER TABLE `live_lectures_cues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `live_lecture_cues_watch`
--
ALTER TABLE `live_lecture_cues_watch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `live_participation_types`
--
ALTER TABLE `live_participation_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `message_templates`
--
ALTER TABLE `message_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `periodic_tasks`
--
ALTER TABLE `periodic_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `placement_tests`
--
ALTER TABLE `placement_tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `placement_test_answers`
--
ALTER TABLE `placement_test_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `placement_test_levels`
--
ALTER TABLE `placement_test_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `placement_test_processes`
--
ALTER TABLE `placement_test_processes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `placement_test_questions`
--
ALTER TABLE `placement_test_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prospective_customers`
--
ALTER TABLE `prospective_customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `remote_locations`
--
ALTER TABLE `remote_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `remote_location_rooms`
--
ALTER TABLE `remote_location_rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `remote_location_room_devices`
--
ALTER TABLE `remote_location_room_devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `running_courses`
--
ALTER TABLE `running_courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `running_course_remote_locations`
--
ALTER TABLE `running_course_remote_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `running_workshops`
--
ALTER TABLE `running_workshops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `running_workshop_remote_locations`
--
ALTER TABLE `running_workshop_remote_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `specializations`
--
ALTER TABLE `specializations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_tasks`
--
ALTER TABLE `sub_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `topic_chats`
--
ALTER TABLE `topic_chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `topic_chat_images`
--
ALTER TABLE `topic_chat_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tracks`
--
ALTER TABLE `tracks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_creation_sources`
--
ALTER TABLE `user_creation_sources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video_cues`
--
ALTER TABLE `video_cues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video_cues_watch`
--
ALTER TABLE `video_cues_watch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video_folders`
--
ALTER TABLE `video_folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video_pathes`
--
ALTER TABLE `video_pathes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whatsapp_black_list`
--
ALTER TABLE `whatsapp_black_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whatsapp_groups`
--
ALTER TABLE `whatsapp_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whatsapp_members`
--
ALTER TABLE `whatsapp_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whatsapp_perodic_message`
--
ALTER TABLE `whatsapp_perodic_message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workshops`
--
ALTER TABLE `workshops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workshops_reg`
--
ALTER TABLE `workshops_reg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workshop_chats`
--
ALTER TABLE `workshop_chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workshop_cues`
--
ALTER TABLE `workshop_cues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workshop_cues_watch`
--
ALTER TABLE `workshop_cues_watch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workshop_types`
--
ALTER TABLE `workshop_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- Constraints for table `crm_tickets`
--
ALTER TABLE `crm_tickets`
  ADD CONSTRAINT `fk_ticket_sales_level` FOREIGN KEY (`sales_level_id`) REFERENCES `crm_sales_ticket_levels` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `crm_ticket_messages`
--
ALTER TABLE `crm_ticket_messages`
  ADD CONSTRAINT `fk_msg_platform` FOREIGN KEY (`platform_id`) REFERENCES `crm_platforms` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `crm_ticket_timers`
--
ALTER TABLE `crm_ticket_timers`
  ADD CONSTRAINT `fk_timer_ticket` FOREIGN KEY (`crm_ticket_id`) REFERENCES `crm_tickets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `placement_tests`
--
ALTER TABLE `placement_tests`
  ADD CONSTRAINT `placement_tests_ibfk_1` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
