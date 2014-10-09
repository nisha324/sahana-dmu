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
-- Table structure for table `pa_capacity`
--

CREATE TABLE IF NOT EXISTS `pa_capacity` (
  `capacity_id` int(11) NOT NULL AUTO_INCREMENT,
  `capacity_date` date NOT NULL,
  `capacity_user` varchar(20) NOT NULL,
  `update_dis_data` int(11) NOT NULL,
  `pA` int(11) NOT NULL,
  `pa_date` varchar(15) DEFAULT NULL,
  `pa_place` varchar(20) DEFAULT NULL,
  `eW` int(11) NOT NULL,
  `eW2` int(11) NOT NULL,
  `sA` int(11) NOT NULL,
  `sA2` int(11) NOT NULL,
  `sA3` int(11) NOT NULL,
  `emp` int(11) NOT NULL,
  `emp2` int(11) NOT NULL,
  `eRM` int(11) NOT NULL,
  `drill` int(11) NOT NULL,
  `drill_date` varchar(15) DEFAULT NULL,
  `plan` int(11) NOT NULL,
  `plan2` int(11) NOT NULL,
  PRIMARY KEY (`capacity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `pa_capacity`
--

INSERT INTO `pa_capacity` (`capacity_id`, `capacity_date`, `capacity_user`, `update_dis_data`, `pA`, `pa_date`, `pa_place`, `eW`, `eW2`, `sA`, `sA2`, `sA3`, `emp`, `emp2`, `eRM`, `drill`, `drill_date`, `plan`, `plan2`) VALUES
(4, '2014-09-08', 'user', 0, 0, '', '', 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
