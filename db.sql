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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `items` */

insert  into `items`(`id`,`name`,`stock`,`unit`,`last_updated_by`,`created_at`,`updated_at`) values 
(1,'keju swiss',40,'potong',25,'2018-04-29 14:35:18','2018-05-09 13:00:04'),
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
(12,'wortel',2,'plastik',25,'2018-04-29 14:35:18','2018-05-01 01:36:30'),
(14,'daging ayam',20,'potong',1,'2018-04-29 14:35:18','2018-04-29 14:35:18');

/*Table structure for table `migrations` */

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2018_04_29_044608_create_products_table',1),
(4,'2018_04_29_044619_create_items_table',1),
(5,'2018_04_29_044634_create_transactions_table',1),
(6,'2018_04_29_045252_create_transaction_details_table',1),
(7,'2018_04_29_045955_create_product_recipes_table',1),
(8,'2018_04_29_095315_create_user_verifications_table',2);

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
(17,'sandwich ayam',7000,'ayam segar dibalut sandwich nikamt','1525975947.png',25,'2018-05-10 17:50:04','2018-05-10 18:12:27');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `transaction_details` */

insert  into `transaction_details`(`id`,`transaction_id`,`product_id`,`price`,`sub_price`,`qty`,`created_at`,`updated_at`) values 
(1,1,1,4000,4000,1,'2018-05-19 10:10:10','2018-05-19 10:10:10'),
(8,8,2,8000,8000,1,'2018-05-24 18:37:12','2018-05-24 18:37:12');

/*Table structure for table `transactions` */

CREATE TABLE `transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `total_price` int(11) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `transactions` */

insert  into `transactions`(`id`,`user_id`,`total_price`,`total_amount`,`created_at`,`updated_at`) values 
(1,25,4000,1,'2018-05-01 17:29:37','2018-05-19 20:42:26'),
(8,25,8000,1,'2018-05-24 18:37:12','2018-05-24 18:37:12');

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(13,'Ken Larson','iondricka@barton.info','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(14,'Mrs. Cheyanne Kessler','elenor.buckridge@gmail.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0),
(15,'Hipolito Hane','nlebsack@haley.com','$2y$10$GFRE/69SO6tNiVtMrj2BqOVDoMTXHUtdnr9QX0b6zkcum5ljzn.ga',NULL,NULL,NULL,0);

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
