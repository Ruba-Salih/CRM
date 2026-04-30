-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 12, 2026 at 09:43 AM
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
-- Database: `test4_atc`
--

-- --------------------------------------------------------

--
-- Table structure for table `ibok_transactions`
--

DROP TABLE IF EXISTS `ibok_transactions`;
CREATE TABLE IF NOT EXISTS `ibok_transactions` (
  `id` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `remarks` mediumtext,
  `transfer_ref` varchar(50) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT NULL,
  `type` enum('DR','CR') NOT NULL DEFAULT 'DR',
  `used_before` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transfer_ref` (`transfer_ref`),
  KEY `transfer_ref_2` (`transfer_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ibok_transactions`
--

INSERT INTO `ibok_transactions` (`id`, `date`, `remarks`, `transfer_ref`, `amount`, `balance`, `type`, `used_before`, `created_at`) VALUES
('', '2025-04-14', NULL, '20024574213', '18000.00', NULL, 'CR', 0, '2025-05-10 06:54:53'),
('2', '2025-04-15', NULL, '1016561871', '6000.00', NULL, 'CR', 0, '2025-04-15 11:34:22'),
('22315', '2025-04-08', NULL, '20058124254', '18000.00', NULL, 'CR', 0, '2025-05-10 08:04:22'),
('23324', '2025-04-09', NULL, '20037058355', '70000.00', NULL, 'CR', 0, '2025-05-11 11:25:04'),
('235', '2025-04-15', NULL, '20016550468', '38000.00', NULL, 'CR', 0, '2025-04-15 11:34:22'),
('2356', '2025-04-02', NULL, '20014181174', '18000.00', NULL, 'CR', 0, '2025-05-10 09:19:00'),
('2425', '2025-04-30', NULL, '20194793107', '18000.00', NULL, 'CR', 0, '2025-04-30 10:22:40'),
('32422', '2025-04-10', NULL, '20021552780', '30000.00', NULL, 'CR', 0, '2025-04-15 11:34:22'),
('3256376', '2025-04-16', NULL, '20008947701', '18000.00', NULL, 'CR', 0, '2025-05-10 07:09:50'),
('34532', '2025-04-17', NULL, '20036985300', '9000.00', NULL, 'CR', 0, '2025-04-30 10:52:40'),
('42543532', '2025-04-14', NULL, '20016154913', '18000.00', NULL, 'CR', 0, '2025-04-29 15:04:23'),
('432423664', '2025-04-16', NULL, '20012983519', '72000.00', NULL, 'CR', 0, '2025-04-30 09:16:43'),
('43525', '2025-04-10', NULL, '20008961674', '15000.00', NULL, 'CR', 0, '2025-04-15 11:34:22'),
('4553453', '2025-04-15', NULL, '20190882018', '18000.00', NULL, 'CR', 0, '2025-05-10 12:37:09'),
('535256', '2025-04-12', NULL, '20191194082', '130000.00', NULL, 'CR', 0, '2025-04-29 16:23:03'),
('7466836', '2025-04-15', NULL, '20009348601', '18000.00', NULL, 'CR', 0, '2025-04-30 10:38:05');

-- --------------------------------------------------------

--
-- Table structure for table `mbok_deposit_requests`
--

DROP TABLE IF EXISTS `mbok_deposit_requests`;
CREATE TABLE IF NOT EXISTS `mbok_deposit_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `payment_id` varchar(255) NOT NULL,
  `value` decimal(20,3) NOT NULL DEFAULT '0.000',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `accounting_inserted` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `payment_id` (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mbok_deposit_requests`
--

INSERT INTO `mbok_deposit_requests` (`id`, `user_id`, `payment_id`, `value`, `status`, `accounting_inserted`, `created`, `updated`) VALUES
(3, 18, '20009348601', '18000.000', 1, 1, '2025-05-09 13:03:25', '2025-05-09 13:23:20'),
(4, 19, '20016550468', '38000.000', 1, 1, '2025-05-09 13:03:25', '2025-05-11 11:23:17'),
(7, 18, '20037058355', '0.000', 1, 1, '2025-05-11 11:17:25', '2025-05-11 11:25:09');

-- --------------------------------------------------------

--
-- Table structure for table `mbok_withdrawl_requests`
--

DROP TABLE IF EXISTS `mbok_withdrawl_requests`;
CREATE TABLE IF NOT EXISTS `mbok_withdrawl_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `accounting_inserted` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mbok_withdrawl_requests`
--

INSERT INTO `mbok_withdrawl_requests` (`id`, `user_id`, `value`, `status`, `accounting_inserted`, `created`, `updated`) VALUES
(1, 11, '60000.00', 1, 1, '2025-05-04 07:57:49', '2025-05-04 14:13:02'),
(2, 4, '100.00', 0, 1, '2025-05-04 07:57:49', '2026-01-29 12:50:29'),
(3, 18, '100.00', 1, 1, '2025-05-04 07:57:49', '2025-05-04 14:29:28'),
(4, 18, '50000.00', 1, 1, '2025-05-11 11:32:18', '2025-05-11 11:34:10');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mbok_deposit_requests`
--
ALTER TABLE `mbok_deposit_requests`
  ADD CONSTRAINT `mbok_deposit_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `mbok_withdrawl_requests`
--
ALTER TABLE `mbok_withdrawl_requests`
  ADD CONSTRAINT `mbok_withdrawl_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
