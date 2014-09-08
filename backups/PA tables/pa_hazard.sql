-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 08, 2014 at 12:40 PM
-- Server version: 5.5.24-log
-- PHP Version: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sahana-dmu`
--

-- --------------------------------------------------------

--
-- Table structure for table `pa_hazard`
--

CREATE TABLE IF NOT EXISTS `pa_hazard` (
  `hazard_id` int(11) NOT NULL AUTO_INCREMENT,
  `hazard_date` date DEFAULT NULL,
  `hazard_user` varchar(30) DEFAULT NULL,
  `flood_poten` int(2) DEFAULT NULL,
  `flood_frq` int(2) DEFAULT NULL,
  `flood_SP` int(2) DEFAULT NULL,
  `landslide_poten` int(2) DEFAULT NULL,
  `landslide_frq` int(2) DEFAULT NULL,
  `landslide_SP` int(2) DEFAULT NULL,
  `drought_poten` int(2) DEFAULT NULL,
  `drought_frq` int(2) DEFAULT NULL,
  `drought_SP` int(2) DEFAULT NULL,
  `cyclones_poten` int(2) DEFAULT NULL,
  `cyclones_frq` int(2) DEFAULT NULL,
  `cyclones_SP` int(2) DEFAULT NULL,
  `tsunami_poten` int(2) DEFAULT NULL,
  `tsunami_frq` int(2) DEFAULT NULL,
  `tsunami_SP` int(2) DEFAULT NULL,
  PRIMARY KEY (`hazard_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

--
-- Dumping data for table `pa_hazard`
--

INSERT INTO `pa_hazard` (`hazard_id`, `hazard_date`, `hazard_user`, `flood_poten`, `flood_frq`, `flood_SP`, `landslide_poten`, `landslide_frq`, `landslide_SP`, `drought_poten`, `drought_frq`, `drought_SP`, `cyclones_poten`, `cyclones_frq`, `cyclones_SP`, `tsunami_poten`, `tsunami_frq`, `tsunami_SP`) VALUES
(38, '2014-09-08', 'user', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(39, '2014-09-08', 'user', 2, 2, 3, 1, 2, 2, 2, 3, 1, 1, 2, 3, 2, 2, 3),
(40, '2014-09-08', 'user', 2, 2, 3, 1, 2, 2, 2, 3, 1, 1, 2, 3, 2, 2, 3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
