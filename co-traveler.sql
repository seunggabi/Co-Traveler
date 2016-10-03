/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


CREATE DATABASE `co-traveler` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `co-traveler`;
CREATE TABLE `board` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `wtime` datetime DEFAULT NULL,
  `cnt` int(11) DEFAULT NULL,
  PRIMARY KEY (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `trip` (
  `t_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `start` varchar(255) DEFAULT NULL,
  `dest` varchar(255) DEFAULT NULL,
  `tripnum` int(11) DEFAULT NULL,
  `content` text,
  `wdate` datetime DEFAULT NULL,
  `sdate` datetime DEFAULT NULL,
  `edate` datetime DEFAULT NULL,
  `spos_x` varchar(255) DEFAULT NULL,
  `spos_y` varchar(255) DEFAULT NULL,
  `epos_x` varchar(255) DEFAULT NULL,
  `epos_y` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `trip_partner` (
  `tp_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_id` int(11) DEFAULT NULL,
  `u_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `join_type` varchar(10) DEFAULT NULL,
  `id` varchar(50) NOT NULL DEFAULT '',
  `pw` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `start` varchar(255) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `adm` char(1) DEFAULT NULL,
  PRIMARY KEY (`u_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
