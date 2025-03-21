/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : localhost:3306
 Source Schema         : py_online_mall

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44)
 File Encoding         : 65001

 Date: 21/03/2025 10:04:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES (1, '超级管理员');
INSERT INTO `auth_group` VALUES (2, '黑名单');

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
INSERT INTO `auth_group_permissions` VALUES (1, 1, 1);
INSERT INTO `auth_group_permissions` VALUES (2, 1, 2);
INSERT INTO `auth_group_permissions` VALUES (3, 1, 3);
INSERT INTO `auth_group_permissions` VALUES (4, 1, 4);
INSERT INTO `auth_group_permissions` VALUES (5, 1, 5);
INSERT INTO `auth_group_permissions` VALUES (6, 1, 6);
INSERT INTO `auth_group_permissions` VALUES (7, 1, 7);
INSERT INTO `auth_group_permissions` VALUES (8, 1, 8);
INSERT INTO `auth_group_permissions` VALUES (9, 1, 9);
INSERT INTO `auth_group_permissions` VALUES (10, 1, 10);
INSERT INTO `auth_group_permissions` VALUES (11, 1, 11);
INSERT INTO `auth_group_permissions` VALUES (12, 1, 12);
INSERT INTO `auth_group_permissions` VALUES (13, 1, 13);
INSERT INTO `auth_group_permissions` VALUES (14, 1, 14);
INSERT INTO `auth_group_permissions` VALUES (15, 1, 15);
INSERT INTO `auth_group_permissions` VALUES (16, 1, 16);
INSERT INTO `auth_group_permissions` VALUES (17, 1, 17);
INSERT INTO `auth_group_permissions` VALUES (18, 1, 18);
INSERT INTO `auth_group_permissions` VALUES (19, 1, 19);
INSERT INTO `auth_group_permissions` VALUES (20, 1, 20);
INSERT INTO `auth_group_permissions` VALUES (21, 1, 21);
INSERT INTO `auth_group_permissions` VALUES (22, 1, 22);
INSERT INTO `auth_group_permissions` VALUES (23, 1, 23);
INSERT INTO `auth_group_permissions` VALUES (24, 1, 24);
INSERT INTO `auth_group_permissions` VALUES (25, 1, 25);
INSERT INTO `auth_group_permissions` VALUES (26, 1, 26);
INSERT INTO `auth_group_permissions` VALUES (27, 1, 27);
INSERT INTO `auth_group_permissions` VALUES (28, 1, 28);
INSERT INTO `auth_group_permissions` VALUES (29, 1, 29);
INSERT INTO `auth_group_permissions` VALUES (30, 1, 30);
INSERT INTO `auth_group_permissions` VALUES (31, 1, 31);
INSERT INTO `auth_group_permissions` VALUES (32, 1, 32);
INSERT INTO `auth_group_permissions` VALUES (33, 1, 33);
INSERT INTO `auth_group_permissions` VALUES (34, 1, 34);
INSERT INTO `auth_group_permissions` VALUES (35, 1, 35);
INSERT INTO `auth_group_permissions` VALUES (36, 1, 36);
INSERT INTO `auth_group_permissions` VALUES (37, 1, 37);
INSERT INTO `auth_group_permissions` VALUES (38, 1, 38);
INSERT INTO `auth_group_permissions` VALUES (39, 1, 39);
INSERT INTO `auth_group_permissions` VALUES (40, 1, 40);
INSERT INTO `auth_group_permissions` VALUES (41, 1, 41);
INSERT INTO `auth_group_permissions` VALUES (42, 1, 42);
INSERT INTO `auth_group_permissions` VALUES (43, 1, 43);
INSERT INTO `auth_group_permissions` VALUES (44, 1, 44);
INSERT INTO `auth_group_permissions` VALUES (45, 1, 45);
INSERT INTO `auth_group_permissions` VALUES (46, 1, 46);
INSERT INTO `auth_group_permissions` VALUES (47, 1, 47);
INSERT INTO `auth_group_permissions` VALUES (48, 1, 48);
INSERT INTO `auth_group_permissions` VALUES (49, 1, 49);
INSERT INTO `auth_group_permissions` VALUES (50, 1, 50);
INSERT INTO `auth_group_permissions` VALUES (51, 1, 51);
INSERT INTO `auth_group_permissions` VALUES (52, 1, 52);
INSERT INTO `auth_group_permissions` VALUES (53, 1, 53);
INSERT INTO `auth_group_permissions` VALUES (54, 1, 54);
INSERT INTO `auth_group_permissions` VALUES (55, 1, 55);
INSERT INTO `auth_group_permissions` VALUES (56, 1, 56);
INSERT INTO `auth_group_permissions` VALUES (57, 1, 57);
INSERT INTO `auth_group_permissions` VALUES (58, 1, 58);
INSERT INTO `auth_group_permissions` VALUES (59, 1, 59);
INSERT INTO `auth_group_permissions` VALUES (60, 1, 60);
INSERT INTO `auth_group_permissions` VALUES (61, 1, 61);
INSERT INTO `auth_group_permissions` VALUES (62, 1, 62);
INSERT INTO `auth_group_permissions` VALUES (63, 1, 63);
INSERT INTO `auth_group_permissions` VALUES (64, 1, 64);
INSERT INTO `auth_group_permissions` VALUES (65, 1, 65);
INSERT INTO `auth_group_permissions` VALUES (66, 1, 66);
INSERT INTO `auth_group_permissions` VALUES (67, 1, 67);
INSERT INTO `auth_group_permissions` VALUES (68, 1, 68);
INSERT INTO `auth_group_permissions` VALUES (69, 1, 69);
INSERT INTO `auth_group_permissions` VALUES (70, 1, 70);
INSERT INTO `auth_group_permissions` VALUES (71, 1, 71);
INSERT INTO `auth_group_permissions` VALUES (72, 1, 72);

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add 商品信息', 7, 'add_commodityinfos');
INSERT INTO `auth_permission` VALUES (26, 'Can change 商品信息', 7, 'change_commodityinfos');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 商品信息', 7, 'delete_commodityinfos');
INSERT INTO `auth_permission` VALUES (28, 'Can view 商品信息', 7, 'view_commodityinfos');
INSERT INTO `auth_permission` VALUES (29, 'Can add 商品类型', 8, 'add_types');
INSERT INTO `auth_permission` VALUES (30, 'Can change 商品类型', 8, 'change_types');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 商品类型', 8, 'delete_types');
INSERT INTO `auth_permission` VALUES (32, 'Can view 商品类型', 8, 'view_types');
INSERT INTO `auth_permission` VALUES (33, 'Can add 购物车', 9, 'add_cartinfos');
INSERT INTO `auth_permission` VALUES (34, 'Can change 购物车', 9, 'change_cartinfos');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 购物车', 9, 'delete_cartinfos');
INSERT INTO `auth_permission` VALUES (36, 'Can view 购物车', 9, 'view_cartinfos');
INSERT INTO `auth_permission` VALUES (37, 'Can add 订单信息', 10, 'add_orderinfos');
INSERT INTO `auth_permission` VALUES (38, 'Can change 订单信息', 10, 'change_orderinfos');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 订单信息', 10, 'delete_orderinfos');
INSERT INTO `auth_permission` VALUES (40, 'Can view 订单信息', 10, 'view_orderinfos');
INSERT INTO `auth_permission` VALUES (41, 'Can add 退款信息', 11, 'add_refundinfos');
INSERT INTO `auth_permission` VALUES (42, 'Can change 退款信息', 11, 'change_refundinfos');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 退款信息', 11, 'delete_refundinfos');
INSERT INTO `auth_permission` VALUES (44, 'Can view 退款信息', 11, 'view_refundinfos');
INSERT INTO `auth_permission` VALUES (45, 'Can add 购买信息', 12, 'add_purchaseinfos');
INSERT INTO `auth_permission` VALUES (46, 'Can change 购买信息', 12, 'change_purchaseinfos');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 购买信息', 12, 'delete_purchaseinfos');
INSERT INTO `auth_permission` VALUES (48, 'Can view 购买信息', 12, 'view_purchaseinfos');
INSERT INTO `auth_permission` VALUES (49, 'Can add 收货地址', 13, 'add_addressinfos');
INSERT INTO `auth_permission` VALUES (50, 'Can change 收货地址', 13, 'change_addressinfos');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 收货地址', 13, 'delete_addressinfos');
INSERT INTO `auth_permission` VALUES (52, 'Can view 收货地址', 13, 'view_addressinfos');
INSERT INTO `auth_permission` VALUES (53, 'Can add outbound order', 14, 'add_outboundorder');
INSERT INTO `auth_permission` VALUES (54, 'Can change outbound order', 14, 'change_outboundorder');
INSERT INTO `auth_permission` VALUES (55, 'Can delete outbound order', 14, 'delete_outboundorder');
INSERT INTO `auth_permission` VALUES (56, 'Can view outbound order', 14, 'view_outboundorder');
INSERT INTO `auth_permission` VALUES (57, 'Can add purchase order', 15, 'add_purchaseorder');
INSERT INTO `auth_permission` VALUES (58, 'Can change purchase order', 15, 'change_purchaseorder');
INSERT INTO `auth_permission` VALUES (59, 'Can delete purchase order', 15, 'delete_purchaseorder');
INSERT INTO `auth_permission` VALUES (60, 'Can view purchase order', 15, 'view_purchaseorder');
INSERT INTO `auth_permission` VALUES (61, 'Can add 入库单', 16, 'add_stockinorder');
INSERT INTO `auth_permission` VALUES (62, 'Can change 入库单', 16, 'change_stockinorder');
INSERT INTO `auth_permission` VALUES (63, 'Can delete 入库单', 16, 'delete_stockinorder');
INSERT INTO `auth_permission` VALUES (64, 'Can view 入库单', 16, 'view_stockinorder');
INSERT INTO `auth_permission` VALUES (65, 'Can add outbound order item', 17, 'add_outboundorderitem');
INSERT INTO `auth_permission` VALUES (66, 'Can change outbound order item', 17, 'change_outboundorderitem');
INSERT INTO `auth_permission` VALUES (67, 'Can delete outbound order item', 17, 'delete_outboundorderitem');
INSERT INTO `auth_permission` VALUES (68, 'Can view outbound order item', 17, 'view_outboundorderitem');
INSERT INTO `auth_permission` VALUES (69, 'Can add logistics order', 18, 'add_logisticsorder');
INSERT INTO `auth_permission` VALUES (70, 'Can change logistics order', 18, 'change_logisticsorder');
INSERT INTO `auth_permission` VALUES (71, 'Can delete logistics order', 18, 'delete_logisticsorder');
INSERT INTO `auth_permission` VALUES (72, 'Can view logistics order', 18, 'view_logisticsorder');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$390000$694rJdcpUlGYJUC4PNuGAH$gCpI8WXxFWsWrjMNLuJQhGYPzmU6ZR403XsXo2fW/fM=', '2023-02-22 07:59:05.253142', 0, '13800138006', '', '', '', 1, 1, '2020-03-15 15:57:00.833884');
INSERT INTO `auth_user` VALUES (2, 'pbkdf2_sha256$180000$At3aYjpISu82$R7bdGl2DXza5QeL+ix1wMN8Jpk/ZV8lCvD4rFjEPdAk=', '2020-03-20 20:58:22.819140', 0, '13800138001', '', '', '', 1, 1, '2020-03-18 13:36:23.868460');
INSERT INTO `auth_user` VALUES (3, 'pbkdf2_sha256$180000$2eJ0TPkb0tnz$0uDiusZeZeqoKJPRF47X5Ht53BhG7vjpFTVjxWoSP/w=', NULL, 0, '13800138002', '', '', '', 1, 1, '2020-03-18 13:44:49.759706');
INSERT INTO `auth_user` VALUES (4, 'pbkdf2_sha256$180000$f4ITV8ohCE9V$UzjFyfQx2KLR4f1WRda8UjxN/O5R5MCz9W5+5ruZtpE=', NULL, 0, '13800138019', '', '', '', 1, 1, '2020-03-20 19:42:09.213362');
INSERT INTO `auth_user` VALUES (5, 'pbkdf2_sha256$180000$z4UBsmS1SBDV$caS1L0Gc7OMjh2Zt/4qURZv1+TfOWXnjMOP8PFJbvp4=', NULL, 0, '13800138020', '', '', '', 1, 1, '2020-03-20 19:49:06.244017');
INSERT INTO `auth_user` VALUES (6, 'pbkdf2_sha256$180000$lmeJpXObPmkW$W0a/+CnBM5iE+RMrZpgEem3hYFBkYLFWquTp62fli1o=', '2020-03-20 20:00:10.783815', 0, '13800138021', '', '', '', 1, 1, '2020-03-20 19:51:29.472941');
INSERT INTO `auth_user` VALUES (7, 'pbkdf2_sha256$180000$prFFunZxwFSW$+pGe0nzKREB9UISl1k4SJwy/J4D6DTCrr3Z9qRy03z0=', '2020-03-20 20:18:56.685928', 0, '13800138030', '', '', '', 1, 1, '2020-03-20 20:18:17.733500');
INSERT INTO `auth_user` VALUES (8, 'pbkdf2_sha256$390000$5HZmO9STBodPib25QOWG1T$RQloDqKOLs+dIVZkkHsAuTkzSEUsGAMFyLCkAg0AKSw=', '2025-03-18 08:02:24.459381', 1, 'admin', '', '', '', 1, 1, '2020-03-29 12:41:00.000000');
INSERT INTO `auth_user` VALUES (9, 'pbkdf2_sha256$180000$glARPxfubTBG$9K7saCHrrO93F/XhwE3Dt9IdaP/vZb7bHHRDxIEfDYw=', '2020-03-31 15:33:09.438771', 0, 'root', '', '', '', 1, 1, '2020-03-31 14:29:00.000000');
INSERT INTO `auth_user` VALUES (10, 'pbkdf2_sha256$390000$TzjYqOwykaJIbukcELfFln$HorM21FeakI1G7HLyNB5sqYhVI5fdhSFdBVnsJD7sXQ=', '2024-06-13 07:29:06.404150', 0, '17666578420', '', '', '', 1, 1, '2024-06-13 07:29:05.131932');
INSERT INTO `auth_user` VALUES (11, 'pbkdf2_sha256$390000$RfgnU2jMGF7TVHM4IKoXlx$V6P5KMPRlPxGO5O9ia4UVaz5O1bvNO08oqEoRpo+grw=', '2024-06-18 01:47:11.778008', 0, '13543482480', '', '', '', 1, 1, '2024-06-17 16:27:14.112091');
INSERT INTO `auth_user` VALUES (12, 'pbkdf2_sha256$390000$qnkz00okRWScb5g0oOn2n4$4MAvEra0LnNvzKF1iELLvXDipfTEKvQxFDmVaGilyVY=', '2024-06-18 07:40:11.220122', 0, '18765433343', '', '', '', 1, 1, '2024-06-18 07:40:10.296404');
INSERT INTO `auth_user` VALUES (13, 'pbkdf2_sha256$390000$87nIZ2VDxEvLWnXsMfLwa8$uViSsYiLLTbowOtXMoa+Lr/kjKj5LDIBtEPEv2OJBo8=', '2024-06-18 16:14:34.629728', 0, '13634344345', '', '', '', 1, 1, '2024-06-18 16:14:33.649331');
INSERT INTO `auth_user` VALUES (14, 'pbkdf2_sha256$390000$6cJniC9umedvmImo4kXxAh$6GkIQ/Hk7eFv5BHYQY/i3aU8YYEgi3daGbvTG5juw7Y=', '2024-06-18 18:01:53.219270', 0, '19876564634', '', '', '', 1, 1, '2024-06-18 18:01:52.384785');
INSERT INTO `auth_user` VALUES (15, 'pbkdf2_sha256$390000$50rs9ee0TaEH3lwMkyfkue$x1bN6CXRuwMY/uD0GyJdyTtmFZnAdUPPkRDYAhQgVZQ=', '2024-08-19 06:50:47.065964', 0, '13333333333', '', '', '', 1, 1, '2024-08-19 06:50:46.897679');
INSERT INTO `auth_user` VALUES (16, 'pbkdf2_sha256$390000$HbnYL7KqajMqwimNIbvZzR$PegiEKssT9PdLLMU+o84l8QE3qvfwO79huasY87f9sE=', '2025-03-11 08:59:00.000000', 0, '2021211748', '', '', '', 1, 1, '2025-03-11 08:59:00.000000');
INSERT INTO `auth_user` VALUES (17, 'pbkdf2_sha256$390000$eVO35opdniLJSodtn4Zt54$jydLLwPGT0P2+csjszihvP6btX8zDmnxTtgXnfnZTWg=', '2025-03-11 08:59:25.167460', 0, '13956769346', '', '', '', 1, 1, '2025-03-11 08:59:24.829399');
INSERT INTO `auth_user` VALUES (18, 'pbkdf2_sha256$390000$HyuqfAF4EZ7g2svWvW2PeW$/jvX2ZRuWioguLo6TeMp8h6DVSn4nckvzQkLH7EMBgs=', NULL, 0, 'logistics_manager', '', '', '', 1, 1, '2025-03-16 06:57:00.000000');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------
INSERT INTO `auth_user_groups` VALUES (1, 16, 2);

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------
INSERT INTO `auth_user_user_permissions` VALUES (41, 8, 1);
INSERT INTO `auth_user_user_permissions` VALUES (42, 8, 2);
INSERT INTO `auth_user_user_permissions` VALUES (43, 8, 3);
INSERT INTO `auth_user_user_permissions` VALUES (44, 8, 4);
INSERT INTO `auth_user_user_permissions` VALUES (45, 8, 5);
INSERT INTO `auth_user_user_permissions` VALUES (46, 8, 6);
INSERT INTO `auth_user_user_permissions` VALUES (47, 8, 7);
INSERT INTO `auth_user_user_permissions` VALUES (48, 8, 8);
INSERT INTO `auth_user_user_permissions` VALUES (49, 8, 9);
INSERT INTO `auth_user_user_permissions` VALUES (50, 8, 10);
INSERT INTO `auth_user_user_permissions` VALUES (51, 8, 11);
INSERT INTO `auth_user_user_permissions` VALUES (52, 8, 12);
INSERT INTO `auth_user_user_permissions` VALUES (53, 8, 13);
INSERT INTO `auth_user_user_permissions` VALUES (54, 8, 14);
INSERT INTO `auth_user_user_permissions` VALUES (55, 8, 15);
INSERT INTO `auth_user_user_permissions` VALUES (56, 8, 16);
INSERT INTO `auth_user_user_permissions` VALUES (57, 8, 17);
INSERT INTO `auth_user_user_permissions` VALUES (58, 8, 18);
INSERT INTO `auth_user_user_permissions` VALUES (59, 8, 19);
INSERT INTO `auth_user_user_permissions` VALUES (60, 8, 20);
INSERT INTO `auth_user_user_permissions` VALUES (61, 8, 21);
INSERT INTO `auth_user_user_permissions` VALUES (62, 8, 22);
INSERT INTO `auth_user_user_permissions` VALUES (63, 8, 23);
INSERT INTO `auth_user_user_permissions` VALUES (64, 8, 24);
INSERT INTO `auth_user_user_permissions` VALUES (65, 8, 25);
INSERT INTO `auth_user_user_permissions` VALUES (66, 8, 26);
INSERT INTO `auth_user_user_permissions` VALUES (67, 8, 27);
INSERT INTO `auth_user_user_permissions` VALUES (68, 8, 28);
INSERT INTO `auth_user_user_permissions` VALUES (69, 8, 29);
INSERT INTO `auth_user_user_permissions` VALUES (70, 8, 30);
INSERT INTO `auth_user_user_permissions` VALUES (71, 8, 31);
INSERT INTO `auth_user_user_permissions` VALUES (72, 8, 32);
INSERT INTO `auth_user_user_permissions` VALUES (73, 8, 33);
INSERT INTO `auth_user_user_permissions` VALUES (74, 8, 34);
INSERT INTO `auth_user_user_permissions` VALUES (75, 8, 35);
INSERT INTO `auth_user_user_permissions` VALUES (76, 8, 36);
INSERT INTO `auth_user_user_permissions` VALUES (77, 8, 37);
INSERT INTO `auth_user_user_permissions` VALUES (78, 8, 38);
INSERT INTO `auth_user_user_permissions` VALUES (79, 8, 39);
INSERT INTO `auth_user_user_permissions` VALUES (80, 8, 40);
INSERT INTO `auth_user_user_permissions` VALUES (1, 9, 1);
INSERT INTO `auth_user_user_permissions` VALUES (2, 9, 2);
INSERT INTO `auth_user_user_permissions` VALUES (3, 9, 3);
INSERT INTO `auth_user_user_permissions` VALUES (4, 9, 4);
INSERT INTO `auth_user_user_permissions` VALUES (5, 9, 5);
INSERT INTO `auth_user_user_permissions` VALUES (6, 9, 6);
INSERT INTO `auth_user_user_permissions` VALUES (7, 9, 7);
INSERT INTO `auth_user_user_permissions` VALUES (8, 9, 8);
INSERT INTO `auth_user_user_permissions` VALUES (9, 9, 9);
INSERT INTO `auth_user_user_permissions` VALUES (10, 9, 10);
INSERT INTO `auth_user_user_permissions` VALUES (11, 9, 11);
INSERT INTO `auth_user_user_permissions` VALUES (12, 9, 12);
INSERT INTO `auth_user_user_permissions` VALUES (13, 9, 13);
INSERT INTO `auth_user_user_permissions` VALUES (14, 9, 14);
INSERT INTO `auth_user_user_permissions` VALUES (15, 9, 15);
INSERT INTO `auth_user_user_permissions` VALUES (16, 9, 16);
INSERT INTO `auth_user_user_permissions` VALUES (17, 9, 17);
INSERT INTO `auth_user_user_permissions` VALUES (18, 9, 18);
INSERT INTO `auth_user_user_permissions` VALUES (19, 9, 19);
INSERT INTO `auth_user_user_permissions` VALUES (20, 9, 20);
INSERT INTO `auth_user_user_permissions` VALUES (21, 9, 21);
INSERT INTO `auth_user_user_permissions` VALUES (22, 9, 22);
INSERT INTO `auth_user_user_permissions` VALUES (23, 9, 23);
INSERT INTO `auth_user_user_permissions` VALUES (24, 9, 24);
INSERT INTO `auth_user_user_permissions` VALUES (25, 9, 25);
INSERT INTO `auth_user_user_permissions` VALUES (26, 9, 26);
INSERT INTO `auth_user_user_permissions` VALUES (27, 9, 27);
INSERT INTO `auth_user_user_permissions` VALUES (28, 9, 28);
INSERT INTO `auth_user_user_permissions` VALUES (29, 9, 29);
INSERT INTO `auth_user_user_permissions` VALUES (30, 9, 30);
INSERT INTO `auth_user_user_permissions` VALUES (31, 9, 31);
INSERT INTO `auth_user_user_permissions` VALUES (32, 9, 32);
INSERT INTO `auth_user_user_permissions` VALUES (33, 9, 33);
INSERT INTO `auth_user_user_permissions` VALUES (34, 9, 34);
INSERT INTO `auth_user_user_permissions` VALUES (35, 9, 35);
INSERT INTO `auth_user_user_permissions` VALUES (36, 9, 36);
INSERT INTO `auth_user_user_permissions` VALUES (37, 9, 37);
INSERT INTO `auth_user_user_permissions` VALUES (38, 9, 38);
INSERT INTO `auth_user_user_permissions` VALUES (39, 9, 39);
INSERT INTO `auth_user_user_permissions` VALUES (40, 9, 40);
INSERT INTO `auth_user_user_permissions` VALUES (81, 18, 1);
INSERT INTO `auth_user_user_permissions` VALUES (82, 18, 2);
INSERT INTO `auth_user_user_permissions` VALUES (83, 18, 3);
INSERT INTO `auth_user_user_permissions` VALUES (84, 18, 4);
INSERT INTO `auth_user_user_permissions` VALUES (85, 18, 5);
INSERT INTO `auth_user_user_permissions` VALUES (86, 18, 6);
INSERT INTO `auth_user_user_permissions` VALUES (87, 18, 7);
INSERT INTO `auth_user_user_permissions` VALUES (88, 18, 8);
INSERT INTO `auth_user_user_permissions` VALUES (89, 18, 9);
INSERT INTO `auth_user_user_permissions` VALUES (90, 18, 10);
INSERT INTO `auth_user_user_permissions` VALUES (91, 18, 11);
INSERT INTO `auth_user_user_permissions` VALUES (92, 18, 12);
INSERT INTO `auth_user_user_permissions` VALUES (93, 18, 13);
INSERT INTO `auth_user_user_permissions` VALUES (94, 18, 14);
INSERT INTO `auth_user_user_permissions` VALUES (95, 18, 15);
INSERT INTO `auth_user_user_permissions` VALUES (96, 18, 16);
INSERT INTO `auth_user_user_permissions` VALUES (97, 18, 17);
INSERT INTO `auth_user_user_permissions` VALUES (98, 18, 18);
INSERT INTO `auth_user_user_permissions` VALUES (99, 18, 19);
INSERT INTO `auth_user_user_permissions` VALUES (100, 18, 20);
INSERT INTO `auth_user_user_permissions` VALUES (101, 18, 21);
INSERT INTO `auth_user_user_permissions` VALUES (102, 18, 22);
INSERT INTO `auth_user_user_permissions` VALUES (103, 18, 23);
INSERT INTO `auth_user_user_permissions` VALUES (104, 18, 24);
INSERT INTO `auth_user_user_permissions` VALUES (105, 18, 25);
INSERT INTO `auth_user_user_permissions` VALUES (106, 18, 26);
INSERT INTO `auth_user_user_permissions` VALUES (107, 18, 27);
INSERT INTO `auth_user_user_permissions` VALUES (108, 18, 28);
INSERT INTO `auth_user_user_permissions` VALUES (109, 18, 29);
INSERT INTO `auth_user_user_permissions` VALUES (110, 18, 30);
INSERT INTO `auth_user_user_permissions` VALUES (111, 18, 31);
INSERT INTO `auth_user_user_permissions` VALUES (112, 18, 32);
INSERT INTO `auth_user_user_permissions` VALUES (113, 18, 33);
INSERT INTO `auth_user_user_permissions` VALUES (114, 18, 34);
INSERT INTO `auth_user_user_permissions` VALUES (115, 18, 35);
INSERT INTO `auth_user_user_permissions` VALUES (116, 18, 36);
INSERT INTO `auth_user_user_permissions` VALUES (117, 18, 37);
INSERT INTO `auth_user_user_permissions` VALUES (118, 18, 38);
INSERT INTO `auth_user_user_permissions` VALUES (119, 18, 39);
INSERT INTO `auth_user_user_permissions` VALUES (120, 18, 40);
INSERT INTO `auth_user_user_permissions` VALUES (121, 18, 41);
INSERT INTO `auth_user_user_permissions` VALUES (122, 18, 42);
INSERT INTO `auth_user_user_permissions` VALUES (123, 18, 43);
INSERT INTO `auth_user_user_permissions` VALUES (124, 18, 44);
INSERT INTO `auth_user_user_permissions` VALUES (125, 18, 45);
INSERT INTO `auth_user_user_permissions` VALUES (126, 18, 46);
INSERT INTO `auth_user_user_permissions` VALUES (127, 18, 47);
INSERT INTO `auth_user_user_permissions` VALUES (128, 18, 48);
INSERT INTO `auth_user_user_permissions` VALUES (129, 18, 49);
INSERT INTO `auth_user_user_permissions` VALUES (130, 18, 50);
INSERT INTO `auth_user_user_permissions` VALUES (131, 18, 51);
INSERT INTO `auth_user_user_permissions` VALUES (132, 18, 52);
INSERT INTO `auth_user_user_permissions` VALUES (133, 18, 53);
INSERT INTO `auth_user_user_permissions` VALUES (134, 18, 54);
INSERT INTO `auth_user_user_permissions` VALUES (135, 18, 55);
INSERT INTO `auth_user_user_permissions` VALUES (136, 18, 56);
INSERT INTO `auth_user_user_permissions` VALUES (137, 18, 57);
INSERT INTO `auth_user_user_permissions` VALUES (138, 18, 58);
INSERT INTO `auth_user_user_permissions` VALUES (139, 18, 59);
INSERT INTO `auth_user_user_permissions` VALUES (140, 18, 60);
INSERT INTO `auth_user_user_permissions` VALUES (141, 18, 61);
INSERT INTO `auth_user_user_permissions` VALUES (142, 18, 62);
INSERT INTO `auth_user_user_permissions` VALUES (143, 18, 63);
INSERT INTO `auth_user_user_permissions` VALUES (144, 18, 64);
INSERT INTO `auth_user_user_permissions` VALUES (145, 18, 65);
INSERT INTO `auth_user_user_permissions` VALUES (146, 18, 66);
INSERT INTO `auth_user_user_permissions` VALUES (147, 18, 67);
INSERT INTO `auth_user_user_permissions` VALUES (148, 18, 68);
INSERT INTO `auth_user_user_permissions` VALUES (149, 18, 69);
INSERT INTO `auth_user_user_permissions` VALUES (150, 18, 70);
INSERT INTO `auth_user_user_permissions` VALUES (151, 18, 71);
INSERT INTO `auth_user_user_permissions` VALUES (152, 18, 72);

-- ----------------------------
-- Table structure for commodity_commodityinfos
-- ----------------------------
DROP TABLE IF EXISTS `commodity_commodityinfos`;
CREATE TABLE `commodity_commodityinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sezes` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `types` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` double NOT NULL,
  `discount` double NOT NULL,
  `stock` int(11) NOT NULL,
  `sold` int(11) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `created` date NOT NULL,
  `img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `details` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `inventory` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of commodity_commodityinfos
-- ----------------------------
INSERT INTO `commodity_commodityinfos` VALUES (1, '2024新款平板电脑护眼官方正品', '黑', '平板电脑', 599, 399, 2000, 0, 0, '2024-06-18', 'imgs/v1d_VxtVcO1.png', 'details/v1m.jpg', 999);
INSERT INTO `commodity_commodityinfos` VALUES (2, '2024新款平板电脑护眼官方正品', '白', '平板电脑', 799, 399, 888, 0, 1, '2024-06-18', 'imgs/v2d_My7JK7V.png', 'details/v2m.jpg', 999);
INSERT INTO `commodity_commodityinfos` VALUES (3, '双屏三防加固笔记本', '黑', '笔记本电脑', 25800, 23800, 999, 0, 1, '2024-06-18', 'imgs/v3d.png', 'details/v3m.jpg', 999);
INSERT INTO `commodity_commodityinfos` VALUES (4, '2024英特尔全新游戏超薄笔记本电脑', '白', '笔记本电脑', 1192, 832, 9977, 0, 0, '2024-06-18', 'imgs/v4d.png', 'details/v4m.jpg', 999);
INSERT INTO `commodity_commodityinfos` VALUES (5, '神舟战神S8/Z8系列笔记本电脑', '黑', '游戏本', 6451, 5789, 666, 0, 0, '2024-06-18', 'imgs/v5d.png', 'details/v5m.jpg', 999);
INSERT INTO `commodity_commodityinfos` VALUES (6, 'Asus/华硕天选16英寸游戏本电脑', '黑', '游戏本', 7099, 6789, 776, 0, 0, '2024-06-18', 'imgs/v6d.png', 'details/v6mm.jpg', 999);

-- ----------------------------
-- Table structure for commodity_types
-- ----------------------------
DROP TABLE IF EXISTS `commodity_types`;
CREATE TABLE `commodity_types`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firsts` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `seconds` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of commodity_types
-- ----------------------------
INSERT INTO `commodity_types` VALUES (1, '电脑整机', '平板电脑');
INSERT INTO `commodity_types` VALUES (2, '电脑整机', '游戏本');
INSERT INTO `commodity_types` VALUES (3, '电脑整机', '笔记本电脑');
INSERT INTO `commodity_types` VALUES (18, '食品', '粮油调味');
INSERT INTO `commodity_types` VALUES (19, '食品', '中外名酒');
INSERT INTO `commodity_types` VALUES (20, '食品', '休闲食品');
INSERT INTO `commodity_types` VALUES (21, '食品', '饮料');
INSERT INTO `commodity_types` VALUES (22, '食品', '新鲜水果');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NULL DEFAULT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2020-03-31 14:29:14.791765', '9', 'root', 1, '[{\"added\": {}}]', 4, 8);
INSERT INTO `django_admin_log` VALUES (2, '2020-03-31 15:32:59.927205', '9', 'root', 2, '[{\"changed\": {\"fields\": [\"Staff status\", \"User permissions\"]}}]', 4, 8);
INSERT INTO `django_admin_log` VALUES (3, '2020-03-31 15:49:40.192259', '1', '1', 2, '[]', 7, 8);
INSERT INTO `django_admin_log` VALUES (4, '2023-02-20 11:01:34.600494', '1', '13800138006', 2, '[{\"changed\": {\"fields\": [\"password\"]}}]', 4, 8);
INSERT INTO `django_admin_log` VALUES (5, '2024-06-17 01:46:28.572275', '8', 'admin', 2, '[{\"changed\": {\"fields\": [\"User permissions\", \"Last login\"]}}]', 4, 8);
INSERT INTO `django_admin_log` VALUES (6, '2024-06-18 01:25:05.381879', '1', '1', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u540d\\u79f0\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (7, '2024-06-18 01:25:16.557301', '1', '1', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u540d\\u79f0\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (8, '2024-06-18 01:28:26.402903', '17', '17', 2, '[{\"changed\": {\"fields\": [\"\\u4e00\\u7ea7\\u7c7b\\u578b\"]}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (9, '2024-06-18 01:28:32.066500', '17', '17', 2, '[{\"changed\": {\"fields\": [\"\\u4e00\\u7ea7\\u7c7b\\u578b\"]}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (10, '2024-06-18 02:15:19.284274', '1', '1', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4e3b\\u56fe\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (11, '2024-06-18 08:58:59.729440', '3', '3', 2, '[{\"changed\": {\"fields\": [\"\\u4e00\\u7ea7\\u7c7b\\u578b\", \"\\u4e8c\\u7ea7\\u7c7b\\u578b\"]}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (12, '2024-06-18 08:58:59.744547', '2', '2', 2, '[{\"changed\": {\"fields\": [\"\\u4e00\\u7ea7\\u7c7b\\u578b\", \"\\u4e8c\\u7ea7\\u7c7b\\u578b\"]}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (13, '2024-06-18 08:58:59.761537', '1', '1', 2, '[{\"changed\": {\"fields\": [\"\\u4e00\\u7ea7\\u7c7b\\u578b\", \"\\u4e8c\\u7ea7\\u7c7b\\u578b\"]}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (14, '2024-06-18 09:21:02.703315', '1', '1', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (15, '2024-06-18 13:07:53.919214', '17', '17', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (16, '2024-06-18 13:07:53.959188', '16', '16', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (17, '2024-06-18 13:07:53.975183', '15', '15', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (18, '2024-06-18 13:07:53.998169', '14', '14', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (19, '2024-06-18 13:07:54.009158', '13', '13', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (20, '2024-06-18 13:07:54.029143', '12', '12', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (21, '2024-06-18 13:07:54.043146', '11', '11', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (22, '2024-06-18 13:07:54.053132', '10', '10', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (23, '2024-06-18 13:07:54.056140', '9', '9', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (24, '2024-06-18 13:07:54.064132', '8', '8', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (25, '2024-06-18 13:07:54.074119', '7', '7', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (26, '2024-06-18 13:07:54.083112', '6', '6', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (27, '2024-06-18 13:07:54.092107', '5', '5', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (28, '2024-06-18 13:07:54.101101', '4', '4', 3, '', 8, 8);
INSERT INTO `django_admin_log` VALUES (29, '2024-06-18 13:14:50.593926', '2', '2', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (30, '2024-06-18 13:19:18.990608', '1', '1', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4e3b\\u56fe\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (31, '2024-06-18 13:19:19.014594', '2', '2', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4e3b\\u56fe\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (32, '2024-06-18 13:52:09.669515', '3', '3', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (33, '2024-06-18 13:53:05.609503', '1', '1', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u540d\\u79f0\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (34, '2024-06-18 13:53:05.624481', '2', '2', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u540d\\u79f0\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (35, '2024-06-18 13:53:43.605563', '3', '3', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u540d\\u79f0\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (36, '2024-06-18 13:54:10.435632', '3', '3', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u540d\\u79f0\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (37, '2024-06-18 14:01:14.456058', '4', '4', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (38, '2024-06-18 14:13:52.452317', '5', '5', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (39, '2024-06-18 14:18:41.242348', '6', '6', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (40, '2024-06-18 14:19:17.863391', '6', '6', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u540d\\u79f0\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (41, '2024-06-18 15:35:00.067604', '18', '18', 1, '[{\"added\": {}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (42, '2024-06-18 15:35:19.645060', '19', '19', 1, '[{\"added\": {}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (43, '2024-06-18 15:35:39.392684', '20', '20', 1, '[{\"added\": {}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (44, '2024-06-18 15:36:04.348242', '21', '21', 1, '[{\"added\": {}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (45, '2024-06-18 15:36:12.706803', '22', '22', 1, '[{\"added\": {}}]', 8, 8);
INSERT INTO `django_admin_log` VALUES (46, '2025-03-16 06:32:44.126342', '1', 'PurchaseOrder object (1)', 1, '[{\"added\": {}}]', 15, 8);
INSERT INTO `django_admin_log` VALUES (47, '2025-03-16 06:54:48.854819', '1', 'LogisticsOrder object (1)', 1, '[{\"added\": {}}]', 18, 8);
INSERT INTO `django_admin_log` VALUES (48, '2025-03-16 06:56:04.787152', '1', '超级管理员', 1, '[{\"added\": {}}]', 3, 8);
INSERT INTO `django_admin_log` VALUES (49, '2025-03-16 06:57:00.662437', '18', 'logistics_manager', 1, '[{\"added\": {}}]', 4, 8);
INSERT INTO `django_admin_log` VALUES (50, '2025-03-16 06:57:40.829539', '18', 'logistics_manager', 2, '[{\"changed\": {\"fields\": [\"Staff status\", \"User permissions\"]}}]', 4, 8);
INSERT INTO `django_admin_log` VALUES (51, '2025-03-18 07:40:04.673001', '2', 'PurchaseOrder object (2)', 1, '[{\"added\": {}}]', 15, 8);
INSERT INTO `django_admin_log` VALUES (52, '2025-03-18 08:02:45.307722', '2', '黑名单', 1, '[{\"added\": {}}]', 3, 8);
INSERT INTO `django_admin_log` VALUES (53, '2025-03-18 08:02:58.523237', '16', '2021211748', 2, '[{\"changed\": {\"fields\": [\"Groups\", \"Last login\"]}}]', 4, 8);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (7, 'commodity', 'commodityinfos');
INSERT INTO `django_content_type` VALUES (8, 'commodity', 'types');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (18, 'logistics', 'logisticsorder');
INSERT INTO `django_content_type` VALUES (14, 'logistics', 'outboundorder');
INSERT INTO `django_content_type` VALUES (17, 'logistics', 'outboundorderitem');
INSERT INTO `django_content_type` VALUES (15, 'logistics', 'purchaseorder');
INSERT INTO `django_content_type` VALUES (16, 'logistics', 'stockinorder');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (13, 'shopper', 'addressinfos');
INSERT INTO `django_content_type` VALUES (9, 'shopper', 'cartinfos');
INSERT INTO `django_content_type` VALUES (10, 'shopper', 'orderinfos');
INSERT INTO `django_content_type` VALUES (12, 'shopper', 'purchaseinfos');
INSERT INTO `django_content_type` VALUES (11, 'shopper', 'refundinfos');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `applied` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2020-02-24 15:16:26.623814');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2020-02-24 15:16:27.026737');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2020-02-24 15:16:28.147737');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2020-02-24 15:16:28.523732');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2020-02-24 15:16:28.536698');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2020-02-24 15:16:28.766083');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2020-02-24 15:16:29.015416');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2020-02-24 15:16:29.062290');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2020-02-24 15:16:29.078248');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2020-02-24 15:16:29.194935');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2020-02-24 15:16:29.199921');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2020-02-24 15:16:29.211891');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2020-02-24 15:16:29.351528');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2020-02-24 15:16:29.515078');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2020-02-24 15:16:29.565943');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2020-02-24 15:16:29.580902');
INSERT INTO `django_migrations` VALUES (17, 'commodity', '0001_initial', '2020-02-24 15:16:29.706567');
INSERT INTO `django_migrations` VALUES (18, 'sessions', '0001_initial', '2020-02-24 15:16:29.775383');
INSERT INTO `django_migrations` VALUES (19, 'shopper', '0001_initial', '2020-02-24 15:16:29.942934');
INSERT INTO `django_migrations` VALUES (20, 'auth', '0012_alter_user_first_name_max_length', '2023-02-17 02:48:51.494733');
INSERT INTO `django_migrations` VALUES (21, 'shopper', '0002_alter_cartinfos_commodityinfos_id', '2023-02-21 07:27:25.555295');
INSERT INTO `django_migrations` VALUES (22, 'shopper', '0003_orderinfos_pay_id_alter_orderinfos_state', '2025-03-14 05:54:33.187244');
INSERT INTO `django_migrations` VALUES (23, 'commodity', '0002_commodityinfos_inventory', '2025-03-14 06:13:22.633530');
INSERT INTO `django_migrations` VALUES (24, 'shopper', '0004_remove_cartinfos_user_id_remove_orderinfos_user_id_and_more', '2025-03-16 02:06:11.160314');
INSERT INTO `django_migrations` VALUES (25, 'logistics', '0001_initial', '2025-03-16 06:27:46.650346');
INSERT INTO `django_migrations` VALUES (26, 'logistics', '0002_alter_logisticsorder_options_and_more', '2025-03-18 07:51:11.813376');
INSERT INTO `django_migrations` VALUES (27, 'shopper', '0005_orderinfos_address', '2025-03-18 07:51:11.923362');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expire_date` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('04gh5eoprgxcpo1nchzensd84p7wqfk5', 'MmNiN2NiN2U0M2FlNTAwMzkzYTFiYjg0Y2ZhNDExMDczMDgwN2Q4YTp7Imxpa2VzIjpudWxsfQ==', '2020-03-26 13:36:44.052388');
INSERT INTO `django_session` VALUES ('1rr4fki27eu0mxp4nv2nkrb8l6i0tc10', '.eJxdj8FugzAMht_FZxQlDiGE42477LYjEnITe7B1UAE5VFXffXTrqrY36_t-_7JP0FFe-y4vPHdDggaMh-Ie7ih-8Xgx6ZPGj0nFaVznYacuEXW1i3qbEu9frtmHgp6WftuWSMQWvXE14zaUUdBrbY0EiShCaHWIhsQHIq0ZUxmYvK8i2YowbKUHOr6OMkFzgsM8RIbGhaB0AbfrjS9gWWndFLTZJcE2Vw6lzSWn-q_i_83SVLV1NcL5F78P3_zEfwCKWljB:1trvSg:h9Kq9xVbDPE_9ailVu-iFWWNOsDoQ0zDPNcWZu1oiJ8', '2025-03-25 08:59:42.490594');
INSERT INTO `django_session` VALUES ('2ydw817m4zhotqb44za44z5khm5cxjii', 'NTNiMDMzZThjOWE3MjFiNzRmN2Y1M2ZiODMzYjgzM2ZkM2QzYjAxNzp7Il9hdXRoX3VzZXJfaWQiOiI5IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjZmEyYjQwNWY4MmEzNTBiYTg3YWI4OWYxNzIwNWNiMTVjZDNjMTM0In0=', '2020-04-14 15:33:09.445780');
INSERT INTO `django_session` VALUES ('3d9m5rs0yn638h3y44hqy85oq67j9tr4', '.eJxVjMsOwiAQRf-FtSHlNYBL934DgWGQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYMzszx06_W4r4oLaDfI_t1jn2ti5z4rvCDzr4tWd6Xg7376DGUb91jM4mK0F7RVkbJZIwYFARoinKOI3Si2ILZOEnMgk9AYLOEiaHYC17fwDdbTeQ:1sJbVn:5hzmbowVUQcNHRzxB7xXdauc7GF0_Zy65gbTK_QjGTk', '2024-07-02 16:16:47.813079');
INSERT INTO `django_session` VALUES ('5j91ajmm2jumaviice8web25kz2whqik', '.eJxVjMEOwiAQRP-FsyFLKQU8eu83kF3YStXQpLQn479bkh70OPPezFsE3Lcc9sprmJO4CiUuvx1hfHJpID2w3BcZl7KtM8mmyJNWOS6JX7fT_TvIWPOxniYAM5iOvNIugkN3ZGLqVTQt9EkblSzhAIqAKTrvDTBrMGCt7sTnC8kXNvg:1pUUgs:O3HjSza7-mue5HfYvq8HfxqJBx5kH97wEXjUeTXtH8c', '2023-03-07 15:36:26.952958');
INSERT INTO `django_session` VALUES ('6uv9mid0lvdh62zp9s4mwwaxvf40j6n2', '.eJxdj7tuhDAQRf9lamRh4_GDMl2KdCmRkD0eB5INrAAX0Sr_vuxDUXbbe-49mjlBH8o29GXlpR8TtOCg-p_FQF88XUD6DNPHLGietmWM4lIRd7qKtznx4eXefRAMYR32dQjORquM9g0njY2MEg1Sw0SYG3SalJfZZpOkrxkjeTZkdFKmdmSs3aXH8PM65RnaExyXkRha9F7UFfwd7ypYt7DtBLqCKauuGFS5K5qTuxluT0qrlXKoagu_1_h9_Oan_AyK9leN:1tuRyK:15Rme5Y9o_x-YXijP-bvdOQLQJHEhEoGRNaTF6SCing', '2025-04-01 08:06:48.588912');
INSERT INTO `django_session` VALUES ('93rbpb43zi18cr3n3o6bij9pyun3715n', 'MjIzZGE0YjQ5ZTNjYWMzNTlhNjA4YzVkZjFmMGJkNmExZmJmMGU4OTp7Imxpa2VzIjp0cnVlfQ==', '2020-03-26 10:30:29.662811');
INSERT INTO `django_session` VALUES ('bcmyunt3inli143guv01n32cbfom2wm1', 'MmNiN2NiN2U0M2FlNTAwMzkzYTFiYjg0Y2ZhNDExMDczMDgwN2Q4YTp7Imxpa2VzIjpudWxsfQ==', '2020-03-26 13:32:26.837713');
INSERT INTO `django_session` VALUES ('hqdzj2aii98g7aqfhd6cxtarbto74k3x', 'MmNiN2NiN2U0M2FlNTAwMzkzYTFiYjg0Y2ZhNDExMDczMDgwN2Q4YTp7Imxpa2VzIjpudWxsfQ==', '2020-03-26 13:35:25.046970');
INSERT INTO `django_session` VALUES ('k53j3orf1urfnqn5bqjyy9pfa7fy1dwl', 'MjIzZGE0YjQ5ZTNjYWMzNTlhNjA4YzVkZjFmMGJkNmExZmJmMGU4OTp7Imxpa2VzIjp0cnVlfQ==', '2020-03-26 10:38:44.347533');
INSERT INTO `django_session` VALUES ('lff8n3a25ens007n2z29u41t0czjioui', 'MjQxNGM0NDM4ODIzNmYxZmFiZGFiNzZiYzNiN2U5ODM5NDM0ZTgzNjp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYzVhMGIzOTFiMzZmNzdiNGMyNjM5ZmE4NGI0NzFkMDkzODg0ZDM2In0=', '2020-04-12 12:42:04.663516');
INSERT INTO `django_session` VALUES ('lhme8f0yy000osv1wl5jhbk400rkp5l7', '.eJxVjEEOwiAQRe_C2hBAaBmX7nsGMsxMpWpoUtqV8e7apAvd_vfef6mE21rS1mRJE6uLsur0u2Wkh9Qd8B3rbdY013WZst4VfdCmh5nleT3cv4OCrXxrF2AMPjAbB0YoYkeeMXKPXRTxEUwOBA7J9qOADcRy9oDROhJvLKj3B-xGOBE:1pRluq:9OMrErUzoOrq7fCtl9xGd9DJLrPnGhjiwAwgoYwqu_c', '2023-02-28 03:23:36.514605');
INSERT INTO `django_session` VALUES ('mtp8ubigxekcq4kolcxhhy46lsabnmg4', '.eJxVjMsOwiAQRf-FtSHlNYBL934DgWGQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYMzszx06_W4r4oLaDfI_t1jn2ti5z4rvCDzr4tWd6Xg7376DGUb91jM4mK0F7RVkbJZIwYFARoinKOI3Si2ILZOEnMgk9AYLOEiaHYC17fwDdbTeQ:1sJdNt:vlvGQGhZiVkULhovuOWworJpiR2RXRfg6A0spOMyJnk', '2024-07-02 18:16:45.390878');
INSERT INTO `django_session` VALUES ('ndsh24znckwqpz3p82cena0wk6rxnyaf', 'eyJsaWtlcyI6WzMsMl19:1sJZTJ:FLl1gdNMV-d395US92W_pp8mXTLGXSRwbLd_udZNnUI', '2024-07-02 14:06:05.482117');
INSERT INTO `django_session` VALUES ('o6o4h0v7h0w8w8bdvaasze57qfx1buzg', '.eJxVjrluwzAQRP9la4HgtTxUpnORLqUAgVySkRJbMiSxCAz_eyTDMJJ23szD3KAPdRv6uualHxO04KD5m8VA33k6QPoK0-fMaJ62ZYzsqLAnXdn7nPL57dn9JxjCOuzrEJyNVhrtVU4alYgCDZLKRFgUOk3Si2KLScLzjJF8NmR0koY7Mtbu0mv4OU1lhvYG12WkDC16z3gDr_OugXUL206gq5iK7KpBWbqqc3Jwfyg-xsvBhZWa7w8Uh_svQ8RSHg:1sfxrO:4MuJl2Yc_wK7o24aMPhu4XZnzG8V5U1PUuPTHOPmSck', '2024-09-02 08:35:30.598178');
INSERT INTO `django_session` VALUES ('r2gey1gibhywms3nxndagw04w2ir1jd6', 'MmNiN2NiN2U0M2FlNTAwMzkzYTFiYjg0Y2ZhNDExMDczMDgwN2Q4YTp7Imxpa2VzIjpudWxsfQ==', '2020-03-26 13:41:00.303808');
INSERT INTO `django_session` VALUES ('sfzayj3e8lsylgvlxi4veh0yud237rf3', 'MmNiN2NiN2U0M2FlNTAwMzkzYTFiYjg0Y2ZhNDExMDczMDgwN2Q4YTp7Imxpa2VzIjpudWxsfQ==', '2020-03-26 13:29:55.534079');
INSERT INTO `django_session` VALUES ('tgx1d0s3pdlf1fuma2uverbzkw9r84ke', '.eJxVjMEOwiAQRP-FsyFLKQU8eu83kF3YStXQpLQn479bkh70OPPezFsE3Lcc9sprmJO4CiUuvx1hfHJpID2w3BcZl7KtM8mmyJNWOS6JX7fT_TvIWPOxniYAM5iOvNIugkN3ZGLqVTQt9EkblSzhAIqAKTrvDTBrMGCt7sTnC8kXNvg:1pUk1p:Wny1DpWVcTSvipuMa9COf9Hgh_kFQGF0ZmO_dYBuIcU', '2023-03-08 07:59:05.258146');
INSERT INTO `django_session` VALUES ('toqiw1u5vdy9qbgqivt8zn2qn9z328sf', 'MDk0NmEwMGVhOGYyZjc2YWVlMTNhNmE5NzBkMzg2YTQ0ZTRmNTllYjp7Imxpa2VzIjpbNSw0XSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNiZmM4ODIzNGQxODQwYzhmMWIzODBhMDBiNzUzZTgwYTlkNjAyZDMifQ==', '2020-03-29 15:57:11.652234');
INSERT INTO `django_session` VALUES ('uaskjeoc29l2pg55m1xsy5g3xtopo6qn', 'MjIzZGE0YjQ5ZTNjYWMzNTlhNjA4YzVkZjFmMGJkNmExZmJmMGU4OTp7Imxpa2VzIjp0cnVlfQ==', '2020-03-26 10:39:29.603761');
INSERT INTO `django_session` VALUES ('uqmxlp2skgnyqn0wa4l8272igc4as50a', 'NmE4NWJlODNmOTg3ZGRlODBlMzYyM2M4ZGYxOTBiMWRlYWM3MmFkZTp7Imxpa2VzIjpbMTcsNCwxNywxMCwxMCw1XX0=', '2020-03-27 06:12:10.036017');
INSERT INTO `django_session` VALUES ('z9lshjwvzdeq1n8khklvqmm2xvlbwkru', '.eJxVjMEOwiAQRP-FsyFLKQU8eu83kF3YStXQpLQn479bkh70OPPezFsE3Lcc9sprmJO4CiUuvx1hfHJpID2w3BcZl7KtM8mmyJNWOS6JX7fT_TvIWPOxniYAM5iOvNIugkN3ZGLqVTQt9EkblSzhAIqAKTrvDTBrMGCt7sTnC8kXNvg:1pUNNd:6ZIu-4tDljJPW0xABoNtNdHm9XCnr8MfqX9pF0xeFF0', '2023-03-07 07:48:05.610227');

-- ----------------------------
-- Table structure for logistics_logisticsorder
-- ----------------------------
DROP TABLE IF EXISTS `logistics_logisticsorder`;
CREATE TABLE `logistics_logisticsorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tracking_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `carrier` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estimated_delivery` date NOT NULL,
  `actual_delivery` date NULL DEFAULT NULL,
  `order_info_id` int(11) NULL DEFAULT NULL,
  `purchase_order_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tracking_number`(`tracking_number`) USING BTREE,
  INDEX `logistics_logisticso_order_info_id_dde823b8_fk_shopper_o`(`order_info_id`) USING BTREE,
  INDEX `logistics_logisticso_purchase_order_id_165dc102_fk_logistics`(`purchase_order_id`) USING BTREE,
  CONSTRAINT `logistics_logisticso_order_info_id_dde823b8_fk_shopper_o` FOREIGN KEY (`order_info_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_logisticso_purchase_order_id_165dc102_fk_logistics` FOREIGN KEY (`purchase_order_id`) REFERENCES `logistics_purchaseorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_logisticsorder
-- ----------------------------
INSERT INTO `logistics_logisticsorder` VALUES (1, '11234441', '顺丰速运', 'shipped', '2025-03-18', NULL, NULL, 1);

-- ----------------------------
-- Table structure for logistics_outboundorder
-- ----------------------------
DROP TABLE IF EXISTS `logistics_outboundorder`;
CREATE TABLE `logistics_outboundorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `commodity_id` int(11) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE,
  INDEX `logistics_outboundor_commodity_id_36082379_fk_commodity`(`commodity_id`) USING BTREE,
  INDEX `logistics_outboundorder_created_by_id_afe0b5b1_fk_auth_user_id`(`created_by_id`) USING BTREE,
  CONSTRAINT `logistics_outboundor_commodity_id_36082379_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_outboundorder_created_by_id_afe0b5b1_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_outboundorder
-- ----------------------------

-- ----------------------------
-- Table structure for logistics_outboundorderitem
-- ----------------------------
DROP TABLE IF EXISTS `logistics_outboundorderitem`;
CREATE TABLE `logistics_outboundorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_picked` tinyint(1) NOT NULL,
  `order_id` int(11) NOT NULL,
  `outbound_order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `logistics_outboundorderi_outbound_order_id_order__ce2f593c_uniq`(`outbound_order_id`, `order_id`) USING BTREE,
  INDEX `logistics_outboundor_order_id_e92e776e_fk_shopper_o`(`order_id`) USING BTREE,
  CONSTRAINT `logistics_outboundor_order_id_e92e776e_fk_shopper_o` FOREIGN KEY (`order_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_outboundor_outbound_order_id_6f261153_fk_logistics` FOREIGN KEY (`outbound_order_id`) REFERENCES `logistics_outboundorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_outboundorderitem
-- ----------------------------

-- ----------------------------
-- Table structure for logistics_purchaseorder
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchaseorder`;
CREATE TABLE `logistics_purchaseorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `supplier` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `commodity_id` int(11) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE,
  INDEX `logistics_purchaseor_commodity_id_28c120de_fk_commodity`(`commodity_id`) USING BTREE,
  INDEX `logistics_purchaseorder_created_by_id_20212d3e_fk_auth_user_id`(`created_by_id`) USING BTREE,
  CONSTRAINT `logistics_purchaseor_commodity_id_28c120de_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_purchaseorder_created_by_id_20212d3e_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_purchaseorder
-- ----------------------------
INSERT INTO `logistics_purchaseorder` VALUES (1, '5234352', 5, '公司', '2025-03-16 06:32:44.126342', 'approved', 1, 8);
INSERT INTO `logistics_purchaseorder` VALUES (2, '1111', 2, '公司', '2025-03-18 07:40:04.671998', 'approved', 2, 8);

-- ----------------------------
-- Table structure for logistics_stockinorder
-- ----------------------------
DROP TABLE IF EXISTS `logistics_stockinorder`;
CREATE TABLE `logistics_stockinorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stock_in_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `quantity` int(11) NOT NULL,
  `notes` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `order_info_id` int(11) NULL DEFAULT NULL,
  `purchase_order_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `stock_in_number`(`stock_in_number`) USING BTREE,
  INDEX `logistics_stockinorder_created_by_id_5249a99f_fk_auth_user_id`(`created_by_id`) USING BTREE,
  INDEX `logistics_stockinord_order_info_id_a7bda6d2_fk_shopper_o`(`order_info_id`) USING BTREE,
  INDEX `logistics_stockinord_purchase_order_id_c035c297_fk_logistics`(`purchase_order_id`) USING BTREE,
  CONSTRAINT `logistics_stockinord_order_info_id_a7bda6d2_fk_shopper_o` FOREIGN KEY (`order_info_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_stockinord_purchase_order_id_c035c297_fk_logistics` FOREIGN KEY (`purchase_order_id`) REFERENCES `logistics_purchaseorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_stockinorder_created_by_id_5249a99f_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_stockinorder
-- ----------------------------

-- ----------------------------
-- Table structure for shopper_addressinfos
-- ----------------------------
DROP TABLE IF EXISTS `shopper_addressinfos`;
CREATE TABLE `shopper_addressinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_addressinfos_user_id_a8203ccf_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `shopper_addressinfos_user_id_a8203ccf_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopper_addressinfos
-- ----------------------------

-- ----------------------------
-- Table structure for shopper_cartinfos
-- ----------------------------
DROP TABLE IF EXISTS `shopper_cartinfos`;
CREATE TABLE `shopper_cartinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `commodityInfos_id_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_cartinfos_commodityInfos_id_id_68f10ae8`(`commodityInfos_id_id`) USING BTREE,
  INDEX `shopper_cartinfos_user_id_abb2b502_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `shopper_cartinfos_commodityInfos_id_id_68f10ae8_fk_commodity` FOREIGN KEY (`commodityInfos_id_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_cartinfos_user_id_abb2b502_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopper_cartinfos
-- ----------------------------
INSERT INTO `shopper_cartinfos` VALUES (2, 1, 3, 1);
INSERT INTO `shopper_cartinfos` VALUES (3, 1, 2, 1);
INSERT INTO `shopper_cartinfos` VALUES (4, 1, 1, 1);
INSERT INTO `shopper_cartinfos` VALUES (37, 1, 1, 1);
INSERT INTO `shopper_cartinfos` VALUES (38, 1, 1, 1);
INSERT INTO `shopper_cartinfos` VALUES (41, 1, 1, 1);
INSERT INTO `shopper_cartinfos` VALUES (42, 1, 1, 8);

-- ----------------------------
-- Table structure for shopper_orderinfos
-- ----------------------------
DROP TABLE IF EXISTS `shopper_orderinfos`;
CREATE TABLE `shopper_orderinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `created` date NOT NULL,
  `state` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `pay_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `refund_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `address_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_orderinfos_user_id_c136f6f2_fk_auth_user_id`(`user_id`) USING BTREE,
  INDEX `shopper_orderinfos_address_id_9fb3bb5e_fk_shopper_a`(`address_id`) USING BTREE,
  CONSTRAINT `shopper_orderinfos_address_id_9fb3bb5e_fk_shopper_a` FOREIGN KEY (`address_id`) REFERENCES `shopper_addressinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_orderinfos_user_id_c136f6f2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopper_orderinfos
-- ----------------------------
INSERT INTO `shopper_orderinfos` VALUES (1, 25800, '2024-06-19', '已支付', NULL, NULL, 1, NULL);
INSERT INTO `shopper_orderinfos` VALUES (2, 799, '2024-06-19', '已支付', NULL, NULL, 1, NULL);
INSERT INTO `shopper_orderinfos` VALUES (3, 599, '2025-03-14', '已支付', '1741931924', NULL, 1, NULL);
INSERT INTO `shopper_orderinfos` VALUES (4, 599, '2025-03-15', '已支付', '1742008537', NULL, 1, NULL);

-- ----------------------------
-- Table structure for shopper_purchaseinfos
-- ----------------------------
DROP TABLE IF EXISTS `shopper_purchaseinfos`;
CREATE TABLE `shopper_purchaseinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `commodityInfos_id_id` int(11) NULL DEFAULT NULL,
  `order_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_purchaseinfo_commodityInfos_id_id_85b45edb_fk_commodity`(`commodityInfos_id_id`) USING BTREE,
  INDEX `shopper_purchaseinfos_order_id_156be8d0_fk_shopper_orderinfos_id`(`order_id`) USING BTREE,
  INDEX `shopper_purchaseinfos_user_id_4c9e42a1_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `shopper_purchaseinfo_commodityInfos_id_id_85b45edb_fk_commodity` FOREIGN KEY (`commodityInfos_id_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_purchaseinfos_order_id_156be8d0_fk_shopper_orderinfos_id` FOREIGN KEY (`order_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_purchaseinfos_user_id_4c9e42a1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopper_purchaseinfos
-- ----------------------------

-- ----------------------------
-- Table structure for shopper_refundinfos
-- ----------------------------
DROP TABLE IF EXISTS `shopper_refundinfos`;
CREATE TABLE `shopper_refundinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `refund_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double NOT NULL,
  `created` date NOT NULL,
  `state` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attach` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_refundinfos_order_id_1d4e5b94_fk_shopper_orderinfos_id`(`order_id`) USING BTREE,
  INDEX `shopper_refundinfos_user_id_caf0b49d_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `shopper_refundinfos_order_id_1d4e5b94_fk_shopper_orderinfos_id` FOREIGN KEY (`order_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_refundinfos_user_id_caf0b49d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopper_refundinfos
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
