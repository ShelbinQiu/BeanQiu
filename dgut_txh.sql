/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : dgut_txh

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2019-01-16 17:10:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_activity`
-- ----------------------------
DROP TABLE IF EXISTS `t_activity`;
CREATE TABLE `t_activity` (
  `act_id` int(11) NOT NULL AUTO_INCREMENT,
  `act_title` varchar(20) NOT NULL,
  `act_content` text NOT NULL,
  `act_purpose` varchar(100) NOT NULL,
  `act_address` varchar(50) NOT NULL,
  `act_name` varchar(8) NOT NULL,
  `act_phone` char(11) NOT NULL,
  `act_time` varchar(50) NOT NULL,
  `act_money` float DEFAULT NULL,
  `act_result` text,
  PRIMARY KEY (`act_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_activity
-- ----------------------------

-- ----------------------------
-- Table structure for `t_activityapply`
-- ----------------------------
DROP TABLE IF EXISTS `t_activityapply`;
CREATE TABLE `t_activityapply` (
  `aa_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `act_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL DEFAULT '1',
  `aa_state` char(1) NOT NULL,
  `aa_result` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`aa_id`),
  KEY `activity` (`act_id`),
  KEY `adminManage` (`admin_id`),
  KEY `memberApply` (`member_id`),
  CONSTRAINT `activity` FOREIGN KEY (`act_id`) REFERENCES `t_activity` (`act_id`) ON UPDATE CASCADE,
  CONSTRAINT `adminManage` FOREIGN KEY (`admin_id`) REFERENCES `t_admin` (`admin_id`) ON UPDATE CASCADE,
  CONSTRAINT `memberApply` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`member_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_activityapply
-- ----------------------------

-- ----------------------------
-- Table structure for `t_admin`
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(12) NOT NULL,
  `admin_name` varchar(8) NOT NULL,
  `admin_sex` varchar(1) DEFAULT '',
  `admin_wechat` char(20) DEFAULT NULL,
  `admin_qq` char(11) DEFAULT NULL,
  `admin_email` char(64) DEFAULT NULL,
  `admin_phone` char(11) DEFAULT NULL,
  `admin_idcard` char(18) NOT NULL,
  `admin_note` text,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('1', '12345', '张三', '男', 'wx123456', '896574512', 'adminTest@163.com', '13550343796', '440204199910277017', '超级管理员，测试着修改功能');
INSERT INTO `t_admin` VALUES ('2', '23456', '李四', '女', 'dfs15468', '9598451865', '156478946@136.com', '13444974846', '500101199901081049', '哈哈哈哈');
INSERT INTO `t_admin` VALUES ('3', '1234567', 'test', '女', '123456', '789456', 'adminTest@163.com', '13650344876', '442829199602140031', '测试修改管理员信息');

-- ----------------------------
-- Table structure for `t_apply`
-- ----------------------------
DROP TABLE IF EXISTS `t_apply`;
CREATE TABLE `t_apply` (
  `app_id` int(11) NOT NULL AUTO_INCREMENT,
  `ass_id` char(4) NOT NULL,
  `member_id` int(11) NOT NULL,
  `app_state` char(1) NOT NULL COMMENT '0表示不通过，1表示通过',
  `app_result` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`app_id`),
  KEY `ass_apply` (`ass_id`),
  KEY `menber_apply` (`member_id`),
  CONSTRAINT `ass_apply` FOREIGN KEY (`ass_id`) REFERENCES `t_association` (`ass_id`) ON UPDATE CASCADE,
  CONSTRAINT `menber_apply` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`member_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_apply
-- ----------------------------
INSERT INTO `t_apply` VALUES ('1', '4453', '1', '1', '通过');
INSERT INTO `t_apply` VALUES ('2', '4451', '3', '1', '通过');
INSERT INTO `t_apply` VALUES ('3', '4453', '5', '0', '身份证与同乡会不符合');
INSERT INTO `t_apply` VALUES ('4', '4405', '5', '1', '通过');
INSERT INTO `t_apply` VALUES ('5', '4453', '10', '1', '通过');
INSERT INTO `t_apply` VALUES ('6', '4453', '7', '1', '通过');
INSERT INTO `t_apply` VALUES ('7', '4453', '8', '1', '通过');
INSERT INTO `t_apply` VALUES ('8', '4453', '9', '1', '通过');
INSERT INTO `t_apply` VALUES ('9', '4413', '6', '1', '通过');

-- ----------------------------
-- Table structure for `t_association`
-- ----------------------------
DROP TABLE IF EXISTS `t_association`;
CREATE TABLE `t_association` (
  `ass_id` char(4) NOT NULL,
  `ass_name` varchar(20) NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  `ass_qqgroup` varchar(50) DEFAULT NULL,
  `ass_email` char(64) DEFAULT NULL,
  `ass_introduce` text,
  PRIMARY KEY (`ass_id`),
  KEY `association_member` (`member_id`),
  CONSTRAINT `association_member` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`member_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_association
-- ----------------------------
INSERT INTO `t_association` VALUES ('4401', '广州同乡会', null, '1345684351', 'asdsdas@156', '广州是一个历史文化名城，素有羊城的称号，广州是广东的省会，位于珠江三角洲');
INSERT INTO `t_association` VALUES ('4402', '韶关同乡会', null, '', '', '测试用的123');
INSERT INTO `t_association` VALUES ('4403', '深圳同乡会', null, '', '', '测试删除用的');
INSERT INTO `t_association` VALUES ('4404', '珠海同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4405', '汕头同乡会', '5', '', 'asdsdas@156', '');
INSERT INTO `t_association` VALUES ('4406', '佛山同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4407', '江门同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4408', '湛江同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4409', '茂名同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4412', '肇庆同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4413', '惠州同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4414', '梅州同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4415', '汕尾同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4416', '河源同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4417', '阳江同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4418', '清远同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4419', '东莞同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4420', '中山同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4451', '潮州同乡会', '3', null, null, null);
INSERT INTO `t_association` VALUES ('4452', '揭阳同乡会', null, null, null, null);
INSERT INTO `t_association` VALUES ('4453', '城院云浮同学会', '1', '190514752', '', '测试用的');

-- ----------------------------
-- Table structure for `t_inform`
-- ----------------------------
DROP TABLE IF EXISTS `t_inform`;
CREATE TABLE `t_inform` (
  `inform_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `inform_title` varchar(20) NOT NULL,
  `inform_content` text NOT NULL,
  `inform_time` datetime NOT NULL,
  `inform_file` varchar(50) DEFAULT NULL,
  `inform_state` char(1) NOT NULL,
  PRIMARY KEY (`inform_id`),
  KEY `send` (`admin_id`),
  CONSTRAINT `send` FOREIGN KEY (`admin_id`) REFERENCES `t_admin` (`admin_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_inform
-- ----------------------------

-- ----------------------------
-- Table structure for `t_job`
-- ----------------------------
DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `job_title` varchar(20) NOT NULL,
  `job_company` varchar(20) NOT NULL,
  `job_introduce` text NOT NULL,
  `job_address` varchar(50) NOT NULL,
  `job_require` varchar(100) NOT NULL,
  `job_email` char(64) NOT NULL,
  `job_welfare` varchar(100) NOT NULL,
  `job_salary` float NOT NULL,
  `job_count` int(3) NOT NULL,
  PRIMARY KEY (`job_id`),
  KEY `AdminJob` (`admin_id`),
  CONSTRAINT `AdminJob` FOREIGN KEY (`admin_id`) REFERENCES `t_admin` (`admin_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_job
-- ----------------------------

-- ----------------------------
-- Table structure for `t_major`
-- ----------------------------
DROP TABLE IF EXISTS `t_major`;
CREATE TABLE `t_major` (
  `major_id` int(11) NOT NULL AUTO_INCREMENT,
  `major_dept` varchar(20) NOT NULL,
  `major_name` varchar(20) NOT NULL,
  PRIMARY KEY (`major_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_major
-- ----------------------------
INSERT INTO `t_major` VALUES ('1', '计信系', '计算机科学与技术');
INSERT INTO `t_major` VALUES ('2', '计信系', '软件工程');
INSERT INTO `t_major` VALUES ('3', '计信系', '建筑电气与智能化');
INSERT INTO `t_major` VALUES ('4', '商学院', '会计学');
INSERT INTO `t_major` VALUES ('5', '商学院', '财务管理');
INSERT INTO `t_major` VALUES ('6', '商学院', '工商管理');
INSERT INTO `t_major` VALUES ('7', '商学院', '人力资源管理');
INSERT INTO `t_major` VALUES ('8', '商学院', '物流管理');
INSERT INTO `t_major` VALUES ('9', '商学院', '市场营销');
INSERT INTO `t_major` VALUES ('10', '金贸系', '国际经济与贸易');
INSERT INTO `t_major` VALUES ('11', '金贸系', '保险学');
INSERT INTO `t_major` VALUES ('12', '金贸系', '投资学');
INSERT INTO `t_major` VALUES ('13', '金贸系', '金融学');
INSERT INTO `t_major` VALUES ('14', '金贸系', '电子商务');
INSERT INTO `t_major` VALUES ('15', '城环系', '土木工程');
INSERT INTO `t_major` VALUES ('16', '城环系', '安全工程');
INSERT INTO `t_major` VALUES ('17', '城环系', '环境工程');
INSERT INTO `t_major` VALUES ('18', '城环系', '人文地理与城乡规划');
INSERT INTO `t_major` VALUES ('19', '城环系', '自然地理与资源环境');
INSERT INTO `t_major` VALUES ('20', '文传系', '汉语言文学');
INSERT INTO `t_major` VALUES ('21', '文传系', '秘书学');
INSERT INTO `t_major` VALUES ('22', '文传系', '网络与新媒体');
INSERT INTO `t_major` VALUES ('23', '政法系', '法学');
INSERT INTO `t_major` VALUES ('24', '政法系', '行政管理');
INSERT INTO `t_major` VALUES ('25', '政法系', '社会工作');
INSERT INTO `t_major` VALUES ('26', '机电系', '机械设计制造及其自动化');
INSERT INTO `t_major` VALUES ('27', '机电系', '机械电子工程');
INSERT INTO `t_major` VALUES ('28', '机电系', '材料成型及控制工程');
INSERT INTO `t_major` VALUES ('29', '机电系', '印刷工程');
INSERT INTO `t_major` VALUES ('30', '艺术系', '音乐表演');
INSERT INTO `t_major` VALUES ('31', '艺术系', '舞蹈表演');
INSERT INTO `t_major` VALUES ('32', '艺术系', '影视表演');
INSERT INTO `t_major` VALUES ('35', '外语系', '英语专业');
INSERT INTO `t_major` VALUES ('36', '外语系', '商务英语专业');
INSERT INTO `t_major` VALUES ('37', '创意设计学院', '数字媒体艺术');
INSERT INTO `t_major` VALUES ('38', '创意设计学院', '工业设计');
INSERT INTO `t_major` VALUES ('39', '创意设计学院', '视觉传达');
INSERT INTO `t_major` VALUES ('40', '电子工程与智能制造学院', '物联网工程');
INSERT INTO `t_major` VALUES ('41', '电子工程与智能制造学院', '电子信息工程');

-- ----------------------------
-- Table structure for `t_member`
-- ----------------------------
DROP TABLE IF EXISTS `t_member`;
CREATE TABLE `t_member` (
  `member_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(12) NOT NULL,
  `member_name` varchar(8) NOT NULL,
  `member_sex` varchar(1) DEFAULT '男',
  `member_grade` char(4) NOT NULL,
  `major_id` int(11) NOT NULL,
  `member_class` char(2) NOT NULL DEFAULT '1',
  `ass_id` char(4) DEFAULT NULL,
  `member_wechat` char(20) DEFAULT NULL,
  `member_qq` char(11) DEFAULT NULL,
  `member_email` char(64) DEFAULT NULL,
  `member_phone` char(11) DEFAULT NULL,
  `member_idcard` char(18) NOT NULL,
  `member_address` varchar(50) DEFAULT NULL,
  `member_from` varchar(12) NOT NULL,
  `member_note` text,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `stu_id` (`user_id`) USING BTREE,
  KEY `major_id` (`major_id`),
  KEY `association` (`ass_id`),
  CONSTRAINT `association` FOREIGN KEY (`ass_id`) REFERENCES `t_association` (`ass_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `major_id` FOREIGN KEY (`major_id`) REFERENCES `t_major` (`major_id`) ON UPDATE CASCADE,
  CONSTRAINT `stu_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_member
-- ----------------------------
INSERT INTO `t_member` VALUES ('1', '201535020117', '邱晓彬', '男', '2015', '2', '1', '4453', 'QiuXiaoBin928505216', '928505216', '928505216@qq.com', '13650388977', '445322199608250035', '广东省云浮市郁南县都城镇', '广东云浮', '测试修改信息用的');
INSERT INTO `t_member` VALUES ('3', '201535020126', '许涎', '男', '2015', '2', '1', '4451', 'xxs1563', '6468135', 'asd153@126.com', '13650343794', '445122199510102615', null, '广东潮州', '测试');
INSERT INTO `t_member` VALUES ('5', '201535020111', '林佳展', '男', '2015', '2', '1', '4405', '', '', '', '', '440559199610230415', '', '广东汕头', '测试');
INSERT INTO `t_member` VALUES ('6', '201535020133', '曾志鹏', '男', '2015', '2', '1', '4413', '', '', '', '', '441335199807230468', '不知道他家住哪里', '广东惠州', '测试');
INSERT INTO `t_member` VALUES ('7', '201840020104', '戴成袖', '女', '2018', '10', '1', '4412', null, null, null, null, '441283200001222782', null, '广东云浮', '测试');
INSERT INTO `t_member` VALUES ('8', '201735030221', '林琳', '女', '2017', '41', '1', '4453', null, null, null, null, '445322199808195827', null, '广东云浮', '测试');
INSERT INTO `t_member` VALUES ('9', '201835030212', '赖小丽', '女', '2018', '41', '1', '4453', null, null, null, null, '445322199808033123', null, '广东云浮', null);
INSERT INTO `t_member` VALUES ('10', '201837080516', '区勤', '女', '2018', '15', '1', null, null, null, null, null, '510723199905041768', null, '广东云浮', null);

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `notice_title` varchar(20) NOT NULL,
  `notice_content` text NOT NULL,
  `notice_time` datetime NOT NULL,
  `notice_file` varchar(50) DEFAULT NULL,
  `notice_state` char(1) NOT NULL,
  PRIMARY KEY (`notice_id`),
  KEY `adminSend` (`admin_id`),
  CONSTRAINT `adminSend` FOREIGN KEY (`admin_id`) REFERENCES `t_admin` (`admin_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------

-- ----------------------------
-- Table structure for `t_receiveinform`
-- ----------------------------
DROP TABLE IF EXISTS `t_receiveinform`;
CREATE TABLE `t_receiveinform` (
  `ri_id` int(11) NOT NULL,
  `inform_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `inform_read` char(1) DEFAULT NULL,
  PRIMARY KEY (`ri_id`),
  KEY `informFK` (`inform_id`),
  KEY `receive` (`member_id`),
  CONSTRAINT `informFK` FOREIGN KEY (`inform_id`) REFERENCES `t_inform` (`inform_id`) ON UPDATE CASCADE,
  CONSTRAINT `receive` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`member_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_receiveinform
-- ----------------------------

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` char(12) NOT NULL COMMENT '用户id，学生是学号',
  `user_pw` char(16) NOT NULL COMMENT '用户密码',
  `user_type` char(1) NOT NULL DEFAULT '1' COMMENT '1是会员，2是同乡会管理员，3是超级管理员',
  `user_state` char(1) NOT NULL DEFAULT '1' COMMENT '0是已注销，1是正常使用',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('12345', 'adminTest', '3', '1');
INSERT INTO `t_user` VALUES ('1234567', '123456', '2', '1');
INSERT INTO `t_user` VALUES ('201535020111', 'ljz111', '1', '1');
INSERT INTO `t_user` VALUES ('201535020117', 'qxb117', '1', '1');
INSERT INTO `t_user` VALUES ('201535020126', 'xx126', '1', '1');
INSERT INTO `t_user` VALUES ('201535020133', 'zzp133', '1', '1');
INSERT INTO `t_user` VALUES ('201735030221', 'll221', '1', '1');
INSERT INTO `t_user` VALUES ('201835030212', 'fwj212', '1', '1');
INSERT INTO `t_user` VALUES ('201837080516', 'oq516', '1', '1');
INSERT INTO `t_user` VALUES ('201840020104', 'dcx104', '1', '1');
INSERT INTO `t_user` VALUES ('23456', '123456', '2', '1');

-- ----------------------------
-- View structure for `v_activityapply`
-- ----------------------------
DROP VIEW IF EXISTS `v_activityapply`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_activityapply` AS select `t_activityapply`.`aa_id` AS `aa_id`,`t_member`.`member_name` AS `member_name`,`t_activity`.`act_title` AS `act_title`,`t_activity`.`act_content` AS `act_content`,`t_activity`.`act_purpose` AS `act_purpose`,`t_activity`.`act_address` AS `act_address`,`t_activity`.`act_name` AS `act_name`,`t_activity`.`act_time` AS `act_time`,`t_activity`.`act_money` AS `act_money`,`t_admin`.`admin_name` AS `admin_name`,`t_activityapply`.`aa_state` AS `aa_state` from (((`t_activity` join `t_activityapply`) join `t_admin`) join `t_member`) where ((`t_activity`.`act_id` = `t_activityapply`.`act_id`) and (`t_admin`.`admin_id` = `t_activityapply`.`admin_id`) and (`t_activityapply`.`member_id` = `t_member`.`member_id`)) ;

-- ----------------------------
-- View structure for `v_association`
-- ----------------------------
DROP VIEW IF EXISTS `v_association`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_association` AS select `t_association`.`ass_id` AS `ass_id`,`t_association`.`ass_name` AS `ass_name`,`t_member`.`member_name` AS `member_name`,`t_member`.`member_wechat` AS `member_wechat`,`t_member`.`member_phone` AS `member_phone`,`t_association`.`ass_qqgroup` AS `ass_qqgroup`,`t_association`.`ass_email` AS `ass_email`,`t_association`.`ass_introduce` AS `ass_introduce` from (`t_association` join `t_member`) where (`t_association`.`member_id` = `t_member`.`member_id`) ;

-- ----------------------------
-- View structure for `v_inform`
-- ----------------------------
DROP VIEW IF EXISTS `v_inform`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_inform` AS select `t_inform`.`inform_id` AS `inform_id`,`t_admin`.`admin_name` AS `admin_name`,`t_inform`.`inform_title` AS `inform_title`,`t_inform`.`inform_content` AS `inform_content`,`t_inform`.`inform_time` AS `inform_time`,`t_inform`.`inform_file` AS `inform_file`,`t_inform`.`inform_state` AS `inform_state` from (`t_inform` join `t_admin`) where (`t_inform`.`admin_id` = `t_admin`.`admin_id`) ;

-- ----------------------------
-- View structure for `v_member`
-- ----------------------------
DROP VIEW IF EXISTS `v_member`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_member` AS select `t_member`.`member_id` AS `member_id`,`t_member`.`user_id` AS `user_id`,`t_member`.`member_name` AS `member_name`,`t_member`.`member_sex` AS `member_sex`,`t_member`.`member_grade` AS `member_grade`,`t_major`.`major_dept` AS `major_dept`,`t_major`.`major_name` AS `major_name`,`t_member`.`member_class` AS `member_class`,`t_association`.`ass_name` AS `ass_name`,`t_member`.`member_wechat` AS `member_wechat`,`t_member`.`member_qq` AS `member_qq`,`t_member`.`member_email` AS `member_email`,`t_member`.`member_phone` AS `member_phone`,`t_member`.`member_idcard` AS `member_idcard`,`t_member`.`member_address` AS `member_address`,`t_member`.`member_from` AS `member_from`,`t_member`.`member_note` AS `member_note` from ((`t_member` join `t_major`) join `t_association`) where ((`t_member`.`major_id` = `t_major`.`major_id`) and (`t_member`.`ass_id` = `t_association`.`ass_id`)) ;
