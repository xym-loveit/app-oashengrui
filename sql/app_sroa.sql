/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : app_sroa

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2012-08-07 20:00:32
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `app_admin_attendance`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_attendance`;
CREATE TABLE `app_admin_attendance` (
  `attend_id` bigint(20) NOT NULL auto_increment COMMENT '考勤ID',
  `work_date` date NOT NULL COMMENT '工作日期',
  `work_time` varchar(64) NOT NULL COMMENT '工作时间',
  `offtime_shour` varchar(11) default NULL COMMENT '实际下班时间 - 打卡小时 (上)',
  `offtime_ehour` varchar(11) default NULL COMMENT '实际下班时间 - 打卡分钟 (上)',
  `offtime_smin` varchar(11) default NULL COMMENT '实际下班时间 - 打卡小时 (下)',
  `offtime_emin` varchar(11) default NULL COMMENT '实际下班时间 - 打卡分钟 (下)',
  `staff_id` bigint(20) NOT NULL COMMENT '员工ID',
  `staff_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `work_type` tinyint(4) NOT NULL COMMENT '上班类型, 1=正常上班,2=调休加班, 3=带薪加班, 4=倍薪加班',
  `work_status` tinyint(4) NOT NULL COMMENT '上班状态， 0=在岗, 1=出差, 2=请假',
  `leave_type` char(1) default NULL COMMENT '请假类型',
  `staff_behalf_name` varchar(64) default NULL COMMENT '代班员工姓名',
  `staff_behalf_id` bigint(20) default NULL COMMENT '代班员工ID',
  `meto` varchar(250) default NULL COMMENT '说明 (请假说明, 旷工说明)',
  `attendance_result` char(1) DEFAULT NULL COMMENT '考勤结果,1:按时,2:迟到,3:早退,4:迟到早退',
  `exception`  char(1) DEFAULT NULL COMMENT '数据是否异常,0:正常,1:异常',
  PRIMARY KEY  (`attend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-员工考勤';

-- ----------------------------
-- Records of app_admin_attendance
-- ----------------------------

-- ----------------------------
-- Table structure for `app_admin_conference`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_conference`;
CREATE TABLE `app_admin_conference` (
  `conference_id` bigint(20) NOT NULL auto_increment,
  `conference_name` varchar(45) default NULL,
  `conference_level` varchar(45) default NULL,
  `district_id` bigint(20) default NULL,
  `depart_id` bigint(20) default NULL,
  `address` varchar(45) default NULL,
  `start_day` date default NULL,
  `start_hour` varchar(45) default NULL,
  `start_minute` varchar(45) default NULL,
  `end_day` date default NULL,
  `end_hour` varchar(45) default NULL,
  `end_minute` varchar(45) default NULL,
  `attendances` text,
  `count` int(11) default NULL,
  `contactor` varchar(45) default NULL,
  `phone` varchar(45) default NULL,
  `content` text,
  `status` char(1) default NULL COMMENT '1:已发起,2:已结束,3:已取消',
  `sponsor` bigint(20) default NULL COMMENT '发起者',
  `summary` text,
  `conference_type` bigint(20) default NULL,
  `attendances_ids` varchar(200) default NULL COMMENT '参会人员ID',
  PRIMARY KEY  (`conference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='会议表';

-- ----------------------------
-- Records of app_admin_conference
-- ----------------------------
INSERT INTO `app_admin_conference` VALUES ('1', 'meeting3', '公司级别会议', '1', '15', '123', '2012-08-02', '08', '00', '2012-08-09', '08', '00', '管理员,刘苗芳,程聪', '3', '', '', '', '1', '1', null, '9', '1,24,29');
INSERT INTO `app_admin_conference` VALUES ('2', 'meeting7', '公司级别会议', '3', '18', '地址', '2012-08-04', '08', '00', '2012-08-07', '10', '00', '管理员,罗佳驹,刘苗芳,梅杰,程聪', '6', '12312fadf', '123123fadf', 'afdd', '2', '1', 'summary', '9', '1,19,24,20,29');
INSERT INTO `app_admin_conference` VALUES ('3', 'meeting8', '公司级别会议', '1', '15', '121323', '2012-08-03', '08', '00', '2012-08-03', '15', '00', '管理员,罗佳驹,梅杰', '3', '', '', '', '2', '1', '我的总结', '9', '1,19,20');

-- ----------------------------
-- Table structure for `app_admin_doc`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_doc`;
CREATE TABLE `app_admin_doc` (
  `doc_id` bigint(20) NOT NULL auto_increment COMMENT '文档ID',
  `type_dicid` bigint(20) NOT NULL COMMENT '文档类型ID (来自系统字典)',
  `doc_name` varchar(150) NOT NULL COMMENT '文档名称',
  `doc_level_id` int(5) NOT NULL default '0' COMMENT '文档级别',
  `doc_VisiableRange_id` int(5) NOT NULL default '0' COMMENT '文档范围',
  `doc_userNames` varchar(250) default NULL COMMENT '文档可见人姓名集合, 多用户姓名之间用,连接, 主要方便于数据库查询',
  `doc_userIds` varchar(150) default NULL COMMENT '文档可见用户ID集合, 主要方便数据库查询',
  `doc_postDistrictId` bigint(20) NOT NULL COMMENT '文档上传校区',
  `doc_postDepId` bigint(20) NOT NULL COMMENT '文档上传部门',
  `author_id` bigint(20) NOT NULL default '0' COMMENT '上传用户',
  `create_time` datetime NOT NULL COMMENT '上传时间',
  `file_id` bigint(20) default NULL COMMENT '附件id',
  PRIMARY KEY  (`doc_id`),
  KEY `PK_range` (`doc_VisiableRange_id`),
  KEY `PK_level` (`doc_level_id`),
  KEY `PK_district` (`doc_postDistrictId`),
  KEY `PK_department` (`doc_postDepId`),
  KEY `PK_author` (`author_id`),
  KEY `PK_dcoType` (`type_dicid`),
  KEY `PK_file` (`file_id`),
  CONSTRAINT `PK_author` FOREIGN KEY (`author_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `PK_dcoType` FOREIGN KEY (`type_dicid`) REFERENCES `app_system_dictionary` (`id`),
  CONSTRAINT `PK_department` FOREIGN KEY (`doc_postDepId`) REFERENCES `app_school_department` (`dep_id`),
  CONSTRAINT `PK_district` FOREIGN KEY (`doc_postDistrictId`) REFERENCES `app_school_district` (`district_id`),
  CONSTRAINT `PK_file` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`),
  CONSTRAINT `PK_level` FOREIGN KEY (`doc_level_id`) REFERENCES `app_admin_doc_level` (`id`),
  CONSTRAINT `PK_range` FOREIGN KEY (`doc_VisiableRange_id`) REFERENCES `app_admin_doc_visiable_range` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-文档';

-- ----------------------------
-- Records of app_admin_doc
-- ----------------------------

-- ----------------------------
-- Table structure for `app_admin_doc_level`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_doc_level`;
CREATE TABLE `app_admin_doc_level` (
  `id` int(5) NOT NULL auto_increment COMMENT '编号',
  `level_name` varchar(100) default NULL COMMENT '文档级别名称',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='文档级别';

-- ----------------------------
-- Records of app_admin_doc_level
-- ----------------------------
INSERT INTO `app_admin_doc_level` VALUES ('1', '公司级别');
INSERT INTO `app_admin_doc_level` VALUES ('2', '校区级别');
INSERT INTO `app_admin_doc_level` VALUES ('3', '校区部门级别');
INSERT INTO `app_admin_doc_level` VALUES ('4', '总部对口部门级别');

-- ----------------------------
-- Table structure for `app_admin_doc_visiable_range`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_doc_visiable_range`;
CREATE TABLE `app_admin_doc_visiable_range` (
  `id` int(5) NOT NULL auto_increment,
  `visiable_name` varchar(100) default NULL COMMENT '文档范围名称',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='文档范围';

-- ----------------------------
-- Records of app_admin_doc_visiable_range
-- ----------------------------
INSERT INTO `app_admin_doc_visiable_range` VALUES ('1', '所有校区');
INSERT INTO `app_admin_doc_visiable_range` VALUES ('2', '设置个人可见');
INSERT INTO `app_admin_doc_visiable_range` VALUES ('3', '杭州总部');
INSERT INTO `app_admin_doc_visiable_range` VALUES ('4', '萧山校区');

-- ----------------------------
-- Table structure for `app_admin_news`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_news`;
CREATE TABLE `app_admin_news` (
  `news_id` bigint(20) NOT NULL auto_increment,
  `type_dicid` bigint(20) NOT NULL COMMENT '新闻类型id (来自系统字典)',
  `news_subject` varchar(128) NOT NULL COMMENT '新闻标题',
  `news_content` text NOT NULL COMMENT '新闻内容',
  `author_id` bigint(20) NOT NULL COMMENT '新闻作者ID',
  `author_name` varchar(120) NOT NULL COMMENT '新闻作者名',
  `news_level` tinyint(4) NOT NULL COMMENT '新闻级别, 0=公司新闻, 1=校区新闻',
  `district_visible` bigint(20) default NULL COMMENT '可见校区',
  `district_post` bigint(20) NOT NULL COMMENT '发布校区',
  `dep_post` bigint(20) NOT NULL COMMENT '发布部门',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime default NULL COMMENT '最后更新时间',
  `top_index` int(11) default NULL COMMENT '置顶序号',
  `status` smallint(6) NOT NULL COMMENT '0=草稿, 1=已发布并待审核, 2=审核通过, 3=审批退回',
  PRIMARY KEY  (`news_id`),
  KEY `type_id` (`type_dicid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻';

-- ----------------------------
-- Records of app_admin_news
-- ----------------------------
INSERT INTO `app_admin_news` VALUES ('1', '3', 'news1', 'news1<br />', '1', 'admin', '0', null, '1', '15', '2012-07-31 11:27:46', '2012-07-31 11:27:46', '0', '1');
INSERT INTO `app_admin_news` VALUES ('3', '3', 'news2', '我的新闻_ 你好啊<br />', '19', '00001001', '0', null, '1', '15', '2012-07-31 14:21:21', '2012-08-03 14:09:08', '0', '1');

-- ----------------------------
-- Table structure for `app_admin_news_file`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_news_file`;
CREATE TABLE `app_admin_news_file` (
  `news_id` bigint(20) NOT NULL COMMENT '新闻ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`news_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻文件关联表';

-- ----------------------------
-- Records of app_admin_news_file
-- ----------------------------

-- ----------------------------
-- Table structure for `app_admin_task`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_task`;
CREATE TABLE `app_admin_task` (
  `task_id` bigint(20) NOT NULL auto_increment,
  `type_dicid` bigint(20) NOT NULL COMMENT '任务类型Id (来自系统字典)',
  `task_name` varchar(120) NOT NULL COMMENT '任务名称',
  `task_originator` bigint(20) NOT NULL COMMENT '任务发起人',
  `task_charger` bigint(20) NOT NULL COMMENT '任务负责人',
  `task_charger_depid` bigint(20) default NULL COMMENT '任务负责人所属部门ID',
  `task_charger_disid` bigint(20) default NULL COMMENT '任务负责人所属校区ID',
  `task_planStartDate` date NOT NULL COMMENT '任务计划开始时间',
  `task_planEndDate` date NOT NULL COMMENT '任务计划终止时间',
  `task_actualFinishDate` date default NULL COMMENT '任务实际完成时间',
  `task_desc` text COMMENT '任务描述',
  `task_participant_ids` varchar(120) default NULL COMMENT '任务参与人ID列表',
  `task_participant_names` varchar(250) default NULL COMMENT '任务参与人名称列表',
  `task_status` tinyint(4) default NULL COMMENT '任务状态',
  `approval_status` tinyint(4) default NULL COMMENT '审批状态',
  `create_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY  (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托';

-- ----------------------------
-- Records of app_admin_task
-- ----------------------------
INSERT INTO `app_admin_task` VALUES ('4', '7', 'task1', '36', '27', null, null, '2012-07-31', '2012-08-07', null, 'hi', null, null, '2', '2', '2012-07-31 21:39:58');
INSERT INTO `app_admin_task` VALUES ('5', '7', 'task2', '36', '27', null, null, '2012-07-29', '2012-08-02', '2012-08-03', '', null, null, '3', '4', '2012-08-01 11:20:20');
INSERT INTO `app_admin_task` VALUES ('6', '7', 'task', '19', '19', null, null, '2012-08-02', '2012-08-15', '2012-08-04', 'test21312', null, null, '3', null, '2012-08-02 17:00:00');
INSERT INTO `app_admin_task` VALUES ('7', '7', 'task2', '20', '19', null, null, '2012-08-01', '2012-08-04', null, 'test', null, null, '4', null, '2012-08-02 17:02:08');
INSERT INTO `app_admin_task` VALUES ('8', '8', 'task5', '19', '22', null, null, '2012-08-01', '2012-08-03', null, 'testfadfadf', null, null, null, '4', '2012-08-02 21:40:48');
INSERT INTO `app_admin_task` VALUES ('10', '7', 'task7', '19', '19', null, null, '2012-08-02', '2012-08-11', null, '12312fadffafds', null, null, '5', '2', '2012-08-02 23:14:02');

-- ----------------------------
-- Table structure for `app_admin_task_file`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_task_file`;
CREATE TABLE `app_admin_task_file` (
  `task_id` bigint(20) NOT NULL COMMENT '任务ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`task_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托文件关联表';

-- ----------------------------
-- Records of app_admin_task_file
-- ----------------------------
INSERT INTO `app_admin_task_file` VALUES ('6', '45');
INSERT INTO `app_admin_task_file` VALUES ('7', '35');
INSERT INTO `app_admin_task_file` VALUES ('8', '44');
INSERT INTO `app_admin_task_file` VALUES ('10', '46');

-- ----------------------------
-- Table structure for `app_admin_task_participants`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_task_participants`;
CREATE TABLE `app_admin_task_participants` (
  `task_id` bigint(20) NOT NULL,
  `emp_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`task_id`,`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务参与人';

-- ----------------------------
-- Records of app_admin_task_participants
-- ----------------------------
INSERT INTO `app_admin_task_participants` VALUES ('3', '7');
INSERT INTO `app_admin_task_participants` VALUES ('3', '14');
INSERT INTO `app_admin_task_participants` VALUES ('4', '19');
INSERT INTO `app_admin_task_participants` VALUES ('4', '27');
INSERT INTO `app_admin_task_participants` VALUES ('4', '36');
INSERT INTO `app_admin_task_participants` VALUES ('5', '30');
INSERT INTO `app_admin_task_participants` VALUES ('6', '19');
INSERT INTO `app_admin_task_participants` VALUES ('6', '20');
INSERT INTO `app_admin_task_participants` VALUES ('6', '22');
INSERT INTO `app_admin_task_participants` VALUES ('6', '24');
INSERT INTO `app_admin_task_participants` VALUES ('7', '24');
INSERT INTO `app_admin_task_participants` VALUES ('7', '29');
INSERT INTO `app_admin_task_participants` VALUES ('8', '19');
INSERT INTO `app_admin_task_participants` VALUES ('8', '20');
INSERT INTO `app_admin_task_participants` VALUES ('8', '21');
INSERT INTO `app_admin_task_participants` VALUES ('8', '24');
INSERT INTO `app_admin_task_participants` VALUES ('8', '25');
INSERT INTO `app_admin_task_participants` VALUES ('8', '26');
INSERT INTO `app_admin_task_participants` VALUES ('8', '29');
INSERT INTO `app_admin_task_participants` VALUES ('10', '21');
INSERT INTO `app_admin_task_participants` VALUES ('10', '25');
INSERT INTO `app_admin_task_participants` VALUES ('10', '26');

-- ----------------------------
-- Table structure for `app_admin_task_tracks`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_task_tracks`;
CREATE TABLE `app_admin_task_tracks` (
  `track_id` bigint(20) NOT NULL auto_increment,
  `task_id` bigint(20) NOT NULL COMMENT '任务ID',
  `task_applyTime` date NOT NULL COMMENT '申请时间',
  `task_applyType` tinyint(4) NOT NULL COMMENT '申请类型',
  `task_applyFinalTime` date NOT NULL COMMENT '申请完成时间/延期时间',
  `task_applyMeto` text COMMENT '申请描述',
  `task_auditState` tinyint(4) default NULL COMMENT '审批状态',
  `task_auditFinalTime` date default NULL COMMENT '审批确认完成/延期时间',
  `task_auditMeto` text COMMENT '审批描述',
  `task_auditTime` datetime default NULL COMMENT '审批时间',
  PRIMARY KEY  (`track_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='任务委托审批记录';

-- ----------------------------
-- Records of app_admin_task_tracks
-- ----------------------------
INSERT INTO `app_admin_task_tracks` VALUES ('3', '3', '2012-07-26', '1', '2012-07-27', '', '1', '2012-07-26', '', '2012-07-26 14:58:49');
INSERT INTO `app_admin_task_tracks` VALUES ('4', '5', '2012-08-01', '1', '2012-08-02', '', '1', '2012-08-03', 'pass', '2012-08-01 11:25:11');
INSERT INTO `app_admin_task_tracks` VALUES ('5', '4', '2012-08-01', '0', '2012-08-07', '', '1', '2012-08-07', '123', '2012-08-01 11:24:59');
INSERT INTO `app_admin_task_tracks` VALUES ('6', '6', '2012-08-02', '1', '2012-08-03', '我要完成', '1', '2012-08-04', '通过完成', '2012-08-02 23:09:37');
INSERT INTO `app_admin_task_tracks` VALUES ('7', '7', '2012-08-02', '0', '2012-08-10', '我要延期', null, null, null, null);
INSERT INTO `app_admin_task_tracks` VALUES ('8', '10', '2012-08-02', '1', '2012-08-03', '1213231212', '0', '2012-08-10', '交流交流分撒旦', '2012-08-02 23:15:50');
INSERT INTO `app_admin_task_tracks` VALUES ('9', '10', '2012-08-02', '0', '2012-08-17', '123123', null, null, null, null);
INSERT INTO `app_admin_task_tracks` VALUES ('10', '10', '2012-08-03', '1', '2012-08-04', 'fadsf', null, null, null, null);

-- ----------------------------
-- Table structure for `app_admin_workarrange`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_workarrange`;
CREATE TABLE `app_admin_workarrange` (
  `work_id` bigint(20) NOT NULL auto_increment COMMENT '工作ID',
  `work_date` date NOT NULL COMMENT '工作日期',
  `work_time` bigint(20) NOT NULL COMMENT '工作时间',
  `staff_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `staff_id` bigint(20) NOT NULL COMMENT '员工ID',
  `work_type` int(5) default NULL COMMENT '上班类型',
  `work_content` bigint(20) default NULL COMMENT '工作内容',
  `district_id` bigint(20) default NULL COMMENT '员工所在校区',
  `attend_id` bigint(20) default NULL COMMENT '对应的考勤记录',
  PRIMARY KEY  (`work_id`),
  KEY `PK_user` (`staff_id`),
  KEY `PK_type` (`work_type`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='行政管理-工作安排';

-- ----------------------------
-- Records of app_admin_workarrange
-- ----------------------------
INSERT INTO `app_admin_workarrange` VALUES ('1', '2012-08-05', '4', '刘苗芳', '24', '1', '4', '1', '2');
INSERT INTO `app_admin_workarrange` VALUES ('2', '2012-08-05', '4', '梅杰', '20', '1', '4', '1', '3');
INSERT INTO `app_admin_workarrange` VALUES ('3', '2012-08-05', '4', '罗佳驹', '19', '1', '4', '1', '1');
INSERT INTO `app_admin_workarrange` VALUES ('4', '2012-08-05', '4', '程聪', '29', '1', '4', '1', '4');
INSERT INTO `app_admin_workarrange` VALUES ('5', '2012-08-06', '4', '罗佳驹', '19', '1', '5', '1', null);
INSERT INTO `app_admin_workarrange` VALUES ('6', '2012-08-06', '4', '蒋晓萍', '26', '1', '5', '1', null);
INSERT INTO `app_admin_workarrange` VALUES ('7', '2012-08-06', '4', '程聪', '29', '1', '5', '1', '5');
INSERT INTO `app_admin_workarrange` VALUES ('8', '2012-08-06', '4', '刘苗芳', '24', '1', '5', '1', null);
INSERT INTO `app_admin_workarrange` VALUES ('9', '2012-08-06', '4', '周碧英', '25', '1', '5', '1', '6');
INSERT INTO `app_admin_workarrange` VALUES ('10', '2012-08-06', '4', '梅杰', '20', '1', '5', '1', null);
INSERT INTO `app_admin_workarrange` VALUES ('11', '2012-08-06', '4', '林菁菁', '21', '1', '5', '1', null);

-- ----------------------------
-- Table structure for `app_admin_worktype`
-- ----------------------------
DROP TABLE IF EXISTS `app_admin_worktype`;
CREATE TABLE `app_admin_worktype` (
  `id` int(5) NOT NULL auto_increment,
  `type` varchar(50) default NULL COMMENT '工作类型名称',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_admin_worktype
-- ----------------------------
INSERT INTO `app_admin_worktype` VALUES ('1', '正常上班');
INSERT INTO `app_admin_worktype` VALUES ('2', '调休加班');
INSERT INTO `app_admin_worktype` VALUES ('3', '带薪加班');
INSERT INTO `app_admin_worktype` VALUES ('4', '倍薪加班');

-- ----------------------------
-- Table structure for `app_conference_file`
-- ----------------------------
DROP TABLE IF EXISTS `app_conference_file`;
CREATE TABLE `app_conference_file` (
  `conference_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`conference_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会议文件';

-- ----------------------------
-- Records of app_conference_file
-- ----------------------------
INSERT INTO `app_conference_file` VALUES ('2', '47');
INSERT INTO `app_conference_file` VALUES ('2', '48');
INSERT INTO `app_conference_file` VALUES ('2', '49');
INSERT INTO `app_conference_file` VALUES ('3', '50');
INSERT INTO `app_conference_file` VALUES ('3', '51');

-- ----------------------------
-- Table structure for `app_file_attach`
-- ----------------------------
DROP TABLE IF EXISTS `app_file_attach`;
CREATE TABLE `app_file_attach` (
  `file_id` bigint(20) NOT NULL auto_increment,
  `file_name` varchar(128) NOT NULL COMMENT '文件名',
  `file_path` varchar(128) NOT NULL COMMENT '文件路径',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `file_ext` varchar(32) default NULL COMMENT '扩展名',
  `file_type` varchar(32) NOT NULL COMMENT '附件类型            如：邮件附件',
  `note` varchar(1024) default NULL COMMENT '说明',
  `creator` varchar(32) NOT NULL COMMENT '上传者',
  `creator_id` bigint(20) default NULL COMMENT '上传者ID',
  `file_bytes` int(11) NOT NULL COMMENT '文件总大小',
  `del_flag` smallint(6) default '0' COMMENT '1=已删除, 0=未删除',
  PRIMARY KEY  (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='附件';

-- ----------------------------
-- Records of app_file_attach
-- ----------------------------
INSERT INTO `app_file_attach` VALUES ('1', 'app_sroa.sql', 'others/201207/dd9c92d8daaf41aebd15b34ae6c990d1.sql', '2012-07-29 02:29:03', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('2', 'app_sroa.sql', 'others/201207/a7ec5fe0df0f4f498eb09931ae97157f.sql', '2012-07-29 02:31:35', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('3', 'app_sroa.sql', 'others/201207/80133f86d4dd4c36b4164c92eb459e09.sql', '2012-07-29 02:31:51', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('4', 'app_sroa.sql', 'others/201207/6cd5b2fd469344999692c939711f38f4.sql', '2012-07-29 02:32:25', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('5', 'app_sroa.sql', 'others/201207/e9d63b09f20b4c6fb23fecc58886945e.sql', '2012-07-29 02:33:04', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('6', 'app_sroa.sql', 'others/201207/272365e4438047818156c5331fcacb7a.sql', '2012-07-29 02:34:47', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('7', 'app_sroa.sql', 'others/201207/b8651629ff704724a14f4c5bdd24ea76.sql', '2012-07-29 02:38:20', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('8', 'app_sroa.sql', 'others/201207/d27c6b908edb4f3982430a64b0daf464.sql', '2012-07-29 02:38:35', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('9', 'app_sroa_2012-7-19.sql', 'others/201207/dffd3f76c09a4597b1bc3afbb1ee1a05.sql', '2012-07-29 02:39:18', 'sql', 'others', '77.66 KB', 'Unknow', null, '79524', '0');
INSERT INTO `app_file_attach` VALUES ('10', 'app_sroa.sql', 'others/201207/af51d5e1e1254fbe861413ccacd0ba2e.sql', '2012-07-29 02:39:29', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('11', 'app_sroa.sql', 'others/201207/1bae96881dda463bb4ffe7f2050a08c2.sql', '2012-07-29 02:39:44', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('12', 'app_sroa_2012-7-19.sql', 'others/201207/43b14965662f438894239653359a4adc.sql', '2012-07-29 02:40:47', 'sql', 'others', '77.66 KB', 'Unknow', null, '79524', '0');
INSERT INTO `app_file_attach` VALUES ('13', 'app_sroa.sql', 'others/201207/3cbb7bb7b6ce4558a87d7b7e1d32e3e1.sql', '2012-07-29 02:41:14', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('14', 'app_sroa.sql', 'others/201207/5f1791e1d41748bba4c6df4f6a858c73.sql', '2012-07-29 02:41:39', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('15', 'app_sroa.sql', 'others/201207/502ed14518324c88a9a1c63c0271cdb2.sql', '2012-07-29 02:43:14', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('16', 'app_sroa_2012-7-19.sql', 'others/201207/86e8e70ba0c046a2b6a52165889629f1.sql', '2012-07-29 02:44:10', 'sql', 'others', '77.66 KB', 'Unknow', null, '79524', '0');
INSERT INTO `app_file_attach` VALUES ('17', 'app_sroa.sql', 'others/201207/e1edbcb9249944c98457821506bf8f92.sql', '2012-07-29 02:44:35', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('18', 'app_sroa.sql', 'others/201207/db2609b048c94d2e8decb73d39208834.sql', '2012-07-29 02:45:00', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('19', 'app_sroa.sql', 'others/201207/1cf6dc98a082454c99470f18e982fcb5.sql', '2012-07-29 02:47:10', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('20', 'app_sroa.sql', 'others/201207/93e821e68bbc46f7b7d8268cb1f0525a.sql', '2012-07-29 02:47:19', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('21', 'app_sroa.sql', 'others/201207/203e56a40d3f494fa80faaea53a39ef0.sql', '2012-07-29 02:47:59', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('22', 'app_sroa.sql', 'others/201207/0d04862981f047cba25b59f8a6d0701f.sql', '2012-07-29 02:48:44', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('23', 'app_sroa.sql', 'others/201207/a8aa5bb5e8ac4c8e805e22d2d78717f2.sql', '2012-07-29 02:50:02', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('24', 'app_sroa.sql', 'others/201207/4795f58efa8f4110b875200bba1fc22a.sql', '2012-07-29 02:56:49', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('25', 'app_sroa.sql', 'others/201207/390d031db6524f5fa3ffbc2398817d20.sql', '2012-07-29 02:57:04', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('26', 'app_sroa.sql', 'others/201207/987e31d6526c45848e589286830c7f55.sql', '2012-07-29 02:57:40', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('27', 'app_sroa.sql', 'others/201207/368214185a1d4ca3b26085ed316c2602.sql', '2012-07-29 02:57:59', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('28', 'app_sroa_2012-7-19.sql', 'others/201207/68493572b869426eaeb7adc38b6b9a36.sql', '2012-07-29 02:58:10', 'sql', 'others', '77.66 KB', 'Unknow', null, '79524', '0');
INSERT INTO `app_file_attach` VALUES ('29', 'app_sroa.sql', 'others/201207/d2bc890776344d6083cd2fc5e1f6263b.sql', '2012-07-29 02:59:51', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('30', 'app_sroa.sql', 'others/201207/832bfc53a3f2452d9776e17d01d7ebee.sql', '2012-07-29 03:00:00', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('31', 'app_sroa_2012-7-19.sql', 'others/201207/f855d90364b54aee82ad0eff7e5a16e1.sql', '2012-07-29 03:00:45', 'sql', 'others', '77.66 KB', 'Unknow', null, '79524', '0');
INSERT INTO `app_file_attach` VALUES ('32', 'app_sroa.sql', 'others/201207/3b0fa07934884d7e963be64713ad0f62.sql', '2012-07-29 03:01:32', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('33', 'app_sroa.sql', 'others/201207/b8adf07d0fc64d099825d9061c6afbcd.sql', '2012-07-29 03:02:36', 'sql', 'others', '93.60 KB', 'Unknow', null, '95846', '0');
INSERT INTO `app_file_attach` VALUES ('34', '123.txt', 'others/201208/929c9d8ba8844a789d8aa7f6a3ccb7cd.txt', '2012-08-02 16:59:21', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('35', '123.txt', 'others/201208/a6398d78353f4f7b90589f9a962dcdc0.txt', '2012-08-02 17:02:05', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('36', '123.txt', 'others/201208/a73fb601202f40b4b6d5870a90bc869b.txt', '2012-08-02 20:25:36', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('37', '123.txt', 'others/201208/3c54b843ba9b49a1b58a3cc6ef3e2623.txt', '2012-08-02 20:57:18', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('38', '123.txt', 'others/201208/200ba3e3bfd04ef8ba33c1f717e8676d.txt', '2012-08-02 21:16:38', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('39', '123.txt', 'others/201208/a7ae11c9c24547b5b89f2df31c2e4bbb.txt', '2012-08-02 21:25:34', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('40', '123.txt', 'others/201208/5fa38a9305ce49e88d1a0bd8d3b05265.txt', '2012-08-02 21:26:29', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('41', '123.txt', 'others/201208/ce233a6058a94d9d99d8cae0930c39ca.txt', '2012-08-02 21:28:37', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('42', '123.txt', 'others/201208/e3d22090b10f4483abade6dfdf70748e.txt', '2012-08-02 21:30:13', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('43', '123.txt', 'others/201208/7db2628c0a6e4364b15a34c8728df503.txt', '2012-08-02 21:35:28', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('44', '123.txt', 'others/201208/b5e907f82055439b91e6f0c6409d4a36.txt', '2012-08-02 21:36:15', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('45', '123.txt', 'others/201208/c259594446084f74b320b7073d9d8102.txt', '2012-08-02 22:28:11', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('46', '123.txt', 'others/201208/6e88fc8c2fa0438dbf391bd6b76d05eb.txt', '2012-08-03 08:41:15', 'txt', 'others', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('47', '123.txt', 'others/201208/e66347f1e8914aaa858c99779c6fbfc9.txt', '2012-08-03 09:14:46', 'txt', 'conference_process', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('48', 'HrmEmployeeImportAction.java', 'others/201208/8bae8d21518f41cca2d6628d88f2e830.java', '2012-08-03 09:14:56', 'java', 'conference_attach', '1.58 KB', 'Unknow', null, '1622', '0');
INSERT INTO `app_file_attach` VALUES ('49', '123.txt', 'others/201208/625f7a1fd2c54ffea994b1494ba00acc.txt', '2012-08-03 10:26:11', 'txt', 'conference_summary', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('50', '123.txt', 'others/201208/07181a623b7a44819081e5bfe1d73278.txt', '2012-08-03 10:27:00', 'txt', 'conference_summary', '18.0 bytes', 'Unknow', null, '18', '0');
INSERT INTO `app_file_attach` VALUES ('51', 'HrmEmployeeImportAction.java', 'others/201208/beecf12ccb614c7faabdd9532d0c1be7.java', '2012-08-03 10:27:08', 'java', 'conference_summary', '1.58 KB', 'Unknow', null, '1622', '0');

-- ----------------------------
-- Table structure for `app_finan_contract`
-- ----------------------------
DROP TABLE IF EXISTS `app_finan_contract`;
CREATE TABLE `app_finan_contract` (
  `contract_id` bigint(20) NOT NULL auto_increment,
  `apply_form_no` varchar(120) NOT NULL COMMENT '申请单号',
  `apply_form_type` bigint(20) NOT NULL COMMENT '合同申请类型',
  `emp_id` bigint(20) NOT NULL COMMENT '经办人 (申请人)',
  `emp_district` bigint(20) NOT NULL COMMENT '员工所属校区',
  `emp_dep` bigint(20) NOT NULL COMMENT '员工所属部门',
  `emp_phone_no` varchar(24) NOT NULL COMMENT '员工联系电话',
  `apply_date` date NOT NULL COMMENT '申请时间',
  `comments` text COMMENT '合同事项说明',
  `apply_amt` double NOT NULL COMMENT '合同总金额',
  `contract_no` varchar(120) default NULL COMMENT '合同编号',
  `contract_parties` varchar(120) default NULL COMMENT '合同签约方',
  `contract_parties_contact` varchar(120) default NULL COMMENT '合同签约方联系方式',
  `pay_method` varchar(150) default NULL COMMENT '付款方式',
  `audit_state` tinyint(4) default NULL COMMENT '审核状态, 1=审核中, 2=审核通过 3=审核不通过, 4=审核被退回...',
  `entry_id` bigint(20) NOT NULL COMMENT '录入人员',
  `entry_datetime` datetime NOT NULL COMMENT '录入时间',
  PRIMARY KEY  (`contract_id`),
  KEY `apply_form_no` (`apply_form_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='合同申请';

-- ----------------------------
-- Records of app_finan_contract
-- ----------------------------
INSERT INTO `app_finan_contract` VALUES ('3', 'FC20120803161623', '8', '19', '1', '15', '13575747066', '2012-08-03', '', '2000', '', '123', '12131232132', '', '2', '1', '2012-08-03 16:16:23');

-- ----------------------------
-- Table structure for `app_finan_expense`
-- ----------------------------
DROP TABLE IF EXISTS `app_finan_expense`;
CREATE TABLE `app_finan_expense` (
  `expense_id` bigint(20) NOT NULL auto_increment,
  `apply_form_no` varchar(120) default NULL COMMENT '人资审批流程',
  `apply_form_type` bigint(20) default NULL,
  `apply_date` date default NULL,
  `comments` longtext,
  `emp_id` bigint(20) default NULL COMMENT '员工ID',
  `emp_district` bigint(20) default NULL,
  `emp_dep` bigint(20) default NULL,
  `emp_phone_no` varchar(120) default NULL,
  `apply_amt` double default NULL,
  `payer` bigint(20) default NULL,
  `contract_no` varchar(120) default NULL,
  `attach_count` varchar(120) default NULL,
  `audit_advance` bigint(20) default NULL,
  `asset_no` varchar(120) default NULL,
  `amt_receiver` varchar(120) default NULL,
  `amt_receiver_contact` varchar(120) default NULL,
  `pay_method` bigint(20) default NULL,
  `bank` varchar(120) default NULL,
  `account_name` varchar(120) default NULL,
  `account_no` varchar(120) default NULL,
  `status` char(1) default NULL,
  `audit_state` bigint(20) default NULL COMMENT '审核状态, 1=审核中, 2=审核通过 3=审核不通过, 4=审核被退回...',
  `entry_id` bigint(20) default NULL,
  `entry_datetime` datetime default NULL,
  PRIMARY KEY  (`expense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_finan_expense
-- ----------------------------

-- ----------------------------
-- Table structure for `app_function`
-- ----------------------------
DROP TABLE IF EXISTS `app_function`;
CREATE TABLE `app_function` (
  `func_id` int(11) NOT NULL auto_increment,
  `func_key` varchar(60) NOT NULL COMMENT '功能key',
  `func_name` varchar(120) NOT NULL COMMENT '功能名称',
  `func_icon` varchar(32) default NULL COMMENT '功能显示图片',
  `func_desc` varchar(150) default NULL COMMENT '功能描述',
  `menu_id` bigint(20) NOT NULL COMMENT '所属菜单',
  `strategy_ids` varchar(120) default NULL COMMENT '功能数据权限ID集合',
  PRIMARY KEY  (`func_id`),
  UNIQUE KEY `func_key` (`func_key`),
  KEY `menu_id` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 COMMENT='功能表';

-- ----------------------------
-- Records of app_function
-- ----------------------------
INSERT INTO `app_function` VALUES ('5', '_FUNCKEY_HRM_JOBHIRE_JOB_VIEW', '岗位管理-岗位查看', '', '查看岗位详细信息..', '48', null);
INSERT INTO `app_function` VALUES ('6', '_FUNCKEY_HRM_JOBHIRE_JOB_POST', '岗位管理-岗位发布', '', '需先具备`岗位查看`的权限, 才能进行岗位发布操作.', '48', null);
INSERT INTO `app_function` VALUES ('7', '_FUNCKEY_HRM_JOBHIRE_JOB_EDIT', '岗位管理-岗位编辑', '', '需先具备`岗位查看`的权限, 才能进行岗位编辑操作.', '48', null);
INSERT INTO `app_function` VALUES ('8', '_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL', '岗位管理-应聘控制', '', '应聘控制包含, `应聘开启`和`应聘关闭`操作.', '48', null);
INSERT INTO `app_function` VALUES ('9', '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY', '入职安排-页面查看', '', '对通过面试的人员进行入职安排操作.', '48', null);
INSERT INTO `app_function` VALUES ('10', '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW', '入职安排-简历查看', '', '入职安排页面中查看应聘者简历信息.', '48', null);
INSERT INTO `app_function` VALUES ('11', '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW', '入职安排-面试查看', '', '入职安排页面中查看应聘者面试记录信息.', '48', null);
INSERT INTO `app_function` VALUES ('12', '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE', '入职安排-入职安排', '', '主要是对入职校区、部门、时间等信息的安排.', '48', null);
INSERT INTO `app_function` VALUES ('13', '_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL', '岗位管理-岗位审批', '', '对发布的岗位进行审批操作.', '48', null);
INSERT INTO `app_function` VALUES ('14', '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER', '招聘安排-页面查看', '', '主要对应聘者进行面试安排等操作.', '48', null);
INSERT INTO `app_function` VALUES ('15', '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW', '招聘安排-简历查看', '', '招聘安排页面中查看应聘者简历信息.', '48', null);
INSERT INTO `app_function` VALUES ('16', '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW', '招聘安排-面试查看', '', '招聘安排页面中查看应聘者面试记录信息.', '48', null);
INSERT INTO `app_function` VALUES ('17', '_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE', '招聘安排-员工录用', '', '面试过后, 进行员工录用状态转换操作.', '48', null);
INSERT INTO `app_function` VALUES ('18', '_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE', '招聘安排-员工淘汰', '', '面试过后, 进行员工淘汰状态转换操作.', '48', null);
INSERT INTO `app_function` VALUES ('19', '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE', '招聘安排-员工未到', '', '面试过后, 进行员工淘汰状态转换操作.', '48', null);
INSERT INTO `app_function` VALUES ('20', '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE', '招聘安排-招聘安排', '', '应聘者面试安排操作', '48', null);
INSERT INTO `app_function` VALUES ('21', '_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW', '查看简历信息', '', '查看人才简历信息', '49', null);
INSERT INTO `app_function` VALUES ('22', '_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE', '删除简历信息', '', '删除人才库中的简历信息', '49', null);
INSERT INTO `app_function` VALUES ('23', '_FUNCKEY_HRM_ENTRY_OP_ONBOARD', '入职处理', '', '对入职安排中的应聘者进行入职安排操作.', '50', null);
INSERT INTO `app_function` VALUES ('24', '_FUNCKEY_HRM_ENTRY_OP_ABSENCE', '未到处理', '', '对入职安排中的应聘者进行未到安排操作.', '50', null);
INSERT INTO `app_function` VALUES ('25', '_FUNCKEY_HRM_ENTRY_OP_QUALIFY', '考察处理', '', '对入职安排中的应聘者进行考察通过、考察未通过处理.', '50', null);
INSERT INTO `app_function` VALUES ('26', '_FUNCKEY_HRM_EMPLOYEE_ADD', '员工数据添加', '', '添加单个新员工数据', '51', null);
INSERT INTO `app_function` VALUES ('27', '_FUNCKEY_HRM_EMPLOYEE_REMOVE', '员工数据删除', '', '员工数据删除', '51', null);
INSERT INTO `app_function` VALUES ('28', '_FUNCKEY_HRM_EMPLOYEE_VIEW', '员工数据查看', '', '员工数据信息查看, 包括简历信息以及晟睿旅程信息.', '51', null);
INSERT INTO `app_function` VALUES ('29', '_FUNCKEY_HRM_EMPLOYEE_UPDATE', '员工数据更新', '', '员工数据更新, 包括员工简历信息更新以及员工晟睿旅程信息的更新.', '51', null);
INSERT INTO `app_function` VALUES ('30', '_FUNCKEY_HRM_DEVELOP_FINALIZE', '审批状态操作', '', '主要是针对员工, 转正、晋升、离职、调动等状态转换操作.', '47', null);
INSERT INTO `app_function` VALUES ('31', '_FUNCKEY_HRM_DEVELOP_VIEWDATA', '审批数据加载', '', '加载\"审批中\"与\"已审批\"Tab的人力发展数据.', '47', null);
INSERT INTO `app_function` VALUES ('32', '_FUNCKEY_FINAN_EXPENSE_APPLY', '费用支出申请', '', '填写费用支出申请单并提交审核.', '7', null);
INSERT INTO `app_function` VALUES ('33', '_FUNCKEY_FINAN_EXPENSE_VIEW', '费用支出查看', '', '查看提交的费用支出申请单数据.', '7', null);
INSERT INTO `app_function` VALUES ('34', '_FUNCKEY_FINAN_EXPENSE_APPROVE', '费用支出审核', '', '审核提交上来的费用支出', '7', null);
INSERT INTO `app_function` VALUES ('35', '_FUNCKEY_FINAN_CONTRACT_APPLY', '合同申请提交', '', '填写合同申请单并提交审核', '30', null);
INSERT INTO `app_function` VALUES ('36', '_FUNCKEY_FINAN_CONTRACT_VIEW', '合同申请查看', '', '查看合同申请单数据', '30', null);
INSERT INTO `app_function` VALUES ('37', '_FUNCKEY_FINAN_CONTRACT_APPROVE', '合同申请审核', '', '审核提交上来的费用支出', '30', null);
INSERT INTO `app_function` VALUES ('38', '_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW', '审批记录查看', '', '查看费用审批记录数据.', '28', null);
INSERT INTO `app_function` VALUES ('39', '_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW', '审批记录查看', '', '查看费用审批记录数据.', '31', null);
INSERT INTO `app_function` VALUES ('40', '_FUNCKEY_SYSTEM_MENU_ADD', '菜单项添加', '', '添加新的菜单项...', '16', null);
INSERT INTO `app_function` VALUES ('41', '_FUNCKEY_SYSTEM_MENU_EDIT', '菜单项编辑', '', '编辑菜单项', '16', null);
INSERT INTO `app_function` VALUES ('42', '_FUNCKEY_SYSTEM_MENU_REFRESH', '菜单项刷新', '', '刷新左侧菜单项树状结构.', '16', null);
INSERT INTO `app_function` VALUES ('43', '_FUNCKEY_SYSTEM_MENU_FUNC_ADD', '功能项添加', '', '添加菜单对应的功能项.', '16', null);
INSERT INTO `app_function` VALUES ('44', '_FUNCKEY_SYSTEM_MENU_FUNC_EDIT', '功能项编辑', '', '编辑菜单对应的功能项.', '16', null);
INSERT INTO `app_function` VALUES ('45', '_FUNCKEY_SYSTEM_MENU_FUNC_REFRESH', '功能项刷新', '', '刷新选中菜单拥有的功能项.', '16', null);
INSERT INTO `app_function` VALUES ('46', '_FUNCKEY_SYSTEM_MENU_FUNC_REMOVE', '功能项删除', '', '删除菜单某功能项', '16', null);
INSERT INTO `app_function` VALUES ('47', '_FUNCKEY_SYSTEM_ROLE_VIEW', '权限组查看', '', '查看权限组详细信息', '15', null);
INSERT INTO `app_function` VALUES ('48', '_FUNCKEY_SYSTEM_ROLE_ADD', '权限组添加', '', '添加新的权限组', '15', null);
INSERT INTO `app_function` VALUES ('49', '_FUNCKEY_SYSTEM_ROLE_EDIT', '权限组编辑', '', '编辑权限组信息.', '15', null);
INSERT INTO `app_function` VALUES ('50', '_FUNCKEY_SYSTEM_ROLE_REMOVE', '权限组删除', '', '删除权限组', '15', null);
INSERT INTO `app_function` VALUES ('51', '_FUNCKEY_FLOW_HRM_TYPE_REFRESH', '审批类型刷新', '', '刷新左侧人资审批类型树状结构', '20', null);
INSERT INTO `app_function` VALUES ('52', '_FUNCKEY_FLOW_HRM_PROCESS_REFRESH', '审批流程刷新', '', '根据审批类型刷新审批流程数据', '20', null);
INSERT INTO `app_function` VALUES ('53', '_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE', '审批流程配置', '', '人资审批流程配置, 包括流程数据加载、节点添加及删除等操作.', '20', null);
INSERT INTO `app_function` VALUES ('54', '_FUNCKEY_FLOW_HRM_PROCESS_REMOVE', '审批流程删除', '', '审批流程删除.. (链接待完善...)', '20', null);
INSERT INTO `app_function` VALUES ('55', '_FUNCKEY_FLOW_FINAN_TYPE_REFRESH', '审批类型刷新', '', '财务审批类型刷新,主要体现在左侧的树状结构.', '21', null);
INSERT INTO `app_function` VALUES ('56', '_FUNCKEY_FLOW_FINAN_PROC_TYPE_REFRESH', '申请类别刷新', '', '根据审批类型获取申请类别数据.', '21', null);
INSERT INTO `app_function` VALUES ('57', '_FUNCKEY_FLOW_FINAN_PROC_TYPE_ADD', '申请类别添加', '', '添加申请类别', '21', null);
INSERT INTO `app_function` VALUES ('58', '_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT', '申请类别编辑', '', '编辑申请类别.', '21', null);
INSERT INTO `app_function` VALUES ('59', '_FUNCKEY_FLOW_FINAN_PROC_APPROVE', '审批流程配置', '', '对审批申请类型进行流程配置.', '21', null);
INSERT INTO `app_function` VALUES ('60', '_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_ADD', '校区添加', '', '添加新校区.', '22', null);
INSERT INTO `app_function` VALUES ('61', '_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_EDIT', '校区编辑', '', '校区数据编辑.', '22', null);
INSERT INTO `app_function` VALUES ('62', '_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_REMOVE', '校区删除', '', '校区数据删除.', '22', null);
INSERT INTO `app_function` VALUES ('63', '_FUNCKEY_SYSTEM_SCHOOL_POSET_ADD', '职位添加', '', '添加新职位信息.', '24', null);
INSERT INTO `app_function` VALUES ('64', '_FUNCKEY_SYSTEM_SCHOOL_POSET_REMOVE', '职位删除', '', '删除职位信息.', '24', null);
INSERT INTO `app_function` VALUES ('65', '_FUNCKEY_SYSTEM_SCHOOL_POSET_EDIT', '职位编辑', '', '编辑职位信息', '24', null);
INSERT INTO `app_function` VALUES ('66', '_FUNCKEY_SYSTEM_SCHOOL_DEP_ADD', '部门添加', '', '新增部门数据', '23', null);
INSERT INTO `app_function` VALUES ('67', '_FUNCKEY_SYSTEM_SCHOOL_DEP_REFRESH', '部门刷新', '', '刷新左侧部门树状结构', '23', null);
INSERT INTO `app_function` VALUES ('68', '_FUNCKEY_SYSTEM_SCHOOL_DEP_REMOVE', '部门删除', '', '删除部门数据.', '23', null);
INSERT INTO `app_function` VALUES ('69', '_FUNCKEY_SYSTEM_SCHOOL_DEP_EDIT', '部门编辑', '', '编辑部门数据.', '23', null);
INSERT INTO `app_function` VALUES ('70', '_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REFRESH', '岗位刷新', '', '根据选择的部门刷新对应的岗位数据.', '23', null);
INSERT INTO `app_function` VALUES ('71', '_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REMOVE', '岗位删除', '', '删除岗位数据', '23', null);
INSERT INTO `app_function` VALUES ('72', '_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_ADD', '岗位添加', '', '添加岗位信息.', '23', null);
INSERT INTO `app_function` VALUES ('73', '_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY', '我的历史应聘', '', '访问我的历史应聘数据', '35', null);
INSERT INTO `app_function` VALUES ('74', '_FUNCKEY_PERSONAL_INTERVIEW_HISTORY', '我的历史面试', '', '访问我的历史面试数据', '36', null);
INSERT INTO `app_function` VALUES ('75', '_FUNCKEY_PERSONAL_INTERVIEW_COMMIT', '提交面试意见', '', '提交面试意见.', '36', null);
INSERT INTO `app_function` VALUES ('76', '_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW', '查看岗位信息', '', '查看岗位详细信息.', '36', null);
INSERT INTO `app_function` VALUES ('77', '_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW', '查看简历信息', '', '查看简历详细信息.', '36', null);
INSERT INTO `app_function` VALUES ('78', '_FUNCKEY_PERSONAL_TASK_VIEW', '任务详情查看', '', '查看任务详细信息.', '4', null);
INSERT INTO `app_function` VALUES ('79', '_FUNCKEY_PERSONAL_TASK_MYVIEW', '查看我发起的任务', '', '查看我发起的任务', '4', null);
INSERT INTO `app_function` VALUES ('80', '_FUNCKEY_PERSONAL_TASK_ADD', '任务新建', '', '新建任务', '4', null);
INSERT INTO `app_function` VALUES ('81', '_FUNCKEY_PERSONAL_TASK_EDIT', '任务编辑', '', '编辑发起的任务.', '4', null);
INSERT INTO `app_function` VALUES ('82', '_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW', '任务审批记录查看', '', '查看任务审批记录详情.', '4', null);
INSERT INTO `app_function` VALUES ('83', '_FUNCKEY_PERSONAL_TASK_POSTPONE', '任务延期申请', '', '提交任务延期申请单', '4', null);
INSERT INTO `app_function` VALUES ('84', '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH', '任务完成申请', '', '提交任务完成申请单.', '4', null);
INSERT INTO `app_function` VALUES ('85', '_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE', '任务延期审批', '', '审批任务延期申请单.', '4', null);
INSERT INTO `app_function` VALUES ('86', '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE', '任务完成审批', '', '审批提交的任务完成申请单.', '4', null);
INSERT INTO `app_function` VALUES ('87', '_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW', '查看面试记录', '', '查看面试记录.', '36', null);
INSERT INTO `app_function` VALUES ('88', '_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW', '查看岗位信息', '', '查看发布的岗位信息', '35', null);
INSERT INTO `app_function` VALUES ('89', '_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW', '查看简历信息', '', '查看推荐或应聘的简历信息', '35', null);
INSERT INTO `app_function` VALUES ('90', '_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY', '岗位应聘', '', '个人提交岗位应聘信息.', '35', null);
INSERT INTO `app_function` VALUES ('91', '_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND', '岗位推荐', '', '推荐他人应聘岗位', '35', null);
INSERT INTO `app_function` VALUES ('92', '_FUNCKEY_ADMIN_TASK_VIEW', '任务信息查看', '', '查看任务信息', '40', null);
INSERT INTO `app_function` VALUES ('93', '_FUNCKEY_ADMIN_TASK_EDIT', '任务信息编辑', '', '编辑任务信息', '40', null);
INSERT INTO `app_function` VALUES ('94', '_FUNCKEY_ADMIN_TASK_REMOVE', '任务信息删除', '', '删除任务信息', '40', null);
INSERT INTO `app_function` VALUES ('95', '_FUNCKEY_ADMIN_TASK_APPROVE', '任务信息审批', '', '审批提交的任务信息', '40', null);
INSERT INTO `app_function` VALUES ('96', '_FUNCKEY_HRM_DEVELOP_APPROVE', '流程审批', '', '审批人资申请流程节点数据, 必须先具备有\'审批详细查看\'功能后才能进入页面进行审批操作.', '47', null);
INSERT INTO `app_function` VALUES ('97', '_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS', '审批详细查看', '', '查看审批详细记录数据', '47', null);
INSERT INTO `app_function` VALUES ('98', '_FUNCKEY_PERSONAL_APPLICATION_VIEW', '申请单查看', '', '查看申请单详细数据.', '37', null);
INSERT INTO `app_function` VALUES ('99', '_FUNCKEY_PERSONAL_APPLICATION_POST', '申请单提交', '', '填写申请单数据并提交审核.', '37', null);
INSERT INTO `app_function` VALUES ('100', '_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_EDIT', '岗位编辑', '', '编辑部门岗位', '23', null);
INSERT INTO `app_function` VALUES ('101', '_FUNCKEY_FLOW_FINAN_PROC_TYPE_REMOVE', '申请类别删除', '', '删除申请类别数据. (功能链接待添加...)', '21', null);
INSERT INTO `app_function` VALUES ('102', '_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE', '查看我发起的所有会议', '', '查看我发起的会议', '32', null);
INSERT INTO `app_function` VALUES ('103', '_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE', '发起新的会议', '', '发起新的会议', '32', null);
INSERT INTO `app_function` VALUES ('104', '_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE', '取消会议', '', '取消已经发起的会议', '32', null);
INSERT INTO `app_function` VALUES ('105', '_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE', '调整会议', '', '调整会议内容', '32', null);
INSERT INTO `app_function` VALUES ('106', '_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE', '查看会议内容', '', '查看会议内容信息', '32', null);
INSERT INTO `app_function` VALUES ('107', '_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE', '激活会议', '', '重新激活已经取消的会议', '32', null);
INSERT INTO `app_function` VALUES ('108', '_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE', '提交会议总结', '', '会议结束后进行的会议总结，包括上传会议记录', '32', null);
INSERT INTO `app_function` VALUES ('109', '_FUNCKEY_ADMIN_ADD_WORK_ARRANGE', '添加工作安排', '', '添加工作安排', '43', null);
INSERT INTO `app_function` VALUES ('110', '_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE', '编辑工作安排', '', '编辑工作安排', '43', null);
INSERT INTO `app_function` VALUES ('111', '_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE', '删除工作安排', '', '删除工作安排', '43', null);
INSERT INTO `app_function` VALUES ('112', '_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE', '从模板导入工作安排', '', '从模板导入工作安排', '43', null);
INSERT INTO `app_function` VALUES ('113', '_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE', '调整工作安排', '', '调整工作安排', '43', null);
INSERT INTO `app_function` VALUES ('114', '_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE', '查看工作安排', '', '按周查看工作安排情况', '43', null);
INSERT INTO `app_function` VALUES ('115', '_FUNCKEY_SYSTEM_ADD_DICTIONARY', '添加数据字典', '', '添加数据字典', '11', null);
INSERT INTO `app_function` VALUES ('116', '_FUNCKEY_SYSTEM_EDIT_DICTIONARY', '编辑数据字典', '', '编辑数据字典', '11', null);
INSERT INTO `app_function` VALUES ('117', '_FUNCKEY_SYSTEM_DELETE_DICTIONARY', '删除数据字典', '', '删除数据字典', '11', null);
INSERT INTO `app_function` VALUES ('119', '_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT', '编辑工作内容', '', '编辑工作内容', '19', null);
INSERT INTO `app_function` VALUES ('120', '_FUNCKEY_SYSTEM_ADD_WORK_CONTENT', '添加工作内容', '', '添加工作内容', '19', null);
INSERT INTO `app_function` VALUES ('121', '_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT', '删除工作内容', '', '删除工作内容', '19', null);
INSERT INTO `app_function` VALUES ('122', '_FUNCKEY_SYSTEM_ADD_WORK_TIME', '添加工作时间', '', '添加工作时间', '19', null);
INSERT INTO `app_function` VALUES ('123', '_FUNCKEY_SYSTEM_DELETE_WORK_TIME', '删除工作时间', '', '删除工作时间', '19', null);
INSERT INTO `app_function` VALUES ('124', '_FUNCKEY_SYSTEM_EDIT_WORK_TIME', '编辑工作时间', '', '编辑工作时间', '19', null);
INSERT INTO `app_function` VALUES ('125', '_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD', '安排模板里的工作', '', '给每套模板安排工作', '18', null);
INSERT INTO `app_function` VALUES ('126', '_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE', '启动模板', '', '启动模板', '18', null);
INSERT INTO `app_function` VALUES ('127', '_FUNCKEY_ADMIN_NEWS_ADD', '发布新闻', '', '发布新闻', '39', null);
INSERT INTO `app_function` VALUES ('128', '_FUNCKEY_ADMIN_NEWS_EDIT', '编辑新闻', '', '修改新闻', '39', null);
INSERT INTO `app_function` VALUES ('129', '_FUNCKEY_ADMIN_NEWS_DELETE', '删除新闻', '', '删除新闻', '39', null);
INSERT INTO `app_function` VALUES ('130', '_FUNCKEY_ADMIN_NEWS_APPROVE', '新闻管理与审批', '', '审批新闻', '39', null);
INSERT INTO `app_function` VALUES ('131', '_FUNCKEY_ADMIN_NEWS_TOP', '新闻置顶', '', '新闻置顶', '39', null);
INSERT INTO `app_function` VALUES ('132', '_FUNCKEY_ADMIN_NEWS_APPROVING', '新闻审批', '', '', '39', null);
INSERT INTO `app_function` VALUES ('133', '_FUNCKEY_ADMIN_DOC_ADD', '上传文档', '', '上传文档', '42', null);
INSERT INTO `app_function` VALUES ('134', '_FUNCKEY_ADMIN_DOC_REMOVE', '删除文档', '', '删除文档', '42', null);
INSERT INTO `app_function` VALUES ('135', '_FUNCKEY_ADMIN_DOC_EDIT', '编辑文档', '', '编辑文档', '42', null);
INSERT INTO `app_function` VALUES ('136', '_FUNCKEY_ADMIN_ACCOUNT_LOCK', '冻结账号', '', '', '26', null);
INSERT INTO `app_function` VALUES ('137', '_FUNCKEY_ADMIN_ACCOUNT_ACTIVE', '激活账号', '', '', '26', null);
INSERT INTO `app_function` VALUES ('138', '_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET', '重置密码', '', '', '26', null);
INSERT INTO `app_function` VALUES ('139', '_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW', '岗位管理-岗位列表', '', '查看岗位列表..', '48', '5,4,2,1');

-- ----------------------------
-- Table structure for `app_function_strategy`
-- ----------------------------
DROP TABLE IF EXISTS `app_function_strategy`;
CREATE TABLE `app_function_strategy` (
  `stg_id` bigint(20) NOT NULL auto_increment COMMENT '功能数据权限id',
  `func_id` bigint(20) default NULL COMMENT '功能id',
  `stg_type` tinyint(4) NOT NULL COMMENT '数据策略类型',
  PRIMARY KEY  (`stg_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='功能数据权限';

-- ----------------------------
-- Records of app_function_strategy
-- ----------------------------
INSERT INTO `app_function_strategy` VALUES ('19', '139', '5');
INSERT INTO `app_function_strategy` VALUES ('20', '139', '1');
INSERT INTO `app_function_strategy` VALUES ('21', '139', '4');
INSERT INTO `app_function_strategy` VALUES ('22', '139', '2');

-- ----------------------------
-- Table structure for `app_function_url`
-- ----------------------------
DROP TABLE IF EXISTS `app_function_url`;
CREATE TABLE `app_function_url` (
  `url_id` int(11) NOT NULL auto_increment,
  `func_id` int(11) default NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY  (`url_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8 COMMENT='功能URL';

-- ----------------------------
-- Records of app_function_url
-- ----------------------------
INSERT INTO `app_function_url` VALUES ('21', '5', 'app/hrm/hire.do?action=hrmPageJobDetail');
INSERT INTO `app_function_url` VALUES ('24', '8', 'app/hrm/hire.do?action=actionJobOpenControl');
INSERT INTO `app_function_url` VALUES ('25', '10', 'app/hrm/hire.do?action=hrmPageJobResume');
INSERT INTO `app_function_url` VALUES ('26', '11', 'app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex');
INSERT INTO `app_function_url` VALUES ('28', '9', 'app/hrm/hire.do?action=hrmPageJobEntryIndex');
INSERT INTO `app_function_url` VALUES ('30', '12', 'app/hrm/hire.do?action=actionJobEntrySave');
INSERT INTO `app_function_url` VALUES ('31', '12', 'app/hrm/hire.do?action=hrmPageJobEntryDetail');
INSERT INTO `app_function_url` VALUES ('32', '13', 'app/hrm/hire.do?action=hrmPageJobApprovalIndex');
INSERT INTO `app_function_url` VALUES ('33', '6', 'app/hrm/hire.do?action=actionJobSave');
INSERT INTO `app_function_url` VALUES ('34', '6', 'app/hrm/hire.do?action=hrmPageJobDetail');
INSERT INTO `app_function_url` VALUES ('35', '7', 'app/hrm/hire.do?action=hrmPageJobDetail');
INSERT INTO `app_function_url` VALUES ('36', '7', 'app/hrm/hire.do?action=actionJobSave');
INSERT INTO `app_function_url` VALUES ('38', '14', 'app/hrm/hire.do?action=hrmPageJobOfferIndex');
INSERT INTO `app_function_url` VALUES ('39', '15', 'app/hrm/hire.do?action=hrmPageJobResume');
INSERT INTO `app_function_url` VALUES ('40', '16', 'app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex');
INSERT INTO `app_function_url` VALUES ('47', '19', 'app/hrm/hire.do?action=actionJobIssueFinalize');
INSERT INTO `app_function_url` VALUES ('48', '19', 'app/hrm/hire.do?action=dialogJobOfferFinalizePage');
INSERT INTO `app_function_url` VALUES ('49', '17', 'app/hrm/hire.do?action=dialogJobOfferFinalizePage');
INSERT INTO `app_function_url` VALUES ('50', '17', 'app/hrm/hire.do?action=actionJobIssueFinalize');
INSERT INTO `app_function_url` VALUES ('51', '18', 'app/hrm/hire.do?action=actionJobIssueFinalize');
INSERT INTO `app_function_url` VALUES ('52', '18', 'app/hrm/hire.do?action=dialogJobOfferFinalizePage');
INSERT INTO `app_function_url` VALUES ('54', '20', 'app/hrm/hire.do?action=hrmPageJobOfferInterviewPlan');
INSERT INTO `app_function_url` VALUES ('55', '20', 'app/hrm/hire/interview.do?action=actionJobInterviewPlanSave');
INSERT INTO `app_function_url` VALUES ('57', '21', 'app/hrm/hire.do?action=hrmPageJobResume');
INSERT INTO `app_function_url` VALUES ('59', '22', 'app/hrm/archive.do?action=actionResumeRemove');
INSERT INTO `app_function_url` VALUES ('64', '25', 'app/hrm/entry.do?action=dialogEntryFinalize');
INSERT INTO `app_function_url` VALUES ('65', '25', 'app/hrm/entry.do?action=actionEntrySave');
INSERT INTO `app_function_url` VALUES ('66', '24', 'app/hrm/entry.do?action=actionEntrySave');
INSERT INTO `app_function_url` VALUES ('67', '24', 'app/hrm/entry.do?action=dialogEntryFinalize');
INSERT INTO `app_function_url` VALUES ('68', '23', 'app/hrm/entry.do?action=dialogEntryBoardPage');
INSERT INTO `app_function_url` VALUES ('69', '23', 'app/hrm/entry.do?action=actionEntrySave');
INSERT INTO `app_function_url` VALUES ('77', '26', 'app/hrm/employee/data.do?action=dialogHrmEmployeeAdd');
INSERT INTO `app_function_url` VALUES ('78', '26', 'app/hrm/employee/data.do?action=actionEmployeeAdd');
INSERT INTO `app_function_url` VALUES ('79', '27', 'app/hrm/employee.do?action=actionEmployeeDelete');
INSERT INTO `app_function_url` VALUES ('80', '28', 'app/hrm/employee.do?action=hrmEmployeeDocDetail');
INSERT INTO `app_function_url` VALUES ('81', '28', 'app/hrm/hire.do?action=hrmPageJobResume');
INSERT INTO `app_function_url` VALUES ('82', '28', 'app/hrm/employee.do?action=hrmEmployeeDocRoadMap');
INSERT INTO `app_function_url` VALUES ('83', '29', 'app/hrm/employee.do?action=actionRoadMapSave');
INSERT INTO `app_function_url` VALUES ('84', '29', 'app/hrm/hire/resume.do?action=actionEmployeeResumeSave');
INSERT INTO `app_function_url` VALUES ('87', '30', 'app/hrm/develop.do?action=actionDevelopFinalize');
INSERT INTO `app_function_url` VALUES ('89', '33', 'app/finan/expense.do?action=diaglogFinaExpensePage&id=1&op=view');
INSERT INTO `app_function_url` VALUES ('90', '34', 'app/finan/expense.do?action=actionFinanApplicationApprove');
INSERT INTO `app_function_url` VALUES ('92', '32', 'app/finan/expense.do?action=actionFinanExpenseFormSave');
INSERT INTO `app_function_url` VALUES ('93', '32', 'app/finan/expense.do?action=diaglogFinaExpensePage');
INSERT INTO `app_function_url` VALUES ('98', '36', 'app/finan/contract.do?action=diaglogFinaContractPage');
INSERT INTO `app_function_url` VALUES ('99', '35', 'app/finan/contract.do?action=diaglogFinaContractPage');
INSERT INTO `app_function_url` VALUES ('100', '35', 'app/finan/contract.do?action=actionFinanContractFormSave');
INSERT INTO `app_function_url` VALUES ('101', '37', 'app/finan/contract.do?action=actionFinanApplicationApprove');
INSERT INTO `app_function_url` VALUES ('103', '38', 'app/finan/expense.do?action=diaglogFinaExpensePage');
INSERT INTO `app_function_url` VALUES ('104', '38', 'app/finan/expense.do?action=loadFinaExpenseRecords');
INSERT INTO `app_function_url` VALUES ('105', '39', 'app/finan/contract.do?action=diaglogFinaContractPage');
INSERT INTO `app_function_url` VALUES ('106', '39', 'app/finan/contract.do?action=loadFinaContractRecords');
INSERT INTO `app_function_url` VALUES ('107', '40', 'app/system/menu/item.do?action=actionSaveMenuItem');
INSERT INTO `app_function_url` VALUES ('108', '40', 'app/system/menu/item.do?action=dialogMenuItemPage');
INSERT INTO `app_function_url` VALUES ('109', '41', 'app/system/menu/item.do?action=dialogMenuItemPage');
INSERT INTO `app_function_url` VALUES ('110', '41', 'app/system/menu/item.do?action=actionSaveMenuItem');
INSERT INTO `app_function_url` VALUES ('111', '42', 'app/system/menu/item.do?action=actionLoadMenuItemTree');
INSERT INTO `app_function_url` VALUES ('112', '43', 'app/system/menu/func.do?action=dialogMenuFuncPage');
INSERT INTO `app_function_url` VALUES ('113', '43', 'app/system/menu/func.do?action=actionSaveMenuFunc');
INSERT INTO `app_function_url` VALUES ('114', '44', 'app/system/menu/func.do?action=dialogMenuFuncPage');
INSERT INTO `app_function_url` VALUES ('115', '44', 'app/system/menu/func.do?action=actionSaveMenuFunc');
INSERT INTO `app_function_url` VALUES ('116', '45', 'app/system/menu/func.do?action=actionLoadMenuFuncList');
INSERT INTO `app_function_url` VALUES ('117', '46', 'app/system/menu/func.do?action=actionRemoveMenuFunc');
INSERT INTO `app_function_url` VALUES ('118', '47', 'app/system/role.do?action=dialogRolePage');
INSERT INTO `app_function_url` VALUES ('119', '47', 'app/system/role.do?action=actionLoadAppFuncs');
INSERT INTO `app_function_url` VALUES ('120', '48', 'app/system/role.do?action=dialogRolePage');
INSERT INTO `app_function_url` VALUES ('121', '48', 'app/system/role.do?action=actionSaveRole');
INSERT INTO `app_function_url` VALUES ('122', '49', 'app/system/role.do?action=actionSaveRole');
INSERT INTO `app_function_url` VALUES ('123', '49', 'app/system/role.do?action=dialogRolePage');
INSERT INTO `app_function_url` VALUES ('124', '50', 'app/system/role.do?action=actionRemoveRole');
INSERT INTO `app_function_url` VALUES ('126', '52', 'app/flow/hrm.do?action=actionLoadProcessPosets');
INSERT INTO `app_function_url` VALUES ('127', '51', 'app/flow/hrm.do?action=actionLoadProcessRootType');
INSERT INTO `app_function_url` VALUES ('132', '53', 'app/flow/hrm.do?action=dialogFlowTaskConfigurationPage');
INSERT INTO `app_function_url` VALUES ('133', '53', 'app/flow/hrm.do?action=actionRemoveProcessTask');
INSERT INTO `app_function_url` VALUES ('134', '53', 'app/flow/hrm.do?action=actionSaveProcessTask');
INSERT INTO `app_function_url` VALUES ('135', '53', 'app/flow/hrm.do?action=pageFlowPosetConfigure');
INSERT INTO `app_function_url` VALUES ('136', '53', 'app/flow/hrm.do?action=actionLoadProcessTypes');
INSERT INTO `app_function_url` VALUES ('137', '53', 'app/flow.do?action=actionLoadProcessRootType');
INSERT INTO `app_function_url` VALUES ('139', '55', 'app/flow.do?action=actionLoadProcessRootType');
INSERT INTO `app_function_url` VALUES ('140', '56', 'app/flow/finance.do?action=actionLoadProcessTypes');
INSERT INTO `app_function_url` VALUES ('141', '57', 'app/flow.do?action=dialogFlowTypePage');
INSERT INTO `app_function_url` VALUES ('142', '57', 'app/flow.do?action=actionSaveProcessType');
INSERT INTO `app_function_url` VALUES ('144', '58', 'app/flow/finance.do?action=dialogFlowTypePage');
INSERT INTO `app_function_url` VALUES ('145', '58', 'app/flow.do?action=actionSaveProcessType');
INSERT INTO `app_function_url` VALUES ('151', '59', 'app/flow/finance.do?action=dialogFlowDefConditionPage');
INSERT INTO `app_function_url` VALUES ('152', '59', 'app/flow/finance.do?action=actionRemoveProcessTask');
INSERT INTO `app_function_url` VALUES ('153', '59', 'app/flow/finance.do?action=dialogFlowTaskConfigurationPage');
INSERT INTO `app_function_url` VALUES ('154', '59', 'app/flow/finance.do?action=pageFlowConfigure');
INSERT INTO `app_function_url` VALUES ('155', '59', 'app/flow/finance.do?action=actionLoadProcessTasks');
INSERT INTO `app_function_url` VALUES ('156', '59', 'app/flow/finance.do?action=actionSaveProcessTask');
INSERT INTO `app_function_url` VALUES ('157', '60', 'app/system/school/district.do?action=dialogSchoolDistrictPage');
INSERT INTO `app_function_url` VALUES ('158', '60', 'app/system/school/district.do?action=actionSaveDistrict');
INSERT INTO `app_function_url` VALUES ('159', '61', 'app/system/school/district.do?action=dialogSchoolDistrictPage');
INSERT INTO `app_function_url` VALUES ('160', '61', 'app/system/school/district.do?action=actionSaveDistrict');
INSERT INTO `app_function_url` VALUES ('161', '62', 'app/system/school/district.do?action=actionRemoveDistrict');
INSERT INTO `app_function_url` VALUES ('162', '63', 'app/system/school/poset.do?action=actionSavePoset');
INSERT INTO `app_function_url` VALUES ('163', '63', 'app/system/school/poset.do?action=dialogSchoolPosetPage');
INSERT INTO `app_function_url` VALUES ('164', '64', 'app/system/school/poset.do?action=actionRemovePoset');
INSERT INTO `app_function_url` VALUES ('165', '65', 'app/system/school/poset.do?action=dialogSchoolPosetPage');
INSERT INTO `app_function_url` VALUES ('166', '65', 'app/system/school/poset.do?action=actionSavePoset');
INSERT INTO `app_function_url` VALUES ('167', '66', 'app/system/school/department.do?action=dialogSchoolDepartmentPage');
INSERT INTO `app_function_url` VALUES ('168', '66', 'app/system/school/department.do?action=actionSaveDepartment');
INSERT INTO `app_function_url` VALUES ('169', '67', 'app/system/school/department.do?action=actionLoadDepartmentTree');
INSERT INTO `app_function_url` VALUES ('170', '68', 'app/system/school/department.do?action=actionRemoveDepartment');
INSERT INTO `app_function_url` VALUES ('171', '69', 'app/system/school/department.do?action=dialogSchoolDepartmentPage');
INSERT INTO `app_function_url` VALUES ('172', '70', 'app/system/school/department/position.do?action=actionLoadDepartmentPosition');
INSERT INTO `app_function_url` VALUES ('173', '71', 'app/system/school/department/position.do?action=actionRemoveDepartmentPosition');
INSERT INTO `app_function_url` VALUES ('174', '72', 'app/system/school/department/position.do?action=actionSaveDepartmentPosition');
INSERT INTO `app_function_url` VALUES ('175', '72', 'app/system/school/department/position.do?action=dialogSchoolDepartmentPositionPage');
INSERT INTO `app_function_url` VALUES ('178', '73', 'app/hrm/hire.do?action=hrmPageJobResume');
INSERT INTO `app_function_url` VALUES ('179', '73', 'app/personal/jobapplication.do?action=pageMyHistoryJobApplication');
INSERT INTO `app_function_url` VALUES ('180', '73', 'app/hrm/hire.do?action=hrmPageJobDetail');
INSERT INTO `app_function_url` VALUES ('186', '76', 'app/hrm/hire.do?action=hrmPageJobDetail');
INSERT INTO `app_function_url` VALUES ('187', '77', 'app/hrm/hire.do?action=hrmPageJobResume');
INSERT INTO `app_function_url` VALUES ('188', '75', 'app/personal/interview.do?action=dialogInterviewCommentPage');
INSERT INTO `app_function_url` VALUES ('189', '75', 'app/personal/interview.do?action=actionDoComment');
INSERT INTO `app_function_url` VALUES ('196', '79', 'app/personal/task.do?action=pageTaskLaunched');
INSERT INTO `app_function_url` VALUES ('206', '84', 'app/personal/task.do?action=dialogApplyPage');
INSERT INTO `app_function_url` VALUES ('207', '84', 'app/personal/task.do?action=actionSaveTaskApply');
INSERT INTO `app_function_url` VALUES ('208', '83', 'app/personal/task.do?action=dialogApplyPage');
INSERT INTO `app_function_url` VALUES ('209', '83', 'app/personal/task.do?action=actionSaveTaskApply');
INSERT INTO `app_function_url` VALUES ('210', '80', 'app/personal/task.do?action=dialogTaskPage');
INSERT INTO `app_function_url` VALUES ('211', '80', 'app/personal/task.do?action=actionSaveTaskPlan');
INSERT INTO `app_function_url` VALUES ('212', '82', 'app/personal/task.do?action=dialogAuditRecords');
INSERT INTO `app_function_url` VALUES ('213', '78', 'app/personal/task.do?action=dialogTaskPage');
INSERT INTO `app_function_url` VALUES ('214', '81', 'app/personal/task.do?action=dialogTaskPage');
INSERT INTO `app_function_url` VALUES ('215', '81', 'app/personal/task.do?action=actionSaveTaskPlan');
INSERT INTO `app_function_url` VALUES ('216', '85', 'app/personal/task.do?action=actionSaveTaskApproval');
INSERT INTO `app_function_url` VALUES ('217', '85', 'app/personal/task.do?action=dialogAuditPage');
INSERT INTO `app_function_url` VALUES ('218', '86', 'app/personal/task.do?action=actionSaveTaskApproval');
INSERT INTO `app_function_url` VALUES ('219', '86', 'app/personal/task.do?action=dialogAuditPage');
INSERT INTO `app_function_url` VALUES ('223', '74', 'app/personal/interview.do?action=pageMyInterviewHistory');
INSERT INTO `app_function_url` VALUES ('224', '87', 'app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex');
INSERT INTO `app_function_url` VALUES ('225', '88', 'app/hrm/hire.do?action=hrmPageJobDetail');
INSERT INTO `app_function_url` VALUES ('226', '89', 'app/hrm/hire.do?action=hrmPageJobResume');
INSERT INTO `app_function_url` VALUES ('231', '93', 'app/admin/task.do?action=dialogTaskPage');
INSERT INTO `app_function_url` VALUES ('232', '92', 'app/admin/task.do?action=dialogTaskPage');
INSERT INTO `app_function_url` VALUES ('233', '94', 'app/admin/task.do?action=actionRemoveTaskPlan');
INSERT INTO `app_function_url` VALUES ('234', '95', 'app/admin/task.do?action=dialogTaskPage');
INSERT INTO `app_function_url` VALUES ('235', '95', 'app/personal/task.do?action=actionSaveTaskPlan');
INSERT INTO `app_function_url` VALUES ('237', '97', 'app/personal/application_form.do?action=dialogApplicationFormPage');
INSERT INTO `app_function_url` VALUES ('238', '31', 'app/hrm/develop.do?action=actionDevelopLoadRecords');
INSERT INTO `app_function_url` VALUES ('239', '96', 'app/personal/application_form.do?action=actionApproveProcess');
INSERT INTO `app_function_url` VALUES ('240', '98', 'app/personal/application_form.do?action=dialogApplicationFormPage');
INSERT INTO `app_function_url` VALUES ('241', '99', 'app/personal/application_form.do?action=actionSaveApplication');
INSERT INTO `app_function_url` VALUES ('242', '99', 'app/personal/application_form.do?action=dialogApplicationFormPage');
INSERT INTO `app_function_url` VALUES ('243', '99', 'app/personal/application_form.do?action=actionLoadTemplatePage');
INSERT INTO `app_function_url` VALUES ('244', '100', 'app/system/school/department/position.do?action=actionSaveDepartmentPosition');
INSERT INTO `app_function_url` VALUES ('245', '100', 'app/system/menu/func.do?action=dialogMenuFuncPage');
INSERT INTO `app_function_url` VALUES ('246', '101', 'TO BE ADDED HERE...');
INSERT INTO `app_function_url` VALUES ('247', '54', 'app/flow/hrm.do?action=actionRemoveProcessTask');
INSERT INTO `app_function_url` VALUES ('251', '104', 'app/personal/conference.do?action=actionCancelConference');
INSERT INTO `app_function_url` VALUES ('253', '106', 'app/personal/conference.do?action=conferenceDetail');
INSERT INTO `app_function_url` VALUES ('254', '102', 'app/personal/conference.do?action=myConferences');
INSERT INTO `app_function_url` VALUES ('255', '107', 'app/personal/conference.do?action=actionActivateConference');
INSERT INTO `app_function_url` VALUES ('257', '109', 'app/admin.do?action=dialogStaffWorkArrange');
INSERT INTO `app_function_url` VALUES ('258', '110', 'app/admin.do?action=adminEditStaffWorkArrangeDialog');
INSERT INTO `app_function_url` VALUES ('259', '111', 'app/admin.do?action=adminDeleteWorkArrange');
INSERT INTO `app_function_url` VALUES ('260', '112', 'app/admin.do?action=actionImportDataFromTemplateDialog');
INSERT INTO `app_function_url` VALUES ('261', '113', 'app/admin.do?action=actionAdjustWorkArrangeDialog');
INSERT INTO `app_function_url` VALUES ('262', '114', 'app/admin.do?action=actionViewWorkArrangePage');
INSERT INTO `app_function_url` VALUES ('264', '16', 'app/system/dictionary.do?action=actionLoadDictionaryEditPage');
INSERT INTO `app_function_url` VALUES ('265', '117', 'app/system/dictionary.do?action=actionDeleteDictionary');
INSERT INTO `app_function_url` VALUES ('267', '119', 'app/system/work/base.do?action=dialogBaseWorkBasePage');
INSERT INTO `app_function_url` VALUES ('269', '121', 'app/system/work/base.do?action=actionRemoveBaseWorkContent');
INSERT INTO `app_function_url` VALUES ('270', '122', 'app/system/work/base/time.do?action=dialogAddWorkTime');
INSERT INTO `app_function_url` VALUES ('271', '123', 'app/system/work/base/time.do?action=actionRemoveBaseWorkTime');
INSERT INTO `app_function_url` VALUES ('272', '124', 'app/system/work/base/time.do?action=dialogBaseWorkTimePage');
INSERT INTO `app_function_url` VALUES ('273', '125', 'app/system/work/template.do?action=dialogWorkArrangePage');
INSERT INTO `app_function_url` VALUES ('274', '126', 'app/system/work/template.do?action=actionEnableWorkTemplate');
INSERT INTO `app_function_url` VALUES ('277', '108', 'app/personal/conference.do?action=actionLoadSubmitSummaryDialog');
INSERT INTO `app_function_url` VALUES ('278', '108', 'app/personal/conference.do?action=actionSubmitSummary');
INSERT INTO `app_function_url` VALUES ('279', '105', 'app/personal/conference.do?action=actionConferenceSave');
INSERT INTO `app_function_url` VALUES ('280', '105', 'app/personal/conference.do?action=conferenceDetail');
INSERT INTO `app_function_url` VALUES ('281', '115', 'app/system/dictionary.do?action=actionSaveDictionary');
INSERT INTO `app_function_url` VALUES ('282', '120', 'app/system/work/base.do?action=actionSaveBaseWorkContent');
INSERT INTO `app_function_url` VALUES ('283', '120', 'app/system/work/base.do?action=dialogAddWorkContent');
INSERT INTO `app_function_url` VALUES ('284', '127', 'app/admin.do?action=adminPageEntryDetail');
INSERT INTO `app_function_url` VALUES ('285', '128', 'app/admin/news.do?action=adminPageEntryApprovalIndex');
INSERT INTO `app_function_url` VALUES ('286', '129', 'app/admin.do?action=adminOprEntryRemove');
INSERT INTO `app_function_url` VALUES ('287', '130', 'app/admin.do?action=adminPageEntryDetail');
INSERT INTO `app_function_url` VALUES ('288', '131', 'app/admin.do?action=adminOprEntryFirst');
INSERT INTO `app_function_url` VALUES ('289', '132', 'app/admin.do?action=adminPageEntryDetail');
INSERT INTO `app_function_url` VALUES ('292', '103', 'app/system/dictionary.do?action=actionLoadByTypeAndLevel&type=conference&level={value}');
INSERT INTO `app_function_url` VALUES ('293', '103', 'app/personal/conference.do?action=actionConferenceSave');
INSERT INTO `app_function_url` VALUES ('294', '103', 'app/personal/conference.do?action=conferenceDetail');
INSERT INTO `app_function_url` VALUES ('297', '133', 'app/admin/doc.do?action=adminPageDocumentDetail');
INSERT INTO `app_function_url` VALUES ('298', '133', 'app/admin/doc.do?action=adminPageDocumentSave');
INSERT INTO `app_function_url` VALUES ('299', '134', 'app/admin/doc.do?action=adminPageDocumentDelete');
INSERT INTO `app_function_url` VALUES ('301', '135', 'app/admin/doc.do?action=adminPageDocumentEdit');
INSERT INTO `app_function_url` VALUES ('302', '135', 'app/admin/doc.do?action=adminPageDocumentEditDetail');
INSERT INTO `app_function_url` VALUES ('303', '136', 'app/system/account.do?action=actionUserStateChange');
INSERT INTO `app_function_url` VALUES ('304', '137', 'app/system/account.do?action=actionUserStateChange');
INSERT INTO `app_function_url` VALUES ('305', '138', 'app/system/account.do?action=actionUserPwdReset');
INSERT INTO `app_function_url` VALUES ('306', '139', 'app/hrm/hire.do?action=hrmJobIndex');
INSERT INTO `app_function_url` VALUES ('307', '91', 'app/hrm/hire.do?action=hrmPageJobResume');
INSERT INTO `app_function_url` VALUES ('308', '91', 'app/hrm/hire/resume.do?action=actionJobApply');
INSERT INTO `app_function_url` VALUES ('309', '90', 'app/hrm/hire.do?action=hrmPageJobResume');
INSERT INTO `app_function_url` VALUES ('310', '90', 'app/hrm/hire/resume.do?action=actionJobApply');

-- ----------------------------
-- Table structure for `app_global_type`
-- ----------------------------
DROP TABLE IF EXISTS `app_global_type`;
CREATE TABLE `app_global_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '名称',
  `type_parent` bigint(20) default NULL COMMENT '父节点',
  `type_key` varchar(64) NOT NULL COMMENT '节点的分类Key',
  `type_desc` varchar(150) default NULL COMMENT '分类描述',
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总分类表  用于显示树层次结构的分类 可以允许任何层次结构';

-- ----------------------------
-- Records of app_global_type
-- ----------------------------

-- ----------------------------
-- Table structure for `app_hrm_archive`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_archive`;
CREATE TABLE `app_hrm_archive` (
  `archive_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `job_id` bigint(20) NOT NULL COMMENT '应聘岗位ID',
  `archive_source` tinyint(4) NOT NULL COMMENT '来源',
  `archive_star` tinyint(4) NOT NULL COMMENT '评定星级',
  PRIMARY KEY  (`archive_id`),
  KEY `job_id` (`job_id`),
  KEY `resume_id` (`resume_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='公司人才库';

-- ----------------------------
-- Records of app_hrm_archive
-- ----------------------------
INSERT INTO `app_hrm_archive` VALUES ('4', '30', '4', '2', '3');
INSERT INTO `app_hrm_archive` VALUES ('5', '56', '10', '5', '3');
INSERT INTO `app_hrm_archive` VALUES ('6', '57', '10', '1', '1');

-- ----------------------------
-- Table structure for `app_hrm_employee`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_employee`;
CREATE TABLE `app_hrm_employee` (
  `emp_id` bigint(20) NOT NULL auto_increment,
  `emp_no` varchar(64) NOT NULL COMMENT '员工编号',
  `dep_id` bigint(20) NOT NULL COMMENT '员工所在部门ID',
  `district_id` bigint(20) NOT NULL COMMENT '员工所在校区ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `position_id` bigint(20) default NULL COMMENT '岗位',
  `birthdate` date default NULL COMMENT '出生日期',
  `phone_no` varchar(64) default NULL COMMENT '电话',
  `short_no` varchar(64) default NULL COMMENT '短号',
  `office_phone` varchar(64) default NULL COMMENT '办公室电话',
  `urgency_contacts` varchar(64) default NULL COMMENT '紧急联系人联系方式',
  `positive_due_date` date default NULL COMMENT '待转正日期',
  `contract_end_date` date default NULL COMMENT '合同到期日期',
  `onboard_status` bigint(20) default NULL COMMENT '在职状态',
  `teacher_star` bigint(20) default NULL,
  `consult_star` bigint(20) default NULL,
  `teach_class` varchar(120) default NULL,
  `teach_subject` varchar(120) default NULL,
  `resume_id` bigint(20) default NULL COMMENT '简历',
  `status` char(10) default NULL COMMENT '员工状态',
  `onboard_date` date default NULL COMMENT '到岗日期',
  `entry_id` bigint(20) default NULL COMMENT '录入人员',
  `entry_datetime` datetime default NULL COMMENT '录入日期',
  `bankNo` varchar(30) default NULL COMMENT '银行账号',
  PRIMARY KEY  (`emp_id`),
  UNIQUE KEY `emp_no` (`emp_no`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='员工档案表';

-- ----------------------------
-- Records of app_hrm_employee
-- ----------------------------
INSERT INTO `app_hrm_employee` VALUES ('19', '00001001', '15', '1', '罗佳驹', '26', '1984-10-12', '13575747066', '', '0571-88071135', '', null, null, '2', null, null, null, null, '37', null, '2009-07-01', '1', '2012-07-31 12:35:10', null);
INSERT INTO `app_hrm_employee` VALUES ('20', '00001002', '15', '1', '梅杰', '13', '1985-01-08', '13777845267', '', '0571-88071391', '', null, null, '2', null, null, null, null, '38', null, '2009-07-01', '1', '2012-07-31 12:37:23', null);
INSERT INTO `app_hrm_employee` VALUES ('21', '00003001', '17', '1', '林菁菁', '39', '1984-03-26', '13968155954', '', '0571-88321763', '', null, null, '2', null, null, null, null, '39', null, '2010-07-01', '1', '2012-07-31 12:40:05', null);
INSERT INTO `app_hrm_employee` VALUES ('22', '00004001', '22', '1', '许玉凤', '40', '1982-10-01', '13968032442', '', '0571-88323637', '', null, null, '2', null, null, null, null, '40', null, '2011-05-01', '1', '2012-07-31 12:41:33', null);
INSERT INTO `app_hrm_employee` VALUES ('23', '00005001', '23', '1', '王伟平', '42', '1986-10-09', '13758194262', '', '0571-88321652', '', null, null, '2', null, null, null, null, '41', null, '2009-07-01', '1', '2012-07-31 12:42:29', null);
INSERT INTO `app_hrm_employee` VALUES ('24', '00002001', '16', '1', '刘苗芳', '14', null, '0571-88071385', '', '', '', null, null, '2', null, null, null, null, '42', null, '2009-07-01', '1', '2012-07-31 12:43:27', null);
INSERT INTO `app_hrm_employee` VALUES ('25', '00003002', '17', '1', '周碧英', '28', null, '0571-88321763', '', '', '', null, null, '2', null, null, null, null, '43', null, '2011-08-23', '1', '2012-07-31 13:07:07', null);
INSERT INTO `app_hrm_employee` VALUES ('26', '00003003', '17', '1', '蒋晓萍', '17', null, '0571-88321763', '', '', '', null, null, '2', null, null, null, null, '44', null, '2011-09-19', '1', '2012-07-31 13:08:01', null);
INSERT INTO `app_hrm_employee` VALUES ('27', '00006001', '24', '1', '杨琪', '45', null, '0571-88313621', '', '', '', null, null, '2', null, null, null, null, '45', null, '2012-05-01', '1', '2012-07-31 13:09:15', null);
INSERT INTO `app_hrm_employee` VALUES ('28', '00005002', '23', '1', '何滨', '43', null, '0571-88071385', '', '', '', null, null, '2', null, null, null, null, '46', null, '2012-04-05', '1', '2012-07-31 13:10:01', null);
INSERT INTO `app_hrm_employee` VALUES ('29', '00002002', '16', '1', '程聪', '29', null, '15068789653', '', '', '', null, null, '2', null, null, null, null, '47', null, '2012-05-07', '1', '2012-07-31 13:12:00', null);
INSERT INTO `app_hrm_employee` VALUES ('30', '00005003', '23', '1', '苏斯翔', '43', null, '13858056931', '', '', '', null, null, '2', null, null, null, null, '48', null, '2012-05-01', '1', '2012-07-31 13:12:40', null);
INSERT INTO `app_hrm_employee` VALUES ('31', '00066001', '20', '8', '俞柏红', '25', null, '0571-82652282', '', '', '', null, null, '2', null, null, null, null, '49', null, '2011-10-19', '1', '2012-07-31 13:14:18', null);
INSERT INTO `app_hrm_employee` VALUES ('32', '00076001', '20', '9', '蔡晓喻', '30', null, '15005725156', '', '', '', null, null, '2', null, null, null, null, '50', null, '2012-05-31', '1', '2012-07-31 13:19:14', null);
INSERT INTO `app_hrm_employee` VALUES ('33', '00056001', '20', '7', '章荷英', '25', null, '13735168660', '', '', '', null, null, '2', null, null, null, null, '51', null, '2011-04-01', '1', '2012-07-31 13:20:08', null);
INSERT INTO `app_hrm_employee` VALUES ('34', '00046001', '20', '6', '冯毓', '30', null, '15858332937', '', '', '', null, null, '2', null, null, null, null, '53', null, '2011-12-08', '1', '2012-07-31 13:21:08', null);
INSERT INTO `app_hrm_employee` VALUES ('35', '00036001', '20', '5', '陈蕾红', '25', null, '13626868497', '', '', '', null, null, '2', null, null, null, null, '54', null, '2011-11-09', '1', '2012-07-31 13:21:50', null);
INSERT INTO `app_hrm_employee` VALUES ('36', '00006002', '24', '1', 'ljx', '44', null, '28056121', '', '', '', null, null, '2', null, null, null, null, '55', null, '2012-07-31', '1', '2012-07-31 21:37:38', null);
INSERT INTO `app_hrm_employee` VALUES ('37', '00003004', '17', '1', '林立', '16', null, '28056121', null, null, null, null, null, '1', null, null, null, null, '28', null, '2012-08-03', '19', '2012-08-03 16:37:55', null);

-- ----------------------------
-- Table structure for `app_hrm_employee_develop`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_employee_develop`;
CREATE TABLE `app_hrm_employee_develop` (
  `develop_id` bigint(20) NOT NULL auto_increment,
  `apply_form_no` varchar(120) NOT NULL COMMENT '人资审批流程',
  `apply_form_type` bigint(20) NOT NULL COMMENT '人资申请类型',
  `apply_date` date NOT NULL COMMENT '申请时间',
  `comments` longtext COMMENT '申请报告',
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `onboard_date` date default NULL COMMENT '到岗日期',
  `from_district` bigint(20) default NULL COMMENT '原校区',
  `from_dep` bigint(20) default NULL COMMENT '原部门',
  `from_position` bigint(20) default NULL COMMENT '原岗位',
  `to_district` bigint(20) default NULL COMMENT '申请校区',
  `to_department` bigint(20) default NULL COMMENT '申请部门',
  `to_position` bigint(20) default NULL COMMENT '申请岗位',
  `status` char(1) default NULL,
  `audit_state` bigint(20) default NULL,
  `op_state` tinyint(4) NOT NULL default '0' COMMENT '操作状态, 0=未操作, 1=已操作 ',
  `entry_id` bigint(20) default NULL,
  `entry_datetime` datetime default NULL COMMENT '录入时间',
  PRIMARY KEY  (`develop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='人资申请';

-- ----------------------------
-- Records of app_hrm_employee_develop
-- ----------------------------
INSERT INTO `app_hrm_employee_develop` VALUES ('1', 'HRM20120803162335', '4', '2012-08-03', '', '19', null, '1', '15', '26', '1', '16', '14', null, null, '0', '1', '2012-08-03 16:23:35');
INSERT INTO `app_hrm_employee_develop` VALUES ('2', 'HRM20120803162615', '4', '2012-08-03', 'fdf', '19', null, '1', '15', '26', '1', '16', '14', null, '2', '1', '1', '2012-08-03 16:26:15');

-- ----------------------------
-- Table structure for `app_hrm_employee_profile`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_employee_profile`;
CREATE TABLE `app_hrm_employee_profile` (
  `profile_id` bigint(20) NOT NULL auto_increment,
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `status` tinyint(4) NOT NULL COMMENT '员工状态',
  PRIMARY KEY  (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工基本信息表';

-- ----------------------------
-- Records of app_hrm_employee_profile
-- ----------------------------

-- ----------------------------
-- Table structure for `app_hrm_employee_roadmap`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_employee_roadmap`;
CREATE TABLE `app_hrm_employee_roadmap` (
  `roadmap_id` int(11) NOT NULL auto_increment,
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `orginal_depid` bigint(20) NOT NULL COMMENT '员工所在部门ID',
  `orginal_districtid` bigint(20) NOT NULL COMMENT '员工所在校区ID',
  `orginal_positionid` bigint(20) NOT NULL COMMENT '员工所在职位ID',
  `dst_depid` bigint(20) default NULL COMMENT '员工去向部门ID',
  `dst_districtid` bigint(20) default NULL COMMENT '员工去向校区ID',
  `dst_positionid` bigint(20) default NULL COMMENT '员工去向职位ID',
  `type` tinyint(4) NOT NULL COMMENT '类型',
  `date` datetime NOT NULL COMMENT '发生时间',
  PRIMARY KEY  (`roadmap_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='员工历程';

-- ----------------------------
-- Records of app_hrm_employee_roadmap
-- ----------------------------
INSERT INTO `app_hrm_employee_roadmap` VALUES ('18', '19', '15', '1', '26', null, null, null, '1', '2009-07-01 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('19', '20', '15', '1', '13', null, null, null, '1', '2009-07-01 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('20', '21', '17', '1', '16', null, null, null, '1', '2010-07-01 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('21', '22', '22', '1', '18', null, null, null, '1', '2011-05-01 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('22', '23', '23', '1', '20', null, null, null, '1', '2009-07-01 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('23', '24', '16', '1', '14', null, null, null, '1', '2009-07-01 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('24', '25', '17', '1', '28', null, null, null, '1', '2011-08-23 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('25', '26', '17', '1', '17', null, null, null, '1', '2011-09-19 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('26', '27', '24', '1', '23', null, null, null, '1', '2012-05-01 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('27', '28', '23', '1', '21', null, null, null, '1', '2012-04-05 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('28', '29', '16', '1', '29', null, null, null, '1', '2012-05-07 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('29', '30', '23', '1', '21', null, null, null, '1', '2012-05-01 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('30', '31', '20', '8', '25', null, null, null, '1', '2011-10-19 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('31', '32', '20', '9', '30', null, null, null, '1', '2012-05-31 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('32', '33', '20', '7', '25', null, null, null, '1', '2011-04-01 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('33', '34', '20', '6', '30', null, null, null, '1', '2011-12-08 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('34', '35', '20', '5', '25', null, null, null, '1', '2011-11-09 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('35', '36', '24', '1', '22', null, null, null, '1', '2012-07-31 00:00:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('36', '19', '15', '1', '26', '16', '1', '14', '3', '2012-08-03 16:27:00');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('37', '37', '17', '1', '16', null, null, null, '1', '2012-08-03 16:37:55');

-- ----------------------------
-- Table structure for `app_hrm_hire_entries`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_entries`;
CREATE TABLE `app_hrm_hire_entries` (
  `entry_id` bigint(20) NOT NULL auto_increment,
  `issue_id` bigint(20) NOT NULL COMMENT '应聘ID',
  `district_id` bigint(20) default NULL COMMENT '入职校区',
  `dep_id` bigint(20) default NULL COMMENT '入职部门',
  `position_id` bigint(20) default NULL COMMENT '入职岗位',
  `charger_id` bigint(20) default NULL COMMENT '负责人',
  `plan_date` datetime default NULL COMMENT '安排入职时间',
  `act_date` datetime default NULL COMMENT '实际入职时间',
  `inspect_status` tinyint(4) default NULL COMMENT '考察结果状态',
  `cstatus` tinyint(4) NOT NULL COMMENT '当前状态',
  `fstatus` tinyint(4) default NULL COMMENT '最终处理状态',
  PRIMARY KEY  (`entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='员工入职安排表';

-- ----------------------------
-- Records of app_hrm_hire_entries
-- ----------------------------
INSERT INTO `app_hrm_hire_entries` VALUES ('9', '20', '1', '17', '16', '1', '2012-08-03 00:00:00', '2012-08-03 00:00:00', '0', '2', '1');
INSERT INTO `app_hrm_hire_entries` VALUES ('10', '21', '1', '16', '7', '1', '2012-07-26 00:00:00', '2012-07-26 00:00:00', '0', '2', '1');
INSERT INTO `app_hrm_hire_entries` VALUES ('11', '24', null, null, null, null, null, null, null, '1', '0');
INSERT INTO `app_hrm_hire_entries` VALUES ('12', '25', '1', '15', '13', '20', '2012-08-08 14:00:00', null, null, '2', '2');
INSERT INTO `app_hrm_hire_entries` VALUES ('13', '26', '1', '15', '13', '20', '2012-08-16 22:56:07', null, null, '2', '2');
INSERT INTO `app_hrm_hire_entries` VALUES ('14', '27', '1', '15', '13', '20', '2012-08-15 00:00:00', null, null, '2', '0');
INSERT INTO `app_hrm_hire_entries` VALUES ('15', '28', '4', '18', '27', '23', '2012-08-27 00:00:00', null, null, '2', '0');

-- ----------------------------
-- Table structure for `app_hrm_hire_interviews`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_interviews`;
CREATE TABLE `app_hrm_hire_interviews` (
  `hw_id` bigint(20) NOT NULL auto_increment,
  `hissue_id` bigint(20) NOT NULL COMMENT '应聘ID',
  `interview_address` varchar(150) NOT NULL COMMENT '面试地址',
  `interview_date` datetime NOT NULL COMMENT '面试时间',
  `interviewer_id` bigint(20) NOT NULL COMMENT '面试官ID',
  `meto` varchar(250) default NULL COMMENT '面试备注',
  `session_sn` tinyint(4) NOT NULL COMMENT '当前面试环节',
  `state` tinyint(4) default NULL COMMENT '面试状态',
  `comments` varchar(150) default NULL COMMENT '面试意见',
  PRIMARY KEY  (`hw_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='招聘面试';

-- ----------------------------
-- Records of app_hrm_hire_interviews
-- ----------------------------
INSERT INTO `app_hrm_hire_interviews` VALUES ('14', '20', '教室1', '2012-07-27 00:00:00', '6', '', '1', '2', '很好');

-- ----------------------------
-- Table structure for `app_hrm_hire_interviews_file`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_interviews_file`;
CREATE TABLE `app_hrm_hire_interviews_file` (
  `interview_id` bigint(20) NOT NULL COMMENT '面试ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`interview_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='面试附件';

-- ----------------------------
-- Records of app_hrm_hire_interviews_file
-- ----------------------------

-- ----------------------------
-- Table structure for `app_hrm_hire_issue`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_issue`;
CREATE TABLE `app_hrm_hire_issue` (
  `hissue_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `hjob_id` bigint(20) NOT NULL COMMENT '应聘职位ID',
  `current_status` tinyint(4) NOT NULL COMMENT '当前状态',
  `final_result` tinyint(4) default NULL COMMENT '最终处理结果',
  `user_id` bigint(20) default NULL COMMENT '应聘者ID, 主要用于存员工申请 (包含自我申请, 推荐他人)',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY  (`hissue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='当前招聘';

-- ----------------------------
-- Records of app_hrm_hire_issue
-- ----------------------------
INSERT INTO `app_hrm_hire_issue` VALUES ('20', '28', '4', '4', '1', '1', '2012-07-26 13:44:20');
INSERT INTO `app_hrm_hire_issue` VALUES ('21', '29', '5', '4', '1', '1', '2012-07-26 14:06:11');
INSERT INTO `app_hrm_hire_issue` VALUES ('24', '32', '5', '4', '1', '1', '2012-07-29 03:26:36');
INSERT INTO `app_hrm_hire_issue` VALUES ('25', '56', '10', '4', '1', '20', '2012-08-06 22:23:30');
INSERT INTO `app_hrm_hire_issue` VALUES ('26', '57', '10', '4', '1', '1', '2012-08-06 22:54:02');
INSERT INTO `app_hrm_hire_issue` VALUES ('27', '58', '10', '4', '1', '1', '2012-08-06 22:58:19');
INSERT INTO `app_hrm_hire_issue` VALUES ('28', '59', '10', '4', '1', '1', '2012-08-06 22:58:27');

-- ----------------------------
-- Table structure for `app_hrm_hire_job`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_job`;
CREATE TABLE `app_hrm_hire_job` (
  `hjob_id` bigint(20) NOT NULL auto_increment,
  `job_title` varchar(128) NOT NULL COMMENT '招聘岗位名称',
  `hjob_districtid` bigint(20) NOT NULL COMMENT '招聘校区',
  `hjob_depid` bigint(20) NOT NULL COMMENT '招聘部门',
  `hjob_range` tinyint(4) NOT NULL COMMENT '招聘范围',
  `hjob_visible_districtid` bigint(20) default NULL COMMENT '可见范围',
  `end_date` datetime NOT NULL COMMENT '结束时间',
  `hjob_count` int(11) NOT NULL COMMENT '招聘人数',
  `hjob_condition` varchar(1024) default NULL COMMENT '招聘要求(条件)',
  `hjob_address` varchar(150) default NULL COMMENT '工作地点',
  `hjob_responsibility` text COMMENT '工作职责',
  `hjob_salary` text COMMENT '薪资福利',
  `reg_fullname` varchar(128) default NULL COMMENT '登记人姓名',
  `reg_date` datetime default NULL COMMENT '登记时间',
  `modify_fullname` varchar(32) default NULL COMMENT '变更人姓名',
  `modify_date` datetime default NULL COMMENT '变更时间',
  `check_fullname` varchar(32) default NULL COMMENT '审核人姓名',
  `check_opinion` varchar(512) default NULL COMMENT '审核意见',
  `check_date` datetime default NULL COMMENT '审批时间',
  `status` smallint(6) NOT NULL COMMENT '状态            1=通过审核            0=未审核            2=审核不通过',
  `memo` varchar(1024) default NULL COMMENT '备注',
  `isopen` tinyint(4) default '1' COMMENT '应聘控制 0=关闭, 1=开放',
  `entry_id` bigint(20) default NULL COMMENT '岗位发布人员ID',
  `entry_time` datetime default NULL COMMENT '岗位发布时间',
  PRIMARY KEY  (`hjob_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='招聘岗位发布';

-- ----------------------------
-- Records of app_hrm_hire_job
-- ----------------------------
INSERT INTO `app_hrm_hire_job` VALUES ('4', '校区总监', '3', '18', '1', null, '2012-07-26 00:00:00', '1', '', '', '', '', '管理员', '2012-07-26 13:43:27', null, null, null, null, null, '4', null, '1', null, null);
INSERT INTO `app_hrm_hire_job` VALUES ('5', '教师', '1', '16', '1', null, '2012-07-31 00:00:00', '10', '', '', '', '', '管理员', '2012-07-26 14:05:40', null, null, null, null, null, '4', null, '1', null, null);
INSERT INTO `app_hrm_hire_job` VALUES ('6', 'teat', '1', '15', '1', '3', '2012-07-24 00:00:00', '12', '', '213', '321', '', '管理员', '2012-07-29 03:02:37', null, null, null, null, null, '2', null, null, null, null);
INSERT INTO `app_hrm_hire_job` VALUES ('7', '行政助理', '1', '24', '1', null, '2012-08-02 00:00:00', '2', '', '', '', '', '管理员', '2012-07-31 14:56:59', null, null, null, null, null, '4', null, '1', null, null);
INSERT INTO `app_hrm_hire_job` VALUES ('8', 'test', '1', '15', '1', null, '2012-07-31 00:00:00', '2', '', '', '', '', '管理员', '2012-07-31 16:23:54', null, null, null, null, null, '4', null, null, null, null);
INSERT INTO `app_hrm_hire_job` VALUES ('9', 'abcd', '1', '15', '1', null, '2012-08-15 00:00:00', '12', '', '', '', '', '管理员', '2012-08-06 22:11:39', null, null, null, null, null, '3', null, null, '1', '2012-08-05 19:28:02');
INSERT INTO `app_hrm_hire_job` VALUES ('10', 'admin_job', '1', '15', '1', null, '2012-08-06 00:00:00', '12', '', '', '', '', '管理员', '2012-08-06 22:15:57', null, null, null, null, null, '4', null, '1', '1', '2012-08-06 22:15:44');

-- ----------------------------
-- Table structure for `app_hrm_hire_job_file`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_job_file`;
CREATE TABLE `app_hrm_hire_job_file` (
  `hjob_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`hjob_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招聘岗位附件';

-- ----------------------------
-- Records of app_hrm_hire_job_file
-- ----------------------------
INSERT INTO `app_hrm_hire_job_file` VALUES ('6', '33');

-- ----------------------------
-- Table structure for `app_hrm_resume`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_resume`;
CREATE TABLE `app_hrm_resume` (
  `resume_id` bigint(20) NOT NULL auto_increment,
  `emp_id` bigint(20) default NULL COMMENT '员工ID号, 有可能该ID号为空',
  `fullname` varchar(64) NOT NULL COMMENT '姓名',
  `age` int(11) default NULL COMMENT '年龄',
  `birthday` datetime default NULL COMMENT '出生日期',
  `address` varchar(128) default NULL COMMENT '居住地址',
  `marriage` tinyint(4) default NULL COMMENT '婚姻状况 1=未婚, 2=已婚',
  `zip` varchar(32) default NULL COMMENT '邮编',
  `sex` tinyint(4) default NULL COMMENT '性别 1=男生, 2=女生',
  `phone` varchar(64) default NULL COMMENT '座机',
  `mobile` varchar(64) default NULL COMMENT '移动电话 (联系电话)',
  `email` varchar(128) default NULL COMMENT '邮箱地址',
  `hobby` varchar(256) default NULL COMMENT '兴趣爱好',
  `religion` varchar(128) default NULL,
  `party` tinyint(4) default NULL COMMENT '政治面貌 1=群众, 2=党员, 3=团员',
  `nationality` varchar(32) default NULL COMMENT '国籍',
  `race` varchar(32) default NULL,
  `birthPlace` varchar(128) default NULL COMMENT '籍贯',
  `eduCollege` varchar(128) default NULL COMMENT '毕业院校',
  `eduDegree` tinyint(4) default NULL COMMENT '学历 1=研究生, 2=本科, 3=大专, 4=其他',
  `eduMajor` varchar(128) default NULL COMMENT '专业',
  `teacher_major` tinyint(4) default NULL COMMENT '师范类专业 1=是, 2=否',
  `teacher_cert` tinyint(4) default NULL COMMENT '有无教师资格 1=有, 2=无',
  `startWorkDate` datetime default NULL,
  `idNo` varchar(64) default NULL COMMENT '身份证',
  `photo` varchar(128) default NULL,
  `status` varchar(64) default NULL COMMENT '状态                        通过            未通过            准备安排面试            面试通过                        ',
  `memo` varchar(1024) default NULL,
  `registor` varchar(64) default NULL,
  `regTime` datetime default NULL,
  `workCase` text,
  `trainCase` text,
  `projectCase` text,
  `en_level` tinyint(4) default NULL COMMENT '外语等级 1=CET-4, 2=CET-6, 3=专业四级, 4=专业八级, 5=其他',
  `cn_level` tinyint(4) default NULL COMMENT '普通话等级 1=一级甲等, 2=一级乙等, 3=二级甲等, 4=二级乙等, 5=三级甲等, 6=三级乙等, 7=无',
  `source` tinyint(4) default NULL COMMENT '简历来源',
  PRIMARY KEY  (`resume_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='简历管理';

-- ----------------------------
-- Records of app_hrm_resume
-- ----------------------------
INSERT INTO `app_hrm_resume` VALUES ('20', '6', '罗家驹', null, null, '', '1', null, '1', null, '12345678', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('21', '7', '张三', null, null, '', '1', null, '1', null, '11223223', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('22', '8', '李四', null, null, '', '1', null, '1', null, '12321123', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('23', '9', '王五', null, null, '', '1', null, '1', null, '1222222', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('24', '10', '赵六', null, null, '', '1', null, '1', null, '11111111', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('25', '11', '钱七', null, null, '', '1', null, '1', null, '1234512', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('26', '12', '孙八', null, null, '', '1', null, '1', null, '123212312', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('27', '13', '周九', null, null, '', '1', null, '1', null, '12312132', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('28', '37', '林立', null, null, '', '1', null, '1', null, '28056121', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '2');
INSERT INTO `app_hrm_resume` VALUES ('29', '14', '教师1', null, null, '', '1', null, '1', null, '28056121', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('32', null, 'test', null, null, '', '1', null, '1', null, '12421', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('33', '15', 'test2', null, null, '', '1', null, '1', null, '121321321', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('34', '16', 'test3', null, null, '', '1', null, '1', null, '112312321', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('35', '17', 'test4', null, null, '', '1', null, '1', null, '12312312', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('36', '18', 'test5', null, null, '', '1', null, '1', null, '121321321', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('37', '19', '罗佳驹', null, '1984-10-12 00:00:00', '杭州市拱墅区湖墅南路', '1', null, '1', null, '13575747066', '13575747066@139.com', null, null, '1', null, null, '', '浙江大学', '1', '', '1', '2', null, '330682198410120030 ', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('38', '20', '梅杰', null, '1985-01-08 00:00:00', '杭州市浙大路38号', '1', null, '1', null, '13777845267', '13777845267@139.com', null, null, '1', null, null, '', '浙江大学', '1', '', '1', '1', null, '330523198501085618', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('39', '21', '林菁菁', null, '1984-03-26 00:00:00', '杭州市西湖区九莲新村', '1', null, '2', null, '13968155954', '13968155954@139.com', null, null, '1', null, null, '上虞', '浙江大学', '1', '', '1', '1', null, '330682198403265944', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('40', '22', '许玉凤', null, '1982-10-01 00:00:00', '', '1', null, '2', null, '13968032442', '', null, null, '1', null, null, '安徽', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('41', '23', '王伟平', null, '1986-10-09 00:00:00', '', '1', null, '1', null, '13758194262', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('42', '24', '刘苗芳', null, null, '', '1', null, '2', null, '0571-88071385', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('43', '25', '周碧英', null, null, '', '1', null, '2', null, '0571-88321763', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('44', '26', '蒋晓萍', null, null, '', '1', null, '2', null, '0571-88321763', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('45', '27', '杨琪', null, null, '', '1', null, '1', null, '0571-88313621', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('46', '28', '何滨', null, null, '', '1', null, '1', null, '0571-88071385', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('47', '29', '程聪', null, null, '', '1', null, '1', null, '15068789653', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('48', '30', '苏斯翔', null, null, '', '1', null, '2', null, '13858056931', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('49', '31', '俞柏红', null, null, '', '1', null, '2', null, '0571-82652282', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('50', '32', '蔡晓喻', null, null, '', '1', null, '2', null, '15005725156', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('51', '33', '章荷英', null, null, '', '1', null, '2', null, '13735168660', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('52', null, '章荷英', null, null, '', '1', null, '2', null, '13735168660', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('53', '34', '冯毓', null, null, '', '1', null, '2', null, '15858332937', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('54', '35', '陈蕾红', null, null, '', '1', null, '1', null, '13626868497', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('55', '36', 'ljx', null, null, '', '1', null, '1', null, '28056121', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('56', null, '赵祥', null, null, '方家花苑', '1', null, '1', null, '13588064354', 'z405656232x@163.com', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '2');
INSERT INTO `app_hrm_resume` VALUES ('57', null, '宇智波斑', null, null, '', '1', null, '1', null, '13588064354', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('58', null, '阿毛', null, null, '', '1', null, '1', null, '124124', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('59', null, '阿狗', null, null, '', '1', null, '1', null, '12421', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', '', null, null, null, null, null, null, null, '1', '1', '0');

-- ----------------------------
-- Table structure for `app_hrm_resume_file`
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_resume_file`;
CREATE TABLE `app_hrm_resume_file` (
  `file_id` bigint(20) NOT NULL,
  `resum_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`file_id`,`resum_id`),
  CONSTRAINT `app_hrm_resume_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历附件';

-- ----------------------------
-- Records of app_hrm_resume_file
-- ----------------------------

-- ----------------------------
-- Table structure for `app_menu`
-- ----------------------------
DROP TABLE IF EXISTS `app_menu`;
CREATE TABLE `app_menu` (
  `menu_id` bigint(20) NOT NULL auto_increment,
  `menu_title` varchar(120) NOT NULL COMMENT '菜单名称',
  `menu_icon` varchar(64) default NULL COMMENT '菜单图标',
  `menu_url` varchar(120) NOT NULL COMMENT '菜单链接',
  `menu_key` varchar(64) NOT NULL COMMENT '菜单key',
  `menu_desc` varchar(100) default NULL COMMENT '菜单描述',
  `menu_parent` int(11) default NULL COMMENT '父菜单',
  `menu_order` int(11) default NULL COMMENT '菜单项顺序',
  PRIMARY KEY  (`menu_id`),
  UNIQUE KEY `menu_key` (`menu_key`),
  KEY `menu_parent` (`menu_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='系统菜单';

-- ----------------------------
-- Records of app_menu
-- ----------------------------
INSERT INTO `app_menu` VALUES ('3', '我的工作区', 'icon-desktop', 'javascript:void(0);', '_menu_mod_personal', '', null, '0');
INSERT INTO `app_menu` VALUES ('4', '我的任务', 'icon-myplan', 'app/personal/task.do?action=pageTaskIndex', '_menu_mod_personal_mytask', '', '3', '0');
INSERT INTO `app_menu` VALUES ('5', '财务管理', 'icon-financial', 'javascript:void(0);', '_menu_mod_fina', '', null, '3');
INSERT INTO `app_menu` VALUES ('6', '费用支出管理', 'icon-finmrmb', 'javascript:void(0);', '_menu_mod_fina_exp_mgr', '', '5', '0');
INSERT INTO `app_menu` VALUES ('7', '费用支出申请', 'icon-finmrmbApply', 'app/finan/expense.do?action=pageFinaExpenseIndex', '_menu_mod_fina_exp_apply', '', '6', '0');
INSERT INTO `app_menu` VALUES ('8', '人资管理', 'icon-hr', 'javascript:void(0);', '_menu_mod_hrm', '', null, '2');
INSERT INTO `app_menu` VALUES ('9', '系统管理', 'icon-system', 'javascript:void(0);', '_menu_mod_sysmgr', '', null, '4');
INSERT INTO `app_menu` VALUES ('10', '系统设置', 'icon-settings', 'javascript:void(0);', '_menu_mod_syscfg', '', null, '4');
INSERT INTO `app_menu` VALUES ('11', '数据字典设置', 'icon-setdic', 'app/system/dictionary.do?action=actionDictionaryPage', '_menu_mod_syscfg_item_dic', '', '10', '0');
INSERT INTO `app_menu` VALUES ('12', '工作安排设置', 'icon-setaskm', 'javascript:void(0);', '_menu_mod_syscfg_item_workarrange', '', '10', '1');
INSERT INTO `app_menu` VALUES ('13', '审批流程设置', 'icon-setflowm', 'javascript:void(0);', '_menu_mod_syscfg_item_flow', '', '10', '2');
INSERT INTO `app_menu` VALUES ('14', '学校设置', 'icon-setorg', 'javascript:void(0);', '_menu_mod_syscfg_item_school', '', '10', '3');
INSERT INTO `app_menu` VALUES ('15', '权限组配置', 'icon-setrole', 'app/system/role.do?action=pageRoleIndex', '_menu_mod_syscfg_item_role', '', '10', '4');
INSERT INTO `app_menu` VALUES ('16', '菜单设置', 'icon-setres', 'app/system/menu.do?action=pageMenuIndex', '_menu_mod_syscfg_item_menu', '', '10', '5');
INSERT INTO `app_menu` VALUES ('17', '行政管理', 'icon-admin', 'javascript:void(0);', '_menu_mod_admin', '', null, '1');
INSERT INTO `app_menu` VALUES ('18', '工作安排模板设置', 'icon-setaskmTpl', 'app/system/work/template.do?action=pageWorkTemplateIndex', '_menu_mod_syscfg_item_workarrange_template', '', '12', '0');
INSERT INTO `app_menu` VALUES ('19', '工作安排基础设置', 'icon-setaskmBase', 'app/system/work/base.do?action=pageWorkBaseIndex', '_menu_mod_syscfg_item_workarrange_base', '', '12', '1');
INSERT INTO `app_menu` VALUES ('20', '人资审批流程设置', 'icon-setflowmhr', 'app/flow/hrm.do?action=pageFlowIndex', '_menu_mod_syscfg_item_flow_financial', '', '13', '0');
INSERT INTO `app_menu` VALUES ('21', '财务审批流程设置', 'icon-setflowmfin', 'app/flow/finance.do?action=pageFlowIndex', '_menu_mod_syscfg_item_flow_financ', '', '13', '1');
INSERT INTO `app_menu` VALUES ('22', '校区设置', 'icon-setorgDep', 'app/system/school/district.do?action=pageSchoolDistrictIndex', '_menu_mod_syscfg_item_school_district', '', '14', '0');
INSERT INTO `app_menu` VALUES ('23', '部门岗位设置', 'icon-setorgRepo', 'app/system/school/department.do?action=pageSchoolDepartmentIndex', '_menu_mod_syscfg_item_school_dep', '', '14', '1');
INSERT INTO `app_menu` VALUES ('24', '职位岗位设置', 'icon-setdePos', 'app/system/school/poset.do?action=pageSchoolPosetIndex', '_menu_mod_syscfg_item_school_poset', '', '14', '2');
INSERT INTO `app_menu` VALUES ('25', '密码修改', 'icon-sysmpwd', 'app/system/password.do?action=changePasswordPage', '_menu_mod_sysmgr_svpwd', '', '9', '0');
INSERT INTO `app_menu` VALUES ('26', '用户管理', 'icon-sysmusr', 'app/system/account.do?action=pageAccountIndex', '_menu_mod_sysmgr_usrmgr', '', '9', '1');
INSERT INTO `app_menu` VALUES ('27', '系统日志', 'icon-sysmlogs', 'app/system/log.do?action=actionLoadLogPage', '_menu_mod_sysmgr_logs', '', '9', '2');
INSERT INTO `app_menu` VALUES ('28', '费用审批记录', 'icon-finmrmbApproval', 'app/finan/expense.do?action=pageFinaExpenseRecords', '_menu_mod_fina_exp_records', '', '6', '1');
INSERT INTO `app_menu` VALUES ('29', '合同管理', 'icon-finmcontracts', 'javascript:void(0);', '_menu_mod_fina_contract', '', '5', '1');
INSERT INTO `app_menu` VALUES ('30', '合同审批申请', 'icon-finmcontractsApply', 'app/finan/contract.do?action=pageFinaContractIndex', '_menu_mod_fina_contract_apply', '', '29', '0');
INSERT INTO `app_menu` VALUES ('31', '合同审批记录', 'icon-finmcontractsRecords', 'app/finan/contract.do?action=pageFinaContractRecords', '_menu_mod_fina_contract_records', '', '29', '1');
INSERT INTO `app_menu` VALUES ('32', '我的会议', 'icon-myconference', 'app/personal/conference.do?action=myConferenceIndex', '_menu_mod_personal_conference', '', '3', '1');
INSERT INTO `app_menu` VALUES ('33', '我的新闻', 'icon-mynews', 'app/personal/news.do?action=pageMyNews', '_menu_mod_personal_news', '', '3', '2');
INSERT INTO `app_menu` VALUES ('34', '文档下载区', 'icon-infodoc', 'app/personal/doc.do?action=pageMyDoc', '_menu_mod_personal_doc', '', '3', '3');
INSERT INTO `app_menu` VALUES ('35', '我要应聘', 'icon-hrjobreg', 'app/personal/jobapplication.do?action=pageJobOnHiring', '_menu_mod_personal_jobreg', '', '3', '4');
INSERT INTO `app_menu` VALUES ('36', '我做伯乐', 'icon-myinvite', 'app/personal/interview.do?action=pageMyInterviewToDo', '_menu_mod_personal_invitation', '', '3', '5');
INSERT INTO `app_menu` VALUES ('37', '我的申请', 'icon-myapply', 'app/personal/application_form.do?action=pageMyApplicationIndex', '_menu_mod_personal_apply', '', '3', '6');
INSERT INTO `app_menu` VALUES ('38', '待我审批', 'icon-myapproval', 'app/personal/approval.do?action=pageMyApproval', '_menu_mod_personal_approval', '', '3', '7');
INSERT INTO `app_menu` VALUES ('39', '新闻发布与管理', 'icon-adminnews', 'app/admin/news.do?action=adminPageEntryIndex', '_menu_mod_admin_news', '', '17', '0');
INSERT INTO `app_menu` VALUES ('40', '任务委托管理', 'icon-admintask', 'app/admin/task.do?action=pageTaskDelegateIndex', '_menu_mod_admin_task', '', '17', '1');
INSERT INTO `app_menu` VALUES ('41', '员工考勤管理', 'icon-admindutyStaff', 'javascript:void(0);', '_menu_mod_admin_staff', '', '17', '2');
INSERT INTO `app_menu` VALUES ('42', '文档上传与管理', 'icon-infoshared', 'app/admin/doc.do?action=adminPageDocumentIndex', '_menu_mod_personal_docup', '', '17', '3');
INSERT INTO `app_menu` VALUES ('43', '工作安排', 'icon-admindutyArrange', 'app/admin.do?action=adminPageStaffWorkArrange', '_menu_mod_admin_staff_workarrange', '', '41', '0');
INSERT INTO `app_menu` VALUES ('44', '员工考勤', 'icon-adminduty', 'app/admin/attendance/view.do?action=adminPageStaffAttendance', '_menu_mod_admin_staff_attendance', '', '41', '1');
INSERT INTO `app_menu` VALUES ('45', '招聘管理', 'icon-hrjobm', 'javascript:void(0);', '_menu_mod_hrm_jobhire', '', '8', '0');
INSERT INTO `app_menu` VALUES ('46', '员工档案管理', 'icon-hrstaffm', 'javascript:void(0);', '_menu_mod_hrm_empdoc', '', '8', '1');
INSERT INTO `app_menu` VALUES ('47', '人力发展管理', 'icon-hrmcheck', 'app/hrm/develop.do?action=hrmEmployeeDevelopIndex', '_menu_mod_admin_emp_develop', '', '8', '2');
INSERT INTO `app_menu` VALUES ('48', '当前招聘管理', 'icon-hrjobmIssue', 'app/hrm/hire.do?action=hrmJobIndex', '_menu_mod_hrm_jobhire_cmgr', '', '45', '0');
INSERT INTO `app_menu` VALUES ('49', '公司人才库', 'icon-hrjobmProfile', 'app/hrm/archive.do?action=hrmJobResumeIndex', '_menu_mod_hrm_jobhire_develop', '', '45', '1');
INSERT INTO `app_menu` VALUES ('50', '招聘入职', 'icon-hrjobreg', 'app/hrm/entry.do?action=hrmPageEntryIndex', '_menu_mod_hrm_entry', '', '46', '0');
INSERT INTO `app_menu` VALUES ('51', '员工档案', 'icon-hrstaffmProfile', 'app/hrm/employee.do?action=hrmEmployeeDocIndex', '_menu_mod_hrm_emp_archive', '', '46', '1');

-- ----------------------------
-- Table structure for `app_message_entity`
-- ----------------------------
DROP TABLE IF EXISTS `app_message_entity`;
CREATE TABLE `app_message_entity` (
  `msg_id` bigint(20) NOT NULL auto_increment,
  `msg_subject` varchar(150) NOT NULL COMMENT '消息标题',
  `msg_content` text NOT NULL COMMENT '消息内容',
  `sender_id` bigint(20) NOT NULL COMMENT '发送者ID',
  `sender_name` varchar(120) NOT NULL COMMENT '发送者姓名',
  `msg_type` tinyint(4) default NULL COMMENT '消息类型',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  PRIMARY KEY  (`msg_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='短消息';

-- ----------------------------
-- Records of app_message_entity
-- ----------------------------
INSERT INTO `app_message_entity` VALUES ('1', 'tesat', 'ttesta', '6', '罗家驹', '1', '2012-07-27 09:44:54');
INSERT INTO `app_message_entity` VALUES ('2', 'tesat', 'noimno', '6', '罗家驹', '1', '2012-07-27 10:13:44');
INSERT INTO `app_message_entity` VALUES ('3', '测试下....', 'test', '6', '罗家驹', '1', '2012-07-27 10:34:06');
INSERT INTO `app_message_entity` VALUES ('4', '消息测试', 'acae', '6', '罗家驹', '1', '2012-07-27 10:34:20');
INSERT INTO `app_message_entity` VALUES ('5', 'test', 'fawefwae', '6', '罗家驹', '1', '2012-07-27 12:34:48');
INSERT INTO `app_message_entity` VALUES ('6', 'test', 'test', '19', '罗佳驹', '1', '2012-08-01 20:18:39');
INSERT INTO `app_message_entity` VALUES ('7', 'hi', 'hello', '19', '罗佳驹', '1', '2012-08-02 17:43:54');

-- ----------------------------
-- Table structure for `app_message_in`
-- ----------------------------
DROP TABLE IF EXISTS `app_message_in`;
CREATE TABLE `app_message_in` (
  `receive_id` bigint(20) NOT NULL auto_increment,
  `msg_id` bigint(20) NOT NULL COMMENT '短消息ID',
  `user_id` bigint(20) NOT NULL COMMENT '接收用户ID',
  `user_name` varchar(64) NOT NULL COMMENT '接收用户姓名',
  `flag_read` tinyint(4) NOT NULL default '0' COMMENT '阅读标记, 1=已读, 0=未读',
  `flag_del` tinyint(4) NOT NULL default '0' COMMENT '删除标记, 1=已删, 0=未删',
  `receiv_time` datetime NOT NULL COMMENT '接收时间',
  PRIMARY KEY  (`receive_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='收件箱';

-- ----------------------------
-- Records of app_message_in
-- ----------------------------
INSERT INTO `app_message_in` VALUES ('1', '1', '6', '罗家驹', '1', '0', '2012-07-27 09:44:55');
INSERT INTO `app_message_in` VALUES ('2', '2', '6', '罗家驹', '1', '1', '2012-07-27 10:13:44');
INSERT INTO `app_message_in` VALUES ('3', '3', '14', '教师1', '0', '0', '2012-07-27 10:34:06');
INSERT INTO `app_message_in` VALUES ('4', '3', '6', '罗家驹', '0', '1', '2012-07-27 10:34:06');
INSERT INTO `app_message_in` VALUES ('5', '3', '7', '张三', '0', '0', '2012-07-27 10:34:07');
INSERT INTO `app_message_in` VALUES ('6', '4', '14', '教师1', '1', '0', '2012-07-27 10:34:21');
INSERT INTO `app_message_in` VALUES ('7', '4', '6', '罗家驹', '1', '0', '2012-07-27 10:34:21');
INSERT INTO `app_message_in` VALUES ('8', '4', '7', '张三', '0', '0', '2012-07-27 10:34:21');
INSERT INTO `app_message_in` VALUES ('9', '4', '8', '李四', '0', '0', '2012-07-27 10:34:21');
INSERT INTO `app_message_in` VALUES ('10', '5', '6', '罗家驹', '1', '0', '2012-07-27 12:34:48');
INSERT INTO `app_message_in` VALUES ('11', '6', '20', '梅杰', '0', '0', '2012-08-01 20:18:39');
INSERT INTO `app_message_in` VALUES ('12', '6', '19', '罗佳驹', '1', '0', '2012-08-01 20:18:39');
INSERT INTO `app_message_in` VALUES ('13', '7', '20', '梅杰', '0', '0', '2012-08-02 17:43:54');
INSERT INTO `app_message_in` VALUES ('14', '7', '19', '罗佳驹', '1', '0', '2012-08-02 17:43:54');

-- ----------------------------
-- Table structure for `app_process_definition`
-- ----------------------------
DROP TABLE IF EXISTS `app_process_definition`;
CREATE TABLE `app_process_definition` (
  `def_id` bigint(20) NOT NULL auto_increment,
  `type_id` bigint(20) default NULL COMMENT '流程分类ID',
  `def_name` varchar(256) default NULL COMMENT '流程名称',
  `def_description` varchar(250) default NULL COMMENT '流程描述',
  `filter_poset` bigint(20) default NULL COMMENT '过滤职位',
  `def_trigger` varchar(120) default NULL COMMENT '条件',
  `createtime` datetime default NULL COMMENT '创建时间',
  PRIMARY KEY  (`def_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `app_process_definition_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_process_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='流程定义';

-- ----------------------------
-- Records of app_process_definition
-- ----------------------------
INSERT INTO `app_process_definition` VALUES ('1', '7', '0 < 支出费用 <= 1000', '', '0', 'x > 0 && x <= 1000', '2012-06-29 14:50:40');
INSERT INTO `app_process_definition` VALUES ('2', '7', '1000 < 支出费用 <= 10000', '', '0', 'x > 1000 && x <= 10000', '2012-06-29 14:51:15');
INSERT INTO `app_process_definition` VALUES ('3', '7', '支出费用 >10000', '', '0', 'x > 10000', '2012-06-29 15:00:28');
INSERT INTO `app_process_definition` VALUES ('4', '8', '0 < 合同费用 <= 1000', '', '0', 'x > 0 && x <= 1000', '2012-07-15 14:30:52');
INSERT INTO `app_process_definition` VALUES ('5', '8', '1000 < 合同费用 <= 10000', '', '0', 'x > 1000 && x <= 10000', '2012-07-15 21:01:38');
INSERT INTO `app_process_definition` VALUES ('6', '3', '转正申请审批-总经理', '转正申请审批-总经理', '1', null, '2012-07-26 12:34:00');
INSERT INTO `app_process_definition` VALUES ('7', '3', '转正申请审批-总部主管', '转正申请审批-总部主管', '2', null, '2012-07-26 12:34:15');
INSERT INTO `app_process_definition` VALUES ('8', '3', '转正申请审批-校区主管', '转正申请审批-校区主管', '4', null, '2012-07-26 12:35:19');
INSERT INTO `app_process_definition` VALUES ('9', '3', '转正申请审批-校区校长', '转正申请审批-校区校长', '3', null, '2012-07-26 12:37:52');
INSERT INTO `app_process_definition` VALUES ('10', '4', '调动申请审批-总经理(in)', '调动申请审批-总经理(in)', '1', 'x == 0', '2012-07-26 12:38:45');
INSERT INTO `app_process_definition` VALUES ('11', '4', '调动申请审批-总经理(out)', '调动申请审批-总经理(out)', '1', 'x == 1', '2012-07-26 12:38:46');
INSERT INTO `app_process_definition` VALUES ('12', '4', '调动申请审批-总部主管(in)', '调动申请审批-总部主管(in)', '2', 'x == 0', '2012-07-26 12:45:16');
INSERT INTO `app_process_definition` VALUES ('13', '4', '调动申请审批-总部主管(out)', '调动申请审批-总部主管(out)', '2', 'x == 1', '2012-07-26 12:45:16');
INSERT INTO `app_process_definition` VALUES ('14', '4', '调动申请审批-校区主管(in)', '调动申请审批-校区主管(in)', '4', 'x == 0', '2012-07-26 12:45:49');
INSERT INTO `app_process_definition` VALUES ('15', '4', '调动申请审批-校区主管(out)', '调动申请审批-校区主管(out)', '4', 'x == 1', '2012-07-26 12:45:49');
INSERT INTO `app_process_definition` VALUES ('16', '4', '调动申请审批-校区校长(in)', '调动申请审批-校区校长(in)', '3', 'x == 0', '2012-07-26 12:46:28');
INSERT INTO `app_process_definition` VALUES ('17', '4', '调动申请审批-校区校长(out)', '调动申请审批-校区校长(out)', '3', 'x == 1', '2012-07-26 12:46:28');
INSERT INTO `app_process_definition` VALUES ('18', '8', '合同费用 > 10000', '', null, 'x >10000', '2012-07-26 14:41:44');
INSERT INTO `app_process_definition` VALUES ('19', '4', '调动申请审批-总部主管职位(in)', '调动申请审批-总部主管职位(in)', '8', 'x == 0', '2012-08-03 16:20:46');
INSERT INTO `app_process_definition` VALUES ('20', '4', '调动申请审批-总部主管职位(out)', '调动申请审批-总部主管职位(out)', '8', 'x == 1', '2012-08-03 16:20:46');
INSERT INTO `app_process_definition` VALUES ('21', '3', '转正申请审批-基本岗位（总部）', '转正申请审批-基本岗位（总部）', '12', null, '2012-08-07 14:44:12');
INSERT INTO `app_process_definition` VALUES ('22', '3', '转正申请审批-基本岗位（校区）', '转正申请审批-基本岗位（校区）', '13', null, '2012-08-07 14:44:33');
INSERT INTO `app_process_definition` VALUES ('23', '3', '转正申请审批-总经办职位', '转正申请审批-总经办职位', '11', null, '2012-08-07 14:44:53');
INSERT INTO `app_process_definition` VALUES ('24', '3', '转正申请审批-总部主管', '转正申请审批-总部主管', '10', null, '2012-08-07 14:45:24');
INSERT INTO `app_process_definition` VALUES ('25', '3', '转正申请审批-校区主管（校区）', '转正申请审批-校区主管（校区）', '14', null, '2012-08-07 14:46:18');
INSERT INTO `app_process_definition` VALUES ('26', '4', '调动申请审批-基本岗位（总部）(in)', '调动申请审批-基本岗位（总部）(in)', '12', 'x == 0', '2012-08-07 14:48:54');
INSERT INTO `app_process_definition` VALUES ('27', '4', '调动申请审批-基本岗位（总部）(out)', '调动申请审批-基本岗位（总部）(out)', '12', 'x == 1', '2012-08-07 14:48:54');
INSERT INTO `app_process_definition` VALUES ('28', '4', '调动申请审批-基本岗位（校区）(in)', '调动申请审批-基本岗位（校区）(in)', '13', 'x == 0', '2012-08-07 14:49:49');
INSERT INTO `app_process_definition` VALUES ('29', '4', '调动申请审批-基本岗位（校区）(out)', '调动申请审批-基本岗位（校区）(out)', '13', 'x == 1', '2012-08-07 14:49:49');
INSERT INTO `app_process_definition` VALUES ('30', '4', '调动申请审批-总经办职位(in)', '调动申请审批-总经办职位(in)', '11', 'x == 0', '2012-08-07 14:50:31');
INSERT INTO `app_process_definition` VALUES ('31', '4', '调动申请审批-总经办职位(out)', '调动申请审批-总经办职位(out)', '11', 'x == 1', '2012-08-07 14:50:31');
INSERT INTO `app_process_definition` VALUES ('32', '4', '调动申请审批-总部主管(in)', '调动申请审批-总部主管(in)', '10', 'x == 0', '2012-08-07 14:51:06');
INSERT INTO `app_process_definition` VALUES ('33', '4', '调动申请审批-总部主管(out)', '调动申请审批-总部主管(out)', '10', 'x == 1', '2012-08-07 14:51:06');
INSERT INTO `app_process_definition` VALUES ('34', '4', '调动申请审批-校区主管（校区）(in)', '调动申请审批-校区主管（校区）(in)', '14', 'x == 0', '2012-08-07 14:51:52');
INSERT INTO `app_process_definition` VALUES ('35', '4', '调动申请审批-校区主管（校区）(out)', '调动申请审批-校区主管（校区）(out)', '14', 'x == 1', '2012-08-07 14:51:52');
INSERT INTO `app_process_definition` VALUES ('36', '5', '晋升申请审批-基本岗位（总部）(in)', '晋升申请审批-基本岗位（总部）(in)', '12', 'x == 0', '2012-08-07 15:04:38');
INSERT INTO `app_process_definition` VALUES ('37', '5', '晋升申请审批-基本岗位（总部）(out)', '晋升申请审批-基本岗位（总部）(out)', '12', 'x == 1', '2012-08-07 15:04:38');
INSERT INTO `app_process_definition` VALUES ('38', '5', '晋升申请审批-基本岗位（校区）(in)', '晋升申请审批-基本岗位（校区）(in)', '13', 'x == 0', '2012-08-07 15:05:20');
INSERT INTO `app_process_definition` VALUES ('39', '5', '晋升申请审批-基本岗位（校区）(out)', '晋升申请审批-基本岗位（校区）(out)', '13', 'x == 1', '2012-08-07 15:05:20');
INSERT INTO `app_process_definition` VALUES ('40', '5', '晋升申请审批-总经办职位(in)', '晋升申请审批-总经办职位(in)', '11', 'x == 0', '2012-08-07 15:05:52');
INSERT INTO `app_process_definition` VALUES ('41', '5', '晋升申请审批-总经办职位(out)', '晋升申请审批-总经办职位(out)', '11', 'x == 1', '2012-08-07 15:05:52');
INSERT INTO `app_process_definition` VALUES ('42', '5', '晋升申请审批-总部主管(in)', '晋升申请审批-总部主管(in)', '10', 'x == 0', '2012-08-07 15:06:21');
INSERT INTO `app_process_definition` VALUES ('43', '5', '晋升申请审批-总部主管(out)', '晋升申请审批-总部主管(out)', '10', 'x == 1', '2012-08-07 15:06:21');
INSERT INTO `app_process_definition` VALUES ('44', '5', '晋升申请审批-校区主管（校区）(in)', '晋升申请审批-校区主管（校区）(in)', '14', 'x == 0', '2012-08-07 15:15:49');
INSERT INTO `app_process_definition` VALUES ('45', '5', '晋升申请审批-校区主管（校区）(out)', '晋升申请审批-校区主管（校区）(out)', '14', 'x == 1', '2012-08-07 15:15:49');
INSERT INTO `app_process_definition` VALUES ('46', '6', '离职申请审批-基本岗位（总部）', '离职申请审批-基本岗位（总部）', '12', null, '2012-08-07 15:16:17');
INSERT INTO `app_process_definition` VALUES ('47', '6', '离职申请审批-基本岗位（校区）', '离职申请审批-基本岗位（校区）', '13', null, '2012-08-07 15:16:30');
INSERT INTO `app_process_definition` VALUES ('48', '6', '离职申请审批-总经办职位', '离职申请审批-总经办职位', '11', null, '2012-08-07 15:16:45');
INSERT INTO `app_process_definition` VALUES ('49', '6', '离职申请审批-总部主管', '离职申请审批-总部主管', '10', null, '2012-08-07 15:16:57');
INSERT INTO `app_process_definition` VALUES ('50', '6', '离职申请审批-校区主管（校区）', '离职申请审批-校区主管（校区）', '14', null, '2012-08-07 15:17:15');
INSERT INTO `app_process_definition` VALUES ('51', '9', '薪资 >10000', '', null, 'x >10000', '2012-08-07 15:23:13');
INSERT INTO `app_process_definition` VALUES ('52', '9', '1000 < 薪资 <= 10000', '', null, 'x > 1000 && x <= 10000', '2012-08-07 15:24:19');
INSERT INTO `app_process_definition` VALUES ('53', '9', '0 < 薪资 <=1000', '', null, 'x > 0 && x <= 1000', '2012-08-07 15:24:53');

-- ----------------------------
-- Table structure for `app_process_form`
-- ----------------------------
DROP TABLE IF EXISTS `app_process_form`;
CREATE TABLE `app_process_form` (
  `form_id` bigint(20) NOT NULL auto_increment,
  `form_no` varchar(120) NOT NULL COMMENT '流程申请单号',
  `type_id` bigint(20) NOT NULL COMMENT '流程类型',
  `task_name` varchar(128) default NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) default NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) default NULL COMMENT '跳转节点, 跳转至下一任务',
  `seq_sn` int(11) NOT NULL COMMENT '序列编号',
  `task_type` tinyint(4) NOT NULL COMMENT '任务类型',
  `to_rolenames` varchar(250) default NULL,
  `to_distnames` varchar(250) default NULL,
  `to_depnames` varchar(250) default NULL,
  `to_posnames` varchar(250) default NULL,
  `to_usernames` varchar(250) default NULL,
  `audit_rolenames` varchar(250) default NULL,
  `audit_distnames` varchar(250) default NULL,
  `audit_depnames` varchar(250) default NULL,
  `audit_usernames` varchar(250) default NULL,
  `audit_posnames` varchar(250) default NULL,
  `to_userids` varchar(250) default NULL,
  `to_roleids` varchar(250) default NULL,
  `to_distids` varchar(250) default NULL,
  `to_depids` varchar(250) default NULL,
  `to_posids` varchar(250) default NULL,
  `audit_userids` varchar(250) default NULL,
  `audit_roleids` varchar(250) default NULL,
  `audit_distids` varchar(250) default NULL,
  `audit_depids` varchar(250) default NULL,
  `audit_posids` varchar(250) default NULL,
  `audit_date` datetime default NULL,
  `audit_state` smallint(6) default NULL COMMENT '审核状态, 1=审核中, 2=审核通过 3=审核不通过, 4=审核被退回...',
  `audit_comments` text COMMENT '审核意见',
  PRIMARY KEY  (`form_id`),
  KEY `form_no` (`form_no`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据';

-- ----------------------------
-- Records of app_process_form
-- ----------------------------
INSERT INTO `app_process_form` VALUES ('21', 'HRM20120803162335', '4', null, null, null, '1', '4', null, null, '总经办', '副总经理', null, null, null, null, null, null, null, null, null, '15', '13', null, null, null, null, null, null, '1', null);
INSERT INTO `app_process_form` VALUES ('22', 'HRM20120803162335', '4', null, null, null, '2', '4', null, null, '行政部', '行政总监', null, null, null, null, null, null, null, null, null, '24', '22', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `app_process_history`
-- ----------------------------
DROP TABLE IF EXISTS `app_process_history`;
CREATE TABLE `app_process_history` (
  `history_id` bigint(20) NOT NULL auto_increment,
  `form_no` varchar(120) NOT NULL COMMENT '流程申请单号',
  `type_id` bigint(20) NOT NULL COMMENT '流程类型',
  `task_name` varchar(128) default NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) default NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) default NULL COMMENT '跳转节点, 跳转至下一任务',
  `task_type` tinyint(4) default NULL COMMENT '任务类型',
  `seq_sn` int(11) default NULL COMMENT '序列编号',
  `to_rolenames` varchar(250) default NULL,
  `to_distnames` varchar(250) default NULL,
  `to_depnames` varchar(250) default NULL,
  `to_posnames` varchar(250) default NULL,
  `to_usernames` varchar(250) default NULL,
  `audit_rolenames` varchar(250) default NULL,
  `audit_distnames` varchar(250) default NULL,
  `audit_depnames` varchar(250) default NULL,
  `audit_usernames` varchar(250) default NULL,
  `audit_posnames` varchar(250) default NULL,
  `to_userids` varchar(250) default NULL,
  `to_roleids` varchar(250) default NULL,
  `to_distids` varchar(250) default NULL,
  `to_depids` varchar(250) default NULL,
  `to_posids` varchar(250) default NULL,
  `audit_userids` varchar(250) default NULL,
  `audit_roleids` varchar(250) default NULL,
  `audit_distids` varchar(250) default NULL,
  `audit_depids` varchar(250) default NULL,
  `audit_posids` varchar(250) default NULL,
  `audit_date` datetime default NULL,
  `audit_state` smallint(6) default NULL COMMENT '审核状态, 0=审核中, 1=审核通过 2=审核不通过',
  `audit_comments` text COMMENT '审核意见',
  PRIMARY KEY  (`history_id`),
  KEY `form_no` (`form_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据';

-- ----------------------------
-- Records of app_process_history
-- ----------------------------
INSERT INTO `app_process_history` VALUES ('4', 'FC20120803161623', '8', null, null, null, '4', null, null, null, '总经办', '副总经理', null, null, '杭州总部', '总经办', '梅杰', '副总经理', null, null, null, '15', '13', '20', null, '1', '15', '13', '2012-08-03 16:17:26', '2', '');
INSERT INTO `app_process_history` VALUES ('6', 'HRM20120803162615', '4', null, null, null, '4', null, null, null, '总经办', '副总经理', null, null, '杭州总部', '总经办', '梅杰', '副总经理', null, null, null, '15', '13', '20', null, '1', '15', '13', '2012-08-03 16:26:46', '2', '');

-- ----------------------------
-- Table structure for `app_process_task`
-- ----------------------------
DROP TABLE IF EXISTS `app_process_task`;
CREATE TABLE `app_process_task` (
  `task_id` bigint(20) NOT NULL auto_increment,
  `def_id` bigint(20) default NULL COMMENT '所属流程定义ID',
  `task_name` varchar(128) default NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) default NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) default NULL COMMENT '跳转节点, 跳转至下一任务',
  `seq_sn` int(11) NOT NULL COMMENT '序列编号',
  `to_rolenames` varchar(250) default NULL COMMENT '待审批角色名称集合',
  `to_depnames` varchar(250) default NULL COMMENT '待审批部门名称集合',
  `to_posnames` varchar(250) default NULL COMMENT '待审批职位名称集合',
  `to_usernames` varchar(250) default NULL COMMENT '待审批用户名称集合',
  `to_userids` varchar(250) default NULL COMMENT '用户IDS 格式如下，以方便使用like操作 ,1,2,',
  `to_roleids` varchar(250) default NULL COMMENT '角色IDS 格式如下，以方便使用like操作 ,1,2,',
  `to_depids` varchar(250) default NULL COMMENT '部门IDS 格式如下，以方便使用like操作 ,1,2,',
  `to_posids` varchar(250) default NULL COMMENT '岗位ID集合, 易于操作',
  `comments` text COMMENT '意见',
  `task_type` tinyint(4) default NULL COMMENT '活动类型',
  PRIMARY KEY  (`task_id`),
  KEY `def_id` (`def_id`),
  CONSTRAINT `app_process_task_ibfk_1` FOREIGN KEY (`def_id`) REFERENCES `app_process_definition` (`def_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程任务设置';

-- ----------------------------
-- Records of app_process_task
-- ----------------------------
INSERT INTO `app_process_task` VALUES ('1', '18', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('2', '5', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('3', '4', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('4', '19', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('6', '20', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('7', '21', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('8', '22', null, null, null, '1', null, '总监室', '校长', null, null, null, '18', '27', null, '2');
INSERT INTO `app_process_task` VALUES ('9', '23', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('10', '24', null, null, null, '1', null, '人资部', '人资总监', null, null, null, '26', '46', null, '4');
INSERT INTO `app_process_task` VALUES ('11', '24', null, null, null, '2', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('12', '25', null, null, null, '1', null, '总监室', '校长', null, null, null, '18', '27', null, '2');
INSERT INTO `app_process_task` VALUES ('13', '26', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('14', '27', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('15', '27', null, null, null, '2', null, '总监室', '校长', null, null, null, '18', '27', null, '5');
INSERT INTO `app_process_task` VALUES ('16', '28', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('17', '29', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('18', '30', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('19', '31', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('20', '32', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('21', '33', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('22', '33', null, null, null, '2', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('23', '34', null, null, null, '1', null, '总监室', '校长', null, null, null, '18', '27', null, '2');
INSERT INTO `app_process_task` VALUES ('24', '35', null, null, null, '1', null, '总监室', '校长', null, null, null, '18', '27', null, '2');
INSERT INTO `app_process_task` VALUES ('25', '35', null, null, null, '2', null, '总监室', '校长', null, null, null, '18', '27', null, '5');
INSERT INTO `app_process_task` VALUES ('26', '36', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('27', '37', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('28', '38', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('29', '39', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('30', '40', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('31', '41', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('32', '42', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('33', '43', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('34', '44', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('35', '45', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('36', '46', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('37', '47', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('38', '48', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('39', '49', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('40', '50', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('41', '3', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('42', '3', null, null, null, '2', null, '财务部', '财务总监', null, null, null, '17', '39', null, '4');
INSERT INTO `app_process_task` VALUES ('43', '2', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('44', '1', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('45', '53', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('46', '52', null, null, null, '1', null, '总经办', '总经理', null, null, null, '15', '26', null, '4');
INSERT INTO `app_process_task` VALUES ('47', '51', null, null, null, '1', null, '总经办', '副总经理', null, null, null, '15', '13', null, '4');
INSERT INTO `app_process_task` VALUES ('48', '51', null, null, null, '2', null, '财务部', '财务总监', null, null, null, '17', '39', null, '4');
INSERT INTO `app_process_task` VALUES ('49', '18', null, null, null, '2', null, '财务部', '财务总监', null, null, null, '17', '39', null, '4');


-- ----------------------------
-- Table structure for `app_process_type`
-- ----------------------------
DROP TABLE IF EXISTS `app_process_type`;
CREATE TABLE `app_process_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '流程分类名',
  `type_key` varchar(64) default NULL COMMENT '流程分类KEY',
  `type_desc` varchar(250) default NULL COMMENT '流程分类描述',
  `type_slug` varchar(64) NOT NULL COMMENT '分类类别',
  `type_parent` bigint(20) default NULL COMMENT '流程父分类',
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='流程分类';

-- ----------------------------
-- Records of app_process_type
-- ----------------------------
INSERT INTO `app_process_type` VALUES ('1', '费用支出申请审批', 'PROCESS_PAYMENT', null, 'finance', null);
INSERT INTO `app_process_type` VALUES ('2', '合同申请审批', 'PROCESS_CONTRACT', null, 'finance', null);
INSERT INTO `app_process_type` VALUES ('3', '转正申请审批', 'PROCESS_MEMBER_BERGULAR', null, 'hrm', null);
INSERT INTO `app_process_type` VALUES ('4', '调动申请审批', 'PROCESS_MEMBER_TRANSFER', null, 'hrm', null);
INSERT INTO `app_process_type` VALUES ('5', '晋升申请审批', 'PROCESS_MEMBER_PROMOTION', null, 'hrm', null);
INSERT INTO `app_process_type` VALUES ('6', '离职申请审批', 'PROCESS_MEMBER_FAIRWELL', null, 'hrm', null);
INSERT INTO `app_process_type` VALUES ('7', '工资薪资支出', 'PROCESS_SALARY_PAYMENT', '支付给员工薪资的审批类型...', 'finance', '1');
INSERT INTO `app_process_type` VALUES ('8', '房租合同', 'PROCESS_HOUSE_RENT', '房租合同', 'finance', '2');
INSERT INTO `app_process_type` VALUES ('9', '员工薪资', 'PROCESS_EMP_PAYROLL', '', 'finance', '1');

-- ----------------------------
-- Table structure for `app_role`
-- ----------------------------
DROP TABLE IF EXISTS `app_role`;
CREATE TABLE `app_role` (
  `role_id` int(11) NOT NULL auto_increment,
  `role_name` varchar(120) NOT NULL COMMENT '角色名称',
  `role_key` varchar(64) NOT NULL COMMENT '权限组Key',
  `role_desc` varchar(150) default NULL COMMENT '角色描述',
  `role_status` tinyint(4) default '1' COMMENT '角色状态, 1=开放, 0=被锁住',
  `role_rights` text COMMENT '权限功能列表',
  `role_type` tinyint(4) NOT NULL COMMENT '角色类型, 0=总部, 1=校区, 2=片区',
  `role_edit` tinyint(4) NOT NULL default '1' COMMENT '角色是否可以进行修改, 1=可以, 0=不可以',
  PRIMARY KEY  (`role_id`),
  UNIQUE KEY `role_key` (`role_key`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of app_role
-- ----------------------------
INSERT INTO `app_role` VALUES ('7', '基础权限（总部）', 'ROLE_EMPLOYEE_HEADOFFICE', '基础权限（总部）', '1', '_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY', '0', '1');
INSERT INTO `app_role` VALUES ('8', '基础权限(校区)', 'ROLE_EMPLOYEE_SCHOOL', '基础权限(校区)', '1', '_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW', '1', '1');
INSERT INTO `app_role` VALUES ('9', '管理员', 'ROLE_ADMIN', '', '1', '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_MYVIEW,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT,_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE,_FUNCKEY_HRM_ENTRY_OP_QUALIFY,_FUNCKEY_HRM_EMPLOYEE_REMOVE,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_EMPLOYEE_ADD,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET,_FUNCKEY_SYSTEM_DELETE_DICTIONARY,_FUNCKEY_SYSTEM_ADD_DICTIONARY,_FUNCKEY_SYSTEM_EDIT_DICTIONARY,_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE,_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD,_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT,_FUNCKEY_SYSTEM_DELETE_WORK_TIME,_FUNCKEY_SYSTEM_ADD_WORK_CONTENT,_FUNCKEY_SYSTEM_ADD_WORK_TIME,_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT,_FUNCKEY_SYSTEM_EDIT_WORK_TIME,_FUNCKEY_FLOW_HRM_PROCESS_REMOVE,_FUNCKEY_FLOW_HRM_PROCESS_REFRESH,_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE,_FUNCKEY_FLOW_HRM_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_APPROVE,_FUNCKEY_FLOW_FINAN_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REMOVE,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_ADD,_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_ADD,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_EDIT,_FUNCKEY_SYSTEM_SCHOOL_POSET_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_POSET_ADD,_FUNCKEY_SYSTEM_SCHOOL_POSET_EDIT,_FUNCKEY_SYSTEM_ROLE_REMOVE,_FUNCKEY_SYSTEM_ROLE_VIEW,_FUNCKEY_SYSTEM_ROLE_ADD,_FUNCKEY_SYSTEM_ROLE_EDIT,_FUNCKEY_SYSTEM_MENU_FUNC_REMOVE,_FUNCKEY_SYSTEM_MENU_FUNC_REFRESH,_FUNCKEY_SYSTEM_MENU_FUNC_ADD,_FUNCKEY_SYSTEM_MENU_FUNC_EDIT,_FUNCKEY_SYSTEM_MENU_REFRESH,_FUNCKEY_SYSTEM_MENU_ADD,_FUNCKEY_SYSTEM_MENU_EDIT', '0', '1');
INSERT INTO `app_role` VALUES ('14', '校区管理员', 'ROLE_SCHOOL_ADMIN', '', '1', '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_MYVIEW,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT,_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE,_FUNCKEY_HRM_ENTRY_OP_QUALIFY,_FUNCKEY_HRM_EMPLOYEE_REMOVE,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_EMPLOYEE_ADD,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET,_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE,_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD,_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT,_FUNCKEY_SYSTEM_DELETE_WORK_TIME,_FUNCKEY_SYSTEM_ADD_WORK_CONTENT,_FUNCKEY_SYSTEM_ADD_WORK_TIME,_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT,_FUNCKEY_SYSTEM_EDIT_WORK_TIME', '1', '1');
INSERT INTO `app_role` VALUES ('22', '新闻发布与管理（总部）', 'ROLE_ADMIN_NEWS_PUBLISH', '新闻发布与管理（总部）', '1', '_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_EDIT', '0', '1');
INSERT INTO `app_role` VALUES ('23', '新闻审批与管理（总部）', 'ROLE_ADMIN_NEWS_APPROVE', '', '1', '_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP', '0', '1');
INSERT INTO `app_role` VALUES ('24', '新闻查看(查看)', 'ROLE_PERSONAL_NEWS_READ', '', '1', '', '0', '1');
INSERT INTO `app_role` VALUES ('26', '任务审批与管理（总部）', 'ROLE_ADMIN_TASK_APPROVE', '对发起的任务是否通过进行审批', '1', '_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT', '0', '1');
INSERT INTO `app_role` VALUES ('27', '任务发起与管理（总部）', 'ROLE_PERSONAL_TASK_PUBLISH', '', '1', '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_MYVIEW', '0', '1');
INSERT INTO `app_role` VALUES ('28', '任务查看', 'ROLE_PERSONAL_TASK_READ', '查看用户所负责或参与的任务', '1', '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_VIEW', '0', '1');
INSERT INTO `app_role` VALUES ('29', '工作安排添加导入', 'ROLE_ADMIN_WORKPLAN_ADD', '', '1', '_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE', '0', '1');
INSERT INTO `app_role` VALUES ('30', '工作安排调整', 'ROLE_ADMIN_WORKPLAN_ADJUST', '工作安排调整、编辑、删除', '1', '_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE', '0', '1');
INSERT INTO `app_role` VALUES ('31', '工作安排查看', 'ROLE_ADMIN_WORKPLAN_READ', '工作安排查看', '1', '_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE', '0', '1');
INSERT INTO `app_role` VALUES ('32', '员工考勤操作', 'ROLE_ADMIN_ATTENDANCE_MANAGE', '员工考勤的打卡、出差、请假、旷工等操作', '1', '', '0', '1');
INSERT INTO `app_role` VALUES ('33', '文档上传与管理', 'ROLE_ADMIN_DOC_UPLOAD', '', '1', '_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_EDIT', '0', '1');
INSERT INTO `app_role` VALUES ('34', '文档查看下载', 'ROLE_PERSONAL_DOC_DOWNLOAD', '', '1', '', '0', '1');
INSERT INTO `app_role` VALUES ('35', '会议发起与管理', 'ROLE_PERSONAL_CONFERENCE_MANAGE', '会议发起、调整、取消、激活', '1', '_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE', '0', '1');
INSERT INTO `app_role` VALUES ('36', '会议总结', 'ROLE_PERSONAL_CONFERENCE_SUMMARY', '会议总结', '1', '_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE', '0', '1');
INSERT INTO `app_role` VALUES ('37', '会议查看', 'ROLE_PERSONAL_CONFERENCE_READ', '查看所参加的会议', '1', '_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE', '0', '1');
INSERT INTO `app_role` VALUES ('38', '岗位管理-发布岗位', 'ROLE_ADMIN_HRM_JOB_PUBLISH', '发布岗位', '1', '_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT', '0', '1');
INSERT INTO `app_role` VALUES ('39', '岗位管理-发布审批', 'ROLE_ADMIN_HRM_JOB_APPROVE', '', '1', '_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW', '0', '1');
INSERT INTO `app_role` VALUES ('41', '岗位管理-管理权限', 'ROLE_ADMIN_HRM_JOB_MANAGE', '岗位编辑、应聘控制', '1', '_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL', '0', '1');
INSERT INTO `app_role` VALUES ('42', '入职安排-信息查看', 'ROLE_ADMIN_HRM_ONBOARD_REVIEW', '简历查看、面试查看', '1', '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY', '0', '1');
INSERT INTO `app_role` VALUES ('43', '入职安排-入职安排', 'ROLE_ADMIN_HRM_ONBOARD', '', '1', '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY', '0', '1');
INSERT INTO `app_role` VALUES ('44', '招聘安排-页面查看', 'ROLE_ADMIN_HRM_RECRUIT_REVIEW', '', '1', '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER', '0', '1');
INSERT INTO `app_role` VALUES ('45', '招聘安排-招聘安排', 'ROLE_ADMIN_HRM_RECRUITING', '', '1', '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER', '0', '1');
INSERT INTO `app_role` VALUES ('46', '招聘安排-录用淘汰', 'ROLE_ADMIN_HRM_RECRUIT_RESULT', '录用、淘汰、未到操作', '1', '_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER', '0', '1');
INSERT INTO `app_role` VALUES ('48', '公司人才库-删除', 'ROLE_ADMIN_HRM_ARCHIVE_RESUME_REMOVE', '', '1', '_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE', '0', '1');
INSERT INTO `app_role` VALUES ('49', '公司人才库-查看', 'ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW', '', '1', '_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW', '0', '1');
INSERT INTO `app_role` VALUES ('50', '招聘入职-入职处理', 'ROLE_ADMIN_HRM_ENTRY_OP_ONBOARD', '', '1', '_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE', '0', '1');
INSERT INTO `app_role` VALUES ('51', '招聘入职-考察处理', 'ROLE_ADMIN_HRM_ENTRY_OP_QUALIFY', '', '1', '_FUNCKEY_HRM_ENTRY_OP_QUALIFY', '0', '1');
INSERT INTO `app_role` VALUES ('52', '员工档案-添加', 'ROLE_ADMIN_HRM_EMPLOYEE_ADD', '', '1', '_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_ADD', '0', '1');
INSERT INTO `app_role` VALUES ('53', '员工档案-删除', 'ROLE_ADMIN_HRM_EMPLOYEE_DELETE', '', '1', '_FUNCKEY_HRM_EMPLOYEE_REMOVE', '0', '1');
INSERT INTO `app_role` VALUES ('54', '员工档案-查看', 'ROLE_ADMIN_HRM_EMPLOYEE_VIEW', '', '1', '_FUNCKEY_HRM_EMPLOYEE_VIEW', '0', '1');
INSERT INTO `app_role` VALUES ('55', '人力发展-审批', 'ROLE_ADMIN_HRM_DEVELOP_APPROVE', '流程审批', '1', '_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_APPROVE', '0', '1');
INSERT INTO `app_role` VALUES ('56', '人力发展-审批记录查看', 'ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA', '', '1', '_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS', '0', '1');
INSERT INTO `app_role` VALUES ('57', '人力发展-落实操作', 'ROLE_ADMIN_HRM_DEVELOP_FINALIZE', '主要是针对员工, 转正、晋升、离职、调动等状态转换操作.', '1', '_FUNCKEY_HRM_DEVELOP_FINALIZE', '0', '1');
INSERT INTO `app_role` VALUES ('58', '财务-费用支出申请', 'ROLE_ADMIN_FINAN_EXPENSE_APPLY', '', '1', '_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY', '0', '1');
INSERT INTO `app_role` VALUES ('59', '财务-费用支出审核', 'ROLE_ADMIN_FINAN_EXPENSE_APPROVE', '', '1', '_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW', '0', '1');
INSERT INTO `app_role` VALUES ('60', '财务-合同申请', 'ROLE_ADMIN_FINAN_CONTRACT_APPLY', '', '1', '_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW', '0', '1');
INSERT INTO `app_role` VALUES ('61', '财务-合同审批', 'ROLE_ADMIN_FINAN_CONTRACT_APPROVE', '', '1', '_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW', '0', '1');
INSERT INTO `app_role` VALUES ('62', '用户管理', 'ROLE_ADMIN_ACCOUNT_MANAGE', '', '1', '_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET', '0', '1');
INSERT INTO `app_role` VALUES ('63', '系统日志', 'ROLE_ADMIN_SYSTEM_LOG', '', '1', '', '0', '1');
INSERT INTO `app_role` VALUES ('64', '系统设置', 'ROLE_ADMIN_SYSTEM_MANAGE', '', '1', '_FUNCKEY_SYSTEM_DELETE_DICTIONARY,_FUNCKEY_SYSTEM_ADD_DICTIONARY,_FUNCKEY_SYSTEM_EDIT_DICTIONARY,_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE,_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD,_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT,_FUNCKEY_SYSTEM_DELETE_WORK_TIME,_FUNCKEY_SYSTEM_ADD_WORK_CONTENT,_FUNCKEY_SYSTEM_ADD_WORK_TIME,_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT,_FUNCKEY_SYSTEM_EDIT_WORK_TIME,_FUNCKEY_FLOW_HRM_PROCESS_REMOVE,_FUNCKEY_FLOW_HRM_PROCESS_REFRESH,_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE,_FUNCKEY_FLOW_HRM_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_APPROVE,_FUNCKEY_FLOW_FINAN_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REMOVE,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_ADD,_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_ADD,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_EDIT,_FUNCKEY_SYSTEM_SCHOOL_POSET_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_POSET_ADD,_FUNCKEY_SYSTEM_SCHOOL_POSET_EDIT,_FUNCKEY_SYSTEM_ROLE_REMOVE,_FUNCKEY_SYSTEM_ROLE_VIEW,_FUNCKEY_SYSTEM_ROLE_ADD,_FUNCKEY_SYSTEM_ROLE_EDIT,_FUNCKEY_SYSTEM_MENU_FUNC_REMOVE,_FUNCKEY_SYSTEM_MENU_FUNC_REFRESH,_FUNCKEY_SYSTEM_MENU_FUNC_ADD,_FUNCKEY_SYSTEM_MENU_FUNC_EDIT,_FUNCKEY_SYSTEM_MENU_REFRESH,_FUNCKEY_SYSTEM_MENU_ADD,_FUNCKEY_SYSTEM_MENU_EDIT', '0', '1');

-- ----------------------------
-- Table structure for `app_role_dac`
-- ----------------------------
DROP TABLE IF EXISTS `app_role_dac`;
CREATE TABLE `app_role_dac` (
  `role_id` bigint(20) NOT NULL,
  `stg_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`role_id`,`stg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限组的数据权限';

-- ----------------------------
-- Records of app_role_dac
-- ----------------------------
INSERT INTO `app_role_dac` VALUES ('7', '20');
INSERT INTO `app_role_dac` VALUES ('7', '22');
INSERT INTO `app_role_dac` VALUES ('9', '19');
INSERT INTO `app_role_dac` VALUES ('9', '20');
INSERT INTO `app_role_dac` VALUES ('9', '21');
INSERT INTO `app_role_dac` VALUES ('9', '22');

-- ----------------------------
-- Table structure for `app_role_func`
-- ----------------------------
DROP TABLE IF EXISTS `app_role_func`;
CREATE TABLE `app_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`role_id`,`func_id`),
  KEY `role_id` (`role_id`),
  KEY `app_role_func_ibfk_2` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

-- ----------------------------
-- Records of app_role_func
-- ----------------------------
INSERT INTO `app_role_func` VALUES ('7', '32');
INSERT INTO `app_role_func` VALUES ('7', '34');
INSERT INTO `app_role_func` VALUES ('7', '35');
INSERT INTO `app_role_func` VALUES ('7', '37');
INSERT INTO `app_role_func` VALUES ('7', '73');
INSERT INTO `app_role_func` VALUES ('7', '78');
INSERT INTO `app_role_func` VALUES ('7', '88');
INSERT INTO `app_role_func` VALUES ('7', '89');
INSERT INTO `app_role_func` VALUES ('7', '90');
INSERT INTO `app_role_func` VALUES ('7', '91');
INSERT INTO `app_role_func` VALUES ('7', '98');
INSERT INTO `app_role_func` VALUES ('7', '99');
INSERT INTO `app_role_func` VALUES ('7', '106');
INSERT INTO `app_role_func` VALUES ('8', '73');
INSERT INTO `app_role_func` VALUES ('8', '78');
INSERT INTO `app_role_func` VALUES ('8', '88');
INSERT INTO `app_role_func` VALUES ('8', '89');
INSERT INTO `app_role_func` VALUES ('8', '90');
INSERT INTO `app_role_func` VALUES ('8', '91');
INSERT INTO `app_role_func` VALUES ('8', '98');
INSERT INTO `app_role_func` VALUES ('8', '99');
INSERT INTO `app_role_func` VALUES ('8', '106');
INSERT INTO `app_role_func` VALUES ('14', '5');
INSERT INTO `app_role_func` VALUES ('14', '6');
INSERT INTO `app_role_func` VALUES ('14', '7');
INSERT INTO `app_role_func` VALUES ('14', '8');
INSERT INTO `app_role_func` VALUES ('14', '9');
INSERT INTO `app_role_func` VALUES ('14', '10');
INSERT INTO `app_role_func` VALUES ('14', '11');
INSERT INTO `app_role_func` VALUES ('14', '12');
INSERT INTO `app_role_func` VALUES ('14', '13');
INSERT INTO `app_role_func` VALUES ('14', '14');
INSERT INTO `app_role_func` VALUES ('14', '15');
INSERT INTO `app_role_func` VALUES ('14', '16');
INSERT INTO `app_role_func` VALUES ('14', '17');
INSERT INTO `app_role_func` VALUES ('14', '18');
INSERT INTO `app_role_func` VALUES ('14', '19');
INSERT INTO `app_role_func` VALUES ('14', '20');
INSERT INTO `app_role_func` VALUES ('14', '21');
INSERT INTO `app_role_func` VALUES ('14', '22');
INSERT INTO `app_role_func` VALUES ('14', '23');
INSERT INTO `app_role_func` VALUES ('14', '24');
INSERT INTO `app_role_func` VALUES ('14', '25');
INSERT INTO `app_role_func` VALUES ('14', '26');
INSERT INTO `app_role_func` VALUES ('14', '27');
INSERT INTO `app_role_func` VALUES ('14', '28');
INSERT INTO `app_role_func` VALUES ('14', '29');
INSERT INTO `app_role_func` VALUES ('14', '30');
INSERT INTO `app_role_func` VALUES ('14', '31');
INSERT INTO `app_role_func` VALUES ('14', '32');
INSERT INTO `app_role_func` VALUES ('14', '33');
INSERT INTO `app_role_func` VALUES ('14', '34');
INSERT INTO `app_role_func` VALUES ('14', '35');
INSERT INTO `app_role_func` VALUES ('14', '36');
INSERT INTO `app_role_func` VALUES ('14', '37');
INSERT INTO `app_role_func` VALUES ('14', '38');
INSERT INTO `app_role_func` VALUES ('14', '39');
INSERT INTO `app_role_func` VALUES ('14', '73');
INSERT INTO `app_role_func` VALUES ('14', '74');
INSERT INTO `app_role_func` VALUES ('14', '75');
INSERT INTO `app_role_func` VALUES ('14', '76');
INSERT INTO `app_role_func` VALUES ('14', '77');
INSERT INTO `app_role_func` VALUES ('14', '78');
INSERT INTO `app_role_func` VALUES ('14', '79');
INSERT INTO `app_role_func` VALUES ('14', '80');
INSERT INTO `app_role_func` VALUES ('14', '81');
INSERT INTO `app_role_func` VALUES ('14', '82');
INSERT INTO `app_role_func` VALUES ('14', '83');
INSERT INTO `app_role_func` VALUES ('14', '84');
INSERT INTO `app_role_func` VALUES ('14', '85');
INSERT INTO `app_role_func` VALUES ('14', '86');
INSERT INTO `app_role_func` VALUES ('14', '87');
INSERT INTO `app_role_func` VALUES ('14', '88');
INSERT INTO `app_role_func` VALUES ('14', '89');
INSERT INTO `app_role_func` VALUES ('14', '90');
INSERT INTO `app_role_func` VALUES ('14', '91');
INSERT INTO `app_role_func` VALUES ('14', '92');
INSERT INTO `app_role_func` VALUES ('14', '93');
INSERT INTO `app_role_func` VALUES ('14', '94');
INSERT INTO `app_role_func` VALUES ('14', '95');
INSERT INTO `app_role_func` VALUES ('14', '96');
INSERT INTO `app_role_func` VALUES ('14', '97');
INSERT INTO `app_role_func` VALUES ('14', '98');
INSERT INTO `app_role_func` VALUES ('14', '99');
INSERT INTO `app_role_func` VALUES ('14', '102');
INSERT INTO `app_role_func` VALUES ('14', '103');
INSERT INTO `app_role_func` VALUES ('14', '104');
INSERT INTO `app_role_func` VALUES ('14', '105');
INSERT INTO `app_role_func` VALUES ('14', '106');
INSERT INTO `app_role_func` VALUES ('14', '107');
INSERT INTO `app_role_func` VALUES ('14', '108');
INSERT INTO `app_role_func` VALUES ('14', '109');
INSERT INTO `app_role_func` VALUES ('14', '110');
INSERT INTO `app_role_func` VALUES ('14', '111');
INSERT INTO `app_role_func` VALUES ('14', '112');
INSERT INTO `app_role_func` VALUES ('14', '113');
INSERT INTO `app_role_func` VALUES ('14', '114');
INSERT INTO `app_role_func` VALUES ('14', '119');
INSERT INTO `app_role_func` VALUES ('14', '120');
INSERT INTO `app_role_func` VALUES ('14', '121');
INSERT INTO `app_role_func` VALUES ('14', '122');
INSERT INTO `app_role_func` VALUES ('14', '123');
INSERT INTO `app_role_func` VALUES ('14', '124');
INSERT INTO `app_role_func` VALUES ('14', '125');
INSERT INTO `app_role_func` VALUES ('14', '126');
INSERT INTO `app_role_func` VALUES ('14', '127');
INSERT INTO `app_role_func` VALUES ('14', '128');
INSERT INTO `app_role_func` VALUES ('14', '129');
INSERT INTO `app_role_func` VALUES ('14', '130');
INSERT INTO `app_role_func` VALUES ('14', '131');
INSERT INTO `app_role_func` VALUES ('14', '132');
INSERT INTO `app_role_func` VALUES ('14', '133');
INSERT INTO `app_role_func` VALUES ('14', '134');
INSERT INTO `app_role_func` VALUES ('14', '135');
INSERT INTO `app_role_func` VALUES ('14', '136');
INSERT INTO `app_role_func` VALUES ('14', '137');
INSERT INTO `app_role_func` VALUES ('14', '138');
INSERT INTO `app_role_func` VALUES ('22', '127');
INSERT INTO `app_role_func` VALUES ('22', '128');
INSERT INTO `app_role_func` VALUES ('22', '129');
INSERT INTO `app_role_func` VALUES ('23', '130');
INSERT INTO `app_role_func` VALUES ('23', '131');
INSERT INTO `app_role_func` VALUES ('23', '132');
INSERT INTO `app_role_func` VALUES ('26', '92');
INSERT INTO `app_role_func` VALUES ('26', '93');
INSERT INTO `app_role_func` VALUES ('26', '94');
INSERT INTO `app_role_func` VALUES ('26', '95');
INSERT INTO `app_role_func` VALUES ('27', '79');
INSERT INTO `app_role_func` VALUES ('27', '80');
INSERT INTO `app_role_func` VALUES ('27', '81');
INSERT INTO `app_role_func` VALUES ('27', '82');
INSERT INTO `app_role_func` VALUES ('27', '85');
INSERT INTO `app_role_func` VALUES ('27', '86');
INSERT INTO `app_role_func` VALUES ('28', '78');
INSERT INTO `app_role_func` VALUES ('28', '83');
INSERT INTO `app_role_func` VALUES ('28', '84');
INSERT INTO `app_role_func` VALUES ('29', '109');
INSERT INTO `app_role_func` VALUES ('29', '112');
INSERT INTO `app_role_func` VALUES ('30', '110');
INSERT INTO `app_role_func` VALUES ('30', '111');
INSERT INTO `app_role_func` VALUES ('30', '113');
INSERT INTO `app_role_func` VALUES ('31', '114');
INSERT INTO `app_role_func` VALUES ('33', '133');
INSERT INTO `app_role_func` VALUES ('33', '134');
INSERT INTO `app_role_func` VALUES ('33', '135');
INSERT INTO `app_role_func` VALUES ('35', '102');
INSERT INTO `app_role_func` VALUES ('35', '103');
INSERT INTO `app_role_func` VALUES ('35', '104');
INSERT INTO `app_role_func` VALUES ('35', '105');
INSERT INTO `app_role_func` VALUES ('35', '106');
INSERT INTO `app_role_func` VALUES ('35', '107');
INSERT INTO `app_role_func` VALUES ('36', '102');
INSERT INTO `app_role_func` VALUES ('36', '106');
INSERT INTO `app_role_func` VALUES ('36', '108');
INSERT INTO `app_role_func` VALUES ('37', '106');
INSERT INTO `app_role_func` VALUES ('38', '5');
INSERT INTO `app_role_func` VALUES ('38', '6');
INSERT INTO `app_role_func` VALUES ('38', '7');
INSERT INTO `app_role_func` VALUES ('39', '5');
INSERT INTO `app_role_func` VALUES ('39', '13');
INSERT INTO `app_role_func` VALUES ('41', '5');
INSERT INTO `app_role_func` VALUES ('41', '7');
INSERT INTO `app_role_func` VALUES ('41', '8');
INSERT INTO `app_role_func` VALUES ('42', '9');
INSERT INTO `app_role_func` VALUES ('42', '10');
INSERT INTO `app_role_func` VALUES ('42', '11');
INSERT INTO `app_role_func` VALUES ('43', '9');
INSERT INTO `app_role_func` VALUES ('43', '12');
INSERT INTO `app_role_func` VALUES ('44', '14');
INSERT INTO `app_role_func` VALUES ('44', '15');
INSERT INTO `app_role_func` VALUES ('44', '16');
INSERT INTO `app_role_func` VALUES ('45', '14');
INSERT INTO `app_role_func` VALUES ('45', '20');
INSERT INTO `app_role_func` VALUES ('46', '14');
INSERT INTO `app_role_func` VALUES ('46', '17');
INSERT INTO `app_role_func` VALUES ('46', '18');
INSERT INTO `app_role_func` VALUES ('46', '19');
INSERT INTO `app_role_func` VALUES ('48', '22');
INSERT INTO `app_role_func` VALUES ('49', '21');
INSERT INTO `app_role_func` VALUES ('50', '23');
INSERT INTO `app_role_func` VALUES ('50', '24');
INSERT INTO `app_role_func` VALUES ('51', '25');
INSERT INTO `app_role_func` VALUES ('52', '26');
INSERT INTO `app_role_func` VALUES ('52', '29');
INSERT INTO `app_role_func` VALUES ('53', '27');
INSERT INTO `app_role_func` VALUES ('54', '28');
INSERT INTO `app_role_func` VALUES ('55', '31');
INSERT INTO `app_role_func` VALUES ('55', '96');
INSERT INTO `app_role_func` VALUES ('56', '97');
INSERT INTO `app_role_func` VALUES ('57', '30');
INSERT INTO `app_role_func` VALUES ('58', '32');
INSERT INTO `app_role_func` VALUES ('58', '33');
INSERT INTO `app_role_func` VALUES ('59', '34');
INSERT INTO `app_role_func` VALUES ('59', '38');
INSERT INTO `app_role_func` VALUES ('60', '35');
INSERT INTO `app_role_func` VALUES ('60', '36');
INSERT INTO `app_role_func` VALUES ('61', '37');
INSERT INTO `app_role_func` VALUES ('61', '39');
INSERT INTO `app_role_func` VALUES ('62', '136');
INSERT INTO `app_role_func` VALUES ('62', '137');
INSERT INTO `app_role_func` VALUES ('62', '138');
INSERT INTO `app_role_func` VALUES ('64', '40');
INSERT INTO `app_role_func` VALUES ('64', '41');
INSERT INTO `app_role_func` VALUES ('64', '42');
INSERT INTO `app_role_func` VALUES ('64', '43');
INSERT INTO `app_role_func` VALUES ('64', '44');
INSERT INTO `app_role_func` VALUES ('64', '45');
INSERT INTO `app_role_func` VALUES ('64', '46');
INSERT INTO `app_role_func` VALUES ('64', '47');
INSERT INTO `app_role_func` VALUES ('64', '48');
INSERT INTO `app_role_func` VALUES ('64', '49');
INSERT INTO `app_role_func` VALUES ('64', '50');
INSERT INTO `app_role_func` VALUES ('64', '51');
INSERT INTO `app_role_func` VALUES ('64', '52');
INSERT INTO `app_role_func` VALUES ('64', '53');
INSERT INTO `app_role_func` VALUES ('64', '54');
INSERT INTO `app_role_func` VALUES ('64', '55');
INSERT INTO `app_role_func` VALUES ('64', '56');
INSERT INTO `app_role_func` VALUES ('64', '57');
INSERT INTO `app_role_func` VALUES ('64', '58');
INSERT INTO `app_role_func` VALUES ('64', '59');
INSERT INTO `app_role_func` VALUES ('64', '60');
INSERT INTO `app_role_func` VALUES ('64', '61');
INSERT INTO `app_role_func` VALUES ('64', '62');
INSERT INTO `app_role_func` VALUES ('64', '63');
INSERT INTO `app_role_func` VALUES ('64', '64');
INSERT INTO `app_role_func` VALUES ('64', '65');
INSERT INTO `app_role_func` VALUES ('64', '66');
INSERT INTO `app_role_func` VALUES ('64', '67');
INSERT INTO `app_role_func` VALUES ('64', '68');
INSERT INTO `app_role_func` VALUES ('64', '69');
INSERT INTO `app_role_func` VALUES ('64', '70');
INSERT INTO `app_role_func` VALUES ('64', '71');
INSERT INTO `app_role_func` VALUES ('64', '72');
INSERT INTO `app_role_func` VALUES ('64', '100');
INSERT INTO `app_role_func` VALUES ('64', '101');
INSERT INTO `app_role_func` VALUES ('64', '115');
INSERT INTO `app_role_func` VALUES ('64', '116');
INSERT INTO `app_role_func` VALUES ('64', '117');
INSERT INTO `app_role_func` VALUES ('64', '119');
INSERT INTO `app_role_func` VALUES ('64', '120');
INSERT INTO `app_role_func` VALUES ('64', '121');
INSERT INTO `app_role_func` VALUES ('64', '122');
INSERT INTO `app_role_func` VALUES ('64', '123');
INSERT INTO `app_role_func` VALUES ('64', '124');
INSERT INTO `app_role_func` VALUES ('64', '125');
INSERT INTO `app_role_func` VALUES ('64', '126');
INSERT INTO `app_role_func` VALUES ('65', '5');
INSERT INTO `app_role_func` VALUES ('65', '6');
INSERT INTO `app_role_func` VALUES ('65', '7');
INSERT INTO `app_role_func` VALUES ('65', '8');
INSERT INTO `app_role_func` VALUES ('65', '9');
INSERT INTO `app_role_func` VALUES ('65', '10');
INSERT INTO `app_role_func` VALUES ('65', '11');
INSERT INTO `app_role_func` VALUES ('65', '12');
INSERT INTO `app_role_func` VALUES ('65', '13');
INSERT INTO `app_role_func` VALUES ('65', '14');
INSERT INTO `app_role_func` VALUES ('65', '15');
INSERT INTO `app_role_func` VALUES ('65', '16');
INSERT INTO `app_role_func` VALUES ('65', '17');
INSERT INTO `app_role_func` VALUES ('65', '18');
INSERT INTO `app_role_func` VALUES ('65', '19');
INSERT INTO `app_role_func` VALUES ('65', '20');
INSERT INTO `app_role_func` VALUES ('65', '21');
INSERT INTO `app_role_func` VALUES ('65', '22');
INSERT INTO `app_role_func` VALUES ('65', '23');
INSERT INTO `app_role_func` VALUES ('65', '24');
INSERT INTO `app_role_func` VALUES ('65', '25');
INSERT INTO `app_role_func` VALUES ('65', '26');
INSERT INTO `app_role_func` VALUES ('65', '27');
INSERT INTO `app_role_func` VALUES ('65', '28');
INSERT INTO `app_role_func` VALUES ('65', '29');
INSERT INTO `app_role_func` VALUES ('65', '30');
INSERT INTO `app_role_func` VALUES ('65', '31');
INSERT INTO `app_role_func` VALUES ('65', '32');
INSERT INTO `app_role_func` VALUES ('65', '33');
INSERT INTO `app_role_func` VALUES ('65', '34');
INSERT INTO `app_role_func` VALUES ('65', '35');
INSERT INTO `app_role_func` VALUES ('65', '36');
INSERT INTO `app_role_func` VALUES ('65', '37');
INSERT INTO `app_role_func` VALUES ('65', '38');
INSERT INTO `app_role_func` VALUES ('65', '39');
INSERT INTO `app_role_func` VALUES ('65', '40');
INSERT INTO `app_role_func` VALUES ('65', '41');
INSERT INTO `app_role_func` VALUES ('65', '42');
INSERT INTO `app_role_func` VALUES ('65', '43');
INSERT INTO `app_role_func` VALUES ('65', '44');
INSERT INTO `app_role_func` VALUES ('65', '45');
INSERT INTO `app_role_func` VALUES ('65', '46');
INSERT INTO `app_role_func` VALUES ('65', '47');
INSERT INTO `app_role_func` VALUES ('65', '48');
INSERT INTO `app_role_func` VALUES ('65', '49');
INSERT INTO `app_role_func` VALUES ('65', '50');
INSERT INTO `app_role_func` VALUES ('65', '51');
INSERT INTO `app_role_func` VALUES ('65', '52');
INSERT INTO `app_role_func` VALUES ('65', '53');
INSERT INTO `app_role_func` VALUES ('65', '54');
INSERT INTO `app_role_func` VALUES ('65', '55');
INSERT INTO `app_role_func` VALUES ('65', '56');
INSERT INTO `app_role_func` VALUES ('65', '57');
INSERT INTO `app_role_func` VALUES ('65', '58');
INSERT INTO `app_role_func` VALUES ('65', '59');
INSERT INTO `app_role_func` VALUES ('65', '60');
INSERT INTO `app_role_func` VALUES ('65', '61');
INSERT INTO `app_role_func` VALUES ('65', '62');
INSERT INTO `app_role_func` VALUES ('65', '63');
INSERT INTO `app_role_func` VALUES ('65', '64');
INSERT INTO `app_role_func` VALUES ('65', '65');
INSERT INTO `app_role_func` VALUES ('65', '66');
INSERT INTO `app_role_func` VALUES ('65', '67');
INSERT INTO `app_role_func` VALUES ('65', '68');
INSERT INTO `app_role_func` VALUES ('65', '69');
INSERT INTO `app_role_func` VALUES ('65', '70');
INSERT INTO `app_role_func` VALUES ('65', '71');
INSERT INTO `app_role_func` VALUES ('65', '72');
INSERT INTO `app_role_func` VALUES ('65', '73');
INSERT INTO `app_role_func` VALUES ('65', '74');
INSERT INTO `app_role_func` VALUES ('65', '75');
INSERT INTO `app_role_func` VALUES ('65', '76');
INSERT INTO `app_role_func` VALUES ('65', '77');
INSERT INTO `app_role_func` VALUES ('65', '78');
INSERT INTO `app_role_func` VALUES ('65', '79');
INSERT INTO `app_role_func` VALUES ('65', '80');
INSERT INTO `app_role_func` VALUES ('65', '81');
INSERT INTO `app_role_func` VALUES ('65', '82');
INSERT INTO `app_role_func` VALUES ('65', '83');
INSERT INTO `app_role_func` VALUES ('65', '84');
INSERT INTO `app_role_func` VALUES ('65', '85');
INSERT INTO `app_role_func` VALUES ('65', '86');
INSERT INTO `app_role_func` VALUES ('65', '87');
INSERT INTO `app_role_func` VALUES ('65', '88');
INSERT INTO `app_role_func` VALUES ('65', '89');
INSERT INTO `app_role_func` VALUES ('65', '90');
INSERT INTO `app_role_func` VALUES ('65', '91');
INSERT INTO `app_role_func` VALUES ('65', '92');
INSERT INTO `app_role_func` VALUES ('65', '93');
INSERT INTO `app_role_func` VALUES ('65', '94');
INSERT INTO `app_role_func` VALUES ('65', '95');
INSERT INTO `app_role_func` VALUES ('65', '96');
INSERT INTO `app_role_func` VALUES ('65', '97');
INSERT INTO `app_role_func` VALUES ('65', '98');
INSERT INTO `app_role_func` VALUES ('65', '99');
INSERT INTO `app_role_func` VALUES ('65', '100');
INSERT INTO `app_role_func` VALUES ('65', '101');
INSERT INTO `app_role_func` VALUES ('65', '102');
INSERT INTO `app_role_func` VALUES ('65', '103');
INSERT INTO `app_role_func` VALUES ('65', '104');
INSERT INTO `app_role_func` VALUES ('65', '105');
INSERT INTO `app_role_func` VALUES ('65', '106');
INSERT INTO `app_role_func` VALUES ('65', '107');
INSERT INTO `app_role_func` VALUES ('65', '108');
INSERT INTO `app_role_func` VALUES ('65', '109');
INSERT INTO `app_role_func` VALUES ('65', '110');
INSERT INTO `app_role_func` VALUES ('65', '111');
INSERT INTO `app_role_func` VALUES ('65', '112');
INSERT INTO `app_role_func` VALUES ('65', '113');
INSERT INTO `app_role_func` VALUES ('65', '114');
INSERT INTO `app_role_func` VALUES ('65', '115');
INSERT INTO `app_role_func` VALUES ('65', '116');
INSERT INTO `app_role_func` VALUES ('65', '117');
INSERT INTO `app_role_func` VALUES ('65', '119');
INSERT INTO `app_role_func` VALUES ('65', '120');
INSERT INTO `app_role_func` VALUES ('65', '121');
INSERT INTO `app_role_func` VALUES ('65', '122');
INSERT INTO `app_role_func` VALUES ('65', '123');
INSERT INTO `app_role_func` VALUES ('65', '124');
INSERT INTO `app_role_func` VALUES ('65', '125');
INSERT INTO `app_role_func` VALUES ('65', '126');
INSERT INTO `app_role_func` VALUES ('65', '127');
INSERT INTO `app_role_func` VALUES ('65', '128');
INSERT INTO `app_role_func` VALUES ('65', '129');
INSERT INTO `app_role_func` VALUES ('65', '130');
INSERT INTO `app_role_func` VALUES ('65', '131');
INSERT INTO `app_role_func` VALUES ('65', '132');
INSERT INTO `app_role_func` VALUES ('65', '133');
INSERT INTO `app_role_func` VALUES ('65', '134');
INSERT INTO `app_role_func` VALUES ('65', '135');
INSERT INTO `app_role_func` VALUES ('65', '136');
INSERT INTO `app_role_func` VALUES ('65', '137');
INSERT INTO `app_role_func` VALUES ('65', '138');

-- ----------------------------
-- Table structure for `app_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `app_role_menu`;
CREATE TABLE `app_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单';

-- ----------------------------
-- Records of app_role_menu
-- ----------------------------
INSERT INTO `app_role_menu` VALUES ('7', '3');
INSERT INTO `app_role_menu` VALUES ('7', '4');
INSERT INTO `app_role_menu` VALUES ('7', '5');
INSERT INTO `app_role_menu` VALUES ('7', '6');
INSERT INTO `app_role_menu` VALUES ('7', '7');
INSERT INTO `app_role_menu` VALUES ('7', '9');
INSERT INTO `app_role_menu` VALUES ('7', '29');
INSERT INTO `app_role_menu` VALUES ('7', '30');
INSERT INTO `app_role_menu` VALUES ('7', '32');
INSERT INTO `app_role_menu` VALUES ('7', '35');
INSERT INTO `app_role_menu` VALUES ('7', '37');
INSERT INTO `app_role_menu` VALUES ('8', '3');
INSERT INTO `app_role_menu` VALUES ('8', '4');
INSERT INTO `app_role_menu` VALUES ('8', '9');
INSERT INTO `app_role_menu` VALUES ('8', '25');
INSERT INTO `app_role_menu` VALUES ('8', '32');
INSERT INTO `app_role_menu` VALUES ('8', '33');
INSERT INTO `app_role_menu` VALUES ('8', '34');
INSERT INTO `app_role_menu` VALUES ('8', '35');
INSERT INTO `app_role_menu` VALUES ('8', '37');
INSERT INTO `app_role_menu` VALUES ('14', '3');
INSERT INTO `app_role_menu` VALUES ('14', '4');
INSERT INTO `app_role_menu` VALUES ('14', '5');
INSERT INTO `app_role_menu` VALUES ('14', '6');
INSERT INTO `app_role_menu` VALUES ('14', '7');
INSERT INTO `app_role_menu` VALUES ('14', '8');
INSERT INTO `app_role_menu` VALUES ('14', '9');
INSERT INTO `app_role_menu` VALUES ('14', '10');
INSERT INTO `app_role_menu` VALUES ('14', '12');
INSERT INTO `app_role_menu` VALUES ('14', '17');
INSERT INTO `app_role_menu` VALUES ('14', '18');
INSERT INTO `app_role_menu` VALUES ('14', '19');
INSERT INTO `app_role_menu` VALUES ('14', '25');
INSERT INTO `app_role_menu` VALUES ('14', '26');
INSERT INTO `app_role_menu` VALUES ('14', '27');
INSERT INTO `app_role_menu` VALUES ('14', '28');
INSERT INTO `app_role_menu` VALUES ('14', '29');
INSERT INTO `app_role_menu` VALUES ('14', '30');
INSERT INTO `app_role_menu` VALUES ('14', '31');
INSERT INTO `app_role_menu` VALUES ('14', '32');
INSERT INTO `app_role_menu` VALUES ('14', '33');
INSERT INTO `app_role_menu` VALUES ('14', '34');
INSERT INTO `app_role_menu` VALUES ('14', '35');
INSERT INTO `app_role_menu` VALUES ('14', '36');
INSERT INTO `app_role_menu` VALUES ('14', '37');
INSERT INTO `app_role_menu` VALUES ('14', '38');
INSERT INTO `app_role_menu` VALUES ('14', '39');
INSERT INTO `app_role_menu` VALUES ('14', '40');
INSERT INTO `app_role_menu` VALUES ('14', '41');
INSERT INTO `app_role_menu` VALUES ('14', '42');
INSERT INTO `app_role_menu` VALUES ('14', '43');
INSERT INTO `app_role_menu` VALUES ('14', '44');
INSERT INTO `app_role_menu` VALUES ('14', '45');
INSERT INTO `app_role_menu` VALUES ('14', '46');
INSERT INTO `app_role_menu` VALUES ('14', '47');
INSERT INTO `app_role_menu` VALUES ('14', '48');
INSERT INTO `app_role_menu` VALUES ('14', '49');
INSERT INTO `app_role_menu` VALUES ('14', '50');
INSERT INTO `app_role_menu` VALUES ('14', '51');
INSERT INTO `app_role_menu` VALUES ('22', '17');
INSERT INTO `app_role_menu` VALUES ('22', '39');
INSERT INTO `app_role_menu` VALUES ('23', '17');
INSERT INTO `app_role_menu` VALUES ('23', '39');
INSERT INTO `app_role_menu` VALUES ('24', '3');
INSERT INTO `app_role_menu` VALUES ('24', '33');
INSERT INTO `app_role_menu` VALUES ('26', '17');
INSERT INTO `app_role_menu` VALUES ('26', '40');
INSERT INTO `app_role_menu` VALUES ('27', '3');
INSERT INTO `app_role_menu` VALUES ('27', '4');
INSERT INTO `app_role_menu` VALUES ('28', '3');
INSERT INTO `app_role_menu` VALUES ('28', '4');
INSERT INTO `app_role_menu` VALUES ('29', '17');
INSERT INTO `app_role_menu` VALUES ('29', '41');
INSERT INTO `app_role_menu` VALUES ('29', '43');
INSERT INTO `app_role_menu` VALUES ('30', '17');
INSERT INTO `app_role_menu` VALUES ('30', '41');
INSERT INTO `app_role_menu` VALUES ('30', '43');
INSERT INTO `app_role_menu` VALUES ('31', '17');
INSERT INTO `app_role_menu` VALUES ('31', '41');
INSERT INTO `app_role_menu` VALUES ('31', '43');
INSERT INTO `app_role_menu` VALUES ('32', '17');
INSERT INTO `app_role_menu` VALUES ('32', '41');
INSERT INTO `app_role_menu` VALUES ('32', '44');
INSERT INTO `app_role_menu` VALUES ('33', '17');
INSERT INTO `app_role_menu` VALUES ('33', '42');
INSERT INTO `app_role_menu` VALUES ('34', '3');
INSERT INTO `app_role_menu` VALUES ('34', '34');
INSERT INTO `app_role_menu` VALUES ('35', '3');
INSERT INTO `app_role_menu` VALUES ('35', '32');
INSERT INTO `app_role_menu` VALUES ('36', '3');
INSERT INTO `app_role_menu` VALUES ('36', '32');
INSERT INTO `app_role_menu` VALUES ('37', '3');
INSERT INTO `app_role_menu` VALUES ('37', '32');
INSERT INTO `app_role_menu` VALUES ('38', '8');
INSERT INTO `app_role_menu` VALUES ('38', '45');
INSERT INTO `app_role_menu` VALUES ('38', '48');
INSERT INTO `app_role_menu` VALUES ('39', '8');
INSERT INTO `app_role_menu` VALUES ('39', '45');
INSERT INTO `app_role_menu` VALUES ('39', '48');
INSERT INTO `app_role_menu` VALUES ('41', '8');
INSERT INTO `app_role_menu` VALUES ('41', '45');
INSERT INTO `app_role_menu` VALUES ('41', '48');
INSERT INTO `app_role_menu` VALUES ('42', '8');
INSERT INTO `app_role_menu` VALUES ('42', '45');
INSERT INTO `app_role_menu` VALUES ('42', '48');
INSERT INTO `app_role_menu` VALUES ('43', '8');
INSERT INTO `app_role_menu` VALUES ('43', '45');
INSERT INTO `app_role_menu` VALUES ('43', '48');
INSERT INTO `app_role_menu` VALUES ('44', '8');
INSERT INTO `app_role_menu` VALUES ('44', '45');
INSERT INTO `app_role_menu` VALUES ('44', '48');
INSERT INTO `app_role_menu` VALUES ('45', '8');
INSERT INTO `app_role_menu` VALUES ('45', '45');
INSERT INTO `app_role_menu` VALUES ('45', '48');
INSERT INTO `app_role_menu` VALUES ('46', '8');
INSERT INTO `app_role_menu` VALUES ('46', '45');
INSERT INTO `app_role_menu` VALUES ('46', '46');
INSERT INTO `app_role_menu` VALUES ('46', '48');
INSERT INTO `app_role_menu` VALUES ('46', '49');
INSERT INTO `app_role_menu` VALUES ('46', '50');
INSERT INTO `app_role_menu` VALUES ('46', '51');
INSERT INTO `app_role_menu` VALUES ('48', '8');
INSERT INTO `app_role_menu` VALUES ('48', '45');
INSERT INTO `app_role_menu` VALUES ('48', '49');
INSERT INTO `app_role_menu` VALUES ('49', '8');
INSERT INTO `app_role_menu` VALUES ('49', '45');
INSERT INTO `app_role_menu` VALUES ('49', '49');
INSERT INTO `app_role_menu` VALUES ('50', '8');
INSERT INTO `app_role_menu` VALUES ('50', '46');
INSERT INTO `app_role_menu` VALUES ('50', '50');
INSERT INTO `app_role_menu` VALUES ('51', '8');
INSERT INTO `app_role_menu` VALUES ('51', '46');
INSERT INTO `app_role_menu` VALUES ('51', '50');
INSERT INTO `app_role_menu` VALUES ('52', '8');
INSERT INTO `app_role_menu` VALUES ('52', '45');
INSERT INTO `app_role_menu` VALUES ('52', '46');
INSERT INTO `app_role_menu` VALUES ('52', '48');
INSERT INTO `app_role_menu` VALUES ('52', '49');
INSERT INTO `app_role_menu` VALUES ('52', '50');
INSERT INTO `app_role_menu` VALUES ('52', '51');
INSERT INTO `app_role_menu` VALUES ('53', '8');
INSERT INTO `app_role_menu` VALUES ('53', '46');
INSERT INTO `app_role_menu` VALUES ('53', '51');
INSERT INTO `app_role_menu` VALUES ('54', '8');
INSERT INTO `app_role_menu` VALUES ('54', '46');
INSERT INTO `app_role_menu` VALUES ('54', '51');
INSERT INTO `app_role_menu` VALUES ('55', '8');
INSERT INTO `app_role_menu` VALUES ('55', '47');
INSERT INTO `app_role_menu` VALUES ('56', '8');
INSERT INTO `app_role_menu` VALUES ('56', '47');
INSERT INTO `app_role_menu` VALUES ('57', '8');
INSERT INTO `app_role_menu` VALUES ('57', '47');
INSERT INTO `app_role_menu` VALUES ('58', '5');
INSERT INTO `app_role_menu` VALUES ('58', '6');
INSERT INTO `app_role_menu` VALUES ('58', '7');
INSERT INTO `app_role_menu` VALUES ('59', '5');
INSERT INTO `app_role_menu` VALUES ('59', '6');
INSERT INTO `app_role_menu` VALUES ('59', '7');
INSERT INTO `app_role_menu` VALUES ('59', '28');
INSERT INTO `app_role_menu` VALUES ('60', '5');
INSERT INTO `app_role_menu` VALUES ('60', '29');
INSERT INTO `app_role_menu` VALUES ('60', '30');
INSERT INTO `app_role_menu` VALUES ('61', '5');
INSERT INTO `app_role_menu` VALUES ('61', '29');
INSERT INTO `app_role_menu` VALUES ('61', '30');
INSERT INTO `app_role_menu` VALUES ('61', '31');
INSERT INTO `app_role_menu` VALUES ('62', '9');
INSERT INTO `app_role_menu` VALUES ('62', '26');
INSERT INTO `app_role_menu` VALUES ('63', '9');
INSERT INTO `app_role_menu` VALUES ('63', '27');
INSERT INTO `app_role_menu` VALUES ('64', '10');
INSERT INTO `app_role_menu` VALUES ('64', '11');
INSERT INTO `app_role_menu` VALUES ('64', '12');
INSERT INTO `app_role_menu` VALUES ('64', '13');
INSERT INTO `app_role_menu` VALUES ('64', '14');
INSERT INTO `app_role_menu` VALUES ('64', '15');
INSERT INTO `app_role_menu` VALUES ('64', '16');
INSERT INTO `app_role_menu` VALUES ('64', '18');
INSERT INTO `app_role_menu` VALUES ('64', '19');
INSERT INTO `app_role_menu` VALUES ('64', '20');
INSERT INTO `app_role_menu` VALUES ('64', '21');
INSERT INTO `app_role_menu` VALUES ('64', '22');
INSERT INTO `app_role_menu` VALUES ('64', '23');
INSERT INTO `app_role_menu` VALUES ('64', '24');
INSERT INTO `app_role_menu` VALUES ('65', '3');
INSERT INTO `app_role_menu` VALUES ('65', '4');
INSERT INTO `app_role_menu` VALUES ('65', '5');
INSERT INTO `app_role_menu` VALUES ('65', '6');
INSERT INTO `app_role_menu` VALUES ('65', '7');
INSERT INTO `app_role_menu` VALUES ('65', '8');
INSERT INTO `app_role_menu` VALUES ('65', '9');
INSERT INTO `app_role_menu` VALUES ('65', '10');
INSERT INTO `app_role_menu` VALUES ('65', '11');
INSERT INTO `app_role_menu` VALUES ('65', '12');
INSERT INTO `app_role_menu` VALUES ('65', '13');
INSERT INTO `app_role_menu` VALUES ('65', '14');
INSERT INTO `app_role_menu` VALUES ('65', '15');
INSERT INTO `app_role_menu` VALUES ('65', '16');
INSERT INTO `app_role_menu` VALUES ('65', '17');
INSERT INTO `app_role_menu` VALUES ('65', '18');
INSERT INTO `app_role_menu` VALUES ('65', '19');
INSERT INTO `app_role_menu` VALUES ('65', '20');
INSERT INTO `app_role_menu` VALUES ('65', '21');
INSERT INTO `app_role_menu` VALUES ('65', '22');
INSERT INTO `app_role_menu` VALUES ('65', '23');
INSERT INTO `app_role_menu` VALUES ('65', '24');
INSERT INTO `app_role_menu` VALUES ('65', '25');
INSERT INTO `app_role_menu` VALUES ('65', '26');
INSERT INTO `app_role_menu` VALUES ('65', '27');
INSERT INTO `app_role_menu` VALUES ('65', '28');
INSERT INTO `app_role_menu` VALUES ('65', '29');
INSERT INTO `app_role_menu` VALUES ('65', '30');
INSERT INTO `app_role_menu` VALUES ('65', '31');
INSERT INTO `app_role_menu` VALUES ('65', '32');
INSERT INTO `app_role_menu` VALUES ('65', '33');
INSERT INTO `app_role_menu` VALUES ('65', '34');
INSERT INTO `app_role_menu` VALUES ('65', '35');
INSERT INTO `app_role_menu` VALUES ('65', '36');
INSERT INTO `app_role_menu` VALUES ('65', '37');
INSERT INTO `app_role_menu` VALUES ('65', '38');
INSERT INTO `app_role_menu` VALUES ('65', '39');
INSERT INTO `app_role_menu` VALUES ('65', '40');
INSERT INTO `app_role_menu` VALUES ('65', '41');
INSERT INTO `app_role_menu` VALUES ('65', '42');
INSERT INTO `app_role_menu` VALUES ('65', '43');
INSERT INTO `app_role_menu` VALUES ('65', '44');
INSERT INTO `app_role_menu` VALUES ('65', '45');
INSERT INTO `app_role_menu` VALUES ('65', '46');
INSERT INTO `app_role_menu` VALUES ('65', '47');
INSERT INTO `app_role_menu` VALUES ('65', '48');
INSERT INTO `app_role_menu` VALUES ('65', '49');
INSERT INTO `app_role_menu` VALUES ('65', '50');
INSERT INTO `app_role_menu` VALUES ('65', '51');

-- ----------------------------
-- Table structure for `app_school_department`
-- ----------------------------
DROP TABLE IF EXISTS `app_school_department`;
CREATE TABLE `app_school_department` (
  `dep_id` bigint(20) NOT NULL auto_increment,
  `dep_no` varchar(32) NOT NULL COMMENT '部门编号',
  `dep_name` varchar(128) NOT NULL COMMENT '部门名称',
  `dep_desc` varchar(256) default NULL COMMENT '部门描述',
  `dep_eqlevel` tinyint(4) default '-1' COMMENT '对口级别, -1=无, 0=总部, 1=校区, 2=片区',
  `dep_eqid` bigint(20) default NULL COMMENT '对口部门',
  `dep_orgtype` tinyint(4) NOT NULL COMMENT '部门结构类型 0=总部, 1=校区, 2=片区',
  PRIMARY KEY  (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='学校部门设置';

-- ----------------------------
-- Records of app_school_department
-- ----------------------------
INSERT INTO `app_school_department` VALUES ('15', '1', '总经办', '', '0', null, '0');
INSERT INTO `app_school_department` VALUES ('16', '2', '市场部', '', '0', '15', '0');
INSERT INTO `app_school_department` VALUES ('17', '3', '财务部', '', '0', '15', '0');
INSERT INTO `app_school_department` VALUES ('18', '1', '总监室', '', '0', '15', '1');
INSERT INTO `app_school_department` VALUES ('19', '5', '教务部', '', '0', '23', '1');
INSERT INTO `app_school_department` VALUES ('20', '6', '行政部', '', '0', '24', '1');
INSERT INTO `app_school_department` VALUES ('21', '2', '市场部', '', '0', '16', '1');
INSERT INTO `app_school_department` VALUES ('22', '4', '运营部', '', '0', '15', '0');
INSERT INTO `app_school_department` VALUES ('23', '5', '教务部', '', '0', '15', '0');
INSERT INTO `app_school_department` VALUES ('24', '6', '行政部', '', '0', '15', '0');
INSERT INTO `app_school_department` VALUES ('25', '5', '财务部', '', '0', '17', '1');
INSERT INTO `app_school_department` VALUES ('26', '7', '人资部', '', '0', '15', '0');

-- ----------------------------
-- Table structure for `app_school_department_position`
-- ----------------------------
DROP TABLE IF EXISTS `app_school_department_position`;
CREATE TABLE `app_school_department_position` (
  `pos_id` bigint(20) NOT NULL auto_increment,
  `pos_name` varchar(150) NOT NULL COMMENT '岗位名称',
  `pos_desc` varchar(250) default NULL COMMENT '岗位描述',
  `pos_leadership` tinyint(4) default '1' COMMENT '是否领导, 0=是, 1=不是',
  `dep_id` bigint(20) NOT NULL COMMENT '部门ID',
  `pos_roleRights` varchar(500) default NULL COMMENT '岗位角色权限',
  PRIMARY KEY  (`pos_id`),
  KEY `dep_id` (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='部门岗位';

-- ----------------------------
-- Records of app_school_department_position
-- ----------------------------
INSERT INTO `app_school_department_position` VALUES ('13', '副总经理', '', '0', '15', 'ROLE_ADMIN');
INSERT INTO `app_school_department_position` VALUES ('14', '市场总监', '', '0', '16', 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY');
INSERT INTO `app_school_department_position` VALUES ('15', '市场专员', '', '1', '16', 'ROLE_EMPLOYEE_HEADOFFICE');
INSERT INTO `app_school_department_position` VALUES ('17', '财务专员', '', '1', '17', 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPLY');
INSERT INTO `app_school_department_position` VALUES ('25', '校区行政', '', '1', '20', 'ROLE_EMPLOYEE_SCHOOL');
INSERT INTO `app_school_department_position` VALUES ('26', '总经理', '', '0', '15', 'ROLE_ADMIN');
INSERT INTO `app_school_department_position` VALUES ('27', '校长', '', '0', '18', 'ROLE_SCHOOL_ADMIN');
INSERT INTO `app_school_department_position` VALUES ('28', '会计', '', '1', '17', 'ROLE_EMPLOYEE_HEADOFFICE');
INSERT INTO `app_school_department_position` VALUES ('29', '美工设计', '', '1', '16', 'ROLE_EMPLOYEE_HEADOFFICE');
INSERT INTO `app_school_department_position` VALUES ('30', '行政主管', '', '0', '20', 'ROLE_SCHOOL_ADMIN');
INSERT INTO `app_school_department_position` VALUES ('33', '教务主管', '', '0', '19', 'ROLE_EMPLOYEE_SCHOOL');
INSERT INTO `app_school_department_position` VALUES ('34', '教务助理', '', '1', '19', 'ROLE_EMPLOYEE_SCHOOL');
INSERT INTO `app_school_department_position` VALUES ('35', '教师', '', '1', '19', 'ROLE_EMPLOYEE_SCHOOL');
INSERT INTO `app_school_department_position` VALUES ('36', '学科组长', '', '1', '19', 'ROLE_EMPLOYEE_SCHOOL');
INSERT INTO `app_school_department_position` VALUES ('37', '市场专员', '', '1', '21', 'ROLE_EMPLOYEE_SCHOOL');
INSERT INTO `app_school_department_position` VALUES ('38', '财务', '', '1', '25', 'ROLE_EMPLOYEE_SCHOOL');
INSERT INTO `app_school_department_position` VALUES ('39', '财务总监', '', '0', '17', 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE');
INSERT INTO `app_school_department_position` VALUES ('40', '运营总监', '', '0', '22', 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY');
INSERT INTO `app_school_department_position` VALUES ('41', '运营专员', '', '1', '22', 'ROLE_EMPLOYEE_HEADOFFICE');
INSERT INTO `app_school_department_position` VALUES ('42', '教务总监', '', '0', '23', 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY');
INSERT INTO `app_school_department_position` VALUES ('43', '教务专员', '', '1', '23', 'ROLE_EMPLOYEE_HEADOFFICE');
INSERT INTO `app_school_department_position` VALUES ('44', '行政总监', '', '0', '24', 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_ADMIN_NEWS_APPROVE,ROLE_ADMIN_TASK_APPROVE,ROLE_PERSONAL_TASK_PUBLISH,ROLE_ADMIN_WORKPLAN_ADD,ROLE_ADMIN_WORKPLAN_ADJUST,ROLE_ADMIN_WORKPLAN_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ');
INSERT INTO `app_school_department_position` VALUES ('45', '行政专员', '', '1', '24', 'ROLE_EMPLOYEE_HEADOFFICE');
INSERT INTO `app_school_department_position` VALUES ('46', '人资总监', '', '0', '26', 'ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_JOB_MANAGE,ROLE_ADMIN_HRM_ONBOARD,ROLE_ADMIN_HRM_RECRUIT_REVIEW,ROLE_ADMIN_HRM_RECRUITING,ROLE_ADMIN_HRM_RECRUIT_RESULT,ROLE_ADMIN_HRM_ENTRY_OP_ONBOARD,ROLE_ADMIN_HRM_ENTRY_OP_QUALIFY,ROLE_ADMIN_HRM_EMPLOYEE_ADD,ROLE_ADMIN_HRM_EMPLOYEE_DELETE,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_FINALIZE');
INSERT INTO `app_school_department_position` VALUES ('47', '人资专员', '', '1', '26', 'ROLE_EMPLOYEE_HEADOFFICE');

-- ----------------------------
-- Table structure for `app_school_department_position_role`
-- ----------------------------
DROP TABLE IF EXISTS `app_school_department_position_role`;
CREATE TABLE `app_school_department_position_role` (
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY  (`pos_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位权限';

-- ----------------------------
-- Records of app_school_department_position_role
-- ----------------------------
INSERT INTO `app_school_department_position_role` VALUES ('13', '9');
INSERT INTO `app_school_department_position_role` VALUES ('14', '7');
INSERT INTO `app_school_department_position_role` VALUES ('14', '27');
INSERT INTO `app_school_department_position_role` VALUES ('14', '35');
INSERT INTO `app_school_department_position_role` VALUES ('14', '36');
INSERT INTO `app_school_department_position_role` VALUES ('15', '7');
INSERT INTO `app_school_department_position_role` VALUES ('17', '7');
INSERT INTO `app_school_department_position_role` VALUES ('17', '58');
INSERT INTO `app_school_department_position_role` VALUES ('17', '60');
INSERT INTO `app_school_department_position_role` VALUES ('25', '8');
INSERT INTO `app_school_department_position_role` VALUES ('26', '9');
INSERT INTO `app_school_department_position_role` VALUES ('27', '14');
INSERT INTO `app_school_department_position_role` VALUES ('28', '7');
INSERT INTO `app_school_department_position_role` VALUES ('29', '7');
INSERT INTO `app_school_department_position_role` VALUES ('30', '14');
INSERT INTO `app_school_department_position_role` VALUES ('33', '8');
INSERT INTO `app_school_department_position_role` VALUES ('34', '8');
INSERT INTO `app_school_department_position_role` VALUES ('35', '8');
INSERT INTO `app_school_department_position_role` VALUES ('36', '8');
INSERT INTO `app_school_department_position_role` VALUES ('37', '8');
INSERT INTO `app_school_department_position_role` VALUES ('38', '8');
INSERT INTO `app_school_department_position_role` VALUES ('39', '7');
INSERT INTO `app_school_department_position_role` VALUES ('39', '27');
INSERT INTO `app_school_department_position_role` VALUES ('39', '35');
INSERT INTO `app_school_department_position_role` VALUES ('39', '36');
INSERT INTO `app_school_department_position_role` VALUES ('39', '58');
INSERT INTO `app_school_department_position_role` VALUES ('39', '59');
INSERT INTO `app_school_department_position_role` VALUES ('39', '60');
INSERT INTO `app_school_department_position_role` VALUES ('39', '61');
INSERT INTO `app_school_department_position_role` VALUES ('40', '7');
INSERT INTO `app_school_department_position_role` VALUES ('40', '27');
INSERT INTO `app_school_department_position_role` VALUES ('40', '35');
INSERT INTO `app_school_department_position_role` VALUES ('40', '36');
INSERT INTO `app_school_department_position_role` VALUES ('41', '7');
INSERT INTO `app_school_department_position_role` VALUES ('42', '7');
INSERT INTO `app_school_department_position_role` VALUES ('42', '27');
INSERT INTO `app_school_department_position_role` VALUES ('42', '35');
INSERT INTO `app_school_department_position_role` VALUES ('42', '36');
INSERT INTO `app_school_department_position_role` VALUES ('43', '7');
INSERT INTO `app_school_department_position_role` VALUES ('44', '7');
INSERT INTO `app_school_department_position_role` VALUES ('44', '22');
INSERT INTO `app_school_department_position_role` VALUES ('44', '23');
INSERT INTO `app_school_department_position_role` VALUES ('44', '26');
INSERT INTO `app_school_department_position_role` VALUES ('44', '27');
INSERT INTO `app_school_department_position_role` VALUES ('44', '29');
INSERT INTO `app_school_department_position_role` VALUES ('44', '30');
INSERT INTO `app_school_department_position_role` VALUES ('44', '31');
INSERT INTO `app_school_department_position_role` VALUES ('44', '33');
INSERT INTO `app_school_department_position_role` VALUES ('44', '35');
INSERT INTO `app_school_department_position_role` VALUES ('44', '36');
INSERT INTO `app_school_department_position_role` VALUES ('44', '37');
INSERT INTO `app_school_department_position_role` VALUES ('45', '7');
INSERT INTO `app_school_department_position_role` VALUES ('46', '38');
INSERT INTO `app_school_department_position_role` VALUES ('46', '41');
INSERT INTO `app_school_department_position_role` VALUES ('46', '43');
INSERT INTO `app_school_department_position_role` VALUES ('46', '44');
INSERT INTO `app_school_department_position_role` VALUES ('46', '45');
INSERT INTO `app_school_department_position_role` VALUES ('46', '46');
INSERT INTO `app_school_department_position_role` VALUES ('46', '50');
INSERT INTO `app_school_department_position_role` VALUES ('46', '51');
INSERT INTO `app_school_department_position_role` VALUES ('46', '52');
INSERT INTO `app_school_department_position_role` VALUES ('46', '53');
INSERT INTO `app_school_department_position_role` VALUES ('46', '55');
INSERT INTO `app_school_department_position_role` VALUES ('46', '57');
INSERT INTO `app_school_department_position_role` VALUES ('47', '7');

-- ----------------------------
-- Table structure for `app_school_district`
-- ----------------------------
DROP TABLE IF EXISTS `app_school_district`;
CREATE TABLE `app_school_district` (
  `district_id` bigint(20) NOT NULL auto_increment,
  `district_no` varchar(64) NOT NULL COMMENT '校区编号',
  `district_name` varchar(120) NOT NULL COMMENT '学校校区名称',
  `district_type` tinyint(4) NOT NULL COMMENT '校区类型',
  `district_address` varchar(150) default NULL COMMENT '校区地址',
  `district_phone` varchar(150) default NULL COMMENT '校区电话',
  `district_parent` bigint(20) default NULL COMMENT '校区上级结构',
  PRIMARY KEY  (`district_id`),
  UNIQUE KEY `district_no` (`district_no`),
  KEY `district_parent` (`district_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='校区设置';

-- ----------------------------
-- Records of app_school_district
-- ----------------------------
INSERT INTO `app_school_district` VALUES ('1', '0000', '杭州总部', '0', '', '', null);
INSERT INTO `app_school_district` VALUES ('3', '0001', '绍兴解放路校区', '1', '', '', '1');
INSERT INTO `app_school_district` VALUES ('4', '0002', '绍兴迪荡校区', '1', '德清', '', '1');
INSERT INTO `app_school_district` VALUES ('5', '0003', '柯桥校区', '1', '', '', '1');
INSERT INTO `app_school_district` VALUES ('6', '0004', '嘉兴校区', '1', '', '', '1');
INSERT INTO `app_school_district` VALUES ('7', '0005', '湖州校区', '1', '', '', '1');
INSERT INTO `app_school_district` VALUES ('8', '0006', '萧山校区', '1', '', '', '1');
INSERT INTO `app_school_district` VALUES ('9', '0007', '德清校区', '1', '', '', '1');

-- ----------------------------
-- Table structure for `app_school_posets`
-- ----------------------------
DROP TABLE IF EXISTS `app_school_posets`;
CREATE TABLE `app_school_posets` (
  `poset_id` bigint(20) NOT NULL auto_increment COMMENT '职位岗位ID',
  `poset_name` varchar(64) NOT NULL COMMENT '职位岗位名称',
  PRIMARY KEY  (`poset_id`),
  UNIQUE KEY `poset_name` (`poset_name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='职位岗位';

-- ----------------------------
-- Records of app_school_posets
-- ----------------------------
INSERT INTO `app_school_posets` VALUES ('12', '基本岗位（总部）');
INSERT INTO `app_school_posets` VALUES ('13', '基本岗位（校区）');
INSERT INTO `app_school_posets` VALUES ('11', '总经办职位');
INSERT INTO `app_school_posets` VALUES ('10', '总部主管');
INSERT INTO `app_school_posets` VALUES ('14', '校区主管（校区）');

-- ----------------------------
-- Table structure for `app_school_posets_terms`
-- ----------------------------
DROP TABLE IF EXISTS `app_school_posets_terms`;
CREATE TABLE `app_school_posets_terms` (
  `poset_id` bigint(20) NOT NULL COMMENT '职位岗位ID',
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY  (`poset_id`,`pos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职位与岗位关系表';

-- ----------------------------
-- Records of app_school_posets_terms
-- ----------------------------
INSERT INTO `app_school_posets_terms` VALUES ('10', '14');
INSERT INTO `app_school_posets_terms` VALUES ('10', '39');
INSERT INTO `app_school_posets_terms` VALUES ('10', '40');
INSERT INTO `app_school_posets_terms` VALUES ('10', '42');
INSERT INTO `app_school_posets_terms` VALUES ('10', '44');
INSERT INTO `app_school_posets_terms` VALUES ('10', '46');
INSERT INTO `app_school_posets_terms` VALUES ('11', '13');
INSERT INTO `app_school_posets_terms` VALUES ('11', '26');
INSERT INTO `app_school_posets_terms` VALUES ('12', '15');
INSERT INTO `app_school_posets_terms` VALUES ('12', '17');
INSERT INTO `app_school_posets_terms` VALUES ('12', '28');
INSERT INTO `app_school_posets_terms` VALUES ('12', '29');
INSERT INTO `app_school_posets_terms` VALUES ('12', '41');
INSERT INTO `app_school_posets_terms` VALUES ('12', '43');
INSERT INTO `app_school_posets_terms` VALUES ('13', '25');
INSERT INTO `app_school_posets_terms` VALUES ('13', '34');
INSERT INTO `app_school_posets_terms` VALUES ('13', '35');
INSERT INTO `app_school_posets_terms` VALUES ('13', '36');
INSERT INTO `app_school_posets_terms` VALUES ('13', '37');
INSERT INTO `app_school_posets_terms` VALUES ('13', '38');
INSERT INTO `app_school_posets_terms` VALUES ('14', '27');
INSERT INTO `app_school_posets_terms` VALUES ('14', '30');
INSERT INTO `app_school_posets_terms` VALUES ('14', '33');

-- ----------------------------
-- Table structure for `app_system_config`
-- ----------------------------
DROP TABLE IF EXISTS `app_system_config`;
CREATE TABLE `app_system_config` (
  `config_id` bigint(20) NOT NULL auto_increment,
  `config_key` varchar(64) NOT NULL COMMENT 'Key',
  `config_name` varchar(64) NOT NULL COMMENT '配置名称',
  `config_desc` varchar(256) default NULL COMMENT '配置描述',
  `type_name` varchar(32) NOT NULL COMMENT '所属分类名称',
  `data_type` smallint(6) NOT NULL COMMENT '数据类型            1=varchar            2=intger            3=decimal            4=datetime            5=time            ',
  `data_value` varchar(64) default NULL COMMENT '数据值',
  PRIMARY KEY  (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置,用于系统的全局配置';

-- ----------------------------
-- Records of app_system_config
-- ----------------------------

-- ----------------------------
-- Table structure for `app_system_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `app_system_dictionary`;
CREATE TABLE `app_system_dictionary` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(200) NOT NULL,
  `value` varchar(200) NOT NULL,
  `type` varchar(200) NOT NULL,
  `level` varchar(200) default NULL COMMENT '级别',
  `sequence` int(11) NOT NULL default '0',
  `extra_value` varchar(200) default NULL,
  `creation_date` datetime default '0000-00-00 00:00:00',
  `modified_date` datetime default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_system_dictionary
-- ----------------------------
INSERT INTO `app_system_dictionary` VALUES ('1', '人资文档', '人资文档', 'docType', '总部文档', '0', '123456', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `app_system_dictionary` VALUES ('2', '行政文档', '行政文档', 'docType', '总部文档', '0', '456789', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `app_system_dictionary` VALUES ('3', '新闻', '新闻', 'news', '公司总部新闻', '1', '', '2012-07-26 13:22:31', '2012-07-26 13:22:31');
INSERT INTO `app_system_dictionary` VALUES ('4', '通知', '通知', 'news', '公司总部新闻', '2', '', '2012-07-26 13:22:44', '2012-07-26 13:22:44');
INSERT INTO `app_system_dictionary` VALUES ('5', '校区新闻', '校区新闻', 'news', '分校区新闻', '0', '', '2012-07-26 13:22:52', '2012-07-26 13:22:52');
INSERT INTO `app_system_dictionary` VALUES ('6', '校区通知', '校区通知', 'news', '分校区新闻', '0', '', '2012-07-26 13:23:02', '2012-07-26 13:23:02');
INSERT INTO `app_system_dictionary` VALUES ('7', '任务类型1', '任务类型1', 'task', null, '0', '', '2012-07-26 13:23:20', '2012-07-26 13:23:20');
INSERT INTO `app_system_dictionary` VALUES ('8', '任务类型2', '任务类型2', 'task', null, '0', '', '2012-07-26 13:23:26', '2012-07-26 13:23:26');
INSERT INTO `app_system_dictionary` VALUES ('9', '年度会议', '年度会议', 'conference', '公司级别会议', '0', '', '2012-07-26 13:23:55', '2012-07-26 13:23:55');
INSERT INTO `app_system_dictionary` VALUES ('10', '月度会议', '月度会议', 'conference', '公司级别会议', '0', '', '2012-07-26 13:24:11', '2012-07-26 13:24:11');
INSERT INTO `app_system_dictionary` VALUES ('11', '周例会', '周例会', 'conference', '校区级别会议', '0', '', '2012-07-26 13:24:19', '2012-07-26 13:24:19');
INSERT INTO `app_system_dictionary` VALUES ('12', '教学讨论会', '教学讨论会', 'conference', '校区级别会议', '0', '', '2012-07-26 13:24:35', '2012-07-26 13:24:35');
INSERT INTO `app_system_dictionary` VALUES ('13', '1星', '1星', 'teacher', null, '0', '', '2012-07-26 13:25:23', '2012-07-26 13:25:23');
INSERT INTO `app_system_dictionary` VALUES ('14', '2星', '2星', 'teacher', null, '0', '', '2012-07-26 13:25:29', '2012-07-26 13:25:29');
INSERT INTO `app_system_dictionary` VALUES ('15', '3星', '3星', 'teacher', null, '0', '', '2012-07-26 13:25:35', '2012-07-26 13:25:35');
INSERT INTO `app_system_dictionary` VALUES ('16', '1星', '1星', 'counselor', null, '0', '', '2012-07-26 13:29:44', '2012-07-26 13:29:44');
INSERT INTO `app_system_dictionary` VALUES ('17', '2星', '2星', 'counselor', null, '0', '', '2012-07-26 13:29:49', '2012-07-26 13:29:49');
INSERT INTO `app_system_dictionary` VALUES ('18', '3星', '3星', 'counselor', null, '0', '', '2012-07-26 13:29:55', '2012-07-26 13:29:55');

-- ----------------------------
-- Table structure for `app_system_log`
-- ----------------------------
DROP TABLE IF EXISTS `app_system_log`;
CREATE TABLE `app_system_log` (
  `log_id` bigint(20) NOT NULL auto_increment,
  `user_name` varchar(120) NOT NULL COMMENT '用户名',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  `detail` text COMMENT '操作详细说明',
  `ip` varchar(128) default NULL COMMENT '登录IP',
  `cost` bigint(20) default NULL COMMENT '操作耗时',
  PRIMARY KEY  (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Records of app_system_log
-- ----------------------------
INSERT INTO `app_system_log` VALUES ('1', '管理员', '1', '2012-07-26 11:50:42', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '240');
INSERT INTO `app_system_log` VALUES ('3', '管理员', '1', '2012-07-26 13:50:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '37');
INSERT INTO `app_system_log` VALUES ('5', '管理员', '1', '2012-07-26 14:08:47', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '40');
INSERT INTO `app_system_log` VALUES ('7', '管理员', '1', '2012-07-26 14:10:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '60');
INSERT INTO `app_system_log` VALUES ('8', '管理员', '1', '2012-07-26 14:56:08', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '79');
INSERT INTO `app_system_log` VALUES ('9', '管理员', '1', '2012-07-27 09:28:51', '登录', '用户通过身份验证进入系统', '127.0.0.1', '656');
INSERT INTO `app_system_log` VALUES ('10', '管理员', '1', '2012-07-27 09:28:51', '登录', '用户通过身份验证进入系统', '127.0.0.1', '203');
INSERT INTO `app_system_log` VALUES ('11', '管理员', '1', '2012-07-27 12:27:15', '登录', '用户通过身份验证进入系统', '127.0.0.1', '297');
INSERT INTO `app_system_log` VALUES ('12', '管理员', '1', '2012-07-27 12:27:15', '登录', '用户通过身份验证进入系统', '127.0.0.1', '1266');
INSERT INTO `app_system_log` VALUES ('13', '管理员', '1', '2012-07-27 14:34:01', '登录', '用户通过身份验证进入系统', '127.0.0.1', '875');
INSERT INTO `app_system_log` VALUES ('15', '管理员', '1', '2012-07-28 09:47:03', '登录', '用户通过身份验证进入系统', '127.0.0.1', '110');
INSERT INTO `app_system_log` VALUES ('20', '管理员', '1', '2012-07-28 09:57:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '78');
INSERT INTO `app_system_log` VALUES ('23', '管理员', '1', '2012-07-28 10:09:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '3773');
INSERT INTO `app_system_log` VALUES ('25', '管理员', '1', '2012-07-28 11:35:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '42');
INSERT INTO `app_system_log` VALUES ('26', '管理员', '1', '2012-07-28 11:36:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '78');
INSERT INTO `app_system_log` VALUES ('27', '管理员', '1', '2012-07-28 11:38:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '75');
INSERT INTO `app_system_log` VALUES ('28', '管理员', '1', '2012-07-28 11:39:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '82');
INSERT INTO `app_system_log` VALUES ('31', '管理员', '1', '2012-07-28 22:40:26', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '406');
INSERT INTO `app_system_log` VALUES ('32', '管理员', '1', '2012-07-28 22:42:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '94');
INSERT INTO `app_system_log` VALUES ('33', '管理员', '1', '2012-07-29 00:48:10', '登录', '用户通过身份验证进入系统', '127.0.0.1', '83');
INSERT INTO `app_system_log` VALUES ('34', '管理员', '1', '2012-07-29 02:34:00', '登录', '用户通过身份验证进入系统', '127.0.0.1', '233');
INSERT INTO `app_system_log` VALUES ('35', '管理员', '1', '2012-07-29 03:26:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '63');
INSERT INTO `app_system_log` VALUES ('36', '管理员', '1', '2012-07-29 16:53:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '240');
INSERT INTO `app_system_log` VALUES ('37', '管理员', '1', '2012-07-29 21:42:54', '登录', '用户通过身份验证进入系统', '127.0.0.1', '70');
INSERT INTO `app_system_log` VALUES ('38', '管理员', '1', '2012-07-29 21:52:26', '登录', '用户通过身份验证进入系统', '127.0.0.1', '261');
INSERT INTO `app_system_log` VALUES ('39', '管理员', '1', '2012-07-30 12:16:02', '登录', '用户通过身份验证进入系统', '127.0.0.1', '1235');
INSERT INTO `app_system_log` VALUES ('40', '管理员', '1', '2012-07-30 12:16:04', '登录', '用户通过身份验证进入系统', '127.0.0.1', '156');
INSERT INTO `app_system_log` VALUES ('43', '管理员', '1', '2012-07-30 14:19:35', '登录', '用户通过身份验证进入系统', '127.0.0.1', '704');
INSERT INTO `app_system_log` VALUES ('44', '管理员', '1', '2012-07-31 02:46:11', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '247');
INSERT INTO `app_system_log` VALUES ('47', '管理员', '1', '2012-07-31 10:36:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '48');
INSERT INTO `app_system_log` VALUES ('48', '管理员', '1', '2012-07-31 10:37:08', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '45');
INSERT INTO `app_system_log` VALUES ('50', '管理员', '1', '2012-07-31 11:23:36', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '69');
INSERT INTO `app_system_log` VALUES ('51', '管理员', '1', '2012-07-31 11:26:05', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '48');
INSERT INTO `app_system_log` VALUES ('53', '管理员', '1', '2012-07-31 11:27:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '38');
INSERT INTO `app_system_log` VALUES ('55', '管理员', '1', '2012-07-31 11:34:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '50');
INSERT INTO `app_system_log` VALUES ('57', '管理员', '1', '2012-07-31 11:40:24', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '68');
INSERT INTO `app_system_log` VALUES ('59', '管理员', '1', '2012-07-31 12:13:55', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '59');
INSERT INTO `app_system_log` VALUES ('60', '周碧英', '25', '2012-07-31 13:22:31', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '82');
INSERT INTO `app_system_log` VALUES ('61', '管理员', '1', '2012-07-31 13:22:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '40');
INSERT INTO `app_system_log` VALUES ('62', '许玉凤', '22', '2012-07-31 13:23:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '51');
INSERT INTO `app_system_log` VALUES ('63', '杨琪', '27', '2012-07-31 13:23:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '66');
INSERT INTO `app_system_log` VALUES ('64', '管理员', '1', '2012-07-31 13:53:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '101');
INSERT INTO `app_system_log` VALUES ('65', '杨琪', '27', '2012-07-31 13:58:48', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '88');
INSERT INTO `app_system_log` VALUES ('66', '管理员', '1', '2012-07-31 14:06:02', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '50');
INSERT INTO `app_system_log` VALUES ('67', '罗佳驹', '19', '2012-07-31 14:20:50', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '47');
INSERT INTO `app_system_log` VALUES ('68', '俞柏红', '31', '2012-07-31 14:22:06', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '61');
INSERT INTO `app_system_log` VALUES ('69', '管理员', '1', '2012-07-31 14:22:26', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '41');
INSERT INTO `app_system_log` VALUES ('70', '俞柏红', '31', '2012-07-31 14:24:23', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '65');
INSERT INTO `app_system_log` VALUES ('71', '俞柏红', '31', '2012-07-31 14:25:43', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '59');
INSERT INTO `app_system_log` VALUES ('72', '管理员', '1', '2012-07-31 14:27:46', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '72');
INSERT INTO `app_system_log` VALUES ('73', '俞柏红', '31', '2012-07-31 14:44:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '49');
INSERT INTO `app_system_log` VALUES ('74', '管理员', '1', '2012-07-31 14:55:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '36');
INSERT INTO `app_system_log` VALUES ('75', '杨琪', '27', '2012-07-31 14:57:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '56');
INSERT INTO `app_system_log` VALUES ('76', '管理员', '1', '2012-07-31 15:02:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '38');
INSERT INTO `app_system_log` VALUES ('77', '杨琪', '27', '2012-07-31 15:05:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '57');
INSERT INTO `app_system_log` VALUES ('78', '杨琪', '27', '2012-07-31 15:05:21', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '48');
INSERT INTO `app_system_log` VALUES ('79', '管理员', '1', '2012-07-31 15:10:36', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '254');
INSERT INTO `app_system_log` VALUES ('80', '杨琪', '27', '2012-07-31 15:10:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '46');
INSERT INTO `app_system_log` VALUES ('81', '管理员', '1', '2012-07-31 15:12:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '43');
INSERT INTO `app_system_log` VALUES ('82', '杨琪', '27', '2012-07-31 15:18:12', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '76');
INSERT INTO `app_system_log` VALUES ('83', '管理员', '1', '2012-07-31 15:18:46', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '37');
INSERT INTO `app_system_log` VALUES ('84', '杨琪', '27', '2012-07-31 15:19:44', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '76');
INSERT INTO `app_system_log` VALUES ('85', '管理员', '1', '2012-07-31 15:21:17', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '62');
INSERT INTO `app_system_log` VALUES ('86', '杨琪', '27', '2012-07-31 15:22:44', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '55');
INSERT INTO `app_system_log` VALUES ('87', '管理员', '1', '2012-07-31 15:27:36', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '776');
INSERT INTO `app_system_log` VALUES ('88', '杨琪', '27', '2012-07-31 15:36:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '70');
INSERT INTO `app_system_log` VALUES ('89', '管理员', '1', '2012-07-31 15:36:37', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '82');
INSERT INTO `app_system_log` VALUES ('90', '杨琪', '27', '2012-07-31 15:37:29', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '74');
INSERT INTO `app_system_log` VALUES ('91', '管理员', '1', '2012-07-31 15:38:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '54');
INSERT INTO `app_system_log` VALUES ('92', '俞柏红', '31', '2012-07-31 15:39:38', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '58');
INSERT INTO `app_system_log` VALUES ('93', '管理员', '1', '2012-07-31 15:39:54', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '48');
INSERT INTO `app_system_log` VALUES ('94', '俞柏红', '31', '2012-07-31 15:40:27', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '65');
INSERT INTO `app_system_log` VALUES ('95', '管理员', '1', '2012-07-31 16:14:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '41');
INSERT INTO `app_system_log` VALUES ('96', '罗佳驹', '19', '2012-07-31 16:15:02', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '55');
INSERT INTO `app_system_log` VALUES ('97', '俞柏红', '31', '2012-07-31 16:15:43', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '73');
INSERT INTO `app_system_log` VALUES ('98', '管理员', '1', '2012-07-31 16:18:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '61');
INSERT INTO `app_system_log` VALUES ('99', '俞柏红', '31', '2012-07-31 19:58:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '481');
INSERT INTO `app_system_log` VALUES ('100', '罗佳驹', '19', '2012-07-31 19:58:51', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '77');
INSERT INTO `app_system_log` VALUES ('101', '管理员', '1', '2012-07-31 19:59:04', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '52');
INSERT INTO `app_system_log` VALUES ('102', '管理员', '1', '2012-07-31 20:11:05', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '46');
INSERT INTO `app_system_log` VALUES ('103', '管理员', '1', '2012-07-31 20:22:03', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '108');
INSERT INTO `app_system_log` VALUES ('104', '管理员', '1', '2012-07-31 21:15:04', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '178');
INSERT INTO `app_system_log` VALUES ('105', 'ljx', '36', '2012-07-31 21:38:22', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '64');
INSERT INTO `app_system_log` VALUES ('106', '杨琪', '27', '2012-07-31 21:40:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '135');
INSERT INTO `app_system_log` VALUES ('107', '苏斯翔', '30', '2012-07-31 21:42:55', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '111');
INSERT INTO `app_system_log` VALUES ('108', '管理员', '1', '2012-07-31 22:14:30', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '296');
INSERT INTO `app_system_log` VALUES ('109', '管理员', '1', '2012-08-01 11:08:37', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '1446');
INSERT INTO `app_system_log` VALUES ('110', 'ljx', '36', '2012-08-01 11:17:55', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '246');
INSERT INTO `app_system_log` VALUES ('111', '苏斯翔', '30', '2012-08-01 11:22:01', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '53');
INSERT INTO `app_system_log` VALUES ('112', '杨琪', '27', '2012-08-01 11:22:51', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '54');
INSERT INTO `app_system_log` VALUES ('113', 'ljx', '36', '2012-08-01 11:24:37', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '64');
INSERT INTO `app_system_log` VALUES ('114', '杨琪', '27', '2012-08-01 11:25:50', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '83');
INSERT INTO `app_system_log` VALUES ('115', '管理员', '1', '2012-08-01 11:33:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '57');
INSERT INTO `app_system_log` VALUES ('116', 'ljx', '36', '2012-08-01 11:40:31', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '49');
INSERT INTO `app_system_log` VALUES ('117', '管理员', '1', '2012-08-01 11:42:09', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '98');
INSERT INTO `app_system_log` VALUES ('118', 'ljx', '36', '2012-08-01 13:50:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '87');
INSERT INTO `app_system_log` VALUES ('119', '管理员', '1', '2012-08-01 13:52:10', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '48');
INSERT INTO `app_system_log` VALUES ('120', 'ljx', '36', '2012-08-01 13:53:08', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '91');
INSERT INTO `app_system_log` VALUES ('121', '管理员', '1', '2012-08-01 13:53:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '53');
INSERT INTO `app_system_log` VALUES ('122', '管理员', '1', '2012-08-01 16:54:12', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '388');
INSERT INTO `app_system_log` VALUES ('123', 'ljx', '36', '2012-08-01 16:55:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '155');
INSERT INTO `app_system_log` VALUES ('124', '管理员', '1', '2012-08-01 17:09:14', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '72');
INSERT INTO `app_system_log` VALUES ('125', 'ljx', '36', '2012-08-01 17:38:43', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '72');
INSERT INTO `app_system_log` VALUES ('126', '管理员', '1', '2012-08-01 17:41:57', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '59');
INSERT INTO `app_system_log` VALUES ('127', 'ljx', '36', '2012-08-01 17:56:31', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '69');
INSERT INTO `app_system_log` VALUES ('128', '管理员', '1', '2012-08-01 19:51:36', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '320');
INSERT INTO `app_system_log` VALUES ('129', 'ljx', '36', '2012-08-01 19:53:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '105');
INSERT INTO `app_system_log` VALUES ('130', '管理员', '1', '2012-08-01 19:55:05', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '77');
INSERT INTO `app_system_log` VALUES ('131', '管理员', '1', '2012-08-02 16:43:04', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '1091');
INSERT INTO `app_system_log` VALUES ('132', '梅杰', '20', '2012-08-02 17:01:07', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '206');
INSERT INTO `app_system_log` VALUES ('133', '管理员', '1', '2012-08-02 17:40:09', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '41');
INSERT INTO `app_system_log` VALUES ('134', '管理员', '1', '2012-08-02 17:42:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '50');
INSERT INTO `app_system_log` VALUES ('135', '罗佳驹', '19', '2012-08-02 17:43:27', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '61');
INSERT INTO `app_system_log` VALUES ('136', '管理员', '1', '2012-08-02 17:46:15', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '50');
INSERT INTO `app_system_log` VALUES ('137', '罗佳驹', '19', '2012-08-02 17:46:48', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '54');
INSERT INTO `app_system_log` VALUES ('138', '罗佳驹', '19', '2012-08-02 17:47:06', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '84');
INSERT INTO `app_system_log` VALUES ('139', '管理员', '1', '2012-08-02 17:53:44', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '145');
INSERT INTO `app_system_log` VALUES ('140', '管理员', '1', '2012-08-02 20:51:01', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '409');
INSERT INTO `app_system_log` VALUES ('141', 'ljx', '36', '2012-08-02 20:51:47', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '143');
INSERT INTO `app_system_log` VALUES ('142', '管理员', '1', '2012-08-02 20:59:01', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '77');
INSERT INTO `app_system_log` VALUES ('143', '管理员', '1', '2012-08-02 21:30:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '107');
INSERT INTO `app_system_log` VALUES ('144', '管理员', '1', '2012-08-02 22:51:48', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '99');
INSERT INTO `app_system_log` VALUES ('145', '管理员', '1', '2012-08-03 08:36:01', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '1858');
INSERT INTO `app_system_log` VALUES ('146', '管理员', '1', '2012-08-03 08:40:12', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '49');
INSERT INTO `app_system_log` VALUES ('147', '梅杰', '20', '2012-08-03 09:36:07', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '263');
INSERT INTO `app_system_log` VALUES ('148', '管理员', '1', '2012-08-03 09:36:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '68');
INSERT INTO `app_system_log` VALUES ('149', '管理员', '1', '2012-08-03 10:09:50', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '303');
INSERT INTO `app_system_log` VALUES ('150', 'ljx', '36', '2012-08-03 12:05:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '90');
INSERT INTO `app_system_log` VALUES ('151', '管理员', '1', '2012-08-03 12:08:07', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '66');
INSERT INTO `app_system_log` VALUES ('152', 'ljx', '36', '2012-08-03 12:08:54', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '62');
INSERT INTO `app_system_log` VALUES ('153', '管理员', '1', '2012-08-03 12:09:22', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '70');
INSERT INTO `app_system_log` VALUES ('154', 'ljx', '36', '2012-08-03 12:10:03', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '105');
INSERT INTO `app_system_log` VALUES ('155', '管理员', '1', '2012-08-03 12:25:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '307');
INSERT INTO `app_system_log` VALUES ('156', '管理员', '1', '2012-08-03 13:00:04', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '858');
INSERT INTO `app_system_log` VALUES ('157', '管理员', '1', '2012-08-03 14:01:21', '登录', '用户通过身份验证进入系统', '125.118.54.30', '40');
INSERT INTO `app_system_log` VALUES ('158', '管理员', '1', '2012-08-03 14:02:05', '登录', '用户通过身份验证进入系统', '125.118.54.30', '39');
INSERT INTO `app_system_log` VALUES ('159', '管理员', '1', '2012-08-03 14:02:40', '登录', '用户通过身份验证进入系统', '125.118.54.30', '35');
INSERT INTO `app_system_log` VALUES ('160', '管理员', '1', '2012-08-03 16:13:17', '登录', '用户通过身份验证进入系统', '125.118.54.30', '37');
INSERT INTO `app_system_log` VALUES ('161', '梅杰', '20', '2012-08-03 16:17:10', '登录', '用户通过身份验证进入系统', '125.118.54.30', '49');
INSERT INTO `app_system_log` VALUES ('162', '管理员', '1', '2012-08-03 16:21:03', '登录', '用户通过身份验证进入系统', '125.118.54.30', '26');
INSERT INTO `app_system_log` VALUES ('163', '梅杰', '20', '2012-08-03 16:24:07', '登录', '用户通过身份验证进入系统', '125.118.54.30', '37');
INSERT INTO `app_system_log` VALUES ('164', '管理员', '1', '2012-08-03 16:25:19', '登录', '用户通过身份验证进入系统', '125.118.54.30', '33');
INSERT INTO `app_system_log` VALUES ('165', '梅杰', '20', '2012-08-03 16:26:32', '登录', '用户通过身份验证进入系统', '125.118.54.30', '34');
INSERT INTO `app_system_log` VALUES ('166', '管理员', '1', '2012-08-03 16:27:54', '登录', '用户通过身份验证进入系统', '125.118.54.30', '28');
INSERT INTO `app_system_log` VALUES ('167', '罗佳驹', '19', '2012-08-03 16:28:07', '登录', '用户通过身份验证进入系统', '125.118.54.30', '36');
INSERT INTO `app_system_log` VALUES ('168', '林立', '37', '2012-08-03 16:38:24', '登录', '用户通过身份验证进入系统', '125.118.54.30', '37');
INSERT INTO `app_system_log` VALUES ('169', '管理员', '1', '2012-08-03 16:38:58', '登录', '用户通过身份验证进入系统', '125.118.54.30', '25');
INSERT INTO `app_system_log` VALUES ('170', '杨琪', '27', '2012-08-05 19:20:15', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '84');
INSERT INTO `app_system_log` VALUES ('171', '杨琪', '27', '2012-08-05 19:20:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '178');
INSERT INTO `app_system_log` VALUES ('172', '管理员', '1', '2012-08-05 19:22:33', '登录', '用户通过身份验证进入系统', '127.0.0.1', '12');
INSERT INTO `app_system_log` VALUES ('173', '管理员', '1', '2012-08-05 19:34:29', '登录', '用户通过身份验证进入系统', '127.0.0.1', '212');
INSERT INTO `app_system_log` VALUES ('174', '杨琪', '27', '2012-08-05 19:36:54', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '74');
INSERT INTO `app_system_log` VALUES ('175', '管理员', '1', '2012-08-06 21:40:48', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '325');
INSERT INTO `app_system_log` VALUES ('176', '梅杰', '20', '2012-08-06 22:16:22', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '171');
INSERT INTO `app_system_log` VALUES ('177', '梅杰', '20', '2012-08-06 22:17:50', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '21');
INSERT INTO `app_system_log` VALUES ('178', '梅杰', '20', '2012-08-06 22:23:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '16');
INSERT INTO `app_system_log` VALUES ('179', '管理员', '1', '2012-08-06 22:38:07', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '72');
INSERT INTO `app_system_log` VALUES ('180', '管理员', '1', '2012-08-06 22:44:28', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '310');
INSERT INTO `app_system_log` VALUES ('181', '管理员', '1', '2012-08-06 22:47:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', '263');

-- ----------------------------
-- Table structure for `app_system_work_content`
-- ----------------------------
DROP TABLE IF EXISTS `app_system_work_content`;
CREATE TABLE `app_system_work_content` (
  `cnt_id` bigint(20) unsigned NOT NULL auto_increment COMMENT '工作内容ID',
  `item_name` varchar(120) default NULL COMMENT '选项名称',
  `item_value` varchar(120) default NULL COMMENT '选项值',
  `meto` varchar(250) default NULL COMMENT '工作内容说明',
  `district_id` bigint(20) NOT NULL COMMENT '校区ID',
  `update_time` datetime default NULL COMMENT '修改时间',
  PRIMARY KEY  (`cnt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='系统工作内容设置';

-- ----------------------------
-- Records of app_system_work_content
-- ----------------------------
INSERT INTO `app_system_work_content` VALUES ('4', '行政', '行政', '', '1', '2012-07-26 12:47:43');
INSERT INTO `app_system_work_content` VALUES ('5', '教学', '教学', '', '1', '2012-07-26 12:48:11');
INSERT INTO `app_system_work_content` VALUES ('6', '校区行政', '校区行政', '', '3', '2012-07-26 12:48:48');
INSERT INTO `app_system_work_content` VALUES ('7', '教学', '教学', '', '3', '2012-07-26 12:48:57');
INSERT INTO `app_system_work_content` VALUES ('8', '咨询', '咨询', '', '3', '2012-07-26 12:49:08');
INSERT INTO `app_system_work_content` VALUES ('9', '教学', '教学', '', '4', '2012-07-26 12:49:32');
INSERT INTO `app_system_work_content` VALUES ('10', '咨询', '咨询', '', '4', '2012-07-26 12:49:38');

-- ----------------------------
-- Table structure for `app_system_work_template`
-- ----------------------------
DROP TABLE IF EXISTS `app_system_work_template`;
CREATE TABLE `app_system_work_template` (
  `work_tpl_id` bigint(20) NOT NULL auto_increment COMMENT '工作模板ID',
  `work_day` varchar(20) default NULL COMMENT '工作日期',
  `worktm_id` bigint(20) default NULL COMMENT '工作时间ID',
  `district_id` bigint(20) default NULL COMMENT '校区ID',
  `staff_id` bigint(20) default NULL COMMENT '员工ID',
  `staff_name` varchar(60) default NULL COMMENT '员工姓名',
  `enable` char(1) default '0' COMMENT '该模板是否启用',
  `template_id` bigint(20) default NULL COMMENT '模板ID',
  `workcnt_id` bigint(20) default NULL,
  PRIMARY KEY  (`work_tpl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='工作模板设置';

-- ----------------------------
-- Records of app_system_work_template
-- ----------------------------
INSERT INTO `app_system_work_template` VALUES ('12', '周一', '4', '1', '20', '梅杰', '1', '1', '4');
INSERT INTO `app_system_work_template` VALUES ('13', '周一', '4', '1', '19', '罗佳驹', '1', '1', '4');

-- ----------------------------
-- Table structure for `app_system_work_time`
-- ----------------------------
DROP TABLE IF EXISTS `app_system_work_time`;
CREATE TABLE `app_system_work_time` (
  `worktm_id` bigint(20) NOT NULL auto_increment COMMENT '工作时间ID',
  `item_name` varchar(120) default NULL COMMENT '选项名称',
  `work_stime` varchar(20) default NULL COMMENT '工作开始时间',
  `work_etime` varchar(20) default NULL COMMENT '工作结束时间',
  `meto` varchar(250) default NULL COMMENT '说明',
  `adjust_days` varchar(120) default NULL COMMENT '适用天数',
  `template_id` bigint(20) default NULL COMMENT '模板ID',
  `district_id` bigint(20) NOT NULL COMMENT '校区ID',
  `update_time` datetime default NULL COMMENT '修改时间',
  PRIMARY KEY  (`worktm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='工作时间设置';

-- ----------------------------
-- Records of app_system_work_time
-- ----------------------------
INSERT INTO `app_system_work_time` VALUES ('4', '早班', '8:30', '17:30', '', '周一,周二,周三,周四,周五', '1', '1', '2012-07-26 12:50:09');
INSERT INTO `app_system_work_time` VALUES ('5', '周末早班', '9:00', '17:00', '', '周六,周日', '1', '1', '2012-07-26 12:50:45');
INSERT INTO `app_system_work_time` VALUES ('6', '晚班', '18:30', '21:00', '', '周一,周二,周三,周四,周五', '1', '1', '2012-07-26 12:51:13');
INSERT INTO `app_system_work_time` VALUES ('7', '统班', '8:30', '20:30', '', '周一,周二,周三,周四,周五,周六,周日', '2', '1', '2012-07-26 12:52:02');
INSERT INTO `app_system_work_time` VALUES ('8', '早班', '8:00', '17:00', '', '周一,周二,周三,周四,周五,周六,周日', '1', '3', '2012-07-26 13:19:14');
INSERT INTO `app_system_work_time` VALUES ('9', '晚班', '18:40', '21:00', '', '周一,周二,周三,周四,周五,周六,周日', '1', '3', '2012-07-26 13:19:47');

-- ----------------------------
-- Table structure for `app_user`
-- ----------------------------
DROP TABLE IF EXISTS `app_user`;
CREATE TABLE `app_user` (
  `user_id` bigint(20) NOT NULL auto_increment COMMENT '主键',
  `username` varchar(128) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `fullname` varchar(64) default NULL COMMENT '用户姓名',
  `email` varchar(128) default NULL COMMENT '邮件',
  `dep_id` bigint(20) default NULL COMMENT '所属部门',
  `pos_id` bigint(20) default NULL COMMENT '职位',
  `district_id` bigint(20) default NULL COMMENT '用户所在校区',
  `emp_id` bigint(20) default NULL COMMENT '员工ID',
  `phone` varchar(32) default NULL COMMENT '电话',
  `mobile` varchar(32) default NULL COMMENT '手机',
  `fax` varchar(32) default NULL COMMENT '传真',
  `address` varchar(64) default NULL COMMENT '地址',
  `zip` varchar(32) default NULL COMMENT '邮编',
  `photo` varchar(128) default NULL COMMENT '相片',
  `status` smallint(6) NOT NULL COMMENT '状态            1=激活            0=冻结',
  `del_flag` tinyint(4) default '0' COMMENT '删除标记, 1=已删除, 0=未删除',
  `logon_lastip` varchar(64) default NULL COMMENT '最后登录IP',
  `logon_lastime` datetime default NULL COMMENT '最后登录时间',
  PRIMARY KEY  (`user_id`),
  KEY `FK_AU_R_DPT` (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表';

-- ----------------------------
-- Records of app_user
-- ----------------------------
INSERT INTO `app_user` VALUES ('1', 'admin', 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=', '管理员', 'csx@jee-soft.cn', null, '26', '1', '19', null, null, null, null, null, null, '1', '0', '218.108.223.245', '2012-08-07 15:59:30');
INSERT INTO `app_user` VALUES ('19', '00001001', 'ro+N+ETeTFw+SYrc4TnIzXuXWwO93mUJgr0ArrsNPfk=', '罗佳驹', null, '15', '26', '1', '19', null, null, null, null, null, null, '1', '0', '125.118.54.30', '2012-08-03 16:28:07');
INSERT INTO `app_user` VALUES ('20', '00001002', 'YtwP6mUL0cqp45wC4yCgaYVYKkKWE4LUtMn1mqljowc=', '梅杰', null, '15', '13', '1', '20', null, null, null, null, null, null, '1', '0', '125.118.54.30', '2012-08-03 16:26:32');
INSERT INTO `app_user` VALUES ('21', '00003001', 'mxA4ujFL57JAzeke5W87Cujn+35uwD+aKrCuNK4f+6A=', '林菁菁', null, '17', '39', '1', '21', null, null, null, null, null, null, '1', '0', null, null);
INSERT INTO `app_user` VALUES ('22', '00004001', 'p0TBRM7B1PaLy7I3j+aXC7xeOeBwzBU7pF6IxMFGLOg=', '许玉凤', null, '22', '40', '1', '22', null, null, null, null, null, null, '1', '0', '0:0:0:0:0:0:0:1', '2012-07-31 13:23:25');
INSERT INTO `app_user` VALUES ('23', '00005001', 'B4aIJZIEodZjpMtGatbKbo46E2vBzRJBFmJPmW2frYI=', '王伟平', null, '23', '42', '1', '23', null, null, null, null, null, null, '1', '0', '218.108.223.245', '2012-08-07 15:52:37');
INSERT INTO `app_user` VALUES ('24', '00002001', '/4xWL9bhPAve03Tu5HeR7T0U6Qsmy6eYjLtZM4aAcFs=', '刘苗芳', null, '16', '14', '1', '24', null, null, null, null, null, null, '1', '0', null, null);
INSERT INTO `app_user` VALUES ('25', '00003002', 'CqfBdfhjcLbqOIDd62kTxYiDhAbXBkgFrv8eH8/fpQw=', '周碧英', null, '17', '28', '1', '25', null, null, null, null, null, null, '1', '0', '0:0:0:0:0:0:0:1', '2012-07-31 13:22:31');
INSERT INTO `app_user` VALUES ('26', '00003003', '8t8/A0jkYHUyLfiJtVydFhZ0Q/X2xuJ1LGJUPHLs4Zk=', '蒋晓萍', null, '17', '17', '1', '26', null, null, null, null, null, null, '1', '0', null, null);
INSERT INTO `app_user` VALUES ('27', '00006001', 'AdR3o6rcgoyXwyqu2QCIn/IbWgsYIfDIbybGB7ESK+k=', '杨琪', null, '24', '45', '1', '27', null, null, null, null, null, null, '1', '0', '0:0:0:0:0:0:0:1', '2012-08-01 11:25:50');
INSERT INTO `app_user` VALUES ('28', '00005002', 'VmQ2dhyZSxuzomLV9mx1T+y2Fl7rkdxAxIkbDN7dWT4=', '何滨', null, '23', '43', '1', '28', null, null, null, null, null, null, '1', '0', null, null);
INSERT INTO `app_user` VALUES ('29', '00002002', 'VH4xR+A+M04zzSSzxg3T2osRhsB1+1gJYxVjJ38uk4E=', '程聪', null, '16', '29', '1', '29', null, null, null, null, null, null, '1', '0', null, null);
INSERT INTO `app_user` VALUES ('30', '00005003', 'yFKhbyaKjjizMHXNo0w0Kp45bl/g3/5fRBNJKMmq8t0=', '苏斯翔', null, '23', '43', '1', '30', null, null, null, null, null, null, '1', '0', '0:0:0:0:0:0:0:1', '2012-08-01 11:22:01');
INSERT INTO `app_user` VALUES ('31', '00066001', 'rfm23G77+wfY8xG9pX4eAfGkp4XWzHxVXuy1HIyOApU=', '俞柏红', null, '20', '25', '8', '31', null, null, null, null, null, null, '1', '0', '0:0:0:0:0:0:0:1', '2012-07-31 19:58:00');
INSERT INTO `app_user` VALUES ('32', '00076001', 'anI9MmTiyrzAeGYpjdEtqIbc4+5HsOweg6X7o1JNQjA=', '蔡晓喻', null, '20', '30', '9', '32', null, null, null, null, null, null, '1', '0', null, null);
INSERT INTO `app_user` VALUES ('33', '00056001', '5Rsppf8nmetp92hxvHFFEXJtj7V8d4z1CYA/bHSaXfM=', '章荷英', null, '20', '25', '7', '33', null, null, null, null, null, null, '1', '0', null, null);
INSERT INTO `app_user` VALUES ('34', '00046001', '3pnDrR8cXanV8I/+PMniD+bMPmu4AFZjmRF+SCA73yQ=', '冯毓', null, '20', '30', '6', '34', null, null, null, null, null, null, '1', '0', null, null);
INSERT INTO `app_user` VALUES ('35', '00036001', 'XmV3a5D8g46S/4qJugvbYAy4y1z6wF+b1tzU3C/37P4=', '陈蕾红', null, '20', '25', '5', '35', null, null, null, null, null, null, '1', '0', null, null);
INSERT INTO `app_user` VALUES ('36', '00006002', 'gfbTaJlUYHQ1K6VFo1nJ+W4jxm7NEPtO9Kl3H4xm070=', 'ljx', null, '24', '44', '1', '36', null, null, null, null, null, null, '1', '0', '218.108.223.245', '2012-08-07 15:45:57');
INSERT INTO `app_user` VALUES ('37', '00003004', '8JxP5z5ukGlNHehkcTvpwUFoej2ycC+LHDt785I/Cos=', '林立', null, '17', '16', '1', '37', null, null, null, null, null, null, '1', '0', '125.118.54.30', '2012-08-03 16:38:24');

-- ----------------------------
-- Table structure for `app_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `app_user_role`;
CREATE TABLE `app_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限表';

-- ----------------------------
-- Records of app_user_role
-- ----------------------------

-- ----------------------------
-- View structure for `app_admin_attendance_view`
-- ----------------------------
DROP VIEW IF EXISTS `app_admin_attendance_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `app_admin_attendance_view` AS select 'attendance' AS `origin`,`app_admin_attendance`.`attend_id` AS `attendance_view_id`,`app_admin_attendance`.`work_date` AS `work_date`,`app_admin_attendance`.`work_time` AS `work_time`,`app_admin_attendance`.`offtime_shour` AS `offtime_shour`,`app_admin_attendance`.`offtime_ehour` AS `offtime_ehour`,`app_admin_attendance`.`offtime_smin` AS `offtime_smin`,`app_admin_attendance`.`offtime_emin` AS `offtime_emin`,`app_admin_attendance`.`staff_id` AS `staff_id`,`app_admin_attendance`.`staff_name` AS `staff_name`,`app_admin_attendance`.`work_type` AS `work_type`,`app_admin_attendance`.`work_status` AS `work_status`,`app_admin_attendance`.`leave_type` AS `leave_type`,`app_admin_attendance`.`staff_behalf_name` AS `staff_behalf_name`,`app_admin_attendance`.`staff_behalf_id` AS `staff_behalf_id`,`app_admin_attendance`.`meto` AS `meto`,`app_admin_attendance`.`attendance_result` AS `attendance_result`,`app_admin_attendance`.`exception` AS `exception` from `app_admin_attendance` union select 'arrange' AS `origin`,`app_admin_workarrange`.`work_id` AS `attendance_view_id`,`app_admin_workarrange`.`work_date` AS `work_date`,concat(`app_system_work_time`.`work_stime`,'-',`app_system_work_time`.`work_etime`) AS `work_time`,NULL AS `offtime_shour`,NULL AS `offtime_ehour`,NULL AS `offtime_smin`,NULL AS `offtime_emin`,`app_admin_workarrange`.`staff_id` AS `staff_id`,`app_admin_workarrange`.`staff_name` AS `staff_name`,`app_admin_workarrange`.`work_type` AS `work_type`,'0' AS `work_status`,NULL AS `leave_type`,NULL AS `staff_behalf_name`,NULL AS `staff_behalf_id`,NULL AS `meto`,'1' AS `attendance_result`,'0' AS `exception` from (`app_admin_workarrange` join `app_system_work_time`) where (isnull(`app_admin_workarrange`.`attend_id`) and (`app_admin_workarrange`.`work_time` = `app_system_work_time`.`worktm_id`))
