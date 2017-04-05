-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2017 at 07:37 PM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ces-time-tracker`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAllEmployees`()
    NO SQL
SELECT EmployeeID, FirstName, LastName
FROM employees$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAllEmployeesTime`()
    NO SQL
SELECT 
	e.EmployeeNum, e.FirstName, e.LastName, e.Rate, 
	r.StartTime, r.EndTime, r.Recorded,
    j.JobName
FROM 
	employees e 
	INNER JOIN recordedtime r ON e.EmployeeID = r.EmployeeID
    INNER JOIN jobs j ON r.JobID = j.JobID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAllJobs`()
    NO SQL
SELECT JobID, JobName, JobNum, Address, Latitude, Longitude
FROM jobs$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getEmployeeByID`(IN `ID` INT)
    NO SQL
SELECT EmployeeID, FirstName, LastName, Rate
FROM employees
WHERE EmployeeID = ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getJobByJobNum`(IN `ID` INT(20))
    NO SQL
SELECT Address, JobName, JobNum, Latitude, Longitude
FROM jobs
WHERE JobID = ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getTimeByID`(IN `ID` INT)
    NO SQL
SELECT 
	e.EmployeeNum, e.FirstName, e.LastName, e.Rate, 
	r.StartTime, r.EndTime, r.Recorded,
    j.JobName
FROM 
	employees e 
	INNER JOIN recordedtime r ON e.EmployeeID = r.EmployeeID
    INNER JOIN jobs j ON r.JobID = j.JobID
    WHERE r.EmployeeID = ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertEmployee`(IN `FirstName` VARCHAR(255), IN `LastName` VARCHAR(255), IN `Rate` DECIMAL(13,2))
    NO SQL
INSERT INTO employees (FirstName, LastName, Rate)
VALUES (FirstName, LastName, Rate)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertJob`(IN `Address` VARCHAR(255), IN `JobName` VARCHAR(255), IN `JobNum` INT(20), IN `Latitude` DECIMAL(10,8), IN `Longitude` DECIMAL(11,8))
    NO SQL
INSERT INTO jobs (Address, JobName, JobNum, Latitude, Longitude)
VALUES (Address, JobName, JobNum, Latitude, Longitude)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertTime`(IN `JobID` INT, IN `EmployeeID` INT, IN `StartTime` TIME, IN `EndTime` TIME)
    NO SQL
INSERT INTO recordedtime (JobID, EmployeeID, StartTime, EndTime)
VALUES (JobID, EmployeeID, StartTime, EndTime)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE IF NOT EXISTS `employees` (
  `EmployeeID` int(11) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `EmployeeNum` int(20) NOT NULL,
  `Rate` decimal(13,2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`EmployeeID`, `LastName`, `FirstName`, `EmployeeNum`, `Rate`) VALUES
(1, 'EmployeeLN', 'EmployeeFN', 1, '22.50'),
(2, 'Jones', 'Bobby', 0, '20.25'),
(3, 'Elliot', 'Sam', 0, '16.25');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE IF NOT EXISTS `jobs` (
  `JobID` int(11) NOT NULL,
  `JobName` varchar(255) NOT NULL,
  `JobNum` int(20) DEFAULT NULL,
  `Address` varchar(255) NOT NULL,
  `Latitude` decimal(10,8) DEFAULT NULL,
  `Longitude` decimal(11,8) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`JobID`, `JobName`, `JobNum`, `Address`, `Latitude`, `Longitude`) VALUES
(1, 'CES', 12017, '60 Romney Street, Charleston SC 29403', '32.80763900', '-79.94640900'),
(2, 'Hardees', 2105, '7409 Magi Rd, Hanahan, SC 29410', '32.95042600', '-80.00662900');

-- --------------------------------------------------------

--
-- Table structure for table `recordedtime`
--

CREATE TABLE IF NOT EXISTS `recordedtime` (
  `TimeID` int(11) NOT NULL,
  `JobID` int(11) NOT NULL,
  `EmployeeID` int(11) NOT NULL,
  `StartTime` time DEFAULT '00:00:00',
  `EndTime` time DEFAULT '00:00:00',
  `Recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recordedtime`
--

INSERT INTO `recordedtime` (`TimeID`, `JobID`, `EmployeeID`, `StartTime`, `EndTime`, `Recorded`) VALUES
(1, 1, 1, '00:00:00', '02:05:15', '2017-03-23 14:11:47'),
(2, 2, 2, '00:00:00', '01:24:49', '2017-03-24 11:07:23'),
(3, 1, 2, '00:00:00', '00:34:08', '2017-03-24 11:17:04'),
(4, 1, 1, '00:00:00', '03:52:08', '2017-03-30 13:42:53'),
(5, 1, 1, '00:00:00', '01:01:01', '2017-04-05 11:26:14'),
(6, 2, 1, '00:00:00', '03:03:03', '2017-04-05 11:28:33'),
(7, 2, 1, '00:00:00', '03:03:03', '2017-04-05 11:29:20'),
(8, 1, 2, '00:00:00', '03:03:03', '2017-04-05 11:44:42'),
(9, 1, 2, '00:00:00', '05:05:05', '2017-04-05 11:46:13'),
(10, 1, 2, '00:00:00', '09:09:09', '2017-04-05 11:53:26'),
(11, 2, 2, '00:00:00', '19:19:19', '2017-04-05 11:55:36'),
(12, 2, 1, '00:00:00', '00:00:10', '2017-04-05 12:00:27'),
(15, 2, 1, '00:00:00', '00:00:00', '2017-04-05 12:37:01'),
(21, 1, 1, '00:00:00', '00:00:00', '2017-04-05 12:44:41'),
(22, 2, 2, '00:00:00', '00:00:12', '2017-04-05 12:48:57'),
(23, 1, 1, '00:00:00', '00:00:16', '2017-04-05 13:16:58'),
(24, 2, 3, '00:00:00', '00:00:06', '2017-04-05 13:31:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EmployeeID`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`JobID`);

--
-- Indexes for table `recordedtime`
--
ALTER TABLE `recordedtime`
  ADD PRIMARY KEY (`TimeID`),
  ADD KEY `JobID` (`JobID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `EmployeeID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `JobID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `recordedtime`
--
ALTER TABLE `recordedtime`
  MODIFY `TimeID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `recordedtime`
--
ALTER TABLE `recordedtime`
  ADD CONSTRAINT `recordedtime_ibfk_1` FOREIGN KEY (`JobID`) REFERENCES `jobs` (`JobID`),
  ADD CONSTRAINT `recordedtime_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
