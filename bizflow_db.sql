-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 28, 2026 at 10:25 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bizflow_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `category_code` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_name`, `category_code`, `description`, `parent_id`, `status`, `created_at`) VALUES
(1, 'Gaming Mice', 'CAT-MOU', 'High performance gaming mice for gamers', NULL, 'active', '2026-02-28 09:19:06'),
(2, 'Keyboards', 'CAT-KEY', 'Mechanical and membrane keyboards', NULL, 'active', '2026-02-28 09:19:06'),
(3, 'Headphones', 'CAT-HDP', 'Gaming and music headphones', NULL, 'active', '2026-02-28 09:19:06'),
(4, 'Cables & Adapters', 'CAT-CBL', 'USB cables, HDMI, adapters and connectors', NULL, 'active', '2026-02-28 09:19:06'),
(5, 'Storage Devices', 'CAT-STO', 'SSD, HDD, Flash drives and memory cards', NULL, 'active', '2026-02-28 09:19:06'),
(6, 'Webcams', 'CAT-WEB', 'HD and 4K webcams for streaming and conferences', NULL, 'active', '2026-02-28 09:19:06'),
(7, 'Laptop Accessories', 'CAT-LAP', 'Laptop stands, bags, coolers and docks', NULL, 'active', '2026-02-28 09:19:06'),
(8, 'Networking', 'CAT-NET', 'Routers, switches, network cards and cables', NULL, 'active', '2026-02-28 09:19:06'),
(9, 'Software', 'CAT-SOFT', 'Operating systems, office software and antivirus', NULL, 'active', '2026-02-28 09:19:06'),
(10, 'Printers & Scanners', 'CAT-PRN', 'Printers, scanners, toners and papers', NULL, 'active', '2026-02-28 09:19:06');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `customer_code` varchar(50) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `customer_type` enum('regular','vip','wholesale') DEFAULT 'regular',
  `total_purchases` decimal(15,2) DEFAULT 0.00,
  `total_orders` int(11) DEFAULT 0,
  `last_purchase_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_code`, `name`, `email`, `phone`, `address`, `city`, `customer_type`, `total_purchases`, `total_orders`, `last_purchase_date`, `notes`, `status`, `created_at`, `updated_at`) VALUES
(1, 'CUST-001', 'John Doe', 'john.doe@email.com', '0712 345 678', '123 Main Street', 'Dar es Salaam', 'vip', 0.00, 0, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(2, 'CUST-002', 'Jane Smith', 'jane.smith@email.com', '0723 456 789', '456 Park Avenue', 'Dar es Salaam', 'regular', 0.00, 0, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(3, 'CUST-003', 'Mike Johnson', 'mike.j@email.com', '0734 567 890', '789 Beach Road', 'Mombasa', 'wholesale', 0.00, 0, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(4, 'CUST-004', 'Sarah Wilson', 'sarah.w@email.com', '0745 678 901', '321 Hill Street', 'Arusha', 'regular', 0.00, 0, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(5, 'CUST-005', 'Tech Solutions Ltd', 'info@techsol.co.tz', '0756 789 012', '789 Industrial Area', 'Dar es Salaam', 'wholesale', 0.00, 0, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(6, 'CUST-006', 'Digital World Store', 'digital@world.co.tz', '0767 890 123', '456 Market Street', 'Dar es Salaam', 'wholesale', 0.00, 0, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(7, 'CUST-007', 'James Brown', 'james.b@email.com', '0778 901 234', '123 Valley Road', 'Dodoma', 'regular', 0.00, 0, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(8, 'CUST-008', 'Emily Davis', 'emily.d@email.com', '0789 012 345', '789 Lake View', 'Mwanza', 'vip', 0.00, 0, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `expense_date` date NOT NULL,
  `expense_category` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `payment_method` enum('cash','card','mpesa','bank') DEFAULT 'cash',
  `reference_no` varchar(100) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `payment_no` varchar(50) DEFAULT NULL,
  `reference_type` enum('sale','purchase') NOT NULL,
  `reference_id` int(11) NOT NULL,
  `payment_date` datetime DEFAULT current_timestamp(),
  `amount` decimal(15,2) NOT NULL,
  `payment_method` enum('cash','card','mpesa','bank') NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `product_code` varchar(50) NOT NULL,
  `product_name` varchar(200) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `buying_price` decimal(15,2) DEFAULT 0.00,
  `selling_price` decimal(15,2) DEFAULT 0.00,
  `quantity` int(11) DEFAULT 0,
  `low_stock_threshold` int(11) DEFAULT 5,
  `unit` varchar(20) DEFAULT 'pcs',
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `warranty_period` int(11) DEFAULT 0,
  `warranty_type` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_code`, `product_name`, `category_id`, `supplier_id`, `description`, `buying_price`, `selling_price`, `quantity`, `low_stock_threshold`, `unit`, `brand`, `model`, `warranty_period`, `warranty_type`, `location`, `image_path`, `status`, `created_at`, `updated_at`) VALUES
(1, 'MOU-001', 'Logitech G502 Hero Gaming Mouse', 1, 1, NULL, 55000.00, 85000.00, 45, 5, 'pcs', 'Logitech', 'G502 Hero', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(2, 'MOU-002', 'Razer DeathAdder V2', 1, 2, NULL, 60000.00, 95000.00, 30, 5, 'pcs', 'Razer', 'DeathAdder V2', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(3, 'MOU-003', 'SteelSeries Rival 600', 1, 2, NULL, 70000.00, 110000.00, 15, 5, 'pcs', 'SteelSeries', 'Rival 600', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(4, 'MOU-004', 'Corsair Dark Core RGB', 1, 1, NULL, 75000.00, 120000.00, 8, 3, 'pcs', 'Corsair', 'Dark Core', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(5, 'MOU-005', 'HP Gaming Mouse X1000', 1, 3, NULL, 25000.00, 42000.00, 12, 5, 'pcs', 'HP', 'X1000', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(6, 'KEY-001', 'Corsair K70 RGB Mechanical Keyboard', 2, 1, NULL, 90000.00, 145000.00, 12, 3, 'pcs', 'Corsair', 'K70 RGB', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(7, 'KEY-002', 'Logitech G213 Prodigy', 2, 1, NULL, 35000.00, 55000.00, 3, 5, 'pcs', 'Logitech', 'G213', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(8, 'KEY-003', 'Redragon K552 Mechanical Keyboard', 2, 2, NULL, 25000.00, 45000.00, 25, 5, 'pcs', 'Redragon', 'K552', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(9, 'KEY-004', 'HP Wireless Keyboard', 2, 3, NULL, 15000.00, 28000.00, 18, 5, 'pcs', 'HP', 'Wireless', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(10, 'KEY-005', 'Apple Magic Keyboard', 2, 4, NULL, 80000.00, 130000.00, 2, 2, 'pcs', 'Apple', 'Magic', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(11, 'HDP-001', 'Sony WH-1000XM4 Wireless Headphones', 3, 4, NULL, 180000.00, 250000.00, 8, 2, 'pcs', 'Sony', 'WH-1000XM4', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(12, 'HDP-002', 'HyperX Cloud II Gaming Headset', 3, 2, NULL, 80000.00, 130000.00, 20, 5, 'pcs', 'HyperX', 'Cloud II', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(13, 'HDP-003', 'JBL Quantum 800', 3, 2, NULL, 110000.00, 175000.00, 2, 2, 'pcs', 'JBL', 'Quantum 800', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(14, 'HDP-004', 'Logitech G433 Gaming Headset', 3, 1, NULL, 65000.00, 105000.00, 7, 3, 'pcs', 'Logitech', 'G433', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(15, 'HDP-005', 'Apple AirPods Pro', 3, 4, NULL, 160000.00, 240000.00, 4, 2, 'pcs', 'Apple', 'AirPods Pro', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(16, 'CBL-001', 'USB-C to HDMI Adapter', 4, 1, NULL, 15000.00, 28000.00, 50, 10, 'pcs', 'Anker', 'A8362', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(17, 'CBL-002', '10m HDMI 2.1 Cable', 4, 1, NULL, 18000.00, 32000.00, 35, 10, 'pcs', 'Belkin', 'HDMI-10M', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(18, 'CBL-003', '6-in-1 USB-C Hub', 4, 1, NULL, 25000.00, 45000.00, 8, 5, 'pcs', 'Anker', 'PowerExpand', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(19, 'CBL-004', 'Ethernet Cable 20m', 4, 3, NULL, 12000.00, 22000.00, 22, 5, 'pcs', 'TP-Link', 'CAT6', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(20, 'CBL-005', 'VGA to HDMI Adapter', 4, 3, NULL, 10000.00, 18000.00, 15, 5, 'pcs', 'UGREEN', 'VGA-HDMI', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(21, 'STO-001', 'Samsung T7 1TB External SSD', 5, 4, NULL, 120000.00, 180000.00, 15, 3, 'pcs', 'Samsung', 'T7', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(22, 'STO-002', 'SanDisk 128GB USB 3.0 Flash Drive', 5, 1, NULL, 15000.00, 28000.00, 60, 10, 'pcs', 'SanDisk', 'Ultra Fit', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(23, 'STO-003', 'WD 2TB External HDD', 5, 3, NULL, 95000.00, 145000.00, 10, 3, 'pcs', 'WD', 'Elements', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(24, 'STO-004', 'Samsung 970 EVO 500GB NVMe SSD', 5, 4, NULL, 85000.00, 135000.00, 5, 2, 'pcs', 'Samsung', '970 EVO', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(25, 'STO-005', 'Kingston 32GB USB Drive', 5, 1, NULL, 8000.00, 15000.00, 45, 10, 'pcs', 'Kingston', 'DataTraveler', 0, NULL, NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` int(11) NOT NULL,
  `po_number` varchar(50) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `order_date` date NOT NULL,
  `expected_delivery` date DEFAULT NULL,
  `actual_delivery` date DEFAULT NULL,
  `status` enum('draft','sent','confirmed','received','cancelled') DEFAULT 'draft',
  `subtotal` decimal(15,2) DEFAULT 0.00,
  `tax_amount` decimal(15,2) DEFAULT 0.00,
  `discount_amount` decimal(15,2) DEFAULT 0.00,
  `total_amount` decimal(15,2) DEFAULT 0.00,
  `payment_status` enum('paid','partial','unpaid') DEFAULT 'unpaid',
  `payment_method` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_items`
--

CREATE TABLE `purchase_order_items` (
  `id` int(11) NOT NULL,
  `po_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `received_quantity` int(11) DEFAULT 0,
  `unit_price` decimal(15,2) NOT NULL,
  `total_price` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `invoice_no` varchar(50) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `sale_date` datetime DEFAULT current_timestamp(),
  `subtotal` decimal(15,2) DEFAULT 0.00,
  `tax_amount` decimal(15,2) DEFAULT 0.00,
  `discount_amount` decimal(15,2) DEFAULT 0.00,
  `total_amount` decimal(15,2) DEFAULT 0.00,
  `payment_method` enum('cash','card','mpesa','bank','credit') DEFAULT 'cash',
  `payment_status` enum('paid','partial','pending','cancelled') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `invoice_no`, `customer_id`, `user_id`, `sale_date`, `subtotal`, `tax_amount`, `discount_amount`, `total_amount`, `payment_method`, `payment_status`, `notes`, `created_at`) VALUES
(1, 'INV-2025-001', 1, 1, '2026-02-28 12:19:07', 178000.00, 0.00, 0.00, 178000.00, 'cash', 'paid', NULL, '2026-02-28 09:19:07'),
(2, 'INV-2025-002', 2, 1, '2026-02-28 12:19:07', 205000.00, 0.00, 0.00, 205000.00, 'card', 'paid', NULL, '2026-02-28 09:19:07'),
(3, 'INV-2025-003', 3, 2, '2026-02-28 12:19:07', 45000.00, 0.00, 0.00, 45000.00, 'mpesa', 'paid', NULL, '2026-02-28 09:19:07'),
(4, 'INV-2025-004', 1, 1, '2026-02-28 12:19:07', 255000.00, 0.00, 0.00, 255000.00, 'card', 'paid', NULL, '2026-02-28 09:19:07'),
(5, 'INV-2025-005', 5, 2, '2026-02-28 12:19:07', 560000.00, 0.00, 0.00, 560000.00, 'bank', 'pending', NULL, '2026-02-28 09:19:07'),
(6, 'INV-2025-006', 4, 3, '2026-02-28 12:19:07', 130000.00, 0.00, 0.00, 130000.00, 'cash', 'paid', NULL, '2026-02-28 09:19:07'),
(7, 'INV-2025-007', 7, 1, '2026-02-28 12:19:07', 85000.00, 0.00, 0.00, 85000.00, 'mpesa', 'pending', NULL, '2026-02-28 09:19:07'),
(8, 'INV-2025-008', 8, 2, '2026-02-28 12:19:07', 370000.00, 0.00, 0.00, 370000.00, 'card', 'paid', NULL, '2026-02-28 09:19:07');

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `discount` decimal(15,2) DEFAULT 0.00,
  `total_price` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `quantity`, `unit_price`, `discount`, `total_price`, `created_at`) VALUES
(1, 1, 1, 2, 85000.00, 0.00, 170000.00, '2026-02-28 09:19:08'),
(2, 1, 5, 1, 8000.00, 0.00, 8000.00, '2026-02-28 09:19:08'),
(3, 2, 3, 1, 110000.00, 0.00, 110000.00, '2026-02-28 09:19:08'),
(4, 2, 1, 1, 85000.00, 0.00, 85000.00, '2026-02-28 09:19:08'),
(5, 2, 5, 2, 5000.00, 0.00, 10000.00, '2026-02-28 09:19:08'),
(6, 3, 11, 1, 45000.00, 0.00, 45000.00, '2026-02-28 09:19:08'),
(7, 4, 2, 1, 95000.00, 0.00, 95000.00, '2026-02-28 09:19:08'),
(8, 4, 7, 1, 145000.00, 0.00, 145000.00, '2026-02-28 09:19:08'),
(9, 4, 17, 1, 15000.00, 0.00, 15000.00, '2026-02-28 09:19:08'),
(10, 5, 8, 5, 55000.00, 0.00, 275000.00, '2026-02-28 09:19:08'),
(11, 5, 15, 3, 95000.00, 0.00, 285000.00, '2026-02-28 09:19:08'),
(12, 6, 6, 1, 130000.00, 0.00, 130000.00, '2026-02-28 09:19:08'),
(13, 7, 1, 1, 85000.00, 0.00, 85000.00, '2026-02-28 09:19:08'),
(14, 8, 9, 1, 45000.00, 0.00, 45000.00, '2026-02-28 09:19:08'),
(15, 8, 14, 1, 175000.00, 0.00, 175000.00, '2026-02-28 09:19:08'),
(16, 8, 16, 1, 150000.00, 0.00, 150000.00, '2026-02-28 09:19:08');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` enum('text','number','boolean','json') DEFAULT 'text',
  `description` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `setting_type`, `description`, `updated_by`, `updated_at`) VALUES
(1, 'company_name', 'TechZone Computers', 'text', 'Jina la kampuni', NULL, '2026-02-28 09:19:08'),
(2, 'company_email', 'info@techzone.co.tz', 'text', 'Barua pepe ya kampuni', NULL, '2026-02-28 09:19:08'),
(3, 'company_phone', '0712 345 678', 'text', 'Namba ya simu', NULL, '2026-02-28 09:19:08'),
(4, 'company_address', '123 Main Street, Dar es Salaam', 'text', 'Anwani ya kampuni', NULL, '2026-02-28 09:19:08'),
(5, 'tax_rate', '18', 'number', 'VAT rate asilimia', NULL, '2026-02-28 09:19:08'),
(6, 'currency', 'TSh', 'text', 'Sarafu inayotumika', NULL, '2026-02-28 09:19:08'),
(7, 'low_stock_alert', '1', 'boolean', 'Tuma alert stock ikishuka', NULL, '2026-02-28 09:19:08'),
(8, 'invoice_prefix', 'INV-', 'text', 'Prefix kwa invoice numbers', NULL, '2026-02-28 09:19:08'),
(9, 'business_type', 'retail', 'text', 'Aina ya biashara', NULL, '2026-02-28 09:19:08');

-- --------------------------------------------------------

--
-- Table structure for table `stock_movements`
--

CREATE TABLE `stock_movements` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `movement_type` enum('purchase','sale','return','adjustment','damage') NOT NULL,
  `quantity` int(11) NOT NULL,
  `previous_quantity` int(11) DEFAULT NULL,
  `new_quantity` int(11) DEFAULT NULL,
  `reference_type` varchar(50) DEFAULT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `unit_price` decimal(15,2) DEFAULT NULL,
  `total_price` decimal(15,2) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `supplier_code` varchar(50) DEFAULT NULL,
  `company_name` varchar(200) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `payment_terms` varchar(100) DEFAULT NULL,
  `tax_number` varchar(50) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `supplier_code`, `company_name`, `contact_person`, `email`, `phone`, `address`, `city`, `payment_terms`, `tax_number`, `status`, `created_at`, `updated_at`) VALUES
(1, 'SUP-001', 'Tech Distributors Ltd', 'Robert Mushi', 'robert@techdist.co.tz', '0712 345 678', NULL, 'Dar es Salaam', NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(2, 'SUP-002', 'Gaming Gear Africa', 'Sarah Kimani', 'sarah@gaminggear.co.ke', '0723 456 789', NULL, 'Nairobi', NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(3, 'SUP-003', 'Computer Parts Wholesale', 'David Ochieng', 'david@compparts.co.ke', '0734 567 890', NULL, 'Mombasa', NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07'),
(4, 'SUP-004', 'Electronics Importers', 'Aisha Mohammed', 'aisha@elecimport.co.tz', '0745 678 901', NULL, 'Dar es Salaam', NULL, NULL, 'active', '2026-02-28 09:19:07', '2026-02-28 09:19:07');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `task_title` varchar(200) NOT NULL,
  `task_description` text DEFAULT NULL,
  `assigned_to` int(11) DEFAULT NULL,
  `assigned_by` int(11) DEFAULT NULL,
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `status` enum('pending','in_progress','completed','cancelled') DEFAULT 'pending',
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `completed_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `task_title`, `task_description`, `assigned_to`, `assigned_by`, `priority`, `status`, `start_date`, `due_date`, `completed_date`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'Check low stock items', 'Review all products with stock below threshold and create purchase orders', 2, 1, 'high', 'pending', NULL, '2025-03-05', NULL, NULL, '2026-02-28 09:19:08', '2026-02-28 09:19:08'),
(2, 'Update product prices', 'Review and update selling prices for new stock', 3, 1, 'medium', 'in_progress', NULL, '2025-03-03', NULL, NULL, '2026-02-28 09:19:08', '2026-02-28 09:19:08'),
(3, 'Contact supplier', 'Follow up on pending order with Tech Distributors', 2, 1, 'urgent', 'pending', NULL, '2025-03-02', NULL, NULL, '2026-02-28 09:19:08', '2026-02-28 09:19:08'),
(4, 'Clean inventory', 'Organize and clean the inventory room', 3, 2, 'low', 'completed', NULL, '2025-02-28', NULL, NULL, '2026-02-28 09:19:08', '2026-02-28 09:19:08'),
(5, 'Prepare monthly report', 'Generate sales report for February 2025', 2, 1, 'high', 'pending', NULL, '2025-03-01', NULL, NULL, '2026-02-28 09:19:08', '2026-02-28 09:19:08'),
(6, 'Customer follow-up', 'Call VIP customers for feedback', 3, 2, 'medium', 'pending', NULL, '2025-03-04', NULL, NULL, '2026-02-28 09:19:08', '2026-02-28 09:19:08');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','manager','staff') DEFAULT 'staff',
  `shop_name` varchar(100) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `role`, `shop_name`, `profile_image`, `created_at`, `updated_at`) VALUES
(1, 'Alex John', 'alex@bizflow.com', 'admin123', 'admin', 'TechZone Computers', NULL, '2026-02-28 09:19:05', '2026-02-28 09:19:05'),
(2, 'Maria Garcia', 'maria@bizflow.com', 'manager123', 'manager', 'TechZone Computers', NULL, '2026-02-28 09:19:05', '2026-02-28 09:19:05'),
(3, 'John Smith', 'john@bizflow.com', 'staff123', 'staff', 'TechZone Computers', NULL, '2026-02-28 09:19:05', '2026-02-28 09:19:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_code` (`category_code`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_code` (`customer_code`),
  ADD KEY `idx_customer_email` (`email`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_no` (`payment_no`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_code` (`product_code`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `idx_product_category` (`category_id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `po_number` (`po_number`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `po_id` (`po_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_no` (`invoice_no`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_sale_date` (`sale_date`),
  ADD KEY `idx_invoice_no` (`invoice_no`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `supplier_code` (`supplier_code`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_to` (`assigned_to`),
  ADD KEY `assigned_by` (`assigned_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `stock_movements`
--
ALTER TABLE `stock_movements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `purchase_orders_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD CONSTRAINT `purchase_order_items_ibfk_1` FOREIGN KEY (`po_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `sale_items_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sale_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD CONSTRAINT `stock_movements_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_movements_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
