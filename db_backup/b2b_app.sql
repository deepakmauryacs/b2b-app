-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 23, 2025 at 11:12 AM
-- Server version: 5.7.40
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `b2b_app`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `categories`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `categories` ()   BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000000 DO
        INSERT INTO categories (name, slug, parent_id, status, created_at, updated_at)
        VALUES (
            CONCAT('Category ', i),
            CONCAT('category-', i),
            IF(i % 10 = 0, NULL, FLOOR(1 + RAND() * 100)),  -- Random parent_id or NULL
            IF(i % 2 = 0, 1, 0),  -- Alternating status
            NOW(),
            NOW()
        );
        SET i = i + 1;
    END WHILE;
END$$

DROP PROCEDURE IF EXISTS `InsertDummyCategories`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDummyCategories` (IN `num_records` INT)   BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE parent_id_val INT;
    DECLARE category_name VARCHAR(255);
    DECLARE category_slug VARCHAR(255);
    
    WHILE i < num_records DO
        -- Random parent_id (about 20% will have parents)
        SET parent_id_val = CASE WHEN RAND() < 0.2 THEN FLOOR(1 + RAND() * i) ELSE NULL END;
        
        -- Generate category name
        SET category_name = CONCAT('Category ', i+1);
        
        -- Generate slug
        SET category_slug = CONCAT('category-', i+1);
        
        -- Insert record
        INSERT INTO `categories` (`name`, `slug`, `parent_id`, `status`, `created_at`, `updated_at`)
        VALUES (
            category_name,
            category_slug,
            parent_id_val,
            1,
            NOW() - INTERVAL FLOOR(RAND() * 365) DAY,
            NOW() - INTERVAL FLOOR(RAND() * 30) DAY
        );
        
        SET i = i + 1;
        
        -- Commit every 1000 records to improve performance
        IF i % 1000 = 0 THEN
            COMMIT;
        END IF;
    END WHILE;
END$$

DROP PROCEDURE IF EXISTS `InsertDummyProducts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDummyProducts` (IN `num_records` INT)   BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE v_vendor_id INT UNSIGNED;
    DECLARE v_category_id INT UNSIGNED;
    DECLARE v_sub_category_id INT UNSIGNED;
    DECLARE v_product_name VARCHAR(255);
    DECLARE v_slug VARCHAR(255);
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_status ENUM('pending','approved','rejected');
    
    -- Disable unique checks and autocommit for faster inserts
    SET unique_checks = 0;
    SET autocommit = 0;

    WHILE i < num_records DO
        SET v_vendor_id = FLOOR(1 + RAND() * 1000); -- Dummy vendors (1 to 1000)
        SET v_category_id = FLOOR(1 + RAND() * 100); -- Dummy categories (1 to 100)
        SET v_sub_category_id = FLOOR(1 + RAND() * 500); -- Dummy sub-categories (1 to 500)
        SET v_product_name = CONCAT('Product ', i);
        SET v_slug = CONCAT('product-', i, '-', LPAD(FLOOR(RAND() * 10000), 4, '0')); -- Add random suffix to ensure uniqueness
        SET v_price = ROUND(10.00 + (RAND() * 990.00), 2); -- Price between 10.00 and 1000.00
        SET v_status = ELT(FLOOR(1 + RAND() * 3), 'pending', 'approved', 'rejected');

        INSERT INTO `products` (
            `vendor_id`, `category_id`, `sub_category_id`, `product_name`, 
            `product_image`, `slug`, `description`, `price`, `unit`, 
            `min_order_qty`, `stock_quantity`, `hsn_code`, `gst_rate`, `status`
        ) VALUES (
            v_vendor_id, v_category_id, v_sub_category_id, v_product_name, 
            NULL, v_slug, 'This is a dummy product description for testing purposes.', 
            v_price, 'pcs', 1, FLOOR(RAND() * 1000), NULL, 18, v_status
        );

        SET i = i + 1;
        
        -- Commit in batches to avoid huge transaction logs and memory issues
        IF (i % 50000 = 0) THEN -- Commit every 50,000 records
            COMMIT;
        END IF;
    END WHILE;
    
    COMMIT; -- Commit any remaining records
    
    SET unique_checks = 1;
    SET autocommit = 1;

END$$

DROP PROCEDURE IF EXISTS `insert_categories_demo_data`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_categories_demo_data` ()   BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000000 DO
        INSERT INTO categories (name, slug, parent_id, status, created_at, updated_at)
        VALUES (
            CONCAT('Category ', i),
            CONCAT('category-', i),
            IF(i % 10 = 0, NULL, FLOOR(1 + RAND() * 100)),  -- Random parent_id or NULL
            IF(i % 2 = 0, 1, 0),  -- Alternating status
            NOW(),
            NOW()
        );
        SET i = i + 1;
    END WHILE;
END$$

DROP PROCEDURE IF EXISTS `insert_dummy_vendors`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_dummy_vendors` ()   BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 250000 DO
        INSERT INTO users (parent_id, name, email, phone, role, password, status, is_profile_verified, created_at, updated_at)
        VALUES (
            NULL,
            CONCAT('Vendor_', i),
            CONCAT('vendor_', i, '@example.com'),
            CONCAT('900000000', LPAD(i % 10, 1, '0')),
            'vendor',
            '$2y$10$dummyhashforpassword1234567890', -- use Laravel hashed dummy password
            '1',
            '1',
            NOW(),
            NOW()
        );
        
        INSERT INTO vendor_profiles (user_id, store_name, email, phone, country, state, city, pincode, address, gst_no, gst_doc, store_logo, accept_terms, created_at, updated_at)
        VALUES (
            LAST_INSERT_ID(),
            CONCAT('Store_', i),
            CONCAT('vendor_', i, '@example.com'),
            CONCAT('900000000', LPAD(i % 10, 1, '0')),
            'India',
            'Uttar Pradesh',
            'Varanasi',
            '221001',
            'Some address here',
            CONCAT('GSTIN', LPAD(i, 10, '0')),
            NULL,
            NULL,
            1,
            NOW(),
            NOW()
        );
        
        SET i = i + 1;
    END WHILE;
END$$

DROP PROCEDURE IF EXISTS `insert_if_unique_product`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_if_unique_product` (IN `p_product_name` VARCHAR(200), IN `p_category_id` INT, IN `p_sub_category_id` INT, IN `p_slug` TEXT, IN `p_description` TEXT, IN `p_hsn_code` VARCHAR(255), IN `p_gst_rate` TINYINT)   BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM unique_products WHERE product_name = p_product_name
    ) THEN
        INSERT INTO unique_products (
            product_name,
            category_id,
            sub_category_id,
            slug,
            description,
            hsn_code,
            gst_rate
        )
        VALUES (
            p_product_name,
            p_category_id,
            p_sub_category_id,
            p_slug,
            p_description,
            p_hsn_code,
            p_gst_rate
        );
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) DEFAULT NULL,
  `causer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `batch_uuid` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `causer` (`causer_type`,`causer_id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1, 'default', 'updated', 'App\\Models\\Product', 'updated', 11, 'App\\Models\\User', 1, '{\"old\": {\"status\": \"pending\"}, \"attributes\": {\"status\": \"approved\"}}', NULL, '2025-06-14 16:35:46', '2025-06-14 16:35:46'),
(2, 'default', 'updated', 'App\\Models\\Category', 'updated', 69, 'App\\Models\\User', 1, '{\"old\": {\"status\": 1}, \"attributes\": {\"status\": 0}}', NULL, '2025-06-14 16:43:50', '2025-06-14 16:43:50'),
(3, 'default', 'created', 'App\\Models\\Category', 'created', 1000074, 'App\\Models\\User', 1, '{\"attributes\": {\"name\": \"DEEPAK MAURYA\", \"slug\": \"deepak-maurya\", \"status\": 1, \"parent_id\": 0}}', NULL, '2025-06-14 16:45:11', '2025-06-14 16:45:11'),
(4, 'default', 'updated', 'App\\Models\\Product', 'updated', 14, 'App\\Models\\User', 1, '{\"old\": {\"status\": \"pending\"}, \"attributes\": {\"status\": \"rejected\"}}', NULL, '2025-06-14 17:18:46', '2025-06-14 17:18:46'),
(5, 'default', 'updated', 'App\\Models\\Product', 'updated', 13, 'App\\Models\\User', 1, '{\"old\": {\"status\": \"pending\"}, \"attributes\": {\"status\": \"rejected\"}}', NULL, '2025-06-14 17:56:06', '2025-06-14 17:56:06'),
(6, 'default', 'updated', 'App\\Models\\Product', 'updated', 6, 'App\\Models\\User', 1, '{\"old\": {\"status\": \"pending\"}, \"attributes\": {\"status\": \"rejected\"}}', NULL, '2025-06-14 18:14:46', '2025-06-14 18:14:46'),
(7, 'default', 'updated', 'App\\Models\\Product', 'updated', 13, 'App\\Models\\User', 1, '{\"old\": {\"status\": \"rejected\"}, \"attributes\": {\"status\": \"pending\"}}', NULL, '2025-06-14 18:22:25', '2025-06-14 18:22:25'),
(8, 'default', 'updated', 'App\\Models\\Product', 'updated', 22, 'App\\Models\\User', 1, '{\"old\": {\"status\": \"approved\"}, \"attributes\": {\"status\": \"pending\"}}', NULL, '2025-06-14 18:22:51', '2025-06-14 18:22:51'),
(9, 'default', 'updated', 'App\\Models\\Product', 'updated', 22, 'App\\Models\\User', 1, '{\"old\": {\"status\": \"pending\"}, \"attributes\": {\"status\": \"rejected\"}}', NULL, '2025-06-14 18:23:00', '2025-06-14 18:23:00'),
(10, 'default', 'updated', 'App\\Models\\Product', 'updated', 21, 'App\\Models\\User', 1, '{\"old\": {\"status\": \"approved\"}, \"attributes\": {\"status\": \"pending\"}}', NULL, '2025-06-14 18:25:27', '2025-06-14 18:25:27'),
(11, 'default', 'updated', 'App\\Models\\Product', 'updated', 21, 'App\\Models\\User', 1, '{\"old\": {\"status\": \"pending\"}, \"attributes\": {\"status\": \"approved\"}}', NULL, '2025-06-14 18:25:56', '2025-06-14 18:25:56'),
(12, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"1\"}, \"attributes\": {\"is_profile_verified\": \"2\"}}', NULL, '2025-06-14 21:40:35', '2025-06-14 21:40:35'),
(13, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"2\"}, \"attributes\": {\"is_profile_verified\": \"1\"}}', NULL, '2025-06-14 21:40:36', '2025-06-14 21:40:36'),
(14, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"1\"}, \"attributes\": {\"is_profile_verified\": \"2\"}}', NULL, '2025-06-14 21:54:47', '2025-06-14 21:54:47'),
(15, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"2\"}, \"attributes\": {\"is_profile_verified\": \"1\"}}', NULL, '2025-06-14 21:55:01', '2025-06-14 21:55:01'),
(16, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"1\"}, \"attributes\": {\"is_profile_verified\": \"2\"}}', NULL, '2025-06-14 21:56:55', '2025-06-14 21:56:55'),
(17, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"2\"}, \"attributes\": {\"is_profile_verified\": \"1\"}}', NULL, '2025-06-14 21:56:55', '2025-06-14 21:56:55'),
(18, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"1\"}, \"attributes\": {\"is_profile_verified\": \"2\"}}', NULL, '2025-06-14 22:30:21', '2025-06-14 22:30:21'),
(19, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"2\"}, \"attributes\": {\"is_profile_verified\": \"1\"}}', NULL, '2025-06-14 22:35:33', '2025-06-14 22:35:33'),
(20, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"1\"}, \"attributes\": {\"is_profile_verified\": \"2\"}}', NULL, '2025-06-14 22:35:39', '2025-06-14 22:35:39'),
(21, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"2\"}, \"attributes\": {\"is_profile_verified\": \"1\"}}', NULL, '2025-06-14 22:35:42', '2025-06-14 22:35:42'),
(22, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"1\"}, \"attributes\": {\"is_profile_verified\": \"2\"}}', NULL, '2025-06-14 22:50:10', '2025-06-14 22:50:10'),
(23, 'default', 'updated', 'App\\Models\\User', 'updated', 2, 'App\\Models\\User', 1, '{\"old\": {\"is_profile_verified\": \"2\"}, \"attributes\": {\"is_profile_verified\": \"1\"}}', NULL, '2025-06-14 22:50:12', '2025-06-14 22:50:12'),
(24, 'default', 'created', 'App\\Models\\Banner', 'created', 1, 'App\\Models\\User', 1, '{\"attributes\": {\"status\": 1, \"banner_img\": \"uploads/banners/k5e5bi86rSA4VNvBkBJegZgrWENEluyEyyrbw7WE.png\", \"banner_link\": \"https://www.flipkart.com\", \"banner_type\": 1, \"banner_end_date\": \"2024-07-06\", \"banner_start_date\": \"2021-07-06\"}}', NULL, '2025-07-04 12:53:40', '2025-07-04 12:53:40'),
(25, 'default', 'updated', 'App\\Models\\Banner', 'updated', 1, 'App\\Models\\User', 1, '{\"old\": {\"banner_img\": \"uploads/banners/k5e5bi86rSA4VNvBkBJegZgrWENEluyEyyrbw7WE.png\", \"banner_end_date\": \"2024-07-06\", \"banner_start_date\": \"2021-07-06\"}, \"attributes\": {\"banner_img\": \"uploads/banners/1nGRbT9dRWvC7xPuVw0jLomgrF75sK8I9B7OnTDv.png\", \"banner_end_date\": null, \"banner_start_date\": null}}', NULL, '2025-07-07 00:04:38', '2025-07-07 00:04:38'),
(26, 'default', 'updated', 'App\\Models\\Banner', 'updated', 1, 'App\\Models\\User', 1, '{\"old\": {\"banner_img\": \"uploads/banners/1nGRbT9dRWvC7xPuVw0jLomgrF75sK8I9B7OnTDv.png\"}, \"attributes\": {\"banner_img\": \"uploads/banners/kOWPMd6Ni0Gwq0yCTrx6zzRTnrbo8oQE9X3KsnJf.png\"}}', NULL, '2025-07-07 00:08:23', '2025-07-07 00:08:23'),
(27, 'default', 'updated', 'App\\Models\\Banner', 'updated', 1, 'App\\Models\\User', 1, '{\"old\": {\"banner_img\": \"uploads/banners/kOWPMd6Ni0Gwq0yCTrx6zzRTnrbo8oQE9X3KsnJf.png\"}, \"attributes\": {\"banner_img\": \"uploads/banners/Bi1IH3slzj18OAG2zVPwQIWJgf9YMzWHRb3aQBMw.png\"}}', NULL, '2025-07-07 00:09:27', '2025-07-07 00:09:27'),
(28, 'default', 'updated', 'App\\Models\\Banner', 'updated', 1, 'App\\Models\\User', 1, '{\"old\": {\"banner_img\": \"uploads/banners/Bi1IH3slzj18OAG2zVPwQIWJgf9YMzWHRb3aQBMw.png\"}, \"attributes\": {\"banner_img\": \"uploads/banners/1751866964_poco.png\"}}', NULL, '2025-07-07 00:12:44', '2025-07-07 00:12:44'),
(29, 'default', 'updated', 'App\\Models\\Banner', 'updated', 1, 'App\\Models\\User', 1, '{\"old\": {\"banner_end_date\": null, \"banner_start_date\": null}, \"attributes\": {\"banner_end_date\": \"2025-07-31\", \"banner_start_date\": \"2025-07-07\"}}', NULL, '2025-07-07 00:27:12', '2025-07-07 00:27:12'),
(30, 'default', 'updated', 'App\\Models\\Banner', 'updated', 1, 'App\\Models\\User', 1, '{\"old\": {\"status\": 1, \"banner_end_date\": \"2025-07-31\", \"banner_start_date\": \"2025-07-07\"}, \"attributes\": {\"status\": 2, \"banner_end_date\": null, \"banner_start_date\": null}}', NULL, '2025-07-07 00:28:41', '2025-07-07 00:28:41'),
(31, 'default', 'updated', 'App\\Models\\Banner', 'updated', 1, 'App\\Models\\User', 1, '{\"old\": {\"banner_end_date\": null, \"banner_start_date\": null}, \"attributes\": {\"banner_end_date\": \"2025-07-31\", \"banner_start_date\": \"2025-07-07\"}}', NULL, '2025-07-07 00:30:46', '2025-07-07 00:30:46'),
(32, 'default', 'updated', 'App\\Models\\Banner', 'updated', 1, 'App\\Models\\User', 1, '{\"old\": {\"status\": 2}, \"attributes\": {\"status\": 1}}', NULL, '2025-07-07 00:31:07', '2025-07-07 00:31:07'),
(33, 'default', 'updated', 'App\\Models\\Banner', 'updated', 1, 'App\\Models\\User', 1, '{\"old\": {\"banner_end_date\": \"2025-07-31\"}, \"attributes\": {\"banner_end_date\": \"2030-07-12\"}}', NULL, '2025-07-07 08:00:27', '2025-07-07 08:00:27');

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
CREATE TABLE IF NOT EXISTS `banners` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `banner_img` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_start_date` date DEFAULT NULL,
  `banner_end_date` date DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `banner_type` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `banner_img`, `banner_link`, `banner_start_date`, `banner_end_date`, `status`, `banner_type`, `created_at`, `updated_at`) VALUES
(1, 'uploads/banners/1751866964_poco.png', 'https://www.flipkart.com', '2025-07-07', '2030-07-12', 1, 1, '2025-07-04 12:53:40', '2025-07-07 08:00:27');

-- --------------------------------------------------------

--
-- Table structure for table `buyer_profiles`
--

DROP TABLE IF EXISTS `buyer_profiles`;
CREATE TABLE IF NOT EXISTS `buyer_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `store_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `pincode` varchar(20) DEFAULT NULL,
  `address` text,
  `gst_no` varchar(50) DEFAULT NULL,
  `gst_doc` text,
  `store_logo` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `buyer_profiles`
--

INSERT INTO `buyer_profiles` (`id`, `user_id`, `store_name`, `email`, `phone`, `country`, `state`, `city`, `pincode`, `address`, `gst_no`, `gst_doc`, `store_logo`, `created_at`, `updated_at`) VALUES
(1, 3, 'Dev', NULL, NULL, 'India', 'Delhi', 'New Delhi', '110093', '571, Street Number 6, Chanderlok, Shahdara, Delhi, 110093, India  1', '09AAACH7409R1ZZ', NULL, NULL, '2025-06-17 12:18:26', '2025-06-17 13:22:25');

-- --------------------------------------------------------

--
-- Table structure for table `buyer_subscriptions`
--

DROP TABLE IF EXISTS `buyer_subscriptions`;
CREATE TABLE IF NOT EXISTS `buyer_subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('active','expired') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `buyer_subscriptions`
--

INSERT INTO `buyer_subscriptions` (`id`, `user_id`, `plan_name`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 3, 'Basic', '2025-06-19', '2025-12-19', 'active', '2025-06-19 00:34:54', '2025-06-19 00:34:54'),
(2, 3, 'Free', '2025-06-19', '2025-12-19', 'active', '2025-06-19 03:16:59', '2025-06-19 03:16:59');

-- --------------------------------------------------------

--
-- Table structure for table `buy_requirements`
--

DROP TABLE IF EXISTS `buy_requirements`;
CREATE TABLE IF NOT EXISTS `buy_requirements` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expected_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `buy_requirements`
--

INSERT INTO `buy_requirements` (`id`, `product_name`, `country_code`, `mobile_number`, `expected_date`, `created_at`, `updated_at`) VALUES
(1, 'RED MANGO 1', '', '8081008296', '2025-07-26', '2025-07-26 12:16:55', '2025-07-26 12:16:55'),
(2, 'NEW MANGO 123', '', '8081008926', '2025-07-26', '2025-07-26 12:24:10', '2025-07-26 12:24:10'),
(3, 'RED MANGO 1', '', '8081008926', NULL, '2025-07-26 12:25:35', '2025-07-26 12:25:35'),
(4, 'RED MANGO 1', '', '8081008926', '2025-07-26', '2025-07-26 12:42:15', '2025-07-26 12:42:15');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_categories_name` (`name`),
  KEY `idx_categories_status_name` (`status`,`name`),
  KEY `idx_categories_status` (`status`),
  KEY `idx_categories_parent_status` (`parent_id`,`status`),
  KEY `idx_categories_parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `parent_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Industrial Machinery', 'industrial-machinery', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(2, 'Tools, Equipment & Supplies', 'tools-equipment-supplies', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(3, 'Building & Construction', 'building-construction', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(4, 'Electrical Equipment', 'electrical-equipment', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(5, 'Plumbing & Sanitary', 'plumbing-sanitary', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(6, 'Apparel & Garments', 'apparel-garments', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(7, 'Electronics & Components', 'electronics-components', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(8, 'Hotel, Restaurant & Catering', 'hotel-restaurant-catering', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(9, 'Retail & Display Fixtures', 'retail-display-fixtures', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(10, 'Medical Supplies', 'medical-supplies', 0, 1, '2025-06-10 00:12:20', '2025-06-10 00:12:20'),
(11, 'Agriculture', 'agriculture', 0, 1, '2025-06-10 00:12:52', '2025-06-10 00:12:52'),
(12, 'Packaging Machines', 'packaging-machines', 1, 1, '2025-06-10 00:13:40', '2025-06-10 00:13:40'),
(13, 'Food Processing Machines', 'food-processing-machines', 1, 1, '2025-06-10 00:13:40', '2025-06-10 00:13:40'),
(14, 'Construction Equipment', 'construction-equipment', 1, 1, '2025-06-10 00:13:40', '2025-06-10 00:13:40'),
(15, 'CNC Machines', 'cnc-machines', 1, 1, '2025-06-10 00:13:40', '2025-06-10 00:13:40'),
(16, 'Printing Machines', 'printing-machines', 1, 1, '2025-06-10 00:13:40', '2025-06-10 00:13:40'),
(17, 'Power Tools', 'power-tools', 2, 1, '2025-06-10 00:13:58', '2025-06-10 00:13:58'),
(18, 'Hand Tools', 'hand-tools', 2, 1, '2025-06-10 00:13:58', '2025-06-10 00:13:58'),
(19, 'Cutting Tools', 'cutting-tools', 2, 1, '2025-06-10 00:13:58', '2025-06-10 00:13:58'),
(20, 'Welding Equipment', 'welding-equipment', 2, 1, '2025-06-10 00:13:58', '2025-06-10 00:13:58'),
(21, 'Safety Equipment', 'safety-equipment', 2, 1, '2025-06-10 00:13:58', '2025-06-10 00:13:58'),
(22, 'Cement', 'cement', 3, 1, '2025-06-10 00:14:10', '2025-06-10 00:14:10'),
(23, 'Bricks & Blocks', 'bricks-blocks', 3, 1, '2025-06-10 00:14:10', '2025-06-10 00:14:10'),
(24, 'Tiles & Marble', 'tiles-marble', 3, 1, '2025-06-10 00:14:10', '2025-06-10 00:14:10'),
(25, 'Paints & Wall Finishes', 'paints-wall-finishes', 3, 1, '2025-06-10 00:14:10', '2025-06-10 00:14:10'),
(26, 'Roofing Sheets', 'roofing-sheets', 3, 1, '2025-06-10 00:14:10', '2025-06-10 00:14:10'),
(27, 'Wires & Cables', 'wires-cables', 4, 1, '2025-06-10 00:14:23', '2025-06-10 00:14:23'),
(28, 'Switches & Sockets', 'switches-sockets', 4, 1, '2025-06-10 00:14:23', '2025-06-10 00:14:23'),
(29, 'Circuit Breakers', 'circuit-breakers', 4, 1, '2025-06-10 00:14:23', '2025-06-10 00:14:23'),
(30, 'Electric Motors', 'electric-motors', 4, 1, '2025-06-10 00:14:23', '2025-06-10 00:14:23'),
(31, 'Batteries & UPS', 'batteries-ups', 4, 1, '2025-06-10 00:14:23', '2025-06-10 00:14:23'),
(32, 'Pipes & Fittings', 'pipes-fittings', 5, 1, '2025-06-10 00:14:32', '2025-06-10 00:14:32'),
(33, 'Water Tanks', 'water-tanks', 5, 1, '2025-06-10 00:14:32', '2025-06-10 00:14:32'),
(34, 'Taps & Faucets', 'taps-faucets', 5, 1, '2025-06-10 00:14:32', '2025-06-10 00:14:32'),
(35, 'Bathroom Accessories', 'bathroom-accessories', 5, 1, '2025-06-10 00:14:32', '2025-06-10 00:14:32'),
(36, 'Water Heaters', 'water-heaters', 5, 1, '2025-06-10 00:14:32', '2025-06-10 00:14:32'),
(37, 'Men\'s Wear', 'mens-wear', 6, 1, '2025-06-10 00:14:41', '2025-06-10 00:14:41'),
(38, 'Women\'s Wear 1', 'women-s-wear-1', 6, 1, '2025-06-10 00:14:41', '2025-06-14 20:10:17'),
(39, 'Kids Clothing', 'kids-clothing', 6, 1, '2025-06-10 00:14:41', '2025-06-10 00:14:41'),
(40, 'School Uniforms', 'school-uniforms', 6, 1, '2025-06-10 00:14:41', '2025-06-10 00:14:41'),
(41, 'Ethnic Wear', 'ethnic-wear', 6, 1, '2025-06-10 00:14:41', '2025-06-10 00:14:41'),
(42, 'Mobile Phones', 'mobile-phones', 7, 1, '2025-06-10 00:14:51', '2025-06-10 00:14:51'),
(43, 'LED TVs', 'led-tvs', 7, 1, '2025-06-10 00:14:51', '2025-06-10 00:14:51'),
(44, 'Computer Components', 'computer-components', 7, 1, '2025-06-10 00:14:51', '2025-06-10 00:14:51'),
(45, 'Sensors & Modules', 'sensors-modules', 7, 1, '2025-06-10 00:14:51', '2025-06-10 00:14:51'),
(46, 'PCBs', 'pcbs', 7, 1, '2025-06-10 00:14:51', '2025-06-10 00:14:51'),
(47, 'Kitchen Equipment', 'kitchen-equipment', 8, 1, '2025-06-10 00:15:28', '2025-06-10 00:15:28'),
(48, 'Cutlery & Utensils', 'cutlery-utensils', 8, 1, '2025-06-10 00:15:28', '2025-06-10 00:15:28'),
(49, 'Commercial Refrigerators', 'commercial-refrigerators', 8, 1, '2025-06-10 00:15:28', '2025-06-10 00:15:28'),
(50, 'Disposable Items', 'disposable-items', 8, 1, '2025-06-10 00:15:28', '2025-06-10 00:15:28'),
(51, 'Diagnostic Tools', 'diagnostic-tools', 10, 1, '2025-06-10 00:16:06', '2025-06-10 00:16:06'),
(52, 'Tractors & Tractor Parts', 'tractors-tractor-parts', 11, 1, '2025-06-10 00:16:39', '2025-06-10 00:16:39'),
(53, 'Harvesters & Combine Machines', 'harvesters-combine-machines', 11, 1, '2025-06-10 00:16:39', '2025-06-10 00:16:39'),
(54, 'Irrigation Equipment', 'irrigation-equipment', 11, 1, '2025-06-10 00:16:39', '2025-06-10 00:16:39'),
(55, 'Greenhouse & Polyhouse', 'greenhouse-polyhouse', 11, 1, '2025-06-10 00:16:39', '2025-06-10 00:16:39'),
(56, 'Agro Chemicals & Fertilizers', 'agro-chemicals-fertilizers', 11, 1, '2025-06-10 00:16:39', '2025-06-10 00:16:39'),
(57, 'Seeds & Planting Material', 'seeds-planting-material', 11, 1, '2025-06-10 00:16:39', '2025-06-10 00:16:39'),
(58, 'Pesticides & Insecticides', 'pesticides-insecticides', 11, 1, '2025-06-10 00:16:39', '2025-06-10 00:16:39'),
(59, 'Agri Tools & Equipment', 'agri-tools-equipment', 11, 0, '2025-06-10 00:16:39', '2025-06-14 22:13:50'),
(60, 'Crop Protection Nets', 'crop-protection-nets', 11, 1, '2025-06-10 00:16:39', '2025-06-10 00:16:39'),
(61, 'Agricultural Sprayers', 'agricultural-sprayers', 11, 1, '2025-06-10 00:16:39', '2025-06-10 00:16:39');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `help_supports`
--

DROP TABLE IF EXISTS `help_supports`;
CREATE TABLE IF NOT EXISTS `help_supports` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_type` enum('vendor','buyer') NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `reply_message` text,
  `status` enum('open','pending','on_hold','solved','closed') NOT NULL DEFAULT 'open',
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `help_supports`
--

INSERT INTO `help_supports` (`id`, `user_type`, `name`, `contact_no`, `email`, `message`, `attachment`, `reply_message`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'vendor', 'Deepak Maurya', '8081008926', 'deepakmauryacs17@gmail.com', 'Hello', NULL, NULL, 'open', 2, 2, '2025-06-19 09:53:26', '2025-06-19 09:53:26');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(20, 'exports', '{\"uuid\":\"0523aa3e-d9ab-4f5b-8f02-372b4495e5b7\",\"displayName\":\"Closure (VendorController.php:146)\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Queue\\\\CallQueuedClosure\",\"command\":\"O:34:\\\"Illuminate\\\\Queue\\\\CallQueuedClosure\\\":2:{s:7:\\\"closure\\\";O:47:\\\"Laravel\\\\SerializableClosure\\\\SerializableClosure\\\":1:{s:12:\\\"serializable\\\";O:46:\\\"Laravel\\\\SerializableClosure\\\\Serializers\\\\Signed\\\":2:{s:12:\\\"serializable\\\";s:1470:\\\"O:46:\\\"Laravel\\\\SerializableClosure\\\\Serializers\\\\Native\\\":5:{s:3:\\\"use\\\";a:2:{s:8:\\\"exportId\\\";s:36:\\\"9489cea9-5d7a-458d-b1d0-fac722194688\\\";s:8:\\\"filePath\\\";s:57:\\\"exports\\/vendors_9489cea9-5d7a-458d-b1d0-fac722194688.xlsx\\\";}s:8:\\\"function\\\";s:1105:\\\"function () use ($exportId, $filePath) {\\r\\n                \\/\\/ Simulate progress updates (replace with actual logic if needed)\\r\\n                for ($i = 10; $i <= 90; $i += 10) {\\r\\n                    cache()->put(\'export_progress_\' . $exportId, [\\r\\n                        \'progress\' => $i,\\r\\n                        \'message\' => \'Exporting data... (\' . $i . \'%)\',\\r\\n                        \'status\' => \'processing\',\\r\\n                        \'file_path\' => $filePath\\r\\n                    ], now()->addMinutes(30));\\r\\n                    sleep(1); \\/\\/ Simulate processing time\\r\\n                }\\r\\n\\r\\n                \\/\\/ Generate and store the Excel file\\r\\n                \\\\Maatwebsite\\\\Excel\\\\Facades\\\\Excel::store(new \\\\App\\\\Exports\\\\VendorsExport, $filePath, \'public\');\\r\\n\\r\\n                \\/\\/ Mark as completed\\r\\n                cache()->put(\'export_progress_\' . $exportId, [\\r\\n                    \'progress\' => 100,\\r\\n                    \'message\' => \'Export completed!\',\\r\\n                    \'status\' => \'completed\',\\r\\n                    \'file_path\' => $filePath\\r\\n                ], now()->addMinutes(30));\\r\\n            }\\\";s:5:\\\"scope\\\";s:43:\\\"App\\\\Http\\\\Controllers\\\\Admin\\\\VendorController\\\";s:4:\\\"this\\\";N;s:4:\\\"self\\\";s:32:\\\"00000000000002400000000000000000\\\";}\\\";s:4:\\\"hash\\\";s:44:\\\"eXO+JuOCJnqeSHwX3cmJVXaVLFXwpjvaFwGVMt\\/TuH0=\\\";}}s:5:\\\"queue\\\";s:7:\\\"exports\\\";}\"},\"createdAt\":1750010894,\"delay\":null}', 0, NULL, 1750010895, 1750010895);

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_06_08_043655_create_vendor_profiles_table', 2),
(5, '2025_06_09_185819_create_products_table', 3),
(6, '2025_06_13_183922_create_categories_table', 4),
(7, '2025_06_14_215339_create_activity_log_table', 4),
(8, '2025_06_14_215340_add_event_column_to_activity_log_table', 4),
(9, '2025_06_14_215341_add_batch_uuid_column_to_activity_log_table', 4),
(10, '2025_06_17_112848_create_vendor_exports_table', 5),
(12, '2025_06_08_043656_create_buyer_profiles_table', 6),
(13, '2025_06_17_120000_create_roles_table', 7),
(14, '2025_06_17_120100_create_role_user_table', 7),
(15, '2025_06_17_120200_create_role_permissions_table', 7),
(16, '2025_06_18_120000_create_vendor_subscriptions_table', 8),
(17, '2025_06_18_142527_create_plans_table', 9),
(18, '2025_06_18_150000_create_buyer_subscriptions_table', 10),
(19, '2025_06_18_160000_create_help_supports_table', 11),
(20, '2025_06_20_205514_create_stock_logs_table', 12),
(21, '2025_06_21_030700_create_warehouses_table', 13),
(22, '2025_06_22_000000_create_warehouse_product_table', 14),
(23, '2025_06_20_000000_create_banners_table', 15),
(24, '2025_06_23_000000_create_buy_requirements_table', 16),
(25, '2025_07_16_175353_create_rfqs_table', 17),
(26, '2025_07_16_175407_create_rfq_vendors_table', 17),
(27, '2025_07_28_191922_create_rfq_carts_table', 18);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
CREATE TABLE IF NOT EXISTS `plans` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `plan_for` enum('vendor','buyer') NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `name`, `price`, `plan_for`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Free', '0.00', 'vendor', 'active', '2025-06-18 09:23:48', '2025-06-19 00:51:45'),
(2, 'Free', '0.00', 'buyer', 'active', '2025-06-19 00:34:39', '2025-06-19 00:51:24');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `vendor_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `sub_category_id` int(10) UNSIGNED DEFAULT NULL,
  `product_name` varchar(200) NOT NULL,
  `product_image` text,
  `slug` text NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `unit` varchar(50) DEFAULT NULL,
  `min_order_qty` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `stock_quantity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `hsn_code` varchar(255) DEFAULT NULL,
  `gst_rate` tinyint(3) UNSIGNED DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_vendor_id` (`vendor_id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_sub_category_id` (`sub_category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_price` (`price`),
  KEY `idx_stock_quantity` (`stock_quantity`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_updated_at` (`updated_at`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_vendor_status` (`vendor_id`,`status`),
  KEY `idx_category_subcategory` (`category_id`,`sub_category_id`),
  KEY `idx_category_price` (`category_id`,`price`),
  KEY `idx_vendor_price` (`vendor_id`,`price`),
  KEY `idx_product_image` (`product_image`(255)),
  KEY `idx_name_image` (`product_name`,`product_image`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rfqs`
--

DROP TABLE IF EXISTS `rfqs`;
CREATE TABLE IF NOT EXISTS `rfqs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rfq_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `buyer_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_specification` text COLLATE utf8mb4_unicode_ci,
  `quantity` decimal(10,2) NOT NULL,
  `measurement_unit` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rfqs_rfq_id_unique` (`rfq_id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rfqs`
--

INSERT INTO `rfqs` (`id`, `rfq_id`, `buyer_id`, `product_name`, `product_specification`, `quantity`, `measurement_unit`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'RFQ-BN0S5RNF', 2, 'Product 999985', 'HELLO', '1000.00', 'KG', 2, '2025-07-16 14:02:13', '2025-07-16 14:02:13'),
(2, 'RFQ-IRVV6MYA', 2, 'Product 999985', 'HELLO', '1000.00', 'KG', 2, '2025-07-16 14:02:41', '2025-07-16 14:02:41'),
(3, 'RFQ-QGUYBUYL', 0, 'Product 999997', 'Product 999997', '1000.00', 'KG', 0, '2025-07-22 11:34:04', '2025-07-22 11:34:04'),
(4, 'RFQ-ORITUROV', 0, 'Product 999997', 'Product 999997', '1000.00', 'kg', 0, '2025-07-22 12:13:32', '2025-07-22 12:13:32'),
(5, 'RFQ-E0CHVHJV', 0, 'Product 999997', 'Product 999997', '1000.00', 'kg', 0, '2025-07-22 12:14:34', '2025-07-22 12:14:34'),
(6, 'RFQ-ZEJYQBU6', 0, 'Product 999995', 'Product 999995', '1000.00', 'kg', 0, '2025-07-22 12:15:45', '2025-07-22 12:15:45'),
(7, 'RFQ-O4FDYLXQ', 0, 'Product 999831', 'Product 999831', '1000.00', 'kg', 0, '2025-07-22 12:17:08', '2025-07-22 12:17:08'),
(8, 'RFQ-OP9KXWZN', 0, 'Product 999997', 'Product 999997', '100000.00', 'kg', 0, '2025-07-22 12:22:33', '2025-07-22 12:22:33'),
(9, 'RFQ-FRMFF0DJ', 0, 'Product 999980', 'Product 999980', '1000.00', 'kg', 0, '2025-07-22 12:23:06', '2025-07-22 12:23:06'),
(10, 'RFQ-2YG8ZQYQ', 0, 'Product 999997', 'Product 999997', '10.00', 'kg', 0, '2025-07-22 12:23:32', '2025-07-22 12:23:32'),
(11, 'RFQ-U91CKAPJ', 0, 'Product 999995', 'Product 999995', '10.00', 'kg', 0, '2025-07-22 12:23:57', '2025-07-22 12:23:57'),
(12, 'RFQ-ZCUDUDU3', 0, 'Product 999997', 'Product 999997', '10.00', 'kg', 0, '2025-07-22 12:24:30', '2025-07-22 12:24:30'),
(13, 'RFQ-VTINGIXR', 0, 'Product 999982', 'Product 999982', '10.00', 'kg', 0, '2025-07-22 12:25:12', '2025-07-22 12:25:12'),
(14, 'RFQ-YA9W5KN6', 0, 'Product 999995', NULL, '1000.00', 'kg', 0, '2025-07-23 13:02:53', '2025-07-23 13:02:53'),
(15, 'RFQ-EXPCYFRA', 0, 'Product 999997', 'hello', '1000.00', 'kg', 0, '2025-07-23 13:06:20', '2025-07-23 13:06:20'),
(16, 'RFQ-JU7RVYYR', 0, 'Product 999703', NULL, '1000.00', 'lb', 0, '2025-07-23 13:06:53', '2025-07-23 13:06:53'),
(17, 'RFQ-TAJ7IR5J', 0, 'Product 999931', NULL, '1000.00', 'mg', 0, '2025-07-24 03:54:57', '2025-07-24 03:54:57'),
(18, 'RFQ-RVR5X1ZG', 0, 'Product 999997', 'no', '1000.00', 'mg', 0, '2025-07-25 04:04:13', '2025-07-25 04:04:13'),
(19, 'RFQ-T2PFGLOL', 0, 'Product 999997', NULL, '1000.00', 'g', 0, '2025-07-25 11:59:20', '2025-07-25 11:59:20'),
(20, 'RFQ-EQSRLAQK', 0, 'Product 999997', NULL, '1000.00', 'mg', 0, '2025-07-25 12:02:33', '2025-07-25 12:02:33'),
(21, 'RFQ-KD2AWOQV', 0, 'Product 999982', NULL, '1000.00', 'kg', 0, '2025-07-25 12:02:44', '2025-07-25 12:02:44'),
(22, 'RFQ-XPPO2VT1', 0, 'Product 999811', NULL, '1000.00', 'kg', 0, '2025-07-25 12:04:03', '2025-07-25 12:04:03'),
(23, 'RFQ-COL0VKC9', 0, 'Product 999997', NULL, '1000.00', 'kg', 0, '2025-07-25 12:10:01', '2025-07-25 12:10:01'),
(24, 'RFQ-EYKHRERQ', 0, 'Apple', '100', '1000.00', 'kg', 0, '2025-07-25 12:13:25', '2025-07-25 12:13:25'),
(25, 'RFQ-ESSFSRXZ', 0, 'Apple', NULL, '1000.00', 'kg', 0, '2025-07-25 12:15:10', '2025-07-25 12:15:10'),
(26, 'RFQ-D9NDCHPY', 0, 'Product 100005', NULL, '1000.00', 'kg', 0, '2025-07-25 12:15:16', '2025-07-25 12:15:16'),
(27, 'RFQ-UHTXYTH1', 0, 'Product 100009', NULL, '1000.00', 'oz', 0, '2025-07-25 12:15:29', '2025-07-25 12:15:29'),
(28, 'RFQ-UQVY4WJW', 0, 'Product 100009', NULL, '1000.00', 'kg', 0, '2025-07-25 12:18:33', '2025-07-25 12:18:33'),
(29, 'RFQ-LBMEOBTR', 0, 'Product 100005', NULL, '1000.00', 'kg', 0, '2025-07-25 12:18:47', '2025-07-25 12:18:47'),
(30, 'RFQ-O7PVFK3X', 250004, 'Product 10', NULL, '1000.00', 'kg', 250004, '2025-07-26 09:00:30', '2025-07-26 09:00:30'),
(31, 'RFQ-JQ9RUZKE', 250004, 'Product 100', NULL, '10.00', 'oz', 250004, '2025-07-26 09:00:39', '2025-07-26 09:00:39'),
(32, 'RFQ-6IWVDQAL', 2, 'Product 999963', NULL, '1000.00', 'kg', 2, '2025-07-28 13:42:22', '2025-07-28 13:42:22'),
(33, 'RFQ-ZNZRTZ36', 250004, 'Product 999952', NULL, '1000.00', 'kg', 250004, '2025-07-29 06:42:07', '2025-07-29 06:42:07');

-- --------------------------------------------------------

--
-- Table structure for table `rfq_carts`
--

DROP TABLE IF EXISTS `rfq_carts`;
CREATE TABLE IF NOT EXISTS `rfq_carts` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rfq_carts`
--

INSERT INTO `rfq_carts` (`id`, `user_id`, `product_name`, `created_at`, `updated_at`) VALUES
(1, 2, 'Product 999997', '2025-07-28 13:54:39', '2025-07-28 13:54:39'),
(2, 2, 'Product 999992', '2025-07-28 13:54:42', '2025-07-28 13:54:42'),
(3, 2, 'Product 999990', '2025-07-28 13:54:44', '2025-07-28 13:54:44'),
(4, 2, 'Product 999997', '2025-07-28 13:57:30', '2025-07-28 13:57:30'),
(5, 2, 'Product 999995', '2025-07-28 13:57:33', '2025-07-28 13:57:33'),
(6, 250004, 'Product 999997', '2025-07-28 23:28:32', '2025-07-28 23:28:32'),
(7, 250004, 'Product 999995', '2025-07-28 23:28:35', '2025-07-28 23:28:35'),
(8, 250004, 'Product 999997', '2025-07-28 23:30:00', '2025-07-28 23:30:00'),
(9, 250004, 'Product 999995', '2025-07-28 23:30:05', '2025-07-28 23:30:05'),
(10, 250004, 'Product 999992', '2025-07-28 23:30:07', '2025-07-28 23:30:07'),
(11, 250004, 'Product 999990', '2025-07-28 23:30:08', '2025-07-28 23:30:08'),
(12, 250004, 'Product 999985', '2025-07-28 23:30:12', '2025-07-28 23:30:12'),
(13, 250004, 'Product 999984', '2025-07-28 23:30:18', '2025-07-28 23:30:18'),
(14, 250004, 'Product 999978', '2025-07-28 23:30:52', '2025-07-28 23:30:52'),
(15, 250004, 'Product 999982', '2025-07-28 23:31:18', '2025-07-28 23:31:18'),
(16, 250004, 'Product 999831', '2025-07-28 23:40:59', '2025-07-28 23:40:59'),
(17, 250004, 'Product 999974', '2025-07-28 23:44:11', '2025-07-28 23:44:11'),
(18, 250004, 'Product 999972', '2025-07-28 23:44:13', '2025-07-28 23:44:13'),
(19, 250004, 'Product 999980', '2025-07-28 23:44:44', '2025-07-28 23:44:44'),
(20, 250004, 'Product 999934', '2025-07-28 23:44:50', '2025-07-28 23:44:50'),
(21, 250004, 'Product 999927', '2025-07-28 23:44:54', '2025-07-28 23:44:54'),
(22, 250004, 'Product 999926', '2025-07-28 23:45:00', '2025-07-28 23:45:00'),
(23, 250004, 'Product 999929', '2025-07-28 23:45:01', '2025-07-28 23:45:01'),
(24, 250004, 'Product 999952', '2025-07-28 23:47:04', '2025-07-28 23:47:04'),
(25, 250004, 'Product 999952', '2025-07-28 23:47:04', '2025-07-28 23:47:04'),
(26, 250004, 'Product 999961', '2025-07-28 23:47:07', '2025-07-28 23:47:07'),
(27, 250004, 'Product 999961', '2025-07-28 23:47:07', '2025-07-28 23:47:07'),
(28, 250004, 'Product 999937', '2025-07-28 23:47:09', '2025-07-28 23:47:09'),
(29, 250004, 'Product 999937', '2025-07-28 23:47:09', '2025-07-28 23:47:09'),
(30, 250004, 'Product 999944', '2025-07-28 23:47:10', '2025-07-28 23:47:10'),
(31, 250004, 'Product 999944', '2025-07-28 23:47:10', '2025-07-28 23:47:10'),
(32, 250004, 'Product 999911', '2025-07-28 23:47:19', '2025-07-28 23:47:19'),
(33, 250004, 'Product 999911', '2025-07-28 23:47:19', '2025-07-28 23:47:19'),
(34, 250004, 'Product 999788', '2025-07-28 23:48:24', '2025-07-28 23:48:24'),
(35, 250004, 'Product 999784', '2025-07-28 23:48:25', '2025-07-28 23:48:25'),
(36, 250004, 'Product 999783', '2025-07-28 23:48:26', '2025-07-28 23:48:26'),
(37, 250004, 'Product 999963', '2025-07-28 23:49:45', '2025-07-28 23:49:45'),
(38, 250004, 'Product 999965', '2025-07-28 23:49:48', '2025-07-28 23:49:48'),
(39, 250004, 'Product 999976', '2025-07-29 06:19:20', '2025-07-29 06:19:20');

-- --------------------------------------------------------

--
-- Table structure for table `rfq_vendors`
--

DROP TABLE IF EXISTS `rfq_vendors`;
CREATE TABLE IF NOT EXISTS `rfq_vendors` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rfq_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vendor_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rfq_vendors`
--

INSERT INTO `rfq_vendors` (`id`, `rfq_id`, `vendor_id`, `created_at`, `updated_at`) VALUES
(1, 'RFQ-IRVV6MYA', 432, '2025-07-16 14:02:41', '2025-07-16 14:02:41'),
(2, 'RFQ-QGUYBUYL', 229, '2025-07-22 11:34:04', '2025-07-22 11:34:04'),
(3, 'RFQ-ORITUROV', 229, '2025-07-22 12:13:32', '2025-07-22 12:13:32'),
(4, 'RFQ-E0CHVHJV', 229, '2025-07-22 12:14:34', '2025-07-22 12:14:34'),
(5, 'RFQ-ZEJYQBU6', 543, '2025-07-22 12:15:45', '2025-07-22 12:15:45'),
(6, 'RFQ-O4FDYLXQ', 739, '2025-07-22 12:17:08', '2025-07-22 12:17:08'),
(7, 'RFQ-OP9KXWZN', 229, '2025-07-22 12:22:33', '2025-07-22 12:22:33'),
(8, 'RFQ-FRMFF0DJ', 638, '2025-07-22 12:23:06', '2025-07-22 12:23:06'),
(9, 'RFQ-2YG8ZQYQ', 229, '2025-07-22 12:23:32', '2025-07-22 12:23:32'),
(10, 'RFQ-U91CKAPJ', 543, '2025-07-22 12:23:57', '2025-07-22 12:23:57'),
(11, 'RFQ-ZCUDUDU3', 229, '2025-07-22 12:24:30', '2025-07-22 12:24:30'),
(12, 'RFQ-VTINGIXR', 854, '2025-07-22 12:25:12', '2025-07-22 12:25:12'),
(13, 'RFQ-YA9W5KN6', 543, '2025-07-23 13:02:53', '2025-07-23 13:02:53'),
(14, 'RFQ-EXPCYFRA', 229, '2025-07-23 13:06:20', '2025-07-23 13:06:20'),
(15, 'RFQ-JU7RVYYR', 591, '2025-07-23 13:06:53', '2025-07-23 13:06:53'),
(16, 'RFQ-TAJ7IR5J', 818, '2025-07-24 03:54:57', '2025-07-24 03:54:57'),
(17, 'RFQ-RVR5X1ZG', 229, '2025-07-25 04:04:13', '2025-07-25 04:04:13'),
(18, 'RFQ-T2PFGLOL', 229, '2025-07-25 11:59:21', '2025-07-25 11:59:21'),
(19, 'RFQ-EQSRLAQK', 229, '2025-07-25 12:02:33', '2025-07-25 12:02:33'),
(20, 'RFQ-KD2AWOQV', 854, '2025-07-25 12:02:44', '2025-07-25 12:02:44'),
(21, 'RFQ-XPPO2VT1', 597, '2025-07-25 12:04:03', '2025-07-25 12:04:03'),
(22, 'RFQ-COL0VKC9', 229, '2025-07-25 12:10:01', '2025-07-25 12:10:01'),
(23, 'RFQ-EYKHRERQ', 41, '2025-07-25 12:13:25', '2025-07-25 12:13:25'),
(24, 'RFQ-ESSFSRXZ', 41, '2025-07-25 12:15:10', '2025-07-25 12:15:10'),
(25, 'RFQ-D9NDCHPY', 471, '2025-07-25 12:15:16', '2025-07-25 12:15:16'),
(26, 'RFQ-UHTXYTH1', 753, '2025-07-25 12:15:29', '2025-07-25 12:15:29'),
(27, 'RFQ-UQVY4WJW', 753, '2025-07-25 12:18:33', '2025-07-25 12:18:33'),
(28, 'RFQ-LBMEOBTR', 471, '2025-07-25 12:18:47', '2025-07-25 12:18:47'),
(29, 'RFQ-O7PVFK3X', 332, '2025-07-26 09:00:30', '2025-07-26 09:00:30'),
(30, 'RFQ-JQ9RUZKE', 395, '2025-07-26 09:00:39', '2025-07-26 09:00:39'),
(31, 'RFQ-6IWVDQAL', 508, '2025-07-28 13:42:22', '2025-07-28 13:42:22'),
(32, 'RFQ-ZNZRTZ36', 463, '2025-07-29 06:42:07', '2025-07-29 06:42:07');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_parent_id_foreign` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `parent_id`, `created_at`, `updated_at`) VALUES
(1, 'Admin', NULL, '2025-06-17 13:54:54', '2025-06-17 13:54:54'),
(2, 'Super Admin', 1, '2025-06-17 13:55:30', '2025-06-17 13:55:30'),
(3, 'FEEDER NUT', NULL, '2025-06-17 15:35:07', '2025-06-17 15:35:07');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE IF NOT EXISTS `role_permissions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `module` varchar(255) NOT NULL,
  `can_add` tinyint(1) NOT NULL DEFAULT '0',
  `can_edit` tinyint(1) NOT NULL DEFAULT '0',
  `can_view` tinyint(1) NOT NULL DEFAULT '0',
  `can_export` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_permissions_role_id_foreign` (`role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `role_id`, `module`, `can_add`, `can_edit`, `can_view`, `can_export`, `created_at`, `updated_at`) VALUES
(48, 1, 'roles', 1, 1, 1, 1, '2025-07-04 11:21:54', '2025-07-04 11:21:54'),
(47, 1, 'users', 1, 1, 1, 1, '2025-07-04 11:21:54', '2025-07-04 11:21:54'),
(46, 1, 'products', 1, 1, 1, 1, '2025-07-04 11:21:54', '2025-07-04 11:21:54'),
(43, 1, 'categories', 1, 1, 1, 1, '2025-07-04 11:21:54', '2025-07-04 11:21:54'),
(45, 1, 'buyers', 1, 1, 1, 1, '2025-07-04 11:21:54', '2025-07-04 11:21:54'),
(44, 1, 'vendors', 1, 1, 1, 1, '2025-07-04 11:21:54', '2025-07-04 11:21:54'),
(28, 3, 'products', 1, 1, 1, 0, '2025-06-17 15:42:45', '2025-06-17 15:42:45'),
(27, 3, 'buyers', 1, 1, 1, 0, '2025-06-17 15:42:45', '2025-06-17 15:42:45'),
(26, 3, 'vendors', 1, 1, 1, 0, '2025-06-17 15:42:45', '2025-06-17 15:42:45'),
(25, 3, 'categories', 1, 1, 1, 1, '2025-06-17 15:42:45', '2025-06-17 15:42:45'),
(29, 3, 'users', 1, 1, 1, 0, '2025-06-17 15:42:45', '2025-06-17 15:42:45'),
(30, 3, 'roles', 1, 1, 1, 0, '2025-06-17 15:42:45', '2025-06-17 15:42:45');

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
CREATE TABLE IF NOT EXISTS `role_user` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `role_user_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('CPGMqTAR0yIqWR49pDYIML6wwetbRXxSqg5Elxc5', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia2JXR3JaTkx1a0QyRzZUREl1NkE2WnJrNk96ZDBqRkNLUk5NaWFOZCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3QvYjJiLWFwcC9wdWJsaWMvY2F0ZWdvcmllcyI7fX0=', 1755457140),
('XPCvtfHz6s2DsWPgPDyCWWWQiwTmqddMhxgrZEOL', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWlEyaktaa3JBeGFQVjhHMUFLZVo3NVdCRGh0Wm1KOURCM1R0ektXUyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1MDoiaHR0cDovL2xvY2FsaG9zdC9iMmItYXBwL3B1YmxpYy9hZG1pbi92ZW5kb3JzL2xpc3QiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo1MDoiaHR0cDovL2xvY2FsaG9zdC9iMmItYXBwL3B1YmxpYy9hZG1pbi92ZW5kb3JzL2xpc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1755946443),
('eMM3C2hPJzztqfAVOiglCILrdwZNQV7YZVhQH7Nn', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZjl3d29aUTVEMzdaY1BleHo4VkNFMWxIamk4blZBMHBRSGZUTlN0ZSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3QvYjJiLWFwcC9wdWJsaWMvY2F0ZWdvcmllcyI7fX0=', 1755946672);

-- --------------------------------------------------------

--
-- Table structure for table `stock_logs`
--

DROP TABLE IF EXISTS `stock_logs`;
CREATE TABLE IF NOT EXISTS `stock_logs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `old_quantity` int(11) NOT NULL,
  `new_quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_logs_product_id_foreign` (`product_id`),
  KEY `stock_logs_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stock_logs`
--

INSERT INTO `stock_logs` (`id`, `product_id`, `user_id`, `old_quantity`, `new_quantity`, `created_at`, `updated_at`) VALUES
(1, 999769, 2, 959, 1000, '2025-06-20 15:36:40', '2025-06-20 15:36:40'),
(2, 999769, 2, 1000, 1001, '2025-06-20 15:38:13', '2025-06-20 15:38:13'),
(3, 999769, 2, 1001, 1002, '2025-06-20 15:38:16', '2025-06-20 15:38:16'),
(4, 999769, 2, 1002, 1003, '2025-06-20 15:38:19', '2025-06-20 15:38:19'),
(5, 999769, 2, 1003, 1004, '2025-06-20 15:38:22', '2025-06-20 15:38:22'),
(6, 999769, 2, 1004, 1005, '2025-06-20 15:38:26', '2025-06-20 15:38:26'),
(7, 999769, 2, 1005, 1006, '2025-06-20 15:38:29', '2025-06-20 15:38:29'),
(8, 999769, 2, 1006, 1007, '2025-06-20 15:38:32', '2025-06-20 15:38:32'),
(9, 999769, 2, 1007, 1008, '2025-06-20 15:38:35', '2025-06-20 15:38:35'),
(10, 999769, 2, 1008, 1008, '2025-06-20 15:38:38', '2025-06-20 15:38:38'),
(11, 999769, 2, 1008, 1008, '2025-06-20 15:38:42', '2025-06-20 15:38:42'),
(12, 999769, 2, 1008, 1008, '2025-06-20 15:38:45', '2025-06-20 15:38:45'),
(13, 999769, 2, 1008, 1008, '2025-06-20 15:38:49', '2025-06-20 15:38:49'),
(14, 999769, 2, 1008, 1008, '2025-06-20 15:38:51', '2025-06-20 15:38:51'),
(15, 999769, 2, 1008, 10099, '2025-06-20 15:38:54', '2025-06-20 15:38:54'),
(16, 999769, 2, 10099, 10096, '2025-06-20 15:38:57', '2025-06-20 15:38:57'),
(17, 999769, 2, 10096, 10096, '2025-06-20 15:39:00', '2025-06-20 15:39:00'),
(18, 999769, 2, 10096, 300, '2025-06-20 15:41:59', '2025-06-20 15:41:59'),
(19, 999769, 2, 300, 400, '2025-06-20 16:05:44', '2025-06-20 16:05:44'),
(20, 999769, 2, 400, 406, '2025-06-20 16:05:48', '2025-06-20 16:05:48'),
(21, 999769, 2, 406, 416, '2025-06-20 23:17:25', '2025-06-20 23:17:25'),
(22, 999769, 2, 416, 516, '2025-06-20 23:17:56', '2025-06-20 23:17:56'),
(23, 996386, 2, 100, 200, '2025-06-21 00:35:54', '2025-06-21 00:35:54'),
(24, 999284, 2, 731, 761, '2025-06-21 00:36:00', '2025-06-21 00:36:00'),
(25, 999769, 2, 516, 716, '2025-06-28 00:22:00', '2025-06-28 00:22:00'),
(26, 990024, 2, 642, 742, '2025-06-30 04:23:16', '2025-06-30 04:23:16'),
(27, 999769, 2, 716, 616, '2025-06-30 12:23:22', '2025-06-30 12:23:22'),
(28, 999420, 2, 396, 596, '2025-07-09 00:22:08', '2025-07-09 00:22:08'),
(29, 999420, 2, 596, 1096, '2025-07-09 00:22:21', '2025-07-09 00:22:21'),
(30, 999769, 2, 616, 621, '2025-07-09 00:25:26', '2025-07-09 00:25:26');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `role` enum('vendor','buyer','admin') NOT NULL DEFAULT 'vendor',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('1','2') NOT NULL DEFAULT '1' COMMENT '1->Active,2->Inactive',
  `is_profile_verified` enum('1','2') NOT NULL DEFAULT '2' COMMENT '1->verified,2->not verified',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `idx_users_parent_id` (`parent_id`),
  KEY `idx_users_name` (`name`),
  KEY `idx_users_role` (`role`),
  KEY `idx_users_status` (`status`),
  KEY `idx_users_is_profile_verified` (`is_profile_verified`),
  KEY `idx_users_role_status` (`role`,`status`),
  KEY `idx_users_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `parent_id`, `name`, `email`, `phone`, `role`, `email_verified_at`, `password`, `status`, `is_profile_verified`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Super Admin', 'admin@gmail.com', '8081008926', 'admin', NULL, '$2y$12$jbVVDd6wVazpcOiG3rsJIemvEv5848yMI/RXdn5cYDa1/SdJnB6ty', '1', '2', NULL, '2025-06-07 16:41:27', '2025-06-07 16:41:27'),
(2, NULL, 'Deepak Maurya', 'deepakmauryacs16@gmail.com', '8081008926', 'vendor', NULL, '$2y$12$ZCgK037.N4ZlGHq0YLeafecl561GG4l7t/LIHvYl3nbeRhJBYEEJ.', '1', '1', NULL, '2025-06-07 16:41:27', '2025-07-26 15:48:34');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_exports`
--

DROP TABLE IF EXISTS `vendor_exports`;
CREATE TABLE IF NOT EXISTS `vendor_exports` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `range_start` bigint(20) UNSIGNED NOT NULL,
  `range_end` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'in_progress',
  `file_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vendor_exports`
--

INSERT INTO `vendor_exports` (`id`, `range_start`, `range_end`, `status`, `file_name`, `created_at`, `updated_at`) VALUES
(3, 1, 5, 'in_progress', NULL, '2025-06-17 06:28:50', '2025-06-17 06:28:50');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_profiles`
--

DROP TABLE IF EXISTS `vendor_profiles`;
CREATE TABLE IF NOT EXISTS `vendor_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `store_name` varchar(22) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `pincode` varchar(20) DEFAULT NULL,
  `address` text,
  `gst_no` varchar(20) DEFAULT NULL,
  `gst_doc` text,
  `store_logo` text,
  `accept_terms` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_vendor_profiles_gst_no` (`gst_no`),
  KEY `idx_vendor_profiles_user_id` (`user_id`),
  KEY `idx_vendor_profiles_store_name` (`store_name`),
  KEY `idx_vendor_profiles_location` (`country`,`state`,`city`),
  KEY `idx_vendor_profiles_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_subscriptions`
--

DROP TABLE IF EXISTS `vendor_subscriptions`;
CREATE TABLE IF NOT EXISTS `vendor_subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('active','expired') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vendor_subscriptions`
--

INSERT INTO `vendor_subscriptions` (`id`, `user_id`, `plan_name`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Free', '2025-06-28', '2025-09-28', 'active', '2025-06-18 07:13:00', '2025-06-28 00:10:38'),
(2, 2, 'Free', '2025-07-07', '2025-12-07', 'active', '2025-06-19 03:17:29', '2025-07-07 08:10:48');

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
CREATE TABLE IF NOT EXISTS `warehouses` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `warehouses_vendor_id_foreign` (`vendor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `vendor_id`, `name`, `address`, `city`, `state`, `pincode`, `created_at`, `updated_at`) VALUES
(1, 2, 'Warehouse  2', '571, Street Number 6, Chanderlok, Shahdara, Delhi, 110093, India', 'New Delhi', 'Delhi', '110093', '2025-06-20 22:06:46', '2025-06-20 22:08:54'),
(2, 2, 'Warehouse  1', '571, Street Number 6, Chanderlok, Shahdara, Delhi, 110093, India', 'New Delhi', 'Delhi', '110093', '2025-06-20 22:08:35', '2025-06-20 22:08:47');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_product`
--

DROP TABLE IF EXISTS `warehouse_product`;
CREATE TABLE IF NOT EXISTS `warehouse_product` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `warehouse_product_warehouse_id_product_id_unique` (`warehouse_id`,`product_id`),
  KEY `warehouse_product_product_id_foreign` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `warehouse_product`
--

INSERT INTO `warehouse_product` (`id`, `warehouse_id`, `product_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 2, 999769, 115, '2025-06-20 23:17:25', '2025-07-09 00:25:26'),
(2, 1, 999769, 100, '2025-06-20 23:17:56', '2025-06-20 23:17:56'),
(3, 2, 996386, 100, '2025-06-21 00:35:54', '2025-06-21 00:35:54'),
(4, 2, 999284, 30, '2025-06-21 00:36:00', '2025-06-21 00:36:00'),
(5, 2, 990024, 100, '2025-06-30 04:23:16', '2025-06-30 04:23:16'),
(6, 2, 999420, 200, '2025-07-09 00:22:08', '2025-07-09 00:22:08'),
(7, 1, 999420, 500, '2025-07-09 00:22:21', '2025-07-09 00:22:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products` ADD FULLTEXT KEY `ft_idx_product_name` (`product_name`);
ALTER TABLE `products` ADD FULLTEXT KEY `ft_idx_description` (`description`);
ALTER TABLE `products` ADD FULLTEXT KEY `ft_idx_product_search` (`product_name`,`description`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
