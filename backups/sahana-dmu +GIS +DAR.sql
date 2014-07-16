-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2014 at 05:26 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sahana-dmu`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_reported_person`(IN id VARCHAR(128),IN deleteNotes BOOLEAN)
BEGIN


DELETE p.* FROM person_uuid p, person_to_report pr WHERE pr.rep_uuid = p.p_uuid AND pr.p_uuid = id AND pr.rep_uuid NOT IN (SELECT p_uuid FROM users);


DELETE person_uuid.* FROM person_uuid WHERE p_uuid = id;


DELETE pfif_person.* FROM pfif_person WHERE p_uuid = id;

IF deleteNotes THEN

  DELETE pfif_note.* FROM pfif_note WHERE p_uuid = id;


  UPDATE pfif_note SET linked_person_record_id = NULL WHERE linked_person_record_id = id;
END IF;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `adodb_logsql`
--

CREATE TABLE IF NOT EXISTS `adodb_logsql` (
  `created` datetime NOT NULL,
  `sql0` varchar(250) NOT NULL,
  `sql1` text NOT NULL,
  `params` text NOT NULL,
  `tracer` text NOT NULL,
  `timer` decimal(16,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `affected_area`
--

CREATE TABLE IF NOT EXISTS `affected_area` (
  `affected_area_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`affected_area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `alt_logins`
--

CREATE TABLE IF NOT EXISTS `alt_logins` (
  `p_uuid` varchar(128) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `type` varchar(60) DEFAULT 'openid',
  PRIMARY KEY (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `arrival_rate`
--

CREATE TABLE IF NOT EXISTS `arrival_rate` (
  `person_uuid` varchar(128) NOT NULL,
  `incident_id` bigint(20) NOT NULL,
  `arrival_time` datetime NOT NULL,
  `source_all` int(32) NOT NULL,
  `source_triagepic` int(32) NOT NULL,
  `source_reunite` int(32) NOT NULL,
  `source_website` int(32) NOT NULL,
  `source_pfif` int(32) NOT NULL,
  `source_vanilla_email` int(32) NOT NULL,
  PRIMARY KEY (`person_uuid`),
  KEY `incident_index` (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `arrival_rate`
--

INSERT INTO `arrival_rate` (`person_uuid`, `incident_id`, `arrival_time`, `source_all`, `source_triagepic`, `source_reunite`, `source_website`, `source_pfif`, `source_vanilla_email`) VALUES
('localhost/sahana-dmu/www/person.101', 1, '2014-05-12 10:39:18', 1, 0, 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `audit`
--

CREATE TABLE IF NOT EXISTS `audit` (
  `audit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `x_uuid` varchar(128) NOT NULL,
  `u_uuid` varchar(128) NOT NULL,
  `change_type` varchar(3) NOT NULL,
  `change_table` varchar(100) NOT NULL,
  `change_field` varchar(100) NOT NULL,
  `prev_val` text,
  `new_val` text,
  PRIMARY KEY (`audit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE IF NOT EXISTS `config` (
  `config_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `module_id` varchar(20) DEFAULT NULL,
  `confkey` varchar(50) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`config_id`),
  KEY `module_id` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE IF NOT EXISTS `contact` (
  `p_uuid` varchar(128) NOT NULL,
  `opt_contact_type` varchar(10) NOT NULL,
  `contact_value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`p_uuid`,`opt_contact_type`),
  KEY `contact_value` (`contact_value`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `dao_error_log`
--

CREATE TABLE IF NOT EXISTS `dao_error_log` (
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `file` text,
  `line` text,
  `method` text,
  `class` text,
  `function` text,
  `error_message` text,
  `other` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='logs errors encountered in the DAO objects';

--
-- Dumping data for table `dao_error_log`
--

INSERT INTO `dao_error_log` (`time`, `file`, `line`, `method`, `class`, `function`, `error_message`, `other`) VALUES
('2014-06-15 18:14:27', 'E:\\xampp\\htdocs\\sahana-dmu\\mod\\gis\\xajax.inc', '102', 'gis_create_vector_layer', '', 'gis_create_vector_layer', 'Unknown column ''featur_feature_id'' in ''field list''', 'Inserting feature'),
('2014-06-15 18:14:27', 'E:\\xampp\\htdocs\\sahana-dmu\\mod\\gis\\xajax.inc', '102', 'gis_create_vector_layer', '', 'gis_create_vector_layer', 'Unknown column ''featur_feature_id'' in ''field list''', 'Inserting feature'),
('2014-06-15 19:13:44', 'E:\\xampp\\htdocs\\sahana-dmu\\mod\\gis\\xajax.inc', '142', 'gis_get_layer_data', '', 'gis_get_layer_data', 'Unknown column ''undefined'' in ''where clause''', 'show events 1'),
('2014-06-15 19:15:09', 'E:\\xampp\\htdocs\\sahana-dmu\\mod\\gis\\xajax.inc', '142', 'gis_get_layer_data', '', 'gis_get_layer_data', 'Unknown column ''undefined'' in ''where clause''', 'show events 1');

-- --------------------------------------------------------

--
-- Table structure for table `disaster`
--

CREATE TABLE IF NOT EXISTS `disaster` (
  `disaster_id` int(11) NOT NULL AUTO_INCREMENT,
  `disaster_type` int(11) NOT NULL,
  `assessment_date` date DEFAULT NULL,
  `disaster_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `assessor_id` int(11) NOT NULL,
  `focal_point_id` int(32) NOT NULL,
  PRIMARY KEY (`disaster_id`),
  KEY `fk_disaster_DisasterType_idx` (`disaster_type`),
  KEY `fk_disaster_assessor1_idx` (`assessor_id`),
  KEY `fk_disaster_hospital1_idx` (`focal_point_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `disaster_has_affected_area`
--

CREATE TABLE IF NOT EXISTS `disaster_has_affected_area` (
  `disaster_id` int(11) NOT NULL,
  `affected_area_id` int(11) NOT NULL,
  PRIMARY KEY (`disaster_id`,`affected_area_id`),
  KEY `fk_disaster_has_affected_area_affected_area1_idx` (`affected_area_id`),
  KEY `fk_disaster_has_affected_area_disaster1_idx` (`disaster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `disaster_type`
--

CREATE TABLE IF NOT EXISTS `disaster_type` (
  `disaster_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`disaster_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `disease`
--

CREATE TABLE IF NOT EXISTS `disease` (
  `respiratory` int(11) DEFAULT NULL,
  `diarrhea_watery` int(11) DEFAULT NULL,
  `diarrhea_dysentery` int(11) DEFAULT NULL,
  `hepatitis_a` int(11) DEFAULT NULL,
  `dengue` int(11) DEFAULT NULL,
  `malaria` int(11) DEFAULT NULL,
  `measles` int(11) DEFAULT NULL,
  `meningitis` int(11) DEFAULT NULL,
  `chicken_pox` int(11) DEFAULT NULL,
  `diabetes` int(11) DEFAULT NULL,
  `hypertension` int(11) DEFAULT NULL,
  `asthma` int(11) DEFAULT NULL,
  `copd` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_co_header`
--

CREATE TABLE IF NOT EXISTS `edxl_co_header` (
  `de_id` int(11) NOT NULL,
  `co_id` int(11) NOT NULL,
  `p_uuid` varchar(128) DEFAULT NULL COMMENT 'ties the contentObject to a person',
  `type` enum('lpf','tep','pix') DEFAULT NULL COMMENT 'defines the type of the contentObject',
  `content_descr` varchar(255) DEFAULT NULL COMMENT 'Content description',
  `incident_id` varchar(255) DEFAULT NULL,
  `incident_descr` varchar(255) DEFAULT NULL COMMENT 'Incident description',
  `confidentiality` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`co_id`),
  KEY `de_id` (`de_id`),
  KEY `p_uuid_idx` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_co_header_seq`
--

CREATE TABLE IF NOT EXISTS `edxl_co_header_seq` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'stores next id in sequence for the edxl_co_header table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `edxl_co_header_seq`
--

INSERT INTO `edxl_co_header_seq` (`id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `edxl_co_keywords`
--

CREATE TABLE IF NOT EXISTS `edxl_co_keywords` (
  `co_id` int(11) NOT NULL,
  `keyword_num` int(11) NOT NULL,
  `keyword_urn` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  PRIMARY KEY (`co_id`,`keyword_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_co_lpf`
--

CREATE TABLE IF NOT EXISTS `edxl_co_lpf` (
  `co_id` int(11) NOT NULL,
  `p_uuid` varchar(255) NOT NULL COMMENT 'Sahana person ID',
  `schema_version` varchar(255) NOT NULL,
  `login_machine` varchar(255) NOT NULL,
  `login_account` varchar(255) NOT NULL,
  `person_id` varchar(255) NOT NULL COMMENT 'Mass casualty patient ID',
  `event_name` varchar(255) NOT NULL,
  `event_long_name` varchar(255) NOT NULL,
  `org_name` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `gender` enum('M','F','U','C') NOT NULL,
  `peds` tinyint(1) NOT NULL,
  `triage_category` enum('Green','BH Green','Yellow','Red','Gray','Black') NOT NULL,
  PRIMARY KEY (`co_id`,`p_uuid`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='LPF is an example of an "other xml" content object, e.g., ot';

-- --------------------------------------------------------

--
-- Table structure for table `edxl_co_photos`
--

CREATE TABLE IF NOT EXISTS `edxl_co_photos` (
  `co_id` int(11) NOT NULL,
  `p_uuid` varchar(255) NOT NULL COMMENT 'Sahana person ID',
  `mimeType` varchar(255) NOT NULL COMMENT 'As in ''image/jpeg''',
  `uri` varchar(255) NOT NULL COMMENT 'Photo filename = Mass casualty patient ID + zone + ''s#'' if secondary + optional caption after hypen',
  `contentData` mediumtext CHARACTER SET ascii NOT NULL COMMENT 'Base-64 encoded image',
  `image_id` int(20) DEFAULT NULL COMMENT 'reference to the image.image_id field',
  `sha1` varchar(40) DEFAULT NULL COMMENT 'sha1 calculated hash of the image',
  PRIMARY KEY (`co_id`,`p_uuid`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='LPF is an example of an "other xml" content object, e.g., ot';

-- --------------------------------------------------------

--
-- Table structure for table `edxl_co_roles`
--

CREATE TABLE IF NOT EXISTS `edxl_co_roles` (
  `co_id` int(11) NOT NULL,
  `role_num` int(11) NOT NULL DEFAULT '0',
  `of_originator` tinyint(1) NOT NULL COMMENT '0 = false = of consumer',
  `role_urn` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`co_id`,`role_num`),
  KEY `role_num` (`role_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_de_header`
--

CREATE TABLE IF NOT EXISTS `edxl_de_header` (
  `de_id` int(11) NOT NULL,
  `when_sent` datetime NOT NULL,
  `sender_id` varchar(255) NOT NULL COMMENT 'Email, phone num, etc.  Not always URI, URN, URL',
  `distr_id` varchar(255) NOT NULL COMMENT 'Distribution ID.  Sender may or may not choose to vary.',
  `distr_status` enum('Actual','Exercise','System','Test') NOT NULL,
  `distr_type` enum('Ack','Cancel','Dispatch','Error','Report','Request','Response','Update') NOT NULL COMMENT 'Not included: types for sensor grids',
  `combined_conf` varchar(255) NOT NULL COMMENT 'Combined confidentiality of all content objects',
  `language` varchar(255) DEFAULT NULL,
  `when_here` datetime NOT NULL COMMENT 'Received or sent from here.  [local]',
  `inbound` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'BOOLEAN [local]',
  PRIMARY KEY (`de_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Overall message base, defined by EDXL Distribution Element';

-- --------------------------------------------------------

--
-- Table structure for table `edxl_de_header_seq`
--

CREATE TABLE IF NOT EXISTS `edxl_de_header_seq` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'stores next id in sequence for the edxl_de_header table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `edxl_de_header_seq`
--

INSERT INTO `edxl_de_header_seq` (`id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `edxl_de_keywords`
--

CREATE TABLE IF NOT EXISTS `edxl_de_keywords` (
  `de_id` int(11) NOT NULL,
  `keyword_num` int(11) NOT NULL DEFAULT '0',
  `keyword_urn` varchar(255) NOT NULL,
  `keyword` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`de_id`,`keyword_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_de_prior_messages`
--

CREATE TABLE IF NOT EXISTS `edxl_de_prior_messages` (
  `de_id` int(11) NOT NULL,
  `prior_msg_num` int(11) NOT NULL DEFAULT '0',
  `when_sent` datetime NOT NULL COMMENT 'external time',
  `sender_id` varchar(255) NOT NULL COMMENT 'external ID',
  `distr_id` varchar(255) NOT NULL COMMENT 'external distribution ID',
  PRIMARY KEY (`de_id`,`prior_msg_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_de_roles`
--

CREATE TABLE IF NOT EXISTS `edxl_de_roles` (
  `de_id` int(11) NOT NULL,
  `role_num` int(11) NOT NULL DEFAULT '0',
  `of_sender` tinyint(1) NOT NULL,
  `role_urn` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`de_id`,`role_num`),
  KEY `role_idx` (`role_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_de_target_addresses`
--

CREATE TABLE IF NOT EXISTS `edxl_de_target_addresses` (
  `de_id` int(11) NOT NULL,
  `address_num` int(11) NOT NULL DEFAULT '0',
  `scheme` varchar(255) NOT NULL COMMENT 'Like "e-mail"',
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`de_id`,`address_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_de_target_circles`
--

CREATE TABLE IF NOT EXISTS `edxl_de_target_circles` (
  `de_id` int(11) NOT NULL,
  `circle_num` int(11) NOT NULL DEFAULT '0',
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `radius_km` float NOT NULL,
  PRIMARY KEY (`de_id`,`circle_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_de_target_codes`
--

CREATE TABLE IF NOT EXISTS `edxl_de_target_codes` (
  `de_id` int(11) NOT NULL,
  `codes_num` int(11) NOT NULL DEFAULT '0',
  `code_type` enum('country','subdivision','locCodeUN') DEFAULT NULL COMMENT 'Respectively (1) ISO 3166-1 2-letter country code (2) ISO 3166-2 code: country + "-" + per-country 2-3 char code like state, e.g., "US-MD". (3) UN transport hub code: country + "-" + 2-3 char code (cap ASCII or 2-9), e.g., "US-BWI"',
  `code` varchar(6) DEFAULT NULL COMMENT 'See format examples for code_type field',
  PRIMARY KEY (`de_id`,`codes_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `edxl_de_target_polygons`
--

CREATE TABLE IF NOT EXISTS `edxl_de_target_polygons` (
  `de_id` int(11) NOT NULL,
  `poly_num` int(11) NOT NULL DEFAULT '0',
  `point_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Point within this polygon',
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  PRIMARY KEY (`de_id`,`poly_num`,`point_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `expiry_queue`
--

CREATE TABLE IF NOT EXISTS `expiry_queue` (
  `index` int(20) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) DEFAULT NULL,
  `requested_by_user_id` int(16) DEFAULT NULL,
  `requested_when` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `requested_why` text COMMENT 'the reason (optional) why a expiration/deletion was requested',
  `queued` tinyint(1) DEFAULT NULL COMMENT 'true when an expiration is requested',
  `approved_by_user_id` int(16) DEFAULT NULL,
  `approved_when` timestamp NULL DEFAULT NULL,
  `approved_why` text COMMENT 'the reason why an approval was accepted or rejected',
  `expired` tinyint(1) DEFAULT NULL COMMENT 'true when a expiration is approved',
  PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='person expiry request management queue and related informati' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `feature`
--

CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int(11) NOT NULL AUTO_INCREMENT,
  `geometry` smallint(6) DEFAULT NULL,
  `layer_layer_id` int(11) NOT NULL,
  PRIMARY KEY (`feature_id`),
  KEY `fk_feature_layer1_idx` (`layer_layer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `feature`
--

INSERT INTO `feature` (`feature_id`, `geometry`, `layer_layer_id`) VALUES
(10, 1, 39),
(11, 1, 39),
(12, 1, 39),
(13, 1, 39),
(14, 3, 41);

-- --------------------------------------------------------

--
-- Table structure for table `field_options`
--

CREATE TABLE IF NOT EXISTS `field_options` (
  `field_name` varchar(100) DEFAULT NULL,
  `option_code` varchar(10) DEFAULT NULL,
  `option_description` varchar(50) DEFAULT NULL,
  `display_order` int(8) DEFAULT NULL,
  KEY `option_code` (`option_code`),
  KEY `option_description` (`option_description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `field_options`
--

INSERT INTO `field_options` (`field_name`, `option_code`, `option_description`, `display_order`) VALUES
('opt_status', 'ali', 'Alive & Well', NULL),
('opt_status', 'mis', 'Missing', NULL),
('opt_status', 'inj', 'Injured', NULL),
('opt_status', 'dec', 'Deceased', NULL),
('opt_gender', 'mal', 'Male', NULL),
('opt_gender', 'fml', 'Female', NULL),
('opt_contact_type', 'home', 'Home(permanent address)', NULL),
('opt_contact_type', 'name', 'Contact Person', NULL),
('opt_contact_type', 'pmob', 'Personal Mobile', NULL),
('opt_contact_type', 'curr', 'Current Phone', NULL),
('opt_contact_type', 'cmob', 'Current Mobile', NULL),
('opt_contact_type', 'email', 'Email address', NULL),
('opt_contact_type', 'fax', 'Fax Number', NULL),
('opt_contact_type', 'web', 'Website', NULL),
('opt_contact_type', 'inst', 'Instant Messenger', NULL),
('opt_eye_color', 'GRN', 'Green', NULL),
('opt_eye_color', 'GRY', 'Gray', NULL),
('opt_race', 'R1', 'American Indian or Alaska Native', NULL),
('opt_race', NULL, 'Unknown', NULL),
('opt_eye_color', 'BRO', 'Brown', NULL),
('opt_eye_color', 'BLU', 'Blue', NULL),
('opt_eye_color', 'BLK', 'Black', NULL),
('opt_skin_color', 'DRK', 'Dark', NULL),
('opt_skin_color', 'BLK', 'Black', NULL),
('opt_skin_color', 'ALB', 'Albino', NULL),
('opt_hair_color', 'BLN', 'Blond or Strawberry', NULL),
('opt_hair_color', 'BLK', 'Black', NULL),
('opt_hair_color', 'BLD', 'Bald', NULL),
('opt_location_type', '2', 'Town or Neighborhood', NULL),
('opt_location_type', '1', 'County or Equivalent', NULL),
('opt_contact_type', 'zip', 'Zip Code', NULL),
('opt_eye_color', NULL, 'Unknown', NULL),
('opt_eye_color', 'HAZ', 'Hazel', NULL),
('opt_eye_color', 'MAR', 'Maroon', NULL),
('opt_eye_color', 'MUL', 'Multicolored', NULL),
('opt_eye_color', 'PNK', 'Pink', NULL),
('opt_skin_color', 'DBR', 'Dark Brown', NULL),
('opt_skin_color', 'FAR', 'Fair', NULL),
('opt_skin_color', 'LGT', 'Light', NULL),
('opt_skin_color', 'LBR', 'Light Brown', NULL),
('opt_skin_color', 'MED', 'Medium', NULL),
('opt_skin_color', NULL, 'Unknown', NULL),
('opt_skin_color', 'OLV', 'Olive', NULL),
('opt_skin_color', 'RUD', 'Ruddy', NULL),
('opt_skin_color', 'SAL', 'Sallow', NULL),
('opt_skin_color', 'YEL', 'Yellow', NULL),
('opt_hair_color', 'BLU', 'Blue', NULL),
('opt_hair_color', 'BRO', 'Brown', NULL),
('opt_hair_color', 'GRY', 'Gray', NULL),
('opt_hair_color', 'GRN', 'Green', NULL),
('opt_hair_color', 'ONG', 'Orange', NULL),
('opt_hair_color', 'PLE', 'Purple', NULL),
('opt_hair_color', 'PNK', 'Pink', NULL),
('opt_hair_color', 'RED', 'Red or Auburn', NULL),
('opt_hair_color', 'SDY', 'Sandy', NULL),
('opt_hair_color', 'WHI', 'White', NULL),
('opt_race', 'R2', 'Asian', NULL),
('opt_race', 'R3', 'Black or African American', NULL),
('opt_race', 'R4', 'Native Hawaiian or Other Pacific Islander', NULL),
('opt_race', 'R5', 'White', NULL),
('opt_race', 'R9', 'Other Race', NULL),
('opt_religion', 'PEV', 'Protestant, Evangelical', 1),
('opt_religion', 'PML', 'Protestant, Mainline', 2),
('opt_religion', 'PHB', 'Protestant, Historically Black', 3),
('opt_religion', 'CAT', 'Catholic', 4),
('opt_religion', 'MOM', 'Mormon', 5),
('opt_religion', 'JWN', 'Jehovah''s Witness', 6),
('opt_religion', 'ORT', 'Orthodox', 7),
('opt_religion', 'COT', 'Other Christian', 8),
('opt_religion', 'JEW', 'Jewish', 9),
('opt_religion', 'BUD', 'Buddhist', 10),
('opt_religion', 'HIN', 'Hindu', 11),
('opt_religion', 'MOS', 'Muslim', 12),
('opt_religion', 'OTH', 'Other Faiths', 13),
('opt_religion', 'NOE', 'Unaffiliated', 14),
('opt_religion', NULL, 'Unknown', 15),
('opt_hair_color', NULL, 'Unknown', NULL),
('opt_skin_color', 'MBR', 'Medium Brown', NULL),
('opt_gender', NULL, 'Unknown', NULL),
('opt_gender', 'cpx', 'Complex', NULL),
('opt_status', 'unk', 'Unknown', NULL),
('opt_status', 'fnd', 'Found', NULL),
('opt_status_color', 'fnd', '#7E2217', NULL),
('opt_status_color', 'ali', '#167D21', NULL),
('opt_status_color', 'inj', '#FF0000', NULL),
('opt_status_color', 'unk', '#808080', NULL),
('opt_status_color', 'dec', '#000000', NULL),
('opt_status_color', 'mis', '#0000FF', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fp_manager`
--

CREATE TABLE IF NOT EXISTS `fp_manager` (
  `fp_manager_id` int(11) NOT NULL,
  `name` varchar(450) DEFAULT NULL,
  `designation` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`fp_manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hospital`
--

CREATE TABLE IF NOT EXISTS `hospital` (
  `hospital_uuid` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT 'enter name here',
  `short_name` varchar(30) NOT NULL DEFAULT 'shortname',
  `street1` varchar(120) DEFAULT NULL,
  `street2` varchar(120) DEFAULT NULL,
  `city` varchar(60) DEFAULT NULL,
  `county` varchar(60) DEFAULT NULL,
  `region` varchar(60) DEFAULT NULL,
  `postal_code` varchar(16) DEFAULT NULL,
  `country` varchar(32) DEFAULT NULL,
  `latitude` double NOT NULL DEFAULT '38.995523',
  `longitude` double NOT NULL DEFAULT '-77.096597',
  `phone` varchar(16) DEFAULT NULL,
  `fax` varchar(16) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `www` varchar(256) DEFAULT NULL,
  `npi` varchar(32) DEFAULT NULL,
  `patient_id_prefix` varchar(32) DEFAULT NULL,
  `patient_id_suffix_variable` tinyint(1) NOT NULL DEFAULT '1',
  `patient_id_suffix_fixed_length` int(11) NOT NULL DEFAULT '0',
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `icon_url` varchar(128) DEFAULT NULL,
  `legalese` text COMMENT 'legalese',
  `legaleseAnon` text COMMENT 'anonymized legalese',
  `legaleseTimestamp` timestamp NULL DEFAULT NULL COMMENT 'when legalese was last updated',
  `legaleseAnonTimestamp` timestamp NULL DEFAULT NULL COMMENT 'when legaleseAnon was last updated',
  `photo_required` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Whether a photo is requred for incoming patients.',
  `honor_no_photo_request` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Whether to honor requests no to save patient images.',
  `photographer_name_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether to require if a photographer include his/her name.',
  PRIMARY KEY (`hospital_uuid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `hospital`
--

INSERT INTO `hospital` (`hospital_uuid`, `name`, `short_name`, `street1`, `street2`, `city`, `county`, `region`, `postal_code`, `country`, `latitude`, `longitude`, `phone`, `fax`, `email`, `www`, `npi`, `patient_id_prefix`, `patient_id_suffix_variable`, `patient_id_suffix_fixed_length`, `creation_time`, `icon_url`, `legalese`, `legaleseAnon`, `legaleseTimestamp`, `legaleseAnonTimestamp`, `photo_required`, `honor_no_photo_request`, `photographer_name_required`) VALUES
(1, 'Suburban Hospital', 'Suburban', '8600 Old Georgetown Road', '', 'Bethesda', 'Montgomery', 'MD', '20814-1497', 'USA', 43.4420293, -71.300549, '301-896-3118', '', 'info@suburbanhospital.org', 'www.suburbanhospital.org', '1205896446', '911-', 0, 5, '2010-01-01 06:01:01', 'theme/lpf3/img/suburban.png', '[This document is a straw man example, based on a reworking of the HIPAA policy statement at www.hhs.gov/hipaafaq/providers/hipaa-1068.html.  It has not been reviewed by legal council, nor reviewed or approved by Suburban Hospital or any other BHEPP member.]\n\n[The following is an example statement for attachment to a full record generated by "TriagePic".  Partial records (e.g., de-identified) have different statements.]\n\nNotice of Privacy Practices and Information Distribution\n========================================================\nSuburban Hospital is covered by HIPAA, so the provided disaster victim information (the "record", which may include a photo) is governed by provisions of the HIPAA Privacy Rule.\n\nDuring a disaster, HIPPA permits disclosures for treatment purposes, and certain disclosures to disaster relief organizations (like the American Red Cross) so that family members can be notified of the patient''s location.  (See CFR 164.510(b)(4).\n\nThe primary of purpose of the record is for family reunification.  Secondary usages may include in-hospital patient tracking, treatment/continuity-of-care on patient transfer, disaster situational awareness and resource management, and feedback to emergency medical service providers who provide pre-hospital treatment.  The record (in various forms) will be distributed within Suburban Hospital, and to and within the institutions with which Suburban Hospital partners through the Bethesda Hospital Emergency Preparedness Partnership.  These are the NIH Clinical Center, Walter Reed National Military Medical Hospital, and National Library of Medicine.  In particular, the record is sent to NLM''s Lost Person Finder database for exposure through the web site, with appropriate filtering and verification.  HIPAA allows patients to be listed in the facility directory, and some aspects of Lost Person Finder are analogous to that.  For more, see the Notice of Privacy Practices associated with the LPF web site.  \n\nThe record was generated by a "TriagePic" application, operated by Suburban Hospital personnel.  The application includes the ability to express the following [TO DO]:\n\n- patient agrees to let hospital personnel speak with family members or friends involved in the patient''s care (45 CFR 164.510(b));\n- patient wishes to opt out of the facility directory (45 CFR 164.510(a));  [THIS MIGHT BE INTERPRETED AS OPTING OUT OF LPF.  MORE TO UNDERSTAND.]\n- patient requests privacy restrictions (45 CFR 164.522(a))\n- patient requests confidential communications (45 CFR 164.522(b))\n\n[IMPLICATIONS OF THESE CHOICES ON RECORD GENERATION NOT YET KNOWN.]\n\nIn addition, there is a requirement to distribute a notice of privacy practices, addressed by this attachment and the LPF Notice of Privacy Practices.\n\nPenalties for non-compliance with the above five rules may be waived, for a limited time in a limited geographical area, if the President declares an emergency or disaster AND the Health and Human Services Secretary declares a public health emergency.  Within that declared timespan, a hospital may rely on the waiver (which covers all patients present) only from the moment of instituting its disaster protocol to at most 72 hours later.  For more, see www.hhs.gov/hipaafaq/providers/hipaa-1068.html.  The waiver is authorized under the Project Bioshield Act of 2004 (PL 108-276) and section 1135(b) of the Social Security Act.\n\nPhoto Copyright\n===============\nThe attached photo if any was taken by an employee or volunteer of Suburban Hospital and is copyright Suburban Hospital in the year given by the reporting date.  Reproduction and distribution is permitted to the extent governed by policy for the overall record.  Please credit Suburban Hospital and the employee(s)/volunteer(s) listed.', '[This document is a straw man example.  It has not been reviewed by legal council, nor reviewed or approved by Suburban Hospital or any other BHEPP member.]\n\n[The following is an example statement for attachment to an anonymized, de-identified record generated by "TriagePic".  Full records (e.g., patient-identified) may have different statements.]\n\nNotice of Privacy Practices and Information Distribution\n========================================================\nThe attached record was generated by a "TriagePic" application, operated by Suburban Hospital personnel at the point where disaster victims arrive at the hospital.  While the application does generate real-time patient-specific information (text and photo), the attached record has been anonymized/de-identified to remove patient identifiers (e.g., no photo), and is intended for public release.  It retains categorial information on gender and adult-vs.-child ("Peds"), as well as arrival time, and the hospital personnel involved.  It is intended to be useful for disaster situational awareness and rate-of-arrival purposes.\n\nNo system of de-identification that retains any useful information is perfect.  The recipient who uses this record in an effort to re-identify patients is responsible for any legal ramifications and potential violations of HIPAA or other laws pertaining to patient confidentiality.', '2011-10-04 16:50:51', '2011-10-04 16:50:51', 1, 1, 0),
(2, 'Walter Reed National Military Medical Center', 'WRNMMC', '8901 Rockville Pike', '', 'Bethesda', 'Montgomery', 'MD', '20889-0001', 'USA', 39.00204, -77.0945, '301-295-4611', '', '', 'www.bethesda.med.navy.mil', '1356317069', '', 1, 0, '2010-09-22 22:49:34', 'theme/lpf3/img/nnmc.png', '[This document is a straw man example, based on a reworking of the HIPAA policy statement at www.hhs.gov/hipaafaq/providers/hipaa-1068.html.  It has not been reviewed by legal council, nor reviewed or approved by Walter Reed National Naval Medical Center or any other BHEPP member.]\n\n[The following is an example statement for attachment to a full record generated by "TriagePic".  Partial records (e.g., de-identified) have different statements.]\n\nNotice of Privacy Practices and Information Distribution\n========================================================\nWalter Reed National Medical Medical Center is covered by HIPAA, so the provided disaster victim information (the "record", which may include a photo) is governed by provisions of the HIPAA Privacy Rule.\n\nDuring a disaster, HIPPA permits disclosures for treatment purposes, and certain disclosures to disaster relief organizations (like the American Red Cross) so that family members can be notified of the patient''s location.  (See CFR 164.510(b)(4).\n\nThe primary of purpose of the record is for family reunification.  Secondary usages may include in-hospital patient tracking, treatment/continuity-of-care on patient transfer, disaster situational awareness and resource management, and feedback to emergency medical service providers who provide pre-hospital treatment.  The record (in various forms) will be distributed within Walter Reed National Medical Medical Center, and to and within the institutions with which National Naval Medical Center partners through the Bethesda Hospital Emergency Preparedness Partnership.  These are the NIH Clinical Center, Walter Reed National Medical Medical Hospital, and National Library of Medicine.  In particular, the record is sent to NLM''s People Locator database for exposure through the web site, with appropriate filtering and verification.  HIPAA allows patients to be listed in the facility directory, and some aspects of People Locator are analogous to that.  For more, see the Notice of Privacy Practices associated with the PL web site.  \n\nThe record was generated by a "TriagePic" application, operated by Walter Reed National Military Medical Center personnel.  The application includes the ability to express the following [TO DO]:\n\n- patient agrees to let hospital personnel speak with family members or friends involved in the patient''s care (45 CFR 164.510(b));\n- patient wishes to opt out of the facility directory (45 CFR 164.510(a));  [THIS MIGHT BE INTERPRETED AS OPTING OUT OF PL.  MORE TO UNDERSTAND.]\n- patient requests privacy restrictions (45 CFR 164.522(a))\n- patient requests confidential communications (45 CFR 164.522(b))\n\n[IMPLICATIONS OF THESE CHOICES ON RECORD GENERATION NOT YET KNOWN.]\n\nIn addition, there is a requirement to distribute a notice of privacy practices, addressed by this attachment and the PL Notice of Privacy Practices.\n\nPenalties for non-compliance with the above five rules may be waived, for a limited time in a limited geographical area, if the President declares an emergency or disaster AND the Health and Human Services Secretary declares a public health emergency.  Within that declared timespan, a hospital may rely on the waiver (which covers all patients present) only from the moment of instituting its disaster protocol to at most 72 hours later.  For more, see www.hhs.gov/hipaafaq/providers/hipaa-1068.html.  The waiver is authorized under the Project Bioshield Act of 2004 (PL 108-276) and section 1135(b) of the Social Security Act.\n\nPhoto Copyright\n===============\nThe attached photo if any was taken by an employee or volunteer of Walter Reed National Military Medical Center and is copyright Walter Reed National Military Medical Center in the year given by the reporting date.  Reproduction and distribution is permitted to the extent governed by policy for the overall record.  Please credit Walter Reed National Military Medical Center and the employee(s)/volunteer(s) listed.', '[This document is a straw man example.  It has not been reviewed by legal council, nor reviewed or approved by Walter Reed National Military Medical Center or any other BHEPP member.]\n\n[The following is an example statement for attachment to an anonymized, de-identified record generated by "TriagePic".  Full records (e.g., patient-identified) may have different statements.]\n\nNotice of Privacy Practices and Information Distribution\n========================================================\nThe attached record was generated by a "TriagePic" application, operated by Walter Reed National Military Medical Center personnel at the point where disaster victims arrive at the hospital.  While the application does generate real-time patient-specific information (text and photo), the attached record has been anonymized/de-identified to remove patient identifiers (e.g., no photo), and is intended for public release.  It retains categorial information on gender and adult-vs.-child ("Peds"), as well as arrival time, and the hospital personnel involved.  It is intended to be useful for disaster situational awareness and rate-of-arrival purposes.\n\nNo system of de-identification that retains any useful information is perfect.  The recipient who uses this record in an effort to re-identify patients is responsible for any legal ramifications and potential violations of HIPAA or other laws pertaining to patient confidentiality.', '2011-10-04 16:52:15', '2011-10-04 16:52:15', 1, 1, 0),
(3, 'NLM (testing)', 'NLM', '9000 Rockville Pike', '', 'Bethesda', 'Montgomery', 'MD', '20892', 'USA', 38.995523, -77.096597, '', '', '', 'www.nlm.nih.gov', '1234567890', '911-', 1, -1, '2011-05-02 17:35:40', '', '[This document is a straw man example, based on a reworking of the HIPAA policy statement at www.hhs.gov/hipaafaq/providers/hipaa-1068.html.  It has not been reviewed by legal council, nor reviewed or approved by NLM or any other BHEPP member.]\n\n[The following is an example statement for attachment to a full record generated by "TriagePic".  Partial records (e.g., de-identified) have different statements.]\n\nNotice of Privacy Practices and Information Distribution\n========================================================\nRecords generated by NLM personnel during TriagePic testing do not generally represent real disaster victims.  Photos are most often of drill participants or NLM employees or contractors.\n\nFor any real disaster victim records gathered by a participating BHEPP hospital and provided to NLM:\n\nHospital records are generally covered by HIPAA, so the provided disaster victim information (the "record", which may include a photo) is governed by provisions of the HIPAA Privacy Rule.\n\nDuring a disaster, HIPPA permits disclosures for treatment purposes, and certain disclosures to disaster relief organizations (like the American Red Cross) so that family members can be notified of the patient''s location.  (See CFR 164.510(b)(4).\n\nThe primary of purpose of the record is for family reunification.  Secondary usages may include in-hospital patient tracking, treatment/continuity-of-care on patient transfer, disaster situational awareness and resource management, and feedback to emergency medical service providers who provide pre-hospital treatment.  The record (in various forms) will be distributed within the originating hospital, within NLM (acting as if a hospital while testing by developers), and to and within the institutions with which NLM partners through the Bethesda Hospital Emergency Preparedness Partnership.  These are the NIH Clinical Center, Walter Reed National Medical Medical Hospital, and Suburban Hospital.  In particular, the record is sent to NLM''s Person Locator database for exposure through the web site, with appropriate filtering and verification.  HIPAA allows patients to be listed in the facility directory, and some aspects of Person Locator are analogous to that.  For more, see the Notice of Privacy Practices associated with the PL web site.  \n\nThe record was generated by a "TriagePic" application, operated by BHEPP hospital personnel.  The application includes the ability to express the following [TO DO]:\n\n- patient agrees to let hospital personnel speak with family members or friends involved in the patient''s care (45 CFR 164.510(b));\n- patient wishes to opt out of the facility directory (45 CFR 164.510(a));  [THIS MIGHT BE INTERPRETED AS OPTING OUT OF LPF.  MORE TO UNDERSTAND.]\n- patient requests privacy restrictions (45 CFR 164.522(a))\n- patient requests confidential communications (45 CFR 164.522(b))\n\n[IMPLICATIONS OF THESE CHOICES ON RECORD GENERATION NOT YET KNOWN.]\n\nIn addition, there is a requirement to distribute a notice of privacy practices, addressed by this attachment and the PL Notice of Privacy Practices.\n\nPenalties for non-compliance with the above five rules may be waived, for a limited time in a limited geographical area, if the President declares an emergency or disaster AND the Health and Human Services Secretary declares a public health emergency.  Within that declared timespan, a hospital may rely on the waiver (which covers all patients present) only from the moment of instituting its disaster protocol to at most 72 hours later.  For more, see www.hhs.gov/hipaafaq/providers/hipaa-1068.html.  The waiver is authorized under the Project Bioshield Act of 2004 (PL 108-276) and section 1135(b) of the Social Security Act.\n\nPhoto Copyright\n===============\nThe attached photo if any was taken by an employee, contractor, or volunteer of NLM or of another institutional member of the BHEPP partnership and may be in some cases copyrighted by that institution in the year given by the reporting date or earlier.  Reproduction and distribution is permitted to the extent governed by policy for the overall record.  Please credit the NLM and/or BHEPP and the staffers listed.', '[This document is a straw man example.  It has not been reviewed by legal council, nor reviewed or approved by NLM or any other BHEPP member.]\n\n[The following is an example statement for attachment to an anonymized, de-identified record generated by "TriagePic".  Full records (e.g., patient-identified) may have different statements.]\n\nNotice of Privacy Practices and Information Distribution\n========================================================\nThe attached record was generated by a "TriagePic" application, operated by NLM personnel with test data, or, less likely, by actual BHEPP-partner hospital personnel at the point where disaster victims arrive at the hospital.  While the application does generate real-time patient-specific information (text and photo), the attached record has been anonymized/de-identified to remove patient identifiers (e.g., no photo), and is intended for public release.  It retains categorial information on gender and adult-vs.-child ("Peds"), as well as arrival time, and the hospital personnel involved.  It is intended to be useful for disaster situational awareness and rate-of-arrival purposes.\n\nNo system of de-identification that retains any useful information is perfect.  The recipient who uses this record in an effort to re-identify patients is responsible for any legal ramifications and potential violations of HIPAA or other laws pertaining to patient confidentiality.', '2011-10-04 16:53:01', '2011-10-04 16:53:01', 1, 1, 0),
(4, 'Shady Grove Adventist Hospital', 'Shady Grove', '9901 Medical Center Drive', '', 'Rockville', 'Montgomery', 'MD', '20850', 'USA', 39.096975, -77.199597, '(240) 826-6000', '', '', 'www.shadygroveadventisthospital.com', '1376754457', '', 1, 0, '2011-09-16 14:22:01', '', '...', '...', '2011-10-04 16:53:30', '2011-10-04 16:53:30', 1, 1, 0),
(5, 'Holy Cross Hospital', 'Holy Cross', '1500 Forest Glen Road', '', 'Silver Spring', 'Montgomery', 'MD', '20910', 'USA', 39.015784, -77.0359073, '301-754-7000', '', '', 'www.holycrosshealth.org', '1225067101', '', 1, 0, '2011-09-16 14:28:57', '', '...', '...', '2011-10-04 16:53:47', '2011-10-04 16:53:47', 1, 1, 0),
(7, 'Virginia Hospital Center, Arlington', 'VHC Arlington', '1701 N. George Mason Drive', '', 'Arlington', 'Arlington', 'VA', '22205-3698', 'USA', 38.889643, -77.126661, '(703) 558-5000', '(703) 558-5787', '', 'www.virginiahospitalcenter.com', '1790785996', '', 1, 0, '2011-09-16 14:38:11', '', '...', '...', '2011-10-04 16:53:57', '2011-10-04 16:53:57', 1, 1, 0),
(8, 'St. Francis BG', 'SFBG', '1600 Albany Street', '', 'Beech Grove', '', 'Indiana', '46107', '', 39, -77.101, '', '', '', 'http://www.stfrancishospitals.org/DesktopDefault.aspx?tabid=67', '1205931706', '', 1, 0, '2012-01-17 18:06:25', '', '', '', NULL, NULL, 1, 1, 0),
(9, 'St. Francis IND', 'STF-IND', '8111 S Emerson Ave', '', 'Indianapolis', '', 'IN', '46237', '', 39.6483541, -86.0823324, '(317) 528-5000', '', '', 'http://www.stfrancishospitals.org/DesktopDefault.aspx?tabid=67', '1386749893 ', '', 1, 0, '2012-01-17 18:08:32', '', '', '', NULL, NULL, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE IF NOT EXISTS `image` (
  `image_id` bigint(20) NOT NULL,
  `p_uuid` varchar(128) NOT NULL,
  `image_type` varchar(100) NOT NULL,
  `image_height` int(11) DEFAULT NULL,
  `image_width` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `url` varchar(512) DEFAULT NULL,
  `url_thumb` varchar(512) DEFAULT NULL,
  `original_filename` varchar(64) DEFAULT NULL,
  `principal` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`image_id`),
  KEY `p_uuid` (`p_uuid`),
  KEY `principal` (`principal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `image_seq`
--

CREATE TABLE IF NOT EXISTS `image_seq` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'stores next id in sequence for the image table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `image_seq`
--

INSERT INTO `image_seq` (`id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `image_tag`
--

CREATE TABLE IF NOT EXISTS `image_tag` (
  `tag_id` int(12) NOT NULL AUTO_INCREMENT,
  `image_id` bigint(20) NOT NULL,
  `tag_x` int(12) NOT NULL,
  `tag_y` int(12) NOT NULL,
  `tag_w` int(12) NOT NULL,
  `tag_h` int(12) NOT NULL,
  `tag_text` varchar(128) NOT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `tag_id` (`tag_id`,`image_id`),
  KEY `image_id` (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `image_tag_seq`
--

CREATE TABLE IF NOT EXISTS `image_tag_seq` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'stores next id in sequence for the image_tag table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `image_tag_seq`
--

INSERT INTO `image_tag_seq` (`id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `incident`
--

CREATE TABLE IF NOT EXISTS `incident` (
  `incident_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `search_id` varchar(60) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `shortname` varchar(16) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `private_group` int(11) DEFAULT NULL,
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(1024) DEFAULT NULL,
  `street` varchar(256) DEFAULT NULL,
  `external_report` varchar(8192) DEFAULT NULL,
  PRIMARY KEY (`incident_id`),
  UNIQUE KEY `shortname_idx` (`shortname`),
  KEY `parent_id` (`parent_id`),
  KEY `private_group` (`private_group`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `incident`
--

INSERT INTO `incident` (`incident_id`, `parent_id`, `search_id`, `name`, `shortname`, `date`, `type`, `latitude`, `longitude`, `default`, `private_group`, `closed`, `description`, `street`, `external_report`) VALUES
(1, NULL, NULL, 'Test Exercise', 'test', '2000-01-01', 'TEST', 0, 0, 1, NULL, 0, 'for the Test Exercise', '', ''),
(3, NULL, NULL, 'new event 1507746440', 'x1507746440', '2014-06-08', 'TEST', 39, -77.101, NULL, 1, 0, NULL, NULL, NULL),
(4, NULL, NULL, 'new event 1047169456', 'x1047169456', '2014-06-08', 'TEST', 39, -77.101, NULL, 1, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `incident_seq`
--

CREATE TABLE IF NOT EXISTS `incident_seq` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'stores next id in sequence for the incident table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `incident_seq`
--

INSERT INTO `incident_seq` (`id`) VALUES
(4);

-- --------------------------------------------------------

--
-- Table structure for table `layer`
--

CREATE TABLE IF NOT EXISTS `layer` (
  `layer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `type` smallint(6) NOT NULL,
  `options` varchar(100) NOT NULL,
  PRIMARY KEY (`layer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=42 ;

--
-- Dumping data for table `layer`
--

INSERT INTO `layer` (`layer_id`, `name`, `type`, `options`) VALUES
(38, 'OpenStreetMaps', 0, '{\n      source: new ol.source.OSM()\n    }'),
(39, 'Central Hospitals', 1, ''),
(40, 'OpenStreetMap', 0, '{      source: new ol.source.OSM()    }'),
(41, 'flooded areas', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `map`
--

CREATE TABLE IF NOT EXISTS `map` (
  `map_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `thumbnail` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`map_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `map`
--

INSERT INTO `map` (`map_id`, `name`, `thumbnail`) VALUES
(1, 'Population', 'http://placehold.it/150x150'),
(2, 'Hospitals', 'http://placehold.it/150x150'),
(3, 'Water Resources', 'http://placehold.it/150x150'),
(4, '2014.06.10 Flood', 'http://placehold.it/150x150');

-- --------------------------------------------------------

--
-- Table structure for table `map_has_layer`
--

CREATE TABLE IF NOT EXISTS `map_has_layer` (
  `map_map_id` int(11) NOT NULL,
  `layer_layer_id` int(11) NOT NULL,
  `owner` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`map_map_id`,`layer_layer_id`),
  KEY `fk_map_has_layer_layer1_idx` (`layer_layer_id`),
  KEY `fk_map_has_layer_map1_idx` (`map_map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `map_has_layer`
--

INSERT INTO `map_has_layer` (`map_map_id`, `layer_layer_id`, `owner`) VALUES
(2, 38, 1),
(2, 39, 1),
(4, 39, 0),
(4, 40, 1),
(4, 41, 1);

-- --------------------------------------------------------

--
-- Table structure for table `marker`
--

CREATE TABLE IF NOT EXISTS `marker` (
  `marker_id` int(11) NOT NULL AUTO_INCREMENT,
  `feature_feature_id` int(11) NOT NULL,
  `lat` float DEFAULT NULL,
  `lon` float DEFAULT NULL,
  `alt` int(11) DEFAULT NULL,
  PRIMARY KEY (`marker_id`),
  KEY `fk_marker_feature1_idx` (`feature_feature_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `marker`
--

INSERT INTO `marker` (`marker_id`, `feature_feature_id`, `lat`, `lon`, `alt`) VALUES
(1, 10, 79.9159, 6.91961, 0),
(2, 11, 79.8756, 6.86729, 0),
(3, 12, 79.9108, 6.84253, 1),
(4, 13, 80.2248, 6.07034, 1);

-- --------------------------------------------------------

--
-- Table structure for table `mpres_log`
--

CREATE TABLE IF NOT EXISTS `mpres_log` (
  `log_index` int(11) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `email_subject` varchar(256) NOT NULL,
  `email_from` varchar(128) NOT NULL,
  `email_date` varchar(64) NOT NULL,
  `update_time` datetime NOT NULL,
  `xml_format` varchar(16) DEFAULT NULL COMMENT 'MPRES (unstructured) or XML Format of Incoming Email',
  PRIMARY KEY (`log_index`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `mpres_messages`
--

CREATE TABLE IF NOT EXISTS `mpres_messages` (
  `ix` int(32) NOT NULL AUTO_INCREMENT COMMENT 'the index',
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'when the script was last executed',
  `messages` text COMMENT 'the message log from the execution',
  `error_code` int(12) DEFAULT NULL,
  PRIMARY KEY (`ix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores the message log from mpres module' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `mpres_seq`
--

CREATE TABLE IF NOT EXISTS `mpres_seq` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `last_executed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores status of mpres module' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `mpres_seq`
--

INSERT INTO `mpres_seq` (`id`, `last_executed`, `last_message`) VALUES
(1, '2012-04-01 04:00:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `old_passwords`
--

CREATE TABLE IF NOT EXISTS `old_passwords` (
  `p_uuid` varchar(60) NOT NULL,
  `password` varchar(100) NOT NULL DEFAULT '',
  `changed_timestamp` bigint(20) NOT NULL,
  PRIMARY KEY (`p_uuid`,`password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `password_event_log`
--

CREATE TABLE IF NOT EXISTS `password_event_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `changed_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `p_uuid` varchar(128) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `event_type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `password_event_log`
--

INSERT INTO `password_event_log` (`log_id`, `changed_timestamp`, `p_uuid`, `user_name`, `comment`, `event_type`) VALUES
(1, '2014-05-11 16:05:33', '1', 'root', 'Login Failed : Invalid Password.', '1'),
(2, '2014-05-13 18:35:03', '1', 'root', 'Login Failed : Invalid Password.', '1'),
(4, '2014-06-08 04:08:22', '1', 'root', 'Created a new event using Event Manager', 'EVENT CREATE'),
(5, '2014-06-08 12:16:30', '1', 'root', 'Created a new event using Event Manager', 'EVENT CREATE'),
(14, '2014-06-14 02:00:59', '1', 'root', 'Login Failed : Invalid Password.', '1');

-- --------------------------------------------------------

--
-- Table structure for table `person_deceased`
--

CREATE TABLE IF NOT EXISTS `person_deceased` (
  `deceased_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `details` text,
  `date_of_death` date DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL,
  `place_of_death` text,
  `comments` text,
  PRIMARY KEY (`deceased_id`),
  UNIQUE KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `person_details`
--

CREATE TABLE IF NOT EXISTS `person_details` (
  `details_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `opt_race` varchar(10) DEFAULT NULL,
  `opt_religion` varchar(10) DEFAULT NULL,
  `opt_gender` varchar(10) DEFAULT NULL,
  `years_old` int(7) DEFAULT NULL,
  `minAge` int(7) DEFAULT NULL,
  `maxAge` int(7) DEFAULT NULL,
  `last_seen` text,
  `last_clothing` text,
  `other_comments` text,
  PRIMARY KEY (`details_id`),
  UNIQUE KEY `p_uuid` (`p_uuid`),
  KEY `opt_gender` (`opt_gender`),
  KEY `years_old` (`years_old`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2996979 ;

--
-- Dumping data for table `person_details`
--

INSERT INTO `person_details` (`details_id`, `p_uuid`, `birth_date`, `opt_race`, `opt_religion`, `opt_gender`, `years_old`, `minAge`, `maxAge`, `last_seen`, `last_clothing`, `other_comments`) VALUES
(2995458, '3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2996977, '4', NULL, NULL, NULL, NULL, NULL, 18, 150, 'NLM (testing) Hospital', NULL, 'LPF notification - disaster victim arrives at hospital triage station'),
(2996978, 'localhost/sahana-dmu/www/person.101', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `person_followers`
--

CREATE TABLE IF NOT EXISTS `person_followers` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `follower_p_uuid` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `p_uuid` (`p_uuid`),
  KEY `follower_p_uuid` (`follower_p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `person_notes`
--

CREATE TABLE IF NOT EXISTS `person_notes` (
  `note_id` int(11) NOT NULL AUTO_INCREMENT,
  `note_about_p_uuid` varchar(128) NOT NULL,
  `note_written_by_p_uuid` varchar(128) NOT NULL,
  `note` varchar(1024) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `suggested_status` varchar(3) DEFAULT NULL COMMENT 'the status of the person as suggested by the note maker',
  PRIMARY KEY (`note_id`),
  KEY `note_about_p_uuid` (`note_about_p_uuid`),
  KEY `note_written_by_p_uuid` (`note_written_by_p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `person_physical`
--

CREATE TABLE IF NOT EXISTS `person_physical` (
  `physical_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `opt_blood_type` varchar(10) DEFAULT NULL,
  `height` varchar(10) DEFAULT NULL,
  `weight` varchar(10) DEFAULT NULL,
  `opt_eye_color` varchar(50) DEFAULT NULL,
  `opt_skin_color` varchar(50) DEFAULT NULL,
  `opt_hair_color` varchar(50) DEFAULT NULL,
  `injuries` text,
  `comments` text,
  PRIMARY KEY (`physical_id`),
  UNIQUE KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `person_search`
--
CREATE TABLE IF NOT EXISTS `person_search` (
`p_uuid` varchar(128)
,`full_name` varchar(100)
,`given_name` varchar(50)
,`family_name` varchar(50)
,`expiry_date` datetime
,`updated` datetime
,`updated_db` datetime
,`opt_status` varchar(3)
,`opt_gender` varchar(10)
,`years_old` bigint(11)
,`minAge` bigint(11)
,`maxAge` bigint(11)
,`ageGroup` varchar(7)
,`image_height` int(11)
,`image_width` int(11)
,`url_thumb` varchar(512)
,`icon_url` varchar(128)
,`shortname` varchar(16)
,`hospital` varchar(30)
,`comments` text
,`last_seen` text
,`mass_casualty_id` varchar(255)
);
-- --------------------------------------------------------

--
-- Table structure for table `person_seq`
--

CREATE TABLE IF NOT EXISTS `person_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `person_seq`
--

INSERT INTO `person_seq` (`id`) VALUES
(101);

-- --------------------------------------------------------

--
-- Table structure for table `person_status`
--

CREATE TABLE IF NOT EXISTS `person_status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `opt_status` varchar(3) NOT NULL DEFAULT 'unk',
  `last_updated` datetime DEFAULT NULL,
  `creation_time` datetime DEFAULT NULL,
  `last_updated_db` datetime DEFAULT NULL COMMENT 'Last DB update. (For SOLR indexing.)',
  PRIMARY KEY (`status_id`),
  UNIQUE KEY `p_uuid` (`p_uuid`),
  KEY `last_updated_db` (`last_updated_db`),
  KEY `opt_status` (`opt_status`),
  KEY `last_updated` (`last_updated`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `person_status`
--

INSERT INTO `person_status` (`status_id`, `p_uuid`, `opt_status`, `last_updated`, `creation_time`, `last_updated_db`) VALUES
(1, 'localhost/sahana-dmu/www/person.101', 'unk', '2014-05-12 10:39:17', '2014-05-12 10:39:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `person_to_report`
--

CREATE TABLE IF NOT EXISTS `person_to_report` (
  `p_uuid` varchar(128) NOT NULL,
  `rep_uuid` varchar(128) NOT NULL,
  PRIMARY KEY (`p_uuid`,`rep_uuid`),
  KEY `rep_uuid` (`rep_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `person_to_report`
--

INSERT INTO `person_to_report` (`p_uuid`, `rep_uuid`) VALUES
('localhost/sahana-dmu/www/person.101', '1');

-- --------------------------------------------------------

--
-- Table structure for table `person_updates`
--

CREATE TABLE IF NOT EXISTS `person_updates` (
  `update_index` int(32) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_table` varchar(64) NOT NULL,
  `updated_column` varchar(64) NOT NULL,
  `old_value` varchar(512) DEFAULT NULL,
  `new_value` varchar(512) DEFAULT NULL,
  `updated_by_p_uuid` varchar(128) NOT NULL,
  PRIMARY KEY (`update_index`),
  KEY `p_uuid` (`p_uuid`),
  KEY `updated_by_p_uuid` (`updated_by_p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `person_uuid`
--

CREATE TABLE IF NOT EXISTS `person_uuid` (
  `p_uuid` varchar(128) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `family_name` varchar(50) DEFAULT NULL,
  `given_name` varchar(50) DEFAULT NULL,
  `incident_id` bigint(20) DEFAULT NULL,
  `hospital_uuid` int(32) DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  PRIMARY KEY (`p_uuid`),
  KEY `full_name_idx` (`full_name`),
  KEY `incident_id_index` (`incident_id`),
  KEY `hospital_index` (`hospital_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `person_uuid`
--

INSERT INTO `person_uuid` (`p_uuid`, `full_name`, `family_name`, `given_name`, `incident_id`, `hospital_uuid`, `expiry_date`) VALUES
('1', 'Root /', '/', 'Root', NULL, NULL, NULL),
('2', 'Email System', 'System', 'Email', NULL, NULL, NULL),
('3', 'Anonymous User', 'User', 'Anonymous', NULL, NULL, NULL),
('4', 'TestFrom WebServices', 'WebServices', 'TestFrom', NULL, NULL, NULL),
('localhost/sahana-dmu/www/person.101', NULL, NULL, NULL, 1, NULL, '0000-01-01 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pfif_export_log`
--

CREATE TABLE IF NOT EXISTS `pfif_export_log` (
  `log_index` int(11) NOT NULL AUTO_INCREMENT,
  `repository_id` int(11) DEFAULT '0',
  `direction` varchar(3) NOT NULL DEFAULT 'in',
  `status` varchar(10) NOT NULL,
  `start_mode` varchar(10) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `first_entry` datetime NOT NULL,
  `last_entry` datetime NOT NULL,
  `last_count` int(11) DEFAULT '0',
  `person_count` int(11) DEFAULT '0',
  `note_count` int(11) DEFAULT '0',
  PRIMARY KEY (`log_index`),
  KEY `repository_id` (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pfif_harvest_note_log`
--

CREATE TABLE IF NOT EXISTS `pfif_harvest_note_log` (
  `log_index` int(11) NOT NULL AUTO_INCREMENT,
  `repository_id` int(11) DEFAULT '0',
  `direction` varchar(3) NOT NULL DEFAULT 'in',
  `status` varchar(10) NOT NULL,
  `start_mode` varchar(10) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `first_entry` datetime NOT NULL,
  `last_entry` datetime NOT NULL,
  `last_count` int(11) DEFAULT '0',
  `note_count` int(11) DEFAULT '0',
  PRIMARY KEY (`log_index`),
  KEY `repository_id` (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pfif_harvest_person_log`
--

CREATE TABLE IF NOT EXISTS `pfif_harvest_person_log` (
  `log_index` int(11) NOT NULL AUTO_INCREMENT,
  `repository_id` int(11) DEFAULT '0',
  `direction` varchar(3) NOT NULL DEFAULT 'in',
  `status` varchar(10) NOT NULL,
  `start_mode` varchar(10) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `first_entry` datetime NOT NULL,
  `last_entry` datetime NOT NULL,
  `last_count` int(11) DEFAULT '0',
  `person_count` int(11) DEFAULT '0',
  `images_in` int(11) DEFAULT '0',
  `images_retried` int(11) DEFAULT '0',
  `images_failed` int(11) DEFAULT '0',
  PRIMARY KEY (`log_index`),
  KEY `repository_id` (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pfif_note`
--

CREATE TABLE IF NOT EXISTS `pfif_note` (
  `note_record_id` varchar(128) NOT NULL,
  `p_uuid` varchar(128) NOT NULL,
  `source_version` varchar(10) NOT NULL DEFAULT '1.3',
  `source_repository_id` int(11) DEFAULT NULL,
  `linked_person_record_id` varchar(128) DEFAULT NULL,
  `entry_date` datetime NOT NULL,
  `author_name` varchar(100) DEFAULT NULL,
  `author_email` varchar(100) DEFAULT NULL,
  `author_phone` varchar(100) DEFAULT NULL,
  `source_date` datetime NOT NULL,
  `found` varchar(5) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `email_of_found_person` varchar(100) DEFAULT NULL,
  `phone_of_found_person` varchar(100) DEFAULT NULL,
  `last_known_location` text,
  `text` text,
  PRIMARY KEY (`note_record_id`),
  KEY `p_uuid` (`p_uuid`),
  KEY `source_repository_id` (`source_repository_id`),
  KEY `linked_person_record_id` (`linked_person_record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IMPORT WILL FAIL if you add foreign key constraints.';

-- --------------------------------------------------------

--
-- Table structure for table `pfif_note_seq`
--

CREATE TABLE IF NOT EXISTS `pfif_note_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pfif_note_seq`
--

INSERT INTO `pfif_note_seq` (`id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `pfif_person`
--

CREATE TABLE IF NOT EXISTS `pfif_person` (
  `p_uuid` varchar(128) NOT NULL,
  `source_version` varchar(10) NOT NULL,
  `source_repository_id` int(11) NOT NULL,
  `entry_date` datetime NOT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `author_name` varchar(100) DEFAULT NULL,
  `author_email` varchar(100) DEFAULT NULL,
  `author_phone` varchar(100) DEFAULT NULL,
  `source_name` varchar(100) DEFAULT NULL,
  `source_date` datetime DEFAULT NULL,
  `source_url` varchar(512) DEFAULT NULL,
  `full_name` varchar(128) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `home_city` varchar(100) DEFAULT NULL,
  `home_state` varchar(15) DEFAULT NULL,
  `home_country` varchar(2) DEFAULT NULL,
  `home_neighborhood` varchar(100) DEFAULT NULL,
  `home_street` varchar(100) DEFAULT NULL,
  `home_postal_code` varchar(16) DEFAULT NULL,
  `photo_url` varchar(512) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `age` varchar(10) DEFAULT NULL,
  `other` text,
  PRIMARY KEY (`p_uuid`),
  KEY `source_repository_id` (`source_repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pfif_repository`
--

CREATE TABLE IF NOT EXISTS `pfif_repository` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `incident_id` bigint(11) DEFAULT NULL,
  `base_url` varchar(512) DEFAULT NULL,
  `subdomain` varchar(32) DEFAULT 'YMz6eKr-yEA3TXGp',
  `auth_key` varchar(16) DEFAULT 'YMz6eKr-yEA3TXGp',
  `resource_type` varchar(6) DEFAULT NULL,
  `role` varchar(6) DEFAULT NULL,
  `granularity` varchar(20) NOT NULL DEFAULT 'YYYY-MM-DDThh:mm:ssZ',
  `deleted_record` varchar(10) NOT NULL DEFAULT 'no',
  `sched_interval_minutes` int(11) NOT NULL DEFAULT '0',
  `log_granularity` varchar(20) NOT NULL DEFAULT '24:00:00',
  `first_entry` datetime DEFAULT NULL,
  `last_entry` datetime DEFAULT NULL,
  `total_persons` int(11) NOT NULL DEFAULT '0',
  `total_notes` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `pfif_repository`
--

INSERT INTO `pfif_repository` (`id`, `name`, `incident_id`, `base_url`, `subdomain`, `auth_key`, `resource_type`, `role`, `granularity`, `deleted_record`, `sched_interval_minutes`, `log_granularity`, `first_entry`, `last_entry`, `total_persons`, `total_notes`) VALUES
(1, 'googlexxx', 3, NULL, 'YMz6eKr-yEA3TXGp', 'YMz6eKr-yEA3TXGp', 'person', 'source', 'YYYY-MM-DDThh:mm:ssZ', 'no', 0, '24:00:00', NULL, NULL, 0, 0),
(2, 'googlexxx', 3, NULL, 'YMz6eKr-yEA3TXGp', 'YMz6eKr-yEA3TXGp', 'note', 'source', 'YYYY-MM-DDThh:mm:ssZ', 'no', 0, '24:00:00', NULL, NULL, 0, 0),
(3, 'googlexxx', 3, NULL, 'YMz6eKr-yEA3TXGp', 'YMz6eKr-yEA3TXGp', 'both', 'sink', 'YYYY-MM-DDThh:mm:ssZ', 'no', 0, '24:00:00', NULL, NULL, 0, 0),
(4, 'googlexxx', 4, NULL, 'YMz6eKr-yEA3TXGp', 'YMz6eKr-yEA3TXGp', 'person', 'source', 'YYYY-MM-DDThh:mm:ssZ', 'no', 0, '24:00:00', NULL, NULL, 0, 0),
(5, 'googlexxx', 4, NULL, 'YMz6eKr-yEA3TXGp', 'YMz6eKr-yEA3TXGp', 'note', 'source', 'YYYY-MM-DDThh:mm:ssZ', 'no', 0, '24:00:00', NULL, NULL, 0, 0),
(6, 'googlexxx', 4, NULL, 'YMz6eKr-yEA3TXGp', 'YMz6eKr-yEA3TXGp', 'both', 'sink', 'YYYY-MM-DDThh:mm:ssZ', 'no', 0, '24:00:00', NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `phonetic_word`
--

CREATE TABLE IF NOT EXISTS `phonetic_word` (
  `encode1` varchar(50) DEFAULT NULL,
  `encode2` varchar(50) DEFAULT NULL,
  `pgl_uuid` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `plus_access_log`
--

CREATE TABLE IF NOT EXISTS `plus_access_log` (
  `access_id` int(16) NOT NULL AUTO_INCREMENT,
  `access_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `application` varchar(32) DEFAULT NULL,
  `version` varchar(16) DEFAULT NULL,
  `ip` varchar(16) DEFAULT NULL,
  `call` varchar(64) DEFAULT NULL,
  `api_version` varchar(8) DEFAULT NULL,
  `latitude` double DEFAULT NULL COMMENT 'lat of the ip address',
  `longitude` double DEFAULT NULL COMMENT 'lon of the ip address',
  `user_name` varchar(100) DEFAULT NULL COMMENT 'users.user_name that make the call',
  PRIMARY KEY (`access_id`),
  KEY `user_idx` (`user_name`),
  KEY `ip_idx` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `plus_report_log`
--

CREATE TABLE IF NOT EXISTS `plus_report_log` (
  `report_id` int(16) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `report_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `enum` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `point`
--

CREATE TABLE IF NOT EXISTS `point` (
  `point_id` int(11) NOT NULL AUTO_INCREMENT,
  `lat` float DEFAULT NULL,
  `lon` float DEFAULT NULL,
  `alt` int(11) DEFAULT NULL,
  `polyline_polyline_id` int(11) NOT NULL,
  PRIMARY KEY (`point_id`),
  KEY `fk_point_polyline1_idx` (`polyline_polyline_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `point`
--

INSERT INTO `point` (`point_id`, `lat`, `lon`, `alt`, `polyline_polyline_id`) VALUES
(3, 79.8445, 6.93188, 1, 1),
(4, 79.8548, 6.89098, 1, 1),
(5, 79.8843, 6.91279, 1, 1),
(6, 79.8603, 6.9312, 1, 1),
(7, 79.8445, 6.93188, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `polyline`
--

CREATE TABLE IF NOT EXISTS `polyline` (
  `polyline_id` int(11) NOT NULL AUTO_INCREMENT,
  `feature_feature_id` int(11) NOT NULL,
  `is_area` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`polyline_id`),
  KEY `fk_polyline_feature1_idx` (`feature_feature_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `polyline`
--

INSERT INTO `polyline` (`polyline_id`, `feature_feature_id`, `is_area`) VALUES
(1, 14, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `population`
--

CREATE TABLE IF NOT EXISTS `population` (
  `disaster_id` int(11) NOT NULL,
  `total_area` float NOT NULL,
  `area_population` int(11) NOT NULL,
  `affected_area` float DEFAULT NULL,
  `male_injured` int(11) DEFAULT NULL,
  `female_injured` int(11) DEFAULT NULL,
  `pregnant_female_injured` int(11) DEFAULT NULL,
  `young_children_injured` int(11) DEFAULT NULL,
  `infants_injured` int(11) DEFAULT NULL,
  `children_injured` int(11) DEFAULT NULL,
  `male_displaced` int(11) DEFAULT NULL,
  `female_displaced` int(11) DEFAULT NULL,
  `pregnant_female_displaced` int(11) DEFAULT NULL,
  `children_displaced` int(11) NOT NULL,
  `young_children_displaced` int(11) DEFAULT NULL,
  `infants_displaced` int(11) DEFAULT NULL,
  `male_missing` int(11) DEFAULT NULL,
  `female_missing` int(11) DEFAULT NULL,
  `pregnant_female_missing` int(11) DEFAULT NULL,
  `children_missing` int(11) NOT NULL,
  `young_children_missing` int(11) DEFAULT NULL,
  `infants_missing` int(11) DEFAULT NULL,
  `male_deceased` int(11) DEFAULT NULL,
  `female_deceased` int(11) DEFAULT NULL,
  `pregnant_female_deceased` int(11) DEFAULT NULL,
  `children_deceased` int(11) NOT NULL,
  `young_children_deceased` int(11) DEFAULT NULL,
  `infants_deceased` int(11) DEFAULT NULL,
  KEY `fk_population_disaster1_idx` (`disaster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pop_outlog`
--

CREATE TABLE IF NOT EXISTS `pop_outlog` (
  `outlog_index` int(11) NOT NULL AUTO_INCREMENT,
  `mod_accessed` varchar(8) NOT NULL,
  `time_sent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `send_status` varchar(8) NOT NULL,
  `error_message` varchar(512) NOT NULL,
  `email_subject` varchar(256) NOT NULL,
  `email_from` varchar(128) NOT NULL,
  `email_recipients` varchar(256) NOT NULL,
  PRIMARY KEY (`outlog_index`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `pop_outlog`
--

INSERT INTO `pop_outlog` (`outlog_index`, `mod_accessed`, `time_sent`, `send_status`, `error_message`, `email_subject`, `email_from`, `email_recipients`) VALUES
(1, 'xst', '2014-06-08 04:08:22', 'ERROR', '<strong>Invalid address: </strong><br />\n', '{ DMU Vesuvius Event Manager Audit }', '', 'audit@example.com'),
(2, 'xst', '2014-06-08 12:16:30', 'ERROR', '<strong>Invalid address: </strong><br />\n', '{ DMU Vesuvius Event Manager Audit }', '', 'audit@example.com');

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE IF NOT EXISTS `property` (
  `property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `value` varchar(45) DEFAULT NULL,
  `feature_feature_id` int(11) NOT NULL,
  PRIMARY KEY (`property_id`),
  KEY `fk_property_feature1_idx` (`feature_feature_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`property_id`, `name`, `value`, `feature_feature_id`) VALUES
(15, 'name', 'National Hospital Colombo', 10),
(16, 'beds', '3246', 10),
(17, 'name', 'Kalubowila Hospital', 11),
(18, 'beds', '1093', 11),
(19, 'name', 'Sri Jayawardenepura hospital', 12),
(20, 'beds', '1043', 12),
(21, 'name', 'Karapitiya', 13),
(22, 'beds', '1596', 13),
(23, 'area', '214 km', 14);

-- --------------------------------------------------------

--
-- Table structure for table `rap_log`
--

CREATE TABLE IF NOT EXISTS `rap_log` (
  `rap_id` int(16) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `report_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rap_id`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `rap_log`
--

INSERT INTO `rap_log` (`rap_id`, `p_uuid`, `report_time`) VALUES
(1, 'localhost/sahana-dmu/www/person.101', '2014-05-12 08:39:19');

-- --------------------------------------------------------

--
-- Table structure for table `rez_pages`
--

CREATE TABLE IF NOT EXISTS `rez_pages` (
  `rez_page_id` int(11) NOT NULL AUTO_INCREMENT,
  `rez_menu_title` varchar(64) NOT NULL,
  `rez_menu_order` int(11) NOT NULL,
  `rez_content` mediumtext NOT NULL,
  `rez_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rez_visibility` varchar(16) NOT NULL,
  `rez_locale` varchar(6) NOT NULL DEFAULT 'en_US',
  PRIMARY KEY (`rez_page_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=44 ;

--
-- Dumping data for table `rez_pages`
--

INSERT INTO `rez_pages` (`rez_page_id`, `rez_menu_title`, `rez_menu_order`, `rez_content`, `rez_timestamp`, `rez_visibility`, `rez_locale`) VALUES
(-45, 'PLUS Web Service API', 38, '<a href="https://docs.google.com/document/d/17pApAVZvg4g93sjZOY3Rp8-MfSu8wSRMycUca3LXNJc/edit?hl=en_US">Click here to open the Google Doc for the PLUS Web Services</a><br>', '2012-03-01 21:29:28', 'Hidden', 'en_US'),
(-30, 'ABOUT', 36, '<meta http-equiv="content-type" content="text/html; charset=utf-8"><span class="Apple-style-span" style="font-family: ''Times New Roman''; font-size: medium; "><pre style="word-wrap: break-word; white-space: pre-wrap; ">Some of the Sahana Agasti modules are being actively developed, maintained, or customized by the U.S. National Library of Medicine (NLM), located on the National Institutes of Health (NIH) campus in Bethesda, Maryland. NLM is in a community partnership with 3 nearby hospitals (National Naval Medical Center, NIH Clinical Center, Suburban Hospital) to improve emergency responses to a mass disaster impacting those hospitals. The partnership, called the Bethesda Hospitals'' Emergency Preparedness Partnership (BHEPP), received initial federal funding for LPF and other NLM IT projects in 2008-9. The LPF project is currently supported by the Intramural Research Program of the NIH, through NLMâ€™s Lister Hill National Center for Biomedical Communications (LHNCBC). Software development is headed by LHNCBC''s Communication Engineering Branch (CEB), with additional content from LHNCBC''s Computer Science Branch (CSB) and the Disaster Information Management Research Center (DIMRC), part of NLM''s Specialized Information Services.</pre></span>', '2012-03-01 21:29:33', 'Hidden', 'en_US'),
(-20, 'Access Denied', -20, 'You do not have permission to access this event. If you believe this is in error, please contact lpfsupport@mail.nih.gov', '2011-06-14 16:59:53', 'Hidden', 'en_US'),
(-6, 'Password Reset.', 8, '<div><br></div><div>Your password has been successfully reset and the new password emailed to you.</div>', '2011-06-14 17:09:49', 'Hidden', 'en_US'),
(-5, 'Account activated.', 7, '<div><br></div><div>Your account has been successfully activated. You may now <a href="index.php?mod=pref&amp;act=loginForm" title="login" target="">login to the site</a> to begin using it.</div>', '2011-06-14 17:09:49', 'Hidden', 'en_US'),
(-4, 'Account already active.', 6, '<div><br></div><div>This confirmation link is no longer valid. The account attached to it is already active.</div>', '2011-06-14 17:06:55', 'Hidden', 'en_US'),
(11, 'How do I search for a person?', 14, '<h2>Searching</h2>\n1) Enter a name in the search box<br>\n2) Click on the "Search" button, or hit Enter <br>\n<br>\n<i>Examples:</i><br>\n<br>\n Joseph Doe<br>\n Doe, Jane<br>\n Joseph Joe Joey<br>\n<br>\nIt is best to leave off titles ("Dr.", "Mrs.") and suffixes ("Jr") at this time.<br>\n<br>\n<br>\n<h2>Search Options</h2>\nOnce you have performed a search, you may also limit your results by status, gender, and age.<br>\n<br>\nStatus choices are missing (blue), alive and well (green), injured (red), deceased (black), found (brown) or unknown (gray).<br>\n<br>\nGender choices are male, female, and other/unknown.<br>\n<br>\nAge choices are 0-17, 18+, or unknown.<br><br>If you want to see only records that have photos, include "[image]" in the search box.&nbsp; Use "[-image]" to see only records that have no photos.<br>\n<br>\n<br>\n<h2>Results</h2>\nResults include any of the search terms.&nbsp; To tolerate misspellings, results are not limited to exact matches.&nbsp; Matches may include names found in certain fields, like Notes, that will be visible only if you consult the record''s details.<br>\n<br>\nUnder the search box is the number of records found that match your search, and the total number in the database (e.g., Found 2 out of 43).<br>\n<br>\nYou may sort your results by Time, Name, Age, or Status.&nbsp; By Name orders by last name, then within that, first.&nbsp; By Age will use a calculated midpoint age for each record with an age range. <br>\n<br>\nInteractive mode displays results by page.  The default is 25 per page.  You may change it to 50 or 100 per page via the pull down menu at the top of the results.<br>\n<br>\nHands Free mode displays results as several horizontally-scrolling rows of boxes with a photograph or text.  The boxes always distribute themselves evenly among the rows, starting at the right side and from top row to bottom.  If there are more boxes than can be shown at once, the rows will become animated to scroll horizontally with wrap-around.  There is no meaning to the ordering of the images at this time.<br>\n<br>\n<br>\n<h2>Getting Details about a Given Results<br></h2>\nClick on the results (photo or text) for more information.<br>\n<br>\n<br>\n<h2>Pause and Play Buttons</h2>\nIf horizontal scrolling is occurring, Pause will stop that, and Play will resume it.  Even while paused, the search will be repeated every minute to look for fresh content.<br>\n<br>\n<br>\n<h2>Search and Data Updates</h2>\nOnce a set of results for a search is loaded, the search will be quietly repeated every minute to see if there is new content.<br><br>New Information can be input via the Report a Person page, or sent to us directly by email or web service, e.g., from apps like ReUnite and TriagePic.\n<br>\n<br><br>', '2011-11-22 20:39:09', 'Public', 'en_US'),
(24, 'Links to other organizations', 35, '<h2>Find Family and Friends</h2>\n<a href="https://safeandwell.communityos.org/cms//" title="Red Cross Safe and Well List">Red Cross Safe and Well List</a><br>\n<a href="http://www.nokr.org/nok/restricted/home.htm" title="Next of Kin National Registry">Next of Kin National Registry</a><br>\n<a href="http://www.lrcf.net/create-flyer/" title="Missing Person Flier Creation Tools">Missing Person Flier Creation Tools</a><br>\n<br>\n\n<h2>Disaster Resources - General</h2>\n<a target="" title="Disaster Assistance" href="http://www.disasterassistance.gov/">Disaster Assistance</a><br>\n<a href="http://app.redcross.org/nss-app/" title="Red Cross Provides Shelters and Food">Red Cross Provides Shelters and Food</a><br>\n<a target="" title="NLM''s Disaster Information Management Resource Center" href="http://disasterinfo.nlm.nih.gov">NLM''s Disaster Information Management Resource Center</a>, currently highlighting flood and hurricane information.<br> \n\n<h2>Disaster Resources - Tornadoes</h2>\n<a target="" title="Tornado Information from the Disaster Information Management Resource Center" href="http://disaster.nlm.nih.gov/enviro/tornados.html">From the Disaster Information Management Resource Center</a><br>\n<a target="" title="Tornado Information  from MedlinePlus" href="http://www.nlm.nih.gov/medlineplus/tornadoes.html">From MedlinePlus</a><br>\n<a target="" title="NOAA 2011 Tornado Information" href="http://www.noaanews.noaa.gov/2011_tornado_information.html">From NOAA 2011</a><br>\n<a target="" title="From Joplin Globe''s Facebook page" href="http://www.poynter.org/latest-news/making-sense-of-news/133446/joplin-globes-facebook-page-locates-reunites-missing-people-in-tornado-aftermath/">About Joplin Globe''s Facebook page -  locates, reunites missing people in tornado aftermath</a>\n\n\n\n\n', '2012-03-01 21:29:37', 'Public', 'en_US'),
(43, 'How do I report a missing or found person?', 18, '<div style="">\n<script type="text/javascript" src="res/js/jquery-1.4.4.min.js"></script>\n<script type="text/javascript" src="res/js/animatedcollapse.js"></script>\n<script>\nanimatedcollapse.addDiv(''more_reunite_en'', ''fade=1,hide=1'');\nanimatedcollapse.addDiv(''more_email_en'', ''fade=1,hide=1'');\nanimatedcollapse.addDiv(''more_reunite_es'', ''fade=1,hide=1'');\nanimatedcollapse.addDiv(''more_email_es'', ''fade=1,hide=1'');\nanimatedcollapse.addDiv(''more_reunite_fr'', ''fade=1,hide=1'');\nanimatedcollapse.addDiv(''more_email_fr'', ''fade=1,hide=1'');\nanimatedcollapse.init();\nanimatedcollapse.ontoggle=function($, divobj, state){}\n</script>\n\n<h1>Reporting a Missing or Found Person</h1>\n<ul>\n  <li><b>By Browser.</b> Use the "Report a Person" link at left.  This is the way to update a report, too.</li>\n  <li><b>By iPhone, iPod Touch, or iPad.</b> Get our free <a href="http://lpf.nlm.nih.gov/" title="">“ReUnite” app</a> from the Apple Store (<a href="#reunite_en">details...</a>).</li>\n  <li><b>By Email.</b> Put name and status in the subject line, as in "Jane Doe missing", attach a photo, and send to <a href="mailto:disaster@mail.nih.gov">disaster@mail.nih.gov</a> (<a href="#email_en">details...</a>).</li>\n  <li><b>By Specialized Software for Hospitals.</b> Ask NLM about our "TriagePic" Windows software for triage stations.</li>\n</ul>\n<br>\n<p>[<a href="#reporting_es">[TO DO: In Spanish]</a>]</p>\n<p>[<a href="#reporting_fr">En Français</a>]</p>\n<br>\n<h1>Details</h1>\n\n<a id="reunite_en"><br><h4>Reporting using our iPhone™ App, “ReUnite”</h4></a>\n\nOf particular interest to aid workers, we provide a free iPhone app called <a href="http://lpf.nlm.nih.gov/" title="">ReUnite</a> through the Apple Store.&nbsp;\nThis creates structured content with associated photographs (limited to 1 per submission so far).&nbsp;\nMore information can be transmitted to us this way than using the unstructured email method below.<br>\n<br>\nReUnite currently supports iPhone 3G and iPhone 4 with iPhone OS 3.0 or later.&nbsp; iPod Touch and iPad are also usable.<br>\n<br>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:animatedcollapse.toggle(''more_reunite_en'')">Show/Hide More...</a>\n<br>\n<br>\n<div id="more_reunite_en" display="none;">\nUsers can choose to take a new photo using their iPhone’s camera\nor use an existing image from their camera roll/photo library.&nbsp;\nThey are then able to tag certain information about the person in the photo.&nbsp;\nThe following fields, all optional, are available for editing:<br>\n    <ul>\n      <li>Given Name</li>\n      <li>Family Name</li>\n      <li>Health Status: (Alive &amp; Well / Injured / Deceased / Unknown)</li>\n      <li>Gender: (Male / Female / Unknown)</li>\n      <li>Age Group: (0-17 / 18+ / Unknown) <i>(or enter an estimated age instead)</i></li>\n      <li>Estimated Age, in years</li>\n      <li>Location Status: (Missing / Known)</li>\n      <li>Last Known Location <i>(if missing)</i> / Current Location <i>(otherwise)</i></li>\n    </ul>\n    <p>Street <i>(typically)</i></p>\n    <p>Town <i>(typically)</i></p>\n    <ul>\n      <li>ID Tag <i>Automatically generated by default. Aid workers can substitute organization’s triage number.</i></li>\n      <li>Voice Note</li>\n      <li>Text Note</li>\n    </ul>\n    <p>In addition, the following info is generated at the time the record is created:</p>\n    <ul>\n      <li>GPS Location <span style="font-style: italic;">(if enabled)</span><br></li>\n      <li>Date and time</li>\n    </ul>\nThe image and corresponding information can then be sent by web service (or as backup, by email) to the PL server automatically.&nbsp;\n    The info is also embedded into the image’s EXIF tags.&nbsp;\n    The records (including photos) are stored locally on the iPhone in an SQLite database format.&nbsp;\n    This database can be sent by email to <a href="mailto:lpfsupport@mail.nih.gov">lpfsupport@mail.nih.gov</a>,\n    where support personnel can arrange to have it included in our database.&nbsp;\n    Consequently, data can be collected when cell phone connectivity is not available,\n    and subsequently sent when connectivity becomes available.<br>\n</div>\n<br>\n<a id="email_en"><br><h4>Quick Reporting by Email of Name, Status, and Photo</h4></a>\n\nYou may also report a name and simple status directly to us by email (such as by cell phone).  You may also attach a photograph (limited to 1 at the moment).  Acceptable formats are .jpg (or .jpeg), .png, and .gif . For now, content in the email body is ignored.<br>\n<br>\n<p>Email to: <a href="mailto:disaster@mail.nih.gov">disaster@mail.nih.gov</a></p>\n<p>Subject Line: <i>Name of Missing or Found Person</i> <b>Status</b></p>\n<p>where <b>Status</b>, whose case doesn''t matter, is</p>\n<ul>\n   <li>Missing</li>\n   <li>Alive and Well</li>\n   <li>Injured</li>\n   <li>Deceased</li>\n   <li>Found <i>(but it''s better to use a status that indicates health too)</i></li>\n</ul>\n<br>\nExample of subject line: “Jean Baptiste alive and well”<br>\nPunctuation will be treated as spaces.<br>\n<br>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:animatedcollapse.toggle(''more_email_en'')">Show/Hide More...</a>\n<br>\n<br>\n<div id="more_email_en" display="none;">\n<p><b>Table of Status Words</b></p>\n <table border="1" cellpadding="0" cellspacing="0">\n  <tbody><tr>\n   <td valign="top" width="163"><p><b>Status Assumed</b></p></td>\n   <td valign="top" width="811"><p><b>Recognized words in subject line (case doesn’t matter)</b></p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Missing</p></td>\n   <td valign="top" width="811"><p>missing, lost, looking for, [to] find</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"></td>\n   <td valign="top" width="811"><p>French: disparu, perdu, trouver, a la recherche de, trouver [SUITE: à la recherche de]</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Alive and Well</p></td>\n   <td valign="top" width="811"><p>alive, well, okay, OK, good, healthy, recovered, fine</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"></td>\n   <td valign="top" width="811"> <p>French: en vie, vivant, ok, bien portant, en bonne sante, gueri [SUITE: en bonne santé, guéri]</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Injured</p></td>\n   <td valign="top" width="811"><p>injured, hurt, wounded, sick, treated, recovering</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"></td>\n   <td valign="top" width="811"><p>French: blesse, mal en point, malade, soigne, convalscent [SUITE: blessé, soigné]</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Deceased</p></td>\n   <td valign="top" width="811"><p>deceased, dead, died, buried</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"></td>\n   <td valign="top" width="811"><p>French: decede, mort, inhume [SUITE: décédé, inhumé ]</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Found</p></td>\n   <td valign="top" width="811"><p>found</p></td>\n  </tr>\n </tbody></table>\n<p>When entering Status:</p>\n<ul>\n   <li>Avoid using the word “not”</li>\n   <li>Avoid using the word “found” alone, without further indicating health status in one of the three categories.</li>\n</ul>\n</div>\n<br>\n<hr>\n<br>\n<a id="reporting_es"><br><h1>Creando un reporte [TO DO: about a Missing or Found Person][TRANSLATION IN PROGRESS]</h1></a>\n    <br>\n	[TO DO: Bullet points]<br>\n<ul>\n  <li><b>By Browser.</b> Use the "Report a Person" link at left.  This is the way to update a report, too.</li>\n  <li><b>By iPhone, iPod Touch, or iPad.</b> Get our free <a href="http://lpf.nlm.nih.gov/" title="">“ReUnite” app</a> from the Apple Store (<a href="#reunite_es">details...</a>).</li>\n  <li><b>By Email.</b> Put name and status in the subject line, as in "Jane Doe missing", attach a photo, and send to <a href="mailto:disaster@mail.nih.gov">disaster@mail.nih.gov</a> (<a href="#email_es">details...</a>).</li>\n  <li><b>By Specialized Software for Hospitals.</b> Ask NLM about our "TriagePic" Windows software for triage stations.</li>\n</ul>\n<br>\n<h3>[TO DO: Details]</h3>\n	<a id="reunite_es"><h4>Enviando un reporte mediante la aplicación de iPHone, "ReUnite"</h4></a>\n    De particular interés para los trabajadores humanitarios, ofrecemos una aplicación libre de costo para el iPhone llamada\n    <a href="http://itunes.apple.com/us/app/reunite/id368052994?mt=8" title="">ReUnite</a> a través del "Apple Store".&nbsp;\n    Esta aplicación crea un mensaje electrónico con un contenido estructurado con fotografías asociadas (limitado a 1 por reporte por el momento).\n    Esta aplicación de iPhone permite proporcionar más información que mediante el método de correo electrónico no estructurado explicado arriba.\n    <br><br>\n    "ReUnite" actualmente soporta iPhone 3G y iPhone 4 con iPhone OS 3.0 o una versión más actual.<br>\n	{TO DO: iPod Touch and iPad are also usable.]<br>\n<br>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:animatedcollapse.toggle(''more_reunite_es'')">{TO DO]Show/Hide More...</a>\n<br>\n<br>\n<div id="more_reunite_es" display="none;">\n    Los usuarios pueden elegir tomar una nueva foto usando la cámara de su iPhone o utilizar una imagen existente en su cámara, en su colección de fotografías\n    digitales. Luego de eso, pueden  etiquetar la fotografía con cierta información sobre la persona. Los siguientes campos, todos opcionales, están disponibles para ser editados:<br>\n    <ul>\n      <li>Nombre</li>\n      <li>Apellido</li>\n      <li>Estado de salud: (Vivo y bien / Herido / Fallecido / Desconocido) </li>\n      <li>Género: (Hombre / Mujer / Desconocido) </li>\n      <li>AGrupo de edad: (0-17 / 18 + / Desconocido) <i>(o ingresar una edad estimada en el siguiente campo en su lugar)</i></li>\n      <li>Edad estimada, en años </li>\n      <li>Estado de la información de ubicación: (Desconocida o Conocida) </li>\n      <li>Última ubicación conocida de la persona <i>(si ubicación actual no es conocida)</i> / Ubicación actual <i>(si es conocida)</i></li>\n      <ul>\n         <li>Calle  <i>(típicamente)</i></li>\n         <li>Ciudad o localidad <i>(típicamente)</i></li>\n      </ul>\n      <li>Etiqueta de identificación generada automáticamente. <i>Trabajadores humanitarios pueden substituir esta etiqueta por un código de triage de su organización.</i></li>\n      <li>Notas [TO DO: Voice Note]</li>\n	  <li>Notas [TO DO: Text Note]</li>\n    </ul>\n    <p>Además, la siguiente información se genera cuando sea crea el registro:</p>\n    <ul>\n      <li>Localización geográfica GPS</li>\n      <li>Fecha y hora</li>\n    </ul>\n    Luego, la imagen y la información correspondiente pueden ser enviadas automáticamente por correo electrónico al servidor LPF.\n    La información es también incluida en las etiquetas EXIF de la imagen. Los registros (incluyendo fotos) se almacenan localmente\n    en el iPhone en un formato de base de datos SQLite. Esta base de datos puede ser enviada por correo electrónico a\n    <a href="mailto:lpfsupport@mail.nih.gov">lpfsupport@mail.nih.gov</a>,\n    donde el personal de soporte puede hacer arreglos para que se incluya en nuestra base de datos. Por lo tanto, datos pueden ser recopilados\n    cuando la conectividad de teléfonos celulares no está disponible, y posteriormente enviados cuando la conectividad esté de nuevo disponible.\n	<br>\n</div>\n<br>\n    <a id="email_es"><h4>Creando un reporte rápidamente mediante email, incluyendo nombre, estado y foto</h4></a>\n    <p>Usted puede también reportar directamente el nombre y estado de una persona mediante correo electrónico (por ejemplo desde su teléfono celular).\n    Se puede también adjuntar una fotografía (solo una foto es permitida por el momento). Los formatos digitales aceptados son .jpg (o .jpeg),\n    .png, y .gif. Por ahora, el contenido del cuerpo del mensaje es ignorado.\n	<br>\n    Envíe su correo electrónico a: <a href="mailto:disaster@nih.gov">disaster@nih.gov</a></p>\n	<p>En la línea de asunto (subject) de su mensaje electrónico ingrese el nombre de la persona encontrada o buscada, y una palabra que indique el <b>"estado"</b>\n	o condición de esta persona [, TO DO where <b>estado</b>, whose case doesn''t matter, is]<br>\n    [TO DO: Spanish status strings are planned]<br>\n    </p><ul>\n      <li>Se busca</li>\n      <li>Vivo y bien</li>\n      <li>Herido/herida</li>\n      <li>Fallecido</li>\n	  <li>Encontrado/encontrada <i>([TO DO: but it''s better to use a status that indicates health too)</i></li>\n	</ul>\n\n	Por ejemplo:<br>\n	Asunto: Juan Perez se busca<br>\n	[TO DO:  Punctuation will be treated as spaces.]<br>\n<br>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:animatedcollapse.toggle(''more_email_es'')">[TO DO:]Show/Hide More...</a>\n<br>\n<br>\n<div id="more_email_es" display="none;">\n    <p><b>Tabla de palabras de "estado" o condición de la persona</b></p>\n	[TO DO:  Spanish status strings are planned.  Add English, French rows here too.  Also add spanish to English, French sections]\n <table border="1" cellpadding="0" cellspacing="0">\n  <tbody><tr>\n   <td valign="top" width="163"><p><b>Estados usados por el sistema</b></p></td>\n   <td valign="top" width="811"><p><b>Términos sugeridos para ser usados en "estado" ([TO DO: case doesn''t matter])</b></p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Se busca</p></td>\n   <td valign="top" width="811"><p>Se busca, perdida, perdido, buscando, por encontrar</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Vivo y bien</p></td>\n   <td valign="top" width="811"><p>Vivo, bien, okey, saludable, recuperado</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Herido/herida</p></td>\n   <td valign="top" width="811"><p> Herido, herida, lastimado, lastimada, enfermo, enferma, en tratamiento, recuperándose</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Fallecido</p></td>\n   <td valign="top" width="811"><p>Fallecido, fallecida, muerto, muerta, murió, sepultado, sepultada</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Encontrado/encontrada</p></td>\n   <td valign="top" width="811"><p>Encontrado, encontrada</p></td>\n  </tr>\n </tbody>\n</table>\n    Cuando se ingresa el estado de la persona:<br>\n    <ul>\n      <li> Evite usar la palabra "no"</li>\n      <li>Evite usar la palabra "encontrado" o "encontrada" sola. Indique el estado de salud en una de las tres categorías: vivo y bien, herido, fallecido</li>\n    </ul>\n</div>\n    <br>\n<hr>\n<br>\n<a id="reporting_fr"><br><h1>Signalement d’une Personne Disparu ou Retrouvé<br></h1></a>\n<ul>\n  <li><b>Par Navigateur.</b> Utilisez le lien "Report a Person" à gauche.  C''est la façon de mettre à jour un rapport, aussi.</li>\n  <li><b>Par iPhone, iPod Touch, ou iPad.</b> Obtenez notre application gratuite, <a href="http://lpf.nlm.nih.gov/" title="">“ReUnite”</a>, disponible via Apple Store (<a href="#reunite_fr">détails...</a>).</li>\n  <li><b>Par Courriel.</b> Mettez le nom et le statut dans la ligne sujet ("Jane Doe disparu" par exemple), joindre une photo, et courriel à <a href="mailto:disaster@mail.nih.gov">disaster@mail.nih.gov</a> (<a href="#email_fr">détails...</a>)</li>\n  <li><b>Par des Logiciels Spécialisés pour les Hôpitaux.</b> Demandez NLM sur notre "TriagePic" logiciel Windows pour les stations de triage.</li>\n</ul>\n<br>\n<h1>Détails</h1>\n\n<a id="reunite_fr"><br><h4>Signalement avec l’application iPhone™, “ReUnite”</h4></a>\n\nEn soutien aux acteurs de l’aide internationale, nous proposons une application iPhone gratuite,\n(<a href="http://lpf.nlm.nih.gov/" title="">“ReUnite”</a>), disponible via Apple Store.&nbsp;\nCette application crée un courriel structuré avec photographie jointe (limité à une photographie par soumission).&nbsp;\nD’autres informations peuvent nous être transmises de cette manière, de préférence à l’utilisation d’un courriel classique, non structuré.<br>\n<br>\n“ReUnite” prend actuellement en charge l’iPhone 3G et 4 de l’iPhone avec iPhone OS 3.0 ou une version ultérieure.&nbsp;\niPod Touch et iPad sont également utilisables.<br>\n<br>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:animatedcollapse.toggle(''more_reunite_fr'')">Afficher/Masquer Plus d''Info...</a>\n<br>\n<br>\n<div id="more_reunite_fr" display="none;">\nLes utilisateurs peuvent prendre une photo à l’aide de leur iPhone, ou sélectionner une photo dans leur galerie.&nbsp;\nIls peuvent ensuite joindre certaines informations sur la personne photographiée.&nbsp;\nLes champs suivants (tous optionnels) peuvent être remplis:<br>\n<ul>\n    <li>Prénom</li>\n    <li>Nom de Famille</li>\n    <li>État de santé: (En vie / Blessé /Décédé /Inconnu)</li>\n    <li>Sexe: (Masculin / Féminin / Inconnu)</li>\n    <li>Âge: (0-17 / 18+ / Inconnu) <i>(ou une estimation de l’âge)</i></li>\n    <li>Âge présumé, en années</li>\n    <li>État de position: (Disparu / Connu)</li>\n    <li>Dernière position connue <i>(si disparu)</i> / Position actuelle <i>(sinon)</i></li>\n</ul>\n    <p>Rue <i>(par exemple)</i></p>\n    <p>Ville <i>(par exemple)</i></p>\n<ul>\n    <li>Badge d’identification <i>Généré automatiquement par défaut. Le personnel humanitaire pourra y substituer un numéro de triage spécifique aux organismes.</i></li>\n    <li>Autres remarques et commentaires</li>\n</ul>\nDe plus, les informations suivantes sont automatiquement générées lors de la création du signalement:<br>\n<ul>\n    <li>Position GPS</li>\n    <li>Date et heure</li>\n</ul>\nL’image et les informations associées peuvent ensuite être automatiquement envoyées par courrier électronique au serveur LPF.&nbsp;\nLes informations sont également ajoutées au contenu des tags EXIF de l’image.&nbsp;\nL’ensemble du signalement (y compris l’image) est enregistré localement sur l’iPhone dans une base de données au format SQLite.&nbsp;\nCette base de données peut être envoyée par courrier électronique à <a href="mailto:lpfsupport@mail.nih.gov">lpfsupport@mail.nih.gov</a>,\nafin que notre personnel procède à la mise à jour de notre base de données globale.&nbsp;\nAinsi, les données peuvent être collectées dans des zones sans connexion réseau puis transmises ultérieurement,\ndès qu’une connexion réseau est disponible.<br>\n</div>\n<br>\n\n<a id="email_fr"><br><h4>Signalement rapide par Courriel - envoi de Nom, Statut et Photographie</h4></a>\n\nLe nom et le statut d’une personne peut nous être envoyé\ndirectement par courrier électronique (par exemple, envoyé depuis un\ntéléphone portable).&nbsp; Il vous est également possible de joindre une photographie à votre\nmessage (fonctionnalité limitée à une seule photographie par message\npour l’instant).&nbsp; Les formats acceptés sont .jpg (ou .jpeg), .png, et .gif .&nbsp; Pour l’instant, toute information contenue dans le corps du message\nélectronique est ignorée.<br>\n<br>\n<p>Courriel à : <a href="mailto:disaster@mail.nih.gov">disaster@mail.nih.gov</a></p>\n<p>Sujet: <i>Nom de la victime</i> <b>Statut</b></p>\n<p><span style="font-weight: bold;">Statut</span> =</p>\n<ul>\n  <li>Disparu</li>\n  <li>En Vie</li>\n  <li>Blessé</li>\n  <li>Décédé</li>\n  <li>[Retrouvé] <i>Mais il est préférable d''utiliser un status qui précise la santé, aussi.</i></li>\n</ul>\n<br>\nExemple de sujet d’un courriel: “Jean-Baptiste Dupont En Vie”<br>\nPonctuation seront traités comme des espaces.<br>\n<br>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:animatedcollapse.toggle(''more_email_fr'')">Afficher/Masquer Plus d''Info...</a>\n<br>\n<div id="more_email_fr" display="none;">\n<br>\n<p><b>Tableau des mots décrivant le statut</b></p>\n<table border="1" cellpadding="0" cellspacing="0">\n  <tbody><tr>\n   <td valign="top" width="163"><p><b>Statut Présumé</b></p></td>\n   <td valign="top" width="811">\n    <p><b>Mots Recommandés à indiquer dans le sujet du courriel (pas de distinction entre majuscules et minuscules)</b></p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Disparu</p></td>\n   <td valign="top" width="811"><p>disparu, perdu, trouver, a la recherche de, trouver [SUITE: à la recherche de]</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"></td>\n   <td valign="top" width="811"><p>Anglais: missing, lost, looking for, [to] find</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"> <p>En vie</p></td>\n   <td valign="top" width="811"> <p>en vie, vivant, ok, bien portant, en bonne sante, gueri [SUITE: en bonne santé, guéri]</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"></td>\n   <td valign="top" width="811"><p>Anglais: alive, well, okay, OK, good, healthy, recovered, fine</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"> <p>Blessé</p></td>\n   <td valign="top" width="811"><p>blesse, mal en point, malade, soigne, convalscent [SUITE: blessé, soigné]</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"></td>\n   <td valign="top" width="811"><p>Anglais: injured, hurt, wounded, sick, treated, recovering</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"><p>Décédé</p></td>\n   <td valign="top" width="811"><p>decede, mort, inhume [SUITE: décédé, inhumé ]</p></td>\n  </tr>\n  <tr>\n   <td valign="top" width="163"></td>\n   <td valign="top" width="811"><p>Anglais: deceased, dead, died, buried</p></td>\n  </tr>\n </tbody>\n</table>\nLorsque vous renseignez le statut:<br>\n<ul>\n   <li>Évitez les tournures négatives “pas”, “non”</li>\n   <li>Evitez d’utiliser le mot “trouvé” sans information complémentaire sur l’état de santé de la victime.</li>\n</ul>\n</div>\n<br>\n\n</div>\n\n\n\n\n', '2012-02-29 23:42:37', 'Public', 'en_US');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(64) NOT NULL,
  `sess_key` varchar(64) NOT NULL,
  `secret` varchar(64) NOT NULL,
  `inactive_expiry` bigint(20) NOT NULL,
  `expiry` bigint(20) NOT NULL,
  `data` text,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `sess_key`, `secret`, `inactive_expiry`, `expiry`, `data`) VALUES
('379suqripar1esn4nu3hl3irn2', '56bbfca275bcab4b894fa620901b3d10', 'a83e0573455c14318f030245137cec17', 1402257158, 1402194377, NULL),
('4m8irk5fhffnrlok2sj18r1a50', 'cca6d5eafb051e849766330a1a9488b8', '6df9b44ff5dc4d54e340e3605614bad4', 1402152185, 1402152173, NULL),
('9g7p4tq063tbg3mp2c58htupv5', '077c6d8754c5b44fc70643628d633721', '256afdbaf9fc365d0e542f718fc083e5', 1399889403, 1399882915, NULL),
('car72p8ac1uriujktuiulu7k07', 'c27acb38a53e427e333e99e6b929a651', 'f6710accf8ec92a64204cf70f775fce8', 1398977305, 1398975767, NULL),
('dnf163vk5f6ibap3ol07i2thi7', 'd41d03b3f642345636cb77deee4b6cb1', '8c6b1645463f100f46e38b98a569c25e', 1400083583, 1400083573, NULL),
('e8dtedivl3o74lhtm82740u1h5', '2590cb8f8878b9fbebcb1e7e1fb7fac0', 'd952e9ab85ee72e00a2f6465b29a41c1', 1402335692, 1402334979, NULL),
('eftjktlk2k25ofcl48pg7bk9u1', '82b538c132e47c3b4f4ddc8d548861e1', 'c5045b602915153031b182c16ed49564', 1399833402, 1399824345, NULL),
('g0bdidaak8hbtvs2kuar5f82t4', '0bc6fe1221312ef3e304857b4e04bba1', '6a5e34f56937cb6654ac2d67ec662b28', 1402378075, 1402370414, NULL),
('gj7ttlbittu0nmbivvqq0ck7t6', '31ecec8dee0ddf02d56d7ad237475235', 'f841c4a05988c0b770fdf473f485c797', 1403187979, 1403163026, NULL),
('j0c73rjbmkf04fce568a1kdq62', 'b814511c86fa5b0abfcca3a5b2aaa7b8', '78661af49e0910633ada7efc9836c494', 1402549348, 1402549266, NULL),
('jagpipfijtqls8up9gnsrimkk2', '3a7fcae0ef21e4e0fd6b2f46231d6d81', '418d82d76d2c6662cda15928aff3e08b', 1401983262, 1401983234, NULL),
('johbi0g55nt0u25ct0g25at2s4', '8d5d685d8211410ff86bbe1ce45308b8', 'a086c2f69427e5453c65dc95fd3ca0e3', 1402979973, 1402881785, NULL),
('ls1n28geve8df0cs5e0tl16tg3', 'e941b418b6c6a820395e8c43bb659a3c', '42a1f1600884ff45e259a130e139f9fc', 1402561452, 1402554167, NULL),
('mst531jjes01mnpnrofpmivls1', 'f644204ee35c887d5a0bebde41cac373', '407cc28b8489efd959b567e0b2e33696', 1402567569, 1402539876, NULL),
('oq66r3jvj9h14acoqdj1hgr5v2', '023d46b4265b2f48717671b35eb85847', '8ed25ecda0199f7dd1bb1ed909d83ac1', 1402325441, 1402323725, NULL),
('pb99o6r3qg78gustsh3mq0lod0', '1d33b1e204b1cf5fa1f9ebfb4bf2fa0f', '7f0837b44e17c428e53c2b41e359e132', 1402161875, 1402136797, NULL),
('s3si4j4uim0020e9hvtph7cqt2', 'e72194465cf5f382163e5610da4fe1eb', 'ba4648468556675508a441702cc1cca6', 1402416825, 1402391452, NULL),
('sqcunrotu9pf0vhuenr3pu05i4', '0af461ab013d4c116716d02a2bde0232', '87c522357412f95082e9b68f91b3259a', 1400771371, 1400771355, NULL),
('u9tfpgj2km7ghejpiski8e8mr2', 'd4523250d717fe858772740ca171be85', '6db81b4c18bb31da9588d269f4fdd1af', 1400006125, 1400006115, NULL),
('urfeaiuks89mtpfi9grn8g4rg6', '155d96ae749b6b944d3ff702f753e0b7', '0ed40c4765e19204e10475e9df0fb7d5', 1402596643, 1402577713, NULL),
('vuddg5rvsfk7hjjf98fqqmnri6', '0795702ceabf2015eab6ed2068639e6a', '5ac896fdd1a1a3c93a4ed7271e925622', 1402859736, 1402711271, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `shelter`
--

CREATE TABLE IF NOT EXISTS `shelter` (
  `disaster_id` int(11) NOT NULL,
  `houses_partially` int(11) DEFAULT NULL,
  `houses_totally` int(11) DEFAULT NULL,
  `evaciuation_families` int(11) DEFAULT NULL,
  `evacuation_population` int(11) DEFAULT NULL,
  `displased_families` int(11) DEFAULT NULL,
  `displased_population` int(11) DEFAULT NULL,
  `requiring_shelter` int(11) DEFAULT NULL,
  `require_area` float DEFAULT NULL,
  `temporary_avaiable` int(11) DEFAULT NULL,
  `total _covered` float DEFAULT NULL,
  KEY `fk_shelter_disaster1_idx` (`disaster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_group_to_module`
--

CREATE TABLE IF NOT EXISTS `sys_group_to_module` (
  `group_id` int(11) NOT NULL,
  `module` varchar(60) NOT NULL,
  `status` varchar(60) NOT NULL,
  PRIMARY KEY (`group_id`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_group_to_module`
--

INSERT INTO `sys_group_to_module` (`group_id`, `module`, `status`) VALUES
(1, 'admin', 'enabled'),
(1, 'arrive', 'enabled'),
(1, 'dar', 'enabled'),
(1, 'eap', 'enabled'),
(1, 'em', 'enabled'),
(1, 'gis', 'enabled'),
(1, 'home', 'enabled'),
(1, 'inw', 'enabled'),
(1, 'mpres', 'enabled'),
(1, 'pop', 'enabled'),
(1, 'pref', 'enabled'),
(1, 'rat', 'enabled'),
(1, 'report', 'enabled'),
(1, 'rez', 'enabled'),
(1, 'xst', 'enabled'),
(2, 'eap', 'enabled'),
(2, 'home', 'enabled'),
(2, 'inw', 'enabled'),
(2, 'pref', 'enabled'),
(2, 'report', 'enabled'),
(2, 'rez', 'enabled'),
(2, 'xst', 'enabled'),
(3, 'eap', 'enabled'),
(3, 'home', 'enabled'),
(3, 'inw', 'enabled'),
(3, 'report', 'enabled'),
(3, 'rez', 'enabled'),
(3, 'xst', 'enabled'),
(5, 'eap', 'enabled'),
(5, 'home', 'enabled'),
(5, 'inw', 'enabled'),
(5, 'pref', 'enabled'),
(5, 'report', 'enabled'),
(5, 'rez', 'enabled'),
(5, 'tp', 'enabled'),
(5, 'xst', 'enabled'),
(6, 'eap', 'enabled'),
(6, 'em', 'enabled'),
(6, 'home', 'enabled'),
(6, 'inw', 'enabled'),
(6, 'pref', 'enabled'),
(6, 'report', 'enabled'),
(6, 'rez', 'enabled'),
(6, 'tp', 'enabled'),
(6, 'xst', 'enabled'),
(7, 'eap', 'enabled'),
(7, 'home', 'enabled'),
(7, 'inw', 'enabled'),
(7, 'pref', 'enabled'),
(7, 'report', 'enabled'),
(7, 'rez', 'enabled'),
(7, 'xst', 'enabled');

-- --------------------------------------------------------

--
-- Table structure for table `sys_user_groups`
--

CREATE TABLE IF NOT EXISTS `sys_user_groups` (
  `group_id` int(11) NOT NULL,
  `group_name` varchar(40) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_user_groups`
--

INSERT INTO `sys_user_groups` (`group_id`, `group_name`) VALUES
(1, 'Administrator'),
(2, 'Registered User'),
(3, 'Anonymous User'),
(5, 'Hospital Staff'),
(6, 'Hospital Staff Admin'),
(7, 'Researchers');

-- --------------------------------------------------------

--
-- Table structure for table `sys_user_to_group`
--

CREATE TABLE IF NOT EXISTS `sys_user_to_group` (
  `group_id` int(11) NOT NULL,
  `p_uuid` varchar(128) NOT NULL,
  KEY `p_uuid` (`p_uuid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_user_to_group`
--

INSERT INTO `sys_user_to_group` (`group_id`, `p_uuid`) VALUES
(3, '3'),
(1, '1'),
(3, '2');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(16) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `salt` varchar(100) DEFAULT NULL,
  `changed_timestamp` bigint(20) NOT NULL DEFAULT '0',
  `status` varchar(60) DEFAULT 'active',
  `confirmation` varchar(255) DEFAULT NULL,
  `oauth_id` varchar(32) DEFAULT NULL COMMENT 'the oauth user id',
  `profile_link` varchar(256) DEFAULT NULL COMMENT 'url to profile',
  `profile_picture` varchar(256) DEFAULT NULL COMMENT 'url to profile pic',
  `locale` varchar(8) DEFAULT NULL COMMENT 'language locale',
  `verified_email` tinyint(1) DEFAULT NULL COMMENT 'true if email verified',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `p_uuid`, `user_name`, `password`, `salt`, `changed_timestamp`, `status`, `confirmation`, `oauth_id`, `profile_link`, `profile_picture`, `locale`, `verified_email`) VALUES
(1, '1', 'root', 'c77ce1c91f65ec039c255b7b4981a452', 'e5cb9f3624f2d81964', 1334258322, 'active', NULL, NULL, NULL, NULL, NULL, NULL),
(2, '2', 'mpres', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, '3', 'anonymous', NULL, NULL, 0, 'active', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_preference`
--

CREATE TABLE IF NOT EXISTS `user_preference` (
  `pref_id` int(16) NOT NULL AUTO_INCREMENT,
  `p_uuid` varchar(128) NOT NULL,
  `module_id` varchar(20) NOT NULL,
  `pref_key` varchar(60) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`pref_id`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `voice_note`
--

CREATE TABLE IF NOT EXISTS `voice_note` (
  `voice_note_id` bigint(20) NOT NULL,
  `p_uuid` varchar(128) NOT NULL,
  `length` int(16) DEFAULT NULL,
  `format` varchar(16) DEFAULT NULL,
  `sample_rate` int(16) DEFAULT NULL,
  `channels` int(8) DEFAULT NULL,
  `speaker` enum('Person','Reporter','Other') DEFAULT NULL COMMENT 'Used to identify speaker.',
  `url_original` varchar(1024) DEFAULT NULL COMMENT 'url of the original audio',
  `url_resampled_mp3` varchar(1024) DEFAULT NULL COMMENT 'url of the resampled audio in mp3 format',
  `url_resampled_ogg` varchar(1024) DEFAULT NULL COMMENT 'url of the resampled audio in ogg format',
  PRIMARY KEY (`voice_note_id`),
  KEY `p_uuid` (`p_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `voice_note_seq`
--

CREATE TABLE IF NOT EXISTS `voice_note_seq` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'stores next id in sequence for the voice_note table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `voice_note_seq`
--

INSERT INTO `voice_note_seq` (`id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `wash`
--

CREATE TABLE IF NOT EXISTS `wash` (
  `disaster_id` int(11) NOT NULL,
  `water_resources_id` int(11) NOT NULL,
  `water_status` int(11) DEFAULT NULL,
  `water_in500` int(11) DEFAULT NULL,
  `water_out500` int(11) DEFAULT NULL,
  `need_treatment` int(11) DEFAULT NULL,
  `water_per_day` float DEFAULT NULL,
  `wait_pipe_borne` float DEFAULT NULL,
  `wait_open_well` float DEFAULT NULL,
  `wait_hand_pump` float DEFAULT NULL,
  `need_hygin_training` int(11) DEFAULT NULL,
  `toilets` int(11) DEFAULT NULL,
  `required_toilets` int(11) DEFAULT NULL,
  `deficit_toilet` int(11) DEFAULT NULL,
  `vector_type` varchar(50) DEFAULT NULL,
  `vector_name` varchar(45) DEFAULT NULL,
  `food_disruption` int(11) DEFAULT NULL,
  `food_in200` int(11) DEFAULT NULL,
  KEY `fk_wash_disaster1_idx` (`disaster_id`),
  KEY `fk_wash_water_resources1_idx` (`water_resources_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `water_resources`
--

CREATE TABLE IF NOT EXISTS `water_resources` (
  `water_resources_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`water_resources_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure for view `person_search`
--
DROP TABLE IF EXISTS `person_search`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `person_search` AS select `pu`.`p_uuid` AS `p_uuid`,`pu`.`full_name` AS `full_name`,`pu`.`given_name` AS `given_name`,`pu`.`family_name` AS `family_name`,`pu`.`expiry_date` AS `expiry_date`,`ps`.`last_updated` AS `updated`,`ps`.`last_updated_db` AS `updated_db`,(case when (`ps`.`opt_status` not in (_utf8'ali',_utf8'mis',_utf8'inj',_utf8'dec',_utf8'unk',_utf8'fnd')) then _utf8'unk' else `ps`.`opt_status` end) AS `opt_status`,(case when ((`pd`.`opt_gender` not in (_utf8'mal',_utf8'fml')) or isnull(`pd`.`opt_gender`)) then _utf8'unk' else `pd`.`opt_gender` end) AS `opt_gender`,(case when isnull(cast(`pd`.`years_old` as unsigned)) then -(1) else `pd`.`years_old` end) AS `years_old`,(case when isnull(cast(`pd`.`minAge` as unsigned)) then -(1) else `pd`.`minAge` end) AS `minAge`,(case when isnull(cast(`pd`.`maxAge` as unsigned)) then -(1) else `pd`.`maxAge` end) AS `maxAge`,(case when (cast(`pd`.`years_old` as unsigned) is not null) then (case when (`pd`.`years_old` < 18) then _utf8'youth' when (`pd`.`years_old` >= 18) then _utf8'adult' end) when ((cast(`pd`.`minAge` as unsigned) is not null) and (cast(`pd`.`maxAge` as unsigned) is not null) and (`pd`.`minAge` < 18) and (`pd`.`maxAge` >= 18)) then _utf8'both' when ((cast(`pd`.`minAge` as unsigned) is not null) and (`pd`.`minAge` >= 18)) then _utf8'adult' when ((cast(`pd`.`maxAge` as unsigned) is not null) and (`pd`.`maxAge` < 18)) then _utf8'youth' else _utf8'unknown' end) AS `ageGroup`,`i`.`image_height` AS `image_height`,`i`.`image_width` AS `image_width`,`i`.`url_thumb` AS `url_thumb`,(case when (`h`.`hospital_uuid` = -(1)) then NULL else `h`.`icon_url` end) AS `icon_url`,`inc`.`shortname` AS `shortname`,(case when ((`pu`.`hospital_uuid` not in (1,2,3)) or isnull(`pu`.`hospital_uuid`)) then _utf8'public' else lcase(`h`.`short_name`) end) AS `hospital`,`pd`.`other_comments` AS `comments`,`pd`.`last_seen` AS `last_seen`,`ecl`.`person_id` AS `mass_casualty_id` from ((((((`person_uuid` `pu` join `person_status` `ps` on((`pu`.`p_uuid` = `ps`.`p_uuid`))) left join `image` `i` on(((`pu`.`p_uuid` = `i`.`p_uuid`) and (`i`.`principal` = 1)))) join `person_details` `pd` on((`pu`.`p_uuid` = `pd`.`p_uuid`))) join `incident` `inc` on((`inc`.`incident_id` = `pu`.`incident_id`))) left join `hospital` `h` on((`h`.`hospital_uuid` = `pu`.`hospital_uuid`))) left join `edxl_co_lpf` `ecl` on((`ecl`.`p_uuid` = `pu`.`p_uuid`)));

--
-- Constraints for dumped tables
--

--
-- Constraints for table `arrival_rate`
--
ALTER TABLE `arrival_rate`
  ADD CONSTRAINT `arrival_rate_ibfk_1` FOREIGN KEY (`person_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `arrival_rate_ibfk_2` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `contact_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `disaster`
--
ALTER TABLE `disaster`
  ADD CONSTRAINT `fk_disaster_DisasterType` FOREIGN KEY (`disaster_type`) REFERENCES `disaster_type` (`disaster_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_disaster_assessor1` FOREIGN KEY (`assessor_id`) REFERENCES `fp_manager` (`fp_manager_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_disaster_hospital1` FOREIGN KEY (`focal_point_id`) REFERENCES `hospital` (`hospital_uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `disaster_has_affected_area`
--
ALTER TABLE `disaster_has_affected_area`
  ADD CONSTRAINT `fk_disaster_has_affected_area_disaster1` FOREIGN KEY (`disaster_id`) REFERENCES `disaster` (`disaster_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_disaster_has_affected_area_affected_area1` FOREIGN KEY (`affected_area_id`) REFERENCES `affected_area` (`affected_area_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `edxl_co_header`
--
ALTER TABLE `edxl_co_header`
  ADD CONSTRAINT `edxl_co_header_ibfk_1` FOREIGN KEY (`de_id`) REFERENCES `edxl_de_header` (`de_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `edxl_co_header_ibfk_2` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_co_keywords`
--
ALTER TABLE `edxl_co_keywords`
  ADD CONSTRAINT `edxl_co_keywords_ibfk_1` FOREIGN KEY (`co_id`) REFERENCES `edxl_co_header` (`co_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_co_lpf`
--
ALTER TABLE `edxl_co_lpf`
  ADD CONSTRAINT `edxl_co_lpf_ibfk_1` FOREIGN KEY (`co_id`) REFERENCES `edxl_co_header` (`co_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `edxl_co_lpf_ibfk_2` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_co_photos`
--
ALTER TABLE `edxl_co_photos`
  ADD CONSTRAINT `edxl_co_photos_ibfk_1` FOREIGN KEY (`co_id`) REFERENCES `edxl_co_header` (`co_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `edxl_co_photos_ibfk_2` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_co_roles`
--
ALTER TABLE `edxl_co_roles`
  ADD CONSTRAINT `edxl_co_roles_ibfk_1` FOREIGN KEY (`co_id`) REFERENCES `edxl_co_header` (`co_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `edxl_co_roles_ibfk_2` FOREIGN KEY (`role_num`) REFERENCES `edxl_de_roles` (`role_num`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_de_keywords`
--
ALTER TABLE `edxl_de_keywords`
  ADD CONSTRAINT `edxl_de_keywords_ibfk_1` FOREIGN KEY (`de_id`) REFERENCES `edxl_de_header` (`de_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_de_prior_messages`
--
ALTER TABLE `edxl_de_prior_messages`
  ADD CONSTRAINT `edxl_de_prior_messages_ibfk_1` FOREIGN KEY (`de_id`) REFERENCES `edxl_de_header` (`de_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_de_roles`
--
ALTER TABLE `edxl_de_roles`
  ADD CONSTRAINT `edxl_de_roles_ibfk_1` FOREIGN KEY (`de_id`) REFERENCES `edxl_de_header` (`de_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_de_target_addresses`
--
ALTER TABLE `edxl_de_target_addresses`
  ADD CONSTRAINT `edxl_de_target_addresses_ibfk_1` FOREIGN KEY (`de_id`) REFERENCES `edxl_de_header` (`de_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_de_target_circles`
--
ALTER TABLE `edxl_de_target_circles`
  ADD CONSTRAINT `edxl_de_target_circles_ibfk_1` FOREIGN KEY (`de_id`) REFERENCES `edxl_de_header` (`de_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_de_target_codes`
--
ALTER TABLE `edxl_de_target_codes`
  ADD CONSTRAINT `edxl_de_target_codes_ibfk_1` FOREIGN KEY (`de_id`) REFERENCES `edxl_de_header` (`de_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `edxl_de_target_polygons`
--
ALTER TABLE `edxl_de_target_polygons`
  ADD CONSTRAINT `edxl_de_target_polygons_ibfk_1` FOREIGN KEY (`de_id`) REFERENCES `edxl_de_header` (`de_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feature`
--
ALTER TABLE `feature`
  ADD CONSTRAINT `fk_feature_layer1` FOREIGN KEY (`layer_layer_id`) REFERENCES `layer` (`layer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `image_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `image_tag`
--
ALTER TABLE `image_tag`
  ADD CONSTRAINT `image_tag_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `incident`
--
ALTER TABLE `incident`
  ADD CONSTRAINT `incident_ibfk_1` FOREIGN KEY (`private_group`) REFERENCES `sys_user_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `map_has_layer`
--
ALTER TABLE `map_has_layer`
  ADD CONSTRAINT `fk_map_has_layer_layer1` FOREIGN KEY (`layer_layer_id`) REFERENCES `layer` (`layer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `marker`
--
ALTER TABLE `marker`
  ADD CONSTRAINT `fk_marker_feature1` FOREIGN KEY (`feature_feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mpres_log`
--
ALTER TABLE `mpres_log`
  ADD CONSTRAINT `mpres_log_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `password_event_log`
--
ALTER TABLE `password_event_log`
  ADD CONSTRAINT `password_event_log_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_deceased`
--
ALTER TABLE `person_deceased`
  ADD CONSTRAINT `person_deceased_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_details`
--
ALTER TABLE `person_details`
  ADD CONSTRAINT `person_details_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_followers`
--
ALTER TABLE `person_followers`
  ADD CONSTRAINT `person_followers_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `person_followers_ibfk_2` FOREIGN KEY (`follower_p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_notes`
--
ALTER TABLE `person_notes`
  ADD CONSTRAINT `person_notes_ibfk_1` FOREIGN KEY (`note_about_p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `person_notes_ibfk_2` FOREIGN KEY (`note_written_by_p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_physical`
--
ALTER TABLE `person_physical`
  ADD CONSTRAINT `person_physical_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_status`
--
ALTER TABLE `person_status`
  ADD CONSTRAINT `person_status_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_to_report`
--
ALTER TABLE `person_to_report`
  ADD CONSTRAINT `person_to_report_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_updates`
--
ALTER TABLE `person_updates`
  ADD CONSTRAINT `person_updates_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `person_updates_ibfk_2` FOREIGN KEY (`updated_by_p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_uuid`
--
ALTER TABLE `person_uuid`
  ADD CONSTRAINT `person_uuid_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `person_uuid_ibfk_2` FOREIGN KEY (`hospital_uuid`) REFERENCES `hospital` (`hospital_uuid`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `pfif_export_log`
--
ALTER TABLE `pfif_export_log`
  ADD CONSTRAINT `pfif_export_log_ibfk_1` FOREIGN KEY (`repository_id`) REFERENCES `pfif_repository` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pfif_export_log_ibfk_2` FOREIGN KEY (`repository_id`) REFERENCES `pfif_repository` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pfif_harvest_note_log`
--
ALTER TABLE `pfif_harvest_note_log`
  ADD CONSTRAINT `pfif_harvest_note_log_ibfk_1` FOREIGN KEY (`repository_id`) REFERENCES `pfif_repository` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pfif_harvest_note_log_ibfk_2` FOREIGN KEY (`repository_id`) REFERENCES `pfif_repository` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pfif_harvest_person_log`
--
ALTER TABLE `pfif_harvest_person_log`
  ADD CONSTRAINT `pfif_harvest_person_log_ibfk_1` FOREIGN KEY (`repository_id`) REFERENCES `pfif_repository` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pfif_repository`
--
ALTER TABLE `pfif_repository`
  ADD CONSTRAINT `pfif_repository_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `plus_access_log`
--
ALTER TABLE `plus_access_log`
  ADD CONSTRAINT `plus_access_log_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `users` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `plus_report_log`
--
ALTER TABLE `plus_report_log`
  ADD CONSTRAINT `plus_report_log_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `point`
--
ALTER TABLE `point`
  ADD CONSTRAINT `fk_point_polyline1` FOREIGN KEY (`polyline_polyline_id`) REFERENCES `polyline` (`polyline_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `polyline`
--
ALTER TABLE `polyline`
  ADD CONSTRAINT `fk_polyline_feature1` FOREIGN KEY (`feature_feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `population`
--
ALTER TABLE `population`
  ADD CONSTRAINT `fk_population_disaster1` FOREIGN KEY (`disaster_id`) REFERENCES `disaster` (`disaster_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `fk_property_feature1` FOREIGN KEY (`feature_feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rap_log`
--
ALTER TABLE `rap_log`
  ADD CONSTRAINT `rap_log_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shelter`
--
ALTER TABLE `shelter`
  ADD CONSTRAINT `fk_shelter_disaster1` FOREIGN KEY (`disaster_id`) REFERENCES `disaster` (`disaster_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sys_user_to_group`
--
ALTER TABLE `sys_user_to_group`
  ADD CONSTRAINT `sys_user_to_group_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sys_user_to_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `sys_user_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_preference`
--
ALTER TABLE `user_preference`
  ADD CONSTRAINT `user_preference_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `voice_note`
--
ALTER TABLE `voice_note`
  ADD CONSTRAINT `voice_note_ibfk_1` FOREIGN KEY (`p_uuid`) REFERENCES `person_uuid` (`p_uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wash`
--
ALTER TABLE `wash`
  ADD CONSTRAINT `fk_wash_disaster1` FOREIGN KEY (`disaster_id`) REFERENCES `disaster` (`disaster_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_wash_water_resources1` FOREIGN KEY (`water_resources_id`) REFERENCES `water_resources` (`water_resources_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
