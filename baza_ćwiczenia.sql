CREATE DATABASE  IF NOT EXISTS `infio_liszewskid` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `infio_liszewskid`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: infio_liszewskid
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `pracownik`
--

DROP TABLE IF EXISTS `pracownik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pracownik` (
  `id_pracownika` int NOT NULL AUTO_INCREMENT,
  `imie` varchar(40) NOT NULL,
  `nazwisko` varchar(60) NOT NULL,
  `data_urodzenia` date NOT NULL,
  PRIMARY KEY (`id_pracownika`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pracownik`
--

LOCK TABLES `pracownik` WRITE;
/*!40000 ALTER TABLE `pracownik` DISABLE KEYS */;
INSERT INTO `pracownik` VALUES (1,'Dawid','Liszewski','2007-03-24'),(2,'Jan','Kowalski','1987-07-28'),(3,'Marek','Mostowiak','1980-09-09');
/*!40000 ALTER TABLE `pracownik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projekt`
--

DROP TABLE IF EXISTS `projekt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projekt` (
  `id_projektu` int NOT NULL AUTO_INCREMENT,
  `nazwa_projektu` varchar(150) NOT NULL,
  `data_rozpoczecia` date NOT NULL,
  `data_zakonczenia` date DEFAULT NULL,
  `menadzer_projektu` int DEFAULT NULL,
  PRIMARY KEY (`id_projektu`),
  KEY `pracownik` (`menadzer_projektu`),
  CONSTRAINT `pracownik` FOREIGN KEY (`menadzer_projektu`) REFERENCES `pracownik` (`id_pracownika`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projekt`
--

LOCK TABLES `projekt` WRITE;
/*!40000 ALTER TABLE `projekt` DISABLE KEYS */;
INSERT INTO `projekt` VALUES (1,'Projekt 1','2024-03-17',NULL,1),(2,'Projekt 2','2022-12-07',NULL,2),(3,'Projekt 3','2021-11-03','2026-06-19',3);
/*!40000 ALTER TABLE `projekt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id_statusu` int NOT NULL AUTO_INCREMENT,
  `nazwa_statusu` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_statusu`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'nie rozpoczęty'),(2,'w przygotowaniu'),(3,'ukończony');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zadanie`
--

DROP TABLE IF EXISTS `zadanie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zadanie` (
  `id_zadania` int NOT NULL AUTO_INCREMENT,
  `nazwa_zadania` varchar(150) DEFAULT NULL,
  `priorytet` enum('normalny','wysoki','niski') DEFAULT 'normalny',
  `opis` longtext,
  `pracownik` int DEFAULT NULL,
  `projekt` int DEFAULT NULL,
  `sprint` int DEFAULT NULL,
  PRIMARY KEY (`id_zadania`),
  KEY `pracownik` (`pracownik`),
  KEY `projekt` (`projekt`),
  KEY `sprint` (`sprint`),
  CONSTRAINT `projekt` FOREIGN KEY (`projekt`) REFERENCES `projekt` (`id_projektu`) ON DELETE CASCADE,
  CONSTRAINT `zadanie_ibfk_1` FOREIGN KEY (`pracownik`) REFERENCES `pracownik` (`id_pracownika`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zadanie`
--

LOCK TABLES `zadanie` WRITE;
/*!40000 ALTER TABLE `zadanie` DISABLE KEYS */;
INSERT INTO `zadanie` VALUES (1,'Zadanie 1','normalny','Test 1',1,NULL,1),(2,'Zadanie 2','normalny','Test 2',2,NULL,NULL),(3,'Zadanie 3','wysoki','Test 3',3,NULL,1);
/*!40000 ALTER TABLE `zadanie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zadanie_has_status`
--

DROP TABLE IF EXISTS `zadanie_has_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zadanie_has_status` (
  `id_zdarzenia` int NOT NULL AUTO_INCREMENT,
  `id_zadania` int DEFAULT NULL,
  `id_statusu` int DEFAULT NULL,
  `data_zdarzenia` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_zdarzenia`),
  KEY `id_zadania` (`id_zadania`),
  KEY `id_statusu` (`id_statusu`),
  CONSTRAINT `zadanie_has_status_ibfk_1` FOREIGN KEY (`id_zadania`) REFERENCES `zadanie` (`id_zadania`),
  CONSTRAINT `zadanie_has_status_ibfk_2` FOREIGN KEY (`id_statusu`) REFERENCES `status` (`id_statusu`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zadanie_has_status`
--

LOCK TABLES `zadanie_has_status` WRITE;
/*!40000 ALTER TABLE `zadanie_has_status` DISABLE KEYS */;
INSERT INTO `zadanie_has_status` VALUES (1,1,3,'2026-11-16 11:12:20'),(2,2,2,'2026-11-16 11:12:20'),(3,3,1,'2026-11-16 11:12:20');
/*!40000 ALTER TABLE `zadanie_has_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'infio_liszewskid'
--

--
-- Dumping routines for database 'infio_liszewskid'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-16 11:20:26
