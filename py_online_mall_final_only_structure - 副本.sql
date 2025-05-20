SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户组ID',
  `name` varchar(150) NOT NULL COMMENT '用户组名称',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `name`(`name`) USING BTREE COMMENT '用户组名称唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '用户组';

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `group_id` int(11) NOT NULL COMMENT '用户组ID',
  `permission_id` int(11) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE COMMENT '用户组ID和权限ID联合唯一索引',
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE COMMENT '权限ID索引',
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_permission 表的 id',
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_group 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '用户组权限关联';

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `name` varchar(255) NOT NULL COMMENT '权限名称',
  `content_type_id` int(11) NOT NULL COMMENT '内容类型ID',
  `codename` varchar(100) NOT NULL COMMENT '权限编码名称',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE COMMENT '内容类型ID和权限编码名称联合唯一索引',
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 django_content_type 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '权限';

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `last_login` datetime COMMENT '最后登录时间',
  `is_superuser` tinyint(1) NOT NULL COMMENT '是否为超级用户',
  `username` varchar(150) NOT NULL COMMENT '用户名',
  `first_name` varchar(150) NOT NULL COMMENT '名',
  `last_name` varchar(150) NOT NULL COMMENT '姓',
  `email` varchar(254) NOT NULL COMMENT '邮箱',
  `is_staff` tinyint(1) NOT NULL COMMENT '是否为员工',
  `is_active` tinyint(1) NOT NULL COMMENT '是否激活',
  `date_joined` datetime COMMENT '加入日期',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `username`(`username`) USING BTREE COMMENT '用户名唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '用户';

-- ----------------------------
-- Table structure for auth_user_groups (用户用户组关联)
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `group_id` int(11) NOT NULL COMMENT '用户组ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE COMMENT '用户ID和用户组ID联合唯一索引',
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE COMMENT '用户组ID索引',
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_group 表的 id',
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '用户用户组关联';

-- ----------------------------
-- Table structure for auth_user_user_permissions (用户权限关联)
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `permission_id` int(11) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE COMMENT '用户ID和权限ID联合唯一索引',
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE COMMENT '权限ID索引',
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_permission 表的 id',
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 385 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '用户权限关联';

-- ----------------------------
-- Table structure for commodity_commodityinfos (商品信息)
-- ----------------------------
DROP TABLE IF EXISTS `commodity_commodityinfos`;
CREATE TABLE `commodity_commodityinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `name` varchar(100) NOT NULL COMMENT '商品名称',
  `sezes` varchar(100) NOT NULL COMMENT '商品尺寸',
  `types` varchar(100) NOT NULL COMMENT '商品类型',
  `price` double NOT NULL COMMENT '价格',
  `discount` double NOT NULL COMMENT '折扣',
  `stock` int(11) NOT NULL COMMENT '库存',
  `sold` int(11) NOT NULL COMMENT '已售数量',
  `likes` int(11) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `created` date NOT NULL COMMENT '创建日期',
  `img` varchar(100) NOT NULL COMMENT '商品图片路径',
  `details` varchar(100) NOT NULL COMMENT '商品详情',
  `inventory` int(11) NOT NULL COMMENT '库存量',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键'
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '商品信息';

-- ----------------------------
-- Table structure for commodity_types (商品类型)
-- ----------------------------
DROP TABLE IF EXISTS `commodity_types`;
CREATE TABLE `commodity_types`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '类型ID',
  `firsts` varchar(100) NOT NULL COMMENT '一级分类',
  `seconds` varchar(100) NOT NULL COMMENT '二级分类',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键'
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '商品类型';

-- ----------------------------
-- Table structure for django_admin_log (Django Admin日志)
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `action_time` datetime COMMENT '操作时间',
  `object_id` longtext NULL COMMENT '对象ID',
  `object_repr` varchar(200) NOT NULL COMMENT '对象表示',
  `action_flag` smallint(5) UNSIGNED NOT NULL COMMENT '操作标志',
  `change_message` longtext NOT NULL COMMENT '变更消息',
  `content_type_id` int(11) NULL DEFAULT NULL COMMENT '内容类型ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE COMMENT '内容类型ID索引',
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE COMMENT '用户ID索引',
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 django_content_type 表的 id',
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = 'Django Admin日志';

-- ----------------------------
-- Table structure for django_content_type (Django内容类型)
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '内容类型ID',
  `app_label` varchar(100) NOT NULL COMMENT '应用标签',
  `model` varchar(100) NOT NULL COMMENT '模型名称',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE COMMENT '应用标签和模型名称联合唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = 'Django内容类型';

-- ----------------------------
-- Table structure for django_migrations (Django迁移记录)
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '迁移ID',
  `app` varchar(255) NOT NULL COMMENT '应用名称',
  `name` varchar(255) NOT NULL COMMENT '迁移名称',
  `applied` datetime COMMENT '应用时间',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键'
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = 'Django迁移记录';

-- ----------------------------
-- Table structure for django_session (Django Session)
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) NOT NULL COMMENT 'Session Key',
  `session_data` longtext NOT NULL COMMENT 'Session数据',
  `expire_date` datetime COMMENT '过期日期',
  PRIMARY KEY (`session_key`) USING BTREE COMMENT '主键',
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE COMMENT '过期日期索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = 'Django Session';

-- ----------------------------
-- Table structure for logistics_logisticsorder (物流订单)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_logisticsorder`;
CREATE TABLE `logistics_logisticsorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物流订单ID',
  `tracking_number` varchar(50) NOT NULL COMMENT '追踪单号',
  `carrier` varchar(100) NOT NULL COMMENT '承运商',
  `status` varchar(20) NOT NULL COMMENT '状态',
  `estimated_delivery` date NULL DEFAULT NULL COMMENT '预计送达日期',
  `actual_delivery` date NULL DEFAULT NULL COMMENT '实际送达日期',
  `created_at` datetime COMMENT '创建时间',
  `notes` longtext NULL COMMENT '备注',
  `created_by_id` int(11) NOT NULL COMMENT '创建人ID',
  `destination_address_id` bigint(20) NULL DEFAULT NULL COMMENT '目的地地址ID',
  `order_infos_id` int(11) NULL DEFAULT NULL COMMENT '关联的销售订单ID',
  `origin_address_id` bigint(20) NULL DEFAULT NULL COMMENT '起始地地址ID',
  `outbound_order_id` bigint(20) NULL DEFAULT NULL COMMENT '关联的出库单ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `tracking_number`(`tracking_number`) USING BTREE COMMENT '追踪单号唯一索引',
  INDEX `logistics_logisticsorder_created_by_id_6f555c73_fk_auth_user_id`(`created_by_id`) USING BTREE COMMENT '创建人ID索引',
  INDEX `logistics_logisticso_destination_address__2b0ef79a_fk_shopper_a`(`destination_address_id`) USING BTREE COMMENT '目的地地址ID索引',
  INDEX `logistics_logisticso_order_infos_id_e19763da_fk_shopper_o`(`order_infos_id`) USING BTREE COMMENT '关联的销售订单ID索引',
  INDEX `logistics_logisticso_origin_address_id_8aaa2521_fk_shopper_a`(`origin_address_id`) USING BTREE COMMENT '起始地地址ID索引',
  INDEX `logistics_logisticso_outbound_order_id_d47e11b3_fk_logistics`(`outbound_order_id`) USING BTREE COMMENT '关联的出库单ID索引',
  CONSTRAINT `logistics_logisticso_destination_address__2b0ef79a_fk_shopper_a` FOREIGN KEY (`destination_address_id`) REFERENCES `shopper_addressinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_addressinfos 表的 id (目的地)',
  CONSTRAINT `logistics_logisticso_order_infos_id_e19763da_fk_shopper_o` FOREIGN KEY (`order_infos_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_orderinfos 表的 id',
  CONSTRAINT `logistics_logisticso_origin_address_id_8aaa2521_fk_shopper_a` FOREIGN KEY (`origin_address_id`) REFERENCES `shopper_addressinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_addressinfos 表的 id (起始地)',
  CONSTRAINT `logistics_logisticso_outbound_order_id_d47e11b3_fk_logistics` FOREIGN KEY (`outbound_order_id`) REFERENCES `logistics_outboundorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_outboundorder 表的 id',
  CONSTRAINT `logistics_logisticsorder_created_by_id_6f555c73_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '物流订单';

-- ----------------------------
-- Table structure for logistics_logisticsorderitem (物流订单明细)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_logisticsorderitem`;
CREATE TABLE `logistics_logisticsorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `quantity` int(10) UNSIGNED NOT NULL COMMENT '数量',
  `commodity_id` int(11) NOT NULL COMMENT '商品ID',
  `logistics_order_id` bigint(20) NOT NULL COMMENT '物流订单ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `logistics_logisticsorder_logistics_order_id_commo_5eb97394_uniq`(`logistics_order_id`, `commodity_id`) USING BTREE COMMENT '物流订单ID和商品ID联合唯一索引',
  INDEX `logistics_logisticso_commodity_id_2c7ca148_fk_commodity`(`commodity_id`) USING BTREE COMMENT '商品ID索引',
  CONSTRAINT `logistics_logisticso_commodity_id_2c7ca148_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 commodity_commodityinfos 表的 id',
  CONSTRAINT `logistics_logisticso_logistics_order_id_8d8a3edc_fk_logistics` FOREIGN KEY (`logistics_order_id`) REFERENCES `logistics_logisticsorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_logisticsorder 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '物流订单明细';

-- ----------------------------
-- Table structure for logistics_outboundorder (出库单)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_outboundorder`;
CREATE TABLE `logistics_outboundorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '出库单ID',
  `order_number` varchar(50) NOT NULL COMMENT '出库单号',
  `created_at` datetime COMMENT '创建时间',
  `created_by_id` int(11) NOT NULL COMMENT '创建人ID',
  `notes` longtext NULL COMMENT '备注',
  `outbound_date` datetime COMMENT '出库日期',
  `status` varchar(20) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE COMMENT '出库单号唯一索引',
  INDEX `logistics_outboundorder_created_by_id_afe0b5b1_fk_auth_user_id`(`created_by_id`) USING BTREE COMMENT '创建人ID索引',
  CONSTRAINT `logistics_outboundorder_created_by_id_afe0b5b1_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC COMMENT = '出库单';

-- ----------------------------
-- Table structure for logistics_outboundorder_sales_orders (出库单销售订单关联)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_outboundorder_sales_orders`;
CREATE TABLE `logistics_outboundorder_sales_orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `outboundorder_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `orderinfos_id` int(11) NOT NULL COMMENT '销售订单ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `logistics_outboundorder__outboundorder_id_orderin_9151d7fa_uniq`(`outboundorder_id`, `orderinfos_id`) USING BTREE COMMENT '出库单ID和销售订单ID联合唯一索引',
  INDEX `logistics_outboundor_orderinfos_id_8158dceb_fk_shopper_o`(`orderinfos_id`) USING BTREE COMMENT '销售订单ID索引',
  CONSTRAINT `logistics_outboundor_orderinfos_id_8158dceb_fk_shopper_o` FOREIGN KEY (`orderinfos_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_orderinfos 表的 id',
  CONSTRAINT `logistics_outboundor_outboundorder_id_b7c46474_fk_logistics` FOREIGN KEY (`outboundorder_id`) REFERENCES `logistics_outboundorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_outboundorder 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '出库单销售订单关联';

-- ----------------------------
-- Table structure for logistics_outboundorderitem (出库单明细)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_outboundorderitem`;
CREATE TABLE `logistics_outboundorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `commodity_id` int(11) NOT NULL COMMENT '商品ID',
  `order_number_id` bigint(20) NOT NULL COMMENT '出库单号ID',
  `quantity` int(10) UNSIGNED NOT NULL COMMENT '数量',
  `source_order_id` int(11) NULL DEFAULT NULL COMMENT '源订单ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `logistics_outboundor_commodity_id_6d7b0738_fk_commodity`(`commodity_id`) USING BTREE COMMENT '商品ID索引',
  INDEX `logistics_outboundor_order_number_id_19e6ce04_fk_logistics`(`order_number_id`) USING BTREE COMMENT '出库单号ID索引',
  INDEX `logistics_outboundor_source_order_id_dcadae2d_fk_shopper_o`(`source_order_id`) USING BTREE COMMENT '源订单ID索引',
  CONSTRAINT `logistics_outboundor_commodity_id_6d7b0738_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 commodity_commodityinfos 表的 id',
  CONSTRAINT `logistics_outboundor_order_number_id_19e6ce04_fk_logistics` FOREIGN KEY (`order_number_id`) REFERENCES `logistics_outboundorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_outboundorder 表的 id',
  CONSTRAINT `logistics_outboundor_source_order_id_dcadae2d_fk_shopper_o` FOREIGN KEY (`source_order_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_orderinfos 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC COMMENT = '出库单明细';

-- ----------------------------
-- Table structure for logistics_procurementorder (采购计划单)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_procurementorder`;
CREATE TABLE `logistics_procurementorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '采购计划单ID',
  `order_number` varchar(50) NOT NULL COMMENT '采购计划单号',
  `supplier` varchar(100) NOT NULL COMMENT '供应商',
  `created_at` datetime COMMENT '创建时间',
  `status` varchar(20) NOT NULL COMMENT '状态',
  `created_by_id` int(11) NOT NULL COMMENT '创建人ID',
  `due_date` datetime COMMENT '截止日期',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE COMMENT '采购计划单号唯一索引',
  INDEX `logistics_procuremen_created_by_id_576bce21_fk_auth_user`(`created_by_id`) USING BTREE COMMENT '创建人ID索引',
  CONSTRAINT `logistics_procuremen_created_by_id_576bce21_fk_auth_user` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '采购计划单';

-- ----------------------------
-- Table structure for logistics_procurementorderitem (采购计划单明细)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_procurementorderitem`;
CREATE TABLE `logistics_procurementorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `quantity` int(10) UNSIGNED NOT NULL COMMENT '数量',
  `commodity_id` int(11) NOT NULL COMMENT '商品ID',
  `order_id` bigint(20) NOT NULL COMMENT '采购计划单ID',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `logistics_procuremen_commodity_id_e2ac484e_fk_commodity`(`commodity_id`) USING BTREE COMMENT '商品ID索引',
  INDEX `logistics_procuremen_order_id_e7bbd2e9_fk_logistics`(`order_id`) USING BTREE COMMENT '采购计划单ID索引',
  CONSTRAINT `logistics_procuremen_commodity_id_e2ac484e_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 commodity_commodityinfos 表的 id',
  CONSTRAINT `logistics_procuremen_order_id_e7bbd2e9_fk_logistics` FOREIGN KEY (`order_id`) REFERENCES `logistics_procurementorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_procurementorder 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '采购计划单明细';

-- ----------------------------
-- Table structure for logistics_purchaseorder (采购订单)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchaseorder`;
CREATE TABLE `logistics_purchaseorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '采购订单ID',
  `order_number` varchar(50) NOT NULL COMMENT '采购订单号',
  `supplier` varchar(100) NOT NULL COMMENT '供应商',
  `created_at` datetime COMMENT '创建时间',
  `status` varchar(20) NOT NULL COMMENT '状态',
  `created_by_id` int(11) NOT NULL COMMENT '创建人ID',
  `procurement_plan_id` bigint(20) NULL DEFAULT NULL COMMENT '关联的采购计划单ID',
  `due_date` datetime COMMENT '截止日期',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE COMMENT '采购订单号唯一索引',
  INDEX `logistics_purchaseorder_created_by_id_20212d3e_fk_auth_user_id`(`created_by_id`) USING BTREE COMMENT '创建人ID索引',
  INDEX `logistics_purchaseor_procurement_plan_id_0c6d68ac_fk_logistics`(`procurement_plan_id`) USING BTREE COMMENT '关联的采购计划单ID索引',
  CONSTRAINT `logistics_purchaseor_procurement_plan_id_0c6d68ac_fk_logistics` FOREIGN KEY (`procurement_plan_id`) REFERENCES `logistics_procurementorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_procurementorder 表的 id',
  CONSTRAINT `logistics_purchaseorder_created_by_id_20212d3e_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC COMMENT = '采购订单';

-- ----------------------------
-- Table structure for logistics_purchaseorderitem (采购订单明细)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchaseorderitem`;
CREATE TABLE `logistics_purchaseorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  `quantity_plan` int(10) UNSIGNED NOT NULL COMMENT '计划数量',
  `quantity_actual` int(10) UNSIGNED NOT NULL COMMENT '实际数量',
  `commodity_id` int(11) NOT NULL COMMENT '商品ID',
  `order_id` bigint(20) NOT NULL COMMENT '采购订单ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `logistics_purchaseor_commodity_id_a061b92d_fk_commodity`(`commodity_id`) USING BTREE COMMENT '商品ID索引',
  INDEX `logistics_purchaseor_order_id_ebb83e39_fk_logistics`(`order_id`) USING BTREE COMMENT '采购订单ID索引',
  CONSTRAINT `logistics_purchaseor_commodity_id_a061b92d_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 commodity_commodityinfos 表的 id',
  CONSTRAINT `logistics_purchaseor_order_id_ebb83e39_fk_logistics` FOREIGN KEY (`order_id`) REFERENCES `logistics_purchaseorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_purchaseorder 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '采购订单明细';

-- ----------------------------
-- Table structure for logistics_purchasestockinorder (采购入库单)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchasestockinorder`;
CREATE TABLE `logistics_purchasestockinorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '采购入库单ID',
  `order_number` varchar(50) NOT NULL COMMENT '采购入库单号',
  `created_at` datetime COMMENT '创建时间',
  `notes` longtext NULL COMMENT '备注',
  `status` varchar(20) NOT NULL COMMENT '状态',
  `created_by_id` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE COMMENT '采购入库单号唯一索引',
  INDEX `logistics_purchasest_created_by_id_4ce8d70e_fk_auth_user`(`created_by_id`) USING BTREE COMMENT '创建人ID索引',
  CONSTRAINT `logistics_purchasest_created_by_id_4ce8d70e_fk_auth_user` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '采购入库单';

-- ----------------------------
-- Table structure for logistics_purchasestockinorder_purchase_orders (采购入库单采购订单关联)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchasestockinorder_purchase_orders`;
CREATE TABLE `logistics_purchasestockinorder_purchase_orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `purchasestockinorder_id` bigint(20) NOT NULL COMMENT '采购入库单ID',
  `purchaseorder_id` bigint(20) NOT NULL COMMENT '采购订单ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `logistics_purchasestocki_purchasestockinorder_id__fea330c9_uniq`(`purchasestockinorder_id`, `purchaseorder_id`) USING BTREE COMMENT '采购入库单ID和采购订单ID联合唯一索引',
  INDEX `logistics_purchasest_purchaseorder_id_dd4ffd95_fk_logistics`(`purchaseorder_id`) USING BTREE COMMENT '采购订单ID索引',
  CONSTRAINT `logistics_purchasest_purchaseorder_id_dd4ffd95_fk_logistics` FOREIGN KEY (`purchaseorder_id`) REFERENCES `logistics_purchaseorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_purchaseorder 表的 id',
  CONSTRAINT `logistics_purchasest_purchasestockinorder_40516e44_fk_logistics` FOREIGN KEY (`purchasestockinorder_id`) REFERENCES `logistics_purchasestockinorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_purchasestockinorder 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '采购入库单采购订单关联';

-- ----------------------------
-- Table structure for logistics_purchasestockinorderitem (采购入库单明细)
-- ----------------------------
DROP TABLE IF EXISTS `logistics_purchasestockinorderitem`;
CREATE TABLE `logistics_purchasestockinorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `quantity` int(10) UNSIGNED NOT NULL COMMENT '数量',
  `commodity_id` int(11) NOT NULL COMMENT '商品ID',
  `order_number_id` bigint(20) NOT NULL COMMENT '采购入库单号ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `logistics_purchasestocki_order_number_id_commodit_4b65445c_uniq`(`order_number_id`, `commodity_id`) USING BTREE COMMENT '采购入库单号ID和商品ID联合唯一索引',
  INDEX `logistics_purchasest_commodity_id_4523b3fd_fk_commodity`(`commodity_id`) USING BTREE COMMENT '商品ID索引',
  CONSTRAINT `logistics_purchasest_commodity_id_4523b3fd_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 commodity_commodityinfos 表的 id',
  CONSTRAINT `logistics_purchasest_order_number_id_9d1beb81_fk_logistics` FOREIGN KEY (`order_number_id`) REFERENCES `logistics_purchasestockinorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 logistics_purchasestockinorder 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '采购入库单明细';

-- ----------------------------
-- Table structure for shopper_addressinfos (收货地址信息)
-- ----------------------------
DROP TABLE IF EXISTS `shopper_addressinfos`;
CREATE TABLE `shopper_addressinfos`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `created_at` datetime COMMENT '创建时间',
  `detail` varchar(200) NOT NULL COMMENT '详细地址',
  `is_default` tinyint(1) NOT NULL COMMENT '是否默认地址',
  `city_id` bigint(20) NOT NULL COMMENT '城市ID',
  `district_id` bigint(20) NOT NULL COMMENT '区/县ID',
  `province_id` bigint(20) NOT NULL COMMENT '省份ID',
  `phone_number` bigint(20) NOT NULL COMMENT '电话号码',
  `recipient_name` varchar(50) NOT NULL COMMENT '收件人姓名',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `shopper_addressinfos_user_id_a8203ccf_fk_auth_user_id`(`user_id`) USING BTREE COMMENT '用户ID索引',
  INDEX `shopper_addressinfos_city_id_92d24b61_fk_shopper_region_id`(`city_id`) USING BTREE COMMENT '城市ID索引',
  INDEX `shopper_addressinfos_district_id_05338207_fk_shopper_region_id`(`district_id`) USING BTREE COMMENT '区/县ID索引',
  INDEX `shopper_addressinfos_province_id_2abebb47_fk_shopper_region_id`(`province_id`) USING BTREE COMMENT '省份ID索引',
  CONSTRAINT `shopper_addressinfos_city_id_92d24b61_fk_shopper_region_id` FOREIGN KEY (`city_id`) REFERENCES `shopper_region` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_region 表的 id (城市)',
  CONSTRAINT `shopper_addressinfos_district_id_05338207_fk_shopper_region_id` FOREIGN KEY (`district_id`) REFERENCES `shopper_region` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_region 表的 id (区/县)',
  CONSTRAINT `shopper_addressinfos_province_id_2abebb47_fk_shopper_region_id` FOREIGN KEY (`province_id`) REFERENCES `shopper_region` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_region 表的 id (省份)',
  CONSTRAINT `shopper_addressinfos_user_id_a8203ccf_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC COMMENT = '收货地址信息';

-- ----------------------------
-- Table structure for shopper_cartinfos (购物车信息)
-- ----------------------------
DROP TABLE IF EXISTS `shopper_cartinfos`;
CREATE TABLE `shopper_cartinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车项ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `commodityInfos_id_id` int(11) NULL DEFAULT NULL COMMENT '商品信息ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `shopper_cartinfos_commodityInfos_id_id_68f10ae8`(`commodityInfos_id_id`) USING BTREE COMMENT '商品信息ID索引',
  INDEX `shopper_cartinfos_user_id_abb2b502_fk_auth_user_id`(`user_id`) USING BTREE COMMENT '用户ID索引',
  CONSTRAINT `shopper_cartinfos_commodityInfos_id_id_68f10ae8_fk_commodity` FOREIGN KEY (`commodityInfos_id_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 commodity_commodityinfos 表的 id',
  CONSTRAINT `shopper_cartinfos_user_id_abb2b502_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '购物车信息';

-- ----------------------------
-- Table structure for shopper_orderinfos (订单信息)
-- ----------------------------
DROP TABLE IF EXISTS `shopper_orderinfos`;
CREATE TABLE `shopper_orderinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `price` double NOT NULL COMMENT '订单总价',
  `created` date NOT NULL COMMENT '创建日期',
  `state` varchar(20) NOT NULL COMMENT '订单状态',
  `pay_id` varchar(50) NULL DEFAULT NULL COMMENT '支付单号',
  `refund_id` varchar(50) NULL DEFAULT NULL COMMENT '退款单号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `address_id` bigint(20) NULL DEFAULT NULL COMMENT '收货地址ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `shopper_orderinfos_user_id_c136f6f2_fk_auth_user_id`(`user_id`) USING BTREE COMMENT '用户ID索引',
  INDEX `shopper_orderinfos_address_id_9fb3bb5e_fk_shopper_a`(`address_id`) USING BTREE COMMENT '收货地址ID索引',
  CONSTRAINT `shopper_orderinfos_address_id_9fb3bb5e_fk` FOREIGN KEY (`address_id`) REFERENCES `shopper_addressinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_addressinfos 表的 id',
  CONSTRAINT `shopper_orderinfos_user_id_c136f6f2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC COMMENT = '订单信息';

-- ----------------------------
-- Table structure for shopper_purchaseinfos (购买信息/订单明细)
-- ----------------------------
DROP TABLE IF EXISTS `shopper_purchaseinfos`;
CREATE TABLE `shopper_purchaseinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '购买项ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `commodityInfos_id_id` int(11) NOT NULL COMMENT '商品信息ID',
  `order_id` int(11) NULL DEFAULT NULL COMMENT '关联的订单ID',
  `unit_price` double NOT NULL COMMENT '单价',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `shopper_purchaseinfo_commodityInfos_id_id_85b45edb_fk_commodity`(`commodityInfos_id_id`) USING BTREE COMMENT '商品信息ID索引',
  INDEX `shopper_purchaseinfos_order_id_156be8d0_fk_shopper_orderinfos_id`(`order_id`) USING BTREE COMMENT '关联的订单ID索引',
  CONSTRAINT `shopper_purchaseinfo_commodityInfos_id_id_85b45edb_fk_commodity` FOREIGN KEY (`commodityInfos_id_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 commodity_commodityinfos 表的 id',
  CONSTRAINT `shopper_purchaseinfos_order_id_156be8d0_fk_shopper_orderinfos_id` FOREIGN KEY (`order_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_orderinfos 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC COMMENT = '购买信息/订单明细';

-- ----------------------------
-- Table structure for shopper_refundinfos (退款信息)
-- ----------------------------
DROP TABLE IF EXISTS `shopper_refundinfos`;
CREATE TABLE `shopper_refundinfos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '退款ID',
  `refund_id` varchar(50) NOT NULL COMMENT '退款单号',
  `price` double NOT NULL COMMENT '退款金额',
  `created` date NOT NULL COMMENT '创建日期',
  `state` varchar(20) NOT NULL COMMENT '退款状态',
  `reason` longtext NULL COMMENT '退款原因',
  `attach` varchar(100) NULL DEFAULT NULL COMMENT '附件',
  `order_id` int(11) NOT NULL COMMENT '关联的订单ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `status_before` varchar(20) NULL DEFAULT NULL COMMENT '退款前状态',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `shopper_refundinfos_order_id_1d4e5b94_fk_shopper_orderinfos_id`(`order_id`) USING BTREE COMMENT '关联的订单ID索引',
  INDEX `shopper_refundinfos_user_id_caf0b49d_fk_auth_user_id`(`user_id`) USING BTREE COMMENT '用户ID索引',
  CONSTRAINT `shopper_refundinfos_order_id_1d4e5b94_fk_shopper_orderinfos_id` FOREIGN KEY (`order_id`) REFERENCES `shopper_orderinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_orderinfos 表的 id',
  CONSTRAINT `shopper_refundinfos_user_id_caf0b49d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC COMMENT = '退款信息';

-- ----------------------------
-- Table structure for shopper_refundstockinorder (退货入库单)
-- ----------------------------
DROP TABLE IF EXISTS `shopper_refundstockinorder`;
CREATE TABLE `shopper_refundstockinorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '退货入库单ID',
  `order_number` varchar(50) NOT NULL COMMENT '退货入库单号',
  `created_at` datetime COMMENT '创建时间',
  `notes` longtext NULL COMMENT '备注',
  `status` varchar(20) NOT NULL COMMENT '状态',
  `created_by_id` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE COMMENT '退货入库单号唯一索引',
  INDEX `shopper_refundstocki_created_by_id_f3fed3a6_fk_auth_user`(`created_by_id`) USING BTREE COMMENT '创建人ID索引',
  CONSTRAINT `shopper_refundstocki_created_by_id_f3fed3a6_fk_auth_user` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 auth_user 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '退货入库单';

-- ----------------------------
-- Table structure for shopper_refundstockinorder_refund_orders (退货入库单退款订单关联)
-- ----------------------------
DROP TABLE IF EXISTS `shopper_refundstockinorder_refund_orders`;
CREATE TABLE `shopper_refundstockinorder_refund_orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `refundstockinorder_id` bigint(20) NOT NULL COMMENT '退货入库单ID',
  `refundinfos_id` int(11) NOT NULL COMMENT '退款信息ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `shopper_refundstockinord_refundstockinorder_id_re_9593e9f9_uniq`(`refundstockinorder_id`, `refundinfos_id`) USING BTREE COMMENT '退货入库单ID和退款信息ID联合唯一索引',
  INDEX `shopper_refundstocki_refundinfos_id_64f37795_fk_shopper_r`(`refundinfos_id`) USING BTREE COMMENT '退款信息ID索引',
  CONSTRAINT `shopper_refundstocki_refundinfos_id_64f37795_fk_shopper_r` FOREIGN KEY (`refundinfos_id`) REFERENCES `shopper_refundinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_refundinfos 表的 id',
  CONSTRAINT `shopper_refundstocki_refundstockinorder_i_9d53d14c_fk_shopper_r` FOREIGN KEY (`refundstockinorder_id`) REFERENCES `shopper_refundstockinorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_refundstockinorder 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '退货入库单退款订单关联';

-- ----------------------------
-- Table structure for shopper_refundstockinorderitem (退货入库单明细)
-- ----------------------------
DROP TABLE IF EXISTS `shopper_refundstockinorderitem`;
CREATE TABLE `shopper_refundstockinorderitem`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `quantity` int(10) UNSIGNED NOT NULL COMMENT '数量',
  `commodity_id` int(11) NOT NULL COMMENT '商品ID',
  `order_number_id` bigint(20) NOT NULL COMMENT '退货入库单号ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  UNIQUE INDEX `shopper_refundstockinord_order_number_id_commodit_ea6903a7_uniq`(`order_number_id`, `commodity_id`) USING BTREE COMMENT '退货入库单号ID和商品ID联合唯一索引',
  INDEX `shopper_refundstocki_commodity_id_ef00a7f8_fk_commodity`(`commodity_id`) USING BTREE COMMENT '商品ID索引',
  CONSTRAINT `shopper_refundstocki_commodity_id_ef00a7f8_fk_commodity` FOREIGN KEY (`commodity_id`) REFERENCES `commodity_commodityinfos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 commodity_commodityinfos 表的 id',
  CONSTRAINT `shopper_refundstocki_order_number_id_00bedc98_fk_shopper_r` FOREIGN KEY (`order_number_id`) REFERENCES `shopper_refundstockinorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_refundstockinorder 表的 id'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '退货入库单明细';

-- ----------------------------
-- Table structure for shopper_region (地区信息)
-- ----------------------------
DROP TABLE IF EXISTS `shopper_region`;
CREATE TABLE `shopper_region`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '地区ID',
  `name` varchar(50) NOT NULL COMMENT '地区名称',
  `level` smallint(5) UNSIGNED NOT NULL COMMENT '地区级别',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父级地区ID',
  PRIMARY KEY (`id`) USING BTREE COMMENT '主键',
  INDEX `shopper_region_parent_id_f0f6609f_fk_shopper_region_id`(`parent_id`) USING BTREE COMMENT '父级地区ID索引',
  CONSTRAINT `shopper_region_parent_id_f0f6609f_fk_shopper_region_id` FOREIGN KEY (`parent_id`) REFERENCES `shopper_region` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT COMMENT '外键关联 shopper_region 表的 id (父级)'
) ENGINE = InnoDB AUTO_INCREMENT = 3630 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = '地区信息';

SET FOREIGN_KEY_CHECKS = 1;
