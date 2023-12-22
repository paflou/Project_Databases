-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(25) DEFAULT 'unknown',
  `lastname` varchar(35) DEFAULT 'unknown',
  `reg_date` datetime DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('Alke1996','taeKe3NieSh','Milton','McSherry','2021-02-11 14:13:55','MiltonSMcSherry@dayrep.com'),('Alte1970','Beihoa3xoh','keir','Munro','2021-01-21 09:16:00','KeirMunro@rhyta.com'),('Ancingingen','zah0Keg2c','Terry','Dodd','2023-12-05 17:05:02','TerryLDodd@armyspy.com'),('Fortume','biJ8lue7lah','Thomas','Martin','2019-11-26 20:45:34','ThomasTMartin@armyspy.com'),('Hunitesige','Hephae7ai','Drew','Moore','2020-06-30 16:30:46','DrewMoore@rhyta.com'),('jacko','4321','Jack','Jones','2021-01-14 12:11:59','jackOlantern@gmail.com'),('johnnyboy','1234','John','Adams','2023-11-14 00:00:00','johnny420@gmail.com'),('Mucas1940','Di6nee','Amanda','Peters','2020-11-11 14:02:02','AmandaLPeters@armyspy.com'),('Pilve1984','naiCh6uph7','Martin','Gordon','2009-05-25 14:14:14','MadelineGordon@jourrapide.com'),('Tord2003','YeeK0mi4','George','Alexander','2022-03-15 15:04:29','GeorgeAlexander@armyspy.com'),('Yeepy','Eishi2Achae','Earl','Martin','2015-10-11 09:14:16','EarlRMartin@rhyta.com'),('Yestanters','Eishi2Achae','Earl','Martin','2015-10-11 09:14:16','EarlRMartin@rhyta.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-22 16:53:35
