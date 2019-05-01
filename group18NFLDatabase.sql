-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Apr 30, 2019 at 06:06 PM
-- Server version: 10.3.13-MariaDB-log
-- PHP Version: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_burrisl`
--

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `teamID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `year_founded` int(11) DEFAULT NULL,
  `majority_owner` varchar(255) DEFAULT NULL,
  `conference` varchar(255) NOT NULL,
  `division` varchar(255) NOT NULL,
  PRIMARY KEY (`teamID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `coach`
--

CREATE TABLE `coach` (
  `coachID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `teamID` int(11) DEFAULT NULL,
  PRIMARY KEY (`coachID`),
  KEY `teamID` (`teamID`),
  CONSTRAINT `coach_ibfk_1` FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `corporateSponsor`
--

CREATE TABLE `corporateSponsor` (
  `sponsorID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `productType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sponsorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `playerID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `height` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `teamID` int(11) DEFAULT NULL,
  PRIMARY KEY (`playerID`),
  KEY `teamID` (`teamID`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `seasonStatistics`
--

CREATE TABLE `seasonStatistics` (
  `playerID` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `passingAttempts` int(11) DEFAULT NULL,
  `passingCompletions` int(11) DEFAULT NULL,
  `passingYards` int(11) DEFAULT NULL,
  `passingTouchdowns` int(11) DEFAULT NULL,
  `receptions` int(11) DEFAULT NULL,
  `receivingYards` int(11) DEFAULT NULL,
  `receivingTouchdowns` int(11) DEFAULT NULL,
  `rushes` int(11) DEFAULT NULL,
  `rushingYards` int(11) DEFAULT NULL,
  `rushingTouchdowns` int(11) DEFAULT NULL,
  `tackles` int(11) DEFAULT NULL,
  `sacks` int(11) DEFAULT NULL,
  `interceptions` int(11) DEFAULT NULL,
  PRIMARY KEY (`playerID`,`year`),
  CONSTRAINT `seasonStatistics_ibfk_1` FOREIGN KEY (`playerID`) REFERENCES `player` (`playerID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sponsoredPlayers`
--

CREATE TABLE `sponsoredPlayers` (
  `playerID` int(11) NOT NULL,
  `sponsorID` int(11) NOT NULL,
  PRIMARY KEY (`playerID`,`sponsorID`),
  KEY `sponsorID` (`sponsorID`),
  CONSTRAINT `sponsoredPlayers_ibfk_1` FOREIGN KEY (`playerID`) REFERENCES `player` (`playerID`) ON UPDATE CASCADE,
  CONSTRAINT `sponsoredPlayers_ibfk_2` FOREIGN KEY (`sponsorID`) REFERENCES `corporateSponsor` (`sponsorID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
