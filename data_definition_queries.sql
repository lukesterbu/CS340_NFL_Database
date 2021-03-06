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
-- Drop tables if they exist
--

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `coach`;
DROP TABLE IF EXISTS `seasonStatistics`;
DROP TABLE IF EXISTS `sponsoredPlayers`;
DROP TABLE IF EXISTS `player`;
DROP TABLE IF EXISTS `team`;
DROP TABLE IF EXISTS `corporateSponsor`;
SET FOREIGN_KEY_CHECKS = 1;

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `teamID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
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
  CONSTRAINT `seasonStatistics_ibfk_1` FOREIGN KEY (`playerID`) REFERENCES `player` (`playerID`) ON DELETE CASCADE
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
  CONSTRAINT `sponsoredPlayers_ibfk_1` FOREIGN KEY (`playerID`) REFERENCES `player` (`playerID`) ON DELETE CASCADE,
  CONSTRAINT `sponsoredPlayers_ibfk_2` FOREIGN KEY (`sponsorID`) REFERENCES `corporateSponsor` (`sponsorID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- *****************************
-- Sample Data for NFL Database
-- *****************************

-- Reset IDs to start at 1

ALTER TABLE team AUTO_INCREMENT = 1;
ALTER TABLE coach AUTO_INCREMENT = 1;
ALTER TABLE corporateSponsor AUTO_INCREMENT = 1;
ALTER TABLE player AUTO_INCREMENT = 1;

-- INSERT into team table

INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Bills','Buffalo',1970,NULL,'American Football Conference','East');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Dolphins','Miami',1970,NULL,'American Football Conference','East');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Patriots','New England',1970,NULL,'American Football Conference','East');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Jets','New York',1970,NULL,'American Football Conference','East');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Ravens','Baltimore',1997,NULL,'American Football Conference','North');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Bengals','Cincinnati',1970,NULL,'American Football Conference','North');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Browns','Cleveland',1950,NULL,'American Football Conference','North');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Steelers','Pittsburgh',1933,NULL,'American Football Conference','North');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Texans','Houston',2002,NULL,'American Football Conference','South');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Colts','Indianapolis',1953,NULL,'American Football Conference','South');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Jaguars','Jacksonville',1995,NULL,'American Football Conference','South');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Titans','Tennessee',1970,NULL,'American Football Conference','South');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Broncos','Denver',1970,NULL,'American Football Conference','West');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Chiefs','Kansas City',1970,NULL,'American Football Conference','West');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Chargers','Los Angeles',1970,NULL,'American Football Conference','West');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Raiders','Oakland',1970,NULL,'American Football Conference','West');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Cowboys','Dallas',1960,NULL,'National Football Conference','East');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Giants','New York',1925,NULL,'National Football Conference','East');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Eagles','Philadelphia',1933,NULL,'National Football Conference','East');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Redskins','Washington',1932,NULL,'National Football Conference','East');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Bears','Chicago',1922,NULL,'National Football Conference','North');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Lions','Detroit',1930,NULL,'National Football Conference','North');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Packers','Green Bay',1921,NULL,'National Football Conference','North');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Vikings','Minnesota',1961,NULL,'National Football Conference','North');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Falcons','Atlanta',1966,NULL,'National Football Conference','South');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Panthers','Carolina',1995,NULL,'National Football Conference','South');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Saints','New Orleans',1967,NULL,'National Football Conference','South');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Buccaneers','Tampa Bay',1976,NULL,'National Football Conference','South');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Cardinals','Arizona',1920,NULL,'National Football Conference','West');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Rams','Los Angeles',1937,NULL,'National Football Conference','West');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('49ers','San Francisco',1950,NULL,'National Football Conference','West');
INSERT INTO team(name,location,year_founded,majority_owner,conference,division) VALUES ('Seahawks','Seattle',1976,NULL,'National Football Conference','West');

-- INSERT into coach table

INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Kliff','Kingsbury','Head Coach',29);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Dan','Quinn','Head Coach',25);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('John','Harbaugh','Head Coach',5);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Sean','McDermott','Head Coach',1);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Ron','Rivera','Head Coach',26);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Matt','Nagy','Head Coach',21);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Zac','Taylor','Head Coach',6);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Freddie','Kitchens','Head Coach',7);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Jason','Garrett','Head Coach',17);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Vic','Fangio','Head Coach',13);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Matt','Patricia','Head Coach',22);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Matt','LaFleur','Head Coach',23);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Bill','O''Brien','Head Coach',9);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Frank','Reich','Head Coach',10);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Doug','Marrone','Head Coach',11);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Andy','Reid','Head Coach',14);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Anthony','Lynn','Head Coach',15);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Sean','McVay','Head Coach',30);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Brian','Flores','Head Coach',2);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Mike','Zimmer','Head Coach',24);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Bill','Belichick','Head Coach',3);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Sean','Payton','Head Coach',27);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Pat','Shurmur','Head Coach',18);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Adam','Gase','Head Coach',4);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Jon','Gruden','Head Coach',16);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Doug','Pederson','Head Coach',19);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Mike','Tomlin','Head Coach',8);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Kyle','Shanahan','Head Coach',31);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Pete','Carroll','Head Coach',32);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Bruce','Arians','Head Coach',28);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Mike','Vrabel','Head Coach',12);
INSERT INTO coach(firstName,lastName,title,teamID) VALUES ('Jay','Gruden','Head Coach',20);

-- INSERT into corporateSponsor table

INSERT INTO corporateSponsor(name,productType) VALUES ('Nike','Apparel');
INSERT INTO corporateSponsor(name,productType) VALUES ('Gatorade','Sports Drink');
INSERT INTO corporateSponsor(name,productType) VALUES ('Adidas','Apparel');
INSERT INTO corporateSponsor(name,productType) VALUES ('Powerade','Sports Drink');

-- INSERT into player

INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Todd','Gurley II','Running Back',NULL,NULL,30);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('David','Johnson','Running Back',NULL,NULL,29);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ezekiel','Elliott','Running Back',NULL,NULL,17);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Alvin','Kamara','Running Back',NULL,NULL,27);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Antonio','Brown','Wide Receiver',NULL,NULL,8);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Saquon','Barkley','Running Back',NULL,NULL,18);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Dalvin','Cook','Running Back',NULL,NULL,24);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Melvin','Gordon','Running Back',NULL,NULL,15);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Julio','Jones','Wide Receiver',NULL,NULL,25);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('DeAndre','Hopkins','Wide Receiver',NULL,NULL,9);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Odell','Beckham Jr','Wide Receiver',NULL,NULL,18);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Keenan','Allen','Wide Receiver',NULL,NULL,15);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Michael','Thomas','Wide Receiver',NULL,NULL,27);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Christian','McCaffrey','Running Back',NULL,NULL,26);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kareem','Hunt','Running Back',NULL,NULL,14);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Leonard','Fournette','Running Back',NULL,NULL,11);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Joe','Mixon','Running Back',NULL,NULL,6);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jordan','Howard','Running Back',NULL,NULL,21);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('AJ','Green','Wide Receiver',NULL,NULL,6);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Rob','Gronkowski','Tight End',NULL,NULL,3);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Davante','Adams','Wide Receiver',NULL,NULL,23);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tyreek','Hill','Wide Receiver',NULL,NULL,14);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Travis','Kelce','Tight End',NULL,NULL,14);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Devonta','Freeman','Running Back',NULL,NULL,25);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('LeSean','McCoy','Running Back',NULL,NULL,1);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Mike','Evans','Wide Receiver',NULL,NULL,28);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kenyan','Drake','Running Back',NULL,NULL,2);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Larry','Fitzgerald','Wide Receiver',NULL,NULL,29);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('TY','Hilton','Wide Receiver',NULL,NULL,10);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Adam','Thielen','Wide Receiver',NULL,NULL,24);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Alex','Collins','Running Back',NULL,NULL,5);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Zach','Ertz','Tight End',NULL,NULL,19);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Stefon','Diggs','Wide Receiver',NULL,NULL,24);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Demaryius','Thomas','Wide Receiver',NULL,NULL,13);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Emmanuel','Sanders','Wide Receiver',NULL,NULL,13);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Allen','Robinson','Wide Receiver',NULL,NULL,21);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Amari','Cooper','Wide Receiver',NULL,NULL,16);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jarvis','Landry','Wide Receiver',NULL,NULL,7);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Golden','Tate','Wide Receiver',NULL,NULL,22);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Marvin','Jones Jr','Wide Receiver',NULL,NULL,22);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Brandin','Cooks','Wide Receiver',NULL,NULL,30);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Dion','Lewis','Running Back',NULL,NULL,12);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('JuJu','Smith-Schuster','Wide Receiver',NULL,NULL,8);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Josh','Gordon','Wide Receiver',NULL,NULL,7);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jay','Ajayi','Running Back',NULL,NULL,19);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Lamar','Miller','Running Back',NULL,NULL,9);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Royce','Freeman','Running Back',NULL,NULL,13);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Marshawn','Lynch','Running Back',NULL,NULL,16);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Mark','Ingram II','Running Back',NULL,NULL,27);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Rex','Burkhead','Running Back',NULL,NULL,3);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Le''Veon','Bell','Running Back',NULL,NULL,8);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Carlos','Hyde','Running Back',NULL,NULL,7);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Robert','Woods','Wide Receiver',NULL,NULL,30);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chris','Hogan','Wide Receiver',NULL,NULL,3);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Michael','Crabtree','Wide Receiver',NULL,NULL,5);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Corey','Davis','Wide Receiver',NULL,NULL,12);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Devin','Funchess','Wide Receiver',NULL,NULL,26);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Aaron','Rodgers','Quarterback',NULL,NULL,23);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tom','Brady','Quarterback',NULL,NULL,3);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chris','Thompson','Running Back',NULL,NULL,20);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Derrick','Henry','Running Back',NULL,NULL,12);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chris','Carson','Running Back',NULL,NULL,32);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Peyton','Barber','Running Back',NULL,NULL,28);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jordan','Reed','Tight End',NULL,NULL,20);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jimmy','Graham','Tight End',NULL,NULL,23);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Evan','Engram','Tight End',NULL,NULL,18);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Cooper','Kupp','Wide Receiver',NULL,NULL,30);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Randall','Cobb','Wide Receiver',NULL,NULL,23);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Doug','Baldwin','Wide Receiver',NULL,NULL,32);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Marquise','Goodwin','Wide Receiver',NULL,NULL,31);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Sammy','Watkins','Wide Receiver',NULL,NULL,14);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Nelson','Agholor','Wide Receiver',NULL,NULL,19);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('James','Conner','Running Back',NULL,NULL,8);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Duke','Johnson Jr','Running Back',NULL,NULL,7);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kyle','Rudolph','Tight End',NULL,NULL,24);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jamison','Crowder','Wide Receiver',NULL,NULL,20);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Julian','Edelman','Wide Receiver',NULL,NULL,3);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Cam','Newton','Quarterback',NULL,NULL,26);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Russell','Wilson','Quarterback',NULL,NULL,32);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Andrew','Luck','Quarterback',NULL,NULL,10);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Deshaun','Watson','Quarterback',NULL,NULL,9);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Sterling','Shepard','Wide Receiver',NULL,NULL,18);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Pierre','Garcon','Wide Receiver',NULL,NULL,31);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Will','Fuller V','Wide Receiver',NULL,NULL,9);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tevin','Coleman','Running Back',NULL,NULL,25);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Isaiah','Crowell','Running Back',NULL,NULL,4);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tarik','Cohen','Running Back',NULL,NULL,21);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Adrian','Peterson','Running Back',NULL,NULL,20);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Matt','Breida','Running Back',NULL,NULL,31);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jack','Doyle','Tight End',NULL,NULL,10);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Carson','Wentz','Quarterback',NULL,NULL,19);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kenny','Stills','Wide Receiver',NULL,NULL,2);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jordy','Nelson','Wide Receiver',NULL,NULL,16);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kenny','Golladay','Wide Receiver',NULL,NULL,22);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Robby','Anderson','Wide Receiver',NULL,NULL,4);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Alfred','Morris','Running Back',NULL,NULL,31);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jamaal','Williams','Running Back',NULL,NULL,23);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kerryon','Johnson','Running Back',NULL,NULL,22);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('James','White','Running Back',NULL,NULL,3);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Trey','Burton','Tight End',NULL,NULL,21);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Quincy','Enunwa','Wide Receiver',NULL,NULL,4);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Alshon','Jeffery','Wide Receiver',NULL,NULL,19);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kelvin','Benjamin','Wide Receiver',NULL,NULL,1);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tyler','Lockett','Wide Receiver',NULL,NULL,32);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Mohamed','Sanu','Wide Receiver',NULL,NULL,25);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Danny','Amendola','Wide Receiver',NULL,NULL,2);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chris','Godwin','Wide Receiver',NULL,NULL,28);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Geronimo','Allison','Wide Receiver',NULL,NULL,23);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ted','Ginn Jr','Wide Receiver',NULL,NULL,27);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Josh','Doctson','Wide Receiver',NULL,NULL,20);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Allen','Hurns','Wide Receiver',NULL,NULL,17);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Keelan','Cole','Wide Receiver',NULL,NULL,11);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Paul','Richardson','Wide Receiver',NULL,NULL,20);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ryan','Grant','Wide Receiver',NULL,NULL,10);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('DeVante','Parker','Wide Receiver',NULL,NULL,2);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ben','Roethlisberger','Quarterback',NULL,NULL,8);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kirk','Cousins','Quarterback',NULL,NULL,24);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('George','Kittle','Tight End',NULL,NULL,31);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('David','Njoku','Tight End',NULL,NULL,7);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Benjamin','Watson','Tight End',NULL,NULL,27);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Bilal','Powell','Running Back',NULL,NULL,4);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Phillip','Lindsay','Running Back',NULL,NULL,13);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Marlon','Mack','Running Back',NULL,NULL,10);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Rashaad','Penny','Running Back',NULL,NULL,32);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Sony','Michel','Running Back',NULL,NULL,3);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Patrick','Mahomes','Quarterback',NULL,NULL,14);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Matthew','Stafford','Quarterback',NULL,NULL,22);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Drew','Brees','Quarterback',NULL,NULL,27);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('John','Ross','Wide Receiver',NULL,NULL,6);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('DeSean','Jackson','Wide Receiver',NULL,NULL,28);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('John','Brown','Wide Receiver',NULL,NULL,5);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Courtland','Sutton','Wide Receiver',NULL,NULL,13);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Philip','Rivers','Quarterback',NULL,NULL,15);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Alex','Smith','Quarterback',NULL,NULL,20);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Matt','Ryan','Quarterback',NULL,NULL,25);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jimmy','Garoppolo','Quarterback',NULL,NULL,31);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Donte','Moncrief','Wide Receiver',NULL,NULL,11);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Mike','Williams','Wide Receiver',NULL,NULL,15);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Michael','Gallup','Wide Receiver',NULL,NULL,17);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Rishard','Matthews','Wide Receiver',NULL,NULL,12);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Mike','Wallace','Wide Receiver',NULL,NULL,19);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Theo','Riddick','Running Back',NULL,NULL,22);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ty','Montgomery','Running Back',NULL,NULL,23);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Javorius','Allen','Running Back',NULL,NULL,5);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Austin','Seferian-Jenkins','Tight End',NULL,NULL,11);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tyler','Eifert','Tight End',NULL,NULL,6);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Aaron','Jones','Running Back',NULL,NULL,23);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Darren','Sproles','Running Back',NULL,NULL,19);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Austin','Ekeler','Running Back',NULL,NULL,15);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tyrod','Taylor','Quarterback',NULL,NULL,7);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jared','Goff','Quarterback',NULL,NULL,30);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Mitchell','Trubisky','Quarterback',NULL,NULL,21);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jalen','Richard','Running Back',NULL,NULL,16);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Nyheim','Hines','Running Back',NULL,NULL,10);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jordan','Wilkins','Running Back',NULL,NULL,10);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('TJ','Yeldon','Running Back',NULL,NULL,11);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Dede','Westbrook','Wide Receiver',NULL,NULL,11);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Cole','Beasley','Wide Receiver',NULL,NULL,17);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tyler','Boyd','Wide Receiver',NULL,NULL,6);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jared','Cook','Tight End',NULL,NULL,16);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Anthony','Miller','Wide Receiver',NULL,NULL,21);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Dak','Prescott','Quarterback',NULL,NULL,17);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Giovani','Bernard','Running Back',NULL,NULL,6);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Latavius','Murray','Running Back',NULL,NULL,24);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Taylor','Gabriel','Wide Receiver',NULL,NULL,21);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Calvin','Ridley','Wide Receiver',NULL,NULL,25);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('OJ','Howard','Tight End',NULL,NULL,28);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ricky','Seals-Jones','Tight End',NULL,NULL,29);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Greg','Zuerlein','Kicker',NULL,NULL,30);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Stephen','Gostkowski','Kicker',NULL,NULL,3);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Justin','Tucker','Kicker',NULL,NULL,5);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Matt','Bryant','Kicker',NULL,NULL,25);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Wil','Lutz','Kicker',NULL,NULL,27);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chris','Boswell','Kicker',NULL,NULL,8);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Robbie','Gould','Kicker',NULL,NULL,31);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jake','Elliott','Kicker',NULL,NULL,19);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Matt','Prater','Kicker',NULL,NULL,22);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Harrison','Butker','Kicker',NULL,NULL,14);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Adam','Vinatieri','Kicker',NULL,NULL,10);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Graham','Gano','Kicker',NULL,NULL,26);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ronald','Jones II','Running Back',NULL,NULL,28);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Doug','Martin','Running Back',NULL,NULL,16);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Corey','Clement','Running Back',NULL,NULL,19);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Vance','McDonald','Tight End',NULL,NULL,8);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Austin','Hooper','Tight End',NULL,NULL,25);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Antonio','Gates','Tight End',NULL,NULL,15);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Devontae','Booker','Running Back',NULL,NULL,13);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('CJ','Anderson','Running Back',NULL,NULL,26);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chase','Edmonds','Running Back',NULL,NULL,29);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('LeGarrette','Blount','Running Back',NULL,NULL,22);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Nick','Chubb','Running Back',NULL,NULL,7);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chris','Ivory','Running Back',NULL,NULL,1);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Marcus','Murphy','Running Back',NULL,NULL,1);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Frank','Gore','Running Back',NULL,NULL,2);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Alfred','Blue','Running Back',NULL,NULL,9);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('D''Onta','Foreman','Running Back',NULL,NULL,9);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Spencer','Ware','Running Back',NULL,NULL,14);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Charles','Clay','Tight End',NULL,NULL,1);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Cameron','Brate','Tight End',NULL,NULL,28);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Marcus','Mariota','Quarterback',NULL,NULL,12);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Willie','Snead','Wide Receiver',NULL,NULL,5);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tyrell','Williams','Wide Receiver',NULL,NULL,15);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Brandon','Marshall','Wide Receiver',NULL,NULL,32);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Phillip','Dorsett','Wide Receiver',NULL,NULL,3);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tajae','Sharpe','Wide Receiver',NULL,NULL,12);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('DJ','Moore','Wide Receiver',NULL,NULL,26);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Andy','Dalton','Quarterback',NULL,NULL,6);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ryan','Tannehill','Quarterback',NULL,NULL,2);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ryan','Succop','Kicker',NULL,NULL,12);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Daniel','Carlson','Kicker',NULL,NULL,24);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Dante','Pettis','Wide Receiver',NULL,NULL,31);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('James','Washington','Wide Receiver',NULL,NULL,8);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Christian','Kirk','Wide Receiver',NULL,NULL,29);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Albert','Wilson','Wide Receiver',NULL,NULL,2);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chad','Williams','Wide Receiver',NULL,NULL,29);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Austin','Carr','Wide Receiver',NULL,NULL,27);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Travis','Benjamin','Wide Receiver',NULL,NULL,15);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('DJ','Chark','Wide Receiver',NULL,NULL,11);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Tre''Quan','Smith','Wide Receiver',NULL,NULL,27);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Cordarrelle','Patterson','Wide Receiver',NULL,NULL,3);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jacquizz','Rodgers','Running Back',NULL,NULL,28);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kyle','Juszczyk','Running Back',NULL,NULL,31);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Wayne','Gallman','Running Back',NULL,NULL,18);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Elijah','McGuire','Running Back',NULL,NULL,4);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jonathan','Stewart','Running Back',NULL,NULL,18);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Rod','Smith','Running Back',NULL,NULL,17);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Damien','Williams','Running Back',NULL,NULL,14);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('John','Kelly','Running Back',NULL,NULL,30);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Case','Keenum','Quarterback',NULL,NULL,13);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Eli','Manning','Quarterback',NULL,NULL,18);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Derek','Carr','Quarterback',NULL,NULL,16);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Eric','Ebron','Tight End',NULL,NULL,10);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ryan','Griffin','Tight End',NULL,NULL,9);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jonnu','Smith','Tight End',NULL,NULL,12);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ian','Thomas','Tight End',NULL,NULL,26);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Corey','Grant','Running Back',NULL,NULL,11);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Dez','Bryant','Wide Receiver',NULL,NULL,NULL);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Marquez','Valdes-Scantling','Wide Receiver',NULL,NULL,23);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Mason','Crosby','Kicker',NULL,NULL,23);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Josh','Lambo','Kicker',NULL,NULL,11);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Will','Dissly','Tight End',NULL,NULL,32);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Hayden','Hurst','Tight End',NULL,NULL,5);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Greg','Olsen','Tight End',NULL,NULL,26);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Justin','Hunter','Wide Receiver',NULL,NULL,8);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Deonte','Thompson','Wide Receiver',NULL,NULL,17);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Adam','Humphries','Wide Receiver',NULL,NULL,28);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Zay','Jones','Wide Receiver',NULL,NULL,1);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('TJ','Logan','Running Back',NULL,NULL,29);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('CJ','Prosise','Running Back',NULL,NULL,32);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Blake','Bortles','Quarterback',NULL,NULL,11);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Joe','Flacco','Quarterback',NULL,NULL,5);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Sam','Darnold','Quarterback',NULL,NULL,4);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jameis','Winston','Quarterback',NULL,NULL,28);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Sam','Bradford','Quarterback',NULL,NULL,29);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jermaine','Kearse','Wide Receiver',NULL,NULL,4);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jeremy','Kerley','Wide Receiver',NULL,NULL,1);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Laquon','Treadwell','Wide Receiver',NULL,NULL,24);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Trent','Taylor','Wide Receiver',NULL,NULL,31);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Torrey','Smith','Wide Receiver',NULL,NULL,26);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Robert','Turbin','Running Back',NULL,NULL,10);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ito','Smith','Running Back',NULL,NULL,25);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Kenneth','Dixon','Running Back',NULL,NULL,5);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Christine','Michael','Running Back',NULL,NULL,10);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Rob','Kelley','Running Back',NULL,NULL,20);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jaylen','Samuels','Running Back',NULL,NULL,8);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Malcolm','Brown','Running Back',NULL,NULL,30);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Trenton','Cannon','Running Back',NULL,NULL,4);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chester','Rogers','Wide Receiver',NULL,NULL,10);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Dustin','Hopkins','Kicker',NULL,NULL,20);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Chandler','Catanzaro','Kicker',NULL,NULL,28);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Geoff','Swaim','Tight End',NULL,NULL,17);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Mike','Gesicki','Tight End',NULL,NULL,2);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Vernon','Davis','Tight End',NULL,NULL,20);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Luke','Willson','Tight End',NULL,NULL,22);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Dallas','Goedert','Tight End',NULL,NULL,19);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Seth','Roberts','Wide Receiver',NULL,NULL,16);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Jarius','Wright','Wide Receiver',NULL,NULL,26);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Josh','Allen','Quarterback',NULL,NULL,1);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Baker','Mayfield','Quarterback',NULL,NULL,7);             
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Nick','Foles','Quarterback',NULL,NULL,19);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Josh','Rosen','Quarterback',NULL,NULL,29);              
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Ryan','Fitzpatrick','Quarterback',NULL,NULL,28);
INSERT INTO player(firstName,lastName,position,height,weight,teamID) VALUES ('Lamar','Jackson','Quarterback',NULL,NULL,5);              

-- INSERT into seasonStatistics table - Passing stats

INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (116,2018,675,452,'5129',34,16);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (126,2018,580,383,'5097',50,12);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (135,2018,608,422,'4924',35,7);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (151,2018,561,364,'4688',32,12);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (80,2018,639,430,'4593',39,15);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (58,2018,597,372,'4442',25,2);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (59,2018,570,375,'4355',29,11);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (133,2018,508,347,'4308',32,12);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (230,2018,576,380,'4299',21,11);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (117,2018,606,425,'4298',30,10);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (81,2018,505,345,'4165',26,9);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (216,2018,553,381,'4049',19,10);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (128,2018,489,364,'3992',32,5);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (229,2018,586,365,'3890',18,15);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (162,2018,526,356,'3885',22,8);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (127,2018,555,367,'3777',21,11);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (279,2018,486,310,'3725',27,14);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (79,2018,427,280,'3448',35,7);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (78,2018,471,320,'3395',24,13);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (152,2018,434,289,'3223',24,12);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (91,2018,401,279,'3074',21,7);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (253,2018,378,244,'2992',19,14);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (252,2018,414,239,'2865',17,15);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (250,2018,403,243,'2718',13,11);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (207,2018,365,226,'2566',21,11);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (200,2018,331,228,'2528',11,8);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (251,2018,379,232,'2465',12,6);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (282,2018,246,164,'2366',17,12);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (281,2018,393,217,'2278',11,14);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (134,2018,328,205,'2180',10,5);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (278,2018,320,169,'2074',10,12);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (208,2018,274,176,'1979',17,9);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (280,2018,195,141,'1413',7,4);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (283,2018,170,99,'1201',6,3);
INSERT INTO seasonStatistics(playerID,year,passingAttempts,passingCompletions,passingYards,passingTouchdowns,interceptions) VALUES (136,2018,89,53,'718',5,3);

-- INSERT into seasonStatistics table - Rushing stats

INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (3,2018,304,'1434',6);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (6,2018,261,'1307',11);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (1,2018,256,'1251',17);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (17,2018,237,'1168',8);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (62,2018,247,'1151',9);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (14,2018,219,'1098',7);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (61,2018,215,'1059',12);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (88,2018,251,'1042',7);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (122,2018,192,'1037',9);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (191,2018,192,'996',8);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (46,2018,210,'973',5);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (73,2018,215,'973',12);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (2,2018,258,'940',7);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (18,2018,250,'935',9);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (125,2018,209,'931',6);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (123,2018,195,'908',9);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (8,2018,175,'885',10);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (4,2018,194,'883',14);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (63,2018,234,'871',5);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (15,2018,181,'824',7);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (89,2018,153,'814',3);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (85,2018,167,'800',4);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (147,2018,133,'728',8);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (182,2018,172,'723',4);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (194,2018,156,'722',0);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (86,2018,143,'685',6);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (49,2018,138,'645',6);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (98,2018,118,'641',3);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (7,2018,133,'615',2);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (164,2018,140,'578',6);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (149,2018,106,'554',3);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (27,2018,120,'535',4);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (24,2018,130,'521',5);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (42,2018,155,'517',1);
INSERT INTO seasonStatistics(playerID,year,rushes,rushingYards,rushingTouchdowns) VALUES (25,2018,161,'514',3);

-- INSERT into seasonStatistics table - Receiving stats

INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (9,2018,113,'1677',8);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (10,2018,115,'1572',11);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (26,2018,86,'1524',8);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (22,2018,87,'1479',12);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (43,2018,111,'1426',7);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (13,2018,125,'1405',9);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (21,2018,111,'1386',13);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (118,2018,88,'1377',5);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (30,2018,113,'1373',9);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (23,2018,103,'1336',10);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (5,2018,104,'1297',15);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (29,2018,76,'1270',6);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (53,2018,86,'1219',6);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (41,2018,80,'1204',5);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (12,2018,97,'1196',6);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (32,2018,116,'1163',8);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (94,2018,70,'1063',5);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (11,2018,77,'1052',6);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (159,2018,76,'1028',7);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (33,2018,102,'1021',9);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (38,2018,81,'976',4);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (104,2018,57,'965',10);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (160,2018,68,'896',6);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (56,2018,65,'891',4);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (82,2018,66,'872',4);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (35,2018,71,'868',4);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (77,2018,74,'850',6);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (102,2018,65,'843',6);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (107,2018,59,'842',7);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (105,2018,66,'838',4);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (166,2018,64,'821',10);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (246,2018,76,'816',5);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (206,2018,55,'788',2);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (130,2018,41,'774',4);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (36,2018,55,'754',4);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (95,2018,50,'752',6);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (99,2018,87,'751',7);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (232,2018,66,'750',13);
INSERT INTO seasonStatistics(playerID,year,receptions,receivingYards,receivingTouchdowns) VALUES (93,2018,63,'739',3);

-- INSERT into sponsoredPlayers

INSERT INTO sponsoredPlayers(playerID, sponsorID) VALUES (1, 1);
INSERT INTO sponsoredPlayers(playerID, sponsorID) VALUES (2, 2);
INSERT INTO sponsoredPlayers(playerID, sponsorID) VALUES (3, 3);
INSERT INTO sponsoredPlayers(playerID, sponsorID) VALUES (4, 4);
INSERT INTO sponsoredPlayers(playerID, sponsorID) VALUES (5, 3);

-- END OF FILE

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;