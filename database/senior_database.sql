-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2021 at 12:25 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `senior_database_v2`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_admin`
--

CREATE TABLE `tb_admin` (
  `ad_id` int(11) NOT NULL,
  `ad_username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ad_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ad_FirstName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ad_LastName` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_data`
--

CREATE TABLE `tb_data` (
  `d_id` int(11) NOT NULL,
  `d_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `d_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tb_data`
--

INSERT INTO `tb_data` (`d_id`, `d_name`, `d_date`) VALUES
(1, 'Result_2021-01-06.xlsx', '2021-01-06');

-- --------------------------------------------------------

--
-- Table structure for table `tb_topkeyword`
--

CREATE TABLE `tb_topkeyword` (
  `k_id` int(11) NOT NULL,
  `k_keyword` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `k_count` int(11) DEFAULT NULL,
  `k_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tb_topkeyword`
--

INSERT INTO `tb_topkeyword` (`k_id`, `k_keyword`, `k_count`, `k_date`) VALUES
(1, '63', 104, '2020-11-17'),
(2, 'เมท', 80, '2020-11-17'),
(3, 'dek', 76, '2020-11-17'),
(4, 'รอบ', 53, '2020-11-17'),
(5, 'หา', 48, '2020-11-17'),
(6, 'เรียน', 14, '2021-01-05'),
(7, 'ประกาศ', 12, '2021-01-05'),
(8, 'จีน', 7, '2021-01-05'),
(9, 'อีหลี', 6, '2021-01-05'),
(10, 'ออนไลน์', 6, '2021-01-05'),
(11, 'รับสมัคร', 88, '2021-01-06'),
(12, 'ออนไลน์', 49, '2021-01-06'),
(13, 'Porfolio', 46, '2021-01-06'),
(14, 'มหาวิทยาลัย', 44, '2021-01-06'),
(15, '64', 42, '2021-01-06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_admin`
--
ALTER TABLE `tb_admin`
  ADD PRIMARY KEY (`ad_id`);

--
-- Indexes for table `tb_data`
--
ALTER TABLE `tb_data`
  ADD PRIMARY KEY (`d_id`);

--
-- Indexes for table `tb_topkeyword`
--
ALTER TABLE `tb_topkeyword`
  ADD PRIMARY KEY (`k_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_admin`
--
ALTER TABLE `tb_admin`
  MODIFY `ad_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_data`
--
ALTER TABLE `tb_data`
  MODIFY `d_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_topkeyword`
--
ALTER TABLE `tb_topkeyword`
  MODIFY `k_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
