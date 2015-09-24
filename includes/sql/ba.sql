/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`ba` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `ba`;

/*Table structure for table `article_comments` */

DROP TABLE IF EXISTS `article_comments`;

CREATE TABLE `article_comments` (
  `article_id` binary(16) NOT NULL,
  `comment_id` binary(16) NOT NULL,
  PRIMARY KEY (`article_id`,`comment_id`),
  KEY `FK_article_comments_2` (`comment_id`),
  CONSTRAINT `FK_article_comments_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_article_comments_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `article_comments` */

/*Table structure for table `article_users` */

DROP TABLE IF EXISTS `article_users`;

CREATE TABLE `article_users` (
  `article_id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`article_id`,`user_id`),
  KEY `FK_article_users2` (`user_id`),
  CONSTRAINT `FK_article_users2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_article_users1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `article_users` */

/*Table structure for table `articles` */

DROP TABLE IF EXISTS `articles`;

CREATE TABLE `articles` (
  `article_id` binary(16) NOT NULL,
  `article_title` varchar(256) NOT NULL,
  `article_author` varchar(64) NOT NULL,
  `article_cover_image_ref` varchar(256) DEFAULT NULL,
  `article_brief` varchar(512) NOT NULL,
  `article_url` varchar(256) NOT NULL,
  `article_tag` varchar(256) NOT NULL COMMENT 'comma seperated keywords',
  `article_consultant_id` varbinary(16) DEFAULT NULL COMMENT 'foreign key reference to consultants'' consultant id',
  `article_create_time` datetime NOT NULL,
  `article_update_time` datetime DEFAULT NULL COMMENT 'set as created time when article is created',
  PRIMARY KEY (`article_id`),
  KEY `article_consultant_id` (`article_consultant_id`),
  KEY `article_create_time` (`article_create_time`),
  CONSTRAINT `FK_articles_consultants` FOREIGN KEY (`article_consultant_id`) REFERENCES `consultants` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `articles` */

/*Table structure for table `comments` */

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `comment_id` varbinary(16) NOT NULL,
  `comment_user_id` varbinary(16) NOT NULL,
  `comment_content` varchar(1024) NOT NULL,
  `comment_create_time` datetime NOT NULL,
  `comment_update_time` datetime DEFAULT NULL,
  `comment_parent_comment_id` varbinary(16) NOT NULL COMMENT 'it''s parent commment id to have list model',
  PRIMARY KEY (`comment_id`),
  KEY `FK_comments_users` (`comment_user_id`),
  KEY `FK_comments` (`comment_parent_comment_id`),
  CONSTRAINT `FK_comments` FOREIGN KEY (`comment_parent_comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_comments_users` FOREIGN KEY (`comment_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `comments` */

/*Table structure for table `configurations` */

DROP TABLE IF EXISTS `configurations`;

CREATE TABLE `configurations` (
  `configuration_id` binary(16) NOT NULL,
  `configuration_notification_enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `configurations` */

/*Table structure for table `consultant_messages` */

DROP TABLE IF EXISTS `consultant_messages`;

CREATE TABLE `consultant_messages` (
  `consultant_id` binary(16) NOT NULL,
  `message_id` binary(16) NOT NULL,
  PRIMARY KEY (`consultant_id`,`message_id`),
  KEY `FK_consultant_messages` (`message_id`),
  CONSTRAINT `FK_consultant_messages` FOREIGN KEY (`message_id`) REFERENCES `messages` (`message_id`),
  CONSTRAINT `FK_consultant_messages_1` FOREIGN KEY (`consultant_id`) REFERENCES `consultants` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `consultant_messages` */

/*Table structure for table `consultant_reviews` */

DROP TABLE IF EXISTS `consultant_reviews`;

CREATE TABLE `consultant_reviews` (
  `consultant_id` binary(1) NOT NULL,
  `review_id` binary(1) NOT NULL,
  PRIMARY KEY (`consultant_id`,`review_id`),
  KEY `FK_consultant_reviews_2` (`review_id`),
  CONSTRAINT `FK_consultant_reviews_1` FOREIGN KEY (`consultant_id`) REFERENCES `consultants` (`consultant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_consultant_reviews_2` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `consultant_reviews` */

/*Table structure for table `consultant_service_items` */

DROP TABLE IF EXISTS `consultant_service_items`;

CREATE TABLE `consultant_service_items` (
  `consultant_id` binary(16) NOT NULL,
  `service_item_id` int(11) NOT NULL,
  PRIMARY KEY (`consultant_id`,`service_item_id`),
  KEY `FK_consultant_service_items_2` (`service_item_id`),
  CONSTRAINT `FK_consultant_service_items_1` FOREIGN KEY (`consultant_id`) REFERENCES `consultants` (`consultant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_consultant_service_items_2` FOREIGN KEY (`service_item_id`) REFERENCES `service_items` (`service_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `consultant_service_items` */

/*Table structure for table `consultants` */

DROP TABLE IF EXISTS `consultants`;

CREATE TABLE `consultants` (
  `consultant_id` binary(16) NOT NULL,
  `consultant_name` varchar(128) NOT NULL DEFAULT '公司' COMMENT 'unique ',
  `consultant_email` varchar(128) NOT NULL,
  `consultant_password` varchar(64) NOT NULL,
  `consultant_telephone` varchar(16) DEFAULT NULL,
  `consultant_qq` varchar(16) DEFAULT NULL,
  `consultant_wechat` varchar(32) DEFAULT NULL,
  `consultant_is_organization` tinyint(1) NOT NULL DEFAULT '1',
  `consultant_logo_ref` varchar(128) DEFAULT NULL,
  `consultant_description` varchar(1024) NOT NULL,
  `consultant_accepted_cases` int(10) unsigned DEFAULT NULL,
  `consultant_stars` smallint(5) unsigned DEFAULT NULL,
  `consultant_employee_number` int(10) unsigned DEFAULT NULL,
  `consultant_url` varchar(256) DEFAULT NULL,
  `consultant_create_time` datetime NOT NULL COMMENT 'date time when a consultant is registered',
  `consultant_last_login_time` datetime DEFAULT NULL COMMENT 'date time of a consultant ''s latest login',
  `consultant_total_access_number` int(11) DEFAULT NULL COMMENT 'total logins a consultant has made',
  `consultant_is_deleted` tinyint(1) DEFAULT '0' COMMENT 'true - this consultant is deleted, false - not deleted',
  `consultant_delete_time` datetime DEFAULT NULL COMMENT 'when this consultant is deleted',
  `consultant_configuration_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`consultant_id`),
  KEY `consultant_email` (`consultant_email`),
  KEY `consultant_stars` (`consultant_stars`),
  KEY `consultant_employee_number` (`consultant_employee_number`),
  KEY `consultant_name` (`consultant_name`),
  KEY `FK_consultants_configurations` (`consultant_configuration_id`),
  CONSTRAINT `FK_consultants_configurations` FOREIGN KEY (`consultant_configuration_id`) REFERENCES `configurations` (`configuration_id`),
  CONSTRAINT `FK_consultants_users` FOREIGN KEY (`consultant_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `consultants` */

/*Table structure for table `countries` */

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(64) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `countries` */

insert  into `countries`(country_id,country_name) values (1,'所有国家'),(2,'美国'),(3,'澳大利亚'),(4,'加拿大'),(5,'英国'),(6,'法国'),(7,'德国'),(8,'新西兰'),(9,'日本'),(10,'意大利'),(11,'新加坡'),(12,'荷兰'),(13,'瑞典'),(14,'瑞士'),(15,'丹麦'),(16,'俄罗斯'),(17,'港澳台'),(255,'其他');

/*Table structure for table `currencies` */

DROP TABLE IF EXISTS `currencies`;

CREATE TABLE `currencies` (
  `currency_id` int(11) NOT NULL,
  `currency_name` varchar(16) NOT NULL,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `currencies` */

insert  into `currencies`(currency_id,currency_name) values (1,'人民币'),(2,'美元');

/*Table structure for table `degrees` */

DROP TABLE IF EXISTS `degrees`;

CREATE TABLE `degrees` (
  `degree_id` int(11) NOT NULL,
  `degree_name` varchar(32) NOT NULL,
  PRIMARY KEY (`degree_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `degrees` */

insert  into `degrees`(degree_id,degree_name) values (1,'高中'),(2,'大学'),(3,'研究生'),(4,'MBA'),(5,'博士'),(255,'其他');

/*Table structure for table `document_types` */

DROP TABLE IF EXISTS `document_types`;

CREATE TABLE `document_types` (
  `document_type_id` int(11) NOT NULL,
  `document_type_name` varchar(80) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`document_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `document_types` */

insert  into `document_types`(document_type_id,document_type_name) values (1,'个人陈述'),(2,'活动短文'),(3,'个性化问答'),(4,'简历'),(5,'Cover Letter'),(255,'其他');

/*Table structure for table `educations` */

DROP TABLE IF EXISTS `educations`;

CREATE TABLE `educations` (
  `education_id` binary(16) NOT NULL,
  `education_university` varchar(32) NOT NULL,
  `education_degree_name` varchar(16) NOT NULL COMMENT '//refer to degrees',
  `education_major_id` int(11) NOT NULL,
  `education_gpa` float DEFAULT NULL,
  `education_scale_name` int(11) NOT NULL COMMENT '//refer to grade_scales',
  `education_publications` varchar(1024) DEFAULT NULL,
  `education_social_achievements` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`education_id`),
  KEY `FK_educations_degree` (`education_degree_name`),
  KEY `FK_educations_major` (`education_major_id`),
  KEY `FK_educations_scale` (`education_scale_name`),
  KEY `education_university` (`education_university`,`education_degree_name`,`education_major_id`),
  CONSTRAINT `FK_educations_major` FOREIGN KEY (`education_major_id`) REFERENCES `majors` (`major_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `educations` */

/*Table structure for table `feedbacks` */

DROP TABLE IF EXISTS `feedbacks`;

CREATE TABLE `feedbacks` (
  `feedback_id` varbinary(16) NOT NULL,
  `feedback_user_id` varbinary(16) NOT NULL,
  `feedback_content` varchar(1024) NOT NULL,
  `feedback_create_time` datetime NOT NULL,
  `feedback_update_time` datetime DEFAULT NULL,
  `feedback_parent_feedback_id` varbinary(16) NOT NULL COMMENT 'it''s parent feedback id to have list model',
  PRIMARY KEY (`feedback_id`),
  KEY `FK_feedbacks_users` (`feedback_user_id`),
  KEY `FK_feedbacks` (`feedback_parent_feedback_id`),
  CONSTRAINT `FK_feedbacks` FOREIGN KEY (`feedback_parent_feedback_id`) REFERENCES `feedbacks` (`feedback_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_feedbacks_users` FOREIGN KEY (`feedback_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `feedbacks` */

/*Table structure for table `grade_scales` */

DROP TABLE IF EXISTS `grade_scales`;

CREATE TABLE `grade_scales` (
  `grade_scale_id` int(11) NOT NULL,
  `grade_scale_name` varchar(16) NOT NULL,
  PRIMARY KEY (`grade_scale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `grade_scales` */

insert  into `grade_scales`(grade_scale_id,grade_scale_name) values (1,'四分制'),(2,'五分制'),(3,'百分制'),(255,'其他');

/*Table structure for table `levels` */

DROP TABLE IF EXISTS `levels`;

CREATE TABLE `levels` (
  `level_id` int(11) NOT NULL,
  `level_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `levels` */

insert  into `levels`(level_id,level_name) values (1,'100 Level'),(2,'200 Level'),(3,'300 Level'),(4,'400+ Level'),(5,'硕士课程'),(255,'其他');

/*Table structure for table `majors` */

DROP TABLE IF EXISTS `majors`;

CREATE TABLE `majors` (
  `major_id` int(11) NOT NULL,
  `major_name` varchar(128) NOT NULL,
  PRIMARY KEY (`major_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `majors` */

insert  into `majors`(major_id,major_name) values (1,'Aerospace Studies'),(2,'African Studies'),(3,'Afro-American Studies'),(4,'American Indian Studies'),(5,'Anesthesiology'),(6,'Anthropology'),(7,'Applied Linguistics'),(8,'Archaeology'),(9,'Architecture and Urban Design'),(10,'Art'),(11,'Art History'),(12,'Asian American Studies'),(13,'Asian Languages and Cultures'),(14,'Astronomy and Astrophysics'),(15,'Atmospheric and Oceanic Sciences'),(16,'Bioengineering'),(17,'Bioinformatics'),(18,'Biological Chemistry'),(19,'Biomathematics'),(20,'Biomedical Physics'),(21,'Biomedical Research'),(22,'Biostatistics'),(23,'Chemical and Biomolecular Engineering'),(24,'Chemistry and Biochemistry'),(25,'Chemistry/Materials Science'),(26,'Chicana and Chicano Studies'),(27,'Civic Engagement'),(28,'Civil and Environmental Engineering'),(29,'Classics'),(30,'Communication Studies'),(31,'Community Health Sciences'),(32,'Comparative Literature'),(33,'Computational and Systems Biology'),(34,'Computer Science'),(35,'Conservation of Archaeological Ethnographic Materials'),(36,'Dance'),(37,'Dentistry'),(38,'Design | Media Arts'),(39,'Digital Humanities'),(40,'Disability Studies'),(41,'Earth and Space Sciences'),(42,'East Asian Studies'),(43,'Ecology and Evolutionary Biology'),(44,'Economics'),(45,'Education'),(46,'Electrical Engineering'),(47,'English'),(48,'Environmental Health Sciences'),(49,'Environmental Science and Engineering'),(50,'Epidemiology'),(51,'Ethnomusicology'),(52,'Family Medicine'),(53,'Film, Television, and Digital Media'),(54,'French and Francophone Studies'),(55,'Gender Studies'),(56,'General Education Clusters'),(57,'Geography'),(58,'Germanic Languages'),(59,'Gerontology'),(60,'Global Studies'),(61,'Health Policy and Management'),(62,'History'),(63,'Honors Collegium'),(64,'Human Complex Systems'),(65,'Human Genetics'),(66,'Indo-European Studies'),(67,'Information Studies'),(68,'Institute of the Environment and Sustainability'),(69,'Integrative Biology and Physiology'),(70,'International & Area Studies'),(71,'International Development Studies'),(72,'Iranian Studies'),(73,'Islamic Studies'),(74,'Italian'),(75,'Jewish Studies'),(76,'Labor and Workplace Studies'),(77,'Latin American Studies'),(78,'Law'),(79,'Lesbian, Gay, Bisexual, and Transgender Studies'),(80,'Linguistics'),(81,'Management'),(82,'Materials Science and Engineering'),(83,'Mathematics'),(84,'Mathematics/Atmospheric and Oceanic Sciences'),(85,'Mathematics/Economics'),(86,'Mechanical and Aerospace Engineering'),(87,'Medicine'),(88,'Microbiology, Immunology, and Molecular Genetics'),(89,'Military Science'),(90,'Molecular Biology'),(91,'Molecular Toxicology'),(92,'Molecular and Medical Pharmacology'),(93,'Molecular, Cell, and Developmental Biology'),(94,'Molecular, Cellular, and Integrative Physiology'),(95,'Moving Image Archive Studies'),(96,'Music'),(97,'Musicology'),(98,'Naval Science'),(99,'Near Eastern Languages and Cultures'),(100,'Neurobiology'),(101,'Neurology'),(102,'Neuroscience (Graduate)'),(103,'Neuroscience (Undergraduate)'),(104,'Nursing'),(105,'Ophthalmology'),(106,'Pathology and Laboratory Medicine'),(107,'Pediatrics'),(108,'Philosophy'),(109,'Physics and Astronomy'),(110,'Physiology'),(111,'Political Science'),(112,'Psychiatry and Biobehavioral Sciences'),(113,'Psychobiology'),(114,'Psychology'),(115,'Public Affairs (Undergraduate Minors)'),(116,'Public Policy'),(117,'Russian Language'),(118,'Scandinavian Section'),(119,'Slavic Languages and Literatures'),(120,'Social Thought'),(121,'Social Welfare'),(122,'Society and Genetics'),(123,'Sociology'),(124,'Spanish and Portuguese'),(125,'Statistics'),(126,'Study of Religion'),(127,'Theater'),(128,'Urban Planning'),(65535,'Other');

/*Table structure for table `message_types` */

DROP TABLE IF EXISTS `message_types`;

CREATE TABLE `message_types` (
  `message_type_id` int(11) NOT NULL,
  `message_type_name` varchar(16) NOT NULL,
  PRIMARY KEY (`message_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `message_types` */

insert  into `message_types`(message_type_id,message_type_name) values (1,'新回复'),(2,'新反馈'),(3,'新文章'),(4,'系统消息'),(255,'其他');

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `message_id` binary(16) NOT NULL,
  `message_type_name` varchar(16) CHARACTER SET utf8 NOT NULL COMMENT '//message type name, refer to message_types',
  `message_content` varchar(512) CHARACTER SET utf8 NOT NULL,
  `message_read_flag` tinyint(1) DEFAULT '0',
  `message_object_id` binary(16) DEFAULT NULL,
  `message_create_time` datetime NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `message_create_time` (`message_create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `messages` */

/*Table structure for table `ranks` */

DROP TABLE IF EXISTS `ranks`;

CREATE TABLE `ranks` (
  `rank_id` int(11) NOT NULL,
  `rank_name` varchar(32) NOT NULL,
  PRIMARY KEY (`rank_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `ranks` */

insert  into `ranks`(rank_id,rank_name) values (1,'所有学校'),(2,'Top 10'),(3,'Top 30'),(4,'Top 50'),(5,'Top 100'),(255,'其他');

/*Table structure for table `request_feedbacks` */

DROP TABLE IF EXISTS `request_feedbacks`;

CREATE TABLE `request_feedbacks` (
  `request_id` binary(16) NOT NULL,
  `feedback_id` binary(16) NOT NULL,
  PRIMARY KEY (`request_id`,`feedback_id`),
  KEY `FK_request_feedbacks_2` (`feedback_id`),
  CONSTRAINT `FK_request_feedbacks_2` FOREIGN KEY (`feedback_id`) REFERENCES `feedbacks` (`feedback_id`),
  CONSTRAINT `FK_request_feedbacks_1` FOREIGN KEY (`request_id`) REFERENCES `requests` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `request_feedbacks` */

/*Table structure for table `request_responses` */

DROP TABLE IF EXISTS `request_responses`;

CREATE TABLE `request_responses` (
  `request_id` binary(16) NOT NULL,
  `response_id` binary(16) NOT NULL,
  PRIMARY KEY (`request_id`,`response_id`),
  KEY `FK_request_responses_2` (`response_id`),
  CONSTRAINT `FK_request_responses_1` FOREIGN KEY (`request_id`) REFERENCES `requests` (`request_id`),
  CONSTRAINT `FK_request_responses_2` FOREIGN KEY (`response_id`) REFERENCES `responses` (`response_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `request_responses` */

/*Table structure for table `request_service_items` */

DROP TABLE IF EXISTS `request_service_items`;

CREATE TABLE `request_service_items` (
  `request_id` binary(16) NOT NULL,
  `service_item_id` int(11) NOT NULL,
  `level_name` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT '学术指导和论文指导的难度名,其他服务时是空值，见LEVELS表',
  `document_type_names` varchar(800) CHARACTER SET utf8 DEFAULT NULL COMMENT '文书指导的文书种类，多选时用逗号分开，见DOCUMENT_TYPES表',
  PRIMARY KEY (`request_id`,`service_item_id`),
  KEY `FK_request_service_items_2` (`service_item_id`),
  CONSTRAINT `FK_request_service_items_1` FOREIGN KEY (`request_id`) REFERENCES `requests` (`request_id`),
  CONSTRAINT `FK_request_service_items_2` FOREIGN KEY (`service_item_id`) REFERENCES `service_items` (`service_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `request_service_items` */

/*Table structure for table `requests` */

DROP TABLE IF EXISTS `requests`;

CREATE TABLE `requests` (
  `request_id` varbinary(16) NOT NULL,
  `request_country_id` int(11) DEFAULT NULL,
  `request_degree_id` int(11) DEFAULT NULL,
  `request_major_id` int(11) DEFAULT NULL,
  `request_rank` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '//rank name',
  `request_special_requirement` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  `request_created_time` datetime DEFAULT NULL,
  `request_updated_time` datetime DEFAULT NULL,
  `request_submit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `requests` */

/*Table structure for table `response_feedbacks` */

DROP TABLE IF EXISTS `response_feedbacks`;

CREATE TABLE `response_feedbacks` (
  `response_id` binary(16) NOT NULL,
  `feedback_id` binary(16) NOT NULL,
  PRIMARY KEY (`response_id`,`feedback_id`),
  KEY `FK_response_feedbacks2` (`feedback_id`),
  CONSTRAINT `FK_response_feedbacks2` FOREIGN KEY (`feedback_id`) REFERENCES `feedbacks` (`feedback_id`),
  CONSTRAINT `FK_response_feedbacks1` FOREIGN KEY (`response_id`) REFERENCES `responses` (`response_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `response_feedbacks` */

/*Table structure for table `responses` */

DROP TABLE IF EXISTS `responses`;

CREATE TABLE `responses` (
  `response_id` varbinary(16) NOT NULL,
  `response_consultant_id` binary(16) DEFAULT NULL COMMENT 'foreign key referencing to consults',
  `response_intro` varchar(2014) CHARACTER SET utf8 DEFAULT NULL,
  `response_fee` decimal(10,2) DEFAULT NULL,
  `response_currency` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '//currency name, refer to currencies table',
  `response_created_time` datetime DEFAULT NULL,
  `response_updated_time` datetime DEFAULT NULL,
  `response_submit_time` datetime DEFAULT NULL,
  `response_accepted_time` datetime DEFAULT NULL,
  `response_is_accepted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`response_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `responses` */

/*Table structure for table `review_users` */

DROP TABLE IF EXISTS `review_users`;

CREATE TABLE `review_users` (
  `review_id` binary(16) DEFAULT NULL,
  `user_id` binary(16) DEFAULT NULL,
  KEY `FK_review_users1` (`review_id`),
  KEY `FK_review_users2` (`user_id`),
  CONSTRAINT `FK_review_users2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_review_users1` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `review_users` */

/*Table structure for table `reviews` */

DROP TABLE IF EXISTS `reviews`;

CREATE TABLE `reviews` (
  `review_id` binary(16) NOT NULL,
  `review_student_id` binary(16) NOT NULL,
  `review_content` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  `review_stars` smallint(5) unsigned NOT NULL,
  `review_likes` int(10) unsigned DEFAULT '0',
  `review_create_time` datetime NOT NULL,
  `review_update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `FK_reviews_students` (`review_student_id`),
  KEY `review_create_time` (`review_create_time`),
  CONSTRAINT `FK_reviews_students` FOREIGN KEY (`review_student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `reviews` */

/*Table structure for table `service_categories` */

DROP TABLE IF EXISTS `service_categories`;

CREATE TABLE `service_categories` (
  `service_category_id` int(11) NOT NULL,
  `service_category_name` varchar(32) NOT NULL,
  PRIMARY KEY (`service_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `service_categories` */

insert  into `service_categories`(service_category_id,service_category_name) values (1,'全程申请'),(2,'择校服务'),(3,'文书修改'),(4,'标准化考试辅导'),(5,'学术辅导'),(6,'论文指导'),(7,'紧急应对'),(8,'签证指导'),(255,'其他');

/*Table structure for table `service_category_items` */

DROP TABLE IF EXISTS `service_category_items`;

CREATE TABLE `service_category_items` (
  `service_category_id` int(11) NOT NULL,
  `service_item_id` int(11) NOT NULL,
  PRIMARY KEY (`service_category_id`,`service_item_id`),
  KEY `FK_service_category_items_2` (`service_item_id`),
  CONSTRAINT `FK_service_category_items_2` FOREIGN KEY (`service_item_id`) REFERENCES `service_items` (`service_item_id`),
  CONSTRAINT `FK_service_category_items_1` FOREIGN KEY (`service_category_id`) REFERENCES `service_categories` (`service_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `service_category_items` */

insert  into `service_category_items`(service_category_id,service_item_id) values (1,100),(2,200),(3,300),(3,301),(3,302),(3,399),(4,400),(4,401),(4,402),(4,403),(4,404),(4,405),(4,406),(4,407),(4,408),(4,409),(4,410),(4,411),(4,499),(5,500),(5,501),(5,502),(5,503),(5,504),(5,505),(5,506),(5,507),(5,508),(5,509),(5,510),(5,511),(5,599),(6,600),(6,601),(6,602),(6,603),(6,604),(6,605),(6,606),(6,607),(6,608),(6,609),(6,610),(6,611),(6,699),(7,700),(7,701),(7,702),(7,799),(8,800),(8,801),(8,802),(8,803),(8,804),(8,805),(8,899);

/*Table structure for table `service_items` */

DROP TABLE IF EXISTS `service_items`;

CREATE TABLE `service_items` (
  `service_item_id` int(11) NOT NULL,
  `service_item_name` varchar(32) NOT NULL,
  PRIMARY KEY (`service_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `service_items` */

insert  into `service_items`(service_item_id,service_item_name) values (100,'全程申请'),(200,'择校服务'),(300,'构思准备'),(301,'行文结构'),(302,'润色修改'),(398,'全部文书修改服务'),(399,'其他文书修改服务'),(400,'GRE阅读'),(401,'GRE数学'),(402,'GRE写作'),(403,'SAT阅读'),(404,'SAT数学'),(405,'SAT写作'),(406,'SAT科目'),(407,'托福听说'),(408,'托福阅读'),(409,'托福写作'),(410,'雅思'),(411,'GMAT'),(499,'其他考试辅导'),(500,'英语'),(501,'哲学'),(502,'历史'),(503,'政治'),(504,'艺术'),(505,'计算机'),(506,'化学'),(507,'物理'),(508,'生物'),(509,'数学'),(510,'经济'),(511,'传播学'),(599,'其他学术辅导'),(600,'英语'),(601,'哲学'),(602,'历史'),(603,'政治'),(604,'艺术'),(605,'计算机'),(606,'化学'),(607,'物理'),(608,'生物'),(609,'数学'),(610,'经济'),(611,'传播学'),(699,'其他论文指导'),(700,'被学校开除'),(701,'被警告'),(702,'被休学几个学期'),(799,'其他紧急应对'),(800,'F1'),(801,'J1'),(802,'F2'),(803,'B1'),(804,'B2'),(805,'EB5'),(899,'其他签证指导');

/*Table structure for table `student_consultants` */

DROP TABLE IF EXISTS `student_consultants`;

CREATE TABLE `student_consultants` (
  `student_id` binary(16) NOT NULL,
  `consultant_id` binary(16) NOT NULL,
  PRIMARY KEY (`student_id`,`consultant_id`),
  KEY `FK_student_consultants_2` (`consultant_id`),
  CONSTRAINT `FK_student_consultants_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_student_consultants_2` FOREIGN KEY (`consultant_id`) REFERENCES `consultants` (`consultant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `student_consultants` */

/*Table structure for table `student_educations` */

DROP TABLE IF EXISTS `student_educations`;

CREATE TABLE `student_educations` (
  `student_id` binary(16) NOT NULL,
  `education_id` binary(16) NOT NULL,
  PRIMARY KEY (`student_id`,`education_id`),
  KEY `FK_student_educations_2` (`education_id`),
  CONSTRAINT `FK_student_educations_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_student_educations_2` FOREIGN KEY (`education_id`) REFERENCES `educations` (`education_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `student_educations` */

/*Table structure for table `student_messages` */

DROP TABLE IF EXISTS `student_messages`;

CREATE TABLE `student_messages` (
  `student_id` binary(16) NOT NULL,
  `message_id` binary(16) NOT NULL,
  PRIMARY KEY (`student_id`,`message_id`),
  KEY `FK_student_messages_2` (`message_id`),
  CONSTRAINT `FK_student_messages_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_student_messages_2` FOREIGN KEY (`message_id`) REFERENCES `messages` (`message_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `student_messages` */

/*Table structure for table `student_requests` */

DROP TABLE IF EXISTS `student_requests`;

CREATE TABLE `student_requests` (
  `student_id` binary(16) NOT NULL,
  `request_id` binary(16) NOT NULL,
  PRIMARY KEY (`student_id`,`request_id`),
  KEY `FK_student_requests` (`request_id`),
  CONSTRAINT `FK_student_requests` FOREIGN KEY (`request_id`) REFERENCES `requests` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_student_requests_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `student_requests` */

/*Table structure for table `students` */

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `student_id` binary(16) NOT NULL,
  `student_name` varchar(64) DEFAULT '学生',
  `student_email` varchar(128) NOT NULL,
  `student_password` varchar(64) NOT NULL,
  `student_telephone` varchar(16) DEFAULT NULL,
  `student_qq` varchar(16) DEFAULT NULL,
  `student_wechat` varchar(32) DEFAULT NULL,
  `student_create_time` datetime NOT NULL COMMENT 'date time when a student is registered',
  `student_last_login_time` datetime DEFAULT NULL COMMENT 'date time of a student''s latest login',
  `student_total_access_number` int(11) DEFAULT NULL COMMENT 'total logins a student has made',
  `student_is_deleted` tinyint(1) DEFAULT '0' COMMENT 'true - this student is deleted, false - not deleted',
  `student_delete_time` datetime DEFAULT NULL COMMENT 'when this student is deleted',
  `student_configuration_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `student_email` (`student_email`),
  KEY `student_name` (`student_name`),
  KEY `FK_students_configurations` (`student_configuration_id`),
  CONSTRAINT `FK_students_configurations` FOREIGN KEY (`student_configuration_id`) REFERENCES `configurations` (`configuration_id`),
  CONSTRAINT `FK_students_users` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `students` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` binary(16) NOT NULL,
  `user_type` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '''S'' - Student, ''C'' - Consultant',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `users` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
