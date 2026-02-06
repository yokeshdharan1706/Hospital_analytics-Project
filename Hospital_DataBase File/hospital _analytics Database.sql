-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospital_analytics
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `dim_branch`
--

DROP TABLE IF EXISTS `dim_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_branch` (
  `branch_id` int NOT NULL,
  `branch_name` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `total_beds` int DEFAULT NULL,
  `icu_beds` int DEFAULT NULL,
  `ventailators` int DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_date`
--

DROP TABLE IF EXISTS `dim_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_date` (
  `date` date NOT NULL,
  `day` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `quarter` int DEFAULT NULL,
  `week` int DEFAULT NULL,
  `is_weekend` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_department`
--

DROP TABLE IF EXISTS `dim_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_department` (
  `department_id` int NOT NULL,
  `department_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_doctor`
--

DROP TABLE IF EXISTS `dim_doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_doctor` (
  `doctor_id` int NOT NULL,
  `doctor_name` varchar(100) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `employment_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`doctor_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `dim_doctor_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `dim_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_patient`
--

DROP TABLE IF EXISTS `dim_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_patient` (
  `patient_id` int NOT NULL,
  `age` int DEFAULT NULL,
  `age_group` varchar(10) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `insurance_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_admissions`
--

DROP TABLE IF EXISTS `fact_admissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_admissions` (
  `admission_id` int NOT NULL,
  `patient_id` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `admission_datetime` datetime DEFAULT NULL,
  `discharge_datetime` datetime DEFAULT NULL,
  `admission_type` varchar(20) DEFAULT NULL,
  `diagnosis_category` varchar(50) DEFAULT NULL,
  `outcome` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`admission_id`),
  KEY `idx_adm_date` (`admission_datetime`),
  KEY `idx_adm_branch` (`branch_id`),
  KEY `idx_adm_dept` (`department_id`),
  KEY `idx_adm_patient` (`patient_id`),
  KEY `idx_department_id` (`department_id`),
  KEY `idx_branch_id` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_bed_utilization`
--

DROP TABLE IF EXISTS `fact_bed_utilization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_bed_utilization` (
  `record_date` date NOT NULL,
  `branch_id` int NOT NULL,
  `department_id` int NOT NULL,
  `total_beds` int DEFAULT NULL,
  `occupied_beds` int DEFAULT NULL,
  `icu_beds` int DEFAULT NULL,
  `icu_occupied` int DEFAULT NULL,
  PRIMARY KEY (`record_date`,`branch_id`,`department_id`),
  KEY `branch_id` (`branch_id`),
  KEY `department_id` (`department_id`),
  KEY `idx_bed_date` (`record_date`),
  CONSTRAINT `fact_bed_utilization_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `dim_branch` (`branch_id`),
  CONSTRAINT `fact_bed_utilization_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `dim_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_billing`
--

DROP TABLE IF EXISTS `fact_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_billing` (
  `admission_id` int DEFAULT NULL,
  `total_cost` decimal(10,2) DEFAULT NULL,
  `room_charges` decimal(10,2) DEFAULT NULL,
  `procedure_charges` decimal(10,2) DEFAULT NULL,
  `medicine_charges` decimal(10,2) DEFAULT NULL,
  `insurance_covered` decimal(10,2) DEFAULT NULL,
  `patient_paid` decimal(10,2) DEFAULT NULL,
  KEY `fk_billing_admission` (`admission_id`),
  CONSTRAINT `fk_billing_admission` FOREIGN KEY (`admission_id`) REFERENCES `fact_admissions` (`admission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_procedures`
--

DROP TABLE IF EXISTS `fact_procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_procedures` (
  `procedure_id` int NOT NULL,
  `admission_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `procedure_type` varchar(50) DEFAULT NULL,
  `procedure_datetime` datetime DEFAULT NULL,
  `procedure_cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`procedure_id`),
  KEY `admission_id` (`admission_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `fact_procedures_ibfk_1` FOREIGN KEY (`admission_id`) REFERENCES `fact_admissions` (`admission_id`),
  CONSTRAINT `fact_procedures_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `dim_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vw_department_performance`
--

DROP TABLE IF EXISTS `vw_department_performance`;
/*!50001 DROP VIEW IF EXISTS `vw_department_performance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_department_performance` AS SELECT 
 1 AS `department_name`,
 1 AS `admissions`,
 1 AS `avg_los`,
 1 AS `department_revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_doctor_workload`
--

DROP TABLE IF EXISTS `vw_doctor_workload`;
/*!50001 DROP VIEW IF EXISTS `vw_doctor_workload`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_doctor_workload` AS SELECT 
 1 AS `doctor_name`,
 1 AS `department_name`,
 1 AS `patients_handled`,
 1 AS `avg_los`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_hospital_kpis`
--

DROP TABLE IF EXISTS `vw_hospital_kpis`;
/*!50001 DROP VIEW IF EXISTS `vw_hospital_kpis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_hospital_kpis` AS SELECT 
 1 AS `total_admissions`,
 1 AS `total_patients`,
 1 AS `avg_length_of_stay`,
 1 AS `total_revenue`,
 1 AS `avg_cost_per_admission`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_insurance_analysis`
--

DROP TABLE IF EXISTS `vw_insurance_analysis`;
/*!50001 DROP VIEW IF EXISTS `vw_insurance_analysis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_insurance_analysis` AS SELECT 
 1 AS `insurance_covered`,
 1 AS `total_cases`,
 1 AS `insurance_amount`,
 1 AS `out_of_pocket`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_monthly_trends`
--

DROP TABLE IF EXISTS `vw_monthly_trends`;
/*!50001 DROP VIEW IF EXISTS `vw_monthly_trends`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_monthly_trends` AS SELECT 
 1 AS `year`,
 1 AS `month`,
 1 AS `admissions`,
 1 AS `revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_procedure_analysis`
--

DROP TABLE IF EXISTS `vw_procedure_analysis`;
/*!50001 DROP VIEW IF EXISTS `vw_procedure_analysis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_procedure_analysis` AS SELECT 
 1 AS `procedure_type`,
 1 AS `total_procedures`,
 1 AS `avg_cost`,
 1 AS `total_cost`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_department_performance`
--

/*!50001 DROP VIEW IF EXISTS `vw_department_performance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_department_performance` AS select `d`.`department_name` AS `department_name`,count(`fa`.`admission_id`) AS `admissions`,avg((to_days(`fa`.`discharge_datetime`) - to_days(`fa`.`admission_datetime`))) AS `avg_los`,sum(`fb`.`total_cost`) AS `department_revenue` from ((`fact_admissions` `fa` join `dim_department` `d` on((`fa`.`department_id` = `d`.`department_id`))) join `fact_billing` `fb` on((`fa`.`admission_id` = `fb`.`admission_id`))) group by `d`.`department_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_doctor_workload`
--

/*!50001 DROP VIEW IF EXISTS `vw_doctor_workload`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_doctor_workload` AS select `doc`.`doctor_name` AS `doctor_name`,`d`.`department_name` AS `department_name`,count(`fa`.`admission_id`) AS `patients_handled`,avg((to_days(`fa`.`discharge_datetime`) - to_days(`fa`.`admission_datetime`))) AS `avg_los` from ((`fact_admissions` `fa` join `dim_doctor` `doc` on((`fa`.`doctor_id` = `doc`.`doctor_id`))) join `dim_department` `d` on((`fa`.`department_id` = `d`.`department_id`))) group by `doc`.`doctor_name`,`d`.`department_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_hospital_kpis`
--

/*!50001 DROP VIEW IF EXISTS `vw_hospital_kpis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_hospital_kpis` AS select count(distinct `fa`.`admission_id`) AS `total_admissions`,count(distinct `fa`.`patient_id`) AS `total_patients`,avg((to_days(`fa`.`discharge_datetime`) - to_days(`fa`.`admission_datetime`))) AS `avg_length_of_stay`,sum(`fb`.`total_cost`) AS `total_revenue`,avg(`fb`.`total_cost`) AS `avg_cost_per_admission` from (`fact_admissions` `fa` join `fact_billing` `fb` on((`fa`.`admission_id` = `fb`.`admission_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_insurance_analysis`
--

/*!50001 DROP VIEW IF EXISTS `vw_insurance_analysis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_insurance_analysis` AS select `fb`.`insurance_covered` AS `insurance_covered`,count(`fa`.`admission_id`) AS `total_cases`,sum(`fb`.`insurance_covered`) AS `insurance_amount`,sum(`fb`.`patient_paid`) AS `out_of_pocket` from (`fact_billing` `fb` join `fact_admissions` `fa` on((`fb`.`admission_id` = `fa`.`admission_id`))) group by `fb`.`insurance_covered` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_monthly_trends`
--

/*!50001 DROP VIEW IF EXISTS `vw_monthly_trends`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_monthly_trends` AS select year(`fa`.`admission_datetime`) AS `year`,month(`fa`.`admission_datetime`) AS `month`,count(`fa`.`admission_id`) AS `admissions`,sum(`fb`.`total_cost`) AS `revenue` from (`fact_admissions` `fa` join `fact_billing` `fb` on((`fa`.`admission_id` = `fb`.`admission_id`))) group by year(`fa`.`admission_datetime`),month(`fa`.`admission_datetime`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_procedure_analysis`
--

/*!50001 DROP VIEW IF EXISTS `vw_procedure_analysis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_procedure_analysis` AS select `fact_procedures`.`procedure_type` AS `procedure_type`,count(0) AS `total_procedures`,avg(`fact_procedures`.`procedure_cost`) AS `avg_cost`,sum(`fact_procedures`.`procedure_cost`) AS `total_cost` from `fact_procedures` group by `fact_procedures`.`procedure_type` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-06 13:18:02
