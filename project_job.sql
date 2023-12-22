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
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_date` date DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `position` varchar(60) DEFAULT NULL,
  `edra` varchar(60) DEFAULT NULL,
  `evaluator` varchar(30) DEFAULT NULL,
  `announce_date` datetime DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `EVALUATORjob` (`evaluator`),
  CONSTRAINT `EVALUATORjob` FOREIGN KEY (`evaluator`) REFERENCES `evaluator` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (1,'2023-12-12',60000,'MECHANICAL ENGINEER','PATRAS','jacko','2015-12-13 08:15:34','2015-12-23'),(2,'2023-01-15',50000,'Software Engineer','New York','Ancingingen','2023-01-10 08:00:00','2023-02-28'),(3,'2023-02-20',60000,'Data Analyst','California','johnnyboy','2023-02-15 10:30:00','2023-04-15'),(4,'2023-03-10',70000,'Marketing Manager','Texas','jacko','2023-03-05 12:45:00','2023-05-30'),(5,'2023-04-05',55000,'Financial Advisor','Florida','Mucas1940','2023-03-30 09:15:00','2023-06-10'),(6,'2023-05-22',65000,'HR Specialist','Washington','Alke1996','2023-05-15 11:00:00','2023-07-20'),(7,'2023-06-30',75000,'Project Manager','Illinois','Yestanters','2023-06-25 14:20:00','2023-08-31'),(8,'2023-07-12',58000,'Sales Representative','Arizona','Ancingingen','2023-07-05 09:45:00','2023-09-25');
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-22 16:53:34
