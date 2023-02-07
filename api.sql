-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.19 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5958
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for api
CREATE DATABASE IF NOT EXISTS `api` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `api`;

-- Dumping structure for table api.company
CREATE TABLE IF NOT EXISTS `company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `director_name` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `email` varchar(50) NOT NULL DEFAULT '0',
  `website` varchar(50) NOT NULL DEFAULT '0',
  `phone_number` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table api.company: ~3 rows (approximately)
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`id`, `company_name`, `director_name`, `address`, `email`, `website`, `phone_number`) VALUES
	(1, 'merit', 'Sherzod Qurbonov', 'Qoratosh, 11', 'dhfrfs', 'merit.uz', '+998977006043'),
	(2, 'BTS', 'Kamron Qurbonov', 'Qoratosh 12', 'bts@gmail.com', 'bts.uz', '+998977722006'),
	(3, 'Cargo', 'Shahzod Qurbonov', 'Samarqand,Nurobod', 'cargosam@gmail.com', 'cargosam.uz', '+998979269226');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;

-- Dumping structure for table api.employee
CREATE TABLE IF NOT EXISTS `employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `passport_No` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `company_id` (`company_id`),
  CONSTRAINT `FK_employee_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table api.employee: ~5 rows (approximately)
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`id`, `company_id`, `passport_No`, `first_name`, `last_name`, `middle_name`, `position`, `phone_number`, `address`) VALUES
	(1, 2, 'AA5554466', 'Kamronbek', 'Qurbonov', 'Murodulla o`g`li ', 'dasturchi', '+998900000000', 'sajdvchbi, 524st'),
	(2, 1, 'AB4455455', 'Sherzod', 'Qurbonov', 'Murodulla o`g`li', 'dasturchi', '+998977722006', 'Feruza 3, 51A'),
	(5, 3, 'AB76586788', 'Raimov', 'Aziz', 'Aziz o`g`li', 'sotuvchi', '+9989004637724', 'Mirzo Ulug`bek st'),
	(6, 2, 'AB0000000', 'Tursunov', 'Laziz', 'Temur o`g`li', 'buxgalter', '+9989034574', 'To`ytepa, 524st'),
	(7, 1, 'AB0000786', 'Rustamov', 'Aziz', 'Nozim o`g`li', 'hr xodimi', '+99895465476543', 'Samarqand, 524st');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;

-- Dumping structure for table api.migration
CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apply_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table api.migration: ~2 rows (approximately)
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` (`version`, `apply_time`) VALUES
	('m000000_000000_base', 1664630507),
	('m130524_201442_init', 1664630509),
	('m190124_110200_add_verification_token_column_to_user_table', 1664630510);
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;

-- Dumping structure for table api.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint NOT NULL DEFAULT '10',
  `created_at` int NOT NULL,
  `updated_at` int NOT NULL,
  `verification_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `access_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `FK_user_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table api.user: ~4 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `status`, `created_at`, `updated_at`, `verification_token`, `access_token`, `role`, `company_id`) VALUES
	(3, 'admin', '7kH2oo-llCd5cyT-tCSb8DCMEm3YYxu_', '$2y$13$R5TnxOBvtK1JAm6Ljg0RA.H4ct.2AH4yAw1Ge/8Q8VQxcJswgzKm2', NULL, 'admin@gmail.com', 10, 1664891405, 1675767057, 'BtFBgt-xhPFytS2Qwdi8ft7nwFj4YXo0_1664891405', '9xNk9SL_SKBMZNa0tqMJFm3gl7T1QSuk', 'admin', NULL),
	(5, 'merit', 'JE14SmWGTqcpjwTCZPp0-eE0zWe1tUtb', '$2y$13$3kR5YpMTkgHKiwZwMR6zneKaQ1d7prljBF5qqtfCmKHz6ul1D2FKy', NULL, 'merit@gmail.com', 10, 1664908301, 1665394003, 'XIL196OgHlj0GmLCr5d18LwJmR4uR1Vp_1664908301', '3bGWRt-0e-pBOZ2lmM27HxNBDPvuYSTR', 'company', 1),
	(6, 'bts', 'UlasLheyEnL0vYLK_0YH0KwQou-W0gkb', '$2y$13$OMFBn4S0531axQBfWmQoCeKtadjo5VtoF.50JyVXiRgQ7i8kVXJzC', NULL, 'bts@gmail.com', 10, 1664908946, 1664908946, 'dPOVZEfA42WswbwIrNJPTeoTl0mI7Wxr_1664908946', NULL, 'company', 2),
	(7, 'cargo', 'vR1qQTe5-lpVq3SxzftpybIegEc6ju2C', '$2y$13$9aaenqTJHBLI2OU0X4yYnO3gmNCkVRDMV8/DSv1FAHBpT5my6YU56', NULL, 'cargo@gmail.com', 10, 1664908988, 1664910682, 'oun2nd50E4syYAVMdQB6Cn9Gz7siXH8q_1664908988', 'w91f_m6ceOPgoIzl3sGAkMfhP0AzC4g-', 'company', 3);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
