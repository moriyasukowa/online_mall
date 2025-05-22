/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306_1
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : localhost:3306
 Source Schema         : py_online_mall

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44)
 File Encoding         : 65001

 Date: 21/05/2025 20:45:23
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
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
INSERT INTO `auth_permission` VALUES (73, 'Can add 采购计划', 19, 'add_procurementorder');
INSERT INTO `auth_permission` VALUES (74, 'Can change 采购计划', 19, 'change_procurementorder');
INSERT INTO `auth_permission` VALUES (75, 'Can delete 采购计划', 19, 'delete_procurementorder');
INSERT INTO `auth_permission` VALUES (76, 'Can view 采购计划', 19, 'view_procurementorder');
INSERT INTO `auth_permission` VALUES (77, 'Can add 采购订单项', 20, 'add_procurementorderitem');
INSERT INTO `auth_permission` VALUES (78, 'Can change 采购订单项', 20, 'change_procurementorderitem');
INSERT INTO `auth_permission` VALUES (79, 'Can delete 采购订单项', 20, 'delete_procurementorderitem');
INSERT INTO `auth_permission` VALUES (80, 'Can view 采购订单项', 20, 'view_procurementorderitem');
INSERT INTO `auth_permission` VALUES (81, 'Can add 采购订单项', 21, 'add_purchaseorderitem');
INSERT INTO `auth_permission` VALUES (82, 'Can change 采购订单项', 21, 'change_purchaseorderitem');
INSERT INTO `auth_permission` VALUES (83, 'Can delete 采购订单项', 21, 'delete_purchaseorderitem');
INSERT INTO `auth_permission` VALUES (84, 'Can view 采购订单项', 21, 'view_purchaseorderitem');
INSERT INTO `auth_permission` VALUES (85, 'Can add 行政区域', 22, 'add_region');
INSERT INTO `auth_permission` VALUES (86, 'Can change 行政区域', 22, 'change_region');
INSERT INTO `auth_permission` VALUES (87, 'Can delete 行政区域', 22, 'delete_region');
INSERT INTO `auth_permission` VALUES (88, 'Can view 行政区域', 22, 'view_region');
INSERT INTO `auth_permission` VALUES (89, 'Can add 入库单项', 23, 'add_stockinorderitem');
INSERT INTO `auth_permission` VALUES (90, 'Can change 入库单项', 23, 'change_stockinorderitem');
INSERT INTO `auth_permission` VALUES (91, 'Can delete 入库单项', 23, 'delete_stockinorderitem');
INSERT INTO `auth_permission` VALUES (92, 'Can view 入库单项', 23, 'view_stockinorderitem');
INSERT INTO `auth_permission` VALUES (93, 'Can add 物流单项', 24, 'add_logisticsorderitem');
INSERT INTO `auth_permission` VALUES (94, 'Can change 物流单项', 24, 'change_logisticsorderitem');
INSERT INTO `auth_permission` VALUES (95, 'Can delete 物流单项', 24, 'delete_logisticsorderitem');
INSERT INTO `auth_permission` VALUES (96, 'Can view 物流单项', 24, 'view_logisticsorderitem');
INSERT INTO `auth_permission` VALUES (97, 'Can add 入库单', 25, 'add_refundstockinorder');
INSERT INTO `auth_permission` VALUES (98, 'Can change 入库单', 25, 'change_refundstockinorder');
INSERT INTO `auth_permission` VALUES (99, 'Can delete 入库单', 25, 'delete_refundstockinorder');
INSERT INTO `auth_permission` VALUES (100, 'Can view 入库单', 25, 'view_refundstockinorder');
INSERT INTO `auth_permission` VALUES (101, 'Can add 入库单项', 26, 'add_refundstockinorderitem');
INSERT INTO `auth_permission` VALUES (102, 'Can change 入库单项', 26, 'change_refundstockinorderitem');
INSERT INTO `auth_permission` VALUES (103, 'Can delete 入库单项', 26, 'delete_refundstockinorderitem');
INSERT INTO `auth_permission` VALUES (104, 'Can view 入库单项', 26, 'view_refundstockinorderitem');
INSERT INTO `auth_permission` VALUES (105, 'Can add 入库单', 27, 'add_purchasestockinorder');
INSERT INTO `auth_permission` VALUES (106, 'Can change 入库单', 27, 'change_purchasestockinorder');
INSERT INTO `auth_permission` VALUES (107, 'Can delete 入库单', 27, 'delete_purchasestockinorder');
INSERT INTO `auth_permission` VALUES (108, 'Can view 入库单', 27, 'view_purchasestockinorder');
INSERT INTO `auth_permission` VALUES (109, 'Can add 入库单项', 28, 'add_purchasestockinorderitem');
INSERT INTO `auth_permission` VALUES (110, 'Can change 入库单项', 28, 'change_purchasestockinorderitem');
INSERT INTO `auth_permission` VALUES (111, 'Can delete 入库单项', 28, 'delete_purchasestockinorderitem');
INSERT INTO `auth_permission` VALUES (112, 'Can view 入库单项', 28, 'view_purchasestockinorderitem');

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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
INSERT INTO `auth_user` VALUES (8, 'pbkdf2_sha256$390000$5HZmO9STBodPib25QOWG1T$RQloDqKOLs+dIVZkkHsAuTkzSEUsGAMFyLCkAg0AKSw=', '2025-05-21 15:30:40.353535', 1, 'admin', '', '', '', 1, 1, '2020-03-29 12:41:00.000000');
INSERT INTO `auth_user` VALUES (9, 'pbkdf2_sha256$180000$glARPxfubTBG$9K7saCHrrO93F/XhwE3Dt9IdaP/vZb7bHHRDxIEfDYw=', '2020-03-31 15:33:09.438771', 0, 'root', '', '', '', 1, 1, '2020-03-31 14:29:00.000000');
INSERT INTO `auth_user` VALUES (10, 'pbkdf2_sha256$390000$TzjYqOwykaJIbukcELfFln$HorM21FeakI1G7HLyNB5sqYhVI5fdhSFdBVnsJD7sXQ=', '2024-06-13 07:29:06.404150', 0, '17666578420', '', '', '', 1, 1, '2024-06-13 07:29:05.131932');
INSERT INTO `auth_user` VALUES (11, 'pbkdf2_sha256$390000$RfgnU2jMGF7TVHM4IKoXlx$V6P5KMPRlPxGO5O9ia4UVaz5O1bvNO08oqEoRpo+grw=', '2024-06-18 01:47:11.778008', 0, '13543482480', '', '', '', 1, 1, '2024-06-17 16:27:14.112091');
INSERT INTO `auth_user` VALUES (12, 'pbkdf2_sha256$390000$qnkz00okRWScb5g0oOn2n4$4MAvEra0LnNvzKF1iELLvXDipfTEKvQxFDmVaGilyVY=', '2024-06-18 07:40:11.220122', 0, '18765433343', '', '', '', 1, 1, '2024-06-18 07:40:10.296404');
INSERT INTO `auth_user` VALUES (13, 'pbkdf2_sha256$390000$87nIZ2VDxEvLWnXsMfLwa8$uViSsYiLLTbowOtXMoa+Lr/kjKj5LDIBtEPEv2OJBo8=', '2024-06-18 16:14:34.629728', 0, '13634344345', '', '', '', 1, 1, '2024-06-18 16:14:33.649331');
INSERT INTO `auth_user` VALUES (14, 'pbkdf2_sha256$390000$6cJniC9umedvmImo4kXxAh$6GkIQ/Hk7eFv5BHYQY/i3aU8YYEgi3daGbvTG5juw7Y=', '2024-06-18 18:01:53.219270', 0, '19876564634', '', '', '', 1, 1, '2024-06-18 18:01:52.384785');
INSERT INTO `auth_user` VALUES (15, 'pbkdf2_sha256$390000$50rs9ee0TaEH3lwMkyfkue$x1bN6CXRuwMY/uD0GyJdyTtmFZnAdUPPkRDYAhQgVZQ=', '2024-08-19 06:50:47.065964', 0, '13333333333', '', '', '', 1, 1, '2024-08-19 06:50:46.897679');
INSERT INTO `auth_user` VALUES (16, 'pbkdf2_sha256$390000$HbnYL7KqajMqwimNIbvZzR$PegiEKssT9PdLLMU+o84l8QE3qvfwO79huasY87f9sE=', '2025-03-11 08:59:00.000000', 0, '2021211748', '', '', '', 1, 1, '2025-03-11 08:59:00.000000');
INSERT INTO `auth_user` VALUES (17, 'pbkdf2_sha256$390000$eVO35opdniLJSodtn4Zt54$jydLLwPGT0P2+csjszihvP6btX8zDmnxTtgXnfnZTWg=', '2025-03-11 08:59:00.000000', 0, '13956769346', '', '', '', 1, 1, '2025-03-11 08:59:00.000000');
INSERT INTO `auth_user` VALUES (18, 'pbkdf2_sha256$390000$HyuqfAF4EZ7g2svWvW2PeW$/jvX2ZRuWioguLo6TeMp8h6DVSn4nckvzQkLH7EMBgs=', NULL, 0, 'logistics_manager', '', '', '', 1, 1, '2025-03-16 06:57:00.000000');
INSERT INTO `auth_user` VALUES (19, 'pbkdf2_sha256$390000$toNa5wocra3KQA6uEyzDAX$3IsC8b2E3pKafzvdWSt105Ta+8NM4kUkAUxwSXdx+nw=', '2025-05-21 15:31:19.642313', 1, '13956767164', '', '', '', 1, 1, '2025-04-19 16:05:00.000000');
INSERT INTO `auth_user` VALUES (20, 'pbkdf2_sha256$390000$lke7DBpcx2UJl2bXNU630T$A9y6EdbtLgmJcKQKLXRl73mlpAMueSxChrukyugwCEI=', '2025-05-20 15:06:52.864310', 0, '18811507090', '', '', '', 1, 1, '2025-05-20 15:06:52.547667');
INSERT INTO `auth_user` VALUES (21, 'pbkdf2_sha256$390000$KmAtwPZHKSPIyc5KQnafuc$zPNpU1YoYop0s808iJReFAd4n8LYK7zyXP+gCo9qMp4=', '2025-05-20 15:09:06.736509', 0, '13323452345', '', '', '', 1, 1, '2025-05-20 15:08:56.674796');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------
INSERT INTO `auth_user_groups` VALUES (1, 16, 2);
INSERT INTO `auth_user_groups` VALUES (2, 17, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 385 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
INSERT INTO `auth_user_user_permissions` VALUES (153, 8, 41);
INSERT INTO `auth_user_user_permissions` VALUES (154, 8, 42);
INSERT INTO `auth_user_user_permissions` VALUES (155, 8, 43);
INSERT INTO `auth_user_user_permissions` VALUES (156, 8, 44);
INSERT INTO `auth_user_user_permissions` VALUES (157, 8, 45);
INSERT INTO `auth_user_user_permissions` VALUES (158, 8, 46);
INSERT INTO `auth_user_user_permissions` VALUES (159, 8, 47);
INSERT INTO `auth_user_user_permissions` VALUES (160, 8, 48);
INSERT INTO `auth_user_user_permissions` VALUES (161, 8, 49);
INSERT INTO `auth_user_user_permissions` VALUES (162, 8, 50);
INSERT INTO `auth_user_user_permissions` VALUES (163, 8, 51);
INSERT INTO `auth_user_user_permissions` VALUES (164, 8, 52);
INSERT INTO `auth_user_user_permissions` VALUES (165, 8, 53);
INSERT INTO `auth_user_user_permissions` VALUES (166, 8, 54);
INSERT INTO `auth_user_user_permissions` VALUES (167, 8, 55);
INSERT INTO `auth_user_user_permissions` VALUES (168, 8, 56);
INSERT INTO `auth_user_user_permissions` VALUES (169, 8, 57);
INSERT INTO `auth_user_user_permissions` VALUES (170, 8, 58);
INSERT INTO `auth_user_user_permissions` VALUES (171, 8, 59);
INSERT INTO `auth_user_user_permissions` VALUES (172, 8, 60);
INSERT INTO `auth_user_user_permissions` VALUES (173, 8, 61);
INSERT INTO `auth_user_user_permissions` VALUES (174, 8, 62);
INSERT INTO `auth_user_user_permissions` VALUES (175, 8, 63);
INSERT INTO `auth_user_user_permissions` VALUES (176, 8, 64);
INSERT INTO `auth_user_user_permissions` VALUES (177, 8, 65);
INSERT INTO `auth_user_user_permissions` VALUES (178, 8, 66);
INSERT INTO `auth_user_user_permissions` VALUES (179, 8, 67);
INSERT INTO `auth_user_user_permissions` VALUES (180, 8, 68);
INSERT INTO `auth_user_user_permissions` VALUES (181, 8, 69);
INSERT INTO `auth_user_user_permissions` VALUES (182, 8, 70);
INSERT INTO `auth_user_user_permissions` VALUES (183, 8, 71);
INSERT INTO `auth_user_user_permissions` VALUES (184, 8, 72);
INSERT INTO `auth_user_user_permissions` VALUES (185, 8, 73);
INSERT INTO `auth_user_user_permissions` VALUES (186, 8, 74);
INSERT INTO `auth_user_user_permissions` VALUES (187, 8, 75);
INSERT INTO `auth_user_user_permissions` VALUES (188, 8, 76);
INSERT INTO `auth_user_user_permissions` VALUES (189, 8, 77);
INSERT INTO `auth_user_user_permissions` VALUES (190, 8, 78);
INSERT INTO `auth_user_user_permissions` VALUES (191, 8, 79);
INSERT INTO `auth_user_user_permissions` VALUES (192, 8, 80);
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
INSERT INTO `auth_user_user_permissions` VALUES (193, 17, 1);
INSERT INTO `auth_user_user_permissions` VALUES (194, 17, 2);
INSERT INTO `auth_user_user_permissions` VALUES (195, 17, 3);
INSERT INTO `auth_user_user_permissions` VALUES (196, 17, 4);
INSERT INTO `auth_user_user_permissions` VALUES (197, 17, 5);
INSERT INTO `auth_user_user_permissions` VALUES (198, 17, 6);
INSERT INTO `auth_user_user_permissions` VALUES (199, 17, 7);
INSERT INTO `auth_user_user_permissions` VALUES (200, 17, 8);
INSERT INTO `auth_user_user_permissions` VALUES (201, 17, 9);
INSERT INTO `auth_user_user_permissions` VALUES (202, 17, 10);
INSERT INTO `auth_user_user_permissions` VALUES (203, 17, 11);
INSERT INTO `auth_user_user_permissions` VALUES (204, 17, 12);
INSERT INTO `auth_user_user_permissions` VALUES (205, 17, 13);
INSERT INTO `auth_user_user_permissions` VALUES (206, 17, 14);
INSERT INTO `auth_user_user_permissions` VALUES (207, 17, 15);
INSERT INTO `auth_user_user_permissions` VALUES (208, 17, 16);
INSERT INTO `auth_user_user_permissions` VALUES (209, 17, 17);
INSERT INTO `auth_user_user_permissions` VALUES (210, 17, 18);
INSERT INTO `auth_user_user_permissions` VALUES (211, 17, 19);
INSERT INTO `auth_user_user_permissions` VALUES (212, 17, 20);
INSERT INTO `auth_user_user_permissions` VALUES (213, 17, 21);
INSERT INTO `auth_user_user_permissions` VALUES (214, 17, 22);
INSERT INTO `auth_user_user_permissions` VALUES (215, 17, 23);
INSERT INTO `auth_user_user_permissions` VALUES (216, 17, 24);
INSERT INTO `auth_user_user_permissions` VALUES (217, 17, 25);
INSERT INTO `auth_user_user_permissions` VALUES (218, 17, 26);
INSERT INTO `auth_user_user_permissions` VALUES (219, 17, 27);
INSERT INTO `auth_user_user_permissions` VALUES (220, 17, 28);
INSERT INTO `auth_user_user_permissions` VALUES (221, 17, 29);
INSERT INTO `auth_user_user_permissions` VALUES (222, 17, 30);
INSERT INTO `auth_user_user_permissions` VALUES (223, 17, 31);
INSERT INTO `auth_user_user_permissions` VALUES (224, 17, 32);
INSERT INTO `auth_user_user_permissions` VALUES (225, 17, 33);
INSERT INTO `auth_user_user_permissions` VALUES (226, 17, 34);
INSERT INTO `auth_user_user_permissions` VALUES (227, 17, 35);
INSERT INTO `auth_user_user_permissions` VALUES (228, 17, 36);
INSERT INTO `auth_user_user_permissions` VALUES (229, 17, 37);
INSERT INTO `auth_user_user_permissions` VALUES (230, 17, 38);
INSERT INTO `auth_user_user_permissions` VALUES (231, 17, 39);
INSERT INTO `auth_user_user_permissions` VALUES (232, 17, 40);
INSERT INTO `auth_user_user_permissions` VALUES (233, 17, 41);
INSERT INTO `auth_user_user_permissions` VALUES (234, 17, 42);
INSERT INTO `auth_user_user_permissions` VALUES (235, 17, 43);
INSERT INTO `auth_user_user_permissions` VALUES (236, 17, 44);
INSERT INTO `auth_user_user_permissions` VALUES (237, 17, 45);
INSERT INTO `auth_user_user_permissions` VALUES (238, 17, 46);
INSERT INTO `auth_user_user_permissions` VALUES (239, 17, 47);
INSERT INTO `auth_user_user_permissions` VALUES (240, 17, 48);
INSERT INTO `auth_user_user_permissions` VALUES (241, 17, 49);
INSERT INTO `auth_user_user_permissions` VALUES (242, 17, 50);
INSERT INTO `auth_user_user_permissions` VALUES (243, 17, 51);
INSERT INTO `auth_user_user_permissions` VALUES (244, 17, 52);
INSERT INTO `auth_user_user_permissions` VALUES (245, 17, 53);
INSERT INTO `auth_user_user_permissions` VALUES (246, 17, 54);
INSERT INTO `auth_user_user_permissions` VALUES (247, 17, 55);
INSERT INTO `auth_user_user_permissions` VALUES (248, 17, 56);
INSERT INTO `auth_user_user_permissions` VALUES (249, 17, 57);
INSERT INTO `auth_user_user_permissions` VALUES (250, 17, 58);
INSERT INTO `auth_user_user_permissions` VALUES (251, 17, 59);
INSERT INTO `auth_user_user_permissions` VALUES (252, 17, 60);
INSERT INTO `auth_user_user_permissions` VALUES (253, 17, 61);
INSERT INTO `auth_user_user_permissions` VALUES (254, 17, 62);
INSERT INTO `auth_user_user_permissions` VALUES (255, 17, 63);
INSERT INTO `auth_user_user_permissions` VALUES (256, 17, 64);
INSERT INTO `auth_user_user_permissions` VALUES (257, 17, 65);
INSERT INTO `auth_user_user_permissions` VALUES (258, 17, 66);
INSERT INTO `auth_user_user_permissions` VALUES (259, 17, 67);
INSERT INTO `auth_user_user_permissions` VALUES (260, 17, 68);
INSERT INTO `auth_user_user_permissions` VALUES (261, 17, 69);
INSERT INTO `auth_user_user_permissions` VALUES (262, 17, 70);
INSERT INTO `auth_user_user_permissions` VALUES (263, 17, 71);
INSERT INTO `auth_user_user_permissions` VALUES (264, 17, 72);
INSERT INTO `auth_user_user_permissions` VALUES (265, 17, 73);
INSERT INTO `auth_user_user_permissions` VALUES (266, 17, 74);
INSERT INTO `auth_user_user_permissions` VALUES (267, 17, 75);
INSERT INTO `auth_user_user_permissions` VALUES (268, 17, 76);
INSERT INTO `auth_user_user_permissions` VALUES (269, 17, 77);
INSERT INTO `auth_user_user_permissions` VALUES (270, 17, 78);
INSERT INTO `auth_user_user_permissions` VALUES (271, 17, 79);
INSERT INTO `auth_user_user_permissions` VALUES (272, 17, 80);
INSERT INTO `auth_user_user_permissions` VALUES (273, 17, 81);
INSERT INTO `auth_user_user_permissions` VALUES (274, 17, 82);
INSERT INTO `auth_user_user_permissions` VALUES (275, 17, 83);
INSERT INTO `auth_user_user_permissions` VALUES (276, 17, 84);
INSERT INTO `auth_user_user_permissions` VALUES (277, 17, 85);
INSERT INTO `auth_user_user_permissions` VALUES (278, 17, 86);
INSERT INTO `auth_user_user_permissions` VALUES (279, 17, 87);
INSERT INTO `auth_user_user_permissions` VALUES (280, 17, 88);
INSERT INTO `auth_user_user_permissions` VALUES (281, 17, 89);
INSERT INTO `auth_user_user_permissions` VALUES (282, 17, 90);
INSERT INTO `auth_user_user_permissions` VALUES (283, 17, 91);
INSERT INTO `auth_user_user_permissions` VALUES (284, 17, 92);
INSERT INTO `auth_user_user_permissions` VALUES (285, 17, 93);
INSERT INTO `auth_user_user_permissions` VALUES (286, 17, 94);
INSERT INTO `auth_user_user_permissions` VALUES (287, 17, 95);
INSERT INTO `auth_user_user_permissions` VALUES (288, 17, 96);
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
INSERT INTO `auth_user_user_permissions` VALUES (289, 19, 1);
INSERT INTO `auth_user_user_permissions` VALUES (290, 19, 2);
INSERT INTO `auth_user_user_permissions` VALUES (291, 19, 3);
INSERT INTO `auth_user_user_permissions` VALUES (292, 19, 4);
INSERT INTO `auth_user_user_permissions` VALUES (293, 19, 5);
INSERT INTO `auth_user_user_permissions` VALUES (294, 19, 6);
INSERT INTO `auth_user_user_permissions` VALUES (295, 19, 7);
INSERT INTO `auth_user_user_permissions` VALUES (296, 19, 8);
INSERT INTO `auth_user_user_permissions` VALUES (297, 19, 9);
INSERT INTO `auth_user_user_permissions` VALUES (298, 19, 10);
INSERT INTO `auth_user_user_permissions` VALUES (299, 19, 11);
INSERT INTO `auth_user_user_permissions` VALUES (300, 19, 12);
INSERT INTO `auth_user_user_permissions` VALUES (301, 19, 13);
INSERT INTO `auth_user_user_permissions` VALUES (302, 19, 14);
INSERT INTO `auth_user_user_permissions` VALUES (303, 19, 15);
INSERT INTO `auth_user_user_permissions` VALUES (304, 19, 16);
INSERT INTO `auth_user_user_permissions` VALUES (305, 19, 17);
INSERT INTO `auth_user_user_permissions` VALUES (306, 19, 18);
INSERT INTO `auth_user_user_permissions` VALUES (307, 19, 19);
INSERT INTO `auth_user_user_permissions` VALUES (308, 19, 20);
INSERT INTO `auth_user_user_permissions` VALUES (309, 19, 21);
INSERT INTO `auth_user_user_permissions` VALUES (310, 19, 22);
INSERT INTO `auth_user_user_permissions` VALUES (311, 19, 23);
INSERT INTO `auth_user_user_permissions` VALUES (312, 19, 24);
INSERT INTO `auth_user_user_permissions` VALUES (313, 19, 25);
INSERT INTO `auth_user_user_permissions` VALUES (314, 19, 26);
INSERT INTO `auth_user_user_permissions` VALUES (315, 19, 27);
INSERT INTO `auth_user_user_permissions` VALUES (316, 19, 28);
INSERT INTO `auth_user_user_permissions` VALUES (317, 19, 29);
INSERT INTO `auth_user_user_permissions` VALUES (318, 19, 30);
INSERT INTO `auth_user_user_permissions` VALUES (319, 19, 31);
INSERT INTO `auth_user_user_permissions` VALUES (320, 19, 32);
INSERT INTO `auth_user_user_permissions` VALUES (321, 19, 33);
INSERT INTO `auth_user_user_permissions` VALUES (322, 19, 34);
INSERT INTO `auth_user_user_permissions` VALUES (323, 19, 35);
INSERT INTO `auth_user_user_permissions` VALUES (324, 19, 36);
INSERT INTO `auth_user_user_permissions` VALUES (325, 19, 37);
INSERT INTO `auth_user_user_permissions` VALUES (326, 19, 38);
INSERT INTO `auth_user_user_permissions` VALUES (327, 19, 39);
INSERT INTO `auth_user_user_permissions` VALUES (328, 19, 40);
INSERT INTO `auth_user_user_permissions` VALUES (329, 19, 41);
INSERT INTO `auth_user_user_permissions` VALUES (330, 19, 42);
INSERT INTO `auth_user_user_permissions` VALUES (331, 19, 43);
INSERT INTO `auth_user_user_permissions` VALUES (332, 19, 44);
INSERT INTO `auth_user_user_permissions` VALUES (333, 19, 45);
INSERT INTO `auth_user_user_permissions` VALUES (334, 19, 46);
INSERT INTO `auth_user_user_permissions` VALUES (335, 19, 47);
INSERT INTO `auth_user_user_permissions` VALUES (336, 19, 48);
INSERT INTO `auth_user_user_permissions` VALUES (337, 19, 49);
INSERT INTO `auth_user_user_permissions` VALUES (338, 19, 50);
INSERT INTO `auth_user_user_permissions` VALUES (339, 19, 51);
INSERT INTO `auth_user_user_permissions` VALUES (340, 19, 52);
INSERT INTO `auth_user_user_permissions` VALUES (341, 19, 53);
INSERT INTO `auth_user_user_permissions` VALUES (342, 19, 54);
INSERT INTO `auth_user_user_permissions` VALUES (343, 19, 55);
INSERT INTO `auth_user_user_permissions` VALUES (344, 19, 56);
INSERT INTO `auth_user_user_permissions` VALUES (345, 19, 57);
INSERT INTO `auth_user_user_permissions` VALUES (346, 19, 58);
INSERT INTO `auth_user_user_permissions` VALUES (347, 19, 59);
INSERT INTO `auth_user_user_permissions` VALUES (348, 19, 60);
INSERT INTO `auth_user_user_permissions` VALUES (349, 19, 61);
INSERT INTO `auth_user_user_permissions` VALUES (350, 19, 62);
INSERT INTO `auth_user_user_permissions` VALUES (351, 19, 63);
INSERT INTO `auth_user_user_permissions` VALUES (352, 19, 64);
INSERT INTO `auth_user_user_permissions` VALUES (353, 19, 65);
INSERT INTO `auth_user_user_permissions` VALUES (354, 19, 66);
INSERT INTO `auth_user_user_permissions` VALUES (355, 19, 67);
INSERT INTO `auth_user_user_permissions` VALUES (356, 19, 68);
INSERT INTO `auth_user_user_permissions` VALUES (357, 19, 69);
INSERT INTO `auth_user_user_permissions` VALUES (358, 19, 70);
INSERT INTO `auth_user_user_permissions` VALUES (359, 19, 71);
INSERT INTO `auth_user_user_permissions` VALUES (360, 19, 72);
INSERT INTO `auth_user_user_permissions` VALUES (361, 19, 73);
INSERT INTO `auth_user_user_permissions` VALUES (362, 19, 74);
INSERT INTO `auth_user_user_permissions` VALUES (363, 19, 75);
INSERT INTO `auth_user_user_permissions` VALUES (364, 19, 76);
INSERT INTO `auth_user_user_permissions` VALUES (365, 19, 77);
INSERT INTO `auth_user_user_permissions` VALUES (366, 19, 78);
INSERT INTO `auth_user_user_permissions` VALUES (367, 19, 79);
INSERT INTO `auth_user_user_permissions` VALUES (368, 19, 80);
INSERT INTO `auth_user_user_permissions` VALUES (369, 19, 81);
INSERT INTO `auth_user_user_permissions` VALUES (370, 19, 82);
INSERT INTO `auth_user_user_permissions` VALUES (371, 19, 83);
INSERT INTO `auth_user_user_permissions` VALUES (372, 19, 84);
INSERT INTO `auth_user_user_permissions` VALUES (373, 19, 85);
INSERT INTO `auth_user_user_permissions` VALUES (374, 19, 86);
INSERT INTO `auth_user_user_permissions` VALUES (375, 19, 87);
INSERT INTO `auth_user_user_permissions` VALUES (376, 19, 88);
INSERT INTO `auth_user_user_permissions` VALUES (377, 19, 89);
INSERT INTO `auth_user_user_permissions` VALUES (378, 19, 90);
INSERT INTO `auth_user_user_permissions` VALUES (379, 19, 91);
INSERT INTO `auth_user_user_permissions` VALUES (380, 19, 92);
INSERT INTO `auth_user_user_permissions` VALUES (381, 19, 93);
INSERT INTO `auth_user_user_permissions` VALUES (382, 19, 94);
INSERT INTO `auth_user_user_permissions` VALUES (383, 19, 95);
INSERT INTO `auth_user_user_permissions` VALUES (384, 19, 96);

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of commodity_commodityinfos
-- ----------------------------
INSERT INTO `commodity_commodityinfos` VALUES (1, '2024新款平板电脑护眼官方正品', '黑', '平板电脑', 599, 399, 2000, 6, 0, '2024-06-18', 'imgs/v1d.png', 'details/v1m.jpg', 1018);
INSERT INTO `commodity_commodityinfos` VALUES (2, '2024新款平板电脑护眼官方正品', '白', '平板电脑', 799, 399, 888, 4, 1, '2024-06-18', 'imgs/v2d_My7JK7V.png', 'details/v2m.jpg', 1003);
INSERT INTO `commodity_commodityinfos` VALUES (3, '双屏三防加固笔记本', '黑', '笔记本电脑', 25800, 23800, 999, 0, 1, '2024-06-18', 'imgs/v3d.png', 'details/v3m.jpg', 1000);
INSERT INTO `commodity_commodityinfos` VALUES (4, '2024英特尔全新游戏超薄笔记本电脑', '白', '笔记本电脑', 1192, 832, 9977, 0, 0, '2024-06-18', 'imgs/v4d.png', 'details/v4m.jpg', 999);
INSERT INTO `commodity_commodityinfos` VALUES (5, '神舟战神S8/Z8系列笔记本电脑', '黑', '游戏本', 6451, 5789, 666, 0, 0, '2024-06-18', 'imgs/v5d.png', 'details/v5m.jpg', 1009);
INSERT INTO `commodity_commodityinfos` VALUES (6, 'Asus/华硕天选16英寸游戏本电脑', '黑', '游戏本', 7099, 6789, 776, 0, 0, '2024-06-18', 'imgs/v6d.png', 'details/v6mm.jpg', 999);
INSERT INTO `commodity_commodityinfos` VALUES (7, 'REDMI Book Pro 14 2025', '黑色', '笔记本电脑', 5299, 5299, 10, 0, 1, '2025-04-19', 'imgs/v7_MYW95C7.png', 'details/v7_wbWoNaX.jpg', 9);
INSERT INTO `commodity_commodityinfos` VALUES (8, 'REDMI Turbo 4 Pro', '绿色', '性价比系列', 1999, 1999, 10, 0, 0, '2025-04-27', 'imgs/v8.png', 'details/v8.png', 10);

-- ----------------------------
-- Table structure for commodity_types
-- ----------------------------
DROP TABLE IF EXISTS `commodity_types`;
CREATE TABLE `commodity_types`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firsts` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `seconds` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
INSERT INTO `commodity_types` VALUES (23, '智能手机', '性价比系列');

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
) ENGINE = InnoDB AUTO_INCREMENT = 164 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
INSERT INTO `django_admin_log` VALUES (54, '2025-03-25 08:19:31.621729', '1', 'ProcurementOrder object (1)', 1, '[{\"added\": {}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (55, '2025-03-25 08:41:36.924362', '2', '采购计划PO-20250325-002| 2024新款平板电脑护眼官方正品| 2', 1, '[{\"added\": {}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (56, '2025-03-25 08:45:45.921070', '3', '采购计划PPO-20250325-001| 2024新款平板电脑护眼官方正品| 3', 1, '[{\"added\": {}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (57, '2025-04-01 11:49:19.610310', '4', '订单号：PPO-20250401-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250401-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x22\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250401-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x22\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (58, '2025-04-01 11:49:46.657721', '4', '订单号：PPO-20250401-001', 3, '', 19, 8);
INSERT INTO `django_admin_log` VALUES (59, '2025-04-01 11:50:03.829198', '5', '订单号：PPO-20250401-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250401-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x2\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250401-001 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x2\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250401-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x23\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (60, '2025-04-01 11:50:33.703889', '5', '订单号：PPO-20250401-001', 2, '[{\"changed\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250401-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x0\", \"fields\": [\"\\u91c7\\u8d2d\\u6570\\u91cf\"]}}, {\"changed\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250401-001 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x0\", \"fields\": [\"\\u91c7\\u8d2d\\u6570\\u91cf\"]}}, {\"changed\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250401-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x0\", \"fields\": [\"\\u91c7\\u8d2d\\u6570\\u91cf\"]}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (61, '2025-04-01 11:57:16.404243', '5', '订单号：PPO-20250401-001', 2, '[{\"deleted\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250401-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (62, '2025-04-02 12:27:47.191799', '8', 'admin', 2, '[{\"changed\": {\"fields\": [\"User permissions\", \"Last login\"]}}]', 4, 8);
INSERT INTO `django_admin_log` VALUES (63, '2025-04-07 12:21:05.982616', '6', '订单号：PPO-20250407-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250407-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x2\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250407-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250407-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x2\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (64, '2025-04-07 13:30:56.049080', '6', '订单号：PO-20250407-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250407-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250407-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x0\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250407-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x0\"}}]', 15, 8);
INSERT INTO `django_admin_log` VALUES (65, '2025-04-07 13:34:58.099585', '6', '订单号：PO-20250407-001', 2, '[]', 15, 8);
INSERT INTO `django_admin_log` VALUES (66, '2025-04-08 07:45:42.563845', '7', '订单号：PPO-20250408-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250408-001 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x2\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250408-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250408-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x5\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (67, '2025-04-08 07:51:56.165721', '7', '订单号：PO-20250408-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250408-001 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x0\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250408-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x0\"}}]', 15, 8);
INSERT INTO `django_admin_log` VALUES (68, '2025-04-08 15:58:29.982507', '8', '订单号：PPO-20250408-002', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250408-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x4\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250408-002 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x7\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250408-002 - \\u795e\\u821f\\u6218\\u795eS8/Z8\\u7cfb\\u5217\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x5\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (69, '2025-04-08 15:58:46.791702', '8', '订单号：PO-20250408-004', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250408-004 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x0\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250408-004 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x0\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250408-004 - \\u795e\\u821f\\u6218\\u795eS8/Z8\\u7cfb\\u5217\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x0\"}}]', 15, 8);
INSERT INTO `django_admin_log` VALUES (70, '2025-04-08 17:06:35.514775', '9', '订单号：PPO-20250408-003', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250408-003 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x4\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250408-003 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x7\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250408-003 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (71, '2025-04-08 17:06:41.814539', '9', '订单号：PO-20250408-005', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250408-005 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x0\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250408-005 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x0\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250408-005 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x0\"}}]', 15, 8);
INSERT INTO `django_admin_log` VALUES (72, '2025-04-11 10:37:33.829416', '10', '订单号：PPO-20250411-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250411-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x4\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250411-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x7\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (73, '2025-04-11 10:37:50.117237', '10', '订单号：PO-20250411-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250411-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x1\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250411-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x0\"}}]', 15, 8);
INSERT INTO `django_admin_log` VALUES (74, '2025-04-11 10:50:04.338294', '11', '订单号：PPO-20250411-002', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250411-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x4\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250411-002 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x7\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (75, '2025-04-11 10:54:51.247794', '12', '订单号：PPO-20250411-003', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250411-003 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x4\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250411-003 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x7\"}}]', 19, 8);
INSERT INTO `django_admin_log` VALUES (76, '2025-04-15 15:38:57.774123', '12', '订单号：PO-20250415-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250415-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x2\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250415-001 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x0\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250415-001 - \\u795e\\u821f\\u6218\\u795eS8/Z8\\u7cfb\\u5217\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x0\"}}]', 15, 8);
INSERT INTO `django_admin_log` VALUES (77, '2025-04-17 20:06:53.390567', '1', '安徽省阜阳市太和县城关镇文明西路墨香苑6号楼2单元', 1, '[{\"added\": {}}]', 13, 8);
INSERT INTO `django_admin_log` VALUES (78, '2025-04-17 20:14:01.564823', '2', '北京市市辖区昌平区北京邮电大学沙河校区', 1, '[{\"added\": {}}]', 13, 8);
INSERT INTO `django_admin_log` VALUES (79, '2025-04-18 08:52:05.046869', '3', '北京市市辖区大兴区北京邮电大学沙河校区', 1, '[{\"added\": {}}]', 13, 8);
INSERT INTO `django_admin_log` VALUES (80, '2025-04-18 08:52:20.221445', '3', '北京市市辖区大兴区北京邮电大学沙河校区', 3, '', 13, 8);
INSERT INTO `django_admin_log` VALUES (81, '2025-04-18 08:55:01.580021', '6', '6', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"1\"}}]', 10, 8);
INSERT INTO `django_admin_log` VALUES (82, '2025-04-18 10:45:27.451758', '4', '4@13800138006@2025-03-15@已支付@599.0', 3, '', 10, 8);
INSERT INTO `django_admin_log` VALUES (83, '2025-04-18 10:45:27.456542', '3', '3@13800138006@2025-03-14@已支付@599.0', 3, '', 10, 8);
INSERT INTO `django_admin_log` VALUES (84, '2025-04-18 10:45:27.460609', '2', '2@13800138006@2024-06-19@已支付@799.0', 3, '', 10, 8);
INSERT INTO `django_admin_log` VALUES (85, '2025-04-18 10:45:27.465088', '1', '1@13800138006@2024-06-19@已支付@25800.0', 3, '', 10, 8);
INSERT INTO `django_admin_log` VALUES (86, '2025-04-18 10:45:52.710048', '7', '7@2021211748@2025-04-18@已支付@8357.0', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"2\"}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"3\"}}]', 10, 8);
INSERT INTO `django_admin_log` VALUES (87, '2025-04-18 10:46:05.699997', '8', '8@2021211748@2025-04-18@已支付@7250.0', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"4\"}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"5\"}}]', 10, 8);
INSERT INTO `django_admin_log` VALUES (88, '2025-04-18 20:46:56.719722', '2', '出库单号: OB-20250418-001 (关联销售单数: 1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250418-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x1\"}}]', 14, 8);
INSERT INTO `django_admin_log` VALUES (89, '2025-04-18 20:47:26.816172', '2', '出库单号: OB-20250418-001 (关联销售单数: 1)', 3, '', 14, 8);
INSERT INTO `django_admin_log` VALUES (90, '2025-04-18 20:50:39.497324', '4', '出库单号: OB-20250418-001 (关联销售单数: 1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250418-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x1\"}}]', 14, 8);
INSERT INTO `django_admin_log` VALUES (91, '2025-04-18 20:56:32.036127', '4', '出库单号: OB-20250418-001 (关联销售单数: 1)', 3, '', 14, 8);
INSERT INTO `django_admin_log` VALUES (92, '2025-04-18 20:56:36.470125', '5', '出库单号: OB-20250418-001 (关联销售单数: 1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250418-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x1\"}}]', 14, 8);
INSERT INTO `django_admin_log` VALUES (93, '2025-04-18 20:57:40.450874', '6', '出库单号: OB-20250418-002 (关联销售单数: 1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250418-002 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x5\"}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250418-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x3\"}}]', 14, 8);
INSERT INTO `django_admin_log` VALUES (94, '2025-04-19 13:16:15.824139', '7', '出库单号: OB-20250419-001 (关联销售单数: 1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250419-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250419-001 - \\u795e\\u821f\\u6218\\u795eS8/Z8\\u7cfb\\u5217\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x1\"}}]', 14, 8);
INSERT INTO `django_admin_log` VALUES (95, '2025-04-19 13:55:19.916892', '9', '9@2021211748@2025-04-19@已支付@2983.0', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"6\"}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"7\"}}]', 10, 8);
INSERT INTO `django_admin_log` VALUES (96, '2025-04-19 15:59:18.651177', '7', 'REDMI Book Pro 14 2025@10@黑色', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (97, '2025-04-19 16:07:21.073978', '1', '2024新款平板电脑护眼官方正品@2000@黑', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4e3b\\u56fe\", \"\\u5546\\u54c1\\u4ecb\\u7ecd\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (98, '2025-04-19 16:07:51.516044', '2', '2024新款平板电脑护眼官方正品@888@白', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4ecb\\u7ecd\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (99, '2025-04-19 16:07:51.528748', '3', '双屏三防加固笔记本@999@黑', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4ecb\\u7ecd\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (100, '2025-04-19 16:08:38.579285', '2', '2024新款平板电脑护眼官方正品@888@白', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4e3b\\u56fe\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (101, '2025-04-19 16:08:38.591891', '3', '双屏三防加固笔记本@999@黑', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4e3b\\u56fe\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (102, '2025-04-19 16:08:38.606661', '4', '2024英特尔全新游戏超薄笔记本电脑@9977@白', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4e3b\\u56fe\", \"\\u5546\\u54c1\\u4ecb\\u7ecd\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (103, '2025-04-19 16:08:38.621280', '5', '神舟战神S8/Z8系列笔记本电脑@666@黑', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4e3b\\u56fe\", \"\\u5546\\u54c1\\u4ecb\\u7ecd\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (104, '2025-04-19 16:08:38.635816', '6', 'Asus/华硕天选16英寸游戏本电脑@776@黑', 2, '[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u4e3b\\u56fe\", \"\\u5546\\u54c1\\u4ecb\\u7ecd\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (105, '2025-04-19 16:18:10.640763', '1', '2024新款平板电脑护眼官方正品@2000@黑', 2, '[{\"changed\": {\"fields\": [\"\\u5df2\\u552e\\u6570\\u91cf\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (106, '2025-04-20 11:53:23.203939', '10', '10@13956769346@2025-04-20@已支付@5299.0', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"8\"}}]', 10, 8);
INSERT INTO `django_admin_log` VALUES (107, '2025-04-20 11:53:35.832993', '8', '出库单号: OB-20250420-001 (关联销售单数: 1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250420-001 - REDMI Book Pro 14 2025 x1\"}}]', 14, 8);
INSERT INTO `django_admin_log` VALUES (108, '2025-04-20 11:54:32.010625', '11', '11@13956767164@2025-04-20@已支付@5299.0', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"9\"}}]', 10, 8);
INSERT INTO `django_admin_log` VALUES (109, '2025-04-21 10:44:13.323042', '1', '1', 1, '[{\"added\": {}}]', 11, 8);
INSERT INTO `django_admin_log` VALUES (110, '2025-04-21 11:11:40.852878', '1', '1', 3, '', 11, 8);
INSERT INTO `django_admin_log` VALUES (111, '2025-04-21 11:11:46.715407', '17', '17@13956767164@2025-04-20@退款成功@1398.0', 3, '', 10, 8);
INSERT INTO `django_admin_log` VALUES (112, '2025-04-21 11:12:02.112474', '18', '18@2021211748@2025-04-21@已支付@8835.0', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"20\"}}, {\"added\": {\"name\": \"\\u8d2d\\u4e70\\u4fe1\\u606f\", \"object\": \"21\"}}]', 10, 8);
INSERT INTO `django_admin_log` VALUES (113, '2025-04-21 11:13:36.179885', '2', '2', 1, '[{\"added\": {}}]', 11, 8);
INSERT INTO `django_admin_log` VALUES (114, '2025-04-21 11:14:30.139793', '2', '2', 3, '', 11, 8);
INSERT INTO `django_admin_log` VALUES (115, '2025-04-21 11:14:36.815311', '18', '18@2021211748@2025-04-21@已支付@8835.0', 3, '', 10, 8);
INSERT INTO `django_admin_log` VALUES (116, '2025-04-21 15:29:19.325548', '1', '物流单: LO-20250421-001 (采购单: PO-20250408-005)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u7269\\u6d41\\u5355\\u9879\", \"object\": \"LO-20250421-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x1\"}}]', 18, 8);
INSERT INTO `django_admin_log` VALUES (117, '2025-04-21 15:39:21.970090', '1', '物流单: LO-20250421-001 (采购单: PO-20250408-005)', 3, '', 18, 8);
INSERT INTO `django_admin_log` VALUES (118, '2025-04-21 15:40:35.857217', '2', '物流单: LO-20250421-001 (采购单: PO-20250408-001)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u7269\\u6d41\\u5355\\u9879\", \"object\": \"LO-20250421-001 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x1\"}}]', 18, 8);
INSERT INTO `django_admin_log` VALUES (119, '2025-04-21 15:40:41.929070', '2', '物流单: LO-20250421-001 (采购单: PO-20250408-001)', 3, '', 18, 8);
INSERT INTO `django_admin_log` VALUES (120, '2025-04-21 15:44:59.223659', '11', '北京市市辖区朝阳区公司发货地址', 1, '[{\"added\": {}}]', 13, 8);
INSERT INTO `django_admin_log` VALUES (121, '2025-04-21 16:12:47.435165', '3', '物流单: LO-20250421-001 (采购单: PO-20250407-001)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u7269\\u6d41\\u5355\\u9879\", \"object\": \"LO-20250421-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x2\"}}]', 18, 8);
INSERT INTO `django_admin_log` VALUES (122, '2025-04-21 16:12:53.881362', '3', '物流单: LO-20250421-001 (采购单: PO-20250407-001)', 3, '', 18, 8);
INSERT INTO `django_admin_log` VALUES (123, '2025-04-21 20:14:53.209565', '11', '北京市市辖区朝阳区本所在公司地址', 2, '[{\"changed\": {\"fields\": [\"\\u8be6\\u7ec6\\u5730\\u5740\", \"\\u6536\\u4ef6\\u4eba\\u59d3\\u540d\"]}}]', 13, 8);
INSERT INTO `django_admin_log` VALUES (124, '2025-04-21 20:16:27.541728', '12', '山西省太原市杏花岭区采购公司所在地', 1, '[{\"added\": {}}]', 13, 8);
INSERT INTO `django_admin_log` VALUES (125, '2025-04-24 21:00:30.253325', '17', '13956769346', 2, '[{\"changed\": {\"fields\": [\"Groups\", \"User permissions\", \"Last login\"]}}]', 4, 8);
INSERT INTO `django_admin_log` VALUES (126, '2025-04-24 21:01:10.123078', '19', '13956767164', 2, '[{\"changed\": {\"fields\": [\"Superuser status\", \"User permissions\", \"Last login\"]}}]', 4, 8);
INSERT INTO `django_admin_log` VALUES (127, '2025-04-24 21:29:28.520836', '5', '运输单: LO-20250424-001 (出库单: OB-20250420-001: 销售单: 10)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8fd0\\u8f93\\u5355\\u9879\", \"object\": \"LO-20250424-001 - REDMI Book Pro 14 2025 x1\"}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (128, '2025-04-26 21:46:13.228743', '9', '出库单号: OB-20250426-001 (关联销售单数: 1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250426-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250426-001 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x2\"}}]', 14, 19);
INSERT INTO `django_admin_log` VALUES (129, '2025-04-26 21:46:55.508720', '10', '出库单号: OB-20250426-002 (关联销售单数: 1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250426-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250426-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}]', 14, 19);
INSERT INTO `django_admin_log` VALUES (130, '2025-04-26 21:51:00.118211', '11', '出库单号: OB-20250426-003 (关联销售单数: 1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u51fa\\u5e93\\u5355\\u9879\", \"object\": \"OB-20250426-003 - REDMI Book Pro 14 2025 x1\"}}]', 14, 19);
INSERT INTO `django_admin_log` VALUES (131, '2025-04-26 21:55:11.141442', '1', 'PurchaseStockInOrder object (1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"PSO-20250426-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x2\"}}, {\"added\": {\"name\": \"\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"PSO-20250426-001 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x0\"}}, {\"added\": {\"name\": \"\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"PSO-20250426-001 - \\u795e\\u821f\\u6218\\u795eS8/Z8\\u7cfb\\u5217\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x0\"}}]', 27, 19);
INSERT INTO `django_admin_log` VALUES (132, '2025-04-26 22:04:44.117409', '2', 'PurchaseStockInOrder object (2)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"PSO-20250426-002 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x1\"}}, {\"added\": {\"name\": \"\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"PSO-20250426-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x0\"}}]', 27, 19);
INSERT INTO `django_admin_log` VALUES (133, '2025-04-27 09:02:22.407504', '6', '运输单: LO-20250427-001 (出库单: OB-20250418-001: 销售单: 6)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8fd0\\u8f93\\u5355\\u9879\", \"object\": \"LO-20250427-001 - \\u53cc\\u5c4f\\u4e09\\u9632\\u52a0\\u56fa\\u7b14\\u8bb0\\u672c x1\"}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (134, '2025-04-27 09:02:31.688079', '7', '运输单: LO-20250427-002 (出库单: OB-20250418-002: 销售单: 7)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8fd0\\u8f93\\u5355\\u9879\", \"object\": \"LO-20250427-002 - 2024\\u82f1\\u7279\\u5c14\\u5168\\u65b0\\u6e38\\u620f\\u8d85\\u8584\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x5\"}}, {\"added\": {\"name\": \"\\u8fd0\\u8f93\\u5355\\u9879\", \"object\": \"LO-20250427-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x3\"}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (135, '2025-04-27 09:02:44.803249', '8', '运输单: LO-20250427-003 (出库单: OB-20250419-001: 销售单: 8)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8fd0\\u8f93\\u5355\\u9879\", \"object\": \"LO-20250427-003 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u8fd0\\u8f93\\u5355\\u9879\", \"object\": \"LO-20250427-003 - \\u795e\\u821f\\u6218\\u795eS8/Z8\\u7cfb\\u5217\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x1\"}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (136, '2025-04-27 09:03:23.679951', '9', '运输单: LO-20250427-004 (出库单: OB-20250426-003: 销售单: 11)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8fd0\\u8f93\\u5355\\u9879\", \"object\": \"LO-20250427-004 - REDMI Book Pro 14 2025 x1\"}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (137, '2025-04-27 09:03:52.249226', '10', '运输单: LO-20250427-005 (出库单: OB-20250426-002: 销售单: 19)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u8fd0\\u8f93\\u5355\\u9879\", \"object\": \"LO-20250427-005 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u8fd0\\u8f93\\u5355\\u9879\", \"object\": \"LO-20250427-005 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (138, '2025-04-27 09:28:46.868234', '19', '19@13956767164@2025-04-22@已发货@1398.0', 2, '[{\"changed\": {\"fields\": [\"\\u8ba2\\u5355\\u72b6\\u6001\"]}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (139, '2025-04-27 09:28:46.878047', '11', '11@13956767164@2025-04-20@已发货@5299.0', 2, '[{\"changed\": {\"fields\": [\"\\u8ba2\\u5355\\u72b6\\u6001\"]}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (140, '2025-04-27 09:28:51.230880', '10', '运输单: LO-20250427-005 (出库单: OB-20250426-002: 销售单: 19)', 2, '[{\"changed\": {\"fields\": [\"\\u7269\\u6d41\\u72b6\\u6001\"]}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (141, '2025-04-27 09:28:51.248443', '9', '运输单: LO-20250427-004 (出库单: OB-20250426-003: 销售单: 11)', 2, '[{\"changed\": {\"fields\": [\"\\u7269\\u6d41\\u72b6\\u6001\"]}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (142, '2025-04-27 09:29:14.508417', '19', '19@13956767164@2025-04-22@已发货@1398.0', 2, '[{\"changed\": {\"fields\": [\"\\u8ba2\\u5355\\u72b6\\u6001\"]}}]', 10, 19);
INSERT INTO `django_admin_log` VALUES (143, '2025-04-27 09:29:19.080157', '10', '运输单: LO-20250427-005 (出库单: OB-20250426-002: 销售单: 19)', 2, '[{\"changed\": {\"fields\": [\"\\u7269\\u6d41\\u72b6\\u6001\"]}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (144, '2025-04-27 09:36:57.677870', '10', '运输单: LO-20250427-005 (出库单: OB-20250426-002: 销售单: 19)', 2, '[{\"changed\": {\"fields\": [\"\\u7269\\u6d41\\u72b6\\u6001\"]}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (145, '2025-04-27 09:36:57.693537', '9', '运输单: LO-20250427-004 (出库单: OB-20250426-003: 销售单: 11)', 2, '[{\"changed\": {\"fields\": [\"\\u7269\\u6d41\\u72b6\\u6001\"]}}]', 18, 19);
INSERT INTO `django_admin_log` VALUES (146, '2025-04-27 09:47:50.249578', '4', '4', 2, '[{\"changed\": {\"fields\": [\"\\u9000\\u6b3e\\u539f\\u56e0\"]}}]', 11, 19);
INSERT INTO `django_admin_log` VALUES (147, '2025-04-27 09:50:46.606801', '23', '23', 1, '[{\"added\": {}}]', 8, 19);
INSERT INTO `django_admin_log` VALUES (148, '2025-04-27 09:52:01.751995', '8', 'REDMI Turbo 4 Pro@10@绿色', 1, '[{\"added\": {}}]', 7, 19);
INSERT INTO `django_admin_log` VALUES (149, '2025-04-27 11:32:38.312671', '13', '天津市市辖区河东区太和县', 1, '[{\"added\": {}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (150, '2025-04-27 11:33:41.494067', '13', '天津市市辖区河东区太和县', 3, '', 13, 19);
INSERT INTO `django_admin_log` VALUES (151, '2025-04-27 11:34:41.942639', '14', '北京市市辖区西城区太和县', 1, '[{\"added\": {}}]', 13, 19);
INSERT INTO `django_admin_log` VALUES (152, '2025-04-27 11:34:48.119404', '14', '北京市市辖区西城区太和县', 3, '', 13, 19);
INSERT INTO `django_admin_log` VALUES (153, '2025-05-21 17:46:19.900298', '10', 'PurchaseStockInOrder object (10)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"PSO-20250521-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}]', 27, 19);
INSERT INTO `django_admin_log` VALUES (154, '2025-05-21 17:48:40.427500', '13', '订单号：PPO-20250521-001', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250521-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x13\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PPO-20250521-001 - \\u795e\\u821f\\u6218\\u795eS8/Z8\\u7cfb\\u5217\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x11\"}}]', 19, 19);
INSERT INTO `django_admin_log` VALUES (155, '2025-05-21 17:49:20.525219', '13', 'PO-20250521-001@20@2@待执行@2025-05-28', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250521-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x10\"}}, {\"added\": {\"name\": \"\\u91c7\\u8d2d\\u8ba2\\u5355\\u9879\", \"object\": \"PO-20250521-001 - \\u795e\\u821f\\u6218\\u795eS8/Z8\\u7cfb\\u5217\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x10\"}}]', 15, 19);
INSERT INTO `django_admin_log` VALUES (156, '2025-05-21 17:49:41.378205', '11', 'PurchaseStockInOrder object (11)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"PSO-20250521-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x10\"}}, {\"added\": {\"name\": \"\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"PSO-20250521-002 - \\u795e\\u821f\\u6218\\u795eS8/Z8\\u7cfb\\u5217\\u7b14\\u8bb0\\u672c\\u7535\\u8111 x10\"}}]', 27, 19);
INSERT INTO `django_admin_log` VALUES (157, '2025-05-21 17:51:49.715767', '13', 'PurchaseStockInOrder object (13)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"PSO-20250521-003 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x2\"}}]', 27, 19);
INSERT INTO `django_admin_log` VALUES (158, '2025-05-21 20:17:04.016711', '1', 'RefundStockInOrder object (1)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u9000\\u6b3e\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"RSO-20250521-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u9000\\u6b3e\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"RSO-20250521-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}]', 25, 19);
INSERT INTO `django_admin_log` VALUES (159, '2025-05-21 20:28:31.505011', '1', 'RefundStockInOrder object (1)', 3, '', 25, 19);
INSERT INTO `django_admin_log` VALUES (160, '2025-05-21 20:31:48.466192', '2', 'RefundStockInOrder object (2)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u9000\\u6b3e\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"RSO-20250521-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u9000\\u6b3e\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"RSO-20250521-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}]', 25, 19);
INSERT INTO `django_admin_log` VALUES (161, '2025-05-21 20:35:43.324146', '2', 'RefundStockInOrder object (2)', 3, '', 25, 19);
INSERT INTO `django_admin_log` VALUES (162, '2025-05-21 20:35:57.847615', '3', 'RefundStockInOrder object (3)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u9000\\u6b3e\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"RSO-20250521-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u9000\\u6b3e\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"RSO-20250521-001 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}]', 25, 19);
INSERT INTO `django_admin_log` VALUES (163, '2025-05-21 20:36:49.399052', '4', 'RefundStockInOrder object (4)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"\\u9000\\u6b3e\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"RSO-20250521-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}, {\"added\": {\"name\": \"\\u9000\\u6b3e\\u5165\\u5e93\\u5355\\u9879\", \"object\": \"RSO-20250521-002 - 2024\\u65b0\\u6b3e\\u5e73\\u677f\\u7535\\u8111\\u62a4\\u773c\\u5b98\\u65b9\\u6b63\\u54c1 x1\"}}]', 25, 19);

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
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
INSERT INTO `django_content_type` VALUES (24, 'logistics', 'logisticsorderitem');
INSERT INTO `django_content_type` VALUES (14, 'logistics', 'outboundorder');
INSERT INTO `django_content_type` VALUES (17, 'logistics', 'outboundorderitem');
INSERT INTO `django_content_type` VALUES (19, 'logistics', 'procurementorder');
INSERT INTO `django_content_type` VALUES (20, 'logistics', 'procurementorderitem');
INSERT INTO `django_content_type` VALUES (15, 'logistics', 'purchaseorder');
INSERT INTO `django_content_type` VALUES (21, 'logistics', 'purchaseorderitem');
INSERT INTO `django_content_type` VALUES (27, 'logistics', 'purchasestockinorder');
INSERT INTO `django_content_type` VALUES (28, 'logistics', 'purchasestockinorderitem');
INSERT INTO `django_content_type` VALUES (16, 'logistics', 'stockinorder');
INSERT INTO `django_content_type` VALUES (23, 'logistics', 'stockinorderitem');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (13, 'shopper', 'addressinfos');
INSERT INTO `django_content_type` VALUES (9, 'shopper', 'cartinfos');
INSERT INTO `django_content_type` VALUES (10, 'shopper', 'orderinfos');
INSERT INTO `django_content_type` VALUES (12, 'shopper', 'purchaseinfos');
INSERT INTO `django_content_type` VALUES (11, 'shopper', 'refundinfos');
INSERT INTO `django_content_type` VALUES (25, 'shopper', 'refundstockinorder');
INSERT INTO `django_content_type` VALUES (26, 'shopper', 'refundstockinorderitem');
INSERT INTO `django_content_type` VALUES (22, 'shopper', 'region');

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
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
INSERT INTO `django_migrations` VALUES (28, 'logistics', '0003_alter_logisticsorder_options_and_more', '2025-03-25 08:18:17.432920');
INSERT INTO `django_migrations` VALUES (29, 'logistics', '0004_alter_procurementorder_options_and_more', '2025-04-01 06:08:51.843653');
INSERT INTO `django_migrations` VALUES (30, 'logistics', '0005_alter_procurementorder_options_and_more', '2025-04-01 06:11:29.408802');
INSERT INTO `django_migrations` VALUES (31, 'logistics', '0006_procurementorder_due_date', '2025-04-01 07:44:10.277656');
INSERT INTO `django_migrations` VALUES (32, 'logistics', '0007_remove_purchaseorder_actual_quantity_and_more', '2025-04-07 12:19:02.901761');
INSERT INTO `django_migrations` VALUES (33, 'logistics', '0008_alter_outboundorder_options_and_more', '2025-04-17 10:55:14.864844');
INSERT INTO `django_migrations` VALUES (34, 'logistics', '0009_alter_outboundorderitem_unique_together_and_more', '2025-04-17 11:15:15.078165');
INSERT INTO `django_migrations` VALUES (35, 'shopper', '0006_alter_addressinfos_options_and_more', '2025-04-17 19:05:13.497212');
INSERT INTO `django_migrations` VALUES (36, 'shopper', '0007_addressinfos_phone_number_and_more', '2025-04-17 20:02:58.935949');
INSERT INTO `django_migrations` VALUES (37, 'shopper', '0008_alter_orderinfos_address_alter_orderinfos_state', '2025-04-18 09:11:04.348654');
INSERT INTO `django_migrations` VALUES (38, 'logistics', '0010_remove_outboundorder_sales_order_and_more', '2025-04-18 09:11:04.980338');
INSERT INTO `django_migrations` VALUES (39, 'commodity', '0003_alter_commodityinfos_inventory_and_more', '2025-04-20 20:17:26.533762');
INSERT INTO `django_migrations` VALUES (40, 'logistics', '0011_alter_outboundorder_status', '2025-04-20 20:17:26.565226');
INSERT INTO `django_migrations` VALUES (41, 'shopper', '0009_alter_orderinfos_state_alter_purchaseinfos_order', '2025-04-20 20:17:26.614005');
INSERT INTO `django_migrations` VALUES (42, 'shopper', '0010_refundinfos_status_before_alter_orderinfos_state_and_more', '2025-04-21 11:01:57.697347');
INSERT INTO `django_migrations` VALUES (43, 'logistics', '0012_remove_stockinorder_created_by_and_more', '2025-04-21 14:54:19.873520');
INSERT INTO `django_migrations` VALUES (44, 'shopper', '0011_alter_cartinfos_commodityinfos_id_alter_cartinfos_id_and_more', '2025-04-21 14:54:19.964027');
INSERT INTO `django_migrations` VALUES (45, 'logistics', '0013_logisticsorder_stockinorder_stockinorderitem_and_more', '2025-04-21 14:54:54.097948');
INSERT INTO `django_migrations` VALUES (46, 'logistics', '0014_logisticsorder_created_by_and_more', '2025-04-21 15:11:28.758019');
INSERT INTO `django_migrations` VALUES (47, 'logistics', '0015_logisticsorder_destination_address_and_more', '2025-04-21 15:50:06.369990');
INSERT INTO `django_migrations` VALUES (48, 'logistics', '0016_logisticsorder_order_infos_and_more', '2025-04-21 21:12:47.355625');
INSERT INTO `django_migrations` VALUES (49, 'logistics', '0017_alter_logisticsorderitem_unique_together_and_more', '2025-04-24 13:21:48.781844');
INSERT INTO `django_migrations` VALUES (50, 'shopper', '0012_alter_refundinfos_state', '2025-04-24 13:21:48.808635');
INSERT INTO `django_migrations` VALUES (51, 'logistics', '0018_logisticsorder_logisticsorderitem', '2025-04-24 13:30:45.092943');
INSERT INTO `django_migrations` VALUES (52, 'logistics', '0019_purchasestockinorder_alter_logisticsorder_options_and_more', '2025-04-24 22:02:53.721992');
INSERT INTO `django_migrations` VALUES (53, 'shopper', '0013_refundstockinorder_refundstockinorderitem', '2025-04-24 22:02:54.407741');
INSERT INTO `django_migrations` VALUES (54, 'logistics', '0020_alter_purchasestockinorder_options_and_more', '2025-05-03 09:47:33.308856');
INSERT INTO `django_migrations` VALUES (55, 'shopper', '0014_alter_refundstockinorder_options_and_more', '2025-05-03 09:47:33.509735');
INSERT INTO `django_migrations` VALUES (56, 'logistics', '0021_alter_logisticsorder_estimated_delivery', '2025-05-19 21:01:48.327853');
INSERT INTO `django_migrations` VALUES (57, 'logistics', '0022_alter_logisticsorder_estimated_delivery', '2025-05-19 21:01:48.357250');
INSERT INTO `django_migrations` VALUES (58, 'logistics', '0023_alter_logisticsorder_estimated_delivery', '2025-05-19 21:24:36.311612');

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
INSERT INTO `django_session` VALUES ('6uv9mid0lvdh62zp9s4mwwaxvf40j6n2', '.eJzNl0uPmzAQgP_KyudsAsYvcuyth97aU6lWxjYJ3YAjA4fVKv-9NkS7G5cUFyJlT4PmZc83YA-v4Il37f6pa5R5KiXYAgZWH3U5F8-qdgb5m9c7vRa6bk2Zr53L-mxt1t-0VIcvZ9-LBHve7G0054zmFBKUJkoinMR5jAkWiRICFwlmSMA0LmhBZJxGCuciVUQQJCGJmCCU2qRH_vK1LjTYvoKjKYUCW5ym62gF3jbPVqBpeWstIOuwLGDWEQyLrENKsiHDUGRMEYQMw4iCU6_-XlbqUm-LqFTdNVb78zUDNa9UBrYPGchsaoyIE0jETtCCW0EZijK3IO1FQqz_yvqXltgQWXDzUPBHURpxOBsrx61x5olFUKGcIBEpAtJ25jDYNlxWZb0RurIrle3L-1NpUTabwZ1L-SM0wvqeo3KjuBSmq_KQAuZSOq0ebkXm9MuZVSmdNY4iOJmbCpr3e2f5Iurty1EFwR4cPx3jcA4-48RXxCOL2XMhdTuVqF8s571AEVn4BcUEO6HSZEb3DnpXNm0pmk3TavFc1tpIZa438Yp_eC_nUhjrXnDlfnvwaLb-tVrMUXdtrrtaBoO8DLgTydDafZJk8kVfdqa_Y3p7CgbrRdyF7FwWPmc6kjuNBbWCSSidGLaJYQwXcT4aLTqj7FjQBpP-K-YurOfy8FmzkNzQ5U4wXsa6M8KOjioc9EXA56AcSMKnnPoKNLLYx_Q3vDMv0y47oZq9Ph5tM_qWTMybI77hPZzLYhLr7FMpHhtz0ijqB7I8UTdja1RhL8hAuB-d70J3LgGfLvQV0XgrUS-G2Rgx0U_DjDlB0ch93rg1m32pDvKRH9rJj4Vi2CeDCb1SgPs1HW-g-0PeOPP1tr27_FezlhY9dlcHFuq3ZezgokqgK7twSZpHoXf_QLYzujtOMBt87g4tqFAfGfYV9g8KnP4AEouIQQ:1u4V5M:cTwUnpO9ItyGIuzuQ1d9wfVTzHzbJDof7I-ywRPv_zw', '2025-04-29 09:27:36.985039');
INSERT INTO `django_session` VALUES ('93rbpb43zi18cr3n3o6bij9pyun3715n', 'MjIzZGE0YjQ5ZTNjYWMzNTlhNjA4YzVkZjFmMGJkNmExZmJmMGU4OTp7Imxpa2VzIjp0cnVlfQ==', '2020-03-26 10:30:29.662811');
INSERT INTO `django_session` VALUES ('bcmyunt3inli143guv01n32cbfom2wm1', 'MmNiN2NiN2U0M2FlNTAwMzkzYTFiYjg0Y2ZhNDExMDczMDgwN2Q4YTp7Imxpa2VzIjpudWxsfQ==', '2020-03-26 13:32:26.837713');
INSERT INTO `django_session` VALUES ('hqdzj2aii98g7aqfhd6cxtarbto74k3x', 'MmNiN2NiN2U0M2FlNTAwMzkzYTFiYjg0Y2ZhNDExMDczMDgwN2Q4YTp7Imxpa2VzIjpudWxsfQ==', '2020-03-26 13:35:25.046970');
INSERT INTO `django_session` VALUES ('k53j3orf1urfnqn5bqjyy9pfa7fy1dwl', 'MjIzZGE0YjQ5ZTNjYWMzNTlhNjA4YzVkZjFmMGJkNmExZmJmMGU4OTp7Imxpa2VzIjp0cnVlfQ==', '2020-03-26 10:38:44.347533');
INSERT INTO `django_session` VALUES ('lff8n3a25ens007n2z29u41t0czjioui', 'MjQxNGM0NDM4ODIzNmYxZmFiZGFiNzZiYzNiN2U5ODM5NDM0ZTgzNjp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYzVhMGIzOTFiMzZmNzdiNGMyNjM5ZmE4NGI0NzFkMDkzODg0ZDM2In0=', '2020-04-12 12:42:04.663516');
INSERT INTO `django_session` VALUES ('lhme8f0yy000osv1wl5jhbk400rkp5l7', '.eJxVjEEOwiAQRe_C2hBAaBmX7nsGMsxMpWpoUtqV8e7apAvd_vfef6mE21rS1mRJE6uLsur0u2Wkh9Qd8B3rbdY013WZst4VfdCmh5nleT3cv4OCrXxrF2AMPjAbB0YoYkeeMXKPXRTxEUwOBA7J9qOADcRy9oDROhJvLKj3B-xGOBE:1pRluq:9OMrErUzoOrq7fCtl9xGd9DJLrPnGhjiwAwgoYwqu_c', '2023-02-28 03:23:36.514605');
INSERT INTO `django_session` VALUES ('mtp8ubigxekcq4kolcxhhy46lsabnmg4', '.eJxVjMsOwiAQRf-FtSHlNYBL934DgWGQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYMzszx06_W4r4oLaDfI_t1jn2ti5z4rvCDzr4tWd6Xg7376DGUb91jM4mK0F7RVkbJZIwYFARoinKOI3Si2ILZOEnMgk9AYLOEiaHYC17fwDdbTeQ:1sJdNt:vlvGQGhZiVkULhovuOWworJpiR2RXRfg6A0spOMyJnk', '2024-07-02 18:16:45.390878');
INSERT INTO `django_session` VALUES ('ndsh24znckwqpz3p82cena0wk6rxnyaf', 'eyJsaWtlcyI6WzMsMl19:1sJZTJ:FLl1gdNMV-d395US92W_pp8mXTLGXSRwbLd_udZNnUI', '2024-07-02 14:06:05.482117');
INSERT INTO `django_session` VALUES ('o6o4h0v7h0w8w8bdvaasze57qfx1buzg', '.eJxVjrluwzAQRP9la4HgtTxUpnORLqUAgVySkRJbMiSxCAz_eyTDMJJ23szD3KAPdRv6uualHxO04KD5m8VA33k6QPoK0-fMaJ62ZYzsqLAnXdn7nPL57dn9JxjCOuzrEJyNVhrtVU4alYgCDZLKRFgUOk3Si2KLScLzjJF8NmR0koY7Mtbu0mv4OU1lhvYG12WkDC16z3gDr_OugXUL206gq5iK7KpBWbqqc3Jwfyg-xsvBhZWa7w8Uh_svQ8RSHg:1sfxrO:4MuJl2Yc_wK7o24aMPhu4XZnzG8V5U1PUuPTHOPmSck', '2024-09-02 08:35:30.598178');
INSERT INTO `django_session` VALUES ('pzlf37pzsjsbalcftytwkhmtocabuez6', '.eJzNmEtv4yAQgP9K5XOb-MHD7nHve9zTpqow4MTbxERgH6oq_30Bp0rCkg2xLTmnsWBmYL7Bw-Mreiddu3nvFJfvNYteo6SIns8bS0I_eGN62B_SrMWCiqaVdbkwKotjr1r8FIxvfxx1LxxsiNpoa84hZGVKkoTitIgZzjkFGaMEMkwTwmgMU0gZgEmVlTkHBYiLPC10QwlSgpFxuuNNp7Sv31-rqCE7vopen1bRatVBCJARgCZG4IpogXMQa4EgtiJDWv9Z69c6gt6yIvKpIi-0lnR77NyZOJTpvjEIqLgRKEZVgNtObvu-JWG7ullSsdMj1e3n6atuKqGWvTph7FeohdY9WpWSa46y25UhAQyldHh-morM4c1085qZ3iSO05u-McWlnXtejqLefu55EOxe8eEYh3NwGWduQ-IZDKeoMDNlwA5WEitAjMb9QXnFYiuKzEw-g3BAErdiXau2pur0JSTj8no2r1qEp3UoEA_buyG4CYMep4WuqsYpS5lxmiBoBJ-G876TVFdxrlpBP-ommLbXbhbmI_G4GUA3h8j72cI0Scehl4J2kuuNrw3H7to8APJwHi5rHOI7nXKZ372-H4lyIAmXcu7zDePYbjwptz-N3cqmqimia0vRNSwY9qXBPLDHAXGZF24D8O0WZymdcCdGMEP9usH2GJHZwLTfAUlVG7Hf9zmRXKkb51ivdng6h_LwoB3KwElb4jtA5Tmg_RCVnW1mlwpmQ-4K38QkX9eiuU32qDcL06Fxu0x9N4HLaY67f32zstUkcMWe6c7DdmD8LtvM57vfQI7FMq9QSH25BpUS2QYyPanOg_TesF2WvpJdxHabQGXGJ1unkld67wuEeq48C9ahBFy63pvOhe9JbjqX3MJuOf-xeQDkY284CXIbYn9BAlb0bx0gt6U_y3MjMMj-HVOZMdWm5lv2QrbtzWMKhql1lmb4SgDmidGfVfMCuTTd15N4UrkrZ2OD9j24BAbqpsV3bsecgiuzME7UCxXr_yBbS9HtbzDrdWaHFhSoi8w9dif48BYd_gIEWDzV:1uB1ya:nZvRVOk6dpZ4iqCDwUOQ2N2E8dPLIh4aJ5rp9pAO59o', '2025-05-17 09:47:36.347787');
INSERT INTO `django_session` VALUES ('r2gey1gibhywms3nxndagw04w2ir1jd6', 'MmNiN2NiN2U0M2FlNTAwMzkzYTFiYjg0Y2ZhNDExMDczMDgwN2Q4YTp7Imxpa2VzIjpudWxsfQ==', '2020-03-26 13:41:00.303808');
INSERT INTO `django_session` VALUES ('sfzayj3e8lsylgvlxi4veh0yud237rf3', 'MmNiN2NiN2U0M2FlNTAwMzkzYTFiYjg0Y2ZhNDExMDczMDgwN2Q4YTp7Imxpa2VzIjpudWxsfQ==', '2020-03-26 13:29:55.534079');
INSERT INTO `django_session` VALUES ('tgx1d0s3pdlf1fuma2uverbzkw9r84ke', '.eJxVjMEOwiAQRP-FsyFLKQU8eu83kF3YStXQpLQn479bkh70OPPezFsE3Lcc9sprmJO4CiUuvx1hfHJpID2w3BcZl7KtM8mmyJNWOS6JX7fT_TvIWPOxniYAM5iOvNIugkN3ZGLqVTQt9EkblSzhAIqAKTrvDTBrMGCt7sTnC8kXNvg:1pUk1p:Wny1DpWVcTSvipuMa9COf9Hgh_kFQGF0ZmO_dYBuIcU', '2023-03-08 07:59:05.258146');
INSERT INTO `django_session` VALUES ('toqiw1u5vdy9qbgqivt8zn2qn9z328sf', 'MDk0NmEwMGVhOGYyZjc2YWVlMTNhNmE5NzBkMzg2YTQ0ZTRmNTllYjp7Imxpa2VzIjpbNSw0XSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNiZmM4ODIzNGQxODQwYzhmMWIzODBhMDBiNzUzZTgwYTlkNjAyZDMifQ==', '2020-03-29 15:57:11.652234');
INSERT INTO `django_session` VALUES ('tsr1u0a1gdcr17zoi01un7gghg0u1cw2', '.eJzNmEtv4yAQgP9K5XOb-MHD7nHve9zTpqow4MTbxERgH6oq_30Bp0rCkg2xLTmnsWBmYL7Bw-Mreiddu3nvFJfvNYteo6SIns8bS0I_eGN62B_SrMWCiqaVdbkwKotjr1r8FIxvfxx1LxxsiNpoa84hZGVKkoTitIgZzjkFGaMEMkwTwmgMU0gZgEmVlTkHBYiLPC10QwlSgpFxuuNNp7Sv31-rqCE7vopen1bRatVBCJARgCZG4IpogXMQa4EgtiJDWv9Z69c6gt6yIvKpIi-0lnR77NyZOJTpvjEIqLgRKEZVgNtObvu-JWG7ullSsdMj1e3n6atuKqGWvTph7FeohdY9WpWSa46y25UhAQyldHh-morM4c1085qZ3iSO05u-McWlnXtejqLefu55EOxe8eEYh3NwGWduQ-IZDKeoMDNlwA5WEitAjMb9QXnFYiuKzEw-g3BAErdiXau2pur0JSTj8no2r1qEp3UoEA_buyG4CYMep4WuqsYpS5lxmiBoBJ-G876TVFdxrlpBP-ommLbXbhbmI_G4GUA3h8j72cI0Scehl4J2kuuNrw3H7to8APJwHi5rHOI7nXKZ372-H4lyIAmXcu7zDePYbjwptz-N3cqmqimia0vRNSwY9qXBPLDHAXGZF24D8O0WZymdcCdGMEP9usH2GJHZwLTfAUlVG7Hf9zmRXKkb51ivdng6h_LwoB3KwElb4jtA5Tmg_RCVnW1mlwpmQ-4K38QkX9eiuU32qDcL06Fxu0x9N4HLaY67f32zstUkcMWe6c7DdmD8LtvM57vfQI7FMq9QSH25BpUS2QYyPanOg_TesF2WvpJdxHabQGXGJ1unkld67wuEeq48C9ahBFy63pvOhe9JbjqX3MJuOf-xeQDkY284CXIbYn9BAlb0bx0gt6U_y3MjMMj-HVOZMdWm5lv2QrbtzWMKhql1lmb4SgDmidGfVfMCuTTd15N4UrkrZ2OD9j24BAbqpsV3bsecgiuzME7UCxXr_yBbS9HtbzDrdWaHFhSoi8w9dif48BYd_gIEWDzV:1uHigo:KLWF40XAPGqWE6Vz2c-BE5BXYgw3FHRRYVhlyVsifeg', '2025-06-04 20:36:54.054761');
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
  `estimated_delivery` date NULL DEFAULT NULL,
  `actual_delivery` date NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `notes` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_by_id` int(11) NOT NULL,
  `destination_address_id` bigint(20) NULL DEFAULT NULL,
  `order_infos_id` int(11) NULL DEFAULT NULL,
  `origin_address_id` bigint(20) NULL DEFAULT NULL,
  `outbound_order_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tracking_number`(`tracking_number`) USING BTREE,
  INDEX `logistics_logisticsorder_created_by_id_6f555c73_fk_auth_user_id`(`created_by_id`) USING BTREE,
  INDEX `logistics_logisticso_destination_address__2b0ef79a_fk_shopper_a`(`destination_address_id`) USING BTREE,
  INDEX `logistics_logisticso_order_infos_id_e19763da_fk_shopper_o`(`order_infos_id`) USING BTREE,
  INDEX `logistics_logisticso_origin_address_id_8aaa2521_fk_shopper_a`(`origin_address_id`) USING BTREE,
  INDEX `logistics_logisticso_outbound_order_id_d47e11b3_fk_logistics`(`outbound_order_id`) USING BTREE,
  CONSTRAINT `logistics_logisticso_destination_address__2b0ef79a_fk_shopper_a` FOREIGN KEY (`destination_address_id`) REFERENCES `shopper_addressinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_logisticso_order_infos_id_e19763da_fk_shopper_o` FOREIGN KEY (`order_infos_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_logisticso_origin_address_id_8aaa2521_fk_shopper_a` FOREIGN KEY (`origin_address_id`) REFERENCES `shopper_addressinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_logisticso_outbound_order_id_d47e11b3_fk_logistics` FOREIGN KEY (`outbound_order_id`) REFERENCES `logistics_outboundorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_logisticsorder_created_by_id_6f555c73_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_logisticsorder
-- ----------------------------
INSERT INTO `logistics_logisticsorder` VALUES (5, 'LO-20250424-001', '顺丰速递', 'shipped', '2025-05-01', NULL, '2025-04-24 21:29:28.509696', '', 19, 2, 10, 11, 8);
INSERT INTO `logistics_logisticsorder` VALUES (6, 'LO-20250427-001', '顺丰速递', 'shipped', '2025-05-04', NULL, '2025-04-27 09:02:22.397374', '', 19, 1, 6, 11, 5);
INSERT INTO `logistics_logisticsorder` VALUES (7, 'LO-20250427-002', '顺丰速递', 'shipped', '2025-05-04', NULL, '2025-04-27 09:02:31.657234', '', 19, 2, 7, 11, 6);
INSERT INTO `logistics_logisticsorder` VALUES (8, 'LO-20250427-003', '顺丰速递', 'shipped', '2025-05-04', NULL, '2025-04-27 09:02:44.757159', '', 19, 2, 8, 11, 7);
INSERT INTO `logistics_logisticsorder` VALUES (9, 'LO-20250427-004', '顺丰速递', 'delivered', '2025-05-04', '2025-04-27', '2025-04-27 09:03:23.667279', '', 19, 2, 11, 11, 11);
INSERT INTO `logistics_logisticsorder` VALUES (10, 'LO-20250427-005', '顺丰速递', 'shipped', '2025-05-04', '2025-04-27', '2025-04-27 09:03:52.241701', '', 19, 5, 19, 11, 10);

-- ----------------------------
-- Table structure for logistics_logisticsorderitem
-- ----------------------------
DROP TABLE IF EXISTS `logistics_logisticsorderitem`;
CREATE TABLE `logistics_logisticsorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) UNSIGNED NOT NULL,
  `commodity_id` int(11) NOT NULL,
  `logistics_order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `logistics_logisticsorder_logistics_order_id_commo_5eb97394_uniq`(`logistics_order_id`, `commodity_id`) USING BTREE,
  INDEX `logistics_logisticso_commodity_id_2c7ca148_fk_commodity`(`commodity_id`) USING BTREE,
  CONSTRAINT `logistics_logisticso_commodity_id_2c7ca148_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_logisticso_logistics_order_id_8d8a3edc_fk_logistics` FOREIGN KEY (`logistics_order_id`) REFERENCES `logistics_logisticsorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_logisticsorderitem
-- ----------------------------
INSERT INTO `logistics_logisticsorderitem` VALUES (5, 1, 7, 5);
INSERT INTO `logistics_logisticsorderitem` VALUES (6, 1, 3, 6);
INSERT INTO `logistics_logisticsorderitem` VALUES (7, 5, 4, 7);
INSERT INTO `logistics_logisticsorderitem` VALUES (8, 3, 2, 7);
INSERT INTO `logistics_logisticsorderitem` VALUES (9, 1, 2, 8);
INSERT INTO `logistics_logisticsorderitem` VALUES (10, 1, 5, 8);
INSERT INTO `logistics_logisticsorderitem` VALUES (11, 1, 7, 9);
INSERT INTO `logistics_logisticsorderitem` VALUES (12, 1, 1, 10);
INSERT INTO `logistics_logisticsorderitem` VALUES (13, 1, 2, 10);

-- ----------------------------
-- Table structure for logistics_outboundorder
-- ----------------------------
DROP TABLE IF EXISTS `logistics_outboundorder`;
CREATE TABLE `logistics_outboundorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `notes` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `outbound_date` datetime(6) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE,
  INDEX `logistics_outboundorder_created_by_id_afe0b5b1_fk_auth_user_id`(`created_by_id`) USING BTREE,
  CONSTRAINT `logistics_outboundorder_created_by_id_afe0b5b1_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of logistics_outboundorder
-- ----------------------------
INSERT INTO `logistics_outboundorder` VALUES (5, 'OB-20250418-001', '2025-04-18 20:56:36.441173', 8, '', '2025-04-18 20:56:00.000000', 'completed');
INSERT INTO `logistics_outboundorder` VALUES (6, 'OB-20250418-002', '2025-04-18 20:57:40.414049', 8, '', '2025-04-18 20:57:00.000000', 'completed');
INSERT INTO `logistics_outboundorder` VALUES (7, 'OB-20250419-001', '2025-04-19 13:16:15.786968', 8, '', '2025-04-19 13:16:00.000000', 'completed');
INSERT INTO `logistics_outboundorder` VALUES (8, 'OB-20250420-001', '2025-04-20 11:53:35.772115', 8, '', '2025-04-20 11:53:00.000000', 'completed');
INSERT INTO `logistics_outboundorder` VALUES (9, 'OB-20250426-001', '2025-04-26 21:46:13.198600', 19, '', '2025-04-26 21:46:00.000000', 'pending');
INSERT INTO `logistics_outboundorder` VALUES (10, 'OB-20250426-002', '2025-04-26 21:46:55.468557', 19, '', '2025-04-26 21:46:00.000000', 'completed');
INSERT INTO `logistics_outboundorder` VALUES (11, 'OB-20250426-003', '2025-04-26 21:51:00.080635', 19, '', '2025-04-26 21:50:00.000000', 'completed');

-- ----------------------------
-- Table structure for logistics_outboundorder_sales_orders
-- ----------------------------
DROP TABLE IF EXISTS `logistics_outboundorder_sales_orders`;
CREATE TABLE `logistics_outboundorder_sales_orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `outboundorder_id` bigint(20) NOT NULL,
  `orderinfos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `logistics_outboundorder__outboundorder_id_orderin_9151d7fa_uniq`(`outboundorder_id`, `orderinfos_id`) USING BTREE,
  INDEX `logistics_outboundor_orderinfos_id_8158dceb_fk_shopper_o`(`orderinfos_id`) USING BTREE,
  CONSTRAINT `logistics_outboundor_orderinfos_id_8158dceb_fk_shopper_o` FOREIGN KEY (`orderinfos_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_outboundor_outboundorder_id_b7c46474_fk_logistics` FOREIGN KEY (`outboundorder_id`) REFERENCES `logistics_outboundorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_outboundorder_sales_orders
-- ----------------------------
INSERT INTO `logistics_outboundorder_sales_orders` VALUES (4, 5, 6);
INSERT INTO `logistics_outboundorder_sales_orders` VALUES (5, 6, 7);
INSERT INTO `logistics_outboundorder_sales_orders` VALUES (6, 7, 8);
INSERT INTO `logistics_outboundorder_sales_orders` VALUES (7, 8, 10);
INSERT INTO `logistics_outboundorder_sales_orders` VALUES (8, 9, 9);
INSERT INTO `logistics_outboundorder_sales_orders` VALUES (9, 10, 19);
INSERT INTO `logistics_outboundorder_sales_orders` VALUES (10, 11, 11);

-- ----------------------------
-- Table structure for logistics_outboundorderitem
-- ----------------------------
DROP TABLE IF EXISTS `logistics_outboundorderitem`;
CREATE TABLE `logistics_outboundorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `commodity_id` int(11) NOT NULL,
  `order_number_id` bigint(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `source_order_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `logistics_outboundor_commodity_id_6d7b0738_fk_commodity`(`commodity_id`) USING BTREE,
  INDEX `logistics_outboundor_order_number_id_19e6ce04_fk_logistics`(`order_number_id`) USING BTREE,
  INDEX `logistics_outboundor_source_order_id_dcadae2d_fk_shopper_o`(`source_order_id`) USING BTREE,
  CONSTRAINT `logistics_outboundor_commodity_id_6d7b0738_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_outboundor_order_number_id_19e6ce04_fk_logistics` FOREIGN KEY (`order_number_id`) REFERENCES `logistics_outboundorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_outboundor_source_order_id_dcadae2d_fk_shopper_o` FOREIGN KEY (`source_order_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of logistics_outboundorderitem
-- ----------------------------
INSERT INTO `logistics_outboundorderitem` VALUES (4, 3, 5, 1, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (5, 4, 6, 5, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (6, 2, 6, 3, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (7, 2, 7, 1, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (8, 5, 7, 1, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (9, 7, 8, 1, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (10, 1, 9, 1, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (11, 4, 9, 2, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (12, 1, 10, 1, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (13, 2, 10, 1, NULL);
INSERT INTO `logistics_outboundorderitem` VALUES (14, 7, 11, 1, NULL);

-- ----------------------------
-- Table structure for logistics_procurementorder
-- ----------------------------
DROP TABLE IF EXISTS `logistics_procurementorder`;
CREATE TABLE `logistics_procurementorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `supplier` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `due_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE,
  INDEX `logistics_procuremen_created_by_id_576bce21_fk_auth_user`(`created_by_id`) USING BTREE,
  CONSTRAINT `logistics_procuremen_created_by_id_576bce21_fk_auth_user` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_procurementorder
-- ----------------------------
INSERT INTO `logistics_procurementorder` VALUES (3, 'PPO-20250325-001', '', '2025-03-25 08:45:45.918902', 'pending', 8, '2025-04-04 07:44:10.157666');
INSERT INTO `logistics_procurementorder` VALUES (5, 'PPO-20250401-001', '11', '2025-04-01 11:50:03.822115', 'pending', 8, '2025-04-08 11:49:00.000000');
INSERT INTO `logistics_procurementorder` VALUES (6, 'PPO-20250407-001', '公司', '2025-04-07 12:21:05.962729', 'pending', 8, '2025-04-14 12:20:00.000000');
INSERT INTO `logistics_procurementorder` VALUES (7, 'PPO-20250408-001', '公司', '2025-04-08 07:45:42.549755', 'pending', 8, '2025-04-15 07:45:00.000000');
INSERT INTO `logistics_procurementorder` VALUES (8, 'PPO-20250408-002', '公司', '2025-04-08 15:58:29.965432', 'completed', 8, '2025-04-15 15:58:00.000000');
INSERT INTO `logistics_procurementorder` VALUES (9, 'PPO-20250408-003', '公司', '2025-04-08 17:06:35.514775', 'pending', 8, '2025-04-15 17:06:00.000000');
INSERT INTO `logistics_procurementorder` VALUES (10, 'PPO-20250411-001', '公司', '2025-04-11 10:37:33.827399', 'approved', 8, '2025-04-18 10:37:00.000000');
INSERT INTO `logistics_procurementorder` VALUES (11, 'PPO-20250411-002', '公司', '2025-04-11 10:50:04.320453', 'pending', 8, '2025-04-18 10:49:00.000000');
INSERT INTO `logistics_procurementorder` VALUES (12, 'PPO-20250411-003', '公司', '2025-04-11 10:54:51.241007', 'pending', 8, '2025-04-18 10:54:00.000000');
INSERT INTO `logistics_procurementorder` VALUES (13, 'PPO-20250521-001', '公司', '2025-05-21 17:48:40.424976', 'approved', 19, '2025-05-28 17:48:00.000000');

-- ----------------------------
-- Table structure for logistics_procurementorderitem
-- ----------------------------
DROP TABLE IF EXISTS `logistics_procurementorderitem`;
CREATE TABLE `logistics_procurementorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) UNSIGNED NOT NULL,
  `commodity_id` int(11) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `unit_price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `logistics_procuremen_commodity_id_e2ac484e_fk_commodity`(`commodity_id`) USING BTREE,
  INDEX `logistics_procuremen_order_id_e7bbd2e9_fk_logistics`(`order_id`) USING BTREE,
  CONSTRAINT `logistics_procuremen_commodity_id_e2ac484e_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_procuremen_order_id_e7bbd2e9_fk_logistics` FOREIGN KEY (`order_id`) REFERENCES `logistics_procurementorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_procurementorderitem
-- ----------------------------
INSERT INTO `logistics_procurementorderitem` VALUES (1, 1, 1, 3, 122.00);
INSERT INTO `logistics_procurementorderitem` VALUES (2, 1, 2, 3, 122.00);
INSERT INTO `logistics_procurementorderitem` VALUES (6, 0, 4, 5, 1.00);
INSERT INTO `logistics_procurementorderitem` VALUES (7, 0, 3, 5, 1.00);
INSERT INTO `logistics_procurementorderitem` VALUES (8, 2, 1, 6, 479.20);
INSERT INTO `logistics_procurementorderitem` VALUES (9, 1, 1, 6, 479.20);
INSERT INTO `logistics_procurementorderitem` VALUES (10, 2, 2, 6, 639.20);
INSERT INTO `logistics_procurementorderitem` VALUES (11, 2, 4, 7, 953.60);
INSERT INTO `logistics_procurementorderitem` VALUES (12, 1, 1, 7, 479.20);
INSERT INTO `logistics_procurementorderitem` VALUES (13, 5, 3, 7, 20640.00);
INSERT INTO `logistics_procurementorderitem` VALUES (14, 4, 1, 8, 479.20);
INSERT INTO `logistics_procurementorderitem` VALUES (15, 7, 4, 8, 953.60);
INSERT INTO `logistics_procurementorderitem` VALUES (16, 5, 5, 8, 5160.80);
INSERT INTO `logistics_procurementorderitem` VALUES (17, 4, 4, 9, 953.60);
INSERT INTO `logistics_procurementorderitem` VALUES (18, 7, 3, 9, 20640.00);
INSERT INTO `logistics_procurementorderitem` VALUES (19, 1, 1, 9, 479.20);
INSERT INTO `logistics_procurementorderitem` VALUES (20, 4, 3, 10, 20640.00);
INSERT INTO `logistics_procurementorderitem` VALUES (21, 7, 1, 10, 479.20);
INSERT INTO `logistics_procurementorderitem` VALUES (22, 4, 1, 11, 479.20);
INSERT INTO `logistics_procurementorderitem` VALUES (23, 7, 4, 11, 953.60);
INSERT INTO `logistics_procurementorderitem` VALUES (24, 4, 3, 12, 20640.00);
INSERT INTO `logistics_procurementorderitem` VALUES (25, 7, 2, 12, 639.20);
INSERT INTO `logistics_procurementorderitem` VALUES (26, 13, 1, 13, 479.20);
INSERT INTO `logistics_procurementorderitem` VALUES (27, 11, 5, 13, 5160.80);

-- ----------------------------
-- Table structure for logistics_purchaseorder
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchaseorder`;
CREATE TABLE `logistics_purchaseorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `supplier` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `procurement_plan_id` bigint(20) NULL DEFAULT NULL,
  `due_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE,
  INDEX `logistics_purchaseorder_created_by_id_20212d3e_fk_auth_user_id`(`created_by_id`) USING BTREE,
  INDEX `logistics_purchaseor_procurement_plan_id_0c6d68ac_fk_logistics`(`procurement_plan_id`) USING BTREE,
  CONSTRAINT `logistics_purchaseor_procurement_plan_id_0c6d68ac_fk_logistics` FOREIGN KEY (`procurement_plan_id`) REFERENCES `logistics_procurementorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_purchaseorder_created_by_id_20212d3e_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of logistics_purchaseorder
-- ----------------------------
INSERT INTO `logistics_purchaseorder` VALUES (6, 'PO-20250407-001', '公司', '2025-04-07 13:30:56.034883', 'completed', 8, 6, '2025-04-14 13:30:00.000000');
INSERT INTO `logistics_purchaseorder` VALUES (7, 'PO-20250408-001', '公司', '2025-04-08 07:51:56.164369', 'pending', 8, 7, '2025-04-15 07:51:00.000000');
INSERT INTO `logistics_purchaseorder` VALUES (8, 'PO-20250408-004', '公司', '2025-04-08 15:58:46.774570', 'pending', 8, 8, '2025-04-15 15:58:00.000000');
INSERT INTO `logistics_purchaseorder` VALUES (9, 'PO-20250408-005', '公司', '2025-04-08 17:06:41.809952', 'pending', 8, 9, '2025-04-15 17:06:00.000000');
INSERT INTO `logistics_purchaseorder` VALUES (10, 'PO-20250411-001', '公司', '2025-04-11 10:37:50.115219', 'pending', 8, 10, '2025-04-18 10:37:00.000000');
INSERT INTO `logistics_purchaseorder` VALUES (12, 'PO-20250415-001', '公司', '2025-04-15 15:38:57.754950', 'completed', 8, 8, '2025-04-22 15:38:00.000000');
INSERT INTO `logistics_purchaseorder` VALUES (13, 'PO-20250521-001', '公司', '2025-05-21 17:49:20.524886', 'completed', 19, 13, '2025-05-28 17:48:00.000000');

-- ----------------------------
-- Table structure for logistics_purchaseorderitem
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchaseorderitem`;
CREATE TABLE `logistics_purchaseorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_price` decimal(10, 2) NOT NULL,
  `quantity_plan` int(10) UNSIGNED NOT NULL,
  `quantity_actual` int(10) UNSIGNED NOT NULL,
  `commodity_id` int(11) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `logistics_purchaseor_commodity_id_a061b92d_fk_commodity`(`commodity_id`) USING BTREE,
  INDEX `logistics_purchaseor_order_id_ebb83e39_fk_logistics`(`order_id`) USING BTREE,
  CONSTRAINT `logistics_purchaseor_commodity_id_a061b92d_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_purchaseor_order_id_ebb83e39_fk_logistics` FOREIGN KEY (`order_id`) REFERENCES `logistics_purchaseorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_purchaseorderitem
-- ----------------------------
INSERT INTO `logistics_purchaseorderitem` VALUES (10, 479.20, 2, 1, 1, 6);
INSERT INTO `logistics_purchaseorderitem` VALUES (11, 479.20, 1, 0, 1, 6);
INSERT INTO `logistics_purchaseorderitem` VALUES (12, 639.20, 2, 0, 2, 6);
INSERT INTO `logistics_purchaseorderitem` VALUES (13, 953.60, 2, 0, 4, 7);
INSERT INTO `logistics_purchaseorderitem` VALUES (14, 479.20, 1, 0, 1, 7);
INSERT INTO `logistics_purchaseorderitem` VALUES (15, 479.20, 4, 0, 1, 8);
INSERT INTO `logistics_purchaseorderitem` VALUES (16, 953.60, 7, 0, 4, 8);
INSERT INTO `logistics_purchaseorderitem` VALUES (17, 5160.80, 5, 0, 5, 8);
INSERT INTO `logistics_purchaseorderitem` VALUES (18, 953.60, 4, 0, 4, 9);
INSERT INTO `logistics_purchaseorderitem` VALUES (19, 20640.00, 7, 0, 3, 9);
INSERT INTO `logistics_purchaseorderitem` VALUES (20, 479.20, 1, 0, 1, 9);
INSERT INTO `logistics_purchaseorderitem` VALUES (21, 20640.00, 4, 1, 3, 10);
INSERT INTO `logistics_purchaseorderitem` VALUES (22, 479.20, 7, 0, 1, 10);
INSERT INTO `logistics_purchaseorderitem` VALUES (25, 479.20, 4, 2, 1, 12);
INSERT INTO `logistics_purchaseorderitem` VALUES (26, 953.60, 7, 0, 4, 12);
INSERT INTO `logistics_purchaseorderitem` VALUES (27, 5160.80, 5, 0, 5, 12);
INSERT INTO `logistics_purchaseorderitem` VALUES (28, 479.20, 13, 10, 1, 13);
INSERT INTO `logistics_purchaseorderitem` VALUES (29, 5160.80, 11, 10, 5, 13);

-- ----------------------------
-- Table structure for logistics_purchasestockinorder
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchasestockinorder`;
CREATE TABLE `logistics_purchasestockinorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `notes` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_by_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE,
  INDEX `logistics_purchasest_created_by_id_4ce8d70e_fk_auth_user`(`created_by_id`) USING BTREE,
  CONSTRAINT `logistics_purchasest_created_by_id_4ce8d70e_fk_auth_user` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_purchasestockinorder
-- ----------------------------
INSERT INTO `logistics_purchasestockinorder` VALUES (1, 'PSO-20250426-001', '2025-04-26 21:55:00.000000', '', 'completed', 19);
INSERT INTO `logistics_purchasestockinorder` VALUES (2, 'PSO-20250426-002', '2025-04-26 22:04:00.000000', '', 'completed', 19);
INSERT INTO `logistics_purchasestockinorder` VALUES (10, 'PSO-20250521-001', '2025-05-21 17:45:00.000000', '', 'completed', 19);
INSERT INTO `logistics_purchasestockinorder` VALUES (11, 'PSO-20250521-002', '2025-05-21 17:49:00.000000', '', 'completed', 19);
INSERT INTO `logistics_purchasestockinorder` VALUES (13, 'PSO-20250521-003', '2025-05-21 17:51:00.000000', '', 'completed', 19);

-- ----------------------------
-- Table structure for logistics_purchasestockinorder_purchase_orders
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchasestockinorder_purchase_orders`;
CREATE TABLE `logistics_purchasestockinorder_purchase_orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `purchasestockinorder_id` bigint(20) NOT NULL,
  `purchaseorder_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `logistics_purchasestocki_purchasestockinorder_id__fea330c9_uniq`(`purchasestockinorder_id`, `purchaseorder_id`) USING BTREE,
  INDEX `logistics_purchasest_purchaseorder_id_dd4ffd95_fk_logistics`(`purchaseorder_id`) USING BTREE,
  CONSTRAINT `logistics_purchasest_purchaseorder_id_dd4ffd95_fk_logistics` FOREIGN KEY (`purchaseorder_id`) REFERENCES `logistics_purchaseorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_purchasest_purchasestockinorder_40516e44_fk_logistics` FOREIGN KEY (`purchasestockinorder_id`) REFERENCES `logistics_purchasestockinorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_purchasestockinorder_purchase_orders
-- ----------------------------
INSERT INTO `logistics_purchasestockinorder_purchase_orders` VALUES (1, 1, 12);
INSERT INTO `logistics_purchasestockinorder_purchase_orders` VALUES (2, 2, 10);
INSERT INTO `logistics_purchasestockinorder_purchase_orders` VALUES (3, 10, 6);
INSERT INTO `logistics_purchasestockinorder_purchase_orders` VALUES (4, 11, 13);
INSERT INTO `logistics_purchasestockinorder_purchase_orders` VALUES (5, 13, 12);

-- ----------------------------
-- Table structure for logistics_purchasestockinorderitem
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchasestockinorderitem`;
CREATE TABLE `logistics_purchasestockinorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) UNSIGNED NOT NULL,
  `commodity_id` int(11) NOT NULL,
  `order_number_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `logistics_purchasestocki_order_number_id_commodit_4b65445c_uniq`(`order_number_id`, `commodity_id`) USING BTREE,
  INDEX `logistics_purchasest_commodity_id_4523b3fd_fk_commodity`(`commodity_id`) USING BTREE,
  CONSTRAINT `logistics_purchasest_commodity_id_4523b3fd_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `logistics_purchasest_order_number_id_9d1beb81_fk_logistics` FOREIGN KEY (`order_number_id`) REFERENCES `logistics_purchasestockinorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_purchasestockinorderitem
-- ----------------------------
INSERT INTO `logistics_purchasestockinorderitem` VALUES (1, 2, 1, 1);
INSERT INTO `logistics_purchasestockinorderitem` VALUES (2, 0, 4, 1);
INSERT INTO `logistics_purchasestockinorderitem` VALUES (3, 0, 5, 1);
INSERT INTO `logistics_purchasestockinorderitem` VALUES (4, 1, 3, 2);
INSERT INTO `logistics_purchasestockinorderitem` VALUES (5, 0, 1, 2);
INSERT INTO `logistics_purchasestockinorderitem` VALUES (6, 1, 1, 10);
INSERT INTO `logistics_purchasestockinorderitem` VALUES (7, 10, 1, 11);
INSERT INTO `logistics_purchasestockinorderitem` VALUES (8, 10, 5, 11);
INSERT INTO `logistics_purchasestockinorderitem` VALUES (9, 2, 1, 13);

-- ----------------------------
-- Table structure for shopper_addressinfos
-- ----------------------------
DROP TABLE IF EXISTS `shopper_addressinfos`;
CREATE TABLE `shopper_addressinfos`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `detail` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `city_id` bigint(20) NOT NULL,
  `district_id` bigint(20) NOT NULL,
  `province_id` bigint(20) NOT NULL,
  `phone_number` bigint(20) NOT NULL,
  `recipient_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_addressinfos_user_id_a8203ccf_fk_auth_user_id`(`user_id`) USING BTREE,
  INDEX `shopper_addressinfos_city_id_92d24b61_fk_shopper_region_id`(`city_id`) USING BTREE,
  INDEX `shopper_addressinfos_district_id_05338207_fk_shopper_region_id`(`district_id`) USING BTREE,
  INDEX `shopper_addressinfos_province_id_2abebb47_fk_shopper_region_id`(`province_id`) USING BTREE,
  CONSTRAINT `shopper_addressinfos_city_id_92d24b61_fk_shopper_region_id` FOREIGN KEY (`city_id`) REFERENCES `shopper_region` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_addressinfos_district_id_05338207_fk_shopper_region_id` FOREIGN KEY (`district_id`) REFERENCES `shopper_region` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_addressinfos_province_id_2abebb47_fk_shopper_region_id` FOREIGN KEY (`province_id`) REFERENCES `shopper_region` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_addressinfos_user_id_a8203ccf_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopper_addressinfos
-- ----------------------------
INSERT INTO `shopper_addressinfos` VALUES (1, 16, '2025-04-17 20:06:53.388240', '城关镇文明西路墨香苑6号楼2单元', 1, 140, 1414, 12, 13956769346, '张珂');
INSERT INTO `shopper_addressinfos` VALUES (2, 16, '2025-04-17 20:14:01.561762', '北京邮电大学沙河校区', 0, 32, 385, 1, 13956769346, '张珂');
INSERT INTO `shopper_addressinfos` VALUES (4, 8, '2025-04-20 14:31:18.295704', '城关镇文明西路墨香苑6号楼2单元', 1, 140, 1414, 12, 13956769346, '张珂');
INSERT INTO `shopper_addressinfos` VALUES (5, 19, '2025-04-20 14:32:35.175934', 'Beijing University of Posts and Telecommunications', 1, 32, 385, 1, 13956769346, '张珂');
INSERT INTO `shopper_addressinfos` VALUES (9, 19, '2025-04-20 14:52:27.896587', '家里', 0, 140, 1414, 12, 13956767164, '张敏');
INSERT INTO `shopper_addressinfos` VALUES (11, 18, '2025-04-21 15:44:59.223659', '本所在公司地址', 1, 32, 377, 1, 12222888888, '测试');
INSERT INTO `shopper_addressinfos` VALUES (12, 18, '2025-04-21 20:16:27.541043', '采购公司所在地', 0, 46, 599, 4, 13345678888, '测试');

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
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
INSERT INTO `shopper_cartinfos` VALUES (44, 1, 7, 8);
INSERT INTO `shopper_cartinfos` VALUES (47, 1, 1, 19);

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
  `address_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_orderinfos_user_id_c136f6f2_fk_auth_user_id`(`user_id`) USING BTREE,
  INDEX `shopper_orderinfos_address_id_9fb3bb5e_fk_shopper_a`(`address_id`) USING BTREE,
  CONSTRAINT `shopper_orderinfos_address_id_9fb3bb5e_fk` FOREIGN KEY (`address_id`) REFERENCES `shopper_addressinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_orderinfos_user_id_c136f6f2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopper_orderinfos
-- ----------------------------
INSERT INTO `shopper_orderinfos` VALUES (6, 25800, '2025-04-18', '已发货', NULL, NULL, 16, 1);
INSERT INTO `shopper_orderinfos` VALUES (7, 8357, '2025-04-18', '已发货', NULL, NULL, 16, 2);
INSERT INTO `shopper_orderinfos` VALUES (8, 7250, '2025-04-18', '已发货', NULL, NULL, 16, 2);
INSERT INTO `shopper_orderinfos` VALUES (9, 2983, '2025-04-19', '待揽收', NULL, NULL, 16, 1);
INSERT INTO `shopper_orderinfos` VALUES (10, 5299, '2025-04-20', '已发货', NULL, NULL, 17, 2);
INSERT INTO `shopper_orderinfos` VALUES (11, 5299, '2025-04-20', '已签收', NULL, NULL, 19, 2);
INSERT INTO `shopper_orderinfos` VALUES (19, 1398, '2025-04-22', '已发货', '1745309995', NULL, 19, 5);
INSERT INTO `shopper_orderinfos` VALUES (20, 1398, '2025-04-22', '退款中', '1745312841', 'RF-20250422-001', 19, 5);
INSERT INTO `shopper_orderinfos` VALUES (21, 1398, '2025-04-22', '退款成功', '1745313268', 'RF-20250422-002', 19, 5);
INSERT INTO `shopper_orderinfos` VALUES (22, 1398, '2025-05-02', '已支付', '1746173894', NULL, 19, 5);

-- ----------------------------
-- Table structure for shopper_purchaseinfos
-- ----------------------------
DROP TABLE IF EXISTS `shopper_purchaseinfos`;
CREATE TABLE `shopper_purchaseinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `commodityInfos_id_id` int(11) NOT NULL,
  `order_id` int(11) NULL DEFAULT NULL,
  `unit_price` double NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_purchaseinfo_commodityInfos_id_id_85b45edb_fk_commodity`(`commodityInfos_id_id`) USING BTREE,
  INDEX `shopper_purchaseinfos_order_id_156be8d0_fk_shopper_orderinfos_id`(`order_id`) USING BTREE,
  CONSTRAINT `shopper_purchaseinfo_commodityInfos_id_id_85b45edb_fk_commodity` FOREIGN KEY (`commodityInfos_id_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_purchaseinfos_order_id_156be8d0_fk_shopper_orderinfos_id` FOREIGN KEY (`order_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopper_purchaseinfos
-- ----------------------------
INSERT INTO `shopper_purchaseinfos` VALUES (1, 1, 3, 6, 25800);
INSERT INTO `shopper_purchaseinfos` VALUES (2, 5, 4, 7, 1192);
INSERT INTO `shopper_purchaseinfos` VALUES (3, 3, 2, 7, 799);
INSERT INTO `shopper_purchaseinfos` VALUES (4, 1, 2, 8, 799);
INSERT INTO `shopper_purchaseinfos` VALUES (5, 1, 5, 8, 6451);
INSERT INTO `shopper_purchaseinfos` VALUES (6, 1, 1, 9, 599);
INSERT INTO `shopper_purchaseinfos` VALUES (7, 2, 4, 9, 1192);
INSERT INTO `shopper_purchaseinfos` VALUES (8, 1, 7, 10, 5299);
INSERT INTO `shopper_purchaseinfos` VALUES (9, 1, 7, 11, 5299);
INSERT INTO `shopper_purchaseinfos` VALUES (22, 1, 1, 19, 599);
INSERT INTO `shopper_purchaseinfos` VALUES (23, 1, 2, 19, 799);
INSERT INTO `shopper_purchaseinfos` VALUES (24, 1, 1, 20, 599);
INSERT INTO `shopper_purchaseinfos` VALUES (25, 1, 2, 20, 799);
INSERT INTO `shopper_purchaseinfos` VALUES (26, 1, 1, 21, 599);
INSERT INTO `shopper_purchaseinfos` VALUES (27, 1, 2, 21, 799);
INSERT INTO `shopper_purchaseinfos` VALUES (28, 1, 1, 22, 599);
INSERT INTO `shopper_purchaseinfos` VALUES (29, 1, 2, 22, 799);

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
  `reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `attach` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status_before` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_refundinfos_order_id_1d4e5b94_fk_shopper_orderinfos_id`(`order_id`) USING BTREE,
  INDEX `shopper_refundinfos_user_id_caf0b49d_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `shopper_refundinfos_order_id_1d4e5b94_fk_shopper_orderinfos_id` FOREIGN KEY (`order_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_refundinfos_user_id_caf0b49d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopper_refundinfos
-- ----------------------------
INSERT INTO `shopper_refundinfos` VALUES (3, 'RF-20250422-001', 1398, '2025-04-22', '退款成功', '哈哈哈哈哈', 'details/portrait.png', 20, 19, '已支付');
INSERT INTO `shopper_refundinfos` VALUES (4, 'RF-20250422-002', 1398, '2025-04-22', '退款完成', '哈哈哈哈哈哈', '', 21, 19, '已支付');

-- ----------------------------
-- Table structure for shopper_refundstockinorder
-- ----------------------------
DROP TABLE IF EXISTS `shopper_refundstockinorder`;
CREATE TABLE `shopper_refundstockinorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `notes` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_by_id` int(11) NULL DEFAULT NULL,
  `refund_orders_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE,
  INDEX `shopper_refundstocki_created_by_id_f3fed3a6_fk_auth_user`(`created_by_id`) USING BTREE,
  INDEX `shopper_refundstocki_refund_orders_id_468fa8a5_fk_shopper_r`(`refund_orders_id`) USING BTREE,
  CONSTRAINT `shopper_refundstocki_created_by_id_f3fed3a6_fk_auth_user` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_refundstocki_refund_orders_id_468fa8a5_fk_shopper_r` FOREIGN KEY (`refund_orders_id`) REFERENCES `shopper_refundinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopper_refundstockinorder
-- ----------------------------
INSERT INTO `shopper_refundstockinorder` VALUES (3, 'RSO-20250521-001', '2025-05-21 20:35:00.000000', '', 'completed', 19, 4);
INSERT INTO `shopper_refundstockinorder` VALUES (4, 'RSO-20250521-002', '2025-05-21 20:36:00.000000', '', 'completed', 19, 4);

-- ----------------------------
-- Table structure for shopper_refundstockinorderitem
-- ----------------------------
DROP TABLE IF EXISTS `shopper_refundstockinorderitem`;
CREATE TABLE `shopper_refundstockinorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) UNSIGNED NOT NULL,
  `commodity_id` int(11) NOT NULL,
  `order_number_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shopper_refundstockinord_order_number_id_commodit_ea6903a7_uniq`(`order_number_id`, `commodity_id`) USING BTREE,
  INDEX `shopper_refundstocki_commodity_id_ef00a7f8_fk_commodity`(`commodity_id`) USING BTREE,
  CONSTRAINT `shopper_refundstocki_commodity_id_ef00a7f8_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_refundstocki_order_number_id_00bedc98_fk_shopper_r` FOREIGN KEY (`order_number_id`) REFERENCES `shopper_refundstockinorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopper_refundstockinorderitem
-- ----------------------------
INSERT INTO `shopper_refundstockinorderitem` VALUES (5, 1, 1, 3);
INSERT INTO `shopper_refundstockinorderitem` VALUES (6, 1, 2, 3);
INSERT INTO `shopper_refundstockinorderitem` VALUES (7, 1, 1, 4);
INSERT INTO `shopper_refundstockinorderitem` VALUES (8, 1, 2, 4);

-- ----------------------------
-- Table structure for shopper_region
-- ----------------------------
DROP TABLE IF EXISTS `shopper_region`;
CREATE TABLE `shopper_region`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `level` smallint(5) UNSIGNED NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shopper_region_parent_id_f0f6609f_fk_shopper_region_id`(`parent_id`) USING BTREE,
  CONSTRAINT `shopper_region_parent_id_f0f6609f_fk_shopper_region_id` FOREIGN KEY (`parent_id`) REFERENCES `shopper_region` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3630 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopper_region
-- ----------------------------
INSERT INTO `shopper_region` VALUES (1, '北京市', 1, NULL);
INSERT INTO `shopper_region` VALUES (2, '天津市', 1, NULL);
INSERT INTO `shopper_region` VALUES (3, '河北省', 1, NULL);
INSERT INTO `shopper_region` VALUES (4, '山西省', 1, NULL);
INSERT INTO `shopper_region` VALUES (5, '内蒙古自治区', 1, NULL);
INSERT INTO `shopper_region` VALUES (6, '辽宁省', 1, NULL);
INSERT INTO `shopper_region` VALUES (7, '吉林省', 1, NULL);
INSERT INTO `shopper_region` VALUES (8, '黑龙江省', 1, NULL);
INSERT INTO `shopper_region` VALUES (9, '上海市', 1, NULL);
INSERT INTO `shopper_region` VALUES (10, '江苏省', 1, NULL);
INSERT INTO `shopper_region` VALUES (11, '浙江省', 1, NULL);
INSERT INTO `shopper_region` VALUES (12, '安徽省', 1, NULL);
INSERT INTO `shopper_region` VALUES (13, '福建省', 1, NULL);
INSERT INTO `shopper_region` VALUES (14, '江西省', 1, NULL);
INSERT INTO `shopper_region` VALUES (15, '山东省', 1, NULL);
INSERT INTO `shopper_region` VALUES (16, '河南省', 1, NULL);
INSERT INTO `shopper_region` VALUES (17, '湖北省', 1, NULL);
INSERT INTO `shopper_region` VALUES (18, '湖南省', 1, NULL);
INSERT INTO `shopper_region` VALUES (19, '广东省', 1, NULL);
INSERT INTO `shopper_region` VALUES (20, '广西壮族自治区', 1, NULL);
INSERT INTO `shopper_region` VALUES (21, '海南省', 1, NULL);
INSERT INTO `shopper_region` VALUES (22, '重庆市', 1, NULL);
INSERT INTO `shopper_region` VALUES (23, '四川省', 1, NULL);
INSERT INTO `shopper_region` VALUES (24, '贵州省', 1, NULL);
INSERT INTO `shopper_region` VALUES (25, '云南省', 1, NULL);
INSERT INTO `shopper_region` VALUES (26, '西藏自治区', 1, NULL);
INSERT INTO `shopper_region` VALUES (27, '陕西省', 1, NULL);
INSERT INTO `shopper_region` VALUES (28, '甘肃省', 1, NULL);
INSERT INTO `shopper_region` VALUES (29, '青海省', 1, NULL);
INSERT INTO `shopper_region` VALUES (30, '宁夏回族自治区', 1, NULL);
INSERT INTO `shopper_region` VALUES (31, '新疆维吾尔自治区', 1, NULL);
INSERT INTO `shopper_region` VALUES (32, '市辖区', 2, 1);
INSERT INTO `shopper_region` VALUES (33, '市辖区', 2, 2);
INSERT INTO `shopper_region` VALUES (34, '石家庄市', 2, 3);
INSERT INTO `shopper_region` VALUES (35, '唐山市', 2, 3);
INSERT INTO `shopper_region` VALUES (36, '秦皇岛市', 2, 3);
INSERT INTO `shopper_region` VALUES (37, '邯郸市', 2, 3);
INSERT INTO `shopper_region` VALUES (38, '邢台市', 2, 3);
INSERT INTO `shopper_region` VALUES (39, '保定市', 2, 3);
INSERT INTO `shopper_region` VALUES (40, '张家口市', 2, 3);
INSERT INTO `shopper_region` VALUES (41, '承德市', 2, 3);
INSERT INTO `shopper_region` VALUES (42, '沧州市', 2, 3);
INSERT INTO `shopper_region` VALUES (43, '廊坊市', 2, 3);
INSERT INTO `shopper_region` VALUES (44, '衡水市', 2, 3);
INSERT INTO `shopper_region` VALUES (45, '雄安新区', 2, 3);
INSERT INTO `shopper_region` VALUES (46, '太原市', 2, 4);
INSERT INTO `shopper_region` VALUES (47, '大同市', 2, 4);
INSERT INTO `shopper_region` VALUES (48, '阳泉市', 2, 4);
INSERT INTO `shopper_region` VALUES (49, '长治市', 2, 4);
INSERT INTO `shopper_region` VALUES (50, '晋城市', 2, 4);
INSERT INTO `shopper_region` VALUES (51, '朔州市', 2, 4);
INSERT INTO `shopper_region` VALUES (52, '晋中市', 2, 4);
INSERT INTO `shopper_region` VALUES (53, '运城市', 2, 4);
INSERT INTO `shopper_region` VALUES (54, '忻州市', 2, 4);
INSERT INTO `shopper_region` VALUES (55, '临汾市', 2, 4);
INSERT INTO `shopper_region` VALUES (56, '吕梁市', 2, 4);
INSERT INTO `shopper_region` VALUES (57, '呼和浩特市', 2, 5);
INSERT INTO `shopper_region` VALUES (58, '包头市', 2, 5);
INSERT INTO `shopper_region` VALUES (59, '乌海市', 2, 5);
INSERT INTO `shopper_region` VALUES (60, '赤峰市', 2, 5);
INSERT INTO `shopper_region` VALUES (61, '通辽市', 2, 5);
INSERT INTO `shopper_region` VALUES (62, '鄂尔多斯市', 2, 5);
INSERT INTO `shopper_region` VALUES (63, '呼伦贝尔市', 2, 5);
INSERT INTO `shopper_region` VALUES (64, '巴彦淖尔市', 2, 5);
INSERT INTO `shopper_region` VALUES (65, '乌兰察布市', 2, 5);
INSERT INTO `shopper_region` VALUES (66, '兴安盟', 2, 5);
INSERT INTO `shopper_region` VALUES (67, '锡林郭勒盟', 2, 5);
INSERT INTO `shopper_region` VALUES (68, '阿拉善盟', 2, 5);
INSERT INTO `shopper_region` VALUES (69, '沈阳市', 2, 6);
INSERT INTO `shopper_region` VALUES (70, '大连市', 2, 6);
INSERT INTO `shopper_region` VALUES (71, '鞍山市', 2, 6);
INSERT INTO `shopper_region` VALUES (72, '抚顺市', 2, 6);
INSERT INTO `shopper_region` VALUES (73, '本溪市', 2, 6);
INSERT INTO `shopper_region` VALUES (74, '丹东市', 2, 6);
INSERT INTO `shopper_region` VALUES (75, '锦州市', 2, 6);
INSERT INTO `shopper_region` VALUES (76, '营口市', 2, 6);
INSERT INTO `shopper_region` VALUES (77, '阜新市', 2, 6);
INSERT INTO `shopper_region` VALUES (78, '辽阳市', 2, 6);
INSERT INTO `shopper_region` VALUES (79, '盘锦市', 2, 6);
INSERT INTO `shopper_region` VALUES (80, '铁岭市', 2, 6);
INSERT INTO `shopper_region` VALUES (81, '朝阳市', 2, 6);
INSERT INTO `shopper_region` VALUES (82, '葫芦岛市', 2, 6);
INSERT INTO `shopper_region` VALUES (83, '长春市', 2, 7);
INSERT INTO `shopper_region` VALUES (84, '吉林市', 2, 7);
INSERT INTO `shopper_region` VALUES (85, '四平市', 2, 7);
INSERT INTO `shopper_region` VALUES (86, '辽源市', 2, 7);
INSERT INTO `shopper_region` VALUES (87, '通化市', 2, 7);
INSERT INTO `shopper_region` VALUES (88, '白山市', 2, 7);
INSERT INTO `shopper_region` VALUES (89, '松原市', 2, 7);
INSERT INTO `shopper_region` VALUES (90, '白城市', 2, 7);
INSERT INTO `shopper_region` VALUES (91, '延边朝鲜族自治州', 2, 7);
INSERT INTO `shopper_region` VALUES (92, '哈尔滨市', 2, 8);
INSERT INTO `shopper_region` VALUES (93, '齐齐哈尔市', 2, 8);
INSERT INTO `shopper_region` VALUES (94, '鸡西市', 2, 8);
INSERT INTO `shopper_region` VALUES (95, '鹤岗市', 2, 8);
INSERT INTO `shopper_region` VALUES (96, '双鸭山市', 2, 8);
INSERT INTO `shopper_region` VALUES (97, '大庆市', 2, 8);
INSERT INTO `shopper_region` VALUES (98, '伊春市', 2, 8);
INSERT INTO `shopper_region` VALUES (99, '佳木斯市', 2, 8);
INSERT INTO `shopper_region` VALUES (100, '七台河市', 2, 8);
INSERT INTO `shopper_region` VALUES (101, '牡丹江市', 2, 8);
INSERT INTO `shopper_region` VALUES (102, '黑河市', 2, 8);
INSERT INTO `shopper_region` VALUES (103, '绥化市', 2, 8);
INSERT INTO `shopper_region` VALUES (104, '大兴安岭地区', 2, 8);
INSERT INTO `shopper_region` VALUES (105, '市辖区', 2, 9);
INSERT INTO `shopper_region` VALUES (106, '南京市', 2, 10);
INSERT INTO `shopper_region` VALUES (107, '无锡市', 2, 10);
INSERT INTO `shopper_region` VALUES (108, '徐州市', 2, 10);
INSERT INTO `shopper_region` VALUES (109, '常州市', 2, 10);
INSERT INTO `shopper_region` VALUES (110, '苏州市', 2, 10);
INSERT INTO `shopper_region` VALUES (111, '南通市', 2, 10);
INSERT INTO `shopper_region` VALUES (112, '连云港市', 2, 10);
INSERT INTO `shopper_region` VALUES (113, '淮安市', 2, 10);
INSERT INTO `shopper_region` VALUES (114, '盐城市', 2, 10);
INSERT INTO `shopper_region` VALUES (115, '扬州市', 2, 10);
INSERT INTO `shopper_region` VALUES (116, '镇江市', 2, 10);
INSERT INTO `shopper_region` VALUES (117, '泰州市', 2, 10);
INSERT INTO `shopper_region` VALUES (118, '宿迁市', 2, 10);
INSERT INTO `shopper_region` VALUES (119, '杭州市', 2, 11);
INSERT INTO `shopper_region` VALUES (120, '宁波市', 2, 11);
INSERT INTO `shopper_region` VALUES (121, '温州市', 2, 11);
INSERT INTO `shopper_region` VALUES (122, '嘉兴市', 2, 11);
INSERT INTO `shopper_region` VALUES (123, '湖州市', 2, 11);
INSERT INTO `shopper_region` VALUES (124, '绍兴市', 2, 11);
INSERT INTO `shopper_region` VALUES (125, '金华市', 2, 11);
INSERT INTO `shopper_region` VALUES (126, '衢州市', 2, 11);
INSERT INTO `shopper_region` VALUES (127, '舟山市', 2, 11);
INSERT INTO `shopper_region` VALUES (128, '台州市', 2, 11);
INSERT INTO `shopper_region` VALUES (129, '丽水市', 2, 11);
INSERT INTO `shopper_region` VALUES (130, '合肥市', 2, 12);
INSERT INTO `shopper_region` VALUES (131, '芜湖市', 2, 12);
INSERT INTO `shopper_region` VALUES (132, '蚌埠市', 2, 12);
INSERT INTO `shopper_region` VALUES (133, '淮南市', 2, 12);
INSERT INTO `shopper_region` VALUES (134, '马鞍山市', 2, 12);
INSERT INTO `shopper_region` VALUES (135, '淮北市', 2, 12);
INSERT INTO `shopper_region` VALUES (136, '铜陵市', 2, 12);
INSERT INTO `shopper_region` VALUES (137, '安庆市', 2, 12);
INSERT INTO `shopper_region` VALUES (138, '黄山市', 2, 12);
INSERT INTO `shopper_region` VALUES (139, '滁州市', 2, 12);
INSERT INTO `shopper_region` VALUES (140, '阜阳市', 2, 12);
INSERT INTO `shopper_region` VALUES (141, '宿州市', 2, 12);
INSERT INTO `shopper_region` VALUES (142, '六安市', 2, 12);
INSERT INTO `shopper_region` VALUES (143, '亳州市', 2, 12);
INSERT INTO `shopper_region` VALUES (144, '池州市', 2, 12);
INSERT INTO `shopper_region` VALUES (145, '宣城市', 2, 12);
INSERT INTO `shopper_region` VALUES (146, '福州市', 2, 13);
INSERT INTO `shopper_region` VALUES (147, '厦门市', 2, 13);
INSERT INTO `shopper_region` VALUES (148, '莆田市', 2, 13);
INSERT INTO `shopper_region` VALUES (149, '三明市', 2, 13);
INSERT INTO `shopper_region` VALUES (150, '泉州市', 2, 13);
INSERT INTO `shopper_region` VALUES (151, '漳州市', 2, 13);
INSERT INTO `shopper_region` VALUES (152, '南平市', 2, 13);
INSERT INTO `shopper_region` VALUES (153, '龙岩市', 2, 13);
INSERT INTO `shopper_region` VALUES (154, '宁德市', 2, 13);
INSERT INTO `shopper_region` VALUES (155, '南昌市', 2, 14);
INSERT INTO `shopper_region` VALUES (156, '景德镇市', 2, 14);
INSERT INTO `shopper_region` VALUES (157, '萍乡市', 2, 14);
INSERT INTO `shopper_region` VALUES (158, '九江市', 2, 14);
INSERT INTO `shopper_region` VALUES (159, '新余市', 2, 14);
INSERT INTO `shopper_region` VALUES (160, '鹰潭市', 2, 14);
INSERT INTO `shopper_region` VALUES (161, '赣州市', 2, 14);
INSERT INTO `shopper_region` VALUES (162, '吉安市', 2, 14);
INSERT INTO `shopper_region` VALUES (163, '宜春市', 2, 14);
INSERT INTO `shopper_region` VALUES (164, '抚州市', 2, 14);
INSERT INTO `shopper_region` VALUES (165, '上饶市', 2, 14);
INSERT INTO `shopper_region` VALUES (166, '济南市', 2, 15);
INSERT INTO `shopper_region` VALUES (167, '青岛市', 2, 15);
INSERT INTO `shopper_region` VALUES (168, '淄博市', 2, 15);
INSERT INTO `shopper_region` VALUES (169, '枣庄市', 2, 15);
INSERT INTO `shopper_region` VALUES (170, '东营市', 2, 15);
INSERT INTO `shopper_region` VALUES (171, '烟台市', 2, 15);
INSERT INTO `shopper_region` VALUES (172, '潍坊市', 2, 15);
INSERT INTO `shopper_region` VALUES (173, '济宁市', 2, 15);
INSERT INTO `shopper_region` VALUES (174, '泰安市', 2, 15);
INSERT INTO `shopper_region` VALUES (175, '威海市', 2, 15);
INSERT INTO `shopper_region` VALUES (176, '日照市', 2, 15);
INSERT INTO `shopper_region` VALUES (177, '临沂市', 2, 15);
INSERT INTO `shopper_region` VALUES (178, '德州市', 2, 15);
INSERT INTO `shopper_region` VALUES (179, '聊城市', 2, 15);
INSERT INTO `shopper_region` VALUES (180, '滨州市', 2, 15);
INSERT INTO `shopper_region` VALUES (181, '菏泽市', 2, 15);
INSERT INTO `shopper_region` VALUES (182, '郑州市', 2, 16);
INSERT INTO `shopper_region` VALUES (183, '开封市', 2, 16);
INSERT INTO `shopper_region` VALUES (184, '洛阳市', 2, 16);
INSERT INTO `shopper_region` VALUES (185, '平顶山市', 2, 16);
INSERT INTO `shopper_region` VALUES (186, '安阳市', 2, 16);
INSERT INTO `shopper_region` VALUES (187, '鹤壁市', 2, 16);
INSERT INTO `shopper_region` VALUES (188, '新乡市', 2, 16);
INSERT INTO `shopper_region` VALUES (189, '焦作市', 2, 16);
INSERT INTO `shopper_region` VALUES (190, '濮阳市', 2, 16);
INSERT INTO `shopper_region` VALUES (191, '许昌市', 2, 16);
INSERT INTO `shopper_region` VALUES (192, '漯河市', 2, 16);
INSERT INTO `shopper_region` VALUES (193, '三门峡市', 2, 16);
INSERT INTO `shopper_region` VALUES (194, '南阳市', 2, 16);
INSERT INTO `shopper_region` VALUES (195, '商丘市', 2, 16);
INSERT INTO `shopper_region` VALUES (196, '信阳市', 2, 16);
INSERT INTO `shopper_region` VALUES (197, '周口市', 2, 16);
INSERT INTO `shopper_region` VALUES (198, '驻马店市', 2, 16);
INSERT INTO `shopper_region` VALUES (199, '省直辖县级行政区划', 2, 16);
INSERT INTO `shopper_region` VALUES (200, '武汉市', 2, 17);
INSERT INTO `shopper_region` VALUES (201, '黄石市', 2, 17);
INSERT INTO `shopper_region` VALUES (202, '十堰市', 2, 17);
INSERT INTO `shopper_region` VALUES (203, '宜昌市', 2, 17);
INSERT INTO `shopper_region` VALUES (204, '襄阳市', 2, 17);
INSERT INTO `shopper_region` VALUES (205, '鄂州市', 2, 17);
INSERT INTO `shopper_region` VALUES (206, '荆门市', 2, 17);
INSERT INTO `shopper_region` VALUES (207, '孝感市', 2, 17);
INSERT INTO `shopper_region` VALUES (208, '荆州市', 2, 17);
INSERT INTO `shopper_region` VALUES (209, '黄冈市', 2, 17);
INSERT INTO `shopper_region` VALUES (210, '咸宁市', 2, 17);
INSERT INTO `shopper_region` VALUES (211, '随州市', 2, 17);
INSERT INTO `shopper_region` VALUES (212, '恩施土家族苗族自治州', 2, 17);
INSERT INTO `shopper_region` VALUES (213, '省直辖县级行政区划', 2, 17);
INSERT INTO `shopper_region` VALUES (214, '长沙市', 2, 18);
INSERT INTO `shopper_region` VALUES (215, '株洲市', 2, 18);
INSERT INTO `shopper_region` VALUES (216, '湘潭市', 2, 18);
INSERT INTO `shopper_region` VALUES (217, '衡阳市', 2, 18);
INSERT INTO `shopper_region` VALUES (218, '邵阳市', 2, 18);
INSERT INTO `shopper_region` VALUES (219, '岳阳市', 2, 18);
INSERT INTO `shopper_region` VALUES (220, '常德市', 2, 18);
INSERT INTO `shopper_region` VALUES (221, '张家界市', 2, 18);
INSERT INTO `shopper_region` VALUES (222, '益阳市', 2, 18);
INSERT INTO `shopper_region` VALUES (223, '郴州市', 2, 18);
INSERT INTO `shopper_region` VALUES (224, '永州市', 2, 18);
INSERT INTO `shopper_region` VALUES (225, '怀化市', 2, 18);
INSERT INTO `shopper_region` VALUES (226, '娄底市', 2, 18);
INSERT INTO `shopper_region` VALUES (227, '湘西土家族苗族自治州', 2, 18);
INSERT INTO `shopper_region` VALUES (228, '广州市', 2, 19);
INSERT INTO `shopper_region` VALUES (229, '韶关市', 2, 19);
INSERT INTO `shopper_region` VALUES (230, '深圳市', 2, 19);
INSERT INTO `shopper_region` VALUES (231, '珠海市', 2, 19);
INSERT INTO `shopper_region` VALUES (232, '汕头市', 2, 19);
INSERT INTO `shopper_region` VALUES (233, '佛山市', 2, 19);
INSERT INTO `shopper_region` VALUES (234, '江门市', 2, 19);
INSERT INTO `shopper_region` VALUES (235, '湛江市', 2, 19);
INSERT INTO `shopper_region` VALUES (236, '茂名市', 2, 19);
INSERT INTO `shopper_region` VALUES (237, '肇庆市', 2, 19);
INSERT INTO `shopper_region` VALUES (238, '惠州市', 2, 19);
INSERT INTO `shopper_region` VALUES (239, '梅州市', 2, 19);
INSERT INTO `shopper_region` VALUES (240, '汕尾市', 2, 19);
INSERT INTO `shopper_region` VALUES (241, '河源市', 2, 19);
INSERT INTO `shopper_region` VALUES (242, '阳江市', 2, 19);
INSERT INTO `shopper_region` VALUES (243, '清远市', 2, 19);
INSERT INTO `shopper_region` VALUES (244, '东莞市', 2, 19);
INSERT INTO `shopper_region` VALUES (245, '中山市', 2, 19);
INSERT INTO `shopper_region` VALUES (246, '潮州市', 2, 19);
INSERT INTO `shopper_region` VALUES (247, '揭阳市', 2, 19);
INSERT INTO `shopper_region` VALUES (248, '云浮市', 2, 19);
INSERT INTO `shopper_region` VALUES (249, '南宁市', 2, 20);
INSERT INTO `shopper_region` VALUES (250, '柳州市', 2, 20);
INSERT INTO `shopper_region` VALUES (251, '桂林市', 2, 20);
INSERT INTO `shopper_region` VALUES (252, '梧州市', 2, 20);
INSERT INTO `shopper_region` VALUES (253, '北海市', 2, 20);
INSERT INTO `shopper_region` VALUES (254, '防城港市', 2, 20);
INSERT INTO `shopper_region` VALUES (255, '钦州市', 2, 20);
INSERT INTO `shopper_region` VALUES (256, '贵港市', 2, 20);
INSERT INTO `shopper_region` VALUES (257, '玉林市', 2, 20);
INSERT INTO `shopper_region` VALUES (258, '百色市', 2, 20);
INSERT INTO `shopper_region` VALUES (259, '贺州市', 2, 20);
INSERT INTO `shopper_region` VALUES (260, '河池市', 2, 20);
INSERT INTO `shopper_region` VALUES (261, '来宾市', 2, 20);
INSERT INTO `shopper_region` VALUES (262, '崇左市', 2, 20);
INSERT INTO `shopper_region` VALUES (263, '海口市', 2, 21);
INSERT INTO `shopper_region` VALUES (264, '三亚市', 2, 21);
INSERT INTO `shopper_region` VALUES (265, '三沙市', 2, 21);
INSERT INTO `shopper_region` VALUES (266, '儋州市', 2, 21);
INSERT INTO `shopper_region` VALUES (267, '省直辖县级行政区划', 2, 21);
INSERT INTO `shopper_region` VALUES (268, '市辖区', 2, 22);
INSERT INTO `shopper_region` VALUES (269, '成都市', 2, 23);
INSERT INTO `shopper_region` VALUES (270, '自贡市', 2, 23);
INSERT INTO `shopper_region` VALUES (271, '攀枝花市', 2, 23);
INSERT INTO `shopper_region` VALUES (272, '泸州市', 2, 23);
INSERT INTO `shopper_region` VALUES (273, '德阳市', 2, 23);
INSERT INTO `shopper_region` VALUES (274, '绵阳市', 2, 23);
INSERT INTO `shopper_region` VALUES (275, '广元市', 2, 23);
INSERT INTO `shopper_region` VALUES (276, '遂宁市', 2, 23);
INSERT INTO `shopper_region` VALUES (277, '内江市', 2, 23);
INSERT INTO `shopper_region` VALUES (278, '乐山市', 2, 23);
INSERT INTO `shopper_region` VALUES (279, '南充市', 2, 23);
INSERT INTO `shopper_region` VALUES (280, '眉山市', 2, 23);
INSERT INTO `shopper_region` VALUES (281, '宜宾市', 2, 23);
INSERT INTO `shopper_region` VALUES (282, '广安市', 2, 23);
INSERT INTO `shopper_region` VALUES (283, '达州市', 2, 23);
INSERT INTO `shopper_region` VALUES (284, '雅安市', 2, 23);
INSERT INTO `shopper_region` VALUES (285, '巴中市', 2, 23);
INSERT INTO `shopper_region` VALUES (286, '资阳市', 2, 23);
INSERT INTO `shopper_region` VALUES (287, '阿坝藏族羌族自治州', 2, 23);
INSERT INTO `shopper_region` VALUES (288, '甘孜藏族自治州', 2, 23);
INSERT INTO `shopper_region` VALUES (289, '凉山彝族自治州', 2, 23);
INSERT INTO `shopper_region` VALUES (290, '贵阳市', 2, 24);
INSERT INTO `shopper_region` VALUES (291, '六盘水市', 2, 24);
INSERT INTO `shopper_region` VALUES (292, '遵义市', 2, 24);
INSERT INTO `shopper_region` VALUES (293, '安顺市', 2, 24);
INSERT INTO `shopper_region` VALUES (294, '毕节市', 2, 24);
INSERT INTO `shopper_region` VALUES (295, '铜仁市', 2, 24);
INSERT INTO `shopper_region` VALUES (296, '黔西南布依族苗族自治州', 2, 24);
INSERT INTO `shopper_region` VALUES (297, '黔东南苗族侗族自治州', 2, 24);
INSERT INTO `shopper_region` VALUES (298, '黔南布依族苗族自治州', 2, 24);
INSERT INTO `shopper_region` VALUES (299, '昆明市', 2, 25);
INSERT INTO `shopper_region` VALUES (300, '曲靖市', 2, 25);
INSERT INTO `shopper_region` VALUES (301, '玉溪市', 2, 25);
INSERT INTO `shopper_region` VALUES (302, '保山市', 2, 25);
INSERT INTO `shopper_region` VALUES (303, '昭通市', 2, 25);
INSERT INTO `shopper_region` VALUES (304, '丽江市', 2, 25);
INSERT INTO `shopper_region` VALUES (305, '普洱市', 2, 25);
INSERT INTO `shopper_region` VALUES (306, '临沧市', 2, 25);
INSERT INTO `shopper_region` VALUES (307, '楚雄彝族自治州', 2, 25);
INSERT INTO `shopper_region` VALUES (308, '红河哈尼族彝族自治州', 2, 25);
INSERT INTO `shopper_region` VALUES (309, '文山壮族苗族自治州', 2, 25);
INSERT INTO `shopper_region` VALUES (310, '西双版纳傣族自治州', 2, 25);
INSERT INTO `shopper_region` VALUES (311, '大理白族自治州', 2, 25);
INSERT INTO `shopper_region` VALUES (312, '德宏傣族景颇族自治州', 2, 25);
INSERT INTO `shopper_region` VALUES (313, '怒江傈僳族自治州', 2, 25);
INSERT INTO `shopper_region` VALUES (314, '迪庆藏族自治州', 2, 25);
INSERT INTO `shopper_region` VALUES (315, '拉萨市', 2, 26);
INSERT INTO `shopper_region` VALUES (316, '日喀则市', 2, 26);
INSERT INTO `shopper_region` VALUES (317, '昌都市', 2, 26);
INSERT INTO `shopper_region` VALUES (318, '林芝市', 2, 26);
INSERT INTO `shopper_region` VALUES (319, '山南市', 2, 26);
INSERT INTO `shopper_region` VALUES (320, '那曲市', 2, 26);
INSERT INTO `shopper_region` VALUES (321, '阿里地区', 2, 26);
INSERT INTO `shopper_region` VALUES (322, '西安市', 2, 27);
INSERT INTO `shopper_region` VALUES (323, '铜川市', 2, 27);
INSERT INTO `shopper_region` VALUES (324, '宝鸡市', 2, 27);
INSERT INTO `shopper_region` VALUES (325, '咸阳市', 2, 27);
INSERT INTO `shopper_region` VALUES (326, '渭南市', 2, 27);
INSERT INTO `shopper_region` VALUES (327, '延安市', 2, 27);
INSERT INTO `shopper_region` VALUES (328, '汉中市', 2, 27);
INSERT INTO `shopper_region` VALUES (329, '榆林市', 2, 27);
INSERT INTO `shopper_region` VALUES (330, '安康市', 2, 27);
INSERT INTO `shopper_region` VALUES (331, '商洛市', 2, 27);
INSERT INTO `shopper_region` VALUES (332, '兰州市', 2, 28);
INSERT INTO `shopper_region` VALUES (333, '嘉峪关市', 2, 28);
INSERT INTO `shopper_region` VALUES (334, '金昌市', 2, 28);
INSERT INTO `shopper_region` VALUES (335, '白银市', 2, 28);
INSERT INTO `shopper_region` VALUES (336, '天水市', 2, 28);
INSERT INTO `shopper_region` VALUES (337, '武威市', 2, 28);
INSERT INTO `shopper_region` VALUES (338, '张掖市', 2, 28);
INSERT INTO `shopper_region` VALUES (339, '平凉市', 2, 28);
INSERT INTO `shopper_region` VALUES (340, '酒泉市', 2, 28);
INSERT INTO `shopper_region` VALUES (341, '庆阳市', 2, 28);
INSERT INTO `shopper_region` VALUES (342, '定西市', 2, 28);
INSERT INTO `shopper_region` VALUES (343, '陇南市', 2, 28);
INSERT INTO `shopper_region` VALUES (344, '临夏回族自治州', 2, 28);
INSERT INTO `shopper_region` VALUES (345, '甘南藏族自治州', 2, 28);
INSERT INTO `shopper_region` VALUES (346, '西宁市', 2, 29);
INSERT INTO `shopper_region` VALUES (347, '海东市', 2, 29);
INSERT INTO `shopper_region` VALUES (348, '海北藏族自治州', 2, 29);
INSERT INTO `shopper_region` VALUES (349, '黄南藏族自治州', 2, 29);
INSERT INTO `shopper_region` VALUES (350, '海南藏族自治州', 2, 29);
INSERT INTO `shopper_region` VALUES (351, '果洛藏族自治州', 2, 29);
INSERT INTO `shopper_region` VALUES (352, '玉树藏族自治州', 2, 29);
INSERT INTO `shopper_region` VALUES (353, '海西蒙古族藏族自治州', 2, 29);
INSERT INTO `shopper_region` VALUES (354, '银川市', 2, 30);
INSERT INTO `shopper_region` VALUES (355, '石嘴山市', 2, 30);
INSERT INTO `shopper_region` VALUES (356, '吴忠市', 2, 30);
INSERT INTO `shopper_region` VALUES (357, '固原市', 2, 30);
INSERT INTO `shopper_region` VALUES (358, '中卫市', 2, 30);
INSERT INTO `shopper_region` VALUES (359, '乌鲁木齐市', 2, 31);
INSERT INTO `shopper_region` VALUES (360, '克拉玛依市', 2, 31);
INSERT INTO `shopper_region` VALUES (361, '吐鲁番市', 2, 31);
INSERT INTO `shopper_region` VALUES (362, '哈密市', 2, 31);
INSERT INTO `shopper_region` VALUES (363, '昌吉回族自治州', 2, 31);
INSERT INTO `shopper_region` VALUES (364, '博尔塔拉蒙古自治州', 2, 31);
INSERT INTO `shopper_region` VALUES (365, '巴音郭楞蒙古自治州', 2, 31);
INSERT INTO `shopper_region` VALUES (366, '阿克苏地区', 2, 31);
INSERT INTO `shopper_region` VALUES (367, '克孜勒苏柯尔克孜自治州', 2, 31);
INSERT INTO `shopper_region` VALUES (368, '喀什地区', 2, 31);
INSERT INTO `shopper_region` VALUES (369, '和田地区', 2, 31);
INSERT INTO `shopper_region` VALUES (370, '伊犁哈萨克自治州', 2, 31);
INSERT INTO `shopper_region` VALUES (371, '塔城地区', 2, 31);
INSERT INTO `shopper_region` VALUES (372, '阿勒泰地区', 2, 31);
INSERT INTO `shopper_region` VALUES (373, '自治区直辖县级行政区划', 2, 31);
INSERT INTO `shopper_region` VALUES (374, '县', 2, 22);
INSERT INTO `shopper_region` VALUES (375, '东城区', 3, 32);
INSERT INTO `shopper_region` VALUES (376, '西城区', 3, 32);
INSERT INTO `shopper_region` VALUES (377, '朝阳区', 3, 32);
INSERT INTO `shopper_region` VALUES (378, '丰台区', 3, 32);
INSERT INTO `shopper_region` VALUES (379, '石景山区', 3, 32);
INSERT INTO `shopper_region` VALUES (380, '海淀区', 3, 32);
INSERT INTO `shopper_region` VALUES (381, '门头沟区', 3, 32);
INSERT INTO `shopper_region` VALUES (382, '房山区', 3, 32);
INSERT INTO `shopper_region` VALUES (383, '通州区', 3, 32);
INSERT INTO `shopper_region` VALUES (384, '顺义区', 3, 32);
INSERT INTO `shopper_region` VALUES (385, '昌平区', 3, 32);
INSERT INTO `shopper_region` VALUES (386, '大兴区', 3, 32);
INSERT INTO `shopper_region` VALUES (387, '怀柔区', 3, 32);
INSERT INTO `shopper_region` VALUES (388, '平谷区', 3, 32);
INSERT INTO `shopper_region` VALUES (389, '密云区', 3, 32);
INSERT INTO `shopper_region` VALUES (390, '延庆区', 3, 32);
INSERT INTO `shopper_region` VALUES (391, '和平区', 3, 33);
INSERT INTO `shopper_region` VALUES (392, '河东区', 3, 33);
INSERT INTO `shopper_region` VALUES (393, '河西区', 3, 33);
INSERT INTO `shopper_region` VALUES (394, '南开区', 3, 33);
INSERT INTO `shopper_region` VALUES (395, '河北区', 3, 33);
INSERT INTO `shopper_region` VALUES (396, '红桥区', 3, 33);
INSERT INTO `shopper_region` VALUES (397, '东丽区', 3, 33);
INSERT INTO `shopper_region` VALUES (398, '西青区', 3, 33);
INSERT INTO `shopper_region` VALUES (399, '津南区', 3, 33);
INSERT INTO `shopper_region` VALUES (400, '北辰区', 3, 33);
INSERT INTO `shopper_region` VALUES (401, '武清区', 3, 33);
INSERT INTO `shopper_region` VALUES (402, '宝坻区', 3, 33);
INSERT INTO `shopper_region` VALUES (403, '滨海新区', 3, 33);
INSERT INTO `shopper_region` VALUES (404, '宁河区', 3, 33);
INSERT INTO `shopper_region` VALUES (405, '静海区', 3, 33);
INSERT INTO `shopper_region` VALUES (406, '蓟州区', 3, 33);
INSERT INTO `shopper_region` VALUES (407, '长安区', 3, 34);
INSERT INTO `shopper_region` VALUES (408, '桥西区', 3, 34);
INSERT INTO `shopper_region` VALUES (409, '新华区', 3, 34);
INSERT INTO `shopper_region` VALUES (410, '井陉矿区', 3, 34);
INSERT INTO `shopper_region` VALUES (411, '裕华区', 3, 34);
INSERT INTO `shopper_region` VALUES (412, '藁城区', 3, 34);
INSERT INTO `shopper_region` VALUES (413, '鹿泉区', 3, 34);
INSERT INTO `shopper_region` VALUES (414, '栾城区', 3, 34);
INSERT INTO `shopper_region` VALUES (415, '井陉县', 3, 34);
INSERT INTO `shopper_region` VALUES (416, '正定县', 3, 34);
INSERT INTO `shopper_region` VALUES (417, '行唐县', 3, 34);
INSERT INTO `shopper_region` VALUES (418, '灵寿县', 3, 34);
INSERT INTO `shopper_region` VALUES (419, '高邑县', 3, 34);
INSERT INTO `shopper_region` VALUES (420, '深泽县', 3, 34);
INSERT INTO `shopper_region` VALUES (421, '赞皇县', 3, 34);
INSERT INTO `shopper_region` VALUES (422, '无极县', 3, 34);
INSERT INTO `shopper_region` VALUES (423, '平山县', 3, 34);
INSERT INTO `shopper_region` VALUES (424, '元氏县', 3, 34);
INSERT INTO `shopper_region` VALUES (425, '赵县', 3, 34);
INSERT INTO `shopper_region` VALUES (426, '石家庄高新技术产业开发区', 3, 34);
INSERT INTO `shopper_region` VALUES (427, '石家庄循环化工园区', 3, 34);
INSERT INTO `shopper_region` VALUES (428, '辛集市', 3, 34);
INSERT INTO `shopper_region` VALUES (429, '晋州市', 3, 34);
INSERT INTO `shopper_region` VALUES (430, '新乐市', 3, 34);
INSERT INTO `shopper_region` VALUES (431, '路南区', 3, 35);
INSERT INTO `shopper_region` VALUES (432, '路北区', 3, 35);
INSERT INTO `shopper_region` VALUES (433, '古冶区', 3, 35);
INSERT INTO `shopper_region` VALUES (434, '开平区', 3, 35);
INSERT INTO `shopper_region` VALUES (435, '丰南区', 3, 35);
INSERT INTO `shopper_region` VALUES (436, '丰润区', 3, 35);
INSERT INTO `shopper_region` VALUES (437, '曹妃甸区', 3, 35);
INSERT INTO `shopper_region` VALUES (438, '滦南县', 3, 35);
INSERT INTO `shopper_region` VALUES (439, '乐亭县', 3, 35);
INSERT INTO `shopper_region` VALUES (440, '迁西县', 3, 35);
INSERT INTO `shopper_region` VALUES (441, '玉田县', 3, 35);
INSERT INTO `shopper_region` VALUES (442, '河北唐山芦台经济开发区', 3, 35);
INSERT INTO `shopper_region` VALUES (443, '唐山市汉沽管理区', 3, 35);
INSERT INTO `shopper_region` VALUES (444, '唐山高新技术产业开发区', 3, 35);
INSERT INTO `shopper_region` VALUES (445, '河北唐山海港经济开发区', 3, 35);
INSERT INTO `shopper_region` VALUES (446, '遵化市', 3, 35);
INSERT INTO `shopper_region` VALUES (447, '迁安市', 3, 35);
INSERT INTO `shopper_region` VALUES (448, '滦州市', 3, 35);
INSERT INTO `shopper_region` VALUES (449, '海港区', 3, 36);
INSERT INTO `shopper_region` VALUES (450, '山海关区', 3, 36);
INSERT INTO `shopper_region` VALUES (451, '北戴河区', 3, 36);
INSERT INTO `shopper_region` VALUES (452, '抚宁区', 3, 36);
INSERT INTO `shopper_region` VALUES (453, '青龙满族自治县', 3, 36);
INSERT INTO `shopper_region` VALUES (454, '昌黎县', 3, 36);
INSERT INTO `shopper_region` VALUES (455, '卢龙县', 3, 36);
INSERT INTO `shopper_region` VALUES (456, '秦皇岛市经济技术开发区', 3, 36);
INSERT INTO `shopper_region` VALUES (457, '北戴河新区', 3, 36);
INSERT INTO `shopper_region` VALUES (458, '邯山区', 3, 37);
INSERT INTO `shopper_region` VALUES (459, '丛台区', 3, 37);
INSERT INTO `shopper_region` VALUES (460, '复兴区', 3, 37);
INSERT INTO `shopper_region` VALUES (461, '峰峰矿区', 3, 37);
INSERT INTO `shopper_region` VALUES (462, '肥乡区', 3, 37);
INSERT INTO `shopper_region` VALUES (463, '永年区', 3, 37);
INSERT INTO `shopper_region` VALUES (464, '临漳县', 3, 37);
INSERT INTO `shopper_region` VALUES (465, '成安县', 3, 37);
INSERT INTO `shopper_region` VALUES (466, '大名县', 3, 37);
INSERT INTO `shopper_region` VALUES (467, '涉县', 3, 37);
INSERT INTO `shopper_region` VALUES (468, '磁县', 3, 37);
INSERT INTO `shopper_region` VALUES (469, '邱县', 3, 37);
INSERT INTO `shopper_region` VALUES (470, '鸡泽县', 3, 37);
INSERT INTO `shopper_region` VALUES (471, '广平县', 3, 37);
INSERT INTO `shopper_region` VALUES (472, '馆陶县', 3, 37);
INSERT INTO `shopper_region` VALUES (473, '魏县', 3, 37);
INSERT INTO `shopper_region` VALUES (474, '曲周县', 3, 37);
INSERT INTO `shopper_region` VALUES (475, '邯郸经济技术开发区', 3, 37);
INSERT INTO `shopper_region` VALUES (476, '邯郸冀南新区', 3, 37);
INSERT INTO `shopper_region` VALUES (477, '武安市', 3, 37);
INSERT INTO `shopper_region` VALUES (478, '襄都区', 3, 38);
INSERT INTO `shopper_region` VALUES (479, '信都区', 3, 38);
INSERT INTO `shopper_region` VALUES (480, '任泽区', 3, 38);
INSERT INTO `shopper_region` VALUES (481, '南和区', 3, 38);
INSERT INTO `shopper_region` VALUES (482, '临城县', 3, 38);
INSERT INTO `shopper_region` VALUES (483, '内丘县', 3, 38);
INSERT INTO `shopper_region` VALUES (484, '柏乡县', 3, 38);
INSERT INTO `shopper_region` VALUES (485, '隆尧县', 3, 38);
INSERT INTO `shopper_region` VALUES (486, '宁晋县', 3, 38);
INSERT INTO `shopper_region` VALUES (487, '巨鹿县', 3, 38);
INSERT INTO `shopper_region` VALUES (488, '新河县', 3, 38);
INSERT INTO `shopper_region` VALUES (489, '广宗县', 3, 38);
INSERT INTO `shopper_region` VALUES (490, '平乡县', 3, 38);
INSERT INTO `shopper_region` VALUES (491, '威县', 3, 38);
INSERT INTO `shopper_region` VALUES (492, '清河县', 3, 38);
INSERT INTO `shopper_region` VALUES (493, '临西县', 3, 38);
INSERT INTO `shopper_region` VALUES (494, '河北邢台经济开发区', 3, 38);
INSERT INTO `shopper_region` VALUES (495, '南宫市', 3, 38);
INSERT INTO `shopper_region` VALUES (496, '沙河市', 3, 38);
INSERT INTO `shopper_region` VALUES (497, '竞秀区', 3, 39);
INSERT INTO `shopper_region` VALUES (498, '莲池区', 3, 39);
INSERT INTO `shopper_region` VALUES (499, '满城区', 3, 39);
INSERT INTO `shopper_region` VALUES (500, '清苑区', 3, 39);
INSERT INTO `shopper_region` VALUES (501, '徐水区', 3, 39);
INSERT INTO `shopper_region` VALUES (502, '涞水县', 3, 39);
INSERT INTO `shopper_region` VALUES (503, '阜平县', 3, 39);
INSERT INTO `shopper_region` VALUES (504, '定兴县', 3, 39);
INSERT INTO `shopper_region` VALUES (505, '唐县', 3, 39);
INSERT INTO `shopper_region` VALUES (506, '高阳县', 3, 39);
INSERT INTO `shopper_region` VALUES (507, '容城县', 3, 39);
INSERT INTO `shopper_region` VALUES (508, '涞源县', 3, 39);
INSERT INTO `shopper_region` VALUES (509, '望都县', 3, 39);
INSERT INTO `shopper_region` VALUES (510, '安新县', 3, 39);
INSERT INTO `shopper_region` VALUES (511, '易县', 3, 39);
INSERT INTO `shopper_region` VALUES (512, '曲阳县', 3, 39);
INSERT INTO `shopper_region` VALUES (513, '蠡县', 3, 39);
INSERT INTO `shopper_region` VALUES (514, '顺平县', 3, 39);
INSERT INTO `shopper_region` VALUES (515, '博野县', 3, 39);
INSERT INTO `shopper_region` VALUES (516, '雄县', 3, 39);
INSERT INTO `shopper_region` VALUES (517, '保定高新技术产业开发区', 3, 39);
INSERT INTO `shopper_region` VALUES (518, '保定白沟新城', 3, 39);
INSERT INTO `shopper_region` VALUES (519, '涿州市', 3, 39);
INSERT INTO `shopper_region` VALUES (520, '定州市', 3, 39);
INSERT INTO `shopper_region` VALUES (521, '安国市', 3, 39);
INSERT INTO `shopper_region` VALUES (522, '高碑店市', 3, 39);
INSERT INTO `shopper_region` VALUES (523, '桥东区', 3, 40);
INSERT INTO `shopper_region` VALUES (524, '桥西区', 3, 40);
INSERT INTO `shopper_region` VALUES (525, '宣化区', 3, 40);
INSERT INTO `shopper_region` VALUES (526, '下花园区', 3, 40);
INSERT INTO `shopper_region` VALUES (527, '万全区', 3, 40);
INSERT INTO `shopper_region` VALUES (528, '崇礼区', 3, 40);
INSERT INTO `shopper_region` VALUES (529, '张北县', 3, 40);
INSERT INTO `shopper_region` VALUES (530, '康保县', 3, 40);
INSERT INTO `shopper_region` VALUES (531, '沽源县', 3, 40);
INSERT INTO `shopper_region` VALUES (532, '尚义县', 3, 40);
INSERT INTO `shopper_region` VALUES (533, '蔚县', 3, 40);
INSERT INTO `shopper_region` VALUES (534, '阳原县', 3, 40);
INSERT INTO `shopper_region` VALUES (535, '怀安县', 3, 40);
INSERT INTO `shopper_region` VALUES (536, '怀来县', 3, 40);
INSERT INTO `shopper_region` VALUES (537, '涿鹿县', 3, 40);
INSERT INTO `shopper_region` VALUES (538, '赤城县', 3, 40);
INSERT INTO `shopper_region` VALUES (539, '张家口经济开发区', 3, 40);
INSERT INTO `shopper_region` VALUES (540, '张家口市察北管理区', 3, 40);
INSERT INTO `shopper_region` VALUES (541, '张家口市塞北管理区', 3, 40);
INSERT INTO `shopper_region` VALUES (542, '双桥区', 3, 41);
INSERT INTO `shopper_region` VALUES (543, '双滦区', 3, 41);
INSERT INTO `shopper_region` VALUES (544, '鹰手营子矿区', 3, 41);
INSERT INTO `shopper_region` VALUES (545, '承德县', 3, 41);
INSERT INTO `shopper_region` VALUES (546, '兴隆县', 3, 41);
INSERT INTO `shopper_region` VALUES (547, '滦平县', 3, 41);
INSERT INTO `shopper_region` VALUES (548, '隆化县', 3, 41);
INSERT INTO `shopper_region` VALUES (549, '丰宁满族自治县', 3, 41);
INSERT INTO `shopper_region` VALUES (550, '宽城满族自治县', 3, 41);
INSERT INTO `shopper_region` VALUES (551, '围场满族蒙古族自治县', 3, 41);
INSERT INTO `shopper_region` VALUES (552, '承德高新技术产业开发区', 3, 41);
INSERT INTO `shopper_region` VALUES (553, '平泉市', 3, 41);
INSERT INTO `shopper_region` VALUES (554, '新华区', 3, 42);
INSERT INTO `shopper_region` VALUES (555, '运河区', 3, 42);
INSERT INTO `shopper_region` VALUES (556, '沧县', 3, 42);
INSERT INTO `shopper_region` VALUES (557, '青县', 3, 42);
INSERT INTO `shopper_region` VALUES (558, '东光县', 3, 42);
INSERT INTO `shopper_region` VALUES (559, '海兴县', 3, 42);
INSERT INTO `shopper_region` VALUES (560, '盐山县', 3, 42);
INSERT INTO `shopper_region` VALUES (561, '肃宁县', 3, 42);
INSERT INTO `shopper_region` VALUES (562, '南皮县', 3, 42);
INSERT INTO `shopper_region` VALUES (563, '吴桥县', 3, 42);
INSERT INTO `shopper_region` VALUES (564, '献县', 3, 42);
INSERT INTO `shopper_region` VALUES (565, '孟村回族自治县', 3, 42);
INSERT INTO `shopper_region` VALUES (566, '河北沧州经济开发区', 3, 42);
INSERT INTO `shopper_region` VALUES (567, '沧州高新技术产业开发区', 3, 42);
INSERT INTO `shopper_region` VALUES (568, '沧州渤海新区', 3, 42);
INSERT INTO `shopper_region` VALUES (569, '泊头市', 3, 42);
INSERT INTO `shopper_region` VALUES (570, '任丘市', 3, 42);
INSERT INTO `shopper_region` VALUES (571, '黄骅市', 3, 42);
INSERT INTO `shopper_region` VALUES (572, '河间市', 3, 42);
INSERT INTO `shopper_region` VALUES (573, '安次区', 3, 43);
INSERT INTO `shopper_region` VALUES (574, '广阳区', 3, 43);
INSERT INTO `shopper_region` VALUES (575, '固安县', 3, 43);
INSERT INTO `shopper_region` VALUES (576, '永清县', 3, 43);
INSERT INTO `shopper_region` VALUES (577, '香河县', 3, 43);
INSERT INTO `shopper_region` VALUES (578, '大城县', 3, 43);
INSERT INTO `shopper_region` VALUES (579, '文安县', 3, 43);
INSERT INTO `shopper_region` VALUES (580, '大厂回族自治县', 3, 43);
INSERT INTO `shopper_region` VALUES (581, '廊坊经济技术开发区', 3, 43);
INSERT INTO `shopper_region` VALUES (582, '霸州市', 3, 43);
INSERT INTO `shopper_region` VALUES (583, '三河市', 3, 43);
INSERT INTO `shopper_region` VALUES (584, '桃城区', 3, 44);
INSERT INTO `shopper_region` VALUES (585, '冀州区', 3, 44);
INSERT INTO `shopper_region` VALUES (586, '枣强县', 3, 44);
INSERT INTO `shopper_region` VALUES (587, '武邑县', 3, 44);
INSERT INTO `shopper_region` VALUES (588, '武强县', 3, 44);
INSERT INTO `shopper_region` VALUES (589, '饶阳县', 3, 44);
INSERT INTO `shopper_region` VALUES (590, '安平县', 3, 44);
INSERT INTO `shopper_region` VALUES (591, '故城县', 3, 44);
INSERT INTO `shopper_region` VALUES (592, '景县', 3, 44);
INSERT INTO `shopper_region` VALUES (593, '阜城县', 3, 44);
INSERT INTO `shopper_region` VALUES (594, '河北衡水高新技术产业开发区', 3, 44);
INSERT INTO `shopper_region` VALUES (595, '衡水滨湖新区', 3, 44);
INSERT INTO `shopper_region` VALUES (596, '深州市', 3, 44);
INSERT INTO `shopper_region` VALUES (597, '小店区', 3, 46);
INSERT INTO `shopper_region` VALUES (598, '迎泽区', 3, 46);
INSERT INTO `shopper_region` VALUES (599, '杏花岭区', 3, 46);
INSERT INTO `shopper_region` VALUES (600, '尖草坪区', 3, 46);
INSERT INTO `shopper_region` VALUES (601, '万柏林区', 3, 46);
INSERT INTO `shopper_region` VALUES (602, '晋源区', 3, 46);
INSERT INTO `shopper_region` VALUES (603, '清徐县', 3, 46);
INSERT INTO `shopper_region` VALUES (604, '阳曲县', 3, 46);
INSERT INTO `shopper_region` VALUES (605, '娄烦县', 3, 46);
INSERT INTO `shopper_region` VALUES (606, '山西转型综合改革示范区', 3, 46);
INSERT INTO `shopper_region` VALUES (607, '古交市', 3, 46);
INSERT INTO `shopper_region` VALUES (608, '新荣区', 3, 47);
INSERT INTO `shopper_region` VALUES (609, '平城区', 3, 47);
INSERT INTO `shopper_region` VALUES (610, '云冈区', 3, 47);
INSERT INTO `shopper_region` VALUES (611, '云州区', 3, 47);
INSERT INTO `shopper_region` VALUES (612, '阳高县', 3, 47);
INSERT INTO `shopper_region` VALUES (613, '天镇县', 3, 47);
INSERT INTO `shopper_region` VALUES (614, '广灵县', 3, 47);
INSERT INTO `shopper_region` VALUES (615, '灵丘县', 3, 47);
INSERT INTO `shopper_region` VALUES (616, '浑源县', 3, 47);
INSERT INTO `shopper_region` VALUES (617, '左云县', 3, 47);
INSERT INTO `shopper_region` VALUES (618, '山西大同经济开发区', 3, 47);
INSERT INTO `shopper_region` VALUES (619, '城区', 3, 48);
INSERT INTO `shopper_region` VALUES (620, '矿区', 3, 48);
INSERT INTO `shopper_region` VALUES (621, '郊区', 3, 48);
INSERT INTO `shopper_region` VALUES (622, '平定县', 3, 48);
INSERT INTO `shopper_region` VALUES (623, '盂县', 3, 48);
INSERT INTO `shopper_region` VALUES (624, '潞州区', 3, 49);
INSERT INTO `shopper_region` VALUES (625, '上党区', 3, 49);
INSERT INTO `shopper_region` VALUES (626, '屯留区', 3, 49);
INSERT INTO `shopper_region` VALUES (627, '潞城区', 3, 49);
INSERT INTO `shopper_region` VALUES (628, '襄垣县', 3, 49);
INSERT INTO `shopper_region` VALUES (629, '平顺县', 3, 49);
INSERT INTO `shopper_region` VALUES (630, '黎城县', 3, 49);
INSERT INTO `shopper_region` VALUES (631, '壶关县', 3, 49);
INSERT INTO `shopper_region` VALUES (632, '长子县', 3, 49);
INSERT INTO `shopper_region` VALUES (633, '武乡县', 3, 49);
INSERT INTO `shopper_region` VALUES (634, '沁县', 3, 49);
INSERT INTO `shopper_region` VALUES (635, '沁源县', 3, 49);
INSERT INTO `shopper_region` VALUES (636, '城区', 3, 50);
INSERT INTO `shopper_region` VALUES (637, '沁水县', 3, 50);
INSERT INTO `shopper_region` VALUES (638, '阳城县', 3, 50);
INSERT INTO `shopper_region` VALUES (639, '陵川县', 3, 50);
INSERT INTO `shopper_region` VALUES (640, '泽州县', 3, 50);
INSERT INTO `shopper_region` VALUES (641, '高平市', 3, 50);
INSERT INTO `shopper_region` VALUES (642, '朔城区', 3, 51);
INSERT INTO `shopper_region` VALUES (643, '平鲁区', 3, 51);
INSERT INTO `shopper_region` VALUES (644, '山阴县', 3, 51);
INSERT INTO `shopper_region` VALUES (645, '应县', 3, 51);
INSERT INTO `shopper_region` VALUES (646, '右玉县', 3, 51);
INSERT INTO `shopper_region` VALUES (647, '山西朔州经济开发区', 3, 51);
INSERT INTO `shopper_region` VALUES (648, '怀仁市', 3, 51);
INSERT INTO `shopper_region` VALUES (649, '榆次区', 3, 52);
INSERT INTO `shopper_region` VALUES (650, '太谷区', 3, 52);
INSERT INTO `shopper_region` VALUES (651, '榆社县', 3, 52);
INSERT INTO `shopper_region` VALUES (652, '左权县', 3, 52);
INSERT INTO `shopper_region` VALUES (653, '和顺县', 3, 52);
INSERT INTO `shopper_region` VALUES (654, '昔阳县', 3, 52);
INSERT INTO `shopper_region` VALUES (655, '寿阳县', 3, 52);
INSERT INTO `shopper_region` VALUES (656, '祁县', 3, 52);
INSERT INTO `shopper_region` VALUES (657, '平遥县', 3, 52);
INSERT INTO `shopper_region` VALUES (658, '灵石县', 3, 52);
INSERT INTO `shopper_region` VALUES (659, '介休市', 3, 52);
INSERT INTO `shopper_region` VALUES (660, '盐湖区', 3, 53);
INSERT INTO `shopper_region` VALUES (661, '临猗县', 3, 53);
INSERT INTO `shopper_region` VALUES (662, '万荣县', 3, 53);
INSERT INTO `shopper_region` VALUES (663, '闻喜县', 3, 53);
INSERT INTO `shopper_region` VALUES (664, '稷山县', 3, 53);
INSERT INTO `shopper_region` VALUES (665, '新绛县', 3, 53);
INSERT INTO `shopper_region` VALUES (666, '绛县', 3, 53);
INSERT INTO `shopper_region` VALUES (667, '垣曲县', 3, 53);
INSERT INTO `shopper_region` VALUES (668, '夏县', 3, 53);
INSERT INTO `shopper_region` VALUES (669, '平陆县', 3, 53);
INSERT INTO `shopper_region` VALUES (670, '芮城县', 3, 53);
INSERT INTO `shopper_region` VALUES (671, '永济市', 3, 53);
INSERT INTO `shopper_region` VALUES (672, '河津市', 3, 53);
INSERT INTO `shopper_region` VALUES (673, '忻府区', 3, 54);
INSERT INTO `shopper_region` VALUES (674, '定襄县', 3, 54);
INSERT INTO `shopper_region` VALUES (675, '五台县', 3, 54);
INSERT INTO `shopper_region` VALUES (676, '代县', 3, 54);
INSERT INTO `shopper_region` VALUES (677, '繁峙县', 3, 54);
INSERT INTO `shopper_region` VALUES (678, '宁武县', 3, 54);
INSERT INTO `shopper_region` VALUES (679, '静乐县', 3, 54);
INSERT INTO `shopper_region` VALUES (680, '神池县', 3, 54);
INSERT INTO `shopper_region` VALUES (681, '五寨县', 3, 54);
INSERT INTO `shopper_region` VALUES (682, '岢岚县', 3, 54);
INSERT INTO `shopper_region` VALUES (683, '河曲县', 3, 54);
INSERT INTO `shopper_region` VALUES (684, '保德县', 3, 54);
INSERT INTO `shopper_region` VALUES (685, '偏关县', 3, 54);
INSERT INTO `shopper_region` VALUES (686, '五台山风景名胜区', 3, 54);
INSERT INTO `shopper_region` VALUES (687, '原平市', 3, 54);
INSERT INTO `shopper_region` VALUES (688, '尧都区', 3, 55);
INSERT INTO `shopper_region` VALUES (689, '曲沃县', 3, 55);
INSERT INTO `shopper_region` VALUES (690, '翼城县', 3, 55);
INSERT INTO `shopper_region` VALUES (691, '襄汾县', 3, 55);
INSERT INTO `shopper_region` VALUES (692, '洪洞县', 3, 55);
INSERT INTO `shopper_region` VALUES (693, '古县', 3, 55);
INSERT INTO `shopper_region` VALUES (694, '安泽县', 3, 55);
INSERT INTO `shopper_region` VALUES (695, '浮山县', 3, 55);
INSERT INTO `shopper_region` VALUES (696, '吉县', 3, 55);
INSERT INTO `shopper_region` VALUES (697, '乡宁县', 3, 55);
INSERT INTO `shopper_region` VALUES (698, '大宁县', 3, 55);
INSERT INTO `shopper_region` VALUES (699, '隰县', 3, 55);
INSERT INTO `shopper_region` VALUES (700, '永和县', 3, 55);
INSERT INTO `shopper_region` VALUES (701, '蒲县', 3, 55);
INSERT INTO `shopper_region` VALUES (702, '汾西县', 3, 55);
INSERT INTO `shopper_region` VALUES (703, '侯马市', 3, 55);
INSERT INTO `shopper_region` VALUES (704, '霍州市', 3, 55);
INSERT INTO `shopper_region` VALUES (705, '离石区', 3, 56);
INSERT INTO `shopper_region` VALUES (706, '文水县', 3, 56);
INSERT INTO `shopper_region` VALUES (707, '交城县', 3, 56);
INSERT INTO `shopper_region` VALUES (708, '兴县', 3, 56);
INSERT INTO `shopper_region` VALUES (709, '临县', 3, 56);
INSERT INTO `shopper_region` VALUES (710, '柳林县', 3, 56);
INSERT INTO `shopper_region` VALUES (711, '石楼县', 3, 56);
INSERT INTO `shopper_region` VALUES (712, '岚县', 3, 56);
INSERT INTO `shopper_region` VALUES (713, '方山县', 3, 56);
INSERT INTO `shopper_region` VALUES (714, '中阳县', 3, 56);
INSERT INTO `shopper_region` VALUES (715, '交口县', 3, 56);
INSERT INTO `shopper_region` VALUES (716, '孝义市', 3, 56);
INSERT INTO `shopper_region` VALUES (717, '汾阳市', 3, 56);
INSERT INTO `shopper_region` VALUES (718, '新城区', 3, 57);
INSERT INTO `shopper_region` VALUES (719, '回民区', 3, 57);
INSERT INTO `shopper_region` VALUES (720, '玉泉区', 3, 57);
INSERT INTO `shopper_region` VALUES (721, '赛罕区', 3, 57);
INSERT INTO `shopper_region` VALUES (722, '土默特左旗', 3, 57);
INSERT INTO `shopper_region` VALUES (723, '托克托县', 3, 57);
INSERT INTO `shopper_region` VALUES (724, '和林格尔县', 3, 57);
INSERT INTO `shopper_region` VALUES (725, '清水河县', 3, 57);
INSERT INTO `shopper_region` VALUES (726, '武川县', 3, 57);
INSERT INTO `shopper_region` VALUES (727, '呼和浩特经济技术开发区', 3, 57);
INSERT INTO `shopper_region` VALUES (728, '东河区', 3, 58);
INSERT INTO `shopper_region` VALUES (729, '昆都仑区', 3, 58);
INSERT INTO `shopper_region` VALUES (730, '青山区', 3, 58);
INSERT INTO `shopper_region` VALUES (731, '石拐区', 3, 58);
INSERT INTO `shopper_region` VALUES (732, '白云鄂博矿区', 3, 58);
INSERT INTO `shopper_region` VALUES (733, '九原区', 3, 58);
INSERT INTO `shopper_region` VALUES (734, '土默特右旗', 3, 58);
INSERT INTO `shopper_region` VALUES (735, '固阳县', 3, 58);
INSERT INTO `shopper_region` VALUES (736, '达尔罕茂明安联合旗', 3, 58);
INSERT INTO `shopper_region` VALUES (737, '包头稀土高新技术产业开发区', 3, 58);
INSERT INTO `shopper_region` VALUES (738, '海勃湾区', 3, 59);
INSERT INTO `shopper_region` VALUES (739, '海南区', 3, 59);
INSERT INTO `shopper_region` VALUES (740, '乌达区', 3, 59);
INSERT INTO `shopper_region` VALUES (741, '红山区', 3, 60);
INSERT INTO `shopper_region` VALUES (742, '元宝山区', 3, 60);
INSERT INTO `shopper_region` VALUES (743, '松山区', 3, 60);
INSERT INTO `shopper_region` VALUES (744, '阿鲁科尔沁旗', 3, 60);
INSERT INTO `shopper_region` VALUES (745, '巴林左旗', 3, 60);
INSERT INTO `shopper_region` VALUES (746, '巴林右旗', 3, 60);
INSERT INTO `shopper_region` VALUES (747, '林西县', 3, 60);
INSERT INTO `shopper_region` VALUES (748, '克什克腾旗', 3, 60);
INSERT INTO `shopper_region` VALUES (749, '翁牛特旗', 3, 60);
INSERT INTO `shopper_region` VALUES (750, '喀喇沁旗', 3, 60);
INSERT INTO `shopper_region` VALUES (751, '宁城县', 3, 60);
INSERT INTO `shopper_region` VALUES (752, '敖汉旗', 3, 60);
INSERT INTO `shopper_region` VALUES (753, '科尔沁区', 3, 61);
INSERT INTO `shopper_region` VALUES (754, '科尔沁左翼中旗', 3, 61);
INSERT INTO `shopper_region` VALUES (755, '科尔沁左翼后旗', 3, 61);
INSERT INTO `shopper_region` VALUES (756, '开鲁县', 3, 61);
INSERT INTO `shopper_region` VALUES (757, '库伦旗', 3, 61);
INSERT INTO `shopper_region` VALUES (758, '奈曼旗', 3, 61);
INSERT INTO `shopper_region` VALUES (759, '扎鲁特旗', 3, 61);
INSERT INTO `shopper_region` VALUES (760, '通辽经济技术开发区', 3, 61);
INSERT INTO `shopper_region` VALUES (761, '霍林郭勒市', 3, 61);
INSERT INTO `shopper_region` VALUES (762, '东胜区', 3, 62);
INSERT INTO `shopper_region` VALUES (763, '康巴什区', 3, 62);
INSERT INTO `shopper_region` VALUES (764, '达拉特旗', 3, 62);
INSERT INTO `shopper_region` VALUES (765, '准格尔旗', 3, 62);
INSERT INTO `shopper_region` VALUES (766, '鄂托克前旗', 3, 62);
INSERT INTO `shopper_region` VALUES (767, '鄂托克旗', 3, 62);
INSERT INTO `shopper_region` VALUES (768, '杭锦旗', 3, 62);
INSERT INTO `shopper_region` VALUES (769, '乌审旗', 3, 62);
INSERT INTO `shopper_region` VALUES (770, '伊金霍洛旗', 3, 62);
INSERT INTO `shopper_region` VALUES (771, '海拉尔区', 3, 63);
INSERT INTO `shopper_region` VALUES (772, '扎赉诺尔区', 3, 63);
INSERT INTO `shopper_region` VALUES (773, '阿荣旗', 3, 63);
INSERT INTO `shopper_region` VALUES (774, '莫力达瓦达斡尔族自治旗', 3, 63);
INSERT INTO `shopper_region` VALUES (775, '鄂伦春自治旗', 3, 63);
INSERT INTO `shopper_region` VALUES (776, '鄂温克族自治旗', 3, 63);
INSERT INTO `shopper_region` VALUES (777, '陈巴尔虎旗', 3, 63);
INSERT INTO `shopper_region` VALUES (778, '新巴尔虎左旗', 3, 63);
INSERT INTO `shopper_region` VALUES (779, '新巴尔虎右旗', 3, 63);
INSERT INTO `shopper_region` VALUES (780, '满洲里市', 3, 63);
INSERT INTO `shopper_region` VALUES (781, '牙克石市', 3, 63);
INSERT INTO `shopper_region` VALUES (782, '扎兰屯市', 3, 63);
INSERT INTO `shopper_region` VALUES (783, '额尔古纳市', 3, 63);
INSERT INTO `shopper_region` VALUES (784, '根河市', 3, 63);
INSERT INTO `shopper_region` VALUES (785, '临河区', 3, 64);
INSERT INTO `shopper_region` VALUES (786, '五原县', 3, 64);
INSERT INTO `shopper_region` VALUES (787, '磴口县', 3, 64);
INSERT INTO `shopper_region` VALUES (788, '乌拉特前旗', 3, 64);
INSERT INTO `shopper_region` VALUES (789, '乌拉特中旗', 3, 64);
INSERT INTO `shopper_region` VALUES (790, '乌拉特后旗', 3, 64);
INSERT INTO `shopper_region` VALUES (791, '杭锦后旗', 3, 64);
INSERT INTO `shopper_region` VALUES (792, '集宁区', 3, 65);
INSERT INTO `shopper_region` VALUES (793, '卓资县', 3, 65);
INSERT INTO `shopper_region` VALUES (794, '化德县', 3, 65);
INSERT INTO `shopper_region` VALUES (795, '商都县', 3, 65);
INSERT INTO `shopper_region` VALUES (796, '兴和县', 3, 65);
INSERT INTO `shopper_region` VALUES (797, '凉城县', 3, 65);
INSERT INTO `shopper_region` VALUES (798, '察哈尔右翼前旗', 3, 65);
INSERT INTO `shopper_region` VALUES (799, '察哈尔右翼中旗', 3, 65);
INSERT INTO `shopper_region` VALUES (800, '察哈尔右翼后旗', 3, 65);
INSERT INTO `shopper_region` VALUES (801, '四子王旗', 3, 65);
INSERT INTO `shopper_region` VALUES (802, '丰镇市', 3, 65);
INSERT INTO `shopper_region` VALUES (803, '乌兰浩特市', 3, 66);
INSERT INTO `shopper_region` VALUES (804, '阿尔山市', 3, 66);
INSERT INTO `shopper_region` VALUES (805, '科尔沁右翼前旗', 3, 66);
INSERT INTO `shopper_region` VALUES (806, '科尔沁右翼中旗', 3, 66);
INSERT INTO `shopper_region` VALUES (807, '扎赉特旗', 3, 66);
INSERT INTO `shopper_region` VALUES (808, '突泉县', 3, 66);
INSERT INTO `shopper_region` VALUES (809, '二连浩特市', 3, 67);
INSERT INTO `shopper_region` VALUES (810, '锡林浩特市', 3, 67);
INSERT INTO `shopper_region` VALUES (811, '阿巴嘎旗', 3, 67);
INSERT INTO `shopper_region` VALUES (812, '苏尼特左旗', 3, 67);
INSERT INTO `shopper_region` VALUES (813, '苏尼特右旗', 3, 67);
INSERT INTO `shopper_region` VALUES (814, '东乌珠穆沁旗', 3, 67);
INSERT INTO `shopper_region` VALUES (815, '西乌珠穆沁旗', 3, 67);
INSERT INTO `shopper_region` VALUES (816, '太仆寺旗', 3, 67);
INSERT INTO `shopper_region` VALUES (817, '镶黄旗', 3, 67);
INSERT INTO `shopper_region` VALUES (818, '正镶白旗', 3, 67);
INSERT INTO `shopper_region` VALUES (819, '正蓝旗', 3, 67);
INSERT INTO `shopper_region` VALUES (820, '多伦县', 3, 67);
INSERT INTO `shopper_region` VALUES (821, '乌拉盖管理区管委会', 3, 67);
INSERT INTO `shopper_region` VALUES (822, '阿拉善左旗', 3, 68);
INSERT INTO `shopper_region` VALUES (823, '阿拉善右旗', 3, 68);
INSERT INTO `shopper_region` VALUES (824, '额济纳旗', 3, 68);
INSERT INTO `shopper_region` VALUES (825, '内蒙古阿拉善高新技术产业开发区', 3, 68);
INSERT INTO `shopper_region` VALUES (826, '和平区', 3, 69);
INSERT INTO `shopper_region` VALUES (827, '沈河区', 3, 69);
INSERT INTO `shopper_region` VALUES (828, '大东区', 3, 69);
INSERT INTO `shopper_region` VALUES (829, '皇姑区', 3, 69);
INSERT INTO `shopper_region` VALUES (830, '铁西区', 3, 69);
INSERT INTO `shopper_region` VALUES (831, '苏家屯区', 3, 69);
INSERT INTO `shopper_region` VALUES (832, '浑南区', 3, 69);
INSERT INTO `shopper_region` VALUES (833, '沈北新区', 3, 69);
INSERT INTO `shopper_region` VALUES (834, '于洪区', 3, 69);
INSERT INTO `shopper_region` VALUES (835, '辽中区', 3, 69);
INSERT INTO `shopper_region` VALUES (836, '康平县', 3, 69);
INSERT INTO `shopper_region` VALUES (837, '法库县', 3, 69);
INSERT INTO `shopper_region` VALUES (838, '新民市', 3, 69);
INSERT INTO `shopper_region` VALUES (839, '中山区', 3, 70);
INSERT INTO `shopper_region` VALUES (840, '西岗区', 3, 70);
INSERT INTO `shopper_region` VALUES (841, '沙河口区', 3, 70);
INSERT INTO `shopper_region` VALUES (842, '甘井子区', 3, 70);
INSERT INTO `shopper_region` VALUES (843, '旅顺口区', 3, 70);
INSERT INTO `shopper_region` VALUES (844, '金州区', 3, 70);
INSERT INTO `shopper_region` VALUES (845, '普兰店区', 3, 70);
INSERT INTO `shopper_region` VALUES (846, '长海县', 3, 70);
INSERT INTO `shopper_region` VALUES (847, '瓦房店市', 3, 70);
INSERT INTO `shopper_region` VALUES (848, '庄河市', 3, 70);
INSERT INTO `shopper_region` VALUES (849, '铁东区', 3, 71);
INSERT INTO `shopper_region` VALUES (850, '铁西区', 3, 71);
INSERT INTO `shopper_region` VALUES (851, '立山区', 3, 71);
INSERT INTO `shopper_region` VALUES (852, '千山区', 3, 71);
INSERT INTO `shopper_region` VALUES (853, '台安县', 3, 71);
INSERT INTO `shopper_region` VALUES (854, '岫岩满族自治县', 3, 71);
INSERT INTO `shopper_region` VALUES (855, '海城市', 3, 71);
INSERT INTO `shopper_region` VALUES (856, '新抚区', 3, 72);
INSERT INTO `shopper_region` VALUES (857, '东洲区', 3, 72);
INSERT INTO `shopper_region` VALUES (858, '望花区', 3, 72);
INSERT INTO `shopper_region` VALUES (859, '顺城区', 3, 72);
INSERT INTO `shopper_region` VALUES (860, '抚顺县', 3, 72);
INSERT INTO `shopper_region` VALUES (861, '新宾满族自治县', 3, 72);
INSERT INTO `shopper_region` VALUES (862, '清原满族自治县', 3, 72);
INSERT INTO `shopper_region` VALUES (863, '平山区', 3, 73);
INSERT INTO `shopper_region` VALUES (864, '溪湖区', 3, 73);
INSERT INTO `shopper_region` VALUES (865, '明山区', 3, 73);
INSERT INTO `shopper_region` VALUES (866, '南芬区', 3, 73);
INSERT INTO `shopper_region` VALUES (867, '本溪满族自治县', 3, 73);
INSERT INTO `shopper_region` VALUES (868, '桓仁满族自治县', 3, 73);
INSERT INTO `shopper_region` VALUES (869, '元宝区', 3, 74);
INSERT INTO `shopper_region` VALUES (870, '振兴区', 3, 74);
INSERT INTO `shopper_region` VALUES (871, '振安区', 3, 74);
INSERT INTO `shopper_region` VALUES (872, '宽甸满族自治县', 3, 74);
INSERT INTO `shopper_region` VALUES (873, '东港市', 3, 74);
INSERT INTO `shopper_region` VALUES (874, '凤城市', 3, 74);
INSERT INTO `shopper_region` VALUES (875, '古塔区', 3, 75);
INSERT INTO `shopper_region` VALUES (876, '凌河区', 3, 75);
INSERT INTO `shopper_region` VALUES (877, '太和区', 3, 75);
INSERT INTO `shopper_region` VALUES (878, '黑山县', 3, 75);
INSERT INTO `shopper_region` VALUES (879, '义县', 3, 75);
INSERT INTO `shopper_region` VALUES (880, '凌海市', 3, 75);
INSERT INTO `shopper_region` VALUES (881, '北镇市', 3, 75);
INSERT INTO `shopper_region` VALUES (882, '站前区', 3, 76);
INSERT INTO `shopper_region` VALUES (883, '西市区', 3, 76);
INSERT INTO `shopper_region` VALUES (884, '鲅鱼圈区', 3, 76);
INSERT INTO `shopper_region` VALUES (885, '老边区', 3, 76);
INSERT INTO `shopper_region` VALUES (886, '盖州市', 3, 76);
INSERT INTO `shopper_region` VALUES (887, '大石桥市', 3, 76);
INSERT INTO `shopper_region` VALUES (888, '海州区', 3, 77);
INSERT INTO `shopper_region` VALUES (889, '新邱区', 3, 77);
INSERT INTO `shopper_region` VALUES (890, '太平区', 3, 77);
INSERT INTO `shopper_region` VALUES (891, '清河门区', 3, 77);
INSERT INTO `shopper_region` VALUES (892, '细河区', 3, 77);
INSERT INTO `shopper_region` VALUES (893, '阜新蒙古族自治县', 3, 77);
INSERT INTO `shopper_region` VALUES (894, '彰武县', 3, 77);
INSERT INTO `shopper_region` VALUES (895, '白塔区', 3, 78);
INSERT INTO `shopper_region` VALUES (896, '文圣区', 3, 78);
INSERT INTO `shopper_region` VALUES (897, '宏伟区', 3, 78);
INSERT INTO `shopper_region` VALUES (898, '弓长岭区', 3, 78);
INSERT INTO `shopper_region` VALUES (899, '太子河区', 3, 78);
INSERT INTO `shopper_region` VALUES (900, '辽阳县', 3, 78);
INSERT INTO `shopper_region` VALUES (901, '灯塔市', 3, 78);
INSERT INTO `shopper_region` VALUES (902, '双台子区', 3, 79);
INSERT INTO `shopper_region` VALUES (903, '兴隆台区', 3, 79);
INSERT INTO `shopper_region` VALUES (904, '大洼区', 3, 79);
INSERT INTO `shopper_region` VALUES (905, '盘山县', 3, 79);
INSERT INTO `shopper_region` VALUES (906, '银州区', 3, 80);
INSERT INTO `shopper_region` VALUES (907, '清河区', 3, 80);
INSERT INTO `shopper_region` VALUES (908, '铁岭县', 3, 80);
INSERT INTO `shopper_region` VALUES (909, '西丰县', 3, 80);
INSERT INTO `shopper_region` VALUES (910, '昌图县', 3, 80);
INSERT INTO `shopper_region` VALUES (911, '调兵山市', 3, 80);
INSERT INTO `shopper_region` VALUES (912, '开原市', 3, 80);
INSERT INTO `shopper_region` VALUES (913, '双塔区', 3, 81);
INSERT INTO `shopper_region` VALUES (914, '龙城区', 3, 81);
INSERT INTO `shopper_region` VALUES (915, '朝阳县', 3, 81);
INSERT INTO `shopper_region` VALUES (916, '建平县', 3, 81);
INSERT INTO `shopper_region` VALUES (917, '喀喇沁左翼蒙古族自治县', 3, 81);
INSERT INTO `shopper_region` VALUES (918, '北票市', 3, 81);
INSERT INTO `shopper_region` VALUES (919, '凌源市', 3, 81);
INSERT INTO `shopper_region` VALUES (920, '连山区', 3, 82);
INSERT INTO `shopper_region` VALUES (921, '龙港区', 3, 82);
INSERT INTO `shopper_region` VALUES (922, '南票区', 3, 82);
INSERT INTO `shopper_region` VALUES (923, '绥中县', 3, 82);
INSERT INTO `shopper_region` VALUES (924, '建昌县', 3, 82);
INSERT INTO `shopper_region` VALUES (925, '兴城市', 3, 82);
INSERT INTO `shopper_region` VALUES (926, '南关区', 3, 83);
INSERT INTO `shopper_region` VALUES (927, '宽城区', 3, 83);
INSERT INTO `shopper_region` VALUES (928, '朝阳区', 3, 83);
INSERT INTO `shopper_region` VALUES (929, '二道区', 3, 83);
INSERT INTO `shopper_region` VALUES (930, '绿园区', 3, 83);
INSERT INTO `shopper_region` VALUES (931, '双阳区', 3, 83);
INSERT INTO `shopper_region` VALUES (932, '九台区', 3, 83);
INSERT INTO `shopper_region` VALUES (933, '农安县', 3, 83);
INSERT INTO `shopper_region` VALUES (934, '长春经济技术开发区', 3, 83);
INSERT INTO `shopper_region` VALUES (935, '长春净月高新技术产业开发区', 3, 83);
INSERT INTO `shopper_region` VALUES (936, '长春高新技术产业开发区', 3, 83);
INSERT INTO `shopper_region` VALUES (937, '长春汽车经济技术开发区', 3, 83);
INSERT INTO `shopper_region` VALUES (938, '榆树市', 3, 83);
INSERT INTO `shopper_region` VALUES (939, '德惠市', 3, 83);
INSERT INTO `shopper_region` VALUES (940, '公主岭市', 3, 83);
INSERT INTO `shopper_region` VALUES (941, '昌邑区', 3, 84);
INSERT INTO `shopper_region` VALUES (942, '龙潭区', 3, 84);
INSERT INTO `shopper_region` VALUES (943, '船营区', 3, 84);
INSERT INTO `shopper_region` VALUES (944, '丰满区', 3, 84);
INSERT INTO `shopper_region` VALUES (945, '永吉县', 3, 84);
INSERT INTO `shopper_region` VALUES (946, '吉林经济开发区', 3, 84);
INSERT INTO `shopper_region` VALUES (947, '吉林高新技术产业开发区', 3, 84);
INSERT INTO `shopper_region` VALUES (948, '吉林中国新加坡食品区', 3, 84);
INSERT INTO `shopper_region` VALUES (949, '蛟河市', 3, 84);
INSERT INTO `shopper_region` VALUES (950, '桦甸市', 3, 84);
INSERT INTO `shopper_region` VALUES (951, '舒兰市', 3, 84);
INSERT INTO `shopper_region` VALUES (952, '磐石市', 3, 84);
INSERT INTO `shopper_region` VALUES (953, '铁西区', 3, 85);
INSERT INTO `shopper_region` VALUES (954, '铁东区', 3, 85);
INSERT INTO `shopper_region` VALUES (955, '梨树县', 3, 85);
INSERT INTO `shopper_region` VALUES (956, '伊通满族自治县', 3, 85);
INSERT INTO `shopper_region` VALUES (957, '双辽市', 3, 85);
INSERT INTO `shopper_region` VALUES (958, '龙山区', 3, 86);
INSERT INTO `shopper_region` VALUES (959, '西安区', 3, 86);
INSERT INTO `shopper_region` VALUES (960, '东丰县', 3, 86);
INSERT INTO `shopper_region` VALUES (961, '东辽县', 3, 86);
INSERT INTO `shopper_region` VALUES (962, '东昌区', 3, 87);
INSERT INTO `shopper_region` VALUES (963, '二道江区', 3, 87);
INSERT INTO `shopper_region` VALUES (964, '通化县', 3, 87);
INSERT INTO `shopper_region` VALUES (965, '辉南县', 3, 87);
INSERT INTO `shopper_region` VALUES (966, '柳河县', 3, 87);
INSERT INTO `shopper_region` VALUES (967, '梅河口市', 3, 87);
INSERT INTO `shopper_region` VALUES (968, '集安市', 3, 87);
INSERT INTO `shopper_region` VALUES (969, '浑江区', 3, 88);
INSERT INTO `shopper_region` VALUES (970, '江源区', 3, 88);
INSERT INTO `shopper_region` VALUES (971, '抚松县', 3, 88);
INSERT INTO `shopper_region` VALUES (972, '靖宇县', 3, 88);
INSERT INTO `shopper_region` VALUES (973, '长白朝鲜族自治县', 3, 88);
INSERT INTO `shopper_region` VALUES (974, '临江市', 3, 88);
INSERT INTO `shopper_region` VALUES (975, '宁江区', 3, 89);
INSERT INTO `shopper_region` VALUES (976, '前郭尔罗斯蒙古族自治县', 3, 89);
INSERT INTO `shopper_region` VALUES (977, '长岭县', 3, 89);
INSERT INTO `shopper_region` VALUES (978, '乾安县', 3, 89);
INSERT INTO `shopper_region` VALUES (979, '吉林松原经济开发区', 3, 89);
INSERT INTO `shopper_region` VALUES (980, '扶余市', 3, 89);
INSERT INTO `shopper_region` VALUES (981, '洮北区', 3, 90);
INSERT INTO `shopper_region` VALUES (982, '镇赉县', 3, 90);
INSERT INTO `shopper_region` VALUES (983, '通榆县', 3, 90);
INSERT INTO `shopper_region` VALUES (984, '吉林白城经济开发区', 3, 90);
INSERT INTO `shopper_region` VALUES (985, '洮南市', 3, 90);
INSERT INTO `shopper_region` VALUES (986, '大安市', 3, 90);
INSERT INTO `shopper_region` VALUES (987, '延吉市', 3, 91);
INSERT INTO `shopper_region` VALUES (988, '图们市', 3, 91);
INSERT INTO `shopper_region` VALUES (989, '敦化市', 3, 91);
INSERT INTO `shopper_region` VALUES (990, '珲春市', 3, 91);
INSERT INTO `shopper_region` VALUES (991, '龙井市', 3, 91);
INSERT INTO `shopper_region` VALUES (992, '和龙市', 3, 91);
INSERT INTO `shopper_region` VALUES (993, '汪清县', 3, 91);
INSERT INTO `shopper_region` VALUES (994, '安图县', 3, 91);
INSERT INTO `shopper_region` VALUES (995, '道里区', 3, 92);
INSERT INTO `shopper_region` VALUES (996, '南岗区', 3, 92);
INSERT INTO `shopper_region` VALUES (997, '道外区', 3, 92);
INSERT INTO `shopper_region` VALUES (998, '平房区', 3, 92);
INSERT INTO `shopper_region` VALUES (999, '松北区', 3, 92);
INSERT INTO `shopper_region` VALUES (1000, '香坊区', 3, 92);
INSERT INTO `shopper_region` VALUES (1001, '呼兰区', 3, 92);
INSERT INTO `shopper_region` VALUES (1002, '阿城区', 3, 92);
INSERT INTO `shopper_region` VALUES (1003, '双城区', 3, 92);
INSERT INTO `shopper_region` VALUES (1004, '依兰县', 3, 92);
INSERT INTO `shopper_region` VALUES (1005, '方正县', 3, 92);
INSERT INTO `shopper_region` VALUES (1006, '宾县', 3, 92);
INSERT INTO `shopper_region` VALUES (1007, '巴彦县', 3, 92);
INSERT INTO `shopper_region` VALUES (1008, '木兰县', 3, 92);
INSERT INTO `shopper_region` VALUES (1009, '通河县', 3, 92);
INSERT INTO `shopper_region` VALUES (1010, '延寿县', 3, 92);
INSERT INTO `shopper_region` VALUES (1011, '尚志市', 3, 92);
INSERT INTO `shopper_region` VALUES (1012, '五常市', 3, 92);
INSERT INTO `shopper_region` VALUES (1013, '龙沙区', 3, 93);
INSERT INTO `shopper_region` VALUES (1014, '建华区', 3, 93);
INSERT INTO `shopper_region` VALUES (1015, '铁锋区', 3, 93);
INSERT INTO `shopper_region` VALUES (1016, '昂昂溪区', 3, 93);
INSERT INTO `shopper_region` VALUES (1017, '富拉尔基区', 3, 93);
INSERT INTO `shopper_region` VALUES (1018, '碾子山区', 3, 93);
INSERT INTO `shopper_region` VALUES (1019, '梅里斯达斡尔族区', 3, 93);
INSERT INTO `shopper_region` VALUES (1020, '龙江县', 3, 93);
INSERT INTO `shopper_region` VALUES (1021, '依安县', 3, 93);
INSERT INTO `shopper_region` VALUES (1022, '泰来县', 3, 93);
INSERT INTO `shopper_region` VALUES (1023, '甘南县', 3, 93);
INSERT INTO `shopper_region` VALUES (1024, '富裕县', 3, 93);
INSERT INTO `shopper_region` VALUES (1025, '克山县', 3, 93);
INSERT INTO `shopper_region` VALUES (1026, '克东县', 3, 93);
INSERT INTO `shopper_region` VALUES (1027, '拜泉县', 3, 93);
INSERT INTO `shopper_region` VALUES (1028, '讷河市', 3, 93);
INSERT INTO `shopper_region` VALUES (1029, '鸡冠区', 3, 94);
INSERT INTO `shopper_region` VALUES (1030, '恒山区', 3, 94);
INSERT INTO `shopper_region` VALUES (1031, '滴道区', 3, 94);
INSERT INTO `shopper_region` VALUES (1032, '梨树区', 3, 94);
INSERT INTO `shopper_region` VALUES (1033, '城子河区', 3, 94);
INSERT INTO `shopper_region` VALUES (1034, '麻山区', 3, 94);
INSERT INTO `shopper_region` VALUES (1035, '鸡东县', 3, 94);
INSERT INTO `shopper_region` VALUES (1036, '虎林市', 3, 94);
INSERT INTO `shopper_region` VALUES (1037, '密山市', 3, 94);
INSERT INTO `shopper_region` VALUES (1038, '向阳区', 3, 95);
INSERT INTO `shopper_region` VALUES (1039, '工农区', 3, 95);
INSERT INTO `shopper_region` VALUES (1040, '南山区', 3, 95);
INSERT INTO `shopper_region` VALUES (1041, '兴安区', 3, 95);
INSERT INTO `shopper_region` VALUES (1042, '东山区', 3, 95);
INSERT INTO `shopper_region` VALUES (1043, '兴山区', 3, 95);
INSERT INTO `shopper_region` VALUES (1044, '萝北县', 3, 95);
INSERT INTO `shopper_region` VALUES (1045, '绥滨县', 3, 95);
INSERT INTO `shopper_region` VALUES (1046, '尖山区', 3, 96);
INSERT INTO `shopper_region` VALUES (1047, '岭东区', 3, 96);
INSERT INTO `shopper_region` VALUES (1048, '四方台区', 3, 96);
INSERT INTO `shopper_region` VALUES (1049, '宝山区', 3, 96);
INSERT INTO `shopper_region` VALUES (1050, '集贤县', 3, 96);
INSERT INTO `shopper_region` VALUES (1051, '友谊县', 3, 96);
INSERT INTO `shopper_region` VALUES (1052, '宝清县', 3, 96);
INSERT INTO `shopper_region` VALUES (1053, '饶河县', 3, 96);
INSERT INTO `shopper_region` VALUES (1054, '萨尔图区', 3, 97);
INSERT INTO `shopper_region` VALUES (1055, '龙凤区', 3, 97);
INSERT INTO `shopper_region` VALUES (1056, '让胡路区', 3, 97);
INSERT INTO `shopper_region` VALUES (1057, '红岗区', 3, 97);
INSERT INTO `shopper_region` VALUES (1058, '大同区', 3, 97);
INSERT INTO `shopper_region` VALUES (1059, '肇州县', 3, 97);
INSERT INTO `shopper_region` VALUES (1060, '肇源县', 3, 97);
INSERT INTO `shopper_region` VALUES (1061, '林甸县', 3, 97);
INSERT INTO `shopper_region` VALUES (1062, '杜尔伯特蒙古族自治县', 3, 97);
INSERT INTO `shopper_region` VALUES (1063, '大庆高新技术产业开发区', 3, 97);
INSERT INTO `shopper_region` VALUES (1064, '伊美区', 3, 98);
INSERT INTO `shopper_region` VALUES (1065, '乌翠区', 3, 98);
INSERT INTO `shopper_region` VALUES (1066, '友好区', 3, 98);
INSERT INTO `shopper_region` VALUES (1067, '嘉荫县', 3, 98);
INSERT INTO `shopper_region` VALUES (1068, '汤旺县', 3, 98);
INSERT INTO `shopper_region` VALUES (1069, '丰林县', 3, 98);
INSERT INTO `shopper_region` VALUES (1070, '大箐山县', 3, 98);
INSERT INTO `shopper_region` VALUES (1071, '南岔县', 3, 98);
INSERT INTO `shopper_region` VALUES (1072, '金林区', 3, 98);
INSERT INTO `shopper_region` VALUES (1073, '铁力市', 3, 98);
INSERT INTO `shopper_region` VALUES (1074, '向阳区', 3, 99);
INSERT INTO `shopper_region` VALUES (1075, '前进区', 3, 99);
INSERT INTO `shopper_region` VALUES (1076, '东风区', 3, 99);
INSERT INTO `shopper_region` VALUES (1077, '郊区', 3, 99);
INSERT INTO `shopper_region` VALUES (1078, '桦南县', 3, 99);
INSERT INTO `shopper_region` VALUES (1079, '桦川县', 3, 99);
INSERT INTO `shopper_region` VALUES (1080, '汤原县', 3, 99);
INSERT INTO `shopper_region` VALUES (1081, '同江市', 3, 99);
INSERT INTO `shopper_region` VALUES (1082, '富锦市', 3, 99);
INSERT INTO `shopper_region` VALUES (1083, '抚远市', 3, 99);
INSERT INTO `shopper_region` VALUES (1084, '新兴区', 3, 100);
INSERT INTO `shopper_region` VALUES (1085, '桃山区', 3, 100);
INSERT INTO `shopper_region` VALUES (1086, '茄子河区', 3, 100);
INSERT INTO `shopper_region` VALUES (1087, '勃利县', 3, 100);
INSERT INTO `shopper_region` VALUES (1088, '东安区', 3, 101);
INSERT INTO `shopper_region` VALUES (1089, '阳明区', 3, 101);
INSERT INTO `shopper_region` VALUES (1090, '爱民区', 3, 101);
INSERT INTO `shopper_region` VALUES (1091, '西安区', 3, 101);
INSERT INTO `shopper_region` VALUES (1092, '林口县', 3, 101);
INSERT INTO `shopper_region` VALUES (1093, '绥芬河市', 3, 101);
INSERT INTO `shopper_region` VALUES (1094, '海林市', 3, 101);
INSERT INTO `shopper_region` VALUES (1095, '宁安市', 3, 101);
INSERT INTO `shopper_region` VALUES (1096, '穆棱市', 3, 101);
INSERT INTO `shopper_region` VALUES (1097, '东宁市', 3, 101);
INSERT INTO `shopper_region` VALUES (1098, '爱辉区', 3, 102);
INSERT INTO `shopper_region` VALUES (1099, '逊克县', 3, 102);
INSERT INTO `shopper_region` VALUES (1100, '孙吴县', 3, 102);
INSERT INTO `shopper_region` VALUES (1101, '北安市', 3, 102);
INSERT INTO `shopper_region` VALUES (1102, '五大连池市', 3, 102);
INSERT INTO `shopper_region` VALUES (1103, '嫩江市', 3, 102);
INSERT INTO `shopper_region` VALUES (1104, '北林区', 3, 103);
INSERT INTO `shopper_region` VALUES (1105, '望奎县', 3, 103);
INSERT INTO `shopper_region` VALUES (1106, '兰西县', 3, 103);
INSERT INTO `shopper_region` VALUES (1107, '青冈县', 3, 103);
INSERT INTO `shopper_region` VALUES (1108, '庆安县', 3, 103);
INSERT INTO `shopper_region` VALUES (1109, '明水县', 3, 103);
INSERT INTO `shopper_region` VALUES (1110, '绥棱县', 3, 103);
INSERT INTO `shopper_region` VALUES (1111, '安达市', 3, 103);
INSERT INTO `shopper_region` VALUES (1112, '肇东市', 3, 103);
INSERT INTO `shopper_region` VALUES (1113, '海伦市', 3, 103);
INSERT INTO `shopper_region` VALUES (1114, '漠河市', 3, 104);
INSERT INTO `shopper_region` VALUES (1115, '呼玛县', 3, 104);
INSERT INTO `shopper_region` VALUES (1116, '塔河县', 3, 104);
INSERT INTO `shopper_region` VALUES (1117, '加格达奇区', 3, 104);
INSERT INTO `shopper_region` VALUES (1118, '松岭区', 3, 104);
INSERT INTO `shopper_region` VALUES (1119, '新林区', 3, 104);
INSERT INTO `shopper_region` VALUES (1120, '呼中区', 3, 104);
INSERT INTO `shopper_region` VALUES (1121, '黄浦区', 3, 105);
INSERT INTO `shopper_region` VALUES (1122, '徐汇区', 3, 105);
INSERT INTO `shopper_region` VALUES (1123, '长宁区', 3, 105);
INSERT INTO `shopper_region` VALUES (1124, '静安区', 3, 105);
INSERT INTO `shopper_region` VALUES (1125, '普陀区', 3, 105);
INSERT INTO `shopper_region` VALUES (1126, '虹口区', 3, 105);
INSERT INTO `shopper_region` VALUES (1127, '杨浦区', 3, 105);
INSERT INTO `shopper_region` VALUES (1128, '闵行区', 3, 105);
INSERT INTO `shopper_region` VALUES (1129, '宝山区', 3, 105);
INSERT INTO `shopper_region` VALUES (1130, '嘉定区', 3, 105);
INSERT INTO `shopper_region` VALUES (1131, '浦东新区', 3, 105);
INSERT INTO `shopper_region` VALUES (1132, '金山区', 3, 105);
INSERT INTO `shopper_region` VALUES (1133, '松江区', 3, 105);
INSERT INTO `shopper_region` VALUES (1134, '青浦区', 3, 105);
INSERT INTO `shopper_region` VALUES (1135, '奉贤区', 3, 105);
INSERT INTO `shopper_region` VALUES (1136, '崇明区', 3, 105);
INSERT INTO `shopper_region` VALUES (1137, '玄武区', 3, 106);
INSERT INTO `shopper_region` VALUES (1138, '秦淮区', 3, 106);
INSERT INTO `shopper_region` VALUES (1139, '建邺区', 3, 106);
INSERT INTO `shopper_region` VALUES (1140, '鼓楼区', 3, 106);
INSERT INTO `shopper_region` VALUES (1141, '浦口区', 3, 106);
INSERT INTO `shopper_region` VALUES (1142, '栖霞区', 3, 106);
INSERT INTO `shopper_region` VALUES (1143, '雨花台区', 3, 106);
INSERT INTO `shopper_region` VALUES (1144, '江宁区', 3, 106);
INSERT INTO `shopper_region` VALUES (1145, '六合区', 3, 106);
INSERT INTO `shopper_region` VALUES (1146, '溧水区', 3, 106);
INSERT INTO `shopper_region` VALUES (1147, '高淳区', 3, 106);
INSERT INTO `shopper_region` VALUES (1148, '锡山区', 3, 107);
INSERT INTO `shopper_region` VALUES (1149, '惠山区', 3, 107);
INSERT INTO `shopper_region` VALUES (1150, '滨湖区', 3, 107);
INSERT INTO `shopper_region` VALUES (1151, '梁溪区', 3, 107);
INSERT INTO `shopper_region` VALUES (1152, '新吴区', 3, 107);
INSERT INTO `shopper_region` VALUES (1153, '江阴市', 3, 107);
INSERT INTO `shopper_region` VALUES (1154, '宜兴市', 3, 107);
INSERT INTO `shopper_region` VALUES (1155, '鼓楼区', 3, 108);
INSERT INTO `shopper_region` VALUES (1156, '云龙区', 3, 108);
INSERT INTO `shopper_region` VALUES (1157, '贾汪区', 3, 108);
INSERT INTO `shopper_region` VALUES (1158, '泉山区', 3, 108);
INSERT INTO `shopper_region` VALUES (1159, '铜山区', 3, 108);
INSERT INTO `shopper_region` VALUES (1160, '丰县', 3, 108);
INSERT INTO `shopper_region` VALUES (1161, '沛县', 3, 108);
INSERT INTO `shopper_region` VALUES (1162, '睢宁县', 3, 108);
INSERT INTO `shopper_region` VALUES (1163, '徐州经济技术开发区', 3, 108);
INSERT INTO `shopper_region` VALUES (1164, '新沂市', 3, 108);
INSERT INTO `shopper_region` VALUES (1165, '邳州市', 3, 108);
INSERT INTO `shopper_region` VALUES (1166, '天宁区', 3, 109);
INSERT INTO `shopper_region` VALUES (1167, '钟楼区', 3, 109);
INSERT INTO `shopper_region` VALUES (1168, '新北区', 3, 109);
INSERT INTO `shopper_region` VALUES (1169, '武进区', 3, 109);
INSERT INTO `shopper_region` VALUES (1170, '金坛区', 3, 109);
INSERT INTO `shopper_region` VALUES (1171, '溧阳市', 3, 109);
INSERT INTO `shopper_region` VALUES (1172, '虎丘区', 3, 110);
INSERT INTO `shopper_region` VALUES (1173, '吴中区', 3, 110);
INSERT INTO `shopper_region` VALUES (1174, '相城区', 3, 110);
INSERT INTO `shopper_region` VALUES (1175, '姑苏区', 3, 110);
INSERT INTO `shopper_region` VALUES (1176, '吴江区', 3, 110);
INSERT INTO `shopper_region` VALUES (1177, '苏州工业园区', 3, 110);
INSERT INTO `shopper_region` VALUES (1178, '常熟市', 3, 110);
INSERT INTO `shopper_region` VALUES (1179, '张家港市', 3, 110);
INSERT INTO `shopper_region` VALUES (1180, '昆山市', 3, 110);
INSERT INTO `shopper_region` VALUES (1181, '太仓市', 3, 110);
INSERT INTO `shopper_region` VALUES (1182, '通州区', 3, 111);
INSERT INTO `shopper_region` VALUES (1183, '崇川区', 3, 111);
INSERT INTO `shopper_region` VALUES (1184, '海门区', 3, 111);
INSERT INTO `shopper_region` VALUES (1185, '如东县', 3, 111);
INSERT INTO `shopper_region` VALUES (1186, '南通经济技术开发区', 3, 111);
INSERT INTO `shopper_region` VALUES (1187, '启东市', 3, 111);
INSERT INTO `shopper_region` VALUES (1188, '如皋市', 3, 111);
INSERT INTO `shopper_region` VALUES (1189, '海安市', 3, 111);
INSERT INTO `shopper_region` VALUES (1190, '连云区', 3, 112);
INSERT INTO `shopper_region` VALUES (1191, '海州区', 3, 112);
INSERT INTO `shopper_region` VALUES (1192, '赣榆区', 3, 112);
INSERT INTO `shopper_region` VALUES (1193, '东海县', 3, 112);
INSERT INTO `shopper_region` VALUES (1194, '灌云县', 3, 112);
INSERT INTO `shopper_region` VALUES (1195, '灌南县', 3, 112);
INSERT INTO `shopper_region` VALUES (1196, '连云港经济技术开发区', 3, 112);
INSERT INTO `shopper_region` VALUES (1197, '淮安区', 3, 113);
INSERT INTO `shopper_region` VALUES (1198, '淮阴区', 3, 113);
INSERT INTO `shopper_region` VALUES (1199, '清江浦区', 3, 113);
INSERT INTO `shopper_region` VALUES (1200, '洪泽区', 3, 113);
INSERT INTO `shopper_region` VALUES (1201, '涟水县', 3, 113);
INSERT INTO `shopper_region` VALUES (1202, '盱眙县', 3, 113);
INSERT INTO `shopper_region` VALUES (1203, '金湖县', 3, 113);
INSERT INTO `shopper_region` VALUES (1204, '淮安经济技术开发区', 3, 113);
INSERT INTO `shopper_region` VALUES (1205, '亭湖区', 3, 114);
INSERT INTO `shopper_region` VALUES (1206, '盐都区', 3, 114);
INSERT INTO `shopper_region` VALUES (1207, '大丰区', 3, 114);
INSERT INTO `shopper_region` VALUES (1208, '响水县', 3, 114);
INSERT INTO `shopper_region` VALUES (1209, '滨海县', 3, 114);
INSERT INTO `shopper_region` VALUES (1210, '阜宁县', 3, 114);
INSERT INTO `shopper_region` VALUES (1211, '射阳县', 3, 114);
INSERT INTO `shopper_region` VALUES (1212, '建湖县', 3, 114);
INSERT INTO `shopper_region` VALUES (1213, '盐城经济技术开发区', 3, 114);
INSERT INTO `shopper_region` VALUES (1214, '东台市', 3, 114);
INSERT INTO `shopper_region` VALUES (1215, '广陵区', 3, 115);
INSERT INTO `shopper_region` VALUES (1216, '邗江区', 3, 115);
INSERT INTO `shopper_region` VALUES (1217, '江都区', 3, 115);
INSERT INTO `shopper_region` VALUES (1218, '宝应县', 3, 115);
INSERT INTO `shopper_region` VALUES (1219, '扬州经济技术开发区', 3, 115);
INSERT INTO `shopper_region` VALUES (1220, '仪征市', 3, 115);
INSERT INTO `shopper_region` VALUES (1221, '高邮市', 3, 115);
INSERT INTO `shopper_region` VALUES (1222, '京口区', 3, 116);
INSERT INTO `shopper_region` VALUES (1223, '润州区', 3, 116);
INSERT INTO `shopper_region` VALUES (1224, '丹徒区', 3, 116);
INSERT INTO `shopper_region` VALUES (1225, '镇江新区', 3, 116);
INSERT INTO `shopper_region` VALUES (1226, '丹阳市', 3, 116);
INSERT INTO `shopper_region` VALUES (1227, '扬中市', 3, 116);
INSERT INTO `shopper_region` VALUES (1228, '句容市', 3, 116);
INSERT INTO `shopper_region` VALUES (1229, '海陵区', 3, 117);
INSERT INTO `shopper_region` VALUES (1230, '高港区', 3, 117);
INSERT INTO `shopper_region` VALUES (1231, '姜堰区', 3, 117);
INSERT INTO `shopper_region` VALUES (1232, '兴化市', 3, 117);
INSERT INTO `shopper_region` VALUES (1233, '靖江市', 3, 117);
INSERT INTO `shopper_region` VALUES (1234, '泰兴市', 3, 117);
INSERT INTO `shopper_region` VALUES (1235, '宿城区', 3, 118);
INSERT INTO `shopper_region` VALUES (1236, '宿豫区', 3, 118);
INSERT INTO `shopper_region` VALUES (1237, '沭阳县', 3, 118);
INSERT INTO `shopper_region` VALUES (1238, '泗阳县', 3, 118);
INSERT INTO `shopper_region` VALUES (1239, '泗洪县', 3, 118);
INSERT INTO `shopper_region` VALUES (1240, '宿迁经济技术开发区', 3, 118);
INSERT INTO `shopper_region` VALUES (1241, '上城区', 3, 119);
INSERT INTO `shopper_region` VALUES (1242, '拱墅区', 3, 119);
INSERT INTO `shopper_region` VALUES (1243, '西湖区', 3, 119);
INSERT INTO `shopper_region` VALUES (1244, '滨江区', 3, 119);
INSERT INTO `shopper_region` VALUES (1245, '萧山区', 3, 119);
INSERT INTO `shopper_region` VALUES (1246, '余杭区', 3, 119);
INSERT INTO `shopper_region` VALUES (1247, '富阳区', 3, 119);
INSERT INTO `shopper_region` VALUES (1248, '临安区', 3, 119);
INSERT INTO `shopper_region` VALUES (1249, '临平区', 3, 119);
INSERT INTO `shopper_region` VALUES (1250, '钱塘区', 3, 119);
INSERT INTO `shopper_region` VALUES (1251, '桐庐县', 3, 119);
INSERT INTO `shopper_region` VALUES (1252, '淳安县', 3, 119);
INSERT INTO `shopper_region` VALUES (1253, '建德市', 3, 119);
INSERT INTO `shopper_region` VALUES (1254, '海曙区', 3, 120);
INSERT INTO `shopper_region` VALUES (1255, '江北区', 3, 120);
INSERT INTO `shopper_region` VALUES (1256, '北仑区', 3, 120);
INSERT INTO `shopper_region` VALUES (1257, '镇海区', 3, 120);
INSERT INTO `shopper_region` VALUES (1258, '鄞州区', 3, 120);
INSERT INTO `shopper_region` VALUES (1259, '奉化区', 3, 120);
INSERT INTO `shopper_region` VALUES (1260, '象山县', 3, 120);
INSERT INTO `shopper_region` VALUES (1261, '宁海县', 3, 120);
INSERT INTO `shopper_region` VALUES (1262, '余姚市', 3, 120);
INSERT INTO `shopper_region` VALUES (1263, '慈溪市', 3, 120);
INSERT INTO `shopper_region` VALUES (1264, '鹿城区', 3, 121);
INSERT INTO `shopper_region` VALUES (1265, '龙湾区', 3, 121);
INSERT INTO `shopper_region` VALUES (1266, '瓯海区', 3, 121);
INSERT INTO `shopper_region` VALUES (1267, '洞头区', 3, 121);
INSERT INTO `shopper_region` VALUES (1268, '永嘉县', 3, 121);
INSERT INTO `shopper_region` VALUES (1269, '平阳县', 3, 121);
INSERT INTO `shopper_region` VALUES (1270, '苍南县', 3, 121);
INSERT INTO `shopper_region` VALUES (1271, '文成县', 3, 121);
INSERT INTO `shopper_region` VALUES (1272, '泰顺县', 3, 121);
INSERT INTO `shopper_region` VALUES (1273, '瑞安市', 3, 121);
INSERT INTO `shopper_region` VALUES (1274, '乐清市', 3, 121);
INSERT INTO `shopper_region` VALUES (1275, '龙港市', 3, 121);
INSERT INTO `shopper_region` VALUES (1276, '南湖区', 3, 122);
INSERT INTO `shopper_region` VALUES (1277, '秀洲区', 3, 122);
INSERT INTO `shopper_region` VALUES (1278, '嘉善县', 3, 122);
INSERT INTO `shopper_region` VALUES (1279, '海盐县', 3, 122);
INSERT INTO `shopper_region` VALUES (1280, '海宁市', 3, 122);
INSERT INTO `shopper_region` VALUES (1281, '平湖市', 3, 122);
INSERT INTO `shopper_region` VALUES (1282, '桐乡市', 3, 122);
INSERT INTO `shopper_region` VALUES (1283, '吴兴区', 3, 123);
INSERT INTO `shopper_region` VALUES (1284, '南浔区', 3, 123);
INSERT INTO `shopper_region` VALUES (1285, '德清县', 3, 123);
INSERT INTO `shopper_region` VALUES (1286, '长兴县', 3, 123);
INSERT INTO `shopper_region` VALUES (1287, '安吉县', 3, 123);
INSERT INTO `shopper_region` VALUES (1288, '越城区', 3, 124);
INSERT INTO `shopper_region` VALUES (1289, '柯桥区', 3, 124);
INSERT INTO `shopper_region` VALUES (1290, '上虞区', 3, 124);
INSERT INTO `shopper_region` VALUES (1291, '新昌县', 3, 124);
INSERT INTO `shopper_region` VALUES (1292, '诸暨市', 3, 124);
INSERT INTO `shopper_region` VALUES (1293, '嵊州市', 3, 124);
INSERT INTO `shopper_region` VALUES (1294, '婺城区', 3, 125);
INSERT INTO `shopper_region` VALUES (1295, '金东区', 3, 125);
INSERT INTO `shopper_region` VALUES (1296, '武义县', 3, 125);
INSERT INTO `shopper_region` VALUES (1297, '浦江县', 3, 125);
INSERT INTO `shopper_region` VALUES (1298, '磐安县', 3, 125);
INSERT INTO `shopper_region` VALUES (1299, '兰溪市', 3, 125);
INSERT INTO `shopper_region` VALUES (1300, '义乌市', 3, 125);
INSERT INTO `shopper_region` VALUES (1301, '东阳市', 3, 125);
INSERT INTO `shopper_region` VALUES (1302, '永康市', 3, 125);
INSERT INTO `shopper_region` VALUES (1303, '柯城区', 3, 126);
INSERT INTO `shopper_region` VALUES (1304, '衢江区', 3, 126);
INSERT INTO `shopper_region` VALUES (1305, '常山县', 3, 126);
INSERT INTO `shopper_region` VALUES (1306, '开化县', 3, 126);
INSERT INTO `shopper_region` VALUES (1307, '龙游县', 3, 126);
INSERT INTO `shopper_region` VALUES (1308, '江山市', 3, 126);
INSERT INTO `shopper_region` VALUES (1309, '定海区', 3, 127);
INSERT INTO `shopper_region` VALUES (1310, '普陀区', 3, 127);
INSERT INTO `shopper_region` VALUES (1311, '岱山县', 3, 127);
INSERT INTO `shopper_region` VALUES (1312, '嵊泗县', 3, 127);
INSERT INTO `shopper_region` VALUES (1313, '椒江区', 3, 128);
INSERT INTO `shopper_region` VALUES (1314, '黄岩区', 3, 128);
INSERT INTO `shopper_region` VALUES (1315, '路桥区', 3, 128);
INSERT INTO `shopper_region` VALUES (1316, '三门县', 3, 128);
INSERT INTO `shopper_region` VALUES (1317, '天台县', 3, 128);
INSERT INTO `shopper_region` VALUES (1318, '仙居县', 3, 128);
INSERT INTO `shopper_region` VALUES (1319, '温岭市', 3, 128);
INSERT INTO `shopper_region` VALUES (1320, '临海市', 3, 128);
INSERT INTO `shopper_region` VALUES (1321, '玉环市', 3, 128);
INSERT INTO `shopper_region` VALUES (1322, '莲都区', 3, 129);
INSERT INTO `shopper_region` VALUES (1323, '青田县', 3, 129);
INSERT INTO `shopper_region` VALUES (1324, '缙云县', 3, 129);
INSERT INTO `shopper_region` VALUES (1325, '遂昌县', 3, 129);
INSERT INTO `shopper_region` VALUES (1326, '松阳县', 3, 129);
INSERT INTO `shopper_region` VALUES (1327, '云和县', 3, 129);
INSERT INTO `shopper_region` VALUES (1328, '庆元县', 3, 129);
INSERT INTO `shopper_region` VALUES (1329, '景宁畲族自治县', 3, 129);
INSERT INTO `shopper_region` VALUES (1330, '龙泉市', 3, 129);
INSERT INTO `shopper_region` VALUES (1331, '瑶海区', 3, 130);
INSERT INTO `shopper_region` VALUES (1332, '庐阳区', 3, 130);
INSERT INTO `shopper_region` VALUES (1333, '蜀山区', 3, 130);
INSERT INTO `shopper_region` VALUES (1334, '包河区', 3, 130);
INSERT INTO `shopper_region` VALUES (1335, '长丰县', 3, 130);
INSERT INTO `shopper_region` VALUES (1336, '肥东县', 3, 130);
INSERT INTO `shopper_region` VALUES (1337, '肥西县', 3, 130);
INSERT INTO `shopper_region` VALUES (1338, '庐江县', 3, 130);
INSERT INTO `shopper_region` VALUES (1339, '合肥高新技术产业开发区', 3, 130);
INSERT INTO `shopper_region` VALUES (1340, '合肥经济技术开发区', 3, 130);
INSERT INTO `shopper_region` VALUES (1341, '合肥新站高新技术产业开发区', 3, 130);
INSERT INTO `shopper_region` VALUES (1342, '巢湖市', 3, 130);
INSERT INTO `shopper_region` VALUES (1343, '镜湖区', 3, 131);
INSERT INTO `shopper_region` VALUES (1344, '鸠江区', 3, 131);
INSERT INTO `shopper_region` VALUES (1345, '弋江区', 3, 131);
INSERT INTO `shopper_region` VALUES (1346, '湾沚区', 3, 131);
INSERT INTO `shopper_region` VALUES (1347, '繁昌区', 3, 131);
INSERT INTO `shopper_region` VALUES (1348, '南陵县', 3, 131);
INSERT INTO `shopper_region` VALUES (1349, '芜湖经济技术开发区', 3, 131);
INSERT INTO `shopper_region` VALUES (1350, '安徽芜湖三山经济开发区', 3, 131);
INSERT INTO `shopper_region` VALUES (1351, '无为市', 3, 131);
INSERT INTO `shopper_region` VALUES (1352, '龙子湖区', 3, 132);
INSERT INTO `shopper_region` VALUES (1353, '蚌山区', 3, 132);
INSERT INTO `shopper_region` VALUES (1354, '禹会区', 3, 132);
INSERT INTO `shopper_region` VALUES (1355, '淮上区', 3, 132);
INSERT INTO `shopper_region` VALUES (1356, '怀远县', 3, 132);
INSERT INTO `shopper_region` VALUES (1357, '五河县', 3, 132);
INSERT INTO `shopper_region` VALUES (1358, '固镇县', 3, 132);
INSERT INTO `shopper_region` VALUES (1359, '蚌埠市高新技术开发区', 3, 132);
INSERT INTO `shopper_region` VALUES (1360, '蚌埠市经济开发区', 3, 132);
INSERT INTO `shopper_region` VALUES (1361, '大通区', 3, 133);
INSERT INTO `shopper_region` VALUES (1362, '田家庵区', 3, 133);
INSERT INTO `shopper_region` VALUES (1363, '谢家集区', 3, 133);
INSERT INTO `shopper_region` VALUES (1364, '八公山区', 3, 133);
INSERT INTO `shopper_region` VALUES (1365, '潘集区', 3, 133);
INSERT INTO `shopper_region` VALUES (1366, '凤台县', 3, 133);
INSERT INTO `shopper_region` VALUES (1367, '寿县', 3, 133);
INSERT INTO `shopper_region` VALUES (1368, '花山区', 3, 134);
INSERT INTO `shopper_region` VALUES (1369, '雨山区', 3, 134);
INSERT INTO `shopper_region` VALUES (1370, '博望区', 3, 134);
INSERT INTO `shopper_region` VALUES (1371, '当涂县', 3, 134);
INSERT INTO `shopper_region` VALUES (1372, '含山县', 3, 134);
INSERT INTO `shopper_region` VALUES (1373, '和县', 3, 134);
INSERT INTO `shopper_region` VALUES (1374, '杜集区', 3, 135);
INSERT INTO `shopper_region` VALUES (1375, '相山区', 3, 135);
INSERT INTO `shopper_region` VALUES (1376, '烈山区', 3, 135);
INSERT INTO `shopper_region` VALUES (1377, '濉溪县', 3, 135);
INSERT INTO `shopper_region` VALUES (1378, '铜官区', 3, 136);
INSERT INTO `shopper_region` VALUES (1379, '义安区', 3, 136);
INSERT INTO `shopper_region` VALUES (1380, '郊区', 3, 136);
INSERT INTO `shopper_region` VALUES (1381, '枞阳县', 3, 136);
INSERT INTO `shopper_region` VALUES (1382, '迎江区', 3, 137);
INSERT INTO `shopper_region` VALUES (1383, '大观区', 3, 137);
INSERT INTO `shopper_region` VALUES (1384, '宜秀区', 3, 137);
INSERT INTO `shopper_region` VALUES (1385, '怀宁县', 3, 137);
INSERT INTO `shopper_region` VALUES (1386, '太湖县', 3, 137);
INSERT INTO `shopper_region` VALUES (1387, '宿松县', 3, 137);
INSERT INTO `shopper_region` VALUES (1388, '望江县', 3, 137);
INSERT INTO `shopper_region` VALUES (1389, '岳西县', 3, 137);
INSERT INTO `shopper_region` VALUES (1390, '安徽安庆经济开发区', 3, 137);
INSERT INTO `shopper_region` VALUES (1391, '桐城市', 3, 137);
INSERT INTO `shopper_region` VALUES (1392, '潜山市', 3, 137);
INSERT INTO `shopper_region` VALUES (1393, '屯溪区', 3, 138);
INSERT INTO `shopper_region` VALUES (1394, '黄山区', 3, 138);
INSERT INTO `shopper_region` VALUES (1395, '徽州区', 3, 138);
INSERT INTO `shopper_region` VALUES (1396, '歙县', 3, 138);
INSERT INTO `shopper_region` VALUES (1397, '休宁县', 3, 138);
INSERT INTO `shopper_region` VALUES (1398, '黟县', 3, 138);
INSERT INTO `shopper_region` VALUES (1399, '祁门县', 3, 138);
INSERT INTO `shopper_region` VALUES (1400, '琅琊区', 3, 139);
INSERT INTO `shopper_region` VALUES (1401, '南谯区', 3, 139);
INSERT INTO `shopper_region` VALUES (1402, '来安县', 3, 139);
INSERT INTO `shopper_region` VALUES (1403, '全椒县', 3, 139);
INSERT INTO `shopper_region` VALUES (1404, '定远县', 3, 139);
INSERT INTO `shopper_region` VALUES (1405, '凤阳县', 3, 139);
INSERT INTO `shopper_region` VALUES (1406, '中新苏滁高新技术产业开发区', 3, 139);
INSERT INTO `shopper_region` VALUES (1407, '滁州经济技术开发区', 3, 139);
INSERT INTO `shopper_region` VALUES (1408, '天长市', 3, 139);
INSERT INTO `shopper_region` VALUES (1409, '明光市', 3, 139);
INSERT INTO `shopper_region` VALUES (1410, '颍州区', 3, 140);
INSERT INTO `shopper_region` VALUES (1411, '颍东区', 3, 140);
INSERT INTO `shopper_region` VALUES (1412, '颍泉区', 3, 140);
INSERT INTO `shopper_region` VALUES (1413, '临泉县', 3, 140);
INSERT INTO `shopper_region` VALUES (1414, '太和县', 3, 140);
INSERT INTO `shopper_region` VALUES (1415, '阜南县', 3, 140);
INSERT INTO `shopper_region` VALUES (1416, '颍上县', 3, 140);
INSERT INTO `shopper_region` VALUES (1417, '阜阳合肥现代产业园区', 3, 140);
INSERT INTO `shopper_region` VALUES (1418, '阜阳经济技术开发区', 3, 140);
INSERT INTO `shopper_region` VALUES (1419, '界首市', 3, 140);
INSERT INTO `shopper_region` VALUES (1420, '埇桥区', 3, 141);
INSERT INTO `shopper_region` VALUES (1421, '砀山县', 3, 141);
INSERT INTO `shopper_region` VALUES (1422, '萧县', 3, 141);
INSERT INTO `shopper_region` VALUES (1423, '灵璧县', 3, 141);
INSERT INTO `shopper_region` VALUES (1424, '泗县', 3, 141);
INSERT INTO `shopper_region` VALUES (1425, '宿州马鞍山现代产业园区', 3, 141);
INSERT INTO `shopper_region` VALUES (1426, '宿州经济技术开发区', 3, 141);
INSERT INTO `shopper_region` VALUES (1427, '金安区', 3, 142);
INSERT INTO `shopper_region` VALUES (1428, '裕安区', 3, 142);
INSERT INTO `shopper_region` VALUES (1429, '叶集区', 3, 142);
INSERT INTO `shopper_region` VALUES (1430, '霍邱县', 3, 142);
INSERT INTO `shopper_region` VALUES (1431, '舒城县', 3, 142);
INSERT INTO `shopper_region` VALUES (1432, '金寨县', 3, 142);
INSERT INTO `shopper_region` VALUES (1433, '霍山县', 3, 142);
INSERT INTO `shopper_region` VALUES (1434, '谯城区', 3, 143);
INSERT INTO `shopper_region` VALUES (1435, '涡阳县', 3, 143);
INSERT INTO `shopper_region` VALUES (1436, '蒙城县', 3, 143);
INSERT INTO `shopper_region` VALUES (1437, '利辛县', 3, 143);
INSERT INTO `shopper_region` VALUES (1438, '贵池区', 3, 144);
INSERT INTO `shopper_region` VALUES (1439, '东至县', 3, 144);
INSERT INTO `shopper_region` VALUES (1440, '石台县', 3, 144);
INSERT INTO `shopper_region` VALUES (1441, '青阳县', 3, 144);
INSERT INTO `shopper_region` VALUES (1442, '宣州区', 3, 145);
INSERT INTO `shopper_region` VALUES (1443, '郎溪县', 3, 145);
INSERT INTO `shopper_region` VALUES (1444, '泾县', 3, 145);
INSERT INTO `shopper_region` VALUES (1445, '绩溪县', 3, 145);
INSERT INTO `shopper_region` VALUES (1446, '旌德县', 3, 145);
INSERT INTO `shopper_region` VALUES (1447, '宣城市经济开发区', 3, 145);
INSERT INTO `shopper_region` VALUES (1448, '宁国市', 3, 145);
INSERT INTO `shopper_region` VALUES (1449, '广德市', 3, 145);
INSERT INTO `shopper_region` VALUES (1450, '鼓楼区', 3, 146);
INSERT INTO `shopper_region` VALUES (1451, '台江区', 3, 146);
INSERT INTO `shopper_region` VALUES (1452, '仓山区', 3, 146);
INSERT INTO `shopper_region` VALUES (1453, '马尾区', 3, 146);
INSERT INTO `shopper_region` VALUES (1454, '晋安区', 3, 146);
INSERT INTO `shopper_region` VALUES (1455, '长乐区', 3, 146);
INSERT INTO `shopper_region` VALUES (1456, '闽侯县', 3, 146);
INSERT INTO `shopper_region` VALUES (1457, '连江县', 3, 146);
INSERT INTO `shopper_region` VALUES (1458, '罗源县', 3, 146);
INSERT INTO `shopper_region` VALUES (1459, '闽清县', 3, 146);
INSERT INTO `shopper_region` VALUES (1460, '永泰县', 3, 146);
INSERT INTO `shopper_region` VALUES (1461, '平潭县', 3, 146);
INSERT INTO `shopper_region` VALUES (1462, '福清市', 3, 146);
INSERT INTO `shopper_region` VALUES (1463, '思明区', 3, 147);
INSERT INTO `shopper_region` VALUES (1464, '海沧区', 3, 147);
INSERT INTO `shopper_region` VALUES (1465, '湖里区', 3, 147);
INSERT INTO `shopper_region` VALUES (1466, '集美区', 3, 147);
INSERT INTO `shopper_region` VALUES (1467, '同安区', 3, 147);
INSERT INTO `shopper_region` VALUES (1468, '翔安区', 3, 147);
INSERT INTO `shopper_region` VALUES (1469, '城厢区', 3, 148);
INSERT INTO `shopper_region` VALUES (1470, '涵江区', 3, 148);
INSERT INTO `shopper_region` VALUES (1471, '荔城区', 3, 148);
INSERT INTO `shopper_region` VALUES (1472, '秀屿区', 3, 148);
INSERT INTO `shopper_region` VALUES (1473, '仙游县', 3, 148);
INSERT INTO `shopper_region` VALUES (1474, '三元区', 3, 149);
INSERT INTO `shopper_region` VALUES (1475, '沙县区', 3, 149);
INSERT INTO `shopper_region` VALUES (1476, '明溪县', 3, 149);
INSERT INTO `shopper_region` VALUES (1477, '清流县', 3, 149);
INSERT INTO `shopper_region` VALUES (1478, '宁化县', 3, 149);
INSERT INTO `shopper_region` VALUES (1479, '大田县', 3, 149);
INSERT INTO `shopper_region` VALUES (1480, '尤溪县', 3, 149);
INSERT INTO `shopper_region` VALUES (1481, '将乐县', 3, 149);
INSERT INTO `shopper_region` VALUES (1482, '泰宁县', 3, 149);
INSERT INTO `shopper_region` VALUES (1483, '建宁县', 3, 149);
INSERT INTO `shopper_region` VALUES (1484, '永安市', 3, 149);
INSERT INTO `shopper_region` VALUES (1485, '鲤城区', 3, 150);
INSERT INTO `shopper_region` VALUES (1486, '丰泽区', 3, 150);
INSERT INTO `shopper_region` VALUES (1487, '洛江区', 3, 150);
INSERT INTO `shopper_region` VALUES (1488, '泉港区', 3, 150);
INSERT INTO `shopper_region` VALUES (1489, '惠安县', 3, 150);
INSERT INTO `shopper_region` VALUES (1490, '安溪县', 3, 150);
INSERT INTO `shopper_region` VALUES (1491, '永春县', 3, 150);
INSERT INTO `shopper_region` VALUES (1492, '德化县', 3, 150);
INSERT INTO `shopper_region` VALUES (1493, '石狮市', 3, 150);
INSERT INTO `shopper_region` VALUES (1494, '晋江市', 3, 150);
INSERT INTO `shopper_region` VALUES (1495, '南安市', 3, 150);
INSERT INTO `shopper_region` VALUES (1496, '芗城区', 3, 151);
INSERT INTO `shopper_region` VALUES (1497, '龙文区', 3, 151);
INSERT INTO `shopper_region` VALUES (1498, '龙海区', 3, 151);
INSERT INTO `shopper_region` VALUES (1499, '长泰区', 3, 151);
INSERT INTO `shopper_region` VALUES (1500, '云霄县', 3, 151);
INSERT INTO `shopper_region` VALUES (1501, '漳浦县', 3, 151);
INSERT INTO `shopper_region` VALUES (1502, '诏安县', 3, 151);
INSERT INTO `shopper_region` VALUES (1503, '东山县', 3, 151);
INSERT INTO `shopper_region` VALUES (1504, '南靖县', 3, 151);
INSERT INTO `shopper_region` VALUES (1505, '平和县', 3, 151);
INSERT INTO `shopper_region` VALUES (1506, '华安县', 3, 151);
INSERT INTO `shopper_region` VALUES (1507, '延平区', 3, 152);
INSERT INTO `shopper_region` VALUES (1508, '建阳区', 3, 152);
INSERT INTO `shopper_region` VALUES (1509, '顺昌县', 3, 152);
INSERT INTO `shopper_region` VALUES (1510, '浦城县', 3, 152);
INSERT INTO `shopper_region` VALUES (1511, '光泽县', 3, 152);
INSERT INTO `shopper_region` VALUES (1512, '松溪县', 3, 152);
INSERT INTO `shopper_region` VALUES (1513, '政和县', 3, 152);
INSERT INTO `shopper_region` VALUES (1514, '邵武市', 3, 152);
INSERT INTO `shopper_region` VALUES (1515, '武夷山市', 3, 152);
INSERT INTO `shopper_region` VALUES (1516, '建瓯市', 3, 152);
INSERT INTO `shopper_region` VALUES (1517, '新罗区', 3, 153);
INSERT INTO `shopper_region` VALUES (1518, '永定区', 3, 153);
INSERT INTO `shopper_region` VALUES (1519, '长汀县', 3, 153);
INSERT INTO `shopper_region` VALUES (1520, '上杭县', 3, 153);
INSERT INTO `shopper_region` VALUES (1521, '武平县', 3, 153);
INSERT INTO `shopper_region` VALUES (1522, '连城县', 3, 153);
INSERT INTO `shopper_region` VALUES (1523, '漳平市', 3, 153);
INSERT INTO `shopper_region` VALUES (1524, '蕉城区', 3, 154);
INSERT INTO `shopper_region` VALUES (1525, '霞浦县', 3, 154);
INSERT INTO `shopper_region` VALUES (1526, '古田县', 3, 154);
INSERT INTO `shopper_region` VALUES (1527, '屏南县', 3, 154);
INSERT INTO `shopper_region` VALUES (1528, '寿宁县', 3, 154);
INSERT INTO `shopper_region` VALUES (1529, '周宁县', 3, 154);
INSERT INTO `shopper_region` VALUES (1530, '柘荣县', 3, 154);
INSERT INTO `shopper_region` VALUES (1531, '福安市', 3, 154);
INSERT INTO `shopper_region` VALUES (1532, '福鼎市', 3, 154);
INSERT INTO `shopper_region` VALUES (1533, '东湖区', 3, 155);
INSERT INTO `shopper_region` VALUES (1534, '西湖区', 3, 155);
INSERT INTO `shopper_region` VALUES (1535, '青云谱区', 3, 155);
INSERT INTO `shopper_region` VALUES (1536, '青山湖区', 3, 155);
INSERT INTO `shopper_region` VALUES (1537, '新建区', 3, 155);
INSERT INTO `shopper_region` VALUES (1538, '红谷滩区', 3, 155);
INSERT INTO `shopper_region` VALUES (1539, '南昌县', 3, 155);
INSERT INTO `shopper_region` VALUES (1540, '安义县', 3, 155);
INSERT INTO `shopper_region` VALUES (1541, '进贤县', 3, 155);
INSERT INTO `shopper_region` VALUES (1542, '昌江区', 3, 156);
INSERT INTO `shopper_region` VALUES (1543, '珠山区', 3, 156);
INSERT INTO `shopper_region` VALUES (1544, '浮梁县', 3, 156);
INSERT INTO `shopper_region` VALUES (1545, '乐平市', 3, 156);
INSERT INTO `shopper_region` VALUES (1546, '安源区', 3, 157);
INSERT INTO `shopper_region` VALUES (1547, '湘东区', 3, 157);
INSERT INTO `shopper_region` VALUES (1548, '莲花县', 3, 157);
INSERT INTO `shopper_region` VALUES (1549, '上栗县', 3, 157);
INSERT INTO `shopper_region` VALUES (1550, '芦溪县', 3, 157);
INSERT INTO `shopper_region` VALUES (1551, '濂溪区', 3, 158);
INSERT INTO `shopper_region` VALUES (1552, '浔阳区', 3, 158);
INSERT INTO `shopper_region` VALUES (1553, '柴桑区', 3, 158);
INSERT INTO `shopper_region` VALUES (1554, '武宁县', 3, 158);
INSERT INTO `shopper_region` VALUES (1555, '修水县', 3, 158);
INSERT INTO `shopper_region` VALUES (1556, '永修县', 3, 158);
INSERT INTO `shopper_region` VALUES (1557, '德安县', 3, 158);
INSERT INTO `shopper_region` VALUES (1558, '都昌县', 3, 158);
INSERT INTO `shopper_region` VALUES (1559, '湖口县', 3, 158);
INSERT INTO `shopper_region` VALUES (1560, '彭泽县', 3, 158);
INSERT INTO `shopper_region` VALUES (1561, '瑞昌市', 3, 158);
INSERT INTO `shopper_region` VALUES (1562, '共青城市', 3, 158);
INSERT INTO `shopper_region` VALUES (1563, '庐山市', 3, 158);
INSERT INTO `shopper_region` VALUES (1564, '渝水区', 3, 159);
INSERT INTO `shopper_region` VALUES (1565, '分宜县', 3, 159);
INSERT INTO `shopper_region` VALUES (1566, '月湖区', 3, 160);
INSERT INTO `shopper_region` VALUES (1567, '余江区', 3, 160);
INSERT INTO `shopper_region` VALUES (1568, '贵溪市', 3, 160);
INSERT INTO `shopper_region` VALUES (1569, '章贡区', 3, 161);
INSERT INTO `shopper_region` VALUES (1570, '南康区', 3, 161);
INSERT INTO `shopper_region` VALUES (1571, '赣县区', 3, 161);
INSERT INTO `shopper_region` VALUES (1572, '信丰县', 3, 161);
INSERT INTO `shopper_region` VALUES (1573, '大余县', 3, 161);
INSERT INTO `shopper_region` VALUES (1574, '上犹县', 3, 161);
INSERT INTO `shopper_region` VALUES (1575, '崇义县', 3, 161);
INSERT INTO `shopper_region` VALUES (1576, '安远县', 3, 161);
INSERT INTO `shopper_region` VALUES (1577, '定南县', 3, 161);
INSERT INTO `shopper_region` VALUES (1578, '全南县', 3, 161);
INSERT INTO `shopper_region` VALUES (1579, '宁都县', 3, 161);
INSERT INTO `shopper_region` VALUES (1580, '于都县', 3, 161);
INSERT INTO `shopper_region` VALUES (1581, '兴国县', 3, 161);
INSERT INTO `shopper_region` VALUES (1582, '会昌县', 3, 161);
INSERT INTO `shopper_region` VALUES (1583, '寻乌县', 3, 161);
INSERT INTO `shopper_region` VALUES (1584, '石城县', 3, 161);
INSERT INTO `shopper_region` VALUES (1585, '瑞金市', 3, 161);
INSERT INTO `shopper_region` VALUES (1586, '龙南市', 3, 161);
INSERT INTO `shopper_region` VALUES (1587, '吉州区', 3, 162);
INSERT INTO `shopper_region` VALUES (1588, '青原区', 3, 162);
INSERT INTO `shopper_region` VALUES (1589, '吉安县', 3, 162);
INSERT INTO `shopper_region` VALUES (1590, '吉水县', 3, 162);
INSERT INTO `shopper_region` VALUES (1591, '峡江县', 3, 162);
INSERT INTO `shopper_region` VALUES (1592, '新干县', 3, 162);
INSERT INTO `shopper_region` VALUES (1593, '永丰县', 3, 162);
INSERT INTO `shopper_region` VALUES (1594, '泰和县', 3, 162);
INSERT INTO `shopper_region` VALUES (1595, '遂川县', 3, 162);
INSERT INTO `shopper_region` VALUES (1596, '万安县', 3, 162);
INSERT INTO `shopper_region` VALUES (1597, '安福县', 3, 162);
INSERT INTO `shopper_region` VALUES (1598, '永新县', 3, 162);
INSERT INTO `shopper_region` VALUES (1599, '井冈山市', 3, 162);
INSERT INTO `shopper_region` VALUES (1600, '袁州区', 3, 163);
INSERT INTO `shopper_region` VALUES (1601, '奉新县', 3, 163);
INSERT INTO `shopper_region` VALUES (1602, '万载县', 3, 163);
INSERT INTO `shopper_region` VALUES (1603, '上高县', 3, 163);
INSERT INTO `shopper_region` VALUES (1604, '宜丰县', 3, 163);
INSERT INTO `shopper_region` VALUES (1605, '靖安县', 3, 163);
INSERT INTO `shopper_region` VALUES (1606, '铜鼓县', 3, 163);
INSERT INTO `shopper_region` VALUES (1607, '丰城市', 3, 163);
INSERT INTO `shopper_region` VALUES (1608, '樟树市', 3, 163);
INSERT INTO `shopper_region` VALUES (1609, '高安市', 3, 163);
INSERT INTO `shopper_region` VALUES (1610, '临川区', 3, 164);
INSERT INTO `shopper_region` VALUES (1611, '东乡区', 3, 164);
INSERT INTO `shopper_region` VALUES (1612, '南城县', 3, 164);
INSERT INTO `shopper_region` VALUES (1613, '黎川县', 3, 164);
INSERT INTO `shopper_region` VALUES (1614, '南丰县', 3, 164);
INSERT INTO `shopper_region` VALUES (1615, '崇仁县', 3, 164);
INSERT INTO `shopper_region` VALUES (1616, '乐安县', 3, 164);
INSERT INTO `shopper_region` VALUES (1617, '宜黄县', 3, 164);
INSERT INTO `shopper_region` VALUES (1618, '金溪县', 3, 164);
INSERT INTO `shopper_region` VALUES (1619, '资溪县', 3, 164);
INSERT INTO `shopper_region` VALUES (1620, '广昌县', 3, 164);
INSERT INTO `shopper_region` VALUES (1621, '信州区', 3, 165);
INSERT INTO `shopper_region` VALUES (1622, '广丰区', 3, 165);
INSERT INTO `shopper_region` VALUES (1623, '广信区', 3, 165);
INSERT INTO `shopper_region` VALUES (1624, '玉山县', 3, 165);
INSERT INTO `shopper_region` VALUES (1625, '铅山县', 3, 165);
INSERT INTO `shopper_region` VALUES (1626, '横峰县', 3, 165);
INSERT INTO `shopper_region` VALUES (1627, '弋阳县', 3, 165);
INSERT INTO `shopper_region` VALUES (1628, '余干县', 3, 165);
INSERT INTO `shopper_region` VALUES (1629, '鄱阳县', 3, 165);
INSERT INTO `shopper_region` VALUES (1630, '万年县', 3, 165);
INSERT INTO `shopper_region` VALUES (1631, '婺源县', 3, 165);
INSERT INTO `shopper_region` VALUES (1632, '德兴市', 3, 165);
INSERT INTO `shopper_region` VALUES (1633, '历下区', 3, 166);
INSERT INTO `shopper_region` VALUES (1634, '市中区', 3, 166);
INSERT INTO `shopper_region` VALUES (1635, '槐荫区', 3, 166);
INSERT INTO `shopper_region` VALUES (1636, '天桥区', 3, 166);
INSERT INTO `shopper_region` VALUES (1637, '历城区', 3, 166);
INSERT INTO `shopper_region` VALUES (1638, '长清区', 3, 166);
INSERT INTO `shopper_region` VALUES (1639, '章丘区', 3, 166);
INSERT INTO `shopper_region` VALUES (1640, '济阳区', 3, 166);
INSERT INTO `shopper_region` VALUES (1641, '莱芜区', 3, 166);
INSERT INTO `shopper_region` VALUES (1642, '钢城区', 3, 166);
INSERT INTO `shopper_region` VALUES (1643, '平阴县', 3, 166);
INSERT INTO `shopper_region` VALUES (1644, '商河县', 3, 166);
INSERT INTO `shopper_region` VALUES (1645, '济南高新技术产业开发区', 3, 166);
INSERT INTO `shopper_region` VALUES (1646, '市南区', 3, 167);
INSERT INTO `shopper_region` VALUES (1647, '市北区', 3, 167);
INSERT INTO `shopper_region` VALUES (1648, '黄岛区', 3, 167);
INSERT INTO `shopper_region` VALUES (1649, '崂山区', 3, 167);
INSERT INTO `shopper_region` VALUES (1650, '李沧区', 3, 167);
INSERT INTO `shopper_region` VALUES (1651, '城阳区', 3, 167);
INSERT INTO `shopper_region` VALUES (1652, '即墨区', 3, 167);
INSERT INTO `shopper_region` VALUES (1653, '胶州市', 3, 167);
INSERT INTO `shopper_region` VALUES (1654, '平度市', 3, 167);
INSERT INTO `shopper_region` VALUES (1655, '莱西市', 3, 167);
INSERT INTO `shopper_region` VALUES (1656, '淄川区', 3, 168);
INSERT INTO `shopper_region` VALUES (1657, '张店区', 3, 168);
INSERT INTO `shopper_region` VALUES (1658, '博山区', 3, 168);
INSERT INTO `shopper_region` VALUES (1659, '临淄区', 3, 168);
INSERT INTO `shopper_region` VALUES (1660, '周村区', 3, 168);
INSERT INTO `shopper_region` VALUES (1661, '桓台县', 3, 168);
INSERT INTO `shopper_region` VALUES (1662, '高青县', 3, 168);
INSERT INTO `shopper_region` VALUES (1663, '沂源县', 3, 168);
INSERT INTO `shopper_region` VALUES (1664, '市中区', 3, 169);
INSERT INTO `shopper_region` VALUES (1665, '薛城区', 3, 169);
INSERT INTO `shopper_region` VALUES (1666, '峄城区', 3, 169);
INSERT INTO `shopper_region` VALUES (1667, '台儿庄区', 3, 169);
INSERT INTO `shopper_region` VALUES (1668, '山亭区', 3, 169);
INSERT INTO `shopper_region` VALUES (1669, '滕州市', 3, 169);
INSERT INTO `shopper_region` VALUES (1670, '东营区', 3, 170);
INSERT INTO `shopper_region` VALUES (1671, '河口区', 3, 170);
INSERT INTO `shopper_region` VALUES (1672, '垦利区', 3, 170);
INSERT INTO `shopper_region` VALUES (1673, '利津县', 3, 170);
INSERT INTO `shopper_region` VALUES (1674, '广饶县', 3, 170);
INSERT INTO `shopper_region` VALUES (1675, '东营经济技术开发区', 3, 170);
INSERT INTO `shopper_region` VALUES (1676, '东营港经济开发区', 3, 170);
INSERT INTO `shopper_region` VALUES (1677, '芝罘区', 3, 171);
INSERT INTO `shopper_region` VALUES (1678, '福山区', 3, 171);
INSERT INTO `shopper_region` VALUES (1679, '牟平区', 3, 171);
INSERT INTO `shopper_region` VALUES (1680, '莱山区', 3, 171);
INSERT INTO `shopper_region` VALUES (1681, '蓬莱区', 3, 171);
INSERT INTO `shopper_region` VALUES (1682, '烟台高新技术产业开发区', 3, 171);
INSERT INTO `shopper_region` VALUES (1683, '烟台经济技术开发区', 3, 171);
INSERT INTO `shopper_region` VALUES (1684, '龙口市', 3, 171);
INSERT INTO `shopper_region` VALUES (1685, '莱阳市', 3, 171);
INSERT INTO `shopper_region` VALUES (1686, '莱州市', 3, 171);
INSERT INTO `shopper_region` VALUES (1687, '招远市', 3, 171);
INSERT INTO `shopper_region` VALUES (1688, '栖霞市', 3, 171);
INSERT INTO `shopper_region` VALUES (1689, '海阳市', 3, 171);
INSERT INTO `shopper_region` VALUES (1690, '潍城区', 3, 172);
INSERT INTO `shopper_region` VALUES (1691, '寒亭区', 3, 172);
INSERT INTO `shopper_region` VALUES (1692, '坊子区', 3, 172);
INSERT INTO `shopper_region` VALUES (1693, '奎文区', 3, 172);
INSERT INTO `shopper_region` VALUES (1694, '临朐县', 3, 172);
INSERT INTO `shopper_region` VALUES (1695, '昌乐县', 3, 172);
INSERT INTO `shopper_region` VALUES (1696, '潍坊滨海经济技术开发区', 3, 172);
INSERT INTO `shopper_region` VALUES (1697, '青州市', 3, 172);
INSERT INTO `shopper_region` VALUES (1698, '诸城市', 3, 172);
INSERT INTO `shopper_region` VALUES (1699, '寿光市', 3, 172);
INSERT INTO `shopper_region` VALUES (1700, '安丘市', 3, 172);
INSERT INTO `shopper_region` VALUES (1701, '高密市', 3, 172);
INSERT INTO `shopper_region` VALUES (1702, '昌邑市', 3, 172);
INSERT INTO `shopper_region` VALUES (1703, '任城区', 3, 173);
INSERT INTO `shopper_region` VALUES (1704, '兖州区', 3, 173);
INSERT INTO `shopper_region` VALUES (1705, '微山县', 3, 173);
INSERT INTO `shopper_region` VALUES (1706, '鱼台县', 3, 173);
INSERT INTO `shopper_region` VALUES (1707, '金乡县', 3, 173);
INSERT INTO `shopper_region` VALUES (1708, '嘉祥县', 3, 173);
INSERT INTO `shopper_region` VALUES (1709, '汶上县', 3, 173);
INSERT INTO `shopper_region` VALUES (1710, '泗水县', 3, 173);
INSERT INTO `shopper_region` VALUES (1711, '梁山县', 3, 173);
INSERT INTO `shopper_region` VALUES (1712, '济宁高新技术产业开发区', 3, 173);
INSERT INTO `shopper_region` VALUES (1713, '曲阜市', 3, 173);
INSERT INTO `shopper_region` VALUES (1714, '邹城市', 3, 173);
INSERT INTO `shopper_region` VALUES (1715, '泰山区', 3, 174);
INSERT INTO `shopper_region` VALUES (1716, '岱岳区', 3, 174);
INSERT INTO `shopper_region` VALUES (1717, '宁阳县', 3, 174);
INSERT INTO `shopper_region` VALUES (1718, '东平县', 3, 174);
INSERT INTO `shopper_region` VALUES (1719, '新泰市', 3, 174);
INSERT INTO `shopper_region` VALUES (1720, '肥城市', 3, 174);
INSERT INTO `shopper_region` VALUES (1721, '环翠区', 3, 175);
INSERT INTO `shopper_region` VALUES (1722, '文登区', 3, 175);
INSERT INTO `shopper_region` VALUES (1723, '威海火炬高技术产业开发区', 3, 175);
INSERT INTO `shopper_region` VALUES (1724, '威海经济技术开发区', 3, 175);
INSERT INTO `shopper_region` VALUES (1725, '威海临港经济技术开发区', 3, 175);
INSERT INTO `shopper_region` VALUES (1726, '荣成市', 3, 175);
INSERT INTO `shopper_region` VALUES (1727, '乳山市', 3, 175);
INSERT INTO `shopper_region` VALUES (1728, '东港区', 3, 176);
INSERT INTO `shopper_region` VALUES (1729, '岚山区', 3, 176);
INSERT INTO `shopper_region` VALUES (1730, '五莲县', 3, 176);
INSERT INTO `shopper_region` VALUES (1731, '莒县', 3, 176);
INSERT INTO `shopper_region` VALUES (1732, '日照经济技术开发区', 3, 176);
INSERT INTO `shopper_region` VALUES (1733, '兰山区', 3, 177);
INSERT INTO `shopper_region` VALUES (1734, '罗庄区', 3, 177);
INSERT INTO `shopper_region` VALUES (1735, '河东区', 3, 177);
INSERT INTO `shopper_region` VALUES (1736, '沂南县', 3, 177);
INSERT INTO `shopper_region` VALUES (1737, '郯城县', 3, 177);
INSERT INTO `shopper_region` VALUES (1738, '沂水县', 3, 177);
INSERT INTO `shopper_region` VALUES (1739, '兰陵县', 3, 177);
INSERT INTO `shopper_region` VALUES (1740, '费县', 3, 177);
INSERT INTO `shopper_region` VALUES (1741, '平邑县', 3, 177);
INSERT INTO `shopper_region` VALUES (1742, '莒南县', 3, 177);
INSERT INTO `shopper_region` VALUES (1743, '蒙阴县', 3, 177);
INSERT INTO `shopper_region` VALUES (1744, '临沭县', 3, 177);
INSERT INTO `shopper_region` VALUES (1745, '临沂高新技术产业开发区', 3, 177);
INSERT INTO `shopper_region` VALUES (1746, '德城区', 3, 178);
INSERT INTO `shopper_region` VALUES (1747, '陵城区', 3, 178);
INSERT INTO `shopper_region` VALUES (1748, '宁津县', 3, 178);
INSERT INTO `shopper_region` VALUES (1749, '庆云县', 3, 178);
INSERT INTO `shopper_region` VALUES (1750, '临邑县', 3, 178);
INSERT INTO `shopper_region` VALUES (1751, '齐河县', 3, 178);
INSERT INTO `shopper_region` VALUES (1752, '平原县', 3, 178);
INSERT INTO `shopper_region` VALUES (1753, '夏津县', 3, 178);
INSERT INTO `shopper_region` VALUES (1754, '武城县', 3, 178);
INSERT INTO `shopper_region` VALUES (1755, '德州天衢新区', 3, 178);
INSERT INTO `shopper_region` VALUES (1756, '乐陵市', 3, 178);
INSERT INTO `shopper_region` VALUES (1757, '禹城市', 3, 178);
INSERT INTO `shopper_region` VALUES (1758, '东昌府区', 3, 179);
INSERT INTO `shopper_region` VALUES (1759, '茌平区', 3, 179);
INSERT INTO `shopper_region` VALUES (1760, '阳谷县', 3, 179);
INSERT INTO `shopper_region` VALUES (1761, '莘县', 3, 179);
INSERT INTO `shopper_region` VALUES (1762, '东阿县', 3, 179);
INSERT INTO `shopper_region` VALUES (1763, '冠县', 3, 179);
INSERT INTO `shopper_region` VALUES (1764, '高唐县', 3, 179);
INSERT INTO `shopper_region` VALUES (1765, '临清市', 3, 179);
INSERT INTO `shopper_region` VALUES (1766, '滨城区', 3, 180);
INSERT INTO `shopper_region` VALUES (1767, '沾化区', 3, 180);
INSERT INTO `shopper_region` VALUES (1768, '惠民县', 3, 180);
INSERT INTO `shopper_region` VALUES (1769, '阳信县', 3, 180);
INSERT INTO `shopper_region` VALUES (1770, '无棣县', 3, 180);
INSERT INTO `shopper_region` VALUES (1771, '博兴县', 3, 180);
INSERT INTO `shopper_region` VALUES (1772, '邹平市', 3, 180);
INSERT INTO `shopper_region` VALUES (1773, '牡丹区', 3, 181);
INSERT INTO `shopper_region` VALUES (1774, '定陶区', 3, 181);
INSERT INTO `shopper_region` VALUES (1775, '曹县', 3, 181);
INSERT INTO `shopper_region` VALUES (1776, '单县', 3, 181);
INSERT INTO `shopper_region` VALUES (1777, '成武县', 3, 181);
INSERT INTO `shopper_region` VALUES (1778, '巨野县', 3, 181);
INSERT INTO `shopper_region` VALUES (1779, '郓城县', 3, 181);
INSERT INTO `shopper_region` VALUES (1780, '鄄城县', 3, 181);
INSERT INTO `shopper_region` VALUES (1781, '东明县', 3, 181);
INSERT INTO `shopper_region` VALUES (1782, '菏泽经济技术开发区', 3, 181);
INSERT INTO `shopper_region` VALUES (1783, '菏泽高新技术开发区', 3, 181);
INSERT INTO `shopper_region` VALUES (1784, '中原区', 3, 182);
INSERT INTO `shopper_region` VALUES (1785, '二七区', 3, 182);
INSERT INTO `shopper_region` VALUES (1786, '管城回族区', 3, 182);
INSERT INTO `shopper_region` VALUES (1787, '金水区', 3, 182);
INSERT INTO `shopper_region` VALUES (1788, '上街区', 3, 182);
INSERT INTO `shopper_region` VALUES (1789, '惠济区', 3, 182);
INSERT INTO `shopper_region` VALUES (1790, '中牟县', 3, 182);
INSERT INTO `shopper_region` VALUES (1791, '郑州经济技术开发区', 3, 182);
INSERT INTO `shopper_region` VALUES (1792, '郑州高新技术产业开发区', 3, 182);
INSERT INTO `shopper_region` VALUES (1793, '郑州航空港经济综合实验区', 3, 182);
INSERT INTO `shopper_region` VALUES (1794, '巩义市', 3, 182);
INSERT INTO `shopper_region` VALUES (1795, '荥阳市', 3, 182);
INSERT INTO `shopper_region` VALUES (1796, '新密市', 3, 182);
INSERT INTO `shopper_region` VALUES (1797, '新郑市', 3, 182);
INSERT INTO `shopper_region` VALUES (1798, '登封市', 3, 182);
INSERT INTO `shopper_region` VALUES (1799, '龙亭区', 3, 183);
INSERT INTO `shopper_region` VALUES (1800, '顺河回族区', 3, 183);
INSERT INTO `shopper_region` VALUES (1801, '鼓楼区', 3, 183);
INSERT INTO `shopper_region` VALUES (1802, '禹王台区', 3, 183);
INSERT INTO `shopper_region` VALUES (1803, '祥符区', 3, 183);
INSERT INTO `shopper_region` VALUES (1804, '杞县', 3, 183);
INSERT INTO `shopper_region` VALUES (1805, '通许县', 3, 183);
INSERT INTO `shopper_region` VALUES (1806, '尉氏县', 3, 183);
INSERT INTO `shopper_region` VALUES (1807, '兰考县', 3, 183);
INSERT INTO `shopper_region` VALUES (1808, '老城区', 3, 184);
INSERT INTO `shopper_region` VALUES (1809, '西工区', 3, 184);
INSERT INTO `shopper_region` VALUES (1810, '瀍河回族区', 3, 184);
INSERT INTO `shopper_region` VALUES (1811, '涧西区', 3, 184);
INSERT INTO `shopper_region` VALUES (1812, '偃师区', 3, 184);
INSERT INTO `shopper_region` VALUES (1813, '孟津区', 3, 184);
INSERT INTO `shopper_region` VALUES (1814, '洛龙区', 3, 184);
INSERT INTO `shopper_region` VALUES (1815, '新安县', 3, 184);
INSERT INTO `shopper_region` VALUES (1816, '栾川县', 3, 184);
INSERT INTO `shopper_region` VALUES (1817, '嵩县', 3, 184);
INSERT INTO `shopper_region` VALUES (1818, '汝阳县', 3, 184);
INSERT INTO `shopper_region` VALUES (1819, '宜阳县', 3, 184);
INSERT INTO `shopper_region` VALUES (1820, '洛宁县', 3, 184);
INSERT INTO `shopper_region` VALUES (1821, '伊川县', 3, 184);
INSERT INTO `shopper_region` VALUES (1822, '洛阳高新技术产业开发区', 3, 184);
INSERT INTO `shopper_region` VALUES (1823, '新华区', 3, 185);
INSERT INTO `shopper_region` VALUES (1824, '卫东区', 3, 185);
INSERT INTO `shopper_region` VALUES (1825, '石龙区', 3, 185);
INSERT INTO `shopper_region` VALUES (1826, '湛河区', 3, 185);
INSERT INTO `shopper_region` VALUES (1827, '宝丰县', 3, 185);
INSERT INTO `shopper_region` VALUES (1828, '叶县', 3, 185);
INSERT INTO `shopper_region` VALUES (1829, '鲁山县', 3, 185);
INSERT INTO `shopper_region` VALUES (1830, '郏县', 3, 185);
INSERT INTO `shopper_region` VALUES (1831, '平顶山高新技术产业开发区', 3, 185);
INSERT INTO `shopper_region` VALUES (1832, '平顶山市城乡一体化示范区', 3, 185);
INSERT INTO `shopper_region` VALUES (1833, '舞钢市', 3, 185);
INSERT INTO `shopper_region` VALUES (1834, '汝州市', 3, 185);
INSERT INTO `shopper_region` VALUES (1835, '文峰区', 3, 186);
INSERT INTO `shopper_region` VALUES (1836, '北关区', 3, 186);
INSERT INTO `shopper_region` VALUES (1837, '殷都区', 3, 186);
INSERT INTO `shopper_region` VALUES (1838, '龙安区', 3, 186);
INSERT INTO `shopper_region` VALUES (1839, '安阳县', 3, 186);
INSERT INTO `shopper_region` VALUES (1840, '汤阴县', 3, 186);
INSERT INTO `shopper_region` VALUES (1841, '滑县', 3, 186);
INSERT INTO `shopper_region` VALUES (1842, '内黄县', 3, 186);
INSERT INTO `shopper_region` VALUES (1843, '安阳高新技术产业开发区', 3, 186);
INSERT INTO `shopper_region` VALUES (1844, '林州市', 3, 186);
INSERT INTO `shopper_region` VALUES (1845, '鹤山区', 3, 187);
INSERT INTO `shopper_region` VALUES (1846, '山城区', 3, 187);
INSERT INTO `shopper_region` VALUES (1847, '淇滨区', 3, 187);
INSERT INTO `shopper_region` VALUES (1848, '浚县', 3, 187);
INSERT INTO `shopper_region` VALUES (1849, '淇县', 3, 187);
INSERT INTO `shopper_region` VALUES (1850, '鹤壁经济技术开发区', 3, 187);
INSERT INTO `shopper_region` VALUES (1851, '红旗区', 3, 188);
INSERT INTO `shopper_region` VALUES (1852, '卫滨区', 3, 188);
INSERT INTO `shopper_region` VALUES (1853, '凤泉区', 3, 188);
INSERT INTO `shopper_region` VALUES (1854, '牧野区', 3, 188);
INSERT INTO `shopper_region` VALUES (1855, '新乡县', 3, 188);
INSERT INTO `shopper_region` VALUES (1856, '获嘉县', 3, 188);
INSERT INTO `shopper_region` VALUES (1857, '原阳县', 3, 188);
INSERT INTO `shopper_region` VALUES (1858, '延津县', 3, 188);
INSERT INTO `shopper_region` VALUES (1859, '封丘县', 3, 188);
INSERT INTO `shopper_region` VALUES (1860, '新乡高新技术产业开发区', 3, 188);
INSERT INTO `shopper_region` VALUES (1861, '新乡经济技术开发区', 3, 188);
INSERT INTO `shopper_region` VALUES (1862, '新乡市平原城乡一体化示范区', 3, 188);
INSERT INTO `shopper_region` VALUES (1863, '卫辉市', 3, 188);
INSERT INTO `shopper_region` VALUES (1864, '辉县市', 3, 188);
INSERT INTO `shopper_region` VALUES (1865, '长垣市', 3, 188);
INSERT INTO `shopper_region` VALUES (1866, '解放区', 3, 189);
INSERT INTO `shopper_region` VALUES (1867, '中站区', 3, 189);
INSERT INTO `shopper_region` VALUES (1868, '马村区', 3, 189);
INSERT INTO `shopper_region` VALUES (1869, '山阳区', 3, 189);
INSERT INTO `shopper_region` VALUES (1870, '修武县', 3, 189);
INSERT INTO `shopper_region` VALUES (1871, '博爱县', 3, 189);
INSERT INTO `shopper_region` VALUES (1872, '武陟县', 3, 189);
INSERT INTO `shopper_region` VALUES (1873, '温县', 3, 189);
INSERT INTO `shopper_region` VALUES (1874, '焦作城乡一体化示范区', 3, 189);
INSERT INTO `shopper_region` VALUES (1875, '沁阳市', 3, 189);
INSERT INTO `shopper_region` VALUES (1876, '孟州市', 3, 189);
INSERT INTO `shopper_region` VALUES (1877, '华龙区', 3, 190);
INSERT INTO `shopper_region` VALUES (1878, '清丰县', 3, 190);
INSERT INTO `shopper_region` VALUES (1879, '南乐县', 3, 190);
INSERT INTO `shopper_region` VALUES (1880, '范县', 3, 190);
INSERT INTO `shopper_region` VALUES (1881, '台前县', 3, 190);
INSERT INTO `shopper_region` VALUES (1882, '濮阳县', 3, 190);
INSERT INTO `shopper_region` VALUES (1883, '河南濮阳工业园区', 3, 190);
INSERT INTO `shopper_region` VALUES (1884, '濮阳经济技术开发区', 3, 190);
INSERT INTO `shopper_region` VALUES (1885, '魏都区', 3, 191);
INSERT INTO `shopper_region` VALUES (1886, '建安区', 3, 191);
INSERT INTO `shopper_region` VALUES (1887, '鄢陵县', 3, 191);
INSERT INTO `shopper_region` VALUES (1888, '襄城县', 3, 191);
INSERT INTO `shopper_region` VALUES (1889, '许昌经济技术开发区', 3, 191);
INSERT INTO `shopper_region` VALUES (1890, '禹州市', 3, 191);
INSERT INTO `shopper_region` VALUES (1891, '长葛市', 3, 191);
INSERT INTO `shopper_region` VALUES (1892, '源汇区', 3, 192);
INSERT INTO `shopper_region` VALUES (1893, '郾城区', 3, 192);
INSERT INTO `shopper_region` VALUES (1894, '召陵区', 3, 192);
INSERT INTO `shopper_region` VALUES (1895, '舞阳县', 3, 192);
INSERT INTO `shopper_region` VALUES (1896, '临颍县', 3, 192);
INSERT INTO `shopper_region` VALUES (1897, '漯河经济技术开发区', 3, 192);
INSERT INTO `shopper_region` VALUES (1898, '湖滨区', 3, 193);
INSERT INTO `shopper_region` VALUES (1899, '陕州区', 3, 193);
INSERT INTO `shopper_region` VALUES (1900, '渑池县', 3, 193);
INSERT INTO `shopper_region` VALUES (1901, '卢氏县', 3, 193);
INSERT INTO `shopper_region` VALUES (1902, '河南三门峡经济开发区', 3, 193);
INSERT INTO `shopper_region` VALUES (1903, '义马市', 3, 193);
INSERT INTO `shopper_region` VALUES (1904, '灵宝市', 3, 193);
INSERT INTO `shopper_region` VALUES (1905, '宛城区', 3, 194);
INSERT INTO `shopper_region` VALUES (1906, '卧龙区', 3, 194);
INSERT INTO `shopper_region` VALUES (1907, '南召县', 3, 194);
INSERT INTO `shopper_region` VALUES (1908, '方城县', 3, 194);
INSERT INTO `shopper_region` VALUES (1909, '西峡县', 3, 194);
INSERT INTO `shopper_region` VALUES (1910, '镇平县', 3, 194);
INSERT INTO `shopper_region` VALUES (1911, '内乡县', 3, 194);
INSERT INTO `shopper_region` VALUES (1912, '淅川县', 3, 194);
INSERT INTO `shopper_region` VALUES (1913, '社旗县', 3, 194);
INSERT INTO `shopper_region` VALUES (1914, '唐河县', 3, 194);
INSERT INTO `shopper_region` VALUES (1915, '新野县', 3, 194);
INSERT INTO `shopper_region` VALUES (1916, '桐柏县', 3, 194);
INSERT INTO `shopper_region` VALUES (1917, '南阳高新技术产业开发区', 3, 194);
INSERT INTO `shopper_region` VALUES (1918, '南阳市城乡一体化示范区', 3, 194);
INSERT INTO `shopper_region` VALUES (1919, '邓州市', 3, 194);
INSERT INTO `shopper_region` VALUES (1920, '梁园区', 3, 195);
INSERT INTO `shopper_region` VALUES (1921, '睢阳区', 3, 195);
INSERT INTO `shopper_region` VALUES (1922, '民权县', 3, 195);
INSERT INTO `shopper_region` VALUES (1923, '睢县', 3, 195);
INSERT INTO `shopper_region` VALUES (1924, '宁陵县', 3, 195);
INSERT INTO `shopper_region` VALUES (1925, '柘城县', 3, 195);
INSERT INTO `shopper_region` VALUES (1926, '虞城县', 3, 195);
INSERT INTO `shopper_region` VALUES (1927, '夏邑县', 3, 195);
INSERT INTO `shopper_region` VALUES (1928, '豫东综合物流产业聚集区', 3, 195);
INSERT INTO `shopper_region` VALUES (1929, '河南商丘经济开发区', 3, 195);
INSERT INTO `shopper_region` VALUES (1930, '永城市', 3, 195);
INSERT INTO `shopper_region` VALUES (1931, '浉河区', 3, 196);
INSERT INTO `shopper_region` VALUES (1932, '平桥区', 3, 196);
INSERT INTO `shopper_region` VALUES (1933, '罗山县', 3, 196);
INSERT INTO `shopper_region` VALUES (1934, '光山县', 3, 196);
INSERT INTO `shopper_region` VALUES (1935, '新县', 3, 196);
INSERT INTO `shopper_region` VALUES (1936, '商城县', 3, 196);
INSERT INTO `shopper_region` VALUES (1937, '固始县', 3, 196);
INSERT INTO `shopper_region` VALUES (1938, '潢川县', 3, 196);
INSERT INTO `shopper_region` VALUES (1939, '淮滨县', 3, 196);
INSERT INTO `shopper_region` VALUES (1940, '息县', 3, 196);
INSERT INTO `shopper_region` VALUES (1941, '信阳高新技术产业开发区', 3, 196);
INSERT INTO `shopper_region` VALUES (1942, '川汇区', 3, 197);
INSERT INTO `shopper_region` VALUES (1943, '淮阳区', 3, 197);
INSERT INTO `shopper_region` VALUES (1944, '扶沟县', 3, 197);
INSERT INTO `shopper_region` VALUES (1945, '西华县', 3, 197);
INSERT INTO `shopper_region` VALUES (1946, '商水县', 3, 197);
INSERT INTO `shopper_region` VALUES (1947, '沈丘县', 3, 197);
INSERT INTO `shopper_region` VALUES (1948, '郸城县', 3, 197);
INSERT INTO `shopper_region` VALUES (1949, '太康县', 3, 197);
INSERT INTO `shopper_region` VALUES (1950, '鹿邑县', 3, 197);
INSERT INTO `shopper_region` VALUES (1951, '周口临港开发区', 3, 197);
INSERT INTO `shopper_region` VALUES (1952, '项城市', 3, 197);
INSERT INTO `shopper_region` VALUES (1953, '驿城区', 3, 198);
INSERT INTO `shopper_region` VALUES (1954, '西平县', 3, 198);
INSERT INTO `shopper_region` VALUES (1955, '上蔡县', 3, 198);
INSERT INTO `shopper_region` VALUES (1956, '平舆县', 3, 198);
INSERT INTO `shopper_region` VALUES (1957, '正阳县', 3, 198);
INSERT INTO `shopper_region` VALUES (1958, '确山县', 3, 198);
INSERT INTO `shopper_region` VALUES (1959, '泌阳县', 3, 198);
INSERT INTO `shopper_region` VALUES (1960, '汝南县', 3, 198);
INSERT INTO `shopper_region` VALUES (1961, '遂平县', 3, 198);
INSERT INTO `shopper_region` VALUES (1962, '新蔡县', 3, 198);
INSERT INTO `shopper_region` VALUES (1963, '河南驻马店经济开发区', 3, 198);
INSERT INTO `shopper_region` VALUES (1964, '济源市', 3, 199);
INSERT INTO `shopper_region` VALUES (1965, '江岸区', 3, 200);
INSERT INTO `shopper_region` VALUES (1966, '江汉区', 3, 200);
INSERT INTO `shopper_region` VALUES (1967, '硚口区', 3, 200);
INSERT INTO `shopper_region` VALUES (1968, '汉阳区', 3, 200);
INSERT INTO `shopper_region` VALUES (1969, '武昌区', 3, 200);
INSERT INTO `shopper_region` VALUES (1970, '青山区', 3, 200);
INSERT INTO `shopper_region` VALUES (1971, '洪山区', 3, 200);
INSERT INTO `shopper_region` VALUES (1972, '东西湖区', 3, 200);
INSERT INTO `shopper_region` VALUES (1973, '汉南区', 3, 200);
INSERT INTO `shopper_region` VALUES (1974, '蔡甸区', 3, 200);
INSERT INTO `shopper_region` VALUES (1975, '江夏区', 3, 200);
INSERT INTO `shopper_region` VALUES (1976, '黄陂区', 3, 200);
INSERT INTO `shopper_region` VALUES (1977, '新洲区', 3, 200);
INSERT INTO `shopper_region` VALUES (1978, '黄石港区', 3, 201);
INSERT INTO `shopper_region` VALUES (1979, '西塞山区', 3, 201);
INSERT INTO `shopper_region` VALUES (1980, '下陆区', 3, 201);
INSERT INTO `shopper_region` VALUES (1981, '铁山区', 3, 201);
INSERT INTO `shopper_region` VALUES (1982, '阳新县', 3, 201);
INSERT INTO `shopper_region` VALUES (1983, '大冶市', 3, 201);
INSERT INTO `shopper_region` VALUES (1984, '茅箭区', 3, 202);
INSERT INTO `shopper_region` VALUES (1985, '张湾区', 3, 202);
INSERT INTO `shopper_region` VALUES (1986, '郧阳区', 3, 202);
INSERT INTO `shopper_region` VALUES (1987, '郧西县', 3, 202);
INSERT INTO `shopper_region` VALUES (1988, '竹山县', 3, 202);
INSERT INTO `shopper_region` VALUES (1989, '竹溪县', 3, 202);
INSERT INTO `shopper_region` VALUES (1990, '房县', 3, 202);
INSERT INTO `shopper_region` VALUES (1991, '丹江口市', 3, 202);
INSERT INTO `shopper_region` VALUES (1992, '西陵区', 3, 203);
INSERT INTO `shopper_region` VALUES (1993, '伍家岗区', 3, 203);
INSERT INTO `shopper_region` VALUES (1994, '点军区', 3, 203);
INSERT INTO `shopper_region` VALUES (1995, '猇亭区', 3, 203);
INSERT INTO `shopper_region` VALUES (1996, '夷陵区', 3, 203);
INSERT INTO `shopper_region` VALUES (1997, '远安县', 3, 203);
INSERT INTO `shopper_region` VALUES (1998, '兴山县', 3, 203);
INSERT INTO `shopper_region` VALUES (1999, '秭归县', 3, 203);
INSERT INTO `shopper_region` VALUES (2000, '长阳土家族自治县', 3, 203);
INSERT INTO `shopper_region` VALUES (2001, '五峰土家族自治县', 3, 203);
INSERT INTO `shopper_region` VALUES (2002, '宜都市', 3, 203);
INSERT INTO `shopper_region` VALUES (2003, '当阳市', 3, 203);
INSERT INTO `shopper_region` VALUES (2004, '枝江市', 3, 203);
INSERT INTO `shopper_region` VALUES (2005, '襄城区', 3, 204);
INSERT INTO `shopper_region` VALUES (2006, '樊城区', 3, 204);
INSERT INTO `shopper_region` VALUES (2007, '襄州区', 3, 204);
INSERT INTO `shopper_region` VALUES (2008, '南漳县', 3, 204);
INSERT INTO `shopper_region` VALUES (2009, '谷城县', 3, 204);
INSERT INTO `shopper_region` VALUES (2010, '保康县', 3, 204);
INSERT INTO `shopper_region` VALUES (2011, '老河口市', 3, 204);
INSERT INTO `shopper_region` VALUES (2012, '枣阳市', 3, 204);
INSERT INTO `shopper_region` VALUES (2013, '宜城市', 3, 204);
INSERT INTO `shopper_region` VALUES (2014, '梁子湖区', 3, 205);
INSERT INTO `shopper_region` VALUES (2015, '华容区', 3, 205);
INSERT INTO `shopper_region` VALUES (2016, '鄂城区', 3, 205);
INSERT INTO `shopper_region` VALUES (2017, '东宝区', 3, 206);
INSERT INTO `shopper_region` VALUES (2018, '掇刀区', 3, 206);
INSERT INTO `shopper_region` VALUES (2019, '沙洋县', 3, 206);
INSERT INTO `shopper_region` VALUES (2020, '钟祥市', 3, 206);
INSERT INTO `shopper_region` VALUES (2021, '京山市', 3, 206);
INSERT INTO `shopper_region` VALUES (2022, '孝南区', 3, 207);
INSERT INTO `shopper_region` VALUES (2023, '孝昌县', 3, 207);
INSERT INTO `shopper_region` VALUES (2024, '大悟县', 3, 207);
INSERT INTO `shopper_region` VALUES (2025, '云梦县', 3, 207);
INSERT INTO `shopper_region` VALUES (2026, '应城市', 3, 207);
INSERT INTO `shopper_region` VALUES (2027, '安陆市', 3, 207);
INSERT INTO `shopper_region` VALUES (2028, '汉川市', 3, 207);
INSERT INTO `shopper_region` VALUES (2029, '沙市区', 3, 208);
INSERT INTO `shopper_region` VALUES (2030, '荆州区', 3, 208);
INSERT INTO `shopper_region` VALUES (2031, '公安县', 3, 208);
INSERT INTO `shopper_region` VALUES (2032, '江陵县', 3, 208);
INSERT INTO `shopper_region` VALUES (2033, '荆州经济技术开发区', 3, 208);
INSERT INTO `shopper_region` VALUES (2034, '石首市', 3, 208);
INSERT INTO `shopper_region` VALUES (2035, '洪湖市', 3, 208);
INSERT INTO `shopper_region` VALUES (2036, '松滋市', 3, 208);
INSERT INTO `shopper_region` VALUES (2037, '监利市', 3, 208);
INSERT INTO `shopper_region` VALUES (2038, '黄州区', 3, 209);
INSERT INTO `shopper_region` VALUES (2039, '团风县', 3, 209);
INSERT INTO `shopper_region` VALUES (2040, '红安县', 3, 209);
INSERT INTO `shopper_region` VALUES (2041, '罗田县', 3, 209);
INSERT INTO `shopper_region` VALUES (2042, '英山县', 3, 209);
INSERT INTO `shopper_region` VALUES (2043, '浠水县', 3, 209);
INSERT INTO `shopper_region` VALUES (2044, '蕲春县', 3, 209);
INSERT INTO `shopper_region` VALUES (2045, '黄梅县', 3, 209);
INSERT INTO `shopper_region` VALUES (2046, '龙感湖管理区', 3, 209);
INSERT INTO `shopper_region` VALUES (2047, '麻城市', 3, 209);
INSERT INTO `shopper_region` VALUES (2048, '武穴市', 3, 209);
INSERT INTO `shopper_region` VALUES (2049, '咸安区', 3, 210);
INSERT INTO `shopper_region` VALUES (2050, '嘉鱼县', 3, 210);
INSERT INTO `shopper_region` VALUES (2051, '通城县', 3, 210);
INSERT INTO `shopper_region` VALUES (2052, '崇阳县', 3, 210);
INSERT INTO `shopper_region` VALUES (2053, '通山县', 3, 210);
INSERT INTO `shopper_region` VALUES (2054, '赤壁市', 3, 210);
INSERT INTO `shopper_region` VALUES (2055, '曾都区', 3, 211);
INSERT INTO `shopper_region` VALUES (2056, '随县', 3, 211);
INSERT INTO `shopper_region` VALUES (2057, '广水市', 3, 211);
INSERT INTO `shopper_region` VALUES (2058, '恩施市', 3, 212);
INSERT INTO `shopper_region` VALUES (2059, '利川市', 3, 212);
INSERT INTO `shopper_region` VALUES (2060, '建始县', 3, 212);
INSERT INTO `shopper_region` VALUES (2061, '巴东县', 3, 212);
INSERT INTO `shopper_region` VALUES (2062, '宣恩县', 3, 212);
INSERT INTO `shopper_region` VALUES (2063, '咸丰县', 3, 212);
INSERT INTO `shopper_region` VALUES (2064, '来凤县', 3, 212);
INSERT INTO `shopper_region` VALUES (2065, '鹤峰县', 3, 212);
INSERT INTO `shopper_region` VALUES (2066, '仙桃市', 3, 213);
INSERT INTO `shopper_region` VALUES (2067, '潜江市', 3, 213);
INSERT INTO `shopper_region` VALUES (2068, '天门市', 3, 213);
INSERT INTO `shopper_region` VALUES (2069, '神农架林区', 3, 213);
INSERT INTO `shopper_region` VALUES (2070, '芙蓉区', 3, 214);
INSERT INTO `shopper_region` VALUES (2071, '天心区', 3, 214);
INSERT INTO `shopper_region` VALUES (2072, '岳麓区', 3, 214);
INSERT INTO `shopper_region` VALUES (2073, '开福区', 3, 214);
INSERT INTO `shopper_region` VALUES (2074, '雨花区', 3, 214);
INSERT INTO `shopper_region` VALUES (2075, '望城区', 3, 214);
INSERT INTO `shopper_region` VALUES (2076, '长沙县', 3, 214);
INSERT INTO `shopper_region` VALUES (2077, '浏阳市', 3, 214);
INSERT INTO `shopper_region` VALUES (2078, '宁乡市', 3, 214);
INSERT INTO `shopper_region` VALUES (2079, '荷塘区', 3, 215);
INSERT INTO `shopper_region` VALUES (2080, '芦淞区', 3, 215);
INSERT INTO `shopper_region` VALUES (2081, '石峰区', 3, 215);
INSERT INTO `shopper_region` VALUES (2082, '天元区', 3, 215);
INSERT INTO `shopper_region` VALUES (2083, '渌口区', 3, 215);
INSERT INTO `shopper_region` VALUES (2084, '攸县', 3, 215);
INSERT INTO `shopper_region` VALUES (2085, '茶陵县', 3, 215);
INSERT INTO `shopper_region` VALUES (2086, '炎陵县', 3, 215);
INSERT INTO `shopper_region` VALUES (2087, '醴陵市', 3, 215);
INSERT INTO `shopper_region` VALUES (2088, '雨湖区', 3, 216);
INSERT INTO `shopper_region` VALUES (2089, '岳塘区', 3, 216);
INSERT INTO `shopper_region` VALUES (2090, '湘潭县', 3, 216);
INSERT INTO `shopper_region` VALUES (2091, '湖南湘潭高新技术产业园区', 3, 216);
INSERT INTO `shopper_region` VALUES (2092, '湘潭昭山示范区', 3, 216);
INSERT INTO `shopper_region` VALUES (2093, '湘潭九华示范区', 3, 216);
INSERT INTO `shopper_region` VALUES (2094, '湘乡市', 3, 216);
INSERT INTO `shopper_region` VALUES (2095, '韶山市', 3, 216);
INSERT INTO `shopper_region` VALUES (2096, '珠晖区', 3, 217);
INSERT INTO `shopper_region` VALUES (2097, '雁峰区', 3, 217);
INSERT INTO `shopper_region` VALUES (2098, '石鼓区', 3, 217);
INSERT INTO `shopper_region` VALUES (2099, '蒸湘区', 3, 217);
INSERT INTO `shopper_region` VALUES (2100, '南岳区', 3, 217);
INSERT INTO `shopper_region` VALUES (2101, '衡阳县', 3, 217);
INSERT INTO `shopper_region` VALUES (2102, '衡南县', 3, 217);
INSERT INTO `shopper_region` VALUES (2103, '衡山县', 3, 217);
INSERT INTO `shopper_region` VALUES (2104, '衡东县', 3, 217);
INSERT INTO `shopper_region` VALUES (2105, '祁东县', 3, 217);
INSERT INTO `shopper_region` VALUES (2106, '湖南衡阳松木经济开发区', 3, 217);
INSERT INTO `shopper_region` VALUES (2107, '湖南衡阳高新技术产业园区', 3, 217);
INSERT INTO `shopper_region` VALUES (2108, '耒阳市', 3, 217);
INSERT INTO `shopper_region` VALUES (2109, '常宁市', 3, 217);
INSERT INTO `shopper_region` VALUES (2110, '双清区', 3, 218);
INSERT INTO `shopper_region` VALUES (2111, '大祥区', 3, 218);
INSERT INTO `shopper_region` VALUES (2112, '北塔区', 3, 218);
INSERT INTO `shopper_region` VALUES (2113, '新邵县', 3, 218);
INSERT INTO `shopper_region` VALUES (2114, '邵阳县', 3, 218);
INSERT INTO `shopper_region` VALUES (2115, '隆回县', 3, 218);
INSERT INTO `shopper_region` VALUES (2116, '洞口县', 3, 218);
INSERT INTO `shopper_region` VALUES (2117, '绥宁县', 3, 218);
INSERT INTO `shopper_region` VALUES (2118, '新宁县', 3, 218);
INSERT INTO `shopper_region` VALUES (2119, '城步苗族自治县', 3, 218);
INSERT INTO `shopper_region` VALUES (2120, '武冈市', 3, 218);
INSERT INTO `shopper_region` VALUES (2121, '邵东市', 3, 218);
INSERT INTO `shopper_region` VALUES (2122, '岳阳楼区', 3, 219);
INSERT INTO `shopper_region` VALUES (2123, '云溪区', 3, 219);
INSERT INTO `shopper_region` VALUES (2124, '君山区', 3, 219);
INSERT INTO `shopper_region` VALUES (2125, '岳阳县', 3, 219);
INSERT INTO `shopper_region` VALUES (2126, '华容县', 3, 219);
INSERT INTO `shopper_region` VALUES (2127, '湘阴县', 3, 219);
INSERT INTO `shopper_region` VALUES (2128, '平江县', 3, 219);
INSERT INTO `shopper_region` VALUES (2129, '岳阳市屈原管理区', 3, 219);
INSERT INTO `shopper_region` VALUES (2130, '汨罗市', 3, 219);
INSERT INTO `shopper_region` VALUES (2131, '临湘市', 3, 219);
INSERT INTO `shopper_region` VALUES (2132, '武陵区', 3, 220);
INSERT INTO `shopper_region` VALUES (2133, '鼎城区', 3, 220);
INSERT INTO `shopper_region` VALUES (2134, '安乡县', 3, 220);
INSERT INTO `shopper_region` VALUES (2135, '汉寿县', 3, 220);
INSERT INTO `shopper_region` VALUES (2136, '澧县', 3, 220);
INSERT INTO `shopper_region` VALUES (2137, '临澧县', 3, 220);
INSERT INTO `shopper_region` VALUES (2138, '桃源县', 3, 220);
INSERT INTO `shopper_region` VALUES (2139, '石门县', 3, 220);
INSERT INTO `shopper_region` VALUES (2140, '常德市西洞庭管理区', 3, 220);
INSERT INTO `shopper_region` VALUES (2141, '津市市', 3, 220);
INSERT INTO `shopper_region` VALUES (2142, '永定区', 3, 221);
INSERT INTO `shopper_region` VALUES (2143, '武陵源区', 3, 221);
INSERT INTO `shopper_region` VALUES (2144, '慈利县', 3, 221);
INSERT INTO `shopper_region` VALUES (2145, '桑植县', 3, 221);
INSERT INTO `shopper_region` VALUES (2146, '资阳区', 3, 222);
INSERT INTO `shopper_region` VALUES (2147, '赫山区', 3, 222);
INSERT INTO `shopper_region` VALUES (2148, '南县', 3, 222);
INSERT INTO `shopper_region` VALUES (2149, '桃江县', 3, 222);
INSERT INTO `shopper_region` VALUES (2150, '安化县', 3, 222);
INSERT INTO `shopper_region` VALUES (2151, '益阳市大通湖管理区', 3, 222);
INSERT INTO `shopper_region` VALUES (2152, '湖南益阳高新技术产业园区', 3, 222);
INSERT INTO `shopper_region` VALUES (2153, '沅江市', 3, 222);
INSERT INTO `shopper_region` VALUES (2154, '北湖区', 3, 223);
INSERT INTO `shopper_region` VALUES (2155, '苏仙区', 3, 223);
INSERT INTO `shopper_region` VALUES (2156, '桂阳县', 3, 223);
INSERT INTO `shopper_region` VALUES (2157, '宜章县', 3, 223);
INSERT INTO `shopper_region` VALUES (2158, '永兴县', 3, 223);
INSERT INTO `shopper_region` VALUES (2159, '嘉禾县', 3, 223);
INSERT INTO `shopper_region` VALUES (2160, '临武县', 3, 223);
INSERT INTO `shopper_region` VALUES (2161, '汝城县', 3, 223);
INSERT INTO `shopper_region` VALUES (2162, '桂东县', 3, 223);
INSERT INTO `shopper_region` VALUES (2163, '安仁县', 3, 223);
INSERT INTO `shopper_region` VALUES (2164, '资兴市', 3, 223);
INSERT INTO `shopper_region` VALUES (2165, '零陵区', 3, 224);
INSERT INTO `shopper_region` VALUES (2166, '冷水滩区', 3, 224);
INSERT INTO `shopper_region` VALUES (2167, '东安县', 3, 224);
INSERT INTO `shopper_region` VALUES (2168, '双牌县', 3, 224);
INSERT INTO `shopper_region` VALUES (2169, '道县', 3, 224);
INSERT INTO `shopper_region` VALUES (2170, '江永县', 3, 224);
INSERT INTO `shopper_region` VALUES (2171, '宁远县', 3, 224);
INSERT INTO `shopper_region` VALUES (2172, '蓝山县', 3, 224);
INSERT INTO `shopper_region` VALUES (2173, '新田县', 3, 224);
INSERT INTO `shopper_region` VALUES (2174, '江华瑶族自治县', 3, 224);
INSERT INTO `shopper_region` VALUES (2175, '永州经济技术开发区', 3, 224);
INSERT INTO `shopper_region` VALUES (2176, '永州市回龙圩管理区', 3, 224);
INSERT INTO `shopper_region` VALUES (2177, '祁阳市', 3, 224);
INSERT INTO `shopper_region` VALUES (2178, '鹤城区', 3, 225);
INSERT INTO `shopper_region` VALUES (2179, '中方县', 3, 225);
INSERT INTO `shopper_region` VALUES (2180, '沅陵县', 3, 225);
INSERT INTO `shopper_region` VALUES (2181, '辰溪县', 3, 225);
INSERT INTO `shopper_region` VALUES (2182, '溆浦县', 3, 225);
INSERT INTO `shopper_region` VALUES (2183, '会同县', 3, 225);
INSERT INTO `shopper_region` VALUES (2184, '麻阳苗族自治县', 3, 225);
INSERT INTO `shopper_region` VALUES (2185, '新晃侗族自治县', 3, 225);
INSERT INTO `shopper_region` VALUES (2186, '芷江侗族自治县', 3, 225);
INSERT INTO `shopper_region` VALUES (2187, '靖州苗族侗族自治县', 3, 225);
INSERT INTO `shopper_region` VALUES (2188, '通道侗族自治县', 3, 225);
INSERT INTO `shopper_region` VALUES (2189, '怀化市洪江管理区', 3, 225);
INSERT INTO `shopper_region` VALUES (2190, '洪江市', 3, 225);
INSERT INTO `shopper_region` VALUES (2191, '娄星区', 3, 226);
INSERT INTO `shopper_region` VALUES (2192, '双峰县', 3, 226);
INSERT INTO `shopper_region` VALUES (2193, '新化县', 3, 226);
INSERT INTO `shopper_region` VALUES (2194, '冷水江市', 3, 226);
INSERT INTO `shopper_region` VALUES (2195, '涟源市', 3, 226);
INSERT INTO `shopper_region` VALUES (2196, '吉首市', 3, 227);
INSERT INTO `shopper_region` VALUES (2197, '泸溪县', 3, 227);
INSERT INTO `shopper_region` VALUES (2198, '凤凰县', 3, 227);
INSERT INTO `shopper_region` VALUES (2199, '花垣县', 3, 227);
INSERT INTO `shopper_region` VALUES (2200, '保靖县', 3, 227);
INSERT INTO `shopper_region` VALUES (2201, '古丈县', 3, 227);
INSERT INTO `shopper_region` VALUES (2202, '永顺县', 3, 227);
INSERT INTO `shopper_region` VALUES (2203, '龙山县', 3, 227);
INSERT INTO `shopper_region` VALUES (2204, '荔湾区', 3, 228);
INSERT INTO `shopper_region` VALUES (2205, '越秀区', 3, 228);
INSERT INTO `shopper_region` VALUES (2206, '海珠区', 3, 228);
INSERT INTO `shopper_region` VALUES (2207, '天河区', 3, 228);
INSERT INTO `shopper_region` VALUES (2208, '白云区', 3, 228);
INSERT INTO `shopper_region` VALUES (2209, '黄埔区', 3, 228);
INSERT INTO `shopper_region` VALUES (2210, '番禺区', 3, 228);
INSERT INTO `shopper_region` VALUES (2211, '花都区', 3, 228);
INSERT INTO `shopper_region` VALUES (2212, '南沙区', 3, 228);
INSERT INTO `shopper_region` VALUES (2213, '从化区', 3, 228);
INSERT INTO `shopper_region` VALUES (2214, '增城区', 3, 228);
INSERT INTO `shopper_region` VALUES (2215, '武江区', 3, 229);
INSERT INTO `shopper_region` VALUES (2216, '浈江区', 3, 229);
INSERT INTO `shopper_region` VALUES (2217, '曲江区', 3, 229);
INSERT INTO `shopper_region` VALUES (2218, '始兴县', 3, 229);
INSERT INTO `shopper_region` VALUES (2219, '仁化县', 3, 229);
INSERT INTO `shopper_region` VALUES (2220, '翁源县', 3, 229);
INSERT INTO `shopper_region` VALUES (2221, '乳源瑶族自治县', 3, 229);
INSERT INTO `shopper_region` VALUES (2222, '新丰县', 3, 229);
INSERT INTO `shopper_region` VALUES (2223, '乐昌市', 3, 229);
INSERT INTO `shopper_region` VALUES (2224, '南雄市', 3, 229);
INSERT INTO `shopper_region` VALUES (2225, '罗湖区', 3, 230);
INSERT INTO `shopper_region` VALUES (2226, '福田区', 3, 230);
INSERT INTO `shopper_region` VALUES (2227, '南山区', 3, 230);
INSERT INTO `shopper_region` VALUES (2228, '宝安区', 3, 230);
INSERT INTO `shopper_region` VALUES (2229, '龙岗区', 3, 230);
INSERT INTO `shopper_region` VALUES (2230, '盐田区', 3, 230);
INSERT INTO `shopper_region` VALUES (2231, '龙华区', 3, 230);
INSERT INTO `shopper_region` VALUES (2232, '坪山区', 3, 230);
INSERT INTO `shopper_region` VALUES (2233, '光明区', 3, 230);
INSERT INTO `shopper_region` VALUES (2234, '香洲区', 3, 231);
INSERT INTO `shopper_region` VALUES (2235, '斗门区', 3, 231);
INSERT INTO `shopper_region` VALUES (2236, '金湾区', 3, 231);
INSERT INTO `shopper_region` VALUES (2237, '龙湖区', 3, 232);
INSERT INTO `shopper_region` VALUES (2238, '金平区', 3, 232);
INSERT INTO `shopper_region` VALUES (2239, '濠江区', 3, 232);
INSERT INTO `shopper_region` VALUES (2240, '潮阳区', 3, 232);
INSERT INTO `shopper_region` VALUES (2241, '潮南区', 3, 232);
INSERT INTO `shopper_region` VALUES (2242, '澄海区', 3, 232);
INSERT INTO `shopper_region` VALUES (2243, '南澳县', 3, 232);
INSERT INTO `shopper_region` VALUES (2244, '禅城区', 3, 233);
INSERT INTO `shopper_region` VALUES (2245, '南海区', 3, 233);
INSERT INTO `shopper_region` VALUES (2246, '顺德区', 3, 233);
INSERT INTO `shopper_region` VALUES (2247, '三水区', 3, 233);
INSERT INTO `shopper_region` VALUES (2248, '高明区', 3, 233);
INSERT INTO `shopper_region` VALUES (2249, '蓬江区', 3, 234);
INSERT INTO `shopper_region` VALUES (2250, '江海区', 3, 234);
INSERT INTO `shopper_region` VALUES (2251, '新会区', 3, 234);
INSERT INTO `shopper_region` VALUES (2252, '台山市', 3, 234);
INSERT INTO `shopper_region` VALUES (2253, '开平市', 3, 234);
INSERT INTO `shopper_region` VALUES (2254, '鹤山市', 3, 234);
INSERT INTO `shopper_region` VALUES (2255, '恩平市', 3, 234);
INSERT INTO `shopper_region` VALUES (2256, '赤坎区', 3, 235);
INSERT INTO `shopper_region` VALUES (2257, '霞山区', 3, 235);
INSERT INTO `shopper_region` VALUES (2258, '坡头区', 3, 235);
INSERT INTO `shopper_region` VALUES (2259, '麻章区', 3, 235);
INSERT INTO `shopper_region` VALUES (2260, '遂溪县', 3, 235);
INSERT INTO `shopper_region` VALUES (2261, '徐闻县', 3, 235);
INSERT INTO `shopper_region` VALUES (2262, '廉江市', 3, 235);
INSERT INTO `shopper_region` VALUES (2263, '雷州市', 3, 235);
INSERT INTO `shopper_region` VALUES (2264, '吴川市', 3, 235);
INSERT INTO `shopper_region` VALUES (2265, '茂南区', 3, 236);
INSERT INTO `shopper_region` VALUES (2266, '电白区', 3, 236);
INSERT INTO `shopper_region` VALUES (2267, '高州市', 3, 236);
INSERT INTO `shopper_region` VALUES (2268, '化州市', 3, 236);
INSERT INTO `shopper_region` VALUES (2269, '信宜市', 3, 236);
INSERT INTO `shopper_region` VALUES (2270, '端州区', 3, 237);
INSERT INTO `shopper_region` VALUES (2271, '鼎湖区', 3, 237);
INSERT INTO `shopper_region` VALUES (2272, '高要区', 3, 237);
INSERT INTO `shopper_region` VALUES (2273, '广宁县', 3, 237);
INSERT INTO `shopper_region` VALUES (2274, '怀集县', 3, 237);
INSERT INTO `shopper_region` VALUES (2275, '封开县', 3, 237);
INSERT INTO `shopper_region` VALUES (2276, '德庆县', 3, 237);
INSERT INTO `shopper_region` VALUES (2277, '四会市', 3, 237);
INSERT INTO `shopper_region` VALUES (2278, '惠城区', 3, 238);
INSERT INTO `shopper_region` VALUES (2279, '惠阳区', 3, 238);
INSERT INTO `shopper_region` VALUES (2280, '博罗县', 3, 238);
INSERT INTO `shopper_region` VALUES (2281, '惠东县', 3, 238);
INSERT INTO `shopper_region` VALUES (2282, '龙门县', 3, 238);
INSERT INTO `shopper_region` VALUES (2283, '梅江区', 3, 239);
INSERT INTO `shopper_region` VALUES (2284, '梅县区', 3, 239);
INSERT INTO `shopper_region` VALUES (2285, '大埔县', 3, 239);
INSERT INTO `shopper_region` VALUES (2286, '丰顺县', 3, 239);
INSERT INTO `shopper_region` VALUES (2287, '五华县', 3, 239);
INSERT INTO `shopper_region` VALUES (2288, '平远县', 3, 239);
INSERT INTO `shopper_region` VALUES (2289, '蕉岭县', 3, 239);
INSERT INTO `shopper_region` VALUES (2290, '兴宁市', 3, 239);
INSERT INTO `shopper_region` VALUES (2291, '城区', 3, 240);
INSERT INTO `shopper_region` VALUES (2292, '海丰县', 3, 240);
INSERT INTO `shopper_region` VALUES (2293, '陆河县', 3, 240);
INSERT INTO `shopper_region` VALUES (2294, '陆丰市', 3, 240);
INSERT INTO `shopper_region` VALUES (2295, '源城区', 3, 241);
INSERT INTO `shopper_region` VALUES (2296, '紫金县', 3, 241);
INSERT INTO `shopper_region` VALUES (2297, '龙川县', 3, 241);
INSERT INTO `shopper_region` VALUES (2298, '连平县', 3, 241);
INSERT INTO `shopper_region` VALUES (2299, '和平县', 3, 241);
INSERT INTO `shopper_region` VALUES (2300, '东源县', 3, 241);
INSERT INTO `shopper_region` VALUES (2301, '江城区', 3, 242);
INSERT INTO `shopper_region` VALUES (2302, '阳东区', 3, 242);
INSERT INTO `shopper_region` VALUES (2303, '阳西县', 3, 242);
INSERT INTO `shopper_region` VALUES (2304, '阳春市', 3, 242);
INSERT INTO `shopper_region` VALUES (2305, '清城区', 3, 243);
INSERT INTO `shopper_region` VALUES (2306, '清新区', 3, 243);
INSERT INTO `shopper_region` VALUES (2307, '佛冈县', 3, 243);
INSERT INTO `shopper_region` VALUES (2308, '阳山县', 3, 243);
INSERT INTO `shopper_region` VALUES (2309, '连山壮族瑶族自治县', 3, 243);
INSERT INTO `shopper_region` VALUES (2310, '连南瑶族自治县', 3, 243);
INSERT INTO `shopper_region` VALUES (2311, '英德市', 3, 243);
INSERT INTO `shopper_region` VALUES (2312, '连州市', 3, 243);
INSERT INTO `shopper_region` VALUES (2313, '湘桥区', 3, 246);
INSERT INTO `shopper_region` VALUES (2314, '潮安区', 3, 246);
INSERT INTO `shopper_region` VALUES (2315, '饶平县', 3, 246);
INSERT INTO `shopper_region` VALUES (2316, '榕城区', 3, 247);
INSERT INTO `shopper_region` VALUES (2317, '揭东区', 3, 247);
INSERT INTO `shopper_region` VALUES (2318, '揭西县', 3, 247);
INSERT INTO `shopper_region` VALUES (2319, '惠来县', 3, 247);
INSERT INTO `shopper_region` VALUES (2320, '普宁市', 3, 247);
INSERT INTO `shopper_region` VALUES (2321, '云城区', 3, 248);
INSERT INTO `shopper_region` VALUES (2322, '云安区', 3, 248);
INSERT INTO `shopper_region` VALUES (2323, '新兴县', 3, 248);
INSERT INTO `shopper_region` VALUES (2324, '郁南县', 3, 248);
INSERT INTO `shopper_region` VALUES (2325, '罗定市', 3, 248);
INSERT INTO `shopper_region` VALUES (2326, '兴宁区', 3, 249);
INSERT INTO `shopper_region` VALUES (2327, '青秀区', 3, 249);
INSERT INTO `shopper_region` VALUES (2328, '江南区', 3, 249);
INSERT INTO `shopper_region` VALUES (2329, '西乡塘区', 3, 249);
INSERT INTO `shopper_region` VALUES (2330, '良庆区', 3, 249);
INSERT INTO `shopper_region` VALUES (2331, '邕宁区', 3, 249);
INSERT INTO `shopper_region` VALUES (2332, '武鸣区', 3, 249);
INSERT INTO `shopper_region` VALUES (2333, '隆安县', 3, 249);
INSERT INTO `shopper_region` VALUES (2334, '马山县', 3, 249);
INSERT INTO `shopper_region` VALUES (2335, '上林县', 3, 249);
INSERT INTO `shopper_region` VALUES (2336, '宾阳县', 3, 249);
INSERT INTO `shopper_region` VALUES (2337, '横州市', 3, 249);
INSERT INTO `shopper_region` VALUES (2338, '城中区', 3, 250);
INSERT INTO `shopper_region` VALUES (2339, '鱼峰区', 3, 250);
INSERT INTO `shopper_region` VALUES (2340, '柳南区', 3, 250);
INSERT INTO `shopper_region` VALUES (2341, '柳北区', 3, 250);
INSERT INTO `shopper_region` VALUES (2342, '柳江区', 3, 250);
INSERT INTO `shopper_region` VALUES (2343, '柳城县', 3, 250);
INSERT INTO `shopper_region` VALUES (2344, '鹿寨县', 3, 250);
INSERT INTO `shopper_region` VALUES (2345, '融安县', 3, 250);
INSERT INTO `shopper_region` VALUES (2346, '融水苗族自治县', 3, 250);
INSERT INTO `shopper_region` VALUES (2347, '三江侗族自治县', 3, 250);
INSERT INTO `shopper_region` VALUES (2348, '秀峰区', 3, 251);
INSERT INTO `shopper_region` VALUES (2349, '叠彩区', 3, 251);
INSERT INTO `shopper_region` VALUES (2350, '象山区', 3, 251);
INSERT INTO `shopper_region` VALUES (2351, '七星区', 3, 251);
INSERT INTO `shopper_region` VALUES (2352, '雁山区', 3, 251);
INSERT INTO `shopper_region` VALUES (2353, '临桂区', 3, 251);
INSERT INTO `shopper_region` VALUES (2354, '阳朔县', 3, 251);
INSERT INTO `shopper_region` VALUES (2355, '灵川县', 3, 251);
INSERT INTO `shopper_region` VALUES (2356, '全州县', 3, 251);
INSERT INTO `shopper_region` VALUES (2357, '兴安县', 3, 251);
INSERT INTO `shopper_region` VALUES (2358, '永福县', 3, 251);
INSERT INTO `shopper_region` VALUES (2359, '灌阳县', 3, 251);
INSERT INTO `shopper_region` VALUES (2360, '龙胜各族自治县', 3, 251);
INSERT INTO `shopper_region` VALUES (2361, '资源县', 3, 251);
INSERT INTO `shopper_region` VALUES (2362, '平乐县', 3, 251);
INSERT INTO `shopper_region` VALUES (2363, '恭城瑶族自治县', 3, 251);
INSERT INTO `shopper_region` VALUES (2364, '荔浦市', 3, 251);
INSERT INTO `shopper_region` VALUES (2365, '万秀区', 3, 252);
INSERT INTO `shopper_region` VALUES (2366, '长洲区', 3, 252);
INSERT INTO `shopper_region` VALUES (2367, '龙圩区', 3, 252);
INSERT INTO `shopper_region` VALUES (2368, '苍梧县', 3, 252);
INSERT INTO `shopper_region` VALUES (2369, '藤县', 3, 252);
INSERT INTO `shopper_region` VALUES (2370, '蒙山县', 3, 252);
INSERT INTO `shopper_region` VALUES (2371, '岑溪市', 3, 252);
INSERT INTO `shopper_region` VALUES (2372, '海城区', 3, 253);
INSERT INTO `shopper_region` VALUES (2373, '银海区', 3, 253);
INSERT INTO `shopper_region` VALUES (2374, '铁山港区', 3, 253);
INSERT INTO `shopper_region` VALUES (2375, '合浦县', 3, 253);
INSERT INTO `shopper_region` VALUES (2376, '港口区', 3, 254);
INSERT INTO `shopper_region` VALUES (2377, '防城区', 3, 254);
INSERT INTO `shopper_region` VALUES (2378, '上思县', 3, 254);
INSERT INTO `shopper_region` VALUES (2379, '东兴市', 3, 254);
INSERT INTO `shopper_region` VALUES (2380, '钦南区', 3, 255);
INSERT INTO `shopper_region` VALUES (2381, '钦北区', 3, 255);
INSERT INTO `shopper_region` VALUES (2382, '灵山县', 3, 255);
INSERT INTO `shopper_region` VALUES (2383, '浦北县', 3, 255);
INSERT INTO `shopper_region` VALUES (2384, '港北区', 3, 256);
INSERT INTO `shopper_region` VALUES (2385, '港南区', 3, 256);
INSERT INTO `shopper_region` VALUES (2386, '覃塘区', 3, 256);
INSERT INTO `shopper_region` VALUES (2387, '平南县', 3, 256);
INSERT INTO `shopper_region` VALUES (2388, '桂平市', 3, 256);
INSERT INTO `shopper_region` VALUES (2389, '玉州区', 3, 257);
INSERT INTO `shopper_region` VALUES (2390, '福绵区', 3, 257);
INSERT INTO `shopper_region` VALUES (2391, '容县', 3, 257);
INSERT INTO `shopper_region` VALUES (2392, '陆川县', 3, 257);
INSERT INTO `shopper_region` VALUES (2393, '博白县', 3, 257);
INSERT INTO `shopper_region` VALUES (2394, '兴业县', 3, 257);
INSERT INTO `shopper_region` VALUES (2395, '北流市', 3, 257);
INSERT INTO `shopper_region` VALUES (2396, '右江区', 3, 258);
INSERT INTO `shopper_region` VALUES (2397, '田阳区', 3, 258);
INSERT INTO `shopper_region` VALUES (2398, '田东县', 3, 258);
INSERT INTO `shopper_region` VALUES (2399, '德保县', 3, 258);
INSERT INTO `shopper_region` VALUES (2400, '那坡县', 3, 258);
INSERT INTO `shopper_region` VALUES (2401, '凌云县', 3, 258);
INSERT INTO `shopper_region` VALUES (2402, '乐业县', 3, 258);
INSERT INTO `shopper_region` VALUES (2403, '田林县', 3, 258);
INSERT INTO `shopper_region` VALUES (2404, '西林县', 3, 258);
INSERT INTO `shopper_region` VALUES (2405, '隆林各族自治县', 3, 258);
INSERT INTO `shopper_region` VALUES (2406, '靖西市', 3, 258);
INSERT INTO `shopper_region` VALUES (2407, '平果市', 3, 258);
INSERT INTO `shopper_region` VALUES (2408, '八步区', 3, 259);
INSERT INTO `shopper_region` VALUES (2409, '平桂区', 3, 259);
INSERT INTO `shopper_region` VALUES (2410, '昭平县', 3, 259);
INSERT INTO `shopper_region` VALUES (2411, '钟山县', 3, 259);
INSERT INTO `shopper_region` VALUES (2412, '富川瑶族自治县', 3, 259);
INSERT INTO `shopper_region` VALUES (2413, '金城江区', 3, 260);
INSERT INTO `shopper_region` VALUES (2414, '宜州区', 3, 260);
INSERT INTO `shopper_region` VALUES (2415, '南丹县', 3, 260);
INSERT INTO `shopper_region` VALUES (2416, '天峨县', 3, 260);
INSERT INTO `shopper_region` VALUES (2417, '凤山县', 3, 260);
INSERT INTO `shopper_region` VALUES (2418, '东兰县', 3, 260);
INSERT INTO `shopper_region` VALUES (2419, '罗城仫佬族自治县', 3, 260);
INSERT INTO `shopper_region` VALUES (2420, '环江毛南族自治县', 3, 260);
INSERT INTO `shopper_region` VALUES (2421, '巴马瑶族自治县', 3, 260);
INSERT INTO `shopper_region` VALUES (2422, '都安瑶族自治县', 3, 260);
INSERT INTO `shopper_region` VALUES (2423, '大化瑶族自治县', 3, 260);
INSERT INTO `shopper_region` VALUES (2424, '兴宾区', 3, 261);
INSERT INTO `shopper_region` VALUES (2425, '忻城县', 3, 261);
INSERT INTO `shopper_region` VALUES (2426, '象州县', 3, 261);
INSERT INTO `shopper_region` VALUES (2427, '武宣县', 3, 261);
INSERT INTO `shopper_region` VALUES (2428, '金秀瑶族自治县', 3, 261);
INSERT INTO `shopper_region` VALUES (2429, '合山市', 3, 261);
INSERT INTO `shopper_region` VALUES (2430, '江州区', 3, 262);
INSERT INTO `shopper_region` VALUES (2431, '扶绥县', 3, 262);
INSERT INTO `shopper_region` VALUES (2432, '宁明县', 3, 262);
INSERT INTO `shopper_region` VALUES (2433, '龙州县', 3, 262);
INSERT INTO `shopper_region` VALUES (2434, '大新县', 3, 262);
INSERT INTO `shopper_region` VALUES (2435, '天等县', 3, 262);
INSERT INTO `shopper_region` VALUES (2436, '凭祥市', 3, 262);
INSERT INTO `shopper_region` VALUES (2437, '秀英区', 3, 263);
INSERT INTO `shopper_region` VALUES (2438, '龙华区', 3, 263);
INSERT INTO `shopper_region` VALUES (2439, '琼山区', 3, 263);
INSERT INTO `shopper_region` VALUES (2440, '美兰区', 3, 263);
INSERT INTO `shopper_region` VALUES (2441, '海棠区', 3, 264);
INSERT INTO `shopper_region` VALUES (2442, '吉阳区', 3, 264);
INSERT INTO `shopper_region` VALUES (2443, '天涯区', 3, 264);
INSERT INTO `shopper_region` VALUES (2444, '崖州区', 3, 264);
INSERT INTO `shopper_region` VALUES (2445, '西沙群岛', 3, 265);
INSERT INTO `shopper_region` VALUES (2446, '南沙群岛', 3, 265);
INSERT INTO `shopper_region` VALUES (2447, '中沙群岛的岛礁及其海域', 3, 265);
INSERT INTO `shopper_region` VALUES (2448, '五指山市', 3, 267);
INSERT INTO `shopper_region` VALUES (2449, '琼海市', 3, 267);
INSERT INTO `shopper_region` VALUES (2450, '文昌市', 3, 267);
INSERT INTO `shopper_region` VALUES (2451, '万宁市', 3, 267);
INSERT INTO `shopper_region` VALUES (2452, '东方市', 3, 267);
INSERT INTO `shopper_region` VALUES (2453, '定安县', 3, 267);
INSERT INTO `shopper_region` VALUES (2454, '屯昌县', 3, 267);
INSERT INTO `shopper_region` VALUES (2455, '澄迈县', 3, 267);
INSERT INTO `shopper_region` VALUES (2456, '临高县', 3, 267);
INSERT INTO `shopper_region` VALUES (2457, '白沙黎族自治县', 3, 267);
INSERT INTO `shopper_region` VALUES (2458, '昌江黎族自治县', 3, 267);
INSERT INTO `shopper_region` VALUES (2459, '乐东黎族自治县', 3, 267);
INSERT INTO `shopper_region` VALUES (2460, '陵水黎族自治县', 3, 267);
INSERT INTO `shopper_region` VALUES (2461, '保亭黎族苗族自治县', 3, 267);
INSERT INTO `shopper_region` VALUES (2462, '琼中黎族苗族自治县', 3, 267);
INSERT INTO `shopper_region` VALUES (2463, '万州区', 3, 268);
INSERT INTO `shopper_region` VALUES (2464, '涪陵区', 3, 268);
INSERT INTO `shopper_region` VALUES (2465, '渝中区', 3, 268);
INSERT INTO `shopper_region` VALUES (2466, '大渡口区', 3, 268);
INSERT INTO `shopper_region` VALUES (2467, '江北区', 3, 268);
INSERT INTO `shopper_region` VALUES (2468, '沙坪坝区', 3, 268);
INSERT INTO `shopper_region` VALUES (2469, '九龙坡区', 3, 268);
INSERT INTO `shopper_region` VALUES (2470, '南岸区', 3, 268);
INSERT INTO `shopper_region` VALUES (2471, '北碚区', 3, 268);
INSERT INTO `shopper_region` VALUES (2472, '綦江区', 3, 268);
INSERT INTO `shopper_region` VALUES (2473, '大足区', 3, 268);
INSERT INTO `shopper_region` VALUES (2474, '渝北区', 3, 268);
INSERT INTO `shopper_region` VALUES (2475, '巴南区', 3, 268);
INSERT INTO `shopper_region` VALUES (2476, '黔江区', 3, 268);
INSERT INTO `shopper_region` VALUES (2477, '长寿区', 3, 268);
INSERT INTO `shopper_region` VALUES (2478, '江津区', 3, 268);
INSERT INTO `shopper_region` VALUES (2479, '合川区', 3, 268);
INSERT INTO `shopper_region` VALUES (2480, '永川区', 3, 268);
INSERT INTO `shopper_region` VALUES (2481, '南川区', 3, 268);
INSERT INTO `shopper_region` VALUES (2482, '璧山区', 3, 268);
INSERT INTO `shopper_region` VALUES (2483, '铜梁区', 3, 268);
INSERT INTO `shopper_region` VALUES (2484, '潼南区', 3, 268);
INSERT INTO `shopper_region` VALUES (2485, '荣昌区', 3, 268);
INSERT INTO `shopper_region` VALUES (2486, '开州区', 3, 268);
INSERT INTO `shopper_region` VALUES (2487, '梁平区', 3, 268);
INSERT INTO `shopper_region` VALUES (2488, '武隆区', 3, 268);
INSERT INTO `shopper_region` VALUES (2489, '锦江区', 3, 269);
INSERT INTO `shopper_region` VALUES (2490, '青羊区', 3, 269);
INSERT INTO `shopper_region` VALUES (2491, '金牛区', 3, 269);
INSERT INTO `shopper_region` VALUES (2492, '武侯区', 3, 269);
INSERT INTO `shopper_region` VALUES (2493, '成华区', 3, 269);
INSERT INTO `shopper_region` VALUES (2494, '龙泉驿区', 3, 269);
INSERT INTO `shopper_region` VALUES (2495, '青白江区', 3, 269);
INSERT INTO `shopper_region` VALUES (2496, '新都区', 3, 269);
INSERT INTO `shopper_region` VALUES (2497, '温江区', 3, 269);
INSERT INTO `shopper_region` VALUES (2498, '双流区', 3, 269);
INSERT INTO `shopper_region` VALUES (2499, '郫都区', 3, 269);
INSERT INTO `shopper_region` VALUES (2500, '新津区', 3, 269);
INSERT INTO `shopper_region` VALUES (2501, '金堂县', 3, 269);
INSERT INTO `shopper_region` VALUES (2502, '大邑县', 3, 269);
INSERT INTO `shopper_region` VALUES (2503, '蒲江县', 3, 269);
INSERT INTO `shopper_region` VALUES (2504, '都江堰市', 3, 269);
INSERT INTO `shopper_region` VALUES (2505, '彭州市', 3, 269);
INSERT INTO `shopper_region` VALUES (2506, '邛崃市', 3, 269);
INSERT INTO `shopper_region` VALUES (2507, '崇州市', 3, 269);
INSERT INTO `shopper_region` VALUES (2508, '简阳市', 3, 269);
INSERT INTO `shopper_region` VALUES (2509, '自流井区', 3, 270);
INSERT INTO `shopper_region` VALUES (2510, '贡井区', 3, 270);
INSERT INTO `shopper_region` VALUES (2511, '大安区', 3, 270);
INSERT INTO `shopper_region` VALUES (2512, '沿滩区', 3, 270);
INSERT INTO `shopper_region` VALUES (2513, '荣县', 3, 270);
INSERT INTO `shopper_region` VALUES (2514, '富顺县', 3, 270);
INSERT INTO `shopper_region` VALUES (2515, '东区', 3, 271);
INSERT INTO `shopper_region` VALUES (2516, '西区', 3, 271);
INSERT INTO `shopper_region` VALUES (2517, '仁和区', 3, 271);
INSERT INTO `shopper_region` VALUES (2518, '米易县', 3, 271);
INSERT INTO `shopper_region` VALUES (2519, '盐边县', 3, 271);
INSERT INTO `shopper_region` VALUES (2520, '江阳区', 3, 272);
INSERT INTO `shopper_region` VALUES (2521, '纳溪区', 3, 272);
INSERT INTO `shopper_region` VALUES (2522, '龙马潭区', 3, 272);
INSERT INTO `shopper_region` VALUES (2523, '泸县', 3, 272);
INSERT INTO `shopper_region` VALUES (2524, '合江县', 3, 272);
INSERT INTO `shopper_region` VALUES (2525, '叙永县', 3, 272);
INSERT INTO `shopper_region` VALUES (2526, '古蔺县', 3, 272);
INSERT INTO `shopper_region` VALUES (2527, '旌阳区', 3, 273);
INSERT INTO `shopper_region` VALUES (2528, '罗江区', 3, 273);
INSERT INTO `shopper_region` VALUES (2529, '中江县', 3, 273);
INSERT INTO `shopper_region` VALUES (2530, '广汉市', 3, 273);
INSERT INTO `shopper_region` VALUES (2531, '什邡市', 3, 273);
INSERT INTO `shopper_region` VALUES (2532, '绵竹市', 3, 273);
INSERT INTO `shopper_region` VALUES (2533, '涪城区', 3, 274);
INSERT INTO `shopper_region` VALUES (2534, '游仙区', 3, 274);
INSERT INTO `shopper_region` VALUES (2535, '安州区', 3, 274);
INSERT INTO `shopper_region` VALUES (2536, '三台县', 3, 274);
INSERT INTO `shopper_region` VALUES (2537, '盐亭县', 3, 274);
INSERT INTO `shopper_region` VALUES (2538, '梓潼县', 3, 274);
INSERT INTO `shopper_region` VALUES (2539, '北川羌族自治县', 3, 274);
INSERT INTO `shopper_region` VALUES (2540, '平武县', 3, 274);
INSERT INTO `shopper_region` VALUES (2541, '江油市', 3, 274);
INSERT INTO `shopper_region` VALUES (2542, '利州区', 3, 275);
INSERT INTO `shopper_region` VALUES (2543, '昭化区', 3, 275);
INSERT INTO `shopper_region` VALUES (2544, '朝天区', 3, 275);
INSERT INTO `shopper_region` VALUES (2545, '旺苍县', 3, 275);
INSERT INTO `shopper_region` VALUES (2546, '青川县', 3, 275);
INSERT INTO `shopper_region` VALUES (2547, '剑阁县', 3, 275);
INSERT INTO `shopper_region` VALUES (2548, '苍溪县', 3, 275);
INSERT INTO `shopper_region` VALUES (2549, '船山区', 3, 276);
INSERT INTO `shopper_region` VALUES (2550, '安居区', 3, 276);
INSERT INTO `shopper_region` VALUES (2551, '蓬溪县', 3, 276);
INSERT INTO `shopper_region` VALUES (2552, '大英县', 3, 276);
INSERT INTO `shopper_region` VALUES (2553, '射洪市', 3, 276);
INSERT INTO `shopper_region` VALUES (2554, '市中区', 3, 277);
INSERT INTO `shopper_region` VALUES (2555, '东兴区', 3, 277);
INSERT INTO `shopper_region` VALUES (2556, '威远县', 3, 277);
INSERT INTO `shopper_region` VALUES (2557, '资中县', 3, 277);
INSERT INTO `shopper_region` VALUES (2558, '隆昌市', 3, 277);
INSERT INTO `shopper_region` VALUES (2559, '市中区', 3, 278);
INSERT INTO `shopper_region` VALUES (2560, '沙湾区', 3, 278);
INSERT INTO `shopper_region` VALUES (2561, '五通桥区', 3, 278);
INSERT INTO `shopper_region` VALUES (2562, '金口河区', 3, 278);
INSERT INTO `shopper_region` VALUES (2563, '犍为县', 3, 278);
INSERT INTO `shopper_region` VALUES (2564, '井研县', 3, 278);
INSERT INTO `shopper_region` VALUES (2565, '夹江县', 3, 278);
INSERT INTO `shopper_region` VALUES (2566, '沐川县', 3, 278);
INSERT INTO `shopper_region` VALUES (2567, '峨边彝族自治县', 3, 278);
INSERT INTO `shopper_region` VALUES (2568, '马边彝族自治县', 3, 278);
INSERT INTO `shopper_region` VALUES (2569, '峨眉山市', 3, 278);
INSERT INTO `shopper_region` VALUES (2570, '顺庆区', 3, 279);
INSERT INTO `shopper_region` VALUES (2571, '高坪区', 3, 279);
INSERT INTO `shopper_region` VALUES (2572, '嘉陵区', 3, 279);
INSERT INTO `shopper_region` VALUES (2573, '南部县', 3, 279);
INSERT INTO `shopper_region` VALUES (2574, '营山县', 3, 279);
INSERT INTO `shopper_region` VALUES (2575, '蓬安县', 3, 279);
INSERT INTO `shopper_region` VALUES (2576, '仪陇县', 3, 279);
INSERT INTO `shopper_region` VALUES (2577, '西充县', 3, 279);
INSERT INTO `shopper_region` VALUES (2578, '阆中市', 3, 279);
INSERT INTO `shopper_region` VALUES (2579, '东坡区', 3, 280);
INSERT INTO `shopper_region` VALUES (2580, '彭山区', 3, 280);
INSERT INTO `shopper_region` VALUES (2581, '仁寿县', 3, 280);
INSERT INTO `shopper_region` VALUES (2582, '洪雅县', 3, 280);
INSERT INTO `shopper_region` VALUES (2583, '丹棱县', 3, 280);
INSERT INTO `shopper_region` VALUES (2584, '青神县', 3, 280);
INSERT INTO `shopper_region` VALUES (2585, '翠屏区', 3, 281);
INSERT INTO `shopper_region` VALUES (2586, '南溪区', 3, 281);
INSERT INTO `shopper_region` VALUES (2587, '叙州区', 3, 281);
INSERT INTO `shopper_region` VALUES (2588, '江安县', 3, 281);
INSERT INTO `shopper_region` VALUES (2589, '长宁县', 3, 281);
INSERT INTO `shopper_region` VALUES (2590, '高县', 3, 281);
INSERT INTO `shopper_region` VALUES (2591, '珙县', 3, 281);
INSERT INTO `shopper_region` VALUES (2592, '筠连县', 3, 281);
INSERT INTO `shopper_region` VALUES (2593, '兴文县', 3, 281);
INSERT INTO `shopper_region` VALUES (2594, '屏山县', 3, 281);
INSERT INTO `shopper_region` VALUES (2595, '广安区', 3, 282);
INSERT INTO `shopper_region` VALUES (2596, '前锋区', 3, 282);
INSERT INTO `shopper_region` VALUES (2597, '岳池县', 3, 282);
INSERT INTO `shopper_region` VALUES (2598, '武胜县', 3, 282);
INSERT INTO `shopper_region` VALUES (2599, '邻水县', 3, 282);
INSERT INTO `shopper_region` VALUES (2600, '华蓥市', 3, 282);
INSERT INTO `shopper_region` VALUES (2601, '通川区', 3, 283);
INSERT INTO `shopper_region` VALUES (2602, '达川区', 3, 283);
INSERT INTO `shopper_region` VALUES (2603, '宣汉县', 3, 283);
INSERT INTO `shopper_region` VALUES (2604, '开江县', 3, 283);
INSERT INTO `shopper_region` VALUES (2605, '大竹县', 3, 283);
INSERT INTO `shopper_region` VALUES (2606, '渠县', 3, 283);
INSERT INTO `shopper_region` VALUES (2607, '万源市', 3, 283);
INSERT INTO `shopper_region` VALUES (2608, '雨城区', 3, 284);
INSERT INTO `shopper_region` VALUES (2609, '名山区', 3, 284);
INSERT INTO `shopper_region` VALUES (2610, '荥经县', 3, 284);
INSERT INTO `shopper_region` VALUES (2611, '汉源县', 3, 284);
INSERT INTO `shopper_region` VALUES (2612, '石棉县', 3, 284);
INSERT INTO `shopper_region` VALUES (2613, '天全县', 3, 284);
INSERT INTO `shopper_region` VALUES (2614, '芦山县', 3, 284);
INSERT INTO `shopper_region` VALUES (2615, '宝兴县', 3, 284);
INSERT INTO `shopper_region` VALUES (2616, '巴州区', 3, 285);
INSERT INTO `shopper_region` VALUES (2617, '恩阳区', 3, 285);
INSERT INTO `shopper_region` VALUES (2618, '通江县', 3, 285);
INSERT INTO `shopper_region` VALUES (2619, '南江县', 3, 285);
INSERT INTO `shopper_region` VALUES (2620, '平昌县', 3, 285);
INSERT INTO `shopper_region` VALUES (2621, '雁江区', 3, 286);
INSERT INTO `shopper_region` VALUES (2622, '安岳县', 3, 286);
INSERT INTO `shopper_region` VALUES (2623, '乐至县', 3, 286);
INSERT INTO `shopper_region` VALUES (2624, '马尔康市', 3, 287);
INSERT INTO `shopper_region` VALUES (2625, '汶川县', 3, 287);
INSERT INTO `shopper_region` VALUES (2626, '理县', 3, 287);
INSERT INTO `shopper_region` VALUES (2627, '茂县', 3, 287);
INSERT INTO `shopper_region` VALUES (2628, '松潘县', 3, 287);
INSERT INTO `shopper_region` VALUES (2629, '九寨沟县', 3, 287);
INSERT INTO `shopper_region` VALUES (2630, '金川县', 3, 287);
INSERT INTO `shopper_region` VALUES (2631, '小金县', 3, 287);
INSERT INTO `shopper_region` VALUES (2632, '黑水县', 3, 287);
INSERT INTO `shopper_region` VALUES (2633, '壤塘县', 3, 287);
INSERT INTO `shopper_region` VALUES (2634, '阿坝县', 3, 287);
INSERT INTO `shopper_region` VALUES (2635, '若尔盖县', 3, 287);
INSERT INTO `shopper_region` VALUES (2636, '红原县', 3, 287);
INSERT INTO `shopper_region` VALUES (2637, '康定市', 3, 288);
INSERT INTO `shopper_region` VALUES (2638, '泸定县', 3, 288);
INSERT INTO `shopper_region` VALUES (2639, '丹巴县', 3, 288);
INSERT INTO `shopper_region` VALUES (2640, '九龙县', 3, 288);
INSERT INTO `shopper_region` VALUES (2641, '雅江县', 3, 288);
INSERT INTO `shopper_region` VALUES (2642, '道孚县', 3, 288);
INSERT INTO `shopper_region` VALUES (2643, '炉霍县', 3, 288);
INSERT INTO `shopper_region` VALUES (2644, '甘孜县', 3, 288);
INSERT INTO `shopper_region` VALUES (2645, '新龙县', 3, 288);
INSERT INTO `shopper_region` VALUES (2646, '德格县', 3, 288);
INSERT INTO `shopper_region` VALUES (2647, '白玉县', 3, 288);
INSERT INTO `shopper_region` VALUES (2648, '石渠县', 3, 288);
INSERT INTO `shopper_region` VALUES (2649, '色达县', 3, 288);
INSERT INTO `shopper_region` VALUES (2650, '理塘县', 3, 288);
INSERT INTO `shopper_region` VALUES (2651, '巴塘县', 3, 288);
INSERT INTO `shopper_region` VALUES (2652, '乡城县', 3, 288);
INSERT INTO `shopper_region` VALUES (2653, '稻城县', 3, 288);
INSERT INTO `shopper_region` VALUES (2654, '得荣县', 3, 288);
INSERT INTO `shopper_region` VALUES (2655, '西昌市', 3, 289);
INSERT INTO `shopper_region` VALUES (2656, '会理市', 3, 289);
INSERT INTO `shopper_region` VALUES (2657, '木里藏族自治县', 3, 289);
INSERT INTO `shopper_region` VALUES (2658, '盐源县', 3, 289);
INSERT INTO `shopper_region` VALUES (2659, '德昌县', 3, 289);
INSERT INTO `shopper_region` VALUES (2660, '会东县', 3, 289);
INSERT INTO `shopper_region` VALUES (2661, '宁南县', 3, 289);
INSERT INTO `shopper_region` VALUES (2662, '普格县', 3, 289);
INSERT INTO `shopper_region` VALUES (2663, '布拖县', 3, 289);
INSERT INTO `shopper_region` VALUES (2664, '金阳县', 3, 289);
INSERT INTO `shopper_region` VALUES (2665, '昭觉县', 3, 289);
INSERT INTO `shopper_region` VALUES (2666, '喜德县', 3, 289);
INSERT INTO `shopper_region` VALUES (2667, '冕宁县', 3, 289);
INSERT INTO `shopper_region` VALUES (2668, '越西县', 3, 289);
INSERT INTO `shopper_region` VALUES (2669, '甘洛县', 3, 289);
INSERT INTO `shopper_region` VALUES (2670, '美姑县', 3, 289);
INSERT INTO `shopper_region` VALUES (2671, '雷波县', 3, 289);
INSERT INTO `shopper_region` VALUES (2672, '南明区', 3, 290);
INSERT INTO `shopper_region` VALUES (2673, '云岩区', 3, 290);
INSERT INTO `shopper_region` VALUES (2674, '花溪区', 3, 290);
INSERT INTO `shopper_region` VALUES (2675, '乌当区', 3, 290);
INSERT INTO `shopper_region` VALUES (2676, '白云区', 3, 290);
INSERT INTO `shopper_region` VALUES (2677, '观山湖区', 3, 290);
INSERT INTO `shopper_region` VALUES (2678, '开阳县', 3, 290);
INSERT INTO `shopper_region` VALUES (2679, '息烽县', 3, 290);
INSERT INTO `shopper_region` VALUES (2680, '修文县', 3, 290);
INSERT INTO `shopper_region` VALUES (2681, '清镇市', 3, 290);
INSERT INTO `shopper_region` VALUES (2682, '钟山区', 3, 291);
INSERT INTO `shopper_region` VALUES (2683, '六枝特区', 3, 291);
INSERT INTO `shopper_region` VALUES (2684, '水城区', 3, 291);
INSERT INTO `shopper_region` VALUES (2685, '盘州市', 3, 291);
INSERT INTO `shopper_region` VALUES (2686, '红花岗区', 3, 292);
INSERT INTO `shopper_region` VALUES (2687, '汇川区', 3, 292);
INSERT INTO `shopper_region` VALUES (2688, '播州区', 3, 292);
INSERT INTO `shopper_region` VALUES (2689, '桐梓县', 3, 292);
INSERT INTO `shopper_region` VALUES (2690, '绥阳县', 3, 292);
INSERT INTO `shopper_region` VALUES (2691, '正安县', 3, 292);
INSERT INTO `shopper_region` VALUES (2692, '道真仡佬族苗族自治县', 3, 292);
INSERT INTO `shopper_region` VALUES (2693, '务川仡佬族苗族自治县', 3, 292);
INSERT INTO `shopper_region` VALUES (2694, '凤冈县', 3, 292);
INSERT INTO `shopper_region` VALUES (2695, '湄潭县', 3, 292);
INSERT INTO `shopper_region` VALUES (2696, '余庆县', 3, 292);
INSERT INTO `shopper_region` VALUES (2697, '习水县', 3, 292);
INSERT INTO `shopper_region` VALUES (2698, '赤水市', 3, 292);
INSERT INTO `shopper_region` VALUES (2699, '仁怀市', 3, 292);
INSERT INTO `shopper_region` VALUES (2700, '西秀区', 3, 293);
INSERT INTO `shopper_region` VALUES (2701, '平坝区', 3, 293);
INSERT INTO `shopper_region` VALUES (2702, '普定县', 3, 293);
INSERT INTO `shopper_region` VALUES (2703, '镇宁布依族苗族自治县', 3, 293);
INSERT INTO `shopper_region` VALUES (2704, '关岭布依族苗族自治县', 3, 293);
INSERT INTO `shopper_region` VALUES (2705, '紫云苗族布依族自治县', 3, 293);
INSERT INTO `shopper_region` VALUES (2706, '七星关区', 3, 294);
INSERT INTO `shopper_region` VALUES (2707, '大方县', 3, 294);
INSERT INTO `shopper_region` VALUES (2708, '金沙县', 3, 294);
INSERT INTO `shopper_region` VALUES (2709, '织金县', 3, 294);
INSERT INTO `shopper_region` VALUES (2710, '纳雍县', 3, 294);
INSERT INTO `shopper_region` VALUES (2711, '威宁彝族回族苗族自治县', 3, 294);
INSERT INTO `shopper_region` VALUES (2712, '赫章县', 3, 294);
INSERT INTO `shopper_region` VALUES (2713, '黔西市', 3, 294);
INSERT INTO `shopper_region` VALUES (2714, '碧江区', 3, 295);
INSERT INTO `shopper_region` VALUES (2715, '万山区', 3, 295);
INSERT INTO `shopper_region` VALUES (2716, '江口县', 3, 295);
INSERT INTO `shopper_region` VALUES (2717, '玉屏侗族自治县', 3, 295);
INSERT INTO `shopper_region` VALUES (2718, '石阡县', 3, 295);
INSERT INTO `shopper_region` VALUES (2719, '思南县', 3, 295);
INSERT INTO `shopper_region` VALUES (2720, '印江土家族苗族自治县', 3, 295);
INSERT INTO `shopper_region` VALUES (2721, '德江县', 3, 295);
INSERT INTO `shopper_region` VALUES (2722, '沿河土家族自治县', 3, 295);
INSERT INTO `shopper_region` VALUES (2723, '松桃苗族自治县', 3, 295);
INSERT INTO `shopper_region` VALUES (2724, '兴义市', 3, 296);
INSERT INTO `shopper_region` VALUES (2725, '兴仁市', 3, 296);
INSERT INTO `shopper_region` VALUES (2726, '普安县', 3, 296);
INSERT INTO `shopper_region` VALUES (2727, '晴隆县', 3, 296);
INSERT INTO `shopper_region` VALUES (2728, '贞丰县', 3, 296);
INSERT INTO `shopper_region` VALUES (2729, '望谟县', 3, 296);
INSERT INTO `shopper_region` VALUES (2730, '册亨县', 3, 296);
INSERT INTO `shopper_region` VALUES (2731, '安龙县', 3, 296);
INSERT INTO `shopper_region` VALUES (2732, '凯里市', 3, 297);
INSERT INTO `shopper_region` VALUES (2733, '黄平县', 3, 297);
INSERT INTO `shopper_region` VALUES (2734, '施秉县', 3, 297);
INSERT INTO `shopper_region` VALUES (2735, '三穗县', 3, 297);
INSERT INTO `shopper_region` VALUES (2736, '镇远县', 3, 297);
INSERT INTO `shopper_region` VALUES (2737, '岑巩县', 3, 297);
INSERT INTO `shopper_region` VALUES (2738, '天柱县', 3, 297);
INSERT INTO `shopper_region` VALUES (2739, '锦屏县', 3, 297);
INSERT INTO `shopper_region` VALUES (2740, '剑河县', 3, 297);
INSERT INTO `shopper_region` VALUES (2741, '台江县', 3, 297);
INSERT INTO `shopper_region` VALUES (2742, '黎平县', 3, 297);
INSERT INTO `shopper_region` VALUES (2743, '榕江县', 3, 297);
INSERT INTO `shopper_region` VALUES (2744, '从江县', 3, 297);
INSERT INTO `shopper_region` VALUES (2745, '雷山县', 3, 297);
INSERT INTO `shopper_region` VALUES (2746, '麻江县', 3, 297);
INSERT INTO `shopper_region` VALUES (2747, '丹寨县', 3, 297);
INSERT INTO `shopper_region` VALUES (2748, '都匀市', 3, 298);
INSERT INTO `shopper_region` VALUES (2749, '福泉市', 3, 298);
INSERT INTO `shopper_region` VALUES (2750, '荔波县', 3, 298);
INSERT INTO `shopper_region` VALUES (2751, '贵定县', 3, 298);
INSERT INTO `shopper_region` VALUES (2752, '瓮安县', 3, 298);
INSERT INTO `shopper_region` VALUES (2753, '独山县', 3, 298);
INSERT INTO `shopper_region` VALUES (2754, '平塘县', 3, 298);
INSERT INTO `shopper_region` VALUES (2755, '罗甸县', 3, 298);
INSERT INTO `shopper_region` VALUES (2756, '长顺县', 3, 298);
INSERT INTO `shopper_region` VALUES (2757, '龙里县', 3, 298);
INSERT INTO `shopper_region` VALUES (2758, '惠水县', 3, 298);
INSERT INTO `shopper_region` VALUES (2759, '三都水族自治县', 3, 298);
INSERT INTO `shopper_region` VALUES (2760, '五华区', 3, 299);
INSERT INTO `shopper_region` VALUES (2761, '盘龙区', 3, 299);
INSERT INTO `shopper_region` VALUES (2762, '官渡区', 3, 299);
INSERT INTO `shopper_region` VALUES (2763, '西山区', 3, 299);
INSERT INTO `shopper_region` VALUES (2764, '东川区', 3, 299);
INSERT INTO `shopper_region` VALUES (2765, '呈贡区', 3, 299);
INSERT INTO `shopper_region` VALUES (2766, '晋宁区', 3, 299);
INSERT INTO `shopper_region` VALUES (2767, '富民县', 3, 299);
INSERT INTO `shopper_region` VALUES (2768, '宜良县', 3, 299);
INSERT INTO `shopper_region` VALUES (2769, '石林彝族自治县', 3, 299);
INSERT INTO `shopper_region` VALUES (2770, '嵩明县', 3, 299);
INSERT INTO `shopper_region` VALUES (2771, '禄劝彝族苗族自治县', 3, 299);
INSERT INTO `shopper_region` VALUES (2772, '寻甸回族彝族自治县', 3, 299);
INSERT INTO `shopper_region` VALUES (2773, '安宁市', 3, 299);
INSERT INTO `shopper_region` VALUES (2774, '麒麟区', 3, 300);
INSERT INTO `shopper_region` VALUES (2775, '沾益区', 3, 300);
INSERT INTO `shopper_region` VALUES (2776, '马龙区', 3, 300);
INSERT INTO `shopper_region` VALUES (2777, '陆良县', 3, 300);
INSERT INTO `shopper_region` VALUES (2778, '师宗县', 3, 300);
INSERT INTO `shopper_region` VALUES (2779, '罗平县', 3, 300);
INSERT INTO `shopper_region` VALUES (2780, '富源县', 3, 300);
INSERT INTO `shopper_region` VALUES (2781, '会泽县', 3, 300);
INSERT INTO `shopper_region` VALUES (2782, '宣威市', 3, 300);
INSERT INTO `shopper_region` VALUES (2783, '红塔区', 3, 301);
INSERT INTO `shopper_region` VALUES (2784, '江川区', 3, 301);
INSERT INTO `shopper_region` VALUES (2785, '通海县', 3, 301);
INSERT INTO `shopper_region` VALUES (2786, '华宁县', 3, 301);
INSERT INTO `shopper_region` VALUES (2787, '易门县', 3, 301);
INSERT INTO `shopper_region` VALUES (2788, '峨山彝族自治县', 3, 301);
INSERT INTO `shopper_region` VALUES (2789, '新平彝族傣族自治县', 3, 301);
INSERT INTO `shopper_region` VALUES (2790, '元江哈尼族彝族傣族自治县', 3, 301);
INSERT INTO `shopper_region` VALUES (2791, '澄江市', 3, 301);
INSERT INTO `shopper_region` VALUES (2792, '隆阳区', 3, 302);
INSERT INTO `shopper_region` VALUES (2793, '施甸县', 3, 302);
INSERT INTO `shopper_region` VALUES (2794, '龙陵县', 3, 302);
INSERT INTO `shopper_region` VALUES (2795, '昌宁县', 3, 302);
INSERT INTO `shopper_region` VALUES (2796, '腾冲市', 3, 302);
INSERT INTO `shopper_region` VALUES (2797, '昭阳区', 3, 303);
INSERT INTO `shopper_region` VALUES (2798, '鲁甸县', 3, 303);
INSERT INTO `shopper_region` VALUES (2799, '巧家县', 3, 303);
INSERT INTO `shopper_region` VALUES (2800, '盐津县', 3, 303);
INSERT INTO `shopper_region` VALUES (2801, '大关县', 3, 303);
INSERT INTO `shopper_region` VALUES (2802, '永善县', 3, 303);
INSERT INTO `shopper_region` VALUES (2803, '绥江县', 3, 303);
INSERT INTO `shopper_region` VALUES (2804, '镇雄县', 3, 303);
INSERT INTO `shopper_region` VALUES (2805, '彝良县', 3, 303);
INSERT INTO `shopper_region` VALUES (2806, '威信县', 3, 303);
INSERT INTO `shopper_region` VALUES (2807, '水富市', 3, 303);
INSERT INTO `shopper_region` VALUES (2808, '古城区', 3, 304);
INSERT INTO `shopper_region` VALUES (2809, '玉龙纳西族自治县', 3, 304);
INSERT INTO `shopper_region` VALUES (2810, '永胜县', 3, 304);
INSERT INTO `shopper_region` VALUES (2811, '华坪县', 3, 304);
INSERT INTO `shopper_region` VALUES (2812, '宁蒗彝族自治县', 3, 304);
INSERT INTO `shopper_region` VALUES (2813, '思茅区', 3, 305);
INSERT INTO `shopper_region` VALUES (2814, '宁洱哈尼族彝族自治县', 3, 305);
INSERT INTO `shopper_region` VALUES (2815, '墨江哈尼族自治县', 3, 305);
INSERT INTO `shopper_region` VALUES (2816, '景东彝族自治县', 3, 305);
INSERT INTO `shopper_region` VALUES (2817, '景谷傣族彝族自治县', 3, 305);
INSERT INTO `shopper_region` VALUES (2818, '镇沅彝族哈尼族拉祜族自治县', 3, 305);
INSERT INTO `shopper_region` VALUES (2819, '江城哈尼族彝族自治县', 3, 305);
INSERT INTO `shopper_region` VALUES (2820, '孟连傣族拉祜族佤族自治县', 3, 305);
INSERT INTO `shopper_region` VALUES (2821, '澜沧拉祜族自治县', 3, 305);
INSERT INTO `shopper_region` VALUES (2822, '西盟佤族自治县', 3, 305);
INSERT INTO `shopper_region` VALUES (2823, '临翔区', 3, 306);
INSERT INTO `shopper_region` VALUES (2824, '凤庆县', 3, 306);
INSERT INTO `shopper_region` VALUES (2825, '云县', 3, 306);
INSERT INTO `shopper_region` VALUES (2826, '永德县', 3, 306);
INSERT INTO `shopper_region` VALUES (2827, '镇康县', 3, 306);
INSERT INTO `shopper_region` VALUES (2828, '双江拉祜族佤族布朗族傣族自治县', 3, 306);
INSERT INTO `shopper_region` VALUES (2829, '耿马傣族佤族自治县', 3, 306);
INSERT INTO `shopper_region` VALUES (2830, '沧源佤族自治县', 3, 306);
INSERT INTO `shopper_region` VALUES (2831, '楚雄市', 3, 307);
INSERT INTO `shopper_region` VALUES (2832, '禄丰市', 3, 307);
INSERT INTO `shopper_region` VALUES (2833, '双柏县', 3, 307);
INSERT INTO `shopper_region` VALUES (2834, '牟定县', 3, 307);
INSERT INTO `shopper_region` VALUES (2835, '南华县', 3, 307);
INSERT INTO `shopper_region` VALUES (2836, '姚安县', 3, 307);
INSERT INTO `shopper_region` VALUES (2837, '大姚县', 3, 307);
INSERT INTO `shopper_region` VALUES (2838, '永仁县', 3, 307);
INSERT INTO `shopper_region` VALUES (2839, '元谋县', 3, 307);
INSERT INTO `shopper_region` VALUES (2840, '武定县', 3, 307);
INSERT INTO `shopper_region` VALUES (2841, '个旧市', 3, 308);
INSERT INTO `shopper_region` VALUES (2842, '开远市', 3, 308);
INSERT INTO `shopper_region` VALUES (2843, '蒙自市', 3, 308);
INSERT INTO `shopper_region` VALUES (2844, '弥勒市', 3, 308);
INSERT INTO `shopper_region` VALUES (2845, '屏边苗族自治县', 3, 308);
INSERT INTO `shopper_region` VALUES (2846, '建水县', 3, 308);
INSERT INTO `shopper_region` VALUES (2847, '石屏县', 3, 308);
INSERT INTO `shopper_region` VALUES (2848, '泸西县', 3, 308);
INSERT INTO `shopper_region` VALUES (2849, '元阳县', 3, 308);
INSERT INTO `shopper_region` VALUES (2850, '红河县', 3, 308);
INSERT INTO `shopper_region` VALUES (2851, '金平苗族瑶族傣族自治县', 3, 308);
INSERT INTO `shopper_region` VALUES (2852, '绿春县', 3, 308);
INSERT INTO `shopper_region` VALUES (2853, '河口瑶族自治县', 3, 308);
INSERT INTO `shopper_region` VALUES (2854, '文山市', 3, 309);
INSERT INTO `shopper_region` VALUES (2855, '砚山县', 3, 309);
INSERT INTO `shopper_region` VALUES (2856, '西畴县', 3, 309);
INSERT INTO `shopper_region` VALUES (2857, '麻栗坡县', 3, 309);
INSERT INTO `shopper_region` VALUES (2858, '马关县', 3, 309);
INSERT INTO `shopper_region` VALUES (2859, '丘北县', 3, 309);
INSERT INTO `shopper_region` VALUES (2860, '广南县', 3, 309);
INSERT INTO `shopper_region` VALUES (2861, '富宁县', 3, 309);
INSERT INTO `shopper_region` VALUES (2862, '景洪市', 3, 310);
INSERT INTO `shopper_region` VALUES (2863, '勐海县', 3, 310);
INSERT INTO `shopper_region` VALUES (2864, '勐腊县', 3, 310);
INSERT INTO `shopper_region` VALUES (2865, '大理市', 3, 311);
INSERT INTO `shopper_region` VALUES (2866, '漾濞彝族自治县', 3, 311);
INSERT INTO `shopper_region` VALUES (2867, '祥云县', 3, 311);
INSERT INTO `shopper_region` VALUES (2868, '宾川县', 3, 311);
INSERT INTO `shopper_region` VALUES (2869, '弥渡县', 3, 311);
INSERT INTO `shopper_region` VALUES (2870, '南涧彝族自治县', 3, 311);
INSERT INTO `shopper_region` VALUES (2871, '巍山彝族回族自治县', 3, 311);
INSERT INTO `shopper_region` VALUES (2872, '永平县', 3, 311);
INSERT INTO `shopper_region` VALUES (2873, '云龙县', 3, 311);
INSERT INTO `shopper_region` VALUES (2874, '洱源县', 3, 311);
INSERT INTO `shopper_region` VALUES (2875, '剑川县', 3, 311);
INSERT INTO `shopper_region` VALUES (2876, '鹤庆县', 3, 311);
INSERT INTO `shopper_region` VALUES (2877, '瑞丽市', 3, 312);
INSERT INTO `shopper_region` VALUES (2878, '芒市', 3, 312);
INSERT INTO `shopper_region` VALUES (2879, '梁河县', 3, 312);
INSERT INTO `shopper_region` VALUES (2880, '盈江县', 3, 312);
INSERT INTO `shopper_region` VALUES (2881, '陇川县', 3, 312);
INSERT INTO `shopper_region` VALUES (2882, '泸水市', 3, 313);
INSERT INTO `shopper_region` VALUES (2883, '福贡县', 3, 313);
INSERT INTO `shopper_region` VALUES (2884, '贡山独龙族怒族自治县', 3, 313);
INSERT INTO `shopper_region` VALUES (2885, '兰坪白族普米族自治县', 3, 313);
INSERT INTO `shopper_region` VALUES (2886, '香格里拉市', 3, 314);
INSERT INTO `shopper_region` VALUES (2887, '德钦县', 3, 314);
INSERT INTO `shopper_region` VALUES (2888, '维西傈僳族自治县', 3, 314);
INSERT INTO `shopper_region` VALUES (2889, '城关区', 3, 315);
INSERT INTO `shopper_region` VALUES (2890, '堆龙德庆区', 3, 315);
INSERT INTO `shopper_region` VALUES (2891, '达孜区', 3, 315);
INSERT INTO `shopper_region` VALUES (2892, '林周县', 3, 315);
INSERT INTO `shopper_region` VALUES (2893, '当雄县', 3, 315);
INSERT INTO `shopper_region` VALUES (2894, '尼木县', 3, 315);
INSERT INTO `shopper_region` VALUES (2895, '曲水县', 3, 315);
INSERT INTO `shopper_region` VALUES (2896, '墨竹工卡县', 3, 315);
INSERT INTO `shopper_region` VALUES (2897, '格尔木藏青工业园区', 3, 315);
INSERT INTO `shopper_region` VALUES (2898, '拉萨经济技术开发区', 3, 315);
INSERT INTO `shopper_region` VALUES (2899, '西藏文化旅游创意园区', 3, 315);
INSERT INTO `shopper_region` VALUES (2900, '达孜工业园区', 3, 315);
INSERT INTO `shopper_region` VALUES (2901, '桑珠孜区', 3, 316);
INSERT INTO `shopper_region` VALUES (2902, '南木林县', 3, 316);
INSERT INTO `shopper_region` VALUES (2903, '江孜县', 3, 316);
INSERT INTO `shopper_region` VALUES (2904, '定日县', 3, 316);
INSERT INTO `shopper_region` VALUES (2905, '萨迦县', 3, 316);
INSERT INTO `shopper_region` VALUES (2906, '拉孜县', 3, 316);
INSERT INTO `shopper_region` VALUES (2907, '昂仁县', 3, 316);
INSERT INTO `shopper_region` VALUES (2908, '谢通门县', 3, 316);
INSERT INTO `shopper_region` VALUES (2909, '白朗县', 3, 316);
INSERT INTO `shopper_region` VALUES (2910, '仁布县', 3, 316);
INSERT INTO `shopper_region` VALUES (2911, '康马县', 3, 316);
INSERT INTO `shopper_region` VALUES (2912, '定结县', 3, 316);
INSERT INTO `shopper_region` VALUES (2913, '仲巴县', 3, 316);
INSERT INTO `shopper_region` VALUES (2914, '亚东县', 3, 316);
INSERT INTO `shopper_region` VALUES (2915, '吉隆县', 3, 316);
INSERT INTO `shopper_region` VALUES (2916, '聂拉木县', 3, 316);
INSERT INTO `shopper_region` VALUES (2917, '萨嘎县', 3, 316);
INSERT INTO `shopper_region` VALUES (2918, '岗巴县', 3, 316);
INSERT INTO `shopper_region` VALUES (2919, '卡若区', 3, 317);
INSERT INTO `shopper_region` VALUES (2920, '江达县', 3, 317);
INSERT INTO `shopper_region` VALUES (2921, '贡觉县', 3, 317);
INSERT INTO `shopper_region` VALUES (2922, '类乌齐县', 3, 317);
INSERT INTO `shopper_region` VALUES (2923, '丁青县', 3, 317);
INSERT INTO `shopper_region` VALUES (2924, '察雅县', 3, 317);
INSERT INTO `shopper_region` VALUES (2925, '八宿县', 3, 317);
INSERT INTO `shopper_region` VALUES (2926, '左贡县', 3, 317);
INSERT INTO `shopper_region` VALUES (2927, '芒康县', 3, 317);
INSERT INTO `shopper_region` VALUES (2928, '洛隆县', 3, 317);
INSERT INTO `shopper_region` VALUES (2929, '边坝县', 3, 317);
INSERT INTO `shopper_region` VALUES (2930, '巴宜区', 3, 318);
INSERT INTO `shopper_region` VALUES (2931, '工布江达县', 3, 318);
INSERT INTO `shopper_region` VALUES (2932, '墨脱县', 3, 318);
INSERT INTO `shopper_region` VALUES (2933, '波密县', 3, 318);
INSERT INTO `shopper_region` VALUES (2934, '察隅县', 3, 318);
INSERT INTO `shopper_region` VALUES (2935, '朗县', 3, 318);
INSERT INTO `shopper_region` VALUES (2936, '米林市', 3, 318);
INSERT INTO `shopper_region` VALUES (2937, '乃东区', 3, 319);
INSERT INTO `shopper_region` VALUES (2938, '扎囊县', 3, 319);
INSERT INTO `shopper_region` VALUES (2939, '贡嘎县', 3, 319);
INSERT INTO `shopper_region` VALUES (2940, '桑日县', 3, 319);
INSERT INTO `shopper_region` VALUES (2941, '琼结县', 3, 319);
INSERT INTO `shopper_region` VALUES (2942, '曲松县', 3, 319);
INSERT INTO `shopper_region` VALUES (2943, '措美县', 3, 319);
INSERT INTO `shopper_region` VALUES (2944, '洛扎县', 3, 319);
INSERT INTO `shopper_region` VALUES (2945, '加查县', 3, 319);
INSERT INTO `shopper_region` VALUES (2946, '隆子县', 3, 319);
INSERT INTO `shopper_region` VALUES (2947, '浪卡子县', 3, 319);
INSERT INTO `shopper_region` VALUES (2948, '错那市', 3, 319);
INSERT INTO `shopper_region` VALUES (2949, '色尼区', 3, 320);
INSERT INTO `shopper_region` VALUES (2950, '嘉黎县', 3, 320);
INSERT INTO `shopper_region` VALUES (2951, '比如县', 3, 320);
INSERT INTO `shopper_region` VALUES (2952, '聂荣县', 3, 320);
INSERT INTO `shopper_region` VALUES (2953, '安多县', 3, 320);
INSERT INTO `shopper_region` VALUES (2954, '申扎县', 3, 320);
INSERT INTO `shopper_region` VALUES (2955, '索县', 3, 320);
INSERT INTO `shopper_region` VALUES (2956, '班戈县', 3, 320);
INSERT INTO `shopper_region` VALUES (2957, '巴青县', 3, 320);
INSERT INTO `shopper_region` VALUES (2958, '尼玛县', 3, 320);
INSERT INTO `shopper_region` VALUES (2959, '双湖县', 3, 320);
INSERT INTO `shopper_region` VALUES (2960, '普兰县', 3, 321);
INSERT INTO `shopper_region` VALUES (2961, '札达县', 3, 321);
INSERT INTO `shopper_region` VALUES (2962, '噶尔县', 3, 321);
INSERT INTO `shopper_region` VALUES (2963, '日土县', 3, 321);
INSERT INTO `shopper_region` VALUES (2964, '革吉县', 3, 321);
INSERT INTO `shopper_region` VALUES (2965, '改则县', 3, 321);
INSERT INTO `shopper_region` VALUES (2966, '措勤县', 3, 321);
INSERT INTO `shopper_region` VALUES (2967, '新城区', 3, 322);
INSERT INTO `shopper_region` VALUES (2968, '碑林区', 3, 322);
INSERT INTO `shopper_region` VALUES (2969, '莲湖区', 3, 322);
INSERT INTO `shopper_region` VALUES (2970, '灞桥区', 3, 322);
INSERT INTO `shopper_region` VALUES (2971, '未央区', 3, 322);
INSERT INTO `shopper_region` VALUES (2972, '雁塔区', 3, 322);
INSERT INTO `shopper_region` VALUES (2973, '阎良区', 3, 322);
INSERT INTO `shopper_region` VALUES (2974, '临潼区', 3, 322);
INSERT INTO `shopper_region` VALUES (2975, '长安区', 3, 322);
INSERT INTO `shopper_region` VALUES (2976, '高陵区', 3, 322);
INSERT INTO `shopper_region` VALUES (2977, '鄠邑区', 3, 322);
INSERT INTO `shopper_region` VALUES (2978, '蓝田县', 3, 322);
INSERT INTO `shopper_region` VALUES (2979, '周至县', 3, 322);
INSERT INTO `shopper_region` VALUES (2980, '王益区', 3, 323);
INSERT INTO `shopper_region` VALUES (2981, '印台区', 3, 323);
INSERT INTO `shopper_region` VALUES (2982, '耀州区', 3, 323);
INSERT INTO `shopper_region` VALUES (2983, '宜君县', 3, 323);
INSERT INTO `shopper_region` VALUES (2984, '渭滨区', 3, 324);
INSERT INTO `shopper_region` VALUES (2985, '金台区', 3, 324);
INSERT INTO `shopper_region` VALUES (2986, '陈仓区', 3, 324);
INSERT INTO `shopper_region` VALUES (2987, '凤翔区', 3, 324);
INSERT INTO `shopper_region` VALUES (2988, '岐山县', 3, 324);
INSERT INTO `shopper_region` VALUES (2989, '扶风县', 3, 324);
INSERT INTO `shopper_region` VALUES (2990, '眉县', 3, 324);
INSERT INTO `shopper_region` VALUES (2991, '陇县', 3, 324);
INSERT INTO `shopper_region` VALUES (2992, '千阳县', 3, 324);
INSERT INTO `shopper_region` VALUES (2993, '麟游县', 3, 324);
INSERT INTO `shopper_region` VALUES (2994, '凤县', 3, 324);
INSERT INTO `shopper_region` VALUES (2995, '太白县', 3, 324);
INSERT INTO `shopper_region` VALUES (2996, '秦都区', 3, 325);
INSERT INTO `shopper_region` VALUES (2997, '杨陵区', 3, 325);
INSERT INTO `shopper_region` VALUES (2998, '渭城区', 3, 325);
INSERT INTO `shopper_region` VALUES (2999, '三原县', 3, 325);
INSERT INTO `shopper_region` VALUES (3000, '泾阳县', 3, 325);
INSERT INTO `shopper_region` VALUES (3001, '乾县', 3, 325);
INSERT INTO `shopper_region` VALUES (3002, '礼泉县', 3, 325);
INSERT INTO `shopper_region` VALUES (3003, '永寿县', 3, 325);
INSERT INTO `shopper_region` VALUES (3004, '长武县', 3, 325);
INSERT INTO `shopper_region` VALUES (3005, '旬邑县', 3, 325);
INSERT INTO `shopper_region` VALUES (3006, '淳化县', 3, 325);
INSERT INTO `shopper_region` VALUES (3007, '武功县', 3, 325);
INSERT INTO `shopper_region` VALUES (3008, '兴平市', 3, 325);
INSERT INTO `shopper_region` VALUES (3009, '彬州市', 3, 325);
INSERT INTO `shopper_region` VALUES (3010, '临渭区', 3, 326);
INSERT INTO `shopper_region` VALUES (3011, '华州区', 3, 326);
INSERT INTO `shopper_region` VALUES (3012, '潼关县', 3, 326);
INSERT INTO `shopper_region` VALUES (3013, '大荔县', 3, 326);
INSERT INTO `shopper_region` VALUES (3014, '合阳县', 3, 326);
INSERT INTO `shopper_region` VALUES (3015, '澄城县', 3, 326);
INSERT INTO `shopper_region` VALUES (3016, '蒲城县', 3, 326);
INSERT INTO `shopper_region` VALUES (3017, '白水县', 3, 326);
INSERT INTO `shopper_region` VALUES (3018, '富平县', 3, 326);
INSERT INTO `shopper_region` VALUES (3019, '韩城市', 3, 326);
INSERT INTO `shopper_region` VALUES (3020, '华阴市', 3, 326);
INSERT INTO `shopper_region` VALUES (3021, '宝塔区', 3, 327);
INSERT INTO `shopper_region` VALUES (3022, '安塞区', 3, 327);
INSERT INTO `shopper_region` VALUES (3023, '延长县', 3, 327);
INSERT INTO `shopper_region` VALUES (3024, '延川县', 3, 327);
INSERT INTO `shopper_region` VALUES (3025, '志丹县', 3, 327);
INSERT INTO `shopper_region` VALUES (3026, '吴起县', 3, 327);
INSERT INTO `shopper_region` VALUES (3027, '甘泉县', 3, 327);
INSERT INTO `shopper_region` VALUES (3028, '富县', 3, 327);
INSERT INTO `shopper_region` VALUES (3029, '洛川县', 3, 327);
INSERT INTO `shopper_region` VALUES (3030, '宜川县', 3, 327);
INSERT INTO `shopper_region` VALUES (3031, '黄龙县', 3, 327);
INSERT INTO `shopper_region` VALUES (3032, '黄陵县', 3, 327);
INSERT INTO `shopper_region` VALUES (3033, '子长市', 3, 327);
INSERT INTO `shopper_region` VALUES (3034, '汉台区', 3, 328);
INSERT INTO `shopper_region` VALUES (3035, '南郑区', 3, 328);
INSERT INTO `shopper_region` VALUES (3036, '城固县', 3, 328);
INSERT INTO `shopper_region` VALUES (3037, '洋县', 3, 328);
INSERT INTO `shopper_region` VALUES (3038, '西乡县', 3, 328);
INSERT INTO `shopper_region` VALUES (3039, '勉县', 3, 328);
INSERT INTO `shopper_region` VALUES (3040, '宁强县', 3, 328);
INSERT INTO `shopper_region` VALUES (3041, '略阳县', 3, 328);
INSERT INTO `shopper_region` VALUES (3042, '镇巴县', 3, 328);
INSERT INTO `shopper_region` VALUES (3043, '留坝县', 3, 328);
INSERT INTO `shopper_region` VALUES (3044, '佛坪县', 3, 328);
INSERT INTO `shopper_region` VALUES (3045, '榆阳区', 3, 329);
INSERT INTO `shopper_region` VALUES (3046, '横山区', 3, 329);
INSERT INTO `shopper_region` VALUES (3047, '府谷县', 3, 329);
INSERT INTO `shopper_region` VALUES (3048, '靖边县', 3, 329);
INSERT INTO `shopper_region` VALUES (3049, '定边县', 3, 329);
INSERT INTO `shopper_region` VALUES (3050, '绥德县', 3, 329);
INSERT INTO `shopper_region` VALUES (3051, '米脂县', 3, 329);
INSERT INTO `shopper_region` VALUES (3052, '佳县', 3, 329);
INSERT INTO `shopper_region` VALUES (3053, '吴堡县', 3, 329);
INSERT INTO `shopper_region` VALUES (3054, '清涧县', 3, 329);
INSERT INTO `shopper_region` VALUES (3055, '子洲县', 3, 329);
INSERT INTO `shopper_region` VALUES (3056, '神木市', 3, 329);
INSERT INTO `shopper_region` VALUES (3057, '汉滨区', 3, 330);
INSERT INTO `shopper_region` VALUES (3058, '汉阴县', 3, 330);
INSERT INTO `shopper_region` VALUES (3059, '石泉县', 3, 330);
INSERT INTO `shopper_region` VALUES (3060, '宁陕县', 3, 330);
INSERT INTO `shopper_region` VALUES (3061, '紫阳县', 3, 330);
INSERT INTO `shopper_region` VALUES (3062, '岚皋县', 3, 330);
INSERT INTO `shopper_region` VALUES (3063, '平利县', 3, 330);
INSERT INTO `shopper_region` VALUES (3064, '镇坪县', 3, 330);
INSERT INTO `shopper_region` VALUES (3065, '白河县', 3, 330);
INSERT INTO `shopper_region` VALUES (3066, '旬阳市', 3, 330);
INSERT INTO `shopper_region` VALUES (3067, '商州区', 3, 331);
INSERT INTO `shopper_region` VALUES (3068, '洛南县', 3, 331);
INSERT INTO `shopper_region` VALUES (3069, '丹凤县', 3, 331);
INSERT INTO `shopper_region` VALUES (3070, '商南县', 3, 331);
INSERT INTO `shopper_region` VALUES (3071, '山阳县', 3, 331);
INSERT INTO `shopper_region` VALUES (3072, '镇安县', 3, 331);
INSERT INTO `shopper_region` VALUES (3073, '柞水县', 3, 331);
INSERT INTO `shopper_region` VALUES (3074, '城关区', 3, 332);
INSERT INTO `shopper_region` VALUES (3075, '七里河区', 3, 332);
INSERT INTO `shopper_region` VALUES (3076, '西固区', 3, 332);
INSERT INTO `shopper_region` VALUES (3077, '安宁区', 3, 332);
INSERT INTO `shopper_region` VALUES (3078, '红古区', 3, 332);
INSERT INTO `shopper_region` VALUES (3079, '永登县', 3, 332);
INSERT INTO `shopper_region` VALUES (3080, '皋兰县', 3, 332);
INSERT INTO `shopper_region` VALUES (3081, '榆中县', 3, 332);
INSERT INTO `shopper_region` VALUES (3082, '兰州新区', 3, 332);
INSERT INTO `shopper_region` VALUES (3083, '市辖区', 3, 333);
INSERT INTO `shopper_region` VALUES (3084, '金川区', 3, 334);
INSERT INTO `shopper_region` VALUES (3085, '永昌县', 3, 334);
INSERT INTO `shopper_region` VALUES (3086, '白银区', 3, 335);
INSERT INTO `shopper_region` VALUES (3087, '平川区', 3, 335);
INSERT INTO `shopper_region` VALUES (3088, '靖远县', 3, 335);
INSERT INTO `shopper_region` VALUES (3089, '会宁县', 3, 335);
INSERT INTO `shopper_region` VALUES (3090, '景泰县', 3, 335);
INSERT INTO `shopper_region` VALUES (3091, '秦州区', 3, 336);
INSERT INTO `shopper_region` VALUES (3092, '麦积区', 3, 336);
INSERT INTO `shopper_region` VALUES (3093, '清水县', 3, 336);
INSERT INTO `shopper_region` VALUES (3094, '秦安县', 3, 336);
INSERT INTO `shopper_region` VALUES (3095, '甘谷县', 3, 336);
INSERT INTO `shopper_region` VALUES (3096, '武山县', 3, 336);
INSERT INTO `shopper_region` VALUES (3097, '张家川回族自治县', 3, 336);
INSERT INTO `shopper_region` VALUES (3098, '凉州区', 3, 337);
INSERT INTO `shopper_region` VALUES (3099, '民勤县', 3, 337);
INSERT INTO `shopper_region` VALUES (3100, '古浪县', 3, 337);
INSERT INTO `shopper_region` VALUES (3101, '天祝藏族自治县', 3, 337);
INSERT INTO `shopper_region` VALUES (3102, '甘州区', 3, 338);
INSERT INTO `shopper_region` VALUES (3103, '肃南裕固族自治县', 3, 338);
INSERT INTO `shopper_region` VALUES (3104, '民乐县', 3, 338);
INSERT INTO `shopper_region` VALUES (3105, '临泽县', 3, 338);
INSERT INTO `shopper_region` VALUES (3106, '高台县', 3, 338);
INSERT INTO `shopper_region` VALUES (3107, '山丹县', 3, 338);
INSERT INTO `shopper_region` VALUES (3108, '崆峒区', 3, 339);
INSERT INTO `shopper_region` VALUES (3109, '泾川县', 3, 339);
INSERT INTO `shopper_region` VALUES (3110, '灵台县', 3, 339);
INSERT INTO `shopper_region` VALUES (3111, '崇信县', 3, 339);
INSERT INTO `shopper_region` VALUES (3112, '庄浪县', 3, 339);
INSERT INTO `shopper_region` VALUES (3113, '静宁县', 3, 339);
INSERT INTO `shopper_region` VALUES (3114, '华亭市', 3, 339);
INSERT INTO `shopper_region` VALUES (3115, '肃州区', 3, 340);
INSERT INTO `shopper_region` VALUES (3116, '金塔县', 3, 340);
INSERT INTO `shopper_region` VALUES (3117, '瓜州县', 3, 340);
INSERT INTO `shopper_region` VALUES (3118, '肃北蒙古族自治县', 3, 340);
INSERT INTO `shopper_region` VALUES (3119, '阿克塞哈萨克族自治县', 3, 340);
INSERT INTO `shopper_region` VALUES (3120, '玉门市', 3, 340);
INSERT INTO `shopper_region` VALUES (3121, '敦煌市', 3, 340);
INSERT INTO `shopper_region` VALUES (3122, '西峰区', 3, 341);
INSERT INTO `shopper_region` VALUES (3123, '庆城县', 3, 341);
INSERT INTO `shopper_region` VALUES (3124, '环县', 3, 341);
INSERT INTO `shopper_region` VALUES (3125, '华池县', 3, 341);
INSERT INTO `shopper_region` VALUES (3126, '合水县', 3, 341);
INSERT INTO `shopper_region` VALUES (3127, '正宁县', 3, 341);
INSERT INTO `shopper_region` VALUES (3128, '宁县', 3, 341);
INSERT INTO `shopper_region` VALUES (3129, '镇原县', 3, 341);
INSERT INTO `shopper_region` VALUES (3130, '安定区', 3, 342);
INSERT INTO `shopper_region` VALUES (3131, '通渭县', 3, 342);
INSERT INTO `shopper_region` VALUES (3132, '陇西县', 3, 342);
INSERT INTO `shopper_region` VALUES (3133, '渭源县', 3, 342);
INSERT INTO `shopper_region` VALUES (3134, '临洮县', 3, 342);
INSERT INTO `shopper_region` VALUES (3135, '漳县', 3, 342);
INSERT INTO `shopper_region` VALUES (3136, '岷县', 3, 342);
INSERT INTO `shopper_region` VALUES (3137, '武都区', 3, 343);
INSERT INTO `shopper_region` VALUES (3138, '成县', 3, 343);
INSERT INTO `shopper_region` VALUES (3139, '文县', 3, 343);
INSERT INTO `shopper_region` VALUES (3140, '宕昌县', 3, 343);
INSERT INTO `shopper_region` VALUES (3141, '康县', 3, 343);
INSERT INTO `shopper_region` VALUES (3142, '西和县', 3, 343);
INSERT INTO `shopper_region` VALUES (3143, '礼县', 3, 343);
INSERT INTO `shopper_region` VALUES (3144, '徽县', 3, 343);
INSERT INTO `shopper_region` VALUES (3145, '两当县', 3, 343);
INSERT INTO `shopper_region` VALUES (3146, '临夏市', 3, 344);
INSERT INTO `shopper_region` VALUES (3147, '临夏县', 3, 344);
INSERT INTO `shopper_region` VALUES (3148, '康乐县', 3, 344);
INSERT INTO `shopper_region` VALUES (3149, '永靖县', 3, 344);
INSERT INTO `shopper_region` VALUES (3150, '广河县', 3, 344);
INSERT INTO `shopper_region` VALUES (3151, '和政县', 3, 344);
INSERT INTO `shopper_region` VALUES (3152, '东乡族自治县', 3, 344);
INSERT INTO `shopper_region` VALUES (3153, '积石山保安族东乡族撒拉族自治县', 3, 344);
INSERT INTO `shopper_region` VALUES (3154, '合作市', 3, 345);
INSERT INTO `shopper_region` VALUES (3155, '临潭县', 3, 345);
INSERT INTO `shopper_region` VALUES (3156, '卓尼县', 3, 345);
INSERT INTO `shopper_region` VALUES (3157, '舟曲县', 3, 345);
INSERT INTO `shopper_region` VALUES (3158, '迭部县', 3, 345);
INSERT INTO `shopper_region` VALUES (3159, '玛曲县', 3, 345);
INSERT INTO `shopper_region` VALUES (3160, '碌曲县', 3, 345);
INSERT INTO `shopper_region` VALUES (3161, '夏河县', 3, 345);
INSERT INTO `shopper_region` VALUES (3162, '城东区', 3, 346);
INSERT INTO `shopper_region` VALUES (3163, '城中区', 3, 346);
INSERT INTO `shopper_region` VALUES (3164, '城西区', 3, 346);
INSERT INTO `shopper_region` VALUES (3165, '城北区', 3, 346);
INSERT INTO `shopper_region` VALUES (3166, '湟中区', 3, 346);
INSERT INTO `shopper_region` VALUES (3167, '大通回族土族自治县', 3, 346);
INSERT INTO `shopper_region` VALUES (3168, '湟源县', 3, 346);
INSERT INTO `shopper_region` VALUES (3169, '乐都区', 3, 347);
INSERT INTO `shopper_region` VALUES (3170, '平安区', 3, 347);
INSERT INTO `shopper_region` VALUES (3171, '民和回族土族自治县', 3, 347);
INSERT INTO `shopper_region` VALUES (3172, '互助土族自治县', 3, 347);
INSERT INTO `shopper_region` VALUES (3173, '化隆回族自治县', 3, 347);
INSERT INTO `shopper_region` VALUES (3174, '循化撒拉族自治县', 3, 347);
INSERT INTO `shopper_region` VALUES (3175, '门源回族自治县', 3, 348);
INSERT INTO `shopper_region` VALUES (3176, '祁连县', 3, 348);
INSERT INTO `shopper_region` VALUES (3177, '海晏县', 3, 348);
INSERT INTO `shopper_region` VALUES (3178, '刚察县', 3, 348);
INSERT INTO `shopper_region` VALUES (3179, '同仁市', 3, 349);
INSERT INTO `shopper_region` VALUES (3180, '尖扎县', 3, 349);
INSERT INTO `shopper_region` VALUES (3181, '泽库县', 3, 349);
INSERT INTO `shopper_region` VALUES (3182, '河南蒙古族自治县', 3, 349);
INSERT INTO `shopper_region` VALUES (3183, '共和县', 3, 350);
INSERT INTO `shopper_region` VALUES (3184, '同德县', 3, 350);
INSERT INTO `shopper_region` VALUES (3185, '贵德县', 3, 350);
INSERT INTO `shopper_region` VALUES (3186, '兴海县', 3, 350);
INSERT INTO `shopper_region` VALUES (3187, '贵南县', 3, 350);
INSERT INTO `shopper_region` VALUES (3188, '玛沁县', 3, 351);
INSERT INTO `shopper_region` VALUES (3189, '班玛县', 3, 351);
INSERT INTO `shopper_region` VALUES (3190, '甘德县', 3, 351);
INSERT INTO `shopper_region` VALUES (3191, '达日县', 3, 351);
INSERT INTO `shopper_region` VALUES (3192, '久治县', 3, 351);
INSERT INTO `shopper_region` VALUES (3193, '玛多县', 3, 351);
INSERT INTO `shopper_region` VALUES (3194, '玉树市', 3, 352);
INSERT INTO `shopper_region` VALUES (3195, '杂多县', 3, 352);
INSERT INTO `shopper_region` VALUES (3196, '称多县', 3, 352);
INSERT INTO `shopper_region` VALUES (3197, '治多县', 3, 352);
INSERT INTO `shopper_region` VALUES (3198, '囊谦县', 3, 352);
INSERT INTO `shopper_region` VALUES (3199, '曲麻莱县', 3, 352);
INSERT INTO `shopper_region` VALUES (3200, '格尔木市', 3, 353);
INSERT INTO `shopper_region` VALUES (3201, '德令哈市', 3, 353);
INSERT INTO `shopper_region` VALUES (3202, '茫崖市', 3, 353);
INSERT INTO `shopper_region` VALUES (3203, '乌兰县', 3, 353);
INSERT INTO `shopper_region` VALUES (3204, '都兰县', 3, 353);
INSERT INTO `shopper_region` VALUES (3205, '天峻县', 3, 353);
INSERT INTO `shopper_region` VALUES (3206, '大柴旦行政委员会', 3, 353);
INSERT INTO `shopper_region` VALUES (3207, '兴庆区', 3, 354);
INSERT INTO `shopper_region` VALUES (3208, '西夏区', 3, 354);
INSERT INTO `shopper_region` VALUES (3209, '金凤区', 3, 354);
INSERT INTO `shopper_region` VALUES (3210, '永宁县', 3, 354);
INSERT INTO `shopper_region` VALUES (3211, '贺兰县', 3, 354);
INSERT INTO `shopper_region` VALUES (3212, '灵武市', 3, 354);
INSERT INTO `shopper_region` VALUES (3213, '大武口区', 3, 355);
INSERT INTO `shopper_region` VALUES (3214, '惠农区', 3, 355);
INSERT INTO `shopper_region` VALUES (3215, '平罗县', 3, 355);
INSERT INTO `shopper_region` VALUES (3216, '利通区', 3, 356);
INSERT INTO `shopper_region` VALUES (3217, '红寺堡区', 3, 356);
INSERT INTO `shopper_region` VALUES (3218, '盐池县', 3, 356);
INSERT INTO `shopper_region` VALUES (3219, '同心县', 3, 356);
INSERT INTO `shopper_region` VALUES (3220, '青铜峡市', 3, 356);
INSERT INTO `shopper_region` VALUES (3221, '原州区', 3, 357);
INSERT INTO `shopper_region` VALUES (3222, '西吉县', 3, 357);
INSERT INTO `shopper_region` VALUES (3223, '隆德县', 3, 357);
INSERT INTO `shopper_region` VALUES (3224, '泾源县', 3, 357);
INSERT INTO `shopper_region` VALUES (3225, '彭阳县', 3, 357);
INSERT INTO `shopper_region` VALUES (3226, '沙坡头区', 3, 358);
INSERT INTO `shopper_region` VALUES (3227, '中宁县', 3, 358);
INSERT INTO `shopper_region` VALUES (3228, '海原县', 3, 358);
INSERT INTO `shopper_region` VALUES (3229, '天山区', 3, 359);
INSERT INTO `shopper_region` VALUES (3230, '沙依巴克区', 3, 359);
INSERT INTO `shopper_region` VALUES (3231, '新市区', 3, 359);
INSERT INTO `shopper_region` VALUES (3232, '水磨沟区', 3, 359);
INSERT INTO `shopper_region` VALUES (3233, '头屯河区', 3, 359);
INSERT INTO `shopper_region` VALUES (3234, '达坂城区', 3, 359);
INSERT INTO `shopper_region` VALUES (3235, '米东区', 3, 359);
INSERT INTO `shopper_region` VALUES (3236, '乌鲁木齐县', 3, 359);
INSERT INTO `shopper_region` VALUES (3237, '独山子区', 3, 360);
INSERT INTO `shopper_region` VALUES (3238, '克拉玛依区', 3, 360);
INSERT INTO `shopper_region` VALUES (3239, '白碱滩区', 3, 360);
INSERT INTO `shopper_region` VALUES (3240, '乌尔禾区', 3, 360);
INSERT INTO `shopper_region` VALUES (3241, '高昌区', 3, 361);
INSERT INTO `shopper_region` VALUES (3242, '鄯善县', 3, 361);
INSERT INTO `shopper_region` VALUES (3243, '托克逊县', 3, 361);
INSERT INTO `shopper_region` VALUES (3244, '伊州区', 3, 362);
INSERT INTO `shopper_region` VALUES (3245, '巴里坤哈萨克自治县', 3, 362);
INSERT INTO `shopper_region` VALUES (3246, '伊吾县', 3, 362);
INSERT INTO `shopper_region` VALUES (3247, '昌吉市', 3, 363);
INSERT INTO `shopper_region` VALUES (3248, '阜康市', 3, 363);
INSERT INTO `shopper_region` VALUES (3249, '呼图壁县', 3, 363);
INSERT INTO `shopper_region` VALUES (3250, '玛纳斯县', 3, 363);
INSERT INTO `shopper_region` VALUES (3251, '奇台县', 3, 363);
INSERT INTO `shopper_region` VALUES (3252, '吉木萨尔县', 3, 363);
INSERT INTO `shopper_region` VALUES (3253, '木垒哈萨克自治县', 3, 363);
INSERT INTO `shopper_region` VALUES (3254, '博乐市', 3, 364);
INSERT INTO `shopper_region` VALUES (3255, '阿拉山口市', 3, 364);
INSERT INTO `shopper_region` VALUES (3256, '精河县', 3, 364);
INSERT INTO `shopper_region` VALUES (3257, '温泉县', 3, 364);
INSERT INTO `shopper_region` VALUES (3258, '库尔勒市', 3, 365);
INSERT INTO `shopper_region` VALUES (3259, '轮台县', 3, 365);
INSERT INTO `shopper_region` VALUES (3260, '尉犁县', 3, 365);
INSERT INTO `shopper_region` VALUES (3261, '若羌县', 3, 365);
INSERT INTO `shopper_region` VALUES (3262, '且末县', 3, 365);
INSERT INTO `shopper_region` VALUES (3263, '焉耆回族自治县', 3, 365);
INSERT INTO `shopper_region` VALUES (3264, '和静县', 3, 365);
INSERT INTO `shopper_region` VALUES (3265, '和硕县', 3, 365);
INSERT INTO `shopper_region` VALUES (3266, '博湖县', 3, 365);
INSERT INTO `shopper_region` VALUES (3267, '阿克苏市', 3, 366);
INSERT INTO `shopper_region` VALUES (3268, '库车市', 3, 366);
INSERT INTO `shopper_region` VALUES (3269, '温宿县', 3, 366);
INSERT INTO `shopper_region` VALUES (3270, '沙雅县', 3, 366);
INSERT INTO `shopper_region` VALUES (3271, '新和县', 3, 366);
INSERT INTO `shopper_region` VALUES (3272, '拜城县', 3, 366);
INSERT INTO `shopper_region` VALUES (3273, '乌什县', 3, 366);
INSERT INTO `shopper_region` VALUES (3274, '阿瓦提县', 3, 366);
INSERT INTO `shopper_region` VALUES (3275, '柯坪县', 3, 366);
INSERT INTO `shopper_region` VALUES (3276, '阿图什市', 3, 367);
INSERT INTO `shopper_region` VALUES (3277, '阿克陶县', 3, 367);
INSERT INTO `shopper_region` VALUES (3278, '阿合奇县', 3, 367);
INSERT INTO `shopper_region` VALUES (3279, '乌恰县', 3, 367);
INSERT INTO `shopper_region` VALUES (3280, '喀什市', 3, 368);
INSERT INTO `shopper_region` VALUES (3281, '疏附县', 3, 368);
INSERT INTO `shopper_region` VALUES (3282, '疏勒县', 3, 368);
INSERT INTO `shopper_region` VALUES (3283, '英吉沙县', 3, 368);
INSERT INTO `shopper_region` VALUES (3284, '泽普县', 3, 368);
INSERT INTO `shopper_region` VALUES (3285, '莎车县', 3, 368);
INSERT INTO `shopper_region` VALUES (3286, '叶城县', 3, 368);
INSERT INTO `shopper_region` VALUES (3287, '麦盖提县', 3, 368);
INSERT INTO `shopper_region` VALUES (3288, '岳普湖县', 3, 368);
INSERT INTO `shopper_region` VALUES (3289, '伽师县', 3, 368);
INSERT INTO `shopper_region` VALUES (3290, '巴楚县', 3, 368);
INSERT INTO `shopper_region` VALUES (3291, '塔什库尔干塔吉克自治县', 3, 368);
INSERT INTO `shopper_region` VALUES (3292, '和田市', 3, 369);
INSERT INTO `shopper_region` VALUES (3293, '和田县', 3, 369);
INSERT INTO `shopper_region` VALUES (3294, '墨玉县', 3, 369);
INSERT INTO `shopper_region` VALUES (3295, '皮山县', 3, 369);
INSERT INTO `shopper_region` VALUES (3296, '洛浦县', 3, 369);
INSERT INTO `shopper_region` VALUES (3297, '策勒县', 3, 369);
INSERT INTO `shopper_region` VALUES (3298, '于田县', 3, 369);
INSERT INTO `shopper_region` VALUES (3299, '民丰县', 3, 369);
INSERT INTO `shopper_region` VALUES (3300, '伊宁市', 3, 370);
INSERT INTO `shopper_region` VALUES (3301, '奎屯市', 3, 370);
INSERT INTO `shopper_region` VALUES (3302, '霍尔果斯市', 3, 370);
INSERT INTO `shopper_region` VALUES (3303, '伊宁县', 3, 370);
INSERT INTO `shopper_region` VALUES (3304, '察布查尔锡伯自治县', 3, 370);
INSERT INTO `shopper_region` VALUES (3305, '霍城县', 3, 370);
INSERT INTO `shopper_region` VALUES (3306, '巩留县', 3, 370);
INSERT INTO `shopper_region` VALUES (3307, '新源县', 3, 370);
INSERT INTO `shopper_region` VALUES (3308, '昭苏县', 3, 370);
INSERT INTO `shopper_region` VALUES (3309, '特克斯县', 3, 370);
INSERT INTO `shopper_region` VALUES (3310, '尼勒克县', 3, 370);
INSERT INTO `shopper_region` VALUES (3311, '塔城市', 3, 371);
INSERT INTO `shopper_region` VALUES (3312, '乌苏市', 3, 371);
INSERT INTO `shopper_region` VALUES (3313, '沙湾市', 3, 371);
INSERT INTO `shopper_region` VALUES (3314, '额敏县', 3, 371);
INSERT INTO `shopper_region` VALUES (3315, '托里县', 3, 371);
INSERT INTO `shopper_region` VALUES (3316, '裕民县', 3, 371);
INSERT INTO `shopper_region` VALUES (3317, '和布克赛尔蒙古自治县', 3, 371);
INSERT INTO `shopper_region` VALUES (3318, '阿勒泰市', 3, 372);
INSERT INTO `shopper_region` VALUES (3319, '布尔津县', 3, 372);
INSERT INTO `shopper_region` VALUES (3320, '富蕴县', 3, 372);
INSERT INTO `shopper_region` VALUES (3321, '福海县', 3, 372);
INSERT INTO `shopper_region` VALUES (3322, '哈巴河县', 3, 372);
INSERT INTO `shopper_region` VALUES (3323, '青河县', 3, 372);
INSERT INTO `shopper_region` VALUES (3324, '吉木乃县', 3, 372);
INSERT INTO `shopper_region` VALUES (3325, '石河子市', 3, 373);
INSERT INTO `shopper_region` VALUES (3326, '阿拉尔市', 3, 373);
INSERT INTO `shopper_region` VALUES (3327, '图木舒克市', 3, 373);
INSERT INTO `shopper_region` VALUES (3328, '五家渠市', 3, 373);
INSERT INTO `shopper_region` VALUES (3329, '北屯市', 3, 373);
INSERT INTO `shopper_region` VALUES (3330, '铁门关市', 3, 373);
INSERT INTO `shopper_region` VALUES (3331, '双河市', 3, 373);
INSERT INTO `shopper_region` VALUES (3332, '可克达拉市', 3, 373);
INSERT INTO `shopper_region` VALUES (3333, '昆玉市', 3, 373);
INSERT INTO `shopper_region` VALUES (3334, '胡杨河市', 3, 373);
INSERT INTO `shopper_region` VALUES (3335, '新星市', 3, 373);
INSERT INTO `shopper_region` VALUES (3336, '白杨市', 3, 373);
INSERT INTO `shopper_region` VALUES (3337, '市辖区', 3, 34);
INSERT INTO `shopper_region` VALUES (3338, '市辖区', 3, 35);
INSERT INTO `shopper_region` VALUES (3339, '市辖区', 3, 36);
INSERT INTO `shopper_region` VALUES (3340, '市辖区', 3, 37);
INSERT INTO `shopper_region` VALUES (3341, '市辖区', 3, 38);
INSERT INTO `shopper_region` VALUES (3342, '市辖区', 3, 39);
INSERT INTO `shopper_region` VALUES (3343, '市辖区', 3, 40);
INSERT INTO `shopper_region` VALUES (3344, '市辖区', 3, 41);
INSERT INTO `shopper_region` VALUES (3345, '市辖区', 3, 42);
INSERT INTO `shopper_region` VALUES (3346, '市辖区', 3, 43);
INSERT INTO `shopper_region` VALUES (3347, '市辖区', 3, 44);
INSERT INTO `shopper_region` VALUES (3348, '市辖区', 3, 46);
INSERT INTO `shopper_region` VALUES (3349, '市辖区', 3, 47);
INSERT INTO `shopper_region` VALUES (3350, '市辖区', 3, 48);
INSERT INTO `shopper_region` VALUES (3351, '市辖区', 3, 49);
INSERT INTO `shopper_region` VALUES (3352, '市辖区', 3, 50);
INSERT INTO `shopper_region` VALUES (3353, '市辖区', 3, 51);
INSERT INTO `shopper_region` VALUES (3354, '市辖区', 3, 52);
INSERT INTO `shopper_region` VALUES (3355, '市辖区', 3, 53);
INSERT INTO `shopper_region` VALUES (3356, '市辖区', 3, 54);
INSERT INTO `shopper_region` VALUES (3357, '市辖区', 3, 55);
INSERT INTO `shopper_region` VALUES (3358, '市辖区', 3, 56);
INSERT INTO `shopper_region` VALUES (3359, '市辖区', 3, 57);
INSERT INTO `shopper_region` VALUES (3360, '市辖区', 3, 58);
INSERT INTO `shopper_region` VALUES (3361, '市辖区', 3, 59);
INSERT INTO `shopper_region` VALUES (3362, '市辖区', 3, 60);
INSERT INTO `shopper_region` VALUES (3363, '市辖区', 3, 61);
INSERT INTO `shopper_region` VALUES (3364, '市辖区', 3, 62);
INSERT INTO `shopper_region` VALUES (3365, '市辖区', 3, 63);
INSERT INTO `shopper_region` VALUES (3366, '市辖区', 3, 64);
INSERT INTO `shopper_region` VALUES (3367, '市辖区', 3, 65);
INSERT INTO `shopper_region` VALUES (3368, '市辖区', 3, 69);
INSERT INTO `shopper_region` VALUES (3369, '市辖区', 3, 70);
INSERT INTO `shopper_region` VALUES (3370, '市辖区', 3, 71);
INSERT INTO `shopper_region` VALUES (3371, '市辖区', 3, 72);
INSERT INTO `shopper_region` VALUES (3372, '市辖区', 3, 73);
INSERT INTO `shopper_region` VALUES (3373, '市辖区', 3, 74);
INSERT INTO `shopper_region` VALUES (3374, '市辖区', 3, 75);
INSERT INTO `shopper_region` VALUES (3375, '市辖区', 3, 76);
INSERT INTO `shopper_region` VALUES (3376, '市辖区', 3, 77);
INSERT INTO `shopper_region` VALUES (3377, '市辖区', 3, 78);
INSERT INTO `shopper_region` VALUES (3378, '市辖区', 3, 79);
INSERT INTO `shopper_region` VALUES (3379, '市辖区', 3, 80);
INSERT INTO `shopper_region` VALUES (3380, '市辖区', 3, 81);
INSERT INTO `shopper_region` VALUES (3381, '市辖区', 3, 82);
INSERT INTO `shopper_region` VALUES (3382, '市辖区', 3, 83);
INSERT INTO `shopper_region` VALUES (3383, '市辖区', 3, 84);
INSERT INTO `shopper_region` VALUES (3384, '市辖区', 3, 85);
INSERT INTO `shopper_region` VALUES (3385, '市辖区', 3, 86);
INSERT INTO `shopper_region` VALUES (3386, '市辖区', 3, 87);
INSERT INTO `shopper_region` VALUES (3387, '市辖区', 3, 88);
INSERT INTO `shopper_region` VALUES (3388, '市辖区', 3, 89);
INSERT INTO `shopper_region` VALUES (3389, '市辖区', 3, 90);
INSERT INTO `shopper_region` VALUES (3390, '市辖区', 3, 92);
INSERT INTO `shopper_region` VALUES (3391, '市辖区', 3, 93);
INSERT INTO `shopper_region` VALUES (3392, '市辖区', 3, 94);
INSERT INTO `shopper_region` VALUES (3393, '市辖区', 3, 95);
INSERT INTO `shopper_region` VALUES (3394, '市辖区', 3, 96);
INSERT INTO `shopper_region` VALUES (3395, '市辖区', 3, 97);
INSERT INTO `shopper_region` VALUES (3396, '市辖区', 3, 98);
INSERT INTO `shopper_region` VALUES (3397, '市辖区', 3, 99);
INSERT INTO `shopper_region` VALUES (3398, '市辖区', 3, 100);
INSERT INTO `shopper_region` VALUES (3399, '市辖区', 3, 101);
INSERT INTO `shopper_region` VALUES (3400, '市辖区', 3, 102);
INSERT INTO `shopper_region` VALUES (3401, '市辖区', 3, 103);
INSERT INTO `shopper_region` VALUES (3402, '市辖区', 3, 106);
INSERT INTO `shopper_region` VALUES (3403, '市辖区', 3, 107);
INSERT INTO `shopper_region` VALUES (3404, '市辖区', 3, 108);
INSERT INTO `shopper_region` VALUES (3405, '市辖区', 3, 109);
INSERT INTO `shopper_region` VALUES (3406, '市辖区', 3, 110);
INSERT INTO `shopper_region` VALUES (3407, '市辖区', 3, 111);
INSERT INTO `shopper_region` VALUES (3408, '市辖区', 3, 112);
INSERT INTO `shopper_region` VALUES (3409, '市辖区', 3, 113);
INSERT INTO `shopper_region` VALUES (3410, '市辖区', 3, 114);
INSERT INTO `shopper_region` VALUES (3411, '市辖区', 3, 115);
INSERT INTO `shopper_region` VALUES (3412, '市辖区', 3, 116);
INSERT INTO `shopper_region` VALUES (3413, '市辖区', 3, 117);
INSERT INTO `shopper_region` VALUES (3414, '市辖区', 3, 118);
INSERT INTO `shopper_region` VALUES (3415, '市辖区', 3, 119);
INSERT INTO `shopper_region` VALUES (3416, '市辖区', 3, 120);
INSERT INTO `shopper_region` VALUES (3417, '市辖区', 3, 121);
INSERT INTO `shopper_region` VALUES (3418, '市辖区', 3, 122);
INSERT INTO `shopper_region` VALUES (3419, '市辖区', 3, 123);
INSERT INTO `shopper_region` VALUES (3420, '市辖区', 3, 124);
INSERT INTO `shopper_region` VALUES (3421, '市辖区', 3, 125);
INSERT INTO `shopper_region` VALUES (3422, '市辖区', 3, 126);
INSERT INTO `shopper_region` VALUES (3423, '市辖区', 3, 127);
INSERT INTO `shopper_region` VALUES (3424, '市辖区', 3, 128);
INSERT INTO `shopper_region` VALUES (3425, '市辖区', 3, 129);
INSERT INTO `shopper_region` VALUES (3426, '市辖区', 3, 130);
INSERT INTO `shopper_region` VALUES (3427, '市辖区', 3, 131);
INSERT INTO `shopper_region` VALUES (3428, '市辖区', 3, 132);
INSERT INTO `shopper_region` VALUES (3429, '市辖区', 3, 133);
INSERT INTO `shopper_region` VALUES (3430, '市辖区', 3, 134);
INSERT INTO `shopper_region` VALUES (3431, '市辖区', 3, 135);
INSERT INTO `shopper_region` VALUES (3432, '市辖区', 3, 136);
INSERT INTO `shopper_region` VALUES (3433, '市辖区', 3, 137);
INSERT INTO `shopper_region` VALUES (3434, '市辖区', 3, 138);
INSERT INTO `shopper_region` VALUES (3435, '市辖区', 3, 139);
INSERT INTO `shopper_region` VALUES (3436, '市辖区', 3, 140);
INSERT INTO `shopper_region` VALUES (3437, '市辖区', 3, 141);
INSERT INTO `shopper_region` VALUES (3438, '市辖区', 3, 142);
INSERT INTO `shopper_region` VALUES (3439, '市辖区', 3, 143);
INSERT INTO `shopper_region` VALUES (3440, '市辖区', 3, 144);
INSERT INTO `shopper_region` VALUES (3441, '市辖区', 3, 145);
INSERT INTO `shopper_region` VALUES (3442, '市辖区', 3, 146);
INSERT INTO `shopper_region` VALUES (3443, '市辖区', 3, 147);
INSERT INTO `shopper_region` VALUES (3444, '市辖区', 3, 148);
INSERT INTO `shopper_region` VALUES (3445, '市辖区', 3, 149);
INSERT INTO `shopper_region` VALUES (3446, '市辖区', 3, 150);
INSERT INTO `shopper_region` VALUES (3447, '金门县', 3, 150);
INSERT INTO `shopper_region` VALUES (3448, '市辖区', 3, 151);
INSERT INTO `shopper_region` VALUES (3449, '市辖区', 3, 152);
INSERT INTO `shopper_region` VALUES (3450, '市辖区', 3, 153);
INSERT INTO `shopper_region` VALUES (3451, '市辖区', 3, 154);
INSERT INTO `shopper_region` VALUES (3452, '市辖区', 3, 155);
INSERT INTO `shopper_region` VALUES (3453, '市辖区', 3, 156);
INSERT INTO `shopper_region` VALUES (3454, '市辖区', 3, 157);
INSERT INTO `shopper_region` VALUES (3455, '市辖区', 3, 158);
INSERT INTO `shopper_region` VALUES (3456, '市辖区', 3, 159);
INSERT INTO `shopper_region` VALUES (3457, '市辖区', 3, 160);
INSERT INTO `shopper_region` VALUES (3458, '市辖区', 3, 161);
INSERT INTO `shopper_region` VALUES (3459, '市辖区', 3, 162);
INSERT INTO `shopper_region` VALUES (3460, '市辖区', 3, 163);
INSERT INTO `shopper_region` VALUES (3461, '市辖区', 3, 164);
INSERT INTO `shopper_region` VALUES (3462, '市辖区', 3, 165);
INSERT INTO `shopper_region` VALUES (3463, '市辖区', 3, 166);
INSERT INTO `shopper_region` VALUES (3464, '市辖区', 3, 167);
INSERT INTO `shopper_region` VALUES (3465, '市辖区', 3, 168);
INSERT INTO `shopper_region` VALUES (3466, '市辖区', 3, 169);
INSERT INTO `shopper_region` VALUES (3467, '市辖区', 3, 170);
INSERT INTO `shopper_region` VALUES (3468, '市辖区', 3, 171);
INSERT INTO `shopper_region` VALUES (3469, '市辖区', 3, 172);
INSERT INTO `shopper_region` VALUES (3470, '市辖区', 3, 173);
INSERT INTO `shopper_region` VALUES (3471, '市辖区', 3, 174);
INSERT INTO `shopper_region` VALUES (3472, '市辖区', 3, 175);
INSERT INTO `shopper_region` VALUES (3473, '市辖区', 3, 176);
INSERT INTO `shopper_region` VALUES (3474, '市辖区', 3, 177);
INSERT INTO `shopper_region` VALUES (3475, '市辖区', 3, 178);
INSERT INTO `shopper_region` VALUES (3476, '市辖区', 3, 179);
INSERT INTO `shopper_region` VALUES (3477, '市辖区', 3, 180);
INSERT INTO `shopper_region` VALUES (3478, '市辖区', 3, 181);
INSERT INTO `shopper_region` VALUES (3479, '市辖区', 3, 182);
INSERT INTO `shopper_region` VALUES (3480, '市辖区', 3, 183);
INSERT INTO `shopper_region` VALUES (3481, '市辖区', 3, 184);
INSERT INTO `shopper_region` VALUES (3482, '市辖区', 3, 185);
INSERT INTO `shopper_region` VALUES (3483, '市辖区', 3, 186);
INSERT INTO `shopper_region` VALUES (3484, '市辖区', 3, 187);
INSERT INTO `shopper_region` VALUES (3485, '市辖区', 3, 188);
INSERT INTO `shopper_region` VALUES (3486, '市辖区', 3, 189);
INSERT INTO `shopper_region` VALUES (3487, '市辖区', 3, 190);
INSERT INTO `shopper_region` VALUES (3488, '市辖区', 3, 191);
INSERT INTO `shopper_region` VALUES (3489, '市辖区', 3, 192);
INSERT INTO `shopper_region` VALUES (3490, '市辖区', 3, 193);
INSERT INTO `shopper_region` VALUES (3491, '市辖区', 3, 194);
INSERT INTO `shopper_region` VALUES (3492, '市辖区', 3, 195);
INSERT INTO `shopper_region` VALUES (3493, '市辖区', 3, 196);
INSERT INTO `shopper_region` VALUES (3494, '市辖区', 3, 197);
INSERT INTO `shopper_region` VALUES (3495, '市辖区', 3, 198);
INSERT INTO `shopper_region` VALUES (3496, '市辖区', 3, 200);
INSERT INTO `shopper_region` VALUES (3497, '市辖区', 3, 201);
INSERT INTO `shopper_region` VALUES (3498, '市辖区', 3, 202);
INSERT INTO `shopper_region` VALUES (3499, '市辖区', 3, 203);
INSERT INTO `shopper_region` VALUES (3500, '市辖区', 3, 204);
INSERT INTO `shopper_region` VALUES (3501, '市辖区', 3, 205);
INSERT INTO `shopper_region` VALUES (3502, '市辖区', 3, 206);
INSERT INTO `shopper_region` VALUES (3503, '市辖区', 3, 207);
INSERT INTO `shopper_region` VALUES (3504, '市辖区', 3, 208);
INSERT INTO `shopper_region` VALUES (3505, '市辖区', 3, 209);
INSERT INTO `shopper_region` VALUES (3506, '市辖区', 3, 210);
INSERT INTO `shopper_region` VALUES (3507, '市辖区', 3, 211);
INSERT INTO `shopper_region` VALUES (3508, '市辖区', 3, 214);
INSERT INTO `shopper_region` VALUES (3509, '市辖区', 3, 215);
INSERT INTO `shopper_region` VALUES (3510, '市辖区', 3, 216);
INSERT INTO `shopper_region` VALUES (3511, '市辖区', 3, 217);
INSERT INTO `shopper_region` VALUES (3512, '市辖区', 3, 218);
INSERT INTO `shopper_region` VALUES (3513, '市辖区', 3, 219);
INSERT INTO `shopper_region` VALUES (3514, '市辖区', 3, 220);
INSERT INTO `shopper_region` VALUES (3515, '市辖区', 3, 221);
INSERT INTO `shopper_region` VALUES (3516, '市辖区', 3, 222);
INSERT INTO `shopper_region` VALUES (3517, '市辖区', 3, 223);
INSERT INTO `shopper_region` VALUES (3518, '市辖区', 3, 224);
INSERT INTO `shopper_region` VALUES (3519, '市辖区', 3, 225);
INSERT INTO `shopper_region` VALUES (3520, '市辖区', 3, 226);
INSERT INTO `shopper_region` VALUES (3521, '市辖区', 3, 228);
INSERT INTO `shopper_region` VALUES (3522, '市辖区', 3, 229);
INSERT INTO `shopper_region` VALUES (3523, '市辖区', 3, 230);
INSERT INTO `shopper_region` VALUES (3524, '市辖区', 3, 231);
INSERT INTO `shopper_region` VALUES (3525, '市辖区', 3, 232);
INSERT INTO `shopper_region` VALUES (3526, '市辖区', 3, 233);
INSERT INTO `shopper_region` VALUES (3527, '市辖区', 3, 234);
INSERT INTO `shopper_region` VALUES (3528, '市辖区', 3, 235);
INSERT INTO `shopper_region` VALUES (3529, '市辖区', 3, 236);
INSERT INTO `shopper_region` VALUES (3530, '市辖区', 3, 237);
INSERT INTO `shopper_region` VALUES (3531, '市辖区', 3, 238);
INSERT INTO `shopper_region` VALUES (3532, '市辖区', 3, 239);
INSERT INTO `shopper_region` VALUES (3533, '市辖区', 3, 240);
INSERT INTO `shopper_region` VALUES (3534, '市辖区', 3, 241);
INSERT INTO `shopper_region` VALUES (3535, '市辖区', 3, 242);
INSERT INTO `shopper_region` VALUES (3536, '市辖区', 3, 243);
INSERT INTO `shopper_region` VALUES (3537, '市辖区', 3, 246);
INSERT INTO `shopper_region` VALUES (3538, '市辖区', 3, 247);
INSERT INTO `shopper_region` VALUES (3539, '市辖区', 3, 248);
INSERT INTO `shopper_region` VALUES (3540, '市辖区', 3, 249);
INSERT INTO `shopper_region` VALUES (3541, '市辖区', 3, 250);
INSERT INTO `shopper_region` VALUES (3542, '市辖区', 3, 251);
INSERT INTO `shopper_region` VALUES (3543, '市辖区', 3, 252);
INSERT INTO `shopper_region` VALUES (3544, '市辖区', 3, 253);
INSERT INTO `shopper_region` VALUES (3545, '市辖区', 3, 254);
INSERT INTO `shopper_region` VALUES (3546, '市辖区', 3, 255);
INSERT INTO `shopper_region` VALUES (3547, '市辖区', 3, 256);
INSERT INTO `shopper_region` VALUES (3548, '市辖区', 3, 257);
INSERT INTO `shopper_region` VALUES (3549, '市辖区', 3, 258);
INSERT INTO `shopper_region` VALUES (3550, '市辖区', 3, 259);
INSERT INTO `shopper_region` VALUES (3551, '市辖区', 3, 260);
INSERT INTO `shopper_region` VALUES (3552, '市辖区', 3, 261);
INSERT INTO `shopper_region` VALUES (3553, '市辖区', 3, 262);
INSERT INTO `shopper_region` VALUES (3554, '市辖区', 3, 263);
INSERT INTO `shopper_region` VALUES (3555, '市辖区', 3, 264);
INSERT INTO `shopper_region` VALUES (3556, '市辖区', 3, 269);
INSERT INTO `shopper_region` VALUES (3557, '市辖区', 3, 270);
INSERT INTO `shopper_region` VALUES (3558, '市辖区', 3, 271);
INSERT INTO `shopper_region` VALUES (3559, '市辖区', 3, 272);
INSERT INTO `shopper_region` VALUES (3560, '市辖区', 3, 273);
INSERT INTO `shopper_region` VALUES (3561, '市辖区', 3, 274);
INSERT INTO `shopper_region` VALUES (3562, '市辖区', 3, 275);
INSERT INTO `shopper_region` VALUES (3563, '市辖区', 3, 276);
INSERT INTO `shopper_region` VALUES (3564, '市辖区', 3, 277);
INSERT INTO `shopper_region` VALUES (3565, '市辖区', 3, 278);
INSERT INTO `shopper_region` VALUES (3566, '市辖区', 3, 279);
INSERT INTO `shopper_region` VALUES (3567, '市辖区', 3, 280);
INSERT INTO `shopper_region` VALUES (3568, '市辖区', 3, 281);
INSERT INTO `shopper_region` VALUES (3569, '市辖区', 3, 282);
INSERT INTO `shopper_region` VALUES (3570, '市辖区', 3, 283);
INSERT INTO `shopper_region` VALUES (3571, '市辖区', 3, 284);
INSERT INTO `shopper_region` VALUES (3572, '市辖区', 3, 285);
INSERT INTO `shopper_region` VALUES (3573, '市辖区', 3, 286);
INSERT INTO `shopper_region` VALUES (3574, '市辖区', 3, 290);
INSERT INTO `shopper_region` VALUES (3575, '市辖区', 3, 292);
INSERT INTO `shopper_region` VALUES (3576, '市辖区', 3, 293);
INSERT INTO `shopper_region` VALUES (3577, '市辖区', 3, 294);
INSERT INTO `shopper_region` VALUES (3578, '市辖区', 3, 295);
INSERT INTO `shopper_region` VALUES (3579, '市辖区', 3, 299);
INSERT INTO `shopper_region` VALUES (3580, '市辖区', 3, 300);
INSERT INTO `shopper_region` VALUES (3581, '市辖区', 3, 301);
INSERT INTO `shopper_region` VALUES (3582, '市辖区', 3, 302);
INSERT INTO `shopper_region` VALUES (3583, '市辖区', 3, 303);
INSERT INTO `shopper_region` VALUES (3584, '市辖区', 3, 304);
INSERT INTO `shopper_region` VALUES (3585, '市辖区', 3, 305);
INSERT INTO `shopper_region` VALUES (3586, '市辖区', 3, 306);
INSERT INTO `shopper_region` VALUES (3587, '市辖区', 3, 315);
INSERT INTO `shopper_region` VALUES (3588, '市辖区', 3, 319);
INSERT INTO `shopper_region` VALUES (3589, '市辖区', 3, 322);
INSERT INTO `shopper_region` VALUES (3590, '市辖区', 3, 323);
INSERT INTO `shopper_region` VALUES (3591, '市辖区', 3, 324);
INSERT INTO `shopper_region` VALUES (3592, '市辖区', 3, 325);
INSERT INTO `shopper_region` VALUES (3593, '市辖区', 3, 326);
INSERT INTO `shopper_region` VALUES (3594, '市辖区', 3, 327);
INSERT INTO `shopper_region` VALUES (3595, '市辖区', 3, 328);
INSERT INTO `shopper_region` VALUES (3596, '市辖区', 3, 329);
INSERT INTO `shopper_region` VALUES (3597, '市辖区', 3, 330);
INSERT INTO `shopper_region` VALUES (3598, '市辖区', 3, 331);
INSERT INTO `shopper_region` VALUES (3599, '市辖区', 3, 332);
INSERT INTO `shopper_region` VALUES (3600, '市辖区', 3, 334);
INSERT INTO `shopper_region` VALUES (3601, '市辖区', 3, 335);
INSERT INTO `shopper_region` VALUES (3602, '市辖区', 3, 336);
INSERT INTO `shopper_region` VALUES (3603, '市辖区', 3, 337);
INSERT INTO `shopper_region` VALUES (3604, '市辖区', 3, 338);
INSERT INTO `shopper_region` VALUES (3605, '市辖区', 3, 339);
INSERT INTO `shopper_region` VALUES (3606, '市辖区', 3, 340);
INSERT INTO `shopper_region` VALUES (3607, '市辖区', 3, 341);
INSERT INTO `shopper_region` VALUES (3608, '市辖区', 3, 342);
INSERT INTO `shopper_region` VALUES (3609, '市辖区', 3, 343);
INSERT INTO `shopper_region` VALUES (3610, '市辖区', 3, 346);
INSERT INTO `shopper_region` VALUES (3611, '市辖区', 3, 354);
INSERT INTO `shopper_region` VALUES (3612, '市辖区', 3, 355);
INSERT INTO `shopper_region` VALUES (3613, '市辖区', 3, 356);
INSERT INTO `shopper_region` VALUES (3614, '市辖区', 3, 357);
INSERT INTO `shopper_region` VALUES (3615, '市辖区', 3, 358);
INSERT INTO `shopper_region` VALUES (3616, '市辖区', 3, 359);
INSERT INTO `shopper_region` VALUES (3617, '市辖区', 3, 360);
INSERT INTO `shopper_region` VALUES (3618, '城口县', 3, 374);
INSERT INTO `shopper_region` VALUES (3619, '丰都县', 3, 374);
INSERT INTO `shopper_region` VALUES (3620, '垫江县', 3, 374);
INSERT INTO `shopper_region` VALUES (3621, '忠县', 3, 374);
INSERT INTO `shopper_region` VALUES (3622, '云阳县', 3, 374);
INSERT INTO `shopper_region` VALUES (3623, '奉节县', 3, 374);
INSERT INTO `shopper_region` VALUES (3624, '巫山县', 3, 374);
INSERT INTO `shopper_region` VALUES (3625, '巫溪县', 3, 374);
INSERT INTO `shopper_region` VALUES (3626, '石柱土家族自治县', 3, 374);
INSERT INTO `shopper_region` VALUES (3627, '秀山土家族苗族自治县', 3, 374);
INSERT INTO `shopper_region` VALUES (3628, '酉阳土家族苗族自治县', 3, 374);
INSERT INTO `shopper_region` VALUES (3629, '彭水苗族土家族自治县', 3, 374);

SET FOREIGN_KEY_CHECKS = 1;
