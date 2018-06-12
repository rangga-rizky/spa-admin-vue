/*
SQLyog Community v12.4.1 (64 bit)
MySQL - 10.1.30-MariaDB : Database - pos
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `items` */

CREATE TABLE `items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `stock` int(11) NOT NULL,
  `unit` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `last_updated_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `items` */

insert  into `items`(`id`,`name`,`stock`,`unit`,`last_updated_by`,`created_at`,`updated_at`) values 
(1,'keju swiss',40,'potong',15,'2018-04-29 14:35:18','2018-05-09 13:00:04'),
(2,'roti burger',50,'buah',2,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(3,'daging burger',20,'potong',1,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(4,'telur',10,'buah',1,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(5,'mentega',5,'bungkus',2,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(6,'saos tomat',2,'jerigen',2,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(7,'saos mayones',2,'jerigen',2,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(8,'saos sambal',1,'jerigen',2,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(9,'daging ayam',40,'potong',3,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(10,'selada',10,'ikat',3,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(11,'bawang bombay',5,'plastik',1,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(12,'wortel',2,'plastik',15,'2018-04-29 14:35:18','2018-05-01 01:36:30'),
(14,'daging ayam',20,'potong',1,'2018-04-29 14:35:18','2018-04-29 14:35:18'),
(28,'saus tartar',2,'botol',15,'2018-06-12 06:41:24','2018-06-12 06:41:24'),
(35,'jagung',2,'batang',14,'2018-06-12 18:08:42','2018-06-12 18:08:42'),
(36,'fsafs',0,'sds',14,'2018-06-12 18:10:08','2018-06-12 18:10:08'),
(37,'fsad',0,'sds',15,'2018-06-12 18:24:12','2018-06-12 18:24:12'),
(38,'kentang',2,'sak',15,'2018-06-12 18:27:01','2018-06-12 18:27:01'),
(39,'sd',0,'sd',14,'2018-06-12 18:29:10','2018-06-12 18:29:10'),
(40,'sdsd',0,'sds',14,'2018-06-12 18:30:07','2018-06-12 18:30:07'),
(41,'sdsd',0,'sds',14,'2018-06-12 18:30:34','2018-06-12 18:30:34'),
(42,'sds',0,'sds',14,'2018-06-12 18:39:45','2018-06-12 18:39:45'),
(43,'sds',0,'sds',14,'2018-06-12 18:51:41','2018-06-12 18:51:41'),
(44,'jagung',2,'sak',14,'2018-06-12 18:57:08','2018-06-12 18:57:08');

/*Table structure for table `migrations` */

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2018_04_29_044608_create_products_table',1),
(4,'2018_04_29_044619_create_items_table',1),
(5,'2018_04_29_044634_create_transactions_table',1),
(6,'2018_04_29_045252_create_transaction_details_table',1),
(7,'2018_04_29_045955_create_product_recipes_table',1),
(8,'2018_04_29_095315_create_user_verifications_table',2),
(9,'2018_06_12_060039_create_notifications_table',3);

/*Table structure for table `notifications` */

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text COLLATE utf8_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `notifications` */

insert  into `notifications`(`id`,`type`,`notifiable_type`,`notifiable_id`,`data`,`read_at`,`created_at`,`updated_at`) values 
('0a4d86f0-0c93-401f-b16d-7e753699cd88','App\\Notifications\\NewItem','App\\User',15,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}','2018-06-12 18:57:14','2018-06-12 18:57:09','2018-06-12 18:57:14'),
('0cfcce54-224f-4dce-9aa1-2d89781193b6','App\\Notifications\\NewItem','App\\User',6,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('0d645103-337c-4671-b89b-f494478afc32','App\\Notifications\\NewItem','App\\User',10,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:42','2018-06-12 18:51:42'),
('157d6d9c-b809-4882-bf83-0df6767813bf','App\\Notifications\\NewItem','App\\User',9,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('24598d98-bedd-445a-815e-4ed37977be42','App\\Notifications\\NewItem','App\\User',1,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:45','2018-06-12 18:39:45'),
('272ef26c-58a5-45bb-bbfa-f08f8c6a052c','App\\Notifications\\NewItem','App\\User',13,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:42','2018-06-12 18:51:42'),
('2f8487e8-3184-4af9-a8e1-a16db915b717','App\\Notifications\\NewItem','App\\User',12,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('38ab683d-d096-451f-b5a4-c998a1dfe1fa','App\\Notifications\\NewItem','App\\User',9,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('3cfb1f47-a4dd-4730-a455-a44793a8084f','App\\Notifications\\NewItem','App\\User',1,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:41','2018-06-12 18:51:41'),
('43107d1b-564b-46c5-b651-0854532d61bc','App\\Notifications\\NewItem','App\\User',2,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:41','2018-06-12 18:51:41'),
('53cfcad3-a6a2-467b-a983-9c29bef4f0cf','App\\Notifications\\NewItem','App\\User',9,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:42','2018-06-12 18:51:42'),
('5e37d3f7-945f-4fa0-9364-aa4fcc7e1342','App\\Notifications\\NewItem','App\\User',6,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('62183630-c2c8-4635-8013-9da449e8fcd5','App\\Notifications\\NewItem','App\\User',5,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('65376f67-f46b-40d1-a0f1-a5ecbbb7bfff','App\\Notifications\\NewItem','App\\User',3,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('6b21ab55-9e5d-4469-88ff-5ab0906abef5','App\\Notifications\\NewItem','App\\User',15,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}','2018-06-12 18:55:11','2018-06-12 18:39:46','2018-06-12 18:55:11'),
('734f4b06-576b-4a45-b557-5dd79b125d6a','App\\Notifications\\NewItem','App\\User',14,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:42','2018-06-12 18:51:42'),
('7c21028e-b4c8-4170-bfa0-2ee019884ad5','App\\Notifications\\NewItem','App\\User',11,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('80ec6000-decf-46f1-8501-a0f2828233a1','App\\Notifications\\NewItem','App\\User',4,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('812fa775-cd96-4fb1-b7c3-a191af9bd390','App\\Notifications\\NewItem','App\\User',14,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('84fbd962-1846-412c-8474-2dc7de1f3b50','App\\Notifications\\NewItem','App\\User',6,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:41','2018-06-12 18:51:41'),
('86c36334-6838-43e4-ab5d-51129a67e07c','App\\Notifications\\NewItem','App\\User',8,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:42','2018-06-12 18:51:42'),
('8b2bc572-4980-4916-8d3b-8007d4fb80f7','App\\Notifications\\NewItem','App\\User',10,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('a0126f72-7f40-4c6c-bb2a-6164ca88c573','App\\Notifications\\NewItem','App\\User',11,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:42','2018-06-12 18:51:42'),
('a101b313-e6cb-4311-815a-8bf7f75efcb0','App\\Notifications\\NewItem','App\\User',4,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:41','2018-06-12 18:51:41'),
('a62c8776-0db1-404b-b592-71be3ecbb17a','App\\Notifications\\NewItem','App\\User',15,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}','2018-06-12 18:55:04','2018-06-12 18:51:42','2018-06-12 18:55:04'),
('aa955de7-f977-4dca-b84b-d1a4682f65fe','App\\Notifications\\NewItem','App\\User',3,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:41','2018-06-12 18:51:41'),
('aaadaee9-bfe3-46bd-a3a2-f904043280f6','App\\Notifications\\NewItem','App\\User',5,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:41','2018-06-12 18:51:41'),
('ae9e8e0e-c6c0-4b40-a25e-043c1d0efe97','App\\Notifications\\NewItem','App\\User',12,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('b86407db-5b28-417e-8e0e-fb80ff46db13','App\\Notifications\\NewItem','App\\User',1,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:08','2018-06-12 18:57:08'),
('ba530d54-a596-40a7-a039-c68533011dca','App\\Notifications\\NewItem','App\\User',13,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('ba76aa2e-c8c0-4f0d-87c4-1707ee7ff6b4','App\\Notifications\\NewItem','App\\User',8,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('bb2f85e7-4538-4d51-ba9b-803beeaecd07','App\\Notifications\\NewItem','App\\User',5,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('c501a765-ce63-4ba3-9522-8715d315d5cf','App\\Notifications\\NewItem','App\\User',7,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:41','2018-06-12 18:51:41'),
('cf359cf9-e3da-4a5d-a9e4-7cc6731954be','App\\Notifications\\NewItem','App\\User',12,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:51:42','2018-06-12 18:51:42'),
('d0c0dcaf-59fc-43bd-ba34-4c598d964f3a','App\\Notifications\\NewItem','App\\User',7,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('d257fbbf-56d8-4b43-b28b-bdd3d1b354c4','App\\Notifications\\NewItem','App\\User',7,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('d73252f7-cf13-41ce-91f6-2d5d0a1bbb7c','App\\Notifications\\NewItem','App\\User',3,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('d7935f5b-a2a0-4132-b8c4-054bfe29e9a3','App\\Notifications\\NewItem','App\\User',14,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('da1bd74f-403e-4db3-8683-eb2c0d1180d3','App\\Notifications\\NewItem','App\\User',2,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('dcb8cbb9-3626-4deb-91a7-3078dfa4f518','App\\Notifications\\NewItem','App\\User',13,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('e77fce75-73aa-4a8a-870a-0c7ab4d68e60','App\\Notifications\\NewItem','App\\User',2,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('f339b2f5-fc05-41ce-beab-df64ea3656fa','App\\Notifications\\NewItem','App\\User',4,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46'),
('f5b90272-bfc8-4af7-b3c8-abff1599a15c','App\\Notifications\\NewItem','App\\User',10,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('f67b7d69-3d26-4f6e-87db-47da622396d0','App\\Notifications\\NewItem','App\\User',11,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"jagung\"}',NULL,'2018-06-12 18:57:09','2018-06-12 18:57:09'),
('fa461568-9962-4160-bb7e-3620251360ec','App\\Notifications\\NewItem','App\\User',8,'{\"user_id\":14,\"user_name\":\"Mrs. Cheyanne Kessler\",\"item\":\"sds\"}',NULL,'2018-06-12 18:39:46','2018-06-12 18:39:46');

/*Table structure for table `password_resets` */

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `product_items` */

CREATE TABLE `product_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `qty` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_fk` (`item_id`),
  KEY `product_fk` (`product_id`),
  CONSTRAINT `item_fk` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `product_items` */

insert  into `product_items`(`id`,`product_id`,`item_id`,`qty`) values 
(1,1,2,2),
(2,1,10,1),
(3,1,11,1),
(4,1,12,1),
(5,2,2,4),
(6,2,3,1),
(9,17,2,2),
(10,17,9,1);

/*Table structure for table `products` */

CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_updated_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `products` */

insert  into `products`(`id`,`name`,`price`,`description`,`image_path`,`last_updated_by`,`created_at`,`updated_at`) values 
(1,'burger vegetarian',4000,'roti burger khas dengan selada,bawang bombay serta wortel untuk memenuhi kebutuhan veganmu','1525143514.jpg',1,'2018-04-29 14:46:15','2018-04-29 14:46:15'),
(2,'burger sapi',8000,'daging sapi segar diapit dengan roti burger khas','1525143514.jpg',1,'2018-04-29 14:46:15','2018-04-29 14:46:15'),
(3,'burger ayam',7000,'daging ayam segar diapit dengan roti burger khas','1525143514.jpg',1,'2018-04-29 14:46:15','2018-04-29 14:46:15'),
(4,'burger sapi + telur',10000,'burger sapi extra topping telur','1525143514.jpg',1,'2018-04-29 14:46:15','2018-04-29 14:46:15'),
(5,'burger ayam + telur',9000,'burger ayam extra topping telur','1525143514.jpg',1,'2018-04-29 14:46:15','2018-04-29 14:46:15'),
(6,'burger telur double',7000,'khusus lamu yang suka banget sama telur','1525143514.jpg',1,'2018-04-29 14:46:15','2018-04-29 14:46:15'),
(7,'burger sapi double',12000,'untuk kamu yang suka double daging sapi sekaligus','1525143514.jpg',1,'2018-04-29 14:46:15','2018-04-29 14:46:15'),
(8,'burger ayam double',10000,'untuk kamu yang suka double daging ayamsekaligus','1525143514.jpg',1,'2018-04-29 14:46:15','2018-04-29 14:46:15'),
(17,'sandwich ayam',7000,'ayam segar dibalut sandwich nikamt','1525975947.png',15,'2018-05-10 17:50:04','2018-05-10 18:12:27');

/*Table structure for table `transaction_details` */

CREATE TABLE `transaction_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `sub_price` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `transaction_details` */

insert  into `transaction_details`(`id`,`transaction_id`,`product_id`,`price`,`sub_price`,`qty`,`created_at`,`updated_at`) values 
(1,1,1,4000,4000,1,'2018-05-19 10:10:10','2018-05-19 10:10:10'),
(8,8,2,8000,8000,1,'2018-05-24 18:37:12','2018-05-24 18:37:12'),
(9,9,8,10000,10000,1,'2018-05-27 20:32:03','2018-05-27 20:32:03'),
(10,9,17,7000,14000,2,'2018-05-27 20:32:03','2018-05-27 20:32:03'),
(11,9,7,12000,12000,1,'2018-05-27 20:32:03','2018-05-27 20:32:03');

/*Table structure for table `transactions` */

CREATE TABLE `transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `total_price` int(11) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `transactions` */

insert  into `transactions`(`id`,`user_id`,`total_price`,`total_amount`,`created_at`,`updated_at`) values 
(1,15,4000,1,'2018-05-01 17:29:37','2018-05-19 20:42:26'),
(8,15,8000,1,'2018-05-24 18:37:12','2018-05-24 18:37:12'),
(9,15,36000,4,'2018-05-27 20:32:03','2018-05-27 20:32:03');

/*Table structure for table `user_verifications` */

CREATE TABLE `user_verifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_verifications_user_id_foreign` (`user_id`),
  CONSTRAINT `user_verifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_verifications` */

/*Table structure for table `users` */

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`password`,`remember_token`,`created_at`,`updated_at`,`is_verified`) values 
(1,'Lisa Thompson','mary.kub@feil.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(2,'Dr. Keyshawn Howe','scarlett13@hessel.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(3,'Dr. Kenton Williamson','skoelpin@hotmail.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(4,'Heber Dibbert','emarquardt@hessel.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(5,'Pearline Heidenreich IV','dorris94@hotmail.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(6,'Myah Schamberger','claudia.wiegand@kreiger.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(7,'Chesley Orn','evalyn.kassulke@haag.net','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(8,'Danika Johnson DVM','xlind@reinger.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(9,'Desiree Hintz','amie87@gusikowski.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(10,'Mr. Lesley Harvey Jr.','kmacejkovic@yahoo.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(11,'Crystal Fahey V','emile.grant@hotmail.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(12,'Eric Abernathy','luisa96@yahoo.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(13,'Ken Larson','iondricka@barton.info','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,1),
(14,'Mrs. Cheyanne Kessler','elenor.buckridge@gmail.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,1),
(15,'Hipolito Hane','nlebsack@haley.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,1);

/* Trigger structure for table `transaction_details` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `on_delete_transaction-detail` AFTER DELETE ON `transaction_details` FOR EACH ROW BEGIN
	update transactions set total_price=total_price-old.price,total_amount=total_amount-old.qty
	where id = old.transaction_id;
    END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
