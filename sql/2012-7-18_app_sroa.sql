# MySQL-Front 5.1  (Build 4.13)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


# Host: localhost    Database: app_sroa
# ------------------------------------------------------
# Server version 5.6.5-m8

#
# Source for table app_admin_attendance
#

DROP TABLE IF EXISTS `app_admin_attendance`;
CREATE TABLE `app_admin_attendance` (
  `attend_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '考勤ID',
  `work_date` date NOT NULL COMMENT '工作日期',
  `work_time` varchar(64) NOT NULL COMMENT '工作时间',
  `offtime_shour` int(11) DEFAULT NULL COMMENT '实际下班时间 - 打卡小时 (上)',
  `offtime_ehour` int(11) DEFAULT NULL COMMENT '实际下班时间 - 打卡分钟 (上)',
  `offtime_smin` int(11) DEFAULT NULL COMMENT '实际下班时间 - 打卡小时 (下)',
  `offtime_emin` int(11) DEFAULT NULL COMMENT '实际下班时间 - 打卡分钟 (下)',
  `staff_id` bigint(20) NOT NULL COMMENT '员工ID',
  `staff_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `work_type` tinyint(4) NOT NULL COMMENT '上班类型, 0=正常上班, 1=带薪上班',
  `work_status` tinyint(4) NOT NULL COMMENT '上班状态， 0=在岗, 1=出差, 2=请假',
  `leave_type` tinyint(4) DEFAULT NULL COMMENT '请假类型',
  `staff_behalf_name` varchar(64) DEFAULT NULL COMMENT '代班员工姓名',
  `staff_behalf_id` bigint(20) DEFAULT NULL COMMENT '代班员工ID',
  `meto` varchar(250) DEFAULT NULL COMMENT '说明 (请假说明, 旷工说明)',
  `attendance_result` tinyint(4) DEFAULT NULL COMMENT '考勤结果, 0=按时, 1=迟到, 2=早退, 3=旷工',
  PRIMARY KEY (`attend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-员工考勤';

#
# Dumping data for table app_admin_attendance
#

LOCK TABLES `app_admin_attendance` WRITE;
/*!40000 ALTER TABLE `app_admin_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_admin_attendance` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_doc
#

DROP TABLE IF EXISTS `app_admin_doc`;
CREATE TABLE `app_admin_doc` (
  `doc_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `type_dicid` bigint(20) NOT NULL COMMENT '文档类型ID (来自系统字典)',
  `doc_name` varchar(150) NOT NULL COMMENT '文档名称',
  `doc_level_id` int(5) NOT NULL DEFAULT '0' COMMENT '文档级别',
  `doc_VisiableRange_id` int(5) NOT NULL DEFAULT '0' COMMENT '文档范围',
  `doc_userNames` varchar(250) DEFAULT NULL COMMENT '文档可见人姓名集合, 多用户姓名之间用,连接, 主要方便于数据库查询',
  `doc_userIds` varchar(150) DEFAULT NULL COMMENT '文档可见用户ID集合, 主要方便数据库查询',
  `doc_postDistrictId` bigint(20) NOT NULL COMMENT '文档上传校区',
  `doc_postDepId` bigint(20) NOT NULL COMMENT '文档上传部门',
  `author_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传用户',
  `create_time` datetime NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`doc_id`),
  KEY `PK_range` (`doc_VisiableRange_id`),
  KEY `PK_level` (`doc_level_id`),
  KEY `PK_district` (`doc_postDistrictId`),
  KEY `PK_department` (`doc_postDepId`),
  KEY `PK_author` (`author_id`),
  KEY `PK_dcoType` (`type_dicid`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='行政管理-文档';

#
# Dumping data for table app_admin_doc
#

LOCK TABLES `app_admin_doc` WRITE;
/*!40000 ALTER TABLE `app_admin_doc` DISABLE KEYS */;
INSERT INTO `app_admin_doc` VALUES (1,1,'技术与经济',1,2,'ll','ll',3,7,1,'2011-12-29');
INSERT INTO `app_admin_doc` VALUES (2,2,'你好，舒先生',1,1,'1','1',1,7,1,'2012-07-22');
INSERT INTO `app_admin_doc` VALUES (60,2,'奖赏某某员工',2,1,'',NULL,1,7,1,'2012-07-18 08:54:56');
INSERT INTO `app_admin_doc` VALUES (61,2,'外派出差安排',2,1,'',NULL,3,10,1,'2012-07-18 13:28:46');
INSERT INTO `app_admin_doc` VALUES (62,1,'公司发展谋略',1,3,'',NULL,1,11,1,'2012-07-18 13:29:33');
INSERT INTO `app_admin_doc` VALUES (63,1,'大家一起游玩去吧',1,1,'',NULL,1,7,1,'2012-07-18 13:29:46');
INSERT INTO `app_admin_doc` VALUES (64,1,'世界末日',1,1,'',NULL,1,7,1,'2012-07-18 15:49:24');
INSERT INTO `app_admin_doc` VALUES (65,1,'我想回家',1,1,'',NULL,1,7,1,'2012-07-18 15:58:56');
INSERT INTO `app_admin_doc` VALUES (66,1,'谢谢你们曾经看清我',1,1,'',NULL,1,7,1,'2012-07-18 16:02:57');
/*!40000 ALTER TABLE `app_admin_doc` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_doc_file
#

DROP TABLE IF EXISTS `app_admin_doc_file`;
CREATE TABLE `app_admin_doc_file` (
  `doc_id` bigint(20) NOT NULL COMMENT '文档ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY (`doc_id`),
  KEY `PK_doc` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-文档文件关联表';

#
# Dumping data for table app_admin_doc_file
#

LOCK TABLES `app_admin_doc_file` WRITE;
/*!40000 ALTER TABLE `app_admin_doc_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_admin_doc_file` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_doc_level
#

DROP TABLE IF EXISTS `app_admin_doc_level`;
CREATE TABLE `app_admin_doc_level` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `level_name` varchar(100) DEFAULT NULL COMMENT '文档级别名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='文档级别';

#
# Dumping data for table app_admin_doc_level
#

LOCK TABLES `app_admin_doc_level` WRITE;
/*!40000 ALTER TABLE `app_admin_doc_level` DISABLE KEYS */;
INSERT INTO `app_admin_doc_level` VALUES (1,'公司级别');
INSERT INTO `app_admin_doc_level` VALUES (2,'校区级别');
INSERT INTO `app_admin_doc_level` VALUES (3,'校区部门级别');
INSERT INTO `app_admin_doc_level` VALUES (4,'总部对口部门级别');
/*!40000 ALTER TABLE `app_admin_doc_level` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_doc_visiable_range
#

DROP TABLE IF EXISTS `app_admin_doc_visiable_range`;
CREATE TABLE `app_admin_doc_visiable_range` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `visiable_name` varchar(100) DEFAULT NULL COMMENT '文档范围名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='文档范围';

#
# Dumping data for table app_admin_doc_visiable_range
#

LOCK TABLES `app_admin_doc_visiable_range` WRITE;
/*!40000 ALTER TABLE `app_admin_doc_visiable_range` DISABLE KEYS */;
INSERT INTO `app_admin_doc_visiable_range` VALUES (1,'所有校区');
INSERT INTO `app_admin_doc_visiable_range` VALUES (2,'设置个人可见');
INSERT INTO `app_admin_doc_visiable_range` VALUES (3,'杭州总部');
INSERT INTO `app_admin_doc_visiable_range` VALUES (4,'萧山校区');
/*!40000 ALTER TABLE `app_admin_doc_visiable_range` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_news
#

DROP TABLE IF EXISTS `app_admin_news`;
CREATE TABLE `app_admin_news` (
  `news_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_dicid` bigint(20) NOT NULL COMMENT '新闻类型id (来自系统字典)',
  `news_subject` varchar(128) NOT NULL COMMENT '新闻标题',
  `news_content` text NOT NULL COMMENT '新闻内容',
  `author_id` bigint(20) NOT NULL COMMENT '新闻作者ID',
  `author_name` varchar(120) NOT NULL COMMENT '新闻作者名',
  `news_level` tinyint(4) NOT NULL COMMENT '新闻级别, 0=公司新闻, 1=校区新闻',
  `district_visible` bigint(20) NOT NULL COMMENT '可见校区',
  `district_post` bigint(20) NOT NULL COMMENT '发布校区',
  `dep_post` bigint(20) NOT NULL COMMENT '发布部门',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '最后更新时间',
  `top_index` int(11) DEFAULT NULL COMMENT '置顶序号',
  `status` smallint(6) NOT NULL COMMENT '0=草稿, 1=已发布并待审核, 2=审核通过, 3=审批退回',
  PRIMARY KEY (`news_id`),
  KEY `type_id` (`type_dicid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻';

#
# Dumping data for table app_admin_news
#

LOCK TABLES `app_admin_news` WRITE;
/*!40000 ALTER TABLE `app_admin_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_admin_news` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_news_file
#

DROP TABLE IF EXISTS `app_admin_news_file`;
CREATE TABLE `app_admin_news_file` (
  `news_id` bigint(20) NOT NULL COMMENT '新闻ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY (`news_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻文件关联表';

#
# Dumping data for table app_admin_news_file
#

LOCK TABLES `app_admin_news_file` WRITE;
/*!40000 ALTER TABLE `app_admin_news_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_admin_news_file` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_task
#

DROP TABLE IF EXISTS `app_admin_task`;
CREATE TABLE `app_admin_task` (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_dicid` bigint(20) NOT NULL COMMENT '任务类型Id (来自系统字典)',
  `task_name` varchar(120) NOT NULL COMMENT '任务名称',
  `task_originator` bigint(20) NOT NULL COMMENT '任务发起人',
  `task_charger` bigint(20) NOT NULL COMMENT '任务负责人',
  `task_planStartDate` date NOT NULL COMMENT '任务计划开始时间',
  `task_planEndDate` date NOT NULL COMMENT '任务计划终止时间',
  `task_actualFinishDate` date DEFAULT NULL COMMENT '任务实际完成时间',
  `task_desc` text NOT NULL COMMENT '任务描述',
  `task_participant_ids` varchar(120) DEFAULT NULL COMMENT '任务参与人ID列表',
  `task_participant_names` varchar(250) DEFAULT NULL COMMENT '任务参与人名称列表',
  `task_status` tinyint(4) NOT NULL COMMENT '任务状态',
  `approval_status` tinyint(4) DEFAULT NULL COMMENT '审批状态',
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托';

#
# Dumping data for table app_admin_task
#

LOCK TABLES `app_admin_task` WRITE;
/*!40000 ALTER TABLE `app_admin_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_admin_task` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_task_file
#

DROP TABLE IF EXISTS `app_admin_task_file`;
CREATE TABLE `app_admin_task_file` (
  `task_id` bigint(20) NOT NULL COMMENT '任务ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY (`task_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托文件关联表';

#
# Dumping data for table app_admin_task_file
#

LOCK TABLES `app_admin_task_file` WRITE;
/*!40000 ALTER TABLE `app_admin_task_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_admin_task_file` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_workarrange
#

DROP TABLE IF EXISTS `app_admin_workarrange`;
CREATE TABLE `app_admin_workarrange` (
  `work_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '工作ID',
  `work_date` date NOT NULL COMMENT '工作日期',
  `work_time` varchar(64) NOT NULL COMMENT '工作时间',
  `staff_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `staff_id` bigint(20) NOT NULL COMMENT '员工ID',
  `work_type` int(5) DEFAULT NULL COMMENT '上班类型',
  `work_content` text COMMENT '工作内容',
  PRIMARY KEY (`work_id`),
  KEY `PK_user` (`staff_id`),
  KEY `PK_type` (`work_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='行政管理-工作安排';

#
# Dumping data for table app_admin_workarrange
#

LOCK TABLES `app_admin_workarrange` WRITE;
/*!40000 ALTER TABLE `app_admin_workarrange` DISABLE KEYS */;
INSERT INTO `app_admin_workarrange` VALUES (1,'2012-07-12','12:00-13:00','斩不刀',2,1,'工作好轻松');
INSERT INTO `app_admin_workarrange` VALUES (2,'2012-06-13','13:30-15:59','唐伯虎',1,3,'123456');
/*!40000 ALTER TABLE `app_admin_workarrange` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_admin_worktype
#

DROP TABLE IF EXISTS `app_admin_worktype`;
CREATE TABLE `app_admin_worktype` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL COMMENT '工作类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Dumping data for table app_admin_worktype
#

LOCK TABLES `app_admin_worktype` WRITE;
/*!40000 ALTER TABLE `app_admin_worktype` DISABLE KEYS */;
INSERT INTO `app_admin_worktype` VALUES (1,'正常上班');
INSERT INTO `app_admin_worktype` VALUES (2,'调休加班');
INSERT INTO `app_admin_worktype` VALUES (3,'带薪加班');
INSERT INTO `app_admin_worktype` VALUES (4,'倍薪加班');
/*!40000 ALTER TABLE `app_admin_worktype` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_file_attach
#

DROP TABLE IF EXISTS `app_file_attach`;
CREATE TABLE `app_file_attach` (
  `file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(128) NOT NULL COMMENT '文件名',
  `file_path` varchar(128) NOT NULL COMMENT '文件路径',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `file_ext` varchar(32) DEFAULT NULL COMMENT '扩展名',
  `file_type` varchar(32) NOT NULL COMMENT '附件类型            如：邮件附件',
  `note` varchar(1024) DEFAULT NULL COMMENT '说明',
  `creator` varchar(32) NOT NULL COMMENT '上传者',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '上传者ID',
  `file_bytes` int(11) NOT NULL COMMENT '文件总大小',
  `del_flag` smallint(6) DEFAULT '0' COMMENT '1=已删除, 0=未删除',
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='附件';

#
# Dumping data for table app_file_attach
#

LOCK TABLES `app_file_attach` WRITE;
/*!40000 ALTER TABLE `app_file_attach` DISABLE KEYS */;
INSERT INTO `app_file_attach` VALUES (18,'link.ico','others/201207/49e68712f43b4a4c8f3c2ad0b56a02ce.ico','2012-07-18 15:58:50','ico','others','189.94 KB','Unknow',NULL,194503,0);
INSERT INTO `app_file_attach` VALUES (19,'hot.ico','others/201207/cf48e7e68b894518b20ab0c59696dc91.ico','2012-07-18 15:58:54','ico','others','14.73 KB','Unknow',NULL,15086,0);
INSERT INTO `app_file_attach` VALUES (20,'Favorites.ico','others/201207/1a3bfc9bb9594989bbeade880e877d23.ico','2012-07-18 16:02:53','ico','others','14.73 KB','Unknow',NULL,15086,0);
INSERT INTO `app_file_attach` VALUES (21,'link.ico','others/201207/3beb42c7cd91453a8baff84abd109249.ico','2012-07-18 16:02:56','ico','others','189.94 KB','Unknow',NULL,194503,0);
INSERT INTO `app_file_attach` VALUES (22,'recent.ico','others/201207/e1341b2477224d41b8ba79f440f11477.ico','2012-07-18 16:06:36','ico','others','14.73 KB','Unknow',NULL,15086,0);
/*!40000 ALTER TABLE `app_file_attach` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_finan_expense
#

DROP TABLE IF EXISTS `app_finan_expense`;
CREATE TABLE `app_finan_expense` (
  `expense_id` bigint(20) DEFAULT NULL,
  `apply_form_no` varchar(120) DEFAULT NULL COMMENT '人资审批流程',
  `apply_form_type` bigint(20) DEFAULT NULL,
  `apply_date` date DEFAULT NULL,
  `comments` longtext,
  `emp_id` bigint(20) DEFAULT NULL COMMENT '员工ID',
  `emp_district` bigint(20) DEFAULT NULL,
  `emp_dep` bigint(20) DEFAULT NULL,
  `emp_phone_no` varchar(120) DEFAULT NULL,
  `apply_amt` double DEFAULT NULL,
  `payer` bigint(20) DEFAULT NULL,
  `contract_no` varchar(120) DEFAULT NULL,
  `attach_count` varchar(120) DEFAULT NULL,
  `audit_advance` bigint(20) DEFAULT NULL,
  `asset_no` varchar(120) DEFAULT NULL,
  `amt_receiver` varchar(120) DEFAULT NULL,
  `amt_receiver_contact` varchar(120) DEFAULT NULL,
  `pay_method` bigint(20) DEFAULT NULL,
  `bank` varchar(120) DEFAULT NULL,
  `account_name` varchar(120) DEFAULT NULL,
  `account_no` varchar(120) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `audit_state` bigint(20) DEFAULT NULL,
  `entry_id` bigint(20) DEFAULT NULL,
  `entry_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Dumping data for table app_finan_expense
#

LOCK TABLES `app_finan_expense` WRITE;
/*!40000 ALTER TABLE `app_finan_expense` DISABLE KEYS */;
INSERT INTO `app_finan_expense` VALUES (1,'1',1,'2012-06-19','1weqeqw',3,1,1,'qwe',NULL,1,NULL,NULL,1,NULL,NULL,NULL,1,NULL,NULL,NULL,'Y',1,1,NULL);
INSERT INTO `app_finan_expense` VALUES (1,'1',1,'2012-06-19','1weqeqw',3,1,1,'qwe',NULL,1,NULL,NULL,1,NULL,NULL,NULL,1,NULL,NULL,NULL,'Y',1,1,NULL);
/*!40000 ALTER TABLE `app_finan_expense` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_function
#

DROP TABLE IF EXISTS `app_function`;
CREATE TABLE `app_function` (
  `func_id` int(11) NOT NULL AUTO_INCREMENT,
  `func_key` varchar(60) NOT NULL COMMENT '功能key',
  `func_name` varchar(120) NOT NULL COMMENT '功能名称',
  `func_icon` varchar(32) DEFAULT NULL COMMENT '功能显示图片',
  `func_desc` varchar(150) DEFAULT NULL COMMENT '功能描述',
  `menu_id` bigint(20) NOT NULL COMMENT '所属菜单',
  PRIMARY KEY (`func_id`),
  UNIQUE KEY `func_key` (`func_key`),
  KEY `menu_id` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='功能表';

#
# Dumping data for table app_function
#

LOCK TABLES `app_function` WRITE;
/*!40000 ALTER TABLE `app_function` DISABLE KEYS */;
INSERT INTO `app_function` VALUES (1,'_FUNCKEY_myplan_edit','编辑任务','icon-btnedit','',4);
INSERT INTO `app_function` VALUES (2,'_FUNCKEY_myplan_del','删除任务','icon-btndel','',4);
/*!40000 ALTER TABLE `app_function` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_function_url
#

DROP TABLE IF EXISTS `app_function_url`;
CREATE TABLE `app_function_url` (
  `url_id` int(11) NOT NULL AUTO_INCREMENT,
  `func_id` int(11) NOT NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY (`url_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='功能URL';

#
# Dumping data for table app_function_url
#

LOCK TABLES `app_function_url` WRITE;
/*!40000 ALTER TABLE `app_function_url` DISABLE KEYS */;
INSERT INTO `app_function_url` VALUES (3,1,'aefew');
INSERT INTO `app_function_url` VALUES (4,2,'sdewr');
/*!40000 ALTER TABLE `app_function_url` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_global_type
#

DROP TABLE IF EXISTS `app_global_type`;
CREATE TABLE `app_global_type` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(128) NOT NULL COMMENT '名称',
  `type_parent` bigint(20) DEFAULT NULL COMMENT '父节点',
  `type_key` varchar(64) NOT NULL COMMENT '节点的分类Key',
  `type_desc` varchar(150) DEFAULT NULL COMMENT '分类描述',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总分类表  用于显示树层次结构的分类 可以允许任何层次结构';

#
# Dumping data for table app_global_type
#

LOCK TABLES `app_global_type` WRITE;
/*!40000 ALTER TABLE `app_global_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_global_type` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_archive
#

DROP TABLE IF EXISTS `app_hrm_archive`;
CREATE TABLE `app_hrm_archive` (
  `archive_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `job_id` bigint(20) NOT NULL COMMENT '应聘岗位ID',
  `archive_source` tinyint(4) NOT NULL COMMENT '来源',
  `archive_star` tinyint(4) NOT NULL COMMENT '评定星级',
  PRIMARY KEY (`archive_id`),
  KEY `job_id` (`job_id`),
  KEY `resume_id` (`resume_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='公司人才库';

#
# Dumping data for table app_hrm_archive
#

LOCK TABLES `app_hrm_archive` WRITE;
/*!40000 ALTER TABLE `app_hrm_archive` DISABLE KEYS */;
INSERT INTO `app_hrm_archive` VALUES (1,7,2,2,3);
INSERT INTO `app_hrm_archive` VALUES (2,8,2,5,2);
INSERT INTO `app_hrm_archive` VALUES (3,9,2,2,1);
/*!40000 ALTER TABLE `app_hrm_archive` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_employee
#

DROP TABLE IF EXISTS `app_hrm_employee`;
CREATE TABLE `app_hrm_employee` (
  `emp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_no` varchar(64) NOT NULL COMMENT '员工编号',
  `dep_id` bigint(20) NOT NULL COMMENT '员工所在部门ID',
  `district_id` bigint(20) NOT NULL COMMENT '员工所在校区ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `position_id` bigint(20) DEFAULT NULL COMMENT '岗位',
  `birthdate` date DEFAULT NULL COMMENT '出生日期',
  `phone_no` varchar(64) DEFAULT NULL COMMENT '电话',
  `short_no` varchar(64) DEFAULT NULL COMMENT '短号',
  `positive_due_date` date DEFAULT NULL COMMENT '待转正日期',
  `contract_end_date` date DEFAULT NULL COMMENT '合同到期日期',
  `onboard_status` bigint(20) DEFAULT NULL COMMENT '在职状态',
  `teacher_star` bigint(20) DEFAULT NULL,
  `consult_star` bigint(20) DEFAULT NULL,
  `teach_class` varchar(120) DEFAULT NULL,
  `teach_subject` varchar(120) DEFAULT NULL,
  `resume_id` bigint(20) DEFAULT NULL COMMENT '简历',
  `status` char(1) DEFAULT NULL COMMENT '员工状态',
  `entry_id` bigint(20) DEFAULT NULL COMMENT '录入人员',
  `entry_datetime` datetime DEFAULT NULL COMMENT '录入日期',
  PRIMARY KEY (`emp_id`),
  UNIQUE KEY `emp_no` (`emp_no`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='员工档案表';

#
# Dumping data for table app_hrm_employee
#

LOCK TABLES `app_hrm_employee` WRITE;
/*!40000 ALTER TABLE `app_hrm_employee` DISABLE KEYS */;
INSERT INTO `app_hrm_employee` VALUES (3,'0001012061241011',9,3,'Manie',1,NULL,'13588064354',NULL,NULL,NULL,1,3,4,'A,A1,A3,A5,B1,B3','A,A1,A3,B,B2,B6,C7,C8',16,NULL,1,'2012-06-12 16:10:11');
INSERT INTO `app_hrm_employee` VALUES (4,'0001112061243222',12,3,'Charotte',2,NULL,'13588064354',NULL,NULL,NULL,1,1,1,'','A2,B2',18,NULL,1,'2012-06-12 16:32:22');
INSERT INTO `app_hrm_employee` VALUES (5,'0001012061244839',9,3,'Chonticha',1,NULL,'13588064354',NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,19,NULL,1,'2012-06-12 16:48:39');
/*!40000 ALTER TABLE `app_hrm_employee` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_employee_develop
#

DROP TABLE IF EXISTS `app_hrm_employee_develop`;
CREATE TABLE `app_hrm_employee_develop` (
  `develop_id` bigint(20) DEFAULT NULL,
  `apply_form_no` varchar(120) DEFAULT NULL COMMENT '人资审批流程',
  `apply_form_type` bigint(20) DEFAULT NULL,
  `apply_date` date DEFAULT NULL,
  `comments` longtext,
  `emp_id` bigint(20) DEFAULT NULL COMMENT '员工ID',
  `from_district` bigint(20) DEFAULT NULL,
  `from_dep` bigint(20) DEFAULT NULL,
  `from_position` bigint(20) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `audit_state` bigint(20) DEFAULT NULL,
  `entry_id` bigint(20) DEFAULT NULL,
  `entry_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Dumping data for table app_hrm_employee_develop
#

LOCK TABLES `app_hrm_employee_develop` WRITE;
/*!40000 ALTER TABLE `app_hrm_employee_develop` DISABLE KEYS */;
INSERT INTO `app_hrm_employee_develop` VALUES (1,'1',1,'2012-06-19','1weqeqw',3,1,11,1,'Y',1,1,NULL);
/*!40000 ALTER TABLE `app_hrm_employee_develop` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_employee_profile
#

DROP TABLE IF EXISTS `app_hrm_employee_profile`;
CREATE TABLE `app_hrm_employee_profile` (
  `profile_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `status` tinyint(4) NOT NULL COMMENT '员工状态',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工基本信息表';

#
# Dumping data for table app_hrm_employee_profile
#

LOCK TABLES `app_hrm_employee_profile` WRITE;
/*!40000 ALTER TABLE `app_hrm_employee_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_hrm_employee_profile` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_employee_roadmap
#

DROP TABLE IF EXISTS `app_hrm_employee_roadmap`;
CREATE TABLE `app_hrm_employee_roadmap` (
  `roadmap_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `orginal_depid` bigint(20) NOT NULL COMMENT '员工所在部门ID',
  `orginal_districtid` bigint(20) NOT NULL COMMENT '员工所在校区ID',
  `orginal_positionid` bigint(20) NOT NULL COMMENT '员工所在职位ID',
  `dst_depid` bigint(20) DEFAULT NULL COMMENT '员工去向部门ID',
  `dst_districtid` bigint(20) DEFAULT NULL COMMENT '员工去向校区ID',
  `dst_positionid` bigint(20) DEFAULT NULL COMMENT '员工去向职位ID',
  `type` tinyint(4) NOT NULL COMMENT '类型',
  `date` datetime NOT NULL COMMENT '发生时间',
  PRIMARY KEY (`roadmap_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='员工历程';

#
# Dumping data for table app_hrm_employee_roadmap
#

LOCK TABLES `app_hrm_employee_roadmap` WRITE;
/*!40000 ALTER TABLE `app_hrm_employee_roadmap` DISABLE KEYS */;
INSERT INTO `app_hrm_employee_roadmap` VALUES (1,3,9,3,1,NULL,NULL,NULL,1,'2012-06-12 16:10:11');
INSERT INTO `app_hrm_employee_roadmap` VALUES (2,4,12,3,2,NULL,NULL,NULL,1,'2012-06-12 16:32:22');
INSERT INTO `app_hrm_employee_roadmap` VALUES (3,5,9,3,1,NULL,NULL,NULL,1,'2012-06-12 16:48:39');
INSERT INTO `app_hrm_employee_roadmap` VALUES (4,5,9,3,1,NULL,NULL,NULL,2,'2012-06-12 16:48:52');
/*!40000 ALTER TABLE `app_hrm_employee_roadmap` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_hire_entries
#

DROP TABLE IF EXISTS `app_hrm_hire_entries`;
CREATE TABLE `app_hrm_hire_entries` (
  `entry_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) NOT NULL COMMENT '应聘ID',
  `district_id` bigint(20) DEFAULT NULL COMMENT '入职校区',
  `dep_id` bigint(20) DEFAULT NULL COMMENT '入职部门',
  `position_id` bigint(20) DEFAULT NULL COMMENT '入职岗位',
  `charger_id` bigint(20) DEFAULT NULL COMMENT '负责人',
  `plan_date` datetime DEFAULT NULL COMMENT '安排入职时间',
  `act_date` datetime DEFAULT NULL COMMENT '实际入职时间',
  `inspect_status` tinyint(4) DEFAULT NULL COMMENT '考察结果状态',
  `cstatus` tinyint(4) NOT NULL COMMENT '当前状态',
  `fstatus` tinyint(4) DEFAULT NULL COMMENT '最终处理状态',
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='员工入职安排表';

#
# Dumping data for table app_hrm_hire_entries
#

LOCK TABLES `app_hrm_hire_entries` WRITE;
/*!40000 ALTER TABLE `app_hrm_hire_entries` DISABLE KEYS */;
INSERT INTO `app_hrm_hire_entries` VALUES (1,8,3,9,1,2,'2012-06-10 10:00:00','2012-06-13 05:35:29',2,2,2);
INSERT INTO `app_hrm_hire_entries` VALUES (5,16,3,9,1,1,'2012-06-15','2012-06-12 16:10:02',0,2,1);
INSERT INTO `app_hrm_hire_entries` VALUES (6,17,3,9,1,1,'2012-06-15 15:12:51','2012-06-14 16:05:51',0,2,1);
INSERT INTO `app_hrm_hire_entries` VALUES (7,18,3,12,2,1,'2012-06-15 16:31:47','2012-06-12 16:32:07',1,2,1);
INSERT INTO `app_hrm_hire_entries` VALUES (8,19,3,9,1,1,'2012-06-13','2012-06-15',1,2,1);
/*!40000 ALTER TABLE `app_hrm_hire_entries` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_hire_interviews
#

DROP TABLE IF EXISTS `app_hrm_hire_interviews`;
CREATE TABLE `app_hrm_hire_interviews` (
  `hw_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hissue_id` bigint(20) NOT NULL COMMENT '应聘ID',
  `interview_address` varchar(150) NOT NULL COMMENT '面试地址',
  `interview_date` datetime NOT NULL COMMENT '面试时间',
  `interviewer_id` bigint(20) NOT NULL COMMENT '面试官ID',
  `meto` varchar(250) DEFAULT NULL COMMENT '面试备注',
  `session_sn` tinyint(4) NOT NULL COMMENT '当前面试环节',
  `state` tinyint(4) DEFAULT NULL COMMENT '面试状态',
  `comments` varchar(150) DEFAULT NULL COMMENT '面试意见',
  PRIMARY KEY (`hw_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='招聘面试';

#
# Dumping data for table app_hrm_hire_interviews
#

LOCK TABLES `app_hrm_hire_interviews` WRITE;
/*!40000 ALTER TABLE `app_hrm_hire_interviews` DISABLE KEYS */;
INSERT INTO `app_hrm_hire_interviews` VALUES (5,6,'杭州总部','2012-06-13 14:34:56',1,'',1,2,'建议通过...');
INSERT INTO `app_hrm_hire_interviews` VALUES (6,7,'杭州总部','2012-06-20 15:34:57',2,'',1,3,NULL);
INSERT INTO `app_hrm_hire_interviews` VALUES (7,8,'杭州总部','2012-06-13 14:34:56',2,'',1,0,NULL);
INSERT INTO `app_hrm_hire_interviews` VALUES (8,9,'杭州总部','2012-06-15 23:32:04',1,'',1,3,'不合适...');
INSERT INTO `app_hrm_hire_interviews` VALUES (9,9,'杭州总部','2012-06-21 23:35:07',1,'',2,4,'这人坚决不要, 信用度太低啊..');
INSERT INTO `app_hrm_hire_interviews` VALUES (10,9,'杭州总部','2012-06-13',1,'',3,3,'烦不烦啊... ');
INSERT INTO `app_hrm_hire_interviews` VALUES (11,10,'杭州电子科技大学','2012-06-28 23:42:19',1,'',1,2,'');
INSERT INTO `app_hrm_hire_interviews` VALUES (12,10,'杭州电子科技大学','2012-06-07',1,'',2,3,'');
INSERT INTO `app_hrm_hire_interviews` VALUES (13,11,'萧山校区','2012-06-15 15:00:00',1,'',1,2,'表现很优异啊, 建议直接录取...');
/*!40000 ALTER TABLE `app_hrm_hire_interviews` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_hire_interviews_file
#

DROP TABLE IF EXISTS `app_hrm_hire_interviews_file`;
CREATE TABLE `app_hrm_hire_interviews_file` (
  `interview_id` bigint(20) NOT NULL COMMENT '面试ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY (`interview_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='面试附件';

#
# Dumping data for table app_hrm_hire_interviews_file
#

LOCK TABLES `app_hrm_hire_interviews_file` WRITE;
/*!40000 ALTER TABLE `app_hrm_hire_interviews_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_hrm_hire_interviews_file` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_hire_issue
#

DROP TABLE IF EXISTS `app_hrm_hire_issue`;
CREATE TABLE `app_hrm_hire_issue` (
  `hissue_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `hjob_id` bigint(20) NOT NULL COMMENT '应聘职位ID',
  `current_status` tinyint(4) NOT NULL COMMENT '当前状态',
  `final_result` tinyint(4) DEFAULT NULL COMMENT '最终处理结果',
  `user_id` bigint(20) DEFAULT NULL COMMENT '应聘者ID, 主要用于存员工申请 (包含自我申请, 推荐他人)',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY (`hissue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='当前招聘';

#
# Dumping data for table app_hrm_hire_issue
#

LOCK TABLES `app_hrm_hire_issue` WRITE;
/*!40000 ALTER TABLE `app_hrm_hire_issue` DISABLE KEYS */;
INSERT INTO `app_hrm_hire_issue` VALUES (6,6,2,3,NULL,NULL,'2012-06-10 14:34:39');
INSERT INTO `app_hrm_hire_issue` VALUES (7,7,2,4,2,NULL,'2012-06-10 15:34:45');
INSERT INTO `app_hrm_hire_issue` VALUES (8,8,2,4,1,NULL,'2012-06-10 22:51:23');
INSERT INTO `app_hrm_hire_issue` VALUES (9,9,2,4,2,NULL,'2012-06-11 23:31:55');
INSERT INTO `app_hrm_hire_issue` VALUES (10,10,2,0,NULL,NULL,'2012-06-11 23:42:01');
INSERT INTO `app_hrm_hire_issue` VALUES (11,11,2,4,1,NULL,'2012-06-12 13:45:20');
INSERT INTO `app_hrm_hire_issue` VALUES (12,12,2,4,1,1,'2012-06-12 13:50:57');
INSERT INTO `app_hrm_hire_issue` VALUES (13,13,2,4,1,1,'2012-06-12 14:13:17');
INSERT INTO `app_hrm_hire_issue` VALUES (14,14,2,4,1,1,'2012-06-12 14:15:06');
INSERT INTO `app_hrm_hire_issue` VALUES (15,15,2,4,1,1,'2012-06-12 14:16:21');
INSERT INTO `app_hrm_hire_issue` VALUES (16,16,2,4,1,1,'2012-06-12 14:19:51');
INSERT INTO `app_hrm_hire_issue` VALUES (17,17,2,4,1,1,'2012-06-12 14:36:15');
INSERT INTO `app_hrm_hire_issue` VALUES (18,18,2,4,1,1,'2012-06-12 16:31:21');
INSERT INTO `app_hrm_hire_issue` VALUES (19,19,2,4,1,1,'2012-06-12 16:48:04');
/*!40000 ALTER TABLE `app_hrm_hire_issue` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_hire_job
#

DROP TABLE IF EXISTS `app_hrm_hire_job`;
CREATE TABLE `app_hrm_hire_job` (
  `hjob_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_title` varchar(128) NOT NULL COMMENT '招聘岗位名称',
  `hjob_districtid` bigint(20) NOT NULL COMMENT '招聘校区',
  `hjob_depid` bigint(20) NOT NULL COMMENT '招聘部门',
  `hjob_range` tinyint(4) NOT NULL COMMENT '招聘范围',
  `hjob_visible_districtid` bigint(20) DEFAULT NULL COMMENT '可见范围',
  `end_date` datetime NOT NULL COMMENT '结束时间',
  `hjob_count` int(11) NOT NULL COMMENT '招聘人数',
  `hjob_condition` varchar(1024) DEFAULT NULL COMMENT '招聘要求(条件)',
  `hjob_address` varchar(150) DEFAULT NULL COMMENT '工作地点',
  `hjob_responsibility` text COMMENT '工作职责',
  `hjob_salary` text COMMENT '薪资福利',
  `reg_fullname` varchar(128) DEFAULT NULL COMMENT '登记人姓名',
  `reg_date` datetime DEFAULT NULL COMMENT '登记时间',
  `modify_fullname` varchar(32) DEFAULT NULL COMMENT '变更人姓名',
  `modify_date` datetime DEFAULT NULL COMMENT '变更时间',
  `check_fullname` varchar(32) DEFAULT NULL COMMENT '审核人姓名',
  `check_opinion` varchar(512) DEFAULT NULL COMMENT '审核意见',
  `check_date` datetime DEFAULT NULL COMMENT '审批时间',
  `status` smallint(6) NOT NULL COMMENT '状态            1=通过审核            0=未审核            2=审核不通过',
  `memo` varchar(1024) DEFAULT NULL COMMENT '备注',
  `isopen` tinyint(4) DEFAULT '1' COMMENT '应聘控制 0=关闭, 1=开放',
  PRIMARY KEY (`hjob_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='招聘岗位发布';

#
# Dumping data for table app_hrm_hire_job
#

LOCK TABLES `app_hrm_hire_job` WRITE;
/*!40000 ALTER TABLE `app_hrm_hire_job` DISABLE KEYS */;
INSERT INTO `app_hrm_hire_job` VALUES (1,'技术总监',3,1,2,NULL,'2012-06-18',1,'','杭州','test','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL);
INSERT INTO `app_hrm_hire_job` VALUES (2,'产品经理',1,7,1,NULL,'2012-06-19',5,'','杭州电子科技大学','','',NULL,NULL,NULL,NULL,'卡卡西',NULL,'2012-06-09 12:34:23',1,NULL,1);
INSERT INTO `app_hrm_hire_job` VALUES (3,'test',3,12,1,NULL,'2012-06-15',21,'','','','','卡卡西','2012-06-13 16:39:34',NULL,NULL,NULL,NULL,NULL,4,NULL,NULL);
INSERT INTO `app_hrm_hire_job` VALUES (4,'adsasd',3,9,1,NULL,'2012-07-10',2,'asd','asd','ads','asd','唐伯虎','2012-07-16 16:21:31',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL);
INSERT INTO `app_hrm_hire_job` VALUES (5,'45645',1,11,1,NULL,'2012-07-19',12,'ads','奥德赛ads','ad','asd','唐伯虎','2012-07-18 15:27:48',NULL,NULL,NULL,NULL,NULL,2,NULL,NULL);
/*!40000 ALTER TABLE `app_hrm_hire_job` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_resume
#

DROP TABLE IF EXISTS `app_hrm_resume`;
CREATE TABLE `app_hrm_resume` (
  `resume_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_id` bigint(20) DEFAULT NULL COMMENT '员工ID号, 有可能该ID号为空',
  `fullname` varchar(64) NOT NULL COMMENT '姓名',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `birthday` datetime DEFAULT NULL COMMENT '出生日期',
  `address` varchar(128) DEFAULT NULL COMMENT '居住地址',
  `marriage` tinyint(4) DEFAULT NULL COMMENT '婚姻状况 1=未婚, 2=已婚',
  `zip` varchar(32) DEFAULT NULL COMMENT '邮编',
  `sex` tinyint(4) DEFAULT NULL COMMENT '性别 1=男生, 2=女生',
  `phone` varchar(64) DEFAULT NULL COMMENT '座机',
  `mobile` varchar(64) DEFAULT NULL COMMENT '移动电话 (联系电话)',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱地址',
  `hobby` varchar(256) DEFAULT NULL COMMENT '兴趣爱好',
  `religion` varchar(128) DEFAULT NULL,
  `party` tinyint(4) DEFAULT NULL COMMENT '政治面貌 1=群众, 2=党员, 3=团员',
  `nationality` varchar(32) DEFAULT NULL COMMENT '国籍',
  `race` varchar(32) DEFAULT NULL,
  `birthPlace` varchar(128) DEFAULT NULL COMMENT '籍贯',
  `eduCollege` varchar(128) DEFAULT NULL COMMENT '毕业院校',
  `eduDegree` tinyint(4) DEFAULT NULL COMMENT '学历 1=研究生, 2=本科, 3=大专, 4=其他',
  `eduMajor` varchar(128) DEFAULT NULL COMMENT '专业',
  `teacher_major` tinyint(4) DEFAULT NULL COMMENT '师范类专业 1=是, 2=否',
  `teacher_cert` tinyint(4) DEFAULT NULL COMMENT '有无教师资格 1=有, 2=无',
  `startWorkDate` datetime DEFAULT NULL,
  `idNo` varchar(64) DEFAULT NULL COMMENT '身份证',
  `photo` varchar(128) DEFAULT NULL,
  `status` varchar(64) DEFAULT NULL COMMENT '状态                        通过            未通过            准备安排面试            面试通过                        ',
  `memo` varchar(1024) DEFAULT NULL,
  `registor` varchar(64) DEFAULT NULL,
  `regTime` datetime DEFAULT NULL,
  `workCase` text,
  `trainCase` text,
  `projectCase` text,
  `en_level` tinyint(4) DEFAULT NULL COMMENT '外语等级 1=CET-4, 2=CET-6, 3=专业四级, 4=专业八级, 5=其他',
  `cn_level` tinyint(4) DEFAULT NULL COMMENT '普通话等级 1=一级甲等, 2=一级乙等, 3=二级甲等, 4=二级乙等, 5=三级甲等, 6=三级乙等, 7=无',
  `source` tinyint(4) DEFAULT NULL COMMENT '简历来源',
  PRIMARY KEY (`resume_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='简历管理';

#
# Dumping data for table app_hrm_resume
#

LOCK TABLES `app_hrm_resume` WRITE;
/*!40000 ALTER TABLE `app_hrm_resume` DISABLE KEYS */;
INSERT INTO `app_hrm_resume` VALUES (6,NULL,'佐助',NULL,NULL,'火影村',1,NULL,1,NULL,'13588064354','火影@163.com',NULL,NULL,1,NULL,NULL,'非人类','',1,'',1,1,NULL,'362412312412',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (7,NULL,'大和',NULL,NULL,'',1,NULL,1,NULL,'13512456013','',NULL,NULL,1,NULL,NULL,'','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (8,NULL,'鸣人',NULL,NULL,'',1,NULL,1,NULL,'13512456013','',NULL,NULL,1,NULL,NULL,'','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (9,NULL,'大和2',NULL,NULL,'',1,NULL,1,NULL,'13512456013','',NULL,NULL,1,NULL,NULL,'','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (10,NULL,'品冠',NULL,NULL,'',1,NULL,1,NULL,'13845671203','',NULL,NULL,1,NULL,NULL,'','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (11,NULL,'Vincent',NULL,NULL,'',2,NULL,1,NULL,'13512456013','',NULL,NULL,2,NULL,NULL,'','',2,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4,6,2);
INSERT INTO `app_hrm_resume` VALUES (12,NULL,'Jeth',NULL,NULL,'',1,NULL,1,NULL,'0608943125232','',NULL,NULL,1,NULL,NULL,'菲律宾','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,2);
INSERT INTO `app_hrm_resume` VALUES (13,NULL,'Gino.P',NULL,NULL,'',1,NULL,1,NULL,'0608943125232','',NULL,NULL,1,NULL,NULL,'菲律宾','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (14,NULL,'Gino.M',NULL,NULL,'',1,NULL,1,NULL,'0608943125232','',NULL,NULL,1,NULL,NULL,'菲律宾','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,2);
INSERT INTO `app_hrm_resume` VALUES (15,NULL,'Xavier',NULL,NULL,'',1,NULL,1,NULL,'0608943125232','',NULL,NULL,1,NULL,NULL,'','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (16,NULL,'Manie',NULL,NULL,'',1,NULL,1,NULL,'13588064354','',NULL,NULL,1,NULL,NULL,'','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (17,NULL,'Gian',NULL,NULL,'',1,NULL,1,NULL,'13588064354','',NULL,NULL,1,NULL,NULL,'','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (18,4,'Charotte',NULL,NULL,'',1,NULL,1,NULL,'13588064354','',NULL,NULL,1,NULL,NULL,'','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
INSERT INTO `app_hrm_resume` VALUES (19,5,'Chonticha',NULL,NULL,'',1,NULL,1,NULL,'13588064354','',NULL,NULL,1,NULL,NULL,'泰国','',1,'',1,1,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0);
/*!40000 ALTER TABLE `app_hrm_resume` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_hrm_resume_file
#

DROP TABLE IF EXISTS `app_hrm_resume_file`;
CREATE TABLE `app_hrm_resume_file` (
  `file_id` bigint(20) NOT NULL,
  `resum_id` bigint(20) NOT NULL,
  PRIMARY KEY (`file_id`,`resum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历附件';

#
# Dumping data for table app_hrm_resume_file
#

LOCK TABLES `app_hrm_resume_file` WRITE;
/*!40000 ALTER TABLE `app_hrm_resume_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_hrm_resume_file` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_menu
#

DROP TABLE IF EXISTS `app_menu`;
CREATE TABLE `app_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_title` varchar(50) NOT NULL COMMENT '菜单名称',
  `menu_icon` varchar(20) DEFAULT NULL COMMENT '菜单图标',
  `menu_url` varchar(100) NOT NULL COMMENT '菜单链接',
  `menu_key` varchar(64) NOT NULL COMMENT '菜单key',
  `menu_desc` varchar(100) DEFAULT NULL COMMENT '菜单描述',
  `menu_parent` int(11) DEFAULT NULL COMMENT '父菜单',
  `menu_order` int(11) DEFAULT NULL COMMENT '菜单项顺序',
  PRIMARY KEY (`menu_id`),
  UNIQUE KEY `menu_key` (`menu_key`),
  KEY `menu_parent` (`menu_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='系统菜单';

#
# Dumping data for table app_menu
#

LOCK TABLES `app_menu` WRITE;
/*!40000 ALTER TABLE `app_menu` DISABLE KEYS */;
INSERT INTO `app_menu` VALUES (3,'我的工作区','icon-desktop','javascript:void(0);','_menu_mod_personal','',NULL,0);
INSERT INTO `app_menu` VALUES (4,'我的任务','icon-myplan','javascript:void(0);','_menu_mod_personal_mytask','test0',3,0);
/*!40000 ALTER TABLE `app_menu` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_process_definition
#

DROP TABLE IF EXISTS `app_process_definition`;
CREATE TABLE `app_process_definition` (
  `def_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) DEFAULT NULL COMMENT '流程分类ID',
  `def_name` varchar(256) DEFAULT NULL COMMENT '流程名称',
  `def_description` varchar(250) DEFAULT NULL COMMENT '流程描述',
  `filter_posnames` varchar(250) DEFAULT NULL COMMENT '过滤职位',
  `def_trigger` varchar(120) DEFAULT NULL COMMENT '条件',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`def_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='流程定义';

#
# Dumping data for table app_process_definition
#

LOCK TABLES `app_process_definition` WRITE;
/*!40000 ALTER TABLE `app_process_definition` DISABLE KEYS */;
INSERT INTO `app_process_definition` VALUES (1,7,'0 < 支出费用 <= 1000','','test','x > 0 && x <= 1000','2012-06-29 14:50:40');
INSERT INTO `app_process_definition` VALUES (2,7,'1000 < 支出费用 <= 10000','','test','x > 1000 && x <= 10000','2012-06-29 14:51:15');
INSERT INTO `app_process_definition` VALUES (3,7,'支出费用 >10000','','test','x > 10000','2012-06-29 15:00:28');
/*!40000 ALTER TABLE `app_process_definition` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_process_form
#

DROP TABLE IF EXISTS `app_process_form`;
CREATE TABLE `app_process_form` (
  `form_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_no` varchar(120) NOT NULL COMMENT '流程申请单号',
  `type_id` bigint(20) NOT NULL COMMENT '流程类型',
  `task_name` varchar(128) NOT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) DEFAULT NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) DEFAULT NULL COMMENT '跳转节点, 跳转至下一任务',
  `seq_sn` int(11) NOT NULL COMMENT '序列编号',
  `to_rolenames` varchar(250) DEFAULT NULL,
  `to_distnames` varchar(250) DEFAULT NULL,
  `to_depnames` varchar(250) DEFAULT NULL,
  `to_posnames` varchar(250) DEFAULT NULL,
  `to_usernames` varchar(250) DEFAULT NULL,
  `audit_rolenames` varchar(250) DEFAULT NULL,
  `audit_distnames` varchar(250) DEFAULT NULL,
  `audit_depnames` varchar(250) DEFAULT NULL,
  `audit_usernames` varchar(250) DEFAULT NULL,
  `audit_posnames` varchar(250) DEFAULT NULL,
  `to_userids` varchar(250) DEFAULT NULL,
  `to_roleids` varchar(250) DEFAULT NULL,
  `to_distids` varchar(250) DEFAULT NULL,
  `to_depids` varchar(250) DEFAULT NULL,
  `to_posids` varchar(250) DEFAULT NULL,
  `audit_userids` varchar(250) DEFAULT NULL,
  `audit_roleids` varchar(250) DEFAULT NULL,
  `audit_distids` varchar(250) DEFAULT NULL,
  `audit_depids` varchar(250) DEFAULT NULL,
  `audit_posids` varchar(250) DEFAULT NULL,
  `audit_date` datetime DEFAULT NULL,
  `audit_state` smallint(6) DEFAULT NULL COMMENT '审核状态, 0=审核中, 1=审核通过 2=审核不通过',
  `audit_comments` text COMMENT '审核意见',
  PRIMARY KEY (`form_id`),
  KEY `form_no` (`form_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据';

#
# Dumping data for table app_process_form
#

LOCK TABLES `app_process_form` WRITE;
/*!40000 ALTER TABLE `app_process_form` DISABLE KEYS */;
INSERT INTO `app_process_form` VALUES (1,'1',1,'234234','1','1',1,'1',NULL,'行政部','人事主管','1','1',NULL,'11','11','1','1','1',NULL,'1','1','1','11',NULL,'1','1','2012-06-22 21:03:28',1,'11');
/*!40000 ALTER TABLE `app_process_form` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_process_history
#

DROP TABLE IF EXISTS `app_process_history`;
CREATE TABLE `app_process_history` (
  `history_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_no` varchar(120) NOT NULL COMMENT '流程申请单号',
  `type_id` bigint(20) NOT NULL COMMENT '流程类型',
  `task_name` varchar(128) NOT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) DEFAULT NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) DEFAULT NULL COMMENT '跳转节点, 跳转至下一任务',
  `seq_sn` int(11) NOT NULL COMMENT '序列编号',
  `to_rolenames` varchar(250) DEFAULT NULL,
  `to_distnames` varchar(250) DEFAULT NULL,
  `to_depnames` varchar(250) DEFAULT NULL,
  `to_posnames` varchar(250) DEFAULT NULL,
  `to_usernames` varchar(250) DEFAULT NULL,
  `audit_rolenames` varchar(250) DEFAULT NULL,
  `audit_distnames` varchar(250) DEFAULT NULL,
  `audit_depnames` varchar(250) DEFAULT NULL,
  `audit_usernames` varchar(250) DEFAULT NULL,
  `audit_posnames` varchar(250) DEFAULT NULL,
  `to_userids` varchar(250) DEFAULT NULL,
  `to_roleids` varchar(250) DEFAULT NULL,
  `to_distids` varchar(250) DEFAULT NULL,
  `to_depids` varchar(250) DEFAULT NULL,
  `to_posids` varchar(250) DEFAULT NULL,
  `audit_userids` varchar(250) DEFAULT NULL,
  `audit_roleids` varchar(250) DEFAULT NULL,
  `audit_distids` varchar(250) DEFAULT NULL,
  `audit_depids` varchar(250) DEFAULT NULL,
  `audit_posids` varchar(250) DEFAULT NULL,
  `audit_date` datetime DEFAULT NULL,
  `audit_state` smallint(6) DEFAULT NULL COMMENT '审核状态, 0=审核中, 1=审核通过 2=审核不通过',
  `audit_comments` text COMMENT '审核意见',
  PRIMARY KEY (`history_id`),
  KEY `form_no` (`form_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据';

#
# Dumping data for table app_process_history
#

LOCK TABLES `app_process_history` WRITE;
/*!40000 ALTER TABLE `app_process_history` DISABLE KEYS */;
INSERT INTO `app_process_history` VALUES (1,'1',1,'11','1','1',1,'1','1','1','1','1','1','1','1','11','11','11','11','1','1','1','11','11','11','1','1','0000-00-00 00:00:00',1,NULL);
/*!40000 ALTER TABLE `app_process_history` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_process_task
#

DROP TABLE IF EXISTS `app_process_task`;
CREATE TABLE `app_process_task` (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `def_id` bigint(20) NOT NULL COMMENT '所属流程定义ID',
  `task_name` varchar(128) DEFAULT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) DEFAULT NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) DEFAULT NULL COMMENT '跳转节点, 跳转至下一任务',
  `seq_sn` int(11) NOT NULL COMMENT '序列编号',
  `to_rolenames` varchar(250) DEFAULT NULL COMMENT '待审批角色名称集合',
  `to_depnames` varchar(250) DEFAULT NULL COMMENT '待审批部门名称集合',
  `to_posnames` varchar(250) DEFAULT NULL COMMENT '待审批职位名称集合',
  `to_usernames` varchar(250) DEFAULT NULL COMMENT '待审批用户名称集合',
  `to_userids` varchar(250) DEFAULT NULL COMMENT '用户IDS 格式如下，以方便使用like操作 ,1,2,',
  `to_roleids` varchar(250) DEFAULT NULL COMMENT '角色IDS 格式如下，以方便使用like操作 ,1,2,',
  `to_depids` varchar(250) DEFAULT NULL COMMENT '部门IDS 格式如下，以方便使用like操作 ,1,2,',
  `to_posids` varchar(250) DEFAULT NULL COMMENT '岗位ID集合, 易于操作',
  `comments` text COMMENT '意见',
  `task_type` tinyint(4) DEFAULT NULL COMMENT '活动类型',
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='流程任务设置';

#
# Dumping data for table app_process_task
#

LOCK TABLES `app_process_task` WRITE;
/*!40000 ALTER TABLE `app_process_task` DISABLE KEYS */;
INSERT INTO `app_process_task` VALUES (1,1,NULL,NULL,NULL,1,NULL,'市场部,行政部,总经办,人资部','部门主管,部门主管,行政主管,人事主管',NULL,NULL,NULL,'13,12,9,14','1,4,3,2',NULL,1);
INSERT INTO `app_process_task` VALUES (2,1,NULL,NULL,NULL,2,NULL,'人资部','人事主管',NULL,NULL,NULL,'9','1',NULL,2);
INSERT INTO `app_process_task` VALUES (3,1,NULL,NULL,NULL,3,NULL,'人资部','部门主管',NULL,NULL,NULL,'7','5',NULL,4);
INSERT INTO `app_process_task` VALUES (4,1,NULL,NULL,NULL,4,NULL,'行政部','行政主管',NULL,NULL,NULL,'12','2',NULL,2);
INSERT INTO `app_process_task` VALUES (5,2,NULL,NULL,NULL,1,NULL,'行政部','行政主管',NULL,NULL,NULL,'12','2',NULL,2);
INSERT INTO `app_process_task` VALUES (6,1,NULL,NULL,NULL,5,NULL,'总经办','部门主管',NULL,NULL,NULL,'13','3',NULL,2);
INSERT INTO `app_process_task` VALUES (7,1,NULL,NULL,NULL,6,NULL,'人资部','部门主管',NULL,NULL,NULL,'7','5',NULL,4);
/*!40000 ALTER TABLE `app_process_task` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_process_type
#

DROP TABLE IF EXISTS `app_process_type`;
CREATE TABLE `app_process_type` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(128) NOT NULL COMMENT '流程分类名',
  `type_key` varchar(64) DEFAULT NULL COMMENT '流程分类KEY',
  `type_desc` varchar(250) DEFAULT NULL COMMENT '流程分类描述',
  `type_slug` varchar(64) NOT NULL COMMENT '分类类别',
  `type_parent` bigint(20) DEFAULT NULL COMMENT '流程父分类',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='流程分类';

#
# Dumping data for table app_process_type
#

LOCK TABLES `app_process_type` WRITE;
/*!40000 ALTER TABLE `app_process_type` DISABLE KEYS */;
INSERT INTO `app_process_type` VALUES (1,'费用支出申请审批','PROCESS_PAYMENT',NULL,'finance',NULL);
INSERT INTO `app_process_type` VALUES (2,'合同申请审批','PROCESS_CONTRACT',NULL,'finance',NULL);
INSERT INTO `app_process_type` VALUES (3,'转正申请审批','PROCESS_MEMBER_BERGULAR',NULL,'hrm',NULL);
INSERT INTO `app_process_type` VALUES (4,'调动申请审批','PROCESS_MEMBER_TRANSFER',NULL,'hrm',NULL);
INSERT INTO `app_process_type` VALUES (5,'晋升申请审批','PROCESS_MEMBER_PROMOTION',NULL,'hrm',NULL);
INSERT INTO `app_process_type` VALUES (6,'离职申请审批','PROCESS_MEMBER_FAIRWELL',NULL,'hrm',NULL);
INSERT INTO `app_process_type` VALUES (7,'工资薪资支出','PROCESS_SALARY_PAYMENT','支付给员工薪资的审批类型...','finance',1);
INSERT INTO `app_process_type` VALUES (8,'房租合同','PROCESS_HOUSE_RENT','房租合同','finance',2);
INSERT INTO `app_process_type` VALUES (9,'员工薪资','PROCESS_EMP_PAYROLL','','finance',1);
/*!40000 ALTER TABLE `app_process_type` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_role
#

DROP TABLE IF EXISTS `app_role`;
CREATE TABLE `app_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(120) NOT NULL COMMENT '角色名称',
  `role_key` varchar(64) NOT NULL COMMENT '权限组Key',
  `role_desc` varchar(150) DEFAULT NULL COMMENT '角色描述',
  `role_status` tinyint(4) DEFAULT '1' COMMENT '角色状态, 1=开放, 0=被锁住',
  `role_rights` text COMMENT '权限功能列表',
  `role_type` tinyint(4) NOT NULL COMMENT '角色类型, 0=总部, 1=校区, 2=片区',
  `role_edit` tinyint(4) NOT NULL DEFAULT '1' COMMENT '角色是否可以进行修改, 1=可以, 0=不可以',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_key` (`role_key`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='角色表';

#
# Dumping data for table app_role
#

LOCK TABLES `app_role` WRITE;
/*!40000 ALTER TABLE `app_role` DISABLE KEYS */;
INSERT INTO `app_role` VALUES (1,'超级管理员','ROLE_SUPER',NULL,1,'__ALL',0,0);
INSERT INTO `app_role` VALUES (5,'校长','ROLE_MASTER','teset',1,'_FUNCKEY_myplan_edit',1,1);
/*!40000 ALTER TABLE `app_role` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_role_func
#

DROP TABLE IF EXISTS `app_role_func`;
CREATE TABLE `app_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`func_id`),
  KEY `role_id` (`role_id`),
  KEY `app_role_func_ibfk_2` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

#
# Dumping data for table app_role_func
#

LOCK TABLES `app_role_func` WRITE;
/*!40000 ALTER TABLE `app_role_func` DISABLE KEYS */;
INSERT INTO `app_role_func` VALUES (5,1);
/*!40000 ALTER TABLE `app_role_func` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_role_menu
#

DROP TABLE IF EXISTS `app_role_menu`;
CREATE TABLE `app_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单';

#
# Dumping data for table app_role_menu
#

LOCK TABLES `app_role_menu` WRITE;
/*!40000 ALTER TABLE `app_role_menu` DISABLE KEYS */;
INSERT INTO `app_role_menu` VALUES (5,3);
INSERT INTO `app_role_menu` VALUES (5,4);
/*!40000 ALTER TABLE `app_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_school_department
#

DROP TABLE IF EXISTS `app_school_department`;
CREATE TABLE `app_school_department` (
  `dep_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dep_no` varchar(32) NOT NULL COMMENT '部门编号',
  `dep_name` varchar(128) NOT NULL COMMENT '部门名称',
  `dep_desc` varchar(256) DEFAULT NULL COMMENT '部门描述',
  `dep_eqlevel` tinyint(4) DEFAULT '-1' COMMENT '对口级别, -1=无, 0=总部, 1=校区, 2=片区',
  `dep_eqid` bigint(20) DEFAULT NULL COMMENT '对口部门',
  `dep_orgtype` tinyint(4) NOT NULL COMMENT '部门结构类型 0=总部, 1=校区, 2=片区',
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='学校部门设置';

#
# Dumping data for table app_school_department
#

LOCK TABLES `app_school_department` WRITE;
/*!40000 ALTER TABLE `app_school_department` DISABLE KEYS */;
INSERT INTO `app_school_department` VALUES (7,'0','人资部','',0,NULL,0);
INSERT INTO `app_school_department` VALUES (9,'0','人资部','',0,NULL,1);
INSERT INTO `app_school_department` VALUES (10,'1','总经办','',0,NULL,0);
INSERT INTO `app_school_department` VALUES (11,'1','行政部','',0,NULL,0);
INSERT INTO `app_school_department` VALUES (12,'1','行政部','',0,NULL,1);
INSERT INTO `app_school_department` VALUES (13,'006','总经办','',0,NULL,1);
INSERT INTO `app_school_department` VALUES (14,'007','市场部','',0,NULL,1);
/*!40000 ALTER TABLE `app_school_department` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_school_department_position
#

DROP TABLE IF EXISTS `app_school_department_position`;
CREATE TABLE `app_school_department_position` (
  `pos_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pos_name` varchar(150) NOT NULL COMMENT '岗位名称',
  `pos_desc` varchar(250) DEFAULT NULL COMMENT '岗位描述',
  `pos_leadership` tinyint(4) DEFAULT '1' COMMENT '是否领导, 0=是, 1=不是',
  `dep_id` bigint(20) NOT NULL COMMENT '部门ID',
  `pos_roleRights` varchar(500) DEFAULT NULL COMMENT '岗位角色权限',
  PRIMARY KEY (`pos_id`),
  KEY `dep_id` (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='部门岗位';

#
# Dumping data for table app_school_department_position
#

LOCK TABLES `app_school_department_position` WRITE;
/*!40000 ALTER TABLE `app_school_department_position` DISABLE KEYS */;
INSERT INTO `app_school_department_position` VALUES (1,'人事主管','',0,9,'');
INSERT INTO `app_school_department_position` VALUES (2,'行政主管','',0,12,'');
INSERT INTO `app_school_department_position` VALUES (3,'部门主管','',0,13,'');
INSERT INTO `app_school_department_position` VALUES (4,'部门主管','',0,14,'');
INSERT INTO `app_school_department_position` VALUES (5,'部门主管','',0,7,'');
/*!40000 ALTER TABLE `app_school_department_position` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_school_department_position_role
#

DROP TABLE IF EXISTS `app_school_department_position_role`;
CREATE TABLE `app_school_department_position_role` (
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`pos_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位权限';

#
# Dumping data for table app_school_department_position_role
#

LOCK TABLES `app_school_department_position_role` WRITE;
/*!40000 ALTER TABLE `app_school_department_position_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_school_department_position_role` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_school_district
#

DROP TABLE IF EXISTS `app_school_district`;
CREATE TABLE `app_school_district` (
  `district_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `district_no` varchar(64) NOT NULL COMMENT '校区编号',
  `district_name` varchar(120) NOT NULL COMMENT '学校校区名称',
  `district_type` tinyint(4) NOT NULL COMMENT '校区类型',
  `district_address` varchar(150) DEFAULT NULL COMMENT '校区地址',
  `district_phone` varchar(150) DEFAULT NULL COMMENT '校区电话',
  `district_parent` bigint(20) DEFAULT NULL COMMENT '校区上级结构',
  PRIMARY KEY (`district_id`),
  UNIQUE KEY `district_no` (`district_no`),
  KEY `district_parent` (`district_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='校区设置';

#
# Dumping data for table app_school_district
#

LOCK TABLES `app_school_district` WRITE;
/*!40000 ALTER TABLE `app_school_district` DISABLE KEYS */;
INSERT INTO `app_school_district` VALUES (1,'0000','杭州总部',0,'','',NULL);
INSERT INTO `app_school_district` VALUES (3,'0001','萧山校区',1,'asdads','',1);
/*!40000 ALTER TABLE `app_school_district` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_system_config
#

DROP TABLE IF EXISTS `app_system_config`;
CREATE TABLE `app_system_config` (
  `config_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(64) NOT NULL COMMENT 'Key',
  `config_name` varchar(64) NOT NULL COMMENT '配置名称',
  `config_desc` varchar(256) DEFAULT NULL COMMENT '配置描述',
  `type_name` varchar(32) NOT NULL COMMENT '所属分类名称',
  `data_type` smallint(6) NOT NULL COMMENT '数据类型            1=varchar            2=intger            3=decimal            4=datetime            5=time            ',
  `data_value` varchar(64) DEFAULT NULL COMMENT '数据值',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置,用于系统的全局配置';

#
# Dumping data for table app_system_config
#

LOCK TABLES `app_system_config` WRITE;
/*!40000 ALTER TABLE `app_system_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_system_config` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_system_dictionary
#

DROP TABLE IF EXISTS `app_system_dictionary`;
CREATE TABLE `app_system_dictionary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `value` varchar(200) NOT NULL,
  `type` varchar(200) NOT NULL,
  `sequence` int(11) NOT NULL DEFAULT '0',
  `extra_value` varchar(200) DEFAULT NULL,
  `creation_date` datetime DEFAULT '0000-00-00 00:00:00',
  `modified_date` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Dumping data for table app_system_dictionary
#

LOCK TABLES `app_system_dictionary` WRITE;
/*!40000 ALTER TABLE `app_system_dictionary` DISABLE KEYS */;
INSERT INTO `app_system_dictionary` VALUES (1,'人资文档','人资文档','docType',0,'123456','0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `app_system_dictionary` VALUES (2,'行政文档','行政文档','docType',0,'456789','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `app_system_dictionary` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_system_log
#

DROP TABLE IF EXISTS `app_system_log`;
CREATE TABLE `app_system_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(120) NOT NULL COMMENT '用户名',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='系统日志';

#
# Dumping data for table app_system_log
#

LOCK TABLES `app_system_log` WRITE;
/*!40000 ALTER TABLE `app_system_log` DISABLE KEYS */;
INSERT INTO `app_system_log` VALUES (1,'test',1,'2012-06-02 17:48:55','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (2,'test',1,'2012-06-04 18:41:12','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (3,'test',1,'2012-06-04 18:41:14','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (4,'test',1,'2012-06-04 18:41:27','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (5,'test',1,'2012-06-05 00:07:06','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (6,'test',1,'2012-06-05 01:49:47','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (7,'test',1,'2012-06-05 01:51:06','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (8,'test',1,'2012-06-05 01:51:08','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (9,'test',1,'2012-06-05 01:51:09','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (10,'test',1,'2012-06-05 01:51:20','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (11,'test',1,'2012-06-05 14:23:42','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (12,'test',1,'2012-06-05 17:22:27','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (13,'test',1,'2012-06-05 20:34:34','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (14,'test',1,'2012-06-05 20:34:39','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (15,'test',1,'2012-06-05 20:35:10','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (16,'test',1,'2012-06-05 20:37:54','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (17,'test',1,'2012-06-06 22:04:42','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (18,'test',1,'2012-06-06 22:08:14','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (19,'test',1,'2012-06-06 22:09:23','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (20,'test',1,'2012-06-07 00:01:04','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (21,'test',1,'2012-06-07 19:40:29','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (22,'test',1,'2012-06-07 21:09:28','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (23,'test',1,'2012-06-07 21:09:41','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (24,'test',1,'2012-06-07 23:05:20','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (25,'test',1,'2012-06-07 23:10:57','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (26,'test',1,'2012-06-07 23:11:14','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (27,'test',1,'2012-06-07 23:11:53','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (28,'test',1,'2012-06-07 23:12:09','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (29,'test',1,'2012-06-07 23:12:32','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (30,'test',1,'2012-06-07 23:13:31','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (31,'test',1,'2012-06-07 23:14:23','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (32,'test',1,'2012-06-07 23:14:56','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (33,'test',1,'2012-06-07 23:16:18','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (34,'test',1,'2012-06-07 23:16:52','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (35,'test',1,'2012-06-07 23:16:54','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (36,'test',1,'2012-06-08 00:06:08','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (37,'test',1,'2012-06-08 00:06:10','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (38,'test',1,'2012-06-08 00:21:08','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (39,'test',1,'2012-06-08 00:21:36','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (40,'test',1,'2012-06-08 00:21:41','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (41,'test',1,'2012-06-08 00:22:04','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (42,'test',1,'2012-06-08 01:07:23','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (43,'test',1,'2012-06-09 12:02:01','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (44,'test',1,'2012-06-10 23:37:22','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (45,'test',1,'2012-06-10 23:37:25','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (46,'test',1,'2012-06-10 23:37:28','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (47,'test',1,'2012-06-20 21:32:49','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (48,'test',1,'2012-06-26 22:49:02','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (49,'test',1,'2012-06-30 22:14:12','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (50,'test',1,'2012-07-09 21:23:20','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (51,'test',1,'2012-07-17 15:02:15','进入权限组配置页面');
INSERT INTO `app_system_log` VALUES (52,'test',1,'2012-07-18 13:13:21','进入权限组配置页面');
/*!40000 ALTER TABLE `app_system_log` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_user
#

DROP TABLE IF EXISTS `app_user`;
CREATE TABLE `app_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(128) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `fullname` varchar(64) DEFAULT NULL COMMENT '用户姓名',
  `email` varchar(128) DEFAULT NULL COMMENT '邮件',
  `dep_id` bigint(20) DEFAULT NULL COMMENT '所属部门',
  `pos_id` bigint(20) DEFAULT NULL COMMENT '职位',
  `district_id` bigint(20) DEFAULT NULL COMMENT '用户所在校区',
  `emp_id` bigint(20) DEFAULT NULL COMMENT '员工ID',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `address` varchar(64) DEFAULT NULL COMMENT '地址',
  `zip` varchar(32) DEFAULT NULL COMMENT '邮编',
  `photo` varchar(128) DEFAULT NULL COMMENT '相片',
  `status` smallint(6) NOT NULL COMMENT '状态            1=激活            0=冻结',
  `logon_lastip` varchar(64) DEFAULT NULL COMMENT '最后登录IP',
  `logon_lastime` datetime DEFAULT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`user_id`),
  KEY `FK_AU_R_DPT` (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表';

#
# Dumping data for table app_user
#

LOCK TABLES `app_user` WRITE;
/*!40000 ALTER TABLE `app_user` DISABLE KEYS */;
INSERT INTO `app_user` VALUES (1,'admin','jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=','唐伯虎','csx@jee-soft.cn',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'0:0:0:0:0:0:0:1','2012-07-18 16:02:33');
INSERT INTO `app_user` VALUES (2,'csx','9uCh4qxBlFqap/+KiqoM68EqO8yYGpKa1c+BCgkOEa4=','斩不刀','111@hotmail.com',1,NULL,3,NULL,'','','','','','',0,'',NULL);
INSERT INTO `app_user` VALUES (3,'0001012061241011','QGpDSgQ2on/ITC1MlNeed0CREM5MDxeCejn3iFEhLGk=','Manie',NULL,9,1,3,3,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL);
INSERT INTO `app_user` VALUES (4,'0001112061243222','DnOH9eQngdjBAPlv4OAAtxF1BJdvw3DiTFece8c7PD8=','Charotte',NULL,12,2,3,4,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL);
INSERT INTO `app_user` VALUES (5,'0001012061244839','1pB+T6eAui2DtQe83R0qWFGgwWGmY5HB2cuU4vgLHl4=','Chonticha',NULL,9,1,3,5,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL);
/*!40000 ALTER TABLE `app_user` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table app_user_role
#

DROP TABLE IF EXISTS `app_user_role`;
CREATE TABLE `app_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限表';

#
# Dumping data for table app_user_role
#

LOCK TABLES `app_user_role` WRITE;
/*!40000 ALTER TABLE `app_user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_user_role` ENABLE KEYS */;
UNLOCK TABLES;

#
#  Foreign keys for table app_admin_doc
#

ALTER TABLE `app_admin_doc`
ADD CONSTRAINT `PK_author` FOREIGN KEY (`author_id`) REFERENCES `app_user` (`user_id`),
ADD CONSTRAINT `PK_dcoType` FOREIGN KEY (`type_dicid`) REFERENCES `app_system_dictionary` (`id`),
ADD CONSTRAINT `PK_department` FOREIGN KEY (`doc_postDepId`) REFERENCES `app_school_department` (`dep_id`),
ADD CONSTRAINT `PK_district` FOREIGN KEY (`doc_postDistrictId`) REFERENCES `app_school_district` (`district_id`),
ADD CONSTRAINT `PK_level` FOREIGN KEY (`doc_level_id`) REFERENCES `app_admin_doc_level` (`id`),
ADD CONSTRAINT `PK_range` FOREIGN KEY (`doc_VisiableRange_id`) REFERENCES `app_admin_doc_visiable_range` (`id`);

#
#  Foreign keys for table app_admin_doc_file
#

ALTER TABLE `app_admin_doc_file`
ADD CONSTRAINT `PK_doc` FOREIGN KEY (`doc_id`) REFERENCES `app_admin_doc` (`doc_id`);

#
#  Foreign keys for table app_admin_workarrange
#

ALTER TABLE `app_admin_workarrange`
ADD CONSTRAINT `PK_type` FOREIGN KEY (`work_type`) REFERENCES `app_admin_worktype` (`id`),
ADD CONSTRAINT `PK_user` FOREIGN KEY (`staff_id`) REFERENCES `app_user` (`user_id`);

#
#  Foreign keys for table app_function_url
#

ALTER TABLE `app_function_url`
ADD CONSTRAINT `app_function_url_ibfk_1` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`);

#
#  Foreign keys for table app_hrm_resume_file
#

ALTER TABLE `app_hrm_resume_file`
ADD CONSTRAINT `app_hrm_resume_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`);

#
#  Foreign keys for table app_process_definition
#

ALTER TABLE `app_process_definition`
ADD CONSTRAINT `app_process_definition_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_process_type` (`type_id`);

#
#  Foreign keys for table app_role_func
#

ALTER TABLE `app_role_func`
ADD CONSTRAINT `app_role_func_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`),
ADD CONSTRAINT `app_role_func_ibfk_2` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`);


/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
