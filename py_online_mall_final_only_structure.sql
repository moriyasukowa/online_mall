
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
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `applied` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE,
  INDEX `shopper_refundstocki_created_by_id_f3fed3a6_fk_auth_user`(`created_by_id`) USING BTREE,
  CONSTRAINT `shopper_refundstocki_created_by_id_f3fed3a6_fk_auth_user` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shopper_refundstockinorder_refund_orders
-- ----------------------------
DROP TABLE IF EXISTS `shopper_refundstockinorder_refund_orders`;
CREATE TABLE `shopper_refundstockinorder_refund_orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `refundstockinorder_id` bigint(20) NOT NULL,
  `refundinfos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shopper_refundstockinord_refundstockinorder_id_re_9593e9f9_uniq`(`refundstockinorder_id`, `refundinfos_id`) USING BTREE,
  INDEX `shopper_refundstocki_refundinfos_id_64f37795_fk_shopper_r`(`refundinfos_id`) USING BTREE,
  CONSTRAINT `shopper_refundstocki_refundinfos_id_64f37795_fk_shopper_r` FOREIGN KEY (`refundinfos_id`) REFERENCES `shopper_refundinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopper_refundstocki_refundstockinorder_i_9d53d14c_fk_shopper_r` FOREIGN KEY (`refundstockinorder_id`) REFERENCES `shopper_refundstockinorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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

SET FOREIGN_KEY_CHECKS = 1;
