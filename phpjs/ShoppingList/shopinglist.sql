-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 18, 2022 at 11:21 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `xdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `shopinglist`
--

CREATE TABLE `shopinglist` (
  `id` int(100) NOT NULL,
  `item` varchar(200) DEFAULT NULL,
  `quantity` int(100) NOT NULL,
  `isdone` int(1) NOT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `shopinglist`
--

INSERT INTO `shopinglist` (`id`, `item`, `quantity`, `isdone`) VALUES
(null, 'Apple', 10, 0),
(null, 'Banana', 5, 1),
(null, 'Mango', 9, 0),
(null, 'Orange', 5, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `shopinglist`
--
ALTER TABLE `shopinglist` ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `shopinglist`
--
ALTER TABLE `shopinglist`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
