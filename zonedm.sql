-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2022 at 04:44 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zonedm`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `acc_dbid` int(11) NOT NULL,
  `acc_name` varchar(32) CHARACTER SET latin1 NOT NULL,
  `acc_pass` varchar(255) CHARACTER SET latin1 NOT NULL,
  `Admin` int(11) NOT NULL,
  `Skin` int(11) NOT NULL DEFAULT 3,
  `Score` int(32) NOT NULL DEFAULT 500,
  `Cash` int(11) NOT NULL,
  `PMS` int(11) NOT NULL,
  `register_ip` varchar(60) CHARACTER SET latin1 DEFAULT NULL,
  `register_date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`acc_dbid`, `acc_name`, `acc_pass`, `Admin`, `Skin`, `Score`, `Cash`, `PMS`, `register_ip`, `register_date`) VALUES
(1, 'Ragnarok', '7c222fb2927d828af22f592134e8932480637c0d', 2, 294, 0, 0, 0, '192.168.0.102', 0),
(2, 'Ragnaroktest', '7c222fb2927d828af22f592134e8932480637c0d', 0, 3, 500, 0, 0, '192.168.0.102', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`acc_dbid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `acc_dbid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
