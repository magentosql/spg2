-- MySQL dump 10.13  Distrib 5.7.13, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: spg2ee_db
-- ------------------------------------------------------
-- Server version	5.7.17-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `spg_admin_passwords`
--

DROP TABLE IF EXISTS `spg_admin_passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_admin_passwords` (
  `password_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Password Id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User Id',
  `password_hash` varchar(100) DEFAULT NULL COMMENT 'Password Hash',
  `expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Expires',
  `last_updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Last Updated',
  PRIMARY KEY (`password_id`),
  KEY `SPG_ADMIN_PASSWORDS_USER_ID` (`user_id`),
  CONSTRAINT `SPG_ADMIN_PASSWORDS_USER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `spg_admin_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Passwords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_admin_passwords`
--

LOCK TABLES `spg_admin_passwords` WRITE;
/*!40000 ALTER TABLE `spg_admin_passwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_admin_passwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_admin_system_messages`
--

DROP TABLE IF EXISTS `spg_admin_system_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_admin_system_messages` (
  `identity` varchar(100) NOT NULL COMMENT 'Message id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create date',
  PRIMARY KEY (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin System Messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_admin_system_messages`
--

LOCK TABLES `spg_admin_system_messages` WRITE;
/*!40000 ALTER TABLE `spg_admin_system_messages` DISABLE KEYS */;
INSERT INTO `spg_admin_system_messages` VALUES ('da332d712f3215b9b94bfa268c398323',2,'2017-02-03 08:01:18');
/*!40000 ALTER TABLE `spg_admin_system_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_admin_user`
--

DROP TABLE IF EXISTS `spg_admin_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_admin_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'User First Name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'User Last Name',
  `email` varchar(128) DEFAULT NULL COMMENT 'User Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'User Login',
  `password` varchar(255) NOT NULL COMMENT 'User Password',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'User Created Time',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'User Modified Time',
  `logdate` timestamp NULL DEFAULT NULL COMMENT 'User Last Login Time',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'User Login Number',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Reload ACL',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'User Is Active',
  `extra` text COMMENT 'User Extra Data',
  `rp_token` text COMMENT 'Reset Password Link Token',
  `rp_token_created_at` timestamp NULL DEFAULT NULL COMMENT 'Reset Password Link Token Creation Date',
  `interface_locale` varchar(16) NOT NULL DEFAULT 'en_US' COMMENT 'Backend interface locale',
  `failures_num` smallint(6) DEFAULT '0' COMMENT 'Failure Number',
  `first_failure` timestamp NULL DEFAULT NULL COMMENT 'First Failure',
  `lock_expires` timestamp NULL DEFAULT NULL COMMENT 'Expiration Lock Dates',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `SPG_ADMIN_USER_USERNAME` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Admin User Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_admin_user`
--

LOCK TABLES `spg_admin_user` WRITE;
/*!40000 ALTER TABLE `spg_admin_user` DISABLE KEYS */;
INSERT INTO `spg_admin_user` VALUES (1,'admin','admin','lebaotriet@gmail.com','admin','66636251d48ea313bdbc558e7429b7fda9ff1582bb459d40f678c29a6437e01a:ByGCRfVtqaPBSrJQ8Xs5xgEMxNojZmEF:1','2017-02-03 07:50:37','2017-02-03 10:34:14','2017-02-03 09:09:54',2,0,1,'a:1:{s:11:\"configState\";a:34:{s:34:\"dev_front_end_development_workflow\";s:1:\"1\";s:12:\"dev_restrict\";s:1:\"0\";s:9:\"dev_debug\";s:1:\"0\";s:12:\"dev_template\";s:1:\"0\";s:20:\"dev_translate_inline\";s:1:\"0\";s:6:\"dev_js\";s:1:\"0\";s:7:\"dev_css\";s:1:\"0\";s:9:\"dev_image\";s:1:\"0\";s:10:\"dev_static\";s:1:\"0\";s:8:\"dev_grid\";s:1:\"0\";s:10:\"web_secure\";s:1:\"0\";s:11:\"web_default\";s:1:\"1\";s:12:\"web_unsecure\";s:1:\"1\";s:24:\"web_browser_capabilities\";s:1:\"1\";s:11:\"web_session\";s:1:\"1\";s:10:\"web_cookie\";s:1:\"1\";s:13:\"cms_hierarchy\";s:1:\"1\";s:11:\"cms_wysiwyg\";s:1:\"1\";s:22:\"system_full_page_cache\";s:1:\"1\";s:34:\"system_media_storage_configuration\";s:1:\"1\";s:42:\"system_magento_scheduled_import_export_log\";s:1:\"1\";s:14:\"system_mysqlmq\";s:1:\"1\";s:11:\"system_cron\";s:1:\"1\";s:11:\"system_smtp\";s:1:\"1\";s:13:\"system_backup\";s:1:\"1\";s:15:\"system_rotation\";s:1:\"1\";s:24:\"system_adminnotification\";s:1:\"1\";s:15:\"system_currency\";s:1:\"1\";s:7:\"web_seo\";s:1:\"0\";s:7:\"web_url\";s:1:\"0\";s:25:\"general_store_information\";s:1:\"1\";s:25:\"general_single_store_mode\";s:1:\"1\";s:14:\"general_region\";s:1:\"1\";s:15:\"general_country\";s:1:\"1\";}}',NULL,NULL,'en_US',0,NULL,NULL);
/*!40000 ALTER TABLE `spg_admin_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_admin_user_session`
--

DROP TABLE IF EXISTS `spg_admin_user_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_admin_user_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `session_id` varchar(128) NOT NULL COMMENT 'Session id value',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin User ID',
  `status` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Current Session status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created Time',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  `ip` varchar(15) NOT NULL COMMENT 'Remote user IP',
  PRIMARY KEY (`id`),
  KEY `SPG_ADMIN_USER_SESSION_SESSION_ID` (`session_id`),
  KEY `SPG_ADMIN_USER_SESSION_USER_ID` (`user_id`),
  CONSTRAINT `SPG_ADMIN_USER_SESSION_USER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `spg_admin_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Admin User sessions table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_admin_user_session`
--

LOCK TABLES `spg_admin_user_session` WRITE;
/*!40000 ALTER TABLE `spg_admin_user_session` DISABLE KEYS */;
INSERT INTO `spg_admin_user_session` VALUES (1,'lr1i6dfiaiqdqoigpnh0o2hdm2',1,1,'2017-02-03 08:01:13','2017-02-03 08:02:06','127.0.0.1'),(2,'cq88uh8diepsdmv6siku7k6bh7',1,1,'2017-02-03 09:09:54','2017-02-03 10:36:02','127.0.0.1');
/*!40000 ALTER TABLE `spg_admin_user_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_adminnotification_inbox`
--

DROP TABLE IF EXISTS `spg_adminnotification_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_adminnotification_inbox` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Notification id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create date',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `description` text COMMENT 'Description',
  `url` varchar(255) DEFAULT NULL COMMENT 'Url',
  `is_read` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification read',
  `is_remove` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification might be removed',
  PRIMARY KEY (`notification_id`),
  KEY `SPG_ADMINNOTIFICATION_INBOX_SEVERITY` (`severity`),
  KEY `SPG_ADMINNOTIFICATION_INBOX_IS_READ` (`is_read`),
  KEY `SPG_ADMINNOTIFICATION_INBOX_IS_REMOVE` (`is_remove`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Adminnotification Inbox';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_adminnotification_inbox`
--

LOCK TABLES `spg_adminnotification_inbox` WRITE;
/*!40000 ALTER TABLE `spg_adminnotification_inbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_adminnotification_inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_authorization_role`
--

DROP TABLE IF EXISTS `spg_authorization_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_authorization_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Role ID',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Tree Level',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Sort Order',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role Type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `user_type` varchar(16) DEFAULT NULL COMMENT 'User Type',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role Name',
  `gws_is_all` int(11) NOT NULL DEFAULT '1' COMMENT 'Yes/No Flag',
  `gws_websites` varchar(255) DEFAULT NULL COMMENT 'Comma-separated Website Ids',
  `gws_store_groups` varchar(255) DEFAULT NULL COMMENT 'Comma-separated Store Groups Ids',
  PRIMARY KEY (`role_id`),
  KEY `SPG_AUTHORIZATION_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `SPG_AUTHORIZATION_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Admin Role Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_authorization_role`
--

LOCK TABLES `spg_authorization_role` WRITE;
/*!40000 ALTER TABLE `spg_authorization_role` DISABLE KEYS */;
INSERT INTO `spg_authorization_role` VALUES (1,0,1,1,'G',0,'2','Administrators',1,NULL,NULL),(2,1,2,0,'U',1,'2','admin',1,NULL,NULL);
/*!40000 ALTER TABLE `spg_authorization_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_authorization_rule`
--

DROP TABLE IF EXISTS `spg_authorization_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_authorization_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule ID',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Role ID',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Resource ID',
  `privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `SPG_AUTHORIZATION_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `SPG_AUTHORIZATION_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `SPG_AUTHORIZATION_RULE_ROLE_ID_AUTHORIZATION_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `spg_authorization_role` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Admin Rule Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_authorization_rule`
--

LOCK TABLES `spg_authorization_rule` WRITE;
/*!40000 ALTER TABLE `spg_authorization_rule` DISABLE KEYS */;
INSERT INTO `spg_authorization_rule` VALUES (1,1,'Magento_Backend::all',NULL,'allow');
/*!40000 ALTER TABLE `spg_authorization_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cache`
--

DROP TABLE IF EXISTS `spg_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cache` (
  `id` varchar(200) NOT NULL COMMENT 'Cache Id',
  `data` mediumblob COMMENT 'Cache Data',
  `create_time` int(11) DEFAULT NULL COMMENT 'Cache Creation Time',
  `update_time` int(11) DEFAULT NULL COMMENT 'Time of Cache Updating',
  `expire_time` int(11) DEFAULT NULL COMMENT 'Cache Expiration Time',
  PRIMARY KEY (`id`),
  KEY `SPG_CACHE_EXPIRE_TIME` (`expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cache`
--

LOCK TABLES `spg_cache` WRITE;
/*!40000 ALTER TABLE `spg_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cache_tag`
--

DROP TABLE IF EXISTS `spg_cache_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cache_tag` (
  `tag` varchar(100) NOT NULL COMMENT 'Tag',
  `cache_id` varchar(200) NOT NULL COMMENT 'Cache Id',
  PRIMARY KEY (`tag`,`cache_id`),
  KEY `SPG_CACHE_TAG_CACHE_ID` (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Caches';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cache_tag`
--

LOCK TABLES `spg_cache_tag` WRITE;
/*!40000 ALTER TABLE `spg_cache_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_cache_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_captcha_log`
--

DROP TABLE IF EXISTS `spg_captcha_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_captcha_log` (
  `type` varchar(32) NOT NULL COMMENT 'Type',
  `value` varchar(32) NOT NULL COMMENT 'Value',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Count',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Count Login Attempts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_captcha_log`
--

LOCK TABLES `spg_captcha_log` WRITE;
/*!40000 ALTER TABLE `spg_captcha_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_captcha_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_category_entity`
--

DROP TABLE IF EXISTS `spg_catalog_category_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_category_entity` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Version Id',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `created_in` bigint(20) unsigned NOT NULL COMMENT 'Update Id',
  `updated_in` bigint(20) unsigned NOT NULL COMMENT 'Next Update Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attriute Set ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Category ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  `path` varchar(255) NOT NULL COMMENT 'Tree Path',
  `position` int(11) NOT NULL COMMENT 'Position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'Tree Level',
  `children_count` int(11) NOT NULL COMMENT 'Child Count',
  PRIMARY KEY (`row_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_LEVEL` (`level`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_CREATED_IN` (`created_in`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_UPDATED_IN` (`updated_in`),
  KEY `SPG_CAT_CTGR_ENTT_ENTT_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL` (`entity_id`),
  CONSTRAINT `SPG_CAT_CTGR_ENTT_ENTT_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL` FOREIGN KEY (`entity_id`) REFERENCES `spg_sequence_catalog_category` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_category_entity`
--

LOCK TABLES `spg_catalog_category_entity` WRITE;
/*!40000 ALTER TABLE `spg_catalog_category_entity` DISABLE KEYS */;
INSERT INTO `spg_catalog_category_entity` VALUES (1,1,1,2147483647,3,0,'2017-02-03 07:47:52','2017-02-03 10:02:41','1',0,0,36),(2,2,1,2147483647,3,1,'2017-02-03 07:47:52','2017-02-03 10:02:41','1/2',1,1,35),(3,3,1,2147483647,3,2,'2017-02-03 09:18:07','2017-02-03 09:28:16','1/2/3',1,2,5),(5,5,1,2147483647,3,2,'2017-02-03 09:19:11','2017-02-03 10:02:35','1/2/5',4,2,3),(6,6,1,2147483647,3,2,'2017-02-03 09:20:26','2017-02-03 10:02:27','1/2/6',2,2,9),(7,7,1,2147483647,3,2,'2017-02-03 09:21:02','2017-02-03 10:02:41','1/2/7',6,2,4),(8,8,1,2147483647,3,2,'2017-02-03 09:21:26','2017-02-03 10:02:35','1/2/8',3,2,2),(9,9,1,2147483647,3,2,'2017-02-03 09:22:12','2017-02-03 10:02:41','1/2/9',5,2,5),(10,10,1,2147483647,3,3,'2017-02-03 09:22:49','2017-02-03 09:22:49','1/2/3/10',1,3,0),(11,11,1,2147483647,3,3,'2017-02-03 09:27:15','2017-02-03 09:27:15','1/2/3/11',2,3,0),(12,12,1,2147483647,3,3,'2017-02-03 09:27:39','2017-02-03 09:27:39','1/2/3/12',3,3,0),(13,13,1,2147483647,3,3,'2017-02-03 09:27:57','2017-02-03 09:27:57','1/2/3/13',4,3,0),(14,14,1,2147483647,3,3,'2017-02-03 09:28:16','2017-02-03 09:28:16','1/2/3/14',5,3,0),(15,15,1,2147483647,3,5,'2017-02-03 09:28:42','2017-02-03 09:28:42','1/2/5/15',1,3,0),(16,16,1,2147483647,3,5,'2017-02-03 09:29:00','2017-02-03 09:29:00','1/2/5/16',2,3,0),(17,17,1,2147483647,3,5,'2017-02-03 09:29:15','2017-02-03 09:29:15','1/2/5/17',3,3,0),(18,18,1,2147483647,3,6,'2017-02-03 09:29:46','2017-02-03 09:30:32','1/2/6/18',1,3,3),(19,19,1,2147483647,3,18,'2017-02-03 09:29:57','2017-02-03 09:29:57','1/2/6/18/19',1,4,0),(20,20,1,2147483647,3,18,'2017-02-03 09:30:08','2017-02-03 09:30:08','1/2/6/18/20',2,4,0),(21,21,1,2147483647,3,18,'2017-02-03 09:30:32','2017-02-03 09:30:32','1/2/6/18/21',3,4,0),(22,22,1,2147483647,3,6,'2017-02-03 09:31:02','2017-02-03 09:31:02','1/2/6/22',2,3,0),(23,23,1,2147483647,3,6,'2017-02-03 09:31:17','2017-02-03 09:31:17','1/2/6/23',3,3,0),(24,24,1,2147483647,3,6,'2017-02-03 09:31:30','2017-02-03 09:31:30','1/2/6/24',4,3,0),(25,25,1,2147483647,3,6,'2017-02-03 09:31:45','2017-02-03 09:31:45','1/2/6/25',5,3,0),(26,26,1,2147483647,3,6,'2017-02-03 09:31:58','2017-02-03 09:31:58','1/2/6/26',6,3,0),(27,27,1,2147483647,3,7,'2017-02-03 09:32:13','2017-02-03 09:32:13','1/2/7/27',1,3,0),(28,28,1,2147483647,3,7,'2017-02-03 09:32:30','2017-02-03 09:32:30','1/2/7/28',2,3,0),(29,29,1,2147483647,3,7,'2017-02-03 09:32:45','2017-02-03 09:32:45','1/2/7/29',3,3,0),(30,30,1,2147483647,3,7,'2017-02-03 09:33:01','2017-02-03 09:33:01','1/2/7/30',4,3,0),(31,31,1,2147483647,3,8,'2017-02-03 09:33:17','2017-02-03 09:33:17','1/2/8/31',1,3,0),(32,32,1,2147483647,3,8,'2017-02-03 09:33:57','2017-02-03 09:33:57','1/2/8/32',2,3,0),(33,33,1,2147483647,3,2,'2017-02-03 09:34:36','2017-02-03 10:02:41','1/2/33',7,2,0),(34,34,1,2147483647,3,9,'2017-02-03 09:35:05','2017-02-03 09:35:05','1/2/9/34',1,3,0),(35,35,1,2147483647,3,9,'2017-02-03 09:35:18','2017-02-03 09:35:18','1/2/9/35',2,3,0),(36,36,1,2147483647,3,9,'2017-02-03 09:35:32','2017-02-03 09:35:32','1/2/9/36',3,3,0),(37,37,1,2147483647,3,9,'2017-02-03 09:35:53','2017-02-03 09:35:53','1/2/9/37',4,3,0),(38,38,1,2147483647,3,9,'2017-02-03 09:36:06','2017-02-03 09:36:06','1/2/9/38',5,3,0);
/*!40000 ALTER TABLE `spg_catalog_category_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_category_entity_datetime`
--

DROP TABLE IF EXISTS `spg_catalog_category_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_category_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_CTGR_ENTT_DTIME_ENTT_ID_ATTR_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID` (`row_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_DTIME_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_category_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Datetime Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_category_entity_datetime`
--

LOCK TABLES `spg_catalog_category_entity_datetime` WRITE;
/*!40000 ALTER TABLE `spg_catalog_category_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_category_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_category_entity_decimal`
--

DROP TABLE IF EXISTS `spg_catalog_category_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_category_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_CTGR_ENTT_DEC_ENTT_ID_ATTR_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID` (`row_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_DEC_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_category_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Decimal Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_category_entity_decimal`
--

LOCK TABLES `spg_catalog_category_entity_decimal` WRITE;
/*!40000 ALTER TABLE `spg_catalog_category_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_category_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_category_entity_int`
--

DROP TABLE IF EXISTS `spg_catalog_category_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_category_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID` (`row_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_INT_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_CATEGORY_ENTITY_INT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_INT_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_category_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Integer Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_category_entity_int`
--

LOCK TABLES `spg_catalog_category_entity_int` WRITE;
/*!40000 ALTER TABLE `spg_catalog_category_entity_int` DISABLE KEYS */;
INSERT INTO `spg_catalog_category_entity_int` VALUES (1,69,0,1,1),(2,46,0,2,1),(3,69,0,2,1),(4,46,0,3,1),(5,54,0,3,1),(6,69,0,3,1),(7,70,0,3,0),(8,71,0,3,0),(14,46,0,5,1),(15,54,0,5,1),(16,69,0,5,1),(17,70,0,5,0),(18,71,0,5,0),(19,54,0,2,1),(20,70,0,2,0),(21,71,0,2,0),(22,46,0,6,1),(23,54,0,6,1),(24,69,0,6,1),(25,70,0,6,0),(26,71,0,6,0),(27,46,0,7,1),(28,54,0,7,1),(29,69,0,7,1),(30,70,0,7,0),(31,71,0,7,0),(32,46,0,8,1),(33,54,0,8,1),(34,69,0,8,1),(35,70,0,8,0),(36,71,0,8,0),(37,46,0,9,1),(38,54,0,9,1),(39,69,0,9,1),(40,70,0,9,0),(41,71,0,9,0),(42,46,0,10,1),(43,54,0,10,1),(44,69,0,10,1),(45,70,0,10,0),(46,71,0,10,0),(47,46,0,11,1),(48,54,0,11,1),(49,69,0,11,1),(50,70,0,11,0),(51,71,0,11,0),(52,46,0,12,1),(53,54,0,12,1),(54,69,0,12,1),(55,70,0,12,0),(56,71,0,12,0),(57,46,0,13,1),(58,54,0,13,1),(59,69,0,13,1),(60,70,0,13,0),(61,71,0,13,0),(62,46,0,14,1),(63,54,0,14,1),(64,69,0,14,1),(65,70,0,14,0),(66,71,0,14,0),(67,46,0,15,1),(68,54,0,15,1),(69,69,0,15,1),(70,70,0,15,0),(71,71,0,15,0),(72,46,0,16,1),(73,54,0,16,1),(74,69,0,16,1),(75,70,0,16,0),(76,71,0,16,0),(77,46,0,17,1),(78,54,0,17,1),(79,69,0,17,1),(80,70,0,17,0),(81,71,0,17,0),(82,46,0,18,1),(83,54,0,18,1),(84,69,0,18,1),(85,70,0,18,0),(86,71,0,18,0),(87,46,0,19,1),(88,54,0,19,1),(89,69,0,19,1),(90,70,0,19,0),(91,71,0,19,0),(92,46,0,20,1),(93,54,0,20,1),(94,69,0,20,1),(95,70,0,20,0),(96,71,0,20,0),(97,46,0,21,1),(98,54,0,21,1),(99,69,0,21,1),(100,70,0,21,0),(101,71,0,21,0),(102,46,0,22,1),(103,54,0,22,1),(104,69,0,22,1),(105,70,0,22,0),(106,71,0,22,0),(107,46,0,23,1),(108,54,0,23,1),(109,69,0,23,1),(110,70,0,23,0),(111,71,0,23,0),(112,46,0,24,1),(113,54,0,24,1),(114,69,0,24,1),(115,70,0,24,0),(116,71,0,24,0),(117,46,0,25,1),(118,54,0,25,1),(119,69,0,25,1),(120,70,0,25,0),(121,71,0,25,0),(122,46,0,26,1),(123,54,0,26,1),(124,69,0,26,1),(125,70,0,26,0),(126,71,0,26,0),(127,46,0,27,1),(128,54,0,27,1),(129,69,0,27,1),(130,70,0,27,0),(131,71,0,27,0),(132,46,0,28,1),(133,54,0,28,1),(134,69,0,28,1),(135,70,0,28,0),(136,71,0,28,0),(137,46,0,29,1),(138,54,0,29,1),(139,69,0,29,1),(140,70,0,29,0),(141,71,0,29,0),(142,46,0,30,1),(143,54,0,30,1),(144,69,0,30,1),(145,70,0,30,0),(146,71,0,30,0),(147,46,0,31,1),(148,54,0,31,1),(149,69,0,31,1),(150,70,0,31,0),(151,71,0,31,0),(152,46,0,32,1),(153,54,0,32,1),(154,69,0,32,1),(155,70,0,32,0),(156,71,0,32,0),(157,46,0,33,1),(158,54,0,33,1),(159,69,0,33,1),(160,70,0,33,0),(161,71,0,33,0),(162,46,0,34,1),(163,54,0,34,1),(164,69,0,34,1),(165,70,0,34,0),(166,71,0,34,0),(167,46,0,35,1),(168,54,0,35,1),(169,69,0,35,1),(170,70,0,35,0),(171,71,0,35,0),(172,46,0,36,1),(173,54,0,36,1),(174,69,0,36,1),(175,70,0,36,0),(176,71,0,36,0),(177,46,0,37,1),(178,54,0,37,1),(179,69,0,37,1),(180,70,0,37,0),(181,71,0,37,0),(182,46,0,38,1),(183,54,0,38,1),(184,69,0,38,1),(185,70,0,38,0),(186,71,0,38,0);
/*!40000 ALTER TABLE `spg_catalog_category_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_category_entity_text`
--

DROP TABLE IF EXISTS `spg_catalog_category_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_category_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID` (`row_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_TEXT_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_category_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Text Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_category_entity_text`
--

LOCK TABLES `spg_catalog_category_entity_text` WRITE;
/*!40000 ALTER TABLE `spg_catalog_category_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_category_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_category_entity_varchar`
--

DROP TABLE IF EXISTS `spg_catalog_category_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_category_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_CTGR_ENTT_VCHR_ENTT_ID_ATTR_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID` (`row_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_ENTT_VCHR_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_category_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Varchar Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_category_entity_varchar`
--

LOCK TABLES `spg_catalog_category_entity_varchar` WRITE;
/*!40000 ALTER TABLE `spg_catalog_category_entity_varchar` DISABLE KEYS */;
INSERT INTO `spg_catalog_category_entity_varchar` VALUES (1,45,0,1,'Root Catalog'),(2,45,0,2,'Shopforgirl Primary Category'),(3,52,0,2,'PRODUCTS'),(4,45,0,3,'Áo'),(5,52,0,3,'PRODUCTS'),(6,122,0,3,'ao'),(7,123,0,3,'ao'),(12,45,0,5,'Giày'),(13,52,0,5,'PRODUCTS'),(14,122,0,5,'giay'),(15,123,0,5,'giay'),(16,122,0,2,'shopforgirl-primary-category'),(17,45,0,6,'Quần'),(18,52,0,6,'PRODUCTS'),(19,122,0,6,'qu-n'),(20,123,0,6,'qu-n'),(21,45,0,7,'Set'),(22,52,0,7,'PRODUCTS'),(23,122,0,7,'set'),(24,123,0,7,'set'),(25,45,0,8,'Đầm'),(26,52,0,8,'PRODUCTS'),(27,122,0,8,'d-m'),(28,123,0,8,'d-m'),(29,45,0,9,'Chân váy'),(30,52,0,9,'PRODUCTS'),(31,122,0,9,'chan-vay'),(32,123,0,9,'chan-vay'),(33,45,0,10,'Áo Croptop'),(34,52,0,10,'PRODUCTS'),(35,122,0,10,'ao-croptop'),(36,123,0,10,'ao/ao-croptop'),(37,45,0,11,'Áo khoác'),(38,52,0,11,'PRODUCTS'),(39,122,0,11,'ao-khoac'),(40,123,0,11,'ao/ao-khoac'),(41,45,0,12,'Áo sơ mi'),(42,52,0,12,'PRODUCTS'),(43,122,0,12,'ao-so-mi'),(44,123,0,12,'ao/ao-so-mi'),(45,45,0,13,'Áo thiết kế'),(46,52,0,13,'PRODUCTS'),(47,122,0,13,'ao-thi-t-k'),(48,123,0,13,'ao/ao-thi-t-k'),(49,45,0,14,'Áo thun'),(50,52,0,14,'PRODUCTS'),(51,122,0,14,'ao-thun'),(52,123,0,14,'ao/ao-thun'),(53,45,0,15,'Dép'),(54,52,0,15,'PRODUCTS'),(55,122,0,15,'dep'),(56,123,0,15,'giay/dep'),(57,45,0,16,'Giày búp bê Zara VNXK'),(58,52,0,16,'PRODUCTS'),(59,122,0,16,'giay-bup-be-zara-vnxk'),(60,123,0,16,'giay/giay-bup-be-zara-vnxk'),(61,45,0,17,'Sandal'),(62,52,0,17,'PRODUCTS'),(63,122,0,17,'sandal'),(64,123,0,17,'giay/sandal'),(65,45,0,18,'Quần baggy'),(66,52,0,18,'PRODUCTS'),(67,122,0,18,'qu-n-baggy'),(68,123,0,18,'qu-n/qu-n-baggy'),(69,45,0,19,'Baggy jeans trơn'),(70,52,0,19,'PRODUCTS'),(71,122,0,19,'baggy-jeans-tron'),(72,123,0,19,'qu-n/qu-n-baggy/baggy-jeans-tron'),(73,45,0,20,'Baggy rách jeans'),(74,52,0,20,'PRODUCTS'),(75,122,0,20,'baggy-rach-jeans'),(76,123,0,20,'qu-n/qu-n-baggy/baggy-rach-jeans'),(77,45,0,21,'Baggy vải'),(78,52,0,21,'PRODUCTS'),(79,122,0,21,'baggy-v-i'),(80,123,0,21,'qu-n/qu-n-baggy/baggy-v-i'),(81,45,0,22,'Quần jeans rách gối'),(82,52,0,22,'PRODUCTS'),(83,122,0,22,'qu-n-jeans-rach-g-i'),(84,123,0,22,'qu-n/qu-n-jeans-rach-g-i'),(85,45,0,23,'Quần kiểu'),(86,52,0,23,'PRODUCTS'),(87,122,0,23,'qu-n-ki-u'),(88,123,0,23,'qu-n/qu-n-ki-u'),(89,45,0,24,'Quần legging'),(90,52,0,24,'PRODUCTS'),(91,122,0,24,'qu-n-legging'),(92,123,0,24,'qu-n/qu-n-legging'),(93,45,0,25,'Quần váy'),(94,52,0,25,'PRODUCTS'),(95,122,0,25,'qu-n-vay'),(96,123,0,25,'qu-n/qu-n-vay'),(97,45,0,26,'Short jeans'),(98,52,0,26,'PRODUCTS'),(99,122,0,26,'short-jeans'),(100,123,0,26,'qu-n/short-jeans'),(101,45,0,27,'Áo + quần'),(102,52,0,27,'PRODUCTS'),(103,122,0,27,'ao-qu-n'),(104,123,0,27,'set/ao-qu-n'),(105,45,0,28,'Áo + quần váy'),(106,52,0,28,'PRODUCTS'),(107,122,0,28,'ao-qu-n-vay'),(108,123,0,28,'set/ao-qu-n-vay'),(109,45,0,29,'Áo + váy'),(110,52,0,29,'PRODUCTS'),(111,122,0,29,'ao-vay'),(112,123,0,29,'set/ao-vay'),(113,45,0,30,'Jump'),(114,52,0,30,'PRODUCTS'),(115,122,0,30,'jump'),(116,123,0,30,'set/jump'),(117,45,0,31,'Đầm QC/TL'),(118,52,0,31,'PRODUCTS'),(119,122,0,31,'d-m-qc-tl'),(120,123,0,31,'d-m/d-m-qc-tl'),(121,45,0,32,'Đầm thiết kế'),(122,52,0,32,'PRODUCTS'),(123,122,0,32,'d-m-thi-t-k'),(124,123,0,32,'d-m/d-m-thi-t-k'),(125,45,0,33,'Phụ kiện'),(126,52,0,33,'PRODUCTS'),(127,122,0,33,'ph-ki-n'),(128,123,0,33,'ph-ki-n'),(129,45,0,34,'Bút chì'),(130,52,0,34,'PRODUCTS'),(131,122,0,34,'but-chi'),(132,123,0,34,'chan-vay/but-chi'),(133,45,0,35,'Kiểu'),(134,52,0,35,'PRODUCTS'),(135,122,0,35,'ki-u'),(136,123,0,35,'chan-vay/ki-u'),(137,45,0,36,'Midi không xẻ'),(138,52,0,36,'PRODUCTS'),(139,122,0,36,'midi-khong-x'),(140,123,0,36,'chan-vay/midi-khong-x'),(141,45,0,37,'Midi xẻ trước'),(142,52,0,37,'PRODUCTS'),(143,122,0,37,'midi-x-tru-c'),(144,123,0,37,'chan-vay/midi-x-tru-c'),(145,45,0,38,'Yoko'),(146,52,0,38,'PRODUCTS'),(147,122,0,38,'yoko'),(148,123,0,38,'chan-vay/yoko'),(169,176,0,6,'0');
/*!40000 ALTER TABLE `spg_catalog_category_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_category_product`
--

DROP TABLE IF EXISTS `spg_catalog_category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_category_product` (
  `entity_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`entity_id`,`category_id`,`product_id`),
  UNIQUE KEY `SPG_CATALOG_CATEGORY_PRODUCT_CATEGORY_ID_PRODUCT_ID` (`category_id`,`product_id`),
  KEY `SPG_CATALOG_CATEGORY_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_CAT_CTGR_PRD_CTGR_ID_SPG_SEQUENCE_CAT_CTGR_SEQUENCE_VAL` FOREIGN KEY (`category_id`) REFERENCES `spg_sequence_catalog_category` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_CTGR_PRD_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Category Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_category_product`
--

LOCK TABLES `spg_catalog_category_product` WRITE;
/*!40000 ALTER TABLE `spg_catalog_category_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_category_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_category_product_index`
--

DROP TABLE IF EXISTS `spg_catalog_category_product_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_category_product_index` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `SPG_CAT_CTGR_PRD_IDX_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `IDX_C6CCE7C706BCD6427F7176C1AFA80D9D` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_category_product_index`
--

LOCK TABLES `spg_catalog_category_product_index` WRITE;
/*!40000 ALTER TABLE `spg_catalog_category_product_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_category_product_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_category_product_index_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_category_product_index_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_category_product_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `SPG_CAT_CTGR_PRD_IDX_TMP_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_category_product_index_tmp`
--

LOCK TABLES `spg_catalog_category_product_index_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_category_product_index_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_category_product_index_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_compare_item`
--

DROP TABLE IF EXISTS `spg_catalog_compare_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_compare_item` (
  `catalog_compare_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Compare Item ID',
  `visitor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`catalog_compare_item_id`),
  KEY `SPG_CATALOG_COMPARE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `SPG_CATALOG_COMPARE_ITEM_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  KEY `SPG_CATALOG_COMPARE_ITEM_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `SPG_CATALOG_COMPARE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_COMPARE_ITEM_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CATALOG_COMPARE_ITEM_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_CAT_CMP_ITEM_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Compare Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_compare_item`
--

LOCK TABLES `spg_catalog_compare_item` WRITE;
/*!40000 ALTER TABLE `spg_catalog_compare_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_compare_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_eav_attribute`
--

DROP TABLE IF EXISTS `spg_catalog_eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `frontend_input_renderer` varchar(255) DEFAULT NULL COMMENT 'Frontend Input Renderer',
  `is_global` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Global',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `is_searchable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable',
  `is_filterable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable',
  `is_comparable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Comparable',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `is_html_allowed_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is HTML Allowed On Front',
  `is_used_for_price_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Price Rules',
  `is_filterable_in_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable In Search',
  `used_in_product_listing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used In Product Listing',
  `used_for_sort_by` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Sorting',
  `apply_to` varchar(255) DEFAULT NULL COMMENT 'Apply To',
  `is_visible_in_advanced_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible In Advanced Search',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_wysiwyg_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is WYSIWYG Enabled',
  `is_used_for_promo_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Promo Rules',
  `is_required_in_admin_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Required In Admin Store',
  `is_used_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used in Grid',
  `is_visible_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible in Grid',
  `is_filterable_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable in Grid',
  `search_weight` float NOT NULL DEFAULT '1' COMMENT 'Search Weight',
  `additional_data` text COMMENT 'Additional swatch attributes data',
  PRIMARY KEY (`attribute_id`),
  KEY `SPG_CATALOG_EAV_ATTRIBUTE_USED_FOR_SORT_BY` (`used_for_sort_by`),
  KEY `SPG_CATALOG_EAV_ATTRIBUTE_USED_IN_PRODUCT_LISTING` (`used_in_product_listing`),
  CONSTRAINT `SPG_CAT_EAV_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog EAV Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_eav_attribute`
--

LOCK TABLES `spg_catalog_eav_attribute` WRITE;
/*!40000 ALTER TABLE `spg_catalog_eav_attribute` DISABLE KEYS */;
INSERT INTO `spg_catalog_eav_attribute` VALUES (45,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(46,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(47,NULL,0,1,0,0,0,0,1,0,0,0,0,NULL,0,0,1,0,0,0,0,0,1,NULL),(48,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(49,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(50,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(51,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(52,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(53,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(54,NULL,1,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(55,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(56,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(57,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(58,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(59,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(60,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(61,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(62,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(63,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(64,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(65,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(66,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(67,'Magento\\Catalog\\Block\\Adminhtml\\Category\\Helper\\Sortby\\Available',0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(68,'Magento\\Catalog\\Block\\Adminhtml\\Category\\Helper\\Sortby\\DefaultSortby',0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(69,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(70,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(71,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(72,'Magento\\Catalog\\Block\\Adminhtml\\Category\\Helper\\Pricestep',0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(73,NULL,0,1,1,0,0,0,0,0,0,1,1,NULL,1,0,0,0,0,0,0,0,5,NULL),(74,NULL,1,1,1,0,1,0,0,0,0,0,0,NULL,1,0,0,0,0,0,0,0,6,NULL),(75,NULL,0,1,1,0,1,0,1,0,0,0,0,NULL,1,0,1,0,0,0,0,0,1,NULL),(76,NULL,0,1,1,0,1,0,1,0,0,1,0,NULL,1,0,1,0,0,1,0,0,1,NULL),(77,NULL,1,1,1,1,0,0,0,0,0,1,1,'simple,virtual,bundle,downloadable,configurable',1,0,0,0,0,0,0,0,1,NULL),(78,NULL,1,1,0,0,0,0,0,0,0,1,0,'simple,virtual,bundle,downloadable,configurable',0,0,0,0,0,1,0,1,1,NULL),(79,NULL,2,1,0,0,0,0,0,0,0,1,0,'simple,virtual,bundle,downloadable,configurable',0,0,0,0,0,1,0,0,1,NULL),(80,NULL,2,1,0,0,0,0,0,0,0,1,0,'simple,virtual,bundle,downloadable,configurable',0,0,0,0,0,1,0,0,1,NULL),(81,NULL,1,1,0,0,0,0,0,0,0,0,0,'simple,virtual,downloadable',0,0,0,0,0,1,0,1,1,NULL),(82,'Magento\\Catalog\\Block\\Adminhtml\\Product\\Helper\\Form\\Weight',1,1,0,0,0,0,0,0,0,0,0,'simple,virtual,bundle,downloadable,giftcard,configurable',0,0,0,0,0,1,0,1,1,NULL),(83,NULL,1,1,1,1,1,0,0,0,0,0,0,'simple',1,0,0,0,0,1,0,1,1,NULL),(84,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,1,0,1,1,NULL),(85,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,1,0,1,1,NULL),(86,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,1,0,1,1,NULL),(87,NULL,0,1,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(88,NULL,0,1,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(89,NULL,0,1,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(90,NULL,1,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(91,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(92,NULL,2,1,0,0,0,0,0,0,0,0,0,'simple,virtual,bundle,downloadable,configurable',0,0,0,0,0,0,0,0,1,NULL),(93,NULL,1,1,1,1,1,0,0,0,0,0,0,'simple,virtual,configurable',1,0,0,0,0,1,0,1,1,NULL),(94,NULL,2,1,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,1,0,0,1,NULL),(95,NULL,2,1,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,1,0,0,1,NULL),(96,NULL,1,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(97,'Magento\\Framework\\Data\\Form\\Element\\Hidden',2,1,1,0,0,0,0,0,0,1,0,NULL,0,0,0,0,1,0,0,0,1,NULL),(98,NULL,0,0,0,0,0,0,0,0,0,0,0,'simple,virtual,bundle,downloadable,configurable',0,0,0,0,0,0,0,0,1,NULL),(99,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,1,0,0,0,1,NULL),(100,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,1,0,1,1,NULL),(101,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,1,0,0,1,NULL),(102,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,1,0,0,1,NULL),(103,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(104,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,1,0,0,1,NULL),(105,'Magento\\Catalog\\Block\\Adminhtml\\Product\\Helper\\Form\\Category',1,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(106,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(107,NULL,1,0,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(108,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(109,NULL,0,0,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(110,NULL,0,0,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(111,NULL,0,0,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(112,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(113,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(114,NULL,2,1,0,0,0,0,0,0,0,0,0,'simple,bundle,configurable,grouped',0,0,0,0,0,1,0,1,1,NULL),(115,'Magento\\CatalogInventory\\Block\\Adminhtml\\Form\\Field\\Stock',1,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(116,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,1,0,0,1,NULL),(117,NULL,1,1,0,0,0,0,0,0,0,1,0,'bundle',0,0,0,0,0,0,0,0,1,NULL),(118,NULL,1,1,0,0,0,0,0,0,0,0,0,'bundle',0,0,0,0,0,0,0,0,1,NULL),(119,NULL,1,1,0,0,0,0,0,0,0,1,0,'bundle',0,0,0,0,0,0,0,0,1,NULL),(120,NULL,1,1,0,0,0,0,0,0,0,1,0,'bundle',0,0,0,0,0,0,0,0,1,NULL),(121,NULL,1,1,0,0,0,0,0,0,0,1,0,'bundle',0,0,0,0,0,0,0,0,1,NULL),(122,NULL,0,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(123,NULL,0,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(124,NULL,0,1,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,1,0,1,1,NULL),(125,NULL,0,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(126,'Magento\\Msrp\\Block\\Adminhtml\\Product\\Helper\\Form\\Type',1,1,0,0,0,0,0,0,0,1,0,'simple,virtual,downloadable,bundle,configurable',0,0,0,0,0,1,0,1,1,NULL),(127,'Magento\\Msrp\\Block\\Adminhtml\\Product\\Helper\\Form\\Type\\Price',2,1,0,0,0,0,0,0,0,1,0,'simple,virtual,downloadable,bundle,configurable',0,0,0,0,0,0,0,0,1,NULL),(128,NULL,1,0,0,0,0,0,0,0,0,1,0,'downloadable',0,0,0,0,0,0,0,0,1,NULL),(129,NULL,0,0,0,0,0,0,0,0,0,0,0,'downloadable',0,0,0,0,0,0,0,0,1,NULL),(130,NULL,0,0,0,0,0,0,0,0,0,0,0,'downloadable',0,0,0,0,0,0,0,0,1,NULL),(131,NULL,1,0,0,0,0,0,0,0,0,1,0,'downloadable',0,0,0,0,0,0,0,0,1,NULL),(132,NULL,2,1,0,0,0,0,0,0,0,1,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(133,'Magento\\GiftCard\\Block\\Adminhtml\\Renderer\\OpenAmount',2,1,0,0,0,0,0,0,0,1,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(134,NULL,2,1,0,0,0,0,0,0,0,1,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(135,NULL,2,1,0,0,0,0,0,0,0,1,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(136,NULL,1,1,0,0,0,0,0,0,0,0,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(137,NULL,2,0,0,0,0,0,0,0,0,0,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(138,NULL,2,0,0,0,0,0,0,0,0,0,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(139,NULL,2,0,0,0,0,0,0,0,0,0,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(140,NULL,2,0,0,0,0,0,0,0,0,0,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(141,NULL,0,0,0,0,0,0,0,0,0,0,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(142,NULL,0,0,0,0,0,0,0,0,0,0,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(143,NULL,0,0,0,0,0,0,0,0,0,0,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(144,NULL,0,0,0,0,0,0,0,0,0,0,0,'giftcard',0,0,0,0,0,0,0,0,1,NULL),(145,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(146,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(147,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(148,NULL,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(149,NULL,2,1,1,0,0,0,0,0,0,1,0,'simple,virtual,bundle,downloadable,configurable',0,0,0,0,0,1,0,1,1,NULL),(150,'Magento\\GiftMessage\\Block\\Adminhtml\\Product\\Helper\\Form\\Config',1,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,1,0,0,1,NULL),(151,'Magento\\GiftWrapping\\Block\\Adminhtml\\Product\\Helper\\Form\\Config',0,1,0,0,0,0,0,0,0,0,0,'simple,bundle,giftcard,configurable',0,0,0,0,0,0,0,0,1,NULL),(152,NULL,1,1,0,0,0,0,0,0,0,0,0,'simple,bundle,giftcard,configurable',0,0,0,0,0,0,0,0,1,NULL),(174,'Magento\\Rma\\Block\\Adminhtml\\Product\\Renderer',2,1,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(175,NULL,0,1,0,0,0,0,0,0,0,1,0,NULL,0,0,0,0,0,0,0,0,1,NULL),(176,NULL,0,0,0,0,0,0,0,0,0,0,0,'category',0,0,0,0,0,0,0,0,1,NULL);
/*!40000 ALTER TABLE `spg_catalog_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_bundle_option`
--

DROP TABLE IF EXISTS `spg_catalog_product_bundle_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_bundle_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  PRIMARY KEY (`option_id`),
  KEY `SPG_CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_bundle_option`
--

LOCK TABLES `spg_catalog_product_bundle_option` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_bundle_option_value`
--

DROP TABLE IF EXISTS `spg_catalog_product_bundle_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_bundle_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CATALOG_PRODUCT_BUNDLE_OPTION_VALUE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  CONSTRAINT `SPG_CAT_PRD_BNDL_OPT_VAL_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `spg_catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_bundle_option_value`
--

LOCK TABLES `spg_catalog_product_bundle_option_value` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_option_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_bundle_price_index`
--

DROP TABLE IF EXISTS `spg_catalog_product_bundle_price_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_bundle_price_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `min_price` decimal(12,4) NOT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) NOT NULL COMMENT 'Max Price',
  PRIMARY KEY (`entity_id`,`website_id`,`customer_group_id`),
  KEY `SPG_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_WEBSITE_ID` (`website_id`),
  KEY `SPG_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_8070934FBD54C2F218BD000981E28E94` FOREIGN KEY (`customer_group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_SPG_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`entity_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_BNDL_PRICE_IDX_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Price Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_bundle_price_index`
--

LOCK TABLES `spg_catalog_product_bundle_price_index` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_price_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_price_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_bundle_selection`
--

DROP TABLE IF EXISTS `spg_catalog_product_bundle_selection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_bundle_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Selection Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  `selection_qty` decimal(12,4) DEFAULT NULL COMMENT 'Selection Qty',
  `selection_can_change_qty` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Selection Can Change Qty',
  PRIMARY KEY (`selection_id`),
  KEY `SPG_CATALOG_PRODUCT_BUNDLE_SELECTION_OPTION_ID` (`option_id`),
  KEY `SPG_CATALOG_PRODUCT_BUNDLE_SELECTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_CAT_PRD_BNDL_SELECTION_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `spg_catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_BNDL_SELECTION_PRD_ID_SPG_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_bundle_selection`
--

LOCK TABLES `spg_catalog_product_bundle_selection` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_selection` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_selection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_bundle_selection_price`
--

DROP TABLE IF EXISTS `spg_catalog_product_bundle_selection_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_bundle_selection_price` (
  `selection_id` int(10) unsigned NOT NULL COMMENT 'Selection Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  PRIMARY KEY (`selection_id`,`website_id`),
  KEY `SPG_CATALOG_PRODUCT_BUNDLE_SELECTION_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_A246822BBC7AA045B06CBC0BE51088A4` FOREIGN KEY (`selection_id`) REFERENCES `spg_catalog_product_bundle_selection` (`selection_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_BNDL_SELECTION_PRICE_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection Price';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_bundle_selection_price`
--

LOCK TABLES `spg_catalog_product_bundle_selection_price` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_selection_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_selection_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_bundle_stock_index`
--

DROP TABLE IF EXISTS `spg_catalog_product_bundle_stock_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_bundle_stock_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `stock_status` smallint(6) DEFAULT '0' COMMENT 'Stock Status',
  PRIMARY KEY (`entity_id`,`website_id`,`stock_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Stock Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_bundle_stock_index`
--

LOCK TABLES `spg_catalog_product_bundle_stock_index` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_stock_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_bundle_stock_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Version Id',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `created_in` bigint(20) unsigned NOT NULL COMMENT 'Update Id',
  `updated_in` bigint(20) unsigned NOT NULL COMMENT 'Next Update Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set ID',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  PRIMARY KEY (`row_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_SKU` (`sku`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_CREATED_IN` (`created_in`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_UPDATED_IN` (`updated_in`),
  KEY `SPG_CAT_PRD_ENTT_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL` (`entity_id`),
  CONSTRAINT `SPG_CAT_PRD_ENTT_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `spg_eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`entity_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity`
--

LOCK TABLES `spg_catalog_product_entity` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_datetime`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_PRD_ENTT_DTIME_ENTT_ID_ATTR_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_DTIME_ROW_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Datetime Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_datetime`
--

LOCK TABLES `spg_catalog_product_entity_datetime` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_decimal`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_PRD_ENTT_DEC_ENTT_ID_ATTR_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_DEC_ROW_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Decimal Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_decimal`
--

LOCK TABLES `spg_catalog_product_entity_decimal` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_gallery`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_gallery` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_PRD_ENTT_GLR_ENTT_ID_ATTR_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID` (`row_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_GLR_ROW_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Gallery Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_gallery`
--

LOCK TABLES `spg_catalog_product_entity_gallery` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_int`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_INT_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_PRODUCT_ENTITY_INT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_INT_ROW_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Integer Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_int`
--

LOCK TABLES `spg_catalog_product_entity_int` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_media_gallery`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_media_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_media_gallery` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  `media_type` varchar(32) NOT NULL DEFAULT 'image' COMMENT 'Media entry type',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility status',
  PRIMARY KEY (`value_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_CAT_PRD_ENTT_MDA_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_media_gallery`
--

LOCK TABLES `spg_catalog_product_entity_media_gallery` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_media_gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_media_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_media_gallery_value`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_media_gallery_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_media_gallery_value` (
  `value_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Value ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Disabled',
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Record Id',
  PRIMARY KEY (`record_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_STORE_ID` (`store_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_ENTITY_ID` (`row_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_VALUE_ID` (`value_id`),
  CONSTRAINT `SPG_CAT_PRD_ENTT_MDA_GLR_VAL_ROW_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_MDA_GLR_VAL_STORE_ID_SPG_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_MDA_GLR_VAL_VAL_ID_CAT_PRD_ENTT_MDA_GLR_VAL_ID` FOREIGN KEY (`value_id`) REFERENCES `spg_catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Value Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_media_gallery_value`
--

LOCK TABLES `spg_catalog_product_entity_media_gallery_value` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_media_gallery_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_media_gallery_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_media_gallery_value_to_entity`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_media_gallery_value_to_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_media_gallery_value_to_entity` (
  `value_id` int(10) unsigned NOT NULL COMMENT 'Value media Entry ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  UNIQUE KEY `SPG_CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_VAL_ID_ENTT_ID` (`value_id`,`row_id`),
  KEY `SPG_CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ROW_ID_CAT_PRD_ENTT_ROW_ID` (`row_id`),
  CONSTRAINT `FK_7D7A2DD7A800C0A15F127FF69FC0CDBD` FOREIGN KEY (`value_id`) REFERENCES `spg_catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ROW_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link Media value to Product entity table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_media_gallery_value_to_entity`
--

LOCK TABLES `spg_catalog_product_entity_media_gallery_value_to_entity` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_media_gallery_value_to_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_media_gallery_value_to_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_media_gallery_value_video`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_media_gallery_value_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_media_gallery_value_video` (
  `value_id` int(10) unsigned NOT NULL COMMENT 'Media Entity ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `provider` varchar(32) DEFAULT NULL COMMENT 'Video provider ID',
  `url` text COMMENT 'Video URL',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `description` text COMMENT 'Page Meta Description',
  `metadata` text COMMENT 'Video meta data',
  UNIQUE KEY `SPG_CAT_PRD_ENTT_MDA_GLR_VAL_VIDEO_VAL_ID_STORE_ID` (`value_id`,`store_id`),
  KEY `SPG_CAT_PRD_ENTT_MDA_GLR_VAL_VIDEO_STORE_ID_SPG_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_1989E9392EE65113B633BD6C8A1B9C41` FOREIGN KEY (`value_id`) REFERENCES `spg_catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_MDA_GLR_VAL_VIDEO_STORE_ID_SPG_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Video Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_media_gallery_value_video`
--

LOCK TABLES `spg_catalog_product_entity_media_gallery_value_video` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_media_gallery_value_video` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_media_gallery_value_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_text`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_TEXT_ROW_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Text Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_text`
--

LOCK TABLES `spg_catalog_product_entity_text` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_tier_price`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_tier_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_tier_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'QTY',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_0A12B8A19BE12C03BED30D4616C1848F` (`row_id`,`all_groups`,`customer_group_id`,`qty`,`website_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_77D68FEF996EFCB7D03B13E4B54E9060` FOREIGN KEY (`customer_group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_TIER_PRICE_ROW_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_TIER_PRICE_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_tier_price`
--

LOCK TABLES `spg_catalog_product_entity_tier_price` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_tier_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_tier_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_entity_varchar`
--

DROP TABLE IF EXISTS `spg_catalog_product_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_PRD_ENTT_VCHR_ENTT_ID_ATTR_ID_STORE_ID` (`row_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_ENTT_VCHR_ROW_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Varchar Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_entity_varchar`
--

LOCK TABLES `spg_catalog_product_entity_varchar` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_eav`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_eav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_eav` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_STORE_ID` (`store_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_eav`
--

LOCK TABLES `spg_catalog_product_index_eav` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_eav_decimal`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_eav_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_eav_decimal` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_STORE_ID` (`store_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_eav_decimal`
--

LOCK TABLES `spg_catalog_product_index_eav_decimal` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_eav_decimal_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_eav_decimal_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_eav_decimal_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_STORE_ID` (`store_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_eav_decimal_idx`
--

LOCK TABLES `spg_catalog_product_index_eav_decimal_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_decimal_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_decimal_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_eav_decimal_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_eav_decimal_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_eav_decimal_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_STORE_ID` (`store_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_eav_decimal_tmp`
--

LOCK TABLES `spg_catalog_product_index_eav_decimal_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_decimal_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_decimal_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_eav_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_eav_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_eav_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_IDX_STORE_ID` (`store_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_eav_idx`
--

LOCK TABLES `spg_catalog_product_index_eav_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_eav_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_eav_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_eav_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_TMP_STORE_ID` (`store_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_EAV_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_eav_tmp`
--

LOCK TABLES `spg_catalog_product_index_eav_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_eav_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_PRICE_MIN_PRICE` (`min_price`),
  KEY `SPG_CAT_PRD_IDX_PRICE_WS_ID_CSTR_GROUP_ID_MIN_PRICE` (`website_id`,`customer_group_id`,`min_price`),
  CONSTRAINT `SPG_CAT_PRD_IDX_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_IDX_PRICE_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`entity_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_IDX_PRICE_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price`
--

LOCK TABLES `spg_catalog_product_index_price` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_bundle_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_bundle_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_bundle_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_bundle_idx`
--

LOCK TABLES `spg_catalog_product_index_price_bundle_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_bundle_opt_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_bundle_opt_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_bundle_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_bundle_opt_idx`
--

LOCK TABLES `spg_catalog_product_index_price_bundle_opt_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_opt_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_opt_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_bundle_opt_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_bundle_opt_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_bundle_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_bundle_opt_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_bundle_opt_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_opt_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_opt_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_bundle_sel_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_bundle_sel_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_bundle_sel_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_bundle_sel_idx`
--

LOCK TABLES `spg_catalog_product_index_price_bundle_sel_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_sel_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_sel_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_bundle_sel_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_bundle_sel_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_bundle_sel_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_bundle_sel_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_bundle_sel_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_sel_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_sel_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_bundle_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_bundle_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_bundle_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_bundle_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_bundle_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_bundle_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_cfg_opt_agr_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_cfg_opt_agr_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_cfg_opt_agr_idx` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_cfg_opt_agr_idx`
--

LOCK TABLES `spg_catalog_product_index_price_cfg_opt_agr_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_cfg_opt_agr_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_cfg_opt_agr_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_cfg_opt_agr_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_cfg_opt_agr_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_cfg_opt_agr_tmp` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_cfg_opt_agr_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_cfg_opt_agr_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_cfg_opt_agr_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_cfg_opt_agr_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_cfg_opt_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_cfg_opt_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_cfg_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_cfg_opt_idx`
--

LOCK TABLES `spg_catalog_product_index_price_cfg_opt_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_cfg_opt_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_cfg_opt_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_cfg_opt_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_cfg_opt_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_cfg_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_cfg_opt_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_cfg_opt_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_cfg_opt_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_cfg_opt_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_downlod_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_downlod_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_downlod_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indexer Table for price of downloadable products';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_downlod_idx`
--

LOCK TABLES `spg_catalog_product_index_price_downlod_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_downlod_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_downlod_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_downlod_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_downlod_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_downlod_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Temporary Indexer Table for price of downloadable products';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_downlod_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_downlod_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_downlod_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_downlod_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_final_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_final_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_final_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_final_idx`
--

LOCK TABLES `spg_catalog_product_index_price_final_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_final_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_final_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_final_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_final_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_final_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_final_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_final_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_final_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_final_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_PRICE_IDX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_PRICE_IDX_WEBSITE_ID` (`website_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_PRICE_IDX_MIN_PRICE` (`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_idx`
--

LOCK TABLES `spg_catalog_product_index_price_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_opt_agr_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_opt_agr_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_opt_agr_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_opt_agr_idx`
--

LOCK TABLES `spg_catalog_product_index_price_opt_agr_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_opt_agr_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_opt_agr_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_opt_agr_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_opt_agr_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_opt_agr_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_opt_agr_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_opt_agr_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_opt_agr_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_opt_agr_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_opt_idx`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_opt_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_opt_idx`
--

LOCK TABLES `spg_catalog_product_index_price_opt_idx` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_opt_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_opt_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_opt_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_opt_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_opt_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_opt_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_opt_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_opt_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_price_tmp`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_price_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_price_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_PRICE_TMP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_PRICE_TMP_WEBSITE_ID` (`website_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_PRICE_TMP_MIN_PRICE` (`min_price`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_price_tmp`
--

LOCK TABLES `spg_catalog_product_index_price_tmp` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_price_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_tier_price`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_tier_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_tier_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_629D28909BA51E00260B86472641482E` FOREIGN KEY (`customer_group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_IDX_TIER_PRICE_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`entity_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_IDX_TIER_PRICE_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_tier_price`
--

LOCK TABLES `spg_catalog_product_index_tier_price` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_tier_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_tier_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_index_website`
--

DROP TABLE IF EXISTS `spg_catalog_product_index_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_index_website` (
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `website_date` date DEFAULT NULL COMMENT 'Website Date',
  `rate` float DEFAULT '1' COMMENT 'Rate',
  PRIMARY KEY (`website_id`),
  KEY `SPG_CATALOG_PRODUCT_INDEX_WEBSITE_WEBSITE_DATE` (`website_date`),
  CONSTRAINT `SPG_CAT_PRD_IDX_WS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Website Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_index_website`
--

LOCK TABLES `spg_catalog_product_index_website` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_index_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_index_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_link`
--

DROP TABLE IF EXISTS `spg_catalog_product_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `linked_product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Linked Product ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `SPG_CAT_PRD_LNK_LNK_TYPE_ID_PRD_ID_LNKED_PRD_ID` (`link_type_id`,`product_id`,`linked_product_id`),
  KEY `SPG_CATALOG_PRODUCT_LINK_PRODUCT_ID` (`product_id`),
  KEY `SPG_CATALOG_PRODUCT_LINK_LINKED_PRODUCT_ID` (`linked_product_id`),
  CONSTRAINT `SPG_CAT_PRD_LNK_LNKED_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`linked_product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_LNK_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `spg_catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_LNK_PRD_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`product_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Product Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_link`
--

LOCK TABLES `spg_catalog_product_link` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_link_attribute`
--

DROP TABLE IF EXISTS `spg_catalog_product_link_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_link_attribute` (
  `product_link_attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Link Attribute ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  `product_link_attribute_code` varchar(32) DEFAULT NULL COMMENT 'Product Link Attribute Code',
  `data_type` varchar(32) DEFAULT NULL COMMENT 'Data Type',
  PRIMARY KEY (`product_link_attribute_id`),
  KEY `SPG_CATALOG_PRODUCT_LINK_ATTRIBUTE_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `SPG_CAT_PRD_LNK_ATTR_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `spg_catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_link_attribute`
--

LOCK TABLES `spg_catalog_product_link_attribute` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_link_attribute` DISABLE KEYS */;
INSERT INTO `spg_catalog_product_link_attribute` VALUES (1,1,'position','int'),(2,4,'position','int'),(3,5,'position','int'),(4,3,'position','int'),(5,3,'qty','decimal');
/*!40000 ALTER TABLE `spg_catalog_product_link_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_link_attribute_decimal`
--

DROP TABLE IF EXISTS `spg_catalog_product_link_attribute_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_link_attribute_decimal` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `SPG_CATALOG_PRODUCT_LINK_ATTRIBUTE_DECIMAL_LINK_ID` (`link_id`),
  CONSTRAINT `FK_19454DDE2A389C85230B52CA96DE1DC5` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `spg_catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_LNK_ATTR_DEC_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `spg_catalog_product_link` (`link_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Decimal Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_link_attribute_decimal`
--

LOCK TABLES `spg_catalog_product_link_attribute_decimal` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_link_attribute_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_link_attribute_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_link_attribute_int`
--

DROP TABLE IF EXISTS `spg_catalog_product_link_attribute_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_link_attribute_int` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `SPG_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_LINK_ID` (`link_id`),
  CONSTRAINT `FK_496DD217AB47ABF850AF0CBEF0C4B79D` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `spg_catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_LNK_ATTR_INT_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `spg_catalog_product_link` (`link_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Integer Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_link_attribute_int`
--

LOCK TABLES `spg_catalog_product_link_attribute_int` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_link_attribute_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_link_attribute_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_link_attribute_varchar`
--

DROP TABLE IF EXISTS `spg_catalog_product_link_attribute_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_link_attribute_varchar` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `SPG_CATALOG_PRODUCT_LINK_ATTRIBUTE_VARCHAR_LINK_ID` (`link_id`),
  CONSTRAINT `FK_1A43A2A756BDB059F6706D2360834602` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `spg_catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_LNK_ATTR_VCHR_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `spg_catalog_product_link` (`link_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Varchar Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_link_attribute_varchar`
--

LOCK TABLES `spg_catalog_product_link_attribute_varchar` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_link_attribute_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_link_attribute_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_link_type`
--

DROP TABLE IF EXISTS `spg_catalog_product_link_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_link_type` (
  `link_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Type ID',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  PRIMARY KEY (`link_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Type Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_link_type`
--

LOCK TABLES `spg_catalog_product_link_type` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_link_type` DISABLE KEYS */;
INSERT INTO `spg_catalog_product_link_type` VALUES (1,'relation'),(3,'super'),(4,'up_sell'),(5,'cross_sell');
/*!40000 ALTER TABLE `spg_catalog_product_link_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_option`
--

DROP TABLE IF EXISTS `spg_catalog_product_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `type` varchar(50) DEFAULT NULL COMMENT 'Type',
  `is_require` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Required',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `max_characters` int(10) unsigned DEFAULT NULL COMMENT 'Max Characters',
  `file_extension` varchar(50) DEFAULT NULL COMMENT 'File Extension',
  `image_size_x` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size X',
  `image_size_y` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size Y',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `SPG_CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_CAT_PRD_OPT_PRD_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`product_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_option`
--

LOCK TABLES `spg_catalog_product_option` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_option_price`
--

DROP TABLE IF EXISTS `spg_catalog_product_option_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_option_price` (
  `option_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Price ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_price_id`),
  UNIQUE KEY `SPG_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_OPT_PRICE_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `spg_catalog_product_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Price Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_option_price`
--

LOCK TABLES `spg_catalog_product_option_price` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_option_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_option_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_option_title`
--

DROP TABLE IF EXISTS `spg_catalog_product_option_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_option_title` (
  `option_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Title ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_title_id`),
  UNIQUE KEY `SPG_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_OPT_TTL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `spg_catalog_product_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_option_title`
--

LOCK TABLES `spg_catalog_product_option_title` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_option_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_option_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_option_type_price`
--

DROP TABLE IF EXISTS `spg_catalog_product_option_type_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_option_type_price` (
  `option_type_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Price ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_type_price_id`),
  UNIQUE KEY `SPG_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_0AA4C3584D33F904C48B44D1906FC26A` FOREIGN KEY (`option_type_id`) REFERENCES `spg_catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Price Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_option_type_price`
--

LOCK TABLES `spg_catalog_product_option_type_price` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_option_type_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_option_type_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_option_type_title`
--

DROP TABLE IF EXISTS `spg_catalog_product_option_type_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_option_type_title` (
  `option_type_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Title ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_type_title_id`),
  UNIQUE KEY `SPG_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_022BAB8381BE96AE4EFD79D58E6343D0` FOREIGN KEY (`option_type_id`) REFERENCES `spg_catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_option_type_title`
--

LOCK TABLES `spg_catalog_product_option_type_title` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_option_type_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_option_type_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_option_type_value`
--

DROP TABLE IF EXISTS `spg_catalog_product_option_type_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_option_type_value` (
  `option_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_type_id`),
  KEY `SPG_CATALOG_PRODUCT_OPTION_TYPE_VALUE_OPTION_ID` (`option_id`),
  CONSTRAINT `SPG_CAT_PRD_OPT_TYPE_VAL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `spg_catalog_product_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Value Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_option_type_value`
--

LOCK TABLES `spg_catalog_product_option_type_value` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_option_type_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_option_type_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_relation`
--

DROP TABLE IF EXISTS `spg_catalog_product_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_relation` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  PRIMARY KEY (`parent_id`,`child_id`),
  KEY `SPG_CATALOG_PRODUCT_RELATION_CHILD_ID` (`child_id`),
  CONSTRAINT `SPG_CAT_PRD_RELATION_CHILD_ID_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`child_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_RELATION_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Relation Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_relation`
--

LOCK TABLES `spg_catalog_product_relation` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_super_attribute`
--

DROP TABLE IF EXISTS `spg_catalog_product_super_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_super_attribute` (
  `product_super_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Super Attribute ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`product_super_attribute_id`),
  UNIQUE KEY `SPG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID` (`product_id`,`attribute_id`),
  CONSTRAINT `SPG_CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`product_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_super_attribute`
--

LOCK TABLES `spg_catalog_product_super_attribute` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_super_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_super_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_super_attribute_label`
--

DROP TABLE IF EXISTS `spg_catalog_product_super_attribute_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_super_attribute_label` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `use_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Use Default Value',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID_STORE_ID` (`product_super_attribute_id`,`store_id`),
  KEY `SPG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_568F28C6B8577D7A7A1A09066F06ECBD` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `spg_catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_SPR_ATTR_LBL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Label Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_super_attribute_label`
--

LOCK TABLES `spg_catalog_product_super_attribute_label` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_super_attribute_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_super_attribute_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_super_link`
--

DROP TABLE IF EXISTS `spg_catalog_product_super_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_super_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `SPG_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID` (`product_id`,`parent_id`),
  KEY `SPG_CATALOG_PRODUCT_SUPER_LINK_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ROW_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_SPR_LNK_PRD_ID_SPG_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Link Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_super_link`
--

LOCK TABLES `spg_catalog_product_super_link` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_super_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_super_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_product_website`
--

DROP TABLE IF EXISTS `spg_catalog_product_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_product_website` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`product_id`,`website_id`),
  KEY `SPG_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CAT_PRD_WS_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Website Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_product_website`
--

LOCK TABLES `spg_catalog_product_website` WRITE;
/*!40000 ALTER TABLE `spg_catalog_product_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_product_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalog_url_rewrite_product_category`
--

DROP TABLE IF EXISTS `spg_catalog_url_rewrite_product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalog_url_rewrite_product_category` (
  `url_rewrite_id` int(10) unsigned NOT NULL COMMENT 'url_rewrite_id',
  `category_id` int(10) unsigned NOT NULL COMMENT 'category_id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'product_id',
  KEY `SPG_CATALOG_URL_REWRITE_PRODUCT_CATEGORY_CATEGORY_ID_PRODUCT_ID` (`category_id`,`product_id`),
  KEY `FK_548EA9D4736FC53CBB8B4A890406F6B3` (`url_rewrite_id`),
  KEY `FK_41F1762859F7AF852F9CF74FABE9D82B` (`product_id`),
  CONSTRAINT `FK_41F1762859F7AF852F9CF74FABE9D82B` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `FK_548EA9D4736FC53CBB8B4A890406F6B3` FOREIGN KEY (`url_rewrite_id`) REFERENCES `spg_url_rewrite` (`url_rewrite_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_E032FDA2D6E552B2274B27DE9B34A732` FOREIGN KEY (`category_id`) REFERENCES `spg_sequence_catalog_category` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='url_rewrite_relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalog_url_rewrite_product_category`
--

LOCK TABLES `spg_catalog_url_rewrite_product_category` WRITE;
/*!40000 ALTER TABLE `spg_catalog_url_rewrite_product_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalog_url_rewrite_product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cataloginventory_stock`
--

DROP TABLE IF EXISTS `spg_cataloginventory_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cataloginventory_stock` (
  `stock_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Stock Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_name` varchar(255) DEFAULT NULL COMMENT 'Stock Name',
  PRIMARY KEY (`stock_id`),
  KEY `SPG_CATALOGINVENTORY_STOCK_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cataloginventory_stock`
--

LOCK TABLES `spg_cataloginventory_stock` WRITE;
/*!40000 ALTER TABLE `spg_cataloginventory_stock` DISABLE KEYS */;
INSERT INTO `spg_cataloginventory_stock` VALUES (1,0,'Default');
/*!40000 ALTER TABLE `spg_cataloginventory_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cataloginventory_stock_item`
--

DROP TABLE IF EXISTS `spg_cataloginventory_stock_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cataloginventory_stock_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `stock_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Id',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `min_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Min Qty',
  `use_config_min_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Qty',
  `is_qty_decimal` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Qty Decimal',
  `backorders` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Backorders',
  `use_config_backorders` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Backorders',
  `min_sale_qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'Min Sale Qty',
  `use_config_min_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Sale Qty',
  `max_sale_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Max Sale Qty',
  `use_config_max_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Max Sale Qty',
  `is_in_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is In Stock',
  `low_stock_date` timestamp NULL DEFAULT NULL COMMENT 'Low Stock Date',
  `notify_stock_qty` decimal(12,4) DEFAULT NULL COMMENT 'Notify Stock Qty',
  `use_config_notify_stock_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Notify Stock Qty',
  `manage_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Manage Stock',
  `use_config_manage_stock` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Manage Stock',
  `stock_status_changed_auto` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Status Changed Automatically',
  `use_config_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Qty Increments',
  `qty_increments` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Increments',
  `use_config_enable_qty_inc` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Enable Qty Increments',
  `enable_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable Qty Increments',
  `is_decimal_divided` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Divided into Multiple Boxes for Shipping',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Divided into Multiple Boxes for Shipping',
  `deferred_stock_update` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Use deferred Stock update',
  `use_config_deferred_stock_update` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use configuration settings for deferred Stock update',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `SPG_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID_WEBSITE_ID` (`product_id`,`website_id`),
  KEY `SPG_CATALOGINVENTORY_STOCK_ITEM_WEBSITE_ID` (`website_id`),
  KEY `SPG_CATALOGINVENTORY_STOCK_ITEM_STOCK_ID` (`stock_id`),
  CONSTRAINT `SPG_CATINV_STOCK_ITEM_PRD_ID_SPG_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CATINV_STOCK_ITEM_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `spg_cataloginventory_stock` (`stock_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cataloginventory_stock_item`
--

LOCK TABLES `spg_cataloginventory_stock_item` WRITE;
/*!40000 ALTER TABLE `spg_cataloginventory_stock_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_cataloginventory_stock_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cataloginventory_stock_status`
--

DROP TABLE IF EXISTS `spg_cataloginventory_stock_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cataloginventory_stock_status` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `SPG_CATALOGINVENTORY_STOCK_STATUS_STOCK_ID` (`stock_id`),
  KEY `SPG_CATALOGINVENTORY_STOCK_STATUS_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cataloginventory_stock_status`
--

LOCK TABLES `spg_cataloginventory_stock_status` WRITE;
/*!40000 ALTER TABLE `spg_cataloginventory_stock_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_cataloginventory_stock_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cataloginventory_stock_status_idx`
--

DROP TABLE IF EXISTS `spg_cataloginventory_stock_status_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cataloginventory_stock_status_idx` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `SPG_CATALOGINVENTORY_STOCK_STATUS_IDX_STOCK_ID` (`stock_id`),
  KEY `SPG_CATALOGINVENTORY_STOCK_STATUS_IDX_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cataloginventory_stock_status_idx`
--

LOCK TABLES `spg_cataloginventory_stock_status_idx` WRITE;
/*!40000 ALTER TABLE `spg_cataloginventory_stock_status_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_cataloginventory_stock_status_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cataloginventory_stock_status_tmp`
--

DROP TABLE IF EXISTS `spg_cataloginventory_stock_status_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cataloginventory_stock_status_tmp` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `SPG_CATALOGINVENTORY_STOCK_STATUS_TMP_STOCK_ID` (`stock_id`),
  KEY `SPG_CATALOGINVENTORY_STOCK_STATUS_TMP_WEBSITE_ID` (`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cataloginventory_stock_status_tmp`
--

LOCK TABLES `spg_cataloginventory_stock_status_tmp` WRITE;
/*!40000 ALTER TABLE `spg_cataloginventory_stock_status_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_cataloginventory_stock_status_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalogrule`
--

DROP TABLE IF EXISTS `spg_catalogrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalogrule` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Version Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `created_in` bigint(20) unsigned NOT NULL COMMENT 'Update Id',
  `updated_in` bigint(20) unsigned NOT NULL COMMENT 'Next Update Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL COMMENT 'From',
  `to_date` date DEFAULT NULL COMMENT 'To',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  PRIMARY KEY (`row_id`),
  KEY `SPG_CATALOGRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`),
  KEY `SPG_CATALOGRULE_CREATED_IN` (`created_in`),
  KEY `SPG_CATALOGRULE_UPDATED_IN` (`updated_in`),
  KEY `SPG_CATALOGRULE_RULE_ID_SEQUENCE_CATALOGRULE_SEQUENCE_VALUE` (`rule_id`),
  CONSTRAINT `SPG_CATALOGRULE_RULE_ID_SEQUENCE_CATALOGRULE_SEQUENCE_VALUE` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_catalogrule` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalogrule`
--

LOCK TABLES `spg_catalogrule` WRITE;
/*!40000 ALTER TABLE `spg_catalogrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalogrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalogrule_customer_group`
--

DROP TABLE IF EXISTS `spg_catalogrule_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalogrule_customer_group` (
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`row_id`,`customer_group_id`),
  KEY `SPG_CATALOGRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `SPG_CATALOGRULE_CUSTOMER_GROUP_ROW_ID_CATALOGRULE_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalogrule` (`row_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CATRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Customer Groups Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalogrule_customer_group`
--

LOCK TABLES `spg_catalogrule_customer_group` WRITE;
/*!40000 ALTER TABLE `spg_catalogrule_customer_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalogrule_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalogrule_group_website`
--

DROP TABLE IF EXISTS `spg_catalogrule_group_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalogrule_group_website` (
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`,`website_id`),
  KEY `SPG_CATALOGRULE_GROUP_WEBSITE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SPG_CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_CATRULE_GROUP_WS_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CATRULE_GROUP_WS_RULE_ID_SEQUENCE_CATRULE_SEQUENCE_VAL` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_catalogrule` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CATRULE_GROUP_WS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Group Website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalogrule_group_website`
--

LOCK TABLES `spg_catalogrule_group_website` WRITE;
/*!40000 ALTER TABLE `spg_catalogrule_group_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalogrule_group_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalogrule_product`
--

DROP TABLE IF EXISTS `spg_catalogrule_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalogrule_product` (
  `rule_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `from_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'From Time',
  `to_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'To time',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `action_operator` varchar(10) DEFAULT 'to_fixed' COMMENT 'Action Operator',
  `action_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Action Amount',
  `action_stop` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Action Stop',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_product_id`),
  UNIQUE KEY `IDX_BF1C4A567D469F4AE70271AD2130E47F` (`rule_id`,`from_time`,`to_time`,`website_id`,`customer_group_id`,`product_id`,`sort_order`),
  KEY `SPG_CATALOGRULE_PRODUCT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SPG_CATALOGRULE_PRODUCT_WEBSITE_ID` (`website_id`),
  KEY `SPG_CATALOGRULE_PRODUCT_FROM_TIME` (`from_time`),
  KEY `SPG_CATALOGRULE_PRODUCT_TO_TIME` (`to_time`),
  KEY `SPG_CATALOGRULE_PRODUCT_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalogrule_product`
--

LOCK TABLES `spg_catalogrule_product` WRITE;
/*!40000 ALTER TABLE `spg_catalogrule_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalogrule_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalogrule_product_price`
--

DROP TABLE IF EXISTS `spg_catalogrule_product_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalogrule_product_price` (
  `rule_product_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product PriceId',
  `rule_date` date NOT NULL COMMENT 'Rule Date',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `rule_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rule Price',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `latest_start_date` date DEFAULT NULL COMMENT 'Latest StartDate',
  `earliest_end_date` date DEFAULT NULL COMMENT 'Earliest EndDate',
  PRIMARY KEY (`rule_product_price_id`),
  UNIQUE KEY `SPG_CATRULE_PRD_PRICE_RULE_DATE_WS_ID_CSTR_GROUP_ID_PRD_ID` (`rule_date`,`website_id`,`customer_group_id`,`product_id`),
  KEY `SPG_CATALOGRULE_PRODUCT_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SPG_CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID` (`website_id`),
  KEY `SPG_CATALOGRULE_PRODUCT_PRICE_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product Price';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalogrule_product_price`
--

LOCK TABLES `spg_catalogrule_product_price` WRITE;
/*!40000 ALTER TABLE `spg_catalogrule_product_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalogrule_product_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalogrule_website`
--

DROP TABLE IF EXISTS `spg_catalogrule_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalogrule_website` (
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`row_id`,`website_id`),
  KEY `SPG_CATALOGRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_CATALOGRULE_WEBSITE_ROW_ID_CATALOGRULE_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_catalogrule` (`row_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CATALOGRULE_WEBSITE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Websites Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalogrule_website`
--

LOCK TABLES `spg_catalogrule_website` WRITE;
/*!40000 ALTER TABLE `spg_catalogrule_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalogrule_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalogsearch_fulltext_scope1`
--

DROP TABLE IF EXISTS `spg_catalogsearch_fulltext_scope1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalogsearch_fulltext_scope1` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` int(10) unsigned NOT NULL COMMENT 'Attribute_id',
  `data_index` longtext COMMENT 'Data index',
  PRIMARY KEY (`entity_id`,`attribute_id`),
  FULLTEXT KEY `FTI_FULLTEXT_DATA_INDEX` (`data_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='spg_catalogsearch_fulltext_scope1';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalogsearch_fulltext_scope1`
--

LOCK TABLES `spg_catalogsearch_fulltext_scope1` WRITE;
/*!40000 ALTER TABLE `spg_catalogsearch_fulltext_scope1` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalogsearch_fulltext_scope1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_catalogsearch_recommendations`
--

DROP TABLE IF EXISTS `spg_catalogsearch_recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_catalogsearch_recommendations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `query_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Query Id',
  `relation_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Relation Id',
  PRIMARY KEY (`id`),
  KEY `SPG_CATALOGSEARCH_RECOMMENDATIONS_QUERY_ID_SEARCH_QUERY_QUERY_ID` (`query_id`),
  KEY `SPG_CATSRCH_RECOMMENDATIONS_RELATION_ID_SRCH_QR_QR_ID` (`relation_id`),
  CONSTRAINT `SPG_CATALOGSEARCH_RECOMMENDATIONS_QUERY_ID_SEARCH_QUERY_QUERY_ID` FOREIGN KEY (`query_id`) REFERENCES `spg_search_query` (`query_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CATSRCH_RECOMMENDATIONS_RELATION_ID_SRCH_QR_QR_ID` FOREIGN KEY (`relation_id`) REFERENCES `spg_search_query` (`query_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Advanced Search Recommendations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_catalogsearch_recommendations`
--

LOCK TABLES `spg_catalogsearch_recommendations` WRITE;
/*!40000 ALTER TABLE `spg_catalogsearch_recommendations` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_catalogsearch_recommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_checkout_agreement`
--

DROP TABLE IF EXISTS `spg_checkout_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_checkout_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `content` text COMMENT 'Content',
  `content_height` varchar(25) DEFAULT NULL COMMENT 'Content Height',
  `checkbox_text` text COMMENT 'Checkbox Text',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `is_html` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Html',
  `mode` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Applied mode',
  PRIMARY KEY (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_checkout_agreement`
--

LOCK TABLES `spg_checkout_agreement` WRITE;
/*!40000 ALTER TABLE `spg_checkout_agreement` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_checkout_agreement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_checkout_agreement_store`
--

DROP TABLE IF EXISTS `spg_checkout_agreement_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_checkout_agreement_store` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`agreement_id`,`store_id`),
  KEY `SPG_CHECKOUT_AGREEMENT_STORE_STORE_ID_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CHECKOUT_AGREEMENT_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CHKT_AGRT_STORE_AGRT_ID_CHKT_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `spg_checkout_agreement` (`agreement_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_checkout_agreement_store`
--

LOCK TABLES `spg_checkout_agreement_store` WRITE;
/*!40000 ALTER TABLE `spg_checkout_agreement_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_checkout_agreement_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cms_block`
--

DROP TABLE IF EXISTS `spg_cms_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cms_block` (
  `row_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Version Id',
  `block_id` smallint(6) NOT NULL COMMENT 'Entity Id',
  `created_in` bigint(20) unsigned NOT NULL COMMENT 'Update Id',
  `updated_in` bigint(20) unsigned NOT NULL COMMENT 'Next Update Id',
  `title` varchar(255) NOT NULL COMMENT 'Block Title',
  `identifier` varchar(255) NOT NULL COMMENT 'Block String Identifier',
  `content` mediumtext COMMENT 'Block Content',
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Block Creation Time',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Block Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Block Active',
  PRIMARY KEY (`row_id`),
  KEY `SPG_CMS_BLOCK_CREATED_IN` (`created_in`),
  KEY `SPG_CMS_BLOCK_UPDATED_IN` (`updated_in`),
  KEY `SPG_CMS_BLOCK_BLOCK_ID_SEQUENCE_CMS_BLOCK_SEQUENCE_VALUE` (`block_id`),
  FULLTEXT KEY `SPG_CMS_BLOCK_TITLE_IDENTIFIER_CONTENT` (`title`,`identifier`,`content`),
  CONSTRAINT `SPG_CMS_BLOCK_BLOCK_ID_SEQUENCE_CMS_BLOCK_SEQUENCE_VALUE` FOREIGN KEY (`block_id`) REFERENCES `spg_sequence_cms_block` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS Block Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cms_block`
--

LOCK TABLES `spg_cms_block` WRITE;
/*!40000 ALTER TABLE `spg_cms_block` DISABLE KEYS */;
INSERT INTO `spg_cms_block` VALUES (1,1,1,2147483647,'Catalog Events Lister','catalog_events_lister','<p>{{block class=\"Magento\\\\CatalogEvent\\\\Block\\\\Event\\\\Lister\" name=\"catalog.event.lister\" template=\"lister.phtml\"}}</p>','2017-02-03 07:50:19','2017-02-03 10:26:23',1),(2,2,1,2147483647,'SPG Footer','spg_footer','<p>&lt;div id=\"containerfooter\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-md-6 col-sm-12 footercol1\"&gt;<br />&lt;div class=\"widget-1 widget-first footer-widget\"&gt;&lt;aside id=\"virtue_split_content_widget-3\" class=\"widget virtue_split_content_widget\"&gt;&lt;!-- Image Split --&gt;<br />&lt;div id=\"kt-image-split-48\" class=\"kt-image-slit\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-sm-6 kt-si-imagecol img-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;&lt;img class=\"kt-si-image\" style=\"max-height: 200px;\" src=\"http://s3-ap-southeast-1.amazonaws.com/shopforgirl.vn/wp-content/uploads/2016/10/25225146/logo_new.png\" /&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;div class=\"col-sm-18 kt-si-imagecol content-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;<br />&lt;h2 class=\"kt_imgsplit_title\"&gt;Shopforgirl&lt;/h2&gt;<br />&lt;div class=\"kt_imgsplit_content\"&gt;Chuy&ecirc;n kinh doanh quần &aacute;o may mặc, gi&agrave;y d&eacute;p, phụ kiện thời trang.&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/aside&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;div class=\"col-md-6 col-sm-12 footercol2\"&gt;<br />&lt;div class=\"widget-1 widget-first footer-widget\"&gt;&lt;aside id=\"virtue_split_content_widget-4\" class=\"widget virtue_split_content_widget\"&gt;&lt;!-- Image Split --&gt;<br />&lt;div id=\"kt-image-split-90\" class=\"kt-image-slit\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-sm-24 kt-si-imagecol content-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;<br />&lt;h2 class=\"kt_imgsplit_title\"&gt;Chi nh&aacute;nh&lt;/h2&gt;<br />&lt;div class=\"kt_imgsplit_content\"&gt;</p>\r\n<p>&lt;strong&gt;Chi nh&aacute;nh 1&lt;/strong&gt;</p>\r\n<p>&lt;i class=\"fa fa-map-marker\"&gt;&lt;/i&gt;<br />220 B&agrave; Hạt - Phường 9 - Quận 10</p>\r\n<p>&lt;i class=\"fa fa-phone\"&gt;&lt;/i&gt; 08.66827498</p>\r\n<p>&lt;hr /&gt;</p>\r\n<p>&lt;strong&gt;Chi nh&aacute;nh 2&lt;/strong&gt;</p>\r\n<p>&lt;i class=\"fa fa-map-marker\"&gt;&lt;/i&gt;<br />153/3 Nguyễn Thị Minh Khai - Phường Phạm Ngũ L&atilde;o - Quận 1</p>\r\n<p>&lt;i class=\"fa fa-phone\"&gt;&lt;/i&gt;<br />08.66827459</p>\r\n<p>&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/aside&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;div class=\"col-md-6 col-sm-12 footercol3\"&gt;<br />&lt;div class=\"widget-1 widget-first footer-widget\"&gt;&lt;aside id=\"virtue_split_content_widget-5\" class=\"widget virtue_split_content_widget\"&gt;&lt;!-- Image Split --&gt;<br />&lt;div id=\"kt-image-split-47\" class=\"kt-image-slit\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-sm-24 kt-si-imagecol content-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;<br />&lt;h2 class=\"kt_imgsplit_title\"&gt;Danh mục nổi bật&lt;/h2&gt;<br />&lt;div class=\"kt_imgsplit_content\"&gt;<br />&lt;ul&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/quan/quan-jeans-rach-goi/\"&gt;Quần jeans r&aacute;ch gối&lt;/a&gt;&lt;/li&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/dam/dam-thiet-ke/\"&gt;Đầm thiết kế&lt;/a&gt;&lt;/li&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/ao/ao-croptop/\"&gt;&Aacute;o Croptop&lt;/a&gt;&lt;/li&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/chan-vay/but-chi/\"&gt;B&uacute;t ch&igrave;&lt;/a&gt;&lt;/li&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/chan-vay/midi-xe-truoc/\"&gt;Midi xẻ trước&lt;/a&gt;&lt;/li&gt;<br />&lt;/ul&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/aside&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;div class=\"col-md-6 col-sm-12 footercol4\"&gt;<br />&lt;div class=\"widget-1 widget-first footer-widget\"&gt;&lt;aside id=\"virtue_split_content_widget-6\" class=\"widget virtue_split_content_widget\"&gt;&lt;!-- Image Split --&gt;<br />&lt;div id=\"kt-image-split-50\" class=\"kt-image-slit\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-sm-24 kt-si-imagecol content-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;<br />&lt;h2 class=\"kt_imgsplit_title\"&gt;Li&ecirc;n hệ&lt;/h2&gt;<br />&lt;div class=\"kt_imgsplit_content\"&gt;&lt;i class=\"fa fa-envelope-o\"&gt;&lt;/i&gt; info@shopforgirl.vn</p>\r\n<p>&lt;i class=\"fa fa-facebook\"&gt;&lt;/i&gt;<br />&lt;a href=\"http://www.facebook.com/shop4girl.2011\"&gt;shopforgirl fanpage&lt;/a&gt;</p>\r\n<p>Mở cửa từ 10h đến 21h30</p>\r\n<p>&lt;hr /&gt;</p>\r\n<p>&lt;strong&gt;Thanh to&aacute;n&lt;/strong&gt;</p>\r\n<p>B&ugrave;i Nguyễn Trường An</p>\r\n<p>TK Vietcombank : 0531000282454</p>\r\n<p>TK Đ&Ocirc;NG &Aacute; : 0107854175</p>\r\n<p>Chi nh&aacute;nh Bạch Đằng TP.Hồ Ch&iacute; Minh</p>\r\n<p>&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/aside&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;!-- Row --&gt;</p>\r\n<p>&lt;/div&gt;</p>','2017-02-03 10:30:03','2017-02-03 10:30:20',1);
/*!40000 ALTER TABLE `spg_cms_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cms_block_store`
--

DROP TABLE IF EXISTS `spg_cms_block_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cms_block_store` (
  `row_id` smallint(6) NOT NULL COMMENT 'Version Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`row_id`,`store_id`),
  KEY `SPG_CMS_BLOCK_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CMS_BLOCK_STORE_ROW_ID_CMS_BLOCK_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_cms_block` (`row_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CMS_BLOCK_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block To Store Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cms_block_store`
--

LOCK TABLES `spg_cms_block_store` WRITE;
/*!40000 ALTER TABLE `spg_cms_block_store` DISABLE KEYS */;
INSERT INTO `spg_cms_block_store` VALUES (1,0),(2,0);
/*!40000 ALTER TABLE `spg_cms_block_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cms_page`
--

DROP TABLE IF EXISTS `spg_cms_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cms_page` (
  `row_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Version Id',
  `page_id` smallint(6) NOT NULL COMMENT 'Entity Id',
  `created_in` bigint(20) unsigned NOT NULL COMMENT 'Update Id',
  `updated_in` bigint(20) unsigned NOT NULL COMMENT 'Next Update Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `page_layout` varchar(255) DEFAULT NULL COMMENT 'Page Layout',
  `meta_keywords` text COMMENT 'Page Meta Keywords',
  `meta_description` text COMMENT 'Page Meta Description',
  `identifier` varchar(100) DEFAULT NULL COMMENT 'Page String Identifier',
  `content_heading` varchar(255) DEFAULT NULL COMMENT 'Page Content Heading',
  `content` mediumtext COMMENT 'Page Content',
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Page Creation Time',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Page Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Page Active',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Page Sort Order',
  `layout_update_xml` text COMMENT 'Page Layout Update Content',
  `custom_theme` varchar(100) DEFAULT NULL COMMENT 'Page Custom Theme',
  `custom_root_template` varchar(255) DEFAULT NULL COMMENT 'Page Custom Template',
  `custom_layout_update_xml` text COMMENT 'Page Custom Layout Update Content',
  `custom_theme_from` date DEFAULT NULL COMMENT 'Page Custom Theme Active From Date',
  `custom_theme_to` date DEFAULT NULL COMMENT 'Page Custom Theme Active To Date',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Page Meta Title',
  `website_root` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Website Root',
  PRIMARY KEY (`row_id`),
  KEY `SPG_CMS_PAGE_IDENTIFIER` (`identifier`),
  KEY `SPG_CMS_PAGE_CREATED_IN` (`created_in`),
  KEY `SPG_CMS_PAGE_UPDATED_IN` (`updated_in`),
  KEY `SPG_CMS_PAGE_PAGE_ID_SEQUENCE_CMS_PAGE_SEQUENCE_VALUE` (`page_id`),
  FULLTEXT KEY `FTI_19E65ED3ACFEAD9C37BA0269E36D17E1` (`title`,`meta_keywords`,`meta_description`,`identifier`,`content`),
  CONSTRAINT `SPG_CMS_PAGE_PAGE_ID_SEQUENCE_CMS_PAGE_SEQUENCE_VALUE` FOREIGN KEY (`page_id`) REFERENCES `spg_sequence_cms_page` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='CMS Page Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cms_page`
--

LOCK TABLES `spg_cms_page` WRITE;
/*!40000 ALTER TABLE `spg_cms_page` DISABLE KEYS */;
INSERT INTO `spg_cms_page` VALUES (1,1,1,2147483647,'404 Not Found','2columns-right','Page keywords','Page description','no-route','Whoops, our bad...','<dl>\r\n<dt>The page you requested was not found, and we have a fine guess why.</dt>\r\n<dd>\r\n<ul class=\"disc\">\r\n<li>If you typed the URL directly, please make sure the spelling is correct.</li>\r\n<li>If you clicked on a link to get here, the link is outdated.</li>\r\n</ul></dd>\r\n</dl>\r\n<dl>\r\n<dt>What can you do?</dt>\r\n<dd>Have no fear, help is near! There are many ways you can get back on track with Magento Store.</dd>\r\n<dd>\r\n<ul class=\"disc\">\r\n<li><a href=\"#\" onclick=\"history.go(-1); return false;\">Go back</a> to the previous page.</li>\r\n<li>Use the search bar at the top of the page to search for your products.</li>\r\n<li>Follow these links to get you back on track!<br /><a href=\"{{store url=\"\"}}\">Store Home</a> <span class=\"separator\">|</span> <a href=\"{{store url=\"customer/account\"}}\">My Account</a></li></ul></dd></dl>\r\n','2017-02-03 07:47:51','2017-02-03 07:47:51',1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(2,2,1,2147483647,'Home page','1column',NULL,NULL,'home','Home Page','<p>CMS homepage content goes here.</p>\r\n','2017-02-03 07:47:51','2017-02-03 07:48:24',1,0,'<!--\n    <referenceContainer name=\"right\">\n        <action method=\"unsetChild\"><argument name=\"alias\" xsi:type=\"string\">right.reports.product.viewed</argument></action>\n        <action method=\"unsetChild\"><argument name=\"alias\" xsi:type=\"string\">right.reports.product.compared</argument></action>\n    </referenceContainer>-->',NULL,NULL,NULL,NULL,NULL,NULL,1),(3,3,1,2147483647,'Enable Cookies','1column',NULL,NULL,'enable-cookies','What are Cookies?','<div class=\"enable-cookies cms-content\">\r\n<p>\"Cookies\" are little pieces of data we send when you visit our store. Cookies help us get to know you better and personalize your experience. Plus they help protect you and other shoppers from fraud.</p>\r\n<p style=\"margin-bottom: 20px;\">Set your browser to accept cookies so you can buy items, save items, and receive customized recommendations. Here’s how:</p>\r\n<ul>\r\n<li><a href=\"https://support.google.com/accounts/answer/61416?hl=en\" target=\"_blank\">Google Chrome</a></li>\r\n<li><a href=\"http://windows.microsoft.com/en-us/internet-explorer/delete-manage-cookies\" target=\"_blank\">Internet Explorer</a></li>\r\n<li><a href=\"http://support.apple.com/kb/PH19214\" target=\"_blank\">Safari</a></li>\r\n<li><a href=\"https://support.mozilla.org/en-US/kb/enable-and-disable-cookies-website-preferences\" target=\"_blank\">Mozilla/Firefox</a></li>\r\n</ul>\r\n</div>','2017-02-03 07:47:51','2017-02-03 07:47:51',1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(4,4,1,2147483647,'Privacy and Cookie Policy','1column',NULL,NULL,'privacy-policy-cookie-restriction-mode','Privacy and Cookie Policy','<div class=\"privacy-policy cms-content\">\n    <div class=\"message info\">\n        <span>\n            Please replace this text with you Privacy Policy.\n            Please add any additional cookies your website uses below (e.g. Google Analytics).\n        </span>\n    </div>\n    <p>\n        This privacy policy sets out how this website (hereafter \"the Store\") uses and protects any information that\n        you give the Store while using this website. The Store is committed to ensuring that your privacy is protected.\n        Should we ask you to provide certain information by which you can be identified when using this website, then\n        you can be assured that it will only be used in accordance with this privacy statement. The Store may change\n        this policy from time to time by updating this page. You should check this page from time to time to ensure\n        that you are happy with any changes.\n    </p>\n    <h2>What we collect</h2>\n    <p>We may collect the following information:</p>\n    <ul>\n        <li>name</li>\n        <li>contact information including email address</li>\n        <li>demographic information such as postcode, preferences and interests</li>\n        <li>other information relevant to customer surveys and/or offers</li>\n    </ul>\n    <p>\n        For the exhaustive list of cookies we collect see the <a href=\"#list\">List of cookies we collect</a> section.\n    </p>\n    <h2>What we do with the information we gather</h2>\n    <p>\n        We require this information to understand your needs and provide you with a better service,\n        and in particular for the following reasons:\n    </p>\n    <ul>\n        <li>Internal record keeping.</li>\n        <li>We may use the information to improve our products and services.</li>\n        <li>\n            We may periodically send promotional emails about new products, special offers or other information which we\n            think you may find interesting using the email address which you have provided.\n        </li>\n        <li>\n            From time to time, we may also use your information to contact you for market research purposes.\n            We may contact you by email, phone, fax or mail. We may use the information to customise the website\n            according to your interests.\n        </li>\n    </ul>\n    <h2>Security</h2>\n    <p>\n        We are committed to ensuring that your information is secure. In order to prevent unauthorised access or\n        disclosure, we have put in place suitable physical, electronic and managerial procedures to safeguard and\n        secure the information we collect online.\n    </p>\n    <h2>How we use cookies</h2>\n    <p>\n        A cookie is a small file which asks permission to be placed on your computer\'s hard drive.\n        Once you agree, the file is added and the cookie helps analyse web traffic or lets you know when you visit\n        a particular site. Cookies allow web applications to respond to you as an individual. The web application\n        can tailor its operations to your needs, likes and dislikes by gathering and remembering information about\n        your preferences.\n    </p>\n    <p>\n        We use traffic log cookies to identify which pages are being used. This helps us analyse data about web page\n        traffic and improve our website in order to tailor it to customer needs. We only use this information for\n        statistical analysis purposes and then the data is removed from the system.\n    </p>\n    <p>\n        Overall, cookies help us provide you with a better website, by enabling us to monitor which pages you find\n        useful and which you do not. A cookie in no way gives us access to your computer or any information about you,\n        other than the data you choose to share with us. You can choose to accept or decline cookies.\n        Most web browsers automatically accept cookies, but you can usually modify your browser setting\n        to decline cookies if you prefer. This may prevent you from taking full advantage of the website.\n    </p>\n    <h2>Links to other websites</h2>\n    <p>\n        Our website may contain links to other websites of interest. However, once you have used these links\n        to leave our site, you should note that we do not have any control over that other website.\n        Therefore, we cannot be responsible for the protection and privacy of any information which you provide whilst\n        visiting such sites and such sites are not governed by this privacy statement.\n        You should exercise caution and look at the privacy statement applicable to the website in question.\n    </p>\n    <h2>Controlling your personal information</h2>\n    <p>You may choose to restrict the collection or use of your personal information in the following ways:</p>\n    <ul>\n        <li>\n            whenever you are asked to fill in a form on the website, look for the box that you can click to indicate\n            that you do not want the information to be used by anybody for direct marketing purposes\n        </li>\n        <li>\n            if you have previously agreed to us using your personal information for direct marketing purposes,\n            you may change your mind at any time by letting us know using our Contact Us information\n        </li>\n    </ul>\n    <p>\n        We will not sell, distribute or lease your personal information to third parties unless we have your permission\n        or are required by law to do so. We may use your personal information to send you promotional information\n        about third parties which we think you may find interesting if you tell us that you wish this to happen.\n    </p>\n    <p>\n        You may request details of personal information which we hold about you under the Data Protection Act 1998.\n        A small fee will be payable. If you would like a copy of the information held on you please email us this\n        request using our Contact Us information.\n    </p>\n    <p>\n        If you believe that any information we are holding on you is incorrect or incomplete,\n        please write to or email us as soon as possible, at the above address.\n        We will promptly correct any information found to be incorrect.\n    </p>\n    <h2><a name=\"list\"></a>List of cookies we collect</h2>\n    <p>The table below lists the cookies we collect and what information they store.</p>\n    <table class=\"data-table data-table-definition-list\">\n        <thead>\n        <tr>\n            <th>Cookie Name</th>\n            <th>Cookie Description</th>\n        </tr>\n        </thead>\n        <tbody>\n            <tr>\n                <th>FORM_KEY</th>\n                <td>Stores randomly generated key used to prevent forged requests.</td>\n            </tr>\n            <tr>\n                <th>PHPSESSID</th>\n                <td>Your session ID on the server.</td>\n            </tr>\n            <tr>\n                <th>GUEST-VIEW</th>\n                <td>Allows guests to view and edit their orders.</td>\n            </tr>\n            <tr>\n                <th>PERSISTENT_SHOPPING_CART</th>\n                <td>A link to information about your cart and viewing history, if you have asked for this.</td>\n            </tr>\n            <tr>\n                <th>STF</th>\n                <td>Information on products you have emailed to friends.</td>\n            </tr>\n            <tr>\n                <th>STORE</th>\n                <td>The store view or language you have selected.</td>\n            </tr>\n            <tr>\n                <th>USER_ALLOWED_SAVE_COOKIE</th>\n                <td>Indicates whether a customer allowed to use cookies.</td>\n            </tr>\n            <tr>\n                <th>MAGE-CACHE-SESSID</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>MAGE-CACHE-STORAGE</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>MAGE-CACHE-STORAGE-SECTION-INVALIDATION</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>MAGE-CACHE-TIMEOUT</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>SECTION-DATA-IDS</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>PRIVATE_CONTENT_VERSION</th>\n                <td>Facilitates caching of content on the browser to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>X-MAGENTO-VARY</th>\n                <td>Facilitates caching of content on the server to make pages load faster.</td>\n            </tr>\n            <tr>\n                <th>MAGE-TRANSLATION-FILE-VERSION</th>\n                <td>Facilitates translation of content to other languages.</td>\n            </tr>\n            <tr>\n                <th>MAGE-TRANSLATION-STORAGE</th>\n                <td>Facilitates translation of content to other languages.</td>\n            </tr>\n        </tbody>\n    </table>\n</div>','2017-02-03 07:47:51','2017-02-03 07:47:51',1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(5,5,1,2147483647,'503 Service Unavailable','1column',NULL,NULL,'service-unavailable',NULL,'<div class=\"page-title\"><h1>We\'re Offline...</h1></div>\r\n<p>...but only for just a bit. We\'re working to make the Magento Enterprise Demo a better place for you!</p>','2017-02-03 07:50:18','2017-02-03 07:50:18',1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(6,6,1,2147483647,'Welcome to our Exclusive Online Store','1column',NULL,NULL,'private-sales',NULL,'<div class=\"private-sales-index\">\n        <div class=\"box\">\n        <div class=\"content\">\n        <h1>Welcome to our Exclusive Online Store</h1>\n        <p>If you are a registered member, please <a href=\"{{store url=\"customer/account/login\"}}\">sign in here</a>.</p>\n        </div>\n        </div>\n        </div>','2017-02-03 07:50:18','2017-02-03 07:50:18',1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(7,7,1,2147483647,'Reward Points','1column',NULL,NULL,'reward-points','Reward Points','<p>The Reward Points Program allows you to earn points for certain actions you take on the site. Points are awarded based on making purchases and customer actions such as submitting reviews.</p>\n\n        <h2>Benefits of Reward Points for Registered Customers</h2>\n        <p>Once you register you will be able to earn and accrue reward points, which are then redeemable at time of purchase towards the cost of your order. Rewards are an added bonus to your shopping experience on the site and just one of the ways we thank you for being a loyal customer.</p>\n\n        <h2>Earning Reward Points</h2>\n        <p>Rewards can currently be earned for the following actions:</p>\n        <ul>\n        <li>Making purchases — every time you make a purchase you earn points based on the price of products purchased and these points are added to your Reward Points balance.</li>\n        <li>Registering on the site.</li>\n        <li>Subscribing to a newsletter for the first time.</li>\n        <li>Sending Invitations — Earn points by inviting your friends to join the site.</li>\n        <li>Converting Invitations to Customer — Earn points for every invitation you send out which leads to your friends registering on the site.</li>\n        <li>Converting Invitations to Order — Earn points for every invitation you send out which leads to a sale.</li>\n        <li>Review Submission — Earn points for submitting product reviews.</li>\n        </ul>\n\n        <h2>Reward Points Exchange Rates</h2>\n        <p>The value of reward points is determined by an exchange rate of both currency spent on products to points, and an exchange rate of points earned to currency for spending on future purchases.</p>\n\n        <h2>Redeeming Reward Points</h2>\n        <p>You can redeem your reward points at checkout. If you have accumulated enough points to redeem them you will have the option of using points as one of the payment methods.  The option to use reward points, as well as your balance and the monetary equivalent this balance, will be shown to you in the Payment Method area of the checkout.  Redeemable reward points can be used in conjunction with other payment methods such as credit cards, gift cards and more.</p>\n        <p><img src=\"{{view url=\"Magento_Reward::images/payment.png\"}}\" alt=\"Payment Information\" /></p>\n\n        <h2>Reward Points Minimums and Maximums</h2>\n        <p>Reward points may be capped at a minimum value required for redemption.  If this option is selected you will not be able to use your reward points until you accrue a minimum number of points, at which point they will become available for redemption.</p>\n        <p>Reward points may also be capped at the maximum value of points which can be accrued. If this option is selected you will need to redeem your accrued points before you are able to earn more points.</p>\n\n        <h2>Managing My Reward Points</h2>\n        <p>You have the ability to view and manage your points through your <a href=\"{{store url=\"customer/account\"}}\">Customer Account</a>. From your account you will be able to view your total points (and currency equivalent), minimum needed to redeem, whether you have reached the maximum points limit and a cumulative history of points acquired, redeemed and lost. The history record will retain and display historical rates and currency for informational purposes. The history will also show you comprehensive informational messages regarding points, including expiration notifications.</p>\n        <p><img src=\"{{view url=\"Magento_Reward::images/my_account.png\"}}\" alt=\"My Account\" /></p>\n\n        <h2>Reward Points Expiration</h2>\n        <p>Reward points can be set to expire. Points will expire in the order form which they were first earned.</p>\n        <p><strong>Note</strong>: You can sign up to receive email notifications each time your balance changes when you either earn, redeem or lose points, as well as point expiration notifications. This option is found in the <a href=\"{{store url=\"reward/customer/info\"}}\">Reward Points section</a> of the My Account area.</p>\n        ','2017-02-03 07:50:37','2017-02-03 07:50:37',1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `spg_cms_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cms_page_store`
--

DROP TABLE IF EXISTS `spg_cms_page_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cms_page_store` (
  `row_id` smallint(6) NOT NULL COMMENT 'Version Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`row_id`,`store_id`),
  KEY `SPG_CMS_PAGE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_CMS_PAGE_STORE_ROW_ID_CMS_PAGE_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_cms_page` (`row_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CMS_PAGE_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page To Store Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cms_page_store`
--

LOCK TABLES `spg_cms_page_store` WRITE;
/*!40000 ALTER TABLE `spg_cms_page_store` DISABLE KEYS */;
INSERT INTO `spg_cms_page_store` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0);
/*!40000 ALTER TABLE `spg_cms_page_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_core_config_data`
--

DROP TABLE IF EXISTS `spg_core_config_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_core_config_data` (
  `config_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Config Id',
  `scope` varchar(8) NOT NULL DEFAULT 'default' COMMENT 'Config Scope',
  `scope_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Config Scope Id',
  `path` varchar(255) NOT NULL DEFAULT 'general' COMMENT 'Config Path',
  `value` text COMMENT 'Config Value',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `SPG_CORE_CONFIG_DATA_SCOPE_SCOPE_ID_PATH` (`scope`,`scope_id`,`path`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COMMENT='Config Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_core_config_data`
--

LOCK TABLES `spg_core_config_data` WRITE;
/*!40000 ALTER TABLE `spg_core_config_data` DISABLE KEYS */;
INSERT INTO `spg_core_config_data` VALUES (1,'default',0,'web/seo/use_rewrites','1'),(2,'default',0,'web/unsecure/base_url','http://spg2.dev/'),(3,'default',0,'web/secure/base_url','https://spg2.dev/'),(4,'default',0,'general/locale/code','vi_VN'),(5,'default',0,'web/secure/use_in_frontend',NULL),(6,'default',0,'web/secure/use_in_adminhtml',NULL),(7,'default',0,'general/locale/timezone','Asia/Ho_Chi_Minh'),(8,'default',0,'currency/options/base','VND'),(9,'default',0,'currency/options/default','VND'),(10,'default',0,'currency/options/allow','VND'),(11,'default',0,'general/region/display_all','1'),(12,'default',0,'general/region/state_required','AT,BR,CA,CH,EE,ES,FI,LT,LV,RO,US'),(13,'default',0,'catalog/category/root_id','2'),(15,'default',0,'dev/restrict/allow_ips',NULL),(16,'default',0,'dev/debug/template_hints_storefront','0'),(17,'default',0,'dev/debug/template_hints_admin','0'),(18,'default',0,'dev/debug/template_hints_blocks','0'),(19,'default',0,'dev/template/allow_symlink','0'),(20,'default',0,'dev/translate_inline/active','0'),(21,'default',0,'dev/translate_inline/active_admin','0'),(22,'default',0,'dev/js/merge_files','0'),(23,'default',0,'dev/js/enable_js_bundling','0'),(24,'default',0,'dev/js/minify_files','0'),(25,'default',0,'dev/css/merge_css_files','0'),(26,'default',0,'dev/css/minify_files','0'),(27,'default',0,'dev/static/sign','1'),(28,'stores',1,'design/head/title_prefix',NULL),(29,'stores',1,'design/head/title_suffix',NULL),(30,'stores',1,'design/head/includes',NULL),(31,'stores',1,'design/header/logo_width',NULL),(32,'stores',1,'design/header/logo_height',NULL),(33,'stores',1,'design/footer/absolute_footer',NULL),(34,'stores',1,'design/theme/theme_id','4'),(35,'stores',1,'design/pagination/pagination_frame_skip',NULL),(36,'stores',1,'design/pagination/anchor_text_for_previous',NULL),(37,'stores',1,'design/pagination/anchor_text_for_next',NULL),(38,'stores',1,'design/watermark/image_size',NULL),(39,'stores',1,'design/watermark/image_imageOpacity',NULL),(40,'stores',1,'design/watermark/small_image_size',NULL),(41,'stores',1,'design/watermark/small_image_imageOpacity',NULL),(42,'stores',1,'design/watermark/thumbnail_size',NULL),(43,'stores',1,'design/watermark/thumbnail_imageOpacity',NULL),(44,'stores',1,'design/email/logo_alt',NULL),(45,'stores',1,'design/email/logo_width',NULL),(46,'stores',1,'design/email/logo_height',NULL),(47,'stores',1,'design/watermark/swatch_image_size',NULL),(48,'stores',1,'design/watermark/swatch_image_imageOpacity',NULL),(49,'default',0,'design/head/default_title','Magento Enterprise Edition'),(50,'default',0,'design/head/title_prefix',NULL),(51,'default',0,'design/head/title_suffix',NULL),(52,'default',0,'design/head/default_description','Default Description'),(53,'default',0,'design/head/default_keywords','Magento, Varien, E-commerce'),(54,'default',0,'design/head/includes',NULL),(55,'default',0,'design/head/demonotice','0'),(56,'default',0,'design/header/logo_width',NULL),(57,'default',0,'design/header/logo_height',NULL),(58,'default',0,'design/header/logo_alt','Magento Commerce'),(59,'default',0,'design/header/welcome','Default welcome msg!'),(60,'default',0,'design/footer/copyright','Copyright © 2016 Magento. All rights reserved.'),(61,'default',0,'design/footer/absolute_footer',NULL),(62,'default',0,'design/theme/theme_id','4'),(63,'default',0,'design/pagination/pagination_frame','5'),(64,'default',0,'design/pagination/pagination_frame_skip',NULL),(65,'default',0,'design/pagination/anchor_text_for_previous',NULL),(66,'default',0,'design/pagination/anchor_text_for_next',NULL),(67,'default',0,'design/watermark/image_size',NULL),(68,'default',0,'design/watermark/image_imageOpacity',NULL),(69,'default',0,'design/watermark/image_position','stretch'),(70,'default',0,'design/watermark/small_image_size',NULL),(71,'default',0,'design/watermark/small_image_imageOpacity',NULL),(72,'default',0,'design/watermark/small_image_position','stretch'),(73,'default',0,'design/watermark/thumbnail_size',NULL),(74,'default',0,'design/watermark/thumbnail_imageOpacity',NULL),(75,'default',0,'design/watermark/thumbnail_position','stretch'),(76,'default',0,'design/email/logo_alt',NULL),(77,'default',0,'design/email/logo_width',NULL),(78,'default',0,'design/email/logo_height',NULL),(79,'default',0,'design/email/header_template','design_email_header_template'),(80,'default',0,'design/email/footer_template','design_email_footer_template'),(81,'default',0,'design/watermark/swatch_image_size',NULL),(82,'default',0,'design/watermark/swatch_image_imageOpacity',NULL),(83,'default',0,'design/watermark/swatch_image_position','stretch');
/*!40000 ALTER TABLE `spg_core_config_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_cron_schedule`
--

DROP TABLE IF EXISTS `spg_cron_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_cron_schedule` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Schedule Id',
  `job_code` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Job Code',
  `status` varchar(7) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `messages` text COMMENT 'Messages',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `scheduled_at` timestamp NULL DEFAULT NULL COMMENT 'Scheduled At',
  `executed_at` timestamp NULL DEFAULT NULL COMMENT 'Executed At',
  `finished_at` timestamp NULL DEFAULT NULL COMMENT 'Finished At',
  PRIMARY KEY (`schedule_id`),
  KEY `SPG_CRON_SCHEDULE_JOB_CODE` (`job_code`),
  KEY `SPG_CRON_SCHEDULE_SCHEDULED_AT_STATUS` (`scheduled_at`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron Schedule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_cron_schedule`
--

LOCK TABLES `spg_cron_schedule` WRITE;
/*!40000 ALTER TABLE `spg_cron_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_cron_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_address_entity`
--

DROP TABLE IF EXISTS `spg_customer_address_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_address_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `city` varchar(255) NOT NULL COMMENT 'City',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `country_id` varchar(255) NOT NULL COMMENT 'Country',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `firstname` varchar(255) NOT NULL COMMENT 'First Name',
  `lastname` varchar(255) NOT NULL COMMENT 'Last Name',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middle Name',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Zip/Postal Code',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `region` varchar(255) DEFAULT NULL COMMENT 'State/Province',
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'State/Province',
  `street` text NOT NULL COMMENT 'Street Address',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `telephone` varchar(255) NOT NULL COMMENT 'Phone Number',
  `vat_id` varchar(255) DEFAULT NULL COMMENT 'VAT number',
  `vat_is_valid` int(10) unsigned DEFAULT NULL COMMENT 'VAT number validity',
  `vat_request_date` varchar(255) DEFAULT NULL COMMENT 'VAT number validation request date',
  `vat_request_id` varchar(255) DEFAULT NULL COMMENT 'VAT number validation request ID',
  `vat_request_success` int(10) unsigned DEFAULT NULL COMMENT 'VAT number validation request success',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_CUSTOMER_ADDRESS_ENTITY_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_CUSTOMER_ADDRESS_ENTITY_PARENT_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_address_entity`
--

LOCK TABLES `spg_customer_address_entity` WRITE;
/*!40000 ALTER TABLE `spg_customer_address_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_address_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_address_entity_datetime`
--

DROP TABLE IF EXISTS `spg_customer_address_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_address_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CSTR_ADDR_ENTT_DTIME_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_DTIME_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Datetime';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_address_entity_datetime`
--

LOCK TABLES `spg_customer_address_entity_datetime` WRITE;
/*!40000 ALTER TABLE `spg_customer_address_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_address_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_address_entity_decimal`
--

DROP TABLE IF EXISTS `spg_customer_address_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_address_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_DEC_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Decimal';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_address_entity_decimal`
--

LOCK TABLES `spg_customer_address_entity_decimal` WRITE;
/*!40000 ALTER TABLE `spg_customer_address_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_address_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_address_entity_int`
--

DROP TABLE IF EXISTS `spg_customer_address_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_address_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ADDRESS_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_INT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Int';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_address_entity_int`
--

LOCK TABLES `spg_customer_address_entity_int` WRITE;
/*!40000 ALTER TABLE `spg_customer_address_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_address_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_address_entity_text`
--

DROP TABLE IF EXISTS `spg_customer_address_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_address_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ADDRESS_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_TEXT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Text';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_address_entity_text`
--

LOCK TABLES `spg_customer_address_entity_text` WRITE;
/*!40000 ALTER TABLE `spg_customer_address_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_address_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_address_entity_varchar`
--

DROP TABLE IF EXISTS `spg_customer_address_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_address_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CSTR_ADDR_ENTT_VCHR_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_address_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Varchar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_address_entity_varchar`
--

LOCK TABLES `spg_customer_address_entity_varchar` WRITE;
/*!40000 ALTER TABLE `spg_customer_address_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_address_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_eav_attribute`
--

DROP TABLE IF EXISTS `spg_customer_eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `input_filter` varchar(255) DEFAULT NULL COMMENT 'Input Filter',
  `multiline_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Multiline Count',
  `validate_rules` text COMMENT 'Validate Rules',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `data_model` varchar(255) DEFAULT NULL COMMENT 'Data Model',
  `is_used_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used in Grid',
  `is_visible_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible in Grid',
  `is_filterable_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable in Grid',
  `is_searchable_in_grid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable in Grid',
  `is_used_for_customer_segment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Segment',
  PRIMARY KEY (`attribute_id`),
  CONSTRAINT `SPG_CSTR_EAV_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_eav_attribute`
--

LOCK TABLES `spg_customer_eav_attribute` WRITE;
/*!40000 ALTER TABLE `spg_customer_eav_attribute` DISABLE KEYS */;
INSERT INTO `spg_customer_eav_attribute` VALUES (1,1,NULL,0,NULL,1,10,NULL,1,1,1,0,0),(2,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(3,1,NULL,0,NULL,1,20,NULL,1,1,0,1,0),(4,0,NULL,0,NULL,0,30,NULL,0,0,0,0,0),(5,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,40,NULL,0,0,0,0,1),(6,0,NULL,0,NULL,0,50,NULL,0,0,0,0,0),(7,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,60,NULL,0,0,0,0,1),(8,0,NULL,0,NULL,0,70,NULL,0,0,0,0,0),(9,1,NULL,0,'a:1:{s:16:\"input_validation\";s:5:\"email\";}',1,80,NULL,1,1,1,1,1),(10,1,NULL,0,NULL,1,25,NULL,1,1,1,0,1),(11,0,'date',0,'a:1:{s:16:\"input_validation\";s:4:\"date\";}',0,90,NULL,1,1,1,0,1),(12,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(13,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(14,0,NULL,0,'a:1:{s:16:\"input_validation\";s:4:\"date\";}',1,0,NULL,0,0,0,0,0),(15,0,NULL,0,NULL,1,0,NULL,0,0,0,0,1),(16,0,NULL,0,NULL,1,0,NULL,0,0,0,0,1),(17,0,NULL,0,'a:1:{s:15:\"max_text_length\";i:255;}',0,100,NULL,1,1,0,1,0),(18,0,NULL,0,NULL,1,0,NULL,1,1,1,0,0),(19,0,NULL,0,NULL,0,0,NULL,1,1,1,0,1),(20,0,NULL,0,'a:0:{}',0,110,NULL,1,1,1,0,1),(21,1,NULL,0,NULL,1,28,NULL,0,0,0,0,0),(22,0,NULL,0,NULL,0,10,NULL,0,0,0,0,0),(23,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,20,NULL,1,0,0,1,1),(24,0,NULL,0,NULL,0,30,NULL,0,0,0,0,0),(25,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,40,NULL,1,0,0,1,1),(26,0,NULL,0,NULL,0,50,NULL,0,0,0,0,0),(27,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,60,NULL,1,0,0,1,1),(28,1,NULL,2,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,70,NULL,1,0,0,1,1),(29,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,80,NULL,1,0,0,1,1),(30,1,NULL,0,NULL,1,90,NULL,1,1,1,0,1),(31,1,NULL,0,NULL,1,100,NULL,1,1,0,1,0),(32,1,NULL,0,NULL,1,100,NULL,0,0,0,0,1),(33,1,NULL,0,'a:0:{}',1,110,'Magento\\Customer\\Model\\Attribute\\Data\\Postcode',1,1,1,1,1),(34,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,120,NULL,1,1,1,1,1),(35,0,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',0,130,NULL,1,0,0,1,0),(36,1,NULL,0,NULL,1,140,NULL,0,0,0,0,0),(37,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(38,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(39,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(40,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(41,0,NULL,0,NULL,0,0,NULL,0,0,0,0,0),(42,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(43,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(44,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(155,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0),(156,0,NULL,0,NULL,1,0,NULL,0,0,0,0,0);
/*!40000 ALTER TABLE `spg_customer_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_eav_attribute_website`
--

DROP TABLE IF EXISTS `spg_customer_eav_attribute_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_eav_attribute_website` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `is_visible` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Visible',
  `is_required` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Required',
  `default_value` text COMMENT 'Default Value',
  `multiline_count` smallint(5) unsigned DEFAULT NULL COMMENT 'Multiline Count',
  PRIMARY KEY (`attribute_id`,`website_id`),
  KEY `SPG_CUSTOMER_EAV_ATTRIBUTE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_CSTR_EAV_ATTR_WS_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CSTR_EAV_ATTR_WS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute Website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_eav_attribute_website`
--

LOCK TABLES `spg_customer_eav_attribute_website` WRITE;
/*!40000 ALTER TABLE `spg_customer_eav_attribute_website` DISABLE KEYS */;
INSERT INTO `spg_customer_eav_attribute_website` VALUES (1,1,NULL,NULL,NULL,NULL),(3,1,NULL,NULL,NULL,NULL),(9,1,NULL,NULL,NULL,NULL),(10,1,NULL,NULL,NULL,NULL),(11,1,NULL,NULL,NULL,NULL),(17,1,NULL,NULL,NULL,NULL),(18,1,NULL,NULL,NULL,NULL),(19,1,NULL,NULL,NULL,NULL),(20,1,NULL,NULL,NULL,NULL),(21,1,NULL,NULL,NULL,NULL),(23,1,NULL,NULL,NULL,NULL),(25,1,NULL,NULL,NULL,NULL),(27,1,NULL,NULL,NULL,NULL),(28,1,NULL,NULL,NULL,NULL),(29,1,NULL,NULL,NULL,NULL),(30,1,NULL,NULL,NULL,NULL),(31,1,NULL,NULL,NULL,NULL),(32,1,NULL,NULL,NULL,NULL),(33,1,NULL,NULL,NULL,NULL),(34,1,NULL,NULL,NULL,NULL),(35,1,NULL,NULL,NULL,NULL),(36,1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `spg_customer_eav_attribute_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_entity`
--

DROP TABLE IF EXISTS `spg_customer_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `disable_auto_group_change` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Disable automatic group change based on VAT ID',
  `created_in` varchar(255) DEFAULT NULL COMMENT 'Created From',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'First Name',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middle Name/Initial',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Last Name',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `dob` date DEFAULT NULL COMMENT 'Date of Birth',
  `password_hash` varchar(128) DEFAULT NULL COMMENT 'Password_hash',
  `rp_token` varchar(128) DEFAULT NULL COMMENT 'Reset password token',
  `rp_token_created_at` datetime DEFAULT NULL COMMENT 'Reset password token creation time',
  `default_billing` int(10) unsigned DEFAULT NULL COMMENT 'Default Billing Address',
  `default_shipping` int(10) unsigned DEFAULT NULL COMMENT 'Default Shipping Address',
  `taxvat` varchar(50) DEFAULT NULL COMMENT 'Tax/VAT Number',
  `confirmation` varchar(64) DEFAULT NULL COMMENT 'Is Confirmed',
  `gender` smallint(5) unsigned DEFAULT NULL COMMENT 'Gender',
  `failures_num` smallint(6) DEFAULT '0' COMMENT 'Failure Number',
  `first_failure` timestamp NULL DEFAULT NULL COMMENT 'First Failure',
  `lock_expires` timestamp NULL DEFAULT NULL COMMENT 'Lock Expiration Date',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `SPG_CUSTOMER_ENTITY_STORE_ID` (`store_id`),
  KEY `SPG_CUSTOMER_ENTITY_WEBSITE_ID` (`website_id`),
  KEY `SPG_CUSTOMER_ENTITY_FIRSTNAME` (`firstname`),
  KEY `SPG_CUSTOMER_ENTITY_LASTNAME` (`lastname`),
  KEY `SPG_CUSTOMER_ENTITY_CREATED_AT` (`created_at`),
  KEY `SPG_CUSTOMER_ENTITY_DOB` (`dob`),
  KEY `SPG_CUSTOMER_ENTITY_DEFAULT_BILLING` (`default_billing`),
  KEY `SPG_CUSTOMER_ENTITY_DEFAULT_SHIPPING` (`default_shipping`),
  KEY `SPG_CUSTOMER_ENTITY_GENDER` (`gender`),
  KEY `SPG_CUSTOMER_ENTITY_GROUP_ID` (`group_id`),
  CONSTRAINT `SPG_CUSTOMER_ENTITY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_CUSTOMER_ENTITY_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_entity`
--

LOCK TABLES `spg_customer_entity` WRITE;
/*!40000 ALTER TABLE `spg_customer_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_entity_datetime`
--

DROP TABLE IF EXISTS `spg_customer_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `SPG_CSTR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Datetime';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_entity_datetime`
--

LOCK TABLES `spg_customer_entity_datetime` WRITE;
/*!40000 ALTER TABLE `spg_customer_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_entity_decimal`
--

DROP TABLE IF EXISTS `spg_customer_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `SPG_CSTR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Decimal';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_entity_decimal`
--

LOCK TABLES `spg_customer_entity_decimal` WRITE;
/*!40000 ALTER TABLE `spg_customer_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_entity_int`
--

DROP TABLE IF EXISTS `spg_customer_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `SPG_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CUSTOMER_ENTITY_INT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Int';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_entity_int`
--

LOCK TABLES `spg_customer_entity_int` WRITE;
/*!40000 ALTER TABLE `spg_customer_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_entity_text`
--

DROP TABLE IF EXISTS `spg_customer_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CUSTOMER_ENTITY_TEXT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Text';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_entity_text`
--

LOCK TABLES `spg_customer_entity_text` WRITE;
/*!40000 ALTER TABLE `spg_customer_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_entity_varchar`
--

DROP TABLE IF EXISTS `spg_customer_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_CUSTOMER_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `SPG_CSTR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Varchar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_entity_varchar`
--

LOCK TABLES `spg_customer_entity_varchar` WRITE;
/*!40000 ALTER TABLE `spg_customer_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_form_attribute`
--

DROP TABLE IF EXISTS `spg_customer_form_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_form_attribute` (
  `form_code` varchar(32) NOT NULL COMMENT 'Form Code',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`form_code`,`attribute_id`),
  KEY `SPG_CUSTOMER_FORM_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_CSTR_FORM_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Form Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_form_attribute`
--

LOCK TABLES `spg_customer_form_attribute` WRITE;
/*!40000 ALTER TABLE `spg_customer_form_attribute` DISABLE KEYS */;
INSERT INTO `spg_customer_form_attribute` VALUES ('adminhtml_customer',1),('adminhtml_customer',3),('adminhtml_customer',4),('customer_account_create',4),('customer_account_edit',4),('adminhtml_customer',5),('customer_account_create',5),('customer_account_edit',5),('adminhtml_customer',6),('customer_account_create',6),('customer_account_edit',6),('adminhtml_customer',7),('customer_account_create',7),('customer_account_edit',7),('adminhtml_customer',8),('customer_account_create',8),('customer_account_edit',8),('adminhtml_checkout',9),('adminhtml_customer',9),('customer_account_create',9),('customer_account_edit',9),('adminhtml_checkout',10),('adminhtml_customer',10),('adminhtml_checkout',11),('adminhtml_customer',11),('customer_account_create',11),('customer_account_edit',11),('adminhtml_checkout',17),('adminhtml_customer',17),('customer_account_create',17),('customer_account_edit',17),('adminhtml_customer',19),('customer_account_create',19),('customer_account_edit',19),('adminhtml_checkout',20),('adminhtml_customer',20),('customer_account_create',20),('customer_account_edit',20),('adminhtml_customer',21),('adminhtml_customer_address',22),('customer_address_edit',22),('customer_register_address',22),('adminhtml_customer_address',23),('customer_address_edit',23),('customer_register_address',23),('adminhtml_customer_address',24),('customer_address_edit',24),('customer_register_address',24),('adminhtml_customer_address',25),('customer_address_edit',25),('customer_register_address',25),('adminhtml_customer_address',26),('customer_address_edit',26),('customer_register_address',26),('adminhtml_customer_address',27),('customer_address_edit',27),('customer_register_address',27),('adminhtml_customer_address',28),('customer_address_edit',28),('customer_register_address',28),('adminhtml_customer_address',29),('customer_address_edit',29),('customer_register_address',29),('adminhtml_customer_address',30),('customer_address_edit',30),('customer_register_address',30),('adminhtml_customer_address',31),('customer_address_edit',31),('customer_register_address',31),('adminhtml_customer_address',32),('customer_address_edit',32),('customer_register_address',32),('adminhtml_customer_address',33),('customer_address_edit',33),('customer_register_address',33),('adminhtml_customer_address',34),('customer_address_edit',34),('customer_register_address',34),('adminhtml_customer_address',35),('customer_address_edit',35),('customer_register_address',35),('adminhtml_customer_address',36),('customer_address_edit',36),('customer_register_address',36);
/*!40000 ALTER TABLE `spg_customer_form_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_grid_flat`
--

DROP TABLE IF EXISTS `spg_customer_grid_flat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_grid_flat` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `name` text COMMENT 'Name',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` int(11) DEFAULT NULL COMMENT 'Group_id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created_at',
  `website_id` int(11) DEFAULT NULL COMMENT 'Website_id',
  `confirmation` varchar(255) DEFAULT NULL COMMENT 'Confirmation',
  `created_in` text COMMENT 'Created_in',
  `dob` date DEFAULT NULL COMMENT 'Dob',
  `gender` int(11) DEFAULT NULL COMMENT 'Gender',
  `taxvat` varchar(255) DEFAULT NULL COMMENT 'Taxvat',
  `lock_expires` timestamp NULL DEFAULT NULL COMMENT 'Lock_expires',
  `shipping_full` text COMMENT 'Shipping_full',
  `billing_full` text COMMENT 'Billing_full',
  `billing_firstname` varchar(255) DEFAULT NULL COMMENT 'Billing_firstname',
  `billing_lastname` varchar(255) DEFAULT NULL COMMENT 'Billing_lastname',
  `billing_telephone` varchar(255) DEFAULT NULL COMMENT 'Billing_telephone',
  `billing_postcode` varchar(255) DEFAULT NULL COMMENT 'Billing_postcode',
  `billing_country_id` varchar(255) DEFAULT NULL COMMENT 'Billing_country_id',
  `billing_region` varchar(255) DEFAULT NULL COMMENT 'Billing_region',
  `billing_street` varchar(255) DEFAULT NULL COMMENT 'Billing_street',
  `billing_city` varchar(255) DEFAULT NULL COMMENT 'Billing_city',
  `billing_fax` varchar(255) DEFAULT NULL COMMENT 'Billing_fax',
  `billing_vat_id` varchar(255) DEFAULT NULL COMMENT 'Billing_vat_id',
  `billing_company` varchar(255) DEFAULT NULL COMMENT 'Billing_company',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_CUSTOMER_GRID_FLAT_GROUP_ID` (`group_id`),
  KEY `SPG_CUSTOMER_GRID_FLAT_CREATED_AT` (`created_at`),
  KEY `SPG_CUSTOMER_GRID_FLAT_WEBSITE_ID` (`website_id`),
  KEY `SPG_CUSTOMER_GRID_FLAT_CONFIRMATION` (`confirmation`),
  KEY `SPG_CUSTOMER_GRID_FLAT_DOB` (`dob`),
  KEY `SPG_CUSTOMER_GRID_FLAT_GENDER` (`gender`),
  KEY `SPG_CUSTOMER_GRID_FLAT_BILLING_COUNTRY_ID` (`billing_country_id`),
  FULLTEXT KEY `FTI_C0CB6EBB74402446788608C36B1F0D0A` (`name`,`email`,`created_in`,`taxvat`,`shipping_full`,`billing_full`,`billing_firstname`,`billing_lastname`,`billing_telephone`,`billing_postcode`,`billing_region`,`billing_city`,`billing_fax`,`billing_company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='spg_customer_grid_flat';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_grid_flat`
--

LOCK TABLES `spg_customer_grid_flat` WRITE;
/*!40000 ALTER TABLE `spg_customer_grid_flat` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_grid_flat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_group`
--

DROP TABLE IF EXISTS `spg_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_group` (
  `customer_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Customer Group Id',
  `customer_group_code` varchar(32) NOT NULL COMMENT 'Customer Group Code',
  `tax_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tax Class Id',
  PRIMARY KEY (`customer_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Customer Group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_group`
--

LOCK TABLES `spg_customer_group` WRITE;
/*!40000 ALTER TABLE `spg_customer_group` DISABLE KEYS */;
INSERT INTO `spg_customer_group` VALUES (0,'NOT LOGGED IN',3),(1,'General',3),(2,'Wholesale',3),(3,'Retailer',3);
/*!40000 ALTER TABLE `spg_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_log`
--

DROP TABLE IF EXISTS `spg_customer_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `customer_id` int(11) NOT NULL COMMENT 'Customer ID',
  `last_login_at` timestamp NULL DEFAULT NULL COMMENT 'Last Login Time',
  `last_logout_at` timestamp NULL DEFAULT NULL COMMENT 'Last Logout Time',
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `SPG_CUSTOMER_LOG_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Log Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_log`
--

LOCK TABLES `spg_customer_log` WRITE;
/*!40000 ALTER TABLE `spg_customer_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_customer_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_customer_visitor`
--

DROP TABLE IF EXISTS `spg_customer_visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_customer_visitor` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `session_id` varchar(64) DEFAULT NULL COMMENT 'Session ID',
  `last_visit_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Visit Time',
  PRIMARY KEY (`visitor_id`),
  KEY `SPG_CUSTOMER_VISITOR_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_CUSTOMER_VISITOR_LAST_VISIT_AT` (`last_visit_at`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Visitor Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_customer_visitor`
--

LOCK TABLES `spg_customer_visitor` WRITE;
/*!40000 ALTER TABLE `spg_customer_visitor` DISABLE KEYS */;
INSERT INTO `spg_customer_visitor` VALUES (1,NULL,'hq45bms7kb6m0ltbi99ssogf21','2017-02-03 08:04:18'),(2,NULL,'kvt3evtfatk37cbqfp3v3qh9e7','2017-02-03 08:04:39'),(3,NULL,'bg9dtu6295v2mhom709jja79h2','2017-02-03 09:36:28'),(4,NULL,'2nff0kffvqh3mqddjo01ufh494','2017-02-03 10:35:51'),(5,NULL,'e1pfc2m00puvqdogrvqt9i5f30','2017-02-03 09:36:30'),(6,NULL,'6f210vu6chkdk4fa1hkdl9h2u4','2017-02-03 10:40:09');
/*!40000 ALTER TABLE `spg_customer_visitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_design_change`
--

DROP TABLE IF EXISTS `spg_design_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_design_change` (
  `design_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Design Change Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `design` varchar(255) DEFAULT NULL COMMENT 'Design',
  `date_from` date DEFAULT NULL COMMENT 'First Date of Design Activity',
  `date_to` date DEFAULT NULL COMMENT 'Last Date of Design Activity',
  PRIMARY KEY (`design_change_id`),
  KEY `SPG_DESIGN_CHANGE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_DESIGN_CHANGE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Design Changes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_design_change`
--

LOCK TABLES `spg_design_change` WRITE;
/*!40000 ALTER TABLE `spg_design_change` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_design_change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_design_config_grid_flat`
--

DROP TABLE IF EXISTS `spg_design_config_grid_flat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_design_config_grid_flat` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `store_website_id` int(11) DEFAULT NULL COMMENT 'Store_website_id',
  `store_group_id` int(11) DEFAULT NULL COMMENT 'Store_group_id',
  `store_id` int(11) DEFAULT NULL COMMENT 'Store_id',
  `theme_theme_id` varchar(255) DEFAULT NULL COMMENT 'Theme_theme_id',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_DESIGN_CONFIG_GRID_FLAT_STORE_WEBSITE_ID` (`store_website_id`),
  KEY `SPG_DESIGN_CONFIG_GRID_FLAT_STORE_GROUP_ID` (`store_group_id`),
  KEY `SPG_DESIGN_CONFIG_GRID_FLAT_STORE_ID` (`store_id`),
  FULLTEXT KEY `SPG_DESIGN_CONFIG_GRID_FLAT_THEME_THEME_ID` (`theme_theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='spg_design_config_grid_flat';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_design_config_grid_flat`
--

LOCK TABLES `spg_design_config_grid_flat` WRITE;
/*!40000 ALTER TABLE `spg_design_config_grid_flat` DISABLE KEYS */;
INSERT INTO `spg_design_config_grid_flat` VALUES (0,NULL,NULL,NULL,'4'),(1,1,NULL,NULL,'4'),(2,1,1,1,'4');
/*!40000 ALTER TABLE `spg_design_config_grid_flat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_directory_country`
--

DROP TABLE IF EXISTS `spg_directory_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_directory_country` (
  `country_id` varchar(2) NOT NULL COMMENT 'Country Id in ISO-2',
  `iso2_code` varchar(2) DEFAULT NULL COMMENT 'Country ISO-2 format',
  `iso3_code` varchar(3) DEFAULT NULL COMMENT 'Country ISO-3',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_directory_country`
--

LOCK TABLES `spg_directory_country` WRITE;
/*!40000 ALTER TABLE `spg_directory_country` DISABLE KEYS */;
INSERT INTO `spg_directory_country` VALUES ('AD','AD','AND'),('AE','AE','ARE'),('AF','AF','AFG'),('AG','AG','ATG'),('AI','AI','AIA'),('AL','AL','ALB'),('AM','AM','ARM'),('AN','AN','ANT'),('AO','AO','AGO'),('AQ','AQ','ATA'),('AR','AR','ARG'),('AS','AS','ASM'),('AT','AT','AUT'),('AU','AU','AUS'),('AW','AW','ABW'),('AX','AX','ALA'),('AZ','AZ','AZE'),('BA','BA','BIH'),('BB','BB','BRB'),('BD','BD','BGD'),('BE','BE','BEL'),('BF','BF','BFA'),('BG','BG','BGR'),('BH','BH','BHR'),('BI','BI','BDI'),('BJ','BJ','BEN'),('BL','BL','BLM'),('BM','BM','BMU'),('BN','BN','BRN'),('BO','BO','BOL'),('BR','BR','BRA'),('BS','BS','BHS'),('BT','BT','BTN'),('BV','BV','BVT'),('BW','BW','BWA'),('BY','BY','BLR'),('BZ','BZ','BLZ'),('CA','CA','CAN'),('CC','CC','CCK'),('CD','CD','COD'),('CF','CF','CAF'),('CG','CG','COG'),('CH','CH','CHE'),('CI','CI','CIV'),('CK','CK','COK'),('CL','CL','CHL'),('CM','CM','CMR'),('CN','CN','CHN'),('CO','CO','COL'),('CR','CR','CRI'),('CU','CU','CUB'),('CV','CV','CPV'),('CX','CX','CXR'),('CY','CY','CYP'),('CZ','CZ','CZE'),('DE','DE','DEU'),('DJ','DJ','DJI'),('DK','DK','DNK'),('DM','DM','DMA'),('DO','DO','DOM'),('DZ','DZ','DZA'),('EC','EC','ECU'),('EE','EE','EST'),('EG','EG','EGY'),('EH','EH','ESH'),('ER','ER','ERI'),('ES','ES','ESP'),('ET','ET','ETH'),('FI','FI','FIN'),('FJ','FJ','FJI'),('FK','FK','FLK'),('FM','FM','FSM'),('FO','FO','FRO'),('FR','FR','FRA'),('GA','GA','GAB'),('GB','GB','GBR'),('GD','GD','GRD'),('GE','GE','GEO'),('GF','GF','GUF'),('GG','GG','GGY'),('GH','GH','GHA'),('GI','GI','GIB'),('GL','GL','GRL'),('GM','GM','GMB'),('GN','GN','GIN'),('GP','GP','GLP'),('GQ','GQ','GNQ'),('GR','GR','GRC'),('GS','GS','SGS'),('GT','GT','GTM'),('GU','GU','GUM'),('GW','GW','GNB'),('GY','GY','GUY'),('HK','HK','HKG'),('HM','HM','HMD'),('HN','HN','HND'),('HR','HR','HRV'),('HT','HT','HTI'),('HU','HU','HUN'),('ID','ID','IDN'),('IE','IE','IRL'),('IL','IL','ISR'),('IM','IM','IMN'),('IN','IN','IND'),('IO','IO','IOT'),('IQ','IQ','IRQ'),('IR','IR','IRN'),('IS','IS','ISL'),('IT','IT','ITA'),('JE','JE','JEY'),('JM','JM','JAM'),('JO','JO','JOR'),('JP','JP','JPN'),('KE','KE','KEN'),('KG','KG','KGZ'),('KH','KH','KHM'),('KI','KI','KIR'),('KM','KM','COM'),('KN','KN','KNA'),('KP','KP','PRK'),('KR','KR','KOR'),('KW','KW','KWT'),('KY','KY','CYM'),('KZ','KZ','KAZ'),('LA','LA','LAO'),('LB','LB','LBN'),('LC','LC','LCA'),('LI','LI','LIE'),('LK','LK','LKA'),('LR','LR','LBR'),('LS','LS','LSO'),('LT','LT','LTU'),('LU','LU','LUX'),('LV','LV','LVA'),('LY','LY','LBY'),('MA','MA','MAR'),('MC','MC','MCO'),('MD','MD','MDA'),('ME','ME','MNE'),('MF','MF','MAF'),('MG','MG','MDG'),('MH','MH','MHL'),('MK','MK','MKD'),('ML','ML','MLI'),('MM','MM','MMR'),('MN','MN','MNG'),('MO','MO','MAC'),('MP','MP','MNP'),('MQ','MQ','MTQ'),('MR','MR','MRT'),('MS','MS','MSR'),('MT','MT','MLT'),('MU','MU','MUS'),('MV','MV','MDV'),('MW','MW','MWI'),('MX','MX','MEX'),('MY','MY','MYS'),('MZ','MZ','MOZ'),('NA','NA','NAM'),('NC','NC','NCL'),('NE','NE','NER'),('NF','NF','NFK'),('NG','NG','NGA'),('NI','NI','NIC'),('NL','NL','NLD'),('NO','NO','NOR'),('NP','NP','NPL'),('NR','NR','NRU'),('NU','NU','NIU'),('NZ','NZ','NZL'),('OM','OM','OMN'),('PA','PA','PAN'),('PE','PE','PER'),('PF','PF','PYF'),('PG','PG','PNG'),('PH','PH','PHL'),('PK','PK','PAK'),('PL','PL','POL'),('PM','PM','SPM'),('PN','PN','PCN'),('PS','PS','PSE'),('PT','PT','PRT'),('PW','PW','PLW'),('PY','PY','PRY'),('QA','QA','QAT'),('RE','RE','REU'),('RO','RO','ROU'),('RS','RS','SRB'),('RU','RU','RUS'),('RW','RW','RWA'),('SA','SA','SAU'),('SB','SB','SLB'),('SC','SC','SYC'),('SD','SD','SDN'),('SE','SE','SWE'),('SG','SG','SGP'),('SH','SH','SHN'),('SI','SI','SVN'),('SJ','SJ','SJM'),('SK','SK','SVK'),('SL','SL','SLE'),('SM','SM','SMR'),('SN','SN','SEN'),('SO','SO','SOM'),('SR','SR','SUR'),('ST','ST','STP'),('SV','SV','SLV'),('SY','SY','SYR'),('SZ','SZ','SWZ'),('TC','TC','TCA'),('TD','TD','TCD'),('TF','TF','ATF'),('TG','TG','TGO'),('TH','TH','THA'),('TJ','TJ','TJK'),('TK','TK','TKL'),('TL','TL','TLS'),('TM','TM','TKM'),('TN','TN','TUN'),('TO','TO','TON'),('TR','TR','TUR'),('TT','TT','TTO'),('TV','TV','TUV'),('TW','TW','TWN'),('TZ','TZ','TZA'),('UA','UA','UKR'),('UG','UG','UGA'),('UM','UM','UMI'),('US','US','USA'),('UY','UY','URY'),('UZ','UZ','UZB'),('VA','VA','VAT'),('VC','VC','VCT'),('VE','VE','VEN'),('VG','VG','VGB'),('VI','VI','VIR'),('VN','VN','VNM'),('VU','VU','VUT'),('WF','WF','WLF'),('WS','WS','WSM'),('YE','YE','YEM'),('YT','YT','MYT'),('ZA','ZA','ZAF'),('ZM','ZM','ZMB'),('ZW','ZW','ZWE');
/*!40000 ALTER TABLE `spg_directory_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_directory_country_format`
--

DROP TABLE IF EXISTS `spg_directory_country_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_directory_country_format` (
  `country_format_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Format Id',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id in ISO-2',
  `type` varchar(30) DEFAULT NULL COMMENT 'Country Format Type',
  `format` text NOT NULL COMMENT 'Country Format',
  PRIMARY KEY (`country_format_id`),
  UNIQUE KEY `SPG_DIRECTORY_COUNTRY_FORMAT_COUNTRY_ID_TYPE` (`country_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Format';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_directory_country_format`
--

LOCK TABLES `spg_directory_country_format` WRITE;
/*!40000 ALTER TABLE `spg_directory_country_format` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_directory_country_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_directory_country_region`
--

DROP TABLE IF EXISTS `spg_directory_country_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_directory_country_region` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Region Id',
  `country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Country Id in ISO-2',
  `code` varchar(32) DEFAULT NULL COMMENT 'Region code',
  `default_name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`region_id`),
  KEY `SPG_DIRECTORY_COUNTRY_REGION_COUNTRY_ID` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8 COMMENT='Directory Country Region';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_directory_country_region`
--

LOCK TABLES `spg_directory_country_region` WRITE;
/*!40000 ALTER TABLE `spg_directory_country_region` DISABLE KEYS */;
INSERT INTO `spg_directory_country_region` VALUES (1,'US','AL','Alabama'),(2,'US','AK','Alaska'),(3,'US','AS','American Samoa'),(4,'US','AZ','Arizona'),(5,'US','AR','Arkansas'),(6,'US','AE','Armed Forces Africa'),(7,'US','AA','Armed Forces Americas'),(8,'US','AE','Armed Forces Canada'),(9,'US','AE','Armed Forces Europe'),(10,'US','AE','Armed Forces Middle East'),(11,'US','AP','Armed Forces Pacific'),(12,'US','CA','California'),(13,'US','CO','Colorado'),(14,'US','CT','Connecticut'),(15,'US','DE','Delaware'),(16,'US','DC','District of Columbia'),(17,'US','FM','Federated States Of Micronesia'),(18,'US','FL','Florida'),(19,'US','GA','Georgia'),(20,'US','GU','Guam'),(21,'US','HI','Hawaii'),(22,'US','ID','Idaho'),(23,'US','IL','Illinois'),(24,'US','IN','Indiana'),(25,'US','IA','Iowa'),(26,'US','KS','Kansas'),(27,'US','KY','Kentucky'),(28,'US','LA','Louisiana'),(29,'US','ME','Maine'),(30,'US','MH','Marshall Islands'),(31,'US','MD','Maryland'),(32,'US','MA','Massachusetts'),(33,'US','MI','Michigan'),(34,'US','MN','Minnesota'),(35,'US','MS','Mississippi'),(36,'US','MO','Missouri'),(37,'US','MT','Montana'),(38,'US','NE','Nebraska'),(39,'US','NV','Nevada'),(40,'US','NH','New Hampshire'),(41,'US','NJ','New Jersey'),(42,'US','NM','New Mexico'),(43,'US','NY','New York'),(44,'US','NC','North Carolina'),(45,'US','ND','North Dakota'),(46,'US','MP','Northern Mariana Islands'),(47,'US','OH','Ohio'),(48,'US','OK','Oklahoma'),(49,'US','OR','Oregon'),(50,'US','PW','Palau'),(51,'US','PA','Pennsylvania'),(52,'US','PR','Puerto Rico'),(53,'US','RI','Rhode Island'),(54,'US','SC','South Carolina'),(55,'US','SD','South Dakota'),(56,'US','TN','Tennessee'),(57,'US','TX','Texas'),(58,'US','UT','Utah'),(59,'US','VT','Vermont'),(60,'US','VI','Virgin Islands'),(61,'US','VA','Virginia'),(62,'US','WA','Washington'),(63,'US','WV','West Virginia'),(64,'US','WI','Wisconsin'),(65,'US','WY','Wyoming'),(66,'CA','AB','Alberta'),(67,'CA','BC','British Columbia'),(68,'CA','MB','Manitoba'),(69,'CA','NL','Newfoundland and Labrador'),(70,'CA','NB','New Brunswick'),(71,'CA','NS','Nova Scotia'),(72,'CA','NT','Northwest Territories'),(73,'CA','NU','Nunavut'),(74,'CA','ON','Ontario'),(75,'CA','PE','Prince Edward Island'),(76,'CA','QC','Quebec'),(77,'CA','SK','Saskatchewan'),(78,'CA','YT','Yukon Territory'),(79,'DE','NDS','Niedersachsen'),(80,'DE','BAW','Baden-Württemberg'),(81,'DE','BAY','Bayern'),(82,'DE','BER','Berlin'),(83,'DE','BRG','Brandenburg'),(84,'DE','BRE','Bremen'),(85,'DE','HAM','Hamburg'),(86,'DE','HES','Hessen'),(87,'DE','MEC','Mecklenburg-Vorpommern'),(88,'DE','NRW','Nordrhein-Westfalen'),(89,'DE','RHE','Rheinland-Pfalz'),(90,'DE','SAR','Saarland'),(91,'DE','SAS','Sachsen'),(92,'DE','SAC','Sachsen-Anhalt'),(93,'DE','SCN','Schleswig-Holstein'),(94,'DE','THE','Thüringen'),(95,'AT','WI','Wien'),(96,'AT','NO','Niederösterreich'),(97,'AT','OO','Oberösterreich'),(98,'AT','SB','Salzburg'),(99,'AT','KN','Kärnten'),(100,'AT','ST','Steiermark'),(101,'AT','TI','Tirol'),(102,'AT','BL','Burgenland'),(103,'AT','VB','Vorarlberg'),(104,'CH','AG','Aargau'),(105,'CH','AI','Appenzell Innerrhoden'),(106,'CH','AR','Appenzell Ausserrhoden'),(107,'CH','BE','Bern'),(108,'CH','BL','Basel-Landschaft'),(109,'CH','BS','Basel-Stadt'),(110,'CH','FR','Freiburg'),(111,'CH','GE','Genf'),(112,'CH','GL','Glarus'),(113,'CH','GR','Graubünden'),(114,'CH','JU','Jura'),(115,'CH','LU','Luzern'),(116,'CH','NE','Neuenburg'),(117,'CH','NW','Nidwalden'),(118,'CH','OW','Obwalden'),(119,'CH','SG','St. Gallen'),(120,'CH','SH','Schaffhausen'),(121,'CH','SO','Solothurn'),(122,'CH','SZ','Schwyz'),(123,'CH','TG','Thurgau'),(124,'CH','TI','Tessin'),(125,'CH','UR','Uri'),(126,'CH','VD','Waadt'),(127,'CH','VS','Wallis'),(128,'CH','ZG','Zug'),(129,'CH','ZH','Zürich'),(130,'ES','A Coruсa','A Coruña'),(131,'ES','Alava','Alava'),(132,'ES','Albacete','Albacete'),(133,'ES','Alicante','Alicante'),(134,'ES','Almeria','Almeria'),(135,'ES','Asturias','Asturias'),(136,'ES','Avila','Avila'),(137,'ES','Badajoz','Badajoz'),(138,'ES','Baleares','Baleares'),(139,'ES','Barcelona','Barcelona'),(140,'ES','Burgos','Burgos'),(141,'ES','Caceres','Caceres'),(142,'ES','Cadiz','Cadiz'),(143,'ES','Cantabria','Cantabria'),(144,'ES','Castellon','Castellon'),(145,'ES','Ceuta','Ceuta'),(146,'ES','Ciudad Real','Ciudad Real'),(147,'ES','Cordoba','Cordoba'),(148,'ES','Cuenca','Cuenca'),(149,'ES','Girona','Girona'),(150,'ES','Granada','Granada'),(151,'ES','Guadalajara','Guadalajara'),(152,'ES','Guipuzcoa','Guipuzcoa'),(153,'ES','Huelva','Huelva'),(154,'ES','Huesca','Huesca'),(155,'ES','Jaen','Jaen'),(156,'ES','La Rioja','La Rioja'),(157,'ES','Las Palmas','Las Palmas'),(158,'ES','Leon','Leon'),(159,'ES','Lleida','Lleida'),(160,'ES','Lugo','Lugo'),(161,'ES','Madrid','Madrid'),(162,'ES','Malaga','Malaga'),(163,'ES','Melilla','Melilla'),(164,'ES','Murcia','Murcia'),(165,'ES','Navarra','Navarra'),(166,'ES','Ourense','Ourense'),(167,'ES','Palencia','Palencia'),(168,'ES','Pontevedra','Pontevedra'),(169,'ES','Salamanca','Salamanca'),(170,'ES','Santa Cruz de Tenerife','Santa Cruz de Tenerife'),(171,'ES','Segovia','Segovia'),(172,'ES','Sevilla','Sevilla'),(173,'ES','Soria','Soria'),(174,'ES','Tarragona','Tarragona'),(175,'ES','Teruel','Teruel'),(176,'ES','Toledo','Toledo'),(177,'ES','Valencia','Valencia'),(178,'ES','Valladolid','Valladolid'),(179,'ES','Vizcaya','Vizcaya'),(180,'ES','Zamora','Zamora'),(181,'ES','Zaragoza','Zaragoza'),(182,'FR','1','Ain'),(183,'FR','2','Aisne'),(184,'FR','3','Allier'),(185,'FR','4','Alpes-de-Haute-Provence'),(186,'FR','5','Hautes-Alpes'),(187,'FR','6','Alpes-Maritimes'),(188,'FR','7','Ardèche'),(189,'FR','8','Ardennes'),(190,'FR','9','Ariège'),(191,'FR','10','Aube'),(192,'FR','11','Aude'),(193,'FR','12','Aveyron'),(194,'FR','13','Bouches-du-Rhône'),(195,'FR','14','Calvados'),(196,'FR','15','Cantal'),(197,'FR','16','Charente'),(198,'FR','17','Charente-Maritime'),(199,'FR','18','Cher'),(200,'FR','19','Corrèze'),(201,'FR','2A','Corse-du-Sud'),(202,'FR','2B','Haute-Corse'),(203,'FR','21','Côte-d\'Or'),(204,'FR','22','Côtes-d\'Armor'),(205,'FR','23','Creuse'),(206,'FR','24','Dordogne'),(207,'FR','25','Doubs'),(208,'FR','26','Drôme'),(209,'FR','27','Eure'),(210,'FR','28','Eure-et-Loir'),(211,'FR','29','Finistère'),(212,'FR','30','Gard'),(213,'FR','31','Haute-Garonne'),(214,'FR','32','Gers'),(215,'FR','33','Gironde'),(216,'FR','34','Hérault'),(217,'FR','35','Ille-et-Vilaine'),(218,'FR','36','Indre'),(219,'FR','37','Indre-et-Loire'),(220,'FR','38','Isère'),(221,'FR','39','Jura'),(222,'FR','40','Landes'),(223,'FR','41','Loir-et-Cher'),(224,'FR','42','Loire'),(225,'FR','43','Haute-Loire'),(226,'FR','44','Loire-Atlantique'),(227,'FR','45','Loiret'),(228,'FR','46','Lot'),(229,'FR','47','Lot-et-Garonne'),(230,'FR','48','Lozère'),(231,'FR','49','Maine-et-Loire'),(232,'FR','50','Manche'),(233,'FR','51','Marne'),(234,'FR','52','Haute-Marne'),(235,'FR','53','Mayenne'),(236,'FR','54','Meurthe-et-Moselle'),(237,'FR','55','Meuse'),(238,'FR','56','Morbihan'),(239,'FR','57','Moselle'),(240,'FR','58','Nièvre'),(241,'FR','59','Nord'),(242,'FR','60','Oise'),(243,'FR','61','Orne'),(244,'FR','62','Pas-de-Calais'),(245,'FR','63','Puy-de-Dôme'),(246,'FR','64','Pyrénées-Atlantiques'),(247,'FR','65','Hautes-Pyrénées'),(248,'FR','66','Pyrénées-Orientales'),(249,'FR','67','Bas-Rhin'),(250,'FR','68','Haut-Rhin'),(251,'FR','69','Rhône'),(252,'FR','70','Haute-Saône'),(253,'FR','71','Saône-et-Loire'),(254,'FR','72','Sarthe'),(255,'FR','73','Savoie'),(256,'FR','74','Haute-Savoie'),(257,'FR','75','Paris'),(258,'FR','76','Seine-Maritime'),(259,'FR','77','Seine-et-Marne'),(260,'FR','78','Yvelines'),(261,'FR','79','Deux-Sèvres'),(262,'FR','80','Somme'),(263,'FR','81','Tarn'),(264,'FR','82','Tarn-et-Garonne'),(265,'FR','83','Var'),(266,'FR','84','Vaucluse'),(267,'FR','85','Vendée'),(268,'FR','86','Vienne'),(269,'FR','87','Haute-Vienne'),(270,'FR','88','Vosges'),(271,'FR','89','Yonne'),(272,'FR','90','Territoire-de-Belfort'),(273,'FR','91','Essonne'),(274,'FR','92','Hauts-de-Seine'),(275,'FR','93','Seine-Saint-Denis'),(276,'FR','94','Val-de-Marne'),(277,'FR','95','Val-d\'Oise'),(278,'RO','AB','Alba'),(279,'RO','AR','Arad'),(280,'RO','AG','Argeş'),(281,'RO','BC','Bacău'),(282,'RO','BH','Bihor'),(283,'RO','BN','Bistriţa-Năsăud'),(284,'RO','BT','Botoşani'),(285,'RO','BV','Braşov'),(286,'RO','BR','Brăila'),(287,'RO','B','Bucureşti'),(288,'RO','BZ','Buzău'),(289,'RO','CS','Caraş-Severin'),(290,'RO','CL','Călăraşi'),(291,'RO','CJ','Cluj'),(292,'RO','CT','Constanţa'),(293,'RO','CV','Covasna'),(294,'RO','DB','Dâmboviţa'),(295,'RO','DJ','Dolj'),(296,'RO','GL','Galaţi'),(297,'RO','GR','Giurgiu'),(298,'RO','GJ','Gorj'),(299,'RO','HR','Harghita'),(300,'RO','HD','Hunedoara'),(301,'RO','IL','Ialomiţa'),(302,'RO','IS','Iaşi'),(303,'RO','IF','Ilfov'),(304,'RO','MM','Maramureş'),(305,'RO','MH','Mehedinţi'),(306,'RO','MS','Mureş'),(307,'RO','NT','Neamţ'),(308,'RO','OT','Olt'),(309,'RO','PH','Prahova'),(310,'RO','SM','Satu-Mare'),(311,'RO','SJ','Sălaj'),(312,'RO','SB','Sibiu'),(313,'RO','SV','Suceava'),(314,'RO','TR','Teleorman'),(315,'RO','TM','Timiş'),(316,'RO','TL','Tulcea'),(317,'RO','VS','Vaslui'),(318,'RO','VL','Vâlcea'),(319,'RO','VN','Vrancea'),(320,'FI','Lappi','Lappi'),(321,'FI','Pohjois-Pohjanmaa','Pohjois-Pohjanmaa'),(322,'FI','Kainuu','Kainuu'),(323,'FI','Pohjois-Karjala','Pohjois-Karjala'),(324,'FI','Pohjois-Savo','Pohjois-Savo'),(325,'FI','Etelä-Savo','Etelä-Savo'),(326,'FI','Etelä-Pohjanmaa','Etelä-Pohjanmaa'),(327,'FI','Pohjanmaa','Pohjanmaa'),(328,'FI','Pirkanmaa','Pirkanmaa'),(329,'FI','Satakunta','Satakunta'),(330,'FI','Keski-Pohjanmaa','Keski-Pohjanmaa'),(331,'FI','Keski-Suomi','Keski-Suomi'),(332,'FI','Varsinais-Suomi','Varsinais-Suomi'),(333,'FI','Etelä-Karjala','Etelä-Karjala'),(334,'FI','Päijät-Häme','Päijät-Häme'),(335,'FI','Kanta-Häme','Kanta-Häme'),(336,'FI','Uusimaa','Uusimaa'),(337,'FI','Itä-Uusimaa','Itä-Uusimaa'),(338,'FI','Kymenlaakso','Kymenlaakso'),(339,'FI','Ahvenanmaa','Ahvenanmaa'),(340,'EE','EE-37','Harjumaa'),(341,'EE','EE-39','Hiiumaa'),(342,'EE','EE-44','Ida-Virumaa'),(343,'EE','EE-49','Jõgevamaa'),(344,'EE','EE-51','Järvamaa'),(345,'EE','EE-57','Läänemaa'),(346,'EE','EE-59','Lääne-Virumaa'),(347,'EE','EE-65','Põlvamaa'),(348,'EE','EE-67','Pärnumaa'),(349,'EE','EE-70','Raplamaa'),(350,'EE','EE-74','Saaremaa'),(351,'EE','EE-78','Tartumaa'),(352,'EE','EE-82','Valgamaa'),(353,'EE','EE-84','Viljandimaa'),(354,'EE','EE-86','Võrumaa'),(355,'LV','LV-DGV','Daugavpils'),(356,'LV','LV-JEL','Jelgava'),(357,'LV','Jēkabpils','Jēkabpils'),(358,'LV','LV-JUR','Jūrmala'),(359,'LV','LV-LPX','Liepāja'),(360,'LV','LV-LE','Liepājas novads'),(361,'LV','LV-REZ','Rēzekne'),(362,'LV','LV-RIX','Rīga'),(363,'LV','LV-RI','Rīgas novads'),(364,'LV','Valmiera','Valmiera'),(365,'LV','LV-VEN','Ventspils'),(366,'LV','Aglonas novads','Aglonas novads'),(367,'LV','LV-AI','Aizkraukles novads'),(368,'LV','Aizputes novads','Aizputes novads'),(369,'LV','Aknīstes novads','Aknīstes novads'),(370,'LV','Alojas novads','Alojas novads'),(371,'LV','Alsungas novads','Alsungas novads'),(372,'LV','LV-AL','Alūksnes novads'),(373,'LV','Amatas novads','Amatas novads'),(374,'LV','Apes novads','Apes novads'),(375,'LV','Auces novads','Auces novads'),(376,'LV','Babītes novads','Babītes novads'),(377,'LV','Baldones novads','Baldones novads'),(378,'LV','Baltinavas novads','Baltinavas novads'),(379,'LV','LV-BL','Balvu novads'),(380,'LV','LV-BU','Bauskas novads'),(381,'LV','Beverīnas novads','Beverīnas novads'),(382,'LV','Brocēnu novads','Brocēnu novads'),(383,'LV','Burtnieku novads','Burtnieku novads'),(384,'LV','Carnikavas novads','Carnikavas novads'),(385,'LV','Cesvaines novads','Cesvaines novads'),(386,'LV','Ciblas novads','Ciblas novads'),(387,'LV','LV-CE','Cēsu novads'),(388,'LV','Dagdas novads','Dagdas novads'),(389,'LV','LV-DA','Daugavpils novads'),(390,'LV','LV-DO','Dobeles novads'),(391,'LV','Dundagas novads','Dundagas novads'),(392,'LV','Durbes novads','Durbes novads'),(393,'LV','Engures novads','Engures novads'),(394,'LV','Garkalnes novads','Garkalnes novads'),(395,'LV','Grobiņas novads','Grobiņas novads'),(396,'LV','LV-GU','Gulbenes novads'),(397,'LV','Iecavas novads','Iecavas novads'),(398,'LV','Ikšķiles novads','Ikšķiles novads'),(399,'LV','Ilūkstes novads','Ilūkstes novads'),(400,'LV','Inčukalna novads','Inčukalna novads'),(401,'LV','Jaunjelgavas novads','Jaunjelgavas novads'),(402,'LV','Jaunpiebalgas novads','Jaunpiebalgas novads'),(403,'LV','Jaunpils novads','Jaunpils novads'),(404,'LV','LV-JL','Jelgavas novads'),(405,'LV','LV-JK','Jēkabpils novads'),(406,'LV','Kandavas novads','Kandavas novads'),(407,'LV','Kokneses novads','Kokneses novads'),(408,'LV','Krimuldas novads','Krimuldas novads'),(409,'LV','Krustpils novads','Krustpils novads'),(410,'LV','LV-KR','Krāslavas novads'),(411,'LV','LV-KU','Kuldīgas novads'),(412,'LV','Kārsavas novads','Kārsavas novads'),(413,'LV','Lielvārdes novads','Lielvārdes novads'),(414,'LV','LV-LM','Limbažu novads'),(415,'LV','Lubānas novads','Lubānas novads'),(416,'LV','LV-LU','Ludzas novads'),(417,'LV','Līgatnes novads','Līgatnes novads'),(418,'LV','Līvānu novads','Līvānu novads'),(419,'LV','LV-MA','Madonas novads'),(420,'LV','Mazsalacas novads','Mazsalacas novads'),(421,'LV','Mālpils novads','Mālpils novads'),(422,'LV','Mārupes novads','Mārupes novads'),(423,'LV','Naukšēnu novads','Naukšēnu novads'),(424,'LV','Neretas novads','Neretas novads'),(425,'LV','Nīcas novads','Nīcas novads'),(426,'LV','LV-OG','Ogres novads'),(427,'LV','Olaines novads','Olaines novads'),(428,'LV','Ozolnieku novads','Ozolnieku novads'),(429,'LV','LV-PR','Preiļu novads'),(430,'LV','Priekules novads','Priekules novads'),(431,'LV','Priekuļu novads','Priekuļu novads'),(432,'LV','Pārgaujas novads','Pārgaujas novads'),(433,'LV','Pāvilostas novads','Pāvilostas novads'),(434,'LV','Pļaviņu novads','Pļaviņu novads'),(435,'LV','Raunas novads','Raunas novads'),(436,'LV','Riebiņu novads','Riebiņu novads'),(437,'LV','Rojas novads','Rojas novads'),(438,'LV','Ropažu novads','Ropažu novads'),(439,'LV','Rucavas novads','Rucavas novads'),(440,'LV','Rugāju novads','Rugāju novads'),(441,'LV','Rundāles novads','Rundāles novads'),(442,'LV','LV-RE','Rēzeknes novads'),(443,'LV','Rūjienas novads','Rūjienas novads'),(444,'LV','Salacgrīvas novads','Salacgrīvas novads'),(445,'LV','Salas novads','Salas novads'),(446,'LV','Salaspils novads','Salaspils novads'),(447,'LV','LV-SA','Saldus novads'),(448,'LV','Saulkrastu novads','Saulkrastu novads'),(449,'LV','Siguldas novads','Siguldas novads'),(450,'LV','Skrundas novads','Skrundas novads'),(451,'LV','Skrīveru novads','Skrīveru novads'),(452,'LV','Smiltenes novads','Smiltenes novads'),(453,'LV','Stopiņu novads','Stopiņu novads'),(454,'LV','Strenču novads','Strenču novads'),(455,'LV','Sējas novads','Sējas novads'),(456,'LV','LV-TA','Talsu novads'),(457,'LV','LV-TU','Tukuma novads'),(458,'LV','Tērvetes novads','Tērvetes novads'),(459,'LV','Vaiņodes novads','Vaiņodes novads'),(460,'LV','LV-VK','Valkas novads'),(461,'LV','LV-VM','Valmieras novads'),(462,'LV','Varakļānu novads','Varakļānu novads'),(463,'LV','Vecpiebalgas novads','Vecpiebalgas novads'),(464,'LV','Vecumnieku novads','Vecumnieku novads'),(465,'LV','LV-VE','Ventspils novads'),(466,'LV','Viesītes novads','Viesītes novads'),(467,'LV','Viļakas novads','Viļakas novads'),(468,'LV','Viļānu novads','Viļānu novads'),(469,'LV','Vārkavas novads','Vārkavas novads'),(470,'LV','Zilupes novads','Zilupes novads'),(471,'LV','Ādažu novads','Ādažu novads'),(472,'LV','Ērgļu novads','Ērgļu novads'),(473,'LV','Ķeguma novads','Ķeguma novads'),(474,'LV','Ķekavas novads','Ķekavas novads'),(475,'LT','LT-AL','Alytaus Apskritis'),(476,'LT','LT-KU','Kauno Apskritis'),(477,'LT','LT-KL','Klaipėdos Apskritis'),(478,'LT','LT-MR','Marijampolės Apskritis'),(479,'LT','LT-PN','Panevėžio Apskritis'),(480,'LT','LT-SA','Šiaulių Apskritis'),(481,'LT','LT-TA','Tauragės Apskritis'),(482,'LT','LT-TE','Telšių Apskritis'),(483,'LT','LT-UT','Utenos Apskritis'),(484,'LT','LT-VL','Vilniaus Apskritis'),(485,'BR','AC','Acre'),(486,'BR','AL','Alagoas'),(487,'BR','AP','Amapá'),(488,'BR','AM','Amazonas'),(489,'BR','BA','Bahia'),(490,'BR','CE','Ceará'),(491,'BR','ES','Espírito Santo'),(492,'BR','GO','Goiás'),(493,'BR','MA','Maranhão'),(494,'BR','MT','Mato Grosso'),(495,'BR','MS','Mato Grosso do Sul'),(496,'BR','MG','Minas Gerais'),(497,'BR','PA','Pará'),(498,'BR','PB','Paraíba'),(499,'BR','PR','Paraná'),(500,'BR','PE','Pernambuco'),(501,'BR','PI','Piauí'),(502,'BR','RJ','Rio de Janeiro'),(503,'BR','RN','Rio Grande do Norte'),(504,'BR','RS','Rio Grande do Sul'),(505,'BR','RO','Rondônia'),(506,'BR','RR','Roraima'),(507,'BR','SC','Santa Catarina'),(508,'BR','SP','São Paulo'),(509,'BR','SE','Sergipe'),(510,'BR','TO','Tocantins'),(511,'BR','DF','Distrito Federal');
/*!40000 ALTER TABLE `spg_directory_country_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_directory_country_region_name`
--

DROP TABLE IF EXISTS `spg_directory_country_region_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_directory_country_region_name` (
  `locale` varchar(8) NOT NULL COMMENT 'Locale',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Region Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`locale`,`region_id`),
  KEY `SPG_DIRECTORY_COUNTRY_REGION_NAME_REGION_ID` (`region_id`),
  CONSTRAINT `FK_9F2BEC805CBB30EECFEC9550D44197CA` FOREIGN KEY (`region_id`) REFERENCES `spg_directory_country_region` (`region_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region Name';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_directory_country_region_name`
--

LOCK TABLES `spg_directory_country_region_name` WRITE;
/*!40000 ALTER TABLE `spg_directory_country_region_name` DISABLE KEYS */;
INSERT INTO `spg_directory_country_region_name` VALUES ('en_US',1,'Alabama'),('en_US',2,'Alaska'),('en_US',3,'American Samoa'),('en_US',4,'Arizona'),('en_US',5,'Arkansas'),('en_US',6,'Armed Forces Africa'),('en_US',7,'Armed Forces Americas'),('en_US',8,'Armed Forces Canada'),('en_US',9,'Armed Forces Europe'),('en_US',10,'Armed Forces Middle East'),('en_US',11,'Armed Forces Pacific'),('en_US',12,'California'),('en_US',13,'Colorado'),('en_US',14,'Connecticut'),('en_US',15,'Delaware'),('en_US',16,'District of Columbia'),('en_US',17,'Federated States Of Micronesia'),('en_US',18,'Florida'),('en_US',19,'Georgia'),('en_US',20,'Guam'),('en_US',21,'Hawaii'),('en_US',22,'Idaho'),('en_US',23,'Illinois'),('en_US',24,'Indiana'),('en_US',25,'Iowa'),('en_US',26,'Kansas'),('en_US',27,'Kentucky'),('en_US',28,'Louisiana'),('en_US',29,'Maine'),('en_US',30,'Marshall Islands'),('en_US',31,'Maryland'),('en_US',32,'Massachusetts'),('en_US',33,'Michigan'),('en_US',34,'Minnesota'),('en_US',35,'Mississippi'),('en_US',36,'Missouri'),('en_US',37,'Montana'),('en_US',38,'Nebraska'),('en_US',39,'Nevada'),('en_US',40,'New Hampshire'),('en_US',41,'New Jersey'),('en_US',42,'New Mexico'),('en_US',43,'New York'),('en_US',44,'North Carolina'),('en_US',45,'North Dakota'),('en_US',46,'Northern Mariana Islands'),('en_US',47,'Ohio'),('en_US',48,'Oklahoma'),('en_US',49,'Oregon'),('en_US',50,'Palau'),('en_US',51,'Pennsylvania'),('en_US',52,'Puerto Rico'),('en_US',53,'Rhode Island'),('en_US',54,'South Carolina'),('en_US',55,'South Dakota'),('en_US',56,'Tennessee'),('en_US',57,'Texas'),('en_US',58,'Utah'),('en_US',59,'Vermont'),('en_US',60,'Virgin Islands'),('en_US',61,'Virginia'),('en_US',62,'Washington'),('en_US',63,'West Virginia'),('en_US',64,'Wisconsin'),('en_US',65,'Wyoming'),('en_US',66,'Alberta'),('en_US',67,'British Columbia'),('en_US',68,'Manitoba'),('en_US',69,'Newfoundland and Labrador'),('en_US',70,'New Brunswick'),('en_US',71,'Nova Scotia'),('en_US',72,'Northwest Territories'),('en_US',73,'Nunavut'),('en_US',74,'Ontario'),('en_US',75,'Prince Edward Island'),('en_US',76,'Quebec'),('en_US',77,'Saskatchewan'),('en_US',78,'Yukon Territory'),('en_US',79,'Niedersachsen'),('en_US',80,'Baden-Württemberg'),('en_US',81,'Bayern'),('en_US',82,'Berlin'),('en_US',83,'Brandenburg'),('en_US',84,'Bremen'),('en_US',85,'Hamburg'),('en_US',86,'Hessen'),('en_US',87,'Mecklenburg-Vorpommern'),('en_US',88,'Nordrhein-Westfalen'),('en_US',89,'Rheinland-Pfalz'),('en_US',90,'Saarland'),('en_US',91,'Sachsen'),('en_US',92,'Sachsen-Anhalt'),('en_US',93,'Schleswig-Holstein'),('en_US',94,'Thüringen'),('en_US',95,'Wien'),('en_US',96,'Niederösterreich'),('en_US',97,'Oberösterreich'),('en_US',98,'Salzburg'),('en_US',99,'Kärnten'),('en_US',100,'Steiermark'),('en_US',101,'Tirol'),('en_US',102,'Burgenland'),('en_US',103,'Vorarlberg'),('en_US',104,'Aargau'),('en_US',105,'Appenzell Innerrhoden'),('en_US',106,'Appenzell Ausserrhoden'),('en_US',107,'Bern'),('en_US',108,'Basel-Landschaft'),('en_US',109,'Basel-Stadt'),('en_US',110,'Freiburg'),('en_US',111,'Genf'),('en_US',112,'Glarus'),('en_US',113,'Graubünden'),('en_US',114,'Jura'),('en_US',115,'Luzern'),('en_US',116,'Neuenburg'),('en_US',117,'Nidwalden'),('en_US',118,'Obwalden'),('en_US',119,'St. Gallen'),('en_US',120,'Schaffhausen'),('en_US',121,'Solothurn'),('en_US',122,'Schwyz'),('en_US',123,'Thurgau'),('en_US',124,'Tessin'),('en_US',125,'Uri'),('en_US',126,'Waadt'),('en_US',127,'Wallis'),('en_US',128,'Zug'),('en_US',129,'Zürich'),('en_US',130,'A Coruña'),('en_US',131,'Alava'),('en_US',132,'Albacete'),('en_US',133,'Alicante'),('en_US',134,'Almeria'),('en_US',135,'Asturias'),('en_US',136,'Avila'),('en_US',137,'Badajoz'),('en_US',138,'Baleares'),('en_US',139,'Barcelona'),('en_US',140,'Burgos'),('en_US',141,'Caceres'),('en_US',142,'Cadiz'),('en_US',143,'Cantabria'),('en_US',144,'Castellon'),('en_US',145,'Ceuta'),('en_US',146,'Ciudad Real'),('en_US',147,'Cordoba'),('en_US',148,'Cuenca'),('en_US',149,'Girona'),('en_US',150,'Granada'),('en_US',151,'Guadalajara'),('en_US',152,'Guipuzcoa'),('en_US',153,'Huelva'),('en_US',154,'Huesca'),('en_US',155,'Jaen'),('en_US',156,'La Rioja'),('en_US',157,'Las Palmas'),('en_US',158,'Leon'),('en_US',159,'Lleida'),('en_US',160,'Lugo'),('en_US',161,'Madrid'),('en_US',162,'Malaga'),('en_US',163,'Melilla'),('en_US',164,'Murcia'),('en_US',165,'Navarra'),('en_US',166,'Ourense'),('en_US',167,'Palencia'),('en_US',168,'Pontevedra'),('en_US',169,'Salamanca'),('en_US',170,'Santa Cruz de Tenerife'),('en_US',171,'Segovia'),('en_US',172,'Sevilla'),('en_US',173,'Soria'),('en_US',174,'Tarragona'),('en_US',175,'Teruel'),('en_US',176,'Toledo'),('en_US',177,'Valencia'),('en_US',178,'Valladolid'),('en_US',179,'Vizcaya'),('en_US',180,'Zamora'),('en_US',181,'Zaragoza'),('en_US',182,'Ain'),('en_US',183,'Aisne'),('en_US',184,'Allier'),('en_US',185,'Alpes-de-Haute-Provence'),('en_US',186,'Hautes-Alpes'),('en_US',187,'Alpes-Maritimes'),('en_US',188,'Ardèche'),('en_US',189,'Ardennes'),('en_US',190,'Ariège'),('en_US',191,'Aube'),('en_US',192,'Aude'),('en_US',193,'Aveyron'),('en_US',194,'Bouches-du-Rhône'),('en_US',195,'Calvados'),('en_US',196,'Cantal'),('en_US',197,'Charente'),('en_US',198,'Charente-Maritime'),('en_US',199,'Cher'),('en_US',200,'Corrèze'),('en_US',201,'Corse-du-Sud'),('en_US',202,'Haute-Corse'),('en_US',203,'Côte-d\'Or'),('en_US',204,'Côtes-d\'Armor'),('en_US',205,'Creuse'),('en_US',206,'Dordogne'),('en_US',207,'Doubs'),('en_US',208,'Drôme'),('en_US',209,'Eure'),('en_US',210,'Eure-et-Loir'),('en_US',211,'Finistère'),('en_US',212,'Gard'),('en_US',213,'Haute-Garonne'),('en_US',214,'Gers'),('en_US',215,'Gironde'),('en_US',216,'Hérault'),('en_US',217,'Ille-et-Vilaine'),('en_US',218,'Indre'),('en_US',219,'Indre-et-Loire'),('en_US',220,'Isère'),('en_US',221,'Jura'),('en_US',222,'Landes'),('en_US',223,'Loir-et-Cher'),('en_US',224,'Loire'),('en_US',225,'Haute-Loire'),('en_US',226,'Loire-Atlantique'),('en_US',227,'Loiret'),('en_US',228,'Lot'),('en_US',229,'Lot-et-Garonne'),('en_US',230,'Lozère'),('en_US',231,'Maine-et-Loire'),('en_US',232,'Manche'),('en_US',233,'Marne'),('en_US',234,'Haute-Marne'),('en_US',235,'Mayenne'),('en_US',236,'Meurthe-et-Moselle'),('en_US',237,'Meuse'),('en_US',238,'Morbihan'),('en_US',239,'Moselle'),('en_US',240,'Nièvre'),('en_US',241,'Nord'),('en_US',242,'Oise'),('en_US',243,'Orne'),('en_US',244,'Pas-de-Calais'),('en_US',245,'Puy-de-Dôme'),('en_US',246,'Pyrénées-Atlantiques'),('en_US',247,'Hautes-Pyrénées'),('en_US',248,'Pyrénées-Orientales'),('en_US',249,'Bas-Rhin'),('en_US',250,'Haut-Rhin'),('en_US',251,'Rhône'),('en_US',252,'Haute-Saône'),('en_US',253,'Saône-et-Loire'),('en_US',254,'Sarthe'),('en_US',255,'Savoie'),('en_US',256,'Haute-Savoie'),('en_US',257,'Paris'),('en_US',258,'Seine-Maritime'),('en_US',259,'Seine-et-Marne'),('en_US',260,'Yvelines'),('en_US',261,'Deux-Sèvres'),('en_US',262,'Somme'),('en_US',263,'Tarn'),('en_US',264,'Tarn-et-Garonne'),('en_US',265,'Var'),('en_US',266,'Vaucluse'),('en_US',267,'Vendée'),('en_US',268,'Vienne'),('en_US',269,'Haute-Vienne'),('en_US',270,'Vosges'),('en_US',271,'Yonne'),('en_US',272,'Territoire-de-Belfort'),('en_US',273,'Essonne'),('en_US',274,'Hauts-de-Seine'),('en_US',275,'Seine-Saint-Denis'),('en_US',276,'Val-de-Marne'),('en_US',277,'Val-d\'Oise'),('en_US',278,'Alba'),('en_US',279,'Arad'),('en_US',280,'Argeş'),('en_US',281,'Bacău'),('en_US',282,'Bihor'),('en_US',283,'Bistriţa-Năsăud'),('en_US',284,'Botoşani'),('en_US',285,'Braşov'),('en_US',286,'Brăila'),('en_US',287,'Bucureşti'),('en_US',288,'Buzău'),('en_US',289,'Caraş-Severin'),('en_US',290,'Călăraşi'),('en_US',291,'Cluj'),('en_US',292,'Constanţa'),('en_US',293,'Covasna'),('en_US',294,'Dâmboviţa'),('en_US',295,'Dolj'),('en_US',296,'Galaţi'),('en_US',297,'Giurgiu'),('en_US',298,'Gorj'),('en_US',299,'Harghita'),('en_US',300,'Hunedoara'),('en_US',301,'Ialomiţa'),('en_US',302,'Iaşi'),('en_US',303,'Ilfov'),('en_US',304,'Maramureş'),('en_US',305,'Mehedinţi'),('en_US',306,'Mureş'),('en_US',307,'Neamţ'),('en_US',308,'Olt'),('en_US',309,'Prahova'),('en_US',310,'Satu-Mare'),('en_US',311,'Sălaj'),('en_US',312,'Sibiu'),('en_US',313,'Suceava'),('en_US',314,'Teleorman'),('en_US',315,'Timiş'),('en_US',316,'Tulcea'),('en_US',317,'Vaslui'),('en_US',318,'Vâlcea'),('en_US',319,'Vrancea'),('en_US',320,'Lappi'),('en_US',321,'Pohjois-Pohjanmaa'),('en_US',322,'Kainuu'),('en_US',323,'Pohjois-Karjala'),('en_US',324,'Pohjois-Savo'),('en_US',325,'Etelä-Savo'),('en_US',326,'Etelä-Pohjanmaa'),('en_US',327,'Pohjanmaa'),('en_US',328,'Pirkanmaa'),('en_US',329,'Satakunta'),('en_US',330,'Keski-Pohjanmaa'),('en_US',331,'Keski-Suomi'),('en_US',332,'Varsinais-Suomi'),('en_US',333,'Etelä-Karjala'),('en_US',334,'Päijät-Häme'),('en_US',335,'Kanta-Häme'),('en_US',336,'Uusimaa'),('en_US',337,'Itä-Uusimaa'),('en_US',338,'Kymenlaakso'),('en_US',339,'Ahvenanmaa'),('en_US',340,'Harjumaa'),('en_US',341,'Hiiumaa'),('en_US',342,'Ida-Virumaa'),('en_US',343,'Jõgevamaa'),('en_US',344,'Järvamaa'),('en_US',345,'Läänemaa'),('en_US',346,'Lääne-Virumaa'),('en_US',347,'Põlvamaa'),('en_US',348,'Pärnumaa'),('en_US',349,'Raplamaa'),('en_US',350,'Saaremaa'),('en_US',351,'Tartumaa'),('en_US',352,'Valgamaa'),('en_US',353,'Viljandimaa'),('en_US',354,'Võrumaa'),('en_US',355,'Daugavpils'),('en_US',356,'Jelgava'),('en_US',357,'Jēkabpils'),('en_US',358,'Jūrmala'),('en_US',359,'Liepāja'),('en_US',360,'Liepājas novads'),('en_US',361,'Rēzekne'),('en_US',362,'Rīga'),('en_US',363,'Rīgas novads'),('en_US',364,'Valmiera'),('en_US',365,'Ventspils'),('en_US',366,'Aglonas novads'),('en_US',367,'Aizkraukles novads'),('en_US',368,'Aizputes novads'),('en_US',369,'Aknīstes novads'),('en_US',370,'Alojas novads'),('en_US',371,'Alsungas novads'),('en_US',372,'Alūksnes novads'),('en_US',373,'Amatas novads'),('en_US',374,'Apes novads'),('en_US',375,'Auces novads'),('en_US',376,'Babītes novads'),('en_US',377,'Baldones novads'),('en_US',378,'Baltinavas novads'),('en_US',379,'Balvu novads'),('en_US',380,'Bauskas novads'),('en_US',381,'Beverīnas novads'),('en_US',382,'Brocēnu novads'),('en_US',383,'Burtnieku novads'),('en_US',384,'Carnikavas novads'),('en_US',385,'Cesvaines novads'),('en_US',386,'Ciblas novads'),('en_US',387,'Cēsu novads'),('en_US',388,'Dagdas novads'),('en_US',389,'Daugavpils novads'),('en_US',390,'Dobeles novads'),('en_US',391,'Dundagas novads'),('en_US',392,'Durbes novads'),('en_US',393,'Engures novads'),('en_US',394,'Garkalnes novads'),('en_US',395,'Grobiņas novads'),('en_US',396,'Gulbenes novads'),('en_US',397,'Iecavas novads'),('en_US',398,'Ikšķiles novads'),('en_US',399,'Ilūkstes novads'),('en_US',400,'Inčukalna novads'),('en_US',401,'Jaunjelgavas novads'),('en_US',402,'Jaunpiebalgas novads'),('en_US',403,'Jaunpils novads'),('en_US',404,'Jelgavas novads'),('en_US',405,'Jēkabpils novads'),('en_US',406,'Kandavas novads'),('en_US',407,'Kokneses novads'),('en_US',408,'Krimuldas novads'),('en_US',409,'Krustpils novads'),('en_US',410,'Krāslavas novads'),('en_US',411,'Kuldīgas novads'),('en_US',412,'Kārsavas novads'),('en_US',413,'Lielvārdes novads'),('en_US',414,'Limbažu novads'),('en_US',415,'Lubānas novads'),('en_US',416,'Ludzas novads'),('en_US',417,'Līgatnes novads'),('en_US',418,'Līvānu novads'),('en_US',419,'Madonas novads'),('en_US',420,'Mazsalacas novads'),('en_US',421,'Mālpils novads'),('en_US',422,'Mārupes novads'),('en_US',423,'Naukšēnu novads'),('en_US',424,'Neretas novads'),('en_US',425,'Nīcas novads'),('en_US',426,'Ogres novads'),('en_US',427,'Olaines novads'),('en_US',428,'Ozolnieku novads'),('en_US',429,'Preiļu novads'),('en_US',430,'Priekules novads'),('en_US',431,'Priekuļu novads'),('en_US',432,'Pārgaujas novads'),('en_US',433,'Pāvilostas novads'),('en_US',434,'Pļaviņu novads'),('en_US',435,'Raunas novads'),('en_US',436,'Riebiņu novads'),('en_US',437,'Rojas novads'),('en_US',438,'Ropažu novads'),('en_US',439,'Rucavas novads'),('en_US',440,'Rugāju novads'),('en_US',441,'Rundāles novads'),('en_US',442,'Rēzeknes novads'),('en_US',443,'Rūjienas novads'),('en_US',444,'Salacgrīvas novads'),('en_US',445,'Salas novads'),('en_US',446,'Salaspils novads'),('en_US',447,'Saldus novads'),('en_US',448,'Saulkrastu novads'),('en_US',449,'Siguldas novads'),('en_US',450,'Skrundas novads'),('en_US',451,'Skrīveru novads'),('en_US',452,'Smiltenes novads'),('en_US',453,'Stopiņu novads'),('en_US',454,'Strenču novads'),('en_US',455,'Sējas novads'),('en_US',456,'Talsu novads'),('en_US',457,'Tukuma novads'),('en_US',458,'Tērvetes novads'),('en_US',459,'Vaiņodes novads'),('en_US',460,'Valkas novads'),('en_US',461,'Valmieras novads'),('en_US',462,'Varakļānu novads'),('en_US',463,'Vecpiebalgas novads'),('en_US',464,'Vecumnieku novads'),('en_US',465,'Ventspils novads'),('en_US',466,'Viesītes novads'),('en_US',467,'Viļakas novads'),('en_US',468,'Viļānu novads'),('en_US',469,'Vārkavas novads'),('en_US',470,'Zilupes novads'),('en_US',471,'Ādažu novads'),('en_US',472,'Ērgļu novads'),('en_US',473,'Ķeguma novads'),('en_US',474,'Ķekavas novads'),('en_US',475,'Alytaus Apskritis'),('en_US',476,'Kauno Apskritis'),('en_US',477,'Klaipėdos Apskritis'),('en_US',478,'Marijampolės Apskritis'),('en_US',479,'Panevėžio Apskritis'),('en_US',480,'Šiaulių Apskritis'),('en_US',481,'Tauragės Apskritis'),('en_US',482,'Telšių Apskritis'),('en_US',483,'Utenos Apskritis'),('en_US',484,'Vilniaus Apskritis'),('en_US',485,'Acre'),('en_US',486,'Alagoas'),('en_US',487,'Amapá'),('en_US',488,'Amazonas'),('en_US',489,'Bahia'),('en_US',490,'Ceará'),('en_US',491,'Espírito Santo'),('en_US',492,'Goiás'),('en_US',493,'Maranhão'),('en_US',494,'Mato Grosso'),('en_US',495,'Mato Grosso do Sul'),('en_US',496,'Minas Gerais'),('en_US',497,'Pará'),('en_US',498,'Paraíba'),('en_US',499,'Paraná'),('en_US',500,'Pernambuco'),('en_US',501,'Piauí'),('en_US',502,'Rio de Janeiro'),('en_US',503,'Rio Grande do Norte'),('en_US',504,'Rio Grande do Sul'),('en_US',505,'Rondônia'),('en_US',506,'Roraima'),('en_US',507,'Santa Catarina'),('en_US',508,'São Paulo'),('en_US',509,'Sergipe'),('en_US',510,'Tocantins'),('en_US',511,'Distrito Federal');
/*!40000 ALTER TABLE `spg_directory_country_region_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_directory_currency_rate`
--

DROP TABLE IF EXISTS `spg_directory_currency_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_directory_currency_rate` (
  `currency_from` varchar(3) NOT NULL COMMENT 'Currency Code Convert From',
  `currency_to` varchar(3) NOT NULL COMMENT 'Currency Code Convert To',
  `rate` decimal(24,12) NOT NULL DEFAULT '0.000000000000' COMMENT 'Currency Conversion Rate',
  PRIMARY KEY (`currency_from`,`currency_to`),
  KEY `SPG_DIRECTORY_CURRENCY_RATE_CURRENCY_TO` (`currency_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Currency Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_directory_currency_rate`
--

LOCK TABLES `spg_directory_currency_rate` WRITE;
/*!40000 ALTER TABLE `spg_directory_currency_rate` DISABLE KEYS */;
INSERT INTO `spg_directory_currency_rate` VALUES ('EUR','EUR',1.000000000000),('EUR','USD',1.415000000000),('USD','EUR',0.706700000000),('USD','USD',1.000000000000);
/*!40000 ALTER TABLE `spg_directory_currency_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_downloadable_link`
--

DROP TABLE IF EXISTS `spg_downloadable_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_downloadable_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  `number_of_downloads` int(11) DEFAULT NULL COMMENT 'Number of downloads',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(20) DEFAULT NULL COMMENT 'Link Type',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample Url',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample File',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  PRIMARY KEY (`link_id`),
  KEY `SPG_DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER` (`product_id`,`sort_order`),
  CONSTRAINT `SPG_DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID` FOREIGN KEY (`product_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_downloadable_link`
--

LOCK TABLES `spg_downloadable_link` WRITE;
/*!40000 ALTER TABLE `spg_downloadable_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_downloadable_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_downloadable_link_price`
--

DROP TABLE IF EXISTS `spg_downloadable_link_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_downloadable_link_price` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  PRIMARY KEY (`price_id`),
  KEY `SPG_DOWNLOADABLE_LINK_PRICE_LINK_ID` (`link_id`),
  KEY `SPG_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_DOWNLOADABLE_LINK_PRICE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `spg_downloadable_link` (`link_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Price Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_downloadable_link_price`
--

LOCK TABLES `spg_downloadable_link_price` WRITE;
/*!40000 ALTER TABLE `spg_downloadable_link_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_downloadable_link_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_downloadable_link_purchased`
--

DROP TABLE IF EXISTS `spg_downloadable_link_purchased`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_downloadable_link_purchased` (
  `purchased_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Purchased ID',
  `order_id` int(10) unsigned DEFAULT '0' COMMENT 'Order ID',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment ID',
  `order_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Item ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date of creation',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of modification',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer ID',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product name',
  `product_sku` varchar(255) DEFAULT NULL COMMENT 'Product sku',
  `link_section_title` varchar(255) DEFAULT NULL COMMENT 'Link_section_title',
  PRIMARY KEY (`purchased_id`),
  KEY `SPG_DOWNLOADABLE_LINK_PURCHASED_ORDER_ID` (`order_id`),
  KEY `SPG_DOWNLOADABLE_LINK_PURCHASED_ORDER_ITEM_ID` (`order_item_id`),
  KEY `SPG_DOWNLOADABLE_LINK_PURCHASED_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `SPG_DL_LNK_PURCHASED_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_DOWNLOADABLE_LINK_PURCHASED_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_downloadable_link_purchased`
--

LOCK TABLES `spg_downloadable_link_purchased` WRITE;
/*!40000 ALTER TABLE `spg_downloadable_link_purchased` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_downloadable_link_purchased` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_downloadable_link_purchased_item`
--

DROP TABLE IF EXISTS `spg_downloadable_link_purchased_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_downloadable_link_purchased_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
  `purchased_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Purchased ID',
  `order_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Order Item ID',
  `product_id` int(10) unsigned DEFAULT '0' COMMENT 'Product ID',
  `link_hash` varchar(255) DEFAULT NULL COMMENT 'Link hash',
  `number_of_downloads_bought` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads bought',
  `number_of_downloads_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads used',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `link_title` varchar(255) DEFAULT NULL COMMENT 'Link Title',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable Flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(255) DEFAULT NULL COMMENT 'Link Type',
  `status` varchar(50) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  PRIMARY KEY (`item_id`),
  KEY `SPG_DOWNLOADABLE_LINK_PURCHASED_ITEM_LINK_HASH` (`link_hash`),
  KEY `SPG_DOWNLOADABLE_LINK_PURCHASED_ITEM_ORDER_ITEM_ID` (`order_item_id`),
  KEY `SPG_DOWNLOADABLE_LINK_PURCHASED_ITEM_PURCHASED_ID` (`purchased_id`),
  CONSTRAINT `FK_BBE6BC72D2C2C2B45A787BAF3F199977` FOREIGN KEY (`purchased_id`) REFERENCES `spg_downloadable_link_purchased` (`purchased_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_DL_LNK_PURCHASED_ITEM_ORDER_ITEM_ID_SALES_ORDER_ITEM_ITEM_ID` FOREIGN KEY (`order_item_id`) REFERENCES `spg_sales_order_item` (`item_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Item Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_downloadable_link_purchased_item`
--

LOCK TABLES `spg_downloadable_link_purchased_item` WRITE;
/*!40000 ALTER TABLE `spg_downloadable_link_purchased_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_downloadable_link_purchased_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_downloadable_link_title`
--

DROP TABLE IF EXISTS `spg_downloadable_link_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_downloadable_link_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `SPG_DOWNLOADABLE_LINK_TITLE_LINK_ID_STORE_ID` (`link_id`,`store_id`),
  KEY `SPG_DOWNLOADABLE_LINK_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_DOWNLOADABLE_LINK_TITLE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `spg_downloadable_link` (`link_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_DOWNLOADABLE_LINK_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_downloadable_link_title`
--

LOCK TABLES `spg_downloadable_link_title` WRITE;
/*!40000 ALTER TABLE `spg_downloadable_link_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_downloadable_link_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_downloadable_sample`
--

DROP TABLE IF EXISTS `spg_downloadable_sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_downloadable_sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sample ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample URL',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample file',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`sample_id`),
  KEY `SPG_DOWNLOADABLE_SAMPLE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_DOWNLOADABLE_SAMPLE_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID` FOREIGN KEY (`product_id`) REFERENCES `spg_catalog_product_entity` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_downloadable_sample`
--

LOCK TABLES `spg_downloadable_sample` WRITE;
/*!40000 ALTER TABLE `spg_downloadable_sample` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_downloadable_sample` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_downloadable_sample_title`
--

DROP TABLE IF EXISTS `spg_downloadable_sample_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_downloadable_sample_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `sample_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sample ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `SPG_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID_STORE_ID` (`sample_id`,`store_id`),
  KEY `SPG_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_DL_SAMPLE_TTL_SAMPLE_ID_DL_SAMPLE_SAMPLE_ID` FOREIGN KEY (`sample_id`) REFERENCES `spg_downloadable_sample` (`sample_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_downloadable_sample_title`
--

LOCK TABLES `spg_downloadable_sample_title` WRITE;
/*!40000 ALTER TABLE `spg_downloadable_sample_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_downloadable_sample_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_attribute`
--

DROP TABLE IF EXISTS `spg_eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_code` varchar(255) DEFAULT NULL COMMENT 'Attribute Code',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `backend_model` varchar(255) DEFAULT NULL COMMENT 'Backend Model',
  `backend_type` varchar(8) NOT NULL DEFAULT 'static' COMMENT 'Backend Type',
  `backend_table` varchar(255) DEFAULT NULL COMMENT 'Backend Table',
  `frontend_model` varchar(255) DEFAULT NULL COMMENT 'Frontend Model',
  `frontend_input` varchar(50) DEFAULT NULL COMMENT 'Frontend Input',
  `frontend_label` varchar(255) DEFAULT NULL COMMENT 'Frontend Label',
  `frontend_class` varchar(255) DEFAULT NULL COMMENT 'Frontend Class',
  `source_model` varchar(255) DEFAULT NULL COMMENT 'Source Model',
  `is_required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Required',
  `is_user_defined` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is User Defined',
  `default_value` text COMMENT 'Default Value',
  `is_unique` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Unique',
  `note` varchar(255) DEFAULT NULL COMMENT 'Note',
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `SPG_EAV_ATTRIBUTE_ENTITY_TYPE_ID_ATTRIBUTE_CODE` (`entity_type_id`,`attribute_code`),
  CONSTRAINT `SPG_EAV_ATTRIBUTE_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_attribute`
--

LOCK TABLES `spg_eav_attribute` WRITE;
/*!40000 ALTER TABLE `spg_eav_attribute` DISABLE KEYS */;
INSERT INTO `spg_eav_attribute` VALUES (1,1,'website_id',NULL,'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Website','static',NULL,NULL,'select','Associate to Website',NULL,'Magento\\Customer\\Model\\Customer\\Attribute\\Source\\Website',1,0,NULL,0,NULL),(2,1,'store_id',NULL,'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Store','static',NULL,NULL,'select','Create In',NULL,'Magento\\Customer\\Model\\Customer\\Attribute\\Source\\Store',1,0,NULL,0,NULL),(3,1,'created_in',NULL,NULL,'static',NULL,NULL,'text','Created From',NULL,NULL,0,0,NULL,0,NULL),(4,1,'prefix',NULL,NULL,'static',NULL,NULL,'text','Prefix',NULL,NULL,0,0,NULL,0,NULL),(5,1,'firstname',NULL,NULL,'static',NULL,NULL,'text','First Name',NULL,NULL,1,0,NULL,0,NULL),(6,1,'middlename',NULL,NULL,'static',NULL,NULL,'text','Middle Name/Initial',NULL,NULL,0,0,NULL,0,NULL),(7,1,'lastname',NULL,NULL,'static',NULL,NULL,'text','Last Name',NULL,NULL,1,0,NULL,0,NULL),(8,1,'suffix',NULL,NULL,'static',NULL,NULL,'text','Suffix',NULL,NULL,0,0,NULL,0,NULL),(9,1,'email',NULL,NULL,'static',NULL,NULL,'text','Email',NULL,NULL,1,0,NULL,0,NULL),(10,1,'group_id',NULL,NULL,'static',NULL,NULL,'select','Group',NULL,'Magento\\Customer\\Model\\Customer\\Attribute\\Source\\Group',1,0,NULL,0,NULL),(11,1,'dob',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime','static',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Frontend\\Datetime','date','Date of Birth',NULL,NULL,0,0,NULL,0,NULL),(12,1,'password_hash',NULL,'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Password','static',NULL,NULL,'hidden',NULL,NULL,NULL,0,0,NULL,0,NULL),(13,1,'rp_token',NULL,NULL,'static',NULL,NULL,'hidden',NULL,NULL,NULL,0,0,NULL,0,NULL),(14,1,'rp_token_created_at',NULL,NULL,'static',NULL,NULL,'date',NULL,NULL,NULL,0,0,NULL,0,NULL),(15,1,'default_billing',NULL,'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Billing','static',NULL,NULL,'text','Default Billing Address',NULL,NULL,0,0,NULL,0,NULL),(16,1,'default_shipping',NULL,'Magento\\Customer\\Model\\Customer\\Attribute\\Backend\\Shipping','static',NULL,NULL,'text','Default Shipping Address',NULL,NULL,0,0,NULL,0,NULL),(17,1,'taxvat',NULL,NULL,'static',NULL,NULL,'text','Tax/VAT Number',NULL,NULL,0,0,NULL,0,NULL),(18,1,'confirmation',NULL,NULL,'static',NULL,NULL,'text','Is Confirmed',NULL,NULL,0,0,NULL,0,NULL),(19,1,'created_at',NULL,NULL,'static',NULL,NULL,'date','Created At',NULL,NULL,0,0,NULL,0,NULL),(20,1,'gender',NULL,NULL,'static',NULL,NULL,'select','Gender',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Table',0,0,NULL,0,NULL),(21,1,'disable_auto_group_change',NULL,'Magento\\Customer\\Model\\Attribute\\Backend\\Data\\Boolean','static',NULL,NULL,'boolean','Disable Automatic Group Change Based on VAT ID',NULL,NULL,0,0,NULL,0,NULL),(22,2,'prefix',NULL,NULL,'static',NULL,NULL,'text','Prefix',NULL,NULL,0,0,NULL,0,NULL),(23,2,'firstname',NULL,NULL,'static',NULL,NULL,'text','First Name',NULL,NULL,1,0,NULL,0,NULL),(24,2,'middlename',NULL,NULL,'static',NULL,NULL,'text','Middle Name/Initial',NULL,NULL,0,0,NULL,0,NULL),(25,2,'lastname',NULL,NULL,'static',NULL,NULL,'text','Last Name',NULL,NULL,1,0,NULL,0,NULL),(26,2,'suffix',NULL,NULL,'static',NULL,NULL,'text','Suffix',NULL,NULL,0,0,NULL,0,NULL),(27,2,'company',NULL,NULL,'static',NULL,NULL,'text','Company',NULL,NULL,0,0,NULL,0,NULL),(28,2,'street',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\DefaultBackend','static',NULL,NULL,'multiline','Street Address',NULL,NULL,1,0,NULL,0,NULL),(29,2,'city',NULL,NULL,'static',NULL,NULL,'text','City',NULL,NULL,1,0,NULL,0,NULL),(30,2,'country_id',NULL,NULL,'static',NULL,NULL,'select','Country',NULL,'Magento\\Customer\\Model\\ResourceModel\\Address\\Attribute\\Source\\Country',1,0,NULL,0,NULL),(31,2,'region',NULL,'Magento\\Customer\\Model\\ResourceModel\\Address\\Attribute\\Backend\\Region','static',NULL,NULL,'text','State/Province',NULL,NULL,0,0,NULL,0,NULL),(32,2,'region_id',NULL,NULL,'static',NULL,NULL,'hidden','State/Province',NULL,'Magento\\Customer\\Model\\ResourceModel\\Address\\Attribute\\Source\\Region',0,0,NULL,0,NULL),(33,2,'postcode',NULL,NULL,'static',NULL,NULL,'text','Zip/Postal Code',NULL,NULL,0,0,NULL,0,NULL),(34,2,'telephone',NULL,NULL,'static',NULL,NULL,'text','Phone Number',NULL,NULL,1,0,NULL,0,NULL),(35,2,'fax',NULL,NULL,'static',NULL,NULL,'text','Fax',NULL,NULL,0,0,NULL,0,NULL),(36,2,'vat_id',NULL,NULL,'static',NULL,NULL,'text','VAT number',NULL,NULL,0,0,NULL,0,NULL),(37,2,'vat_is_valid',NULL,NULL,'static',NULL,NULL,'text','VAT number validity',NULL,NULL,0,0,NULL,0,NULL),(38,2,'vat_request_id',NULL,NULL,'static',NULL,NULL,'text','VAT number validation request ID',NULL,NULL,0,0,NULL,0,NULL),(39,2,'vat_request_date',NULL,NULL,'static',NULL,NULL,'text','VAT number validation request date',NULL,NULL,0,0,NULL,0,NULL),(40,2,'vat_request_success',NULL,NULL,'static',NULL,NULL,'text','VAT number validation request success',NULL,NULL,0,0,NULL,0,NULL),(41,1,'updated_at',NULL,NULL,'static',NULL,NULL,'date','Updated At',NULL,NULL,0,0,NULL,0,NULL),(42,1,'failures_num',NULL,NULL,'static',NULL,NULL,'hidden','Failures Number',NULL,NULL,0,0,NULL,0,NULL),(43,1,'first_failure',NULL,NULL,'static',NULL,NULL,'date','First Failure Date',NULL,NULL,0,0,NULL,0,NULL),(44,1,'lock_expires',NULL,NULL,'static',NULL,NULL,'date','Failures Number',NULL,NULL,0,0,NULL,0,NULL),(45,3,'name',NULL,NULL,'varchar',NULL,NULL,'text','Name',NULL,NULL,1,0,NULL,0,NULL),(46,3,'is_active',NULL,NULL,'int',NULL,NULL,'select','Is Active',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',1,0,NULL,0,NULL),(47,3,'description',NULL,NULL,'text',NULL,NULL,'textarea','Description',NULL,NULL,0,0,NULL,0,NULL),(48,3,'image',NULL,'Magento\\Catalog\\Model\\Category\\Attribute\\Backend\\Image','varchar',NULL,NULL,'image','Image',NULL,NULL,0,0,NULL,0,NULL),(49,3,'meta_title',NULL,NULL,'varchar',NULL,NULL,'text','Page Title',NULL,NULL,0,0,NULL,0,NULL),(50,3,'meta_keywords',NULL,NULL,'text',NULL,NULL,'textarea','Meta Keywords',NULL,NULL,0,0,NULL,0,NULL),(51,3,'meta_description',NULL,NULL,'text',NULL,NULL,'textarea','Meta Description',NULL,NULL,0,0,NULL,0,NULL),(52,3,'display_mode',NULL,NULL,'varchar',NULL,NULL,'select','Display Mode',NULL,'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Mode',0,0,NULL,0,NULL),(53,3,'landing_page',NULL,NULL,'int',NULL,NULL,'select','CMS Block',NULL,'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Page',0,0,NULL,0,NULL),(54,3,'is_anchor',NULL,NULL,'int',NULL,NULL,'select','Is Anchor',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',0,0,'1',0,NULL),(55,3,'path',NULL,NULL,'static',NULL,NULL,'text','Path',NULL,NULL,0,0,NULL,0,NULL),(56,3,'position',NULL,NULL,'static',NULL,NULL,'text','Position',NULL,NULL,0,0,NULL,0,NULL),(57,3,'all_children',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(58,3,'path_in_store',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(59,3,'children',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(60,3,'custom_design',NULL,NULL,'varchar',NULL,NULL,'select','Custom Design',NULL,'Magento\\Theme\\Model\\Theme\\Source\\Theme',0,0,NULL,0,NULL),(61,3,'custom_design_from','Magento\\Catalog\\Model\\ResourceModel\\Eav\\Attribute','Magento\\Catalog\\Model\\Attribute\\Backend\\Startdate','datetime',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Frontend\\Datetime','date','Active From',NULL,NULL,0,0,NULL,0,NULL),(62,3,'custom_design_to',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime','datetime',NULL,NULL,'date','Active To',NULL,NULL,0,0,NULL,0,NULL),(63,3,'page_layout',NULL,NULL,'varchar',NULL,NULL,'select','Page Layout',NULL,'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Layout',0,0,NULL,0,NULL),(64,3,'custom_layout_update',NULL,'Magento\\Catalog\\Model\\Attribute\\Backend\\Customlayoutupdate','text',NULL,NULL,'textarea','Custom Layout Update',NULL,NULL,0,0,NULL,0,NULL),(65,3,'level',NULL,NULL,'static',NULL,NULL,'text','Level',NULL,NULL,0,0,NULL,0,NULL),(66,3,'children_count',NULL,NULL,'static',NULL,NULL,'text','Children Count',NULL,NULL,0,0,NULL,0,NULL),(67,3,'available_sort_by',NULL,'Magento\\Catalog\\Model\\Category\\Attribute\\Backend\\Sortby','text',NULL,NULL,'multiselect','Available Product Listing Sort By',NULL,'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Sortby',1,0,NULL,0,NULL),(68,3,'default_sort_by',NULL,'Magento\\Catalog\\Model\\Category\\Attribute\\Backend\\Sortby','varchar',NULL,NULL,'select','Default Product Listing Sort By',NULL,'Magento\\Catalog\\Model\\Category\\Attribute\\Source\\Sortby',1,0,NULL,0,NULL),(69,3,'include_in_menu',NULL,NULL,'int',NULL,NULL,'select','Include in Navigation Menu',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',1,0,'1',0,NULL),(70,3,'custom_use_parent_settings',NULL,NULL,'int',NULL,NULL,'select','Use Parent Category Settings',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',0,0,NULL,0,NULL),(71,3,'custom_apply_to_products',NULL,NULL,'int',NULL,NULL,'select','Apply To Products',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Boolean',0,0,NULL,0,NULL),(72,3,'filter_price_range',NULL,NULL,'decimal',NULL,NULL,'text','Layered Navigation Price Step',NULL,NULL,0,0,NULL,0,NULL),(73,4,'name',NULL,NULL,'varchar',NULL,NULL,'text','Product Name','validate-length maximum-length-255',NULL,1,0,NULL,0,NULL),(74,4,'sku',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Sku','static',NULL,NULL,'text','SKU','validate-length maximum-length-64',NULL,1,0,NULL,1,NULL),(75,4,'description',NULL,NULL,'text',NULL,NULL,'textarea','Description',NULL,NULL,0,0,NULL,0,NULL),(76,4,'short_description',NULL,NULL,'text',NULL,NULL,'textarea','Short Description',NULL,NULL,0,0,NULL,0,NULL),(77,4,'price',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price','decimal',NULL,NULL,'price','Price',NULL,NULL,1,0,NULL,0,NULL),(78,4,'special_price',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price','decimal',NULL,NULL,'price','Special Price',NULL,NULL,0,0,NULL,0,NULL),(79,4,'special_from_date',NULL,'Magento\\Catalog\\Model\\Attribute\\Backend\\Startdate','datetime',NULL,NULL,'date','Special Price From Date',NULL,NULL,0,0,NULL,0,NULL),(80,4,'special_to_date',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime','datetime',NULL,NULL,'date','Special Price To Date',NULL,NULL,0,0,NULL,0,NULL),(81,4,'cost',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price','decimal',NULL,NULL,'price','Cost',NULL,NULL,0,1,NULL,0,NULL),(82,4,'weight',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Weight','decimal',NULL,NULL,'weight','Weight',NULL,NULL,0,0,NULL,0,NULL),(83,4,'manufacturer',NULL,NULL,'int',NULL,NULL,'select','Manufacturer',NULL,NULL,0,1,NULL,0,NULL),(84,4,'meta_title',NULL,NULL,'varchar',NULL,NULL,'text','Meta Title',NULL,NULL,0,0,NULL,0,NULL),(85,4,'meta_keyword',NULL,NULL,'text',NULL,NULL,'textarea','Meta Keywords',NULL,NULL,0,0,NULL,0,NULL),(86,4,'meta_description',NULL,NULL,'varchar',NULL,NULL,'textarea','Meta Description',NULL,NULL,0,0,NULL,0,'Maximum 255 chars. Meta Description should optimally be between 150-160 characters'),(87,4,'image',NULL,NULL,'varchar',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Frontend\\Image','media_image','Base',NULL,NULL,0,0,NULL,0,NULL),(88,4,'small_image',NULL,NULL,'varchar',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Frontend\\Image','media_image','Small',NULL,NULL,0,0,NULL,0,NULL),(89,4,'thumbnail',NULL,NULL,'varchar',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Frontend\\Image','media_image','Thumbnail',NULL,NULL,0,0,NULL,0,NULL),(90,4,'media_gallery',NULL,NULL,'static',NULL,NULL,'gallery','Media Gallery',NULL,NULL,0,0,NULL,0,NULL),(91,4,'old_id',NULL,NULL,'int',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(92,4,'tier_price',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Tierprice','decimal',NULL,NULL,'text','Tier Price',NULL,NULL,0,0,NULL,0,NULL),(93,4,'color',NULL,NULL,'int',NULL,NULL,'select','Color',NULL,NULL,0,1,NULL,0,NULL),(94,4,'news_from_date',NULL,'Magento\\Catalog\\Model\\Attribute\\Backend\\Startdate','datetime',NULL,NULL,'date','Set Product as New from Date',NULL,NULL,0,0,NULL,0,NULL),(95,4,'news_to_date',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime','datetime',NULL,NULL,'date','Set Product as New to Date',NULL,NULL,0,0,NULL,0,NULL),(96,4,'gallery',NULL,NULL,'varchar',NULL,NULL,'gallery','Image Gallery',NULL,NULL,0,0,NULL,0,NULL),(97,4,'status',NULL,NULL,'int',NULL,NULL,'select','Enable Product',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Status',0,0,'1',0,NULL),(98,4,'minimal_price',NULL,NULL,'decimal',NULL,NULL,'price','Minimal Price',NULL,NULL,0,0,NULL,0,NULL),(99,4,'visibility',NULL,NULL,'int',NULL,NULL,'select','Visibility',NULL,'Magento\\Catalog\\Model\\Product\\Visibility',0,0,'4',0,NULL),(100,4,'custom_design',NULL,NULL,'varchar',NULL,NULL,'select','New Theme',NULL,'Magento\\Theme\\Model\\Theme\\Source\\Theme',0,0,NULL,0,NULL),(101,4,'custom_design_from',NULL,'Magento\\Catalog\\Model\\Attribute\\Backend\\Startdate','datetime',NULL,NULL,'date','Active From',NULL,NULL,0,0,NULL,0,NULL),(102,4,'custom_design_to',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Backend\\Datetime','datetime',NULL,NULL,'date','Active To',NULL,NULL,0,0,NULL,0,NULL),(103,4,'custom_layout_update',NULL,'Magento\\Catalog\\Model\\Attribute\\Backend\\Customlayoutupdate','text',NULL,NULL,'textarea','Layout Update XML',NULL,NULL,0,0,NULL,0,NULL),(104,4,'page_layout',NULL,NULL,'varchar',NULL,NULL,'select','Layout',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Layout',0,0,NULL,0,NULL),(105,4,'category_ids',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Category','static',NULL,NULL,'text','Categories',NULL,NULL,0,0,NULL,0,NULL),(106,4,'options_container',NULL,NULL,'varchar',NULL,NULL,'select','Display Product Options In',NULL,'Magento\\Catalog\\Model\\Entity\\Product\\Attribute\\Design\\Options\\Container',0,0,'container2',0,NULL),(107,4,'required_options',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(108,4,'has_options',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(109,4,'image_label',NULL,NULL,'varchar',NULL,NULL,'text','Image Label',NULL,NULL,0,0,NULL,0,NULL),(110,4,'small_image_label',NULL,NULL,'varchar',NULL,NULL,'text','Small Image Label',NULL,NULL,0,0,NULL,0,NULL),(111,4,'thumbnail_label',NULL,NULL,'varchar',NULL,NULL,'text','Thumbnail Label',NULL,NULL,0,0,NULL,0,NULL),(112,4,'created_at',NULL,NULL,'static',NULL,NULL,'date',NULL,NULL,NULL,1,0,NULL,0,NULL),(113,4,'updated_at',NULL,NULL,'static',NULL,NULL,'date',NULL,NULL,NULL,1,0,NULL,0,NULL),(114,4,'country_of_manufacture',NULL,NULL,'varchar',NULL,NULL,'select','Country of Manufacture',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Countryofmanufacture',0,0,NULL,0,NULL),(115,4,'quantity_and_stock_status',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Stock','int',NULL,NULL,'select','Quantity',NULL,'Magento\\CatalogInventory\\Model\\Source\\Stock',0,0,'1',0,NULL),(116,4,'custom_layout',NULL,NULL,'varchar',NULL,NULL,'select','New Layout',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Layout',0,0,NULL,0,NULL),(117,4,'price_type',NULL,NULL,'int',NULL,NULL,'boolean','Dynamic Price',NULL,NULL,1,0,'0',0,NULL),(118,4,'sku_type',NULL,NULL,'int',NULL,NULL,'boolean','Dynamic SKU',NULL,NULL,1,0,'0',0,NULL),(119,4,'weight_type',NULL,NULL,'int',NULL,NULL,'boolean','Dynamic Weight',NULL,NULL,1,0,'0',0,NULL),(120,4,'price_view',NULL,NULL,'int',NULL,NULL,'select','Price View',NULL,'Magento\\Bundle\\Model\\Product\\Attribute\\Source\\Price\\View',1,0,NULL,0,NULL),(121,4,'shipment_type',NULL,NULL,'int',NULL,NULL,'select','Ship Bundle Items',NULL,'Magento\\Bundle\\Model\\Product\\Attribute\\Source\\Shipment\\Type',1,0,'0',0,NULL),(122,3,'url_key',NULL,NULL,'varchar',NULL,NULL,'text','URL Key',NULL,NULL,0,0,NULL,0,NULL),(123,3,'url_path',NULL,NULL,'varchar',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(124,4,'url_key',NULL,NULL,'varchar',NULL,NULL,'text','URL Key',NULL,NULL,0,0,NULL,0,NULL),(125,4,'url_path',NULL,NULL,'varchar',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(126,4,'msrp',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price','decimal',NULL,NULL,'price','Manufacturer\'s Suggested Retail Price',NULL,NULL,0,0,NULL,0,NULL),(127,4,'msrp_display_actual_price_type',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Boolean','varchar',NULL,NULL,'select','Display Actual Price',NULL,'Magento\\Msrp\\Model\\Product\\Attribute\\Source\\Type\\Price',0,0,'0',0,NULL),(128,4,'links_purchased_separately',NULL,NULL,'int',NULL,NULL,NULL,'Links can be purchased separately',NULL,NULL,1,0,NULL,0,NULL),(129,4,'samples_title',NULL,NULL,'varchar',NULL,NULL,NULL,'Samples title',NULL,NULL,1,0,NULL,0,NULL),(130,4,'links_title',NULL,NULL,'varchar',NULL,NULL,NULL,'Links title',NULL,NULL,1,0,NULL,0,NULL),(131,4,'links_exist',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,0,0,'0',0,NULL),(132,4,'giftcard_amounts',NULL,'Magento\\GiftCard\\Model\\Attribute\\Backend\\Giftcard\\Amount','decimal',NULL,NULL,'price','Amount',NULL,NULL,0,0,NULL,0,NULL),(133,4,'allow_open_amount',NULL,NULL,'int',NULL,NULL,'select','Open Amount',NULL,'Magento\\GiftCard\\Model\\Source\\Open',0,0,NULL,0,NULL),(134,4,'open_amount_min',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price','decimal',NULL,NULL,'price','Open Amount From',NULL,NULL,0,0,NULL,0,NULL),(135,4,'open_amount_max',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price','decimal',NULL,NULL,'price','Open Amount To',NULL,NULL,0,0,NULL,0,NULL),(136,4,'giftcard_type',NULL,NULL,'int',NULL,NULL,'select','Card Type',NULL,'Magento\\GiftCard\\Model\\Source\\Type',1,0,NULL,0,NULL),(137,4,'is_redeemable',NULL,NULL,'int',NULL,NULL,'text','Is Redeemable',NULL,NULL,0,0,NULL,0,NULL),(138,4,'use_config_is_redeemable',NULL,NULL,'int',NULL,NULL,'text','Use Config Is Redeemable',NULL,NULL,0,0,NULL,0,NULL),(139,4,'lifetime',NULL,NULL,'int',NULL,NULL,'text','Lifetime',NULL,NULL,0,0,NULL,0,NULL),(140,4,'use_config_lifetime',NULL,NULL,'int',NULL,NULL,'text','Use Config Lifetime',NULL,NULL,0,0,NULL,0,NULL),(141,4,'email_template',NULL,NULL,'varchar',NULL,NULL,'text','Email Template',NULL,NULL,0,0,NULL,0,NULL),(142,4,'use_config_email_template',NULL,NULL,'int',NULL,NULL,'text','Use Config Email Template',NULL,NULL,0,0,NULL,0,NULL),(143,4,'allow_message',NULL,NULL,'int',NULL,NULL,'text','Allow Message',NULL,NULL,0,0,NULL,0,NULL),(144,4,'use_config_allow_message',NULL,NULL,'int',NULL,NULL,'text','Use Config Allow Message',NULL,NULL,0,0,NULL,0,NULL),(145,4,'related_tgtr_position_limit',NULL,'Magento\\TargetRule\\Model\\Catalog\\Product\\Attribute\\Backend\\Rule','int',NULL,NULL,'text','Related Target Rule Rule Based Positions',NULL,NULL,0,0,NULL,0,NULL),(146,4,'related_tgtr_position_behavior',NULL,'Magento\\TargetRule\\Model\\Catalog\\Product\\Attribute\\Backend\\Rule','int',NULL,NULL,'text','Related Target Rule Position Behavior',NULL,NULL,0,0,NULL,0,NULL),(147,4,'upsell_tgtr_position_limit',NULL,'Magento\\TargetRule\\Model\\Catalog\\Product\\Attribute\\Backend\\Rule','int',NULL,NULL,'text','Upsell Target Rule Rule Based Positions',NULL,NULL,0,0,NULL,0,NULL),(148,4,'upsell_tgtr_position_behavior',NULL,'Magento\\TargetRule\\Model\\Catalog\\Product\\Attribute\\Backend\\Rule','int',NULL,NULL,'text','Upsell Target Rule Position Behavior',NULL,NULL,0,0,NULL,0,NULL),(149,4,'tax_class_id',NULL,NULL,'int',NULL,NULL,'select','Tax Class',NULL,'Magento\\Tax\\Model\\TaxClass\\Source\\Product',0,0,'2',0,NULL),(150,4,'gift_message_available',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Boolean','varchar',NULL,NULL,'select','Allow Gift Message',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Boolean',0,0,NULL,0,NULL),(151,4,'gift_wrapping_available',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Boolean','varchar',NULL,NULL,'select','Allow Gift Wrapping','hidden-for-virtual','Magento\\Catalog\\Model\\Product\\Attribute\\Source\\Boolean',0,0,NULL,0,NULL),(152,4,'gift_wrapping_price',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Backend\\Price','decimal',NULL,NULL,'price','Price for Gift Wrapping','hidden-for-virtual',NULL,0,0,NULL,0,NULL),(153,5,'reward_points_balance_refunded',NULL,NULL,'integer',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),(154,5,'reward_salesrule_points',NULL,NULL,'integer',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),(155,1,'reward_update_notification',NULL,NULL,'int',NULL,NULL,'text','Reward update notification',NULL,NULL,0,0,NULL,0,NULL),(156,1,'reward_warning_notification',NULL,NULL,'int',NULL,NULL,'text','Reward warning notification',NULL,NULL,0,0,NULL,0,NULL),(157,9,'rma_entity_id',NULL,NULL,'static',NULL,NULL,'text','RMA Id',NULL,NULL,1,0,NULL,0,NULL),(158,9,'order_item_id',NULL,NULL,'static',NULL,NULL,'text','Order Item Id',NULL,NULL,1,0,NULL,0,NULL),(159,9,'qty_requested',NULL,NULL,'static',NULL,NULL,'text','Qty of requested for RMA items',NULL,NULL,1,0,NULL,0,NULL),(160,9,'qty_authorized',NULL,NULL,'static',NULL,NULL,'text','Qty of authorized items',NULL,NULL,1,0,NULL,0,NULL),(161,9,'qty_approved',NULL,NULL,'static',NULL,NULL,'text','Qty of requested for RMA items',NULL,NULL,1,0,NULL,0,NULL),(162,9,'status',NULL,NULL,'static',NULL,NULL,'select','Status',NULL,'Magento\\Rma\\Model\\Item\\Attribute\\Source\\Status',1,0,NULL,0,NULL),(163,9,'product_name',NULL,NULL,'static',NULL,NULL,'text','Product Name',NULL,NULL,1,0,NULL,0,NULL),(164,9,'product_sku',NULL,NULL,'static',NULL,NULL,'text','Product SKU',NULL,NULL,1,0,NULL,0,NULL),(165,9,'resolution',NULL,NULL,'int',NULL,NULL,'select','Resolution',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Table',1,0,NULL,0,NULL),(166,9,'condition',NULL,NULL,'int',NULL,NULL,'select','Item Condition',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Table',1,0,NULL,0,NULL),(167,9,'reason',NULL,NULL,'int',NULL,NULL,'select','Reason to Return',NULL,'Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Table',1,0,NULL,0,NULL),(168,9,'reason_other',NULL,NULL,'varchar',NULL,NULL,'text','Other',NULL,NULL,1,0,NULL,0,NULL),(169,9,'qty_returned',NULL,NULL,'static',NULL,NULL,'text','Qty of returned items',NULL,NULL,1,0,NULL,0,NULL),(170,9,'product_admin_name',NULL,NULL,'static',NULL,NULL,'text','Product Name For Backend',NULL,NULL,1,0,NULL,0,NULL),(171,9,'product_admin_sku',NULL,NULL,'static',NULL,NULL,'text','Product Sku For Backend',NULL,NULL,1,0,NULL,0,NULL),(172,9,'product_options',NULL,NULL,'static',NULL,NULL,'text','Product Options',NULL,NULL,1,0,NULL,0,NULL),(173,9,'is_qty_decimal',NULL,NULL,'static',NULL,NULL,'text','Is item quantity decimal',NULL,NULL,1,0,NULL,0,NULL),(174,4,'is_returnable',NULL,NULL,'varchar',NULL,NULL,'select','Enable RMA',NULL,'Magento\\Rma\\Model\\Product\\Source',0,0,'2',0,NULL),(175,4,'swatch_image',NULL,NULL,'varchar',NULL,'Magento\\Catalog\\Model\\Product\\Attribute\\Frontend\\Image','media_image','Swatch',NULL,NULL,0,0,NULL,0,NULL),(176,3,'automatic_sorting',NULL,NULL,'varchar',NULL,NULL,'text','Automatic Sorting',NULL,NULL,0,1,'none',0,NULL);
/*!40000 ALTER TABLE `spg_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_attribute_group`
--

DROP TABLE IF EXISTS `spg_eav_attribute_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_attribute_group` (
  `attribute_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Group Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Group Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Default Id',
  `attribute_group_code` varchar(255) NOT NULL COMMENT 'Attribute Group Code',
  `tab_group_code` varchar(255) DEFAULT NULL COMMENT 'Tab Group Code',
  PRIMARY KEY (`attribute_group_id`),
  UNIQUE KEY `SPG_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_ATTRIBUTE_GROUP_NAME` (`attribute_set_id`,`attribute_group_name`),
  KEY `SPG_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  CONSTRAINT `SPG_EAV_ATTR_GROUP_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `spg_eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_attribute_group`
--

LOCK TABLES `spg_eav_attribute_group` WRITE;
/*!40000 ALTER TABLE `spg_eav_attribute_group` DISABLE KEYS */;
INSERT INTO `spg_eav_attribute_group` VALUES (1,1,'General',1,1,'general',NULL),(2,2,'General',1,1,'general',NULL),(3,3,'General',10,1,'general',NULL),(4,3,'General Information',2,0,'general-information',NULL),(5,3,'Display Settings',20,0,'display-settings',NULL),(6,3,'Custom Design',30,0,'custom-design',NULL),(7,4,'Product Details',10,1,'product-details','basic'),(8,4,'Advanced Pricing',40,0,'advanced-pricing','advanced'),(9,4,'Search Engine Optimization',30,0,'search-engine-optimization','basic'),(10,4,'Images',20,0,'image-management','basic'),(11,4,'Design',50,0,'design','advanced'),(12,4,'Autosettings',60,0,'autosettings','advanced'),(13,4,'Content',15,0,'content','basic'),(14,4,'Schedule Design Update',55,0,'schedule-design-update','advanced'),(15,4,'Bundle Items',16,0,'bundle-items',NULL),(16,5,'General',1,1,'general',NULL),(17,6,'General',1,1,'general',NULL),(18,7,'General',1,1,'general',NULL),(19,8,'General',1,1,'general',NULL),(20,4,'Gift Options',61,0,'gift-options',NULL),(21,9,'General',1,1,'general',NULL);
/*!40000 ALTER TABLE `spg_eav_attribute_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_attribute_label`
--

DROP TABLE IF EXISTS `spg_eav_attribute_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_attribute_label` (
  `attribute_label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Label Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`attribute_label_id`),
  KEY `SPG_EAV_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  KEY `SPG_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_STORE_ID` (`attribute_id`,`store_id`),
  CONSTRAINT `SPG_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ATTRIBUTE_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Label';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_attribute_label`
--

LOCK TABLES `spg_eav_attribute_label` WRITE;
/*!40000 ALTER TABLE `spg_eav_attribute_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_attribute_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_attribute_option`
--

DROP TABLE IF EXISTS `spg_eav_attribute_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_attribute_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `SPG_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_attribute_option`
--

LOCK TABLES `spg_eav_attribute_option` WRITE;
/*!40000 ALTER TABLE `spg_eav_attribute_option` DISABLE KEYS */;
INSERT INTO `spg_eav_attribute_option` VALUES (1,20,0),(2,20,1),(3,20,3),(4,165,0),(5,165,1),(6,165,2),(7,166,0),(8,166,1),(9,166,2),(10,167,0),(11,167,1),(12,167,2);
/*!40000 ALTER TABLE `spg_eav_attribute_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_attribute_option_swatch`
--

DROP TABLE IF EXISTS `spg_eav_attribute_option_swatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_attribute_option_swatch` (
  `swatch_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Swatch ID',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `type` smallint(5) unsigned NOT NULL COMMENT 'Swatch type: 0 - text, 1 - visual color, 2 - visual image',
  `value` varchar(255) DEFAULT NULL COMMENT 'Swatch Value',
  PRIMARY KEY (`swatch_id`),
  UNIQUE KEY `SPG_EAV_ATTRIBUTE_OPTION_SWATCH_STORE_ID_OPTION_ID` (`store_id`,`option_id`),
  KEY `SPG_EAV_ATTRIBUTE_OPTION_SWATCH_SWATCH_ID` (`swatch_id`),
  KEY `SPG_EAV_ATTR_OPT_SWATCH_OPT_ID_EAV_ATTR_OPT_OPT_ID` (`option_id`),
  CONSTRAINT `SPG_EAV_ATTRIBUTE_OPTION_SWATCH_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ATTR_OPT_SWATCH_OPT_ID_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `spg_eav_attribute_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Magento Swatches table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_attribute_option_swatch`
--

LOCK TABLES `spg_eav_attribute_option_swatch` WRITE;
/*!40000 ALTER TABLE `spg_eav_attribute_option_swatch` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_attribute_option_swatch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_attribute_option_value`
--

DROP TABLE IF EXISTS `spg_eav_attribute_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_attribute_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `SPG_EAV_ATTRIBUTE_OPTION_VALUE_OPTION_ID` (`option_id`),
  KEY `SPG_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ATTR_OPT_VAL_OPT_ID_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `spg_eav_attribute_option` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_attribute_option_value`
--

LOCK TABLES `spg_eav_attribute_option_value` WRITE;
/*!40000 ALTER TABLE `spg_eav_attribute_option_value` DISABLE KEYS */;
INSERT INTO `spg_eav_attribute_option_value` VALUES (1,1,0,'Male'),(2,2,0,'Female'),(3,3,0,'Not Specified'),(4,4,0,'Exchange'),(5,5,0,'Refund'),(6,6,0,'Store Credit'),(7,7,0,'Unopened'),(8,8,0,'Opened'),(9,9,0,'Damaged'),(10,10,0,'Wrong Color'),(11,11,0,'Wrong Size'),(12,12,0,'Out of Service');
/*!40000 ALTER TABLE `spg_eav_attribute_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_attribute_set`
--

DROP TABLE IF EXISTS `spg_eav_attribute_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_attribute_set` (
  `attribute_set_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Set Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Set Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`attribute_set_id`),
  UNIQUE KEY `SPG_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_ATTRIBUTE_SET_NAME` (`entity_type_id`,`attribute_set_name`),
  KEY `SPG_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_SORT_ORDER` (`entity_type_id`,`sort_order`),
  CONSTRAINT `SPG_EAV_ATTR_SET_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Set';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_attribute_set`
--

LOCK TABLES `spg_eav_attribute_set` WRITE;
/*!40000 ALTER TABLE `spg_eav_attribute_set` DISABLE KEYS */;
INSERT INTO `spg_eav_attribute_set` VALUES (1,1,'Default',2),(2,2,'Default',2),(3,3,'Default',1),(4,4,'Default',1),(5,5,'Default',1),(6,6,'Default',1),(7,7,'Default',1),(8,8,'Default',1),(9,9,'Default',1);
/*!40000 ALTER TABLE `spg_eav_attribute_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_entity`
--

DROP TABLE IF EXISTS `spg_eav_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Entity Active',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_EAV_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `SPG_EAV_ENTITY_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_EAV_ENTITY_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTITY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_entity`
--

LOCK TABLES `spg_eav_entity` WRITE;
/*!40000 ALTER TABLE `spg_eav_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_entity_attribute`
--

DROP TABLE IF EXISTS `spg_eav_entity_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_entity_attribute` (
  `entity_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`entity_attribute_id`),
  UNIQUE KEY `SPG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_ATTRIBUTE_ID` (`attribute_set_id`,`attribute_id`),
  UNIQUE KEY `SPG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_GROUP_ID_ATTRIBUTE_ID` (`attribute_group_id`,`attribute_id`),
  KEY `SPG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  KEY `SPG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTT_ATTR_ATTR_GROUP_ID_EAV_ATTR_GROUP_ATTR_GROUP_ID` FOREIGN KEY (`attribute_group_id`) REFERENCES `spg_eav_attribute_group` (`attribute_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8 COMMENT='Eav Entity Attributes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_entity_attribute`
--

LOCK TABLES `spg_eav_entity_attribute` WRITE;
/*!40000 ALTER TABLE `spg_eav_entity_attribute` DISABLE KEYS */;
INSERT INTO `spg_eav_entity_attribute` VALUES (1,1,1,1,1,10),(2,1,1,1,2,20),(3,1,1,1,3,20),(4,1,1,1,4,30),(5,1,1,1,5,40),(6,1,1,1,6,50),(7,1,1,1,7,60),(8,1,1,1,8,70),(9,1,1,1,9,80),(10,1,1,1,10,25),(11,1,1,1,11,90),(12,1,1,1,12,81),(13,1,1,1,13,115),(14,1,1,1,14,120),(15,1,1,1,15,82),(16,1,1,1,16,83),(17,1,1,1,17,100),(18,1,1,1,18,85),(19,1,1,1,19,86),(20,1,1,1,20,110),(21,1,1,1,21,121),(22,2,2,2,22,10),(23,2,2,2,23,20),(24,2,2,2,24,30),(25,2,2,2,25,40),(26,2,2,2,26,50),(27,2,2,2,27,60),(28,2,2,2,28,70),(29,2,2,2,29,80),(30,2,2,2,30,90),(31,2,2,2,31,100),(32,2,2,2,32,100),(33,2,2,2,33,110),(34,2,2,2,34,120),(35,2,2,2,35,130),(36,2,2,2,36,131),(37,2,2,2,37,132),(38,2,2,2,38,133),(39,2,2,2,39,134),(40,2,2,2,40,135),(41,1,1,1,41,87),(42,1,1,1,42,100),(43,1,1,1,43,110),(44,1,1,1,44,120),(45,3,3,4,45,1),(46,3,3,4,46,2),(47,3,3,4,47,4),(48,3,3,4,48,5),(49,3,3,4,49,6),(50,3,3,4,50,7),(51,3,3,4,51,8),(52,3,3,5,52,10),(53,3,3,5,53,20),(54,3,3,5,54,30),(55,3,3,4,55,12),(56,3,3,4,56,13),(57,3,3,4,57,14),(58,3,3,4,58,15),(59,3,3,4,59,16),(60,3,3,6,60,10),(61,3,3,6,61,30),(62,3,3,6,62,40),(63,3,3,6,63,50),(64,3,3,6,64,60),(65,3,3,4,65,24),(66,3,3,4,66,25),(67,3,3,5,67,40),(68,3,3,5,68,50),(69,3,3,4,69,10),(70,3,3,6,70,5),(71,3,3,6,71,6),(72,3,3,5,72,51),(73,4,4,7,73,10),(74,4,4,7,74,20),(75,4,4,13,75,90),(76,4,4,13,76,100),(77,4,4,7,77,30),(78,4,4,8,78,3),(79,4,4,8,79,4),(80,4,4,8,80,5),(81,4,4,8,81,6),(82,4,4,7,82,70),(83,4,4,9,84,20),(84,4,4,9,85,30),(85,4,4,9,86,40),(86,4,4,10,87,1),(87,4,4,10,88,2),(88,4,4,10,89,3),(89,4,4,10,90,4),(90,4,4,7,91,6),(91,4,4,8,92,7),(92,4,4,7,94,90),(93,4,4,7,95,100),(94,4,4,10,96,5),(95,4,4,7,97,5),(96,4,4,8,98,8),(97,4,4,7,99,80),(98,4,4,14,100,40),(99,4,4,14,101,20),(100,4,4,14,102,30),(101,4,4,11,103,10),(102,4,4,11,104,5),(103,4,4,7,105,80),(104,4,4,11,106,6),(105,4,4,7,107,14),(106,4,4,7,108,15),(107,4,4,7,109,16),(108,4,4,7,110,17),(109,4,4,7,111,18),(110,4,4,7,112,19),(111,4,4,7,113,20),(112,4,4,7,114,110),(113,4,4,7,115,60),(114,4,4,14,116,50),(115,4,4,7,117,31),(116,4,4,7,118,21),(117,4,4,7,119,71),(118,4,4,8,120,9),(119,4,4,15,121,1),(120,3,3,4,122,3),(121,3,3,4,123,17),(122,4,4,9,124,10),(123,4,4,7,125,11),(124,4,4,8,126,10),(125,4,4,8,127,11),(126,4,4,7,128,111),(127,4,4,7,129,112),(128,4,4,7,130,113),(129,4,4,7,131,114),(130,4,4,7,132,32),(131,4,4,7,133,33),(132,4,4,7,134,34),(133,4,4,7,135,35),(134,4,4,7,136,31),(135,4,4,8,137,13),(136,4,4,8,138,14),(137,4,4,8,139,15),(138,4,4,8,140,16),(139,4,4,8,141,17),(140,4,4,8,142,18),(141,4,4,8,143,19),(142,4,4,8,144,20),(143,4,4,7,145,115),(144,4,4,7,146,116),(145,4,4,7,147,117),(146,4,4,7,148,118),(147,4,4,7,149,40),(148,4,4,20,150,10),(149,4,4,20,151,20),(150,4,4,20,152,30),(151,5,5,16,153,1),(152,5,5,16,154,2),(153,1,1,1,155,122),(154,1,1,1,156,123),(155,9,9,21,157,10),(156,9,9,21,158,20),(157,9,9,21,159,30),(158,9,9,21,160,40),(159,9,9,21,161,50),(160,9,9,21,162,60),(161,9,9,21,163,70),(162,9,9,21,164,80),(163,9,9,21,165,90),(164,9,9,21,166,100),(165,9,9,21,167,110),(166,9,9,21,168,120),(167,9,9,21,169,45),(168,9,9,21,170,46),(169,9,9,21,171,47),(170,9,9,21,172,48),(171,9,9,21,173,15),(172,4,4,7,174,120),(173,4,4,10,175,3),(174,3,3,4,176,10);
/*!40000 ALTER TABLE `spg_eav_entity_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_entity_datetime`
--

DROP TABLE IF EXISTS `spg_eav_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_EAV_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `SPG_EAV_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `SPG_EAV_ENTITY_DATETIME_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `SPG_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `SPG_EAV_ENTITY_DATETIME_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTITY_DATETIME_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_entity_datetime`
--

LOCK TABLES `spg_eav_entity_datetime` WRITE;
/*!40000 ALTER TABLE `spg_eav_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_entity_decimal`
--

DROP TABLE IF EXISTS `spg_eav_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_EAV_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `SPG_EAV_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `SPG_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `SPG_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `SPG_EAV_ENTITY_DECIMAL_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTITY_DECIMAL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_entity_decimal`
--

LOCK TABLES `spg_eav_entity_decimal` WRITE;
/*!40000 ALTER TABLE `spg_eav_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_entity_int`
--

DROP TABLE IF EXISTS `spg_eav_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_EAV_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `SPG_EAV_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `SPG_EAV_ENTITY_INT_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `SPG_EAV_ENTITY_INT_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `SPG_EAV_ENTITY_INT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTITY_INT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTITY_INT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_entity_int`
--

LOCK TABLES `spg_eav_entity_int` WRITE;
/*!40000 ALTER TABLE `spg_eav_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_entity_store`
--

DROP TABLE IF EXISTS `spg_eav_entity_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_entity_store` (
  `entity_store_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Store Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `increment_prefix` varchar(20) DEFAULT NULL COMMENT 'Increment Prefix',
  `increment_last_id` varchar(50) DEFAULT NULL COMMENT 'Last Incremented Id',
  PRIMARY KEY (`entity_store_id`),
  KEY `SPG_EAV_ENTITY_STORE_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `SPG_EAV_ENTITY_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_EAV_ENTITY_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTT_STORE_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_entity_store`
--

LOCK TABLES `spg_eav_entity_store` WRITE;
/*!40000 ALTER TABLE `spg_eav_entity_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_entity_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_entity_text`
--

DROP TABLE IF EXISTS `spg_eav_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_EAV_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `SPG_EAV_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `SPG_EAV_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_EAV_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_EAV_ENTITY_TEXT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTITY_TEXT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTT_TEXT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_entity_text`
--

LOCK TABLES `spg_eav_entity_text` WRITE;
/*!40000 ALTER TABLE `spg_eav_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_entity_type`
--

DROP TABLE IF EXISTS `spg_eav_entity_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_entity_type` (
  `entity_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Type Id',
  `entity_type_code` varchar(50) NOT NULL COMMENT 'Entity Type Code',
  `entity_model` varchar(255) NOT NULL COMMENT 'Entity Model',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `entity_table` varchar(255) DEFAULT NULL COMMENT 'Entity Table',
  `value_table_prefix` varchar(255) DEFAULT NULL COMMENT 'Value Table Prefix',
  `entity_id_field` varchar(255) DEFAULT NULL COMMENT 'Entity Id Field',
  `is_data_sharing` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Data Sharing',
  `data_sharing_key` varchar(100) DEFAULT 'default' COMMENT 'Data Sharing Key',
  `default_attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Attribute Set Id',
  `increment_model` varchar(255) DEFAULT NULL COMMENT 'Increment Model',
  `increment_per_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Increment Per Store',
  `increment_pad_length` smallint(5) unsigned NOT NULL DEFAULT '8' COMMENT 'Increment Pad Length',
  `increment_pad_char` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Increment Pad Char',
  `additional_attribute_table` varchar(255) DEFAULT NULL COMMENT 'Additional Attribute Table',
  `entity_attribute_collection` varchar(255) DEFAULT NULL COMMENT 'Entity Attribute Collection',
  PRIMARY KEY (`entity_type_id`),
  KEY `SPG_EAV_ENTITY_TYPE_ENTITY_TYPE_CODE` (`entity_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Eav Entity Type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_entity_type`
--

LOCK TABLES `spg_eav_entity_type` WRITE;
/*!40000 ALTER TABLE `spg_eav_entity_type` DISABLE KEYS */;
INSERT INTO `spg_eav_entity_type` VALUES (1,'customer','Magento\\Customer\\Model\\ResourceModel\\Customer','Magento\\Customer\\Model\\Attribute','customer_entity',NULL,NULL,1,'default',1,'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',0,8,'0','customer_eav_attribute','Magento\\Customer\\Model\\ResourceModel\\Attribute\\Collection'),(2,'customer_address','Magento\\Customer\\Model\\ResourceModel\\Address','Magento\\Customer\\Model\\Attribute','customer_address_entity',NULL,NULL,1,'default',2,NULL,0,8,'0','customer_eav_attribute','Magento\\Customer\\Model\\ResourceModel\\Address\\Attribute\\Collection'),(3,'catalog_category','Magento\\Catalog\\Model\\ResourceModel\\Category','Magento\\Catalog\\Model\\ResourceModel\\Eav\\Attribute','catalog_category_entity',NULL,NULL,1,'default',3,NULL,0,8,'0','catalog_eav_attribute','Magento\\Catalog\\Model\\ResourceModel\\Category\\Attribute\\Collection'),(4,'catalog_product','Magento\\Catalog\\Model\\ResourceModel\\Product','Magento\\Catalog\\Model\\ResourceModel\\Eav\\Attribute','catalog_product_entity',NULL,NULL,1,'default',4,NULL,0,8,'0','catalog_eav_attribute','Magento\\Catalog\\Model\\ResourceModel\\Product\\Attribute\\Collection'),(5,'order','Magento\\Sales\\Model\\ResourceModel\\Order',NULL,'sales_order',NULL,NULL,1,'default',5,'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',1,8,'0',NULL,NULL),(6,'invoice','Magento\\Sales\\Model\\ResourceModel\\Order',NULL,'sales_invoice',NULL,NULL,1,'default',6,'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',1,8,'0',NULL,NULL),(7,'creditmemo','Magento\\Sales\\Model\\ResourceModel\\Order\\Creditmemo',NULL,'sales_creditmemo',NULL,NULL,1,'default',7,'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',1,8,'0',NULL,NULL),(8,'shipment','Magento\\Sales\\Model\\ResourceModel\\Order\\Shipment',NULL,'sales_shipment',NULL,NULL,1,'default',8,'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',1,8,'0',NULL,NULL),(9,'rma_item','Magento\\Rma\\Model\\ResourceModel\\Item','Magento\\Rma\\Model\\Item\\Attribute','magento_rma_item_entity',NULL,NULL,1,'default',9,'Magento\\Eav\\Model\\Entity\\Increment\\NumericValue',1,8,'0','magento_rma_item_eav_attribute',NULL);
/*!40000 ALTER TABLE `spg_eav_entity_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_entity_varchar`
--

DROP TABLE IF EXISTS `spg_eav_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_EAV_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `SPG_EAV_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `SPG_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `SPG_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `SPG_EAV_ENTITY_VARCHAR_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_eav_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTITY_VARCHAR_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_entity_varchar`
--

LOCK TABLES `spg_eav_entity_varchar` WRITE;
/*!40000 ALTER TABLE `spg_eav_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_form_element`
--

DROP TABLE IF EXISTS `spg_eav_form_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_form_element` (
  `element_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Element Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `fieldset_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Fieldset Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`element_id`),
  UNIQUE KEY `SPG_EAV_FORM_ELEMENT_TYPE_ID_ATTRIBUTE_ID` (`type_id`,`attribute_id`),
  KEY `SPG_EAV_FORM_ELEMENT_FIELDSET_ID` (`fieldset_id`),
  KEY `SPG_EAV_FORM_ELEMENT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_EAV_FORM_ELEMENT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_FORM_ELEMENT_FIELDSET_ID_EAV_FORM_FIELDSET_FIELDSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `spg_eav_form_fieldset` (`fieldset_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_EAV_FORM_ELEMENT_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `spg_eav_form_type` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='Eav Form Element';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_form_element`
--

LOCK TABLES `spg_eav_form_element` WRITE;
/*!40000 ALTER TABLE `spg_eav_form_element` DISABLE KEYS */;
INSERT INTO `spg_eav_form_element` VALUES (1,1,NULL,23,0),(2,1,NULL,25,1),(3,1,NULL,27,2),(4,1,NULL,9,3),(5,1,NULL,28,4),(6,1,NULL,29,5),(7,1,NULL,31,6),(8,1,NULL,33,7),(9,1,NULL,30,8),(10,1,NULL,34,9),(11,1,NULL,35,10),(12,2,NULL,23,0),(13,2,NULL,25,1),(14,2,NULL,27,2),(15,2,NULL,9,3),(16,2,NULL,28,4),(17,2,NULL,29,5),(18,2,NULL,31,6),(19,2,NULL,33,7),(20,2,NULL,30,8),(21,2,NULL,34,9),(22,2,NULL,35,10),(23,3,NULL,23,0),(24,3,NULL,25,1),(25,3,NULL,27,2),(26,3,NULL,28,3),(27,3,NULL,29,4),(28,3,NULL,31,5),(29,3,NULL,33,6),(30,3,NULL,30,7),(31,3,NULL,34,8),(32,3,NULL,35,9),(33,4,NULL,23,0),(34,4,NULL,25,1),(35,4,NULL,27,2),(36,4,NULL,28,3),(37,4,NULL,29,4),(38,4,NULL,31,5),(39,4,NULL,33,6),(40,4,NULL,30,7),(41,4,NULL,34,8),(42,4,NULL,35,9);
/*!40000 ALTER TABLE `spg_eav_form_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_form_fieldset`
--

DROP TABLE IF EXISTS `spg_eav_form_fieldset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_form_fieldset` (
  `fieldset_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Fieldset Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`fieldset_id`),
  UNIQUE KEY `SPG_EAV_FORM_FIELDSET_TYPE_ID_CODE` (`type_id`,`code`),
  CONSTRAINT `SPG_EAV_FORM_FIELDSET_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `spg_eav_form_type` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_form_fieldset`
--

LOCK TABLES `spg_eav_form_fieldset` WRITE;
/*!40000 ALTER TABLE `spg_eav_form_fieldset` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_form_fieldset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_form_fieldset_label`
--

DROP TABLE IF EXISTS `spg_eav_form_fieldset_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_form_fieldset_label` (
  `fieldset_id` smallint(5) unsigned NOT NULL COMMENT 'Fieldset Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`fieldset_id`,`store_id`),
  KEY `SPG_EAV_FORM_FIELDSET_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_EAV_FORM_FIELDSET_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_FORM_FSET_LBL_FSET_ID_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `spg_eav_form_fieldset` (`fieldset_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset Label';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_form_fieldset_label`
--

LOCK TABLES `spg_eav_form_fieldset_label` WRITE;
/*!40000 ALTER TABLE `spg_eav_form_fieldset_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_eav_form_fieldset_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_form_type`
--

DROP TABLE IF EXISTS `spg_eav_form_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_form_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `SPG_EAV_FORM_TYPE_CODE_THEME_STORE_ID` (`code`,`theme`,`store_id`),
  KEY `SPG_EAV_FORM_TYPE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_EAV_FORM_TYPE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Eav Form Type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_form_type`
--

LOCK TABLES `spg_eav_form_type` WRITE;
/*!40000 ALTER TABLE `spg_eav_form_type` DISABLE KEYS */;
INSERT INTO `spg_eav_form_type` VALUES (1,'checkout_onepage_register','checkout_onepage_register',1,'',0),(2,'checkout_onepage_register_guest','checkout_onepage_register_guest',1,'',0),(3,'checkout_onepage_billing_address','checkout_onepage_billing_address',1,'',0),(4,'checkout_onepage_shipping_address','checkout_onepage_shipping_address',1,'',0);
/*!40000 ALTER TABLE `spg_eav_form_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_eav_form_type_entity`
--

DROP TABLE IF EXISTS `spg_eav_form_type_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_eav_form_type_entity` (
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`type_id`,`entity_type_id`),
  KEY `SPG_EAV_FORM_TYPE_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `SPG_EAV_FORM_TYPE_ENTITY_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `spg_eav_form_type` (`type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_EAV_FORM_TYPE_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `spg_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type Entity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_eav_form_type_entity`
--

LOCK TABLES `spg_eav_form_type_entity` WRITE;
/*!40000 ALTER TABLE `spg_eav_form_type_entity` DISABLE KEYS */;
INSERT INTO `spg_eav_form_type_entity` VALUES (1,1),(2,1),(1,2),(2,2),(3,2),(4,2);
/*!40000 ALTER TABLE `spg_eav_form_type_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_email_template`
--

DROP TABLE IF EXISTS `spg_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_email_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template ID',
  `template_code` varchar(150) NOT NULL COMMENT 'Template Name',
  `template_text` text NOT NULL COMMENT 'Template Content',
  `template_styles` text COMMENT 'Templste Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) NOT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date of Template Creation',
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Template Modification',
  `orig_template_code` varchar(200) DEFAULT NULL COMMENT 'Original Template Code',
  `orig_template_variables` text COMMENT 'Original Template Variables',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `SPG_EMAIL_TEMPLATE_TEMPLATE_CODE` (`template_code`),
  KEY `SPG_EMAIL_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `SPG_EMAIL_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Templates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_email_template`
--

LOCK TABLES `spg_email_template` WRITE;
/*!40000 ALTER TABLE `spg_email_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_flag`
--

DROP TABLE IF EXISTS `spg_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_flag` (
  `flag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Flag Id',
  `flag_code` varchar(255) NOT NULL COMMENT 'Flag Code',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag State',
  `flag_data` text COMMENT 'Flag Data',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Last Flag Update',
  PRIMARY KEY (`flag_id`),
  KEY `SPG_FLAG_LAST_UPDATE` (`last_update`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_flag`
--

LOCK TABLES `spg_flag` WRITE;
/*!40000 ALTER TABLE `spg_flag` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_gift_message`
--

DROP TABLE IF EXISTS `spg_gift_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_gift_message` (
  `gift_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'GiftMessage Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `sender` varchar(255) DEFAULT NULL COMMENT 'Sender',
  `recipient` varchar(255) DEFAULT NULL COMMENT 'Registrant',
  `message` text COMMENT 'Message',
  PRIMARY KEY (`gift_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gift Message';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_gift_message`
--

LOCK TABLES `spg_gift_message` WRITE;
/*!40000 ALTER TABLE `spg_gift_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_gift_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_googleoptimizer_code`
--

DROP TABLE IF EXISTS `spg_googleoptimizer_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_googleoptimizer_code` (
  `code_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Google experiment code id',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Optimized entity id product id or catalog id',
  `entity_type` varchar(50) DEFAULT NULL COMMENT 'Optimized entity type',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store id',
  `experiment_script` text COMMENT 'Google experiment script',
  PRIMARY KEY (`code_id`),
  UNIQUE KEY `SPG_GOOGLEOPTIMIZER_CODE_STORE_ID_ENTITY_ID_ENTITY_TYPE` (`store_id`,`entity_id`,`entity_type`),
  CONSTRAINT `SPG_GOOGLEOPTIMIZER_CODE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Experiment code';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_googleoptimizer_code`
--

LOCK TABLES `spg_googleoptimizer_code` WRITE;
/*!40000 ALTER TABLE `spg_googleoptimizer_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_googleoptimizer_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_import_history`
--

DROP TABLE IF EXISTS `spg_import_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_import_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History record Id',
  `started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Started at',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `imported_file` varchar(255) DEFAULT NULL COMMENT 'Imported file',
  `execution_time` varchar(255) DEFAULT NULL COMMENT 'Execution time',
  `summary` varchar(255) DEFAULT NULL COMMENT 'Summary',
  `error_file` varchar(255) NOT NULL COMMENT 'Imported file with errors',
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Import history table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_import_history`
--

LOCK TABLES `spg_import_history` WRITE;
/*!40000 ALTER TABLE `spg_import_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_import_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_importexport_importdata`
--

DROP TABLE IF EXISTS `spg_importexport_importdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_importexport_importdata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity` varchar(50) NOT NULL COMMENT 'Entity',
  `behavior` varchar(10) NOT NULL DEFAULT 'append' COMMENT 'Behavior',
  `data` longtext COMMENT 'Data',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Import Data Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_importexport_importdata`
--

LOCK TABLES `spg_importexport_importdata` WRITE;
/*!40000 ALTER TABLE `spg_importexport_importdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_importexport_importdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_indexer_state`
--

DROP TABLE IF EXISTS `spg_indexer_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_indexer_state` (
  `state_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Indexer State Id',
  `indexer_id` varchar(255) DEFAULT NULL COMMENT 'Indexer Id',
  `status` varchar(16) DEFAULT 'invalid' COMMENT 'Indexer Status',
  `updated` datetime DEFAULT NULL COMMENT 'Indexer Status',
  `hash_config` varchar(32) NOT NULL COMMENT 'Hash of indexer config',
  PRIMARY KEY (`state_id`),
  KEY `SPG_INDEXER_STATE_INDEXER_ID` (`indexer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Indexer State';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_indexer_state`
--

LOCK TABLES `spg_indexer_state` WRITE;
/*!40000 ALTER TABLE `spg_indexer_state` DISABLE KEYS */;
INSERT INTO `spg_indexer_state` VALUES (1,'design_config_grid','valid','2017-02-03 09:42:18','27baa8fe6a5369f52c8b7cbd54a3c3c4'),(2,'customer_grid','valid','2017-02-03 07:47:51','d572ea00944c9e3f517b3f46bad058a4'),(3,'catalog_category_product','invalid','2017-02-03 07:47:51','57b48d3cf1fcd64abe6b01dea3173d02'),(4,'catalog_product_category','invalid','2017-02-03 07:47:51','9957f66909342cc58ff2703dcd268bf4'),(5,'catalog_product_price','invalid','2017-02-03 07:47:51','15a819a577a149220cd0722c291de721'),(6,'catalog_product_attribute','invalid','2017-02-03 07:47:51','77eed0bf72b16099d299d0ab47b74910'),(7,'cataloginventory_stock','invalid','2017-02-03 07:47:51','78a405fd852458c326c85096099d7d5e'),(8,'catalogrule_rule','invalid','2017-02-03 07:47:51','5afe3cacdcb52ec3a7e68dc245679021'),(9,'catalogrule_product','invalid','2017-02-03 07:47:51','0ebee9e52ed424273132e8227fe646f3'),(10,'catalogsearch_fulltext','valid','2017-02-03 07:48:28','4486b57e2021aa78b526c68c9af2dcab'),(11,'targetrule_product_rule','invalid','2017-02-03 07:47:51','018ccfe69cf2b4a1d117685d7ff87614'),(12,'targetrule_rule_product','invalid','2017-02-03 07:47:51','7bdbe05508e73152d5685acf8bf32f45'),(13,'salesrule_rule','valid','2017-02-03 07:50:37','0108f6aea42623cb10aab1e0b166632b');
/*!40000 ALTER TABLE `spg_indexer_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_integration`
--

DROP TABLE IF EXISTS `spg_integration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_integration` (
  `integration_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Integration ID',
  `name` varchar(255) NOT NULL COMMENT 'Integration name is displayed in the admin interface',
  `email` varchar(255) NOT NULL COMMENT 'Email address of the contact person',
  `endpoint` varchar(255) DEFAULT NULL COMMENT 'Endpoint for posting consumer credentials',
  `status` smallint(5) unsigned NOT NULL COMMENT 'Integration status',
  `consumer_id` int(10) unsigned DEFAULT NULL COMMENT 'Oauth consumer',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  `setup_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Integration type - manual or config file',
  `identity_link_url` varchar(255) DEFAULT NULL COMMENT 'Identity linking Url',
  PRIMARY KEY (`integration_id`),
  UNIQUE KEY `SPG_INTEGRATION_NAME` (`name`),
  UNIQUE KEY `SPG_INTEGRATION_CONSUMER_ID` (`consumer_id`),
  CONSTRAINT `SPG_INTEGRATION_CONSUMER_ID_SPG_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `spg_oauth_consumer` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='spg_integration';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_integration`
--

LOCK TABLES `spg_integration` WRITE;
/*!40000 ALTER TABLE `spg_integration` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_integration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_layout_link`
--

DROP TABLE IF EXISTS `spg_layout_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_layout_link` (
  `layout_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `theme_id` int(10) unsigned NOT NULL COMMENT 'Theme id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  `is_temporary` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Defines whether Layout Update is Temporary',
  PRIMARY KEY (`layout_link_id`),
  KEY `SPG_LAYOUT_LINK_LAYOUT_UPDATE_ID` (`layout_update_id`),
  KEY `SPG_LAYOUT_LINK_STORE_ID_THEME_ID_LAYOUT_UPDATE_ID_IS_TEMPORARY` (`store_id`,`theme_id`,`layout_update_id`,`is_temporary`),
  KEY `SPG_LAYOUT_LINK_THEME_ID_THEME_THEME_ID` (`theme_id`),
  CONSTRAINT `SPG_LAYOUT_LINK_LAYOUT_UPDATE_ID_LAYOUT_UPDATE_LAYOUT_UPDATE_ID` FOREIGN KEY (`layout_update_id`) REFERENCES `spg_layout_update` (`layout_update_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_LAYOUT_LINK_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_LAYOUT_LINK_THEME_ID_THEME_THEME_ID` FOREIGN KEY (`theme_id`) REFERENCES `spg_theme` (`theme_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Link';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_layout_link`
--

LOCK TABLES `spg_layout_link` WRITE;
/*!40000 ALTER TABLE `spg_layout_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_layout_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_layout_update`
--

DROP TABLE IF EXISTS `spg_layout_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_layout_update` (
  `layout_update_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Layout Update Id',
  `handle` varchar(255) DEFAULT NULL COMMENT 'Handle',
  `xml` text COMMENT 'Xml',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Update Timestamp',
  PRIMARY KEY (`layout_update_id`),
  KEY `SPG_LAYOUT_UPDATE_HANDLE` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Updates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_layout_update`
--

LOCK TABLES `spg_layout_update` WRITE;
/*!40000 ALTER TABLE `spg_layout_update` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_layout_update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_banner`
--

DROP TABLE IF EXISTS `spg_magento_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_banner` (
  `banner_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Banner Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `is_enabled` int(11) NOT NULL COMMENT 'Is Enabled',
  `types` varchar(255) DEFAULT NULL COMMENT 'Types',
  `is_ga_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Google Analytics Universals enabled',
  `ga_creative` text COMMENT 'Google Analytics Universals code',
  PRIMARY KEY (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Banner';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_banner`
--

LOCK TABLES `spg_magento_banner` WRITE;
/*!40000 ALTER TABLE `spg_magento_banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_banner_catalogrule`
--

DROP TABLE IF EXISTS `spg_magento_banner_catalogrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_banner_catalogrule` (
  `banner_id` int(10) unsigned NOT NULL COMMENT 'Banner Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  PRIMARY KEY (`banner_id`,`rule_id`),
  KEY `SPG_MAGENTO_BANNER_CATALOGRULE_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_F3B7A79671854559F54B4E293700ADB4` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_catalogrule` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_BANNER_CATRULE_BANNER_ID_MAGENTO_BANNER_BANNER_ID` FOREIGN KEY (`banner_id`) REFERENCES `spg_magento_banner` (`banner_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Banner Catalogrule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_banner_catalogrule`
--

LOCK TABLES `spg_magento_banner_catalogrule` WRITE;
/*!40000 ALTER TABLE `spg_magento_banner_catalogrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_banner_catalogrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_banner_content`
--

DROP TABLE IF EXISTS `spg_magento_banner_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_banner_content` (
  `banner_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Banner Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `banner_content` mediumtext COMMENT 'Banner Content',
  PRIMARY KEY (`banner_id`,`store_id`),
  KEY `SPG_MAGENTO_BANNER_CONTENT_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_MAGENTO_BANNER_CONTENT_BANNER_ID_MAGENTO_BANNER_BANNER_ID` FOREIGN KEY (`banner_id`) REFERENCES `spg_magento_banner` (`banner_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_BANNER_CONTENT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Banner Content';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_banner_content`
--

LOCK TABLES `spg_magento_banner_content` WRITE;
/*!40000 ALTER TABLE `spg_magento_banner_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_banner_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_banner_customersegment`
--

DROP TABLE IF EXISTS `spg_magento_banner_customersegment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_banner_customersegment` (
  `banner_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Banner Id',
  `segment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Segment Id',
  PRIMARY KEY (`banner_id`,`segment_id`),
  KEY `SPG_MAGENTO_BANNER_CUSTOMERSEGMENT_SEGMENT_ID` (`segment_id`),
  CONSTRAINT `FK_67E06EA331E133F6F0184F548E8CB6B1` FOREIGN KEY (`banner_id`) REFERENCES `spg_magento_banner` (`banner_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_94C118E7C9C17BCA6468D88DA07208C4` FOREIGN KEY (`segment_id`) REFERENCES `spg_magento_customersegment_segment` (`segment_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Banner Customersegment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_banner_customersegment`
--

LOCK TABLES `spg_magento_banner_customersegment` WRITE;
/*!40000 ALTER TABLE `spg_magento_banner_customersegment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_banner_customersegment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_banner_salesrule`
--

DROP TABLE IF EXISTS `spg_magento_banner_salesrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_banner_salesrule` (
  `banner_id` int(10) unsigned NOT NULL COMMENT 'Banner Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  PRIMARY KEY (`banner_id`,`rule_id`),
  KEY `SPG_MAGENTO_BANNER_SALESRULE_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_3C01E7D187D1CF62EB5174807600CE6B` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_salesrule` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_BANNER_SALESRULE_BANNER_ID_MAGENTO_BANNER_BANNER_ID` FOREIGN KEY (`banner_id`) REFERENCES `spg_magento_banner` (`banner_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Banner Salesrule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_banner_salesrule`
--

LOCK TABLES `spg_magento_banner_salesrule` WRITE;
/*!40000 ALTER TABLE `spg_magento_banner_salesrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_banner_salesrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_catalogevent_event`
--

DROP TABLE IF EXISTS `spg_magento_catalogevent_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_catalogevent_event` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT 'Category Id',
  `date_start` datetime DEFAULT NULL COMMENT 'Date Start',
  `date_end` datetime DEFAULT NULL COMMENT 'Date End',
  `display_state` smallint(5) unsigned DEFAULT '0' COMMENT 'Display State',
  `sort_order` int(10) unsigned DEFAULT NULL COMMENT 'Sort Order',
  `status` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Status',
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `SPG_MAGENTO_CATALOGEVENT_EVENT_CATEGORY_ID` (`category_id`),
  KEY `SPG_MAGENTO_CATALOGEVENT_EVENT_DATE_START_DATE_END` (`date_start`,`date_end`),
  CONSTRAINT `FK_B53500590C9CACA061343DB1D4295878` FOREIGN KEY (`category_id`) REFERENCES `spg_sequence_catalog_category` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Catalogevent Event';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_catalogevent_event`
--

LOCK TABLES `spg_magento_catalogevent_event` WRITE;
/*!40000 ALTER TABLE `spg_magento_catalogevent_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_catalogevent_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_catalogevent_event_image`
--

DROP TABLE IF EXISTS `spg_magento_catalogevent_event_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_catalogevent_event_image` (
  `event_id` int(10) unsigned NOT NULL COMMENT 'Event Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `image` varchar(255) NOT NULL COMMENT 'Image',
  PRIMARY KEY (`event_id`,`store_id`),
  KEY `SPG_MAGENTO_CATALOGEVENT_EVENT_IMAGE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_730F10788F432ECC3A78CB787C23994A` FOREIGN KEY (`event_id`) REFERENCES `spg_magento_catalogevent_event` (`event_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_CATALOGEVENT_EVENT_IMAGE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Catalogevent Event Image';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_catalogevent_event_image`
--

LOCK TABLES `spg_magento_catalogevent_event_image` WRITE;
/*!40000 ALTER TABLE `spg_magento_catalogevent_event_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_catalogevent_event_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_catalogpermissions`
--

DROP TABLE IF EXISTS `spg_magento_catalogpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_catalogpermissions` (
  `permission_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Permission Id',
  `category_id` int(10) unsigned NOT NULL COMMENT 'Category Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Group Id',
  `grant_catalog_category_view` smallint(6) NOT NULL COMMENT 'Grant Catalog Category View',
  `grant_catalog_product_price` smallint(6) NOT NULL COMMENT 'Grant Catalog Product Price',
  `grant_checkout_items` smallint(6) NOT NULL COMMENT 'Grant Checkout Items',
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `SPG_MAGENTO_CATPERMISSIONS_CTGR_ID_WS_ID_CSTR_GROUP_ID` (`category_id`,`website_id`,`customer_group_id`),
  KEY `SPG_MAGENTO_CATALOGPERMISSIONS_WEBSITE_ID` (`website_id`),
  KEY `SPG_MAGENTO_CATALOGPERMISSIONS_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_13E70580C32607CABEE9ECFF79C19F88` FOREIGN KEY (`category_id`) REFERENCES `spg_sequence_catalog_category` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `FK_4E6E7B9A0FE8575265ED142A35EDA4B2` FOREIGN KEY (`customer_group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_CATPERMISSIONS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Catalogpermissions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_catalogpermissions`
--

LOCK TABLES `spg_magento_catalogpermissions` WRITE;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_catalogpermissions_index`
--

DROP TABLE IF EXISTS `spg_magento_catalogpermissions_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_catalogpermissions_index` (
  `category_id` int(10) unsigned NOT NULL COMMENT 'Category Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `grant_catalog_category_view` smallint(6) DEFAULT NULL COMMENT 'Grant Catalog Category View',
  `grant_catalog_product_price` smallint(6) DEFAULT NULL COMMENT 'Grant Catalog Product Price',
  `grant_checkout_items` smallint(6) DEFAULT NULL COMMENT 'Grant Checkout Items',
  UNIQUE KEY `SPG_MAGENTO_CATPERMISSIONS_IDX_CTGR_ID_WS_ID_CSTR_GROUP_ID` (`category_id`,`website_id`,`customer_group_id`),
  KEY `SPG_MAGENTO_CATALOGPERMISSIONS_INDEX_WEBSITE_ID` (`website_id`),
  KEY `SPG_MAGENTO_CATALOGPERMISSIONS_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Catalogpermissions Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_catalogpermissions_index`
--

LOCK TABLES `spg_magento_catalogpermissions_index` WRITE;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_catalogpermissions_index_product`
--

DROP TABLE IF EXISTS `spg_magento_catalogpermissions_index_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_catalogpermissions_index_product` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `grant_catalog_category_view` smallint(6) DEFAULT NULL COMMENT 'Grant Catalog Category View',
  `grant_catalog_product_price` smallint(6) DEFAULT NULL COMMENT 'Grant Catalog Product Price',
  `grant_checkout_items` smallint(6) DEFAULT NULL COMMENT 'Grant Checkout Items',
  UNIQUE KEY `SPG_MAGENTO_CATPERMISSIONS_IDX_PRD_PRD_ID_STORE_ID_CSTR_GROUP_ID` (`product_id`,`store_id`,`customer_group_id`),
  KEY `SPG_MAGENTO_CATALOGPERMISSIONS_INDEX_PRODUCT_STORE_ID` (`store_id`),
  KEY `SPG_MAGENTO_CATALOGPERMISSIONS_INDEX_PRODUCT_CUSTOMER_GROUP_ID` (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Catalogpermissions Index Product';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_catalogpermissions_index_product`
--

LOCK TABLES `spg_magento_catalogpermissions_index_product` WRITE;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions_index_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions_index_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_catalogpermissions_index_product_tmp`
--

DROP TABLE IF EXISTS `spg_magento_catalogpermissions_index_product_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_catalogpermissions_index_product_tmp` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `grant_catalog_category_view` smallint(6) DEFAULT NULL COMMENT 'Grant Catalog Category View',
  `grant_catalog_product_price` smallint(6) DEFAULT NULL COMMENT 'Grant Catalog Product Price',
  `grant_checkout_items` smallint(6) DEFAULT NULL COMMENT 'Grant Checkout Items',
  UNIQUE KEY `UNQ_5CBC22B3F175246D218BF8689C923B85` (`product_id`,`store_id`,`customer_group_id`),
  KEY `SPG_MAGENTO_CATALOGPERMISSIONS_INDEX_PRODUCT_TMP_STORE_ID` (`store_id`),
  KEY `SPG_MAGENTO_CATPERMISSIONS_IDX_PRD_TMP_CSTR_GROUP_ID` (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Permissions Temporary Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_catalogpermissions_index_product_tmp`
--

LOCK TABLES `spg_magento_catalogpermissions_index_product_tmp` WRITE;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions_index_product_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions_index_product_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_catalogpermissions_index_tmp`
--

DROP TABLE IF EXISTS `spg_magento_catalogpermissions_index_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_catalogpermissions_index_tmp` (
  `category_id` int(10) unsigned NOT NULL COMMENT 'Category Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `grant_catalog_category_view` smallint(6) DEFAULT NULL COMMENT 'Grant Catalog Category View',
  `grant_catalog_product_price` smallint(6) DEFAULT NULL COMMENT 'Grant Catalog Product Price',
  `grant_checkout_items` smallint(6) DEFAULT NULL COMMENT 'Grant Checkout Items',
  UNIQUE KEY `SPG_MAGENTO_CATPERMISSIONS_IDX_CTGR_ID_WS_ID_CSTR_GROUP_ID` (`category_id`,`website_id`,`customer_group_id`),
  KEY `SPG_MAGENTO_CATALOGPERMISSIONS_INDEX_WEBSITE_ID` (`website_id`),
  KEY `SPG_MAGENTO_CATALOGPERMISSIONS_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Permissions Temporary Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_catalogpermissions_index_tmp`
--

LOCK TABLES `spg_magento_catalogpermissions_index_tmp` WRITE;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions_index_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_catalogpermissions_index_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customerbalance`
--

DROP TABLE IF EXISTS `spg_magento_customerbalance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customerbalance` (
  `balance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Balance Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Balance Amount',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  PRIMARY KEY (`balance_id`),
  UNIQUE KEY `SPG_MAGENTO_CUSTOMERBALANCE_CUSTOMER_ID_WEBSITE_ID` (`customer_id`,`website_id`),
  KEY `SPG_MAGENTO_CUSTOMERBALANCE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_MAGENTO_CSTRBALANCE_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_CUSTOMERBALANCE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customerbalance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customerbalance`
--

LOCK TABLES `spg_magento_customerbalance` WRITE;
/*!40000 ALTER TABLE `spg_magento_customerbalance` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customerbalance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customerbalance_history`
--

DROP TABLE IF EXISTS `spg_magento_customerbalance_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customerbalance_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `balance_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Balance Id',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `action` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Action',
  `balance_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Balance Amount',
  `balance_delta` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Balance Delta',
  `additional_info` varchar(255) DEFAULT NULL COMMENT 'Additional Info',
  `is_customer_notified` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Customer Notified',
  PRIMARY KEY (`history_id`),
  KEY `SPG_MAGENTO_CUSTOMERBALANCE_HISTORY_BALANCE_ID` (`balance_id`),
  CONSTRAINT `FK_88E803860C27F23FBFD6D9D097D80EB7` FOREIGN KEY (`balance_id`) REFERENCES `spg_magento_customerbalance` (`balance_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customerbalance History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customerbalance_history`
--

LOCK TABLES `spg_magento_customerbalance_history` WRITE;
/*!40000 ALTER TABLE `spg_magento_customerbalance_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customerbalance_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customercustomattributes_sales_flat_order`
--

DROP TABLE IF EXISTS `spg_magento_customercustomattributes_sales_flat_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customercustomattributes_sales_flat_order` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  PRIMARY KEY (`entity_id`),
  CONSTRAINT `FK_F55F4D6132EAA6A74FD597977020244D` FOREIGN KEY (`entity_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customer Sales Flat Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customercustomattributes_sales_flat_order`
--

LOCK TABLES `spg_magento_customercustomattributes_sales_flat_order` WRITE;
/*!40000 ALTER TABLE `spg_magento_customercustomattributes_sales_flat_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customercustomattributes_sales_flat_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customercustomattributes_sales_flat_order_address`
--

DROP TABLE IF EXISTS `spg_magento_customercustomattributes_sales_flat_order_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customercustomattributes_sales_flat_order_address` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  PRIMARY KEY (`entity_id`),
  CONSTRAINT `FK_90DA74E6898A6BB231DE78E773FB7FE8` FOREIGN KEY (`entity_id`) REFERENCES `spg_sales_order_address` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customer Sales Flat Order Address';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customercustomattributes_sales_flat_order_address`
--

LOCK TABLES `spg_magento_customercustomattributes_sales_flat_order_address` WRITE;
/*!40000 ALTER TABLE `spg_magento_customercustomattributes_sales_flat_order_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customercustomattributes_sales_flat_order_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customercustomattributes_sales_flat_quote`
--

DROP TABLE IF EXISTS `spg_magento_customercustomattributes_sales_flat_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customercustomattributes_sales_flat_quote` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  PRIMARY KEY (`entity_id`),
  CONSTRAINT `FK_D3DCC13C72B77D040A8538692C382031` FOREIGN KEY (`entity_id`) REFERENCES `spg_quote` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customer Sales Flat Quote';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customercustomattributes_sales_flat_quote`
--

LOCK TABLES `spg_magento_customercustomattributes_sales_flat_quote` WRITE;
/*!40000 ALTER TABLE `spg_magento_customercustomattributes_sales_flat_quote` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customercustomattributes_sales_flat_quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customercustomattributes_sales_flat_quote_address`
--

DROP TABLE IF EXISTS `spg_magento_customercustomattributes_sales_flat_quote_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customercustomattributes_sales_flat_quote_address` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  PRIMARY KEY (`entity_id`),
  CONSTRAINT `FK_D864CC56A93F6B83B1524B8A038151C0` FOREIGN KEY (`entity_id`) REFERENCES `spg_quote_address` (`address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customer Sales Flat Quote Address';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customercustomattributes_sales_flat_quote_address`
--

LOCK TABLES `spg_magento_customercustomattributes_sales_flat_quote_address` WRITE;
/*!40000 ALTER TABLE `spg_magento_customercustomattributes_sales_flat_quote_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customercustomattributes_sales_flat_quote_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customersegment_customer`
--

DROP TABLE IF EXISTS `spg_magento_customersegment_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customersegment_customer` (
  `segment_id` int(10) unsigned NOT NULL COMMENT 'Segment Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Added Date',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated Date',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`segment_id`,`customer_id`,`website_id`),
  UNIQUE KEY `SPG_MAGENTO_CSTRSEGMENT_CSTR_SEGMENT_ID_WS_ID_CSTR_ID` (`segment_id`,`website_id`,`customer_id`),
  KEY `SPG_MAGENTO_CUSTOMERSEGMENT_CUSTOMER_WEBSITE_ID` (`website_id`),
  KEY `SPG_MAGENTO_CUSTOMERSEGMENT_CUSTOMER_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_B13A7ECFA409C20A2A537ECF842959AE` FOREIGN KEY (`segment_id`) REFERENCES `spg_magento_customersegment_segment` (`segment_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_CSTRSEGMENT_CSTR_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_CSTRSEGMENT_CSTR_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customersegment Customer';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customersegment_customer`
--

LOCK TABLES `spg_magento_customersegment_customer` WRITE;
/*!40000 ALTER TABLE `spg_magento_customersegment_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customersegment_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customersegment_event`
--

DROP TABLE IF EXISTS `spg_magento_customersegment_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customersegment_event` (
  `segment_id` int(10) unsigned NOT NULL COMMENT 'Segment Id',
  `event` varchar(255) DEFAULT NULL COMMENT 'Event',
  KEY `SPG_MAGENTO_CUSTOMERSEGMENT_EVENT_EVENT` (`event`),
  KEY `SPG_MAGENTO_CUSTOMERSEGMENT_EVENT_SEGMENT_ID` (`segment_id`),
  CONSTRAINT `FK_B72F29B5EB7BF7FF7EC4B618F2455F3E` FOREIGN KEY (`segment_id`) REFERENCES `spg_magento_customersegment_segment` (`segment_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customersegment Event';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customersegment_event`
--

LOCK TABLES `spg_magento_customersegment_event` WRITE;
/*!40000 ALTER TABLE `spg_magento_customersegment_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customersegment_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customersegment_segment`
--

DROP TABLE IF EXISTS `spg_magento_customersegment_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customersegment_segment` (
  `segment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Segment Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `processing_frequency` int(11) NOT NULL COMMENT 'Processing Frequency',
  `condition_sql` mediumtext COMMENT 'Condition Sql',
  `apply_to` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer types to which this segment applies',
  PRIMARY KEY (`segment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customersegment Segment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customersegment_segment`
--

LOCK TABLES `spg_magento_customersegment_segment` WRITE;
/*!40000 ALTER TABLE `spg_magento_customersegment_segment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customersegment_segment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_customersegment_website`
--

DROP TABLE IF EXISTS `spg_magento_customersegment_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_customersegment_website` (
  `segment_id` int(10) unsigned NOT NULL COMMENT 'Segment Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`segment_id`,`website_id`),
  KEY `SPG_MAGENTO_CUSTOMERSEGMENT_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_7C011EA9515922415BCB4E5EA817C4C5` FOREIGN KEY (`segment_id`) REFERENCES `spg_magento_customersegment_segment` (`segment_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_CSTRSEGMENT_WS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Customersegment Website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_customersegment_website`
--

LOCK TABLES `spg_magento_customersegment_website` WRITE;
/*!40000 ALTER TABLE `spg_magento_customersegment_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_customersegment_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftcard_amount`
--

DROP TABLE IF EXISTS `spg_magento_giftcard_amount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftcard_amount` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `row_id` int(11) DEFAULT NULL COMMENT 'Row id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`value_id`),
  KEY `SPG_MAGENTO_GIFTCARD_AMOUNT_ENTITY_ID` (`row_id`),
  KEY `SPG_MAGENTO_GIFTCARD_AMOUNT_WEBSITE_ID` (`website_id`),
  KEY `SPG_MAGENTO_GIFTCARD_AMOUNT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_MAGENTO_GIFTCARD_AMOUNT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_GIFTCARD_AMOUNT_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Giftcard Amount';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftcard_amount`
--

LOCK TABLES `spg_magento_giftcard_amount` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftcard_amount` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftcard_amount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftcardaccount`
--

DROP TABLE IF EXISTS `spg_magento_giftcardaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftcardaccount` (
  `giftcardaccount_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Giftcardaccount Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `status` smallint(6) NOT NULL COMMENT 'Status',
  `date_created` date NOT NULL COMMENT 'Date Created',
  `date_expires` date DEFAULT NULL COMMENT 'Date Expires',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `balance` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Balance',
  `state` smallint(6) NOT NULL DEFAULT '0' COMMENT 'State',
  `is_redeemable` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Redeemable',
  PRIMARY KEY (`giftcardaccount_id`),
  KEY `SPG_MAGENTO_GIFTCARDACCOUNT_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_MAGENTO_GIFTCARDACCOUNT_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Giftcardaccount';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftcardaccount`
--

LOCK TABLES `spg_magento_giftcardaccount` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftcardaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftcardaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftcardaccount_history`
--

DROP TABLE IF EXISTS `spg_magento_giftcardaccount_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftcardaccount_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `giftcardaccount_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Giftcardaccount Id',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `action` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Action',
  `balance_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Balance Amount',
  `balance_delta` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Balance Delta',
  `additional_info` varchar(255) DEFAULT NULL COMMENT 'Additional Info',
  PRIMARY KEY (`history_id`),
  KEY `SPG_MAGENTO_GIFTCARDACCOUNT_HISTORY_GIFTCARDACCOUNT_ID` (`giftcardaccount_id`),
  CONSTRAINT `FK_5EE565D605AC76CF56453B6B46700D0B` FOREIGN KEY (`giftcardaccount_id`) REFERENCES `spg_magento_giftcardaccount` (`giftcardaccount_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Giftcardaccount History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftcardaccount_history`
--

LOCK TABLES `spg_magento_giftcardaccount_history` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftcardaccount_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftcardaccount_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftcardaccount_pool`
--

DROP TABLE IF EXISTS `spg_magento_giftcardaccount_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftcardaccount_pool` (
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Giftcardaccount Pool';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftcardaccount_pool`
--

LOCK TABLES `spg_magento_giftcardaccount_pool` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftcardaccount_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftcardaccount_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftregistry_data`
--

DROP TABLE IF EXISTS `spg_magento_giftregistry_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftregistry_data` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `event_date` date DEFAULT NULL COMMENT 'Event Date',
  `event_country` varchar(3) DEFAULT NULL COMMENT 'Event Country',
  `event_country_region` int(11) DEFAULT NULL COMMENT 'Event Country Region',
  `event_country_region_text` varchar(30) DEFAULT NULL COMMENT 'Event Country Region Text',
  `event_location` varchar(255) DEFAULT NULL COMMENT 'Event Location',
  PRIMARY KEY (`entity_id`),
  CONSTRAINT `FK_4109397AD4A0EDDE11CF3CED53FC7CC4` FOREIGN KEY (`entity_id`) REFERENCES `spg_magento_giftregistry_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Registry Data Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftregistry_data`
--

LOCK TABLES `spg_magento_giftregistry_data` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftregistry_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftregistry_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftregistry_entity`
--

DROP TABLE IF EXISTS `spg_magento_giftregistry_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftregistry_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Type Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `is_public` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Public',
  `url_key` varchar(100) DEFAULT NULL COMMENT 'Url Key',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `message` text NOT NULL COMMENT 'Message',
  `shipping_address` blob COMMENT 'Shipping Address',
  `custom_values` text COMMENT 'Custom Values',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_MAGENTO_GIFTREGISTRY_ENTITY_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_MAGENTO_GIFTREGISTRY_ENTITY_WEBSITE_ID` (`website_id`),
  KEY `SPG_MAGENTO_GIFTREGISTRY_ENTITY_TYPE_ID` (`type_id`),
  CONSTRAINT `FK_2EB7DCF92ADBBFD4F8ABCA9133BD59C4` FOREIGN KEY (`type_id`) REFERENCES `spg_magento_giftregistry_type` (`type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_GIFTREGISTRY_ENTT_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_GIFTREGISTRY_ENTT_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Registry Entity Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftregistry_entity`
--

LOCK TABLES `spg_magento_giftregistry_entity` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftregistry_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftregistry_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftregistry_item`
--

DROP TABLE IF EXISTS `spg_magento_giftregistry_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftregistry_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `qty_fulfilled` decimal(12,4) DEFAULT NULL COMMENT 'Qty Fulfilled',
  `note` text COMMENT 'Note',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Added At',
  `custom_options` text COMMENT 'Custom Options',
  PRIMARY KEY (`item_id`),
  KEY `SPG_MAGENTO_GIFTREGISTRY_ITEM_ENTITY_ID` (`entity_id`),
  KEY `SPG_MAGENTO_GIFTREGISTRY_ITEM_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_02C6819EFB0DE630E0572AABC8F0D74D` FOREIGN KEY (`entity_id`) REFERENCES `spg_magento_giftregistry_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_CFFF4E738A81B7D0A194A491ED357874` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Registry Item Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftregistry_item`
--

LOCK TABLES `spg_magento_giftregistry_item` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftregistry_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftregistry_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftregistry_item_option`
--

DROP TABLE IF EXISTS `spg_magento_giftregistry_item_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftregistry_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `FK_7A018163912879035B7663FC4C536D4F` (`item_id`),
  CONSTRAINT `FK_7A018163912879035B7663FC4C536D4F` FOREIGN KEY (`item_id`) REFERENCES `spg_magento_giftregistry_item` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Registry Item Option Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftregistry_item_option`
--

LOCK TABLES `spg_magento_giftregistry_item_option` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftregistry_item_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftregistry_item_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftregistry_label`
--

DROP TABLE IF EXISTS `spg_magento_giftregistry_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftregistry_label` (
  `type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Type Id',
  `attribute_code` varchar(32) NOT NULL COMMENT 'Attribute Code',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `option_code` varchar(32) NOT NULL COMMENT 'Option Code',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  PRIMARY KEY (`type_id`,`attribute_code`,`store_id`,`option_code`),
  KEY `SPG_MAGENTO_GIFTREGISTRY_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_347409125285FE2AE5EA5D12DE2593A2` FOREIGN KEY (`type_id`) REFERENCES `spg_magento_giftregistry_type` (`type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_GIFTREGISTRY_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Registry Label Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftregistry_label`
--

LOCK TABLES `spg_magento_giftregistry_label` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftregistry_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftregistry_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftregistry_person`
--

DROP TABLE IF EXISTS `spg_magento_giftregistry_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftregistry_person` (
  `person_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Person Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `firstname` varchar(100) DEFAULT NULL COMMENT 'Firstname',
  `lastname` varchar(100) DEFAULT NULL COMMENT 'Lastname',
  `email` varchar(150) DEFAULT NULL COMMENT 'Email',
  `role` varchar(32) DEFAULT NULL COMMENT 'Role',
  `custom_values` text NOT NULL COMMENT 'Custom Values',
  PRIMARY KEY (`person_id`),
  KEY `SPG_MAGENTO_GIFTREGISTRY_PERSON_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_D6B938E375211B3F874CC43C132E28E6` FOREIGN KEY (`entity_id`) REFERENCES `spg_magento_giftregistry_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Registry Person Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftregistry_person`
--

LOCK TABLES `spg_magento_giftregistry_person` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftregistry_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftregistry_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftregistry_type`
--

DROP TABLE IF EXISTS `spg_magento_giftregistry_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftregistry_type` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type Id',
  `code` varchar(15) DEFAULT NULL COMMENT 'Code',
  `meta_xml` blob COMMENT 'Meta Xml',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Registry Type Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftregistry_type`
--

LOCK TABLES `spg_magento_giftregistry_type` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftregistry_type` DISABLE KEYS */;
INSERT INTO `spg_magento_giftregistry_type` VALUES (1,'birthday','<config><prototype><registry><event_date><label>Event Date</label><group>event_information</group><type>date</type><sort_order>5</sort_order><date_format>3</date_format><frontend><is_required>1</is_required><is_searcheable>1</is_searcheable><is_listed>1</is_listed></frontend></event_date><event_country><label>Country</label><group>event_information</group><type>country</type><sort_order>1</sort_order><show_region>1</show_region><frontend><is_required>1</is_required><is_searcheable>1</is_searcheable><is_listed>1</is_listed></frontend></event_country></registry></prototype></config>'),(2,'baby_registry','<config><prototype><registrant><role><label>Role</label><group>registrant</group><type>select</type><sort_order>1</sort_order><options><mom>Mother</mom><dad>Father</dad></options><frontend><is_required>1</is_required><is_searcheable>1</is_searcheable><is_listed>1</is_listed></frontend></role></registrant><registry><baby_gender><label>Baby Gender</label><group>registry</group><type>select</type><sort_order>5</sort_order><options><boy>Boy</boy><girl>Girl</girl><surprise>Surprise</surprise></options><default>surprise</default><frontend><is_required>1</is_required></frontend></baby_gender><event_country><label>Country</label><group>event_information</group><type>country</type><sort_order>1</sort_order><show_region>1</show_region><frontend><is_required>1</is_required><is_searcheable>1</is_searcheable><is_listed>1</is_listed></frontend></event_country></registry></prototype></config>'),(3,'wedding','<config><prototype><registrant><role><label>Role</label><group>registrant</group><type>select</type><sort_order>20</sort_order><options><groom>Groom</groom><bride>Bride</bride><partner>Partner</partner></options><frontend><is_required>1</is_required><is_searcheable>0</is_searcheable><is_listed>1</is_listed></frontend></role></registrant><registry><event_country><label>Country</label><group>event_information</group><type>country</type><sort_order>1</sort_order><show_region>1</show_region><frontend><is_required>1</is_required><is_searcheable>1</is_searcheable><is_listed>1</is_listed></frontend></event_country><event_date><label>Wedding Date</label><group>event_information</group><type>date</type><sort_order>5</sort_order><date_format>3</date_format><frontend><is_required>1</is_required><is_searcheable>1</is_searcheable><is_listed>1</is_listed></frontend></event_date><event_location><label>Location</label><group>event_information</group><type>text</type><sort_order>10</sort_order><frontend><is_required>1</is_required><is_searcheable>1</is_searcheable><is_listed>1</is_listed></frontend></event_location><number_of_guests><label>Number of Guests</label><group>event_information</group><type>text</type><sort_order>15</sort_order><frontend><is_required>1</is_required></frontend></number_of_guests></registry></prototype></config>');
/*!40000 ALTER TABLE `spg_magento_giftregistry_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftregistry_type_info`
--

DROP TABLE IF EXISTS `spg_magento_giftregistry_type_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftregistry_type_info` (
  `type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Type Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `is_listed` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Listed',
  `sort_order` smallint(5) unsigned DEFAULT NULL COMMENT 'Sort Order',
  PRIMARY KEY (`type_id`,`store_id`),
  KEY `SPG_MAGENTO_GIFTREGISTRY_TYPE_INFO_STORE_ID` (`store_id`),
  CONSTRAINT `FK_5270493C9060011161D97264B4A9BAFF` FOREIGN KEY (`type_id`) REFERENCES `spg_magento_giftregistry_type` (`type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_GIFTREGISTRY_TYPE_INFO_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Registry Info Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftregistry_type_info`
--

LOCK TABLES `spg_magento_giftregistry_type_info` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftregistry_type_info` DISABLE KEYS */;
INSERT INTO `spg_magento_giftregistry_type_info` VALUES (1,0,'Birthday',1,1),(2,0,'Baby Registry',1,5),(3,0,'Wedding',1,10);
/*!40000 ALTER TABLE `spg_magento_giftregistry_type_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftwrapping`
--

DROP TABLE IF EXISTS `spg_magento_giftwrapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftwrapping` (
  `wrapping_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wrapping Id',
  `status` smallint(5) unsigned NOT NULL COMMENT 'Status',
  `base_price` decimal(12,4) NOT NULL COMMENT 'Base Price',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  PRIMARY KEY (`wrapping_id`),
  KEY `SPG_MAGENTO_GIFTWRAPPING_STATUS` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Wrapping Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftwrapping`
--

LOCK TABLES `spg_magento_giftwrapping` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftwrapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftwrapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftwrapping_store_attributes`
--

DROP TABLE IF EXISTS `spg_magento_giftwrapping_store_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftwrapping_store_attributes` (
  `wrapping_id` int(10) unsigned NOT NULL COMMENT 'Wrapping Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `design` varchar(255) NOT NULL COMMENT 'Design',
  PRIMARY KEY (`wrapping_id`,`store_id`),
  KEY `SPG_MAGENTO_GIFTWRAPPING_STORE_ATTRIBUTES_STORE_ID` (`store_id`),
  CONSTRAINT `FK_FAE26808C0AC766DF5CC6D3A14008A48` FOREIGN KEY (`wrapping_id`) REFERENCES `spg_magento_giftwrapping` (`wrapping_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_GIFTWRAPPING_STORE_ATTRS_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Wrapping Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftwrapping_store_attributes`
--

LOCK TABLES `spg_magento_giftwrapping_store_attributes` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftwrapping_store_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftwrapping_store_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_giftwrapping_website`
--

DROP TABLE IF EXISTS `spg_magento_giftwrapping_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_giftwrapping_website` (
  `wrapping_id` int(10) unsigned NOT NULL COMMENT 'Wrapping Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`wrapping_id`,`website_id`),
  KEY `SPG_MAGENTO_GIFTWRAPPING_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_0898062E185958424068DD9E68AA5F44` FOREIGN KEY (`wrapping_id`) REFERENCES `spg_magento_giftwrapping` (`wrapping_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_GIFTWRAPPING_WS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Gift Wrapping Website Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_giftwrapping_website`
--

LOCK TABLES `spg_magento_giftwrapping_website` WRITE;
/*!40000 ALTER TABLE `spg_magento_giftwrapping_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_giftwrapping_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_invitation`
--

DROP TABLE IF EXISTS `spg_magento_invitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_invitation` (
  `invitation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Invitation Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `invitation_date` timestamp NULL DEFAULT NULL COMMENT 'Invitation Date',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `referral_id` int(10) unsigned DEFAULT NULL COMMENT 'Referral Id',
  `protection_code` varchar(32) DEFAULT NULL COMMENT 'Protection Code',
  `signup_date` timestamp NULL DEFAULT NULL COMMENT 'Signup Date',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `group_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Group Id',
  `message` text COMMENT 'Message',
  `status` varchar(8) NOT NULL DEFAULT 'new' COMMENT 'Status',
  PRIMARY KEY (`invitation_id`),
  KEY `SPG_MAGENTO_INVITATION_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_MAGENTO_INVITATION_REFERRAL_ID` (`referral_id`),
  KEY `SPG_MAGENTO_INVITATION_STORE_ID` (`store_id`),
  KEY `SPG_MAGENTO_INVITATION_GROUP_ID` (`group_id`),
  CONSTRAINT `SPG_MAGENTO_INVITATION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_MAGENTO_INVITATION_GROUP_ID_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_MAGENTO_INVITATION_REFERRAL_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`referral_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_MAGENTO_INVITATION_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Invitation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_invitation`
--

LOCK TABLES `spg_magento_invitation` WRITE;
/*!40000 ALTER TABLE `spg_magento_invitation` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_invitation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_invitation_status_history`
--

DROP TABLE IF EXISTS `spg_magento_invitation_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_invitation_status_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `invitation_id` int(10) unsigned NOT NULL COMMENT 'Invitation Id',
  `invitation_date` timestamp NULL DEFAULT NULL COMMENT 'Invitation Date',
  `status` varchar(8) NOT NULL DEFAULT 'new' COMMENT 'Invitation Status',
  PRIMARY KEY (`history_id`),
  KEY `SPG_MAGENTO_INVITATION_STATUS_HISTORY_INVITATION_ID` (`invitation_id`),
  CONSTRAINT `FK_36108327B046A14647DBECA6D2400CB4` FOREIGN KEY (`invitation_id`) REFERENCES `spg_magento_invitation` (`invitation_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Invitation Status History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_invitation_status_history`
--

LOCK TABLES `spg_magento_invitation_status_history` WRITE;
/*!40000 ALTER TABLE `spg_magento_invitation_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_invitation_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_invitation_track`
--

DROP TABLE IF EXISTS `spg_magento_invitation_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_invitation_track` (
  `track_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Track Id',
  `inviter_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Inviter Id',
  `referral_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Referral Id',
  PRIMARY KEY (`track_id`),
  UNIQUE KEY `SPG_MAGENTO_INVITATION_TRACK_INVITER_ID_REFERRAL_ID` (`inviter_id`,`referral_id`),
  KEY `SPG_MAGENTO_INVITATION_TRACK_REFERRAL_ID` (`referral_id`),
  CONSTRAINT `SPG_MAGENTO_INVITATION_TRACK_INVITER_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`inviter_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_INVITATION_TRACK_REFERRAL_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`referral_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Invitation Track';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_invitation_track`
--

LOCK TABLES `spg_magento_invitation_track` WRITE;
/*!40000 ALTER TABLE `spg_magento_invitation_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_invitation_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_logging_event`
--

DROP TABLE IF EXISTS `spg_magento_logging_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_logging_event` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Log Id',
  `ip` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Ip address',
  `x_forwarded_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Real ip address if visitor used proxy',
  `event_code` varchar(100) DEFAULT NULL COMMENT 'Event Code',
  `time` timestamp NULL DEFAULT NULL COMMENT 'Even date',
  `action` varchar(20) DEFAULT NULL COMMENT 'Event action',
  `info` varchar(255) DEFAULT NULL COMMENT 'Additional information',
  `status` varchar(15) DEFAULT NULL COMMENT 'Status',
  `user` varchar(40) DEFAULT NULL COMMENT 'User name',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'User Id',
  `fullaction` varchar(200) DEFAULT NULL COMMENT 'Full action description',
  `error_message` text COMMENT 'Error Message',
  PRIMARY KEY (`log_id`),
  KEY `SPG_MAGENTO_LOGGING_EVENT_USER_ID` (`user_id`),
  KEY `SPG_MAGENTO_LOGGING_EVENT_USER` (`user`),
  CONSTRAINT `SPG_MAGENTO_LOGGING_EVENT_USER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `spg_admin_user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8 COMMENT='Enterprise Logging Event';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_logging_event`
--

LOCK TABLES `spg_magento_logging_event` WRITE;
/*!40000 ALTER TABLE `spg_magento_logging_event` DISABLE KEYS */;
INSERT INTO `spg_magento_logging_event` VALUES (1,2130706433,0,'admin_login','2017-02-03 08:01:13','login','a:1:{s:7:\"general\";N;}','success','admin',1,'adminhtml_index_index',NULL),(2,2130706433,0,'admin_login','2017-02-03 09:09:54','login','a:1:{s:7:\"general\";N;}','success','admin',1,'adminhtml_index_index',NULL),(3,2130706433,0,'catalog_categories','2017-02-03 09:16:19','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(4,2130706433,0,'catalog_categories','2017-02-03 09:17:32','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(5,2130706433,0,'catalog_categories','2017-02-03 09:18:07','save','a:1:{s:7:\"general\";s:4:\"2, 3\";}','success','admin',1,'catalog_category_save',NULL),(6,2130706433,0,'catalog_categories','2017-02-03 09:18:08','view','a:1:{s:7:\"general\";s:1:\"3\";}','success','admin',1,'catalog_category_edit',NULL),(7,2130706433,0,'catalog_categories','2017-02-03 09:18:39','save','a:1:{s:7:\"general\";s:4:\"3, 4\";}','success','admin',1,'catalog_category_save',NULL),(8,2130706433,0,'catalog_categories','2017-02-03 09:18:40','view','a:1:{s:7:\"general\";s:1:\"4\";}','success','admin',1,'catalog_category_edit',NULL),(9,2130706433,0,'catalog_categories','2017-02-03 09:18:46','view','a:1:{s:7:\"general\";s:1:\"4\";}','success','admin',1,'catalog_category_edit',NULL),(10,2130706433,0,'catalog_categories','2017-02-03 09:18:57','delete','a:1:{s:7:\"general\";s:1:\"4\";}','success','admin',1,'catalog_category_delete',NULL),(11,2130706433,0,'catalog_categories','2017-02-03 09:19:01','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(12,2130706433,0,'catalog_categories','2017-02-03 09:19:11','save','a:1:{s:7:\"general\";s:4:\"2, 5\";}','success','admin',1,'catalog_category_save',NULL),(13,2130706433,0,'catalog_categories','2017-02-03 09:19:12','view','a:1:{s:7:\"general\";s:1:\"5\";}','success','admin',1,'catalog_category_edit',NULL),(14,2130706433,0,'catalog_categories','2017-02-03 09:19:15','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(15,2130706433,0,'catalog_categories','2017-02-03 09:19:43','save','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_save',NULL),(16,2130706433,0,'catalog_categories','2017-02-03 09:19:44','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(17,2130706433,0,'catalog_categories','2017-02-03 09:20:17','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(18,2130706433,0,'catalog_categories','2017-02-03 09:20:26','save','a:1:{s:7:\"general\";s:4:\"2, 6\";}','success','admin',1,'catalog_category_save',NULL),(19,2130706433,0,'catalog_categories','2017-02-03 09:20:27','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(20,2130706433,0,'catalog_categories','2017-02-03 09:20:36','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(21,2130706433,0,'catalog_categories','2017-02-03 09:21:02','save','a:1:{s:7:\"general\";s:4:\"2, 7\";}','success','admin',1,'catalog_category_save',NULL),(22,2130706433,0,'catalog_categories','2017-02-03 09:21:02','view','a:1:{s:7:\"general\";s:1:\"7\";}','success','admin',1,'catalog_category_edit',NULL),(23,2130706433,0,'catalog_categories','2017-02-03 09:21:16','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(24,2130706433,0,'catalog_categories','2017-02-03 09:21:26','save','a:1:{s:7:\"general\";s:4:\"2, 8\";}','success','admin',1,'catalog_category_save',NULL),(25,2130706433,0,'catalog_categories','2017-02-03 09:21:27','view','a:1:{s:7:\"general\";s:1:\"8\";}','success','admin',1,'catalog_category_edit',NULL),(26,2130706433,0,'catalog_categories','2017-02-03 09:21:48','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(27,2130706433,0,'catalog_categories','2017-02-03 09:22:13','save','a:1:{s:7:\"general\";s:4:\"2, 9\";}','success','admin',1,'catalog_category_save',NULL),(28,2130706433,0,'catalog_categories','2017-02-03 09:22:13','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(29,2130706433,0,'catalog_categories','2017-02-03 09:22:17','view','a:1:{s:7:\"general\";s:1:\"3\";}','success','admin',1,'catalog_category_edit',NULL),(30,2130706433,0,'catalog_categories','2017-02-03 09:22:49','save','a:1:{s:7:\"general\";s:5:\"3, 10\";}','success','admin',1,'catalog_category_save',NULL),(31,2130706433,0,'catalog_categories','2017-02-03 09:22:50','view','a:1:{s:7:\"general\";s:2:\"10\";}','success','admin',1,'catalog_category_edit',NULL),(32,2130706433,0,'catalog_categories','2017-02-03 09:27:02','view','a:1:{s:7:\"general\";s:2:\"10\";}','success','admin',1,'catalog_category_edit',NULL),(33,2130706433,0,'catalog_categories','2017-02-03 09:27:06','view','a:1:{s:7:\"general\";s:1:\"3\";}','success','admin',1,'catalog_category_edit',NULL),(34,2130706433,0,'catalog_categories','2017-02-03 09:27:15','save','a:1:{s:7:\"general\";s:5:\"3, 11\";}','success','admin',1,'catalog_category_save',NULL),(35,2130706433,0,'catalog_categories','2017-02-03 09:27:16','view','a:1:{s:7:\"general\";s:2:\"11\";}','success','admin',1,'catalog_category_edit',NULL),(36,2130706433,0,'catalog_categories','2017-02-03 09:27:21','view','a:1:{s:7:\"general\";s:1:\"3\";}','success','admin',1,'catalog_category_edit',NULL),(37,2130706433,0,'catalog_categories','2017-02-03 09:27:29','view','a:1:{s:7:\"general\";s:1:\"3\";}','success','admin',1,'catalog_category_edit',NULL),(38,2130706433,0,'catalog_categories','2017-02-03 09:27:39','save','a:1:{s:7:\"general\";s:5:\"3, 12\";}','success','admin',1,'catalog_category_save',NULL),(39,2130706433,0,'catalog_categories','2017-02-03 09:27:40','view','a:1:{s:7:\"general\";s:2:\"12\";}','success','admin',1,'catalog_category_edit',NULL),(40,2130706433,0,'catalog_categories','2017-02-03 09:27:45','view','a:1:{s:7:\"general\";s:1:\"3\";}','success','admin',1,'catalog_category_edit',NULL),(41,2130706433,0,'catalog_categories','2017-02-03 09:27:57','save','a:1:{s:7:\"general\";s:5:\"3, 13\";}','success','admin',1,'catalog_category_save',NULL),(42,2130706433,0,'catalog_categories','2017-02-03 09:27:58','view','a:1:{s:7:\"general\";s:2:\"13\";}','success','admin',1,'catalog_category_edit',NULL),(43,2130706433,0,'catalog_categories','2017-02-03 09:28:03','view','a:1:{s:7:\"general\";s:1:\"3\";}','success','admin',1,'catalog_category_edit',NULL),(44,2130706433,0,'catalog_categories','2017-02-03 09:28:16','save','a:1:{s:7:\"general\";s:5:\"3, 14\";}','success','admin',1,'catalog_category_save',NULL),(45,2130706433,0,'catalog_categories','2017-02-03 09:28:17','view','a:1:{s:7:\"general\";s:2:\"14\";}','success','admin',1,'catalog_category_edit',NULL),(46,2130706433,0,'catalog_categories','2017-02-03 09:28:33','view','a:1:{s:7:\"general\";s:1:\"5\";}','success','admin',1,'catalog_category_edit',NULL),(47,2130706433,0,'catalog_categories','2017-02-03 09:28:42','save','a:1:{s:7:\"general\";s:5:\"5, 15\";}','success','admin',1,'catalog_category_save',NULL),(48,2130706433,0,'catalog_categories','2017-02-03 09:28:43','view','a:1:{s:7:\"general\";s:2:\"15\";}','success','admin',1,'catalog_category_edit',NULL),(49,2130706433,0,'catalog_categories','2017-02-03 09:28:49','view','a:1:{s:7:\"general\";s:1:\"5\";}','success','admin',1,'catalog_category_edit',NULL),(50,2130706433,0,'catalog_categories','2017-02-03 09:29:01','save','a:1:{s:7:\"general\";s:5:\"5, 16\";}','success','admin',1,'catalog_category_save',NULL),(51,2130706433,0,'catalog_categories','2017-02-03 09:29:02','view','a:1:{s:7:\"general\";s:2:\"16\";}','success','admin',1,'catalog_category_edit',NULL),(52,2130706433,0,'catalog_categories','2017-02-03 09:29:07','view','a:1:{s:7:\"general\";s:1:\"5\";}','success','admin',1,'catalog_category_edit',NULL),(53,2130706433,0,'catalog_categories','2017-02-03 09:29:15','save','a:1:{s:7:\"general\";s:5:\"5, 17\";}','success','admin',1,'catalog_category_save',NULL),(54,2130706433,0,'catalog_categories','2017-02-03 09:29:16','view','a:1:{s:7:\"general\";s:2:\"17\";}','success','admin',1,'catalog_category_edit',NULL),(55,2130706433,0,'catalog_categories','2017-02-03 09:29:24','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(56,2130706433,0,'catalog_categories','2017-02-03 09:29:46','save','a:1:{s:7:\"general\";s:5:\"6, 18\";}','success','admin',1,'catalog_category_save',NULL),(57,2130706433,0,'catalog_categories','2017-02-03 09:29:47','view','a:1:{s:7:\"general\";s:2:\"18\";}','success','admin',1,'catalog_category_edit',NULL),(58,2130706433,0,'catalog_categories','2017-02-03 09:29:57','save','a:1:{s:7:\"general\";s:6:\"18, 19\";}','success','admin',1,'catalog_category_save',NULL),(59,2130706433,0,'catalog_categories','2017-02-03 09:29:58','view','a:1:{s:7:\"general\";s:2:\"19\";}','success','admin',1,'catalog_category_edit',NULL),(60,2130706433,0,'catalog_categories','2017-02-03 09:30:02','view','a:1:{s:7:\"general\";s:2:\"18\";}','success','admin',1,'catalog_category_edit',NULL),(61,2130706433,0,'catalog_categories','2017-02-03 09:30:08','save','a:1:{s:7:\"general\";s:6:\"18, 20\";}','success','admin',1,'catalog_category_save',NULL),(62,2130706433,0,'catalog_categories','2017-02-03 09:30:09','view','a:1:{s:7:\"general\";s:2:\"20\";}','success','admin',1,'catalog_category_edit',NULL),(63,2130706433,0,'catalog_categories','2017-02-03 09:30:22','view','a:1:{s:7:\"general\";s:2:\"18\";}','success','admin',1,'catalog_category_edit',NULL),(64,2130706433,0,'catalog_categories','2017-02-03 09:30:32','save','a:1:{s:7:\"general\";s:6:\"18, 21\";}','success','admin',1,'catalog_category_save',NULL),(65,2130706433,0,'catalog_categories','2017-02-03 09:30:32','view','a:1:{s:7:\"general\";s:2:\"21\";}','success','admin',1,'catalog_category_edit',NULL),(66,2130706433,0,'catalog_categories','2017-02-03 09:30:53','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(67,2130706433,0,'catalog_categories','2017-02-03 09:31:02','save','a:1:{s:7:\"general\";s:5:\"6, 22\";}','success','admin',1,'catalog_category_save',NULL),(68,2130706433,0,'catalog_categories','2017-02-03 09:31:03','view','a:1:{s:7:\"general\";s:2:\"22\";}','success','admin',1,'catalog_category_edit',NULL),(69,2130706433,0,'catalog_categories','2017-02-03 09:31:10','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(70,2130706433,0,'catalog_categories','2017-02-03 09:31:17','save','a:1:{s:7:\"general\";s:5:\"6, 23\";}','success','admin',1,'catalog_category_save',NULL),(71,2130706433,0,'catalog_categories','2017-02-03 09:31:18','view','a:1:{s:7:\"general\";s:2:\"23\";}','success','admin',1,'catalog_category_edit',NULL),(72,2130706433,0,'catalog_categories','2017-02-03 09:31:22','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(73,2130706433,0,'catalog_categories','2017-02-03 09:31:30','save','a:1:{s:7:\"general\";s:5:\"6, 24\";}','success','admin',1,'catalog_category_save',NULL),(74,2130706433,0,'catalog_categories','2017-02-03 09:31:31','view','a:1:{s:7:\"general\";s:2:\"24\";}','success','admin',1,'catalog_category_edit',NULL),(75,2130706433,0,'catalog_categories','2017-02-03 09:31:38','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(76,2130706433,0,'catalog_categories','2017-02-03 09:31:46','save','a:1:{s:7:\"general\";s:5:\"6, 25\";}','success','admin',1,'catalog_category_save',NULL),(77,2130706433,0,'catalog_categories','2017-02-03 09:31:47','view','a:1:{s:7:\"general\";s:2:\"25\";}','success','admin',1,'catalog_category_edit',NULL),(78,2130706433,0,'catalog_categories','2017-02-03 09:31:51','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(79,2130706433,0,'catalog_categories','2017-02-03 09:31:59','save','a:1:{s:7:\"general\";s:5:\"6, 26\";}','success','admin',1,'catalog_category_save',NULL),(80,2130706433,0,'catalog_categories','2017-02-03 09:31:59','view','a:1:{s:7:\"general\";s:2:\"26\";}','success','admin',1,'catalog_category_edit',NULL),(81,2130706433,0,'catalog_categories','2017-02-03 09:32:06','view','a:1:{s:7:\"general\";s:1:\"7\";}','success','admin',1,'catalog_category_edit',NULL),(82,2130706433,0,'catalog_categories','2017-02-03 09:32:13','save','a:1:{s:7:\"general\";s:5:\"7, 27\";}','success','admin',1,'catalog_category_save',NULL),(83,2130706433,0,'catalog_categories','2017-02-03 09:32:14','view','a:1:{s:7:\"general\";s:2:\"27\";}','success','admin',1,'catalog_category_edit',NULL),(84,2130706433,0,'catalog_categories','2017-02-03 09:32:22','view','a:1:{s:7:\"general\";s:1:\"7\";}','success','admin',1,'catalog_category_edit',NULL),(85,2130706433,0,'catalog_categories','2017-02-03 09:32:30','save','a:1:{s:7:\"general\";s:5:\"7, 28\";}','success','admin',1,'catalog_category_save',NULL),(86,2130706433,0,'catalog_categories','2017-02-03 09:32:31','view','a:1:{s:7:\"general\";s:2:\"28\";}','success','admin',1,'catalog_category_edit',NULL),(87,2130706433,0,'catalog_categories','2017-02-03 09:32:35','view','a:1:{s:7:\"general\";s:1:\"7\";}','success','admin',1,'catalog_category_edit',NULL),(88,2130706433,0,'catalog_categories','2017-02-03 09:32:45','save','a:1:{s:7:\"general\";s:5:\"7, 29\";}','success','admin',1,'catalog_category_save',NULL),(89,2130706433,0,'catalog_categories','2017-02-03 09:32:46','view','a:1:{s:7:\"general\";s:2:\"29\";}','success','admin',1,'catalog_category_edit',NULL),(90,2130706433,0,'catalog_categories','2017-02-03 09:32:54','view','a:1:{s:7:\"general\";s:1:\"7\";}','success','admin',1,'catalog_category_edit',NULL),(91,2130706433,0,'catalog_categories','2017-02-03 09:33:01','save','a:1:{s:7:\"general\";s:5:\"7, 30\";}','success','admin',1,'catalog_category_save',NULL),(92,2130706433,0,'catalog_categories','2017-02-03 09:33:02','view','a:1:{s:7:\"general\";s:2:\"30\";}','success','admin',1,'catalog_category_edit',NULL),(93,2130706433,0,'catalog_categories','2017-02-03 09:33:10','view','a:1:{s:7:\"general\";s:1:\"8\";}','success','admin',1,'catalog_category_edit',NULL),(94,2130706433,0,'catalog_categories','2017-02-03 09:33:18','save','a:1:{s:7:\"general\";s:5:\"8, 31\";}','success','admin',1,'catalog_category_save',NULL),(95,2130706433,0,'catalog_categories','2017-02-03 09:33:19','view','a:1:{s:7:\"general\";s:2:\"31\";}','success','admin',1,'catalog_category_edit',NULL),(96,2130706433,0,'catalog_categories','2017-02-03 09:33:23','view','a:1:{s:7:\"general\";s:1:\"8\";}','success','admin',1,'catalog_category_edit',NULL),(97,2130706433,0,'catalog_categories','2017-02-03 09:33:58','save','a:1:{s:7:\"general\";s:5:\"8, 32\";}','success','admin',1,'catalog_category_save',NULL),(98,2130706433,0,'catalog_categories','2017-02-03 09:33:58','view','a:1:{s:7:\"general\";s:2:\"32\";}','success','admin',1,'catalog_category_edit',NULL),(99,2130706433,0,'catalog_categories','2017-02-03 09:34:10','view','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'catalog_category_edit',NULL),(100,2130706433,0,'catalog_categories','2017-02-03 09:34:36','save','a:1:{s:7:\"general\";s:5:\"2, 33\";}','success','admin',1,'catalog_category_save',NULL),(101,2130706433,0,'catalog_categories','2017-02-03 09:34:37','view','a:1:{s:7:\"general\";s:2:\"33\";}','success','admin',1,'catalog_category_edit',NULL),(102,2130706433,0,'catalog_categories','2017-02-03 09:34:40','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(103,2130706433,0,'catalog_categories','2017-02-03 09:34:44','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(104,2130706433,0,'catalog_categories','2017-02-03 09:34:47','view','a:1:{s:7:\"general\";s:2:\"33\";}','success','admin',1,'catalog_category_edit',NULL),(105,2130706433,0,'catalog_categories','2017-02-03 09:34:48','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(106,2130706433,0,'catalog_categories','2017-02-03 09:35:05','save','a:1:{s:7:\"general\";s:5:\"9, 34\";}','success','admin',1,'catalog_category_save',NULL),(107,2130706433,0,'catalog_categories','2017-02-03 09:35:06','view','a:1:{s:7:\"general\";s:2:\"34\";}','success','admin',1,'catalog_category_edit',NULL),(108,2130706433,0,'catalog_categories','2017-02-03 09:35:11','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(109,2130706433,0,'catalog_categories','2017-02-03 09:35:18','save','a:1:{s:7:\"general\";s:5:\"9, 35\";}','success','admin',1,'catalog_category_save',NULL),(110,2130706433,0,'catalog_categories','2017-02-03 09:35:19','view','a:1:{s:7:\"general\";s:2:\"35\";}','success','admin',1,'catalog_category_edit',NULL),(111,2130706433,0,'catalog_categories','2017-02-03 09:35:23','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(112,2130706433,0,'catalog_categories','2017-02-03 09:35:32','save','a:1:{s:7:\"general\";s:5:\"9, 36\";}','success','admin',1,'catalog_category_save',NULL),(113,2130706433,0,'catalog_categories','2017-02-03 09:35:33','view','a:1:{s:7:\"general\";s:2:\"36\";}','success','admin',1,'catalog_category_edit',NULL),(114,2130706433,0,'catalog_categories','2017-02-03 09:35:36','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(115,2130706433,0,'catalog_categories','2017-02-03 09:35:46','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(116,2130706433,0,'catalog_categories','2017-02-03 09:35:53','save','a:1:{s:7:\"general\";s:5:\"9, 37\";}','success','admin',1,'catalog_category_save',NULL),(117,2130706433,0,'catalog_categories','2017-02-03 09:35:54','view','a:1:{s:7:\"general\";s:2:\"37\";}','success','admin',1,'catalog_category_edit',NULL),(118,2130706433,0,'catalog_categories','2017-02-03 09:35:59','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(119,2130706433,0,'catalog_categories','2017-02-03 09:36:06','save','a:1:{s:7:\"general\";s:5:\"9, 38\";}','success','admin',1,'catalog_category_save',NULL),(120,2130706433,0,'catalog_categories','2017-02-03 09:36:07','view','a:1:{s:7:\"general\";s:2:\"38\";}','success','admin',1,'catalog_category_edit',NULL),(121,2130706433,0,'adminhtml_system_config','2017-02-03 09:37:44','view','a:1:{s:7:\"general\";s:7:\"general\";}','success','admin',1,'adminhtml_system_config_index',NULL),(122,2130706433,0,'adminhtml_system_config','2017-02-03 09:37:49','view','a:1:{s:7:\"general\";s:5:\"admin\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(123,2130706433,0,'adminhtml_system_config','2017-02-03 09:37:53','view','a:1:{s:7:\"general\";s:3:\"dev\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(124,2130706433,0,'adminhtml_system_config','2017-02-03 09:37:58','save','a:1:{s:7:\"general\";s:3:\"dev\";}','success','admin',1,'adminhtml_system_config_save',NULL),(125,2130706433,0,'cache_management','2017-02-03 09:38:16','flush','a:1:{s:7:\"general\";N;}','success','admin',1,'adminhtml_cache_flushSystem',NULL),(126,2130706433,0,'adminhtml_system_config','2017-02-03 09:40:21','view','a:1:{s:7:\"general\";s:3:\"dev\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(127,2130706433,0,'cache_management','2017-02-03 09:42:24','flush','a:1:{s:7:\"general\";N;}','success','admin',1,'adminhtml_cache_flushSystem',NULL),(128,2130706433,0,'adminhtml_system_config','2017-02-03 09:54:14','view','a:1:{s:7:\"general\";s:7:\"general\";}','success','admin',1,'adminhtml_system_config_index',NULL),(129,2130706433,0,'adminhtml_system_config','2017-02-03 09:54:28','view','a:1:{s:7:\"general\";s:3:\"dev\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(130,2130706433,0,'adminhtml_system_config','2017-02-03 09:54:38','save','a:1:{s:7:\"general\";s:3:\"dev\";}','success','admin',1,'adminhtml_system_config_save',NULL),(131,2130706433,0,'cache_management','2017-02-03 09:54:43','flush','a:1:{s:7:\"general\";N;}','success','admin',1,'adminhtml_cache_flushSystem',NULL),(132,2130706433,0,'catalog_categories','2017-02-03 09:56:23','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(133,2130706433,0,'catalog_categories','2017-02-03 09:56:24','view','a:1:{s:7:\"general\";s:1:\"8\";}','success','admin',1,'catalog_category_edit',NULL),(134,2130706433,0,'catalog_categories','2017-02-03 09:56:25','view','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_edit',NULL),(135,2130706433,0,'catalog_categories','2017-02-03 09:56:26','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(136,2130706433,0,'catalog_categories','2017-02-03 09:56:27','view','a:1:{s:7:\"general\";s:1:\"8\";}','success','admin',1,'catalog_category_edit',NULL),(137,2130706433,0,'catalog_categories','2017-02-03 09:56:28','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(138,2130706433,0,'catalog_categories','2017-02-03 10:01:05','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(139,2130706433,0,'catalog_categories','2017-02-03 10:02:27','move','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_move',NULL),(140,2130706433,0,'catalog_categories','2017-02-03 10:02:36','move','a:1:{s:7:\"general\";s:1:\"8\";}','success','admin',1,'catalog_category_move',NULL),(141,2130706433,0,'catalog_categories','2017-02-03 10:02:41','move','a:1:{s:7:\"general\";s:1:\"9\";}','success','admin',1,'catalog_category_move',NULL),(142,2130706433,0,'catalog_categories','2017-02-03 10:02:45','save','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_save',NULL),(143,2130706433,0,'catalog_categories','2017-02-03 10:02:46','view','a:1:{s:7:\"general\";s:1:\"6\";}','success','admin',1,'catalog_category_edit',NULL),(144,2130706433,0,'cms_blocks','2017-02-03 10:17:36','view','a:1:{s:7:\"general\";s:1:\"1\";}','success','admin',1,'cms_block_edit',NULL),(145,2130706433,0,'adminhtml_system_config','2017-02-03 10:19:01','view','a:1:{s:7:\"general\";s:7:\"general\";}','success','admin',1,'adminhtml_system_config_index',NULL),(146,2130706433,0,'adminhtml_system_config','2017-02-03 10:19:07','view','a:1:{s:7:\"general\";s:6:\"design\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(147,2130706433,0,'adminhtml_system_config','2017-02-03 10:19:12','view','a:1:{s:7:\"general\";s:3:\"cms\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(148,2130706433,0,'adminhtml_system_config','2017-02-03 10:19:16','view','a:1:{s:7:\"general\";s:3:\"web\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(149,2130706433,0,'adminhtml_system_config','2017-02-03 10:19:37','view','a:1:{s:7:\"general\";s:3:\"cms\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(150,2130706433,0,'adminhtml_system_config','2017-02-03 10:19:43','view','a:1:{s:7:\"general\";s:7:\"reports\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(151,2130706433,0,'adminhtml_system_config','2017-02-03 10:20:04','view','a:1:{s:7:\"general\";s:6:\"design\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(152,2130706433,0,'magento_versionscms_hierarchy','2017-02-03 10:20:14','view','a:1:{s:7:\"general\";O:24:\"Magento\\Framework\\Phrase\":2:{s:30:\"\0Magento\\Framework\\Phrase\0text\";s:11:\"Tree Viewed\";s:35:\"\0Magento\\Framework\\Phrase\0arguments\";a:0:{}}}','success','admin',1,'adminhtml_cms_hierarchy_index',NULL),(153,2130706433,0,'cms_blocks','2017-02-03 10:25:39','view','a:1:{s:7:\"general\";s:1:\"1\";}','success','admin',1,'cms_block_edit',NULL),(154,2130706433,0,'cms_blocks','2017-02-03 10:25:58','save','a:1:{s:7:\"general\";s:1:\"1\";}','success','admin',1,'cms_block_save',NULL),(155,2130706433,0,'cms_blocks','2017-02-03 10:26:18','view','a:1:{s:7:\"general\";s:1:\"1\";}','success','admin',1,'cms_block_edit',NULL),(156,2130706433,0,'cms_blocks','2017-02-03 10:26:23','save','a:1:{s:7:\"general\";s:1:\"1\";}','success','admin',1,'cms_block_save',NULL),(157,2130706433,0,'cms_blocks','2017-02-03 10:30:03','save','a:1:{s:7:\"general\";s:1:\"2\";}','success','admin',1,'cms_block_save',NULL),(158,2130706433,0,'adminhtml_system_config','2017-02-03 10:32:44','view','a:1:{s:7:\"general\";s:7:\"general\";}','success','admin',1,'adminhtml_system_config_index',NULL),(159,2130706433,0,'adminhtml_system_config','2017-02-03 10:32:55','view','a:1:{s:7:\"general\";s:6:\"system\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(160,2130706433,0,'adminhtml_system_config','2017-02-03 10:33:17','view','a:1:{s:7:\"general\";s:5:\"admin\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(161,2130706433,0,'adminhtml_system_config','2017-02-03 10:33:21','view','a:1:{s:7:\"general\";s:8:\"advanced\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(162,2130706433,0,'adminhtml_system_config','2017-02-03 10:33:24','view','a:1:{s:7:\"general\";s:3:\"dev\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(163,2130706433,0,'adminhtml_system_config','2017-02-03 10:33:30','save','a:1:{s:7:\"general\";s:3:\"dev\";}','success','admin',1,'adminhtml_system_config_save',NULL),(164,2130706433,0,'adminhtml_system_config','2017-02-03 10:33:41','view','a:1:{s:7:\"general\";s:3:\"web\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(165,2130706433,0,'adminhtml_system_config','2017-02-03 10:33:56','view','a:1:{s:7:\"general\";s:6:\"design\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(166,2130706433,0,'adminhtml_system_config','2017-02-03 10:33:59','view','a:1:{s:7:\"general\";s:7:\"general\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(167,2130706433,0,'adminhtml_system_config','2017-02-03 10:34:19','view','a:1:{s:7:\"general\";s:3:\"cms\";}','success','admin',1,'adminhtml_system_config_edit',NULL),(168,2130706433,0,'cache_management','2017-02-03 10:34:26','flush','a:1:{s:7:\"general\";N;}','success','admin',1,'adminhtml_cache_flushSystem',NULL),(169,2130706433,0,'cache_management','2017-02-03 10:35:55','flush','a:1:{s:7:\"general\";N;}','success','admin',1,'adminhtml_cache_flushSystem',NULL);
/*!40000 ALTER TABLE `spg_magento_logging_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_logging_event_changes`
--

DROP TABLE IF EXISTS `spg_magento_logging_event_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_logging_event_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Enterprise logging id',
  `source_name` varchar(150) DEFAULT NULL COMMENT 'Logged Source Name',
  `event_id` int(11) DEFAULT NULL COMMENT 'Logged event id',
  `source_id` int(11) DEFAULT NULL COMMENT 'Logged Source Id',
  `original_data` text COMMENT 'Logged Original Data',
  `result_data` text COMMENT 'Logged Result Data',
  PRIMARY KEY (`id`),
  KEY `SPG_MAGENTO_LOGGING_EVENT_CHANGES_EVENT_ID` (`event_id`),
  CONSTRAINT `FK_977A1063E61C7E83F9DFBE9DF3F3BB4C` FOREIGN KEY (`event_id`) REFERENCES `spg_magento_logging_event` (`log_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='Enterprise Logging Event Changes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_logging_event_changes`
--

LOCK TABLES `spg_magento_logging_event_changes` WRITE;
/*!40000 ALTER TABLE `spg_magento_logging_event_changes` DISABLE KEYS */;
INSERT INTO `spg_magento_logging_event_changes` VALUES (1,'Magento\\Catalog\\Model\\Category',5,3,'a:1:{s:13:\"__was_created\";b:1;}','a:41:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"2\";s:4:\"path\";s:5:\"1/2/3\";s:4:\"name\";s:3:\"Áo\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:2:\"ao\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:18:\"position_cache_key\";s:13:\"58944aaf71792\";s:17:\"is_smart_category\";s:1:\"0\";s:20:\"smart_category_rules\";s:0:\"\";s:10:\"sort_order\";s:1:\"0\";s:20:\"vm_category_products\";s:2:\"[]\";s:5:\"image\";N;s:9:\"parent_id\";i:2;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:2:\"ao\";s:10:\"created_at\";s:19:\"2017-02-03 09:18:07\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:1;s:5:\"level\";i:2;s:9:\"entity_id\";s:1:\"3\";s:6:\"row_id\";s:1:\"3\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(2,'Magento\\Catalog\\Model\\Category',7,4,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"3\";s:4:\"path\";s:7:\"1/2/3/4\";s:4:\"name\";s:5:\"Giày\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:4:\"giay\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:3;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:7:\"ao/giay\";s:10:\"created_at\";s:19:\"2017-02-03 09:18:39\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:1;s:5:\"level\";i:3;s:9:\"entity_id\";s:1:\"4\";s:6:\"row_id\";s:1:\"4\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(3,'Magento\\Catalog\\Model\\Category',10,4,'a:20:{s:6:\"row_id\";s:1:\"4\";s:9:\"entity_id\";s:1:\"4\";s:10:\"created_in\";s:1:\"1\";s:10:\"updated_in\";s:10:\"2147483647\";s:16:\"attribute_set_id\";s:1:\"3\";s:9:\"parent_id\";s:1:\"3\";s:10:\"created_at\";s:19:\"2017-02-03 09:18:39\";s:4:\"path\";s:7:\"1/2/3/4\";s:8:\"position\";s:1:\"1\";s:5:\"level\";s:1:\"3\";s:14:\"children_count\";s:1:\"0\";s:4:\"name\";s:5:\"Giày\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:7:\"url_key\";s:4:\"giay\";s:8:\"url_path\";s:7:\"ao/giay\";s:9:\"is_active\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";}','a:1:{s:13:\"__was_deleted\";b:1;}'),(4,'Magento\\Catalog\\Model\\Category',12,5,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"2\";s:4:\"path\";s:5:\"1/2/5\";s:4:\"name\";s:5:\"Giày\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:4:\"giay\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:5:\"image\";N;s:9:\"parent_id\";i:2;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:4:\"giay\";s:10:\"created_at\";s:19:\"2017-02-03 09:19:11\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:2;s:5:\"level\";i:2;s:9:\"entity_id\";s:1:\"5\";s:6:\"row_id\";s:1:\"5\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(5,'Magento\\Catalog\\Model\\Category',15,2,'a:1:{s:13:\"__was_created\";b:1;}','a:34:{s:8:\"store_id\";s:1:\"0\";s:6:\"row_id\";s:1:\"2\";s:9:\"entity_id\";s:1:\"2\";s:16:\"attribute_set_id\";s:1:\"3\";s:9:\"parent_id\";i:1;s:10:\"created_at\";s:19:\"2017-02-03 07:47:52\";s:4:\"path\";s:3:\"1/2\";s:5:\"level\";s:1:\"1\";s:14:\"children_count\";s:1:\"2\";s:4:\"name\";s:28:\"Shopforgirl Primary Category\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"0\";s:18:\"filter_price_range\";N;s:10:\"meta_title\";s:0:\"\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:15:\"default_sort_by\";N;s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:5:\"image\";N;s:17:\"available_sort_by\";N;s:7:\"url_key\";s:28:\"shopforgirl-primary-category\";s:8:\"url_path\";s:0:\"\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:10:\"created_in\";i:1;s:10:\"updated_in\";s:10:\"2147483647\";s:23:\"is_changed_product_list\";b:0;}'),(6,'Magento\\Catalog\\Model\\Category',18,6,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"2\";s:4:\"path\";s:5:\"1/2/6\";s:4:\"name\";s:6:\"Quần\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:4:\"qu-n\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:5:\"image\";N;s:9:\"parent_id\";i:2;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:4:\"qu-n\";s:10:\"created_at\";s:19:\"2017-02-03 09:20:26\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:3;s:5:\"level\";i:2;s:9:\"entity_id\";s:1:\"6\";s:6:\"row_id\";s:1:\"6\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(7,'Magento\\Catalog\\Model\\Category',21,7,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"2\";s:4:\"path\";s:5:\"1/2/7\";s:4:\"name\";s:3:\"Set\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:3:\"set\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:2;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:3:\"set\";s:10:\"created_at\";s:19:\"2017-02-03 09:21:02\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:4;s:5:\"level\";i:2;s:9:\"entity_id\";s:1:\"7\";s:6:\"row_id\";s:1:\"7\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(8,'Magento\\Catalog\\Model\\Category',24,8,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"2\";s:4:\"path\";s:5:\"1/2/8\";s:4:\"name\";s:6:\"Đầm\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:3:\"d-m\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:2;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:3:\"d-m\";s:10:\"created_at\";s:19:\"2017-02-03 09:21:26\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:5;s:5:\"level\";i:2;s:9:\"entity_id\";s:1:\"8\";s:6:\"row_id\";s:1:\"8\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(9,'Magento\\Catalog\\Model\\Category',27,9,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"2\";s:4:\"path\";s:5:\"1/2/9\";s:4:\"name\";s:10:\"Chân váy\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:8:\"chan-vay\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:2;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:8:\"chan-vay\";s:10:\"created_at\";s:19:\"2017-02-03 09:22:12\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:6;s:5:\"level\";i:2;s:9:\"entity_id\";s:1:\"9\";s:6:\"row_id\";s:1:\"9\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(10,'Magento\\Catalog\\Model\\Category',30,10,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"3\";s:4:\"path\";s:8:\"1/2/3/10\";s:4:\"name\";s:11:\"Áo Croptop\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:10:\"ao-croptop\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:3;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:13:\"ao/ao-croptop\";s:10:\"created_at\";s:19:\"2017-02-03 09:22:49\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:1;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"10\";s:6:\"row_id\";s:2:\"10\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(11,'Magento\\Catalog\\Model\\Category',34,11,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"3\";s:4:\"path\";s:8:\"1/2/3/11\";s:4:\"name\";s:10:\"Áo khoác\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:8:\"ao-khoac\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:3;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:11:\"ao/ao-khoac\";s:10:\"created_at\";s:19:\"2017-02-03 09:27:15\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:2;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"11\";s:6:\"row_id\";s:2:\"11\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(12,'Magento\\Catalog\\Model\\Category',38,12,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"3\";s:4:\"path\";s:8:\"1/2/3/12\";s:4:\"name\";s:10:\"Áo sơ mi\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:8:\"ao-so-mi\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:3;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:11:\"ao/ao-so-mi\";s:10:\"created_at\";s:19:\"2017-02-03 09:27:39\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:3;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"12\";s:6:\"row_id\";s:2:\"12\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(13,'Magento\\Catalog\\Model\\Category',41,13,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"3\";s:4:\"path\";s:8:\"1/2/3/13\";s:4:\"name\";s:16:\"Áo thiết kế\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:10:\"ao-thi-t-k\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:3;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:13:\"ao/ao-thi-t-k\";s:10:\"created_at\";s:19:\"2017-02-03 09:27:57\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:4;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"13\";s:6:\"row_id\";s:2:\"13\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(14,'Magento\\Catalog\\Model\\Category',44,14,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"3\";s:4:\"path\";s:8:\"1/2/3/14\";s:4:\"name\";s:8:\"Áo thun\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:7:\"ao-thun\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:3;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:10:\"ao/ao-thun\";s:10:\"created_at\";s:19:\"2017-02-03 09:28:16\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:5;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"14\";s:6:\"row_id\";s:2:\"14\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(15,'Magento\\Catalog\\Model\\Category',47,15,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"5\";s:4:\"path\";s:8:\"1/2/5/15\";s:4:\"name\";s:4:\"Dép\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:3:\"dep\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:5;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:8:\"giay/dep\";s:10:\"created_at\";s:19:\"2017-02-03 09:28:42\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:1;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"15\";s:6:\"row_id\";s:2:\"15\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(16,'Magento\\Catalog\\Model\\Category',50,16,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"5\";s:4:\"path\";s:8:\"1/2/5/16\";s:4:\"name\";s:24:\"Giày búp bê Zara VNXK\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:21:\"giay-bup-be-zara-vnxk\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:5:\"image\";N;s:9:\"parent_id\";i:5;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:26:\"giay/giay-bup-be-zara-vnxk\";s:10:\"created_at\";s:19:\"2017-02-03 09:29:00\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:2;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"16\";s:6:\"row_id\";s:2:\"16\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(17,'Magento\\Catalog\\Model\\Category',53,17,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"5\";s:4:\"path\";s:8:\"1/2/5/17\";s:4:\"name\";s:6:\"Sandal\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:6:\"sandal\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:5;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:11:\"giay/sandal\";s:10:\"created_at\";s:19:\"2017-02-03 09:29:15\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:3;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"17\";s:6:\"row_id\";s:2:\"17\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(18,'Magento\\Catalog\\Model\\Category',56,18,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"6\";s:4:\"path\";s:8:\"1/2/6/18\";s:4:\"name\";s:12:\"Quần baggy\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:10:\"qu-n-baggy\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:6;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:15:\"qu-n/qu-n-baggy\";s:10:\"created_at\";s:19:\"2017-02-03 09:29:46\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:1;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"18\";s:6:\"row_id\";s:2:\"18\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(19,'Magento\\Catalog\\Model\\Category',58,19,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:2:\"18\";s:4:\"path\";s:11:\"1/2/6/18/19\";s:4:\"name\";s:17:\"Baggy jeans trơn\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:16:\"baggy-jeans-tron\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:18;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:32:\"qu-n/qu-n-baggy/baggy-jeans-tron\";s:10:\"created_at\";s:19:\"2017-02-03 09:29:56\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:1;s:5:\"level\";i:4;s:9:\"entity_id\";s:2:\"19\";s:6:\"row_id\";s:2:\"19\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(20,'Magento\\Catalog\\Model\\Category',61,20,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:2:\"18\";s:4:\"path\";s:11:\"1/2/6/18/20\";s:4:\"name\";s:17:\"Baggy rách jeans\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:16:\"baggy-rach-jeans\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:18;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:32:\"qu-n/qu-n-baggy/baggy-rach-jeans\";s:10:\"created_at\";s:19:\"2017-02-03 09:30:08\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:2;s:5:\"level\";i:4;s:9:\"entity_id\";s:2:\"20\";s:6:\"row_id\";s:2:\"20\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(21,'Magento\\Catalog\\Model\\Category',64,21,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:2:\"18\";s:4:\"path\";s:11:\"1/2/6/18/21\";s:4:\"name\";s:11:\"Baggy vải\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:9:\"baggy-v-i\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:18;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:25:\"qu-n/qu-n-baggy/baggy-v-i\";s:10:\"created_at\";s:19:\"2017-02-03 09:30:32\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:3;s:5:\"level\";i:4;s:9:\"entity_id\";s:2:\"21\";s:6:\"row_id\";s:2:\"21\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(22,'Magento\\Catalog\\Model\\Category',67,22,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"6\";s:4:\"path\";s:8:\"1/2/6/22\";s:4:\"name\";s:24:\"Quần jeans rách gối\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:19:\"qu-n-jeans-rach-g-i\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:6;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:24:\"qu-n/qu-n-jeans-rach-g-i\";s:10:\"created_at\";s:19:\"2017-02-03 09:31:01\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:2;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"22\";s:6:\"row_id\";s:2:\"22\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(23,'Magento\\Catalog\\Model\\Category',70,23,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"6\";s:4:\"path\";s:8:\"1/2/6/23\";s:4:\"name\";s:13:\"Quần kiểu\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:9:\"qu-n-ki-u\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:6;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:14:\"qu-n/qu-n-ki-u\";s:10:\"created_at\";s:19:\"2017-02-03 09:31:17\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:3;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"23\";s:6:\"row_id\";s:2:\"23\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(24,'Magento\\Catalog\\Model\\Category',73,24,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"6\";s:4:\"path\";s:8:\"1/2/6/24\";s:4:\"name\";s:14:\"Quần legging\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:12:\"qu-n-legging\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:6;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:17:\"qu-n/qu-n-legging\";s:10:\"created_at\";s:19:\"2017-02-03 09:31:30\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:4;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"24\";s:6:\"row_id\";s:2:\"24\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(25,'Magento\\Catalog\\Model\\Category',76,25,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"6\";s:4:\"path\";s:8:\"1/2/6/25\";s:4:\"name\";s:11:\"Quần váy\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:8:\"qu-n-vay\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:6;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:13:\"qu-n/qu-n-vay\";s:10:\"created_at\";s:19:\"2017-02-03 09:31:45\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:5;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"25\";s:6:\"row_id\";s:2:\"25\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(26,'Magento\\Catalog\\Model\\Category',79,26,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"6\";s:4:\"path\";s:8:\"1/2/6/26\";s:4:\"name\";s:11:\"Short jeans\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:11:\"short-jeans\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:6;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:16:\"qu-n/short-jeans\";s:10:\"created_at\";s:19:\"2017-02-03 09:31:58\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:6;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"26\";s:6:\"row_id\";s:2:\"26\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(27,'Magento\\Catalog\\Model\\Category',82,27,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"7\";s:4:\"path\";s:8:\"1/2/7/27\";s:4:\"name\";s:12:\"Áo + quần\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:7:\"ao-qu-n\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:7;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:11:\"set/ao-qu-n\";s:10:\"created_at\";s:19:\"2017-02-03 09:32:13\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:1;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"27\";s:6:\"row_id\";s:2:\"27\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(28,'Magento\\Catalog\\Model\\Category',85,28,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"7\";s:4:\"path\";s:8:\"1/2/7/28\";s:4:\"name\";s:17:\"Áo + quần váy\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:11:\"ao-qu-n-vay\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:7;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:15:\"set/ao-qu-n-vay\";s:10:\"created_at\";s:19:\"2017-02-03 09:32:30\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:2;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"28\";s:6:\"row_id\";s:2:\"28\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(29,'Magento\\Catalog\\Model\\Category',88,29,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"7\";s:4:\"path\";s:8:\"1/2/7/29\";s:4:\"name\";s:10:\"Áo + váy\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:6:\"ao-vay\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:7;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:10:\"set/ao-vay\";s:10:\"created_at\";s:19:\"2017-02-03 09:32:45\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:3;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"29\";s:6:\"row_id\";s:2:\"29\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(30,'Magento\\Catalog\\Model\\Category',91,30,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"7\";s:4:\"path\";s:8:\"1/2/7/30\";s:4:\"name\";s:4:\"Jump\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:4:\"jump\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:7;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:8:\"set/jump\";s:10:\"created_at\";s:19:\"2017-02-03 09:33:01\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:4;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"30\";s:6:\"row_id\";s:2:\"30\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(31,'Magento\\Catalog\\Model\\Category',94,31,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"8\";s:4:\"path\";s:8:\"1/2/8/31\";s:4:\"name\";s:12:\"Đầm QC/TL\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:9:\"d-m-qc-tl\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:8;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:13:\"d-m/d-m-qc-tl\";s:10:\"created_at\";s:19:\"2017-02-03 09:33:17\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:1;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"31\";s:6:\"row_id\";s:2:\"31\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(32,'Magento\\Catalog\\Model\\Category',97,32,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"8\";s:4:\"path\";s:8:\"1/2/8/32\";s:4:\"name\";s:19:\"Đầm thiết kế\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:11:\"d-m-thi-t-k\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:5:\"image\";N;s:9:\"parent_id\";i:8;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:15:\"d-m/d-m-thi-t-k\";s:10:\"created_at\";s:19:\"2017-02-03 09:33:57\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:2;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"32\";s:6:\"row_id\";s:2:\"32\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(33,'Magento\\Catalog\\Model\\Category',100,33,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"2\";s:4:\"path\";s:6:\"1/2/33\";s:4:\"name\";s:12:\"Phụ kiện\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:7:\"ph-ki-n\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:2;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:7:\"ph-ki-n\";s:10:\"created_at\";s:19:\"2017-02-03 09:34:36\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:7;s:5:\"level\";i:2;s:9:\"entity_id\";s:2:\"33\";s:6:\"row_id\";s:2:\"33\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(34,'Magento\\Catalog\\Model\\Category',106,34,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"9\";s:4:\"path\";s:8:\"1/2/9/34\";s:4:\"name\";s:9:\"Bút chì\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:7:\"but-chi\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:9;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:16:\"chan-vay/but-chi\";s:10:\"created_at\";s:19:\"2017-02-03 09:35:05\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:1;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"34\";s:6:\"row_id\";s:2:\"34\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(35,'Magento\\Catalog\\Model\\Category',109,35,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"9\";s:4:\"path\";s:8:\"1/2/9/35\";s:4:\"name\";s:6:\"Kiểu\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:4:\"ki-u\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:9;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:13:\"chan-vay/ki-u\";s:10:\"created_at\";s:19:\"2017-02-03 09:35:18\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:2;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"35\";s:6:\"row_id\";s:2:\"35\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(36,'Magento\\Catalog\\Model\\Category',112,36,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"9\";s:4:\"path\";s:8:\"1/2/9/36\";s:4:\"name\";s:16:\"Midi không xẻ\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:12:\"midi-khong-x\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:5:\"image\";N;s:9:\"parent_id\";i:9;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:21:\"chan-vay/midi-khong-x\";s:10:\"created_at\";s:19:\"2017-02-03 09:35:32\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:3;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"36\";s:6:\"row_id\";s:2:\"36\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(37,'Magento\\Catalog\\Model\\Category',116,37,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"9\";s:4:\"path\";s:8:\"1/2/9/37\";s:4:\"name\";s:18:\"Midi xẻ trước\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:12:\"midi-x-tru-c\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:9;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:21:\"chan-vay/midi-x-tru-c\";s:10:\"created_at\";s:19:\"2017-02-03 09:35:53\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:4;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"37\";s:6:\"row_id\";s:2:\"37\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(38,'Magento\\Catalog\\Model\\Category',119,38,'a:1:{s:13:\"__was_created\";b:1;}','a:36:{s:8:\"store_id\";s:1:\"0\";s:2:\"id\";s:0:\"\";s:6:\"parent\";s:1:\"9\";s:4:\"path\";s:8:\"1/2/9/38\";s:4:\"name\";s:4:\"Yoko\";s:18:\"filter_price_range\";N;s:7:\"url_key\";s:4:\"yoko\";s:10:\"meta_title\";s:0:\"\";s:9:\"is_active\";s:1:\"1\";s:15:\"include_in_menu\";s:1:\"1\";s:9:\"is_anchor\";s:1:\"1\";s:26:\"custom_use_parent_settings\";s:1:\"0\";s:24:\"custom_apply_to_products\";s:1:\"0\";s:23:\"url_key_create_redirect\";s:1:\"0\";s:11:\"description\";s:0:\"\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:12:\"display_mode\";s:8:\"PRODUCTS\";s:15:\"default_sort_by\";N;s:5:\"image\";N;s:9:\"parent_id\";i:9;s:17:\"available_sort_by\";N;s:16:\"attribute_set_id\";s:1:\"3\";s:8:\"url_path\";s:13:\"chan-vay/yoko\";s:10:\"created_at\";s:19:\"2017-02-03 09:36:06\";s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:14:\"children_count\";i:0;s:8:\"position\";i:5;s:5:\"level\";i:3;s:9:\"entity_id\";s:2:\"38\";s:6:\"row_id\";s:2:\"38\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;s:23:\"is_changed_product_list\";b:0;}'),(39,'front_end_development_workflow',124,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:4:\"type\";s:23:\"client_side_compilation\";}'),(40,'restrict',124,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:9:\"allow_ips\";s:0:\"\";}'),(41,'debug',124,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:3:{s:25:\"template_hints_storefront\";s:1:\"0\";s:20:\"template_hints_admin\";s:1:\"0\";s:21:\"template_hints_blocks\";s:1:\"0\";}'),(42,'template',124,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:13:\"allow_symlink\";s:1:\"0\";}'),(43,'translate_inline',124,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:2:{s:6:\"active\";s:1:\"0\";s:12:\"active_admin\";s:1:\"0\";}'),(44,'js',124,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:3:{s:11:\"merge_files\";s:1:\"0\";s:18:\"enable_js_bundling\";s:1:\"0\";s:12:\"minify_files\";s:1:\"0\";}'),(45,'css',124,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:2:{s:15:\"merge_css_files\";s:1:\"0\";s:12:\"minify_files\";s:1:\"0\";}'),(46,'static',124,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:4:\"sign\";s:1:\"1\";}'),(47,'front_end_development_workflow',130,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:4:\"type\";s:23:\"server_side_compilation\";}'),(48,'restrict',130,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:9:\"allow_ips\";s:0:\"\";}'),(49,'debug',130,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:3:{s:25:\"template_hints_storefront\";s:1:\"0\";s:20:\"template_hints_admin\";s:1:\"0\";s:21:\"template_hints_blocks\";s:1:\"0\";}'),(50,'template',130,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:13:\"allow_symlink\";s:1:\"0\";}'),(51,'translate_inline',130,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:2:{s:6:\"active\";s:1:\"0\";s:12:\"active_admin\";s:1:\"0\";}'),(52,'js',130,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:3:{s:11:\"merge_files\";s:1:\"0\";s:18:\"enable_js_bundling\";s:1:\"0\";s:12:\"minify_files\";s:1:\"0\";}'),(53,'css',130,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:2:{s:15:\"merge_css_files\";s:1:\"0\";s:12:\"minify_files\";s:1:\"0\";}'),(54,'static',130,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:4:\"sign\";s:1:\"1\";}'),(55,'Magento\\Catalog\\Model\\Category',142,6,'a:1:{s:12:\"__no_changes\";b:1;}','a:22:{s:2:\"id\";s:1:\"6\";s:6:\"parent\";s:1:\"0\";s:18:\"filter_price_range\";N;s:10:\"meta_title\";s:0:\"\";s:23:\"url_key_create_redirect\";s:4:\"qu-n\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:20:\"custom_layout_update\";s:0:\"\";s:15:\"default_sort_by\";N;s:11:\"description\";s:0:\"\";s:18:\"position_cache_key\";s:13:\"589454e0e0971\";s:17:\"is_smart_category\";s:1:\"0\";s:17:\"automatic_sorting\";s:1:\"0\";s:20:\"smart_category_rules\";s:0:\"\";s:10:\"sort_order\";s:1:\"0\";s:20:\"vm_category_products\";s:2:\"[]\";s:5:\"image\";N;s:17:\"available_sort_by\";N;s:21:\"save_rewrites_history\";b:1;s:18:\"custom_design_from\";N;s:30:\"custom_design_from_is_formated\";b:1;s:23:\"is_changed_product_list\";b:0;}'),(56,'Magento\\Cms\\Model\\Block',154,1,'a:1:{s:7:\"content\";s:113:\"{{block class=\"Magento\\\\CatalogEvent\\\\Block\\\\Event\\\\Lister\" name=\"catalog.event.lister\" template=\"lister.phtml\"}}\";}','a:4:{s:7:\"content\";s:11:\"<p>test</p>\";s:15:\"_first_store_id\";s:1:\"0\";s:10:\"store_code\";s:5:\"admin\";s:9:\"parent_id\";i:0;}'),(57,'Magento\\Cms\\Model\\Block',156,1,'a:1:{s:7:\"content\";s:11:\"<p>test</p>\";}','a:4:{s:7:\"content\";s:120:\"<p>{{block class=\"Magento\\\\CatalogEvent\\\\Block\\\\Event\\\\Lister\" name=\"catalog.event.lister\" template=\"lister.phtml\"}}</p>\";s:15:\"_first_store_id\";s:1:\"0\";s:10:\"store_code\";s:5:\"admin\";s:9:\"parent_id\";i:0;}'),(58,'Magento\\Cms\\Model\\Block',157,2,'a:1:{s:13:\"__was_created\";b:1;}','a:9:{s:8:\"block_id\";s:1:\"2\";s:5:\"title\";s:10:\"SPG Footer\";s:10:\"identifier\";s:10:\"spg-footer\";s:9:\"is_active\";s:1:\"1\";s:7:\"content\";s:5361:\"<p>&lt;div id=\"containerfooter\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-md-6 col-sm-12 footercol1\"&gt;<br />&lt;div class=\"widget-1 widget-first footer-widget\"&gt;&lt;aside id=\"virtue_split_content_widget-3\" class=\"widget virtue_split_content_widget\"&gt;&lt;!-- Image Split --&gt;<br />&lt;div id=\"kt-image-split-48\" class=\"kt-image-slit\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-sm-6 kt-si-imagecol img-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;&lt;img class=\"kt-si-image\" style=\"max-height: 200px;\" src=\"http://s3-ap-southeast-1.amazonaws.com/shopforgirl.vn/wp-content/uploads/2016/10/25225146/logo_new.png\" /&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;div class=\"col-sm-18 kt-si-imagecol content-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;<br />&lt;h2 class=\"kt_imgsplit_title\"&gt;Shopforgirl&lt;/h2&gt;<br />&lt;div class=\"kt_imgsplit_content\"&gt;Chuy&ecirc;n kinh doanh quần &aacute;o may mặc, gi&agrave;y d&eacute;p, phụ kiện thời trang.&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/aside&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;div class=\"col-md-6 col-sm-12 footercol2\"&gt;<br />&lt;div class=\"widget-1 widget-first footer-widget\"&gt;&lt;aside id=\"virtue_split_content_widget-4\" class=\"widget virtue_split_content_widget\"&gt;&lt;!-- Image Split --&gt;<br />&lt;div id=\"kt-image-split-90\" class=\"kt-image-slit\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-sm-24 kt-si-imagecol content-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;<br />&lt;h2 class=\"kt_imgsplit_title\"&gt;Chi nh&aacute;nh&lt;/h2&gt;<br />&lt;div class=\"kt_imgsplit_content\"&gt;</p>\r\n<p>&lt;strong&gt;Chi nh&aacute;nh 1&lt;/strong&gt;</p>\r\n<p>&lt;i class=\"fa fa-map-marker\"&gt;&lt;/i&gt;<br />220 B&agrave; Hạt - Phường 9 - Quận 10</p>\r\n<p>&lt;i class=\"fa fa-phone\"&gt;&lt;/i&gt; 08.66827498</p>\r\n<p>&lt;hr /&gt;</p>\r\n<p>&lt;strong&gt;Chi nh&aacute;nh 2&lt;/strong&gt;</p>\r\n<p>&lt;i class=\"fa fa-map-marker\"&gt;&lt;/i&gt;<br />153/3 Nguyễn Thị Minh Khai - Phường Phạm Ngũ L&atilde;o - Quận 1</p>\r\n<p>&lt;i class=\"fa fa-phone\"&gt;&lt;/i&gt;<br />08.66827459</p>\r\n<p>&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/aside&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;div class=\"col-md-6 col-sm-12 footercol3\"&gt;<br />&lt;div class=\"widget-1 widget-first footer-widget\"&gt;&lt;aside id=\"virtue_split_content_widget-5\" class=\"widget virtue_split_content_widget\"&gt;&lt;!-- Image Split --&gt;<br />&lt;div id=\"kt-image-split-47\" class=\"kt-image-slit\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-sm-24 kt-si-imagecol content-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;<br />&lt;h2 class=\"kt_imgsplit_title\"&gt;Danh mục nổi bật&lt;/h2&gt;<br />&lt;div class=\"kt_imgsplit_content\"&gt;<br />&lt;ul&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/quan/quan-jeans-rach-goi/\"&gt;Quần jeans r&aacute;ch gối&lt;/a&gt;&lt;/li&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/dam/dam-thiet-ke/\"&gt;Đầm thiết kế&lt;/a&gt;&lt;/li&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/ao/ao-croptop/\"&gt;&Aacute;o Croptop&lt;/a&gt;&lt;/li&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/chan-vay/but-chi/\"&gt;B&uacute;t ch&igrave;&lt;/a&gt;&lt;/li&gt;<br /> &lt;li&gt;&lt;a href=\"http://shopforgirl.vn/san-pham/chan-vay/midi-xe-truoc/\"&gt;Midi xẻ trước&lt;/a&gt;&lt;/li&gt;<br />&lt;/ul&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/aside&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;div class=\"col-md-6 col-sm-12 footercol4\"&gt;<br />&lt;div class=\"widget-1 widget-first footer-widget\"&gt;&lt;aside id=\"virtue_split_content_widget-6\" class=\"widget virtue_split_content_widget\"&gt;&lt;!-- Image Split --&gt;<br />&lt;div id=\"kt-image-split-50\" class=\"kt-image-slit\"&gt;<br />&lt;div class=\"row\"&gt;<br />&lt;div class=\"col-sm-24 kt-si-imagecol content-ktsi-left\"&gt;<br />&lt;div class=\"kt-si-table-box\" style=\"height: 200px;\"&gt;<br />&lt;div class=\"kt-si-cell-box\"&gt;<br />&lt;h2 class=\"kt_imgsplit_title\"&gt;Li&ecirc;n hệ&lt;/h2&gt;<br />&lt;div class=\"kt_imgsplit_content\"&gt;&lt;i class=\"fa fa-envelope-o\"&gt;&lt;/i&gt; info@shopforgirl.vn</p>\r\n<p>&lt;i class=\"fa fa-facebook\"&gt;&lt;/i&gt;<br />&lt;a href=\"http://www.facebook.com/shop4girl.2011\"&gt;shopforgirl fanpage&lt;/a&gt;</p>\r\n<p>Mở cửa từ 10h đến 21h30</p>\r\n<p>&lt;hr /&gt;</p>\r\n<p>&lt;strong&gt;Thanh to&aacute;n&lt;/strong&gt;</p>\r\n<p>B&ugrave;i Nguyễn Trường An</p>\r\n<p>TK Vietcombank : 0531000282454</p>\r\n<p>TK Đ&Ocirc;NG &Aacute; : 0107854175</p>\r\n<p>Chi nh&aacute;nh Bạch Đằng TP.Hồ Ch&iacute; Minh</p>\r\n<p>&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/aside&gt;&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;/div&gt;<br />&lt;!-- Row --&gt;</p>\r\n<p>&lt;/div&gt;</p>\";s:9:\"parent_id\";i:0;s:6:\"row_id\";s:1:\"2\";s:10:\"created_in\";i:1;s:10:\"updated_in\";i:2147483647;}'),(59,'restrict',163,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:9:\"allow_ips\";s:0:\"\";}'),(60,'debug',163,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:3:{s:25:\"template_hints_storefront\";s:1:\"0\";s:20:\"template_hints_admin\";s:1:\"0\";s:21:\"template_hints_blocks\";s:1:\"0\";}'),(61,'template',163,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:13:\"allow_symlink\";s:1:\"0\";}'),(62,'translate_inline',163,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:2:{s:6:\"active\";s:1:\"0\";s:12:\"active_admin\";s:1:\"0\";}'),(63,'js',163,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:3:{s:11:\"merge_files\";s:1:\"0\";s:18:\"enable_js_bundling\";s:1:\"0\";s:12:\"minify_files\";s:1:\"0\";}'),(64,'css',163,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:2:{s:15:\"merge_css_files\";s:1:\"0\";s:12:\"minify_files\";s:1:\"0\";}'),(65,'static',163,NULL,'a:1:{s:13:\"__was_created\";b:1;}','a:1:{s:4:\"sign\";s:1:\"1\";}');
/*!40000 ALTER TABLE `spg_magento_logging_event_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_reminder_rule`
--

DROP TABLE IF EXISTS `spg_magento_reminder_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_reminder_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `conditions_serialized` mediumtext NOT NULL COMMENT 'Conditions Serialized',
  `condition_sql` mediumtext COMMENT 'Condition Sql',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `salesrule_id` int(10) unsigned DEFAULT NULL COMMENT 'Salesrule Id',
  `schedule` varchar(255) DEFAULT NULL COMMENT 'Schedule',
  `default_label` varchar(255) DEFAULT NULL COMMENT 'Default Label',
  `default_description` text COMMENT 'Default Description',
  `from_date` datetime DEFAULT NULL COMMENT 'Active From',
  `to_date` datetime DEFAULT NULL COMMENT 'Active To',
  PRIMARY KEY (`rule_id`),
  KEY `SPG_MAGENTO_REMINDER_RULE_SALESRULE_ID` (`salesrule_id`),
  CONSTRAINT `FK_C900B53E3874EE81D5B3E07E64E3B01B` FOREIGN KEY (`salesrule_id`) REFERENCES `spg_sequence_salesrule` (`sequence_value`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Reminder Rule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_reminder_rule`
--

LOCK TABLES `spg_magento_reminder_rule` WRITE;
/*!40000 ALTER TABLE `spg_magento_reminder_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_reminder_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_reminder_rule_coupon`
--

DROP TABLE IF EXISTS `spg_magento_reminder_rule_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_reminder_rule_coupon` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `coupon_id` int(10) unsigned DEFAULT NULL COMMENT 'Coupon Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `associated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Associated At',
  `emails_failed` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Emails Failed',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  PRIMARY KEY (`rule_id`,`customer_id`),
  CONSTRAINT `FK_39B000B1E01E8382C62DA9D77B2A4BD2` FOREIGN KEY (`rule_id`) REFERENCES `spg_magento_reminder_rule` (`rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Reminder Rule Coupon';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_reminder_rule_coupon`
--

LOCK TABLES `spg_magento_reminder_rule_coupon` WRITE;
/*!40000 ALTER TABLE `spg_magento_reminder_rule_coupon` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_reminder_rule_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_reminder_rule_log`
--

DROP TABLE IF EXISTS `spg_magento_reminder_rule_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_reminder_rule_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `sent_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Sent At',
  PRIMARY KEY (`log_id`),
  KEY `SPG_MAGENTO_REMINDER_RULE_LOG_RULE_ID` (`rule_id`),
  KEY `SPG_MAGENTO_REMINDER_RULE_LOG_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_587C9D3F40E85328856BD401651859A9` FOREIGN KEY (`rule_id`) REFERENCES `spg_magento_reminder_rule` (`rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Reminder Rule Log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_reminder_rule_log`
--

LOCK TABLES `spg_magento_reminder_rule_log` WRITE;
/*!40000 ALTER TABLE `spg_magento_reminder_rule_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_reminder_rule_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_reminder_rule_website`
--

DROP TABLE IF EXISTS `spg_magento_reminder_rule_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_reminder_rule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `SPG_MAGENTO_REMINDER_RULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_EBDC65AC7B575228232CFEA869151B5E` FOREIGN KEY (`rule_id`) REFERENCES `spg_magento_reminder_rule` (`rule_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_REMINDER_RULE_WS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Reminder Rule Website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_reminder_rule_website`
--

LOCK TABLES `spg_magento_reminder_rule_website` WRITE;
/*!40000 ALTER TABLE `spg_magento_reminder_rule_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_reminder_rule_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_reminder_template`
--

DROP TABLE IF EXISTS `spg_magento_reminder_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_reminder_template` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `store_id` smallint(6) NOT NULL COMMENT 'Store Id',
  `template_id` int(10) unsigned DEFAULT NULL COMMENT 'Template ID',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `description` text COMMENT 'Description',
  PRIMARY KEY (`rule_id`,`store_id`),
  KEY `SPG_MAGENTO_REMINDER_TEMPLATE_TEMPLATE_ID` (`template_id`),
  CONSTRAINT `FK_CD2DE295291781C291D8EFE917756409` FOREIGN KEY (`template_id`) REFERENCES `spg_email_template` (`template_id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DCA1C169C6ABBA59F5DA225D4398EE7C` FOREIGN KEY (`rule_id`) REFERENCES `spg_magento_reminder_rule` (`rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Reminder Template';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_reminder_template`
--

LOCK TABLES `spg_magento_reminder_template` WRITE;
/*!40000 ALTER TABLE `spg_magento_reminder_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_reminder_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_reward`
--

DROP TABLE IF EXISTS `spg_magento_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_reward` (
  `reward_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Reward Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `points_balance` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Points Balance',
  `website_currency_code` varchar(3) DEFAULT NULL COMMENT 'Website Currency Code',
  PRIMARY KEY (`reward_id`),
  UNIQUE KEY `SPG_MAGENTO_REWARD_CUSTOMER_ID_WEBSITE_ID` (`customer_id`,`website_id`),
  KEY `SPG_MAGENTO_REWARD_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_MAGENTO_REWARD_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Reward';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_reward`
--

LOCK TABLES `spg_magento_reward` WRITE;
/*!40000 ALTER TABLE `spg_magento_reward` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_reward_history`
--

DROP TABLE IF EXISTS `spg_magento_reward_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_reward_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `reward_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Reward Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `action` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Action',
  `entity` int(11) DEFAULT NULL COMMENT 'Entity',
  `points_balance` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Points Balance',
  `points_delta` int(11) NOT NULL DEFAULT '0' COMMENT 'Points Delta',
  `points_used` int(11) NOT NULL DEFAULT '0' COMMENT 'Points Used',
  `points_voided` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Points Voided',
  `currency_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Currency Amount',
  `currency_delta` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Currency Delta',
  `base_currency_code` varchar(5) NOT NULL COMMENT 'Base Currency Code',
  `additional_data` text NOT NULL COMMENT 'Additional Data',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `expired_at_static` timestamp NULL DEFAULT NULL COMMENT 'Expired At Static',
  `expired_at_dynamic` timestamp NULL DEFAULT NULL COMMENT 'Expired At Dynamic',
  `is_expired` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Expired',
  `is_duplicate_of` int(10) unsigned DEFAULT NULL COMMENT 'Is Duplicate Of',
  `notification_sent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Notification Sent',
  PRIMARY KEY (`history_id`),
  KEY `SPG_MAGENTO_REWARD_HISTORY_REWARD_ID` (`reward_id`),
  KEY `SPG_MAGENTO_REWARD_HISTORY_WEBSITE_ID` (`website_id`),
  KEY `SPG_MAGENTO_REWARD_HISTORY_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_MAGENTO_REWARD_HISTORY_REWARD_ID_MAGENTO_REWARD_REWARD_ID` FOREIGN KEY (`reward_id`) REFERENCES `spg_magento_reward` (`reward_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_REWARD_HISTORY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_MAGENTO_REWARD_HISTORY_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Reward History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_reward_history`
--

LOCK TABLES `spg_magento_reward_history` WRITE;
/*!40000 ALTER TABLE `spg_magento_reward_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_reward_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_reward_rate`
--

DROP TABLE IF EXISTS `spg_magento_reward_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_reward_rate` (
  `rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rate Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `direction` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Direction',
  `points` int(11) NOT NULL DEFAULT '0' COMMENT 'Points',
  `currency_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Currency Amount',
  PRIMARY KEY (`rate_id`),
  UNIQUE KEY `SPG_MAGENTO_REWARD_RATE_WEBSITE_ID_CUSTOMER_GROUP_ID_DIRECTION` (`website_id`,`customer_group_id`,`direction`),
  KEY `SPG_MAGENTO_REWARD_RATE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `SPG_MAGENTO_REWARD_RATE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Reward Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_reward_rate`
--

LOCK TABLES `spg_magento_reward_rate` WRITE;
/*!40000 ALTER TABLE `spg_magento_reward_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_reward_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_reward_salesrule`
--

DROP TABLE IF EXISTS `spg_magento_reward_salesrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_reward_salesrule` (
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `points_delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Points Delta',
  UNIQUE KEY `SPG_MAGENTO_REWARD_SALESRULE_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_436D3D4A32C22F44BE814C09A84DA87E` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_salesrule` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Reward Reward Salesrule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_reward_salesrule`
--

LOCK TABLES `spg_magento_reward_salesrule` WRITE;
/*!40000 ALTER TABLE `spg_magento_reward_salesrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_reward_salesrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma`
--

DROP TABLE IF EXISTS `spg_magento_rma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'RMA Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `date_requested` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'RMA Requested At',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `customer_custom_email` varchar(255) DEFAULT NULL COMMENT 'Customer Custom Email',
  `protect_code` varchar(255) DEFAULT NULL COMMENT 'Protect Code',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_MAGENTO_RMA_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_MAGENTO_RMA_STATUS` (`status`),
  KEY `SPG_MAGENTO_RMA_IS_ACTIVE` (`is_active`),
  KEY `SPG_MAGENTO_RMA_DATE_REQUESTED` (`date_requested`),
  KEY `SPG_MAGENTO_RMA_ORDER_ID` (`order_id`),
  KEY `SPG_MAGENTO_RMA_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SPG_MAGENTO_RMA_STORE_ID` (`store_id`),
  KEY `SPG_MAGENTO_RMA_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `SPG_MAGENTO_RMA_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_MAGENTO_RMA_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA LIst';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma`
--

LOCK TABLES `spg_magento_rma` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_grid`
--

DROP TABLE IF EXISTS `spg_magento_rma_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'RMA Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `date_requested` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'RMA Requested At',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `order_date` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `customer_name` varchar(255) DEFAULT NULL COMMENT 'Customer Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_MAGENTO_RMA_GRID_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_MAGENTO_RMA_GRID_STATUS` (`status`),
  KEY `SPG_MAGENTO_RMA_GRID_DATE_REQUESTED` (`date_requested`),
  KEY `SPG_MAGENTO_RMA_GRID_ORDER_ID` (`order_id`),
  KEY `SPG_MAGENTO_RMA_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SPG_MAGENTO_RMA_GRID_ORDER_DATE` (`order_date`),
  KEY `SPG_MAGENTO_RMA_GRID_STORE_ID` (`store_id`),
  KEY `SPG_MAGENTO_RMA_GRID_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_MAGENTO_RMA_GRID_CUSTOMER_NAME` (`customer_name`),
  CONSTRAINT `SPG_MAGENTO_RMA_GRID_ENTITY_ID_MAGENTO_RMA_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_magento_rma` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_grid`
--

LOCK TABLES `spg_magento_rma_grid` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_item_eav_attribute`
--

DROP TABLE IF EXISTS `spg_magento_rma_item_eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_item_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `input_filter` varchar(255) DEFAULT NULL COMMENT 'Input Filter',
  `multiline_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Multiline Count',
  `validate_rules` text COMMENT 'Validate Rules',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `data_model` varchar(255) DEFAULT NULL COMMENT 'Data Model',
  PRIMARY KEY (`attribute_id`),
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_EAV_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA Item EAV Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_item_eav_attribute`
--

LOCK TABLES `spg_magento_rma_item_eav_attribute` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_item_eav_attribute` DISABLE KEYS */;
INSERT INTO `spg_magento_rma_item_eav_attribute` VALUES (157,0,NULL,0,NULL,1,10,NULL),(158,0,NULL,0,NULL,1,20,NULL),(159,0,NULL,0,NULL,1,30,NULL),(160,0,NULL,0,NULL,1,40,NULL),(161,0,NULL,0,NULL,1,50,NULL),(162,0,NULL,0,NULL,1,60,NULL),(163,0,NULL,0,NULL,1,70,NULL),(164,0,NULL,0,NULL,1,80,NULL),(165,1,NULL,0,'a:0:{}',0,90,NULL),(166,1,NULL,0,'a:0:{}',0,100,NULL),(167,1,NULL,0,'a:0:{}',0,110,NULL),(168,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,120,NULL),(169,0,NULL,0,NULL,1,45,NULL),(170,0,NULL,0,NULL,1,46,NULL),(171,0,NULL,0,NULL,1,47,NULL),(172,0,NULL,0,NULL,1,48,NULL),(173,0,NULL,0,NULL,1,15,NULL);
/*!40000 ALTER TABLE `spg_magento_rma_item_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_item_eav_attribute_website`
--

DROP TABLE IF EXISTS `spg_magento_rma_item_eav_attribute_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_item_eav_attribute_website` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `is_visible` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Visible',
  `is_required` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Required',
  `default_value` text COMMENT 'Default Value',
  `multiline_count` smallint(5) unsigned DEFAULT NULL COMMENT 'Multiline Count',
  PRIMARY KEY (`attribute_id`,`website_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_EAV_ATTRIBUTE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_EAV_ATTR_WS_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_EAV_ATTR_WS_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise RMA Item Eav Attribute Website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_item_eav_attribute_website`
--

LOCK TABLES `spg_magento_rma_item_eav_attribute_website` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_item_eav_attribute_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_item_eav_attribute_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_item_entity`
--

DROP TABLE IF EXISTS `spg_magento_rma_item_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_item_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `rma_entity_id` int(10) unsigned NOT NULL COMMENT 'RMA entity id',
  `is_qty_decimal` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Qty Decimal',
  `qty_requested` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty of requested for RMA items',
  `qty_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Qty of authorized items',
  `qty_approved` decimal(12,4) DEFAULT NULL COMMENT 'Qty of approved items',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `order_item_id` int(10) unsigned NOT NULL COMMENT 'Product Order Item Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `qty_returned` decimal(12,4) DEFAULT NULL COMMENT 'Qty of returned items',
  `product_sku` varchar(255) DEFAULT NULL COMMENT 'Product Sku',
  `product_admin_name` varchar(255) DEFAULT NULL COMMENT 'Product Name For Backend',
  `product_admin_sku` varchar(255) DEFAULT NULL COMMENT 'Product Sku For Backend',
  `product_options` text COMMENT 'Product Options',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_RMA_ENTITY_ID_MAGENTO_RMA_ENTITY_ID` (`rma_entity_id`),
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_ENTITY_RMA_ENTITY_ID_MAGENTO_RMA_ENTITY_ID` FOREIGN KEY (`rma_entity_id`) REFERENCES `spg_magento_rma` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA Item Entity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_item_entity`
--

LOCK TABLES `spg_magento_rma_item_entity` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_item_entity_datetime`
--

DROP TABLE IF EXISTS `spg_magento_rma_item_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_item_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTT_DTIME_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_0B78646000D073D0EA6E292EF09C82AC` FOREIGN KEY (`entity_id`) REFERENCES `spg_magento_rma_item_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA Item Entity Datetime';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_item_entity_datetime`
--

LOCK TABLES `spg_magento_rma_item_entity_datetime` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_item_entity_decimal`
--

DROP TABLE IF EXISTS `spg_magento_rma_item_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_item_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_A542DDA149AA54DF9345A3B9B8BFA6E0` FOREIGN KEY (`entity_id`) REFERENCES `spg_magento_rma_item_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA Item Entity Decimal';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_item_entity_decimal`
--

LOCK TABLES `spg_magento_rma_item_entity_decimal` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_item_entity_int`
--

DROP TABLE IF EXISTS `spg_magento_rma_item_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_item_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_1EC3C04B3BBE5850D4ADE0D8FA2B3AAB` FOREIGN KEY (`entity_id`) REFERENCES `spg_magento_rma_item_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA Item Entity Int';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_item_entity_int`
--

LOCK TABLES `spg_magento_rma_item_entity_int` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_item_entity_text`
--

DROP TABLE IF EXISTS `spg_magento_rma_item_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_item_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_3947FC8B1E4E6B71B77FEECFC8D11FCD` FOREIGN KEY (`entity_id`) REFERENCES `spg_magento_rma_item_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA Item Entity Text';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_item_entity_text`
--

LOCK TABLES `spg_magento_rma_item_entity_text` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_item_entity_varchar`
--

DROP TABLE IF EXISTS `spg_magento_rma_item_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_item_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_E5C473FF9AC5DD1679FFB11B41C1EB07` FOREIGN KEY (`entity_id`) REFERENCES `spg_magento_rma_item_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA Item Entity Varchar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_item_entity_varchar`
--

LOCK TABLES `spg_magento_rma_item_entity_varchar` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_item_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_item_form_attribute`
--

DROP TABLE IF EXISTS `spg_magento_rma_item_form_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_item_form_attribute` (
  `form_code` varchar(32) NOT NULL COMMENT 'Form Code',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`form_code`,`attribute_id`),
  KEY `SPG_MAGENTO_RMA_ITEM_FORM_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_MAGENTO_RMA_ITEM_FORM_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA Item Form Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_item_form_attribute`
--

LOCK TABLES `spg_magento_rma_item_form_attribute` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_item_form_attribute` DISABLE KEYS */;
INSERT INTO `spg_magento_rma_item_form_attribute` VALUES ('default',165),('default',166),('default',167),('default',168);
/*!40000 ALTER TABLE `spg_magento_rma_item_form_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_shipping_label`
--

DROP TABLE IF EXISTS `spg_magento_rma_shipping_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_shipping_label` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `rma_entity_id` int(10) unsigned NOT NULL COMMENT 'RMA Entity Id',
  `shipping_label` mediumblob COMMENT 'Shipping Label Content',
  `packages` text COMMENT 'Packed Products in Packages',
  `track_number` text COMMENT 'Tracking Number',
  `carrier_title` varchar(255) DEFAULT NULL COMMENT 'Carrier Title',
  `method_title` varchar(255) DEFAULT NULL COMMENT 'Method Title',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT 'Carrier Code',
  `method_code` varchar(32) DEFAULT NULL COMMENT 'Method Code',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `is_admin` smallint(6) DEFAULT NULL COMMENT 'Is this Label Created by Merchant',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_MAGENTO_RMA_SHPP_LBL_RMA_ENTT_ID_MAGENTO_RMA_ENTT_ID` (`rma_entity_id`),
  CONSTRAINT `SPG_MAGENTO_RMA_SHPP_LBL_RMA_ENTT_ID_MAGENTO_RMA_ENTT_ID` FOREIGN KEY (`rma_entity_id`) REFERENCES `spg_magento_rma` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of RMA Shipping Labels';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_shipping_label`
--

LOCK TABLES `spg_magento_rma_shipping_label` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_shipping_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_shipping_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_rma_status_history`
--

DROP TABLE IF EXISTS `spg_magento_rma_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_rma_status_history` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `rma_entity_id` int(10) unsigned NOT NULL COMMENT 'RMA Entity Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `is_admin` smallint(6) DEFAULT NULL COMMENT 'Is this Merchant Comment',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_MAGENTO_RMA_STATUS_HISTORY_RMA_ENTITY_ID` (`rma_entity_id`),
  KEY `SPG_MAGENTO_RMA_STATUS_HISTORY_CREATED_AT` (`created_at`),
  CONSTRAINT `SPG_MAGENTO_RMA_STS_HISTORY_RMA_ENTT_ID_MAGENTO_RMA_ENTT_ID` FOREIGN KEY (`rma_entity_id`) REFERENCES `spg_magento_rma` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RMA status history magento_rma_status_history';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_rma_status_history`
--

LOCK TABLES `spg_magento_rma_status_history` WRITE;
/*!40000 ALTER TABLE `spg_magento_rma_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_rma_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_sales_creditmemo_grid_archive`
--

DROP TABLE IF EXISTS `spg_magento_sales_creditmemo_grid_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_sales_creditmemo_grid_archive` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `order_status` varchar(32) DEFAULT NULL COMMENT 'Order Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `customer_name` varchar(128) NOT NULL COMMENT 'Customer Name',
  `customer_email` varchar(128) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `payment_method` varchar(32) DEFAULT NULL COMMENT 'Payment Method',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Information',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `shipping_and_handling` decimal(12,4) DEFAULT NULL COMMENT 'Shipping And Handling',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `order_base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Order Base Grand Total',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_CREATED_AT` (`created_at`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_UPDATED_AT` (`updated_at`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_ORDER_CREATED_AT` (`order_created_at`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_STATE` (`state`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_BILLING_NAME` (`billing_name`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_ORDER_STATUS` (`order_status`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_STORE_ID` (`store_id`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_ORDER_BASE_GRAND_TOTAL` (`order_base_grand_total`),
  KEY `SPG_MAGENTO_SALES_CREDITMEMO_GRID_ARCHIVE_ORDER_ID` (`order_id`),
  FULLTEXT KEY `FTI_C5E7EBF9F52AC9DA6E81406741958E10` (`increment_id`,`order_increment_id`,`billing_name`,`billing_address`,`shipping_address`,`customer_name`,`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Spg Magento Sales Creditmemo Grid Archive';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_sales_creditmemo_grid_archive`
--

LOCK TABLES `spg_magento_sales_creditmemo_grid_archive` WRITE;
/*!40000 ALTER TABLE `spg_magento_sales_creditmemo_grid_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_sales_creditmemo_grid_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_sales_invoice_grid_archive`
--

DROP TABLE IF EXISTS `spg_magento_sales_invoice_grid_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_sales_invoice_grid_archive` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `customer_name` varchar(255) DEFAULT NULL COMMENT 'Customer Name',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `payment_method` varchar(128) DEFAULT NULL COMMENT 'Payment Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Information',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `shipping_and_handling` decimal(12,4) DEFAULT NULL COMMENT 'Shipping And Handling',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_STORE_ID` (`store_id`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_GRAND_TOTAL` (`grand_total`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_ORDER_ID` (`order_id`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_STATE` (`state`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_CREATED_AT` (`created_at`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_UPDATED_AT` (`updated_at`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_ORDER_CREATED_AT` (`order_created_at`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_BILLING_NAME` (`billing_name`),
  KEY `SPG_MAGENTO_SALES_INVOICE_GRID_ARCHIVE_BASE_GRAND_TOTAL` (`base_grand_total`),
  FULLTEXT KEY `FTI_674DA097D775A815A670417265C53475` (`increment_id`,`order_increment_id`,`billing_name`,`billing_address`,`shipping_address`,`customer_name`,`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Spg Magento Sales Invoice Grid Archive';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_sales_invoice_grid_archive`
--

LOCK TABLES `spg_magento_sales_invoice_grid_archive` WRITE;
/*!40000 ALTER TABLE `spg_magento_sales_invoice_grid_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_sales_invoice_grid_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_sales_order_grid_archive`
--

DROP TABLE IF EXISTS `spg_magento_sales_order_grid_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_sales_order_grid_archive` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Information',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group` varchar(255) DEFAULT NULL COMMENT 'Customer Group',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `shipping_and_handling` decimal(12,4) DEFAULT NULL COMMENT 'Shipping And Handling',
  `customer_name` varchar(255) DEFAULT NULL COMMENT 'Customer Name',
  `payment_method` varchar(255) DEFAULT NULL COMMENT 'Payment Method',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `refunded_to_store_credit` decimal(12,4) DEFAULT NULL COMMENT 'Refund to Store Credit',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_STATUS` (`status`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_STORE_ID` (`store_id`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_BASE_TOTAL_PAID` (`base_total_paid`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_GRAND_TOTAL` (`grand_total`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_TOTAL_PAID` (`total_paid`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_SHIPPING_NAME` (`shipping_name`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_BILLING_NAME` (`billing_name`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_CREATED_AT` (`created_at`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_MAGENTO_SALES_ORDER_GRID_ARCHIVE_UPDATED_AT` (`updated_at`),
  FULLTEXT KEY `FTI_1AC1694854DAF6FB727493BB5DAB2B34` (`increment_id`,`billing_name`,`shipping_name`,`shipping_address`,`billing_address`,`customer_name`,`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Spg Magento Sales Order Grid Archive';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_sales_order_grid_archive`
--

LOCK TABLES `spg_magento_sales_order_grid_archive` WRITE;
/*!40000 ALTER TABLE `spg_magento_sales_order_grid_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_sales_order_grid_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_sales_shipment_grid_archive`
--

DROP TABLE IF EXISTS `spg_magento_sales_shipment_grid_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_sales_shipment_grid_archive` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_increment_id` varchar(32) NOT NULL COMMENT 'Order Increment Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Order Created At',
  `customer_name` varchar(128) NOT NULL COMMENT 'Customer Name',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `order_status` varchar(32) DEFAULT NULL COMMENT 'Order Status',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `billing_name` varchar(128) DEFAULT NULL COMMENT 'Billing Name',
  `shipping_name` varchar(128) DEFAULT NULL COMMENT 'Shipping Name',
  `customer_email` varchar(128) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `payment_method` varchar(32) DEFAULT NULL COMMENT 'Payment Method',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_STORE_ID` (`store_id`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_TOTAL_QTY` (`total_qty`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_SHIPMENT_STATUS` (`shipment_status`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_ORDER_STATUS` (`order_status`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_CREATED_AT` (`created_at`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_UPDATED_AT` (`updated_at`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_ORDER_CREATED_AT` (`order_created_at`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_SHIPPING_NAME` (`shipping_name`),
  KEY `SPG_MAGENTO_SALES_SHIPMENT_GRID_ARCHIVE_BILLING_NAME` (`billing_name`),
  FULLTEXT KEY `FTI_B7DF5A18950199F2AEA26B4B5350BCF7` (`increment_id`,`order_increment_id`,`shipping_name`,`customer_name`,`customer_email`,`billing_address`,`shipping_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Spg Magento Sales Shipment Grid Archive';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_sales_shipment_grid_archive`
--

LOCK TABLES `spg_magento_sales_shipment_grid_archive` WRITE;
/*!40000 ALTER TABLE `spg_magento_sales_shipment_grid_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_sales_shipment_grid_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_salesrule_filter`
--

DROP TABLE IF EXISTS `spg_magento_salesrule_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_salesrule_filter` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `group_id` int(10) unsigned NOT NULL COMMENT 'Group Id',
  `weight` float NOT NULL DEFAULT '1' COMMENT 'Condition weight',
  `filter_text` varchar(255) NOT NULL COMMENT 'Filter text',
  `filter_text_generator_class` varchar(255) DEFAULT NULL COMMENT 'Filter text generator class name',
  `filter_text_generator_arguments` varchar(255) DEFAULT NULL COMMENT 'Filter text generator arguments',
  KEY `IDX_39E8E8DB3B077AB67ECB92CC60CBA0B6` (`filter_text_generator_class`,`filter_text_generator_arguments`),
  KEY `SPG_MAGENTO_SALESRULE_FILTER_RULE_ID` (`rule_id`),
  KEY `SPG_MAGENTO_SALESRULE_FILTER_FILTER_TEXT_RULE_ID_GROUP_ID` (`filter_text`,`rule_id`,`group_id`),
  CONSTRAINT `FK_C009362598AFA12590DA005C02B1B77E` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_salesrule` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise SalesRule Filter';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_salesrule_filter`
--

LOCK TABLES `spg_magento_salesrule_filter` WRITE;
/*!40000 ALTER TABLE `spg_magento_salesrule_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_salesrule_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_scheduled_operations`
--

DROP TABLE IF EXISTS `spg_magento_scheduled_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_scheduled_operations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `name` varchar(255) NOT NULL COMMENT 'Operation Name',
  `operation_type` varchar(50) NOT NULL COMMENT 'Operation',
  `entity_type` varchar(50) NOT NULL COMMENT 'Entity',
  `behavior` varchar(15) DEFAULT NULL COMMENT 'Behavior',
  `start_time` varchar(10) NOT NULL COMMENT 'Start Time',
  `freq` varchar(1) NOT NULL COMMENT 'Frequency',
  `force_import` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Force Import',
  `file_info` text COMMENT 'File Information',
  `details` varchar(255) DEFAULT NULL COMMENT 'Operation Details',
  `entity_attributes` text COMMENT 'Entity Attributes',
  `status` smallint(6) NOT NULL COMMENT 'Status',
  `is_success` smallint(6) NOT NULL DEFAULT '2' COMMENT 'Is Success',
  `last_run_date` timestamp NULL DEFAULT NULL COMMENT 'Last Run Date',
  `email_receiver` varchar(150) NOT NULL COMMENT 'Email Receiver',
  `email_sender` varchar(150) NOT NULL COMMENT 'Email Receiver',
  `email_template` varchar(250) NOT NULL COMMENT 'Email Template',
  `email_copy` varchar(255) DEFAULT NULL COMMENT 'Email Copy',
  `email_copy_method` varchar(10) NOT NULL COMMENT 'Email Copy Method',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Scheduled Import/Export Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_scheduled_operations`
--

LOCK TABLES `spg_magento_scheduled_operations` WRITE;
/*!40000 ALTER TABLE `spg_magento_scheduled_operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_scheduled_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule`
--

DROP TABLE IF EXISTS `spg_magento_targetrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `from_date` date DEFAULT NULL COMMENT 'From',
  `to_date` date DEFAULT NULL COMMENT 'To',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` text NOT NULL COMMENT 'Conditions Serialized',
  `actions_serialized` text NOT NULL COMMENT 'Actions Serialized',
  `positions_limit` int(11) NOT NULL DEFAULT '0' COMMENT 'Positions Limit',
  `apply_to` smallint(5) unsigned NOT NULL COMMENT 'Apply To',
  `sort_order` int(11) DEFAULT NULL COMMENT 'Sort Order',
  `action_select` text COMMENT 'Action Select',
  `action_select_bind` text COMMENT 'Action Select Bind',
  PRIMARY KEY (`rule_id`),
  KEY `SPG_MAGENTO_TARGETRULE_IS_ACTIVE` (`is_active`),
  KEY `SPG_MAGENTO_TARGETRULE_APPLY_TO` (`apply_to`),
  KEY `SPG_MAGENTO_TARGETRULE_SORT_ORDER` (`sort_order`),
  KEY `SPG_MAGENTO_TARGETRULE_FROM_DATE_TO_DATE` (`from_date`,`to_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule`
--

LOCK TABLES `spg_magento_targetrule` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule_customersegment`
--

DROP TABLE IF EXISTS `spg_magento_targetrule_customersegment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule_customersegment` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `segment_id` int(10) unsigned NOT NULL COMMENT 'Segment Id',
  PRIMARY KEY (`rule_id`,`segment_id`),
  KEY `SPG_MAGENTO_TARGETRULE_CUSTOMERSEGMENT_SEGMENT_ID` (`segment_id`),
  CONSTRAINT `FK_0161E458D169936CDA038EB2B5053BB9` FOREIGN KEY (`rule_id`) REFERENCES `spg_magento_targetrule` (`rule_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_1B7BDD8BE2B862B7D2316FDAD56B37BD` FOREIGN KEY (`segment_id`) REFERENCES `spg_magento_customersegment_segment` (`segment_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule Customersegment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule_customersegment`
--

LOCK TABLES `spg_magento_targetrule_customersegment` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule_customersegment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule_customersegment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule_index`
--

DROP TABLE IF EXISTS `spg_magento_targetrule_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `flag` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Flag',
  `customer_segment_id` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Customer Segment Id',
  PRIMARY KEY (`entity_id`,`store_id`,`customer_group_id`,`type_id`,`customer_segment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule_index`
--

LOCK TABLES `spg_magento_targetrule_index` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule_index_crosssell`
--

DROP TABLE IF EXISTS `spg_magento_targetrule_index_crosssell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule_index_crosssell` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `customer_segment_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Segment Id',
  `product_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Set Id',
  PRIMARY KEY (`product_set_id`),
  UNIQUE KEY `IDX_AEE08A4D8D2DEB79029F23559544D3BC` (`entity_id`,`store_id`,`customer_group_id`,`customer_segment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule Index Crosssell';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule_index_crosssell`
--

LOCK TABLES `spg_magento_targetrule_index_crosssell` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_crosssell` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_crosssell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule_index_crosssell_product`
--

DROP TABLE IF EXISTS `spg_magento_targetrule_index_crosssell_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule_index_crosssell_product` (
  `product_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'TargetRule Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  UNIQUE KEY `SPG_MAGENTO_TARGETRULE_IDX_CROSSSELL_PRD_PRD_SET_ID_PRD_ID` (`product_set_id`,`product_id`),
  CONSTRAINT `FK_2E05A98353C39D27AD416E1D682A507F` FOREIGN KEY (`product_set_id`) REFERENCES `spg_magento_targetrule_index_crosssell` (`product_set_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule Index Crosssell Products';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule_index_crosssell_product`
--

LOCK TABLES `spg_magento_targetrule_index_crosssell_product` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_crosssell_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_crosssell_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule_index_related`
--

DROP TABLE IF EXISTS `spg_magento_targetrule_index_related`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule_index_related` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `customer_segment_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Segment Id',
  `product_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Set Id',
  PRIMARY KEY (`product_set_id`),
  UNIQUE KEY `IDX_68512C0B145F0FCAFD87C91DCD977AF7` (`entity_id`,`store_id`,`customer_group_id`,`customer_segment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule Index Related';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule_index_related`
--

LOCK TABLES `spg_magento_targetrule_index_related` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_related` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_related` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule_index_related_product`
--

DROP TABLE IF EXISTS `spg_magento_targetrule_index_related_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule_index_related_product` (
  `product_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'TargetRule Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  UNIQUE KEY `SPG_MAGENTO_TARGETRULE_IDX_RELATED_PRD_PRD_SET_ID_PRD_ID` (`product_set_id`,`product_id`),
  CONSTRAINT `FK_833EB3BEB7F04C619DDB61D9B17D6D89` FOREIGN KEY (`product_set_id`) REFERENCES `spg_magento_targetrule_index_related` (`product_set_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule Index Related Products';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule_index_related_product`
--

LOCK TABLES `spg_magento_targetrule_index_related_product` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_related_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_related_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule_index_upsell`
--

DROP TABLE IF EXISTS `spg_magento_targetrule_index_upsell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule_index_upsell` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `customer_segment_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Segment Id',
  `product_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Set Id',
  PRIMARY KEY (`product_set_id`),
  UNIQUE KEY `IDX_B2B1D920BB47FDFF460DDB2A2C23E211` (`entity_id`,`store_id`,`customer_group_id`,`customer_segment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule Index Upsell';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule_index_upsell`
--

LOCK TABLES `spg_magento_targetrule_index_upsell` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_upsell` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_upsell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule_index_upsell_product`
--

DROP TABLE IF EXISTS `spg_magento_targetrule_index_upsell_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule_index_upsell_product` (
  `product_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'TargetRule Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  UNIQUE KEY `SPG_MAGENTO_TARGETRULE_IDX_UPSELL_PRD_PRD_SET_ID_PRD_ID` (`product_set_id`,`product_id`),
  CONSTRAINT `FK_D65EC1F9D3E6EE8E2A20C5B123C66CCF` FOREIGN KEY (`product_set_id`) REFERENCES `spg_magento_targetrule_index_upsell` (`product_set_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule Index Upsell Products';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule_index_upsell_product`
--

LOCK TABLES `spg_magento_targetrule_index_upsell_product` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_upsell_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule_index_upsell_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_targetrule_product`
--

DROP TABLE IF EXISTS `spg_magento_targetrule_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_targetrule_product` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  PRIMARY KEY (`rule_id`,`product_id`),
  KEY `SPG_MAGENTO_TARGETRULE_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_MAGENTO_TARGETRULE_PRD_PRD_ID_SPG_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_MAGENTO_TARGETRULE_PRD_RULE_ID_MAGENTO_TARGETRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `spg_magento_targetrule` (`rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Targetrule Product';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_targetrule_product`
--

LOCK TABLES `spg_magento_targetrule_product` WRITE;
/*!40000 ALTER TABLE `spg_magento_targetrule_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_targetrule_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_versionscms_hierarchy_lock`
--

DROP TABLE IF EXISTS `spg_magento_versionscms_hierarchy_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_versionscms_hierarchy_lock` (
  `lock_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Lock Id',
  `user_id` int(10) unsigned NOT NULL COMMENT 'User Id',
  `user_name` varchar(50) DEFAULT NULL COMMENT 'User Name',
  `session_id` varchar(50) DEFAULT NULL COMMENT 'Session Id',
  `started_at` int(10) unsigned NOT NULL COMMENT 'Started At',
  PRIMARY KEY (`lock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Cms Hierarchy Lock';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_versionscms_hierarchy_lock`
--

LOCK TABLES `spg_magento_versionscms_hierarchy_lock` WRITE;
/*!40000 ALTER TABLE `spg_magento_versionscms_hierarchy_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_versionscms_hierarchy_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_versionscms_hierarchy_metadata`
--

DROP TABLE IF EXISTS `spg_magento_versionscms_hierarchy_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_versionscms_hierarchy_metadata` (
  `node_id` int(10) unsigned NOT NULL COMMENT 'Node Id',
  `meta_first_last` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Meta First Last',
  `meta_next_previous` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Meta Next Previous',
  `meta_chapter` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Meta Chapter',
  `meta_section` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Meta Section',
  `meta_cs_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Meta Cs Enabled',
  `pager_visibility` smallint(5) unsigned DEFAULT NULL COMMENT 'Pager Visibility',
  `pager_frame` smallint(5) unsigned DEFAULT NULL COMMENT 'Pager Frame',
  `pager_jump` smallint(5) unsigned DEFAULT NULL COMMENT 'Pager Jump',
  `menu_visibility` smallint(5) unsigned DEFAULT NULL COMMENT 'Menu Visibility',
  `menu_excluded` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Menu Excluded',
  `menu_layout` varchar(50) DEFAULT NULL COMMENT 'Menu Layout',
  `menu_brief` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Menu Brief',
  `menu_levels_down` smallint(5) unsigned DEFAULT NULL COMMENT 'Menu Levels Down',
  `menu_ordered` smallint(5) unsigned DEFAULT NULL COMMENT 'Menu Ordered',
  `menu_list_type` varchar(50) DEFAULT NULL COMMENT 'Menu List Type',
  `top_menu_visibility` smallint(5) unsigned DEFAULT NULL COMMENT 'Top Menu Visibility',
  `top_menu_excluded` smallint(5) unsigned DEFAULT NULL COMMENT 'Top Menu Excluded',
  PRIMARY KEY (`node_id`),
  CONSTRAINT `FK_837463E31BCA5B41F04C1EC8A09EAB43` FOREIGN KEY (`node_id`) REFERENCES `spg_magento_versionscms_hierarchy_node` (`node_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Cms Hierarchy Metadata';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_versionscms_hierarchy_metadata`
--

LOCK TABLES `spg_magento_versionscms_hierarchy_metadata` WRITE;
/*!40000 ALTER TABLE `spg_magento_versionscms_hierarchy_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_versionscms_hierarchy_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_versionscms_hierarchy_node`
--

DROP TABLE IF EXISTS `spg_magento_versionscms_hierarchy_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_versionscms_hierarchy_node` (
  `node_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Node Id',
  `parent_node_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Node Id',
  `page_id` smallint(6) DEFAULT NULL COMMENT 'Page Id',
  `identifier` varchar(100) DEFAULT NULL COMMENT 'Identifier',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Level',
  `sort_order` int(11) NOT NULL COMMENT 'Sort Order',
  `request_url` varchar(255) DEFAULT NULL COMMENT 'Request Url',
  `xpath` varchar(255) DEFAULT NULL COMMENT 'Xpath',
  `scope` varchar(8) NOT NULL COMMENT 'Scope: default|website|store',
  `scope_id` int(10) unsigned NOT NULL COMMENT 'Scope Id',
  PRIMARY KEY (`node_id`),
  UNIQUE KEY `UNQ_C01DB11A07DEAA24F07335807CA0040D` (`request_url`,`scope`,`scope_id`),
  KEY `SPG_MAGENTO_VERSIONSCMS_HIERARCHY_NODE_PARENT_NODE_ID` (`parent_node_id`),
  KEY `SPG_MAGENTO_VERSIONSCMS_HIERARCHY_NODE_PAGE_ID` (`page_id`),
  CONSTRAINT `FK_5EC61D6CA21928EED95DF999C5355129` FOREIGN KEY (`parent_node_id`) REFERENCES `spg_magento_versionscms_hierarchy_node` (`node_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_8F28CD6F5A33B4290CEDFBA3A24EFCDD` FOREIGN KEY (`page_id`) REFERENCES `spg_sequence_cms_page` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Cms Hierarchy Node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_versionscms_hierarchy_node`
--

LOCK TABLES `spg_magento_versionscms_hierarchy_node` WRITE;
/*!40000 ALTER TABLE `spg_magento_versionscms_hierarchy_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_versionscms_hierarchy_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_magento_versionscms_increment`
--

DROP TABLE IF EXISTS `spg_magento_versionscms_increment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_magento_versionscms_increment` (
  `increment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Increment Id',
  `increment_type` int(11) NOT NULL COMMENT 'Increment Type',
  `increment_node` int(10) unsigned NOT NULL COMMENT 'Increment Node',
  `increment_level` int(10) unsigned NOT NULL COMMENT 'Increment Level',
  `last_id` int(10) unsigned NOT NULL COMMENT 'Last Id',
  PRIMARY KEY (`increment_id`),
  UNIQUE KEY `UNQ_145E77C4DFA13050DE9E3897D6869B94` (`increment_type`,`increment_node`,`increment_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enterprise Cms Increment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_magento_versionscms_increment`
--

LOCK TABLES `spg_magento_versionscms_increment` WRITE;
/*!40000 ALTER TABLE `spg_magento_versionscms_increment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_magento_versionscms_increment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_mview_state`
--

DROP TABLE IF EXISTS `spg_mview_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_mview_state` (
  `state_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'View State Id',
  `view_id` varchar(255) DEFAULT NULL COMMENT 'View Id',
  `mode` varchar(16) DEFAULT 'disabled' COMMENT 'View Mode',
  `status` varchar(16) DEFAULT 'idle' COMMENT 'View Status',
  `updated` datetime DEFAULT NULL COMMENT 'View updated time',
  `version_id` int(10) unsigned DEFAULT NULL COMMENT 'View Version Id',
  PRIMARY KEY (`state_id`),
  KEY `SPG_MVIEW_STATE_VIEW_ID` (`view_id`),
  KEY `SPG_MVIEW_STATE_MODE` (`mode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='View State';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_mview_state`
--

LOCK TABLES `spg_mview_state` WRITE;
/*!40000 ALTER TABLE `spg_mview_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_mview_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_newsletter_problem`
--

DROP TABLE IF EXISTS `spg_newsletter_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_newsletter_problem` (
  `problem_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Problem Id',
  `subscriber_id` int(10) unsigned DEFAULT NULL COMMENT 'Subscriber Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `problem_error_code` int(10) unsigned DEFAULT '0' COMMENT 'Problem Error Code',
  `problem_error_text` varchar(200) DEFAULT NULL COMMENT 'Problem Error Text',
  PRIMARY KEY (`problem_id`),
  KEY `SPG_NEWSLETTER_PROBLEM_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `SPG_NEWSLETTER_PROBLEM_QUEUE_ID` (`queue_id`),
  CONSTRAINT `SPG_NEWSLETTER_PROBLEM_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `spg_newsletter_queue` (`queue_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_NLTTR_PROBLEM_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `spg_newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Problems';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_newsletter_problem`
--

LOCK TABLES `spg_newsletter_problem` WRITE;
/*!40000 ALTER TABLE `spg_newsletter_problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_newsletter_problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_newsletter_queue`
--

DROP TABLE IF EXISTS `spg_newsletter_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_newsletter_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID',
  `newsletter_type` int(11) DEFAULT NULL COMMENT 'Newsletter Type',
  `newsletter_text` text COMMENT 'Newsletter Text',
  `newsletter_styles` text COMMENT 'Newsletter Styles',
  `newsletter_subject` varchar(200) DEFAULT NULL COMMENT 'Newsletter Subject',
  `newsletter_sender_name` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Name',
  `newsletter_sender_email` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Email',
  `queue_status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Status',
  `queue_start_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Start At',
  `queue_finish_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Finish At',
  PRIMARY KEY (`queue_id`),
  KEY `SPG_NEWSLETTER_QUEUE_TEMPLATE_ID` (`template_id`),
  CONSTRAINT `SPG_NEWSLETTER_QUEUE_TEMPLATE_ID_NEWSLETTER_TEMPLATE_TEMPLATE_ID` FOREIGN KEY (`template_id`) REFERENCES `spg_newsletter_template` (`template_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_newsletter_queue`
--

LOCK TABLES `spg_newsletter_queue` WRITE;
/*!40000 ALTER TABLE `spg_newsletter_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_newsletter_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_newsletter_queue_link`
--

DROP TABLE IF EXISTS `spg_newsletter_queue_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_newsletter_queue_link` (
  `queue_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Link Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `subscriber_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subscriber Id',
  `letter_sent_at` timestamp NULL DEFAULT NULL COMMENT 'Letter Sent At',
  PRIMARY KEY (`queue_link_id`),
  KEY `SPG_NEWSLETTER_QUEUE_LINK_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `SPG_NEWSLETTER_QUEUE_LINK_QUEUE_ID_LETTER_SENT_AT` (`queue_id`,`letter_sent_at`),
  CONSTRAINT `SPG_NEWSLETTER_QUEUE_LINK_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `spg_newsletter_queue` (`queue_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_NLTTR_QUEUE_LNK_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `spg_newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Link';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_newsletter_queue_link`
--

LOCK TABLES `spg_newsletter_queue_link` WRITE;
/*!40000 ALTER TABLE `spg_newsletter_queue_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_newsletter_queue_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_newsletter_queue_store_link`
--

DROP TABLE IF EXISTS `spg_newsletter_queue_store_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_newsletter_queue_store_link` (
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`queue_id`,`store_id`),
  KEY `SPG_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_NLTTR_QUEUE_STORE_LNK_QUEUE_ID_NLTTR_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `spg_newsletter_queue` (`queue_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Store Link';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_newsletter_queue_store_link`
--

LOCK TABLES `spg_newsletter_queue_store_link` WRITE;
/*!40000 ALTER TABLE `spg_newsletter_queue_store_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_newsletter_queue_store_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_newsletter_subscriber`
--

DROP TABLE IF EXISTS `spg_newsletter_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_newsletter_subscriber` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Subscriber Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `change_status_at` timestamp NULL DEFAULT NULL COMMENT 'Change Status At',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `subscriber_email` varchar(150) DEFAULT NULL COMMENT 'Subscriber Email',
  `subscriber_status` int(11) NOT NULL DEFAULT '0' COMMENT 'Subscriber Status',
  `subscriber_confirm_code` varchar(32) DEFAULT 'NULL' COMMENT 'Subscriber Confirm Code',
  PRIMARY KEY (`subscriber_id`),
  KEY `SPG_NEWSLETTER_SUBSCRIBER_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_NEWSLETTER_SUBSCRIBER_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_NEWSLETTER_SUBSCRIBER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Subscriber';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_newsletter_subscriber`
--

LOCK TABLES `spg_newsletter_subscriber` WRITE;
/*!40000 ALTER TABLE `spg_newsletter_subscriber` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_newsletter_subscriber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_newsletter_template`
--

DROP TABLE IF EXISTS `spg_newsletter_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_newsletter_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template ID',
  `template_code` varchar(150) DEFAULT NULL COMMENT 'Template Code',
  `template_text` text COMMENT 'Template Text',
  `template_styles` text COMMENT 'Template Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) DEFAULT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `template_actual` smallint(5) unsigned DEFAULT '1' COMMENT 'Template Actual',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Added At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  PRIMARY KEY (`template_id`),
  KEY `SPG_NEWSLETTER_TEMPLATE_TEMPLATE_ACTUAL` (`template_actual`),
  KEY `SPG_NEWSLETTER_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `SPG_NEWSLETTER_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Template';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_newsletter_template`
--

LOCK TABLES `spg_newsletter_template` WRITE;
/*!40000 ALTER TABLE `spg_newsletter_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_newsletter_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_oauth_consumer`
--

DROP TABLE IF EXISTS `spg_oauth_consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_oauth_consumer` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `name` varchar(255) NOT NULL COMMENT 'Name of consumer',
  `key` varchar(32) NOT NULL COMMENT 'Key code',
  `secret` varchar(32) NOT NULL COMMENT 'Secret code',
  `callback_url` text COMMENT 'Callback URL',
  `rejected_callback_url` text NOT NULL COMMENT 'Rejected callback URL',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_OAUTH_CONSUMER_KEY` (`key`),
  UNIQUE KEY `SPG_OAUTH_CONSUMER_SECRET` (`secret`),
  KEY `SPG_OAUTH_CONSUMER_CREATED_AT` (`created_at`),
  KEY `SPG_OAUTH_CONSUMER_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Consumers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_oauth_consumer`
--

LOCK TABLES `spg_oauth_consumer` WRITE;
/*!40000 ALTER TABLE `spg_oauth_consumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_oauth_consumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_oauth_nonce`
--

DROP TABLE IF EXISTS `spg_oauth_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_oauth_nonce` (
  `nonce` varchar(32) NOT NULL COMMENT 'Nonce String',
  `timestamp` int(10) unsigned NOT NULL COMMENT 'Nonce Timestamp',
  `consumer_id` int(10) unsigned NOT NULL COMMENT 'Consumer ID',
  UNIQUE KEY `SPG_OAUTH_NONCE_NONCE_CONSUMER_ID` (`nonce`,`consumer_id`),
  KEY `SPG_OAUTH_NONCE_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` (`consumer_id`),
  CONSTRAINT `SPG_OAUTH_NONCE_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `spg_oauth_consumer` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Nonce';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_oauth_nonce`
--

LOCK TABLES `spg_oauth_nonce` WRITE;
/*!40000 ALTER TABLE `spg_oauth_nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_oauth_nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_oauth_token`
--

DROP TABLE IF EXISTS `spg_oauth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_oauth_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `consumer_id` int(10) unsigned DEFAULT NULL COMMENT 'Oauth Consumer ID',
  `admin_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin user ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer user ID',
  `type` varchar(16) NOT NULL COMMENT 'Token Type',
  `token` varchar(32) NOT NULL COMMENT 'Token',
  `secret` varchar(32) NOT NULL COMMENT 'Token Secret',
  `verifier` varchar(32) DEFAULT NULL COMMENT 'Token Verifier',
  `callback_url` text NOT NULL COMMENT 'Token Callback URL',
  `revoked` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token revoked',
  `authorized` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token authorized',
  `user_type` int(11) DEFAULT NULL COMMENT 'User type',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Token creation timestamp',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_OAUTH_TOKEN_TOKEN` (`token`),
  KEY `SPG_OAUTH_TOKEN_CONSUMER_ID` (`consumer_id`),
  KEY `SPG_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` (`admin_id`),
  KEY `SPG_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`customer_id`),
  CONSTRAINT `SPG_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `spg_admin_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_OAUTH_TOKEN_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `spg_oauth_consumer` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Tokens';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_oauth_token`
--

LOCK TABLES `spg_oauth_token` WRITE;
/*!40000 ALTER TABLE `spg_oauth_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_oauth_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_oauth_token_request_log`
--

DROP TABLE IF EXISTS `spg_oauth_token_request_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_oauth_token_request_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log Id',
  `user_name` varchar(255) NOT NULL COMMENT 'Customer email or admin login',
  `user_type` smallint(5) unsigned NOT NULL COMMENT 'User type (admin or customer)',
  `failures_count` smallint(5) unsigned DEFAULT '0' COMMENT 'Number of failed authentication attempts in a row',
  `lock_expires_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Lock expiration time',
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `SPG_OAUTH_TOKEN_REQUEST_LOG_USER_NAME_USER_TYPE` (`user_name`,`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log of token request authentication failures.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_oauth_token_request_log`
--

LOCK TABLES `spg_oauth_token_request_log` WRITE;
/*!40000 ALTER TABLE `spg_oauth_token_request_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_oauth_token_request_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_password_reset_request_event`
--

DROP TABLE IF EXISTS `spg_password_reset_request_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_password_reset_request_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `request_type` smallint(5) unsigned NOT NULL COMMENT 'Type of the event under a security control',
  `account_reference` varchar(255) DEFAULT NULL COMMENT 'An identifier for existing account or another target',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when the event occurs',
  `ip` varchar(15) NOT NULL COMMENT 'Remote user IP',
  PRIMARY KEY (`id`),
  KEY `SPG_PASSWORD_RESET_REQUEST_EVENT_ACCOUNT_REFERENCE` (`account_reference`),
  KEY `SPG_PASSWORD_RESET_REQUEST_EVENT_CREATED_AT` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Password Reset Request Event under a security control';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_password_reset_request_event`
--

LOCK TABLES `spg_password_reset_request_event` WRITE;
/*!40000 ALTER TABLE `spg_password_reset_request_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_password_reset_request_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_paypal_billing_agreement`
--

DROP TABLE IF EXISTS `spg_paypal_billing_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_paypal_billing_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `reference_id` varchar(32) NOT NULL COMMENT 'Reference Id',
  `status` varchar(20) NOT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `agreement_label` varchar(255) DEFAULT NULL COMMENT 'Agreement Label',
  PRIMARY KEY (`agreement_id`),
  KEY `SPG_PAYPAL_BILLING_AGREEMENT_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_PAYPAL_BILLING_AGREEMENT_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_PAYPAL_BILLING_AGREEMENT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_PAYPAL_BILLING_AGRT_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_paypal_billing_agreement`
--

LOCK TABLES `spg_paypal_billing_agreement` WRITE;
/*!40000 ALTER TABLE `spg_paypal_billing_agreement` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_paypal_billing_agreement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_paypal_billing_agreement_order`
--

DROP TABLE IF EXISTS `spg_paypal_billing_agreement_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_paypal_billing_agreement_order` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  PRIMARY KEY (`agreement_id`,`order_id`),
  KEY `SPG_PAYPAL_BILLING_AGREEMENT_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_A239203D7752CA86F1D5993D258EE5D5` FOREIGN KEY (`agreement_id`) REFERENCES `spg_paypal_billing_agreement` (`agreement_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_PAYPAL_BILLING_AGRT_ORDER_ORDER_ID_SALES_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_paypal_billing_agreement_order`
--

LOCK TABLES `spg_paypal_billing_agreement_order` WRITE;
/*!40000 ALTER TABLE `spg_paypal_billing_agreement_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_paypal_billing_agreement_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_paypal_cert`
--

DROP TABLE IF EXISTS `spg_paypal_cert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_paypal_cert` (
  `cert_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cert Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `content` text COMMENT 'Content',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`cert_id`),
  KEY `SPG_PAYPAL_CERT_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_PAYPAL_CERT_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Certificate Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_paypal_cert`
--

LOCK TABLES `spg_paypal_cert` WRITE;
/*!40000 ALTER TABLE `spg_paypal_cert` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_paypal_cert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_paypal_payment_transaction`
--

DROP TABLE IF EXISTS `spg_paypal_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_paypal_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `SPG_PAYPAL_PAYMENT_TRANSACTION_TXN_ID` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='PayPal Payflow Link Payment Transaction';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_paypal_payment_transaction`
--

LOCK TABLES `spg_paypal_payment_transaction` WRITE;
/*!40000 ALTER TABLE `spg_paypal_payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_paypal_payment_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_paypal_settlement_report`
--

DROP TABLE IF EXISTS `spg_paypal_settlement_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_paypal_settlement_report` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Id',
  `report_date` timestamp NULL DEFAULT NULL COMMENT 'Report Date',
  `account_id` varchar(64) DEFAULT NULL COMMENT 'Account Id',
  `filename` varchar(24) DEFAULT NULL COMMENT 'Filename',
  `last_modified` timestamp NULL DEFAULT NULL COMMENT 'Last Modified',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `SPG_PAYPAL_SETTLEMENT_REPORT_REPORT_DATE_ACCOUNT_ID` (`report_date`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_paypal_settlement_report`
--

LOCK TABLES `spg_paypal_settlement_report` WRITE;
/*!40000 ALTER TABLE `spg_paypal_settlement_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_paypal_settlement_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_paypal_settlement_report_row`
--

DROP TABLE IF EXISTS `spg_paypal_settlement_report_row`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_paypal_settlement_report_row` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Row Id',
  `report_id` int(10) unsigned NOT NULL COMMENT 'Report Id',
  `transaction_id` varchar(19) DEFAULT NULL COMMENT 'Transaction Id',
  `invoice_id` varchar(127) DEFAULT NULL COMMENT 'Invoice Id',
  `paypal_reference_id` varchar(19) DEFAULT NULL COMMENT 'Paypal Reference Id',
  `paypal_reference_id_type` varchar(3) DEFAULT NULL COMMENT 'Paypal Reference Id Type',
  `transaction_event_code` varchar(5) DEFAULT NULL COMMENT 'Transaction Event Code',
  `transaction_initiation_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Initiation Date',
  `transaction_completion_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Completion Date',
  `transaction_debit_or_credit` varchar(2) NOT NULL DEFAULT 'CR' COMMENT 'Transaction Debit Or Credit',
  `gross_transaction_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Gross Transaction Amount',
  `gross_transaction_currency` varchar(3) DEFAULT NULL COMMENT 'Gross Transaction Currency',
  `fee_debit_or_credit` varchar(2) DEFAULT NULL COMMENT 'Fee Debit Or Credit',
  `fee_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Fee Amount',
  `fee_currency` varchar(3) DEFAULT NULL COMMENT 'Fee Currency',
  `custom_field` varchar(255) DEFAULT NULL COMMENT 'Custom Field',
  `consumer_id` varchar(127) DEFAULT NULL COMMENT 'Consumer Id',
  `payment_tracking_id` varchar(255) DEFAULT NULL COMMENT 'Payment Tracking ID',
  `store_id` varchar(50) DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`row_id`),
  KEY `SPG_PAYPAL_SETTLEMENT_REPORT_ROW_REPORT_ID` (`report_id`),
  CONSTRAINT `FK_B6106CD5041B99E9EEA7584282B374EA` FOREIGN KEY (`report_id`) REFERENCES `spg_paypal_settlement_report` (`report_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Row Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_paypal_settlement_report_row`
--

LOCK TABLES `spg_paypal_settlement_report_row` WRITE;
/*!40000 ALTER TABLE `spg_paypal_settlement_report_row` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_paypal_settlement_report_row` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_persistent_session`
--

DROP TABLE IF EXISTS `spg_persistent_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_persistent_session` (
  `persistent_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Session id',
  `key` varchar(50) NOT NULL COMMENT 'Unique cookie key',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `info` text COMMENT 'Session Data',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`persistent_id`),
  UNIQUE KEY `SPG_PERSISTENT_SESSION_KEY` (`key`),
  UNIQUE KEY `SPG_PERSISTENT_SESSION_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_PERSISTENT_SESSION_UPDATED_AT` (`updated_at`),
  KEY `SPG_PERSISTENT_SESSION_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_PERSISTENT_SESSION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_PERSISTENT_SESSION_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Persistent Session';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_persistent_session`
--

LOCK TABLES `spg_persistent_session` WRITE;
/*!40000 ALTER TABLE `spg_persistent_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_persistent_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_product_alert_price`
--

DROP TABLE IF EXISTS `spg_product_alert_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_product_alert_price` (
  `alert_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert price id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price amount',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `last_send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert last send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert send count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_price_id`),
  KEY `SPG_PRODUCT_ALERT_PRICE_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_PRODUCT_ALERT_PRICE_PRODUCT_ID` (`product_id`),
  KEY `SPG_PRODUCT_ALERT_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_PRD_ALERT_PRICE_PRD_ID_SPG_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_PRODUCT_ALERT_PRICE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_PRODUCT_ALERT_PRICE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Price';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_product_alert_price`
--

LOCK TABLES `spg_product_alert_price` WRITE;
/*!40000 ALTER TABLE `spg_product_alert_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_product_alert_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_product_alert_stock`
--

DROP TABLE IF EXISTS `spg_product_alert_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_product_alert_stock` (
  `alert_stock_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert stock id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Send Count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_stock_id`),
  KEY `SPG_PRODUCT_ALERT_STOCK_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_PRODUCT_ALERT_STOCK_PRODUCT_ID` (`product_id`),
  KEY `SPG_PRODUCT_ALERT_STOCK_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_PRD_ALERT_STOCK_PRD_ID_SPG_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_PRODUCT_ALERT_STOCK_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_PRODUCT_ALERT_STOCK_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Stock';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_product_alert_stock`
--

LOCK TABLES `spg_product_alert_stock` WRITE;
/*!40000 ALTER TABLE `spg_product_alert_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_product_alert_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_queue`
--

DROP TABLE IF EXISTS `spg_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue ID',
  `name` varchar(255) DEFAULT NULL COMMENT 'Queue name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_QUEUE_NAME` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Table storing unique queues';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_queue`
--

LOCK TABLES `spg_queue` WRITE;
/*!40000 ALTER TABLE `spg_queue` DISABLE KEYS */;
INSERT INTO `spg_queue` VALUES (1,'catalog_product_removed_queue'),(2,'inventory_qty_counter_queue');
/*!40000 ALTER TABLE `spg_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_queue_lock`
--

DROP TABLE IF EXISTS `spg_queue_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_queue_lock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message ID',
  `message_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'Message Code',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_QUEUE_LOCK_MESSAGE_CODE` (`message_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Messages that were processed are inserted here to be locked.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_queue_lock`
--

LOCK TABLES `spg_queue_lock` WRITE;
/*!40000 ALTER TABLE `spg_queue_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_queue_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_queue_message`
--

DROP TABLE IF EXISTS `spg_queue_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_queue_message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message ID',
  `topic_name` varchar(255) DEFAULT NULL COMMENT 'Message topic',
  `body` longtext COMMENT 'Message body',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Queue messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_queue_message`
--

LOCK TABLES `spg_queue_message` WRITE;
/*!40000 ALTER TABLE `spg_queue_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_queue_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_queue_message_status`
--

DROP TABLE IF EXISTS `spg_queue_message_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_queue_message_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Relation ID',
  `queue_id` int(10) unsigned NOT NULL COMMENT 'Queue ID',
  `message_id` bigint(20) unsigned NOT NULL COMMENT 'Message ID',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `status` smallint(5) unsigned NOT NULL COMMENT 'Message status in particular queue',
  `number_of_trials` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of trials to processed failed message processing',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_QUEUE_MESSAGE_STATUS_QUEUE_ID_MESSAGE_ID` (`queue_id`,`message_id`),
  KEY `SPG_QUEUE_MESSAGE_STATUS_STATUS_UPDATED_AT` (`status`,`updated_at`),
  KEY `SPG_QUEUE_MESSAGE_ID_QUEUE_MESSAGE_STATUS_MESSAGE_ID` (`message_id`),
  CONSTRAINT `SPG_QUEUE_ID_QUEUE_MESSAGE_STATUS_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `spg_queue` (`id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_QUEUE_MESSAGE_ID_QUEUE_MESSAGE_STATUS_MESSAGE_ID` FOREIGN KEY (`message_id`) REFERENCES `spg_queue_message` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relation table to keep associations between queues and messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_queue_message_status`
--

LOCK TABLES `spg_queue_message_status` WRITE;
/*!40000 ALTER TABLE `spg_queue_message_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_queue_message_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_quote`
--

DROP TABLE IF EXISTS `spg_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_quote` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `converted_at` timestamp NULL DEFAULT NULL COMMENT 'Converted At',
  `is_active` smallint(5) unsigned DEFAULT '1' COMMENT 'Is Active',
  `is_virtual` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Virtual',
  `is_multi_shipping` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Multi Shipping',
  `items_count` int(10) unsigned DEFAULT '0' COMMENT 'Items Count',
  `items_qty` decimal(12,4) DEFAULT '0.0000' COMMENT 'Items Qty',
  `orig_order_id` int(10) unsigned DEFAULT '0' COMMENT 'Orig Order Id',
  `store_to_base_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Base Rate',
  `store_to_quote_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Quote Rate',
  `base_currency_code` varchar(255) DEFAULT NULL COMMENT 'Base Currency Code',
  `store_currency_code` varchar(255) DEFAULT NULL COMMENT 'Store Currency Code',
  `quote_currency_code` varchar(255) DEFAULT NULL COMMENT 'Quote Currency Code',
  `grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `checkout_method` varchar(255) DEFAULT NULL COMMENT 'Checkout Method',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `customer_tax_class_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Tax Class Id',
  `customer_group_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Group Id',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_prefix` varchar(40) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_middlename` varchar(40) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_suffix` varchar(40) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `customer_note` varchar(255) DEFAULT NULL COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT '1' COMMENT 'Customer Note Notify',
  `customer_is_guest` smallint(5) unsigned DEFAULT '0' COMMENT 'Customer Is Guest',
  `remote_ip` varchar(32) DEFAULT NULL COMMENT 'Remote Ip',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `reserved_order_id` varchar(64) DEFAULT NULL COMMENT 'Reserved Order Id',
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Password Hash',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `global_currency_code` varchar(255) DEFAULT NULL COMMENT 'Global Currency Code',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_quote_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Quote Rate',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `customer_gender` varchar(255) DEFAULT NULL COMMENT 'Customer Gender',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal With Discount',
  `is_changed` int(10) unsigned DEFAULT NULL COMMENT 'Is Changed',
  `trigger_recollect` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Trigger Recollect',
  `ext_shipping_info` text COMMENT 'Ext Shipping Info',
  `is_persistent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Quote Persistent',
  `customer_balance_amount_used` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount Used',
  `base_customer_bal_amount_used` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Bal Amount Used',
  `use_customer_balance` int(11) DEFAULT NULL COMMENT 'Use Customer Balance',
  `gift_cards` text COMMENT 'Gift Cards',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards_amount_used` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount Used',
  `base_gift_cards_amount_used` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount Used',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_allow_gift_receipt` int(11) DEFAULT NULL COMMENT 'Gw Allow Gift Receipt',
  `gw_add_card` int(11) DEFAULT NULL COMMENT 'Gw Add Card',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `gw_base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Incl Tax',
  `gw_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Incl Tax',
  `gw_items_base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price Incl Tax',
  `gw_items_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price Incl Tax',
  `gw_card_base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price Incl Tax',
  `gw_card_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price Incl Tax',
  `use_reward_points` int(11) DEFAULT NULL COMMENT 'Use Reward Points',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_QUOTE_CUSTOMER_ID_STORE_ID_IS_ACTIVE` (`customer_id`,`store_id`,`is_active`),
  KEY `SPG_QUOTE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_QUOTE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_quote`
--

LOCK TABLES `spg_quote` WRITE;
/*!40000 ALTER TABLE `spg_quote` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_quote_address`
--

DROP TABLE IF EXISTS `spg_quote_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_quote_address` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `save_in_address_book` smallint(6) DEFAULT '0' COMMENT 'Save In Address Book',
  `customer_address_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Address Id',
  `address_type` varchar(10) DEFAULT NULL COMMENT 'Address Type',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `firstname` varchar(20) DEFAULT NULL COMMENT 'Firstname',
  `middlename` varchar(20) DEFAULT NULL COMMENT 'Middlename',
  `lastname` varchar(20) DEFAULT NULL COMMENT 'Lastname',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(40) DEFAULT NULL COMMENT 'City',
  `region` varchar(40) DEFAULT NULL COMMENT 'Region',
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'Region Id',
  `postcode` varchar(20) DEFAULT NULL COMMENT 'Postcode',
  `country_id` varchar(30) DEFAULT NULL COMMENT 'Country Id',
  `telephone` varchar(20) DEFAULT NULL COMMENT 'Phone Number',
  `fax` varchar(20) DEFAULT NULL COMMENT 'Fax',
  `same_as_billing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Same As Billing',
  `collect_shipping_rates` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Collect Shipping Rates',
  `shipping_method` varchar(40) DEFAULT NULL COMMENT 'Shipping Method',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `weight` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Weight',
  `subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal With Discount',
  `tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Shipping Amount',
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Shipping Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `customer_notes` text COMMENT 'Customer Notes',
  `applied_taxes` text COMMENT 'Applied Taxes',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Total Incl Tax',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `shipping_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Tax Compensation Amount',
  `base_shipping_discount_tax_compensation_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Tax Compensation Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `free_shipping` smallint(6) DEFAULT NULL,
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `base_customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Amount',
  `customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards` text COMMENT 'Gift Cards',
  `used_gift_cards` text COMMENT 'Used Gift Cards',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_allow_gift_receipt` int(11) DEFAULT NULL COMMENT 'Gw Allow Gift Receipt',
  `gw_add_card` int(11) DEFAULT NULL COMMENT 'Gw Add Card',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `gw_base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Incl Tax',
  `gw_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Incl Tax',
  `gw_items_base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price Incl Tax',
  `gw_items_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price Incl Tax',
  `gw_card_base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price Incl Tax',
  `gw_card_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price Incl Tax',
  `giftregistry_item_id` int(11) DEFAULT NULL COMMENT 'Giftregistry Item Id',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  PRIMARY KEY (`address_id`),
  KEY `SPG_QUOTE_ADDRESS_QUOTE_ID` (`quote_id`),
  CONSTRAINT `SPG_QUOTE_ADDRESS_QUOTE_ID_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `spg_quote` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_quote_address`
--

LOCK TABLES `spg_quote_address` WRITE;
/*!40000 ALTER TABLE `spg_quote_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_quote_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_quote_address_item`
--

DROP TABLE IF EXISTS `spg_quote_address_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_quote_address_item` (
  `address_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Item Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Address Id',
  `quote_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Item Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `super_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Super Product Id',
  `parent_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Product Id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `is_qty_decimal` int(10) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `discount_percent` decimal(12,4) DEFAULT NULL COMMENT 'Discount Percent',
  `no_discount` int(10) unsigned DEFAULT NULL COMMENT 'No Discount',
  `tax_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tax Percent',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `free_shipping` int(11) DEFAULT NULL,
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  PRIMARY KEY (`address_item_id`),
  KEY `SPG_QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID` (`quote_address_id`),
  KEY `SPG_QUOTE_ADDRESS_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `SPG_QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID` (`quote_item_id`),
  CONSTRAINT `SPG_QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID_QUOTE_ADDRESS_ADDRESS_ID` FOREIGN KEY (`quote_address_id`) REFERENCES `spg_quote_address` (`address_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID_QUOTE_ITEM_ITEM_ID` FOREIGN KEY (`quote_item_id`) REFERENCES `spg_quote_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_QUOTE_ADDR_ITEM_PARENT_ITEM_ID_QUOTE_ADDR_ITEM_ADDR_ITEM_ID` FOREIGN KEY (`parent_item_id`) REFERENCES `spg_quote_address_item` (`address_item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_quote_address_item`
--

LOCK TABLES `spg_quote_address_item` WRITE;
/*!40000 ALTER TABLE `spg_quote_address_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_quote_address_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_quote_id_mask`
--

DROP TABLE IF EXISTS `spg_quote_id_mask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_quote_id_mask` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `quote_id` int(10) unsigned NOT NULL COMMENT 'Quote ID',
  `masked_id` varchar(32) DEFAULT NULL COMMENT 'Masked ID',
  PRIMARY KEY (`entity_id`,`quote_id`),
  KEY `SPG_QUOTE_ID_MASK_QUOTE_ID` (`quote_id`),
  KEY `SPG_QUOTE_ID_MASK_MASKED_ID` (`masked_id`),
  CONSTRAINT `SPG_QUOTE_ID_MASK_QUOTE_ID_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `spg_quote` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quote ID and masked ID mapping';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_quote_id_mask`
--

LOCK TABLES `spg_quote_id_mask` WRITE;
/*!40000 ALTER TABLE `spg_quote_id_mask` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_quote_id_mask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_quote_item`
--

DROP TABLE IF EXISTS `spg_quote_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_quote_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned DEFAULT '0' COMMENT 'No Discount',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Custom Price',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `original_custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Custom Price',
  `redirect_url` varchar(255) DEFAULT NULL COMMENT 'Redirect Url',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `free_shipping` smallint(6) DEFAULT NULL,
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `event_id` int(11) DEFAULT NULL COMMENT 'Event Id',
  `giftregistry_item_id` int(11) DEFAULT NULL COMMENT 'Giftregistry Item Id',
  PRIMARY KEY (`item_id`),
  KEY `SPG_QUOTE_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `SPG_QUOTE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `SPG_QUOTE_ITEM_QUOTE_ID` (`quote_id`),
  KEY `SPG_QUOTE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_QUOTE_ITEM_PARENT_ITEM_ID_QUOTE_ITEM_ITEM_ID` FOREIGN KEY (`parent_item_id`) REFERENCES `spg_quote_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_QUOTE_ITEM_QUOTE_ID_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `spg_quote` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_QUOTE_ITEM_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_quote_item`
--

LOCK TABLES `spg_quote_item` WRITE;
/*!40000 ALTER TABLE `spg_quote_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_quote_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_quote_item_option`
--

DROP TABLE IF EXISTS `spg_quote_item_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_quote_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `SPG_QUOTE_ITEM_OPTION_ITEM_ID` (`item_id`),
  CONSTRAINT `SPG_QUOTE_ITEM_OPTION_ITEM_ID_QUOTE_ITEM_ITEM_ID` FOREIGN KEY (`item_id`) REFERENCES `spg_quote_item` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item Option';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_quote_item_option`
--

LOCK TABLES `spg_quote_item_option` WRITE;
/*!40000 ALTER TABLE `spg_quote_item_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_quote_item_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_quote_payment`
--

DROP TABLE IF EXISTS `spg_quote_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_quote_payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_last_4` varchar(255) DEFAULT NULL COMMENT 'Cc Last 4',
  `cc_cid_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Enc',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_exp_month` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_exp_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Year',
  `cc_ss_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Owner',
  `cc_ss_start_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Month',
  `cc_ss_start_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Year',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `additional_data` text COMMENT 'Additional Data',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `additional_information` text COMMENT 'Additional Information',
  `paypal_payer_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Id',
  `paypal_payer_status` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Status',
  `paypal_correlation_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Correlation Id',
  PRIMARY KEY (`payment_id`),
  KEY `SPG_QUOTE_PAYMENT_QUOTE_ID` (`quote_id`),
  CONSTRAINT `SPG_QUOTE_PAYMENT_QUOTE_ID_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `spg_quote` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Payment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_quote_payment`
--

LOCK TABLES `spg_quote_payment` WRITE;
/*!40000 ALTER TABLE `spg_quote_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_quote_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_quote_preview`
--

DROP TABLE IF EXISTS `spg_quote_preview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_quote_preview` (
  `quote_id` int(10) unsigned NOT NULL COMMENT 'Preview Quota Id',
  KEY `SPG_QUOTE_PREVIEW_QUOTE_ID_SPG_QUOTE_ENTITY_ID` (`quote_id`),
  CONSTRAINT `SPG_QUOTE_PREVIEW_QUOTE_ID_SPG_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `spg_quote` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preview quotas list';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_quote_preview`
--

LOCK TABLES `spg_quote_preview` WRITE;
/*!40000 ALTER TABLE `spg_quote_preview` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_quote_preview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_quote_shipping_rate`
--

DROP TABLE IF EXISTS `spg_quote_shipping_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_quote_shipping_rate` (
  `rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rate Id',
  `address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Address Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `carrier` varchar(255) DEFAULT NULL COMMENT 'Carrier',
  `carrier_title` varchar(255) DEFAULT NULL COMMENT 'Carrier Title',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `method_description` text COMMENT 'Method Description',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `error_message` text COMMENT 'Error Message',
  `method_title` text COMMENT 'Method Title',
  PRIMARY KEY (`rate_id`),
  KEY `SPG_QUOTE_SHIPPING_RATE_ADDRESS_ID` (`address_id`),
  CONSTRAINT `SPG_QUOTE_SHIPPING_RATE_ADDRESS_ID_QUOTE_ADDRESS_ADDRESS_ID` FOREIGN KEY (`address_id`) REFERENCES `spg_quote_address` (`address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Shipping Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_quote_shipping_rate`
--

LOCK TABLES `spg_quote_shipping_rate` WRITE;
/*!40000 ALTER TABLE `spg_quote_shipping_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_quote_shipping_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_rating`
--

DROP TABLE IF EXISTS `spg_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_rating` (
  `rating_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Id',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `rating_code` varchar(64) NOT NULL COMMENT 'Rating Code',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Position On Storefront',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Rating is active.',
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `SPG_RATING_RATING_CODE` (`rating_code`),
  KEY `SPG_RATING_ENTITY_ID` (`entity_id`),
  CONSTRAINT `SPG_RATING_ENTITY_ID_RATING_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_rating_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Ratings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_rating`
--

LOCK TABLES `spg_rating` WRITE;
/*!40000 ALTER TABLE `spg_rating` DISABLE KEYS */;
INSERT INTO `spg_rating` VALUES (1,1,'Quality',0,1),(2,1,'Value',0,1),(3,1,'Price',0,1);
/*!40000 ALTER TABLE `spg_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_rating_entity`
--

DROP TABLE IF EXISTS `spg_rating_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_rating_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_code` varchar(64) NOT NULL COMMENT 'Entity Code',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_RATING_ENTITY_ENTITY_CODE` (`entity_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Rating entities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_rating_entity`
--

LOCK TABLES `spg_rating_entity` WRITE;
/*!40000 ALTER TABLE `spg_rating_entity` DISABLE KEYS */;
INSERT INTO `spg_rating_entity` VALUES (1,'product'),(2,'product_review'),(3,'review');
/*!40000 ALTER TABLE `spg_rating_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_rating_option`
--

DROP TABLE IF EXISTS `spg_rating_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_rating_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Option Id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `code` varchar(32) NOT NULL COMMENT 'Rating Option Code',
  `value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Option Value',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Ration option position on Storefront',
  PRIMARY KEY (`option_id`),
  KEY `SPG_RATING_OPTION_RATING_ID` (`rating_id`),
  CONSTRAINT `SPG_RATING_OPTION_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `spg_rating` (`rating_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Rating options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_rating_option`
--

LOCK TABLES `spg_rating_option` WRITE;
/*!40000 ALTER TABLE `spg_rating_option` DISABLE KEYS */;
INSERT INTO `spg_rating_option` VALUES (1,1,'1',1,1),(2,1,'2',2,2),(3,1,'3',3,3),(4,1,'4',4,4),(5,1,'5',5,5),(6,2,'1',1,1),(7,2,'2',2,2),(8,2,'3',3,3),(9,2,'4',4,4),(10,2,'5',5,5),(11,3,'1',1,1),(12,3,'2',2,2),(13,3,'3',3,3),(14,3,'4',4,4),(15,3,'5',5,5);
/*!40000 ALTER TABLE `spg_rating_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_rating_option_vote`
--

DROP TABLE IF EXISTS `spg_rating_option_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_rating_option_vote` (
  `vote_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote option id',
  `remote_ip` varchar(16) NOT NULL COMMENT 'Customer IP',
  `remote_ip_long` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Customer IP converted to long integer format',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `review_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Review id',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Percent amount',
  `value` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote option value',
  PRIMARY KEY (`vote_id`),
  KEY `SPG_RATING_OPTION_VOTE_OPTION_ID` (`option_id`),
  KEY `SPG_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` (`review_id`),
  CONSTRAINT `SPG_RATING_OPTION_VOTE_OPTION_ID_RATING_OPTION_OPTION_ID` FOREIGN KEY (`option_id`) REFERENCES `spg_rating_option` (`option_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `spg_review` (`review_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating option values';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_rating_option_vote`
--

LOCK TABLES `spg_rating_option_vote` WRITE;
/*!40000 ALTER TABLE `spg_rating_option_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_rating_option_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_rating_option_vote_aggregated`
--

DROP TABLE IF EXISTS `spg_rating_option_vote_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_rating_option_vote_aggregated` (
  `primary_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Vote aggregation id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote dty',
  `vote_value_sum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'General vote sum',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote percent',
  `percent_approved` smallint(6) DEFAULT '0' COMMENT 'Vote percent approved by admin',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`primary_id`),
  KEY `SPG_RATING_OPTION_VOTE_AGGREGATED_RATING_ID` (`rating_id`),
  KEY `SPG_RATING_OPTION_VOTE_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_RATING_OPTION_VOTE_AGGREGATED_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `spg_rating` (`rating_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_RATING_OPTION_VOTE_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating vote aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_rating_option_vote_aggregated`
--

LOCK TABLES `spg_rating_option_vote_aggregated` WRITE;
/*!40000 ALTER TABLE `spg_rating_option_vote_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_rating_option_vote_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_rating_store`
--

DROP TABLE IF EXISTS `spg_rating_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_rating_store` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `SPG_RATING_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_RATING_STORE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `spg_rating` (`rating_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_RATING_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_rating_store`
--

LOCK TABLES `spg_rating_store` WRITE;
/*!40000 ALTER TABLE `spg_rating_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_rating_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_rating_title`
--

DROP TABLE IF EXISTS `spg_rating_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_rating_title` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Rating Label',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `SPG_RATING_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_RATING_TITLE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `spg_rating` (`rating_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_RATING_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Title';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_rating_title`
--

LOCK TABLES `spg_rating_title` WRITE;
/*!40000 ALTER TABLE `spg_rating_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_rating_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_report_compared_product_index`
--

DROP TABLE IF EXISTS `spg_report_compared_product_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_report_compared_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `SPG_REPORT_COMPARED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `SPG_REPORT_COMPARED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `SPG_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `SPG_REPORT_COMPARED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `SPG_REPORT_COMPARED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_REPORT_CMPD_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REPORT_CMPD_PRD_IDX_PRD_ID_SPG_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Compared Product Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_report_compared_product_index`
--

LOCK TABLES `spg_report_compared_product_index` WRITE;
/*!40000 ALTER TABLE `spg_report_compared_product_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_report_compared_product_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_report_event`
--

DROP TABLE IF EXISTS `spg_report_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_report_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `logged_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Logged At',
  `event_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type Id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Object Id',
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subject Id',
  `subtype` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Subtype',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`event_id`),
  KEY `SPG_REPORT_EVENT_EVENT_TYPE_ID` (`event_type_id`),
  KEY `SPG_REPORT_EVENT_SUBJECT_ID` (`subject_id`),
  KEY `SPG_REPORT_EVENT_OBJECT_ID` (`object_id`),
  KEY `SPG_REPORT_EVENT_SUBTYPE` (`subtype`),
  KEY `SPG_REPORT_EVENT_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_REPORT_EVENT_EVENT_TYPE_ID_REPORT_EVENT_TYPES_EVENT_TYPE_ID` FOREIGN KEY (`event_type_id`) REFERENCES `spg_report_event_types` (`event_type_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REPORT_EVENT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_report_event`
--

LOCK TABLES `spg_report_event` WRITE;
/*!40000 ALTER TABLE `spg_report_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_report_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_report_event_types`
--

DROP TABLE IF EXISTS `spg_report_event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_report_event_types` (
  `event_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Type Id',
  `event_name` varchar(64) NOT NULL COMMENT 'Event Name',
  `customer_login` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Login',
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Reports Event Type Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_report_event_types`
--

LOCK TABLES `spg_report_event_types` WRITE;
/*!40000 ALTER TABLE `spg_report_event_types` DISABLE KEYS */;
INSERT INTO `spg_report_event_types` VALUES (1,'catalog_product_view',0),(2,'sendfriend_product',0),(3,'catalog_product_compare_add_product',0),(4,'checkout_cart_add_product',0),(5,'wishlist_add_product',0),(6,'wishlist_share',0);
/*!40000 ALTER TABLE `spg_report_event_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_report_viewed_product_aggregated_daily`
--

DROP TABLE IF EXISTS `spg_report_viewed_product_aggregated_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_report_viewed_product_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_REPORT_VIEWED_PRD_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `SPG_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `SPG_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_12BB64100DB00664A9202820F323786B` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REPORT_VIEWED_PRD_AGGRED_DAILY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Daily';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_report_viewed_product_aggregated_daily`
--

LOCK TABLES `spg_report_viewed_product_aggregated_daily` WRITE;
/*!40000 ALTER TABLE `spg_report_viewed_product_aggregated_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_report_viewed_product_aggregated_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_report_viewed_product_aggregated_monthly`
--

DROP TABLE IF EXISTS `spg_report_viewed_product_aggregated_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_report_viewed_product_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `SPG_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `SPG_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_5107616773A596DB90A3D1CB58F4BF0D` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REPORT_VIEWED_PRD_AGGRED_MONTHLY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Monthly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_report_viewed_product_aggregated_monthly`
--

LOCK TABLES `spg_report_viewed_product_aggregated_monthly` WRITE;
/*!40000 ALTER TABLE `spg_report_viewed_product_aggregated_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_report_viewed_product_aggregated_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_report_viewed_product_aggregated_yearly`
--

DROP TABLE IF EXISTS `spg_report_viewed_product_aggregated_yearly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_report_viewed_product_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_REPORT_VIEWED_PRD_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `SPG_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `SPG_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_819892910DEB49E44C0FC52BBD55A416` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REPORT_VIEWED_PRD_AGGRED_YEARLY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Yearly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_report_viewed_product_aggregated_yearly`
--

LOCK TABLES `spg_report_viewed_product_aggregated_yearly` WRITE;
/*!40000 ALTER TABLE `spg_report_viewed_product_aggregated_yearly` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_report_viewed_product_aggregated_yearly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_report_viewed_product_index`
--

DROP TABLE IF EXISTS `spg_report_viewed_product_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_report_viewed_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `SPG_REPORT_VIEWED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `SPG_REPORT_VIEWED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `SPG_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `SPG_REPORT_VIEWED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `SPG_REPORT_VIEWED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_REPORT_VIEWED_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REPORT_VIEWED_PRD_IDX_PRD_ID_SPG_SEQUENCE_PRD_SEQUENCE_VAL` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Viewed Product Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_report_viewed_product_index`
--

LOCK TABLES `spg_report_viewed_product_index` WRITE;
/*!40000 ALTER TABLE `spg_report_viewed_product_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_report_viewed_product_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_reporting_counts`
--

DROP TABLE IF EXISTS `spg_reporting_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_reporting_counts` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `type` varchar(255) DEFAULT NULL COMMENT 'Item Reported',
  `count` int(10) unsigned DEFAULT NULL COMMENT 'Count Value',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reporting for all count related events generated via the cron job';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_reporting_counts`
--

LOCK TABLES `spg_reporting_counts` WRITE;
/*!40000 ALTER TABLE `spg_reporting_counts` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_reporting_counts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_reporting_module_status`
--

DROP TABLE IF EXISTS `spg_reporting_module_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_reporting_module_status` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Module Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Module Name',
  `active` varchar(255) DEFAULT NULL COMMENT 'Module Active Status',
  `setup_version` varchar(255) DEFAULT NULL COMMENT 'Module Version',
  `state` varchar(255) DEFAULT NULL COMMENT 'Module State',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Module Status Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_reporting_module_status`
--

LOCK TABLES `spg_reporting_module_status` WRITE;
/*!40000 ALTER TABLE `spg_reporting_module_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_reporting_module_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_reporting_orders`
--

DROP TABLE IF EXISTS `spg_reporting_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_reporting_orders` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `total` decimal(20,2) DEFAULT NULL COMMENT 'Total From Store',
  `total_base` decimal(20,2) DEFAULT NULL COMMENT 'Total From Base Currency',
  `item_count` int(10) unsigned NOT NULL COMMENT 'Line Item Count',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reporting for all orders';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_reporting_orders`
--

LOCK TABLES `spg_reporting_orders` WRITE;
/*!40000 ALTER TABLE `spg_reporting_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_reporting_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_reporting_system_updates`
--

DROP TABLE IF EXISTS `spg_reporting_system_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_reporting_system_updates` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `type` varchar(255) DEFAULT NULL COMMENT 'Update Type',
  `action` varchar(255) DEFAULT NULL COMMENT 'Action Performed',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reporting for system updates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_reporting_system_updates`
--

LOCK TABLES `spg_reporting_system_updates` WRITE;
/*!40000 ALTER TABLE `spg_reporting_system_updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_reporting_system_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_reporting_users`
--

DROP TABLE IF EXISTS `spg_reporting_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_reporting_users` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `type` varchar(255) DEFAULT NULL COMMENT 'User Type',
  `action` varchar(255) DEFAULT NULL COMMENT 'Action Performed',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reporting for user actions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_reporting_users`
--

LOCK TABLES `spg_reporting_users` WRITE;
/*!40000 ALTER TABLE `spg_reporting_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_reporting_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_review`
--

DROP TABLE IF EXISTS `spg_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_review` (
  `review_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Review create date',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity id',
  `entity_pk_value` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `status_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status code',
  PRIMARY KEY (`review_id`),
  KEY `SPG_REVIEW_ENTITY_ID` (`entity_id`),
  KEY `SPG_REVIEW_STATUS_ID` (`status_id`),
  KEY `SPG_REVIEW_ENTITY_PK_VALUE` (`entity_pk_value`),
  CONSTRAINT `SPG_REVIEW_ENTITY_ID_REVIEW_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `spg_review_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REVIEW_STATUS_ID_REVIEW_STATUS_STATUS_ID` FOREIGN KEY (`status_id`) REFERENCES `spg_review_status` (`status_id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review base information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_review`
--

LOCK TABLES `spg_review` WRITE;
/*!40000 ALTER TABLE `spg_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_review_detail`
--

DROP TABLE IF EXISTS `spg_review_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_review_detail` (
  `detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review detail id',
  `review_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Review id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store id',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `detail` text NOT NULL COMMENT 'Detail description',
  `nickname` varchar(128) NOT NULL COMMENT 'User nickname',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  PRIMARY KEY (`detail_id`),
  KEY `SPG_REVIEW_DETAIL_REVIEW_ID` (`review_id`),
  KEY `SPG_REVIEW_DETAIL_STORE_ID` (`store_id`),
  KEY `SPG_REVIEW_DETAIL_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `SPG_REVIEW_DETAIL_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_REVIEW_DETAIL_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `spg_review` (`review_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REVIEW_DETAIL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review detail information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_review_detail`
--

LOCK TABLES `spg_review_detail` WRITE;
/*!40000 ALTER TABLE `spg_review_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_review_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_review_entity`
--

DROP TABLE IF EXISTS `spg_review_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_review_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review entity id',
  `entity_code` varchar(32) NOT NULL COMMENT 'Review entity code',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Review entities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_review_entity`
--

LOCK TABLES `spg_review_entity` WRITE;
/*!40000 ALTER TABLE `spg_review_entity` DISABLE KEYS */;
INSERT INTO `spg_review_entity` VALUES (1,'product'),(2,'customer'),(3,'category');
/*!40000 ALTER TABLE `spg_review_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_review_entity_summary`
--

DROP TABLE IF EXISTS `spg_review_entity_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_review_entity_summary` (
  `primary_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Summary review entity id',
  `entity_pk_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Product id',
  `entity_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Entity type id',
  `reviews_count` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Qty of reviews',
  `rating_summary` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Summarized rating',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`primary_id`),
  KEY `SPG_REVIEW_ENTITY_SUMMARY_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_REVIEW_ENTITY_SUMMARY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review aggregates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_review_entity_summary`
--

LOCK TABLES `spg_review_entity_summary` WRITE;
/*!40000 ALTER TABLE `spg_review_entity_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_review_entity_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_review_status`
--

DROP TABLE IF EXISTS `spg_review_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_review_status` (
  `status_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Status id',
  `status_code` varchar(32) NOT NULL COMMENT 'Status code',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Review statuses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_review_status`
--

LOCK TABLES `spg_review_status` WRITE;
/*!40000 ALTER TABLE `spg_review_status` DISABLE KEYS */;
INSERT INTO `spg_review_status` VALUES (1,'Approved'),(2,'Pending'),(3,'Not Approved');
/*!40000 ALTER TABLE `spg_review_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_review_store`
--

DROP TABLE IF EXISTS `spg_review_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_review_store` (
  `review_id` bigint(20) unsigned NOT NULL COMMENT 'Review Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`review_id`,`store_id`),
  KEY `SPG_REVIEW_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_REVIEW_STORE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `spg_review` (`review_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_REVIEW_STORE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_review_store`
--

LOCK TABLES `spg_review_store` WRITE;
/*!40000 ALTER TABLE `spg_review_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_review_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_bestsellers_aggregated_daily`
--

DROP TABLE IF EXISTS `spg_sales_bestsellers_aggregated_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_bestsellers_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_BESTSELLERS_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `SPG_SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `SPG_SALES_BESTSELLERS_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Daily';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_bestsellers_aggregated_daily`
--

LOCK TABLES `spg_sales_bestsellers_aggregated_daily` WRITE;
/*!40000 ALTER TABLE `spg_sales_bestsellers_aggregated_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_bestsellers_aggregated_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_bestsellers_aggregated_monthly`
--

DROP TABLE IF EXISTS `spg_sales_bestsellers_aggregated_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_bestsellers_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_BESTSELLERS_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `SPG_SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `SPG_SALES_BESTSELLERS_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Monthly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_bestsellers_aggregated_monthly`
--

LOCK TABLES `spg_sales_bestsellers_aggregated_monthly` WRITE;
/*!40000 ALTER TABLE `spg_sales_bestsellers_aggregated_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_bestsellers_aggregated_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_bestsellers_aggregated_yearly`
--

DROP TABLE IF EXISTS `spg_sales_bestsellers_aggregated_yearly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_bestsellers_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_BESTSELLERS_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `SPG_SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `SPG_SALES_BESTSELLERS_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `SPG_SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Yearly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_bestsellers_aggregated_yearly`
--

LOCK TABLES `spg_sales_bestsellers_aggregated_yearly` WRITE;
/*!40000 ALTER TABLE `spg_sales_bestsellers_aggregated_yearly` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_bestsellers_aggregated_yearly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_creditmemo`
--

DROP TABLE IF EXISTS `spg_sales_creditmemo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_creditmemo` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `send_email` smallint(5) unsigned DEFAULT NULL COMMENT 'Send Email',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `shipping_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Tax Compensation Amount',
  `base_shipping_discount_tax_compensation_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Tax Compensation Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `customer_note` text COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `base_customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Amount',
  `customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount',
  `bs_customer_bal_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Bs Customer Bal Total Refunded',
  `customer_bal_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Customer Bal Total Refunded',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  `reward_points_balance_refund` int(11) DEFAULT NULL COMMENT 'Reward Points Balance Refund',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_SALES_CREDITMEMO_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_SALES_CREDITMEMO_STORE_ID` (`store_id`),
  KEY `SPG_SALES_CREDITMEMO_ORDER_ID` (`order_id`),
  KEY `SPG_SALES_CREDITMEMO_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `SPG_SALES_CREDITMEMO_STATE` (`state`),
  KEY `SPG_SALES_CREDITMEMO_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_CREDITMEMO_UPDATED_AT` (`updated_at`),
  KEY `SPG_SALES_CREDITMEMO_SEND_EMAIL` (`send_email`),
  KEY `SPG_SALES_CREDITMEMO_EMAIL_SENT` (`email_sent`),
  CONSTRAINT `SPG_SALES_CREDITMEMO_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALES_CREDITMEMO_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_creditmemo`
--

LOCK TABLES `spg_sales_creditmemo` WRITE;
/*!40000 ALTER TABLE `spg_sales_creditmemo` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_creditmemo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_creditmemo_comment`
--

DROP TABLE IF EXISTS `spg_sales_creditmemo_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_creditmemo_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_CREDITMEMO_COMMENT_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_CREDITMEMO_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_SALES_CREDITMEMO_COMMENT_PARENT_ID_SALES_CREDITMEMO_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_creditmemo` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Comment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_creditmemo_comment`
--

LOCK TABLES `spg_sales_creditmemo_comment` WRITE;
/*!40000 ALTER TABLE `spg_sales_creditmemo_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_creditmemo_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_creditmemo_grid`
--

DROP TABLE IF EXISTS `spg_sales_creditmemo_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_creditmemo_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `state` int(11) DEFAULT NULL COMMENT 'Status',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `order_status` varchar(32) DEFAULT NULL COMMENT 'Order Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `customer_name` varchar(128) NOT NULL COMMENT 'Customer Name',
  `customer_email` varchar(128) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `payment_method` varchar(32) DEFAULT NULL COMMENT 'Payment Method',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Method Name',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `shipping_and_handling` decimal(12,4) DEFAULT NULL COMMENT 'Shipping and handling amount',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `order_base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Order Grand Total',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_SALES_CREDITMEMO_GRID_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_SALES_CREDITMEMO_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SPG_SALES_CREDITMEMO_GRID_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_CREDITMEMO_GRID_UPDATED_AT` (`updated_at`),
  KEY `SPG_SALES_CREDITMEMO_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `SPG_SALES_CREDITMEMO_GRID_STATE` (`state`),
  KEY `SPG_SALES_CREDITMEMO_GRID_BILLING_NAME` (`billing_name`),
  KEY `SPG_SALES_CREDITMEMO_GRID_ORDER_STATUS` (`order_status`),
  KEY `SPG_SALES_CREDITMEMO_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `SPG_SALES_CREDITMEMO_GRID_STORE_ID` (`store_id`),
  KEY `SPG_SALES_CREDITMEMO_GRID_ORDER_BASE_GRAND_TOTAL` (`order_base_grand_total`),
  KEY `SPG_SALES_CREDITMEMO_GRID_ORDER_ID` (`order_id`),
  FULLTEXT KEY `FTI_C07A712FCBDB86F62F302EB7BC7B71EB` (`increment_id`,`order_increment_id`,`billing_name`,`billing_address`,`shipping_address`,`customer_name`,`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_creditmemo_grid`
--

LOCK TABLES `spg_sales_creditmemo_grid` WRITE;
/*!40000 ALTER TABLE `spg_sales_creditmemo_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_creditmemo_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_creditmemo_item`
--

DROP TABLE IF EXISTS `spg_sales_creditmemo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_creditmemo_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `tax_ratio` text COMMENT 'Ratio of tax in the creditmemo item over tax of the order item',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_CREDITMEMO_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_SALES_CREDITMEMO_ITEM_PARENT_ID_SALES_CREDITMEMO_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_creditmemo` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_creditmemo_item`
--

LOCK TABLES `spg_sales_creditmemo_item` WRITE;
/*!40000 ALTER TABLE `spg_sales_creditmemo_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_creditmemo_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_invoice`
--

DROP TABLE IF EXISTS `spg_sales_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_invoice` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `is_used_for_refund` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Used For Refund',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `send_email` smallint(5) unsigned DEFAULT NULL COMMENT 'Send Email',
  `can_void_flag` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Void Flag',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `shipping_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Tax Compensation Amount',
  `base_shipping_discount_tax_compensation_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Tax Compensation Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `customer_note` text COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `base_customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Amount',
  `customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_SALES_INVOICE_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_SALES_INVOICE_STORE_ID` (`store_id`),
  KEY `SPG_SALES_INVOICE_GRAND_TOTAL` (`grand_total`),
  KEY `SPG_SALES_INVOICE_ORDER_ID` (`order_id`),
  KEY `SPG_SALES_INVOICE_STATE` (`state`),
  KEY `SPG_SALES_INVOICE_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_INVOICE_UPDATED_AT` (`updated_at`),
  KEY `SPG_SALES_INVOICE_SEND_EMAIL` (`send_email`),
  KEY `SPG_SALES_INVOICE_EMAIL_SENT` (`email_sent`),
  CONSTRAINT `SPG_SALES_INVOICE_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALES_INVOICE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_invoice`
--

LOCK TABLES `spg_sales_invoice` WRITE;
/*!40000 ALTER TABLE `spg_sales_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_invoice_comment`
--

DROP TABLE IF EXISTS `spg_sales_invoice_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_invoice_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_INVOICE_COMMENT_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_INVOICE_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_SALES_INVOICE_COMMENT_PARENT_ID_SALES_INVOICE_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_invoice` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Comment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_invoice_comment`
--

LOCK TABLES `spg_sales_invoice_comment` WRITE;
/*!40000 ALTER TABLE `spg_sales_invoice_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_invoice_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_invoice_grid`
--

DROP TABLE IF EXISTS `spg_sales_invoice_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_invoice_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `customer_name` varchar(255) DEFAULT NULL COMMENT 'Customer Name',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `payment_method` varchar(128) DEFAULT NULL COMMENT 'Payment Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Method Name',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `shipping_and_handling` decimal(12,4) DEFAULT NULL COMMENT 'Shipping and handling amount',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_SALES_INVOICE_GRID_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_SALES_INVOICE_GRID_STORE_ID` (`store_id`),
  KEY `SPG_SALES_INVOICE_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `SPG_SALES_INVOICE_GRID_ORDER_ID` (`order_id`),
  KEY `SPG_SALES_INVOICE_GRID_STATE` (`state`),
  KEY `SPG_SALES_INVOICE_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SPG_SALES_INVOICE_GRID_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_INVOICE_GRID_UPDATED_AT` (`updated_at`),
  KEY `SPG_SALES_INVOICE_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `SPG_SALES_INVOICE_GRID_BILLING_NAME` (`billing_name`),
  KEY `SPG_SALES_INVOICE_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  FULLTEXT KEY `FTI_A953B886D74DEBB98A38FACC5DC7DE03` (`increment_id`,`order_increment_id`,`billing_name`,`billing_address`,`shipping_address`,`customer_name`,`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_invoice_grid`
--

LOCK TABLES `spg_sales_invoice_grid` WRITE;
/*!40000 ALTER TABLE `spg_sales_invoice_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_invoice_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_invoice_item`
--

DROP TABLE IF EXISTS `spg_sales_invoice_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_invoice_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `tax_ratio` text COMMENT 'Ratio of tax invoiced over tax of the order item',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_INVOICE_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_SALES_INVOICE_ITEM_PARENT_ID_SALES_INVOICE_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_invoice` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_invoice_item`
--

LOCK TABLES `spg_sales_invoice_item` WRITE;
/*!40000 ALTER TABLE `spg_sales_invoice_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_invoice_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_invoiced_aggregated`
--

DROP TABLE IF EXISTS `spg_sales_invoiced_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_invoiced_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_INVOICED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SPG_SALES_INVOICED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_INVOICED_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_invoiced_aggregated`
--

LOCK TABLES `spg_sales_invoiced_aggregated` WRITE;
/*!40000 ALTER TABLE `spg_sales_invoiced_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_invoiced_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_invoiced_aggregated_order`
--

DROP TABLE IF EXISTS `spg_sales_invoiced_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_invoiced_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_INVOICED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SPG_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_invoiced_aggregated_order`
--

LOCK TABLES `spg_sales_invoiced_aggregated_order` WRITE;
/*!40000 ALTER TABLE `spg_sales_invoiced_aggregated_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_invoiced_aggregated_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order`
--

DROP TABLE IF EXISTS `spg_sales_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `state` varchar(32) DEFAULT NULL COMMENT 'State',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `protect_code` varchar(255) DEFAULT NULL COMMENT 'Protect Code',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Canceled',
  `base_discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Invoiced',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `base_shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Canceled',
  `base_shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Invoiced',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Refunded',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `base_subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Canceled',
  `base_subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Invoiced',
  `base_subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Refunded',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Canceled',
  `base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Invoiced',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `base_total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Canceled',
  `base_total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced',
  `base_total_invoiced_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced Cost',
  `base_total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Offline Refunded',
  `base_total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Online Refunded',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `base_total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Qty Ordered',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Canceled',
  `discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Invoiced',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Canceled',
  `shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Invoiced',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Refunded',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Canceled',
  `subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Invoiced',
  `subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Refunded',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Tax Invoiced',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Total Canceled',
  `total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Total Invoiced',
  `total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Offline Refunded',
  `total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Online Refunded',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty Ordered',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `can_ship_partially` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially',
  `can_ship_partially_item` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially Item',
  `customer_is_guest` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Is Guest',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `edit_increment` int(11) DEFAULT NULL COMMENT 'Edit Increment',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `send_email` smallint(5) unsigned DEFAULT NULL COMMENT 'Send Email',
  `forced_shipment_with_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Forced Do Shipment With Invoice',
  `payment_auth_expiration` int(11) DEFAULT NULL COMMENT 'Payment Authorization Expiration',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `quote_id` int(11) DEFAULT NULL COMMENT 'Quote Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `base_total_due` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Due',
  `payment_authorization_amount` decimal(12,4) DEFAULT NULL COMMENT 'Payment Authorization Amount',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `total_due` decimal(12,4) DEFAULT NULL COMMENT 'Total Due',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `increment_id` varchar(32) DEFAULT NULL COMMENT 'Increment Id',
  `applied_rule_ids` varchar(128) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `customer_email` varchar(128) DEFAULT NULL COMMENT 'Customer Email',
  `customer_firstname` varchar(128) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_lastname` varchar(128) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_middlename` varchar(128) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_prefix` varchar(32) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_suffix` varchar(32) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_taxvat` varchar(32) DEFAULT NULL COMMENT 'Customer Taxvat',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `ext_customer_id` varchar(32) DEFAULT NULL COMMENT 'Ext Customer Id',
  `ext_order_id` varchar(32) DEFAULT NULL COMMENT 'Ext Order Id',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `hold_before_state` varchar(32) DEFAULT NULL COMMENT 'Hold Before State',
  `hold_before_status` varchar(32) DEFAULT NULL COMMENT 'Hold Before Status',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `original_increment_id` varchar(32) DEFAULT NULL COMMENT 'Original Increment Id',
  `relation_child_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Id',
  `relation_child_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Real Id',
  `relation_parent_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Id',
  `relation_parent_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Real Id',
  `remote_ip` varchar(32) DEFAULT NULL COMMENT 'Remote Ip',
  `shipping_method` varchar(32) DEFAULT NULL COMMENT 'Shipping Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `store_name` varchar(32) DEFAULT NULL COMMENT 'Store Name',
  `x_forwarded_for` varchar(32) DEFAULT NULL COMMENT 'X Forwarded For',
  `customer_note` text COMMENT 'Customer Note',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `total_item_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Total Item Count',
  `customer_gender` int(11) DEFAULT NULL COMMENT 'Customer Gender',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `shipping_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Tax Compensation Amount',
  `base_shipping_discount_tax_compensation_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Tax Compensation Amount',
  `discount_tax_compensation_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Invoiced',
  `base_discount_tax_compensation_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Invoiced',
  `discount_tax_compensation_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Refunded',
  `base_discount_tax_compensation_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Refunded',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `coupon_rule_name` varchar(255) DEFAULT NULL COMMENT 'Coupon Sales Rule Name',
  `base_customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Amount',
  `customer_balance_amount` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Amount',
  `base_customer_balance_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Invoiced',
  `customer_balance_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Invoiced',
  `base_customer_balance_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Customer Balance Refunded',
  `customer_balance_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Customer Balance Refunded',
  `bs_customer_bal_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Bs Customer Bal Total Refunded',
  `customer_bal_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Customer Bal Total Refunded',
  `gift_cards` text COMMENT 'Gift Cards',
  `base_gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Amount',
  `gift_cards_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Amount',
  `base_gift_cards_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Invoiced',
  `gift_cards_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Invoiced',
  `base_gift_cards_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Gift Cards Refunded',
  `gift_cards_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gift Cards Refunded',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_allow_gift_receipt` int(11) DEFAULT NULL COMMENT 'Gw Allow Gift Receipt',
  `gw_add_card` int(11) DEFAULT NULL COMMENT 'Gw Add Card',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_items_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price',
  `gw_items_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price',
  `gw_card_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price',
  `gw_card_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_items_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Amount',
  `gw_items_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Amount',
  `gw_card_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Amount',
  `gw_card_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Amount',
  `gw_base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Incl Tax',
  `gw_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Incl Tax',
  `gw_items_base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price Incl Tax',
  `gw_items_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price Incl Tax',
  `gw_card_base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price Incl Tax',
  `gw_card_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price Incl Tax',
  `gw_base_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Invoiced',
  `gw_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Invoiced',
  `gw_items_base_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price Invoiced',
  `gw_items_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price Invoiced',
  `gw_card_base_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price Invoiced',
  `gw_card_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price Invoiced',
  `gw_base_tax_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount Invoiced',
  `gw_tax_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount Invoiced',
  `gw_items_base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Invoiced',
  `gw_items_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Invoiced',
  `gw_card_base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Invoiced',
  `gw_card_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Invoiced',
  `gw_base_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Refunded',
  `gw_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Refunded',
  `gw_items_base_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Price Refunded',
  `gw_items_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Price Refunded',
  `gw_card_base_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Price Refunded',
  `gw_card_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Price Refunded',
  `gw_base_tax_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount Refunded',
  `gw_tax_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount Refunded',
  `gw_items_base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Base Tax Refunded',
  `gw_items_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Items Tax Refunded',
  `gw_card_base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Base Tax Refunded',
  `gw_card_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Card Tax Refunded',
  `paypal_ipn_customer_notified` int(11) DEFAULT '0' COMMENT 'Paypal Ipn Customer Notified',
  `reward_points_balance` int(11) DEFAULT NULL COMMENT 'Reward Points Balance',
  `base_reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Reward Currency Amount',
  `reward_currency_amount` decimal(12,4) DEFAULT NULL COMMENT 'Reward Currency Amount',
  `base_rwrd_crrncy_amt_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Rwrd Crrncy Amt Invoiced',
  `rwrd_currency_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Rwrd Currency Amount Invoiced',
  `base_rwrd_crrncy_amnt_refnded` decimal(12,4) DEFAULT NULL COMMENT 'Base Rwrd Crrncy Amnt Refnded',
  `rwrd_crrncy_amnt_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Rwrd Crrncy Amnt Refunded',
  `reward_points_balance_refund` int(11) DEFAULT NULL COMMENT 'Reward Points Balance Refund',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_SALES_ORDER_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_SALES_ORDER_STATUS` (`status`),
  KEY `SPG_SALES_ORDER_STATE` (`state`),
  KEY `SPG_SALES_ORDER_STORE_ID` (`store_id`),
  KEY `SPG_SALES_ORDER_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_ORDER_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_SALES_ORDER_EXT_ORDER_ID` (`ext_order_id`),
  KEY `SPG_SALES_ORDER_QUOTE_ID` (`quote_id`),
  KEY `SPG_SALES_ORDER_UPDATED_AT` (`updated_at`),
  KEY `SPG_SALES_ORDER_SEND_EMAIL` (`send_email`),
  KEY `SPG_SALES_ORDER_EMAIL_SENT` (`email_sent`),
  CONSTRAINT `SPG_SALES_ORDER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_SALES_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order`
--

LOCK TABLES `spg_sales_order` WRITE;
/*!40000 ALTER TABLE `spg_sales_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_address`
--

DROP TABLE IF EXISTS `spg_sales_order_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_address` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `customer_address_id` int(11) DEFAULT NULL COMMENT 'Customer Address Id',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `region_id` int(11) DEFAULT NULL COMMENT 'Region Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Phone Number',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `prefix` varchar(255) DEFAULT NULL COMMENT 'Prefix',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middlename',
  `suffix` varchar(255) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `giftregistry_item_id` int(11) DEFAULT NULL COMMENT 'Giftregistry Item Id',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_ORDER_ADDRESS_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_SALES_ORDER_ADDRESS_PARENT_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Address';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_address`
--

LOCK TABLES `spg_sales_order_address` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_aggregated_created`
--

DROP TABLE IF EXISTS `spg_sales_order_aggregated_created`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_ORDER_AGGREGATED_CREATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SPG_SALES_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_ORDER_AGGREGATED_CREATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Created';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_aggregated_created`
--

LOCK TABLES `spg_sales_order_aggregated_created` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_aggregated_created` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_aggregated_created` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_aggregated_updated`
--

DROP TABLE IF EXISTS `spg_sales_order_aggregated_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_ORDER_AGGREGATED_UPDATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SPG_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID_SPG_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Spg Sales Order Aggregated Updated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_aggregated_updated`
--

LOCK TABLES `spg_sales_order_aggregated_updated` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_aggregated_updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_aggregated_updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_grid`
--

DROP TABLE IF EXISTS `spg_sales_order_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Method Name',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group` varchar(255) DEFAULT NULL COMMENT 'Customer Group',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `shipping_and_handling` decimal(12,4) DEFAULT NULL COMMENT 'Shipping and handling amount',
  `customer_name` varchar(255) DEFAULT NULL COMMENT 'Customer Name',
  `payment_method` varchar(255) DEFAULT NULL COMMENT 'Payment Method',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `refunded_to_store_credit` decimal(12,4) DEFAULT NULL COMMENT 'Refund to Store Credit',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_SALES_ORDER_GRID_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_SALES_ORDER_GRID_STATUS` (`status`),
  KEY `SPG_SALES_ORDER_GRID_STORE_ID` (`store_id`),
  KEY `SPG_SALES_ORDER_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `SPG_SALES_ORDER_GRID_BASE_TOTAL_PAID` (`base_total_paid`),
  KEY `SPG_SALES_ORDER_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `SPG_SALES_ORDER_GRID_TOTAL_PAID` (`total_paid`),
  KEY `SPG_SALES_ORDER_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `SPG_SALES_ORDER_GRID_BILLING_NAME` (`billing_name`),
  KEY `SPG_SALES_ORDER_GRID_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_ORDER_GRID_CUSTOMER_ID` (`customer_id`),
  KEY `SPG_SALES_ORDER_GRID_UPDATED_AT` (`updated_at`),
  FULLTEXT KEY `FTI_D53C6ED77DF5E8D1FF6F97EA5A306ECA` (`increment_id`,`billing_name`,`shipping_name`,`shipping_address`,`billing_address`,`customer_name`,`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_grid`
--

LOCK TABLES `spg_sales_order_grid` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_item`
--

DROP TABLE IF EXISTS `spg_sales_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Quote Item Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `product_options` text COMMENT 'Product Options',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'No Discount',
  `qty_backordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Backordered',
  `qty_canceled` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Canceled',
  `qty_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Invoiced',
  `qty_ordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `qty_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Refunded',
  `qty_shipped` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Shipped',
  `base_cost` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Cost',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `original_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `base_original_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Original Price',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Invoiced',
  `base_tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Invoiced',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Invoiced',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Invoiced',
  `amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Amount Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Amount Refunded',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Invoiced',
  `base_row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Invoiced',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `ext_order_item_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Item Id',
  `locked_do_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Invoice',
  `locked_do_ship` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Ship',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Amount',
  `base_discount_tax_compensation_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Amount',
  `discount_tax_compensation_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Invoiced',
  `base_discount_tax_compensation_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Invoiced',
  `discount_tax_compensation_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Refunded',
  `base_discount_tax_compensation_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Tax Compensation Refunded',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `discount_tax_compensation_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Tax Compensation Canceled',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `qty_returned` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty of returned items',
  `free_shipping` smallint(6) DEFAULT NULL,
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gift_message_available` int(11) DEFAULT NULL COMMENT 'Gift Message Available',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `gw_id` int(11) DEFAULT NULL COMMENT 'Gw Id',
  `gw_base_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price',
  `gw_price` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price',
  `gw_base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount',
  `gw_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount',
  `gw_base_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Invoiced',
  `gw_price_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Invoiced',
  `gw_base_tax_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount Invoiced',
  `gw_tax_amount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount Invoiced',
  `gw_base_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Price Refunded',
  `gw_price_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Price Refunded',
  `gw_base_tax_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Base Tax Amount Refunded',
  `gw_tax_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Gw Tax Amount Refunded',
  `event_id` int(11) DEFAULT NULL COMMENT 'Event Id',
  `giftregistry_item_id` int(11) DEFAULT NULL COMMENT 'Giftregistry Item Id',
  PRIMARY KEY (`item_id`),
  KEY `SPG_SALES_ORDER_ITEM_ORDER_ID` (`order_id`),
  KEY `SPG_SALES_ORDER_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_ORDER_ITEM_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALES_ORDER_ITEM_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_item`
--

LOCK TABLES `spg_sales_order_item` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_payment`
--

DROP TABLE IF EXISTS `spg_sales_order_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_payment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Captured',
  `shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Captured',
  `amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Amount Refunded',
  `base_amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid',
  `amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Amount Canceled',
  `base_amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Authorized',
  `base_amount_paid_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid Online',
  `base_amount_refunded_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded Online',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Amount Paid',
  `amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Amount Authorized',
  `base_amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Ordered',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded',
  `amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Amount Ordered',
  `base_amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Canceled',
  `quote_payment_id` int(11) DEFAULT NULL COMMENT 'Quote Payment Id',
  `additional_data` text COMMENT 'Additional Data',
  `cc_exp_month` varchar(12) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_ss_start_year` varchar(12) DEFAULT NULL COMMENT 'Cc Ss Start Year',
  `echeck_bank_name` varchar(128) DEFAULT NULL COMMENT 'Echeck Bank Name',
  `method` varchar(128) DEFAULT NULL COMMENT 'Method',
  `cc_debug_request_body` varchar(32) DEFAULT NULL COMMENT 'Cc Debug Request Body',
  `cc_secure_verify` varchar(32) DEFAULT NULL COMMENT 'Cc Secure Verify',
  `protection_eligibility` varchar(32) DEFAULT NULL COMMENT 'Protection Eligibility',
  `cc_approval` varchar(32) DEFAULT NULL COMMENT 'Cc Approval',
  `cc_last_4` varchar(100) DEFAULT NULL COMMENT 'Cc Last 4',
  `cc_status_description` varchar(32) DEFAULT NULL COMMENT 'Cc Status Description',
  `echeck_type` varchar(32) DEFAULT NULL COMMENT 'Echeck Type',
  `cc_debug_response_serialized` varchar(32) DEFAULT NULL COMMENT 'Cc Debug Response Serialized',
  `cc_ss_start_month` varchar(128) DEFAULT NULL COMMENT 'Cc Ss Start Month',
  `echeck_account_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Type',
  `last_trans_id` varchar(32) DEFAULT NULL COMMENT 'Last Trans Id',
  `cc_cid_status` varchar(32) DEFAULT NULL COMMENT 'Cc Cid Status',
  `cc_owner` varchar(128) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_type` varchar(32) DEFAULT NULL COMMENT 'Cc Type',
  `po_number` varchar(32) DEFAULT NULL COMMENT 'Po Number',
  `cc_exp_year` varchar(4) DEFAULT NULL COMMENT 'Cc Exp Year',
  `cc_status` varchar(4) DEFAULT NULL COMMENT 'Cc Status',
  `echeck_routing_number` varchar(32) DEFAULT NULL COMMENT 'Echeck Routing Number',
  `account_status` varchar(32) DEFAULT NULL COMMENT 'Account Status',
  `anet_trans_method` varchar(32) DEFAULT NULL COMMENT 'Anet Trans Method',
  `cc_debug_response_body` varchar(32) DEFAULT NULL COMMENT 'Cc Debug Response Body',
  `cc_ss_issue` varchar(32) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `echeck_account_name` varchar(32) DEFAULT NULL COMMENT 'Echeck Account Name',
  `cc_avs_status` varchar(32) DEFAULT NULL COMMENT 'Cc Avs Status',
  `cc_number_enc` varchar(32) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_trans_id` varchar(32) DEFAULT NULL COMMENT 'Cc Trans Id',
  `address_status` varchar(32) DEFAULT NULL COMMENT 'Address Status',
  `additional_information` text COMMENT 'Additional Information',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_ORDER_PAYMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_SALES_ORDER_PAYMENT_PARENT_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Payment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_payment`
--

LOCK TABLES `spg_sales_order_payment` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_status`
--

DROP TABLE IF EXISTS `spg_sales_order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_status` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_status`
--

LOCK TABLES `spg_sales_order_status` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_status` DISABLE KEYS */;
INSERT INTO `spg_sales_order_status` VALUES ('canceled','Canceled'),('closed','Closed'),('complete','Complete'),('fraud','Suspected Fraud'),('holded','On Hold'),('payment_review','Payment Review'),('paypal_canceled_reversal','PayPal Canceled Reversal'),('paypal_reversed','PayPal Reversed'),('pending','Pending'),('pending_payment','Pending Payment'),('pending_paypal','Pending PayPal'),('processing','Processing');
/*!40000 ALTER TABLE `spg_sales_order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_status_history`
--

DROP TABLE IF EXISTS `spg_sales_order_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_status_history` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `entity_name` varchar(32) DEFAULT NULL COMMENT 'Shows what entity history is bind to.',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_ORDER_STATUS_HISTORY_PARENT_ID` (`parent_id`),
  KEY `SPG_SALES_ORDER_STATUS_HISTORY_CREATED_AT` (`created_at`),
  CONSTRAINT `SPG_SALES_ORDER_STATUS_HISTORY_PARENT_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Status History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_status_history`
--

LOCK TABLES `spg_sales_order_status_history` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_status_label`
--

DROP TABLE IF EXISTS `spg_sales_order_status_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_status_label` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`,`store_id`),
  KEY `SPG_SALES_ORDER_STATUS_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_ORDER_STATUS_LABEL_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `spg_sales_order_status` (`status`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALES_ORDER_STATUS_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Label Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_status_label`
--

LOCK TABLES `spg_sales_order_status_label` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_status_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_status_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_status_state`
--

DROP TABLE IF EXISTS `spg_sales_order_status_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_status_state` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `state` varchar(32) NOT NULL COMMENT 'Label',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visible on front',
  PRIMARY KEY (`status`,`state`),
  CONSTRAINT `SPG_SALES_ORDER_STATUS_STATE_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `spg_sales_order_status` (`status`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_status_state`
--

LOCK TABLES `spg_sales_order_status_state` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_status_state` DISABLE KEYS */;
INSERT INTO `spg_sales_order_status_state` VALUES ('canceled','canceled',1,1),('closed','closed',1,1),('complete','complete',1,1),('fraud','payment_review',0,1),('fraud','processing',0,1),('holded','holded',1,1),('payment_review','payment_review',1,1),('pending','new',1,1),('pending_payment','pending_payment',1,0),('processing','processing',1,1);
/*!40000 ALTER TABLE `spg_sales_order_status_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_tax`
--

DROP TABLE IF EXISTS `spg_sales_order_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_tax` (
  `tax_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `percent` decimal(12,4) DEFAULT NULL COMMENT 'Percent',
  `amount` decimal(12,4) DEFAULT NULL COMMENT 'Amount',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `base_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount',
  `process` smallint(6) NOT NULL COMMENT 'Process',
  `base_real_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Real Amount',
  PRIMARY KEY (`tax_id`),
  KEY `SPG_SALES_ORDER_TAX_ORDER_ID_PRIORITY_POSITION` (`order_id`,`priority`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_tax`
--

LOCK TABLES `spg_sales_order_tax` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_order_tax_item`
--

DROP TABLE IF EXISTS `spg_sales_order_tax_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_order_tax_item` (
  `tax_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Item Id',
  `tax_id` int(10) unsigned NOT NULL COMMENT 'Tax Id',
  `item_id` int(10) unsigned DEFAULT NULL COMMENT 'Item Id',
  `tax_percent` decimal(12,4) NOT NULL COMMENT 'Real Tax Percent For Item',
  `amount` decimal(12,4) NOT NULL COMMENT 'Tax amount for the item and tax rate',
  `base_amount` decimal(12,4) NOT NULL COMMENT 'Base tax amount for the item and tax rate',
  `real_amount` decimal(12,4) NOT NULL COMMENT 'Real tax amount for the item and tax rate',
  `real_base_amount` decimal(12,4) NOT NULL COMMENT 'Real base tax amount for the item and tax rate',
  `associated_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Id of the associated item',
  `taxable_item_type` varchar(32) NOT NULL COMMENT 'Type of the taxable item',
  PRIMARY KEY (`tax_item_id`),
  UNIQUE KEY `SPG_SALES_ORDER_TAX_ITEM_TAX_ID_ITEM_ID` (`tax_id`,`item_id`),
  KEY `SPG_SALES_ORDER_TAX_ITEM_ITEM_ID` (`item_id`),
  KEY `FK_B3F29B591DD5ED586803A2B470F49EBA` (`associated_item_id`),
  CONSTRAINT `FK_B3F29B591DD5ED586803A2B470F49EBA` FOREIGN KEY (`associated_item_id`) REFERENCES `spg_sales_order_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALES_ORDER_TAX_ITEM_ITEM_ID_SALES_ORDER_ITEM_ITEM_ID` FOREIGN KEY (`item_id`) REFERENCES `spg_sales_order_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALES_ORDER_TAX_ITEM_TAX_ID_SALES_ORDER_TAX_TAX_ID` FOREIGN KEY (`tax_id`) REFERENCES `spg_sales_order_tax` (`tax_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_order_tax_item`
--

LOCK TABLES `spg_sales_order_tax_item` WRITE;
/*!40000 ALTER TABLE `spg_sales_order_tax_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_order_tax_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_payment_transaction`
--

DROP TABLE IF EXISTS `spg_sales_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Transaction Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Payment Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `parent_txn_id` varchar(100) DEFAULT NULL COMMENT 'Parent Txn Id',
  `txn_type` varchar(15) DEFAULT NULL COMMENT 'Txn Type',
  `is_closed` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Closed',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `SPG_SALES_PAYMENT_TRANSACTION_ORDER_ID_PAYMENT_ID_TXN_ID` (`order_id`,`payment_id`,`txn_id`),
  KEY `SPG_SALES_PAYMENT_TRANSACTION_PARENT_ID` (`parent_id`),
  KEY `SPG_SALES_PAYMENT_TRANSACTION_PAYMENT_ID` (`payment_id`),
  CONSTRAINT `FK_096FDF3EF913BC4D30DF25441F23B1C1` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_payment_transaction` (`transaction_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_BD6EA140D5B45C2808E4D4D48E189918` FOREIGN KEY (`payment_id`) REFERENCES `spg_sales_order_payment` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALES_PAYMENT_TRANSACTION_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Payment Transaction';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_payment_transaction`
--

LOCK TABLES `spg_sales_payment_transaction` WRITE;
/*!40000 ALTER TABLE `spg_sales_payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_payment_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_refunded_aggregated`
--

DROP TABLE IF EXISTS `spg_sales_refunded_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_refunded_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_REFUNDED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SPG_SALES_REFUNDED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_REFUNDED_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_refunded_aggregated`
--

LOCK TABLES `spg_sales_refunded_aggregated` WRITE;
/*!40000 ALTER TABLE `spg_sales_refunded_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_refunded_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_refunded_aggregated_order`
--

DROP TABLE IF EXISTS `spg_sales_refunded_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_refunded_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_REFUNDED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `SPG_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_refunded_aggregated_order`
--

LOCK TABLES `spg_sales_refunded_aggregated_order` WRITE;
/*!40000 ALTER TABLE `spg_sales_refunded_aggregated_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_refunded_aggregated_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_sequence_meta`
--

DROP TABLE IF EXISTS `spg_sales_sequence_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_sequence_meta` (
  `meta_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity_type` varchar(32) NOT NULL COMMENT 'Prefix',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `sequence_table` varchar(32) NOT NULL COMMENT 'table for sequence',
  PRIMARY KEY (`meta_id`),
  UNIQUE KEY `SPG_SALES_SEQUENCE_META_ENTITY_TYPE_STORE_ID` (`entity_type`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='spg_sales_sequence_meta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_sequence_meta`
--

LOCK TABLES `spg_sales_sequence_meta` WRITE;
/*!40000 ALTER TABLE `spg_sales_sequence_meta` DISABLE KEYS */;
INSERT INTO `spg_sales_sequence_meta` VALUES (1,'order',0,'spg_sequence_order_0'),(2,'invoice',0,'spg_sequence_invoice_0'),(3,'creditmemo',0,'spg_sequence_creditmemo_0'),(4,'shipment',0,'spg_sequence_shipment_0'),(5,'rma_item',0,'spg_sequence_rma_item_0'),(6,'order',1,'spg_sequence_order_1'),(7,'invoice',1,'spg_sequence_invoice_1'),(8,'creditmemo',1,'spg_sequence_creditmemo_1'),(9,'shipment',1,'spg_sequence_shipment_1'),(10,'rma_item',1,'spg_sequence_rma_item_1');
/*!40000 ALTER TABLE `spg_sales_sequence_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_sequence_profile`
--

DROP TABLE IF EXISTS `spg_sales_sequence_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_sequence_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `meta_id` int(10) unsigned NOT NULL COMMENT 'Meta_id',
  `prefix` varchar(32) DEFAULT NULL COMMENT 'Prefix',
  `suffix` varchar(32) DEFAULT NULL COMMENT 'Suffix',
  `start_value` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Start value for sequence',
  `step` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Step for sequence',
  `max_value` int(10) unsigned NOT NULL COMMENT 'MaxValue for sequence',
  `warning_value` int(10) unsigned NOT NULL COMMENT 'WarningValue for sequence',
  `is_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'isActive flag',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `SPG_SALES_SEQUENCE_PROFILE_META_ID_PREFIX_SUFFIX` (`meta_id`,`prefix`,`suffix`),
  CONSTRAINT `SPG_SALES_SEQUENCE_PROFILE_META_ID_SALES_SEQUENCE_META_META_ID` FOREIGN KEY (`meta_id`) REFERENCES `spg_sales_sequence_meta` (`meta_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='spg_sales_sequence_profile';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_sequence_profile`
--

LOCK TABLES `spg_sales_sequence_profile` WRITE;
/*!40000 ALTER TABLE `spg_sales_sequence_profile` DISABLE KEYS */;
INSERT INTO `spg_sales_sequence_profile` VALUES (1,1,NULL,NULL,1,1,4294967295,4294966295,1),(2,2,NULL,NULL,1,1,4294967295,4294966295,1),(3,3,NULL,NULL,1,1,4294967295,4294966295,1),(4,4,NULL,NULL,1,1,4294967295,4294966295,1),(5,5,NULL,NULL,1,1,4294967295,4294966295,1),(6,6,NULL,NULL,1,1,4294967295,4294966295,1),(7,7,NULL,NULL,1,1,4294967295,4294966295,1),(8,8,NULL,NULL,1,1,4294967295,4294966295,1),(9,9,NULL,NULL,1,1,4294967295,4294966295,1),(10,10,NULL,NULL,1,1,4294967295,4294966295,1);
/*!40000 ALTER TABLE `spg_sales_sequence_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_shipment`
--

DROP TABLE IF EXISTS `spg_sales_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_shipment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_weight` decimal(12,4) DEFAULT NULL COMMENT 'Total Weight',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `send_email` smallint(5) unsigned DEFAULT NULL COMMENT 'Send Email',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  `packages` text COMMENT 'Packed Products in Packages',
  `shipping_label` mediumblob COMMENT 'Shipping Label Content',
  `customer_note` text COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_SALES_SHIPMENT_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_SALES_SHIPMENT_STORE_ID` (`store_id`),
  KEY `SPG_SALES_SHIPMENT_TOTAL_QTY` (`total_qty`),
  KEY `SPG_SALES_SHIPMENT_ORDER_ID` (`order_id`),
  KEY `SPG_SALES_SHIPMENT_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_SHIPMENT_UPDATED_AT` (`updated_at`),
  KEY `SPG_SALES_SHIPMENT_SEND_EMAIL` (`send_email`),
  KEY `SPG_SALES_SHIPMENT_EMAIL_SENT` (`email_sent`),
  CONSTRAINT `SPG_SALES_SHIPMENT_ORDER_ID_SALES_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `spg_sales_order` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALES_SHIPMENT_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_shipment`
--

LOCK TABLES `spg_sales_shipment` WRITE;
/*!40000 ALTER TABLE `spg_sales_shipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_shipment_comment`
--

DROP TABLE IF EXISTS `spg_sales_shipment_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_shipment_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_SHIPMENT_COMMENT_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_SHIPMENT_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_SALES_SHIPMENT_COMMENT_PARENT_ID_SALES_SHIPMENT_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_shipment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Comment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_shipment_comment`
--

LOCK TABLES `spg_sales_shipment_comment` WRITE;
/*!40000 ALTER TABLE `spg_sales_shipment_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_shipment_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_shipment_grid`
--

DROP TABLE IF EXISTS `spg_sales_shipment_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_shipment_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_increment_id` varchar(32) NOT NULL COMMENT 'Order Increment Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `order_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Order Increment Id',
  `customer_name` varchar(128) NOT NULL COMMENT 'Customer Name',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `order_status` varchar(32) DEFAULT NULL COMMENT 'Order',
  `billing_address` varchar(255) DEFAULT NULL COMMENT 'Billing Address',
  `shipping_address` varchar(255) DEFAULT NULL COMMENT 'Shipping Address',
  `billing_name` varchar(128) DEFAULT NULL COMMENT 'Billing Name',
  `shipping_name` varchar(128) DEFAULT NULL COMMENT 'Shipping Name',
  `customer_email` varchar(128) DEFAULT NULL COMMENT 'Customer Email',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `payment_method` varchar(32) DEFAULT NULL COMMENT 'Payment Method',
  `shipping_information` varchar(255) DEFAULT NULL COMMENT 'Shipping Method Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_SALES_SHIPMENT_GRID_INCREMENT_ID_STORE_ID` (`increment_id`,`store_id`),
  KEY `SPG_SALES_SHIPMENT_GRID_STORE_ID` (`store_id`),
  KEY `SPG_SALES_SHIPMENT_GRID_TOTAL_QTY` (`total_qty`),
  KEY `SPG_SALES_SHIPMENT_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `SPG_SALES_SHIPMENT_GRID_SHIPMENT_STATUS` (`shipment_status`),
  KEY `SPG_SALES_SHIPMENT_GRID_ORDER_STATUS` (`order_status`),
  KEY `SPG_SALES_SHIPMENT_GRID_CREATED_AT` (`created_at`),
  KEY `SPG_SALES_SHIPMENT_GRID_UPDATED_AT` (`updated_at`),
  KEY `SPG_SALES_SHIPMENT_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `SPG_SALES_SHIPMENT_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `SPG_SALES_SHIPMENT_GRID_BILLING_NAME` (`billing_name`),
  FULLTEXT KEY `FTI_9E2E6A7B0AA3E5BCC84907D6713C8872` (`increment_id`,`order_increment_id`,`shipping_name`,`customer_name`,`customer_email`,`billing_address`,`shipping_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_shipment_grid`
--

LOCK TABLES `spg_sales_shipment_grid` WRITE;
/*!40000 ALTER TABLE `spg_sales_shipment_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_shipment_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_shipment_item`
--

DROP TABLE IF EXISTS `spg_sales_shipment_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_shipment_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_SHIPMENT_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `SPG_SALES_SHIPMENT_ITEM_PARENT_ID_SALES_SHIPMENT_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_shipment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_shipment_item`
--

LOCK TABLES `spg_sales_shipment_item` WRITE;
/*!40000 ALTER TABLE `spg_sales_shipment_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_shipment_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_shipment_track`
--

DROP TABLE IF EXISTS `spg_sales_shipment_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_shipment_track` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `track_number` text COMMENT 'Number',
  `description` text COMMENT 'Description',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT 'Carrier Code',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  KEY `SPG_SALES_SHIPMENT_TRACK_PARENT_ID` (`parent_id`),
  KEY `SPG_SALES_SHIPMENT_TRACK_ORDER_ID` (`order_id`),
  KEY `SPG_SALES_SHIPMENT_TRACK_CREATED_AT` (`created_at`),
  CONSTRAINT `SPG_SALES_SHIPMENT_TRACK_PARENT_ID_SALES_SHIPMENT_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `spg_sales_shipment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Track';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_shipment_track`
--

LOCK TABLES `spg_sales_shipment_track` WRITE;
/*!40000 ALTER TABLE `spg_sales_shipment_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_shipment_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_shipping_aggregated`
--

DROP TABLE IF EXISTS `spg_sales_shipping_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_shipping_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SPG_SALES_SHPP_AGGRED_PERIOD_STORE_ID_ORDER_STS_SHPP_DESCRIPTION` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `SPG_SALES_SHIPPING_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_SHIPPING_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_shipping_aggregated`
--

LOCK TABLES `spg_sales_shipping_aggregated` WRITE;
/*!40000 ALTER TABLE `spg_sales_shipping_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_shipping_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sales_shipping_aggregated_order`
--

DROP TABLE IF EXISTS `spg_sales_shipping_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sales_shipping_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_E8B52B51117F28FD97762F99EAA5C66E` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `SPG_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sales_shipping_aggregated_order`
--

LOCK TABLES `spg_sales_shipping_aggregated_order` WRITE;
/*!40000 ALTER TABLE `spg_sales_shipping_aggregated_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sales_shipping_aggregated_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule`
--

DROP TABLE IF EXISTS `spg_salesrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Version Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `created_in` bigint(20) unsigned NOT NULL COMMENT 'Update Id',
  `updated_in` bigint(20) unsigned NOT NULL COMMENT 'Next Update Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL COMMENT 'From',
  `to_date` date DEFAULT NULL COMMENT 'To',
  `uses_per_customer` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Customer',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `is_advanced` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Advanced',
  `product_ids` text COMMENT 'Product Ids',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `discount_qty` decimal(12,4) DEFAULT NULL COMMENT 'Discount Qty',
  `discount_step` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Discount Step',
  `apply_to_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Apply To Shipping',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `is_rss` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Rss',
  `coupon_type` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Coupon Type',
  `use_auto_generation` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Use Auto Generation',
  `uses_per_coupon` int(11) NOT NULL DEFAULT '0' COMMENT 'User Per Coupon',
  `simple_free_shipping` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`row_id`),
  KEY `SPG_SALESRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`),
  KEY `SPG_SALESRULE_CREATED_IN` (`created_in`),
  KEY `SPG_SALESRULE_UPDATED_IN` (`updated_in`),
  KEY `SPG_SALESRULE_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE` (`rule_id`),
  CONSTRAINT `SPG_SALESRULE_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_salesrule` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule`
--

LOCK TABLES `spg_salesrule` WRITE;
/*!40000 ALTER TABLE `spg_salesrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_coupon`
--

DROP TABLE IF EXISTS `spg_salesrule_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_coupon` (
  `coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Coupon Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `usage_limit` int(10) unsigned DEFAULT NULL COMMENT 'Usage Limit',
  `usage_per_customer` int(10) unsigned DEFAULT NULL COMMENT 'Usage Per Customer',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `expiration_date` timestamp NULL DEFAULT NULL COMMENT 'Expiration Date',
  `is_primary` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Primary',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Coupon Code Creation Date',
  `type` smallint(6) DEFAULT '0' COMMENT 'Coupon Code Type',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `SPG_SALESRULE_COUPON_CODE` (`code`),
  UNIQUE KEY `SPG_SALESRULE_COUPON_RULE_ID_IS_PRIMARY` (`rule_id`,`is_primary`),
  KEY `SPG_SALESRULE_COUPON_RULE_ID` (`rule_id`),
  CONSTRAINT `SPG_SALESRULE_COUPON_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_salesrule` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_coupon`
--

LOCK TABLES `spg_salesrule_coupon` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_coupon` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_coupon_aggregated`
--

DROP TABLE IF EXISTS `spg_salesrule_coupon_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_coupon_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_FB49043FD5383E5A7E0E3325182FD248` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `SPG_SALESRULE_COUPON_AGGREGATED_STORE_ID` (`store_id`),
  KEY `SPG_SALESRULE_COUPON_AGGREGATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `SPG_SALESRULE_COUPON_AGGREGATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_coupon_aggregated`
--

LOCK TABLES `spg_salesrule_coupon_aggregated` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_coupon_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_coupon_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_coupon_aggregated_order`
--

DROP TABLE IF EXISTS `spg_salesrule_coupon_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_coupon_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_5A032BDC69130C3388CC8ADEE52EDAC1` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `SPG_SALESRULE_COUPON_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  KEY `SPG_SALESRULE_COUPON_AGGREGATED_ORDER_RULE_NAME` (`rule_name`),
  CONSTRAINT `SPG_SALESRULE_COUPON_AGGREGATED_ORDER_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_coupon_aggregated_order`
--

LOCK TABLES `spg_salesrule_coupon_aggregated_order` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_coupon_aggregated_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_coupon_aggregated_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_coupon_aggregated_updated`
--

DROP TABLE IF EXISTS `spg_salesrule_coupon_aggregated_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_coupon_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_2B2B9C9A9224A2F7229A7524EEBF17C9` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `SPG_SALESRULE_COUPON_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  KEY `SPG_SALESRULE_COUPON_AGGREGATED_UPDATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `SPG_SALESRULE_COUPON_AGGRED_UPDATED_STORE_ID_SPG_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Spg Salesrule Coupon Aggregated Updated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_coupon_aggregated_updated`
--

LOCK TABLES `spg_salesrule_coupon_aggregated_updated` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_coupon_aggregated_updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_coupon_aggregated_updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_coupon_usage`
--

DROP TABLE IF EXISTS `spg_salesrule_coupon_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_coupon_usage` (
  `coupon_id` int(10) unsigned NOT NULL COMMENT 'Coupon Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`coupon_id`,`customer_id`),
  KEY `SPG_SALESRULE_COUPON_USAGE_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `SPG_SALESRULE_COUPON_USAGE_COUPON_ID_SALESRULE_COUPON_COUPON_ID` FOREIGN KEY (`coupon_id`) REFERENCES `spg_salesrule_coupon` (`coupon_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALESRULE_COUPON_USAGE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon Usage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_coupon_usage`
--

LOCK TABLES `spg_salesrule_coupon_usage` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_coupon_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_coupon_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_customer`
--

DROP TABLE IF EXISTS `spg_salesrule_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_customer` (
  `rule_customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Customer Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `times_used` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`rule_customer_id`),
  KEY `SPG_SALESRULE_CUSTOMER_RULE_ID_CUSTOMER_ID` (`rule_id`,`customer_id`),
  KEY `SPG_SALESRULE_CUSTOMER_CUSTOMER_ID_RULE_ID` (`customer_id`,`rule_id`),
  CONSTRAINT `SPG_SALESRULE_CUSTOMER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALESRULE_CUSTOMER_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_salesrule` (`sequence_value`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Customer';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_customer`
--

LOCK TABLES `spg_salesrule_customer` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_customer_group`
--

DROP TABLE IF EXISTS `spg_salesrule_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_customer_group` (
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`row_id`,`customer_group_id`),
  KEY `SPG_SALESRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `SPG_SALESRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALESRULE_CUSTOMER_GROUP_ROW_ID_SALESRULE_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_salesrule` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Customer Groups Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_customer_group`
--

LOCK TABLES `spg_salesrule_customer_group` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_customer_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_label`
--

DROP TABLE IF EXISTS `spg_salesrule_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_label` (
  `label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Label Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  PRIMARY KEY (`label_id`),
  UNIQUE KEY `SPG_SALESRULE_LABEL_RULE_ID_STORE_ID` (`rule_id`,`store_id`),
  KEY `SPG_SALESRULE_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SALESRULE_LABEL_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE` FOREIGN KEY (`rule_id`) REFERENCES `spg_sequence_salesrule` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALESRULE_LABEL_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Label';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_label`
--

LOCK TABLES `spg_salesrule_label` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_product_attribute`
--

DROP TABLE IF EXISTS `spg_salesrule_product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_product_attribute` (
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`row_id`,`website_id`,`customer_group_id`,`attribute_id`),
  KEY `SPG_SALESRULE_PRODUCT_ATTRIBUTE_WEBSITE_ID` (`website_id`),
  KEY `SPG_SALESRULE_PRODUCT_ATTRIBUTE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `SPG_SALESRULE_PRODUCT_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_SALESRULE_PRD_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALESRULE_PRD_ATTR_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `spg_customer_group` (`customer_group_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALESRULE_PRD_ATTR_WS_ID_STORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALESRULE_PRODUCT_ATTRIBUTE_ROW_ID_SALESRULE_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_salesrule` (`row_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Product Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_product_attribute`
--

LOCK TABLES `spg_salesrule_product_attribute` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_product_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_product_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_salesrule_website`
--

DROP TABLE IF EXISTS `spg_salesrule_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_salesrule_website` (
  `row_id` int(10) unsigned NOT NULL COMMENT 'Version Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`row_id`,`website_id`),
  KEY `SPG_SALESRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `SPG_SALESRULE_WEBSITE_ROW_ID_SALESRULE_ROW_ID` FOREIGN KEY (`row_id`) REFERENCES `spg_salesrule` (`row_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SALESRULE_WEBSITE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Websites Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_salesrule_website`
--

LOCK TABLES `spg_salesrule_website` WRITE;
/*!40000 ALTER TABLE `spg_salesrule_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_salesrule_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_search_query`
--

DROP TABLE IF EXISTS `spg_search_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_search_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Query ID',
  `query_text` varchar(255) DEFAULT NULL COMMENT 'Query text',
  `num_results` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Num results',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `redirect` varchar(255) DEFAULT NULL COMMENT 'Redirect',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `display_in_terms` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Display in terms',
  `is_active` smallint(6) DEFAULT '1' COMMENT 'Active status',
  `is_processed` smallint(6) DEFAULT '0' COMMENT 'Processed status',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated at',
  PRIMARY KEY (`query_id`),
  UNIQUE KEY `SPG_SEARCH_QUERY_QUERY_TEXT_STORE_ID` (`query_text`,`store_id`),
  KEY `SPG_SEARCH_QUERY_QUERY_TEXT_STORE_ID_POPULARITY` (`query_text`,`store_id`,`popularity`),
  KEY `SPG_SEARCH_QUERY_STORE_ID` (`store_id`),
  KEY `SPG_SEARCH_QUERY_IS_PROCESSED` (`is_processed`),
  CONSTRAINT `SPG_SEARCH_QUERY_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Search query table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_search_query`
--

LOCK TABLES `spg_search_query` WRITE;
/*!40000 ALTER TABLE `spg_search_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_search_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_search_synonyms`
--

DROP TABLE IF EXISTS `spg_search_synonyms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_search_synonyms` (
  `group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Synonyms Group Id',
  `synonyms` text NOT NULL COMMENT 'list of synonyms making up this group',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id - identifies the store view these synonyms belong to',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id - identifies the website id these synonyms belong to',
  PRIMARY KEY (`group_id`),
  KEY `SPG_SEARCH_SYNONYMS_STORE_ID` (`store_id`),
  KEY `SPG_SEARCH_SYNONYMS_WEBSITE_ID` (`website_id`),
  FULLTEXT KEY `SPG_SEARCH_SYNONYMS_SYNONYMS` (`synonyms`),
  CONSTRAINT `SPG_SEARCH_SYNONYMS_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_SEARCH_SYNONYMS_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='table storing various synonyms groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_search_synonyms`
--

LOCK TABLES `spg_search_synonyms` WRITE;
/*!40000 ALTER TABLE `spg_search_synonyms` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_search_synonyms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sendfriend_log`
--

DROP TABLE IF EXISTS `spg_sendfriend_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sendfriend_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `ip` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer IP address',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log time',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`log_id`),
  KEY `SPG_SENDFRIEND_LOG_IP` (`ip`),
  KEY `SPG_SENDFRIEND_LOG_TIME` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Send to friend function log storage table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sendfriend_log`
--

LOCK TABLES `spg_sendfriend_log` WRITE;
/*!40000 ALTER TABLE `spg_sendfriend_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sendfriend_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_catalog_category`
--

DROP TABLE IF EXISTS `spg_sequence_catalog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_catalog_category` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_catalog_category`
--

LOCK TABLES `spg_sequence_catalog_category` WRITE;
/*!40000 ALTER TABLE `spg_sequence_catalog_category` DISABLE KEYS */;
INSERT INTO `spg_sequence_catalog_category` VALUES (1),(2),(3),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31),(32),(33),(34),(35),(36),(37),(38);
/*!40000 ALTER TABLE `spg_sequence_catalog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_catalogrule`
--

DROP TABLE IF EXISTS `spg_sequence_catalogrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_catalogrule` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_catalogrule`
--

LOCK TABLES `spg_sequence_catalogrule` WRITE;
/*!40000 ALTER TABLE `spg_sequence_catalogrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_catalogrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_cms_block`
--

DROP TABLE IF EXISTS `spg_sequence_cms_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_cms_block` (
  `sequence_value` smallint(6) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_cms_block`
--

LOCK TABLES `spg_sequence_cms_block` WRITE;
/*!40000 ALTER TABLE `spg_sequence_cms_block` DISABLE KEYS */;
INSERT INTO `spg_sequence_cms_block` VALUES (1),(2);
/*!40000 ALTER TABLE `spg_sequence_cms_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_cms_page`
--

DROP TABLE IF EXISTS `spg_sequence_cms_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_cms_page` (
  `sequence_value` smallint(6) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_cms_page`
--

LOCK TABLES `spg_sequence_cms_page` WRITE;
/*!40000 ALTER TABLE `spg_sequence_cms_page` DISABLE KEYS */;
INSERT INTO `spg_sequence_cms_page` VALUES (1),(2),(3),(4),(5),(6),(7);
/*!40000 ALTER TABLE `spg_sequence_cms_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_creditmemo_0`
--

DROP TABLE IF EXISTS `spg_sequence_creditmemo_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_creditmemo_0` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_creditmemo_0`
--

LOCK TABLES `spg_sequence_creditmemo_0` WRITE;
/*!40000 ALTER TABLE `spg_sequence_creditmemo_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_creditmemo_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_creditmemo_1`
--

DROP TABLE IF EXISTS `spg_sequence_creditmemo_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_creditmemo_1` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_creditmemo_1`
--

LOCK TABLES `spg_sequence_creditmemo_1` WRITE;
/*!40000 ALTER TABLE `spg_sequence_creditmemo_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_creditmemo_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_invoice_0`
--

DROP TABLE IF EXISTS `spg_sequence_invoice_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_invoice_0` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_invoice_0`
--

LOCK TABLES `spg_sequence_invoice_0` WRITE;
/*!40000 ALTER TABLE `spg_sequence_invoice_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_invoice_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_invoice_1`
--

DROP TABLE IF EXISTS `spg_sequence_invoice_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_invoice_1` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_invoice_1`
--

LOCK TABLES `spg_sequence_invoice_1` WRITE;
/*!40000 ALTER TABLE `spg_sequence_invoice_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_invoice_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_order_0`
--

DROP TABLE IF EXISTS `spg_sequence_order_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_order_0` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_order_0`
--

LOCK TABLES `spg_sequence_order_0` WRITE;
/*!40000 ALTER TABLE `spg_sequence_order_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_order_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_order_1`
--

DROP TABLE IF EXISTS `spg_sequence_order_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_order_1` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_order_1`
--

LOCK TABLES `spg_sequence_order_1` WRITE;
/*!40000 ALTER TABLE `spg_sequence_order_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_order_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_product`
--

DROP TABLE IF EXISTS `spg_sequence_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_product` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_product`
--

LOCK TABLES `spg_sequence_product` WRITE;
/*!40000 ALTER TABLE `spg_sequence_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_rma_item_0`
--

DROP TABLE IF EXISTS `spg_sequence_rma_item_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_rma_item_0` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_rma_item_0`
--

LOCK TABLES `spg_sequence_rma_item_0` WRITE;
/*!40000 ALTER TABLE `spg_sequence_rma_item_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_rma_item_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_rma_item_1`
--

DROP TABLE IF EXISTS `spg_sequence_rma_item_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_rma_item_1` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_rma_item_1`
--

LOCK TABLES `spg_sequence_rma_item_1` WRITE;
/*!40000 ALTER TABLE `spg_sequence_rma_item_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_rma_item_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_salesrule`
--

DROP TABLE IF EXISTS `spg_sequence_salesrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_salesrule` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_salesrule`
--

LOCK TABLES `spg_sequence_salesrule` WRITE;
/*!40000 ALTER TABLE `spg_sequence_salesrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_salesrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_shipment_0`
--

DROP TABLE IF EXISTS `spg_sequence_shipment_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_shipment_0` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_shipment_0`
--

LOCK TABLES `spg_sequence_shipment_0` WRITE;
/*!40000 ALTER TABLE `spg_sequence_shipment_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_shipment_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sequence_shipment_1`
--

DROP TABLE IF EXISTS `spg_sequence_shipment_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sequence_shipment_1` (
  `sequence_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sequence_shipment_1`
--

LOCK TABLES `spg_sequence_shipment_1` WRITE;
/*!40000 ALTER TABLE `spg_sequence_shipment_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sequence_shipment_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_session`
--

DROP TABLE IF EXISTS `spg_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_session` (
  `session_id` varchar(255) NOT NULL COMMENT 'Session Id',
  `session_expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Date of Session Expiration',
  `session_data` mediumblob NOT NULL COMMENT 'Session Data',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Database Sessions Storage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_session`
--

LOCK TABLES `spg_session` WRITE;
/*!40000 ALTER TABLE `spg_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_setup_module`
--

DROP TABLE IF EXISTS `spg_setup_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_setup_module` (
  `module` varchar(50) NOT NULL COMMENT 'Module',
  `schema_version` varchar(50) DEFAULT NULL COMMENT 'Schema Version',
  `data_version` varchar(50) DEFAULT NULL COMMENT 'Data Version',
  PRIMARY KEY (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Module versions registry';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_setup_module`
--

LOCK TABLES `spg_setup_module` WRITE;
/*!40000 ALTER TABLE `spg_setup_module` DISABLE KEYS */;
INSERT INTO `spg_setup_module` VALUES ('Magento_AdminGws','2.0.0','2.0.0'),('Magento_AdminNotification','2.0.0','2.0.0'),('Magento_AdvancedCatalog','2.0.0','2.0.0'),('Magento_AdvancedCheckout','2.0.0','2.0.0'),('Magento_AdvancedPricingImportExport','2.0.0','2.0.0'),('Magento_AdvancedRule','2.0.0','2.0.0'),('Magento_AdvancedSalesRule','2.0.0','2.0.0'),('Magento_AdvancedSearch','2.0.0','2.0.0'),('Magento_Amqp','2.0.0','2.0.0'),('Magento_Authorization','2.0.0','2.0.0'),('Magento_Authorizenet','2.0.0','2.0.0'),('Magento_Backend','2.0.0','2.0.0'),('Magento_Backup','2.0.0','2.0.0'),('Magento_Banner','2.0.0','2.0.0'),('Magento_BannerCustomerSegment','2.0.0','2.0.0'),('Magento_Braintree','2.0.0','2.0.0'),('Magento_Bundle','2.0.2','2.0.2'),('Magento_BundleImportExport','2.0.0','2.0.0'),('Magento_BundleStaging','2.0.0','2.0.0'),('Magento_CacheInvalidate','2.0.0','2.0.0'),('Magento_Captcha','2.0.0','2.0.0'),('Magento_Catalog','2.1.3','2.1.3'),('Magento_CatalogEvent','2.0.1','2.0.1'),('Magento_CatalogImportExport','2.0.0','2.0.0'),('Magento_CatalogImportExportStaging','2.0.0','2.0.0'),('Magento_CatalogInventory','2.0.1','2.0.1'),('Magento_CatalogInventoryStaging','2.0.0','2.0.0'),('Magento_CatalogPermissions','2.0.0','2.0.0'),('Magento_CatalogRule','2.0.1','2.0.1'),('Magento_CatalogRuleConfigurable','2.0.0','2.0.0'),('Magento_CatalogRuleStaging','2.0.0','2.0.0'),('Magento_CatalogSearch','2.0.0','2.0.0'),('Magento_CatalogStaging','2.1.0','2.1.0'),('Magento_CatalogUrlRewrite','2.0.0','2.0.0'),('Magento_CatalogUrlRewriteStaging','2.0.0','2.0.0'),('Magento_CatalogWidget','2.0.0','2.0.0'),('Magento_Checkout','2.0.0','2.0.0'),('Magento_CheckoutAgreements','2.0.1','2.0.1'),('Magento_CheckoutStaging','2.0.0','2.0.0'),('Magento_Cms','2.0.1','2.0.1'),('Magento_CmsStaging','2.0.0','2.0.0'),('Magento_CmsUrlRewrite','2.0.0','2.0.0'),('Magento_Config','2.0.0','2.0.0'),('Magento_ConfigurableImportExport','2.0.0','2.0.0'),('Magento_ConfigurableProduct','2.0.0','2.0.0'),('Magento_ConfigurableProductStaging','2.0.0','2.0.0'),('Magento_Contact','2.0.0','2.0.0'),('Magento_Cookie','2.0.0','2.0.0'),('Magento_Cron','2.0.0','2.0.0'),('Magento_CurrencySymbol','2.0.0','2.0.0'),('Magento_CustomAttributeManagement','2.0.0','2.0.0'),('Magento_Customer','2.0.9','2.0.9'),('Magento_CustomerBalance','2.0.0','2.0.0'),('Magento_CustomerCustomAttributes','2.0.0','2.0.0'),('Magento_CustomerFinance','2.0.0','2.0.0'),('Magento_CustomerImportExport','2.0.0','2.0.0'),('Magento_CustomerSegment','2.0.0','2.0.0'),('Magento_Cybersource','2.0.0','2.0.0'),('Magento_Deploy','2.0.0','2.0.0'),('Magento_Developer','2.0.0','2.0.0'),('Magento_Dhl','2.0.0','2.0.0'),('Magento_Directory','2.0.0','2.0.0'),('Magento_Downloadable','2.0.1','2.0.1'),('Magento_DownloadableImportExport','2.0.0','2.0.0'),('Magento_DownloadableStaging','2.0.0','2.0.0'),('Magento_Eav','2.0.0','2.0.0'),('Magento_Elasticsearch','2.0.0','2.0.0'),('Magento_Email','2.0.0','2.0.0'),('Magento_EncryptionKey','2.0.0','2.0.0'),('Magento_Enterprise','2.0.0','2.0.0'),('Magento_Eway','2.0.0','2.0.0'),('Magento_Fedex','2.0.0','2.0.0'),('Magento_GiftCard','2.0.1','2.0.1'),('Magento_GiftCardAccount','2.0.0','2.0.0'),('Magento_GiftCardImportExport','2.0.0','2.0.0'),('Magento_GiftCardStaging','2.0.0','2.0.0'),('Magento_GiftMessage','2.0.1','2.0.1'),('Magento_GiftMessageStaging','2.0.0','2.0.0'),('Magento_GiftRegistry','2.0.0','2.0.0'),('Magento_GiftWrapping','2.1.3','2.1.3'),('Magento_GiftWrappingStaging','2.0.0','2.0.0'),('Magento_GoogleAdwords','2.0.0','2.0.0'),('Magento_GoogleAnalytics','2.0.0','2.0.0'),('Magento_GoogleOptimizer','2.0.0','2.0.0'),('Magento_GoogleOptimizerStaging','2.0.0','2.0.0'),('Magento_GoogleTagManager','2.0.0','2.0.0'),('Magento_GroupedImportExport','2.0.0','2.0.0'),('Magento_GroupedProduct','2.0.1','2.0.1'),('Magento_GroupedProductStaging','2.0.0','2.0.0'),('Magento_ImportExport','2.0.1','2.0.1'),('Magento_Indexer','2.0.0','2.0.0'),('Magento_Integration','2.0.1','2.0.1'),('Magento_Invitation','2.0.0','2.0.0'),('Magento_LayeredNavigation','2.0.0','2.0.0'),('Magento_LayeredNavigationStaging','2.0.2','2.0.2'),('Magento_Logging','2.0.0','2.0.0'),('Magento_Marketplace','1.0.0','1.0.0'),('Magento_MediaStorage','2.0.0','2.0.0'),('Magento_MessageQueue','2.1.0','2.1.0'),('Magento_Msrp','2.1.3','2.1.3'),('Magento_MsrpStaging','2.0.0','2.0.0'),('Magento_MultipleWishlist','2.0.0','2.0.0'),('Magento_Multishipping','2.0.0','2.0.0'),('Magento_MysqlMq','2.0.0','2.0.0'),('Magento_NewRelicReporting','2.0.0','2.0.0'),('Magento_Newsletter','2.0.0','2.0.0'),('Magento_OfflinePayments','2.0.0','2.0.0'),('Magento_OfflineShipping','2.0.0','2.0.0'),('Magento_PageCache','2.0.0','2.0.0'),('Magento_Payment','2.0.0','2.0.0'),('Magento_PaymentStaging','2.0.0','2.0.0'),('Magento_Paypal','2.0.0','2.0.0'),('Magento_Persistent','2.0.0','2.0.0'),('Magento_PersistentHistory','2.0.0','2.0.0'),('Magento_PricePermissions','2.0.0','2.0.0'),('Magento_ProductAlert','2.0.0','2.0.0'),('Magento_ProductVideo','2.0.0.2','2.0.0.2'),('Magento_ProductVideoStaging','2.0.0','2.0.0'),('Magento_PromotionPermissions','2.0.0','2.0.0'),('Magento_Quote','2.0.3','2.0.3'),('Magento_Reminder','2.0.1','2.0.1'),('Magento_Reports','2.0.0','2.0.0'),('Magento_RequireJs','2.0.0','2.0.0'),('Magento_ResourceConnections','2.0.0','2.0.0'),('Magento_Review','2.0.0','2.0.0'),('Magento_ReviewStaging','2.0.0','2.0.0'),('Magento_Reward','2.0.0','2.0.0'),('Magento_Rma','2.0.2','2.0.2'),('Magento_RmaStaging','2.0.0','2.0.0'),('Magento_Rss','2.0.0','2.0.0'),('Magento_Rule','2.0.0','2.0.0'),('Magento_Sales','2.0.3','2.0.3'),('Magento_SalesArchive','2.0.0','2.0.0'),('Magento_SalesInventory','1.0.0','1.0.0'),('Magento_SalesRule','2.0.1','2.0.1'),('Magento_SalesRuleStaging','2.0.0','2.0.0'),('Magento_SalesSequence','2.0.0','2.0.0'),('Magento_SampleData','2.0.0','2.0.0'),('Magento_ScalableCheckout','2.0.0','2.0.0'),('Magento_ScalableInventory','2.0.0','2.0.0'),('Magento_ScalableOms','2.0.0','2.0.0'),('Magento_ScheduledImportExport','2.0.0','2.0.0'),('Magento_Search','2.0.4','2.0.4'),('Magento_SearchStaging','2.0.0','2.0.0'),('Magento_Security','2.0.1','2.0.1'),('Magento_SendFriend','2.0.0','2.0.0'),('Magento_Shipping','2.0.0','2.0.0'),('Magento_Sitemap','2.0.0','2.0.0'),('Magento_Solr','2.0.0','2.0.0'),('Magento_Staging','2.1.0','2.1.0'),('Magento_Store','2.0.0','2.0.0'),('Magento_Support','2.0.0.1','2.0.0.1'),('Magento_Swagger','2.0.0','2.0.0'),('Magento_Swatches','2.0.1','2.0.1'),('Magento_SwatchesLayeredNavigation','2.0.0','2.0.0'),('Magento_TargetRule','2.0.0','2.0.0'),('Magento_Tax','2.0.1','2.0.1'),('Magento_TaxImportExport','2.0.0','2.0.0'),('Magento_Theme','2.0.1','2.0.1'),('Magento_Translation','2.0.0','2.0.0'),('Magento_Ui','2.0.0','2.0.0'),('Magento_Ups','2.0.0','2.0.0'),('Magento_UrlRewrite','2.0.0','2.0.0'),('Magento_User','2.0.1','2.0.1'),('Magento_Usps','2.0.0','2.0.0'),('Magento_Variable','2.0.0','2.0.0'),('Magento_Vault','2.0.2','2.0.2'),('Magento_Version','2.0.0','2.0.0'),('Magento_VersionsCms','2.0.1','2.0.1'),('Magento_VisualMerchandiser','2.0.0','2.0.0'),('Magento_Webapi','2.0.0','2.0.0'),('Magento_WebapiSecurity','2.0.0','2.0.0'),('Magento_WebsiteRestriction','2.0.0','2.0.0'),('Magento_Weee','2.0.0','2.0.0'),('Magento_WeeeStaging','2.0.0','2.0.0'),('Magento_Widget','2.0.0','2.0.0'),('Magento_Wishlist','2.0.0','2.0.0'),('Magento_Worldpay','2.0.0','2.0.0');
/*!40000 ALTER TABLE `spg_setup_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_shipping_tablerate`
--

DROP TABLE IF EXISTS `spg_shipping_tablerate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_shipping_tablerate` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `website_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `dest_country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Destination coutry ISO/2 or ISO/3 code',
  `dest_region_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Destination Region Id',
  `dest_zip` varchar(10) NOT NULL DEFAULT '*' COMMENT 'Destination Post Code (Zip)',
  `condition_name` varchar(20) NOT NULL COMMENT 'Rate Condition name',
  `condition_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rate condition value',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `cost` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Cost',
  PRIMARY KEY (`pk`),
  UNIQUE KEY `UNQ_FCCD1DC8BC5E57FC915419BD47594736` (`website_id`,`dest_country_id`,`dest_region_id`,`dest_zip`,`condition_name`,`condition_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Shipping Tablerate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_shipping_tablerate`
--

LOCK TABLES `spg_shipping_tablerate` WRITE;
/*!40000 ALTER TABLE `spg_shipping_tablerate` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_shipping_tablerate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_sitemap`
--

DROP TABLE IF EXISTS `spg_sitemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_sitemap` (
  `sitemap_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sitemap Id',
  `sitemap_type` varchar(32) DEFAULT NULL COMMENT 'Sitemap Type',
  `sitemap_filename` varchar(32) DEFAULT NULL COMMENT 'Sitemap Filename',
  `sitemap_path` varchar(255) DEFAULT NULL COMMENT 'Sitemap Path',
  `sitemap_time` timestamp NULL DEFAULT NULL COMMENT 'Sitemap Time',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`sitemap_id`),
  KEY `SPG_SITEMAP_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_SITEMAP_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='XML Sitemap';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_sitemap`
--

LOCK TABLES `spg_sitemap` WRITE;
/*!40000 ALTER TABLE `spg_sitemap` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_sitemap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_staging_update`
--

DROP TABLE IF EXISTS `spg_staging_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_staging_update` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Update ID',
  `start_time` datetime DEFAULT NULL COMMENT 'Update start time',
  `name` varchar(255) DEFAULT NULL COMMENT 'Update name',
  `description` varchar(255) DEFAULT NULL COMMENT 'Update description',
  `rollback_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Rollback ID',
  `is_campaign` tinyint(1) DEFAULT NULL COMMENT 'Is update a campaign',
  `is_rollback` tinyint(1) DEFAULT NULL COMMENT 'Is update a rollback',
  `moved_to` bigint(20) unsigned DEFAULT NULL COMMENT 'Update Id it was moved to',
  PRIMARY KEY (`id`),
  KEY `SPG_STAGING_UPDATE_IS_CAMPAIGN` (`is_campaign`),
  FULLTEXT KEY `SPG_STAGING_UPDATE_GRID_NAME_DESCRIPTION` (`name`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Staging Updates table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_staging_update`
--

LOCK TABLES `spg_staging_update` WRITE;
/*!40000 ALTER TABLE `spg_staging_update` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_staging_update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_store`
--

DROP TABLE IF EXISTS `spg_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_store` (
  `store_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Store Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Sort Order',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Activity',
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `SPG_STORE_CODE` (`code`),
  KEY `SPG_STORE_WEBSITE_ID` (`website_id`),
  KEY `SPG_STORE_IS_ACTIVE_SORT_ORDER` (`is_active`,`sort_order`),
  KEY `SPG_STORE_GROUP_ID` (`group_id`),
  CONSTRAINT `SPG_STORE_GROUP_ID_STORE_GROUP_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `spg_store_group` (`group_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_STORE_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_store`
--

LOCK TABLES `spg_store` WRITE;
/*!40000 ALTER TABLE `spg_store` DISABLE KEYS */;
INSERT INTO `spg_store` VALUES (0,'admin',0,0,'Admin',0,1),(1,'default',1,1,'Default Store View',0,1);
/*!40000 ALTER TABLE `spg_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_store_group`
--

DROP TABLE IF EXISTS `spg_store_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_store_group` (
  `group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Group Name',
  `root_category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Root Category Id',
  `default_store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Store Id',
  PRIMARY KEY (`group_id`),
  KEY `SPG_STORE_GROUP_WEBSITE_ID` (`website_id`),
  KEY `SPG_STORE_GROUP_DEFAULT_STORE_ID` (`default_store_id`),
  CONSTRAINT `SPG_STORE_GROUP_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Store Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_store_group`
--

LOCK TABLES `spg_store_group` WRITE;
/*!40000 ALTER TABLE `spg_store_group` DISABLE KEYS */;
INSERT INTO `spg_store_group` VALUES (0,0,'Default',0,0),(1,1,'Main Website Store',2,1);
/*!40000 ALTER TABLE `spg_store_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_store_website`
--

DROP TABLE IF EXISTS `spg_store_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_store_website` (
  `website_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Website Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `name` varchar(64) DEFAULT NULL COMMENT 'Website Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Group Id',
  `is_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Defines Is Website Default',
  PRIMARY KEY (`website_id`),
  UNIQUE KEY `SPG_STORE_WEBSITE_CODE` (`code`),
  KEY `SPG_STORE_WEBSITE_SORT_ORDER` (`sort_order`),
  KEY `SPG_STORE_WEBSITE_DEFAULT_GROUP_ID` (`default_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Websites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_store_website`
--

LOCK TABLES `spg_store_website` WRITE;
/*!40000 ALTER TABLE `spg_store_website` DISABLE KEYS */;
INSERT INTO `spg_store_website` VALUES (0,'admin','Admin',0,0,0),(1,'base','Main Website',0,1,1);
/*!40000 ALTER TABLE `spg_store_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_support_backup`
--

DROP TABLE IF EXISTS `spg_support_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_support_backup` (
  `backup_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Backup ID',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Updated',
  `log` text COMMENT 'Log',
  PRIMARY KEY (`backup_id`),
  KEY `SPG_SUPPORT_BACKUP_STATUS` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Support System Backups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_support_backup`
--

LOCK TABLES `spg_support_backup` WRITE;
/*!40000 ALTER TABLE `spg_support_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_support_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_support_backup_item`
--

DROP TABLE IF EXISTS `spg_support_backup_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_support_backup_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  `type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Type',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Size',
  `backup_id` int(10) unsigned NOT NULL COMMENT 'Backup ID',
  PRIMARY KEY (`item_id`),
  KEY `SPG_SUPPORT_BACKUP_ITEM_STATUS` (`status`),
  KEY `SPG_SUPPORT_BACKUP_ITEM_TYPE` (`type`),
  KEY `SPG_SUPPORT_BACKUP_BACKUP_ID_SUPPORT_BACKUP_ITEM_BACKUP_ID` (`backup_id`),
  CONSTRAINT `SPG_SUPPORT_BACKUP_BACKUP_ID_SUPPORT_BACKUP_ITEM_BACKUP_ID` FOREIGN KEY (`backup_id`) REFERENCES `spg_support_backup` (`backup_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Support System Backup Items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_support_backup_item`
--

LOCK TABLES `spg_support_backup_item` WRITE;
/*!40000 ALTER TABLE `spg_support_backup_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_support_backup_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_support_report`
--

DROP TABLE IF EXISTS `spg_support_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_support_report` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `client_host` varchar(255) NOT NULL COMMENT 'Client Host',
  `magento_version` varchar(25) NOT NULL COMMENT 'Magento',
  `report_groups` text NOT NULL COMMENT 'Report Groups',
  `report_flags` text NOT NULL COMMENT 'Report Flags',
  `report_data` mediumtext NOT NULL COMMENT 'Report Data',
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Support System Reports';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_support_report`
--

LOCK TABLES `spg_support_report` WRITE;
/*!40000 ALTER TABLE `spg_support_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_support_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_tax_calculation`
--

DROP TABLE IF EXISTS `spg_tax_calculation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_tax_calculation` (
  `tax_calculation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `tax_calculation_rule_id` int(11) NOT NULL COMMENT 'Tax Calculation Rule Id',
  `customer_tax_class_id` smallint(6) NOT NULL COMMENT 'Customer Tax Class Id',
  `product_tax_class_id` smallint(6) NOT NULL COMMENT 'Product Tax Class Id',
  PRIMARY KEY (`tax_calculation_id`),
  KEY `SPG_TAX_CALCULATION_TAX_CALCULATION_RULE_ID` (`tax_calculation_rule_id`),
  KEY `SPG_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID` (`customer_tax_class_id`),
  KEY `SPG_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID` (`product_tax_class_id`),
  KEY `SPG_TAX_CALC_TAX_CALC_RATE_ID_CSTR_TAX_CLASS_ID_PRD_TAX_CLASS_ID` (`tax_calculation_rate_id`,`customer_tax_class_id`,`product_tax_class_id`),
  CONSTRAINT `SPG_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`customer_tax_class_id`) REFERENCES `spg_tax_class` (`class_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`product_tax_class_id`) REFERENCES `spg_tax_class` (`class_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_TAX_CALC_TAX_CALC_RATE_ID_TAX_CALC_RATE_TAX_CALC_RATE_ID` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `spg_tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_TAX_CALC_TAX_CALC_RULE_ID_TAX_CALC_RULE_TAX_CALC_RULE_ID` FOREIGN KEY (`tax_calculation_rule_id`) REFERENCES `spg_tax_calculation_rule` (`tax_calculation_rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_tax_calculation`
--

LOCK TABLES `spg_tax_calculation` WRITE;
/*!40000 ALTER TABLE `spg_tax_calculation` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_tax_calculation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_tax_calculation_rate`
--

DROP TABLE IF EXISTS `spg_tax_calculation_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_tax_calculation_rate` (
  `tax_calculation_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Id',
  `tax_country_id` varchar(2) NOT NULL COMMENT 'Tax Country Id',
  `tax_region_id` int(11) NOT NULL COMMENT 'Tax Region Id',
  `tax_postcode` varchar(21) DEFAULT NULL COMMENT 'Tax Postcode',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `rate` decimal(12,4) NOT NULL COMMENT 'Rate',
  `zip_is_range` smallint(6) DEFAULT NULL COMMENT 'Zip Is Range',
  `zip_from` int(10) unsigned DEFAULT NULL COMMENT 'Zip From',
  `zip_to` int(10) unsigned DEFAULT NULL COMMENT 'Zip To',
  PRIMARY KEY (`tax_calculation_rate_id`),
  KEY `SPG_TAX_CALC_RATE_TAX_COUNTRY_ID_TAX_REGION_ID_TAX_POSTCODE` (`tax_country_id`,`tax_region_id`,`tax_postcode`),
  KEY `SPG_TAX_CALCULATION_RATE_CODE` (`code`),
  KEY `IDX_B262036827336C3B02B8BA6E8F31AE03` (`tax_calculation_rate_id`,`tax_country_id`,`tax_region_id`,`zip_is_range`,`tax_postcode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_tax_calculation_rate`
--

LOCK TABLES `spg_tax_calculation_rate` WRITE;
/*!40000 ALTER TABLE `spg_tax_calculation_rate` DISABLE KEYS */;
INSERT INTO `spg_tax_calculation_rate` VALUES (1,'US',12,'*','US-CA-*-Rate 1',8.2500,NULL,NULL,NULL),(2,'US',43,'*','US-NY-*-Rate 1',8.3750,NULL,NULL,NULL);
/*!40000 ALTER TABLE `spg_tax_calculation_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_tax_calculation_rate_title`
--

DROP TABLE IF EXISTS `spg_tax_calculation_rate_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_tax_calculation_rate_title` (
  `tax_calculation_rate_title_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Title Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`tax_calculation_rate_title_id`),
  KEY `SPG_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID_STORE_ID` (`tax_calculation_rate_id`,`store_id`),
  KEY `SPG_TAX_CALCULATION_RATE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_43CF41D39D4FCDC4C1C547959966E4E1` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `spg_tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_TAX_CALCULATION_RATE_TITLE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate Title';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_tax_calculation_rate_title`
--

LOCK TABLES `spg_tax_calculation_rate_title` WRITE;
/*!40000 ALTER TABLE `spg_tax_calculation_rate_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_tax_calculation_rate_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_tax_calculation_rule`
--

DROP TABLE IF EXISTS `spg_tax_calculation_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_tax_calculation_rule` (
  `tax_calculation_rule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rule Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `calculate_subtotal` int(11) NOT NULL COMMENT 'Calculate off subtotal option',
  PRIMARY KEY (`tax_calculation_rule_id`),
  KEY `SPG_TAX_CALCULATION_RULE_PRIORITY_POSITION` (`priority`,`position`),
  KEY `SPG_TAX_CALCULATION_RULE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_tax_calculation_rule`
--

LOCK TABLES `spg_tax_calculation_rule` WRITE;
/*!40000 ALTER TABLE `spg_tax_calculation_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_tax_calculation_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_tax_class`
--

DROP TABLE IF EXISTS `spg_tax_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_tax_class` (
  `class_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Class Id',
  `class_name` varchar(255) NOT NULL COMMENT 'Class Name',
  `class_type` varchar(8) NOT NULL DEFAULT 'CUSTOMER' COMMENT 'Class Type',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Tax Class';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_tax_class`
--

LOCK TABLES `spg_tax_class` WRITE;
/*!40000 ALTER TABLE `spg_tax_class` DISABLE KEYS */;
INSERT INTO `spg_tax_class` VALUES (2,'Taxable Goods','PRODUCT'),(3,'Retail Customer','CUSTOMER');
/*!40000 ALTER TABLE `spg_tax_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_tax_order_aggregated_created`
--

DROP TABLE IF EXISTS `spg_tax_order_aggregated_created`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_tax_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_6A4E06EE79A82452FE98AF1B4B7D6D39` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `SPG_TAX_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_TAX_ORDER_AGGREGATED_CREATED_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_tax_order_aggregated_created`
--

LOCK TABLES `spg_tax_order_aggregated_created` WRITE;
/*!40000 ALTER TABLE `spg_tax_order_aggregated_created` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_tax_order_aggregated_created` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_tax_order_aggregated_updated`
--

DROP TABLE IF EXISTS `spg_tax_order_aggregated_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_tax_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_7355BD8F7DB346EDFDCA266C8B53DAAF` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `SPG_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID_SPG_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Spg Tax Order Aggregated Updated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_tax_order_aggregated_updated`
--

LOCK TABLES `spg_tax_order_aggregated_updated` WRITE;
/*!40000 ALTER TABLE `spg_tax_order_aggregated_updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_tax_order_aggregated_updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_theme`
--

DROP TABLE IF EXISTS `spg_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_theme` (
  `theme_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Theme identifier',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Parent Id',
  `theme_path` varchar(255) DEFAULT NULL COMMENT 'Theme Path',
  `theme_title` varchar(255) NOT NULL COMMENT 'Theme Title',
  `preview_image` varchar(255) DEFAULT NULL COMMENT 'Preview Image',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is Theme Featured',
  `area` varchar(255) NOT NULL COMMENT 'Theme Area',
  `type` smallint(6) NOT NULL COMMENT 'Theme type: 0:physical, 1:virtual, 2:staging',
  `code` text COMMENT 'Full theme code, including package',
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Core theme';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_theme`
--

LOCK TABLES `spg_theme` WRITE;
/*!40000 ALTER TABLE `spg_theme` DISABLE KEYS */;
INSERT INTO `spg_theme` VALUES (1,NULL,'Magento/blank','Magento Blank','preview_image_5894359c7cc82.jpeg',0,'frontend',0,'Magento/blank'),(2,1,'Magento/luma','Magento Luma','preview_image_5894359c884e2.jpeg',0,'frontend',0,'Magento/luma'),(3,NULL,'Magento/backend','Magento 2 backend',NULL,0,'adminhtml',0,'Magento/backend'),(4,1,'SPG/newage','SPG NewAge','preview_image_58944f611b590.jpeg',0,'frontend',0,'SPG/newage');
/*!40000 ALTER TABLE `spg_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_theme_file`
--

DROP TABLE IF EXISTS `spg_theme_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_theme_file` (
  `theme_files_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Theme files identifier',
  `theme_id` int(10) unsigned NOT NULL COMMENT 'Theme Id',
  `file_path` varchar(255) DEFAULT NULL COMMENT 'Relative path to file',
  `file_type` varchar(32) NOT NULL COMMENT 'File Type',
  `content` longtext NOT NULL COMMENT 'File Content',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `is_temporary` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is Temporary File',
  PRIMARY KEY (`theme_files_id`),
  KEY `SPG_THEME_FILE_THEME_ID_THEME_THEME_ID` (`theme_id`),
  CONSTRAINT `SPG_THEME_FILE_THEME_ID_THEME_THEME_ID` FOREIGN KEY (`theme_id`) REFERENCES `spg_theme` (`theme_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Core theme files';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_theme_file`
--

LOCK TABLES `spg_theme_file` WRITE;
/*!40000 ALTER TABLE `spg_theme_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_theme_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_translation`
--

DROP TABLE IF EXISTS `spg_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_translation` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Key Id of Translation',
  `string` varchar(255) NOT NULL DEFAULT 'Translate String' COMMENT 'Translation String',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `translate` varchar(255) DEFAULT NULL COMMENT 'Translate',
  `locale` varchar(20) NOT NULL DEFAULT 'en_US' COMMENT 'Locale',
  `crc_string` bigint(20) NOT NULL DEFAULT '1591228201' COMMENT 'Translation String CRC32 Hash',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `SPG_TRANSLATION_STORE_ID_LOCALE_CRC_STRING_STRING` (`store_id`,`locale`,`crc_string`,`string`),
  CONSTRAINT `SPG_TRANSLATION_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_translation`
--

LOCK TABLES `spg_translation` WRITE;
/*!40000 ALTER TABLE `spg_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_ui_bookmark`
--

DROP TABLE IF EXISTS `spg_ui_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_ui_bookmark` (
  `bookmark_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Bookmark identifier',
  `user_id` int(10) unsigned NOT NULL COMMENT 'User Id',
  `namespace` varchar(255) NOT NULL COMMENT 'Bookmark namespace',
  `identifier` varchar(255) NOT NULL COMMENT 'Bookmark Identifier',
  `current` smallint(6) NOT NULL COMMENT 'Mark current bookmark per user and identifier',
  `title` varchar(255) DEFAULT NULL COMMENT 'Bookmark title',
  `config` longtext COMMENT 'Bookmark config',
  `created_at` datetime NOT NULL COMMENT 'Bookmark created at',
  `updated_at` datetime NOT NULL COMMENT 'Bookmark updated at',
  PRIMARY KEY (`bookmark_id`),
  KEY `SPG_UI_BOOKMARK_USER_ID_NAMESPACE_IDENTIFIER` (`user_id`,`namespace`,`identifier`),
  CONSTRAINT `SPG_UI_BOOKMARK_USER_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `spg_admin_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Bookmark';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_ui_bookmark`
--

LOCK TABLES `spg_ui_bookmark` WRITE;
/*!40000 ALTER TABLE `spg_ui_bookmark` DISABLE KEYS */;
INSERT INTO `spg_ui_bookmark` VALUES (1,1,'product_listing','default',1,'Default View','{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"entity_id\":{\"visible\":true,\"sorting\":\"asc\"},\"name\":{\"visible\":true,\"sorting\":false},\"sku\":{\"visible\":true,\"sorting\":false},\"price\":{\"visible\":true,\"sorting\":false},\"websites\":{\"visible\":true,\"sorting\":false},\"qty\":{\"visible\":true,\"sorting\":false},\"short_description\":{\"visible\":false,\"sorting\":false},\"special_price\":{\"visible\":false,\"sorting\":false},\"cost\":{\"visible\":false,\"sorting\":false},\"weight\":{\"visible\":false,\"sorting\":false},\"meta_title\":{\"visible\":false,\"sorting\":false},\"meta_keyword\":{\"visible\":false,\"sorting\":false},\"meta_description\":{\"visible\":false,\"sorting\":false},\"url_key\":{\"visible\":false,\"sorting\":false},\"msrp\":{\"visible\":false,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"type_id\":{\"visible\":true,\"sorting\":false},\"attribute_set_id\":{\"visible\":true,\"sorting\":false},\"visibility\":{\"visible\":true,\"sorting\":false},\"status\":{\"visible\":true,\"sorting\":false},\"manufacturer\":{\"visible\":false,\"sorting\":false},\"color\":{\"visible\":false,\"sorting\":false},\"custom_design\":{\"visible\":false,\"sorting\":false},\"page_layout\":{\"visible\":false,\"sorting\":false},\"country_of_manufacture\":{\"visible\":false,\"sorting\":false},\"custom_layout\":{\"visible\":false,\"sorting\":false},\"tax_class_id\":{\"visible\":false,\"sorting\":false},\"gift_message_available\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"thumbnail\":{\"visible\":true,\"sorting\":false},\"special_from_date\":{\"visible\":false,\"sorting\":false},\"special_to_date\":{\"visible\":false,\"sorting\":false},\"news_from_date\":{\"visible\":false,\"sorting\":false},\"news_to_date\":{\"visible\":false,\"sorting\":false},\"custom_design_from\":{\"visible\":false,\"sorting\":false},\"custom_design_to\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"positions\":{\"ids\":0,\"entity_id\":1,\"thumbnail\":2,\"name\":3,\"type_id\":4,\"attribute_set_id\":5,\"sku\":6,\"price\":7,\"qty\":8,\"visibility\":9,\"status\":10,\"websites\":11,\"short_description\":12,\"special_price\":13,\"special_from_date\":14,\"special_to_date\":15,\"cost\":16,\"weight\":17,\"manufacturer\":18,\"meta_title\":19,\"meta_keyword\":20,\"meta_description\":21,\"color\":22,\"news_from_date\":23,\"news_to_date\":24,\"custom_design\":25,\"custom_design_from\":26,\"custom_design_to\":27,\"page_layout\":28,\"country_of_manufacture\":29,\"custom_layout\":30,\"url_key\":31,\"msrp\":32,\"tax_class_id\":33,\"gift_message_available\":34,\"actions\":35},\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20}},\"value\":\"Default View\"}}}','0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,1,'product_listing','current',0,NULL,'{\"current\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"entity_id\":{\"visible\":true,\"sorting\":\"asc\"},\"name\":{\"visible\":true,\"sorting\":false},\"sku\":{\"visible\":true,\"sorting\":false},\"price\":{\"visible\":true,\"sorting\":false},\"websites\":{\"visible\":true,\"sorting\":false},\"qty\":{\"visible\":true,\"sorting\":false},\"short_description\":{\"visible\":false,\"sorting\":false},\"special_price\":{\"visible\":false,\"sorting\":false},\"cost\":{\"visible\":false,\"sorting\":false},\"weight\":{\"visible\":false,\"sorting\":false},\"meta_title\":{\"visible\":false,\"sorting\":false},\"meta_keyword\":{\"visible\":false,\"sorting\":false},\"meta_description\":{\"visible\":false,\"sorting\":false},\"url_key\":{\"visible\":false,\"sorting\":false},\"msrp\":{\"visible\":false,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"type_id\":{\"visible\":true,\"sorting\":false},\"attribute_set_id\":{\"visible\":true,\"sorting\":false},\"visibility\":{\"visible\":true,\"sorting\":false},\"status\":{\"visible\":true,\"sorting\":false},\"manufacturer\":{\"visible\":false,\"sorting\":false},\"color\":{\"visible\":false,\"sorting\":false},\"custom_design\":{\"visible\":false,\"sorting\":false},\"page_layout\":{\"visible\":false,\"sorting\":false},\"country_of_manufacture\":{\"visible\":false,\"sorting\":false},\"custom_layout\":{\"visible\":false,\"sorting\":false},\"tax_class_id\":{\"visible\":false,\"sorting\":false},\"gift_message_available\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"thumbnail\":{\"visible\":true,\"sorting\":false},\"special_from_date\":{\"visible\":false,\"sorting\":false},\"special_to_date\":{\"visible\":false,\"sorting\":false},\"news_from_date\":{\"visible\":false,\"sorting\":false},\"news_to_date\":{\"visible\":false,\"sorting\":false},\"custom_design_from\":{\"visible\":false,\"sorting\":false},\"custom_design_to\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"positions\":{\"ids\":0,\"entity_id\":1,\"thumbnail\":2,\"name\":3,\"type_id\":4,\"attribute_set_id\":5,\"sku\":6,\"price\":7,\"qty\":8,\"visibility\":9,\"status\":10,\"websites\":11,\"short_description\":12,\"special_price\":13,\"special_from_date\":14,\"special_to_date\":15,\"cost\":16,\"weight\":17,\"manufacturer\":18,\"meta_title\":19,\"meta_keyword\":20,\"meta_description\":21,\"color\":22,\"news_from_date\":23,\"news_to_date\":24,\"custom_design\":25,\"custom_design_from\":26,\"custom_design_to\":27,\"page_layout\":28,\"country_of_manufacture\":29,\"custom_layout\":30,\"url_key\":31,\"msrp\":32,\"tax_class_id\":33,\"gift_message_available\":34,\"actions\":35},\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20}}}','0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,1,'design_config_listing','default',1,'Default View','{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"default\":{\"visible\":true,\"sorting\":false},\"store_website_id\":{\"visible\":true,\"sorting\":false},\"store_group_id\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"theme_theme_id\":{\"visible\":true,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"default\":0,\"store_website_id\":1,\"store_group_id\":2,\"store_id\":3,\"theme_theme_id\":4,\"actions\":5}},\"value\":\"Default View\"}}}','0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,1,'design_config_listing','current',0,NULL,'{\"current\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"default\":{\"visible\":true,\"sorting\":false},\"store_website_id\":{\"visible\":true,\"sorting\":false},\"store_group_id\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"theme_theme_id\":{\"visible\":true,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"default\":0,\"store_website_id\":1,\"store_group_id\":2,\"store_id\":3,\"theme_theme_id\":4,\"actions\":5}}}','0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,1,'cms_block_listing','default',1,'Default View','{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"search\":{\"value\":\"\"},\"columns\":{\"block_id\":{\"visible\":true,\"sorting\":\"asc\"},\"title\":{\"visible\":true,\"sorting\":false},\"identifier\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"is_active\":{\"visible\":true,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"creation_time\":{\"visible\":true,\"sorting\":false},\"update_time\":{\"visible\":true,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"block_id\":1,\"title\":2,\"identifier\":3,\"store_id\":4,\"is_active\":5,\"creation_time\":6,\"update_time\":7,\"actions\":8}},\"value\":\"Default View\"}}}','0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,1,'cms_block_listing','current',0,NULL,'{\"current\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"search\":{\"value\":\"\"},\"columns\":{\"block_id\":{\"visible\":true,\"sorting\":\"asc\"},\"title\":{\"visible\":true,\"sorting\":false},\"identifier\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"is_active\":{\"visible\":true,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"creation_time\":{\"visible\":true,\"sorting\":false},\"update_time\":{\"visible\":true,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"block_id\":1,\"title\":2,\"identifier\":3,\"store_id\":4,\"is_active\":5,\"creation_time\":6,\"update_time\":7,\"actions\":8}}}','0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,1,'cms_page_listing','default',1,'Default View','{\"views\":{\"default\":{\"label\":\"Default View\",\"index\":\"default\",\"editable\":false,\"data\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"page_id\":{\"visible\":true,\"sorting\":\"asc\"},\"title\":{\"visible\":true,\"sorting\":false},\"identifier\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"meta_title\":{\"visible\":false,\"sorting\":false},\"meta_keywords\":{\"visible\":false,\"sorting\":false},\"meta_description\":{\"visible\":false,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"page_layout\":{\"visible\":true,\"sorting\":false},\"is_active\":{\"visible\":true,\"sorting\":false},\"custom_theme\":{\"visible\":false,\"sorting\":false},\"custom_root_template\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"creation_time\":{\"visible\":true,\"sorting\":false},\"update_time\":{\"visible\":true,\"sorting\":false},\"custom_theme_from\":{\"visible\":false,\"sorting\":false},\"custom_theme_to\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"page_id\":1,\"title\":2,\"identifier\":3,\"page_layout\":4,\"store_id\":5,\"is_active\":6,\"creation_time\":7,\"update_time\":8,\"custom_theme_from\":9,\"custom_theme_to\":10,\"custom_theme\":11,\"custom_root_template\":12,\"meta_title\":13,\"meta_keywords\":14,\"meta_description\":15,\"actions\":16},\"search\":{\"value\":\"\"}},\"value\":\"Default View\"}}}','0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,1,'cms_page_listing','current',0,NULL,'{\"current\":{\"filters\":{\"applied\":{\"placeholder\":true}},\"columns\":{\"page_id\":{\"visible\":true,\"sorting\":\"asc\"},\"title\":{\"visible\":true,\"sorting\":false},\"identifier\":{\"visible\":true,\"sorting\":false},\"store_id\":{\"visible\":true,\"sorting\":false},\"meta_title\":{\"visible\":false,\"sorting\":false},\"meta_keywords\":{\"visible\":false,\"sorting\":false},\"meta_description\":{\"visible\":false,\"sorting\":false},\"ids\":{\"visible\":true,\"sorting\":false},\"page_layout\":{\"visible\":true,\"sorting\":false},\"is_active\":{\"visible\":true,\"sorting\":false},\"custom_theme\":{\"visible\":false,\"sorting\":false},\"custom_root_template\":{\"visible\":false,\"sorting\":false},\"actions\":{\"visible\":true,\"sorting\":false},\"creation_time\":{\"visible\":true,\"sorting\":false},\"update_time\":{\"visible\":true,\"sorting\":false},\"custom_theme_from\":{\"visible\":false,\"sorting\":false},\"custom_theme_to\":{\"visible\":false,\"sorting\":false}},\"displayMode\":\"grid\",\"paging\":{\"options\":{\"20\":{\"value\":20,\"label\":20},\"30\":{\"value\":30,\"label\":30},\"50\":{\"value\":50,\"label\":50},\"100\":{\"value\":100,\"label\":100},\"200\":{\"value\":200,\"label\":200}},\"value\":20},\"positions\":{\"ids\":0,\"page_id\":1,\"title\":2,\"identifier\":3,\"page_layout\":4,\"store_id\":5,\"is_active\":6,\"creation_time\":7,\"update_time\":8,\"custom_theme_from\":9,\"custom_theme_to\":10,\"custom_theme\":11,\"custom_root_template\":12,\"meta_title\":13,\"meta_keywords\":14,\"meta_description\":15,\"actions\":16},\"search\":{\"value\":\"\"}}}','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `spg_ui_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_url_rewrite`
--

DROP TABLE IF EXISTS `spg_url_rewrite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_url_rewrite` (
  `url_rewrite_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rewrite Id',
  `entity_type` varchar(32) NOT NULL COMMENT 'Entity type code',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `request_path` varchar(255) DEFAULT NULL COMMENT 'Request Path',
  `target_path` varchar(255) DEFAULT NULL COMMENT 'Target Path',
  `redirect_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Redirect Type',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description',
  `is_autogenerated` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is rewrite generated automatically flag',
  `metadata` varchar(255) DEFAULT NULL COMMENT 'Meta data for url rewrite',
  PRIMARY KEY (`url_rewrite_id`),
  UNIQUE KEY `SPG_URL_REWRITE_REQUEST_PATH_STORE_ID` (`request_path`,`store_id`),
  KEY `SPG_URL_REWRITE_TARGET_PATH` (`target_path`),
  KEY `SPG_URL_REWRITE_STORE_ID_ENTITY_ID` (`store_id`,`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='Url Rewrites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_url_rewrite`
--

LOCK TABLES `spg_url_rewrite` WRITE;
/*!40000 ALTER TABLE `spg_url_rewrite` DISABLE KEYS */;
INSERT INTO `spg_url_rewrite` VALUES (1,'cms-page',1,'no-route','cms/page/view/page_id/1',0,1,NULL,1,NULL),(2,'cms-page',2,'home','cms/page/view/page_id/2',0,1,NULL,1,NULL),(3,'cms-page',3,'enable-cookies','cms/page/view/page_id/3',0,1,NULL,1,NULL),(4,'cms-page',4,'privacy-policy-cookie-restriction-mode','cms/page/view/page_id/4',0,1,NULL,1,NULL),(5,'cms-page',5,'service-unavailable','cms/page/view/page_id/5',0,1,NULL,1,NULL),(6,'cms-page',6,'private-sales','cms/page/view/page_id/6',0,1,NULL,1,NULL),(7,'cms-page',7,'reward-points','cms/page/view/page_id/7',0,1,NULL,1,NULL),(8,'category',3,'ao.html','catalog/category/view/id/3',0,1,NULL,1,NULL),(10,'category',5,'giay.html','catalog/category/view/id/5',0,1,NULL,1,NULL),(11,'category',6,'qu-n.html','catalog/category/view/id/6',0,1,NULL,1,NULL),(12,'category',7,'set.html','catalog/category/view/id/7',0,1,NULL,1,NULL),(13,'category',8,'d-m.html','catalog/category/view/id/8',0,1,NULL,1,NULL),(14,'category',9,'chan-vay.html','catalog/category/view/id/9',0,1,NULL,1,NULL),(15,'category',10,'ao/ao-croptop.html','catalog/category/view/id/10',0,1,NULL,1,NULL),(16,'category',11,'ao/ao-khoac.html','catalog/category/view/id/11',0,1,NULL,1,NULL),(17,'category',12,'ao/ao-so-mi.html','catalog/category/view/id/12',0,1,NULL,1,NULL),(18,'category',13,'ao/ao-thi-t-k.html','catalog/category/view/id/13',0,1,NULL,1,NULL),(19,'category',14,'ao/ao-thun.html','catalog/category/view/id/14',0,1,NULL,1,NULL),(20,'category',15,'giay/dep.html','catalog/category/view/id/15',0,1,NULL,1,NULL),(21,'category',16,'giay/giay-bup-be-zara-vnxk.html','catalog/category/view/id/16',0,1,NULL,1,NULL),(22,'category',17,'giay/sandal.html','catalog/category/view/id/17',0,1,NULL,1,NULL),(23,'category',18,'qu-n/qu-n-baggy.html','catalog/category/view/id/18',0,1,NULL,1,NULL),(24,'category',19,'qu-n/qu-n-baggy/baggy-jeans-tron.html','catalog/category/view/id/19',0,1,NULL,1,NULL),(25,'category',20,'qu-n/qu-n-baggy/baggy-rach-jeans.html','catalog/category/view/id/20',0,1,NULL,1,NULL),(26,'category',21,'qu-n/qu-n-baggy/baggy-v-i.html','catalog/category/view/id/21',0,1,NULL,1,NULL),(27,'category',22,'qu-n/qu-n-jeans-rach-g-i.html','catalog/category/view/id/22',0,1,NULL,1,NULL),(28,'category',23,'qu-n/qu-n-ki-u.html','catalog/category/view/id/23',0,1,NULL,1,NULL),(29,'category',24,'qu-n/qu-n-legging.html','catalog/category/view/id/24',0,1,NULL,1,NULL),(30,'category',25,'qu-n/qu-n-vay.html','catalog/category/view/id/25',0,1,NULL,1,NULL),(31,'category',26,'qu-n/short-jeans.html','catalog/category/view/id/26',0,1,NULL,1,NULL),(32,'category',27,'set/ao-qu-n.html','catalog/category/view/id/27',0,1,NULL,1,NULL),(33,'category',28,'set/ao-qu-n-vay.html','catalog/category/view/id/28',0,1,NULL,1,NULL),(34,'category',29,'set/ao-vay.html','catalog/category/view/id/29',0,1,NULL,1,NULL),(35,'category',30,'set/jump.html','catalog/category/view/id/30',0,1,NULL,1,NULL),(36,'category',31,'d-m/d-m-qc-tl.html','catalog/category/view/id/31',0,1,NULL,1,NULL),(37,'category',32,'d-m/d-m-thi-t-k.html','catalog/category/view/id/32',0,1,NULL,1,NULL),(38,'category',33,'ph-ki-n.html','catalog/category/view/id/33',0,1,NULL,1,NULL),(39,'category',34,'chan-vay/but-chi.html','catalog/category/view/id/34',0,1,NULL,1,NULL),(40,'category',35,'chan-vay/ki-u.html','catalog/category/view/id/35',0,1,NULL,1,NULL),(41,'category',36,'chan-vay/midi-khong-x.html','catalog/category/view/id/36',0,1,NULL,1,NULL),(42,'category',37,'chan-vay/midi-x-tru-c.html','catalog/category/view/id/37',0,1,NULL,1,NULL),(43,'category',38,'chan-vay/yoko.html','catalog/category/view/id/38',0,1,NULL,1,NULL);
/*!40000 ALTER TABLE `spg_url_rewrite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_variable`
--

DROP TABLE IF EXISTS `spg_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_variable` (
  `variable_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Variable Code',
  `name` varchar(255) DEFAULT NULL COMMENT 'Variable Name',
  PRIMARY KEY (`variable_id`),
  UNIQUE KEY `SPG_VARIABLE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_variable`
--

LOCK TABLES `spg_variable` WRITE;
/*!40000 ALTER TABLE `spg_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_variable_value`
--

DROP TABLE IF EXISTS `spg_variable_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_variable_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Value Id',
  `variable_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Variable Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `plain_value` text COMMENT 'Plain Text Value',
  `html_value` text COMMENT 'Html Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `SPG_VARIABLE_VALUE_VARIABLE_ID_STORE_ID` (`variable_id`,`store_id`),
  KEY `SPG_VARIABLE_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_VARIABLE_VALUE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_VARIABLE_VALUE_VARIABLE_ID_VARIABLE_VARIABLE_ID` FOREIGN KEY (`variable_id`) REFERENCES `spg_variable` (`variable_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_variable_value`
--

LOCK TABLES `spg_variable_value` WRITE;
/*!40000 ALTER TABLE `spg_variable_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_variable_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_vault_payment_token`
--

DROP TABLE IF EXISTS `spg_vault_payment_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_vault_payment_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `public_hash` varchar(128) NOT NULL COMMENT 'Hash code for using on frontend',
  `payment_method_code` varchar(128) NOT NULL COMMENT 'Payment method code',
  `type` varchar(128) NOT NULL COMMENT 'Type',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT 'Expires At',
  `gateway_token` varchar(255) NOT NULL COMMENT 'Gateway Token',
  `details` text COMMENT 'Details',
  `is_active` tinyint(1) NOT NULL COMMENT 'Is active flag',
  `is_visible` tinyint(1) NOT NULL COMMENT 'Is visible flag',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `SPG_VAULT_PAYMENT_TOKEN_HASH_UNIQUE_INDEX_PUBLIC_HASH` (`public_hash`),
  UNIQUE KEY `UNQ_9712109D510FD353C4860E2A519A3B83` (`payment_method_code`,`customer_id`,`gateway_token`),
  KEY `SPG_VAULT_PAYMENT_TOKEN_CSTR_ID_SPG_CSTR_ENTT_ENTT_ID` (`customer_id`),
  CONSTRAINT `SPG_VAULT_PAYMENT_TOKEN_CSTR_ID_SPG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Vault tokens of payment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_vault_payment_token`
--

LOCK TABLES `spg_vault_payment_token` WRITE;
/*!40000 ALTER TABLE `spg_vault_payment_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_vault_payment_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_vault_payment_token_order_payment_link`
--

DROP TABLE IF EXISTS `spg_vault_payment_token_order_payment_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_vault_payment_token_order_payment_link` (
  `order_payment_id` int(10) unsigned NOT NULL COMMENT 'Order payment Id',
  `payment_token_id` int(10) unsigned NOT NULL COMMENT 'Payment token Id',
  PRIMARY KEY (`order_payment_id`,`payment_token_id`),
  KEY `FK_329B059C135A185574B3E17E409D9E86` (`payment_token_id`),
  CONSTRAINT `FK_329B059C135A185574B3E17E409D9E86` FOREIGN KEY (`payment_token_id`) REFERENCES `spg_vault_payment_token` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_9FCFB8FE9D68B77BB56CB11D9FEC1CC6` FOREIGN KEY (`order_payment_id`) REFERENCES `spg_sales_order_payment` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Order payments to vault token';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_vault_payment_token_order_payment_link`
--

LOCK TABLES `spg_vault_payment_token_order_payment_link` WRITE;
/*!40000 ALTER TABLE `spg_vault_payment_token_order_payment_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_vault_payment_token_order_payment_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_visual_merchandiser_rule`
--

DROP TABLE IF EXISTS `spg_visual_merchandiser_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_visual_merchandiser_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  PRIMARY KEY (`rule_id`),
  UNIQUE KEY `SPG_VISUAL_MERCHANDISER_RULE_CATEGORY_ID_STORE_ID` (`category_id`,`store_id`),
  KEY `SPG_VISUAL_MERCHANDISER_RULE_CATEGORY_ID` (`category_id`),
  KEY `SPG_VISUAL_MERCHANDISER_RULE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_BA974CC4E51DB77AC7C10B0C1C117CB9` FOREIGN KEY (`category_id`) REFERENCES `spg_sequence_catalog_category` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_VISUAL_MERCHANDISER_RULE_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='VisualMerchandiser Rules Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_visual_merchandiser_rule`
--

LOCK TABLES `spg_visual_merchandiser_rule` WRITE;
/*!40000 ALTER TABLE `spg_visual_merchandiser_rule` DISABLE KEYS */;
INSERT INTO `spg_visual_merchandiser_rule` VALUES (1,2,0,0,NULL),(2,6,0,0,NULL);
/*!40000 ALTER TABLE `spg_visual_merchandiser_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_weee_tax`
--

DROP TABLE IF EXISTS `spg_weee_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_weee_tax` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `country` varchar(2) DEFAULT NULL COMMENT 'Country',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT 'State',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`value_id`),
  KEY `SPG_WEEE_TAX_WEBSITE_ID` (`website_id`),
  KEY `SPG_WEEE_TAX_ENTITY_ID` (`entity_id`),
  KEY `SPG_WEEE_TAX_COUNTRY` (`country`),
  KEY `SPG_WEEE_TAX_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `SPG_WEEE_TAX_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `spg_eav_attribute` (`attribute_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_WEEE_TAX_COUNTRY_DIRECTORY_COUNTRY_COUNTRY_ID` FOREIGN KEY (`country`) REFERENCES `spg_directory_country` (`country_id`) ON DELETE CASCADE,
  CONSTRAINT `SPG_WEEE_TAX_ENTITY_ID_SPG_SEQUENCE_PRODUCT_SEQUENCE_VALUE` FOREIGN KEY (`entity_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_WEEE_TAX_WEBSITE_ID_STORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `spg_store_website` (`website_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Tax';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_weee_tax`
--

LOCK TABLES `spg_weee_tax` WRITE;
/*!40000 ALTER TABLE `spg_weee_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_weee_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_widget`
--

DROP TABLE IF EXISTS `spg_widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Widget Id',
  `widget_code` varchar(255) DEFAULT NULL COMMENT 'Widget code for template directive',
  `widget_type` varchar(255) DEFAULT NULL COMMENT 'Widget Type',
  `parameters` text COMMENT 'Parameters',
  PRIMARY KEY (`widget_id`),
  KEY `SPG_WIDGET_WIDGET_CODE` (`widget_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preconfigured Widgets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_widget`
--

LOCK TABLES `spg_widget` WRITE;
/*!40000 ALTER TABLE `spg_widget` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_widget_instance`
--

DROP TABLE IF EXISTS `spg_widget_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_widget_instance` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Instance Id',
  `instance_type` varchar(255) DEFAULT NULL COMMENT 'Instance Type',
  `theme_id` int(10) unsigned NOT NULL COMMENT 'Theme id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Widget Title',
  `store_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Store ids',
  `widget_parameters` text COMMENT 'Widget parameters',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  PRIMARY KEY (`instance_id`),
  KEY `SPG_WIDGET_INSTANCE_THEME_ID_THEME_THEME_ID` (`theme_id`),
  CONSTRAINT `SPG_WIDGET_INSTANCE_THEME_ID_THEME_THEME_ID` FOREIGN KEY (`theme_id`) REFERENCES `spg_theme` (`theme_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instances of Widget for Package Theme';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_widget_instance`
--

LOCK TABLES `spg_widget_instance` WRITE;
/*!40000 ALTER TABLE `spg_widget_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_widget_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_widget_instance_page`
--

DROP TABLE IF EXISTS `spg_widget_instance_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_widget_instance_page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Page Id',
  `instance_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Id',
  `page_group` varchar(25) DEFAULT NULL COMMENT 'Block Group Type',
  `layout_handle` varchar(255) DEFAULT NULL COMMENT 'Layout Handle',
  `block_reference` varchar(255) DEFAULT NULL COMMENT 'Container',
  `page_for` varchar(25) DEFAULT NULL COMMENT 'For instance entities',
  `entities` text COMMENT 'Catalog entities (comma separated)',
  `page_template` varchar(255) DEFAULT NULL COMMENT 'Path to widget template',
  PRIMARY KEY (`page_id`),
  KEY `SPG_WIDGET_INSTANCE_PAGE_INSTANCE_ID` (`instance_id`),
  CONSTRAINT `SPG_WIDGET_INSTANCE_PAGE_INSTANCE_ID_WIDGET_INSTANCE_INSTANCE_ID` FOREIGN KEY (`instance_id`) REFERENCES `spg_widget_instance` (`instance_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instance of Widget on Page';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_widget_instance_page`
--

LOCK TABLES `spg_widget_instance_page` WRITE;
/*!40000 ALTER TABLE `spg_widget_instance_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_widget_instance_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_widget_instance_page_layout`
--

DROP TABLE IF EXISTS `spg_widget_instance_page_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_widget_instance_page_layout` (
  `page_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Page Id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  UNIQUE KEY `SPG_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID_PAGE_ID` (`layout_update_id`,`page_id`),
  KEY `SPG_WIDGET_INSTANCE_PAGE_LAYOUT_PAGE_ID` (`page_id`),
  CONSTRAINT `FK_71FCED6BF36D535DC0AD6FF90D580D65` FOREIGN KEY (`layout_update_id`) REFERENCES `spg_layout_update` (`layout_update_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F31E87B0F740A01FC42FCD48F5696513` FOREIGN KEY (`page_id`) REFERENCES `spg_widget_instance_page` (`page_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout updates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_widget_instance_page_layout`
--

LOCK TABLES `spg_widget_instance_page_layout` WRITE;
/*!40000 ALTER TABLE `spg_widget_instance_page_layout` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_widget_instance_page_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_wishlist`
--

DROP TABLE IF EXISTS `spg_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_wishlist` (
  `wishlist_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist ID',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `shared` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sharing flag (0 or 1)',
  `sharing_code` varchar(32) DEFAULT NULL COMMENT 'Sharing encrypted code',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Last updated date',
  `name` varchar(255) DEFAULT NULL COMMENT 'Wish List Name',
  `visibility` smallint(6) DEFAULT '0' COMMENT 'Wish List visibility type',
  PRIMARY KEY (`wishlist_id`),
  KEY `SPG_WISHLIST_SHARED` (`shared`),
  KEY `SPG_WISHLIST_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `SPG_WISHLIST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `spg_customer_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist main Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_wishlist`
--

LOCK TABLES `spg_wishlist` WRITE;
/*!40000 ALTER TABLE `spg_wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_wishlist_item`
--

DROP TABLE IF EXISTS `spg_wishlist_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_wishlist_item` (
  `wishlist_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist item ID',
  `wishlist_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Wishlist ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Add date and time',
  `description` text COMMENT 'Short description of wish list item',
  `qty` decimal(12,4) NOT NULL COMMENT 'Qty',
  PRIMARY KEY (`wishlist_item_id`),
  KEY `SPG_WISHLIST_ITEM_WISHLIST_ID` (`wishlist_id`),
  KEY `SPG_WISHLIST_ITEM_PRODUCT_ID` (`product_id`),
  KEY `SPG_WISHLIST_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `SPG_WISHLIST_ITEM_PRODUCT_ID_SPG_SEQUENCE_PRODUCT_SEQUENCE_VALUE` FOREIGN KEY (`product_id`) REFERENCES `spg_sequence_product` (`sequence_value`) ON DELETE CASCADE,
  CONSTRAINT `SPG_WISHLIST_ITEM_STORE_ID_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `spg_store` (`store_id`) ON DELETE SET NULL,
  CONSTRAINT `SPG_WISHLIST_ITEM_WISHLIST_ID_WISHLIST_WISHLIST_ID` FOREIGN KEY (`wishlist_id`) REFERENCES `spg_wishlist` (`wishlist_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_wishlist_item`
--

LOCK TABLES `spg_wishlist_item` WRITE;
/*!40000 ALTER TABLE `spg_wishlist_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_wishlist_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spg_wishlist_item_option`
--

DROP TABLE IF EXISTS `spg_wishlist_item_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spg_wishlist_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `wishlist_item_id` int(10) unsigned NOT NULL COMMENT 'Wishlist Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `FK_1B2278997CC968CA4A124AC1E1B22B8F` (`wishlist_item_id`),
  CONSTRAINT `FK_1B2278997CC968CA4A124AC1E1B22B8F` FOREIGN KEY (`wishlist_item_id`) REFERENCES `spg_wishlist_item` (`wishlist_item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist Item Option Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spg_wishlist_item_option`
--

LOCK TABLES `spg_wishlist_item_option` WRITE;
/*!40000 ALTER TABLE `spg_wishlist_item_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `spg_wishlist_item_option` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-03 17:48:58