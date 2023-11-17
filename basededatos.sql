-- MariaDB dump 10.19  Distrib 10.11.4-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: getinfo
-- ------------------------------------------------------
-- Server version	10.11.4-MariaDB-1~deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calificacion` (
  `idcalificacion` int(11) NOT NULL AUTO_INCREMENT,
  `punto` int(11) DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcalificacion`),
  KEY `fk_calificacion_1_idx` (`idusuario`),
  CONSTRAINT `fk_calificacion_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificacion`
--

LOCK TABLES `calificacion` WRITE;
/*!40000 ALTER TABLE `calificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `calificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dificultad`
--

DROP TABLE IF EXISTS `dificultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dificultad` (
  `iddificultad` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) DEFAULT NULL,
  `idsoportet` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddificultad`),
  KEY `fk_dificultad_1_idx` (`idsoportet`),
  CONSTRAINT `fk_dificultad_1` FOREIGN KEY (`idsoportet`) REFERENCES `soportet` (`idsoportet`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dificultad`
--

LOCK TABLES `dificultad` WRITE;
/*!40000 ALTER TABLE `dificultad` DISABLE KEYS */;
/*!40000 ALTER TABLE `dificultad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pregunta`
--

DROP TABLE IF EXISTS `pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pregunta` (
  `idpregunta` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `fecha` datetime(1) DEFAULT NULL,
  PRIMARY KEY (`idpregunta`),
  KEY `fk_pregunta_1_idx` (`idusuario`),
  CONSTRAINT `fk_pregunta_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta`
--

LOCK TABLES `pregunta` WRITE;
/*!40000 ALTER TABLE `pregunta` DISABLE KEYS */;
INSERT INTO `pregunta` VALUES
(33,'las rampas ya no funcionan',11,'2023-11-16 20:01:36.0'),
(34,'el router comenzo a calentarse mucho',11,'2023-11-16 20:41:07.0'),
(35,'el internet se esta empezando a corta varias veces',11,'2023-11-16 20:41:34.0'),
(36,'Hay que volver a conectar las computadores a una red LAN denuevo',11,'2023-11-16 20:42:29.0');
/*!40000 ALTER TABLE `pregunta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `respuesta`
--

DROP TABLE IF EXISTS `respuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `respuesta` (
  `idrespuesta` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) DEFAULT NULL,
  `idpregunta` int(11) DEFAULT NULL,
  `idsoportet` int(11) DEFAULT NULL,
  `idcalificacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`idrespuesta`),
  KEY `fk_respuesta_1_idx` (`idpregunta`),
  KEY `fk_respuesta_2_idx` (`idsoportet`),
  KEY `fk_respuesta_3_idx` (`idcalificacion`),
  CONSTRAINT `fk_respuesta_1` FOREIGN KEY (`idpregunta`) REFERENCES `pregunta` (`idpregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuesta_2` FOREIGN KEY (`idsoportet`) REFERENCES `soportet` (`idsoportet`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuesta_3` FOREIGN KEY (`idcalificacion`) REFERENCES `calificacion` (`idcalificacion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `respuesta`
--

LOCK TABLES `respuesta` WRITE;
/*!40000 ALTER TABLE `respuesta` DISABLE KEYS */;
/*!40000 ALTER TABLE `respuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soportet`
--

DROP TABLE IF EXISTS `soportet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `soportet` (
  `idsoportet` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` char(200) NOT NULL,
  `fullname` varchar(45) NOT NULL,
  `esadmi` tinyint(4) NOT NULL,
  PRIMARY KEY (`idsoportet`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soportet`
--

LOCK TABLES `soportet` WRITE;
/*!40000 ALTER TABLE `soportet` DISABLE KEYS */;
INSERT INTO `soportet` VALUES
(1,'martin','pbkdf2:sha256:600000$1G7ffShIMzp4Yy4n$d24565618cd655283149999eff1957623437c7dcddd52fd3664d2006f426f231','martin sosalo',1);
/*!40000 ALTER TABLE `soportet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` char(200) NOT NULL,
  `fullname` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES
(1,'OGARCIA','pbkdf2:sha256:600000$m0I23CytN6yrpWS6$9bf463592714e721f1ef13fdc53bf947cb9002a740c89d9681536c5d9890e409','Oscar garcia'),
(5,'marco','pbkdf2:sha256:600000$gxzxRqw6WTzjClBl$919adf5c42890eab7f2ad1ebbc768a7690ad17efb41ff53382cdbd24cae25774','marco dias'),
(6,'lucas','pbkdf2:sha256:600000$1nh36JgwemPlEstZ$082b7fc39a3635d4269930b2d4c73af98a7e6b2217d75239563e2779fc055f02','lucas nose'),
(7,'s','pbkdf2:sha256:600000$3EGXS8MasPEYgTYV$d0128d4ac841b0252167820daa760a532f901229cf717a9f043cfdc6519161df','s'),
(8,'ricardo','pbkdf2:sha256:600000$FPde7XQIegT7OxU8$0b7bed55fe4a1fb9eb4ff3f0f0c26c70a400d5d99c992ec952dd3989db67fb62','ricardo lopez'),
(10,'lorenzo','pbkdf2:sha256:600000$K5V3vllwWAxxdF7z$9d5a8fa936ee0e18e8faab6dfe5a278e4e27d4dc9feca81898b146bcafca432f','lorenzo dias'),
(11,'and','pbkdf2:sha256:600000$ZCIFhcs0iL4KI6tW$ce0fe88b5c021e230f87283f8599b2c526a8abc6629d5ff090fa589e5a1333f5','and g'),
(12,'dsds','pbkdf2:sha256:600000$aDUCfKxjFG6qpxrQ$d7b22984a39eba99eaf22eadea65f7f730be68d7eff059a46cfcc65bf597740a','dsdsd');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-16 22:02:55
