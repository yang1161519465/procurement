/*
 Navicat Premium Data Transfer

 Source Server         : 我的阿里云
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : yangxuchen.com:3306
 Source Schema         : xgkx

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 15/09/2021 15:25:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for b_bath
-- ----------------------------
DROP TABLE IF EXISTS `b_bath`;
CREATE TABLE `b_bath`  (
  `bath_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '采购批次id',
  `path_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '批次名称',
  `report_start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始上报时间',
  `report_stop_time` datetime(0) NULL DEFAULT NULL COMMENT '上报结束时间',
  `bath_status` int(255) NULL DEFAULT NULL COMMENT '批次状态：  0: 上报中  1: 采购中  2: 已结束',
  `org_id` int(255) NOT NULL COMMENT '组织机构id',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者  登录名',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者  登录名',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间',
  PRIMARY KEY (`bath_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '采购批次表，' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_bath
-- ----------------------------
INSERT INTO `b_bath` VALUES (1, '2021年第一批次', '2021-06-17 08:00:00', '2021-06-23 15:00:00', 0, 15, 'gyzcglc', '2021-06-16 08:32:49.000000', 'gyzcglc', '2021-06-23 14:28:24.000000');
INSERT INTO `b_bath` VALUES (2, '2021第一批次未填报追加', '2021-09-14 17:00:00', '2021-09-14 17:25:00', 0, 15, 'gyzcglc', '2021-09-14 11:41:15.000000', 'gyzcglc', '2021-09-14 17:16:22.000000');

-- ----------------------------
-- Table structure for b_category
-- ----------------------------
DROP TABLE IF EXISTS `b_category`;
CREATE TABLE `b_category`  (
  `cate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` int(11) NOT NULL COMMENT '父类id，若为0，则是顶级分类',
  `cate_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `seq` int(255) NOT NULL DEFAULT 1 COMMENT '排序序号',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者  登录名',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者  登录名',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间',
  PRIMARY KEY (`cate_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表，树形结构，物品只可以属于叶子分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_category
-- ----------------------------
INSERT INTO `b_category` VALUES (1, 0, '文教用品类', 1, 'admin', '2021-04-29 19:02:02.312414', NULL, '2021-04-29 19:03:39.833361');
INSERT INTO `b_category` VALUES (2, 0, '清洁用品类', 1, 'admin', '2021-04-29 19:03:23.546026', NULL, '2021-04-29 19:03:56.137147');
INSERT INTO `b_category` VALUES (3, 0, '其他办公消耗品', 1, 'admin', '2021-04-29 19:04:03.648454', NULL, '2021-04-29 19:04:03.648454');

-- ----------------------------
-- Table structure for b_demand
-- ----------------------------
DROP TABLE IF EXISTS `b_demand`;
CREATE TABLE `b_demand`  (
  `demand_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '需求id',
  `item_id` int(255) NOT NULL COMMENT '物品id',
  `unit_id` int(11) NOT NULL COMMENT '单位id',
  `count` int(11) NOT NULL COMMENT '需求数量',
  `org_id` int(11) NOT NULL COMMENT '组织id',
  `bath_id` int(11) NOT NULL COMMENT '批次id',
  `is_meet` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否给予',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者  登录名',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者  登录名',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间',
  PRIMARY KEY (`demand_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1217 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '需求表，记录每个批次，每个单位所需求的物品数量' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_demand
-- ----------------------------
INSERT INTO `b_demand` VALUES (8, 2, 2, 10, 2, 1, 0, 'zzb', '2021-06-18 10:22:59.000000', 'zzb', '2021-06-18 10:22:59.000000');
INSERT INTO `b_demand` VALUES (9, 1, 1, 10, 2, 1, 0, 'zzb', '2021-06-18 10:23:13.000000', 'zzb', '2021-06-18 10:23:13.000000');
INSERT INTO `b_demand` VALUES (10, 20, 20, 5, 38, 1, 0, 'xxgcxy', '2021-06-18 10:23:31.000000', 'xxgcxy', '2021-06-18 10:23:31.000000');
INSERT INTO `b_demand` VALUES (11, 11, 11, 2, 2, 1, 0, 'zzb', '2021-06-18 10:24:02.000000', 'zzb', '2021-06-18 10:24:02.000000');
INSERT INTO `b_demand` VALUES (12, 13, 13, 2, 2, 1, 0, 'zzb', '2021-06-18 10:24:29.000000', 'zzb', '2021-06-18 10:24:29.000000');
INSERT INTO `b_demand` VALUES (13, 14, 14, 1, 2, 1, 0, 'zzb', '2021-06-18 10:24:54.000000', 'zzb', '2021-06-18 10:24:54.000000');
INSERT INTO `b_demand` VALUES (14, 16, 16, 1, 2, 1, 0, 'zzb', '2021-06-18 10:25:05.000000', 'zzb', '2021-06-18 10:25:05.000000');
INSERT INTO `b_demand` VALUES (16, 17, 17, 30, 2, 1, 0, 'zzb', '2021-06-18 10:26:50.000000', 'zzb', '2021-06-18 10:28:47.000000');
INSERT INTO `b_demand` VALUES (17, 18, 18, 1, 2, 1, 0, 'zzb', '2021-06-18 10:27:29.000000', 'zzb', '2021-06-18 10:27:29.000000');
INSERT INTO `b_demand` VALUES (18, 57, 57, 30, 38, 1, 0, 'xxgcxy', '2021-06-18 10:27:48.000000', 'xxgcxy', '2021-06-18 10:27:48.000000');
INSERT INTO `b_demand` VALUES (19, 74, 74, 5, 38, 1, 0, 'xxgcxy', '2021-06-18 10:28:27.000000', 'xxgcxy', '2021-06-18 10:28:27.000000');
INSERT INTO `b_demand` VALUES (20, 20, 20, 2, 2, 1, 0, 'zzb', '2021-06-18 10:29:20.000000', 'zzb', '2021-06-18 10:29:20.000000');
INSERT INTO `b_demand` VALUES (21, 76, 76, 5, 38, 1, 0, 'xxgcxy', '2021-06-18 10:29:39.000000', 'xxgcxy', '2021-06-18 10:29:39.000000');
INSERT INTO `b_demand` VALUES (22, 21, 21, 12, 2, 1, 0, 'zzb', '2021-06-18 10:29:59.000000', 'zzb', '2021-06-18 10:29:59.000000');
INSERT INTO `b_demand` VALUES (23, 22, 22, 12, 2, 1, 0, 'zzb', '2021-06-18 10:30:21.000000', 'zzb', '2021-06-18 10:30:21.000000');
INSERT INTO `b_demand` VALUES (24, 115, 115, 20, 38, 1, 0, 'xxgcxy', '2021-06-18 10:30:34.000000', 'xxgcxy', '2021-06-18 10:30:34.000000');
INSERT INTO `b_demand` VALUES (26, 48, 48, 5, 3, 1, 0, 'dwxcb', '2021-06-18 10:31:25.000000', 'dwxcb', '2021-06-18 10:31:25.000000');
INSERT INTO `b_demand` VALUES (27, 50, 50, 5, 3, 1, 0, 'dwxcb', '2021-06-18 10:32:41.000000', 'dwxcb', '2021-06-18 10:32:41.000000');
INSERT INTO `b_demand` VALUES (28, 23, 23, 12, 2, 1, 0, 'zzb', '2021-06-18 10:32:59.000000', 'zzb', '2021-06-18 10:32:59.000000');
INSERT INTO `b_demand` VALUES (29, 64, 64, 2, 3, 1, 0, 'dwxcb', '2021-06-18 10:33:02.000000', 'dwxcb', '2021-06-18 10:33:02.000000');
INSERT INTO `b_demand` VALUES (30, 24, 24, 12, 2, 1, 0, 'zzb', '2021-06-18 10:33:11.000000', 'zzb', '2021-06-18 10:33:11.000000');
INSERT INTO `b_demand` VALUES (31, 25, 25, 30, 2, 1, 0, 'zzb', '2021-06-18 10:34:08.000000', 'zzb', '2021-06-18 10:34:08.000000');
INSERT INTO `b_demand` VALUES (32, 87, 87, 6, 3, 1, 0, 'dwxcb', '2021-06-18 10:34:34.000000', 'dwxcb', '2021-06-18 10:34:34.000000');
INSERT INTO `b_demand` VALUES (33, 26, 26, 12, 2, 1, 0, 'zzb', '2021-06-18 10:34:37.000000', 'zzb', '2021-06-18 10:34:37.000000');
INSERT INTO `b_demand` VALUES (34, 88, 88, 6, 3, 1, 0, 'dwxcb', '2021-06-18 10:34:42.000000', 'dwxcb', '2021-06-18 10:34:42.000000');
INSERT INTO `b_demand` VALUES (35, 91, 91, 2, 3, 1, 0, 'dwxcb', '2021-06-18 10:34:56.000000', 'dwxcb', '2021-06-18 10:34:56.000000');
INSERT INTO `b_demand` VALUES (36, 27, 27, 20, 2, 1, 0, 'zzb', '2021-06-18 10:35:08.000000', 'zzb', '2021-06-18 10:35:08.000000');
INSERT INTO `b_demand` VALUES (37, 114, 114, 2, 3, 1, 0, 'dwxcb', '2021-06-18 10:35:30.000000', 'dwxcb', '2021-06-18 10:35:30.000000');
INSERT INTO `b_demand` VALUES (38, 116, 116, 10, 3, 1, 0, 'dwxcb', '2021-06-18 10:35:43.000000', 'dwxcb', '2021-06-18 10:35:43.000000');
INSERT INTO `b_demand` VALUES (39, 36, 36, 10, 2, 1, 0, 'zzb', '2021-06-18 10:38:39.000000', 'zzb', '2021-06-18 10:38:39.000000');
INSERT INTO `b_demand` VALUES (40, 35, 35, 10, 2, 1, 0, 'zzb', '2021-06-18 10:39:50.000000', 'zzb', '2021-06-18 10:39:50.000000');
INSERT INTO `b_demand` VALUES (41, 37, 37, 10, 2, 1, 0, 'zzb', '2021-06-18 10:40:06.000000', 'zzb', '2021-06-18 10:40:06.000000');
INSERT INTO `b_demand` VALUES (42, 41, 41, 10, 2, 1, 0, 'zzb', '2021-06-18 10:41:02.000000', 'zzb', '2021-06-18 10:41:02.000000');
INSERT INTO `b_demand` VALUES (43, 48, 48, 10, 2, 1, 0, 'zzb', '2021-06-18 10:41:44.000000', 'zzb', '2021-06-18 10:41:44.000000');
INSERT INTO `b_demand` VALUES (44, 6, 6, 8, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:42:22.000000', 'mkszyjxb', '2021-06-18 10:42:22.000000');
INSERT INTO `b_demand` VALUES (45, 125, 125, 5, 2, 1, 0, 'zzb', '2021-06-18 10:42:54.000000', 'zzb', '2021-06-18 15:06:37.000000');
INSERT INTO `b_demand` VALUES (46, 7, 7, 8, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:42:47.000000', 'mkszyjxb', '2021-06-18 10:42:47.000000');
INSERT INTO `b_demand` VALUES (47, 50, 50, 20, 2, 1, 0, 'zzb', '2021-06-18 10:44:00.000000', 'zzb', '2021-06-18 10:44:00.000000');
INSERT INTO `b_demand` VALUES (48, 59, 59, 10, 2, 1, 0, 'zzb', '2021-06-18 10:46:51.000000', 'zzb', '2021-06-18 15:04:37.000000');
INSERT INTO `b_demand` VALUES (49, 60, 60, 6, 2, 1, 0, 'zzb', '2021-06-18 10:47:44.000000', 'zzb', '2021-06-18 10:47:44.000000');
INSERT INTO `b_demand` VALUES (50, 63, 63, 10, 2, 1, 0, 'zzb', '2021-06-18 10:48:15.000000', 'zzb', '2021-06-18 10:48:15.000000');
INSERT INTO `b_demand` VALUES (51, 23, 23, 60, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:48:21.000000', 'mkszyjxb', '2021-06-18 10:48:21.000000');
INSERT INTO `b_demand` VALUES (52, 66, 66, 6, 2, 1, 0, 'zzb', '2021-06-18 10:49:02.000000', 'zzb', '2021-06-18 10:49:02.000000');
INSERT INTO `b_demand` VALUES (53, 24, 24, 60, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:48:50.000000', 'mkszyjxb', '2021-06-18 10:48:50.000000');
INSERT INTO `b_demand` VALUES (54, 67, 67, 6, 2, 1, 0, 'zzb', '2021-06-18 10:49:31.000000', 'zzb', '2021-06-18 10:49:31.000000');
INSERT INTO `b_demand` VALUES (56, 27, 27, 2, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:49:32.000000', 'mkszyjxb', '2021-06-18 10:49:32.000000');
INSERT INTO `b_demand` VALUES (57, 68, 68, 1, 2, 1, 0, 'zzb', '2021-06-18 10:50:15.000000', 'zzb', '2021-06-18 10:50:15.000000');
INSERT INTO `b_demand` VALUES (58, 28, 28, 50, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:50:11.000000', 'mkszyjxb', '2021-06-18 10:50:11.000000');
INSERT INTO `b_demand` VALUES (59, 78, 78, 5, 2, 1, 0, 'zzb', '2021-06-18 10:51:07.000000', 'zzb', '2021-06-18 10:51:07.000000');
INSERT INTO `b_demand` VALUES (60, 32, 32, 100, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:50:53.000000', 'mkszyjxb', '2021-06-18 10:55:23.000000');
INSERT INTO `b_demand` VALUES (61, 31, 31, 20, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:51:21.000000', 'mkszyjxb', '2021-06-18 10:51:21.000000');
INSERT INTO `b_demand` VALUES (62, 28, 28, 50, 38, 1, 0, 'xxgcxy', '2021-06-18 10:52:00.000000', 'xxgcxy', '2021-06-18 10:52:00.000000');
INSERT INTO `b_demand` VALUES (63, 85, 85, 100, 2, 1, 0, 'zzb', '2021-06-18 10:52:11.000000', 'zzb', '2021-06-18 10:52:11.000000');
INSERT INTO `b_demand` VALUES (64, 86, 86, 6, 2, 1, 0, 'zzb', '2021-06-18 10:52:25.000000', 'zzb', '2021-06-18 10:52:25.000000');
INSERT INTO `b_demand` VALUES (65, 87, 87, 6, 2, 1, 0, 'zzb', '2021-06-18 10:52:37.000000', 'zzb', '2021-06-18 10:52:37.000000');
INSERT INTO `b_demand` VALUES (66, 88, 88, 6, 2, 1, 0, 'zzb', '2021-06-18 10:52:44.000000', 'zzb', '2021-06-18 10:52:44.000000');
INSERT INTO `b_demand` VALUES (67, 90, 90, 6, 2, 1, 0, 'zzb', '2021-06-18 10:53:09.000000', 'zzb', '2021-06-18 10:53:09.000000');
INSERT INTO `b_demand` VALUES (68, 92, 92, 6, 2, 1, 0, 'zzb', '2021-06-18 10:53:38.000000', 'zzb', '2021-06-18 10:53:38.000000');
INSERT INTO `b_demand` VALUES (69, 93, 93, 3, 2, 1, 0, 'zzb', '2021-06-18 10:54:15.000000', 'zzb', '2021-06-18 10:54:15.000000');
INSERT INTO `b_demand` VALUES (70, 25, 25, 20, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:54:18.000000', 'mkszyjxb', '2021-06-18 10:54:18.000000');
INSERT INTO `b_demand` VALUES (72, 108, 108, 1, 2, 1, 0, 'zzb', '2021-06-18 10:56:45.000000', 'zzb', '2021-06-18 10:56:45.000000');
INSERT INTO `b_demand` VALUES (73, 37, 37, 100, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:58:52.000000', 'mkszyjxb', '2021-06-18 10:58:52.000000');
INSERT INTO `b_demand` VALUES (74, 41, 41, 50, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:59:28.000000', 'mkszyjxb', '2021-06-18 10:59:28.000000');
INSERT INTO `b_demand` VALUES (75, 39, 39, 30, 46, 1, 0, 'mkszyjxb', '2021-06-18 10:59:46.000000', 'mkszyjxb', '2021-06-18 10:59:46.000000');
INSERT INTO `b_demand` VALUES (76, 48, 48, 20, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:00:15.000000', 'mkszyjxb', '2021-06-18 11:00:15.000000');
INSERT INTO `b_demand` VALUES (77, 126, 126, 10, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:00:56.000000', 'mkszyjxb', '2021-06-18 15:02:41.000000');
INSERT INTO `b_demand` VALUES (78, 60, 60, 5, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:02:41.000000', 'mkszyjxb', '2021-06-18 11:30:05.000000');
INSERT INTO `b_demand` VALUES (79, 63, 63, 10, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:03:22.000000', 'mkszyjxb', '2021-06-18 11:03:22.000000');
INSERT INTO `b_demand` VALUES (80, 69, 69, 60, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:03:54.000000', 'mkszyjxb', '2021-06-18 11:03:54.000000');
INSERT INTO `b_demand` VALUES (81, 74, 74, 2, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:04:47.000000', 'mkszyjxb', '2021-06-18 11:04:47.000000');
INSERT INTO `b_demand` VALUES (82, 59, 59, 10, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:06:11.000000', 'mkszyjxb', '2021-06-18 11:06:11.000000');
INSERT INTO `b_demand` VALUES (83, 58, 58, 8, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:06:26.000000', 'mkszyjxb', '2021-06-18 11:06:26.000000');
INSERT INTO `b_demand` VALUES (84, 81, 81, 5, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:06:58.000000', 'mkszyjxb', '2021-06-18 11:06:58.000000');
INSERT INTO `b_demand` VALUES (85, 82, 82, 5, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:07:23.000000', 'mkszyjxb', '2021-06-18 11:07:23.000000');
INSERT INTO `b_demand` VALUES (86, 83, 83, 5, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:07:35.000000', 'mkszyjxb', '2021-06-18 11:07:35.000000');
INSERT INTO `b_demand` VALUES (87, 86, 86, 30, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:08:09.000000', 'mkszyjxb', '2021-06-18 11:08:36.000000');
INSERT INTO `b_demand` VALUES (88, 87, 87, 20, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:08:54.000000', 'mkszyjxb', '2021-06-18 11:08:54.000000');
INSERT INTO `b_demand` VALUES (89, 88, 88, 20, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:09:06.000000', 'mkszyjxb', '2021-06-18 11:09:06.000000');
INSERT INTO `b_demand` VALUES (90, 89, 89, 5, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:09:37.000000', 'mkszyjxb', '2021-06-18 11:09:37.000000');
INSERT INTO `b_demand` VALUES (91, 94, 94, 10, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:10:36.000000', 'mkszyjxb', '2021-06-18 11:10:36.000000');
INSERT INTO `b_demand` VALUES (92, 96, 96, 10, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:10:56.000000', 'mkszyjxb', '2021-06-18 11:10:56.000000');
INSERT INTO `b_demand` VALUES (93, 91, 91, 10, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:11:43.000000', 'mkszyjxb', '2021-06-18 11:11:43.000000');
INSERT INTO `b_demand` VALUES (94, 107, 107, 2, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:13:05.000000', 'mkszyjxb', '2021-06-18 11:13:05.000000');
INSERT INTO `b_demand` VALUES (95, 102, 102, 2, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:13:14.000000', 'mkszyjxb', '2021-06-18 11:13:14.000000');
INSERT INTO `b_demand` VALUES (96, 101, 101, 8, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:13:53.000000', 'mkszyjxb', '2021-06-18 11:13:53.000000');
INSERT INTO `b_demand` VALUES (97, 112, 112, 10, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:14:40.000000', 'mkszyjxb', '2021-06-18 11:14:40.000000');
INSERT INTO `b_demand` VALUES (98, 110, 110, 5, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:15:09.000000', 'mkszyjxb', '2021-06-18 11:15:09.000000');
INSERT INTO `b_demand` VALUES (99, 116, 116, 40, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:15:49.000000', 'mkszyjxb', '2021-06-18 11:24:28.000000');
INSERT INTO `b_demand` VALUES (100, 115, 115, 30, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:16:13.000000', 'mkszyjxb', '2021-06-18 11:16:13.000000');
INSERT INTO `b_demand` VALUES (101, 98, 98, 1, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:19:27.000000', 'mkszyjxb', '2021-06-18 14:33:31.000000');
INSERT INTO `b_demand` VALUES (102, 98, 98, 1, 2, 1, 0, 'zzb', '2021-06-18 11:26:10.000000', 'zzb', '2021-06-18 11:26:10.000000');
INSERT INTO `b_demand` VALUES (103, 3, 3, 2, 2, 1, 0, 'zzb', '2021-06-18 11:27:36.000000', 'zzb', '2021-06-18 11:27:36.000000');
INSERT INTO `b_demand` VALUES (106, 3, 3, 10, 46, 1, 0, 'mkszyjxb', '2021-06-18 11:33:39.000000', 'mkszyjxb', '2021-06-18 11:42:23.000000');
INSERT INTO `b_demand` VALUES (108, 126, 126, 6, 2, 1, 0, 'zzb', '2021-06-18 15:10:14.000000', 'zzb', '2021-06-18 15:10:14.000000');
INSERT INTO `b_demand` VALUES (109, 123, 123, 2, 2, 1, 0, 'zzb', '2021-06-18 15:13:04.000000', 'zzb', '2021-06-18 15:13:04.000000');
INSERT INTO `b_demand` VALUES (110, 122, 122, 1, 2, 1, 0, 'zzb', '2021-06-18 15:13:14.000000', 'zzb', '2021-06-18 15:13:14.000000');
INSERT INTO `b_demand` VALUES (111, 121, 121, 1, 2, 1, 0, 'zzb', '2021-06-18 15:13:20.000000', 'zzb', '2021-06-18 15:13:20.000000');
INSERT INTO `b_demand` VALUES (112, 10, 10, 2, 2, 1, 0, 'zzb', '2021-06-18 15:14:07.000000', 'zzb', '2021-06-18 15:14:07.000000');
INSERT INTO `b_demand` VALUES (114, 95, 95, 1, 2, 1, 0, 'zzb', '2021-06-18 15:15:14.000000', 'zzb', '2021-06-18 15:15:14.000000');
INSERT INTO `b_demand` VALUES (115, 115, 115, 250, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:18:29.000000', 'xdjyjszx', '2021-06-18 15:18:29.000000');
INSERT INTO `b_demand` VALUES (116, 107, 107, 1, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:19:06.000000', 'xdjyjszx', '2021-06-18 15:19:06.000000');
INSERT INTO `b_demand` VALUES (117, 98, 98, 2, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:20:10.000000', 'xdjyjszx', '2021-06-18 15:20:10.000000');
INSERT INTO `b_demand` VALUES (118, 97, 97, 10, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:20:33.000000', 'xdjyjszx', '2021-06-18 15:20:33.000000');
INSERT INTO `b_demand` VALUES (119, 103, 103, 20, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:22:49.000000', 'xdjyjszx', '2021-06-18 15:55:29.000000');
INSERT INTO `b_demand` VALUES (120, 112, 112, 10, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:23:34.000000', 'xdjyjszx', '2021-06-18 15:53:51.000000');
INSERT INTO `b_demand` VALUES (122, 83, 83, 15, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:26:09.000000', 'xdjyjszx', '2021-06-18 15:26:09.000000');
INSERT INTO `b_demand` VALUES (123, 84, 84, 10, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:26:39.000000', 'xdjyjszx', '2021-06-18 15:26:39.000000');
INSERT INTO `b_demand` VALUES (124, 81, 81, 5, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:27:07.000000', 'xdjyjszx', '2021-06-18 15:27:07.000000');
INSERT INTO `b_demand` VALUES (125, 86, 86, 45, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:27:47.000000', 'xdjyjszx', '2021-06-18 15:27:47.000000');
INSERT INTO `b_demand` VALUES (126, 87, 87, 45, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:27:57.000000', 'xdjyjszx', '2021-06-18 15:27:57.000000');
INSERT INTO `b_demand` VALUES (127, 88, 88, 45, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:28:18.000000', 'xdjyjszx', '2021-06-18 15:28:18.000000');
INSERT INTO `b_demand` VALUES (128, 89, 89, 45, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:28:28.000000', 'xdjyjszx', '2021-06-18 15:28:28.000000');
INSERT INTO `b_demand` VALUES (129, 93, 93, 10, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:28:54.000000', 'xdjyjszx', '2021-06-18 15:28:54.000000');
INSERT INTO `b_demand` VALUES (130, 94, 94, 10, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:29:28.000000', 'xdjyjszx', '2021-06-18 15:29:28.000000');
INSERT INTO `b_demand` VALUES (131, 96, 96, 1, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:29:43.000000', 'xdjyjszx', '2021-06-21 09:55:04.000000');
INSERT INTO `b_demand` VALUES (133, 92, 92, 10, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:31:03.000000', 'xdjyjszx', '2021-06-18 15:31:03.000000');
INSERT INTO `b_demand` VALUES (134, 1, 1, 10, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:31:47.000000', 'xdjyjszx', '2021-06-21 09:55:54.000000');
INSERT INTO `b_demand` VALUES (135, 20, 20, 1, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:32:14.000000', 'xdjyjszx', '2021-06-21 09:53:31.000000');
INSERT INTO `b_demand` VALUES (136, 18, 18, 1, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:32:32.000000', 'xdjyjszx', '2021-06-21 09:50:21.000000');
INSERT INTO `b_demand` VALUES (137, 1, 1, 5, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:33:12.000000', 'sysjjxzx', '2021-06-18 15:33:12.000000');
INSERT INTO `b_demand` VALUES (138, 11, 11, 2, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:33:28.000000', 'sysjjxzx', '2021-06-18 15:33:28.000000');
INSERT INTO `b_demand` VALUES (139, 19, 19, 1, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:33:44.000000', 'sysjjxzx', '2021-06-18 15:33:44.000000');
INSERT INTO `b_demand` VALUES (140, 27, 27, 5, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:33:36.000000', 'xdjyjszx', '2021-06-21 09:52:15.000000');
INSERT INTO `b_demand` VALUES (141, 32, 32, 50, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:34:50.000000', 'sysjjxzx', '2021-06-18 15:34:50.000000');
INSERT INTO `b_demand` VALUES (142, 40, 40, 20, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:35:10.000000', 'sysjjxzx', '2021-06-18 15:35:10.000000');
INSERT INTO `b_demand` VALUES (143, 43, 43, 1, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:37:11.000000', 'sysjjxzx', '2021-06-18 15:37:11.000000');
INSERT INTO `b_demand` VALUES (144, 48, 48, 10, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:37:43.000000', 'sysjjxzx', '2021-06-18 15:38:09.000000');
INSERT INTO `b_demand` VALUES (145, 58, 58, 2, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:38:52.000000', 'sysjjxzx', '2021-06-18 15:38:52.000000');
INSERT INTO `b_demand` VALUES (146, 63, 63, 2, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:39:00.000000', 'sysjjxzx', '2021-06-18 15:39:00.000000');
INSERT INTO `b_demand` VALUES (147, 64, 64, 5, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:39:30.000000', 'sysjjxzx', '2021-06-18 15:39:30.000000');
INSERT INTO `b_demand` VALUES (148, 67, 67, 3, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:39:43.000000', 'sysjjxzx', '2021-06-18 15:39:43.000000');
INSERT INTO `b_demand` VALUES (149, 37, 37, 20, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:39:29.000000', 'xdjyjszx', '2021-06-18 15:39:29.000000');
INSERT INTO `b_demand` VALUES (150, 68, 68, 3, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:39:51.000000', 'sysjjxzx', '2021-06-18 15:39:51.000000');
INSERT INTO `b_demand` VALUES (151, 39, 39, 20, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:39:47.000000', 'xdjyjszx', '2021-06-18 15:39:47.000000');
INSERT INTO `b_demand` VALUES (152, 124, 124, 5, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:40:18.000000', 'sysjjxzx', '2021-06-18 15:40:18.000000');
INSERT INTO `b_demand` VALUES (153, 125, 125, 5, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:40:25.000000', 'sysjjxzx', '2021-06-18 15:40:25.000000');
INSERT INTO `b_demand` VALUES (154, 126, 126, 1, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:40:36.000000', 'sysjjxzx', '2021-06-18 15:40:36.000000');
INSERT INTO `b_demand` VALUES (155, 46, 46, 4, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:40:37.000000', 'xdjyjszx', '2021-06-18 15:40:37.000000');
INSERT INTO `b_demand` VALUES (156, 31, 31, 10, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:41:09.000000', 'sysjjxzx', '2021-06-18 15:41:09.000000');
INSERT INTO `b_demand` VALUES (157, 45, 45, 4, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:41:21.000000', 'xdjyjszx', '2021-06-18 15:41:21.000000');
INSERT INTO `b_demand` VALUES (158, 82, 82, 1, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:42:12.000000', 'sysjjxzx', '2021-06-18 15:42:12.000000');
INSERT INTO `b_demand` VALUES (159, 48, 48, 10, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:42:03.000000', 'xdjyjszx', '2021-06-18 15:42:03.000000');
INSERT INTO `b_demand` VALUES (160, 83, 83, 1, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:42:19.000000', 'sysjjxzx', '2021-06-18 15:42:19.000000');
INSERT INTO `b_demand` VALUES (161, 84, 84, 3, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:42:32.000000', 'sysjjxzx', '2021-06-18 15:42:32.000000');
INSERT INTO `b_demand` VALUES (162, 52, 52, 2, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:42:36.000000', 'xdjyjszx', '2021-06-18 15:42:36.000000');
INSERT INTO `b_demand` VALUES (163, 126, 126, 5, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:43:19.000000', 'xdjyjszx', '2021-06-18 15:43:19.000000');
INSERT INTO `b_demand` VALUES (164, 51, 51, 2, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:43:37.000000', 'xdjyjszx', '2021-06-18 15:43:37.000000');
INSERT INTO `b_demand` VALUES (165, 95, 95, 20, 38, 1, 0, 'xxgcxy', '2021-06-18 15:44:04.000000', 'xxgcxy', '2021-06-18 15:44:04.000000');
INSERT INTO `b_demand` VALUES (166, 91, 91, 3, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:44:45.000000', 'sysjjxzx', '2021-06-18 15:44:45.000000');
INSERT INTO `b_demand` VALUES (167, 92, 92, 7, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:45:01.000000', 'sysjjxzx', '2021-06-18 15:45:01.000000');
INSERT INTO `b_demand` VALUES (168, 58, 58, 5, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:44:54.000000', 'xdjyjszx', '2021-06-18 15:44:54.000000');
INSERT INTO `b_demand` VALUES (169, 93, 93, 2, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:45:14.000000', 'sysjjxzx', '2021-06-18 15:45:14.000000');
INSERT INTO `b_demand` VALUES (170, 1, 1, 30, 32, 1, 0, 'ysxy', '2021-06-18 15:44:59.000000', 'ysxy', '2021-06-18 15:44:59.000000');
INSERT INTO `b_demand` VALUES (171, 59, 59, 5, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:45:02.000000', 'xdjyjszx', '2021-06-18 15:45:02.000000');
INSERT INTO `b_demand` VALUES (172, 57, 57, 5, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:45:11.000000', 'xdjyjszx', '2021-06-18 15:45:11.000000');
INSERT INTO `b_demand` VALUES (173, 60, 60, 5, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:45:36.000000', 'xdjyjszx', '2021-06-18 15:45:36.000000');
INSERT INTO `b_demand` VALUES (174, 63, 63, 5, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:45:49.000000', 'xdjyjszx', '2021-06-18 15:45:49.000000');
INSERT INTO `b_demand` VALUES (175, 66, 66, 2, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:46:21.000000', 'xdjyjszx', '2021-06-18 15:46:21.000000');
INSERT INTO `b_demand` VALUES (176, 96, 96, 70, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:47:04.000000', 'sysjjxzx', '2021-06-18 15:47:04.000000');
INSERT INTO `b_demand` VALUES (177, 4, 4, 10, 32, 1, 0, 'ysxy', '2021-06-18 15:47:02.000000', 'ysxy', '2021-06-18 15:47:02.000000');
INSERT INTO `b_demand` VALUES (178, 69, 69, 10, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:47:43.000000', 'xdjyjszx', '2021-06-18 15:47:43.000000');
INSERT INTO `b_demand` VALUES (179, 94, 94, 1, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:48:36.000000', 'sysjjxzx', '2021-06-18 15:48:36.000000');
INSERT INTO `b_demand` VALUES (180, 115, 115, 55, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:49:55.000000', 'sysjjxzx', '2021-06-18 15:49:55.000000');
INSERT INTO `b_demand` VALUES (181, 68, 68, 1, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:49:50.000000', 'xdjyjszx', '2021-06-21 09:48:55.000000');
INSERT INTO `b_demand` VALUES (182, 116, 116, 55, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:50:13.000000', 'sysjjxzx', '2021-06-18 15:50:13.000000');
INSERT INTO `b_demand` VALUES (183, 72, 72, 1, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:50:09.000000', 'xdjyjszx', '2021-06-18 15:50:09.000000');
INSERT INTO `b_demand` VALUES (184, 86, 86, 20, 38, 1, 0, 'xxgcxy', '2021-06-18 15:52:12.000000', 'xxgcxy', '2021-06-18 15:52:12.000000');
INSERT INTO `b_demand` VALUES (185, 87, 87, 20, 38, 1, 0, 'xxgcxy', '2021-06-18 15:52:31.000000', 'xxgcxy', '2021-06-18 15:52:31.000000');
INSERT INTO `b_demand` VALUES (186, 85, 85, 20, 26, 1, 0, 'sysjjxzx', '2021-06-18 15:53:03.000000', 'sysjjxzx', '2021-06-18 15:53:03.000000');
INSERT INTO `b_demand` VALUES (187, 82, 82, 15, 24, 1, 0, 'xdjyjszx', '2021-06-18 15:59:24.000000', 'xdjyjszx', '2021-06-18 15:59:24.000000');
INSERT INTO `b_demand` VALUES (188, 1, 1, 10, 42, 1, 0, 'bsyclxy', '2021-06-18 16:03:43.000000', 'bsyclxy', '2021-06-18 16:12:24.000000');
INSERT INTO `b_demand` VALUES (189, 5, 5, 5, 42, 1, 0, 'bsyclxy', '2021-06-18 16:06:09.000000', 'bsyclxy', '2021-06-18 16:06:09.000000');
INSERT INTO `b_demand` VALUES (190, 4, 4, 5, 42, 1, 0, 'bsyclxy', '2021-06-18 16:06:18.000000', 'bsyclxy', '2021-06-18 16:06:18.000000');
INSERT INTO `b_demand` VALUES (191, 18, 18, 1, 32, 1, 0, 'ysxy', '2021-06-18 16:07:29.000000', 'ysxy', '2021-06-18 16:07:29.000000');
INSERT INTO `b_demand` VALUES (192, 19, 19, 1, 32, 1, 0, 'ysxy', '2021-06-18 16:07:50.000000', 'ysxy', '2021-06-18 16:07:50.000000');
INSERT INTO `b_demand` VALUES (193, 24, 24, 5, 32, 1, 0, 'ysxy', '2021-06-18 16:08:47.000000', 'ysxy', '2021-06-18 16:08:47.000000');
INSERT INTO `b_demand` VALUES (194, 20, 20, 2, 42, 1, 0, 'bsyclxy', '2021-06-18 16:09:15.000000', 'bsyclxy', '2021-06-18 16:09:15.000000');
INSERT INTO `b_demand` VALUES (195, 32, 32, 100, 32, 1, 0, 'ysxy', '2021-06-18 16:09:33.000000', 'ysxy', '2021-06-18 16:09:33.000000');
INSERT INTO `b_demand` VALUES (196, 46, 46, 2, 32, 1, 0, 'ysxy', '2021-06-18 16:10:10.000000', 'ysxy', '2021-06-18 16:10:10.000000');
INSERT INTO `b_demand` VALUES (197, 69, 69, 2, 32, 1, 0, 'ysxy', '2021-06-18 16:13:48.000000', 'ysxy', '2021-06-18 16:13:48.000000');
INSERT INTO `b_demand` VALUES (198, 70, 70, 5, 32, 1, 0, 'ysxy', '2021-06-18 16:14:24.000000', 'ysxy', '2021-06-18 16:14:24.000000');
INSERT INTO `b_demand` VALUES (199, 74, 74, 2, 32, 1, 0, 'ysxy', '2021-06-18 16:15:31.000000', 'ysxy', '2021-06-18 16:15:31.000000');
INSERT INTO `b_demand` VALUES (200, 75, 75, 1, 32, 1, 0, 'ysxy', '2021-06-18 16:15:49.000000', 'ysxy', '2021-06-18 16:15:49.000000');
INSERT INTO `b_demand` VALUES (201, 76, 76, 1, 32, 1, 0, 'ysxy', '2021-06-18 16:16:02.000000', 'ysxy', '2021-06-18 16:16:02.000000');
INSERT INTO `b_demand` VALUES (202, 125, 125, 50, 32, 1, 0, 'ysxy', '2021-06-18 16:16:56.000000', 'ysxy', '2021-06-18 16:16:56.000000');
INSERT INTO `b_demand` VALUES (203, 126, 126, 25, 32, 1, 0, 'ysxy', '2021-06-18 16:17:53.000000', 'ysxy', '2021-06-18 16:17:53.000000');
INSERT INTO `b_demand` VALUES (204, 23, 23, 100, 42, 1, 0, 'bsyclxy', '2021-06-18 16:19:58.000000', 'bsyclxy', '2021-06-18 16:19:58.000000');
INSERT INTO `b_demand` VALUES (205, 58, 58, 1, 32, 1, 0, 'ysxy', '2021-06-18 16:20:27.000000', 'ysxy', '2021-06-18 16:20:27.000000');
INSERT INTO `b_demand` VALUES (206, 24, 24, 60, 42, 1, 0, 'bsyclxy', '2021-06-18 16:20:32.000000', 'bsyclxy', '2021-06-18 16:20:32.000000');
INSERT INTO `b_demand` VALUES (207, 57, 57, 1, 32, 1, 0, 'ysxy', '2021-06-18 16:20:36.000000', 'ysxy', '2021-06-18 16:20:36.000000');
INSERT INTO `b_demand` VALUES (208, 51, 51, 1, 32, 1, 0, 'ysxy', '2021-06-18 16:21:13.000000', 'ysxy', '2021-06-18 16:21:13.000000');
INSERT INTO `b_demand` VALUES (209, 28, 28, 50, 42, 1, 0, 'bsyclxy', '2021-06-18 16:21:40.000000', 'bsyclxy', '2021-06-18 16:21:40.000000');
INSERT INTO `b_demand` VALUES (210, 31, 31, 10, 42, 1, 0, 'bsyclxy', '2021-06-18 16:22:00.000000', 'bsyclxy', '2021-06-18 16:22:00.000000');
INSERT INTO `b_demand` VALUES (211, 32, 32, 100, 42, 1, 0, 'bsyclxy', '2021-06-18 16:22:17.000000', 'bsyclxy', '2021-06-18 16:22:17.000000');
INSERT INTO `b_demand` VALUES (212, 48, 48, 5, 42, 1, 0, 'bsyclxy', '2021-06-18 16:22:43.000000', 'bsyclxy', '2021-06-18 16:22:43.000000');
INSERT INTO `b_demand` VALUES (213, 50, 50, 30, 42, 1, 0, 'bsyclxy', '2021-06-18 16:23:11.000000', 'bsyclxy', '2021-06-18 16:23:11.000000');
INSERT INTO `b_demand` VALUES (214, 52, 52, 5, 42, 1, 0, 'bsyclxy', '2021-06-18 16:23:34.000000', 'bsyclxy', '2021-06-18 16:23:34.000000');
INSERT INTO `b_demand` VALUES (215, 56, 56, 5, 42, 1, 0, 'bsyclxy', '2021-06-18 16:23:57.000000', 'bsyclxy', '2021-06-18 16:23:57.000000');
INSERT INTO `b_demand` VALUES (216, 58, 58, 5, 42, 1, 0, 'bsyclxy', '2021-06-18 16:24:23.000000', 'bsyclxy', '2021-06-18 16:24:23.000000');
INSERT INTO `b_demand` VALUES (217, 59, 59, 3, 42, 1, 0, 'bsyclxy', '2021-06-18 16:24:38.000000', 'bsyclxy', '2021-06-18 16:24:38.000000');
INSERT INTO `b_demand` VALUES (218, 67, 67, 20, 42, 1, 0, 'bsyclxy', '2021-06-18 16:25:02.000000', 'bsyclxy', '2021-06-18 16:25:02.000000');
INSERT INTO `b_demand` VALUES (219, 68, 68, 5, 42, 1, 0, 'bsyclxy', '2021-06-18 16:25:17.000000', 'bsyclxy', '2021-06-18 16:26:06.000000');
INSERT INTO `b_demand` VALUES (220, 78, 78, 2, 42, 1, 0, 'bsyclxy', '2021-06-18 16:26:41.000000', 'bsyclxy', '2021-06-18 16:26:41.000000');
INSERT INTO `b_demand` VALUES (221, 121, 121, 2, 42, 1, 0, 'bsyclxy', '2021-06-18 16:26:54.000000', 'bsyclxy', '2021-06-18 16:26:54.000000');
INSERT INTO `b_demand` VALUES (222, 124, 124, 10, 42, 1, 0, 'bsyclxy', '2021-06-18 16:28:23.000000', 'bsyclxy', '2021-06-18 16:28:23.000000');
INSERT INTO `b_demand` VALUES (223, 1, 1, 26, 38, 1, 0, 'xxgcxy', '2021-06-18 16:29:54.000000', 'xxgcxy', '2021-06-18 16:29:54.000000');
INSERT INTO `b_demand` VALUES (224, 121, 121, 10, 38, 1, 0, 'xxgcxy', '2021-06-18 16:30:27.000000', 'xxgcxy', '2021-06-18 16:30:27.000000');
INSERT INTO `b_demand` VALUES (225, 116, 116, 40, 38, 1, 0, 'xxgcxy', '2021-06-18 16:31:40.000000', 'xxgcxy', '2021-06-18 16:31:40.000000');
INSERT INTO `b_demand` VALUES (231, 1, 1, 20, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:45:14.000000', 'csdzygcxy', '2021-06-18 16:45:14.000000');
INSERT INTO `b_demand` VALUES (232, 4, 4, 10, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:45:40.000000', 'csdzygcxy', '2021-06-18 16:45:40.000000');
INSERT INTO `b_demand` VALUES (233, 85, 85, 20, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:46:24.000000', 'csdzygcxy', '2021-06-18 16:46:24.000000');
INSERT INTO `b_demand` VALUES (234, 86, 86, 130, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:47:31.000000', 'csdzygcxy', '2021-06-18 16:47:31.000000');
INSERT INTO `b_demand` VALUES (235, 87, 87, 100, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:48:03.000000', 'csdzygcxy', '2021-06-18 16:48:03.000000');
INSERT INTO `b_demand` VALUES (236, 94, 94, 8, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:48:34.000000', 'csdzygcxy', '2021-06-22 08:52:59.000000');
INSERT INTO `b_demand` VALUES (237, 89, 89, 16, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:49:49.000000', 'csdzygcxy', '2021-06-18 16:49:49.000000');
INSERT INTO `b_demand` VALUES (238, 118, 118, 1, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:50:58.000000', 'csdzygcxy', '2021-06-18 16:50:58.000000');
INSERT INTO `b_demand` VALUES (239, 112, 112, 1, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:51:19.000000', 'csdzygcxy', '2021-06-18 16:51:19.000000');
INSERT INTO `b_demand` VALUES (240, 100, 100, 2, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:52:10.000000', 'csdzygcxy', '2021-06-18 16:52:10.000000');
INSERT INTO `b_demand` VALUES (241, 104, 104, 10, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:52:52.000000', 'csdzygcxy', '2021-06-18 16:52:52.000000');
INSERT INTO `b_demand` VALUES (242, 76, 76, 5, 47, 1, 0, 'csdzygcxy', '2021-06-18 16:53:38.000000', 'csdzygcxy', '2021-06-18 16:53:38.000000');
INSERT INTO `b_demand` VALUES (243, 1, 1, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:54:39.000000', 'gdjsyjs', '2021-06-18 17:27:09.000000');
INSERT INTO `b_demand` VALUES (244, 5, 5, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:54:53.000000', 'gdjsyjs', '2021-06-18 17:27:47.000000');
INSERT INTO `b_demand` VALUES (245, 17, 17, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:55:16.000000', 'gdjsyjs', '2021-06-18 16:55:16.000000');
INSERT INTO `b_demand` VALUES (246, 18, 18, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:55:33.000000', 'gdjsyjs', '2021-06-18 17:35:56.000000');
INSERT INTO `b_demand` VALUES (247, 19, 19, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:55:39.000000', 'gdjsyjs', '2021-06-18 17:35:38.000000');
INSERT INTO `b_demand` VALUES (248, 20, 20, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:55:56.000000', 'gdjsyjs', '2021-06-18 17:34:22.000000');
INSERT INTO `b_demand` VALUES (249, 21, 21, 10, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:56:08.000000', 'gdjsyjs', '2021-06-18 16:56:08.000000');
INSERT INTO `b_demand` VALUES (250, 32, 32, 20, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:56:25.000000', 'gdjsyjs', '2021-06-18 16:56:25.000000');
INSERT INTO `b_demand` VALUES (251, 39, 39, 10, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:56:43.000000', 'gdjsyjs', '2021-06-18 16:56:43.000000');
INSERT INTO `b_demand` VALUES (252, 41, 41, 10, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:56:58.000000', 'gdjsyjs', '2021-06-18 16:56:58.000000');
INSERT INTO `b_demand` VALUES (253, 46, 46, 5, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:57:13.000000', 'gdjsyjs', '2021-06-18 16:57:13.000000');
INSERT INTO `b_demand` VALUES (254, 47, 47, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:57:34.000000', 'gdjsyjs', '2021-06-18 16:57:34.000000');
INSERT INTO `b_demand` VALUES (255, 48, 48, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:58:00.000000', 'gdjsyjs', '2021-06-18 16:58:00.000000');
INSERT INTO `b_demand` VALUES (256, 49, 49, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:58:19.000000', 'gdjsyjs', '2021-06-18 16:58:19.000000');
INSERT INTO `b_demand` VALUES (257, 52, 52, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:58:38.000000', 'gdjsyjs', '2021-06-18 16:58:38.000000');
INSERT INTO `b_demand` VALUES (258, 56, 56, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:58:56.000000', 'gdjsyjs', '2021-06-18 16:58:56.000000');
INSERT INTO `b_demand` VALUES (259, 57, 57, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:59:03.000000', 'gdjsyjs', '2021-06-18 16:59:03.000000');
INSERT INTO `b_demand` VALUES (260, 58, 58, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:59:09.000000', 'gdjsyjs', '2021-06-18 16:59:09.000000');
INSERT INTO `b_demand` VALUES (261, 59, 59, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 16:59:14.000000', 'gdjsyjs', '2021-06-18 16:59:14.000000');
INSERT INTO `b_demand` VALUES (262, 62, 62, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:00:41.000000', 'gdjsyjs', '2021-06-18 17:00:41.000000');
INSERT INTO `b_demand` VALUES (263, 67, 67, 3, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:01:01.000000', 'gdjsyjs', '2021-06-18 17:01:01.000000');
INSERT INTO `b_demand` VALUES (264, 68, 68, 3, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:01:07.000000', 'gdjsyjs', '2021-06-18 17:01:07.000000');
INSERT INTO `b_demand` VALUES (265, 69, 69, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:01:19.000000', 'gdjsyjs', '2021-06-18 17:01:19.000000');
INSERT INTO `b_demand` VALUES (266, 100, 100, 1, 16, 1, 0, 'xyghjsc', '2021-06-18 17:01:23.000000', 'xyghjsc', '2021-06-18 17:01:23.000000');
INSERT INTO `b_demand` VALUES (267, 74, 74, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:01:49.000000', 'gdjsyjs', '2021-06-18 17:01:49.000000');
INSERT INTO `b_demand` VALUES (268, 121, 121, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:02:14.000000', 'gdjsyjs', '2021-06-18 17:29:03.000000');
INSERT INTO `b_demand` VALUES (269, 124, 124, 3, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:02:29.000000', 'gdjsyjs', '2021-06-18 17:02:29.000000');
INSERT INTO `b_demand` VALUES (270, 125, 125, 3, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:02:35.000000', 'gdjsyjs', '2021-06-18 17:02:35.000000');
INSERT INTO `b_demand` VALUES (271, 126, 126, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:02:48.000000', 'gdjsyjs', '2021-06-18 17:02:48.000000');
INSERT INTO `b_demand` VALUES (272, 66, 66, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:05:14.000000', 'gdjsyjs', '2021-06-18 17:05:14.000000');
INSERT INTO `b_demand` VALUES (274, 82, 82, 3, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:06:49.000000', 'gdjsyjs', '2021-06-18 17:06:49.000000');
INSERT INTO `b_demand` VALUES (275, 83, 83, 3, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:06:55.000000', 'gdjsyjs', '2021-06-18 17:06:55.000000');
INSERT INTO `b_demand` VALUES (276, 84, 84, 3, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:07:00.000000', 'gdjsyjs', '2021-06-18 17:07:00.000000');
INSERT INTO `b_demand` VALUES (277, 85, 85, 5, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:07:19.000000', 'gdjsyjs', '2021-06-18 17:07:19.000000');
INSERT INTO `b_demand` VALUES (278, 89, 89, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:07:31.000000', 'gdjsyjs', '2021-06-18 17:07:31.000000');
INSERT INTO `b_demand` VALUES (279, 91, 91, 3, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:07:47.000000', 'gdjsyjs', '2021-06-18 17:07:47.000000');
INSERT INTO `b_demand` VALUES (280, 115, 115, 20, 42, 1, 0, 'bsyclxy', '2021-06-18 17:07:57.000000', 'bsyclxy', '2021-06-18 17:07:57.000000');
INSERT INTO `b_demand` VALUES (281, 116, 116, 20, 42, 1, 0, 'bsyclxy', '2021-06-18 17:08:07.000000', 'bsyclxy', '2021-06-18 17:08:07.000000');
INSERT INTO `b_demand` VALUES (282, 93, 93, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:08:13.000000', 'gdjsyjs', '2021-06-18 17:08:13.000000');
INSERT INTO `b_demand` VALUES (283, 97, 97, 2, 42, 1, 0, 'bsyclxy', '2021-06-18 17:08:30.000000', 'bsyclxy', '2021-06-18 17:08:30.000000');
INSERT INTO `b_demand` VALUES (284, 95, 95, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:08:33.000000', 'gdjsyjs', '2021-06-18 17:08:33.000000');
INSERT INTO `b_demand` VALUES (285, 96, 96, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:08:45.000000', 'gdjsyjs', '2021-06-18 17:31:23.000000');
INSERT INTO `b_demand` VALUES (286, 85, 85, 10, 42, 1, 0, 'bsyclxy', '2021-06-18 17:09:26.000000', 'bsyclxy', '2021-06-18 17:09:26.000000');
INSERT INTO `b_demand` VALUES (287, 86, 86, 10, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:09:44.000000', 'gdjsyjs', '2021-06-18 17:30:08.000000');
INSERT INTO `b_demand` VALUES (288, 87, 87, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:10:00.000000', 'gdjsyjs', '2021-06-18 17:10:00.000000');
INSERT INTO `b_demand` VALUES (289, 88, 88, 2, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:10:05.000000', 'gdjsyjs', '2021-06-18 17:10:05.000000');
INSERT INTO `b_demand` VALUES (290, 91, 91, 10, 42, 1, 0, 'bsyclxy', '2021-06-18 17:10:25.000000', 'bsyclxy', '2021-06-18 17:10:25.000000');
INSERT INTO `b_demand` VALUES (291, 93, 93, 20, 42, 1, 0, 'bsyclxy', '2021-06-18 17:10:51.000000', 'bsyclxy', '2021-06-18 17:10:51.000000');
INSERT INTO `b_demand` VALUES (292, 104, 104, 5, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:11:14.000000', 'gdjsyjs', '2021-06-18 17:11:14.000000');
INSERT INTO `b_demand` VALUES (293, 113, 113, 5, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:12:22.000000', 'gdjsyjs', '2021-06-18 17:14:22.000000');
INSERT INTO `b_demand` VALUES (294, 1, 1, 6, 29, 1, 0, 'tyb', '2021-06-18 17:12:46.000000', 'tyb', '2021-06-18 17:13:56.000000');
INSERT INTO `b_demand` VALUES (295, 4, 4, 4, 29, 1, 0, 'tyb', '2021-06-18 17:13:18.000000', 'tyb', '2021-06-18 17:13:18.000000');
INSERT INTO `b_demand` VALUES (296, 115, 115, 20, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:13:31.000000', 'gdjsyjs', '2021-06-18 17:13:31.000000');
INSERT INTO `b_demand` VALUES (297, 116, 116, 20, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:13:37.000000', 'gdjsyjs', '2021-06-18 17:13:37.000000');
INSERT INTO `b_demand` VALUES (298, 118, 118, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:13:56.000000', 'gdjsyjs', '2021-06-18 17:13:56.000000');
INSERT INTO `b_demand` VALUES (299, 108, 108, 2, 29, 1, 0, 'tyb', '2021-06-18 17:15:33.000000', 'tyb', '2021-06-18 17:15:33.000000');
INSERT INTO `b_demand` VALUES (300, 94, 94, 4, 29, 1, 0, 'tyb', '2021-06-18 17:20:56.000000', 'tyb', '2021-06-18 17:20:56.000000');
INSERT INTO `b_demand` VALUES (301, 94, 94, 8, 42, 1, 0, 'bsyclxy', '2021-06-18 17:22:47.000000', 'bsyclxy', '2021-06-18 17:22:47.000000');
INSERT INTO `b_demand` VALUES (302, 96, 96, 2, 42, 1, 0, 'bsyclxy', '2021-06-18 17:23:10.000000', 'bsyclxy', '2021-06-18 17:23:10.000000');
INSERT INTO `b_demand` VALUES (303, 88, 88, 10, 42, 1, 0, 'bsyclxy', '2021-06-18 17:23:30.000000', 'bsyclxy', '2021-06-18 17:23:30.000000');
INSERT INTO `b_demand` VALUES (304, 92, 92, 10, 42, 1, 0, 'bsyclxy', '2021-06-18 17:23:59.000000', 'bsyclxy', '2021-06-18 17:23:59.000000');
INSERT INTO `b_demand` VALUES (305, 87, 87, 10, 42, 1, 0, 'bsyclxy', '2021-06-18 17:24:28.000000', 'bsyclxy', '2021-06-18 17:24:28.000000');
INSERT INTO `b_demand` VALUES (306, 4, 4, 1, 44, 1, 0, 'gdjsyjs', '2021-06-18 17:29:25.000000', 'gdjsyjs', '2021-06-18 17:29:25.000000');
INSERT INTO `b_demand` VALUES (307, 87, 87, 6, 6, 1, 0, 'sjc', '2021-06-21 09:48:42.000000', 'sjc', '2021-06-21 09:48:42.000000');
INSERT INTO `b_demand` VALUES (308, 88, 88, 6, 6, 1, 0, 'sjc', '2021-06-21 09:48:50.000000', 'sjc', '2021-06-21 09:48:50.000000');
INSERT INTO `b_demand` VALUES (309, 90, 90, 6, 6, 1, 0, 'sjc', '2021-06-21 09:48:59.000000', 'sjc', '2021-06-21 09:48:59.000000');
INSERT INTO `b_demand` VALUES (310, 93, 93, 3, 6, 1, 0, 'sjc', '2021-06-21 09:49:08.000000', 'sjc', '2021-06-21 09:49:08.000000');
INSERT INTO `b_demand` VALUES (311, 41, 41, 20, 25, 1, 0, 'jxfzzx', '2021-06-21 09:49:31.000000', 'jxfzzx', '2021-06-21 09:49:31.000000');
INSERT INTO `b_demand` VALUES (312, 92, 92, 6, 6, 1, 0, 'sjc', '2021-06-21 09:49:23.000000', 'sjc', '2021-06-21 09:49:23.000000');
INSERT INTO `b_demand` VALUES (315, 39, 39, 4, 25, 1, 0, 'jxfzzx', '2021-06-21 09:50:13.000000', 'jxfzzx', '2021-06-21 09:50:13.000000');
INSERT INTO `b_demand` VALUES (316, 45, 45, 1, 25, 1, 0, 'jxfzzx', '2021-06-21 09:50:27.000000', 'jxfzzx', '2021-06-21 09:50:27.000000');
INSERT INTO `b_demand` VALUES (317, 115, 115, 30, 6, 1, 0, 'sjc', '2021-06-21 09:50:23.000000', 'sjc', '2021-06-21 09:50:23.000000');
INSERT INTO `b_demand` VALUES (319, 116, 116, 30, 6, 1, 0, 'sjc', '2021-06-21 09:50:55.000000', 'sjc', '2021-06-21 09:50:55.000000');
INSERT INTO `b_demand` VALUES (321, 94, 94, 2, 25, 1, 0, 'jxfzzx', '2021-06-21 09:51:26.000000', 'jxfzzx', '2021-06-21 09:51:26.000000');
INSERT INTO `b_demand` VALUES (323, 95, 95, 1, 25, 1, 0, 'jxfzzx', '2021-06-21 09:52:13.000000', 'jxfzzx', '2021-06-21 09:52:13.000000');
INSERT INTO `b_demand` VALUES (324, 86, 86, 4, 25, 1, 0, 'jxfzzx', '2021-06-21 09:52:33.000000', 'jxfzzx', '2021-06-21 09:52:33.000000');
INSERT INTO `b_demand` VALUES (325, 116, 116, 10, 25, 1, 0, 'jxfzzx', '2021-06-21 09:52:55.000000', 'jxfzzx', '2021-06-21 09:52:55.000000');
INSERT INTO `b_demand` VALUES (326, 104, 104, 14, 7, 1, 0, 'rsc', '2021-06-21 09:53:01.000000', 'rsc', '2021-06-21 10:17:56.000000');
INSERT INTO `b_demand` VALUES (327, 98, 98, 2, 7, 1, 0, 'rsc', '2021-06-21 09:53:12.000000', 'rsc', '2021-06-21 09:53:12.000000');
INSERT INTO `b_demand` VALUES (328, 48, 48, 5, 32, 1, 0, 'ysxy', '2021-06-21 09:53:32.000000', 'ysxy', '2021-06-21 09:53:32.000000');
INSERT INTO `b_demand` VALUES (329, 120, 120, 2, 7, 1, 0, 'rsc', '2021-06-21 09:54:03.000000', 'rsc', '2021-06-21 09:56:46.000000');
INSERT INTO `b_demand` VALUES (330, 50, 50, 12, 32, 1, 0, 'ysxy', '2021-06-21 09:54:22.000000', 'ysxy', '2021-06-21 09:54:22.000000');
INSERT INTO `b_demand` VALUES (331, 118, 118, 3, 7, 1, 0, 'rsc', '2021-06-21 09:55:06.000000', 'rsc', '2021-06-21 10:16:52.000000');
INSERT INTO `b_demand` VALUES (332, 33, 33, 15, 6, 1, 0, 'sjc', '2021-06-21 09:55:21.000000', 'sjc', '2021-06-21 09:55:21.000000');
INSERT INTO `b_demand` VALUES (333, 38, 38, 12, 32, 1, 0, 'ysxy', '2021-06-21 09:55:59.000000', 'ysxy', '2021-06-21 09:55:59.000000');
INSERT INTO `b_demand` VALUES (334, 72, 72, 1, 6, 1, 0, 'sjc', '2021-06-21 09:56:07.000000', 'sjc', '2021-06-21 09:56:07.000000');
INSERT INTO `b_demand` VALUES (335, 108, 108, 2, 7, 1, 0, 'rsc', '2021-06-21 09:56:31.000000', 'rsc', '2021-06-21 09:56:31.000000');
INSERT INTO `b_demand` VALUES (336, 82, 82, 1, 7, 1, 0, 'rsc', '2021-06-21 09:57:17.000000', 'rsc', '2021-06-21 09:57:17.000000');
INSERT INTO `b_demand` VALUES (337, 83, 83, 1, 7, 1, 0, 'rsc', '2021-06-21 09:57:23.000000', 'rsc', '2021-06-21 09:57:23.000000');
INSERT INTO `b_demand` VALUES (338, 84, 84, 6, 7, 1, 0, 'rsc', '2021-06-21 09:57:57.000000', 'rsc', '2021-06-21 09:57:57.000000');
INSERT INTO `b_demand` VALUES (340, 53, 53, 2, 10, 1, 0, 'kjc', '2021-06-21 09:59:04.000000', 'kjc', '2021-06-21 09:59:04.000000');
INSERT INTO `b_demand` VALUES (341, 52, 52, 10, 32, 1, 0, 'ysxy', '2021-06-21 09:59:33.000000', 'ysxy', '2021-06-21 09:59:33.000000');
INSERT INTO `b_demand` VALUES (342, 92, 92, 4, 10, 1, 0, 'kjc', '2021-06-21 10:00:02.000000', 'kjc', '2021-06-21 10:00:02.000000');
INSERT INTO `b_demand` VALUES (344, 118, 118, 1, 25, 1, 0, 'jxfzzx', '2021-06-21 10:00:26.000000', 'jxfzzx', '2021-06-21 10:03:21.000000');
INSERT INTO `b_demand` VALUES (345, 92, 92, 6, 7, 1, 0, 'rsc', '2021-06-21 10:00:27.000000', 'rsc', '2021-06-21 10:00:27.000000');
INSERT INTO `b_demand` VALUES (346, 93, 93, 4, 7, 1, 0, 'rsc', '2021-06-21 10:00:59.000000', 'rsc', '2021-06-21 10:00:59.000000');
INSERT INTO `b_demand` VALUES (347, 95, 95, 4, 7, 1, 0, 'rsc', '2021-06-21 10:01:49.000000', 'rsc', '2021-06-21 10:01:49.000000');
INSERT INTO `b_demand` VALUES (348, 96, 96, 10, 7, 1, 0, 'rsc', '2021-06-21 10:01:57.000000', 'rsc', '2021-06-21 10:01:57.000000');
INSERT INTO `b_demand` VALUES (349, 67, 67, 5, 32, 1, 0, 'ysxy', '2021-06-21 10:02:36.000000', 'ysxy', '2021-06-21 10:02:36.000000');
INSERT INTO `b_demand` VALUES (350, 22, 22, 5, 32, 1, 0, 'ysxy', '2021-06-21 10:04:06.000000', 'ysxy', '2021-06-21 10:04:06.000000');
INSERT INTO `b_demand` VALUES (351, 88, 88, 15, 7, 1, 0, 'rsc', '2021-06-21 10:04:14.000000', 'rsc', '2021-06-21 10:05:37.000000');
INSERT INTO `b_demand` VALUES (352, 87, 87, 7, 7, 1, 0, 'rsc', '2021-06-21 10:04:26.000000', 'rsc', '2021-06-21 10:04:26.000000');
INSERT INTO `b_demand` VALUES (353, 53, 53, 1, 32, 1, 0, 'ysxy', '2021-06-21 10:05:48.000000', 'ysxy', '2021-06-21 10:05:48.000000');
INSERT INTO `b_demand` VALUES (354, 5, 5, 5, 32, 1, 0, 'ysxy', '2021-06-21 10:07:55.000000', 'ysxy', '2021-06-21 10:07:55.000000');
INSERT INTO `b_demand` VALUES (355, 107, 107, 2, 32, 1, 0, 'ysxy', '2021-06-21 10:08:58.000000', 'ysxy', '2021-06-21 10:08:58.000000');
INSERT INTO `b_demand` VALUES (356, 108, 108, 2, 32, 1, 0, 'ysxy', '2021-06-21 10:09:11.000000', 'ysxy', '2021-06-21 10:09:11.000000');
INSERT INTO `b_demand` VALUES (357, 111, 111, 3, 10, 1, 0, 'kjc', '2021-06-21 10:09:11.000000', 'kjc', '2021-06-21 10:09:11.000000');
INSERT INTO `b_demand` VALUES (358, 86, 86, 14, 7, 1, 0, 'rsc', '2021-06-21 10:09:27.000000', 'rsc', '2021-06-21 10:09:56.000000');
INSERT INTO `b_demand` VALUES (359, 116, 116, 60, 32, 1, 0, 'ysxy', '2021-06-21 10:10:02.000000', 'ysxy', '2021-06-21 10:10:02.000000');
INSERT INTO `b_demand` VALUES (360, 84, 84, 5, 32, 1, 0, 'ysxy', '2021-06-21 10:12:26.000000', 'ysxy', '2021-06-21 10:12:26.000000');
INSERT INTO `b_demand` VALUES (361, 89, 89, 4, 7, 1, 0, 'rsc', '2021-06-21 10:12:33.000000', 'rsc', '2021-06-21 10:12:33.000000');
INSERT INTO `b_demand` VALUES (363, 14, 14, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:13:36.000000', 'wlxxaqsys', '2021-06-21 10:13:36.000000');
INSERT INTO `b_demand` VALUES (364, 85, 85, 10, 32, 1, 0, 'ysxy', '2021-06-21 10:14:23.000000', 'ysxy', '2021-06-21 10:14:23.000000');
INSERT INTO `b_demand` VALUES (366, 86, 86, 110, 32, 1, 0, 'ysxy', '2021-06-21 10:14:43.000000', 'ysxy', '2021-06-21 10:14:43.000000');
INSERT INTO `b_demand` VALUES (367, 87, 87, 110, 32, 1, 0, 'ysxy', '2021-06-21 10:15:08.000000', 'ysxy', '2021-06-21 10:15:08.000000');
INSERT INTO `b_demand` VALUES (369, 88, 88, 110, 32, 1, 0, 'ysxy', '2021-06-21 10:15:18.000000', 'ysxy', '2021-06-21 10:15:18.000000');
INSERT INTO `b_demand` VALUES (370, 113, 113, 10, 7, 1, 0, 'rsc', '2021-06-21 10:15:50.000000', 'rsc', '2021-06-21 10:15:50.000000');
INSERT INTO `b_demand` VALUES (371, 93, 93, 10, 32, 1, 0, 'ysxy', '2021-06-21 10:16:08.000000', 'ysxy', '2021-06-21 10:16:08.000000');
INSERT INTO `b_demand` VALUES (373, 91, 91, 10, 32, 1, 0, 'ysxy', '2021-06-21 10:18:01.000000', 'ysxy', '2021-06-21 10:18:01.000000');
INSERT INTO `b_demand` VALUES (375, 85, 85, 6, 10, 1, 0, 'kjc', '2021-06-21 10:19:11.000000', 'kjc', '2021-06-21 10:19:11.000000');
INSERT INTO `b_demand` VALUES (377, 63, 63, 5, 32, 1, 0, 'ysxy', '2021-06-21 10:19:21.000000', 'ysxy', '2021-06-21 10:19:21.000000');
INSERT INTO `b_demand` VALUES (378, 15, 15, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:20:07.000000', 'wlxxaqsys', '2021-06-21 10:20:07.000000');
INSERT INTO `b_demand` VALUES (379, 17, 17, 10, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:20:37.000000', 'wlxxaqsys', '2021-06-21 10:20:37.000000');
INSERT INTO `b_demand` VALUES (381, 18, 18, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:21:06.000000', 'wlxxaqsys', '2021-06-21 10:21:06.000000');
INSERT INTO `b_demand` VALUES (382, 116, 116, 60, 7, 1, 0, 'rsc', '2021-06-21 10:21:24.000000', 'rsc', '2021-06-21 10:22:41.000000');
INSERT INTO `b_demand` VALUES (383, 115, 115, 60, 7, 1, 0, 'rsc', '2021-06-21 10:21:34.000000', 'rsc', '2021-06-21 10:22:26.000000');
INSERT INTO `b_demand` VALUES (384, 1, 1, 28, 7, 1, 0, 'rsc', '2021-06-21 10:23:54.000000', 'rsc', '2021-06-21 10:23:54.000000');
INSERT INTO `b_demand` VALUES (385, 4, 4, 8, 7, 1, 0, 'rsc', '2021-06-21 10:24:38.000000', 'rsc', '2021-06-21 10:24:38.000000');
INSERT INTO `b_demand` VALUES (386, 13, 13, 8, 7, 1, 0, 'rsc', '2021-06-21 10:25:16.000000', 'rsc', '2021-06-21 10:25:16.000000');
INSERT INTO `b_demand` VALUES (387, 14, 14, 1, 7, 1, 0, 'rsc', '2021-06-21 10:25:32.000000', 'rsc', '2021-06-21 10:25:32.000000');
INSERT INTO `b_demand` VALUES (388, 15, 15, 2, 7, 1, 0, 'rsc', '2021-06-21 10:25:57.000000', 'rsc', '2021-06-21 10:25:57.000000');
INSERT INTO `b_demand` VALUES (389, 17, 17, 20, 7, 1, 0, 'rsc', '2021-06-21 10:26:26.000000', 'rsc', '2021-06-21 10:26:26.000000');
INSERT INTO `b_demand` VALUES (390, 19, 19, 2, 7, 1, 0, 'rsc', '2021-06-21 10:26:48.000000', 'rsc', '2021-06-21 10:26:48.000000');
INSERT INTO `b_demand` VALUES (391, 2, 2, 3, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:29:02.000000', 'gjjyjlzx', '2021-06-21 10:29:02.000000');
INSERT INTO `b_demand` VALUES (392, 11, 11, 1, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:29:23.000000', 'gjjyjlzx', '2021-06-21 10:29:23.000000');
INSERT INTO `b_demand` VALUES (393, 19, 19, 2, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:29:58.000000', 'gjjyjlzx', '2021-06-21 10:29:58.000000');
INSERT INTO `b_demand` VALUES (394, 32, 32, 10, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:30:53.000000', 'gjjyjlzx', '2021-06-21 10:30:53.000000');
INSERT INTO `b_demand` VALUES (396, 34, 34, 5, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:31:28.000000', 'gjjyjlzx', '2021-06-21 10:31:28.000000');
INSERT INTO `b_demand` VALUES (398, 50, 50, 5, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:33:18.000000', 'gjjyjlzx', '2021-06-21 10:33:18.000000');
INSERT INTO `b_demand` VALUES (399, 20, 20, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:34:00.000000', 'wlxxaqsys', '2021-06-21 10:34:00.000000');
INSERT INTO `b_demand` VALUES (400, 58, 58, 4, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:34:11.000000', 'gjjyjlzx', '2021-06-21 10:34:11.000000');
INSERT INTO `b_demand` VALUES (401, 21, 21, 20, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:34:39.000000', 'wlxxaqsys', '2021-06-21 10:34:39.000000');
INSERT INTO `b_demand` VALUES (402, 67, 67, 5, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:34:46.000000', 'gjjyjlzx', '2021-06-21 10:34:46.000000');
INSERT INTO `b_demand` VALUES (403, 22, 22, 15, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:35:04.000000', 'wlxxaqsys', '2021-06-21 10:35:04.000000');
INSERT INTO `b_demand` VALUES (404, 124, 124, 5, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:35:16.000000', 'gjjyjlzx', '2021-06-21 10:35:16.000000');
INSERT INTO `b_demand` VALUES (405, 24, 24, 20, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:35:28.000000', 'wlxxaqsys', '2021-06-21 10:35:28.000000');
INSERT INTO `b_demand` VALUES (406, 85, 85, 4, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:35:47.000000', 'gjjyjlzx', '2021-06-21 10:35:47.000000');
INSERT INTO `b_demand` VALUES (407, 25, 25, 10, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:36:04.000000', 'wlxxaqsys', '2021-06-21 10:36:04.000000');
INSERT INTO `b_demand` VALUES (408, 92, 92, 4, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:36:28.000000', 'gjjyjlzx', '2021-06-21 10:36:28.000000');
INSERT INTO `b_demand` VALUES (409, 27, 27, 50, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:36:38.000000', 'wlxxaqsys', '2021-06-21 10:36:38.000000');
INSERT INTO `b_demand` VALUES (410, 95, 95, 2, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:36:44.000000', 'gjjyjlzx', '2021-06-21 10:36:44.000000');
INSERT INTO `b_demand` VALUES (411, 102, 102, 4, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:37:18.000000', 'gjjyjlzx', '2021-06-21 10:37:18.000000');
INSERT INTO `b_demand` VALUES (412, 115, 115, 10, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:37:57.000000', 'gjjyjlzx', '2021-06-21 10:37:57.000000');
INSERT INTO `b_demand` VALUES (413, 116, 116, 10, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:38:03.000000', 'gjjyjlzx', '2021-06-21 10:38:03.000000');
INSERT INTO `b_demand` VALUES (414, 32, 32, 20, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:39:25.000000', 'wlxxaqsys', '2021-06-21 10:39:25.000000');
INSERT INTO `b_demand` VALUES (415, 84, 84, 3, 27, 1, 0, 'gjjyjlzx', '2021-06-21 10:39:38.000000', 'gjjyjlzx', '2021-06-21 10:39:38.000000');
INSERT INTO `b_demand` VALUES (416, 21, 21, 20, 7, 1, 0, 'rsc', '2021-06-21 10:40:06.000000', 'rsc', '2021-06-21 10:40:06.000000');
INSERT INTO `b_demand` VALUES (417, 13, 13, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:40:20.000000', 'wlxxaqsys', '2021-06-21 10:40:20.000000');
INSERT INTO `b_demand` VALUES (418, 29, 29, 20, 7, 1, 0, 'rsc', '2021-06-21 10:41:13.000000', 'rsc', '2021-06-21 10:41:13.000000');
INSERT INTO `b_demand` VALUES (419, 51, 51, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:41:40.000000', 'wlxxaqsys', '2021-06-21 10:41:40.000000');
INSERT INTO `b_demand` VALUES (420, 32, 32, 400, 7, 1, 0, 'rsc', '2021-06-21 10:41:57.000000', 'rsc', '2021-06-21 10:41:57.000000');
INSERT INTO `b_demand` VALUES (421, 95, 95, 3, 10, 1, 0, 'kjc', '2021-06-21 10:43:03.000000', 'kjc', '2021-06-21 10:43:03.000000');
INSERT INTO `b_demand` VALUES (422, 50, 50, 2, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:43:31.000000', 'wlxxaqsys', '2021-06-21 10:43:31.000000');
INSERT INTO `b_demand` VALUES (424, 52, 52, 2, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:44:08.000000', 'wlxxaqsys', '2021-06-21 10:44:08.000000');
INSERT INTO `b_demand` VALUES (425, 1, 1, 26, 33, 1, 0, 'fzxy', '2021-06-21 10:45:11.000000', 'fzxy', '2021-06-21 10:45:11.000000');
INSERT INTO `b_demand` VALUES (426, 5, 5, 28, 33, 1, 0, 'fzxy', '2021-06-21 10:47:23.000000', 'fzxy', '2021-06-21 10:47:23.000000');
INSERT INTO `b_demand` VALUES (427, 59, 59, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:49:58.000000', 'wlxxaqsys', '2021-06-21 10:49:58.000000');
INSERT INTO `b_demand` VALUES (428, 35, 35, 48, 7, 1, 0, 'rsc', '2021-06-21 10:51:00.000000', 'rsc', '2021-06-21 10:51:00.000000');
INSERT INTO `b_demand` VALUES (431, 1, 1, 15, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:52:09.000000', 'szyyhjxy', '2021-06-21 10:52:09.000000');
INSERT INTO `b_demand` VALUES (433, 41, 41, 20, 7, 1, 0, 'rsc', '2021-06-21 10:52:34.000000', 'rsc', '2021-06-21 10:52:34.000000');
INSERT INTO `b_demand` VALUES (434, 12, 12, 7, 33, 1, 0, 'fzxy', '2021-06-21 10:52:36.000000', 'fzxy', '2021-06-21 10:52:36.000000');
INSERT INTO `b_demand` VALUES (435, 19, 19, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:52:51.000000', 'szyyhjxy', '2021-06-21 10:52:51.000000');
INSERT INTO `b_demand` VALUES (436, 21, 21, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:53:13.000000', 'szyyhjxy', '2021-06-21 10:53:13.000000');
INSERT INTO `b_demand` VALUES (437, 22, 22, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:53:20.000000', 'szyyhjxy', '2021-06-21 10:53:20.000000');
INSERT INTO `b_demand` VALUES (439, 25, 25, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:53:35.000000', 'szyyhjxy', '2021-06-21 10:53:35.000000');
INSERT INTO `b_demand` VALUES (440, 64, 64, 8, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:53:53.000000', 'wlxxaqsys', '2021-06-21 10:53:53.000000');
INSERT INTO `b_demand` VALUES (441, 28, 28, 10, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:53:50.000000', 'szyyhjxy', '2021-06-21 10:53:50.000000');
INSERT INTO `b_demand` VALUES (443, 30, 30, 10, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:54:02.000000', 'szyyhjxy', '2021-06-21 10:54:02.000000');
INSERT INTO `b_demand` VALUES (444, 31, 31, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:54:15.000000', 'szyyhjxy', '2021-06-21 10:54:15.000000');
INSERT INTO `b_demand` VALUES (445, 13, 13, 6, 33, 1, 0, 'fzxy', '2021-06-21 10:54:16.000000', 'fzxy', '2021-06-21 10:54:16.000000');
INSERT INTO `b_demand` VALUES (446, 42, 42, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:54:25.000000', 'szyyhjxy', '2021-06-21 10:54:25.000000');
INSERT INTO `b_demand` VALUES (447, 44, 44, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:54:39.000000', 'szyyhjxy', '2021-06-21 10:54:39.000000');
INSERT INTO `b_demand` VALUES (448, 39, 39, 35, 7, 1, 0, 'rsc', '2021-06-21 10:54:43.000000', 'rsc', '2021-06-21 10:54:43.000000');
INSERT INTO `b_demand` VALUES (449, 45, 45, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:54:45.000000', 'szyyhjxy', '2021-06-21 10:54:45.000000');
INSERT INTO `b_demand` VALUES (450, 47, 47, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:54:53.000000', 'szyyhjxy', '2021-06-21 10:54:53.000000');
INSERT INTO `b_demand` VALUES (451, 63, 63, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:55:15.000000', 'szyyhjxy', '2021-06-21 10:55:15.000000');
INSERT INTO `b_demand` VALUES (452, 64, 64, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:55:22.000000', 'szyyhjxy', '2021-06-21 10:55:22.000000');
INSERT INTO `b_demand` VALUES (453, 65, 65, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:55:29.000000', 'szyyhjxy', '2021-06-21 10:55:29.000000');
INSERT INTO `b_demand` VALUES (454, 66, 66, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:55:34.000000', 'szyyhjxy', '2021-06-21 10:55:34.000000');
INSERT INTO `b_demand` VALUES (455, 68, 68, 50, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:55:44.000000', 'szyyhjxy', '2021-06-21 10:55:44.000000');
INSERT INTO `b_demand` VALUES (456, 66, 66, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:56:00.000000', 'wlxxaqsys', '2021-06-21 10:56:00.000000');
INSERT INTO `b_demand` VALUES (458, 48, 48, 55, 7, 1, 0, 'rsc', '2021-06-21 10:56:58.000000', 'rsc', '2021-06-21 10:56:58.000000');
INSERT INTO `b_demand` VALUES (459, 67, 67, 10, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:57:11.000000', 'wlxxaqsys', '2021-06-21 10:57:11.000000');
INSERT INTO `b_demand` VALUES (460, 78, 78, 20, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:57:23.000000', 'szyyhjxy', '2021-06-21 10:57:23.000000');
INSERT INTO `b_demand` VALUES (461, 69, 69, 10, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:57:38.000000', 'wlxxaqsys', '2021-06-21 10:57:38.000000');
INSERT INTO `b_demand` VALUES (462, 125, 125, 10, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:57:34.000000', 'szyyhjxy', '2021-06-21 10:57:34.000000');
INSERT INTO `b_demand` VALUES (463, 14, 14, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 10:57:55.000000', 'szyyhjxy', '2021-06-21 10:57:55.000000');
INSERT INTO `b_demand` VALUES (464, 74, 74, 2, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:58:03.000000', 'wlxxaqsys', '2021-06-21 10:58:03.000000');
INSERT INTO `b_demand` VALUES (466, 124, 124, 3, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:58:52.000000', 'wlxxaqsys', '2021-06-21 10:58:52.000000');
INSERT INTO `b_demand` VALUES (467, 125, 125, 6, 48, 1, 0, 'wlxxaqsys', '2021-06-21 10:59:07.000000', 'wlxxaqsys', '2021-06-21 10:59:07.000000');
INSERT INTO `b_demand` VALUES (468, 85, 85, 20, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:00:17.000000', 'wlxxaqsys', '2021-06-21 11:00:17.000000');
INSERT INTO `b_demand` VALUES (469, 50, 50, 40, 7, 1, 0, 'rsc', '2021-06-21 11:00:32.000000', 'rsc', '2021-06-21 11:00:32.000000');
INSERT INTO `b_demand` VALUES (470, 87, 87, 10, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:01:27.000000', 'wlxxaqsys', '2021-06-21 11:01:27.000000');
INSERT INTO `b_demand` VALUES (471, 91, 91, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:02:08.000000', 'wlxxaqsys', '2021-06-21 11:02:08.000000');
INSERT INTO `b_demand` VALUES (472, 52, 52, 3, 7, 1, 0, 'rsc', '2021-06-21 11:02:12.000000', 'rsc', '2021-06-21 11:02:12.000000');
INSERT INTO `b_demand` VALUES (474, 94, 94, 10, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:03:29.000000', 'wlxxaqsys', '2021-06-21 11:03:29.000000');
INSERT INTO `b_demand` VALUES (475, 95, 95, 10, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:03:41.000000', 'wlxxaqsys', '2021-06-21 11:03:41.000000');
INSERT INTO `b_demand` VALUES (477, 59, 59, 40, 7, 1, 0, 'rsc', '2021-06-21 11:03:44.000000', 'rsc', '2021-06-21 11:03:44.000000');
INSERT INTO `b_demand` VALUES (479, 86, 86, 10, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:04:09.000000', 'szyyhjxy', '2021-06-21 11:04:09.000000');
INSERT INTO `b_demand` VALUES (481, 93, 93, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:04:34.000000', 'szyyhjxy', '2021-06-21 11:04:34.000000');
INSERT INTO `b_demand` VALUES (482, 58, 58, 40, 7, 1, 0, 'rsc', '2021-06-21 11:04:37.000000', 'rsc', '2021-06-21 11:04:37.000000');
INSERT INTO `b_demand` VALUES (483, 48, 48, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:04:46.000000', 'wlxxaqsys', '2021-06-21 11:04:46.000000');
INSERT INTO `b_demand` VALUES (485, 96, 96, 10, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:04:55.000000', 'szyyhjxy', '2021-06-21 11:04:55.000000');
INSERT INTO `b_demand` VALUES (486, 1, 1, 3, 11, 1, 0, 'lgbc', '2021-06-21 11:04:56.000000', 'lgbc', '2021-06-21 11:04:56.000000');
INSERT INTO `b_demand` VALUES (487, 2, 2, 3, 11, 1, 0, 'lgbc', '2021-06-21 11:05:03.000000', 'lgbc', '2021-06-21 11:05:03.000000');
INSERT INTO `b_demand` VALUES (489, 57, 57, 20, 7, 1, 0, 'rsc', '2021-06-21 11:05:18.000000', 'rsc', '2021-06-21 11:05:18.000000');
INSERT INTO `b_demand` VALUES (490, 82, 82, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:05:51.000000', 'szyyhjxy', '2021-06-21 11:05:51.000000');
INSERT INTO `b_demand` VALUES (491, 56, 56, 32, 7, 1, 0, 'rsc', '2021-06-21 11:05:55.000000', 'rsc', '2021-06-21 11:05:55.000000');
INSERT INTO `b_demand` VALUES (492, 83, 83, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:05:57.000000', 'szyyhjxy', '2021-06-21 11:05:57.000000');
INSERT INTO `b_demand` VALUES (494, 81, 81, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:06:07.000000', 'szyyhjxy', '2021-06-21 11:06:07.000000');
INSERT INTO `b_demand` VALUES (495, 87, 87, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:06:18.000000', 'szyyhjxy', '2021-06-21 11:06:18.000000');
INSERT INTO `b_demand` VALUES (498, 100, 100, 2, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:06:43.000000', 'szyyhjxy', '2021-06-21 11:06:43.000000');
INSERT INTO `b_demand` VALUES (499, 97, 97, 2, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:06:56.000000', 'wlxxaqsys', '2021-06-21 11:06:56.000000');
INSERT INTO `b_demand` VALUES (500, 53, 53, 5, 11, 1, 0, 'lgbc', '2021-06-21 11:07:03.000000', 'lgbc', '2021-06-21 11:07:03.000000');
INSERT INTO `b_demand` VALUES (501, 66, 66, 2, 7, 1, 0, 'rsc', '2021-06-21 11:07:09.000000', 'rsc', '2021-06-21 11:07:09.000000');
INSERT INTO `b_demand` VALUES (502, 107, 107, 2, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:07:19.000000', 'szyyhjxy', '2021-06-21 11:07:19.000000');
INSERT INTO `b_demand` VALUES (504, 104, 104, 3, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:08:33.000000', 'wlxxaqsys', '2021-06-21 11:08:33.000000');
INSERT INTO `b_demand` VALUES (506, 106, 106, 3, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:08:43.000000', 'wlxxaqsys', '2021-06-21 11:08:43.000000');
INSERT INTO `b_demand` VALUES (509, 67, 67, 15, 7, 1, 0, 'rsc', '2021-06-21 11:08:56.000000', 'rsc', '2021-06-21 11:08:56.000000');
INSERT INTO `b_demand` VALUES (510, 12, 12, 2, 42, 1, 0, 'bsyclxy', '2021-06-21 11:09:01.000000', 'bsyclxy', '2021-06-21 11:09:01.000000');
INSERT INTO `b_demand` VALUES (511, 68, 68, 15, 7, 1, 0, 'rsc', '2021-06-21 11:09:06.000000', 'rsc', '2021-06-21 11:09:06.000000');
INSERT INTO `b_demand` VALUES (512, 17, 17, 20, 33, 1, 0, 'fzxy', '2021-06-21 11:09:27.000000', 'fzxy', '2021-06-21 11:09:27.000000');
INSERT INTO `b_demand` VALUES (513, 108, 108, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:09:40.000000', 'szyyhjxy', '2021-06-21 11:09:40.000000');
INSERT INTO `b_demand` VALUES (514, 115, 115, 10, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:09:50.000000', 'szyyhjxy', '2021-06-21 11:09:50.000000');
INSERT INTO `b_demand` VALUES (516, 116, 116, 10, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:09:57.000000', 'szyyhjxy', '2021-06-21 11:09:57.000000');
INSERT INTO `b_demand` VALUES (517, 124, 124, 40, 7, 1, 0, 'rsc', '2021-06-21 11:10:04.000000', 'rsc', '2021-06-21 11:10:04.000000');
INSERT INTO `b_demand` VALUES (519, 29, 29, 2, 42, 1, 0, 'bsyclxy', '2021-06-21 11:10:18.000000', 'bsyclxy', '2021-06-21 11:10:18.000000');
INSERT INTO `b_demand` VALUES (520, 125, 125, 35, 7, 1, 0, 'rsc', '2021-06-21 11:10:23.000000', 'rsc', '2021-06-21 11:10:23.000000');
INSERT INTO `b_demand` VALUES (524, 32, 32, 50, 17, 1, 0, 'gjjlhzc', '2021-06-21 11:11:12.000000', 'gjjlhzc', '2021-06-21 11:23:15.000000');
INSERT INTO `b_demand` VALUES (525, 118, 118, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:11:21.000000', 'wlxxaqsys', '2021-06-21 11:11:21.000000');
INSERT INTO `b_demand` VALUES (526, 118, 118, 3, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:11:32.000000', 'szyyhjxy', '2021-06-21 11:11:32.000000');
INSERT INTO `b_demand` VALUES (527, 111, 111, 5, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:11:55.000000', 'szyyhjxy', '2021-06-21 11:11:55.000000');
INSERT INTO `b_demand` VALUES (528, 115, 115, 50, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:12:12.000000', 'wlxxaqsys', '2021-06-21 11:12:12.000000');
INSERT INTO `b_demand` VALUES (529, 116, 116, 20, 48, 1, 0, 'wlxxaqsys', '2021-06-21 11:12:56.000000', 'wlxxaqsys', '2021-06-21 11:12:56.000000');
INSERT INTO `b_demand` VALUES (531, 85, 85, 30, 45, 1, 0, 'szyyhjxy', '2021-06-21 11:13:18.000000', 'szyyhjxy', '2021-06-21 11:13:18.000000');
INSERT INTO `b_demand` VALUES (534, 126, 126, 7, 7, 1, 0, 'rsc', '2021-06-21 11:13:59.000000', 'rsc', '2021-06-21 11:13:59.000000');
INSERT INTO `b_demand` VALUES (535, 76, 76, 10, 7, 1, 0, 'rsc', '2021-06-21 11:14:20.000000', 'rsc', '2021-06-21 11:14:20.000000');
INSERT INTO `b_demand` VALUES (537, 75, 75, 2, 7, 1, 0, 'rsc', '2021-06-21 11:14:28.000000', 'rsc', '2021-06-21 11:19:25.000000');
INSERT INTO `b_demand` VALUES (538, 50, 50, 10, 17, 1, 0, 'gjjlhzc', '2021-06-21 11:15:05.000000', 'gjjlhzc', '2021-06-21 11:15:05.000000');
INSERT INTO `b_demand` VALUES (540, 78, 78, 2, 7, 1, 0, 'rsc', '2021-06-21 11:15:42.000000', 'rsc', '2021-06-21 11:15:42.000000');
INSERT INTO `b_demand` VALUES (542, 67, 67, 2, 17, 1, 0, 'gjjlhzc', '2021-06-21 11:16:27.000000', 'gjjlhzc', '2021-06-22 08:25:09.000000');
INSERT INTO `b_demand` VALUES (543, 69, 69, 25, 7, 1, 0, 'rsc', '2021-06-21 11:16:24.000000', 'rsc', '2021-06-21 11:16:24.000000');
INSERT INTO `b_demand` VALUES (544, 69, 69, 5, 17, 1, 0, 'gjjlhzc', '2021-06-21 11:16:41.000000', 'gjjlhzc', '2021-06-21 15:06:35.000000');
INSERT INTO `b_demand` VALUES (546, 124, 124, 2, 17, 1, 0, 'gjjlhzc', '2021-06-21 11:17:09.000000', 'gjjlhzc', '2021-06-22 08:56:42.000000');
INSERT INTO `b_demand` VALUES (550, 25, 25, 70, 33, 1, 0, 'fzxy', '2021-06-21 11:20:52.000000', 'fzxy', '2021-06-21 11:20:52.000000');
INSERT INTO `b_demand` VALUES (551, 21, 21, 17, 33, 1, 0, 'fzxy', '2021-06-21 11:28:46.000000', 'fzxy', '2021-06-21 11:28:46.000000');
INSERT INTO `b_demand` VALUES (553, 48, 48, 5, 33, 1, 0, 'fzxy', '2021-06-21 11:31:25.000000', 'fzxy', '2021-06-21 11:31:25.000000');
INSERT INTO `b_demand` VALUES (554, 63, 63, 2, 33, 1, 0, 'fzxy', '2021-06-21 11:32:28.000000', 'fzxy', '2021-06-21 11:32:28.000000');
INSERT INTO `b_demand` VALUES (555, 67, 67, 12, 33, 1, 0, 'fzxy', '2021-06-21 11:33:33.000000', 'fzxy', '2021-06-21 11:33:33.000000');
INSERT INTO `b_demand` VALUES (557, 74, 74, 2, 33, 1, 0, 'fzxy', '2021-06-21 11:36:13.000000', 'fzxy', '2021-06-21 11:36:13.000000');
INSERT INTO `b_demand` VALUES (558, 78, 78, 2, 33, 1, 0, 'fzxy', '2021-06-21 11:36:29.000000', 'fzxy', '2021-06-21 11:36:29.000000');
INSERT INTO `b_demand` VALUES (559, 49, 49, 25, 33, 1, 0, 'fzxy', '2021-06-21 11:40:23.000000', 'fzxy', '2021-06-21 11:40:23.000000');
INSERT INTO `b_demand` VALUES (560, 116, 116, 10, 33, 1, 0, 'fzxy', '2021-06-21 11:43:35.000000', 'fzxy', '2021-06-21 11:43:35.000000');
INSERT INTO `b_demand` VALUES (561, 96, 96, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 12:29:13.000000', 'wlxxaqsys', '2021-06-21 12:29:13.000000');
INSERT INTO `b_demand` VALUES (562, 100, 100, 4, 48, 1, 0, 'wlxxaqsys', '2021-06-21 12:33:41.000000', 'wlxxaqsys', '2021-06-21 12:33:41.000000');
INSERT INTO `b_demand` VALUES (564, 30, 30, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 12:38:15.000000', 'wlxxaqsys', '2021-06-21 12:38:15.000000');
INSERT INTO `b_demand` VALUES (565, 29, 29, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 12:38:32.000000', 'wlxxaqsys', '2021-06-21 12:38:32.000000');
INSERT INTO `b_demand` VALUES (566, 1, 1, 6, 41, 1, 0, 'jxjyxy', '2021-06-21 12:38:51.000000', 'jxjyxy', '2021-06-22 09:35:49.000000');
INSERT INTO `b_demand` VALUES (567, 2, 2, 1, 41, 1, 0, 'jxjyxy', '2021-06-21 12:39:08.000000', 'jxjyxy', '2021-06-21 12:39:08.000000');
INSERT INTO `b_demand` VALUES (570, 22, 22, 20, 41, 1, 0, 'jxjyxy', '2021-06-21 12:42:50.000000', 'jxjyxy', '2021-06-21 12:42:50.000000');
INSERT INTO `b_demand` VALUES (572, 27, 27, 1, 41, 1, 0, 'jxjyxy', '2021-06-21 12:43:55.000000', 'jxjyxy', '2021-06-21 12:43:55.000000');
INSERT INTO `b_demand` VALUES (579, 86, 86, 11, 33, 1, 0, 'fzxy', '2021-06-21 14:39:57.000000', 'fzxy', '2021-06-21 14:39:57.000000');
INSERT INTO `b_demand` VALUES (580, 87, 87, 11, 33, 1, 0, 'fzxy', '2021-06-21 14:40:08.000000', 'fzxy', '2021-06-21 14:40:08.000000');
INSERT INTO `b_demand` VALUES (581, 89, 89, 11, 33, 1, 0, 'fzxy', '2021-06-21 14:40:17.000000', 'fzxy', '2021-06-21 14:40:17.000000');
INSERT INTO `b_demand` VALUES (582, 88, 88, 11, 33, 1, 0, 'fzxy', '2021-06-21 14:40:30.000000', 'fzxy', '2021-06-21 14:40:30.000000');
INSERT INTO `b_demand` VALUES (583, 94, 94, 5, 33, 1, 0, 'fzxy', '2021-06-21 14:41:14.000000', 'fzxy', '2021-06-21 14:41:14.000000');
INSERT INTO `b_demand` VALUES (585, 52, 52, 2, 41, 1, 0, 'jxjyxy', '2021-06-21 14:48:23.000000', 'jxjyxy', '2021-06-21 15:05:09.000000');
INSERT INTO `b_demand` VALUES (586, 58, 58, 1, 41, 1, 0, 'jxjyxy', '2021-06-21 14:49:02.000000', 'jxjyxy', '2021-06-21 14:49:02.000000');
INSERT INTO `b_demand` VALUES (587, 59, 59, 1, 41, 1, 0, 'jxjyxy', '2021-06-21 14:49:14.000000', 'jxjyxy', '2021-06-21 14:49:14.000000');
INSERT INTO `b_demand` VALUES (588, 63, 63, 6, 41, 1, 0, 'jxjyxy', '2021-06-21 14:49:40.000000', 'jxjyxy', '2021-06-21 16:02:09.000000');
INSERT INTO `b_demand` VALUES (589, 69, 69, 5, 41, 1, 0, 'jxjyxy', '2021-06-21 14:50:16.000000', 'jxjyxy', '2021-06-21 14:50:16.000000');
INSERT INTO `b_demand` VALUES (590, 74, 74, 1, 41, 1, 0, 'jxjyxy', '2021-06-21 14:50:48.000000', 'jxjyxy', '2021-06-21 14:50:48.000000');
INSERT INTO `b_demand` VALUES (591, 78, 78, 3, 41, 1, 0, 'jxjyxy', '2021-06-21 14:51:23.000000', 'jxjyxy', '2021-06-21 14:51:23.000000');
INSERT INTO `b_demand` VALUES (592, 126, 126, 4, 41, 1, 0, 'jxjyxy', '2021-06-21 14:52:01.000000', 'jxjyxy', '2021-06-21 14:52:01.000000');
INSERT INTO `b_demand` VALUES (593, 1, 1, 3, 23, 1, 0, 'xscbzx', '2021-06-21 14:54:18.000000', 'xscbzx', '2021-06-21 15:57:27.000000');
INSERT INTO `b_demand` VALUES (595, 17, 17, 5, 23, 1, 0, 'xscbzx', '2021-06-21 14:56:04.000000', 'xscbzx', '2021-06-21 14:56:04.000000');
INSERT INTO `b_demand` VALUES (596, 18, 18, 1, 23, 1, 0, 'xscbzx', '2021-06-21 14:57:13.000000', 'xscbzx', '2021-06-21 14:57:13.000000');
INSERT INTO `b_demand` VALUES (597, 20, 20, 1, 23, 1, 0, 'xscbzx', '2021-06-21 14:58:05.000000', 'xscbzx', '2021-06-21 14:58:05.000000');
INSERT INTO `b_demand` VALUES (598, 21, 21, 3, 23, 1, 0, 'xscbzx', '2021-06-21 14:58:13.000000', 'xscbzx', '2021-06-21 15:38:09.000000');
INSERT INTO `b_demand` VALUES (599, 85, 85, 2, 41, 1, 0, 'jxjyxy', '2021-06-21 14:57:08.000000', 'jxjyxy', '2021-06-21 15:54:14.000000');
INSERT INTO `b_demand` VALUES (600, 86, 86, 18, 41, 1, 0, 'jxjyxy', '2021-06-21 14:57:21.000000', 'jxjyxy', '2021-06-21 15:56:45.000000');
INSERT INTO `b_demand` VALUES (601, 87, 87, 18, 41, 1, 0, 'jxjyxy', '2021-06-21 14:57:29.000000', 'jxjyxy', '2021-06-21 15:59:57.000000');
INSERT INTO `b_demand` VALUES (602, 82, 82, 10, 29, 1, 0, 'tyb', '2021-06-21 14:57:41.000000', 'tyb', '2021-06-21 14:57:41.000000');
INSERT INTO `b_demand` VALUES (604, 83, 83, 10, 29, 1, 0, 'tyb', '2021-06-21 14:57:54.000000', 'tyb', '2021-06-21 14:57:54.000000');
INSERT INTO `b_demand` VALUES (605, 96, 96, 2, 41, 1, 0, 'jxjyxy', '2021-06-21 14:58:02.000000', 'jxjyxy', '2021-06-21 16:24:32.000000');
INSERT INTO `b_demand` VALUES (606, 27, 27, 5, 23, 1, 0, 'xscbzx', '2021-06-21 14:59:16.000000', 'xscbzx', '2021-06-21 14:59:16.000000');
INSERT INTO `b_demand` VALUES (607, 32, 32, 50, 23, 1, 0, 'xscbzx', '2021-06-21 15:00:34.000000', 'xscbzx', '2021-06-21 15:08:34.000000');
INSERT INTO `b_demand` VALUES (608, 36, 36, 20, 23, 1, 0, 'xscbzx', '2021-06-21 15:02:02.000000', 'xscbzx', '2021-06-21 15:35:05.000000');
INSERT INTO `b_demand` VALUES (609, 52, 52, 6, 23, 1, 0, 'xscbzx', '2021-06-21 15:03:21.000000', 'xscbzx', '2021-06-21 16:05:27.000000');
INSERT INTO `b_demand` VALUES (610, 54, 54, 2, 23, 1, 0, 'xscbzx', '2021-06-21 15:03:43.000000', 'xscbzx', '2021-06-21 15:03:43.000000');
INSERT INTO `b_demand` VALUES (611, 61, 61, 1, 23, 1, 0, 'xscbzx', '2021-06-21 15:04:54.000000', 'xscbzx', '2021-06-21 15:04:54.000000');
INSERT INTO `b_demand` VALUES (612, 67, 67, 6, 23, 1, 0, 'xscbzx', '2021-06-21 15:05:17.000000', 'xscbzx', '2021-06-21 15:05:17.000000');
INSERT INTO `b_demand` VALUES (613, 68, 68, 1, 23, 1, 0, 'xscbzx', '2021-06-21 15:05:26.000000', 'xscbzx', '2021-06-21 15:05:26.000000');
INSERT INTO `b_demand` VALUES (614, 74, 74, 2, 23, 1, 0, 'xscbzx', '2021-06-21 15:06:03.000000', 'xscbzx', '2021-06-21 15:38:34.000000');
INSERT INTO `b_demand` VALUES (615, 76, 76, 1, 23, 1, 0, 'xscbzx', '2021-06-21 15:06:10.000000', 'xscbzx', '2021-06-21 15:06:10.000000');
INSERT INTO `b_demand` VALUES (616, 124, 124, 5, 23, 1, 0, 'xscbzx', '2021-06-21 15:07:13.000000', 'xscbzx', '2021-06-21 15:07:13.000000');
INSERT INTO `b_demand` VALUES (617, 87, 87, 13, 23, 1, 0, 'xscbzx', '2021-06-21 15:08:51.000000', 'xscbzx', '2021-06-21 15:56:40.000000');
INSERT INTO `b_demand` VALUES (618, 98, 98, 1, 23, 1, 0, 'xscbzx', '2021-06-21 15:09:09.000000', 'xscbzx', '2021-06-21 15:09:09.000000');
INSERT INTO `b_demand` VALUES (619, 116, 116, 10, 23, 1, 0, 'xscbzx', '2021-06-21 15:10:09.000000', 'xscbzx', '2021-06-21 15:41:52.000000');
INSERT INTO `b_demand` VALUES (620, 44, 44, 1, 23, 1, 0, 'xscbzx', '2021-06-21 15:10:26.000000', 'xscbzx', '2021-06-21 15:10:26.000000');
INSERT INTO `b_demand` VALUES (621, 84, 84, 1, 23, 1, 0, 'xscbzx', '2021-06-21 15:10:48.000000', 'xscbzx', '2021-06-21 15:10:48.000000');
INSERT INTO `b_demand` VALUES (622, 50, 50, 2, 23, 1, 0, 'xscbzx', '2021-06-21 15:11:26.000000', 'xscbzx', '2021-06-21 15:11:26.000000');
INSERT INTO `b_demand` VALUES (623, 30, 30, 1, 42, 1, 0, 'bsyclxy', '2021-06-21 15:10:27.000000', 'bsyclxy', '2021-06-21 15:10:27.000000');
INSERT INTO `b_demand` VALUES (624, 39, 39, 2, 23, 1, 0, 'xscbzx', '2021-06-21 15:12:26.000000', 'xscbzx', '2021-06-21 15:12:26.000000');
INSERT INTO `b_demand` VALUES (625, 93, 93, 2, 23, 1, 0, 'xscbzx', '2021-06-21 15:13:33.000000', 'xscbzx', '2021-06-21 16:05:02.000000');
INSERT INTO `b_demand` VALUES (626, 91, 91, 10, 29, 1, 0, 'tyb', '2021-06-21 15:12:40.000000', 'tyb', '2021-06-21 15:12:40.000000');
INSERT INTO `b_demand` VALUES (627, 25, 25, 4, 23, 1, 0, 'xscbzx', '2021-06-21 15:13:55.000000', 'xscbzx', '2021-06-21 15:13:55.000000');
INSERT INTO `b_demand` VALUES (628, 26, 26, 4, 23, 1, 0, 'xscbzx', '2021-06-21 15:14:01.000000', 'xscbzx', '2021-06-21 15:14:01.000000');
INSERT INTO `b_demand` VALUES (629, 43, 43, 20, 42, 1, 0, 'bsyclxy', '2021-06-21 15:12:54.000000', 'bsyclxy', '2021-06-21 15:12:54.000000');
INSERT INTO `b_demand` VALUES (630, 41, 41, 20, 42, 1, 0, 'bsyclxy', '2021-06-21 15:13:06.000000', 'bsyclxy', '2021-06-21 15:13:06.000000');
INSERT INTO `b_demand` VALUES (631, 114, 114, 40, 29, 1, 0, 'tyb', '2021-06-21 15:13:57.000000', 'tyb', '2021-06-21 15:13:57.000000');
INSERT INTO `b_demand` VALUES (632, 57, 57, 5, 42, 1, 0, 'bsyclxy', '2021-06-21 15:14:15.000000', 'bsyclxy', '2021-06-21 15:14:15.000000');
INSERT INTO `b_demand` VALUES (633, 118, 118, 2, 29, 1, 0, 'tyb', '2021-06-21 15:14:18.000000', 'tyb', '2021-06-21 15:14:18.000000');
INSERT INTO `b_demand` VALUES (634, 115, 115, 30, 29, 1, 0, 'tyb', '2021-06-21 15:14:28.000000', 'tyb', '2021-06-21 15:14:28.000000');
INSERT INTO `b_demand` VALUES (635, 63, 63, 5, 42, 1, 0, 'bsyclxy', '2021-06-21 15:14:59.000000', 'bsyclxy', '2021-06-21 15:14:59.000000');
INSERT INTO `b_demand` VALUES (636, 40, 40, 3, 23, 1, 0, 'xscbzx', '2021-06-21 15:16:37.000000', 'xscbzx', '2021-06-21 15:16:37.000000');
INSERT INTO `b_demand` VALUES (637, 116, 116, 30, 29, 1, 0, 'tyb', '2021-06-21 15:15:29.000000', 'tyb', '2021-06-21 15:16:14.000000');
INSERT INTO `b_demand` VALUES (638, 41, 41, 3, 23, 1, 0, 'xscbzx', '2021-06-21 15:16:40.000000', 'xscbzx', '2021-06-21 15:16:40.000000');
INSERT INTO `b_demand` VALUES (639, 26, 26, 10, 29, 1, 0, 'tyb', '2021-06-21 15:16:58.000000', 'tyb', '2021-06-21 15:16:58.000000');
INSERT INTO `b_demand` VALUES (640, 126, 126, 5, 42, 1, 0, 'bsyclxy', '2021-06-21 15:16:55.000000', 'bsyclxy', '2021-06-21 15:16:55.000000');
INSERT INTO `b_demand` VALUES (641, 28, 28, 10, 29, 1, 0, 'tyb', '2021-06-21 15:17:43.000000', 'tyb', '2021-06-21 15:17:43.000000');
INSERT INTO `b_demand` VALUES (642, 29, 29, 10, 29, 1, 0, 'tyb', '2021-06-21 15:17:51.000000', 'tyb', '2021-06-21 15:17:51.000000');
INSERT INTO `b_demand` VALUES (643, 30, 30, 10, 29, 1, 0, 'tyb', '2021-06-21 15:17:58.000000', 'tyb', '2021-06-21 15:17:58.000000');
INSERT INTO `b_demand` VALUES (644, 104, 104, 2, 23, 1, 0, 'xscbzx', '2021-06-21 15:19:21.000000', 'xscbzx', '2021-06-21 15:19:21.000000');
INSERT INTO `b_demand` VALUES (645, 101, 101, 5, 42, 1, 0, 'bsyclxy', '2021-06-21 15:23:00.000000', 'bsyclxy', '2021-06-21 15:23:00.000000');
INSERT INTO `b_demand` VALUES (646, 102, 102, 5, 42, 1, 0, 'bsyclxy', '2021-06-21 15:23:13.000000', 'bsyclxy', '2021-06-21 15:23:13.000000');
INSERT INTO `b_demand` VALUES (647, 103, 103, 5, 42, 1, 0, 'bsyclxy', '2021-06-21 15:23:25.000000', 'bsyclxy', '2021-06-21 15:23:25.000000');
INSERT INTO `b_demand` VALUES (648, 104, 104, 10, 42, 1, 0, 'bsyclxy', '2021-06-21 15:23:33.000000', 'bsyclxy', '2021-06-21 15:23:33.000000');
INSERT INTO `b_demand` VALUES (649, 37, 37, 15, 29, 1, 0, 'tyb', '2021-06-21 15:24:09.000000', 'tyb', '2021-06-21 15:24:09.000000');
INSERT INTO `b_demand` VALUES (650, 40, 40, 10, 29, 1, 0, 'tyb', '2021-06-21 15:24:42.000000', 'tyb', '2021-06-21 15:24:42.000000');
INSERT INTO `b_demand` VALUES (651, 41, 41, 10, 29, 1, 0, 'tyb', '2021-06-21 15:24:51.000000', 'tyb', '2021-06-21 15:24:51.000000');
INSERT INTO `b_demand` VALUES (652, 50, 50, 5, 29, 1, 0, 'tyb', '2021-06-21 15:26:05.000000', 'tyb', '2021-06-21 15:26:05.000000');
INSERT INTO `b_demand` VALUES (653, 56, 56, 1, 29, 1, 0, 'tyb', '2021-06-21 15:30:04.000000', 'tyb', '2021-06-21 15:30:04.000000');
INSERT INTO `b_demand` VALUES (654, 57, 57, 1, 29, 1, 0, 'tyb', '2021-06-21 15:30:11.000000', 'tyb', '2021-06-21 15:30:11.000000');
INSERT INTO `b_demand` VALUES (655, 58, 58, 1, 29, 1, 0, 'tyb', '2021-06-21 15:30:18.000000', 'tyb', '2021-06-21 15:30:18.000000');
INSERT INTO `b_demand` VALUES (656, 59, 59, 1, 29, 1, 0, 'tyb', '2021-06-21 15:30:25.000000', 'tyb', '2021-06-21 15:30:25.000000');
INSERT INTO `b_demand` VALUES (657, 72, 72, 2, 29, 1, 0, 'tyb', '2021-06-21 15:30:48.000000', 'tyb', '2021-06-21 15:30:48.000000');
INSERT INTO `b_demand` VALUES (658, 86, 86, 10, 29, 1, 0, 'tyb', '2021-06-21 15:32:03.000000', 'tyb', '2021-06-21 15:32:03.000000');
INSERT INTO `b_demand` VALUES (659, 87, 87, 10, 29, 1, 0, 'tyb', '2021-06-21 15:32:12.000000', 'tyb', '2021-06-21 15:32:12.000000');
INSERT INTO `b_demand` VALUES (660, 88, 88, 10, 29, 1, 0, 'tyb', '2021-06-21 15:32:21.000000', 'tyb', '2021-06-21 15:32:21.000000');
INSERT INTO `b_demand` VALUES (661, 90, 90, 10, 29, 1, 0, 'tyb', '2021-06-21 15:32:30.000000', 'tyb', '2021-06-21 15:32:30.000000');
INSERT INTO `b_demand` VALUES (662, 93, 93, 2, 29, 1, 0, 'tyb', '2021-06-21 15:32:51.000000', 'tyb', '2021-06-21 15:32:51.000000');
INSERT INTO `b_demand` VALUES (663, 88, 88, 13, 23, 1, 0, 'xscbzx', '2021-06-21 15:34:08.000000', 'xscbzx', '2021-06-21 15:34:08.000000');
INSERT INTO `b_demand` VALUES (664, 96, 96, 20, 29, 1, 0, 'tyb', '2021-06-21 15:33:11.000000', 'tyb', '2021-06-21 15:33:11.000000');
INSERT INTO `b_demand` VALUES (665, 102, 102, 1, 23, 1, 0, 'xscbzx', '2021-06-21 15:36:29.000000', 'xscbzx', '2021-06-21 15:36:29.000000');
INSERT INTO `b_demand` VALUES (666, 104, 104, 10, 29, 1, 0, 'tyb', '2021-06-21 15:38:09.000000', 'tyb', '2021-06-21 15:38:09.000000');
INSERT INTO `b_demand` VALUES (667, 107, 107, 1, 23, 1, 0, 'xscbzx', '2021-06-21 15:40:25.000000', 'xscbzx', '2021-06-21 15:40:25.000000');
INSERT INTO `b_demand` VALUES (668, 114, 114, 1, 23, 1, 0, 'xscbzx', '2021-06-21 15:41:12.000000', 'xscbzx', '2021-06-21 15:41:12.000000');
INSERT INTO `b_demand` VALUES (669, 69, 69, 2, 29, 1, 0, 'tyb', '2021-06-21 15:41:14.000000', 'tyb', '2021-06-21 15:41:14.000000');
INSERT INTO `b_demand` VALUES (670, 32, 32, 100, 40, 1, 0, 'yywhxy', '2021-06-21 15:44:03.000000', 'yywhxy', '2021-06-21 15:44:03.000000');
INSERT INTO `b_demand` VALUES (671, 36, 36, 5, 40, 1, 0, 'yywhxy', '2021-06-21 15:45:18.000000', 'yywhxy', '2021-06-21 15:45:18.000000');
INSERT INTO `b_demand` VALUES (672, 103, 103, 5, 41, 1, 0, 'jxjyxy', '2021-06-21 15:49:40.000000', 'jxjyxy', '2021-06-21 15:49:40.000000');
INSERT INTO `b_demand` VALUES (673, 37, 37, 15, 40, 1, 0, 'yywhxy', '2021-06-21 15:50:37.000000', 'yywhxy', '2021-06-21 15:50:37.000000');
INSERT INTO `b_demand` VALUES (674, 101, 101, 5, 41, 1, 0, 'jxjyxy', '2021-06-21 15:50:36.000000', 'jxjyxy', '2021-06-21 16:14:58.000000');
INSERT INTO `b_demand` VALUES (675, 40, 40, 15, 40, 1, 0, 'yywhxy', '2021-06-21 15:52:02.000000', 'yywhxy', '2021-06-21 15:52:02.000000');
INSERT INTO `b_demand` VALUES (676, 1, 1, 11, 15, 1, 0, 'gyzcglc', '2021-06-21 15:51:35.000000', 'gyzcglc', '2021-06-21 15:51:35.000000');
INSERT INTO `b_demand` VALUES (677, 41, 41, 15, 40, 1, 0, 'yywhxy', '2021-06-21 15:52:19.000000', 'yywhxy', '2021-06-21 15:52:19.000000');
INSERT INTO `b_demand` VALUES (678, 20, 20, 1, 15, 1, 0, 'gyzcglc', '2021-06-21 15:52:02.000000', 'gyzcglc', '2021-06-21 15:52:02.000000');
INSERT INTO `b_demand` VALUES (679, 91, 91, 2, 41, 1, 0, 'jxjyxy', '2021-06-21 15:52:09.000000', 'jxjyxy', '2021-06-21 15:52:09.000000');
INSERT INTO `b_demand` VALUES (680, 12, 12, 2, 15, 1, 0, 'gyzcglc', '2021-06-21 15:52:26.000000', 'gyzcglc', '2021-06-21 15:52:26.000000');
INSERT INTO `b_demand` VALUES (681, 82, 82, 2, 41, 1, 0, 'jxjyxy', '2021-06-21 15:53:19.000000', 'jxjyxy', '2021-06-21 15:53:19.000000');
INSERT INTO `b_demand` VALUES (682, 59, 59, 4, 40, 1, 0, 'yywhxy', '2021-06-21 15:54:16.000000', 'yywhxy', '2021-06-21 15:54:16.000000');
INSERT INTO `b_demand` VALUES (684, 65, 65, 10, 40, 1, 0, 'yywhxy', '2021-06-21 15:56:42.000000', 'yywhxy', '2021-06-21 15:56:42.000000');
INSERT INTO `b_demand` VALUES (685, 39, 39, 60, 15, 1, 0, 'gyzcglc', '2021-06-21 15:56:38.000000', 'gyzcglc', '2021-06-21 15:56:38.000000');
INSERT INTO `b_demand` VALUES (686, 88, 88, 18, 41, 1, 0, 'jxjyxy', '2021-06-21 15:57:11.000000', 'jxjyxy', '2021-06-21 15:57:11.000000');
INSERT INTO `b_demand` VALUES (687, 74, 74, 3, 40, 1, 0, 'yywhxy', '2021-06-21 15:57:40.000000', 'yywhxy', '2021-06-21 15:57:40.000000');
INSERT INTO `b_demand` VALUES (688, 90, 90, 18, 41, 1, 0, 'jxjyxy', '2021-06-21 15:57:23.000000', 'jxjyxy', '2021-06-21 15:57:23.000000');
INSERT INTO `b_demand` VALUES (689, 76, 76, 5, 40, 1, 0, 'yywhxy', '2021-06-21 15:58:20.000000', 'yywhxy', '2021-06-21 15:58:20.000000');
INSERT INTO `b_demand` VALUES (690, 61, 61, 5, 15, 1, 0, 'gyzcglc', '2021-06-21 15:58:16.000000', 'gyzcglc', '2021-06-21 15:58:16.000000');
INSERT INTO `b_demand` VALUES (691, 124, 124, 10, 40, 1, 0, 'yywhxy', '2021-06-21 15:59:03.000000', 'yywhxy', '2021-06-21 15:59:03.000000');
INSERT INTO `b_demand` VALUES (692, 17, 17, 20, 15, 1, 0, 'gyzcglc', '2021-06-21 15:58:45.000000', 'gyzcglc', '2021-06-21 15:58:45.000000');
INSERT INTO `b_demand` VALUES (693, 121, 121, 3, 23, 1, 0, 'xscbzx', '2021-06-21 16:00:03.000000', 'xscbzx', '2021-06-21 16:00:03.000000');
INSERT INTO `b_demand` VALUES (694, 24, 24, 10, 15, 1, 0, 'gyzcglc', '2021-06-21 15:59:06.000000', 'gyzcglc', '2021-06-21 15:59:06.000000');
INSERT INTO `b_demand` VALUES (695, 41, 41, 20, 15, 1, 0, 'gyzcglc', '2021-06-21 15:59:22.000000', 'gyzcglc', '2021-06-21 15:59:22.000000');
INSERT INTO `b_demand` VALUES (696, 86, 86, 20, 15, 1, 0, 'gyzcglc', '2021-06-21 16:03:54.000000', 'gyzcglc', '2021-06-21 16:03:54.000000');
INSERT INTO `b_demand` VALUES (697, 87, 87, 20, 15, 1, 0, 'gyzcglc', '2021-06-21 16:04:03.000000', 'gyzcglc', '2021-06-21 16:04:03.000000');
INSERT INTO `b_demand` VALUES (698, 44, 44, 2, 15, 1, 0, 'gyzcglc', '2021-06-21 16:04:27.000000', 'gyzcglc', '2021-06-21 16:04:27.000000');
INSERT INTO `b_demand` VALUES (699, 95, 95, 30, 15, 1, 0, 'gyzcglc', '2021-06-21 16:04:57.000000', 'gyzcglc', '2021-06-21 16:04:57.000000');
INSERT INTO `b_demand` VALUES (700, 96, 96, 20, 15, 1, 0, 'gyzcglc', '2021-06-21 16:05:20.000000', 'gyzcglc', '2021-06-21 16:05:20.000000');
INSERT INTO `b_demand` VALUES (701, 95, 95, 2, 40, 1, 0, 'yywhxy', '2021-06-21 16:05:50.000000', 'yywhxy', '2021-06-21 16:05:50.000000');
INSERT INTO `b_demand` VALUES (702, 32, 32, 200, 15, 1, 0, 'gyzcglc', '2021-06-21 16:05:37.000000', 'gyzcglc', '2021-06-21 16:05:37.000000');
INSERT INTO `b_demand` VALUES (704, 85, 85, 4, 15, 1, 0, 'gyzcglc', '2021-06-21 16:06:09.000000', 'gyzcglc', '2021-06-21 16:06:09.000000');
INSERT INTO `b_demand` VALUES (707, 96, 96, 1, 47, 1, 0, 'csdzygcxy', '2021-06-21 16:07:08.000000', 'csdzygcxy', '2021-06-21 16:07:08.000000');
INSERT INTO `b_demand` VALUES (708, 27, 27, 5, 40, 1, 0, 'yywhxy', '2021-06-21 16:07:57.000000', 'yywhxy', '2021-06-21 16:07:57.000000');
INSERT INTO `b_demand` VALUES (709, 32, 32, 300, 47, 1, 0, 'csdzygcxy', '2021-06-21 16:07:49.000000', 'csdzygcxy', '2021-06-22 08:50:54.000000');
INSERT INTO `b_demand` VALUES (710, 49, 49, 36, 47, 1, 0, 'csdzygcxy', '2021-06-21 16:08:39.000000', 'csdzygcxy', '2021-06-21 16:08:39.000000');
INSERT INTO `b_demand` VALUES (711, 66, 66, 5, 47, 1, 0, 'csdzygcxy', '2021-06-21 16:09:28.000000', 'csdzygcxy', '2021-06-22 08:48:37.000000');
INSERT INTO `b_demand` VALUES (712, 77, 77, 2, 47, 1, 0, 'csdzygcxy', '2021-06-21 16:09:56.000000', 'csdzygcxy', '2021-06-21 16:09:56.000000');
INSERT INTO `b_demand` VALUES (713, 38, 38, 36, 15, 1, 0, 'gyzcglc', '2021-06-21 16:09:59.000000', 'gyzcglc', '2021-06-21 16:09:59.000000');
INSERT INTO `b_demand` VALUES (714, 126, 126, 4, 47, 1, 0, 'csdzygcxy', '2021-06-21 16:10:26.000000', 'csdzygcxy', '2021-06-21 16:10:26.000000');
INSERT INTO `b_demand` VALUES (715, 34, 34, 96, 15, 1, 0, 'gyzcglc', '2021-06-21 16:10:26.000000', 'gyzcglc', '2021-06-21 16:10:26.000000');
INSERT INTO `b_demand` VALUES (716, 16, 16, 1, 41, 1, 0, 'jxjyxy', '2021-06-21 16:17:48.000000', 'jxjyxy', '2021-06-21 16:20:59.000000');
INSERT INTO `b_demand` VALUES (717, 14, 14, 1, 41, 1, 0, 'jxjyxy', '2021-06-21 16:17:59.000000', 'jxjyxy', '2021-06-21 16:20:36.000000');
INSERT INTO `b_demand` VALUES (719, 99, 99, 1, 16, 1, 0, 'xyghjsc', '2021-06-21 16:44:25.000000', 'xyghjsc', '2021-06-21 16:44:25.000000');
INSERT INTO `b_demand` VALUES (721, 110, 110, 6, 16, 1, 0, 'xyghjsc', '2021-06-21 16:49:46.000000', 'xyghjsc', '2021-06-21 16:49:46.000000');
INSERT INTO `b_demand` VALUES (722, 118, 118, 1, 16, 1, 0, 'xyghjsc', '2021-06-21 16:49:58.000000', 'xyghjsc', '2021-06-21 16:49:58.000000');
INSERT INTO `b_demand` VALUES (723, 115, 115, 6, 16, 1, 0, 'xyghjsc', '2021-06-21 16:50:09.000000', 'xyghjsc', '2021-06-21 16:50:09.000000');
INSERT INTO `b_demand` VALUES (724, 116, 116, 6, 16, 1, 0, 'xyghjsc', '2021-06-21 16:50:14.000000', 'xyghjsc', '2021-06-21 16:50:14.000000');
INSERT INTO `b_demand` VALUES (725, 94, 94, 4, 16, 1, 0, 'xyghjsc', '2021-06-21 16:52:23.000000', 'xyghjsc', '2021-06-21 16:52:23.000000');
INSERT INTO `b_demand` VALUES (726, 96, 96, 2, 16, 1, 0, 'xyghjsc', '2021-06-21 16:52:30.000000', 'xyghjsc', '2021-06-21 16:52:30.000000');
INSERT INTO `b_demand` VALUES (727, 3, 3, 2, 16, 1, 0, 'xyghjsc', '2021-06-21 16:53:29.000000', 'xyghjsc', '2021-06-21 16:53:29.000000');
INSERT INTO `b_demand` VALUES (728, 1, 1, 5, 16, 1, 0, 'xyghjsc', '2021-06-21 16:53:36.000000', 'xyghjsc', '2021-06-21 16:53:36.000000');
INSERT INTO `b_demand` VALUES (730, 20, 20, 1, 16, 1, 0, 'xyghjsc', '2021-06-21 16:53:54.000000', 'xyghjsc', '2021-06-21 16:53:54.000000');
INSERT INTO `b_demand` VALUES (733, 32, 32, 15, 16, 1, 0, 'xyghjsc', '2021-06-21 16:54:37.000000', 'xyghjsc', '2021-06-21 16:54:37.000000');
INSERT INTO `b_demand` VALUES (734, 31, 31, 8, 16, 1, 0, 'xyghjsc', '2021-06-21 16:54:50.000000', 'xyghjsc', '2021-06-21 16:54:50.000000');
INSERT INTO `b_demand` VALUES (736, 40, 40, 5, 16, 1, 0, 'xyghjsc', '2021-06-21 16:55:51.000000', 'xyghjsc', '2021-06-21 16:55:51.000000');
INSERT INTO `b_demand` VALUES (737, 41, 41, 5, 16, 1, 0, 'xyghjsc', '2021-06-21 16:56:02.000000', 'xyghjsc', '2021-06-21 16:56:02.000000');
INSERT INTO `b_demand` VALUES (738, 42, 42, 5, 16, 1, 0, 'xyghjsc', '2021-06-21 16:56:08.000000', 'xyghjsc', '2021-06-21 16:56:08.000000');
INSERT INTO `b_demand` VALUES (740, 65, 65, 1, 16, 1, 0, 'xyghjsc', '2021-06-21 16:56:36.000000', 'xyghjsc', '2021-06-21 16:56:36.000000');
INSERT INTO `b_demand` VALUES (741, 63, 63, 3, 16, 1, 0, 'xyghjsc', '2021-06-21 16:56:52.000000', 'xyghjsc', '2021-06-21 16:56:52.000000');
INSERT INTO `b_demand` VALUES (742, 49, 49, 6, 16, 1, 0, 'xyghjsc', '2021-06-21 16:57:02.000000', 'xyghjsc', '2021-06-21 16:57:02.000000');
INSERT INTO `b_demand` VALUES (743, 67, 67, 2, 16, 1, 0, 'xyghjsc', '2021-06-21 16:57:24.000000', 'xyghjsc', '2021-06-21 16:57:24.000000');
INSERT INTO `b_demand` VALUES (744, 69, 69, 2, 16, 1, 0, 'xyghjsc', '2021-06-21 16:57:49.000000', 'xyghjsc', '2021-06-21 16:57:49.000000');
INSERT INTO `b_demand` VALUES (745, 124, 124, 2, 16, 1, 0, 'xyghjsc', '2021-06-21 16:58:23.000000', 'xyghjsc', '2021-06-21 16:58:23.000000');
INSERT INTO `b_demand` VALUES (746, 115, 115, 20, 40, 1, 0, 'yywhxy', '2021-06-21 17:01:04.000000', 'yywhxy', '2021-06-21 17:01:04.000000');
INSERT INTO `b_demand` VALUES (747, 116, 116, 20, 40, 1, 0, 'yywhxy', '2021-06-21 17:01:18.000000', 'yywhxy', '2021-06-21 17:01:18.000000');
INSERT INTO `b_demand` VALUES (748, 21, 21, 10, 40, 1, 0, 'yywhxy', '2021-06-21 17:02:05.000000', 'yywhxy', '2021-06-21 17:02:05.000000');
INSERT INTO `b_demand` VALUES (749, 86, 86, 178, 40, 1, 0, 'yywhxy', '2021-06-21 17:04:06.000000', 'yywhxy', '2021-06-21 17:04:06.000000');
INSERT INTO `b_demand` VALUES (750, 28, 28, 30, 16, 1, 0, 'xyghjsc', '2021-06-21 17:06:05.000000', 'xyghjsc', '2021-06-21 17:06:05.000000');
INSERT INTO `b_demand` VALUES (751, 29, 29, 5, 16, 1, 0, 'xyghjsc', '2021-06-21 17:06:19.000000', 'xyghjsc', '2021-06-21 17:06:19.000000');
INSERT INTO `b_demand` VALUES (752, 1, 1, 3, 17, 1, 0, 'gjjlhzc', '2021-06-21 17:11:15.000000', 'gjjlhzc', '2021-06-22 08:24:24.000000');
INSERT INTO `b_demand` VALUES (753, 127, 127, 2, 17, 1, 0, 'gjjlhzc', '2021-06-21 17:12:34.000000', 'gjjlhzc', '2021-06-21 17:12:34.000000');
INSERT INTO `b_demand` VALUES (754, 17, 17, 3, 16, 1, 0, 'xyghjsc', '2021-06-21 17:12:48.000000', 'xyghjsc', '2021-06-21 17:12:48.000000');
INSERT INTO `b_demand` VALUES (755, 39, 39, 5, 16, 1, 0, 'xyghjsc', '2021-06-21 17:13:03.000000', 'xyghjsc', '2021-06-21 17:13:03.000000');
INSERT INTO `b_demand` VALUES (756, 37, 37, 5, 16, 1, 0, 'xyghjsc', '2021-06-21 17:14:43.000000', 'xyghjsc', '2021-06-21 17:14:43.000000');
INSERT INTO `b_demand` VALUES (757, 105, 105, 1, 16, 1, 0, 'xyghjsc', '2021-06-21 17:17:36.000000', 'xyghjsc', '2021-06-21 17:17:36.000000');
INSERT INTO `b_demand` VALUES (758, 104, 104, 1, 16, 1, 0, 'xyghjsc', '2021-06-21 17:17:42.000000', 'xyghjsc', '2021-06-21 17:17:42.000000');
INSERT INTO `b_demand` VALUES (759, 116, 116, 20, 11, 1, 0, 'lgbc', '2021-06-21 17:39:22.000000', 'lgbc', '2021-06-21 17:39:22.000000');
INSERT INTO `b_demand` VALUES (760, 115, 115, 10, 11, 1, 0, 'lgbc', '2021-06-21 17:39:50.000000', 'lgbc', '2021-06-21 17:39:50.000000');
INSERT INTO `b_demand` VALUES (761, 108, 108, 2, 11, 1, 0, 'lgbc', '2021-06-21 17:40:32.000000', 'lgbc', '2021-06-21 17:40:32.000000');
INSERT INTO `b_demand` VALUES (762, 114, 114, 2, 11, 1, 0, 'lgbc', '2021-06-21 17:41:01.000000', 'lgbc', '2021-06-21 17:41:01.000000');
INSERT INTO `b_demand` VALUES (764, 3, 3, 2, 11, 1, 0, 'lgbc', '2021-06-21 17:41:44.000000', 'lgbc', '2021-06-21 17:41:44.000000');
INSERT INTO `b_demand` VALUES (765, 118, 118, 1, 11, 1, 0, 'lgbc', '2021-06-21 17:43:57.000000', 'lgbc', '2021-06-21 17:43:57.000000');
INSERT INTO `b_demand` VALUES (772, 100, 100, 1, 41, 1, 0, 'jxjyxy', '2021-06-21 18:00:23.000000', 'jxjyxy', '2021-06-22 09:30:18.000000');
INSERT INTO `b_demand` VALUES (774, 126, 126, 4, 16, 1, 0, 'xyghjsc', '2021-06-21 18:05:21.000000', 'xyghjsc', '2021-06-21 18:05:21.000000');
INSERT INTO `b_demand` VALUES (775, 48, 48, 1, 16, 1, 0, 'xyghjsc', '2021-06-21 18:06:34.000000', 'xyghjsc', '2021-06-21 18:06:34.000000');
INSERT INTO `b_demand` VALUES (776, 115, 115, 8, 41, 1, 0, 'jxjyxy', '2021-06-21 18:14:57.000000', 'jxjyxy', '2021-06-21 18:14:57.000000');
INSERT INTO `b_demand` VALUES (777, 116, 116, 8, 41, 1, 0, 'jxjyxy', '2021-06-21 18:15:12.000000', 'jxjyxy', '2021-06-21 18:15:12.000000');
INSERT INTO `b_demand` VALUES (778, 110, 110, 5, 41, 1, 0, 'jxjyxy', '2021-06-21 18:25:25.000000', 'jxjyxy', '2021-06-22 09:26:47.000000');
INSERT INTO `b_demand` VALUES (779, 118, 118, 2, 41, 1, 0, 'jxjyxy', '2021-06-21 18:25:39.000000', 'jxjyxy', '2021-06-21 18:25:39.000000');
INSERT INTO `b_demand` VALUES (780, 1, 1, 10, 13, 1, 0, 'xsgzc', '2021-06-21 22:22:33.000000', 'xsgzc', '2021-06-21 22:41:22.000000');
INSERT INTO `b_demand` VALUES (781, 48, 48, 10, 13, 1, 0, 'xsgzc', '2021-06-21 22:24:07.000000', 'xsgzc', '2021-06-21 22:24:07.000000');
INSERT INTO `b_demand` VALUES (782, 53, 53, 2, 13, 1, 0, 'xsgzc', '2021-06-21 22:25:28.000000', 'xsgzc', '2021-06-21 22:25:28.000000');
INSERT INTO `b_demand` VALUES (783, 59, 59, 10, 13, 1, 0, 'xsgzc', '2021-06-21 22:26:16.000000', 'xsgzc', '2021-06-21 22:37:50.000000');
INSERT INTO `b_demand` VALUES (784, 58, 58, 5, 13, 1, 0, 'xsgzc', '2021-06-21 22:27:12.000000', 'xsgzc', '2021-06-21 22:38:33.000000');
INSERT INTO `b_demand` VALUES (785, 61, 61, 2, 13, 1, 0, 'xsgzc', '2021-06-21 22:27:35.000000', 'xsgzc', '2021-06-21 22:27:35.000000');
INSERT INTO `b_demand` VALUES (786, 63, 63, 2, 13, 1, 0, 'xsgzc', '2021-06-21 22:28:00.000000', 'xsgzc', '2021-06-21 22:28:00.000000');
INSERT INTO `b_demand` VALUES (787, 67, 67, 10, 13, 1, 0, 'xsgzc', '2021-06-21 22:29:36.000000', 'xsgzc', '2021-06-21 22:29:36.000000');
INSERT INTO `b_demand` VALUES (788, 76, 76, 10, 13, 1, 0, 'xsgzc', '2021-06-21 22:30:10.000000', 'xsgzc', '2021-06-21 22:30:10.000000');
INSERT INTO `b_demand` VALUES (790, 88, 88, 5, 13, 1, 0, 'xsgzc', '2021-06-21 22:32:38.000000', 'xsgzc', '2021-06-21 22:39:06.000000');
INSERT INTO `b_demand` VALUES (791, 127, 127, 2, 13, 1, 0, 'xsgzc', '2021-06-21 22:34:15.000000', 'xsgzc', '2021-06-21 22:34:15.000000');
INSERT INTO `b_demand` VALUES (792, 94, 94, 10, 13, 1, 0, 'xsgzc', '2021-06-21 22:34:36.000000', 'xsgzc', '2021-06-21 22:34:36.000000');
INSERT INTO `b_demand` VALUES (793, 39, 39, 10, 13, 1, 0, 'xsgzc', '2021-06-21 22:40:22.000000', 'xsgzc', '2021-06-21 22:40:22.000000');
INSERT INTO `b_demand` VALUES (794, 104, 104, 4, 13, 1, 0, 'xsgzc', '2021-06-21 22:43:20.000000', 'xsgzc', '2021-06-21 22:43:20.000000');
INSERT INTO `b_demand` VALUES (795, 92, 92, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 22:43:43.000000', 'wlxxaqsys', '2021-06-21 22:43:43.000000');
INSERT INTO `b_demand` VALUES (796, 106, 106, 2, 13, 1, 0, 'xsgzc', '2021-06-21 22:43:59.000000', 'xsgzc', '2021-06-21 22:43:59.000000');
INSERT INTO `b_demand` VALUES (797, 1, 1, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 22:44:13.000000', 'wlxxaqsys', '2021-06-21 22:44:13.000000');
INSERT INTO `b_demand` VALUES (798, 2, 2, 5, 48, 1, 0, 'wlxxaqsys', '2021-06-21 22:44:21.000000', 'wlxxaqsys', '2021-06-21 22:44:21.000000');
INSERT INTO `b_demand` VALUES (799, 4, 4, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 22:44:32.000000', 'wlxxaqsys', '2021-06-21 22:44:32.000000');
INSERT INTO `b_demand` VALUES (800, 5, 5, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 22:44:41.000000', 'wlxxaqsys', '2021-06-21 22:44:41.000000');
INSERT INTO `b_demand` VALUES (801, 6, 6, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 22:45:01.000000', 'wlxxaqsys', '2021-06-21 22:45:01.000000');
INSERT INTO `b_demand` VALUES (802, 7, 7, 1, 48, 1, 0, 'wlxxaqsys', '2021-06-21 22:45:07.000000', 'wlxxaqsys', '2021-06-21 22:45:07.000000');
INSERT INTO `b_demand` VALUES (803, 109, 109, 5, 13, 1, 0, 'xsgzc', '2021-06-21 22:45:48.000000', 'xsgzc', '2021-06-21 22:45:48.000000');
INSERT INTO `b_demand` VALUES (804, 41, 41, 6, 48, 1, 0, 'wlxxaqsys', '2021-06-21 22:46:07.000000', 'wlxxaqsys', '2021-06-21 22:46:07.000000');
INSERT INTO `b_demand` VALUES (805, 36, 36, 50, 13, 1, 0, 'xsgzc', '2021-06-21 22:48:44.000000', 'xsgzc', '2021-06-21 22:51:21.000000');
INSERT INTO `b_demand` VALUES (806, 77, 77, 1, 13, 1, 0, 'xsgzc', '2021-06-21 22:52:47.000000', 'xsgzc', '2021-06-21 22:52:47.000000');
INSERT INTO `b_demand` VALUES (810, 49, 49, 12, 13, 1, 0, 'xsgzc', '2021-06-21 23:01:12.000000', 'xsgzc', '2021-06-21 23:01:12.000000');
INSERT INTO `b_demand` VALUES (811, 36, 36, 5, 17, 1, 0, 'gjjlhzc', '2021-06-22 08:02:30.000000', 'gjjlhzc', '2021-06-22 09:11:27.000000');
INSERT INTO `b_demand` VALUES (812, 25, 25, 12, 47, 1, 0, 'csdzygcxy', '2021-06-22 08:40:46.000000', 'csdzygcxy', '2021-06-22 08:40:46.000000');
INSERT INTO `b_demand` VALUES (813, 26, 26, 20, 47, 1, 0, 'csdzygcxy', '2021-06-22 08:41:13.000000', 'csdzygcxy', '2021-06-22 08:41:13.000000');
INSERT INTO `b_demand` VALUES (814, 36, 36, 20, 47, 1, 0, 'csdzygcxy', '2021-06-22 08:41:54.000000', 'csdzygcxy', '2021-06-22 08:41:54.000000');
INSERT INTO `b_demand` VALUES (815, 59, 59, 10, 47, 1, 0, 'csdzygcxy', '2021-06-22 08:42:48.000000', 'csdzygcxy', '2021-06-22 08:42:48.000000');
INSERT INTO `b_demand` VALUES (816, 63, 63, 5, 47, 1, 0, 'csdzygcxy', '2021-06-22 08:43:10.000000', 'csdzygcxy', '2021-06-22 08:43:10.000000');
INSERT INTO `b_demand` VALUES (817, 78, 78, 10, 47, 1, 0, 'csdzygcxy', '2021-06-22 08:43:31.000000', 'csdzygcxy', '2021-06-22 08:43:31.000000');
INSERT INTO `b_demand` VALUES (818, 128, 128, 50, 47, 1, 0, 'csdzygcxy', '2021-06-22 08:44:23.000000', 'csdzygcxy', '2021-06-22 08:44:23.000000');
INSERT INTO `b_demand` VALUES (819, 115, 115, 20, 47, 1, 0, 'csdzygcxy', '2021-06-22 08:46:03.000000', 'csdzygcxy', '2021-06-22 08:46:03.000000');
INSERT INTO `b_demand` VALUES (820, 116, 116, 20, 47, 1, 0, 'csdzygcxy', '2021-06-22 08:46:13.000000', 'csdzygcxy', '2021-06-22 08:46:13.000000');
INSERT INTO `b_demand` VALUES (823, 5, 5, 4, 41, 1, 0, 'jxjyxy', '2021-06-22 09:51:52.000000', 'jxjyxy', '2021-06-22 09:51:52.000000');
INSERT INTO `b_demand` VALUES (824, 74, 74, 5, 39, 1, 0, 'dqkxxy', '2021-06-22 11:18:58.000000', 'dqkxxy', '2021-06-22 11:18:58.000000');
INSERT INTO `b_demand` VALUES (826, 101, 101, 10, 39, 1, 0, 'dqkxxy', '2021-06-22 11:20:52.000000', 'dqkxxy', '2021-06-22 11:20:52.000000');
INSERT INTO `b_demand` VALUES (827, 103, 103, 10, 39, 1, 0, 'dqkxxy', '2021-06-22 11:21:20.000000', 'dqkxxy', '2021-06-22 11:21:20.000000');
INSERT INTO `b_demand` VALUES (828, 104, 104, 10, 39, 1, 0, 'dqkxxy', '2021-06-22 11:21:46.000000', 'dqkxxy', '2021-06-22 11:21:46.000000');
INSERT INTO `b_demand` VALUES (829, 105, 105, 10, 39, 1, 0, 'dqkxxy', '2021-06-22 11:22:02.000000', 'dqkxxy', '2021-06-22 11:22:02.000000');
INSERT INTO `b_demand` VALUES (830, 106, 106, 10, 39, 1, 0, 'dqkxxy', '2021-06-22 11:22:12.000000', 'dqkxxy', '2021-06-22 11:22:12.000000');
INSERT INTO `b_demand` VALUES (831, 115, 115, 50, 39, 1, 0, 'dqkxxy', '2021-06-22 11:26:08.000000', 'dqkxxy', '2021-06-22 11:26:08.000000');
INSERT INTO `b_demand` VALUES (832, 116, 116, 50, 39, 1, 0, 'dqkxxy', '2021-06-22 11:26:17.000000', 'dqkxxy', '2021-06-22 11:26:17.000000');
INSERT INTO `b_demand` VALUES (833, 93, 93, 20, 39, 1, 0, 'dqkxxy', '2021-06-22 11:27:25.000000', 'dqkxxy', '2021-06-22 11:27:25.000000');
INSERT INTO `b_demand` VALUES (834, 98, 98, 1, 41, 1, 0, 'jxjyxy', '2021-06-22 14:03:03.000000', 'jxjyxy', '2021-06-22 14:03:03.000000');
INSERT INTO `b_demand` VALUES (835, 2, 2, 10, 45, 1, 0, 'szyyhjxy', '2021-06-22 14:40:46.000000', 'szyyhjxy', '2021-06-22 14:40:46.000000');
INSERT INTO `b_demand` VALUES (836, 128, 128, 5, 45, 1, 0, 'szyyhjxy', '2021-06-22 14:41:38.000000', 'szyyhjxy', '2021-06-22 14:41:38.000000');
INSERT INTO `b_demand` VALUES (837, 106, 106, 5, 45, 1, 0, 'szyyhjxy', '2021-06-22 14:42:02.000000', 'szyyhjxy', '2021-06-22 14:42:02.000000');
INSERT INTO `b_demand` VALUES (838, 129, 129, 5, 45, 1, 0, 'szyyhjxy', '2021-06-22 14:42:26.000000', 'szyyhjxy', '2021-06-22 14:42:26.000000');
INSERT INTO `b_demand` VALUES (839, 94, 94, 20, 45, 1, 0, 'szyyhjxy', '2021-06-22 14:48:28.000000', 'szyyhjxy', '2021-06-22 14:48:28.000000');
INSERT INTO `b_demand` VALUES (840, 1, 1, 59, 22, 1, 0, 'hqjt', '2021-06-22 15:36:57.000000', 'hqjt', '2021-06-22 15:36:57.000000');
INSERT INTO `b_demand` VALUES (841, 2, 2, 7, 22, 1, 0, 'hqjt', '2021-06-22 15:37:16.000000', 'hqjt', '2021-06-22 15:37:16.000000');
INSERT INTO `b_demand` VALUES (842, 3, 3, 3, 22, 1, 0, 'hqjt', '2021-06-22 15:37:29.000000', 'hqjt', '2021-06-22 15:37:29.000000');
INSERT INTO `b_demand` VALUES (843, 121, 121, 4, 22, 1, 0, 'hqjt', '2021-06-22 15:38:07.000000', 'hqjt', '2021-06-22 15:38:07.000000');
INSERT INTO `b_demand` VALUES (844, 5, 5, 38, 22, 1, 0, 'hqjt', '2021-06-22 15:38:38.000000', 'hqjt', '2021-06-22 15:38:38.000000');
INSERT INTO `b_demand` VALUES (845, 7, 7, 2, 22, 1, 0, 'hqjt', '2021-06-22 15:39:19.000000', 'hqjt', '2021-06-22 15:39:19.000000');
INSERT INTO `b_demand` VALUES (846, 9, 9, 3, 22, 1, 0, 'hqjt', '2021-06-22 15:39:33.000000', 'hqjt', '2021-06-22 15:39:33.000000');
INSERT INTO `b_demand` VALUES (847, 4, 4, 1, 22, 1, 0, 'hqjt', '2021-06-22 15:40:02.000000', 'hqjt', '2021-06-22 15:40:02.000000');
INSERT INTO `b_demand` VALUES (848, 12, 12, 5, 22, 1, 0, 'hqjt', '2021-06-22 15:40:15.000000', 'hqjt', '2021-06-22 15:40:15.000000');
INSERT INTO `b_demand` VALUES (849, 17, 17, 27, 22, 1, 0, 'hqjt', '2021-06-22 15:40:33.000000', 'hqjt', '2021-06-22 15:40:33.000000');
INSERT INTO `b_demand` VALUES (850, 18, 18, 8, 22, 1, 0, 'hqjt', '2021-06-22 15:40:46.000000', 'hqjt', '2021-06-22 15:40:46.000000');
INSERT INTO `b_demand` VALUES (851, 19, 19, 1, 22, 1, 0, 'hqjt', '2021-06-22 15:40:58.000000', 'hqjt', '2021-06-22 15:40:58.000000');
INSERT INTO `b_demand` VALUES (852, 21, 21, 24, 22, 1, 0, 'hqjt', '2021-06-22 15:41:23.000000', 'hqjt', '2021-06-22 15:41:23.000000');
INSERT INTO `b_demand` VALUES (853, 23, 23, 20, 22, 1, 0, 'hqjt', '2021-06-22 15:41:37.000000', 'hqjt', '2021-06-22 15:41:37.000000');
INSERT INTO `b_demand` VALUES (854, 25, 25, 30, 22, 1, 0, 'hqjt', '2021-06-22 15:41:50.000000', 'hqjt', '2021-06-22 15:41:50.000000');
INSERT INTO `b_demand` VALUES (855, 26, 26, 5, 22, 1, 0, 'hqjt', '2021-06-22 15:42:05.000000', 'hqjt', '2021-06-22 15:42:05.000000');
INSERT INTO `b_demand` VALUES (856, 27, 27, 120, 22, 1, 0, 'hqjt', '2021-06-22 15:42:20.000000', 'hqjt', '2021-06-22 15:42:20.000000');
INSERT INTO `b_demand` VALUES (857, 30, 30, 30, 22, 1, 0, 'hqjt', '2021-06-22 15:42:41.000000', 'hqjt', '2021-06-22 15:42:41.000000');
INSERT INTO `b_demand` VALUES (858, 29, 29, 80, 22, 1, 0, 'hqjt', '2021-06-22 15:42:50.000000', 'hqjt', '2021-06-22 15:42:50.000000');
INSERT INTO `b_demand` VALUES (859, 31, 31, 25, 22, 1, 0, 'hqjt', '2021-06-22 15:43:08.000000', 'hqjt', '2021-06-22 15:43:08.000000');
INSERT INTO `b_demand` VALUES (860, 33, 33, 2, 22, 1, 0, 'hqjt', '2021-06-22 15:43:20.000000', 'hqjt', '2021-06-22 15:43:20.000000');
INSERT INTO `b_demand` VALUES (861, 38, 38, 85, 22, 1, 0, 'hqjt', '2021-06-22 15:43:37.000000', 'hqjt', '2021-06-22 15:43:37.000000');
INSERT INTO `b_demand` VALUES (862, 32, 32, 160, 22, 1, 0, 'hqjt', '2021-06-22 15:44:00.000000', 'hqjt', '2021-06-22 15:44:00.000000');
INSERT INTO `b_demand` VALUES (863, 39, 39, 15, 22, 1, 0, 'hqjt', '2021-06-22 15:44:22.000000', 'hqjt', '2021-06-22 15:44:22.000000');
INSERT INTO `b_demand` VALUES (864, 40, 40, 10, 22, 1, 0, 'hqjt', '2021-06-22 15:44:32.000000', 'hqjt', '2021-06-22 15:44:32.000000');
INSERT INTO `b_demand` VALUES (865, 41, 41, 85, 22, 1, 0, 'hqjt', '2021-06-22 15:44:43.000000', 'hqjt', '2021-06-22 15:44:43.000000');
INSERT INTO `b_demand` VALUES (866, 42, 42, 6, 22, 1, 0, 'hqjt', '2021-06-22 15:44:55.000000', 'hqjt', '2021-06-22 15:44:55.000000');
INSERT INTO `b_demand` VALUES (867, 43, 43, 7, 22, 1, 0, 'hqjt', '2021-06-22 15:45:07.000000', 'hqjt', '2021-06-22 15:45:07.000000');
INSERT INTO `b_demand` VALUES (868, 44, 44, 8, 22, 1, 0, 'hqjt', '2021-06-22 15:45:33.000000', 'hqjt', '2021-06-22 15:45:33.000000');
INSERT INTO `b_demand` VALUES (869, 45, 45, 3, 22, 1, 0, 'hqjt', '2021-06-22 15:45:44.000000', 'hqjt', '2021-06-22 15:45:44.000000');
INSERT INTO `b_demand` VALUES (870, 51, 51, 1, 22, 1, 0, 'hqjt', '2021-06-22 15:46:01.000000', 'hqjt', '2021-06-22 15:46:01.000000');
INSERT INTO `b_demand` VALUES (871, 46, 46, 4, 22, 1, 0, 'hqjt', '2021-06-22 15:46:10.000000', 'hqjt', '2021-06-22 15:46:10.000000');
INSERT INTO `b_demand` VALUES (872, 48, 48, 32, 22, 1, 0, 'hqjt', '2021-06-22 15:46:23.000000', 'hqjt', '2021-06-22 15:46:23.000000');
INSERT INTO `b_demand` VALUES (873, 66, 66, 2, 22, 1, 0, 'hqjt', '2021-06-22 15:46:41.000000', 'hqjt', '2021-06-22 15:46:41.000000');
INSERT INTO `b_demand` VALUES (874, 49, 49, 13, 22, 1, 0, 'hqjt', '2021-06-22 15:46:56.000000', 'hqjt', '2021-06-22 15:46:56.000000');
INSERT INTO `b_demand` VALUES (875, 50, 50, 12, 22, 1, 0, 'hqjt', '2021-06-22 15:47:16.000000', 'hqjt', '2021-06-22 15:47:16.000000');
INSERT INTO `b_demand` VALUES (876, 52, 52, 7, 22, 1, 0, 'hqjt', '2021-06-22 15:47:28.000000', 'hqjt', '2021-06-22 15:47:28.000000');
INSERT INTO `b_demand` VALUES (877, 53, 53, 4, 22, 1, 0, 'hqjt', '2021-06-22 15:47:59.000000', 'hqjt', '2021-06-22 15:47:59.000000');
INSERT INTO `b_demand` VALUES (878, 56, 56, 1, 22, 1, 0, 'hqjt', '2021-06-22 15:48:26.000000', 'hqjt', '2021-06-22 15:48:26.000000');
INSERT INTO `b_demand` VALUES (879, 57, 57, 21, 22, 1, 0, 'hqjt', '2021-06-22 15:48:36.000000', 'hqjt', '2021-06-22 15:48:36.000000');
INSERT INTO `b_demand` VALUES (880, 58, 58, 10, 22, 1, 0, 'hqjt', '2021-06-22 15:48:55.000000', 'hqjt', '2021-06-22 15:48:55.000000');
INSERT INTO `b_demand` VALUES (881, 60, 60, 16, 22, 1, 0, 'hqjt', '2021-06-22 15:49:08.000000', 'hqjt', '2021-06-22 15:49:08.000000');
INSERT INTO `b_demand` VALUES (882, 61, 61, 7, 22, 1, 0, 'hqjt', '2021-06-22 15:49:19.000000', 'hqjt', '2021-06-22 15:49:19.000000');
INSERT INTO `b_demand` VALUES (883, 63, 63, 17, 22, 1, 0, 'hqjt', '2021-06-22 15:49:30.000000', 'hqjt', '2021-06-22 16:18:44.000000');
INSERT INTO `b_demand` VALUES (884, 64, 64, 15, 22, 1, 0, 'hqjt', '2021-06-22 15:49:45.000000', 'hqjt', '2021-06-22 15:49:45.000000');
INSERT INTO `b_demand` VALUES (886, 65, 65, 9, 22, 1, 0, 'hqjt', '2021-06-22 15:50:36.000000', 'hqjt', '2021-06-22 15:50:36.000000');
INSERT INTO `b_demand` VALUES (887, 67, 67, 86, 22, 1, 0, 'hqjt', '2021-06-22 15:50:50.000000', 'hqjt', '2021-06-22 15:50:50.000000');
INSERT INTO `b_demand` VALUES (888, 68, 68, 111, 22, 1, 0, 'hqjt', '2021-06-22 15:51:07.000000', 'hqjt', '2021-06-22 15:51:07.000000');
INSERT INTO `b_demand` VALUES (889, 69, 69, 48, 22, 1, 0, 'hqjt', '2021-06-22 15:51:25.000000', 'hqjt', '2021-06-22 15:51:25.000000');
INSERT INTO `b_demand` VALUES (890, 70, 70, 2, 22, 1, 0, 'hqjt', '2021-06-22 15:51:35.000000', 'hqjt', '2021-06-22 15:51:35.000000');
INSERT INTO `b_demand` VALUES (891, 74, 74, 18, 22, 1, 0, 'hqjt', '2021-06-22 15:52:02.000000', 'hqjt', '2021-06-22 15:52:02.000000');
INSERT INTO `b_demand` VALUES (892, 76, 76, 36, 22, 1, 0, 'hqjt', '2021-06-22 15:52:13.000000', 'hqjt', '2021-06-22 15:52:13.000000');
INSERT INTO `b_demand` VALUES (893, 77, 77, 1, 22, 1, 0, 'hqjt', '2021-06-22 15:52:23.000000', 'hqjt', '2021-06-22 15:52:23.000000');
INSERT INTO `b_demand` VALUES (894, 78, 78, 3, 22, 1, 0, 'hqjt', '2021-06-22 15:52:33.000000', 'hqjt', '2021-06-22 15:52:33.000000');
INSERT INTO `b_demand` VALUES (895, 124, 124, 36, 22, 1, 0, 'hqjt', '2021-06-22 15:52:45.000000', 'hqjt', '2021-06-22 15:52:45.000000');
INSERT INTO `b_demand` VALUES (896, 125, 125, 5, 22, 1, 0, 'hqjt', '2021-06-22 15:52:57.000000', 'hqjt', '2021-06-22 15:52:57.000000');
INSERT INTO `b_demand` VALUES (897, 126, 126, 10, 22, 1, 0, 'hqjt', '2021-06-22 15:53:27.000000', 'hqjt', '2021-06-22 15:53:27.000000');
INSERT INTO `b_demand` VALUES (898, 81, 81, 2, 22, 1, 0, 'hqjt', '2021-06-22 15:53:50.000000', 'hqjt', '2021-06-22 15:53:50.000000');
INSERT INTO `b_demand` VALUES (899, 82, 82, 20, 22, 1, 0, 'hqjt', '2021-06-22 15:54:03.000000', 'hqjt', '2021-06-22 15:54:03.000000');
INSERT INTO `b_demand` VALUES (900, 83, 83, 20, 22, 1, 0, 'hqjt', '2021-06-22 15:54:08.000000', 'hqjt', '2021-06-22 15:54:08.000000');
INSERT INTO `b_demand` VALUES (901, 84, 84, 9, 22, 1, 0, 'hqjt', '2021-06-22 15:54:18.000000', 'hqjt', '2021-06-22 15:54:18.000000');
INSERT INTO `b_demand` VALUES (902, 85, 85, 76, 22, 1, 0, 'hqjt', '2021-06-22 15:54:33.000000', 'hqjt', '2021-06-22 15:54:33.000000');
INSERT INTO `b_demand` VALUES (903, 86, 86, 50, 22, 1, 0, 'hqjt', '2021-06-22 15:54:49.000000', 'hqjt', '2021-06-22 17:01:48.000000');
INSERT INTO `b_demand` VALUES (904, 87, 87, 20, 22, 1, 0, 'hqjt', '2021-06-22 15:55:16.000000', 'hqjt', '2021-06-22 17:02:38.000000');
INSERT INTO `b_demand` VALUES (905, 88, 88, 60, 22, 1, 0, 'hqjt', '2021-06-22 15:55:28.000000', 'hqjt', '2021-06-22 17:06:23.000000');
INSERT INTO `b_demand` VALUES (906, 89, 89, 50, 22, 1, 0, 'hqjt', '2021-06-22 15:55:49.000000', 'hqjt', '2021-06-22 17:07:17.000000');
INSERT INTO `b_demand` VALUES (907, 90, 90, 50, 22, 1, 0, 'hqjt', '2021-06-22 15:56:32.000000', 'hqjt', '2021-06-22 17:08:59.000000');
INSERT INTO `b_demand` VALUES (908, 91, 91, 7, 22, 1, 0, 'hqjt', '2021-06-22 15:57:42.000000', 'hqjt', '2021-06-22 15:57:42.000000');
INSERT INTO `b_demand` VALUES (909, 127, 127, 16, 22, 1, 0, 'hqjt', '2021-06-22 15:57:56.000000', 'hqjt', '2021-06-22 15:57:56.000000');
INSERT INTO `b_demand` VALUES (910, 92, 92, 12, 22, 1, 0, 'hqjt', '2021-06-22 15:58:20.000000', 'hqjt', '2021-06-22 17:09:24.000000');
INSERT INTO `b_demand` VALUES (911, 93, 93, 30, 22, 1, 0, 'hqjt', '2021-06-22 15:58:41.000000', 'hqjt', '2021-06-22 15:58:41.000000');
INSERT INTO `b_demand` VALUES (912, 94, 94, 30, 22, 1, 0, 'hqjt', '2021-06-22 15:58:55.000000', 'hqjt', '2021-06-22 15:58:55.000000');
INSERT INTO `b_demand` VALUES (913, 96, 96, 5, 22, 1, 0, 'hqjt', '2021-06-22 15:59:04.000000', 'hqjt', '2021-06-22 15:59:04.000000');
INSERT INTO `b_demand` VALUES (914, 97, 97, 4, 22, 1, 0, 'hqjt', '2021-06-22 16:00:09.000000', 'hqjt', '2021-06-22 16:00:09.000000');
INSERT INTO `b_demand` VALUES (915, 98, 98, 5, 22, 1, 0, 'hqjt', '2021-06-22 16:00:21.000000', 'hqjt', '2021-06-22 16:00:21.000000');
INSERT INTO `b_demand` VALUES (916, 100, 100, 7, 22, 1, 0, 'hqjt', '2021-06-22 16:00:32.000000', 'hqjt', '2021-06-22 16:00:32.000000');
INSERT INTO `b_demand` VALUES (917, 101, 101, 11, 22, 1, 0, 'hqjt', '2021-06-22 16:00:59.000000', 'hqjt', '2021-06-22 16:00:59.000000');
INSERT INTO `b_demand` VALUES (918, 102, 102, 7, 22, 1, 0, 'hqjt', '2021-06-22 16:01:08.000000', 'hqjt', '2021-06-22 16:01:08.000000');
INSERT INTO `b_demand` VALUES (919, 103, 103, 5, 22, 1, 0, 'hqjt', '2021-06-22 16:01:17.000000', 'hqjt', '2021-06-22 16:01:17.000000');
INSERT INTO `b_demand` VALUES (920, 104, 104, 15, 22, 1, 0, 'hqjt', '2021-06-22 16:01:31.000000', 'hqjt', '2021-06-22 16:01:31.000000');
INSERT INTO `b_demand` VALUES (921, 106, 106, 2, 22, 1, 0, 'hqjt', '2021-06-22 16:01:46.000000', 'hqjt', '2021-06-22 16:01:46.000000');
INSERT INTO `b_demand` VALUES (922, 108, 108, 10, 22, 1, 0, 'hqjt', '2021-06-22 16:02:00.000000', 'hqjt', '2021-06-22 16:02:00.000000');
INSERT INTO `b_demand` VALUES (923, 111, 111, 4, 22, 1, 0, 'hqjt', '2021-06-22 16:02:13.000000', 'hqjt', '2021-06-22 16:02:13.000000');
INSERT INTO `b_demand` VALUES (924, 112, 112, 7, 22, 1, 0, 'hqjt', '2021-06-22 16:02:24.000000', 'hqjt', '2021-06-22 16:02:24.000000');
INSERT INTO `b_demand` VALUES (925, 113, 113, 5, 22, 1, 0, 'hqjt', '2021-06-22 16:02:40.000000', 'hqjt', '2021-06-22 16:02:40.000000');
INSERT INTO `b_demand` VALUES (926, 114, 114, 3, 22, 1, 0, 'hqjt', '2021-06-22 16:02:52.000000', 'hqjt', '2021-06-22 16:02:52.000000');
INSERT INTO `b_demand` VALUES (927, 115, 115, 200, 22, 1, 0, 'hqjt', '2021-06-22 16:03:05.000000', 'hqjt', '2021-06-22 17:11:05.000000');
INSERT INTO `b_demand` VALUES (928, 116, 116, 200, 22, 1, 0, 'hqjt', '2021-06-22 16:04:03.000000', 'hqjt', '2021-06-22 17:11:18.000000');
INSERT INTO `b_demand` VALUES (929, 118, 118, 3, 22, 1, 0, 'hqjt', '2021-06-22 16:04:15.000000', 'hqjt', '2021-06-22 16:04:15.000000');
INSERT INTO `b_demand` VALUES (930, 112, 112, 8, 48, 1, 0, 'wlxxaqsys', '2021-06-22 16:38:01.000000', 'wlxxaqsys', '2021-06-22 16:38:01.000000');
INSERT INTO `b_demand` VALUES (933, 28, 28, 50, 35, 1, 0, 'yjsxy', '2021-06-22 17:53:02.000000', 'yjsxy', '2021-06-22 17:53:02.000000');
INSERT INTO `b_demand` VALUES (934, 29, 29, 1, 35, 1, 0, 'yjsxy', '2021-06-22 17:53:08.000000', 'yjsxy', '2021-06-23 08:49:40.000000');
INSERT INTO `b_demand` VALUES (939, 95, 95, 2, 35, 1, 0, 'yjsxy', '2021-06-22 17:55:10.000000', 'yjsxy', '2021-06-23 08:47:57.000000');
INSERT INTO `b_demand` VALUES (940, 115, 115, 30, 35, 1, 0, 'yjsxy', '2021-06-22 17:55:44.000000', 'yjsxy', '2021-06-22 17:56:25.000000');
INSERT INTO `b_demand` VALUES (941, 116, 116, 10, 35, 1, 0, 'yjsxy', '2021-06-22 17:55:58.000000', 'yjsxy', '2021-06-22 17:55:58.000000');
INSERT INTO `b_demand` VALUES (943, 31, 31, 20, 35, 1, 0, 'yjsxy', '2021-06-23 08:52:48.000000', 'yjsxy', '2021-06-23 08:52:48.000000');
INSERT INTO `b_demand` VALUES (944, 1, 1, 20, 8, 1, 0, 'cwc', '2021-06-23 09:25:01.000000', 'cwc', '2021-06-23 09:25:01.000000');
INSERT INTO `b_demand` VALUES (946, 4, 4, 3, 8, 1, 0, 'cwc', '2021-06-23 09:27:27.000000', 'cwc', '2021-06-23 03:19:52.000000');
INSERT INTO `b_demand` VALUES (947, 6, 6, 3, 8, 1, 0, 'cwc', '2021-06-23 09:28:01.000000', 'cwc', '2021-06-23 03:18:56.000000');
INSERT INTO `b_demand` VALUES (948, 2, 2, 20, 8, 1, 0, 'cwc', '2021-06-23 09:29:37.000000', 'cwc', '2021-06-23 03:17:52.000000');
INSERT INTO `b_demand` VALUES (949, 10, 10, 10, 8, 1, 0, 'cwc', '2021-06-23 09:30:56.000000', 'cwc', '2021-06-23 03:16:53.000000');
INSERT INTO `b_demand` VALUES (950, 11, 11, 2, 8, 1, 0, 'cwc', '2021-06-23 09:31:10.000000', 'cwc', '2021-06-23 03:16:19.000000');
INSERT INTO `b_demand` VALUES (953, 13, 13, 20, 8, 1, 0, 'cwc', '2021-06-23 09:32:45.000000', 'cwc', '2021-06-23 03:12:08.000000');
INSERT INTO `b_demand` VALUES (955, 17, 17, 30, 8, 1, 0, 'cwc', '2021-06-23 09:34:23.000000', 'cwc', '2021-06-23 09:34:23.000000');
INSERT INTO `b_demand` VALUES (956, 18, 18, 3, 8, 1, 0, 'cwc', '2021-06-23 09:35:45.000000', 'cwc', '2021-06-23 03:10:07.000000');
INSERT INTO `b_demand` VALUES (957, 20, 20, 5, 8, 1, 0, 'cwc', '2021-06-23 09:36:38.000000', 'cwc', '2021-06-23 09:36:38.000000');
INSERT INTO `b_demand` VALUES (958, 21, 21, 20, 8, 1, 0, 'cwc', '2021-06-23 09:38:01.000000', 'cwc', '2021-06-23 03:09:26.000000');
INSERT INTO `b_demand` VALUES (959, 27, 27, 10, 8, 1, 0, 'cwc', '2021-06-23 09:39:21.000000', 'cwc', '2021-06-23 09:39:21.000000');
INSERT INTO `b_demand` VALUES (960, 38, 38, 10, 8, 1, 0, 'cwc', '2021-06-23 09:43:28.000000', 'cwc', '2021-06-23 09:43:28.000000');
INSERT INTO `b_demand` VALUES (961, 35, 35, 10, 8, 1, 0, 'cwc', '2021-06-23 09:43:49.000000', 'cwc', '2021-06-23 09:43:49.000000');
INSERT INTO `b_demand` VALUES (962, 36, 36, 10, 8, 1, 0, 'cwc', '2021-06-23 09:44:28.000000', 'cwc', '2021-06-23 09:44:28.000000');
INSERT INTO `b_demand` VALUES (963, 39, 39, 20, 8, 1, 0, 'cwc', '2021-06-23 09:45:15.000000', 'cwc', '2021-06-23 09:45:15.000000');
INSERT INTO `b_demand` VALUES (964, 45, 45, 4, 8, 1, 0, 'cwc', '2021-06-23 09:49:14.000000', 'cwc', '2021-06-23 09:49:14.000000');
INSERT INTO `b_demand` VALUES (965, 48, 48, 15, 8, 1, 0, 'cwc', '2021-06-23 09:50:38.000000', 'cwc', '2021-06-23 09:50:38.000000');
INSERT INTO `b_demand` VALUES (966, 49, 49, 6, 8, 1, 0, 'cwc', '2021-06-23 09:52:55.000000', 'cwc', '2021-06-23 09:52:55.000000');
INSERT INTO `b_demand` VALUES (967, 54, 54, 10, 8, 1, 0, 'cwc', '2021-06-23 09:53:47.000000', 'cwc', '2021-06-23 09:53:47.000000');
INSERT INTO `b_demand` VALUES (968, 59, 59, 6, 8, 1, 0, 'cwc', '2021-06-23 09:55:16.000000', 'cwc', '2021-06-23 03:06:51.000000');
INSERT INTO `b_demand` VALUES (969, 58, 58, 6, 8, 1, 0, 'cwc', '2021-06-23 09:55:25.000000', 'cwc', '2021-06-23 03:06:14.000000');
INSERT INTO `b_demand` VALUES (970, 57, 57, 6, 8, 1, 0, 'cwc', '2021-06-23 09:55:35.000000', 'cwc', '2021-06-23 03:06:34.000000');
INSERT INTO `b_demand` VALUES (971, 56, 56, 6, 8, 1, 0, 'cwc', '2021-06-23 09:55:45.000000', 'cwc', '2021-06-23 03:05:59.000000');
INSERT INTO `b_demand` VALUES (972, 60, 60, 3, 8, 1, 0, 'cwc', '2021-06-23 09:56:14.000000', 'cwc', '2021-06-23 09:56:14.000000');
INSERT INTO `b_demand` VALUES (973, 62, 62, 5, 8, 1, 0, 'cwc', '2021-06-23 09:56:36.000000', 'cwc', '2021-06-23 09:56:36.000000');
INSERT INTO `b_demand` VALUES (974, 63, 63, 10, 8, 1, 0, 'cwc', '2021-06-23 09:57:02.000000', 'cwc', '2021-06-23 03:04:41.000000');
INSERT INTO `b_demand` VALUES (975, 66, 66, 20, 8, 1, 0, 'cwc', '2021-06-23 09:57:19.000000', 'cwc', '2021-06-23 09:57:19.000000');
INSERT INTO `b_demand` VALUES (976, 67, 67, 10, 8, 1, 0, 'cwc', '2021-06-23 09:58:06.000000', 'cwc', '2021-06-23 09:58:06.000000');
INSERT INTO `b_demand` VALUES (977, 68, 68, 10, 8, 1, 0, 'cwc', '2021-06-23 09:58:16.000000', 'cwc', '2021-06-23 09:58:16.000000');
INSERT INTO `b_demand` VALUES (978, 70, 70, 2, 8, 1, 0, 'cwc', '2021-06-23 09:58:39.000000', 'cwc', '2021-06-23 09:58:39.000000');
INSERT INTO `b_demand` VALUES (979, 71, 71, 2, 8, 1, 0, 'cwc', '2021-06-23 09:58:51.000000', 'cwc', '2021-06-23 09:58:51.000000');
INSERT INTO `b_demand` VALUES (980, 74, 74, 10, 8, 1, 0, 'cwc', '2021-06-23 09:59:17.000000', 'cwc', '2021-06-23 09:59:17.000000');
INSERT INTO `b_demand` VALUES (981, 76, 76, 10, 8, 1, 0, 'cwc', '2021-06-23 09:59:36.000000', 'cwc', '2021-06-23 09:59:36.000000');
INSERT INTO `b_demand` VALUES (982, 77, 77, 5, 8, 1, 0, 'cwc', '2021-06-23 10:00:10.000000', 'cwc', '2021-06-23 10:00:10.000000');
INSERT INTO `b_demand` VALUES (983, 78, 78, 1, 8, 1, 0, 'cwc', '2021-06-23 10:02:48.000000', 'cwc', '2021-06-23 10:02:48.000000');
INSERT INTO `b_demand` VALUES (984, 124, 124, 3, 8, 1, 0, 'cwc', '2021-06-23 10:03:18.000000', 'cwc', '2021-06-23 10:03:18.000000');
INSERT INTO `b_demand` VALUES (985, 125, 125, 3, 8, 1, 0, 'cwc', '2021-06-23 10:03:28.000000', 'cwc', '2021-06-23 10:03:28.000000');
INSERT INTO `b_demand` VALUES (986, 126, 126, 8, 8, 1, 0, 'cwc', '2021-06-23 10:04:20.000000', 'cwc', '2021-06-23 10:04:20.000000');
INSERT INTO `b_demand` VALUES (987, 128, 128, 30, 8, 1, 0, 'cwc', '2021-06-23 10:05:12.000000', 'cwc', '2021-06-23 02:58:58.000000');
INSERT INTO `b_demand` VALUES (988, 82, 82, 8, 8, 1, 0, 'cwc', '2021-06-23 10:08:58.000000', 'cwc', '2021-06-23 10:08:58.000000');
INSERT INTO `b_demand` VALUES (989, 83, 83, 8, 8, 1, 0, 'cwc', '2021-06-23 10:09:05.000000', 'cwc', '2021-06-23 10:09:05.000000');
INSERT INTO `b_demand` VALUES (990, 85, 85, 8, 8, 1, 0, 'cwc', '2021-06-23 02:07:41.000000', 'cwc', '2021-06-23 02:07:41.000000');
INSERT INTO `b_demand` VALUES (991, 86, 86, 30, 8, 1, 0, 'cwc', '2021-06-23 02:11:37.000000', 'cwc', '2021-06-23 03:25:17.000000');
INSERT INTO `b_demand` VALUES (992, 87, 87, 30, 8, 1, 0, 'cwc', '2021-06-23 02:11:45.000000', 'cwc', '2021-06-23 03:24:52.000000');
INSERT INTO `b_demand` VALUES (993, 88, 88, 30, 8, 1, 0, 'cwc', '2021-06-23 02:11:54.000000', 'cwc', '2021-06-23 03:24:28.000000');
INSERT INTO `b_demand` VALUES (995, 95, 95, 5, 8, 1, 0, 'cwc', '2021-06-23 02:12:47.000000', 'cwc', '2021-06-23 14:37:08.000000');
INSERT INTO `b_demand` VALUES (996, 96, 96, 3, 8, 1, 0, 'cwc', '2021-06-23 02:13:05.000000', 'cwc', '2021-06-23 02:13:05.000000');
INSERT INTO `b_demand` VALUES (997, 100, 100, 3, 8, 1, 0, 'cwc', '2021-06-23 02:13:49.000000', 'cwc', '2021-06-23 02:13:49.000000');
INSERT INTO `b_demand` VALUES (998, 104, 104, 2, 8, 1, 0, 'cwc', '2021-06-23 02:16:05.000000', 'cwc', '2021-06-23 02:16:05.000000');
INSERT INTO `b_demand` VALUES (999, 101, 101, 2, 8, 1, 0, 'cwc', '2021-06-23 02:16:17.000000', 'cwc', '2021-06-23 02:16:17.000000');
INSERT INTO `b_demand` VALUES (1000, 106, 106, 2, 8, 1, 0, 'cwc', '2021-06-23 02:16:46.000000', 'cwc', '2021-06-23 02:16:46.000000');
INSERT INTO `b_demand` VALUES (1001, 114, 114, 8, 8, 1, 0, 'cwc', '2021-06-23 02:18:33.000000', 'cwc', '2021-06-23 02:18:33.000000');
INSERT INTO `b_demand` VALUES (1002, 115, 115, 30, 8, 1, 0, 'cwc', '2021-06-23 02:19:44.000000', 'cwc', '2021-06-23 03:32:54.000000');
INSERT INTO `b_demand` VALUES (1003, 116, 116, 30, 8, 1, 0, 'cwc', '2021-06-23 02:20:18.000000', 'cwc', '2021-06-23 03:29:51.000000');
INSERT INTO `b_demand` VALUES (1004, 92, 92, 9, 8, 1, 0, 'cwc', '2021-06-23 03:26:30.000000', 'cwc', '2021-06-23 14:39:51.000000');
INSERT INTO `b_demand` VALUES (1005, 93, 93, 6, 8, 1, 0, 'cwc', '2021-06-23 03:26:43.000000', 'cwc', '2021-06-23 03:26:43.000000');
INSERT INTO `b_demand` VALUES (1006, 1, 1, 10, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:26:10.000000', 'zyyhjgcyjs', '2021-06-23 11:26:10.000000');
INSERT INTO `b_demand` VALUES (1007, 79, 79, 8, 8, 1, 0, 'cwc', '2021-06-23 03:27:42.000000', 'cwc', '2021-06-23 14:40:36.000000');
INSERT INTO `b_demand` VALUES (1008, 4, 4, 10, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:27:31.000000', 'zyyhjgcyjs', '2021-06-23 11:27:31.000000');
INSERT INTO `b_demand` VALUES (1009, 22, 22, 9, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:28:21.000000', 'zyyhjgcyjs', '2021-06-23 11:28:21.000000');
INSERT INTO `b_demand` VALUES (1010, 28, 28, 5, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:29:09.000000', 'zyyhjgcyjs', '2021-06-23 11:29:09.000000');
INSERT INTO `b_demand` VALUES (1011, 29, 29, 5, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:29:29.000000', 'zyyhjgcyjs', '2021-06-23 11:29:29.000000');
INSERT INTO `b_demand` VALUES (1012, 41, 41, 10, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:30:25.000000', 'zyyhjgcyjs', '2021-06-23 11:30:25.000000');
INSERT INTO `b_demand` VALUES (1013, 51, 51, 5, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:31:05.000000', 'zyyhjgcyjs', '2021-06-23 11:31:05.000000');
INSERT INTO `b_demand` VALUES (1014, 56, 56, 5, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:31:59.000000', 'zyyhjgcyjs', '2021-06-23 11:31:59.000000');
INSERT INTO `b_demand` VALUES (1015, 57, 57, 5, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:32:19.000000', 'zyyhjgcyjs', '2021-06-23 11:32:19.000000');
INSERT INTO `b_demand` VALUES (1016, 58, 58, 5, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:32:41.000000', 'zyyhjgcyjs', '2021-06-23 11:32:41.000000');
INSERT INTO `b_demand` VALUES (1017, 59, 59, 5, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:32:51.000000', 'zyyhjgcyjs', '2021-06-23 11:32:51.000000');
INSERT INTO `b_demand` VALUES (1018, 67, 67, 10, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:33:23.000000', 'zyyhjgcyjs', '2021-06-23 11:33:23.000000');
INSERT INTO `b_demand` VALUES (1019, 126, 126, 5, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:34:11.000000', 'zyyhjgcyjs', '2021-06-23 11:34:11.000000');
INSERT INTO `b_demand` VALUES (1020, 86, 86, 20, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:34:53.000000', 'zyyhjgcyjs', '2021-06-23 11:34:53.000000');
INSERT INTO `b_demand` VALUES (1021, 87, 87, 20, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:35:10.000000', 'zyyhjgcyjs', '2021-06-23 11:35:10.000000');
INSERT INTO `b_demand` VALUES (1022, 88, 88, 20, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:35:20.000000', 'zyyhjgcyjs', '2021-06-23 11:35:20.000000');
INSERT INTO `b_demand` VALUES (1023, 90, 90, 20, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:35:37.000000', 'zyyhjgcyjs', '2021-06-23 11:35:37.000000');
INSERT INTO `b_demand` VALUES (1024, 95, 95, 10, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:36:06.000000', 'zyyhjgcyjs', '2021-06-23 11:36:06.000000');
INSERT INTO `b_demand` VALUES (1025, 100, 100, 5, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:37:12.000000', 'zyyhjgcyjs', '2021-06-23 11:37:12.000000');
INSERT INTO `b_demand` VALUES (1026, 106, 106, 10, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:38:14.000000', 'zyyhjgcyjs', '2021-06-23 11:38:14.000000');
INSERT INTO `b_demand` VALUES (1027, 104, 104, 10, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:38:29.000000', 'zyyhjgcyjs', '2021-06-23 11:38:29.000000');
INSERT INTO `b_demand` VALUES (1032, 114, 114, 9, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:56:11.000000', 'zyyhjgcyjs', '2021-06-23 11:56:11.000000');
INSERT INTO `b_demand` VALUES (1033, 117, 117, 9, 50, 1, 0, 'zyyhjgcyjs', '2021-06-23 11:56:36.000000', 'zyyhjgcyjs', '2021-06-23 11:56:36.000000');
INSERT INTO `b_demand` VALUES (1034, 7, 7, 5, 8, 1, 0, 'cwc', '2021-06-23 14:59:48.000000', 'cwc', '2021-06-23 14:59:48.000000');
INSERT INTO `b_demand` VALUES (1035, 5, 5, 5, 8, 1, 0, 'cwc', '2021-06-23 15:00:09.000000', 'cwc', '2021-06-23 15:00:09.000000');
INSERT INTO `b_demand` VALUES (1036, 1, 1, 10, 14, 2, 0, 'aqgzc', '2021-09-14 14:02:56.000000', 'aqgzc', '2021-09-14 14:13:24.000000');
INSERT INTO `b_demand` VALUES (1038, 23, 23, 5, 14, 2, 0, 'aqgzc', '2021-09-14 14:12:22.000000', 'aqgzc', '2021-09-14 15:24:19.000000');
INSERT INTO `b_demand` VALUES (1039, 27, 27, 10, 14, 2, 0, 'aqgzc', '2021-09-14 14:14:43.000000', 'aqgzc', '2021-09-14 15:13:33.000000');
INSERT INTO `b_demand` VALUES (1040, 39, 39, 5, 14, 2, 0, 'aqgzc', '2021-09-14 14:16:18.000000', 'aqgzc', '2021-09-14 14:33:35.000000');
INSERT INTO `b_demand` VALUES (1041, 41, 41, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:16:34.000000', 'aqgzc', '2021-09-14 15:15:48.000000');
INSERT INTO `b_demand` VALUES (1042, 50, 50, 3, 14, 2, 0, 'aqgzc', '2021-09-14 14:17:10.000000', 'aqgzc', '2021-09-14 15:17:37.000000');
INSERT INTO `b_demand` VALUES (1043, 48, 48, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:18:00.000000', 'aqgzc', '2021-09-14 15:12:05.000000');
INSERT INTO `b_demand` VALUES (1044, 82, 82, 1, 44, 2, 0, 'gdjsyjs', '2021-09-14 14:18:58.000000', 'gdjsyjs', '2021-09-14 14:18:58.000000');
INSERT INTO `b_demand` VALUES (1045, 83, 83, 1, 44, 2, 0, 'gdjsyjs', '2021-09-14 14:19:09.000000', 'gdjsyjs', '2021-09-14 14:19:09.000000');
INSERT INTO `b_demand` VALUES (1046, 84, 84, 1, 44, 2, 0, 'gdjsyjs', '2021-09-14 14:19:25.000000', 'gdjsyjs', '2021-09-14 14:19:25.000000');
INSERT INTO `b_demand` VALUES (1047, 58, 58, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:23:18.000000', 'aqgzc', '2021-09-14 15:19:20.000000');
INSERT INTO `b_demand` VALUES (1049, 63, 63, 4, 14, 2, 0, 'aqgzc', '2021-09-14 14:25:13.000000', 'aqgzc', '2021-09-14 14:25:13.000000');
INSERT INTO `b_demand` VALUES (1050, 67, 67, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:25:43.000000', 'aqgzc', '2021-09-14 15:11:11.000000');
INSERT INTO `b_demand` VALUES (1051, 1, 1, 8, 12, 2, 0, 'fzghc', '2021-09-14 14:25:53.000000', 'fzghc', '2021-09-14 14:25:53.000000');
INSERT INTO `b_demand` VALUES (1052, 72, 72, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:26:17.000000', 'aqgzc', '2021-09-14 14:26:17.000000');
INSERT INTO `b_demand` VALUES (1053, 4, 4, 3, 12, 2, 0, 'fzghc', '2021-09-14 14:26:26.000000', 'fzghc', '2021-09-14 14:26:26.000000');
INSERT INTO `b_demand` VALUES (1054, 77, 77, 1, 14, 2, 0, 'aqgzc', '2021-09-14 14:26:36.000000', 'aqgzc', '2021-09-14 14:26:36.000000');
INSERT INTO `b_demand` VALUES (1055, 78, 78, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:26:50.000000', 'aqgzc', '2021-09-14 14:26:50.000000');
INSERT INTO `b_demand` VALUES (1056, 20, 20, 2, 12, 2, 0, 'fzghc', '2021-09-14 14:27:20.000000', 'fzghc', '2021-09-14 14:27:20.000000');
INSERT INTO `b_demand` VALUES (1057, 22, 22, 8, 12, 2, 0, 'fzghc', '2021-09-14 14:28:12.000000', 'fzghc', '2021-09-14 14:28:12.000000');
INSERT INTO `b_demand` VALUES (1058, 125, 125, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:28:44.000000', 'aqgzc', '2021-09-14 15:10:17.000000');
INSERT INTO `b_demand` VALUES (1059, 26, 26, 1, 12, 2, 0, 'fzghc', '2021-09-14 14:28:48.000000', 'fzghc', '2021-09-14 14:28:48.000000');
INSERT INTO `b_demand` VALUES (1060, 49, 49, 10, 12, 2, 0, 'fzghc', '2021-09-14 14:29:50.000000', 'fzghc', '2021-09-14 14:47:40.000000');
INSERT INTO `b_demand` VALUES (1061, 52, 52, 3, 12, 2, 0, 'fzghc', '2021-09-14 14:30:15.000000', 'fzghc', '2021-09-14 14:30:15.000000');
INSERT INTO `b_demand` VALUES (1062, 1, 1, 30, 36, 2, 0, 'sljxb', '2021-09-14 14:31:06.000000', 'sljxb', '2021-09-14 14:31:06.000000');
INSERT INTO `b_demand` VALUES (1063, 11, 11, 10, 36, 2, 0, 'sljxb', '2021-09-14 14:31:21.000000', 'sljxb', '2021-09-14 14:40:34.000000');
INSERT INTO `b_demand` VALUES (1064, 63, 63, 1, 12, 2, 0, 'fzghc', '2021-09-14 14:31:20.000000', 'fzghc', '2021-09-14 14:31:20.000000');
INSERT INTO `b_demand` VALUES (1065, 17, 17, 20, 36, 2, 0, 'sljxb', '2021-09-14 14:31:57.000000', 'sljxb', '2021-09-14 14:31:57.000000');
INSERT INTO `b_demand` VALUES (1066, 25, 25, 5, 36, 2, 0, 'sljxb', '2021-09-14 14:32:23.000000', 'sljxb', '2021-09-14 14:32:23.000000');
INSERT INTO `b_demand` VALUES (1067, 67, 67, 2, 12, 2, 0, 'fzghc', '2021-09-14 14:31:55.000000', 'fzghc', '2021-09-14 14:31:55.000000');
INSERT INTO `b_demand` VALUES (1068, 68, 68, 5, 12, 2, 0, 'fzghc', '2021-09-14 14:32:11.000000', 'fzghc', '2021-09-14 14:32:11.000000');
INSERT INTO `b_demand` VALUES (1070, 76, 76, 1, 12, 2, 0, 'fzghc', '2021-09-14 14:32:53.000000', 'fzghc', '2021-09-14 14:32:53.000000');
INSERT INTO `b_demand` VALUES (1071, 67, 67, 10, 36, 2, 0, 'sljxb', '2021-09-14 14:33:42.000000', 'sljxb', '2021-09-14 14:33:42.000000');
INSERT INTO `b_demand` VALUES (1072, 69, 69, 20, 36, 2, 0, 'sljxb', '2021-09-14 14:34:00.000000', 'sljxb', '2021-09-14 14:34:00.000000');
INSERT INTO `b_demand` VALUES (1073, 126, 126, 2, 12, 2, 0, 'fzghc', '2021-09-14 14:33:39.000000', 'fzghc', '2021-09-14 14:33:39.000000');
INSERT INTO `b_demand` VALUES (1074, 125, 125, 10, 36, 2, 0, 'sljxb', '2021-09-14 14:34:29.000000', 'sljxb', '2021-09-14 14:34:29.000000');
INSERT INTO `b_demand` VALUES (1075, 82, 82, 5, 36, 2, 0, 'sljxb', '2021-09-14 14:34:57.000000', 'sljxb', '2021-09-14 14:47:45.000000');
INSERT INTO `b_demand` VALUES (1076, 83, 83, 5, 36, 2, 0, 'sljxb', '2021-09-14 14:35:07.000000', 'sljxb', '2021-09-14 14:47:32.000000');
INSERT INTO `b_demand` VALUES (1077, 31, 31, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:35:16.000000', 'aqgzc', '2021-09-14 15:16:38.000000');
INSERT INTO `b_demand` VALUES (1078, 107, 107, 2, 36, 2, 0, 'sljxb', '2021-09-14 14:36:19.000000', 'sljxb', '2021-09-14 14:43:16.000000');
INSERT INTO `b_demand` VALUES (1079, 113, 113, 5, 44, 2, 0, 'gdjsyjs', '2021-09-14 14:35:42.000000', 'gdjsyjs', '2021-09-14 14:35:42.000000');
INSERT INTO `b_demand` VALUES (1080, 86, 86, 15, 14, 2, 0, 'aqgzc', '2021-09-14 14:35:57.000000', 'aqgzc', '2021-09-14 14:35:57.000000');
INSERT INTO `b_demand` VALUES (1081, 87, 87, 15, 14, 2, 0, 'aqgzc', '2021-09-14 14:36:12.000000', 'aqgzc', '2021-09-14 14:36:12.000000');
INSERT INTO `b_demand` VALUES (1082, 88, 88, 15, 14, 2, 0, 'aqgzc', '2021-09-14 14:36:17.000000', 'aqgzc', '2021-09-14 14:36:17.000000');
INSERT INTO `b_demand` VALUES (1083, 74, 74, 1, 12, 2, 0, 'fzghc', '2021-09-14 14:36:20.000000', 'fzghc', '2021-09-14 14:36:20.000000');
INSERT INTO `b_demand` VALUES (1084, 89, 89, 15, 14, 2, 0, 'aqgzc', '2021-09-14 14:36:28.000000', 'aqgzc', '2021-09-14 14:36:28.000000');
INSERT INTO `b_demand` VALUES (1085, 101, 101, 2, 36, 2, 0, 'sljxb', '2021-09-14 14:37:09.000000', 'sljxb', '2021-09-14 14:37:09.000000');
INSERT INTO `b_demand` VALUES (1086, 1, 1, 20, 1, 2, 0, 'lb', '2021-09-14 14:36:29.000000', 'lb', '2021-09-14 14:36:29.000000');
INSERT INTO `b_demand` VALUES (1087, 84, 84, 1, 12, 2, 0, 'fzghc', '2021-09-14 14:36:55.000000', 'fzghc', '2021-09-14 14:36:55.000000');
INSERT INTO `b_demand` VALUES (1088, 2, 2, 5, 1, 2, 0, 'lb', '2021-09-14 14:36:40.000000', 'lb', '2021-09-14 14:36:40.000000');
INSERT INTO `b_demand` VALUES (1089, 92, 92, 6, 14, 2, 0, 'aqgzc', '2021-09-14 14:37:03.000000', 'aqgzc', '2021-09-14 14:37:03.000000');
INSERT INTO `b_demand` VALUES (1090, 3, 3, 5, 1, 2, 0, 'lb', '2021-09-14 14:36:50.000000', 'lb', '2021-09-14 14:36:50.000000');
INSERT INTO `b_demand` VALUES (1091, 86, 86, 8, 12, 2, 0, 'fzghc', '2021-09-14 14:37:14.000000', 'fzghc', '2021-09-14 14:37:14.000000');
INSERT INTO `b_demand` VALUES (1092, 87, 87, 8, 12, 2, 0, 'fzghc', '2021-09-14 14:37:28.000000', 'fzghc', '2021-09-14 14:37:28.000000');
INSERT INTO `b_demand` VALUES (1093, 94, 94, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:37:33.000000', 'aqgzc', '2021-09-14 14:37:33.000000');
INSERT INTO `b_demand` VALUES (1094, 20, 20, 2, 1, 2, 0, 'lb', '2021-09-14 14:37:17.000000', 'lb', '2021-09-14 14:37:17.000000');
INSERT INTO `b_demand` VALUES (1096, 23, 23, 50, 1, 2, 0, 'lb', '2021-09-14 14:37:49.000000', 'lb', '2021-09-14 14:37:49.000000');
INSERT INTO `b_demand` VALUES (1097, 108, 108, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:38:23.000000', 'aqgzc', '2021-09-14 14:39:01.000000');
INSERT INTO `b_demand` VALUES (1098, 94, 94, 5, 12, 2, 0, 'fzghc', '2021-09-14 14:38:38.000000', 'fzghc', '2021-09-14 14:38:38.000000');
INSERT INTO `b_demand` VALUES (1099, 32, 32, 100, 1, 2, 0, 'lb', '2021-09-14 14:38:23.000000', 'lb', '2021-09-14 14:38:23.000000');
INSERT INTO `b_demand` VALUES (1100, 39, 39, 10, 1, 2, 0, 'lb', '2021-09-14 14:38:56.000000', 'lb', '2021-09-14 14:38:56.000000');
INSERT INTO `b_demand` VALUES (1101, 48, 48, 20, 1, 2, 0, 'lb', '2021-09-14 14:39:20.000000', 'lb', '2021-09-14 14:39:20.000000');
INSERT INTO `b_demand` VALUES (1102, 49, 49, 20, 1, 2, 0, 'lb', '2021-09-14 14:39:30.000000', 'lb', '2021-09-14 14:39:30.000000');
INSERT INTO `b_demand` VALUES (1103, 101, 101, 3, 12, 2, 0, 'fzghc', '2021-09-14 14:39:56.000000', 'fzghc', '2021-09-14 14:39:56.000000');
INSERT INTO `b_demand` VALUES (1104, 52, 52, 5, 1, 2, 0, 'lb', '2021-09-14 14:39:48.000000', 'lb', '2021-09-14 14:39:48.000000');
INSERT INTO `b_demand` VALUES (1105, 104, 104, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:40:47.000000', 'aqgzc', '2021-09-14 14:40:47.000000');
INSERT INTO `b_demand` VALUES (1106, 115, 115, 10, 14, 2, 0, 'aqgzc', '2021-09-14 14:42:15.000000', 'aqgzc', '2021-09-14 14:42:15.000000');
INSERT INTO `b_demand` VALUES (1107, 116, 116, 10, 14, 2, 0, 'aqgzc', '2021-09-14 14:42:24.000000', 'aqgzc', '2021-09-14 14:42:24.000000');
INSERT INTO `b_demand` VALUES (1108, 115, 115, 70, 12, 2, 0, 'fzghc', '2021-09-14 14:43:04.000000', 'fzghc', '2021-09-14 14:43:04.000000');
INSERT INTO `b_demand` VALUES (1109, 116, 116, 70, 12, 2, 0, 'fzghc', '2021-09-14 14:44:06.000000', 'fzghc', '2021-09-14 14:44:06.000000');
INSERT INTO `b_demand` VALUES (1110, 69, 69, 4, 14, 2, 0, 'aqgzc', '2021-09-14 14:44:53.000000', 'aqgzc', '2021-09-14 15:20:28.000000');
INSERT INTO `b_demand` VALUES (1111, 87, 87, 10, 36, 2, 0, 'sljxb', '2021-09-14 14:45:32.000000', 'sljxb', '2021-09-14 14:45:32.000000');
INSERT INTO `b_demand` VALUES (1112, 56, 56, 2, 1, 2, 0, 'lb', '2021-09-14 14:44:50.000000', 'lb', '2021-09-14 14:44:50.000000');
INSERT INTO `b_demand` VALUES (1113, 57, 57, 2, 1, 2, 0, 'lb', '2021-09-14 14:44:58.000000', 'lb', '2021-09-14 14:44:58.000000');
INSERT INTO `b_demand` VALUES (1114, 58, 58, 2, 1, 2, 0, 'lb', '2021-09-14 14:45:06.000000', 'lb', '2021-09-14 14:45:06.000000');
INSERT INTO `b_demand` VALUES (1115, 59, 59, 2, 1, 2, 0, 'lb', '2021-09-14 14:45:13.000000', 'lb', '2021-09-14 14:45:13.000000');
INSERT INTO `b_demand` VALUES (1116, 92, 92, 5, 36, 2, 0, 'sljxb', '2021-09-14 14:46:22.000000', 'sljxb', '2021-09-14 14:46:22.000000');
INSERT INTO `b_demand` VALUES (1117, 67, 67, 10, 1, 2, 0, 'lb', '2021-09-14 14:46:03.000000', 'lb', '2021-09-14 14:46:03.000000');
INSERT INTO `b_demand` VALUES (1118, 68, 68, 5, 1, 2, 0, 'lb', '2021-09-14 14:46:16.000000', 'lb', '2021-09-14 14:46:16.000000');
INSERT INTO `b_demand` VALUES (1119, 69, 69, 10, 1, 2, 0, 'lb', '2021-09-14 14:46:27.000000', 'lb', '2021-09-14 14:46:27.000000');
INSERT INTO `b_demand` VALUES (1120, 70, 70, 5, 1, 2, 0, 'lb', '2021-09-14 14:46:37.000000', 'lb', '2021-09-14 14:46:37.000000');
INSERT INTO `b_demand` VALUES (1121, 73, 73, 2, 1, 2, 0, 'lb', '2021-09-14 14:46:51.000000', 'lb', '2021-09-14 14:46:51.000000');
INSERT INTO `b_demand` VALUES (1122, 74, 74, 2, 1, 2, 0, 'lb', '2021-09-14 14:46:58.000000', 'lb', '2021-09-14 14:46:58.000000');
INSERT INTO `b_demand` VALUES (1123, 46, 46, 10, 36, 2, 0, 'sljxb', '2021-09-14 14:48:18.000000', 'sljxb', '2021-09-14 14:48:18.000000');
INSERT INTO `b_demand` VALUES (1124, 124, 124, 5, 1, 2, 0, 'lb', '2021-09-14 14:47:24.000000', 'lb', '2021-09-14 14:47:24.000000');
INSERT INTO `b_demand` VALUES (1125, 125, 125, 5, 1, 2, 0, 'lb', '2021-09-14 14:47:30.000000', 'lb', '2021-09-14 14:47:30.000000');
INSERT INTO `b_demand` VALUES (1127, 48, 48, 10, 36, 2, 0, 'sljxb', '2021-09-14 14:48:40.000000', 'sljxb', '2021-09-14 14:48:40.000000');
INSERT INTO `b_demand` VALUES (1128, 114, 114, 1, 8, 2, 0, 'cwc', '2021-09-14 14:48:32.000000', 'cwc', '2021-09-14 14:48:32.000000');
INSERT INTO `b_demand` VALUES (1129, 85, 85, 30, 1, 2, 0, 'lb', '2021-09-14 14:48:17.000000', 'lb', '2021-09-14 14:48:17.000000');
INSERT INTO `b_demand` VALUES (1130, 88, 88, 10, 1, 2, 0, 'lb', '2021-09-14 14:48:34.000000', 'lb', '2021-09-14 14:48:34.000000');
INSERT INTO `b_demand` VALUES (1131, 89, 89, 10, 1, 2, 0, 'lb', '2021-09-14 14:48:42.000000', 'lb', '2021-09-14 14:48:42.000000');
INSERT INTO `b_demand` VALUES (1132, 91, 91, 2, 1, 2, 0, 'lb', '2021-09-14 14:48:57.000000', 'lb', '2021-09-14 14:48:57.000000');
INSERT INTO `b_demand` VALUES (1133, 93, 93, 10, 1, 2, 0, 'lb', '2021-09-14 14:49:08.000000', 'lb', '2021-09-14 14:49:08.000000');
INSERT INTO `b_demand` VALUES (1134, 127, 127, 10, 1, 2, 0, 'lb', '2021-09-14 14:49:23.000000', 'lb', '2021-09-14 14:49:23.000000');
INSERT INTO `b_demand` VALUES (1135, 98, 98, 1, 1, 2, 0, 'lb', '2021-09-14 14:49:51.000000', 'lb', '2021-09-14 14:49:51.000000');
INSERT INTO `b_demand` VALUES (1136, 112, 112, 2, 1, 2, 0, 'lb', '2021-09-14 14:50:06.000000', 'lb', '2021-09-14 14:51:10.000000');
INSERT INTO `b_demand` VALUES (1137, 115, 115, 100, 1, 2, 0, 'lb', '2021-09-14 14:51:43.000000', 'lb', '2021-09-14 14:51:43.000000');
INSERT INTO `b_demand` VALUES (1138, 64, 64, 2, 14, 2, 0, 'aqgzc', '2021-09-14 14:52:11.000000', 'aqgzc', '2021-09-14 15:08:57.000000');
INSERT INTO `b_demand` VALUES (1139, 109, 109, 2, 1, 2, 0, 'lb', '2021-09-14 14:51:58.000000', 'lb', '2021-09-14 14:51:58.000000');
INSERT INTO `b_demand` VALUES (1140, 116, 116, 30, 1, 2, 0, 'lb', '2021-09-14 14:52:16.000000', 'lb', '2021-09-14 14:52:16.000000');
INSERT INTO `b_demand` VALUES (1141, 118, 118, 1, 1, 2, 0, 'lb', '2021-09-14 14:52:34.000000', 'lb', '2021-09-14 14:52:34.000000');
INSERT INTO `b_demand` VALUES (1142, 17, 17, 5, 1, 2, 0, 'lb', '2021-09-14 14:53:12.000000', 'lb', '2021-09-14 14:53:12.000000');
INSERT INTO `b_demand` VALUES (1143, 1, 1, 2, 21, 2, 0, 'bwg', '2021-09-14 14:58:48.000000', 'bwg', '2021-09-14 14:58:48.000000');
INSERT INTO `b_demand` VALUES (1144, 5, 5, 1, 21, 2, 0, 'bwg', '2021-09-14 14:58:56.000000', 'bwg', '2021-09-14 14:58:56.000000');
INSERT INTO `b_demand` VALUES (1145, 14, 14, 1, 21, 2, 0, 'bwg', '2021-09-14 14:59:20.000000', 'bwg', '2021-09-14 14:59:20.000000');
INSERT INTO `b_demand` VALUES (1146, 19, 19, 2, 21, 2, 0, 'bwg', '2021-09-14 15:00:00.000000', 'bwg', '2021-09-14 15:00:00.000000');
INSERT INTO `b_demand` VALUES (1147, 27, 27, 10, 21, 2, 0, 'bwg', '2021-09-14 15:01:18.000000', 'bwg', '2021-09-14 15:01:18.000000');
INSERT INTO `b_demand` VALUES (1148, 28, 28, 1, 21, 2, 0, 'bwg', '2021-09-14 15:01:35.000000', 'bwg', '2021-09-14 15:01:35.000000');
INSERT INTO `b_demand` VALUES (1149, 29, 29, 1, 21, 2, 0, 'bwg', '2021-09-14 15:01:41.000000', 'bwg', '2021-09-14 15:01:41.000000');
INSERT INTO `b_demand` VALUES (1150, 30, 30, 2, 21, 2, 0, 'bwg', '2021-09-14 15:01:49.000000', 'bwg', '2021-09-14 15:01:49.000000');
INSERT INTO `b_demand` VALUES (1151, 41, 41, 1, 21, 2, 0, 'bwg', '2021-09-14 15:02:07.000000', 'bwg', '2021-09-14 15:02:07.000000');
INSERT INTO `b_demand` VALUES (1152, 48, 48, 1, 21, 2, 0, 'bwg', '2021-09-14 15:02:38.000000', 'bwg', '2021-09-14 15:02:38.000000');
INSERT INTO `b_demand` VALUES (1153, 63, 63, 6, 21, 2, 0, 'bwg', '2021-09-14 15:03:04.000000', 'bwg', '2021-09-14 15:03:04.000000');
INSERT INTO `b_demand` VALUES (1154, 66, 66, 2, 21, 2, 0, 'bwg', '2021-09-14 15:03:13.000000', 'bwg', '2021-09-14 15:03:13.000000');
INSERT INTO `b_demand` VALUES (1155, 67, 67, 2, 21, 2, 0, 'bwg', '2021-09-14 15:03:32.000000', 'bwg', '2021-09-14 15:03:32.000000');
INSERT INTO `b_demand` VALUES (1156, 69, 69, 4, 21, 2, 0, 'bwg', '2021-09-14 15:03:47.000000', 'bwg', '2021-09-14 15:03:47.000000');
INSERT INTO `b_demand` VALUES (1157, 78, 78, 10, 21, 2, 0, 'bwg', '2021-09-14 15:04:51.000000', 'bwg', '2021-09-14 15:04:51.000000');
INSERT INTO `b_demand` VALUES (1158, 128, 128, 4, 21, 2, 0, 'bwg', '2021-09-14 15:05:13.000000', 'bwg', '2021-09-14 15:05:13.000000');
INSERT INTO `b_demand` VALUES (1159, 129, 129, 1, 21, 2, 0, 'bwg', '2021-09-14 15:05:21.000000', 'bwg', '2021-09-14 15:05:21.000000');
INSERT INTO `b_demand` VALUES (1160, 87, 87, 6, 21, 2, 0, 'bwg', '2021-09-14 15:06:20.000000', 'bwg', '2021-09-14 15:06:20.000000');
INSERT INTO `b_demand` VALUES (1161, 88, 88, 6, 21, 2, 0, 'bwg', '2021-09-14 15:06:27.000000', 'bwg', '2021-09-14 15:06:27.000000');
INSERT INTO `b_demand` VALUES (1162, 89, 89, 6, 21, 2, 0, 'bwg', '2021-09-14 15:06:35.000000', 'bwg', '2021-09-14 15:06:35.000000');
INSERT INTO `b_demand` VALUES (1163, 93, 93, 1, 21, 2, 0, 'bwg', '2021-09-14 15:06:55.000000', 'bwg', '2021-09-14 15:06:55.000000');
INSERT INTO `b_demand` VALUES (1164, 95, 95, 5, 21, 2, 0, 'bwg', '2021-09-14 15:07:48.000000', 'bwg', '2021-09-14 15:07:48.000000');
INSERT INTO `b_demand` VALUES (1165, 127, 127, 2, 21, 2, 0, 'bwg', '2021-09-14 15:07:58.000000', 'bwg', '2021-09-14 15:07:58.000000');
INSERT INTO `b_demand` VALUES (1166, 98, 98, 2, 21, 2, 0, 'bwg', '2021-09-14 15:08:56.000000', 'bwg', '2021-09-14 15:08:56.000000');
INSERT INTO `b_demand` VALUES (1167, 103, 103, 4, 21, 2, 0, 'bwg', '2021-09-14 15:09:12.000000', 'bwg', '2021-09-14 15:09:12.000000');
INSERT INTO `b_demand` VALUES (1168, 104, 104, 1, 21, 2, 0, 'bwg', '2021-09-14 15:09:22.000000', 'bwg', '2021-09-14 15:09:22.000000');
INSERT INTO `b_demand` VALUES (1169, 105, 105, 2, 21, 2, 0, 'bwg', '2021-09-14 15:09:30.000000', 'bwg', '2021-09-14 15:09:30.000000');
INSERT INTO `b_demand` VALUES (1170, 106, 106, 2, 21, 2, 0, 'bwg', '2021-09-14 15:09:35.000000', 'bwg', '2021-09-14 15:09:35.000000');
INSERT INTO `b_demand` VALUES (1171, 112, 112, 6, 21, 2, 0, 'bwg', '2021-09-14 15:09:48.000000', 'bwg', '2021-09-14 15:09:48.000000');
INSERT INTO `b_demand` VALUES (1172, 113, 113, 1, 21, 2, 0, 'bwg', '2021-09-14 15:10:03.000000', 'bwg', '2021-09-14 15:10:03.000000');
INSERT INTO `b_demand` VALUES (1173, 115, 115, 40, 21, 2, 0, 'bwg', '2021-09-14 15:10:18.000000', 'bwg', '2021-09-14 15:10:18.000000');
INSERT INTO `b_demand` VALUES (1174, 116, 116, 40, 21, 2, 0, 'bwg', '2021-09-14 15:10:24.000000', 'bwg', '2021-09-14 15:10:24.000000');
INSERT INTO `b_demand` VALUES (1175, 118, 118, 2, 21, 2, 0, 'bwg', '2021-09-14 15:10:41.000000', 'bwg', '2021-09-14 15:10:41.000000');
INSERT INTO `b_demand` VALUES (1176, 92, 92, 4, 21, 2, 0, 'bwg', '2021-09-14 15:11:13.000000', 'bwg', '2021-09-14 15:11:13.000000');
INSERT INTO `b_demand` VALUES (1177, 64, 64, 1, 21, 2, 0, 'bwg', '2021-09-14 15:18:46.000000', 'bwg', '2021-09-14 15:18:46.000000');
INSERT INTO `b_demand` VALUES (1178, 54, 54, 1, 21, 2, 0, 'bwg', '2021-09-14 15:19:11.000000', 'bwg', '2021-09-14 15:19:11.000000');
INSERT INTO `b_demand` VALUES (1179, 18, 18, 6, 21, 2, 0, 'bwg', '2021-09-14 15:20:06.000000', 'bwg', '2021-09-14 15:20:06.000000');
INSERT INTO `b_demand` VALUES (1180, 84, 84, 1, 21, 2, 0, 'bwg', '2021-09-14 15:20:27.000000', 'bwg', '2021-09-14 15:20:27.000000');
INSERT INTO `b_demand` VALUES (1181, 85, 85, 15, 21, 2, 0, 'bwg', '2021-09-14 15:20:48.000000', 'bwg', '2021-09-14 15:20:48.000000');
INSERT INTO `b_demand` VALUES (1182, 86, 86, 3, 21, 2, 0, 'bwg', '2021-09-14 15:21:07.000000', 'bwg', '2021-09-14 15:21:07.000000');
INSERT INTO `b_demand` VALUES (1183, 1, 1, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:35:12.000000', 'gdzyjsjxb', '2021-09-14 15:35:12.000000');
INSERT INTO `b_demand` VALUES (1184, 24, 24, 50, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:37:19.000000', 'gdzyjsjxb', '2021-09-14 15:37:19.000000');
INSERT INTO `b_demand` VALUES (1185, 23, 23, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:37:34.000000', 'gdzyjsjxb', '2021-09-14 15:37:34.000000');
INSERT INTO `b_demand` VALUES (1186, 34, 34, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:37:57.000000', 'gdzyjsjxb', '2021-09-14 15:37:57.000000');
INSERT INTO `b_demand` VALUES (1187, 67, 67, 30, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:38:26.000000', 'gdzyjsjxb', '2021-09-14 15:38:26.000000');
INSERT INTO `b_demand` VALUES (1188, 74, 74, 10, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:38:50.000000', 'gdzyjsjxb', '2021-09-14 15:38:50.000000');
INSERT INTO `b_demand` VALUES (1189, 25, 25, 5, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:39:38.000000', 'gdzyjsjxb', '2021-09-14 15:39:38.000000');
INSERT INTO `b_demand` VALUES (1190, 5, 5, 5, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:39:47.000000', 'gdzyjsjxb', '2021-09-14 15:39:47.000000');
INSERT INTO `b_demand` VALUES (1191, 69, 69, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:40:17.000000', 'gdzyjsjxb', '2021-09-14 15:40:17.000000');
INSERT INTO `b_demand` VALUES (1192, 84, 84, 10, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:40:40.000000', 'gdzyjsjxb', '2021-09-14 15:40:40.000000');
INSERT INTO `b_demand` VALUES (1193, 86, 86, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:41:03.000000', 'gdzyjsjxb', '2021-09-14 15:41:03.000000');
INSERT INTO `b_demand` VALUES (1194, 87, 87, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:41:14.000000', 'gdzyjsjxb', '2021-09-14 15:41:14.000000');
INSERT INTO `b_demand` VALUES (1195, 88, 88, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:41:26.000000', 'gdzyjsjxb', '2021-09-14 15:41:26.000000');
INSERT INTO `b_demand` VALUES (1196, 89, 89, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:41:34.000000', 'gdzyjsjxb', '2021-09-14 15:41:34.000000');
INSERT INTO `b_demand` VALUES (1197, 127, 127, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:41:53.000000', 'gdzyjsjxb', '2021-09-14 15:41:53.000000');
INSERT INTO `b_demand` VALUES (1198, 115, 115, 50, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:42:19.000000', 'gdzyjsjxb', '2021-09-14 15:42:19.000000');
INSERT INTO `b_demand` VALUES (1199, 116, 116, 20, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:42:28.000000', 'gdzyjsjxb', '2021-09-14 15:42:28.000000');
INSERT INTO `b_demand` VALUES (1200, 119, 119, 5, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:42:37.000000', 'gdzyjsjxb', '2021-09-14 15:42:37.000000');
INSERT INTO `b_demand` VALUES (1201, 114, 114, 2, 49, 2, 0, 'gdzyjsjxb', '2021-09-14 15:43:11.000000', 'gdzyjsjxb', '2021-09-14 15:43:11.000000');
INSERT INTO `b_demand` VALUES (1202, 1, 1, 10, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:16:57.000000', 'dxsjyzdyfwzx', '2021-09-14 17:16:57.000000');
INSERT INTO `b_demand` VALUES (1203, 100, 100, 2, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:17:26.000000', 'dxsjyzdyfwzx', '2021-09-14 17:17:26.000000');
INSERT INTO `b_demand` VALUES (1204, 103, 103, 2, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:17:47.000000', 'dxsjyzdyfwzx', '2021-09-14 17:17:47.000000');
INSERT INTO `b_demand` VALUES (1205, 104, 104, 2, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:17:57.000000', 'dxsjyzdyfwzx', '2021-09-14 17:17:57.000000');
INSERT INTO `b_demand` VALUES (1206, 97, 97, 1, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:18:17.000000', 'dxsjyzdyfwzx', '2021-09-14 17:18:17.000000');
INSERT INTO `b_demand` VALUES (1207, 118, 118, 7, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:18:33.000000', 'dxsjyzdyfwzx', '2021-09-14 17:18:33.000000');
INSERT INTO `b_demand` VALUES (1208, 115, 115, 30, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:18:42.000000', 'dxsjyzdyfwzx', '2021-09-14 17:18:42.000000');
INSERT INTO `b_demand` VALUES (1209, 116, 116, 10, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:18:50.000000', 'dxsjyzdyfwzx', '2021-09-14 17:18:50.000000');
INSERT INTO `b_demand` VALUES (1210, 119, 119, 3, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:19:04.000000', 'dxsjyzdyfwzx', '2021-09-14 17:19:04.000000');
INSERT INTO `b_demand` VALUES (1211, 107, 107, 2, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:19:16.000000', 'dxsjyzdyfwzx', '2021-09-14 17:19:16.000000');
INSERT INTO `b_demand` VALUES (1212, 3, 3, 1, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:19:43.000000', 'dxsjyzdyfwzx', '2021-09-14 17:19:43.000000');
INSERT INTO `b_demand` VALUES (1213, 66, 66, 4, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:20:35.000000', 'dxsjyzdyfwzx', '2021-09-14 17:20:35.000000');
INSERT INTO `b_demand` VALUES (1214, 53, 53, 2, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:20:55.000000', 'dxsjyzdyfwzx', '2021-09-14 17:20:55.000000');
INSERT INTO `b_demand` VALUES (1215, 27, 27, 2, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:21:17.000000', 'dxsjyzdyfwzx', '2021-09-14 17:21:17.000000');
INSERT INTO `b_demand` VALUES (1216, 85, 85, 10, 28, 2, 0, 'dxsjyzdyfwzx', '2021-09-14 17:21:35.000000', 'dxsjyzdyfwzx', '2021-09-14 17:21:35.000000');

-- ----------------------------
-- Table structure for b_item
-- ----------------------------
DROP TABLE IF EXISTS `b_item`;
CREATE TABLE `b_item`  (
  `item_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '物品id',
  `item_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物品名称',
  `cate_id` int(11) NOT NULL COMMENT '分类id',
  `item_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物品描述',
  `seq` int(255) NULL DEFAULT NULL COMMENT '排序序号',
  `delete_tag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记  0：未删除  1：已删除',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者  登录名',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者  登录名',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间',
  PRIMARY KEY (`item_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 130 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物品表，记录可以采购的物品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_item
-- ----------------------------
INSERT INTO `b_item` VALUES (1, ' 中性笔', 1, '0.5mm 黑色', NULL, 0, 'admin', '2021-06-18 11:35:03.379389', NULL, '2021-06-18 11:35:03.379389');
INSERT INTO `b_item` VALUES (2, ' 中性笔', 1, '0.7mm 黑色', NULL, 0, 'admin', '2021-06-18 11:35:03.423081', NULL, '2021-06-18 11:35:03.423081');
INSERT INTO `b_item` VALUES (3, ' 中性笔', 1, '1mm 黑色', NULL, 0, 'admin', '2021-06-18 11:35:03.470080', NULL, '2021-06-18 11:35:03.470080');
INSERT INTO `b_item` VALUES (4, '中性笔芯', 1, '0.5mm 红色', NULL, 0, 'admin', '2021-06-18 11:35:03.513361', NULL, '2021-06-18 11:35:03.513361');
INSERT INTO `b_item` VALUES (5, '中性笔芯', 1, '0.5mm 黑色', NULL, 0, 'admin', '2021-06-18 11:35:03.556132', NULL, '2021-06-18 11:35:03.556132');
INSERT INTO `b_item` VALUES (6, '中性笔芯', 1, '0.7mm 红色', NULL, 0, 'admin', '2021-06-18 11:35:03.601700', NULL, '2021-06-18 11:35:03.601700');
INSERT INTO `b_item` VALUES (7, '中性笔芯', 1, '0.7mm 黑色', NULL, 0, 'admin', '2021-06-18 11:35:03.644753', NULL, '2021-06-18 11:35:03.644753');
INSERT INTO `b_item` VALUES (8, '中性笔芯', 1, '1mm 红色', NULL, 0, 'admin', '2021-06-18 11:35:03.688715', NULL, '2021-06-18 11:35:03.688715');
INSERT INTO `b_item` VALUES (9, '中性笔芯', 1, '1mm 黑色', NULL, 0, 'admin', '2021-06-18 11:35:03.732789', NULL, '2021-06-18 11:35:03.732789');
INSERT INTO `b_item` VALUES (10, '圆珠笔', 1, '蓝色', NULL, 0, 'admin', '2021-06-18 11:35:03.777559', NULL, '2021-06-18 11:35:03.777559');
INSERT INTO `b_item` VALUES (11, '圆珠笔', 1, '红色', NULL, 0, 'admin', '2021-06-18 11:35:03.824833', NULL, '2021-06-18 11:35:03.824833');
INSERT INTO `b_item` VALUES (12, '铅笔', 1, 'HB', NULL, 0, 'admin', '2021-06-18 11:35:03.870272', NULL, '2021-06-18 11:35:03.870272');
INSERT INTO `b_item` VALUES (13, '铅笔', 1, '2B', NULL, 0, 'admin', '2021-06-18 11:35:03.913000', NULL, '2021-06-18 11:35:03.913000');
INSERT INTO `b_item` VALUES (14, '自动铅笔', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:03.956273', NULL, '2021-06-18 11:35:03.956273');
INSERT INTO `b_item` VALUES (15, '铅笔笔芯', 1, '0.5mm', NULL, 0, 'admin', '2021-06-18 11:35:04.002366', NULL, '2021-06-18 11:35:04.002366');
INSERT INTO `b_item` VALUES (16, '铅笔笔芯', 1, '0.7mm', NULL, 0, 'admin', '2021-06-18 11:35:04.046154', NULL, '2021-06-18 11:35:04.046154');
INSERT INTO `b_item` VALUES (17, '橡皮', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:04.090662', NULL, '2021-06-18 11:35:04.090662');
INSERT INTO `b_item` VALUES (18, '记号笔', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:04.135207', NULL, '2021-06-18 11:35:04.135207');
INSERT INTO `b_item` VALUES (19, '白板笔', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:04.178796', NULL, '2021-06-18 11:35:04.178796');
INSERT INTO `b_item` VALUES (20, '荧光笔', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:04.221958', NULL, '2021-06-18 11:35:04.221958');
INSERT INTO `b_item` VALUES (21, '皮面本（软皮）', 1, 'A4', NULL, 0, 'admin', '2021-06-18 11:35:04.265330', NULL, '2021-06-21 16:13:35.193797');
INSERT INTO `b_item` VALUES (22, '皮面本（硬皮）', 1, 'A4', NULL, 0, 'admin', '2021-06-18 11:35:04.310568', NULL, '2021-06-21 16:13:45.021460');
INSERT INTO `b_item` VALUES (23, '纸面笔记本', 1, '纸面', NULL, 0, 'admin', '2021-06-18 11:35:04.353420', NULL, '2021-06-18 11:35:04.353420');
INSERT INTO `b_item` VALUES (24, '线圈本', 1, '线圈', NULL, 0, 'admin', '2021-06-18 11:35:04.397855', NULL, '2021-06-18 11:35:04.397855');
INSERT INTO `b_item` VALUES (25, '便利贴', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:04.442499', NULL, '2021-06-18 11:35:04.442499');
INSERT INTO `b_item` VALUES (26, '便签纸', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:04.490935', NULL, '2021-06-18 11:35:04.490935');
INSERT INTO `b_item` VALUES (27, '口取纸', 1, '28*20mm ', NULL, 0, 'admin', '2021-06-18 11:35:04.537263', NULL, '2021-06-18 11:35:04.537263');
INSERT INTO `b_item` VALUES (28, '信封', 1, '大号', NULL, 0, 'admin', '2021-06-18 11:35:04.580884', NULL, '2021-06-18 11:35:04.580884');
INSERT INTO `b_item` VALUES (29, '信封', 1, '中号', NULL, 0, 'admin', '2021-06-18 11:35:04.623920', NULL, '2021-06-18 11:35:04.623920');
INSERT INTO `b_item` VALUES (30, '信封', 1, '小号', NULL, 0, 'admin', '2021-06-18 11:35:04.668045', NULL, '2021-06-18 11:35:04.668045');
INSERT INTO `b_item` VALUES (31, '信纸', 1, ' 16K 70g 100页/本', NULL, 0, 'admin', '2021-06-18 11:35:04.710332', NULL, '2021-06-18 11:35:04.710332');
INSERT INTO `b_item` VALUES (32, '档案袋', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:04.753769', NULL, '2021-06-18 11:35:04.753769');
INSERT INTO `b_item` VALUES (33, '档案盒', 1, 'A4 牛皮纸 50mm', NULL, 0, 'admin', '2021-06-18 11:35:04.797505', NULL, '2021-06-18 11:35:04.797505');
INSERT INTO `b_item` VALUES (34, '档案盒', 1, '310*280*40mm  ', NULL, 0, 'admin', '2021-06-18 11:35:04.840717', NULL, '2021-06-18 11:35:04.840717');
INSERT INTO `b_item` VALUES (35, '档案盒', 1, '310*280*50mm  ', NULL, 0, 'admin', '2021-06-18 11:35:04.885204', NULL, '2021-06-18 11:35:04.885204');
INSERT INTO `b_item` VALUES (36, '档案盒', 1, '310*280*70mm  ', NULL, 0, 'admin', '2021-06-18 11:35:04.929122', NULL, '2021-06-18 11:35:04.929122');
INSERT INTO `b_item` VALUES (37, '档案盒', 1, '310*220*50mm  ', NULL, 0, 'admin', '2021-06-18 11:35:04.972707', NULL, '2021-06-18 11:35:04.972707');
INSERT INTO `b_item` VALUES (38, '档案盒', 1, '310*220*60mm  ', NULL, 0, 'admin', '2021-06-18 11:35:05.015545', NULL, '2021-06-18 11:35:05.015545');
INSERT INTO `b_item` VALUES (39, '文件夹', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:05.058980', NULL, '2021-06-18 11:35:05.058980');
INSERT INTO `b_item` VALUES (40, '文件袋', 1, ' 扣式', NULL, 0, 'admin', '2021-06-18 11:35:05.101501', NULL, '2021-06-18 11:35:05.101501');
INSERT INTO `b_item` VALUES (41, '拉边袋', 1, '拉链式', NULL, 0, 'admin', '2021-06-18 11:35:05.143815', NULL, '2021-06-18 11:35:05.143815');
INSERT INTO `b_item` VALUES (42, '公文袋', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:05.187849', NULL, '2021-06-18 11:35:05.187849');
INSERT INTO `b_item` VALUES (43, '资料册 ', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:05.232171', NULL, '2021-06-18 11:35:05.232171');
INSERT INTO `b_item` VALUES (44, '文件框', 1, '抽屉式', NULL, 0, 'admin', '2021-06-18 11:35:05.276884', NULL, '2021-06-18 11:35:05.276884');
INSERT INTO `b_item` VALUES (45, '文件框', 1, '四联  竖式', NULL, 0, 'admin', '2021-06-18 11:35:05.319740', NULL, '2021-06-18 11:35:05.319740');
INSERT INTO `b_item` VALUES (46, '书立', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:05.363718', NULL, '2021-06-18 11:35:05.363718');
INSERT INTO `b_item` VALUES (47, '台帐夹', 1, '32K', NULL, 0, 'admin', '2021-06-18 11:35:05.406940', NULL, '2021-06-18 11:35:05.406940');
INSERT INTO `b_item` VALUES (48, '曲别针', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:05.450282', NULL, '2021-06-18 11:35:05.450282');
INSERT INTO `b_item` VALUES (49, '订书钉', 1, '10# ', NULL, 0, 'admin', '2021-06-18 11:35:05.493362', NULL, '2021-06-18 11:35:05.493362');
INSERT INTO `b_item` VALUES (50, '订书钉', 1, '12# ；(24/6)宽12MM', NULL, 0, 'admin', '2021-06-18 11:35:05.535880', NULL, '2021-06-18 11:35:05.535880');
INSERT INTO `b_item` VALUES (51, '重型订书器', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:05.579710', NULL, '2021-06-18 11:35:05.579710');
INSERT INTO `b_item` VALUES (52, '起钉器', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:05.622491', NULL, '2021-06-18 11:35:05.622491');
INSERT INTO `b_item` VALUES (53, '计算器', 1, '中号', NULL, 0, 'admin', '2021-06-18 11:35:05.666905', NULL, '2021-06-18 11:35:05.666905');
INSERT INTO `b_item` VALUES (54, '计算器', 1, '大号', NULL, 0, 'admin', '2021-06-18 11:35:05.709659', NULL, '2021-06-18 11:35:05.709659');
INSERT INTO `b_item` VALUES (55, '计算器', 1, '多功能  函数型 ', NULL, 0, 'admin', '2021-06-18 11:35:05.752560', NULL, '2021-06-18 11:35:05.752560');
INSERT INTO `b_item` VALUES (56, '长尾夹', 1, '2#41mm ', NULL, 0, 'admin', '2021-06-18 11:35:05.795911', NULL, '2021-06-18 11:35:05.795911');
INSERT INTO `b_item` VALUES (57, '长尾夹', 1, '3#32mm', NULL, 0, 'admin', '2021-06-18 11:35:05.838294', NULL, '2021-06-18 11:35:05.838294');
INSERT INTO `b_item` VALUES (58, '长尾夹', 1, '4#25mm', NULL, 0, 'admin', '2021-06-18 11:35:05.881114', NULL, '2021-06-18 11:35:05.881114');
INSERT INTO `b_item` VALUES (59, '长尾夹', 1, '5#19mm', NULL, 0, 'admin', '2021-06-18 11:35:05.926678', NULL, '2021-06-18 11:35:05.926678');
INSERT INTO `b_item` VALUES (60, '笔筒', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:05.970242', NULL, '2021-06-18 11:35:05.970242');
INSERT INTO `b_item` VALUES (61, '塑料直尺', 1, '400mm', NULL, 0, 'admin', '2021-06-18 11:35:06.013430', NULL, '2021-06-18 11:35:06.013430');
INSERT INTO `b_item` VALUES (62, '塑料直尺', 1, ' 500mm', NULL, 0, 'admin', '2021-06-18 11:35:06.057087', NULL, '2021-06-18 11:35:06.057087');
INSERT INTO `b_item` VALUES (63, '剪刀', 1, '205mm ', NULL, 0, 'admin', '2021-06-18 11:35:06.100844', NULL, '2021-06-18 11:35:06.100844');
INSERT INTO `b_item` VALUES (64, '刀片式裁纸刀', 1, '145*18.3*12.7mm   ', NULL, 0, 'admin', '2021-06-18 11:35:06.148907', NULL, '2021-06-18 11:35:06.148907');
INSERT INTO `b_item` VALUES (65, ' 铡刀式裁纸刀', 1, '12英寸  ', NULL, 0, 'admin', '2021-06-18 11:35:06.193293', NULL, '2021-06-18 11:35:06.193293');
INSERT INTO `b_item` VALUES (66, '转笔刀', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:06.237816', NULL, '2021-06-18 11:35:06.237816');
INSERT INTO `b_item` VALUES (67, '透明胶带', 1, '宽胶带', NULL, 0, 'admin', '2021-06-18 11:35:06.280373', NULL, '2021-06-18 11:35:06.280373');
INSERT INTO `b_item` VALUES (68, '透明胶带', 1, '窄胶带', NULL, 0, 'admin', '2021-06-18 11:35:06.326278', NULL, '2021-06-18 11:35:06.326278');
INSERT INTO `b_item` VALUES (69, '固体胶棒', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:06.369781', NULL, '2021-06-18 11:35:06.369781');
INSERT INTO `b_item` VALUES (70, '图钉', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:06.413194', NULL, '2021-06-18 11:35:06.413194');
INSERT INTO `b_item` VALUES (71, '大头针', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:06.456434', NULL, '2021-06-18 11:35:06.456434');
INSERT INTO `b_item` VALUES (72, '印泥', 1, ' 60m', NULL, 0, 'admin', '2021-06-18 11:35:06.498706', NULL, '2021-06-18 11:35:06.498706');
INSERT INTO `b_item` VALUES (73, '印台', 1, '蓝色 φ80mm', NULL, 0, 'admin', '2021-06-18 11:35:06.543129', NULL, '2021-06-18 11:35:06.543129');
INSERT INTO `b_item` VALUES (74, '印台', 1, '红色 φ80mm', NULL, 0, 'admin', '2021-06-18 11:35:06.587167', NULL, '2021-06-18 11:35:06.587167');
INSERT INTO `b_item` VALUES (75, '印油', 1, '蓝色10ml', NULL, 0, 'admin', '2021-06-18 11:35:06.631522', NULL, '2021-06-18 11:35:06.631522');
INSERT INTO `b_item` VALUES (76, '印油', 1, '红色10ml', NULL, 0, 'admin', '2021-06-18 11:35:06.676055', NULL, '2021-06-18 11:35:06.676055');
INSERT INTO `b_item` VALUES (77, '皮筋', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:06.719332', NULL, '2021-06-18 11:35:06.719332');
INSERT INTO `b_item` VALUES (78, '捆扎绳', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:06.764192', NULL, '2021-06-18 11:35:06.764192');
INSERT INTO `b_item` VALUES (79, '纸篓', 2, '塑料 φ265*280mm', NULL, 0, 'admin', '2021-06-18 11:35:06.808627', NULL, '2021-06-18 11:35:06.808627');
INSERT INTO `b_item` VALUES (80, '纸篓', 2, '钢丝φ265*280mm', NULL, 0, 'admin', '2021-06-18 11:35:06.852967', NULL, '2021-06-18 11:35:06.852967');
INSERT INTO `b_item` VALUES (81, '塑料脸盆', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:06.902372', NULL, '2021-06-18 11:35:06.902372');
INSERT INTO `b_item` VALUES (82, '扫帚', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:06.945815', NULL, '2021-06-18 11:35:06.945815');
INSERT INTO `b_item` VALUES (83, '簸箕', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:06.989194', NULL, '2021-06-18 11:35:06.989194');
INSERT INTO `b_item` VALUES (84, '垃圾桶', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:07.033953', NULL, '2021-06-18 11:35:07.033953');
INSERT INTO `b_item` VALUES (85, '垃圾袋', 2, '卷', NULL, 0, 'admin', '2021-06-18 11:35:07.077185', NULL, '2021-06-18 15:52:45.284980');
INSERT INTO `b_item` VALUES (86, '毛巾', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:07.120435', NULL, '2021-06-18 11:35:07.120435');
INSERT INTO `b_item` VALUES (87, '香皂', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:07.164317', NULL, '2021-06-18 11:35:07.164317');
INSERT INTO `b_item` VALUES (88, '肥皂', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:07.208851', NULL, '2021-06-18 11:35:07.208851');
INSERT INTO `b_item` VALUES (89, '洗衣粉', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:07.252190', NULL, '2021-06-18 11:35:07.252190');
INSERT INTO `b_item` VALUES (90, '皂粉', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:07.295433', NULL, '2021-06-18 11:35:07.295433');
INSERT INTO `b_item` VALUES (91, '拖把', 2, '杆128cm 胶棉头28cm', NULL, 0, 'admin', '2021-06-18 11:35:07.338832', NULL, '2021-06-18 11:35:07.338832');
INSERT INTO `b_item` VALUES (92, '电蚊香', 2, '液体', NULL, 0, 'admin', '2021-06-18 11:35:07.382063', NULL, '2021-06-18 11:35:07.382063');
INSERT INTO `b_item` VALUES (93, '蝇拍', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:07.426395', NULL, '2021-06-18 11:35:07.426395');
INSERT INTO `b_item` VALUES (94, '纸杯', 2, '普通/50支', NULL, 0, 'admin', '2021-06-18 11:35:07.473174', NULL, '2021-06-18 11:35:07.473174');
INSERT INTO `b_item` VALUES (95, '纸杯', 2, '加厚/50支', NULL, 0, 'admin', '2021-06-18 11:35:07.517893', NULL, '2021-06-18 11:35:07.517893');
INSERT INTO `b_item` VALUES (96, '纸杯杯托', 2, NULL, NULL, 0, 'admin', '2021-06-18 11:35:07.562217', NULL, '2021-06-18 11:35:07.562217');
INSERT INTO `b_item` VALUES (97, '暖壶', 3, NULL, NULL, 0, 'admin', '2021-06-18 11:35:07.606605', NULL, '2021-06-18 11:35:07.606605');
INSERT INTO `b_item` VALUES (98, '电烧水壶', 3, '2.0L', NULL, 0, 'admin', '2021-06-18 11:35:07.649460', NULL, '2021-06-18 11:35:07.649460');
INSERT INTO `b_item` VALUES (99, '电烧水壶', 3, '1.7L', NULL, 0, 'admin', '2021-06-18 11:35:07.693038', NULL, '2021-06-18 11:35:07.693038');
INSERT INTO `b_item` VALUES (100, '电烧水壶', 3, '全自动', NULL, 0, 'admin', '2021-06-18 11:35:07.739400', NULL, '2021-06-18 11:35:07.739400');
INSERT INTO `b_item` VALUES (101, '10A 2500W插线板1', 3, '4孔位分控 1.8米', NULL, 0, 'admin', '2021-06-18 11:35:07.784067', NULL, '2021-06-18 11:35:07.784067');
INSERT INTO `b_item` VALUES (102, '10A 2500W插线板2', 3, '4孔位分控 3米', NULL, 0, 'admin', '2021-06-18 11:35:07.827876', NULL, '2021-06-18 11:35:07.827876');
INSERT INTO `b_item` VALUES (103, '10A 2500W插线板3', 3, '独立分控6位2米', NULL, 0, 'admin', '2021-06-18 11:35:07.871194', NULL, '2021-06-18 11:35:07.871194');
INSERT INTO `b_item` VALUES (104, '10A 2500W插线板4', 3, '独立分控6位3米', NULL, 0, 'admin', '2021-06-18 11:35:07.920899', NULL, '2021-06-18 11:35:07.920899');
INSERT INTO `b_item` VALUES (105, '16A 4000W插线板5', 3, '3位总控1.8米', NULL, 0, 'admin', '2021-06-18 11:35:07.964757', NULL, '2021-06-18 11:35:07.964757');
INSERT INTO `b_item` VALUES (106, '16A 4000W插线板6', 3, '3位总控3米', NULL, 0, 'admin', '2021-06-18 11:35:08.008039', NULL, '2021-06-18 11:35:08.008039');
INSERT INTO `b_item` VALUES (107, '办公电话', 3, '处级', NULL, 0, 'admin', '2021-06-18 11:35:08.051786', NULL, '2021-06-18 11:35:08.051786');
INSERT INTO `b_item` VALUES (108, '办公电话', 3, '普通', NULL, 0, 'admin', '2021-06-18 11:35:08.094623', NULL, '2021-06-18 11:35:08.094623');
INSERT INTO `b_item` VALUES (109, 'U盘', 3, '8GB', NULL, 0, 'admin', '2021-06-18 11:35:08.139972', NULL, '2021-06-18 11:35:08.139972');
INSERT INTO `b_item` VALUES (110, 'U盘', 3, '16GB', NULL, 0, 'admin', '2021-06-18 11:35:08.182715', NULL, '2021-06-18 11:35:08.182715');
INSERT INTO `b_item` VALUES (111, 'U盘', 3, '32GB', NULL, 0, 'admin', '2021-06-18 11:35:08.226490', NULL, '2021-06-18 11:35:08.226490');
INSERT INTO `b_item` VALUES (112, 'U盘', 3, '64GB', NULL, 0, 'admin', '2021-06-18 11:35:08.269676', NULL, '2021-06-18 11:35:08.269676');
INSERT INTO `b_item` VALUES (113, 'U盘', 3, '128GB', NULL, 0, 'admin', '2021-06-18 11:35:08.312638', NULL, '2021-06-18 11:35:08.312638');
INSERT INTO `b_item` VALUES (114, 'U盘', 3, '256GB', NULL, 0, 'admin', '2021-06-18 11:35:08.355691', NULL, '2021-06-18 11:35:08.355691');
INSERT INTO `b_item` VALUES (115, '5号电池', 3, NULL, NULL, 0, 'admin', '2021-06-18 11:35:08.398814', NULL, '2021-06-18 11:35:08.398814');
INSERT INTO `b_item` VALUES (116, '7号电池', 3, NULL, NULL, 0, 'admin', '2021-06-18 11:35:08.442749', NULL, '2021-06-18 11:35:08.442749');
INSERT INTO `b_item` VALUES (117, '移动硬盘', 3, '1T', NULL, 0, 'admin', '2021-06-18 11:35:08.485626', NULL, '2021-06-18 11:35:08.485626');
INSERT INTO `b_item` VALUES (118, '移动硬盘', 3, '2T', NULL, 0, 'admin', '2021-06-18 11:35:08.530704', NULL, '2021-06-18 11:35:08.530704');
INSERT INTO `b_item` VALUES (119, '办公电话', 3, '普通', NULL, 0, 'admin', '2021-06-18 11:35:08.573834', NULL, '2021-06-18 11:35:08.573834');
INSERT INTO `b_item` VALUES (120, '办公电话', 3, '多功能 ', NULL, 0, 'admin', '2021-06-18 11:35:08.618479', NULL, '2021-06-18 11:35:08.618479');
INSERT INTO `b_item` VALUES (121, ' 中性笔', 1, '0.5mm 红色', NULL, 0, 'admin', '2021-06-18 11:35:08.663286', NULL, '2021-06-18 11:35:08.663286');
INSERT INTO `b_item` VALUES (122, ' 中性笔', 1, '0.7mm 红色', NULL, 0, 'admin', '2021-06-18 11:35:08.706880', NULL, '2021-06-18 11:35:08.706880');
INSERT INTO `b_item` VALUES (123, ' 中性笔', 1, '1mm 红色', NULL, 0, 'admin', '2021-06-18 11:35:08.750578', NULL, '2021-06-18 11:35:08.750578');
INSERT INTO `b_item` VALUES (124, '双面胶', 1, '宽', NULL, 0, 'admin', '2021-06-18 11:35:08.793825', NULL, '2021-06-18 11:35:08.793825');
INSERT INTO `b_item` VALUES (125, '双面胶', 1, '窄', NULL, 0, 'admin', '2021-06-18 11:35:08.837029', NULL, '2021-06-18 11:35:08.837029');
INSERT INTO `b_item` VALUES (126, '订书器', 1, NULL, NULL, 0, 'admin', '2021-06-18 11:35:08.880387', NULL, '2021-06-18 11:35:08.880387');
INSERT INTO `b_item` VALUES (127, '拖把', 2, '棉布条', NULL, 0, 'admin', '2021-06-18 11:35:08.880387', NULL, '2021-06-21 15:59:03.172875');
INSERT INTO `b_item` VALUES (128, '皮面本（软皮）', 1, 'A5', NULL, 0, 'admin', '2021-06-18 11:35:04.265330', NULL, '2021-06-21 16:13:35.193797');
INSERT INTO `b_item` VALUES (129, '皮面本（硬皮）', 1, 'A5', NULL, 0, 'admin', '2021-06-18 11:35:04.265330', NULL, '2021-06-21 16:13:35.193797');

-- ----------------------------
-- Table structure for b_procurement
-- ----------------------------
DROP TABLE IF EXISTS `b_procurement`;
CREATE TABLE `b_procurement`  (
  `pro_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '采购id',
  `pro_time` datetime(0) NOT NULL COMMENT '采购时间',
  `org_id` int(11) NOT NULL COMMENT '组织id',
  `item_id` int(11) NOT NULL COMMENT '物品id',
  `unit_id` int(11) NOT NULL COMMENT '单位id',
  `price` decimal(10, 2) NOT NULL COMMENT '单价',
  `count` int(11) NOT NULL COMMENT '采购数量',
  `is_pay` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否下单',
  `is_arrive` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否到货',
  `cost` decimal(10, 2) NOT NULL COMMENT '总花费',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者  登录名',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者  登录名',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间',
  `bath_id` int(11) NULL DEFAULT NULL COMMENT '批次id',
  PRIMARY KEY (`pro_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 125 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '采购表，同时记录采购价格' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_procurement
-- ----------------------------
INSERT INTO `b_procurement` VALUES (1, '2021-09-07 11:08:01', 15, 108, 108, 60.00, 24, 1, 1, 1440.00, 'gyzcglc', '2021-09-07 11:08:01.255782', 'gyzcglc', '2021-09-07 11:08:01.255782', 1);
INSERT INTO `b_procurement` VALUES (2, '2021-09-07 11:08:33', 15, 106, 106, 49.00, 34, 1, 1, 1666.00, 'gyzcglc', '2021-09-07 11:08:33.463974', 'gyzcglc', '2021-09-07 11:08:33.463974', 1);
INSERT INTO `b_procurement` VALUES (3, '2021-09-07 11:08:59', 15, 103, 103, 37.00, 45, 1, 1, 1665.00, 'gyzcglc', '2021-09-07 11:08:58.516746', 'gyzcglc', '2021-09-07 11:08:58.516746', 1);
INSERT INTO `b_procurement` VALUES (4, '2021-09-07 11:09:52', 15, 61, 61, 2.40, 15, 1, 1, 36.00, 'gyzcglc', '2021-09-07 11:09:51.931380', 'gyzcglc', '2021-09-07 11:09:51.931380', 1);
INSERT INTO `b_procurement` VALUES (5, '2021-09-07 11:10:19', 15, 86, 86, 7.00, 716, 1, 1, 5012.00, 'gyzcglc', '2021-09-07 11:10:19.067739', 'gyzcglc', '2021-09-07 11:10:19.067739', 1);
INSERT INTO `b_procurement` VALUES (6, '2021-09-07 11:10:38', 15, 16, 16, 2.00, 2, 1, 1, 4.00, 'gyzcglc', '2021-09-07 11:10:38.117994', 'gyzcglc', '2021-09-07 11:10:38.117994', 1);
INSERT INTO `b_procurement` VALUES (7, '2021-09-07 11:11:17', 15, 58, 58, 9.00, 94, 1, 1, 846.00, 'gyzcglc', '2021-09-07 11:11:16.858932', 'gyzcglc', '2021-09-07 11:11:16.858932', 1);
INSERT INTO `b_procurement` VALUES (8, '2021-09-07 11:11:45', 15, 33, 33, 5.00, 17, 1, 1, 85.00, 'gyzcglc', '2021-09-07 11:11:45.146237', 'gyzcglc', '2021-09-07 11:11:45.146237', 1);
INSERT INTO `b_procurement` VALUES (9, '2021-09-07 11:12:18', 15, 38, 38, 6.50, 143, 1, 1, 929.50, 'gyzcglc', '2021-09-07 11:12:18.331039', 'gyzcglc', '2021-09-07 11:12:18.331039', 1);
INSERT INTO `b_procurement` VALUES (10, '2021-09-07 11:12:35', 15, 35, 35, 5.80, 68, 1, 1, 394.40, 'gyzcglc', '2021-09-07 11:12:35.280483', 'gyzcglc', '2021-09-07 11:12:35.280483', 1);
INSERT INTO `b_procurement` VALUES (11, '2021-09-07 11:12:53', 15, 112, 112, 42.00, 36, 1, 1, 1512.00, 'gyzcglc', '2021-09-07 11:12:53.083385', 'gyzcglc', '2021-09-07 11:12:53.083385', 1);
INSERT INTO `b_procurement` VALUES (12, '2021-09-07 11:13:12', 15, 105, 105, 32.00, 11, 1, 1, 352.00, 'gyzcglc', '2021-09-07 11:13:12.165876', 'gyzcglc', '2021-09-07 11:13:12.165876', 1);
INSERT INTO `b_procurement` VALUES (13, '2021-09-07 11:13:41', 15, 116, 116, 1.80, 799, 1, 1, 1438.20, 'gyzcglc', '2021-09-07 11:13:41.463601', 'gyzcglc', '2021-09-07 11:13:41.463601', 1);
INSERT INTO `b_procurement` VALUES (14, '2021-09-07 11:13:58', 15, 114, 114, 185.00, 65, 1, 1, 12025.00, 'gyzcglc', '2021-09-07 11:13:57.973360', 'gyzcglc', '2021-09-07 11:13:57.973360', 1);
INSERT INTO `b_procurement` VALUES (15, '2021-09-07 11:14:24', 15, 37, 37, 6.00, 165, 1, 1, 990.00, 'gyzcglc', '2021-09-07 11:14:24.010197', 'gyzcglc', '2021-09-07 11:14:24.010197', 1);
INSERT INTO `b_procurement` VALUES (16, '2021-09-07 11:14:51', 15, 120, 120, 110.00, 2, 1, 1, 220.00, 'gyzcglc', '2021-09-07 11:14:51.234169', 'gyzcglc', '2021-09-07 11:14:51.234169', 1);
INSERT INTO `b_procurement` VALUES (17, '2021-09-07 11:15:11', 15, 109, 109, 18.00, 5, 1, 1, 90.00, 'gyzcglc', '2021-09-07 11:15:11.404513', 'gyzcglc', '2021-09-07 11:15:11.404513', 1);
INSERT INTO `b_procurement` VALUES (18, '2021-09-07 11:15:46', 15, 34, 34, 5.00, 101, 1, 1, 505.00, 'gyzcglc', '2021-09-07 11:15:46.419854', 'gyzcglc', '2021-09-07 11:15:46.419854', 1);
INSERT INTO `b_procurement` VALUES (19, '2021-09-07 11:16:02', 15, 107, 107, 110.00, 8, 1, 1, 880.00, 'gyzcglc', '2021-09-07 11:16:01.694912', 'gyzcglc', '2021-09-07 11:16:01.694912', 1);
INSERT INTO `b_procurement` VALUES (20, '2021-09-07 11:16:15', 15, 110, 110, 20.00, 16, 1, 1, 320.00, 'gyzcglc', '2021-09-07 11:16:14.633454', 'gyzcglc', '2021-09-07 11:16:14.633454', 1);
INSERT INTO `b_procurement` VALUES (21, '2021-09-07 11:16:26', 15, 113, 113, 68.00, 20, 1, 1, 1360.00, 'gyzcglc', '2021-09-07 11:16:26.259537', 'gyzcglc', '2021-09-07 11:16:26.259537', 1);
INSERT INTO `b_procurement` VALUES (22, '2021-09-07 11:16:44', 15, 102, 102, 28.00, 19, 1, 1, 532.00, 'gyzcglc', '2021-09-07 11:16:44.196187', 'gyzcglc', '2021-09-07 11:16:44.196187', 1);
INSERT INTO `b_procurement` VALUES (23, '2021-09-07 11:16:58', 15, 36, 36, 11.00, 120, 1, 1, 1320.00, 'gyzcglc', '2021-09-07 11:16:57.644261', 'gyzcglc', '2021-09-07 11:16:57.644261', 1);
INSERT INTO `b_procurement` VALUES (24, '2021-09-07 11:17:14', 15, 104, 104, 45.00, 96, 1, 1, 4320.00, 'gyzcglc', '2021-09-07 11:17:14.136531', 'gyzcglc', '2021-09-07 11:17:14.136531', 1);
INSERT INTO `b_procurement` VALUES (25, '2021-09-07 11:18:06', 15, 101, 101, 24.00, 41, 1, 1, 984.00, 'gyzcglc', '2021-09-07 11:18:05.545503', 'gyzcglc', '2021-09-07 11:18:05.545503', 1);
INSERT INTO `b_procurement` VALUES (26, '2021-09-07 11:18:51', 15, 99, 99, 60.00, 1, 1, 1, 60.00, 'gyzcglc', '2021-09-07 11:18:50.828555', 'gyzcglc', '2021-09-07 11:18:50.828555', 1);
INSERT INTO `b_procurement` VALUES (27, '2021-09-07 11:19:08', 15, 115, 115, 1.80, 959, 1, 1, 1726.20, 'gyzcglc', '2021-09-07 11:19:08.370719', 'gyzcglc', '2021-09-07 11:19:08.370719', 1);
INSERT INTO `b_procurement` VALUES (28, '2021-09-07 11:19:33', 15, 19, 19, 9.00, 13, 1, 1, 117.00, 'gyzcglc', '2021-09-07 11:19:32.908377', 'gyzcglc', '2021-09-07 11:19:32.908377', 1);
INSERT INTO `b_procurement` VALUES (29, '2021-09-07 11:21:19', 15, 60, 60, 5.00, 35, 1, 1, 175.00, 'gyzcglc', '2021-09-07 11:21:19.186845', 'gyzcglc', '2021-09-07 11:21:19.186845', 1);
INSERT INTO `b_procurement` VALUES (30, '2021-09-07 11:21:32', 15, 98, 98, 70.00, 13, 1, 1, 910.00, 'gyzcglc', '2021-09-07 11:21:31.907402', 'gyzcglc', '2021-09-07 11:21:31.907402', 1);
INSERT INTO `b_procurement` VALUES (31, '2021-09-07 11:21:49', 15, 26, 26, 5.30, 51, 1, 1, 270.30, 'gyzcglc', '2021-09-07 11:21:48.605129', 'gyzcglc', '2021-09-07 11:21:48.605129', 1);
INSERT INTO `b_procurement` VALUES (32, '2021-09-07 11:22:11', 15, 25, 25, 3.00, 181, 1, 1, 543.00, 'gyzcglc', '2021-09-07 11:22:10.838839', 'gyzcglc', '2021-09-07 11:22:10.838839', 1);
INSERT INTO `b_procurement` VALUES (33, '2021-09-07 11:22:50', 15, 71, 71, 1.50, 2, 1, 1, 3.00, 'gyzcglc', '2021-09-07 11:22:49.755742', 'gyzcglc', '2021-09-07 11:22:49.755742', 1);
INSERT INTO `b_procurement` VALUES (34, '2021-09-07 11:23:18', 15, 32, 32, 0.60, 1675, 1, 1, 1005.00, 'gyzcglc', '2021-09-07 11:23:18.417728', 'gyzcglc', '2021-09-07 11:23:18.417728', 1);
INSERT INTO `b_procurement` VALUES (35, '2021-09-07 11:23:34', 15, 83, 83, 5.00, 68, 1, 1, 340.00, 'gyzcglc', '2021-09-07 11:23:34.129652', 'gyzcglc', '2021-09-07 11:23:34.129652', 1);
INSERT INTO `b_procurement` VALUES (36, '2021-09-07 11:24:11', 15, 100, 100, 170.00, 25, 1, 1, 4250.00, 'gyzcglc', '2021-09-07 11:24:10.936651', 'gyzcglc', '2021-09-07 11:24:10.936651', 1);
INSERT INTO `b_procurement` VALUES (37, '2021-09-07 11:24:44', 15, 64, 64, 3.00, 35, 1, 1, 105.00, 'gyzcglc', '2021-09-07 11:24:43.556579', 'gyzcglc', '2021-09-07 11:24:43.556579', 1);
INSERT INTO `b_procurement` VALUES (38, '2021-09-07 11:25:13', 15, 50, 50, 1.00, 143, 1, 1, 143.00, 'gyzcglc', '2021-09-07 11:25:12.924972', 'gyzcglc', '2021-09-07 11:25:12.924972', 1);
INSERT INTO `b_procurement` VALUES (39, '2021-09-07 11:25:40', 15, 53, 53, 19.00, 14, 1, 1, 266.00, 'gyzcglc', '2021-09-07 11:25:39.833115', 'gyzcglc', '2021-09-07 11:25:39.833115', 1);
INSERT INTO `b_procurement` VALUES (40, '2021-09-07 11:25:56', 15, 49, 49, 0.90, 100, 1, 1, 90.00, 'gyzcglc', '2021-09-07 11:25:55.995631', 'gyzcglc', '2021-09-07 11:25:55.995631', 1);
INSERT INTO `b_procurement` VALUES (41, '2021-09-07 11:26:15', 15, 46, 46, 13.00, 15, 1, 1, 195.00, 'gyzcglc', '2021-09-07 11:26:15.261660', 'gyzcglc', '2021-09-07 11:26:15.261660', 1);
INSERT INTO `b_procurement` VALUES (42, '2021-09-07 11:27:01', 15, 51, 51, 90.00, 10, 1, 1, 900.00, 'gyzcglc', '2021-09-07 11:27:01.053564', 'gyzcglc', '2021-09-07 11:27:01.053564', 1);
INSERT INTO `b_procurement` VALUES (43, '2021-09-07 11:27:32', 15, 88, 88, 2.50, 387, 1, 1, 967.50, 'gyzcglc', '2021-09-07 11:27:31.839873', 'gyzcglc', '2021-09-07 11:27:31.839873', 1);
INSERT INTO `b_procurement` VALUES (44, '2021-09-07 11:27:48', 15, 126, 126, 14.00, 95, 1, 1, 1330.00, 'gyzcglc', '2021-09-07 11:27:48.285085', 'gyzcglc', '2021-09-07 11:27:48.285085', 1);
INSERT INTO `b_procurement` VALUES (45, '2021-09-07 11:28:00', 15, 42, 42, 12.00, 16, 1, 1, 192.00, 'gyzcglc', '2021-09-07 11:28:00.464581', 'gyzcglc', '2021-09-07 11:28:00.464581', 1);
INSERT INTO `b_procurement` VALUES (46, '2021-09-07 11:28:42', 15, 69, 69, 1.10, 171, 1, 1, 188.10, 'gyzcglc', '2021-09-07 11:28:41.876453', 'gyzcglc', '2021-09-07 11:28:41.876453', 1);
INSERT INTO `b_procurement` VALUES (47, '2021-09-07 11:29:07', 15, 18, 18, 1.20, 21, 1, 1, 25.20, 'gyzcglc', '2021-09-07 11:29:06.535343', 'gyzcglc', '2021-09-07 11:29:06.535343', 1);
INSERT INTO `b_procurement` VALUES (48, '2021-09-07 11:30:50', 15, 54, 54, 28.00, 12, 1, 1, 336.00, 'gyzcglc', '2021-09-07 11:30:50.250126', 'gyzcglc', '2021-09-07 11:30:50.250126', 1);
INSERT INTO `b_procurement` VALUES (49, '2021-09-07 11:31:10', 15, 63, 63, 4.50, 87, 1, 1, 391.50, 'gyzcglc', '2021-09-07 11:31:10.185995', 'gyzcglc', '2021-09-07 11:31:10.185995', 1);
INSERT INTO `b_procurement` VALUES (50, '2021-09-07 11:31:21', 15, 85, 85, 2.20, 315, 1, 1, 693.00, 'gyzcglc', '2021-09-07 11:31:20.734744', 'gyzcglc', '2021-09-07 11:31:20.734744', 1);
INSERT INTO `b_procurement` VALUES (51, '2021-09-07 11:31:58', 15, 78, 78, 4.00, 48, 1, 1, 192.00, 'gyzcglc', '2021-09-07 11:31:58.120975', 'gyzcglc', '2021-09-07 11:31:58.120975', 1);
INSERT INTO `b_procurement` VALUES (52, '2021-09-07 11:32:52', 15, 84, 84, 10.00, 40, 1, 1, 400.00, 'gyzcglc', '2021-09-07 11:32:52.156310', 'gyzcglc', '2021-09-07 11:32:52.156310', 1);
INSERT INTO `b_procurement` VALUES (53, '2021-09-07 11:33:06', 15, 27, 27, 1.40, 218, 1, 1, 305.20, 'gyzcglc', '2021-09-07 11:33:05.661650', 'gyzcglc', '2021-09-07 11:33:05.661650', 1);
INSERT INTO `b_procurement` VALUES (54, '2021-09-07 11:34:01', 15, 97, 97, 21.00, 18, 1, 1, 378.00, 'gyzcglc', '2021-09-07 11:34:01.149550', 'gyzcglc', '2021-09-07 11:34:01.149550', 1);
INSERT INTO `b_procurement` VALUES (55, '2021-09-07 11:34:43', 15, 77, 77, 2.00, 9, 1, 1, 18.00, 'gyzcglc', '2021-09-07 11:34:42.755600', 'gyzcglc', '2021-09-07 11:34:42.755600', 1);
INSERT INTO `b_procurement` VALUES (56, '2021-09-07 11:35:20', 15, 72, 72, 4.00, 4, 1, 1, 16.00, 'gyzcglc', '2021-09-07 11:35:20.000816', 'gyzcglc', '2021-09-07 11:35:20.000816', 1);
INSERT INTO `b_procurement` VALUES (57, '2021-09-07 11:35:43', 15, 44, 44, 75.00, 16, 1, 1, 1200.00, 'gyzcglc', '2021-09-07 11:35:43.083969', 'gyzcglc', '2021-09-07 11:35:43.083969', 1);
INSERT INTO `b_procurement` VALUES (58, '2021-09-07 11:36:01', 15, 128, 128, 11.00, 85, 1, 1, 935.00, 'gyzcglc', '2021-09-07 11:36:01.099741', 'gyzcglc', '2021-09-07 11:36:01.099741', 1);
INSERT INTO `b_procurement` VALUES (59, '2021-09-07 11:36:11', 15, 22, 22, 14.00, 66, 1, 1, 924.00, 'gyzcglc', '2021-09-07 11:36:11.383787', 'gyzcglc', '2021-09-07 11:36:11.383787', 1);
INSERT INTO `b_procurement` VALUES (60, '2021-09-07 11:36:27', 15, 41, 41, 2.90, 284, 1, 1, 823.60, 'gyzcglc', '2021-09-07 11:36:26.889676', 'gyzcglc', '2021-09-07 11:36:26.889676', 1);
INSERT INTO `b_procurement` VALUES (61, '2021-09-07 11:36:45', 15, 10, 10, 4.00, 12, 1, 1, 48.00, 'gyzcglc', '2021-09-07 11:36:44.889836', 'gyzcglc', '2021-09-07 11:36:44.889836', 1);
INSERT INTO `b_procurement` VALUES (62, '2021-09-07 11:36:59', 15, 56, 56, 12.00, 51, 1, 1, 612.00, 'gyzcglc', '2021-09-07 11:36:58.842635', 'gyzcglc', '2021-09-07 11:36:58.842635', 1);
INSERT INTO `b_procurement` VALUES (63, '2021-09-07 11:37:15', 15, 70, 70, 1.50, 9, 1, 1, 13.50, 'gyzcglc', '2021-09-07 11:37:14.844897', 'gyzcglc', '2021-09-07 11:37:14.844897', 1);
INSERT INTO `b_procurement` VALUES (64, '2021-09-07 11:38:15', 15, 95, 95, 10.00, 92, 1, 1, 920.00, 'gyzcglc', '2021-09-07 11:38:15.393591', 'gyzcglc', '2021-09-07 11:38:15.393591', 1);
INSERT INTO `b_procurement` VALUES (65, '2021-09-07 11:38:35', 15, 29, 29, 3.00, 128, 1, 1, 384.00, 'gyzcglc', '2021-09-07 11:38:34.991168', 'gyzcglc', '2021-09-07 11:38:34.991168', 1);
INSERT INTO `b_procurement` VALUES (66, '2021-09-07 11:43:01', 15, 3, 3, 13.00, 19, 1, 1, 247.00, 'gyzcglc', '2021-09-07 11:43:01.460369', 'gyzcglc', '2021-09-07 11:43:01.460369', 1);
INSERT INTO `b_procurement` VALUES (67, '2021-09-07 11:43:55', 15, 7, 7, 12.00, 16, 1, 1, 192.00, 'gyzcglc', '2021-09-07 11:43:55.215640', 'gyzcglc', '2021-09-07 11:43:55.215640', 1);
INSERT INTO `b_procurement` VALUES (68, '2021-09-07 11:44:13', 15, 111, 111, 25.00, 12, 1, 1, 300.00, 'gyzcglc', '2021-09-07 11:44:13.107505', 'gyzcglc', '2021-09-07 11:44:13.107505', 1);
INSERT INTO `b_procurement` VALUES (69, '2021-09-07 11:44:34', 15, 11, 11, 4.00, 7, 1, 1, 28.00, 'gyzcglc', '2021-09-07 11:44:34.113683', 'gyzcglc', '2021-09-07 11:44:34.113683', 1);
INSERT INTO `b_procurement` VALUES (70, '2021-09-07 11:45:03', 15, 30, 30, 4.20, 56, 1, 1, 235.20, 'gyzcglc', '2021-09-07 11:45:03.314828', 'gyzcglc', '2021-09-07 11:45:03.314828', 1);
INSERT INTO `b_procurement` VALUES (71, '2021-09-07 11:45:18', 15, 75, 75, 2.20, 3, 1, 1, 6.60, 'gyzcglc', '2021-09-07 11:45:18.148548', 'gyzcglc', '2021-09-07 11:45:18.148548', 1);
INSERT INTO `b_procurement` VALUES (72, '2021-09-07 11:46:07', 15, 94, 94, 9.00, 122, 1, 1, 1098.00, 'gyzcglc', '2021-09-07 11:46:06.844609', 'gyzcglc', '2021-09-07 11:46:06.844609', 1);
INSERT INTO `b_procurement` VALUES (73, '2021-09-07 11:46:23', 15, 121, 121, 10.00, 21, 1, 1, 210.00, 'gyzcglc', '2021-09-07 11:46:23.158719', 'gyzcglc', '2021-09-07 11:46:23.158719', 1);
INSERT INTO `b_procurement` VALUES (74, '2021-09-07 11:46:50', 15, 118, 118, 390.00, 19, 1, 1, 7410.00, 'gyzcglc', '2021-09-07 11:46:49.761130', 'gyzcglc', '2021-09-07 11:46:49.761130', 1);
INSERT INTO `b_procurement` VALUES (75, '2021-09-07 11:47:06', 15, 123, 123, 13.00, 2, 1, 1, 26.00, 'gyzcglc', '2021-09-07 11:47:05.741703', 'gyzcglc', '2021-09-07 11:47:05.741703', 1);
INSERT INTO `b_procurement` VALUES (76, '2021-09-07 11:47:17', 15, 2, 2, 13.00, 59, 1, 1, 767.00, 'gyzcglc', '2021-09-07 11:47:16.655260', 'gyzcglc', '2021-09-07 11:47:16.655260', 1);
INSERT INTO `b_procurement` VALUES (77, '2021-09-07 11:47:29', 15, 21, 21, 12.00, 141, 1, 1, 1692.00, 'gyzcglc', '2021-09-07 11:47:28.744309', 'gyzcglc', '2021-09-07 11:47:28.744309', 1);
INSERT INTO `b_procurement` VALUES (78, '2021-09-07 11:47:48', 15, 6, 6, 12.00, 12, 1, 1, 144.00, 'gyzcglc', '2021-09-07 11:47:47.685814', 'gyzcglc', '2021-09-07 11:47:47.685814', 1);
INSERT INTO `b_procurement` VALUES (79, '2021-09-07 11:48:10', 15, 127, 127, 8.00, 20, 1, 1, 160.00, 'gyzcglc', '2021-09-07 11:48:10.415203', 'gyzcglc', '2021-09-07 11:48:10.415203', 1);
INSERT INTO `b_procurement` VALUES (80, '2021-09-07 11:48:51', 15, 81, 81, 9.00, 17, 1, 1, 153.00, 'gyzcglc', '2021-09-07 11:48:51.346885', 'gyzcglc', '2021-09-07 11:48:51.346885', 1);
INSERT INTO `b_procurement` VALUES (81, '2021-09-07 11:49:03', 15, 89, 89, 11.00, 132, 1, 1, 1452.00, 'gyzcglc', '2021-09-07 11:49:03.274476', 'gyzcglc', '2021-09-07 11:49:03.274476', 1);
INSERT INTO `b_procurement` VALUES (82, '2021-09-07 11:49:21', 15, 13, 13, 1.20, 37, 1, 1, 44.40, 'gyzcglc', '2021-09-07 11:49:20.592051', 'gyzcglc', '2021-09-07 11:49:20.592051', 1);
INSERT INTO `b_procurement` VALUES (83, '2021-09-07 11:49:38', 15, 59, 59, 6.00, 111, 1, 1, 666.00, 'gyzcglc', '2021-09-07 11:49:37.987976', 'gyzcglc', '2021-09-07 11:49:37.987976', 1);
INSERT INTO `b_procurement` VALUES (84, '2021-09-07 14:47:43', 15, 67, 67, 4.50, 205, 1, 1, 922.50, 'gyzcglc', '2021-09-07 14:47:43.045176', 'gyzcglc', '2021-09-07 14:47:43.045176', 1);
INSERT INTO `b_procurement` VALUES (85, '2021-09-07 14:54:56', 15, 92, 92, 21.50, 79, 1, 1, 1698.50, 'gyzcglc', '2021-09-07 14:54:56.451434', 'gyzcglc', '2021-09-07 14:54:56.451434', 1);
INSERT INTO `b_procurement` VALUES (86, '2021-09-07 14:55:31', 15, 62, 62, 3.40, 7, 1, 1, 23.80, 'gyzcglc', '2021-09-07 14:55:31.146271', 'gyzcglc', '2021-09-07 14:55:31.146271', 1);
INSERT INTO `b_procurement` VALUES (87, '2021-09-07 14:55:44', 15, 82, 82, 4.00, 70, 1, 1, 280.00, 'gyzcglc', '2021-09-07 14:55:44.024378', 'gyzcglc', '2021-09-07 14:55:44.024378', 1);
INSERT INTO `b_procurement` VALUES (88, '2021-09-07 14:56:07', 15, 12, 12, 0.90, 16, 1, 1, 14.40, 'gyzcglc', '2021-09-07 14:56:06.832225', 'gyzcglc', '2021-09-07 14:56:06.832225', 1);
INSERT INTO `b_procurement` VALUES (89, '2021-09-07 14:56:23', 15, 79, 79, 4.00, 8, 1, 1, 32.00, 'gyzcglc', '2021-09-07 14:56:23.193493', 'gyzcglc', '2021-09-07 14:56:23.193493', 1);
INSERT INTO `b_procurement` VALUES (90, '2021-09-07 14:56:41', 15, 1, 1, 17.00, 323, 1, 1, 5491.00, 'gyzcglc', '2021-09-07 14:56:41.097214', 'gyzcglc', '2021-09-07 14:56:41.097214', 1);
INSERT INTO `b_procurement` VALUES (91, '2021-09-07 14:56:53', 15, 5, 5, 10.00, 88, 1, 1, 880.00, 'gyzcglc', '2021-09-07 14:56:52.723983', 'gyzcglc', '2021-09-07 14:56:52.723983', 1);
INSERT INTO `b_procurement` VALUES (92, '2021-09-07 14:57:10', 15, 23, 23, 3.80, 192, 1, 1, 729.60, 'gyzcglc', '2021-09-07 14:57:10.482222', 'gyzcglc', '2021-09-07 14:57:10.482222', 1);
INSERT INTO `b_procurement` VALUES (93, '2021-09-07 14:57:25', 15, 93, 93, 3.00, 119, 1, 1, 357.00, 'gyzcglc', '2021-09-07 14:57:25.344689', 'gyzcglc', '2021-09-07 14:57:25.344689', 1);
INSERT INTO `b_procurement` VALUES (94, '2021-09-07 14:57:38', 15, 48, 48, 1.40, 190, 1, 1, 266.00, 'gyzcglc', '2021-09-07 14:57:38.110893', 'gyzcglc', '2021-09-07 14:57:38.110893', 1);
INSERT INTO `b_procurement` VALUES (95, '2021-09-07 14:59:08', 15, 65, 65, 80.00, 25, 1, 1, 2000.00, 'gyzcglc', '2021-09-07 14:59:08.168317', 'gyzcglc', '2021-09-07 14:59:08.168317', 1);
INSERT INTO `b_procurement` VALUES (96, '2021-09-07 14:59:24', 15, 40, 40, 1.30, 63, 1, 1, 81.90, 'gyzcglc', '2021-09-07 14:59:24.145198', 'gyzcglc', '2021-09-07 14:59:24.145198', 1);
INSERT INTO `b_procurement` VALUES (97, '2021-09-07 14:59:34', 15, 87, 87, 4.00, 489, 1, 1, 1956.00, 'gyzcglc', '2021-09-07 14:59:34.135882', 'gyzcglc', '2021-09-07 14:59:34.135882', 1);
INSERT INTO `b_procurement` VALUES (98, '2021-09-07 14:59:49', 15, 9, 9, 9.00, 3, 1, 1, 27.00, 'gyzcglc', '2021-09-07 14:59:49.465238', 'gyzcglc', '2021-09-07 14:59:49.465238', 1);
INSERT INTO `b_procurement` VALUES (99, '2021-09-07 14:59:59', 15, 15, 15, 2.00, 3, 1, 1, 6.00, 'gyzcglc', '2021-09-07 14:59:59.305943', 'gyzcglc', '2021-09-07 14:59:59.305943', 1);
INSERT INTO `b_procurement` VALUES (100, '2021-09-07 15:00:18', 15, 57, 57, 7.00, 95, 1, 1, 665.00, 'gyzcglc', '2021-09-07 15:00:18.035775', 'gyzcglc', '2021-09-07 15:00:18.035775', 1);
INSERT INTO `b_procurement` VALUES (101, '2021-09-07 15:00:52', 15, 117, 117, 290.00, 9, 1, 1, 2610.00, 'gyzcglc', '2021-09-07 15:00:51.897808', 'gyzcglc', '2021-09-07 15:00:51.897808', 1);
INSERT INTO `b_procurement` VALUES (102, '2021-09-07 15:01:06', 15, 122, 122, 13.00, 1, 1, 1, 13.00, 'gyzcglc', '2021-09-07 15:01:05.519417', 'gyzcglc', '2021-09-07 15:01:05.519417', 1);
INSERT INTO `b_procurement` VALUES (103, '2021-09-07 15:01:17', 15, 76, 76, 2.20, 83, 1, 1, 182.60, 'gyzcglc', '2021-09-07 15:01:16.777368', 'gyzcglc', '2021-09-07 15:01:16.777368', 1);
INSERT INTO `b_procurement` VALUES (104, '2021-09-07 15:02:07', 15, 45, 45, 19.00, 17, 1, 1, 323.00, 'gyzcglc', '2021-09-07 15:02:07.059478', 'gyzcglc', '2021-09-07 15:02:07.059478', 1);
INSERT INTO `b_procurement` VALUES (105, '2021-09-07 15:02:16', 15, 68, 68, 0.90, 200, 1, 1, 180.00, 'gyzcglc', '2021-09-07 15:02:16.266586', 'gyzcglc', '2021-09-07 15:02:16.266586', 1);
INSERT INTO `b_procurement` VALUES (106, '2021-09-07 15:02:41', 15, 90, 90, 7.00, 110, 1, 1, 770.00, 'gyzcglc', '2021-09-07 15:02:40.831977', 'gyzcglc', '2021-09-07 15:02:40.831977', 1);
INSERT INTO `b_procurement` VALUES (107, '2021-09-07 15:02:58', 15, 129, 129, 6.00, 5, 1, 1, 30.00, 'gyzcglc', '2021-09-07 15:02:57.885631', 'gyzcglc', '2021-09-07 15:02:57.885631', 1);
INSERT INTO `b_procurement` VALUES (108, '2021-09-07 15:03:09', 15, 39, 39, 4.90, 211, 1, 1, 1033.90, 'gyzcglc', '2021-09-07 15:03:09.106578', 'gyzcglc', '2021-09-07 15:03:09.106578', 1);
INSERT INTO `b_procurement` VALUES (109, '2021-09-07 15:03:30', 15, 14, 14, 6.00, 9, 1, 1, 54.00, 'gyzcglc', '2021-09-07 15:03:29.921466', 'gyzcglc', '2021-09-07 15:03:29.921466', 1);
INSERT INTO `b_procurement` VALUES (110, '2021-09-07 15:03:45', 15, 31, 31, 2.00, 98, 1, 1, 196.00, 'gyzcglc', '2021-09-07 15:03:44.603917', 'gyzcglc', '2021-09-07 15:03:44.603917', 1);
INSERT INTO `b_procurement` VALUES (111, '2021-09-07 15:03:54', 15, 124, 124, 1.20, 124, 1, 1, 148.80, 'gyzcglc', '2021-09-07 15:03:54.339777', 'gyzcglc', '2021-09-07 15:03:54.339777', 1);
INSERT INTO `b_procurement` VALUES (112, '2021-09-07 15:04:09', 15, 52, 52, 2.20, 38, 1, 1, 83.60, 'gyzcglc', '2021-09-07 15:04:09.456531', 'gyzcglc', '2021-09-07 15:04:09.456531', 1);
INSERT INTO `b_procurement` VALUES (113, '2021-09-07 15:04:21', 15, 74, 74, 2.20, 53, 1, 1, 116.60, 'gyzcglc', '2021-09-07 15:04:21.472422', 'gyzcglc', '2021-09-07 15:04:21.472422', 1);
INSERT INTO `b_procurement` VALUES (114, '2021-09-07 15:05:00', 15, 91, 91, 16.00, 58, 1, 1, 928.00, 'gyzcglc', '2021-09-07 15:05:00.459482', 'gyzcglc', '2021-09-07 15:05:00.459482', 1);
INSERT INTO `b_procurement` VALUES (115, '2021-09-07 15:05:15', 15, 4, 4, 12.00, 53, 1, 1, 636.00, 'gyzcglc', '2021-09-07 15:05:14.859752', 'gyzcglc', '2021-09-07 15:05:14.859752', 1);
INSERT INTO `b_procurement` VALUES (116, '2021-09-07 15:05:29', 15, 17, 17, 0.70, 167, 1, 1, 116.90, 'gyzcglc', '2021-09-07 15:05:28.831913', 'gyzcglc', '2021-09-07 15:05:28.831913', 1);
INSERT INTO `b_procurement` VALUES (117, '2021-09-07 15:05:45', 15, 96, 96, 1.10, 158, 1, 1, 173.80, 'gyzcglc', '2021-09-07 15:05:45.204479', 'gyzcglc', '2021-09-07 15:05:45.204479', 1);
INSERT INTO `b_procurement` VALUES (118, '2021-09-07 15:05:57', 15, 28, 28, 15.00, 255, 1, 1, 3825.00, 'gyzcglc', '2021-09-07 15:05:56.954110', 'gyzcglc', '2021-09-07 15:05:56.954110', 1);
INSERT INTO `b_procurement` VALUES (119, '2021-09-07 15:06:05', 15, 20, 20, 1.50, 25, 1, 1, 37.50, 'gyzcglc', '2021-09-07 15:06:04.804934', 'gyzcglc', '2021-09-07 15:06:04.804934', 1);
INSERT INTO `b_procurement` VALUES (120, '2021-09-07 15:06:16', 15, 47, 47, 5.00, 7, 1, 1, 35.00, 'gyzcglc', '2021-09-07 15:06:16.210479', 'gyzcglc', '2021-09-07 15:06:16.210479', 1);
INSERT INTO `b_procurement` VALUES (121, '2021-09-07 15:06:33', 15, 66, 66, 4.00, 48, 1, 1, 192.00, 'gyzcglc', '2021-09-07 15:06:33.345240', 'gyzcglc', '2021-09-07 15:06:33.345240', 1);
INSERT INTO `b_procurement` VALUES (122, '2021-09-07 15:06:51', 15, 125, 125, 1.20, 122, 1, 1, 146.40, 'gyzcglc', '2021-09-07 15:06:50.723972', 'gyzcglc', '2021-09-07 15:06:50.723972', 1);
INSERT INTO `b_procurement` VALUES (123, '2021-09-07 15:07:05', 15, 24, 24, 7.20, 167, 1, 1, 1202.40, 'gyzcglc', '2021-09-07 15:07:04.763205', 'gyzcglc', '2021-09-07 15:07:04.763205', 1);
INSERT INTO `b_procurement` VALUES (124, '2021-09-07 15:07:13', 15, 43, 43, 9.00, 28, 1, 1, 252.00, 'gyzcglc', '2021-09-07 15:07:12.539824', 'gyzcglc', '2021-09-07 15:07:12.539824', 1);

-- ----------------------------
-- Table structure for b_unit
-- ----------------------------
DROP TABLE IF EXISTS `b_unit`;
CREATE TABLE `b_unit`  (
  `unit_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '单位id',
  `unit_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单位名称',
  `item_id` int(11) NOT NULL COMMENT '物品id',
  `delete_tag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记  0：未删除  1：已删除',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间  登录名',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者 ',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间  登录名',
  PRIMARY KEY (`unit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 130 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单位表，记录物品的单位，一个物品可以有多个单位' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_unit
-- ----------------------------
INSERT INTO `b_unit` VALUES (1, '盒', 1, 0, 'admin', '2021-06-18 11:37:03.783585', NULL, '2021-06-18 11:37:03.783585');
INSERT INTO `b_unit` VALUES (2, '盒', 2, 0, 'admin', '2021-06-18 11:37:03.823880', NULL, '2021-06-18 11:37:03.823880');
INSERT INTO `b_unit` VALUES (3, '盒', 3, 0, 'admin', '2021-06-18 11:37:03.869754', NULL, '2021-06-18 11:37:03.869754');
INSERT INTO `b_unit` VALUES (4, '盒', 4, 0, 'admin', '2021-06-18 11:37:03.909347', NULL, '2021-06-18 11:37:03.909347');
INSERT INTO `b_unit` VALUES (5, '盒', 5, 0, 'admin', '2021-06-18 11:37:03.947978', NULL, '2021-06-18 11:37:03.947978');
INSERT INTO `b_unit` VALUES (6, '盒', 6, 0, 'admin', '2021-06-18 11:37:03.985093', NULL, '2021-06-18 11:37:03.985093');
INSERT INTO `b_unit` VALUES (7, '盒', 7, 0, 'admin', '2021-06-18 11:37:04.025051', NULL, '2021-06-18 11:37:04.025051');
INSERT INTO `b_unit` VALUES (8, '盒', 8, 0, 'admin', '2021-06-18 11:37:04.066915', NULL, '2021-06-18 11:37:04.066915');
INSERT INTO `b_unit` VALUES (9, '盒', 9, 0, 'admin', '2021-06-18 11:37:04.105320', NULL, '2021-06-18 11:37:04.105320');
INSERT INTO `b_unit` VALUES (10, '盒', 10, 0, 'admin', '2021-06-18 11:37:04.145738', NULL, '2021-06-18 11:37:04.145738');
INSERT INTO `b_unit` VALUES (11, '盒', 11, 0, 'admin', '2021-06-18 11:37:04.184127', NULL, '2021-06-18 11:37:04.184127');
INSERT INTO `b_unit` VALUES (12, '盒', 12, 0, 'admin', '2021-06-18 11:37:04.223022', NULL, '2021-06-18 11:37:04.223022');
INSERT INTO `b_unit` VALUES (13, '盒', 13, 0, 'admin', '2021-06-18 11:37:04.261398', NULL, '2021-06-18 11:37:04.261398');
INSERT INTO `b_unit` VALUES (14, '盒', 14, 0, 'admin', '2021-06-18 11:37:04.300274', NULL, '2021-06-18 11:37:04.300274');
INSERT INTO `b_unit` VALUES (15, '盒', 15, 0, 'admin', '2021-06-18 11:37:04.338795', NULL, '2021-06-18 11:37:04.338795');
INSERT INTO `b_unit` VALUES (16, '盒', 16, 0, 'admin', '2021-06-18 11:37:04.376931', NULL, '2021-06-18 11:37:04.376931');
INSERT INTO `b_unit` VALUES (17, '块', 17, 0, 'admin', '2021-06-18 11:37:04.419215', NULL, '2021-06-18 11:37:04.419215');
INSERT INTO `b_unit` VALUES (18, '盒', 18, 0, 'admin', '2021-06-18 11:37:04.457988', NULL, '2021-06-18 11:37:04.457988');
INSERT INTO `b_unit` VALUES (19, '盒', 19, 0, 'admin', '2021-06-18 11:37:04.495890', NULL, '2021-06-18 11:37:04.495890');
INSERT INTO `b_unit` VALUES (20, '盒', 20, 0, 'admin', '2021-06-18 11:37:04.533848', NULL, '2021-06-18 11:37:04.533848');
INSERT INTO `b_unit` VALUES (21, '本', 21, 0, 'admin', '2021-06-18 11:37:04.571961', NULL, '2021-06-18 11:37:04.571961');
INSERT INTO `b_unit` VALUES (22, '本', 22, 0, 'admin', '2021-06-18 11:37:04.609286', NULL, '2021-06-18 11:37:04.609286');
INSERT INTO `b_unit` VALUES (23, '本', 23, 0, 'admin', '2021-06-18 11:37:04.647150', NULL, '2021-06-18 11:37:04.647150');
INSERT INTO `b_unit` VALUES (24, '本', 24, 0, 'admin', '2021-06-18 11:37:04.684851', NULL, '2021-06-18 11:37:04.684851');
INSERT INTO `b_unit` VALUES (25, '本', 25, 0, 'admin', '2021-06-18 11:37:04.722649', NULL, '2021-06-18 11:37:04.722649');
INSERT INTO `b_unit` VALUES (26, '盒', 26, 0, 'admin', '2021-06-18 11:37:04.762629', NULL, '2021-06-18 11:37:04.762629');
INSERT INTO `b_unit` VALUES (27, '张', 27, 0, 'admin', '2021-06-18 11:37:04.802413', NULL, '2021-06-18 11:37:04.802413');
INSERT INTO `b_unit` VALUES (28, '本', 28, 0, 'admin', '2021-06-18 11:37:04.846235', NULL, '2021-06-23 09:55:44.022448');
INSERT INTO `b_unit` VALUES (29, '本', 29, 0, 'admin', '2021-06-18 11:37:04.886088', NULL, '2021-06-18 11:37:04.886088');
INSERT INTO `b_unit` VALUES (30, '本', 30, 0, 'admin', '2021-06-18 11:37:04.926017', NULL, '2021-06-18 11:37:04.926017');
INSERT INTO `b_unit` VALUES (31, '本', 31, 0, 'admin', '2021-06-18 11:37:04.965760', NULL, '2021-06-18 11:37:04.965760');
INSERT INTO `b_unit` VALUES (32, '个', 32, 0, 'admin', '2021-06-18 11:37:05.004344', NULL, '2021-06-18 11:37:05.004344');
INSERT INTO `b_unit` VALUES (33, '个', 33, 0, 'admin', '2021-06-18 11:37:05.045372', NULL, '2021-06-18 11:37:05.045372');
INSERT INTO `b_unit` VALUES (34, '个', 34, 0, 'admin', '2021-06-18 11:37:05.083900', NULL, '2021-06-18 11:37:05.083900');
INSERT INTO `b_unit` VALUES (35, '个', 35, 0, 'admin', '2021-06-18 11:37:05.123886', NULL, '2021-06-18 11:37:05.123886');
INSERT INTO `b_unit` VALUES (36, '个', 36, 0, 'admin', '2021-06-18 11:37:05.161161', NULL, '2021-06-18 11:37:05.161161');
INSERT INTO `b_unit` VALUES (37, '个', 37, 0, 'admin', '2021-06-18 11:37:05.218549', NULL, '2021-06-18 11:37:05.218549');
INSERT INTO `b_unit` VALUES (38, '个', 38, 0, 'admin', '2021-06-18 11:37:05.258702', NULL, '2021-06-18 11:37:05.258702');
INSERT INTO `b_unit` VALUES (39, '个', 39, 0, 'admin', '2021-06-18 11:37:05.298395', NULL, '2021-06-18 11:37:05.298395');
INSERT INTO `b_unit` VALUES (40, '个', 40, 0, 'admin', '2021-06-18 11:37:05.337539', NULL, '2021-06-18 11:37:05.337539');
INSERT INTO `b_unit` VALUES (41, '个', 41, 0, 'admin', '2021-06-18 11:37:05.398623', NULL, '2021-06-18 11:37:05.398623');
INSERT INTO `b_unit` VALUES (42, '个', 42, 0, 'admin', '2021-06-18 11:37:05.443510', NULL, '2021-06-18 11:37:05.443510');
INSERT INTO `b_unit` VALUES (43, '个', 43, 0, 'admin', '2021-06-18 11:37:05.484436', NULL, '2021-06-18 11:37:05.484436');
INSERT INTO `b_unit` VALUES (44, '个', 44, 0, 'admin', '2021-06-18 11:37:05.524608', NULL, '2021-06-18 11:37:05.524608');
INSERT INTO `b_unit` VALUES (45, '个', 45, 0, 'admin', '2021-06-18 11:37:05.571186', NULL, '2021-06-18 11:37:05.571186');
INSERT INTO `b_unit` VALUES (46, '个', 46, 0, 'admin', '2021-06-18 11:37:05.616990', NULL, '2021-06-18 11:37:05.616990');
INSERT INTO `b_unit` VALUES (47, '副', 47, 0, 'admin', '2021-06-18 11:37:05.655321', NULL, '2021-06-18 11:37:05.655321');
INSERT INTO `b_unit` VALUES (48, '盒', 48, 0, 'admin', '2021-06-18 11:37:05.695148', NULL, '2021-06-18 11:37:05.695148');
INSERT INTO `b_unit` VALUES (49, '盒', 49, 0, 'admin', '2021-06-18 11:37:05.734950', NULL, '2021-06-18 11:37:05.734950');
INSERT INTO `b_unit` VALUES (50, '盒', 50, 0, 'admin', '2021-06-18 11:37:05.773237', NULL, '2021-06-18 11:37:05.773237');
INSERT INTO `b_unit` VALUES (51, '个', 51, 0, 'admin', '2021-06-18 11:37:05.811572', NULL, '2021-06-18 11:37:05.811572');
INSERT INTO `b_unit` VALUES (52, '个', 52, 0, 'admin', '2021-06-18 11:37:05.849017', NULL, '2021-06-18 11:37:05.849017');
INSERT INTO `b_unit` VALUES (53, '个', 53, 0, 'admin', '2021-06-18 11:37:05.886949', NULL, '2021-06-18 11:37:05.886949');
INSERT INTO `b_unit` VALUES (54, '个', 54, 0, 'admin', '2021-06-18 11:37:05.932826', NULL, '2021-06-18 11:37:05.932826');
INSERT INTO `b_unit` VALUES (55, '个', 55, 0, 'admin', '2021-06-18 11:37:05.974165', NULL, '2021-06-18 11:37:05.974165');
INSERT INTO `b_unit` VALUES (56, '盒', 56, 0, 'admin', '2021-06-18 11:37:06.012660', NULL, '2021-06-18 11:37:06.012660');
INSERT INTO `b_unit` VALUES (57, '盒', 57, 0, 'admin', '2021-06-18 11:37:06.050928', NULL, '2021-06-18 11:37:06.050928');
INSERT INTO `b_unit` VALUES (58, '盒', 58, 0, 'admin', '2021-06-18 11:37:06.089913', NULL, '2021-06-18 11:37:06.089913');
INSERT INTO `b_unit` VALUES (59, '盒', 59, 0, 'admin', '2021-06-18 11:37:06.127732', NULL, '2021-06-18 11:37:06.127732');
INSERT INTO `b_unit` VALUES (60, '个', 60, 0, 'admin', '2021-06-18 11:37:06.165007', NULL, '2021-06-18 11:37:06.165007');
INSERT INTO `b_unit` VALUES (61, '把', 61, 0, 'admin', '2021-06-18 11:37:06.203272', NULL, '2021-06-18 11:37:06.203272');
INSERT INTO `b_unit` VALUES (62, '支', 62, 0, 'admin', '2021-06-18 11:37:06.241550', NULL, '2021-06-18 11:37:06.241550');
INSERT INTO `b_unit` VALUES (63, '个', 63, 0, 'admin', '2021-06-18 11:37:06.280399', NULL, '2021-06-18 11:37:06.280399');
INSERT INTO `b_unit` VALUES (64, '个', 64, 0, 'admin', '2021-06-18 11:37:06.319672', NULL, '2021-06-18 11:37:06.319672');
INSERT INTO `b_unit` VALUES (65, '个', 65, 0, 'admin', '2021-06-18 11:37:06.358205', NULL, '2021-06-18 11:37:06.358205');
INSERT INTO `b_unit` VALUES (66, '个', 66, 0, 'admin', '2021-06-18 11:37:06.396183', NULL, '2021-06-18 11:37:06.396183');
INSERT INTO `b_unit` VALUES (67, '卷', 67, 0, 'admin', '2021-06-18 11:37:06.435172', NULL, '2021-06-18 11:37:06.435172');
INSERT INTO `b_unit` VALUES (68, '盒', 68, 0, 'admin', '2021-06-18 11:37:06.473006', NULL, '2021-06-18 11:37:06.473006');
INSERT INTO `b_unit` VALUES (69, '管', 69, 0, 'admin', '2021-06-18 11:37:06.511824', NULL, '2021-06-18 11:37:06.511824');
INSERT INTO `b_unit` VALUES (70, '盒', 70, 0, 'admin', '2021-06-18 11:37:06.549664', NULL, '2021-06-18 11:37:06.549664');
INSERT INTO `b_unit` VALUES (71, '个', 71, 0, 'admin', '2021-06-18 11:37:06.587937', NULL, '2021-06-18 11:37:06.587937');
INSERT INTO `b_unit` VALUES (72, '个', 72, 0, 'admin', '2021-06-18 11:37:06.625991', NULL, '2021-06-18 11:37:06.625991');
INSERT INTO `b_unit` VALUES (73, '个', 73, 0, 'admin', '2021-06-18 11:37:06.669425', NULL, '2021-06-18 11:37:06.669425');
INSERT INTO `b_unit` VALUES (74, '个', 74, 0, 'admin', '2021-06-18 11:37:06.707831', NULL, '2021-06-18 11:37:06.707831');
INSERT INTO `b_unit` VALUES (75, '瓶', 75, 0, 'admin', '2021-06-18 11:37:06.747151', NULL, '2021-06-18 11:37:06.747151');
INSERT INTO `b_unit` VALUES (76, '瓶', 76, 0, 'admin', '2021-06-18 11:37:06.786967', NULL, '2021-06-18 11:37:06.786967');
INSERT INTO `b_unit` VALUES (77, '包', 77, 0, 'admin', '2021-06-18 11:37:06.827279', NULL, '2021-06-18 11:37:06.827279');
INSERT INTO `b_unit` VALUES (78, '卷', 78, 0, 'admin', '2021-06-18 11:37:06.865085', NULL, '2021-06-18 11:37:06.865085');
INSERT INTO `b_unit` VALUES (79, '个', 79, 0, 'admin', '2021-06-18 11:37:06.903040', NULL, '2021-06-18 11:37:06.903040');
INSERT INTO `b_unit` VALUES (80, '个', 80, 0, 'admin', '2021-06-18 11:37:06.941568', NULL, '2021-06-18 11:37:06.941568');
INSERT INTO `b_unit` VALUES (81, '个', 81, 0, 'admin', '2021-06-18 11:37:06.980399', NULL, '2021-06-18 11:37:06.980399');
INSERT INTO `b_unit` VALUES (82, '支', 82, 0, 'admin', '2021-06-18 11:37:07.018323', NULL, '2021-06-18 11:37:07.018323');
INSERT INTO `b_unit` VALUES (83, '个', 83, 0, 'admin', '2021-06-18 11:37:07.057100', NULL, '2021-06-18 11:37:07.057100');
INSERT INTO `b_unit` VALUES (84, '个', 84, 0, 'admin', '2021-06-18 11:37:07.107299', NULL, '2021-06-18 11:37:07.107299');
INSERT INTO `b_unit` VALUES (85, '个', 85, 0, 'admin', '2021-06-18 11:37:07.146216', NULL, '2021-06-18 11:37:07.146216');
INSERT INTO `b_unit` VALUES (86, '条', 86, 0, 'admin', '2021-06-18 11:37:07.188123', NULL, '2021-06-18 11:37:07.188123');
INSERT INTO `b_unit` VALUES (87, '块', 87, 0, 'admin', '2021-06-18 11:37:07.227412', NULL, '2021-06-18 11:37:07.227412');
INSERT INTO `b_unit` VALUES (88, '块', 88, 0, 'admin', '2021-06-18 11:37:07.270727', NULL, '2021-06-18 11:37:07.270727');
INSERT INTO `b_unit` VALUES (89, '袋', 89, 0, 'admin', '2021-06-18 11:37:07.308934', NULL, '2021-06-18 11:37:07.308934');
INSERT INTO `b_unit` VALUES (90, '袋', 90, 0, 'admin', '2021-06-18 11:37:07.349285', NULL, '2021-06-18 11:37:07.349285');
INSERT INTO `b_unit` VALUES (91, '支', 91, 0, 'admin', '2021-06-18 11:37:07.387998', NULL, '2021-06-18 11:37:07.387998');
INSERT INTO `b_unit` VALUES (92, '盘', 92, 0, 'admin', '2021-06-18 11:37:07.427485', NULL, '2021-06-18 11:37:07.427485');
INSERT INTO `b_unit` VALUES (93, '个', 93, 0, 'admin', '2021-06-18 11:37:07.465314', NULL, '2021-06-18 11:37:07.465314');
INSERT INTO `b_unit` VALUES (94, '袋', 94, 0, 'admin', '2021-06-18 11:37:07.503157', NULL, '2021-06-18 11:37:07.503157');
INSERT INTO `b_unit` VALUES (95, '袋', 95, 0, 'admin', '2021-06-18 11:37:07.541464', NULL, '2021-06-18 11:37:07.541464');
INSERT INTO `b_unit` VALUES (96, '袋', 96, 0, 'admin', '2021-06-18 11:37:07.580746', NULL, '2021-06-18 11:37:07.580746');
INSERT INTO `b_unit` VALUES (97, '个', 97, 0, 'admin', '2021-06-18 11:37:07.617629', NULL, '2021-06-18 11:37:07.617629');
INSERT INTO `b_unit` VALUES (98, '个', 98, 0, 'admin', '2021-06-18 11:37:07.656111', NULL, '2021-06-18 11:37:07.656111');
INSERT INTO `b_unit` VALUES (99, '个', 99, 0, 'admin', '2021-06-18 11:37:07.694516', NULL, '2021-06-18 11:37:07.694516');
INSERT INTO `b_unit` VALUES (100, '个', 100, 0, 'admin', '2021-06-18 11:37:07.732841', NULL, '2021-06-18 11:37:07.732841');
INSERT INTO `b_unit` VALUES (101, '个', 101, 0, 'admin', '2021-06-18 11:37:07.769750', NULL, '2021-06-18 11:37:07.769750');
INSERT INTO `b_unit` VALUES (102, '个', 102, 0, 'admin', '2021-06-18 11:37:07.807991', NULL, '2021-06-18 11:37:07.807991');
INSERT INTO `b_unit` VALUES (103, '个', 103, 0, 'admin', '2021-06-18 11:37:07.846178', NULL, '2021-06-18 11:37:07.846178');
INSERT INTO `b_unit` VALUES (104, '个', 104, 0, 'admin', '2021-06-18 11:37:07.884504', NULL, '2021-06-18 11:37:07.884504');
INSERT INTO `b_unit` VALUES (105, '个', 105, 0, 'admin', '2021-06-18 11:37:07.923201', NULL, '2021-06-18 11:37:07.923201');
INSERT INTO `b_unit` VALUES (106, '个', 106, 0, 'admin', '2021-06-18 11:37:07.962117', NULL, '2021-06-18 11:37:07.962117');
INSERT INTO `b_unit` VALUES (107, '个', 107, 0, 'admin', '2021-06-18 11:37:08.001098', NULL, '2021-06-18 11:37:08.001098');
INSERT INTO `b_unit` VALUES (108, '个', 108, 0, 'admin', '2021-06-18 11:37:08.039716', NULL, '2021-06-18 11:37:08.039716');
INSERT INTO `b_unit` VALUES (109, '个', 109, 0, 'admin', '2021-06-18 11:37:08.077148', NULL, '2021-06-18 11:37:08.077148');
INSERT INTO `b_unit` VALUES (110, '个', 110, 0, 'admin', '2021-06-18 11:37:08.115433', NULL, '2021-06-18 11:37:08.115433');
INSERT INTO `b_unit` VALUES (111, '个', 111, 0, 'admin', '2021-06-18 11:37:08.152657', NULL, '2021-06-18 11:37:08.152657');
INSERT INTO `b_unit` VALUES (112, '个', 112, 0, 'admin', '2021-06-18 11:37:08.189695', NULL, '2021-06-18 11:37:08.189695');
INSERT INTO `b_unit` VALUES (113, '个', 113, 0, 'admin', '2021-06-18 11:37:08.228277', NULL, '2021-06-18 11:37:08.228277');
INSERT INTO `b_unit` VALUES (114, '个', 114, 0, 'admin', '2021-06-18 11:37:08.267374', NULL, '2021-06-18 11:37:08.267374');
INSERT INTO `b_unit` VALUES (115, '节', 115, 0, 'admin', '2021-06-18 11:37:08.307455', NULL, '2021-06-18 11:37:08.307455');
INSERT INTO `b_unit` VALUES (116, '节', 116, 0, 'admin', '2021-06-18 11:37:08.346274', NULL, '2021-06-18 11:37:08.346274');
INSERT INTO `b_unit` VALUES (117, '个', 117, 0, 'admin', '2021-06-18 11:37:08.384513', NULL, '2021-06-18 11:37:08.384513');
INSERT INTO `b_unit` VALUES (118, '个', 118, 0, 'admin', '2021-06-18 11:37:08.421853', NULL, '2021-06-18 11:37:08.421853');
INSERT INTO `b_unit` VALUES (119, '个', 119, 0, 'admin', '2021-06-18 11:37:08.461708', NULL, '2021-06-18 11:37:08.461708');
INSERT INTO `b_unit` VALUES (120, '个', 120, 0, 'admin', '2021-06-18 11:37:08.500302', NULL, '2021-06-18 11:37:08.500302');
INSERT INTO `b_unit` VALUES (121, '盒', 121, 0, 'admin', '2021-06-18 11:37:08.546087', NULL, '2021-06-18 11:37:08.546087');
INSERT INTO `b_unit` VALUES (122, '盒', 122, 0, 'admin', '2021-06-18 11:37:08.585267', NULL, '2021-06-18 11:37:08.585267');
INSERT INTO `b_unit` VALUES (123, '盒', 123, 0, 'admin', '2021-06-18 11:37:08.624767', NULL, '2021-06-18 11:37:08.624767');
INSERT INTO `b_unit` VALUES (124, '个', 124, 0, 'admin', '2021-06-18 11:37:08.664347', NULL, '2021-06-18 11:37:08.664347');
INSERT INTO `b_unit` VALUES (125, '个', 125, 0, 'admin', '2021-06-18 11:37:08.702949', NULL, '2021-06-18 11:37:08.702949');
INSERT INTO `b_unit` VALUES (126, '个', 126, 0, 'admin', '2021-06-18 11:37:08.741818', NULL, '2021-06-18 11:37:08.741818');
INSERT INTO `b_unit` VALUES (127, '支', 127, 0, 'admin', '2021-06-18 11:37:08.741818', NULL, '2021-06-18 11:37:08.741818');
INSERT INTO `b_unit` VALUES (128, '本', 128, 0, 'admin', '2021-06-18 11:37:04.571961', NULL, '2021-06-21 16:16:03.894735');
INSERT INTO `b_unit` VALUES (129, '本', 129, 0, 'admin', '2021-06-18 11:37:04.571961', NULL, '2021-06-21 16:16:03.894735');

-- ----------------------------
-- Table structure for s_org
-- ----------------------------
DROP TABLE IF EXISTS `s_org`;
CREATE TABLE `s_org`  (
  `org_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组织机构id',
  `org_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组织机构名称',
  `org_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组织机构唯一编码',
  `delete_tag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标记  0：未删除  1：已删除',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者  登录名',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者  登录名',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间',
  PRIMARY KEY (`org_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组织机构表，' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of s_org
-- ----------------------------
INSERT INTO `s_org` VALUES (1, '两办', 'LB', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (2, '组织部', 'ZZB', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (3, '党委宣传部', 'DWXCB', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (4, '党委统战部', 'DWTZB', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (5, '纪检监察处', 'JWJCC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (6, '审计处', 'SJC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (7, '人事处', 'RSC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (8, '财务处', 'CWC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (9, '教务处', 'JWC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (10, '科技处', 'KJC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (11, '老干部处', 'LGBC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (12, '发展规划处', 'FZGHC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (13, '学生工作处', 'XSGZC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (14, '安全工作处', 'AQGZC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (15, '国有资产管理处', 'GYZCGLC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (16, '校园规划建设处', 'XYGHJSC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (17, '国际交流合作处', 'GJJLHZC', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (18, '团委', 'TW', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (19, '工会', 'GH', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (20, '图书馆', 'TSG', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (21, '博物馆', 'BWG', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (22, '后勤集团', 'HQJT', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (23, '学术传播中心', 'XSCBZX', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (24, '现代教育技术中心', 'XDJYJSZX', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (25, '教学发展中心', 'JXFZZX', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (26, '实验实践教学中心', 'SYSJJXZX', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (27, '国际教育交流中心', 'GJJYJLZX', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (28, '大学生就业指导与服务中心', 'DXSJYZDYFWZX', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (29, '体育部', 'TYB', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (30, '经济学院', 'JJXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (31, '管理学院', 'GLXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (32, '艺术学院', 'YSXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (33, '法政学院', 'FZXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (34, '华信学院', 'HXXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (35, '研究生学院', 'YJSXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (36, '数理教学部', 'SLJXB', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (37, '经济研究所', 'JJYJS', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (38, '信息工程学院', 'XXGCXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (39, '地球科学学院', 'DQKXXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (40, '语言文化学院', 'YYWHXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (41, '继续教育学院', 'JXJYXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (42, '宝石与材料学院', 'BSYCLXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (43, '地质调查研究院', 'DZDCYJY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (44, '光电技术研究所', 'GDJSYJS', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (45, '水资源与环境学院', 'SZYYHJXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (46, '马克思主义教学部', 'MKSZYJXB', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (47, '城市地质与工程学院', 'CSDZYGCXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (48, '网络信息安全实验室', 'WLXXAQSYS', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (49, '高等职业技术教学部', 'GDZYJSJXB', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (50, '资源与环境工程研究所', 'ZYYHJGCYJS', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (51, '土地科学与空间规划学院', 'TDKXYKJGHXY', 0, 'admin', '2021-04-30 20:30:30.000576', NULL, '2021-04-30 20:30:30.000576');
INSERT INTO `s_org` VALUES (52, '开发组', 'KFZ', 0, 'admin', '2021-05-12 16:39:53.343405', NULL, '2021-05-12 16:39:53.343405');

-- ----------------------------
-- Table structure for s_role
-- ----------------------------
DROP TABLE IF EXISTS `s_role`;
CREATE TABLE `s_role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `role_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限key',
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者  登录名',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者  登录名',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of s_role
-- ----------------------------
INSERT INTO `s_role` VALUES (1, 'ROLE_ADMIN', '管理员', 'admin', '2021-04-26 12:31:22.289002', NULL, '2021-04-27 10:40:07.146276');
INSERT INTO `s_role` VALUES (2, 'ROLE_USER', '用户', 'admin', '2021-04-26 12:31:34.193866', NULL, '2021-04-27 10:40:10.830637');
INSERT INTO `s_role` VALUES (3, 'ROLE_DEV', '开发者', 'admin', '2021-04-26 13:17:09.801163', NULL, '2021-04-27 10:40:15.218194');

-- ----------------------------
-- Table structure for s_user
-- ----------------------------
DROP TABLE IF EXISTS `s_user`;
CREATE TABLE `s_user`  (
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `login_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录名',
  `org_id` int(11) NOT NULL DEFAULT 0 COMMENT '组织机构id，如果为0，则是开发人员',
  `password_md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码 md5加密',
  `phone_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者  登录名',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者  登录名',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表，记录所有用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of s_user
-- ----------------------------
INSERT INTO `s_user` VALUES ('1386552773538680833', '杨旭晨', 'yxc', 38, '96e79218965eb72c92a549dd5a330112', '18731393262', 'yangxuchen@yangxuchen.com', 'admin', '2021-04-26 13:28:36.802644', '', '2021-05-21 10:54:28.307659');
INSERT INTO `s_user` VALUES ('1393767445109051393', '王毅楠', 'wyn', 38, '96e79218965eb72c92a549dd5a330112', '18232834233', '1521066881@qq.com', 'yxc', '2021-05-16 11:17:08.531189', '', '2021-06-15 20:42:48.780457');
INSERT INTO `s_user` VALUES ('1395331987324694529', 'lb', 'lb', 1, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 18:54:04.456789', '', '2021-05-20 18:54:04.456789');
INSERT INTO `s_user` VALUES ('1395337933060993025', 'zzb', 'zzb', 2, '4607e782c4d86fd5364d7e4508bb10d9', '18732135321', '40461543@qq.com', 'yxc', '2021-05-20 19:17:42.031543', '', '2021-06-18 10:15:47.764723');
INSERT INTO `s_user` VALUES ('1395338030213656578', 'dwxcb', 'dwxcb', 3, 'e10adc3949ba59abbe56e057f20f883e', '', '', 'yxc', '2021-05-20 19:18:05.189294', '', '2021-05-20 19:18:05.189294');
INSERT INTO `s_user` VALUES ('1395338106906505218', 'dwtzb', 'dwtzb', 4, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 19:18:23.478319', '', '2021-05-20 19:18:23.478319');
INSERT INTO `s_user` VALUES ('1395338180038389762', 'jwjcc', 'jwjcc', 5, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 19:18:40.911318', '', '2021-05-20 19:18:40.911318');
INSERT INTO `s_user` VALUES ('1395338267481239553', 'sjc', 'sjc', 6, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 19:19:01.759114', '', '2021-05-20 19:19:01.759114');
INSERT INTO `s_user` VALUES ('1395338621086232577', 'rsc', 'rsc', 7, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 19:20:26.064571', '', '2021-05-20 19:20:26.064571');
INSERT INTO `s_user` VALUES ('1395338924011450369', '财务处', 'cwc', 8, '96e79218965eb72c92a549dd5a330112', '13582619366', '3090923751@qq.com', 'yxc', '2021-05-20 19:21:38.290469', '', '2021-06-23 08:42:22.839459');
INSERT INTO `s_user` VALUES ('1395339005351587841', 'jwc', 'jwc', 9, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 19:21:57.680610', '', '2021-05-20 19:21:57.680610');
INSERT INTO `s_user` VALUES ('1395339136998207490', 'kjc', 'kjc', 10, 'fc0134651438a4cc4f9a35912e20dfb3', '', '', 'yxc', '2021-05-20 19:22:29.068110', '', '2021-05-20 19:22:29.068110');
INSERT INTO `s_user` VALUES ('1395339261791334401', 'lgbc', 'lgbc', 11, 'd27d2a6e6e2019aa73618ee984fe089e', '', '', 'yxc', '2021-05-20 19:22:58.820115', '', '2021-05-20 19:22:58.820115');
INSERT INTO `s_user` VALUES ('1395339321711161345', 'fzghc', 'fzghc', 12, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 19:23:13.107928', '', '2021-05-20 19:23:13.107928');
INSERT INTO `s_user` VALUES ('1395349876551348226', 'xsgzc', 'xsgzc', 13, '513060d8bf28186c7f40ec5934bb9e45', '13673236032', '657083274@qq.com', 'yxc', '2021-05-20 20:05:09.577012', '', '2021-06-21 22:16:21.509985');
INSERT INTO `s_user` VALUES ('1395349957283311617', 'aqgzc', 'aqgzc', 14, '569ec2f318b788f14bd1d03467b0b844', '', '', 'yxc', '2021-05-20 20:05:28.830795', '', '2021-05-20 20:05:28.830795');
INSERT INTO `s_user` VALUES ('1395350067228602370', 'gyzcglc', 'gyzcglc', 15, 'a56c6b3f774dd4bf88936210070b12a3', '', '', 'yxc', '2021-05-20 20:05:55.036761', '', '2021-05-20 20:05:55.036761');
INSERT INTO `s_user` VALUES ('1395350217250467841', '校园规划建设处', 'xyghjsc', 16, '184168f71e5e8d1a49ead0d841a43613', '', '', 'yxc', '2021-05-20 20:06:30.805919', '', '2021-06-21 09:37:04.493131');
INSERT INTO `s_user` VALUES ('1395350369067495425', 'gjjlhzc', 'gjjlhzc', 17, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:07:07.003032', '', '2021-05-20 20:07:07.003032');
INSERT INTO `s_user` VALUES ('1395350411522240513', 'tw', 'tw', 18, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:07:17.125388', '', '2021-05-20 20:07:17.125388');
INSERT INTO `s_user` VALUES ('1395350587834003458', 'gh', 'gh', 19, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:07:59.159200', '', '2021-05-20 20:07:59.159200');
INSERT INTO `s_user` VALUES ('1395350656062746626', 'tsg', 'tsg', 20, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:08:15.426864', '', '2021-05-20 20:08:15.426864');
INSERT INTO `s_user` VALUES ('1395350731199508482', 'bwg', 'bwg', 21, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:08:33.342091', '', '2021-05-20 20:08:33.342091');
INSERT INTO `s_user` VALUES ('1395350987735724033', 'hqjt', 'hqjt', 22, '471d4fb1344ad34694a059649f538ce4', '', '', 'yxc', '2021-05-20 20:09:34.502898', '', '2021-05-20 20:09:34.502898');
INSERT INTO `s_user` VALUES ('1395351161585430530', 'xscbzx', 'xscbzx', 23, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:10:15.953775', '', '2021-05-20 20:10:15.953775');
INSERT INTO `s_user` VALUES ('1395351280884019202', 'xdjyjszx', 'xdjyjszx', 24, 'c01dee94cb802c0fc57d0b3806650e7b', '', '', 'yxc', '2021-05-20 20:10:44.396499', '', '2021-05-20 20:10:44.396499');
INSERT INTO `s_user` VALUES ('1395351533968322562', 'jxfzzx', 'jxfzzx', 25, '895e107673811f49eb81389f5bb791b0', '', '', 'yxc', '2021-05-20 20:11:44.736151', '', '2021-05-20 20:11:44.736151');
INSERT INTO `s_user` VALUES ('1395351719092318209', 'sysjjxzx', 'sysjjxzx', 26, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:12:28.875494', '', '2021-05-20 20:12:28.875494');
INSERT INTO `s_user` VALUES ('1395352287399538689', 'gjjyjlzx', 'gjjyjlzx', 27, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:14:44.367150', '', '2021-05-20 20:14:44.367150');
INSERT INTO `s_user` VALUES ('1395352852573614081', 'dxsjyzdyfwzx', 'dxsjyzdyfwzx', 28, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:16:59.114747', '', '2021-05-20 20:16:59.114747');
INSERT INTO `s_user` VALUES ('1395352916348006402', 'tyb', 'tyb', 29, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:17:14.319346', '', '2021-05-20 20:17:14.319346');
INSERT INTO `s_user` VALUES ('1395352973600256002', 'jjxy', 'jjxy', 30, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:17:27.972220', '', '2021-05-20 20:17:27.972220');
INSERT INTO `s_user` VALUES ('1395353114449178625', 'glxy', 'glxy', 31, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:18:01.551697', '', '2021-05-20 20:18:01.551697');
INSERT INTO `s_user` VALUES ('1395353403176677378', 'ysxy', 'ysxy', 32, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:19:10.391191', '', '2021-05-20 20:19:10.391191');
INSERT INTO `s_user` VALUES ('1395353474018471937', 'fzxy', 'fzxy', 33, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:19:27.281145', '', '2021-05-20 20:19:27.281145');
INSERT INTO `s_user` VALUES ('1395353542167523329', 'hxxy', 'hxxy', 34, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:19:43.527503', '', '2021-05-20 20:19:43.527503');
INSERT INTO `s_user` VALUES ('1395353845164044290', 'yjsxy', 'yjsxy', 35, '1683a300635c93e05fbe1614c839334f', '', '', 'yxc', '2021-05-20 20:20:55.766685', '', '2021-05-20 20:20:55.766685');
INSERT INTO `s_user` VALUES ('1395354007894650882', 'sljxb', 'sljxb', 36, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:21:34.566201', '', '2021-05-20 20:21:34.566201');
INSERT INTO `s_user` VALUES ('1395354139042148353', 'jjyjs', 'jjyjs', 37, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:22:05.832011', '', '2021-05-20 20:22:05.832011');
INSERT INTO `s_user` VALUES ('1395354215747579906', 'xxgcxy', 'xxgcxy', 38, 'a613a0bc127f406f615da16024e30908', '', '', 'yxc', '2021-05-20 20:22:24.124186', '', '2021-05-20 20:22:24.124186');
INSERT INTO `s_user` VALUES ('1395354301453987841', '地球科学学院', 'dqkxxy', 39, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:22:44.553968', '', '2021-06-22 16:56:05.084925');
INSERT INTO `s_user` VALUES ('1395354442701369345', 'yywhxy', 'yywhxy', 40, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:23:18.230234', '', '2021-05-20 20:23:18.230234');
INSERT INTO `s_user` VALUES ('1395354596267421697', '王爱君', 'jxjyxy', 41, 'f3c3c059da74a8dff0174968cfede9b6', '13582109838', '361350601@qq.com', 'yxc', '2021-05-20 20:23:54.844569', '', '2021-06-22 10:05:10.639705');
INSERT INTO `s_user` VALUES ('1395354750483591169', 'bsyclxy', 'bsyclxy', 42, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:24:31.617835', '', '2021-05-20 20:24:31.617835');
INSERT INTO `s_user` VALUES ('1395354904666206209', 'dzdcyjy', 'dzdcyjy', 43, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:25:08.372724', '', '2021-05-20 20:25:08.372724');
INSERT INTO `s_user` VALUES ('1395355020013760514', 'gdjsyjs', 'gdjsyjs', 44, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:25:35.871426', '', '2021-05-20 20:25:35.871426');
INSERT INTO `s_user` VALUES ('1395355397723418625', 'szyyhjxy', 'szyyhjxy', 45, '6406b4d30190b979080cb9bf23e382f7', '', '', 'yxc', '2021-05-20 20:27:05.925518', '', '2021-06-22 14:59:25.914635');
INSERT INTO `s_user` VALUES ('1395355643450912770', '王登龙', 'mkszyjxb', 46, '52ce7aa7c21265d542789ff366673c90', '13111530918', '120669170@qq.com', 'yxc', '2021-05-20 20:28:04.512693', '', '2021-06-18 11:43:33.166417');
INSERT INTO `s_user` VALUES ('1395355927535316993', 'csdzygcxy', 'csdzygcxy', 47, '2295e3e58be2e27cfa9a7fea39c51458', '18633021265', '1551196626@qq.com', 'yxc', '2021-05-20 20:29:12.243337', '', '2021-06-18 16:40:12.247937');
INSERT INTO `s_user` VALUES ('1395356051661549570', 'wlxxaqsys', 'wlxxaqsys', 48, 'f4cac9451ce28b597bba9ea006db5650', '13716587739', 'huabenhanya@126.com', 'yxc', '2021-05-20 20:29:41.838307', '', '2021-06-21 09:43:39.973735');
INSERT INTO `s_user` VALUES ('1395356351692697602', 'gdzyjsjxb', 'gdzyjsjxb', 49, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:30:53.369276', '', '2021-05-20 20:30:53.369276');
INSERT INTO `s_user` VALUES ('1395356514586882050', 'zyyhjgcyjs', 'zyyhjgcyjs', 50, 'b95bf745c2fcec4f27727c68b203e289', '', '', 'yxc', '2021-05-20 20:31:32.205900', '', '2021-05-20 20:31:32.205900');
INSERT INTO `s_user` VALUES ('1395356998697644033', 'tdkxykjghxy', 'tdkxykjghxy', 51, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:33:27.629982', '', '2021-05-20 20:33:27.629982');
INSERT INTO `s_user` VALUES ('1395357102984818690', 'kfz', 'kfz', 52, '96e79218965eb72c92a549dd5a330112', '', '', 'yxc', '2021-05-20 20:33:52.492012', '', '2021-05-20 20:33:52.492012');

-- ----------------------------
-- Table structure for s_user_role
-- ----------------------------
DROP TABLE IF EXISTS `s_user_role`;
CREATE TABLE `s_user_role`  (
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `role_id` int(11) NOT NULL COMMENT '权限id',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者  登录名',
  `create_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者  登录名',
  `update_time` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '修改时间',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户权限表，维护用户和权限的多对多关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of s_user_role
-- ----------------------------
INSERT INTO `s_user_role` VALUES ('1386552773538680833', 3, 'admin', '2021-04-26 13:17:18.846287', NULL, '2021-04-26 13:28:45.996149');
INSERT INTO `s_user_role` VALUES ('1393767445109051393', 1, 'yxc', '2021-05-16 11:17:08.613048', NULL, '2021-05-16 11:17:08.613048');
INSERT INTO `s_user_role` VALUES ('1395330756770426881', 2, 'yxc', '2021-05-20 18:49:11.144600', NULL, '2021-05-23 15:20:17.481838');
INSERT INTO `s_user_role` VALUES ('1395331111679848449', 2, 'yxc', '2021-05-20 18:50:35.695594', NULL, '2021-05-23 15:20:47.212521');
INSERT INTO `s_user_role` VALUES ('1395331987324694529', 2, 'yxc', '2021-05-20 18:54:04.472277', NULL, '2021-05-23 15:20:47.248610');
INSERT INTO `s_user_role` VALUES ('1395337933060993025', 2, 'yxc', '2021-05-20 19:17:42.043082', NULL, '2021-05-23 15:20:47.284575');
INSERT INTO `s_user_role` VALUES ('1395338030213656578', 2, 'yxc', '2021-05-20 19:18:05.196933', NULL, '2021-05-23 15:20:47.319458');
INSERT INTO `s_user_role` VALUES ('1395338106906505218', 2, 'yxc', '2021-05-20 19:18:23.485642', NULL, '2021-05-23 15:20:47.355235');
INSERT INTO `s_user_role` VALUES ('1395338180038389762', 2, 'yxc', '2021-05-20 19:18:40.918178', NULL, '2021-05-23 15:20:47.390475');
INSERT INTO `s_user_role` VALUES ('1395338267481239553', 2, 'yxc', '2021-05-20 19:19:01.771121', NULL, '2021-05-23 15:20:47.425934');
INSERT INTO `s_user_role` VALUES ('1395338621086232577', 2, 'yxc', '2021-05-20 19:20:26.068792', NULL, '2021-05-23 15:20:47.463093');
INSERT INTO `s_user_role` VALUES ('1395338924011450369', 2, 'yxc', '2021-05-20 19:21:38.296293', NULL, '2021-05-23 15:20:47.504488');
INSERT INTO `s_user_role` VALUES ('1395339005351587841', 2, 'yxc', '2021-05-20 19:21:57.689461', NULL, '2021-05-23 15:20:47.541326');
INSERT INTO `s_user_role` VALUES ('1395339136998207490', 2, 'yxc', '2021-05-20 19:22:29.076295', NULL, '2021-05-23 15:20:47.579424');
INSERT INTO `s_user_role` VALUES ('1395339261791334401', 2, 'yxc', '2021-05-20 19:22:58.823493', NULL, '2021-05-23 15:20:47.615499');
INSERT INTO `s_user_role` VALUES ('1395339321711161345', 2, 'yxc', '2021-05-20 19:23:13.116119', NULL, '2021-05-23 15:20:47.657294');
INSERT INTO `s_user_role` VALUES ('1395349876551348226', 2, 'yxc', '2021-05-20 20:05:09.583261', NULL, '2021-05-23 15:20:47.695405');
INSERT INTO `s_user_role` VALUES ('1395349957283311617', 2, 'yxc', '2021-05-20 20:05:28.842205', NULL, '2021-05-23 15:20:47.731966');
INSERT INTO `s_user_role` VALUES ('1395350067228602370', 1, 'yxc', '2021-05-20 20:05:55.038862', NULL, '2021-05-23 15:25:46.232163');
INSERT INTO `s_user_role` VALUES ('1395350217250467841', 2, 'yxc', '2021-05-20 20:06:30.814468', NULL, '2021-05-23 15:20:47.803985');
INSERT INTO `s_user_role` VALUES ('1395350369067495425', 2, 'yxc', '2021-05-20 20:07:07.005027', NULL, '2021-05-23 15:20:47.839406');
INSERT INTO `s_user_role` VALUES ('1395350411522240513', 2, 'yxc', '2021-05-20 20:07:17.130484', NULL, '2021-05-23 15:20:47.874642');
INSERT INTO `s_user_role` VALUES ('1395350587834003458', 2, 'yxc', '2021-05-20 20:07:59.168201', NULL, '2021-05-23 15:20:47.910124');
INSERT INTO `s_user_role` VALUES ('1395350656062746626', 2, 'yxc', '2021-05-20 20:08:15.434874', NULL, '2021-05-23 15:20:47.950464');
INSERT INTO `s_user_role` VALUES ('1395350731199508482', 2, 'yxc', '2021-05-20 20:08:33.344974', NULL, '2021-05-23 15:20:47.988162');
INSERT INTO `s_user_role` VALUES ('1395350987735724033', 2, 'yxc', '2021-05-20 20:09:34.506773', NULL, '2021-05-23 15:20:48.027865');
INSERT INTO `s_user_role` VALUES ('1395351161585430530', 2, 'yxc', '2021-05-20 20:10:15.958887', NULL, '2021-05-23 15:20:48.062763');
INSERT INTO `s_user_role` VALUES ('1395351280884019202', 2, 'yxc', '2021-05-20 20:10:44.407572', NULL, '2021-05-23 15:20:48.097892');
INSERT INTO `s_user_role` VALUES ('1395351533968322562', 2, 'yxc', '2021-05-20 20:11:44.739124', NULL, '2021-05-23 15:20:48.133415');
INSERT INTO `s_user_role` VALUES ('1395351719092318209', 2, 'yxc', '2021-05-20 20:12:28.880012', NULL, '2021-05-23 15:20:48.198229');
INSERT INTO `s_user_role` VALUES ('1395352287399538689', 2, 'yxc', '2021-05-20 20:14:44.370126', NULL, '2021-05-23 15:20:48.234571');
INSERT INTO `s_user_role` VALUES ('1395352852573614081', 2, 'yxc', '2021-05-20 20:16:59.120545', NULL, '2021-05-23 15:20:48.271141');
INSERT INTO `s_user_role` VALUES ('1395352916348006402', 2, 'yxc', '2021-05-20 20:17:14.321281', NULL, '2021-05-23 15:20:48.307638');
INSERT INTO `s_user_role` VALUES ('1395352973600256002', 2, 'yxc', '2021-05-20 20:17:27.975788', NULL, '2021-05-23 15:20:48.344850');
INSERT INTO `s_user_role` VALUES ('1395353114449178625', 2, 'yxc', '2021-05-20 20:18:01.555128', NULL, '2021-05-23 15:20:48.380531');
INSERT INTO `s_user_role` VALUES ('1395353403176677378', 2, 'yxc', '2021-05-20 20:19:10.397237', NULL, '2021-05-23 15:20:48.421230');
INSERT INTO `s_user_role` VALUES ('1395353474018471937', 2, 'yxc', '2021-05-20 20:19:27.283977', NULL, '2021-05-23 15:20:48.462632');
INSERT INTO `s_user_role` VALUES ('1395353542167523329', 2, 'yxc', '2021-05-20 20:19:43.529919', NULL, '2021-05-23 15:20:48.499223');
INSERT INTO `s_user_role` VALUES ('1395353845164044290', 2, 'yxc', '2021-05-20 20:20:55.768498', NULL, '2021-05-23 15:20:48.542302');
INSERT INTO `s_user_role` VALUES ('1395354007894650882', 2, 'yxc', '2021-05-20 20:21:34.572099', NULL, '2021-05-23 15:20:48.577973');
INSERT INTO `s_user_role` VALUES ('1395354139042148353', 2, 'yxc', '2021-05-20 20:22:05.833589', NULL, '2021-05-23 15:20:48.613280');
INSERT INTO `s_user_role` VALUES ('1395354215747579906', 2, 'yxc', '2021-05-20 20:22:24.130062', NULL, '2021-05-23 15:20:48.649207');
INSERT INTO `s_user_role` VALUES ('1395354301453987841', 2, 'yxc', '2021-05-20 20:22:44.555798', NULL, '2021-05-23 15:20:48.684929');
INSERT INTO `s_user_role` VALUES ('1395354442701369345', 2, 'yxc', '2021-05-20 20:23:18.232724', NULL, '2021-05-23 15:20:48.720142');
INSERT INTO `s_user_role` VALUES ('1395354596267421697', 2, 'yxc', '2021-05-20 20:23:54.849146', NULL, '2021-05-23 15:20:48.759087');
INSERT INTO `s_user_role` VALUES ('1395354750483591169', 2, 'yxc', '2021-05-20 20:24:31.620386', NULL, '2021-05-23 15:20:48.797141');
INSERT INTO `s_user_role` VALUES ('1395354904666206209', 2, 'yxc', '2021-05-20 20:25:08.374552', NULL, '2021-05-23 15:20:48.833759');
INSERT INTO `s_user_role` VALUES ('1395355020013760514', 2, 'yxc', '2021-05-20 20:25:35.872934', NULL, '2021-05-23 15:20:48.893804');
INSERT INTO `s_user_role` VALUES ('1395355397723418625', 2, 'yxc', '2021-05-20 20:27:05.946314', NULL, '2021-05-23 15:20:48.930795');
INSERT INTO `s_user_role` VALUES ('1395355643450912770', 2, 'yxc', '2021-05-20 20:28:04.515384', NULL, '2021-05-23 15:20:49.019157');
INSERT INTO `s_user_role` VALUES ('1395355927535316993', 2, 'yxc', '2021-05-20 20:29:12.246285', NULL, '2021-05-23 15:20:49.054406');
INSERT INTO `s_user_role` VALUES ('1395356051661549570', 2, 'yxc', '2021-05-20 20:29:41.841267', NULL, '2021-05-23 15:20:49.090071');
INSERT INTO `s_user_role` VALUES ('1395356351692697602', 2, 'yxc', '2021-05-20 20:30:53.370894', NULL, '2021-05-23 15:20:49.130739');
INSERT INTO `s_user_role` VALUES ('1395356514586882050', 2, 'yxc', '2021-05-20 20:31:32.213446', NULL, '2021-05-23 15:20:49.165417');
INSERT INTO `s_user_role` VALUES ('1395356998697644033', 2, 'yxc', '2021-05-20 20:33:27.631745', NULL, '2021-05-23 15:20:49.199897');
INSERT INTO `s_user_role` VALUES ('1395357102984818690', 2, 'yxc', '2021-05-20 20:33:52.494822', NULL, '2021-05-23 15:20:49.235362');

SET FOREIGN_KEY_CHECKS = 1;
