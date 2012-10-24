-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Sep 06, 2012, 12:28 PM
-- 伺服器版本: 5.0.91
-- PHP 版本: 5.2.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 資料庫: `app_sroa`
--

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_attendance`
--

CREATE TABLE IF NOT EXISTS `app_admin_attendance` (
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
  `attendance_result` char(1) default NULL COMMENT '考勤结果,1:按时,2:迟到,3:早退,4:迟到早退',
  `exception` char(1) default NULL COMMENT '数据是否异常,0:正常,1:异常',
  `dep_id` bigint(20) default NULL COMMENT '员工所在部门ID',
  `district_id` bigint(20) default NULL COMMENT '员工所在校区ID',
  PRIMARY KEY  (`attend_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-员工考勤' AUTO_INCREMENT=16 ;

--
-- 列出以下資料庫的數據： `app_admin_attendance`
--


-- --------------------------------------------------------

--
-- Stand-in structure for view `app_admin_attendance_view`
--
CREATE TABLE IF NOT EXISTS `app_admin_attendance_view` (
`origin` varchar(10)
,`attendance_view_id` bigint(20)
,`work_date` date
,`work_time` varchar(64)
,`offtime_shour` varchar(11)
,`offtime_ehour` varchar(11)
,`offtime_smin` varchar(11)
,`offtime_emin` varchar(11)
,`staff_id` bigint(20)
,`staff_name` varchar(64)
,`work_type` int(11)
,`work_status` varbinary(4)
,`leave_type` char(1)
,`staff_behalf_name` varchar(64)
,`staff_behalf_id` bigint(20)
,`meto` varchar(250)
,`attendance_result` varchar(1)
,`exception` varchar(1)
,`dep_id` bigint(20)
,`district_id` bigint(20)
);
-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_conference`
--

CREATE TABLE IF NOT EXISTS `app_admin_conference` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='会议表' AUTO_INCREMENT=11 ;

--
-- 列出以下資料庫的數據： `app_admin_conference`
--

INSERT INTO `app_admin_conference` (`conference_id`, `conference_name`, `conference_level`, `district_id`, `depart_id`, `address`, `start_day`, `start_hour`, `start_minute`, `end_day`, `end_hour`, `end_minute`, `attendances`, `count`, `contactor`, `phone`, `content`, `status`, `sponsor`, `summary`, `conference_type`, `attendances_ids`) VALUES
(10, '000', '公司级别会议', 1, 17, '杭州', '2012-09-06', '08', '00', '2012-09-07', '08', '00', '林菁菁,周碧英,蒋晓萍', 4, '林菁菁', '13968155954', '4255', '2', 21, '541112522', 10, '21,25,26');

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_doc`
--

CREATE TABLE IF NOT EXISTS `app_admin_doc` (
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
  KEY `PK_file` (`file_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-文档' AUTO_INCREMENT=10 ;

--
-- 列出以下資料庫的數據： `app_admin_doc`
--

INSERT INTO `app_admin_doc` (`doc_id`, `type_dicid`, `doc_name`, `doc_level_id`, `doc_VisiableRange_id`, `doc_userNames`, `doc_userIds`, `doc_postDistrictId`, `doc_postDepId`, `author_id`, `create_time`, `file_id`) VALUES
(9, 1, '系统问题模版', 1, -1, NULL, NULL, 1, 26, 36, '2012-09-05 13:51:04', 84);

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_doc_level`
--

CREATE TABLE IF NOT EXISTS `app_admin_doc_level` (
  `id` int(5) NOT NULL auto_increment COMMENT '编号',
  `level_name` varchar(100) default NULL COMMENT '文档级别名称',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='文档级别' AUTO_INCREMENT=5 ;

--
-- 列出以下資料庫的數據： `app_admin_doc_level`
--

INSERT INTO `app_admin_doc_level` (`id`, `level_name`) VALUES
(1, '公司级别'),
(2, '校区级别'),
(3, '校区部门级别'),
(4, '总部对口部门级别');

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_doc_visiable_range`
--

CREATE TABLE IF NOT EXISTS `app_admin_doc_visiable_range` (
  `id` int(5) NOT NULL auto_increment,
  `visiable_name` varchar(100) default NULL COMMENT '文档范围名称',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='文档范围' AUTO_INCREMENT=5 ;

--
-- 列出以下資料庫的數據： `app_admin_doc_visiable_range`
--

INSERT INTO `app_admin_doc_visiable_range` (`id`, `visiable_name`) VALUES
(1, '所有校区'),
(2, '设置个人可见'),
(3, '杭州总部'),
(4, '萧山校区');

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_news`
--

CREATE TABLE IF NOT EXISTS `app_admin_news` (
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
  `auditor` bigint(20) default NULL COMMENT '审批人',
  `audit_time` datetime default NULL COMMENT '审批时间',
  PRIMARY KEY  (`news_id`),
  KEY `type_id` (`type_dicid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻' AUTO_INCREMENT=13 ;

--
-- 列出以下資料庫的數據： `app_admin_news`
--

INSERT INTO `app_admin_news` (`news_id`, `type_dicid`, `news_subject`, `news_content`, `author_id`, `author_name`, `news_level`, `district_visible`, `district_post`, `dep_post`, `createtime`, `updateTime`, `top_index`, `status`, `auditor`, `audit_time`) VALUES
(11, 3, '系统测试', '<span style="font-size:32px;"><strong>请各位抓紧时间系统测试，不管有无问题，都将反馈意见发至13858056931@139.com</strong></span><br />', 39, '王五', 0, NULL, 1, 26, '2012-09-05 11:51:18', '2012-09-05 11:51:58', 0, 2, 36, '2012-09-05 13:44:22'),
(12, 4, '中秋节', '000.03154521‘】；；，000<br />', 27, '杨琪', 0, NULL, 1, 24, '2012-09-05 13:35:13', '2012-09-05 13:56:14', 0, 1, 36, '2012-09-05 13:44:08');

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_news_file`
--

CREATE TABLE IF NOT EXISTS `app_admin_news_file` (
  `news_id` bigint(20) NOT NULL COMMENT '新闻ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`news_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻文件关联表';

--
-- 列出以下資料庫的數據： `app_admin_news_file`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_task`
--

CREATE TABLE IF NOT EXISTS `app_admin_task` (
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
  `auditor` bigint(20) default NULL COMMENT '审批人',
  `audit_time` datetime default NULL COMMENT '审批时间',
  `create_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY  (`task_id`),
  KEY `approval_status` (`approval_status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托' AUTO_INCREMENT=32 ;

--
-- 列出以下資料庫的數據： `app_admin_task`
--

INSERT INTO `app_admin_task` (`task_id`, `type_dicid`, `task_name`, `task_originator`, `task_charger`, `task_charger_depid`, `task_charger_disid`, `task_planStartDate`, `task_planEndDate`, `task_actualFinishDate`, `task_desc`, `task_participant_ids`, `task_participant_names`, `task_status`, `approval_status`, `auditor`, `audit_time`, `create_time`) VALUES
(27, 7, '任务1', 19, 19, 15, 1, '2012-08-31', '2012-09-01', NULL, '', NULL, NULL, NULL, 2, 19, '2012-08-31 17:01:47', '2012-08-31 17:01:31'),
(28, 7, '任务2', 19, 19, 15, 1, '2012-09-03', '2012-09-05', NULL, '', NULL, NULL, NULL, 2, 19, '2012-08-31 17:02:29', '2012-08-31 17:02:17'),
(29, 7, '核对', 21, 21, 17, 1, '2012-09-05', '2012-09-19', NULL, '1234566', '26,25,23', '蒋晓萍,周碧英,王伟平', NULL, 2, 36, '2012-09-05 13:46:29', '2012-09-05 11:32:24'),
(30, 7, '9月市场计划', 24, 24, 16, 1, '2012-09-05', '2012-09-13', NULL, '嘎哈地方回家想蒋经国就啊哈的合同集团军儿童节', '38,29,24', 'leo,程聪,刘苗芳', NULL, 2, 36, '2012-09-05 13:46:35', '2012-09-05 11:46:39'),
(31, 7, '例会', 39, 39, 26, 1, '2012-09-05', '2012-09-06', '2012-09-14', '请各位抓紧时间系统测试，不管有无问题，都将反馈意见发至13858056931@139.com', '39,38,37,19,24,25,40,22,41,23,20,21,27,26,29,28,36,30', '王五,leo,林立,罗佳驹,刘苗芳,周碧英,张三,许玉凤,林锦贤,王伟平,梅杰,林菁菁,杨琪,蒋晓萍,程聪,何滨,ljx,苏斯翔', 3, 2, 36, '2012-09-05 13:44:51', '2012-09-05 11:49:02');

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_task_file`
--

CREATE TABLE IF NOT EXISTS `app_admin_task_file` (
  `task_id` bigint(20) NOT NULL COMMENT '任务ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`task_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托文件关联表';

--
-- 列出以下資料庫的數據： `app_admin_task_file`
--

INSERT INTO `app_admin_task_file` (`task_id`, `file_id`) VALUES
(29, 79),
(31, 80);

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_task_participants`
--

CREATE TABLE IF NOT EXISTS `app_admin_task_participants` (
  `task_id` bigint(20) NOT NULL,
  `emp_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`task_id`,`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务参与人';

--
-- 列出以下資料庫的數據： `app_admin_task_participants`
--

INSERT INTO `app_admin_task_participants` (`task_id`, `emp_id`) VALUES
(29, 23),
(29, 25),
(29, 26),
(30, 24),
(30, 29),
(30, 38),
(31, 19),
(31, 20),
(31, 21),
(31, 22),
(31, 23),
(31, 24),
(31, 25),
(31, 26),
(31, 27),
(31, 28),
(31, 29),
(31, 30),
(31, 36),
(31, 37),
(31, 38),
(31, 39),
(31, 40),
(31, 41);

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_task_tracks`
--

CREATE TABLE IF NOT EXISTS `app_admin_task_tracks` (
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
  `auditor` bigint(20) default NULL COMMENT '审批人',
  PRIMARY KEY  (`track_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='任务委托审批记录' AUTO_INCREMENT=25 ;

--
-- 列出以下資料庫的數據： `app_admin_task_tracks`
--

INSERT INTO `app_admin_task_tracks` (`track_id`, `task_id`, `task_applyTime`, `task_applyType`, `task_applyFinalTime`, `task_applyMeto`, `task_auditState`, `task_auditFinalTime`, `task_auditMeto`, `task_auditTime`, `auditor`) VALUES
(24, 31, '2012-09-05', 1, '2012-09-14', '', 1, '2012-09-14', '', '2012-09-05 14:57:04', 39);

-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_workarrange`
--

CREATE TABLE IF NOT EXISTS `app_admin_workarrange` (
  `work_id` bigint(20) NOT NULL auto_increment COMMENT '工作ID',
  `work_date` date NOT NULL COMMENT '工作日期',
  `work_time` bigint(20) NOT NULL COMMENT '工作时间',
  `staff_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `staff_id` bigint(20) NOT NULL COMMENT '员工ID',
  `work_type` int(5) default NULL COMMENT '上班类型',
  `work_content` bigint(20) default NULL COMMENT '工作内容',
  `district_id` bigint(20) default NULL COMMENT '员工所在校区',
  `attend_id` bigint(20) default NULL COMMENT '对应的考勤记录',
  `dep_id` bigint(20) default NULL,
  PRIMARY KEY  (`work_id`),
  KEY `PK_user` (`staff_id`),
  KEY `PK_type` (`work_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-工作安排' AUTO_INCREMENT=23 ;

--
-- 列出以下資料庫的數據： `app_admin_workarrange`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_admin_worktype`
--

CREATE TABLE IF NOT EXISTS `app_admin_worktype` (
  `id` int(5) NOT NULL auto_increment,
  `type` varchar(50) default NULL COMMENT '工作类型名称',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 列出以下資料庫的數據： `app_admin_worktype`
--

INSERT INTO `app_admin_worktype` (`id`, `type`) VALUES
(1, '正常上班'),
(2, '调休加班'),
(3, '带薪加班'),
(4, '倍薪加班');

-- --------------------------------------------------------

--
-- 資料表格式： `app_conference_file`
--

CREATE TABLE IF NOT EXISTS `app_conference_file` (
  `conference_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`conference_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会议文件';

--
-- 列出以下資料庫的數據： `app_conference_file`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_file_attach`
--

CREATE TABLE IF NOT EXISTS `app_file_attach` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='附件' AUTO_INCREMENT=86 ;

--
-- 列出以下資料庫的數據： `app_file_attach`
--

INSERT INTO `app_file_attach` (`file_id`, `file_name`, `file_path`, `createtime`, `file_ext`, `file_type`, `note`, `creator`, `creator_id`, `file_bytes`, `del_flag`) VALUES
(77, '员工档案_test.xls', 'others/201208/e6517a9379bd4f20894130281713d30b.xls', '2012-08-31 16:54:30', 'xls', 'others', '26.00 KB', 'Unknow', NULL, 26624, 0),
(78, '员工档案_test2.xls', 'others/201208/cf9a21e4c4de45119ed3663c8c3d2cc1.xls', '2012-08-31 16:55:23', 'xls', 'others', '20.00 KB', 'Unknow', NULL, 20480, 0),
(79, '2季度区业绩.docx', 'others/201209/c56bc0cbdfc640a7b5e49a9590b9aff2.docx', '2012-09-05 11:32:19', 'docx', 'others', '10.35 KB', 'Unknow', NULL, 10598, 0),
(80, '系统问题.doc', 'others/201209/337696036b7f45dc8fe9da91e5b3d8dd.doc', '2012-09-05 11:49:00', 'doc', 'others', '325.50 KB', 'Unknow', NULL, 333312, 0),
(81, '系统问题.doc', 'others/201209/d134688127c34fe18740aad54d195dc8.doc', '2012-09-05 11:52:24', 'doc', 'others', '325.50 KB', 'Unknow', NULL, 333312, 0),
(82, '系统问题.doc', 'others/201209/1b033b47f8384fc58227b50f80b1664e.doc', '2012-09-05 11:54:12', 'doc', 'others', '325.50 KB', 'Unknow', NULL, 333312, 0),
(83, '小班8月传单文字稿.doc', 'others/201209/13f50663c4c649af8b345de3a9877c67.doc', '2012-09-05 13:34:18', 'doc', 'others', '127.00 KB', 'Unknow', NULL, 130048, 0),
(84, '小班8月传单文字稿.doc', 'others/201209/02419d88be9741bcbffb9783512577c0.doc', '2012-09-05 13:51:02', 'doc', 'others', '127.00 KB', 'Unknow', NULL, 130048, 0),
(85, '2011中考科学押题卷及答案杭州.doc', 'others/201209/0348ac276bd741c9a271198238c82f8f.doc', '2012-09-05 16:45:16', 'doc', 'conference_process', '1.71 M', 'Unknow', NULL, 1793536, 0);

-- --------------------------------------------------------

--
-- 資料表格式： `app_finan_contract`
--

CREATE TABLE IF NOT EXISTS `app_finan_contract` (
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
  `cproc_depid` bigint(20) default NULL COMMENT '当前审批环节部门ID',
  `cproc_posid` bigint(20) default NULL COMMENT '当前审批岗位ID',
  PRIMARY KEY  (`contract_id`),
  KEY `apply_form_no` (`apply_form_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='合同申请' AUTO_INCREMENT=9 ;

--
-- 列出以下資料庫的數據： `app_finan_contract`
--

INSERT INTO `app_finan_contract` (`contract_id`, `apply_form_no`, `apply_form_type`, `emp_id`, `emp_district`, `emp_dep`, `emp_phone_no`, `apply_date`, `comments`, `apply_amt`, `contract_no`, `contract_parties`, `contract_parties_contact`, `pay_method`, `audit_state`, `entry_id`, `entry_datetime`, `cproc_depid`, `cproc_posid`) VALUES
(5, 'FC20120905113905', 8, 38, 1, 16, '123123123', '2012-09-05', '', 10000, '', 'ierw', '123345543656', '', NULL, 38, '2012-09-05 11:39:05', 15, 13),
(6, 'FC20120905134321', 8, 19, 1, 15, '13575747066', '2012-09-06', '', 1300, '', '01', '88313621', '', NULL, 27, '2012-09-05 13:43:21', 15, 13),
(7, 'FC20120905135324', 8, 19, 1, 15, '13575747066', '2012-09-13', '', 1300, '', '01', '88313621', '', NULL, 36, '2012-09-05 13:53:24', 15, 13),
(8, 'FC20120905145222', 8, 24, 1, 16, '0571-88071385', '2012-09-05', '', 12000, '', 'gjk', '1231451456', '', NULL, 24, '2012-09-05 14:52:22', 15, 13);

-- --------------------------------------------------------

--
-- 資料表格式： `app_finan_expense`
--

CREATE TABLE IF NOT EXISTS `app_finan_expense` (
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
  `cproc_depid` bigint(20) default NULL COMMENT '当前审批环节部门ID',
  `cproc_posid` bigint(20) default NULL COMMENT '当前审批岗位ID',
  PRIMARY KEY  (`expense_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- 列出以下資料庫的數據： `app_finan_expense`
--

INSERT INTO `app_finan_expense` (`expense_id`, `apply_form_no`, `apply_form_type`, `apply_date`, `comments`, `emp_id`, `emp_district`, `emp_dep`, `emp_phone_no`, `apply_amt`, `payer`, `contract_no`, `attach_count`, `audit_advance`, `asset_no`, `amt_receiver`, `amt_receiver_contact`, `pay_method`, `bank`, `account_name`, `account_no`, `status`, `audit_state`, `entry_id`, `entry_datetime`, `cproc_depid`, `cproc_posid`) VALUES
(12, 'FE20120905111834', 13, '2012-09-05', ' 车费', 25, 1, 17, '0571-88321763', 100, 1, '', '2', 0, '', '周碧英', '18357116886', 0, '', '', '', NULL, NULL, 25, '2012-09-05 11:18:34', 25, 38),
(13, 'FE20120905112134', 13, '2012-09-05', '餐费', 25, 1, 17, '0571-88321763', 202, 0, '', '', 0, '', '周碧英', '18357116886', 0, '', '', '', NULL, NULL, 25, '2012-09-05 11:21:34', 25, 38),
(14, 'FE20120905113722', 9, '2012-09-05', '餐费', 38, 1, 16, '123123123', 300, 1, '', '1', NULL, '', 'leo', '13543345543', 0, '', '', '', NULL, NULL, 38, '2012-09-05 11:37:22', 25, 38),
(15, 'FE20120905113831', 9, '2012-09-05', '教师节日礼品', 38, 1, 16, '123123123', 2000, 1, '', '', NULL, '', 'leo', '1354652534', 0, '', '', '', NULL, NULL, 38, '2012-09-05 11:38:31', 25, 38),
(16, 'FE20120905120032', 9, '2012-09-05', '', 39, 1, 26, '12345', 1000, 1, '', '', NULL, '', '王五', '13495045677', 0, '', '', '', NULL, NULL, 39, '2012-09-05 12:00:32', 25, 38),
(17, 'FE20120905134243', 9, '2012-09-07', '', 19, 1, 15, '13575747066', 1300, 1, '', '', 1, '', '01', '88313621', 1, '滨江', '01', '62222222222', NULL, NULL, 27, '2012-09-05 13:42:43', 25, 38),
(18, 'FE20120905135253', 7, '2012-09-07', '', 19, 1, 15, '13575747066', 1300, NULL, '', '', NULL, '', '01', '88313621', NULL, '滨江', '01', '333333333', NULL, NULL, 36, '2012-09-05 13:52:53', 18, 27),
(19, 'FE20120905145058', 9, '2012-09-05', '', 24, 1, 16, '0571-88071385', 3000, NULL, '', '', NULL, '', 'yj', '132195534965', 0, '', '', '', NULL, NULL, 24, '2012-09-05 14:50:58', 25, 38),
(20, 'FE20120905145138', 13, '2012-09-06', '', 24, 1, 16, '0571-88071385', 200, NULL, '', '', NULL, '', 'gae', '12353234533', 0, '', '', '', NULL, NULL, 24, '2012-09-05 14:51:38', 25, 38),
(21, 'FE20120905163103', 7, '2012-09-13', '费用申请实例', 29, 1, 16, '15068789653', 10000, 0, '', '1', 1, '', '程聪', '15068789653', 1, '杭州农业银行', '程聪', '6542354465478456212', NULL, NULL, 29, '2012-09-05 16:31:03', 18, 27);

-- --------------------------------------------------------

--
-- 資料表格式： `app_finan_project`
--

CREATE TABLE IF NOT EXISTS `app_finan_project` (
  `project_id` bigint(20) NOT NULL auto_increment,
  `apply_form_no` varchar(120) NOT NULL COMMENT '申请单号',
  `apply_form_type` bigint(20) NOT NULL COMMENT '合同申请类型',
  `emp_id` bigint(20) NOT NULL COMMENT '经办人 (申请人)',
  `emp_district` bigint(20) NOT NULL COMMENT '员工所属校区',
  `emp_dep` bigint(20) NOT NULL COMMENT '员工所属部门',
  `emp_phone_no` varchar(24) NOT NULL COMMENT '员工联系电话',
  `apply_date` date NOT NULL COMMENT '申请时间',
  `comments` text COMMENT '合同事项说明',
  `apply_amt` double NOT NULL COMMENT '合同总金额',
  `project_catalog` varchar(120) NOT NULL COMMENT '所属项目',
  `project_owner` bigint(20) NOT NULL COMMENT '项目负责人',
  `attach_count` varchar(120) default NULL COMMENT '附件张数',
  `supplier_name` varchar(120) default NULL COMMENT '供应商姓名',
  `supplier_contact` varchar(120) default NULL COMMENT '供应商联系方式',
  `pay_method` varchar(150) default NULL COMMENT '付款方式',
  `bank` varchar(50) default NULL COMMENT '开户银行',
  `account_name` varchar(50) default NULL COMMENT '账户名',
  `account_no` varchar(50) default NULL COMMENT '账号',
  `audit_state` tinyint(4) default NULL COMMENT '审核状态, 1=审核中, 2=审核通过 3=审核不通过, 4=审核被退回...',
  `entry_id` bigint(20) NOT NULL COMMENT '录入人员',
  `entry_datetime` datetime NOT NULL COMMENT '录入时间',
  `cproc_depid` bigint(20) default NULL COMMENT '当前审批环节部门ID',
  `cproc_posid` bigint(20) default NULL COMMENT '当前审批岗位ID',
  PRIMARY KEY  (`project_id`),
  KEY `apply_form_no` (`apply_form_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新项目支出申请' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_finan_project`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_function`
--

CREATE TABLE IF NOT EXISTS `app_function` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能表' AUTO_INCREMENT=169 ;

--
-- 列出以下資料庫的數據： `app_function`
--

INSERT INTO `app_function` (`func_id`, `func_key`, `func_name`, `func_icon`, `func_desc`, `menu_id`, `strategy_ids`) VALUES
(5, '_FUNCKEY_HRM_JOBHIRE_JOB_VIEW', '岗位管理-岗位查看', '', '查看岗位详细信息..', 48, NULL),
(6, '_FUNCKEY_HRM_JOBHIRE_JOB_POST', '岗位管理-岗位发布', '', '需先具备`岗位查看`的权限, 才能进行岗位发布操作.', 48, NULL),
(7, '_FUNCKEY_HRM_JOBHIRE_JOB_EDIT', '岗位管理-岗位编辑', '', '需先具备`岗位查看`的权限, 才能进行岗位编辑操作.', 48, NULL),
(8, '_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL', '岗位管理-应聘控制', '', '应聘控制包含, `应聘开启`和`应聘关闭`操作.', 48, NULL),
(9, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY', '入职安排-页面查看', '', '对通过面试的人员进行入职安排操作.', 48, NULL),
(10, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW', '入职安排-简历查看', '', '入职安排页面中查看应聘者简历信息.', 48, NULL),
(11, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW', '入职安排-面试查看', '', '入职安排页面中查看应聘者面试记录信息.', 48, NULL),
(12, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE', '入职安排-入职安排', '', '主要是对入职校区、部门、时间等信息的安排.', 48, NULL),
(13, '_FUNCKEY_JOBAPPROVAL_SUBNODE', '岗位管理-岗位审批(校区)', '', '对发布的岗位进行校区审批操作.', 48, NULL),
(14, '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER', '招聘安排-页面查看', '', '主要对应聘者进行面试安排等操作.', 48, NULL),
(15, '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW', '招聘安排-简历查看', '', '招聘安排页面中查看应聘者简历信息.', 48, NULL),
(16, '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW', '招聘安排-面试查看', '', '招聘安排页面中查看应聘者面试记录信息.', 48, NULL),
(17, '_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE', '招聘安排-员工录用', '', '面试过后, 进行员工录用状态转换操作.', 48, NULL),
(18, '_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE', '招聘安排-员工淘汰', '', '面试过后, 进行员工淘汰状态转换操作.', 48, NULL),
(19, '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE', '招聘安排-员工未到', '', '面试过后, 进行员工淘汰状态转换操作.', 48, NULL),
(20, '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE', '招聘安排-招聘安排', '', '应聘者面试安排操作', 48, NULL),
(21, '_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW', '查看简历信息', '', '查看人才简历信息', 49, NULL),
(22, '_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE', '删除简历信息', '', '删除人才库中的简历信息', 49, NULL),
(23, '_FUNCKEY_HRM_ENTRY_OP_ONBOARD', '入职处理', '', '对入职安排中的应聘者进行入职安排操作.', 50, NULL),
(24, '_FUNCKEY_HRM_ENTRY_OP_ABSENCE', '未到处理', '', '对入职安排中的应聘者进行未到安排操作.', 50, NULL),
(25, '_FUNCKEY_HRM_ENTRY_OP_QUALIFY', '考察处理', '', '对入职安排中的应聘者进行考察通过、考察未通过处理.', 50, NULL),
(26, '_FUNCKEY_HRM_EMPLOYEE_ADD', '员工数据添加', '', '添加单个新员工数据', 51, NULL),
(27, '_FUNCKEY_HRM_EMPLOYEE_REMOVE', '员工数据删除', '', '员工数据删除', 51, NULL),
(28, '_FUNCKEY_HRM_EMPLOYEE_VIEW', '员工数据查看', '', '员工数据信息查看, 包括简历信息以及晟睿旅程信息.', 51, NULL),
(29, '_FUNCKEY_HRM_EMPLOYEE_UPDATE', '员工数据更新', '', '员工数据更新, 包括员工简历信息更新以及员工晟睿旅程信息的更新.', 51, NULL),
(30, '_FUNCKEY_HRM_DEVELOP_FINALIZE', '审批状态操作', '', '主要是针对员工, 转正、晋升、离职、调动等状态转换操作.', 47, NULL),
(31, '_FUNCKEY_HRM_DEVELOP_VIEWDATA', '审批数据加载', '', '加载"审批中"与"已审批"Tab的人力发展数据.', 47, NULL),
(32, '_FUNCKEY_FINAN_EXPENSE_APPLY', '费用支出申请', '', '填写费用支出申请单并提交审核.', 7, NULL),
(33, '_FUNCKEY_FINAN_EXPENSE_VIEW', '费用支出查看', '', '查看提交的费用支出申请单数据.', 7, NULL),
(34, '_FUNCKEY_FINAN_EXPENSE_APPROVE', '费用支出审核', '', '审核提交上来的费用支出', 7, NULL),
(35, '_FUNCKEY_FINAN_CONTRACT_APPLY', '合同申请提交', '', '填写合同申请单并提交审核', 30, NULL),
(36, '_FUNCKEY_FINAN_CONTRACT_VIEW', '合同申请查看', '', '查看合同申请单数据', 30, NULL),
(37, '_FUNCKEY_FINAN_CONTRACT_APPROVE', '合同申请审核', '', '审核提交上来的费用支出', 30, NULL),
(38, '_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW', '审批记录查看', '', '查看费用审批记录数据.', 28, NULL),
(39, '_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW', '审批记录查看', '', '查看费用审批记录数据.', 31, NULL),
(40, '_FUNCKEY_SYSTEM_MENU_ADD', '菜单项添加', '', '添加新的菜单项...', 16, NULL),
(41, '_FUNCKEY_SYSTEM_MENU_EDIT', '菜单项编辑', '', '编辑菜单项', 16, NULL),
(42, '_FUNCKEY_SYSTEM_MENU_REFRESH', '菜单项刷新', '', '刷新左侧菜单项树状结构.', 16, NULL),
(43, '_FUNCKEY_SYSTEM_MENU_FUNC_ADD', '功能项添加', '', '添加菜单对应的功能项.', 16, NULL),
(44, '_FUNCKEY_SYSTEM_MENU_FUNC_EDIT', '功能项编辑', '', '编辑菜单对应的功能项.', 16, NULL),
(45, '_FUNCKEY_SYSTEM_MENU_FUNC_REFRESH', '功能项刷新', '', '刷新选中菜单拥有的功能项.', 16, NULL),
(46, '_FUNCKEY_SYSTEM_MENU_FUNC_REMOVE', '功能项删除', '', '删除菜单某功能项', 16, NULL),
(47, '_FUNCKEY_SYSTEM_ROLE_VIEW', '权限组查看', '', '查看权限组详细信息', 15, NULL),
(48, '_FUNCKEY_SYSTEM_ROLE_ADD', '权限组添加', '', '添加新的权限组', 15, NULL),
(49, '_FUNCKEY_SYSTEM_ROLE_EDIT', '权限组编辑', '', '编辑权限组信息.', 15, NULL),
(50, '_FUNCKEY_SYSTEM_ROLE_REMOVE', '权限组删除', '', '删除权限组', 15, NULL),
(51, '_FUNCKEY_FLOW_HRM_TYPE_REFRESH', '审批类型刷新', '', '刷新左侧人资审批类型树状结构', 20, NULL),
(52, '_FUNCKEY_FLOW_HRM_PROCESS_REFRESH', '审批流程刷新', '', '根据审批类型刷新审批流程数据', 20, NULL),
(53, '_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE', '审批流程配置', '', '人资审批流程配置, 包括流程数据加载、节点添加及删除等操作.', 20, NULL),
(54, '_FUNCKEY_FLOW_HRM_PROCESS_REMOVE', '审批流程删除', '', '审批流程删除.. (链接待完善...)', 20, NULL),
(55, '_FUNCKEY_FLOW_FINAN_TYPE_REFRESH', '审批类型刷新', '', '财务审批类型刷新,主要体现在左侧的树状结构.', 21, NULL),
(56, '_FUNCKEY_FLOW_FINAN_PROC_TYPE_REFRESH', '申请类别刷新', '', '根据审批类型获取申请类别数据.', 21, NULL),
(57, '_FUNCKEY_FLOW_FINAN_PROC_TYPE_ADD', '申请类别添加', '', '添加申请类别', 21, NULL),
(58, '_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT', '申请类别编辑', '', '编辑申请类别.', 21, NULL),
(59, '_FUNCKEY_FLOW_FINAN_PROC_APPROVE', '审批流程配置', '', '对审批申请类型进行流程配置.', 21, NULL),
(60, '_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_ADD', '校区添加', '', '添加新校区.', 22, NULL),
(61, '_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_EDIT', '校区编辑', '', '校区数据编辑.', 22, NULL),
(62, '_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_REMOVE', '校区删除', '', '校区数据删除.', 22, NULL),
(63, '_FUNCKEY_SYSTEM_SCHOOL_POSET_ADD', '职位添加', '', '添加新职位信息.', 24, NULL),
(64, '_FUNCKEY_SYSTEM_SCHOOL_POSET_REMOVE', '职位删除', '', '删除职位信息.', 24, NULL),
(65, '_FUNCKEY_SYSTEM_SCHOOL_POSET_EDIT', '职位编辑', '', '编辑职位信息', 24, NULL),
(66, '_FUNCKEY_SYSTEM_SCHOOL_DEP_ADD', '部门添加', '', '新增部门数据', 23, NULL),
(67, '_FUNCKEY_SYSTEM_SCHOOL_DEP_REFRESH', '部门刷新', '', '刷新左侧部门树状结构', 23, NULL),
(68, '_FUNCKEY_SYSTEM_SCHOOL_DEP_REMOVE', '部门删除', '', '删除部门数据.', 23, NULL),
(69, '_FUNCKEY_SYSTEM_SCHOOL_DEP_EDIT', '部门编辑', '', '编辑部门数据.', 23, NULL),
(70, '_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REFRESH', '岗位刷新', '', '根据选择的部门刷新对应的岗位数据.', 23, NULL),
(71, '_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REMOVE', '岗位删除', '', '删除岗位数据', 23, NULL),
(72, '_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_ADD', '岗位添加', '', '添加岗位信息.', 23, NULL),
(73, '_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY', '我的历史应聘', '', '访问我的历史应聘数据', 35, NULL),
(74, '_FUNCKEY_PERSONAL_INTERVIEW_HISTORY', '我的历史面试', '', '访问我的历史面试数据', 36, NULL),
(75, '_FUNCKEY_PERSONAL_INTERVIEW_COMMIT', '提交面试意见', '', '提交面试意见.', 36, NULL),
(76, '_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW', '查看岗位信息', '', '查看岗位详细信息.', 36, NULL),
(77, '_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW', '查看简历信息', '', '查看简历详细信息.', 36, NULL),
(78, '_FUNCKEY_PERSONAL_TASK_VIEW', '任务详情查看', '', '查看任务详细信息.', 4, NULL),
(79, '_FUNCKEY_PERSONAL_TASK_MYVIEW', '查看我发起的任务', '', '查看我发起的任务', 4, '5,4,2,1'),
(80, '_FUNCKEY_PERSONAL_TASK_ADD', '任务新建', '', '新建任务', 4, NULL),
(81, '_FUNCKEY_PERSONAL_TASK_EDIT', '任务编辑', '', '编辑发起的任务.', 4, NULL),
(82, '_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW', '任务审批记录查看', '', '查看任务审批记录详情.', 4, NULL),
(83, '_FUNCKEY_PERSONAL_TASK_POSTPONE', '任务延期申请', '', '提交任务延期申请单', 4, NULL),
(84, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH', '任务完成申请', '', '提交任务完成申请单.', 4, NULL),
(85, '_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE', '任务延期审批', '', '审批任务延期申请单.', 4, NULL),
(86, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE', '任务完成审批', '', '审批提交的任务完成申请单.', 4, NULL),
(87, '_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW', '查看面试记录', '', '查看面试记录.', 36, NULL),
(88, '_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW', '查看岗位信息', '', '查看发布的岗位信息', 35, NULL),
(89, '_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW', '查看简历信息', '', '查看推荐或应聘的简历信息', 35, NULL),
(90, '_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY', '岗位应聘', '', '个人提交岗位应聘信息.', 35, NULL),
(91, '_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND', '岗位推荐', '', '推荐他人应聘岗位', 35, NULL),
(92, '_FUNCKEY_ADMIN_TASK_VIEW', '任务信息查看', '', '查看任务信息', 40, NULL),
(93, '_FUNCKEY_ADMIN_TASK_EDIT', '任务信息编辑', '', '编辑任务信息', 40, NULL),
(94, '_FUNCKEY_ADMIN_TASK_REMOVE', '任务信息删除', '', '删除任务信息', 40, NULL),
(95, '_FUNCKEY_ADMIN_TASK_APPROVE', '任务信息审批', '', '审批提交的任务信息', 40, NULL),
(96, '_FUNCKEY_HRM_DEVELOP_APPROVE', '流程审批', '', '审批人资申请流程节点数据, 必须先具备有''审批详细查看''功能后才能进入页面进行审批操作.', 47, NULL),
(97, '_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS', '审批详细查看', '', '查看审批详细记录数据', 47, NULL),
(98, '_FUNCKEY_PERSONAL_APPLICATION_VIEW', '申请单查看', '', '查看申请单详细数据.', 37, NULL),
(99, '_FUNCKEY_PERSONAL_APPLICATION_POST', '申请单提交', '', '填写申请单数据并提交审核.', 37, NULL),
(100, '_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_EDIT', '岗位编辑', '', '编辑部门岗位', 23, NULL),
(101, '_FUNCKEY_FLOW_FINAN_PROC_TYPE_REMOVE', '申请类别删除', '', '删除申请类别数据. (功能链接待添加...)', 21, NULL),
(102, '_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE', '查看我发起的所有会议', '', '查看我发起的会议', 32, '5,4,2,1'),
(103, '_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE', '发起新的会议', '', '发起新的会议', 32, NULL),
(104, '_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE', '取消会议', '', '取消已经发起的会议', 32, NULL),
(105, '_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE', '调整会议', '', '调整会议内容', 32, NULL),
(106, '_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE', '查看会议内容', '', '查看会议内容信息', 32, NULL),
(107, '_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE', '激活会议', '', '重新激活已经取消的会议', 32, NULL),
(108, '_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE', '提交会议总结', '', '会议结束后进行的会议总结，包括上传会议记录', 32, NULL),
(109, '_FUNCKEY_ADMIN_ADD_WORK_ARRANGE', '添加工作安排', '', '添加工作安排', 43, NULL),
(110, '_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE', '编辑工作安排', '', '编辑工作安排', 43, NULL),
(111, '_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE', '删除工作安排', '', '删除工作安排', 43, NULL),
(112, '_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE', '从模板导入工作安排', '', '从模板导入工作安排', 43, NULL),
(113, '_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE', '调整工作安排', '', '调整工作安排', 43, NULL),
(114, '_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE', '查看工作安排', '', '按周查看工作安排情况', 43, NULL),
(115, '_FUNCKEY_SYSTEM_ADD_DICTIONARY', '添加数据字典', '', '添加数据字典', 11, NULL),
(116, '_FUNCKEY_SYSTEM_EDIT_DICTIONARY', '编辑数据字典', '', '编辑数据字典', 11, NULL),
(117, '_FUNCKEY_SYSTEM_DELETE_DICTIONARY', '删除数据字典', '', '删除数据字典', 11, NULL),
(119, '_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT', '编辑工作内容', '', '编辑工作内容', 19, NULL),
(120, '_FUNCKEY_SYSTEM_ADD_WORK_CONTENT', '添加工作内容', '', '添加工作内容', 19, NULL),
(121, '_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT', '删除工作内容', '', '删除工作内容', 19, NULL),
(122, '_FUNCKEY_SYSTEM_ADD_WORK_TIME', '添加工作时间', '', '添加工作时间', 19, NULL),
(123, '_FUNCKEY_SYSTEM_DELETE_WORK_TIME', '删除工作时间', '', '删除工作时间', 19, NULL),
(124, '_FUNCKEY_SYSTEM_EDIT_WORK_TIME', '编辑工作时间', '', '编辑工作时间', 19, NULL),
(125, '_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD', '安排模板里的工作', '', '给每套模板安排工作', 18, NULL),
(126, '_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE', '启动模板', '', '启动模板', 18, NULL),
(127, '_FUNCKEY_ADMIN_NEWS_ADD', '发布新闻', '', '发布新闻', 39, NULL),
(128, '_FUNCKEY_ADMIN_NEWS_EDIT', '编辑新闻', '', '修改新闻', 39, NULL),
(129, '_FUNCKEY_ADMIN_NEWS_DELETE', '删除新闻', '', '删除新闻', 39, NULL),
(130, '_FUNCKEY_ADMIN_NEWS_APPROVE', '新闻管理与审批', '', '审批新闻', 39, NULL),
(131, '_FUNCKEY_ADMIN_NEWS_TOP', '新闻置顶', '', '新闻置顶', 39, NULL),
(132, '_FUNCKEY_ADMIN_NEWS_APPROVING', '新闻审批', '', '', 39, NULL),
(133, '_FUNCKEY_ADMIN_DOC_ADD', '上传文档', '', '上传文档', 42, NULL),
(134, '_FUNCKEY_ADMIN_DOC_REMOVE', '删除文档', '', '删除文档', 42, NULL),
(135, '_FUNCKEY_ADMIN_DOC_EDIT', '编辑文档', '', '编辑文档', 42, NULL),
(136, '_FUNCKEY_ADMIN_ACCOUNT_LOCK', '冻结账号', '', '', 26, NULL),
(137, '_FUNCKEY_ADMIN_ACCOUNT_ACTIVE', '激活账号', '', '', 26, NULL),
(138, '_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET', '重置密码', '', '', 26, NULL),
(139, '_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW', '岗位管理-岗位列表', '', '查看岗位列表..', 48, '5,4,2,1'),
(140, '_FUNCKEY_PERSONAL_TASK_DATA_LOAD', '我的任务数据加载', '', '数据加载', 4, '5,4,2,1'),
(141, '_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD', '我的会议数据加载', '', '', 32, '5,4,2,1'),
(142, '_FUNCKEY_PERSONAL_TASK_MYVIEW_DATA_LOAD', '我发起的任务数据加载', '', '我发起的任务数据加载', 4, '5,4,2,1'),
(143, '_FUNCKEY_PERSONAL_NEWS_DATA_LOAD', '新闻数据加载', '', '新闻数据加载', 33, NULL),
(144, '_FUNCKEY_PERSONAL_DOCS_DATA_LOAD', '文档数据加载', '', '文档数据加载', 34, NULL),
(145, '_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD', '岗位数据加载', '', '', 35, '5,4,2,1'),
(146, '_FUNCKEY_PERSONAL_APPROVAL_DATA_LOAD', '待我审批数据加载', '', '待我审批数据加载', 38, NULL),
(147, '_FUNCKEY_ADMIN_NEWS_DATA_LOAD', '新闻数据加载', '', '', 39, '5,4,2,1'),
(148, '_FUNCKEY_ADMIN_TASK_DATA_LOAD', '任务数据加载', '', '', 40, '5,4,3,2,1'),
(149, '_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD', '工作安排数据加载', '', '', 43, '5,4,2,1'),
(150, '_FUNCKEY_ADMIN_ATTENDANCE_DATA_LOAD', '员工考勤数据加载', '', '', 44, '5,4,2,1'),
(151, '_FUNCKEY_ADMIN_DOC_DATA_LOAD', '文档数据加载', '', '', 42, '5,4,2,1'),
(152, '_FUNCKEY_HRM_ENTRY_DATA_LOAD', '招聘入职数据加载', '', '', 50, '5,4,2,1'),
(153, '_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD', '员工数据加载', '', '', 51, '5,4,2,1'),
(154, '_FUNCKEY_FINAN_EXPENSE_DATA_LOAD', '费用支出数据加载', '', '', 7, '5,4,2,1'),
(155, '_FUNCKEY_FINAN_CONTRACT_DATA_LOAD', '合同审批数据加载', '', '', 30, '5,4,2,1'),
(156, '_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD', '新闻审批数据加载', '', '', 39, '5,4,2,1'),
(159, '_FUNCKEY_ADMIN_ACCOUNT_DATA_LOAD', '用户数据加载', '', '', 26, '5,4,2,1'),
(160, '_FUNCKEY_PERSONAL_APPLICATION_DATA_LOAD', '申请数据加载', '', '', 37, '5,4,2,1'),
(161, '_FUNCKEY_ADMIN_PASSWORD_CHANGE', '密码修改页面查看', '', '', 25, NULL),
(162, '_FUNCKEY_ADMIN_SYSLOG_VIEW', '系统日志页面查看', '', '', 27, NULL),
(163, '_FUNCKEY_JOBAPPROVAL_ROOT', '岗位管理-岗位审批(总部)', '', '对发布的岗位进行总部审批操作', 48, NULL),
(164, '_FUNCKEY_FINAN_PROJECT_APPROVE', '新项目支出审核', '', '审核提交上来的新项目支出申请', 53, NULL),
(165, '_FUNCKEY_FINAN_PROJECT_DATA_LOAD', '新项目支出数据加载', '', '新项目支出申请数据的异步刷新.', 53, NULL),
(166, '_FUNCKEY_FINAN_PROJECT_VIEW', '新项目支出申请查看', '', '查看提交的新项目支出申请单数据.', 53, NULL),
(167, '_FUNCKEY_FINAN_PROJECT_APPLY', '新项目支出申请', '', '填写新项目支出申请单并提交审核', 53, NULL),
(168, '_FUNCKEY_FINAN_PROJECT_RECORD_VIEW', '新项目审批记录查看', '', '查看费用新项目审批记录数据.', 54, NULL);

-- --------------------------------------------------------

--
-- 資料表格式： `app_function_strategy`
--

CREATE TABLE IF NOT EXISTS `app_function_strategy` (
  `stg_id` bigint(20) NOT NULL auto_increment COMMENT '功能数据权限id',
  `func_id` bigint(20) default NULL COMMENT '功能id',
  `stg_type` tinyint(4) NOT NULL COMMENT '数据策略类型',
  PRIMARY KEY  (`stg_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能数据权限' AUTO_INCREMENT=156 ;

--
-- 列出以下資料庫的數據： `app_function_strategy`
--

INSERT INTO `app_function_strategy` (`stg_id`, `func_id`, `stg_type`) VALUES
(19, NULL, 5),
(20, NULL, 1),
(21, NULL, 4),
(22, NULL, 2),
(23, 140, 1),
(24, 140, 5),
(25, 140, 2),
(26, 140, 4),
(27, NULL, 1),
(28, NULL, 2),
(29, NULL, 4),
(30, NULL, 5),
(31, NULL, 5),
(32, NULL, 1),
(33, NULL, 4),
(34, NULL, 2),
(35, 142, 4),
(36, 142, 1),
(37, 142, 2),
(38, 142, 5),
(39, NULL, 2),
(40, NULL, 5),
(41, NULL, 1),
(42, NULL, 4),
(43, NULL, 2),
(44, NULL, 1),
(45, NULL, 4),
(46, NULL, 5),
(47, 145, 5),
(48, 145, 2),
(49, 145, 1),
(50, 145, 4),
(51, NULL, 4),
(52, NULL, 5),
(53, NULL, 2),
(54, NULL, 1),
(55, 79, 2),
(56, 79, 4),
(57, 79, 1),
(58, 79, 5),
(59, NULL, 5),
(60, NULL, 1),
(61, NULL, 2),
(62, NULL, 4),
(63, 141, 2),
(64, 141, 4),
(65, 141, 1),
(66, 141, 5),
(67, 102, 4),
(68, 102, 1),
(69, 102, 2),
(70, 102, 5),
(71, 149, 2),
(72, 149, 5),
(73, 149, 1),
(74, 149, 4),
(75, 150, 4),
(76, 150, 2),
(77, 150, 1),
(78, 150, 5),
(79, 151, 4),
(80, 151, 2),
(81, 151, 1),
(82, 151, 5),
(83, 139, 1),
(84, 139, 5),
(85, 139, 4),
(86, 139, 2),
(87, 152, 2),
(88, 152, 1),
(89, 152, 4),
(90, 152, 5),
(91, NULL, 2),
(92, NULL, 4),
(93, NULL, 5),
(94, NULL, 1),
(95, 153, 1),
(96, 153, 4),
(97, 153, 5),
(98, 153, 2),
(99, 154, 4),
(100, 154, 5),
(101, 154, 1),
(102, 154, 2),
(103, NULL, 5),
(104, NULL, 4),
(105, NULL, 1),
(106, NULL, 2),
(107, 156, 1),
(108, 156, 4),
(109, 156, 2),
(110, 156, 5),
(111, NULL, 4),
(112, NULL, 1),
(113, NULL, 2),
(114, NULL, 5),
(115, NULL, 5),
(116, NULL, 2),
(117, NULL, 4),
(118, NULL, 1),
(119, NULL, 1),
(120, NULL, 2),
(121, NULL, 5),
(122, NULL, 4),
(123, NULL, 4),
(124, NULL, 1),
(125, NULL, 5),
(126, NULL, 2),
(127, 159, 5),
(128, 159, 1),
(129, 159, 2),
(130, 159, 4),
(131, NULL, 2),
(132, NULL, 4),
(133, NULL, 1),
(134, NULL, 5),
(135, NULL, 1),
(136, NULL, 2),
(137, NULL, 5),
(138, NULL, 4),
(139, 148, 1),
(140, 148, 4),
(141, 148, 5),
(142, 148, 3),
(143, 148, 2),
(144, 160, 1),
(145, 160, 5),
(146, 160, 2),
(147, 160, 4),
(148, 155, 5),
(149, 155, 4),
(150, 155, 2),
(151, 155, 1),
(152, 147, 1),
(153, 147, 5),
(154, 147, 2),
(155, 147, 4);

-- --------------------------------------------------------

--
-- 資料表格式： `app_function_url`
--

CREATE TABLE IF NOT EXISTS `app_function_url` (
  `url_id` int(11) NOT NULL auto_increment,
  `func_id` int(11) default NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY  (`url_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能URL' AUTO_INCREMENT=373 ;

--
-- 列出以下資料庫的數據： `app_function_url`
--

INSERT INTO `app_function_url` (`url_id`, `func_id`, `url_path`) VALUES
(21, 5, 'app/hrm/hire.do?action=hrmPageJobDetail'),
(24, 8, 'app/hrm/hire.do?action=actionJobOpenControl'),
(25, 10, 'app/hrm/hire.do?action=hrmPageJobResume'),
(26, 11, 'app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex'),
(28, 9, 'app/hrm/hire.do?action=hrmPageJobEntryIndex'),
(30, 12, 'app/hrm/hire.do?action=actionJobEntrySave'),
(31, 12, 'app/hrm/hire.do?action=hrmPageJobEntryDetail'),
(33, 6, 'app/hrm/hire.do?action=actionJobSave'),
(34, 6, 'app/hrm/hire.do?action=hrmPageJobDetail'),
(35, 7, 'app/hrm/hire.do?action=hrmPageJobDetail'),
(36, 7, 'app/hrm/hire.do?action=actionJobSave'),
(38, 14, 'app/hrm/hire.do?action=hrmPageJobOfferIndex'),
(39, 15, 'app/hrm/hire.do?action=hrmPageJobResume'),
(40, 16, 'app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex'),
(47, 19, 'app/hrm/hire.do?action=actionJobIssueFinalize'),
(48, 19, 'app/hrm/hire.do?action=dialogJobOfferFinalizePage'),
(49, 17, 'app/hrm/hire.do?action=dialogJobOfferFinalizePage'),
(50, 17, 'app/hrm/hire.do?action=actionJobIssueFinalize'),
(51, 18, 'app/hrm/hire.do?action=actionJobIssueFinalize'),
(52, 18, 'app/hrm/hire.do?action=dialogJobOfferFinalizePage'),
(54, 20, 'app/hrm/hire.do?action=hrmPageJobOfferInterviewPlan'),
(55, 20, 'app/hrm/hire/interview.do?action=actionJobInterviewPlanSave'),
(57, 21, 'app/hrm/hire.do?action=hrmPageJobResume'),
(59, 22, 'app/hrm/archive.do?action=actionResumeRemove'),
(64, 25, 'app/hrm/entry.do?action=dialogEntryFinalize'),
(65, 25, 'app/hrm/entry.do?action=actionEntrySave'),
(66, 24, 'app/hrm/entry.do?action=actionEntrySave'),
(67, 24, 'app/hrm/entry.do?action=dialogEntryFinalize'),
(68, 23, 'app/hrm/entry.do?action=dialogEntryBoardPage'),
(69, 23, 'app/hrm/entry.do?action=actionEntrySave'),
(77, 26, 'app/hrm/employee/data.do?action=dialogHrmEmployeeAdd'),
(78, 26, 'app/hrm/employee/data.do?action=actionEmployeeAdd'),
(79, 27, 'app/hrm/employee.do?action=actionEmployeeDelete'),
(80, 28, 'app/hrm/employee.do?action=hrmEmployeeDocDetail'),
(81, 28, 'app/hrm/hire.do?action=hrmPageJobResume'),
(82, 28, 'app/hrm/employee.do?action=hrmEmployeeDocRoadMap'),
(83, 29, 'app/hrm/employee.do?action=actionRoadMapSave'),
(84, 29, 'app/hrm/hire/resume.do?action=actionEmployeeResumeSave'),
(87, 30, 'app/hrm/develop.do?action=actionDevelopFinalize'),
(89, 33, 'app/finan/expense.do?action=diaglogFinaExpensePage&id=1&op=view'),
(90, 34, 'app/finan/expense.do?action=actionFinanApplicationApprove'),
(92, 32, 'app/finan/expense.do?action=actionFinanExpenseFormSave'),
(93, 32, 'app/finan/expense.do?action=diaglogFinaExpensePage'),
(98, 36, 'app/finan/contract.do?action=diaglogFinaContractPage'),
(99, 35, 'app/finan/contract.do?action=diaglogFinaContractPage'),
(100, 35, 'app/finan/contract.do?action=actionFinanContractFormSave'),
(101, 37, 'app/finan/contract.do?action=actionFinanApplicationApprove'),
(103, 38, 'app/finan/expense.do?action=diaglogFinaExpensePage'),
(104, 38, 'app/finan/expense.do?action=loadFinaExpenseRecords'),
(105, 39, 'app/finan/contract.do?action=diaglogFinaContractPage'),
(106, 39, 'app/finan/contract.do?action=loadFinaContractRecords'),
(107, 40, 'app/system/menu/item.do?action=actionSaveMenuItem'),
(108, 40, 'app/system/menu/item.do?action=dialogMenuItemPage'),
(109, 41, 'app/system/menu/item.do?action=dialogMenuItemPage'),
(110, 41, 'app/system/menu/item.do?action=actionSaveMenuItem'),
(111, 42, 'app/system/menu/item.do?action=actionLoadMenuItemTree'),
(112, 43, 'app/system/menu/func.do?action=dialogMenuFuncPage'),
(113, 43, 'app/system/menu/func.do?action=actionSaveMenuFunc'),
(114, 44, 'app/system/menu/func.do?action=dialogMenuFuncPage'),
(115, 44, 'app/system/menu/func.do?action=actionSaveMenuFunc'),
(116, 45, 'app/system/menu/func.do?action=actionLoadMenuFuncList'),
(117, 46, 'app/system/menu/func.do?action=actionRemoveMenuFunc'),
(118, 47, 'app/system/role.do?action=dialogRolePage'),
(119, 47, 'app/system/role.do?action=actionLoadAppFuncs'),
(120, 48, 'app/system/role.do?action=dialogRolePage'),
(121, 48, 'app/system/role.do?action=actionSaveRole'),
(122, 49, 'app/system/role.do?action=actionSaveRole'),
(123, 49, 'app/system/role.do?action=dialogRolePage'),
(124, 50, 'app/system/role.do?action=actionRemoveRole'),
(126, 52, 'app/flow/hrm.do?action=actionLoadProcessPosets'),
(127, 51, 'app/flow/hrm.do?action=actionLoadProcessRootType'),
(132, 53, 'app/flow/hrm.do?action=dialogFlowTaskConfigurationPage'),
(133, 53, 'app/flow/hrm.do?action=actionRemoveProcessTask'),
(134, 53, 'app/flow/hrm.do?action=actionSaveProcessTask'),
(135, 53, 'app/flow/hrm.do?action=pageFlowPosetConfigure'),
(136, 53, 'app/flow/hrm.do?action=actionLoadProcessTypes'),
(137, 53, 'app/flow.do?action=actionLoadProcessRootType'),
(139, 55, 'app/flow.do?action=actionLoadProcessRootType'),
(140, 56, 'app/flow/finance.do?action=actionLoadProcessTypes'),
(141, 57, 'app/flow.do?action=dialogFlowTypePage'),
(142, 57, 'app/flow.do?action=actionSaveProcessType'),
(144, 58, 'app/flow/finance.do?action=dialogFlowTypePage'),
(145, 58, 'app/flow.do?action=actionSaveProcessType'),
(151, 59, 'app/flow/finance.do?action=dialogFlowDefConditionPage'),
(152, 59, 'app/flow/finance.do?action=actionRemoveProcessTask'),
(153, 59, 'app/flow/finance.do?action=dialogFlowTaskConfigurationPage'),
(154, 59, 'app/flow/finance.do?action=pageFlowConfigure'),
(155, 59, 'app/flow/finance.do?action=actionLoadProcessTasks'),
(156, 59, 'app/flow/finance.do?action=actionSaveProcessTask'),
(157, 60, 'app/system/school/district.do?action=dialogSchoolDistrictPage'),
(158, 60, 'app/system/school/district.do?action=actionSaveDistrict'),
(159, 61, 'app/system/school/district.do?action=dialogSchoolDistrictPage'),
(160, 61, 'app/system/school/district.do?action=actionSaveDistrict'),
(161, 62, 'app/system/school/district.do?action=actionRemoveDistrict'),
(162, 63, 'app/system/school/poset.do?action=actionSavePoset'),
(163, 63, 'app/system/school/poset.do?action=dialogSchoolPosetPage'),
(164, 64, 'app/system/school/poset.do?action=actionRemovePoset'),
(165, 65, 'app/system/school/poset.do?action=dialogSchoolPosetPage'),
(166, 65, 'app/system/school/poset.do?action=actionSavePoset'),
(167, 66, 'app/system/school/department.do?action=dialogSchoolDepartmentPage'),
(168, 66, 'app/system/school/department.do?action=actionSaveDepartment'),
(169, 67, 'app/system/school/department.do?action=actionLoadDepartmentTree'),
(170, 68, 'app/system/school/department.do?action=actionRemoveDepartment'),
(171, 69, 'app/system/school/department.do?action=dialogSchoolDepartmentPage'),
(172, 70, 'app/system/school/department/position.do?action=actionLoadDepartmentPosition'),
(173, 71, 'app/system/school/department/position.do?action=actionRemoveDepartmentPosition'),
(174, 72, 'app/system/school/department/position.do?action=actionSaveDepartmentPosition'),
(175, 72, 'app/system/school/department/position.do?action=dialogSchoolDepartmentPositionPage'),
(178, 73, 'app/hrm/hire.do?action=hrmPageJobResume'),
(179, 73, 'app/personal/jobapplication.do?action=pageMyHistoryJobApplication'),
(180, 73, 'app/hrm/hire.do?action=hrmPageJobDetail'),
(186, 76, 'app/hrm/hire.do?action=hrmPageJobDetail'),
(187, 77, 'app/hrm/hire.do?action=hrmPageJobResume'),
(188, 75, 'app/personal/interview.do?action=dialogInterviewCommentPage'),
(189, 75, 'app/personal/interview.do?action=actionDoComment'),
(206, 84, 'app/personal/task.do?action=dialogApplyPage'),
(207, 84, 'app/personal/task.do?action=actionSaveTaskApply'),
(208, 83, 'app/personal/task.do?action=dialogApplyPage'),
(209, 83, 'app/personal/task.do?action=actionSaveTaskApply'),
(210, 80, 'app/personal/task.do?action=dialogTaskPage'),
(211, 80, 'app/personal/task.do?action=actionSaveTaskPlan'),
(212, 82, 'app/personal/task.do?action=dialogAuditRecords'),
(213, 78, 'app/personal/task.do?action=dialogTaskPage'),
(214, 81, 'app/personal/task.do?action=dialogTaskPage'),
(215, 81, 'app/personal/task.do?action=actionSaveTaskPlan'),
(216, 85, 'app/personal/task.do?action=actionSaveTaskApproval'),
(217, 85, 'app/personal/task.do?action=dialogAuditPage'),
(218, 86, 'app/personal/task.do?action=actionSaveTaskApproval'),
(219, 86, 'app/personal/task.do?action=dialogAuditPage'),
(223, 74, 'app/personal/interview.do?action=pageMyInterviewHistory'),
(224, 87, 'app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex'),
(225, 88, 'app/hrm/hire.do?action=hrmPageJobDetail'),
(226, 89, 'app/hrm/hire.do?action=hrmPageJobResume'),
(231, 93, 'app/admin/task.do?action=dialogTaskPage'),
(232, 92, 'app/admin/task.do?action=dialogTaskPage'),
(233, 94, 'app/admin/task.do?action=actionRemoveTaskPlan'),
(234, 95, 'app/admin/task.do?action=dialogTaskPage'),
(235, 95, 'app/personal/task.do?action=actionSaveTaskPlan'),
(237, 97, 'app/personal/application_form.do?action=dialogApplicationFormPage'),
(238, 31, 'app/hrm/develop.do?action=actionDevelopLoadRecords'),
(239, 96, 'app/personal/application_form.do?action=actionApproveProcess'),
(240, 98, 'app/personal/application_form.do?action=dialogApplicationFormPage'),
(241, 99, 'app/personal/application_form.do?action=actionSaveApplication'),
(242, 99, 'app/personal/application_form.do?action=dialogApplicationFormPage'),
(243, 99, 'app/personal/application_form.do?action=actionLoadTemplatePage'),
(244, 100, 'app/system/school/department/position.do?action=actionSaveDepartmentPosition'),
(245, 100, 'app/system/menu/func.do?action=dialogMenuFuncPage'),
(246, 101, 'TO BE ADDED HERE...'),
(247, 54, 'app/flow/hrm.do?action=actionRemoveProcessTask'),
(251, 104, 'app/personal/conference.do?action=actionCancelConference'),
(253, 106, 'app/personal/conference.do?action=conferenceDetail'),
(255, 107, 'app/personal/conference.do?action=actionActivateConference'),
(257, 109, 'app/admin.do?action=dialogStaffWorkArrange'),
(258, 110, 'app/admin.do?action=adminEditStaffWorkArrangeDialog'),
(259, 111, 'app/admin.do?action=adminDeleteWorkArrange'),
(260, 112, 'app/admin.do?action=actionImportDataFromTemplateDialog'),
(261, 113, 'app/admin.do?action=actionAdjustWorkArrangeDialog'),
(262, 114, 'app/admin.do?action=actionViewWorkArrangePage'),
(264, 16, 'app/system/dictionary.do?action=actionLoadDictionaryEditPage'),
(265, 117, 'app/system/dictionary.do?action=actionDeleteDictionary'),
(267, 119, 'app/system/work/base.do?action=dialogBaseWorkBasePage'),
(269, 121, 'app/system/work/base.do?action=actionRemoveBaseWorkContent'),
(270, 122, 'app/system/work/base/time.do?action=dialogAddWorkTime'),
(271, 123, 'app/system/work/base/time.do?action=actionRemoveBaseWorkTime'),
(272, 124, 'app/system/work/base/time.do?action=dialogBaseWorkTimePage'),
(273, 125, 'app/system/work/template.do?action=dialogWorkArrangePage'),
(274, 126, 'app/system/work/template.do?action=actionEnableWorkTemplate'),
(277, 108, 'app/personal/conference.do?action=actionLoadSubmitSummaryDialog'),
(278, 108, 'app/personal/conference.do?action=actionSubmitSummary'),
(279, 105, 'app/personal/conference.do?action=actionConferenceSave'),
(280, 105, 'app/personal/conference.do?action=conferenceDetail'),
(281, 115, 'app/system/dictionary.do?action=actionSaveDictionary'),
(282, 120, 'app/system/work/base.do?action=actionSaveBaseWorkContent'),
(283, 120, 'app/system/work/base.do?action=dialogAddWorkContent'),
(286, 129, 'app/admin.do?action=adminOprEntryRemove'),
(292, 103, 'app/system/dictionary.do?action=actionLoadByTypeAndLevel&type=conference&level={value}'),
(293, 103, 'app/personal/conference.do?action=actionConferenceSave'),
(294, 103, 'app/personal/conference.do?action=conferenceDetail'),
(297, 133, 'app/admin/doc.do?action=adminPageDocumentDetail'),
(298, 133, 'app/admin/doc.do?action=adminPageDocumentSave'),
(299, 134, 'app/admin/doc.do?action=adminPageDocumentDelete'),
(301, 135, 'app/admin/doc.do?action=adminPageDocumentEdit'),
(302, 135, 'app/admin/doc.do?action=adminPageDocumentEditDetail'),
(303, 136, 'app/system/account.do?action=actionUserStateChange'),
(304, 137, 'app/system/account.do?action=actionUserStateChange'),
(305, 138, 'app/system/account.do?action=actionUserPwdReset'),
(307, 91, 'app/hrm/hire.do?action=hrmPageJobResume'),
(308, 91, 'app/hrm/hire/resume.do?action=actionJobApply'),
(309, 90, 'app/hrm/hire.do?action=hrmPageJobResume'),
(310, 90, 'app/hrm/hire/resume.do?action=actionJobApply'),
(311, 127, 'app/admin.do?action=adminPageEntryDetail'),
(312, 127, 'app/admin/news.do?action=actionNewsEditOrSave'),
(313, 140, 'app/personal/task.do?action=pageTaskIndex'),
(316, 142, 'app/personal/task.do?action=pageTaskLaunched'),
(319, 144, 'app/personal/doc.do?action=pageMyDoc'),
(321, 145, 'app/personal/jobapplication.do?action=pageJobOnHiring'),
(322, 146, 'app/personal/approval.do?action=pageMyApproval'),
(324, 79, 'app/personal/task.do?action=pageTaskLaunched'),
(326, 141, 'app/personal/conference.do?action=myConferenceIndex'),
(327, 102, 'app/personal/conference.do?action=myConferences'),
(328, 149, 'app/admin.do?action=adminPageStaffWorkArrange'),
(329, 150, 'app/admin/attendance/view.do?action=adminPageStaffAtt'),
(330, 151, 'app/admin/doc.do?action=adminPageDocumentIndex'),
(331, 139, 'app/hrm/hire.do?action=hrmJobIndex'),
(332, 152, 'app/hrm/entry.do?action=hrmPageEntryIndex'),
(334, 153, 'app/hrm/employee.do?action=hrmEmployeeDocIndex'),
(335, 154, 'app/finan/expense.do?action=pageFinaExpenseIndex'),
(337, 156, 'app/admin/news.do?action=adminPageEntryApprovalIndex'),
(342, 159, 'app/system/account.do?action=pageAccountIndex'),
(345, 148, 'app/admin/task.do?action=pageTaskDelegateIndex'),
(346, 160, 'app/personal/application_form.do?action=pageMyApplicationIndex'),
(347, 155, 'app/finan/contract.do?action=pageFinaContractIndex'),
(348, 161, 'app/system/password.do?action=changePassword'),
(349, 161, 'app/system/password.do?action=changePasswordPage'),
(350, 162, 'app/system/log.do?action=actionLoadLogPage'),
(351, 132, 'app/admin.do?action=adminPageEntryDetail'),
(352, 132, 'app/admin/news.do?action=actionNewsEditOrSave'),
(353, 130, 'app/admin/news.do?action=adminPageEntryApprovalIndex'),
(354, 131, 'app/admin.do?action=adminOprEntryFirst'),
(356, 128, 'app/admin.do?action=adminPageEntryDetail'),
(357, 128, 'app/admin/news.do?action=actionNewsEditOrSave'),
(358, 13, 'app/hrm/hire.do?action=hrmPageJobApprovalIndex'),
(359, 163, 'app/hrm/hire.do?action=hrmPageJobApprovalIndex'),
(360, 143, 'app/admin/news.do?action=actionNewsScan'),
(361, 143, 'app/personal/news.do?action=pageMyNews'),
(362, 147, 'app/admin/news.do?action=actionNewsScan'),
(363, 147, 'app/admin/news.do?action=adminPageEntryIndex'),
(364, 164, 'app/finan/project.do?action=actionFinanApplicationApprove'),
(367, 167, 'app/finan/project.do?action=actionFinanExpenseFormSave'),
(368, 167, 'app/finan/project.do?action=diaglogFinaProjectPage'),
(369, 166, 'app/finan/project.do?action=diaglogFinaProjectPage'),
(370, 165, 'app/finan/project.do?action=pageFinaProjectIndex'),
(371, 168, 'app/finan/expense.do?action=diaglogFinaExpensePage'),
(372, 168, 'app/finan/expense.do?action=loadFinaExpenseRecords');

-- --------------------------------------------------------

--
-- 資料表格式： `app_global_type`
--

CREATE TABLE IF NOT EXISTS `app_global_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '名称',
  `type_parent` bigint(20) default NULL COMMENT '父节点',
  `type_key` varchar(64) NOT NULL COMMENT '节点的分类Key',
  `type_desc` varchar(150) default NULL COMMENT '分类描述',
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总分类表  用于显示树层次结构的分类 可以允许任何层次结构' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_global_type`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_archive`
--

CREATE TABLE IF NOT EXISTS `app_hrm_archive` (
  `archive_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `job_id` bigint(20) NOT NULL COMMENT '应聘岗位ID',
  `archive_source` tinyint(4) NOT NULL COMMENT '来源',
  `archive_star` tinyint(4) NOT NULL COMMENT '评定星级',
  PRIMARY KEY  (`archive_id`),
  KEY `job_id` (`job_id`),
  KEY `resume_id` (`resume_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='公司人才库' AUTO_INCREMENT=2 ;

--
-- 列出以下資料庫的數據： `app_hrm_archive`
--

INSERT INTO `app_hrm_archive` (`archive_id`, `resume_id`, `job_id`, `archive_source`, `archive_star`) VALUES
(1, 62, 12, 2, 1);

-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_employee`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工档案表' AUTO_INCREMENT=42 ;

--
-- 列出以下資料庫的數據： `app_hrm_employee`
--

INSERT INTO `app_hrm_employee` (`emp_id`, `emp_no`, `dep_id`, `district_id`, `emp_name`, `position_id`, `birthdate`, `phone_no`, `short_no`, `office_phone`, `urgency_contacts`, `positive_due_date`, `contract_end_date`, `onboard_status`, `teacher_star`, `consult_star`, `teach_class`, `teach_subject`, `resume_id`, `status`, `onboard_date`, `entry_id`, `entry_datetime`, `bankNo`) VALUES
(19, '00001001', 15, 1, '罗佳驹', 26, '1984-10-12', '13575747066', '', '0571-88071135', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 37, NULL, '2009-07-01', 1, '2012-07-31 12:35:10', NULL),
(20, '00001002', 15, 1, '梅杰', 13, '1985-01-08', '13777845267', '', '0571-88071391', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 38, NULL, '2009-07-01', 1, '2012-07-31 12:37:23', NULL),
(21, '00003001', 17, 1, '林菁菁', 39, '1984-03-26', '13968155954', '', '0571-88321763', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 39, NULL, '2010-07-01', 1, '2012-07-31 12:40:05', NULL),
(22, '00004001', 22, 1, '许玉凤', 40, '1982-10-01', '13968032442', '', '0571-88323637', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 40, NULL, '2011-05-01', 1, '2012-07-31 12:41:33', NULL),
(23, '00005001', 23, 1, '王伟平', 42, '1986-10-09', '13758194262', '', '0571-88321652', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 41, NULL, '2009-07-01', 1, '2012-07-31 12:42:29', NULL),
(24, '00002001', 16, 1, '刘苗芳', 14, NULL, '0571-88071385', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 42, NULL, '2009-07-01', 1, '2012-07-31 12:43:27', NULL),
(25, '00003002', 17, 1, '周碧英', 28, NULL, '0571-88321763', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 43, NULL, '2011-08-23', 1, '2012-07-31 13:07:07', NULL),
(26, '00003003', 17, 1, '蒋晓萍', 17, NULL, '0571-88321763', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 44, NULL, '2011-09-19', 1, '2012-07-31 13:08:01', NULL),
(27, '00006001', 24, 1, '杨琪', 45, NULL, '0571-88313621', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 45, NULL, '2012-05-01', 1, '2012-07-31 13:09:15', NULL),
(28, '00005002', 23, 1, '何滨', 43, NULL, '0571-88071385', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 46, NULL, '2012-04-05', 1, '2012-07-31 13:10:01', NULL),
(29, '00002002', 16, 1, '程聪', 29, NULL, '15068789653', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 47, NULL, '2012-05-07', 1, '2012-07-31 13:12:00', NULL),
(30, '00005003', 23, 1, '苏斯翔', 43, NULL, '13858056931', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 48, NULL, '2012-05-01', 1, '2012-07-31 13:12:40', NULL),
(31, '00066001', 20, 8, '俞柏红', 25, NULL, '0571-82652282', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 49, NULL, '2011-10-19', 1, '2012-07-31 13:14:18', NULL),
(32, '00076001', 20, 9, '蔡晓喻', 30, NULL, '15005725156', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 50, NULL, '2012-05-31', 1, '2012-07-31 13:19:14', NULL),
(33, '00056001', 20, 7, '章荷英', 25, NULL, '13735168660', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 51, NULL, '2011-04-01', 1, '2012-07-31 13:20:08', NULL),
(34, '00046001', 20, 6, '冯毓', 30, NULL, '15858332937', '', '', '', '2012-08-29', '2012-08-30', 2, 1, 1, '', '', 53, NULL, '2011-12-08', 1, '2012-07-31 13:21:08', NULL),
(35, '00036001', 20, 5, '陈蕾红', 25, NULL, '13626868497', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 54, NULL, '2011-11-09', 1, '2012-07-31 13:21:50', NULL),
(36, '00006002', 24, 1, 'ljx', 44, NULL, '28056121', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 55, NULL, '2012-07-31', 1, '2012-07-31 21:37:38', NULL),
(37, '00003004', 17, 1, '林立', 16, NULL, '28056121', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 28, NULL, '2012-08-03', 19, '2012-08-03 16:37:55', NULL),
(38, '00002003', 16, 1, 'leo', 15, NULL, '123123123', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 60, NULL, '2012-08-24', 19, '2012-08-23 16:04:32', NULL),
(39, '00007001', 26, 1, '王五', 46, NULL, '12345', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 63, NULL, '2012-08-30', 1, '2012-08-30 19:46:59', NULL),
(40, '00003005', 17, 1, '张三', 17, NULL, '12345-32132', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 61, NULL, '2012-08-31', 39, '2012-08-31 11:10:32', NULL),
(41, '00003006', 24, 1, '林锦贤', 45, '1984-10-12', '13575747066', NULL, '0571-88071135', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, 65, NULL, NULL, 1, '2012-08-31 16:54:32', '6228480322386734915');

-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_employee_develop`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee_develop` (
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
  `cproc_depid` bigint(20) default NULL COMMENT '当前审批环节部门ID',
  `cproc_posid` bigint(20) default NULL COMMENT '当前审批岗位ID',
  PRIMARY KEY  (`develop_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='人资申请' AUTO_INCREMENT=21 ;

--
-- 列出以下資料庫的數據： `app_hrm_employee_develop`
--

INSERT INTO `app_hrm_employee_develop` (`develop_id`, `apply_form_no`, `apply_form_type`, `apply_date`, `comments`, `emp_id`, `onboard_date`, `from_district`, `from_dep`, `from_position`, `to_district`, `to_department`, `to_position`, `status`, `audit_state`, `op_state`, `entry_id`, `entry_datetime`, `cproc_depid`, `cproc_posid`) VALUES
(13, 'HRM20120905114235', 6, '2012-09-30', '因本人。。。。。特申请离职', 38, NULL, 1, 16, 15, NULL, NULL, NULL, NULL, 3, 0, 38, '2012-09-05 11:42:35', NULL, NULL),
(14, 'HRM20120905114326', 5, '2012-09-05', '因本人。。。。。特此申请！', 38, NULL, 1, 16, 15, 4, 18, 27, NULL, NULL, 0, 38, '2012-09-05 11:43:26', 20, 30),
(15, 'HRM20120905114347', 3, '2012-09-30', '', 38, NULL, 1, 16, 15, NULL, NULL, NULL, NULL, NULL, 0, 38, '2012-09-05 11:43:47', NULL, NULL),
(16, 'HRM20120905114409', 4, '2012-09-07', '', 38, NULL, 1, 16, 15, 3, 18, 27, NULL, NULL, 0, 38, '2012-09-05 11:44:09', 18, 27),
(17, 'HRM20120905115010', 4, '2012-09-05', '', 39, NULL, 1, 26, 46, 1, 15, 13, NULL, NULL, 0, 39, '2012-09-05 11:50:10', 15, 26),
(18, 'HRM20120905115036', 6, '2012-09-30', '', 39, NULL, 1, 26, 46, NULL, NULL, NULL, NULL, NULL, 0, 39, '2012-09-05 11:50:36', 15, 26),
(19, 'HRM20120905134557', 3, '2012-09-13', '', 36, NULL, 1, 24, 44, NULL, NULL, NULL, NULL, NULL, 0, 36, '2012-09-05 13:45:57', 15, 26),
(20, 'HRM20120905162914', 3, '2012-10-02', '申请实例', 29, NULL, 1, 16, 29, NULL, NULL, NULL, NULL, NULL, 0, 29, '2012-09-05 16:29:14', 16, 14);

-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_employee_profile`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee_profile` (
  `profile_id` bigint(20) NOT NULL auto_increment,
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `status` tinyint(4) NOT NULL COMMENT '员工状态',
  PRIMARY KEY  (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工基本信息表' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_hrm_employee_profile`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_employee_roadmap`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee_roadmap` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工历程' AUTO_INCREMENT=43 ;

--
-- 列出以下資料庫的數據： `app_hrm_employee_roadmap`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_hire_entries`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_entries` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工入职安排表' AUTO_INCREMENT=19 ;

--
-- 列出以下資料庫的數據： `app_hrm_hire_entries`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_hire_interviews`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_interviews` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='招聘面试' AUTO_INCREMENT=19 ;

--
-- 列出以下資料庫的數據： `app_hrm_hire_interviews`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_hire_interviews_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_interviews_file` (
  `interview_id` bigint(20) NOT NULL COMMENT '面试ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`interview_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='面试附件';

--
-- 列出以下資料庫的數據： `app_hrm_hire_interviews_file`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_hire_issue`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_issue` (
  `hissue_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `hjob_id` bigint(20) NOT NULL COMMENT '应聘职位ID',
  `hjobentry_id` bigint(20) default NULL COMMENT '入职数据ID',
  `current_status` tinyint(4) NOT NULL COMMENT '当前状态',
  `final_result` tinyint(4) default NULL COMMENT '最终处理结果',
  `user_id` bigint(20) default NULL COMMENT '应聘者ID, 主要用于存员工申请 (包含自我申请, 推荐他人)',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY  (`hissue_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='当前招聘' AUTO_INCREMENT=38 ;

--
-- 列出以下資料庫的數據： `app_hrm_hire_issue`
--

INSERT INTO `app_hrm_hire_issue` (`hissue_id`, `resume_id`, `hjob_id`, `hjobentry_id`, `current_status`, `final_result`, `user_id`, `apply_time`) VALUES
(35, 66, 18, NULL, 1, NULL, 27, '2012-09-05 13:38:23'),
(36, 67, 18, NULL, 1, NULL, 36, '2012-09-05 13:45:41'),
(37, 68, 18, NULL, 1, NULL, 39, '2012-09-05 13:55:32');

-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_hire_job`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_job` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='招聘岗位发布' AUTO_INCREMENT=20 ;

--
-- 列出以下資料庫的數據： `app_hrm_hire_job`
--

INSERT INTO `app_hrm_hire_job` (`hjob_id`, `job_title`, `hjob_districtid`, `hjob_depid`, `hjob_range`, `hjob_visible_districtid`, `end_date`, `hjob_count`, `hjob_condition`, `hjob_address`, `hjob_responsibility`, `hjob_salary`, `reg_fullname`, `reg_date`, `modify_fullname`, `modify_date`, `check_fullname`, `check_opinion`, `check_date`, `status`, `memo`, `isopen`, `entry_id`, `entry_time`) VALUES
(18, '市场专员', 1, 15, 1, NULL, '2012-09-30 00:00:00', 2, '', '杭州', '', '', '王五', '2012-09-05 11:55:50', NULL, NULL, '王五', NULL, '2012-09-05 11:55:50', 4, NULL, 1, 39, '2012-09-05 11:54:50'),
(19, '行政', 1, 15, 1, NULL, '2012-09-30 00:00:00', 1, '', '', '', '', '王五', '2012-09-05 11:56:32', NULL, NULL, '王五', NULL, '2012-09-05 11:56:32', 4, NULL, 1, 39, '2012-09-05 11:55:06');

-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_hire_job_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_job_file` (
  `hjob_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`hjob_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招聘岗位附件';

--
-- 列出以下資料庫的數據： `app_hrm_hire_job_file`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_resume`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resume` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='简历管理' AUTO_INCREMENT=69 ;

--
-- 列出以下資料庫的數據： `app_hrm_resume`
--

INSERT INTO `app_hrm_resume` (`resume_id`, `emp_id`, `fullname`, `age`, `birthday`, `address`, `marriage`, `zip`, `sex`, `phone`, `mobile`, `email`, `hobby`, `religion`, `party`, `nationality`, `race`, `birthPlace`, `eduCollege`, `eduDegree`, `eduMajor`, `teacher_major`, `teacher_cert`, `startWorkDate`, `idNo`, `photo`, `status`, `memo`, `registor`, `regTime`, `workCase`, `trainCase`, `projectCase`, `en_level`, `cn_level`, `source`) VALUES
(65, 41, '林锦贤', 28, NULL, '杭州市拱墅区湖墅南路', NULL, NULL, 1, NULL, '13575747066', '13575747066@139.com', NULL, NULL, NULL, NULL, NULL, NULL, '浙江大学', NULL, NULL, NULL, NULL, NULL, '330682 19841012 0030 ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(66, NULL, '01', NULL, NULL, '', 1, NULL, 1, NULL, '13333333333', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2),
(67, NULL, '01', NULL, NULL, '', 1, NULL, 1, NULL, '88313621', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2),
(68, NULL, '01', NULL, NULL, '', 1, NULL, 1, NULL, '88313621', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2);

-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_resume_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resume_file` (
  `file_id` bigint(20) NOT NULL,
  `resum_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`file_id`,`resum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历附件';

--
-- 列出以下資料庫的數據： `app_hrm_resume_file`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_menu`
--

CREATE TABLE IF NOT EXISTS `app_menu` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统菜单' AUTO_INCREMENT=55 ;

--
-- 列出以下資料庫的數據： `app_menu`
--

INSERT INTO `app_menu` (`menu_id`, `menu_title`, `menu_icon`, `menu_url`, `menu_key`, `menu_desc`, `menu_parent`, `menu_order`) VALUES
(3, '我的工作区', 'icon-desktop', 'javascript:void(0);', '_menu_mod_personal', '', NULL, 0),
(4, '我的任务', 'icon-myplan', 'app/personal/task.do?action=pageTaskIndex', '_menu_mod_personal_mytask', '', 3, 0),
(5, '财务管理', 'icon-financial', 'javascript:void(0);', '_menu_mod_fina', '', NULL, 3),
(6, '费用支出管理', 'icon-finmrmb', 'javascript:void(0);', '_menu_mod_fina_exp_mgr', '', 5, 0),
(7, '费用支出申请', 'icon-finmrmbApply', 'app/finan/expense.do?action=pageFinaExpenseIndex', '_menu_mod_fina_exp_apply', '', 6, 0),
(8, '人资管理', 'icon-hr', 'javascript:void(0);', '_menu_mod_hrm', '', NULL, 2),
(9, '系统管理', 'icon-system', 'javascript:void(0);', '_menu_mod_sysmgr', '', NULL, 4),
(10, '系统设置', 'icon-settings', 'javascript:void(0);', '_menu_mod_syscfg', '', NULL, 4),
(11, '数据字典设置', 'icon-setdic', 'app/system/dictionary.do?action=actionDictionaryPage', '_menu_mod_syscfg_item_dic', '', 10, 0),
(12, '工作安排设置', 'icon-setaskm', 'javascript:void(0);', '_menu_mod_syscfg_item_workarrange', '', 10, 1),
(13, '审批流程设置', 'icon-setflowm', 'javascript:void(0);', '_menu_mod_syscfg_item_flow', '', 10, 2),
(14, '学校设置', 'icon-setorg', 'javascript:void(0);', '_menu_mod_syscfg_item_school', '', 10, 3),
(15, '权限组配置', 'icon-setrole', 'app/system/role.do?action=pageRoleIndex', '_menu_mod_syscfg_item_role', '', 10, 4),
(16, '菜单设置', 'icon-setres', 'app/system/menu.do?action=pageMenuIndex', '_menu_mod_syscfg_item_menu', '', 10, 5),
(17, '行政管理', 'icon-admin', 'javascript:void(0);', '_menu_mod_admin', '', NULL, 1),
(18, '工作安排模板设置', 'icon-setaskmTpl', 'app/system/work/template.do?action=pageWorkTemplateIndex', '_menu_mod_syscfg_item_workarrange_template', '', 12, 0),
(19, '工作安排基础设置', 'icon-setaskmBase', 'app/system/work/base.do?action=pageWorkBaseIndex', '_menu_mod_syscfg_item_workarrange_base', '', 12, 1),
(20, '人资审批流程设置', 'icon-setflowmhr', 'app/flow/hrm.do?action=pageFlowIndex', '_menu_mod_syscfg_item_flow_financial', '', 13, 0),
(21, '财务审批流程设置', 'icon-setflowmfin', 'app/flow/finance.do?action=pageFlowIndex', '_menu_mod_syscfg_item_flow_financ', '', 13, 1),
(22, '校区设置', 'icon-setorgDep', 'app/system/school/district.do?action=pageSchoolDistrictIndex', '_menu_mod_syscfg_item_school_district', '', 14, 0),
(23, '部门岗位设置', 'icon-setorgRepo', 'app/system/school/department.do?action=pageSchoolDepartmentIndex', '_menu_mod_syscfg_item_school_dep', '', 14, 1),
(24, '职位岗位设置', 'icon-setdePos', 'app/system/school/poset.do?action=pageSchoolPosetIndex', '_menu_mod_syscfg_item_school_poset', '', 14, 2),
(25, '密码修改', 'icon-sysmpwd', 'app/system/password.do?action=changePasswordPage', '_menu_mod_sysmgr_svpwd', '', 9, 0),
(26, '用户管理', 'icon-sysmusr', 'app/system/account.do?action=pageAccountIndex', '_menu_mod_sysmgr_usrmgr', '', 9, 1),
(27, '系统日志', 'icon-sysmlogs', 'app/system/log.do?action=actionLoadLogPage', '_menu_mod_sysmgr_logs', '', 9, 2),
(28, '费用审批记录', 'icon-finmrmbApproval', 'app/finan/expense.do?action=pageFinaExpenseRecords', '_menu_mod_fina_exp_records', '', 6, 1),
(29, '合同管理', 'icon-finmcontracts', 'javascript:void(0);', '_menu_mod_fina_contract', '', 5, 1),
(30, '合同审批申请', 'icon-finmcontractsApply', 'app/finan/contract.do?action=pageFinaContractIndex', '_menu_mod_fina_contract_apply', '', 29, 0),
(31, '合同审批记录', 'icon-finmcontractsRecords', 'app/finan/contract.do?action=pageFinaContractRecords', '_menu_mod_fina_contract_records', '', 29, 1),
(32, '我的会议', 'icon-myconference', 'app/personal/conference.do?action=myConferenceIndex', '_menu_mod_personal_conference', '', 3, 1),
(33, '我的新闻', 'icon-mynews', 'app/personal/news.do?action=pageMyNews', '_menu_mod_personal_news', '', 3, 2),
(34, '文档下载区', 'icon-infodoc', 'app/personal/doc.do?action=pageMyDoc', '_menu_mod_personal_doc', '', 3, 3),
(35, '我要应聘', 'icon-hrjobreg', 'app/personal/jobapplication.do?action=pageJobOnHiring', '_menu_mod_personal_jobreg', '', 3, 4),
(36, '我做伯乐', 'icon-myinvite', 'app/personal/interview.do?action=pageMyInterviewToDo', '_menu_mod_personal_invitation', '', 3, 5),
(37, '我的申请', 'icon-myapply', 'app/personal/application_form.do?action=pageMyApplicationIndex', '_menu_mod_personal_apply', '', 3, 6),
(38, '待我审批', 'icon-myapproval', 'app/personal/approval.do?action=pageMyApproval', '_menu_mod_personal_approval', '', 3, 7),
(39, '新闻发布与管理', 'icon-adminnews', 'app/admin/news.do?action=adminPageEntryIndex', '_menu_mod_admin_news', '', 17, 0),
(40, '任务委托管理', 'icon-admintask', 'app/admin/task.do?action=pageTaskDelegateIndex', '_menu_mod_admin_task', '', 17, 1),
(41, '员工考勤管理', 'icon-admindutyStaff', 'javascript:void(0);', '_menu_mod_admin_staff', '', 17, 2),
(42, '文档上传与管理', 'icon-infoshared', 'app/admin/doc.do?action=adminPageDocumentIndex', '_menu_mod_personal_docup', '', 17, 3),
(43, '工作安排', 'icon-admindutyArrange', 'app/admin.do?action=adminPageStaffWorkArrange', '_menu_mod_admin_staff_workarrange', '', 41, 0),
(44, '员工考勤', 'icon-adminduty', 'app/admin/attendance/view.do?action=adminPageStaffAttendance', '_menu_mod_admin_staff_attendance', '', 41, 1),
(45, '招聘管理', 'icon-hrjobm', 'javascript:void(0);', '_menu_mod_hrm_jobhire', '', 8, 0),
(46, '员工档案管理', 'icon-hrstaffm', 'javascript:void(0);', '_menu_mod_hrm_empdoc', '', 8, 1),
(47, '人力发展管理', 'icon-hrmcheck', 'app/hrm/develop.do?action=hrmEmployeeDevelopIndex', '_menu_mod_admin_emp_develop', '', 8, 2),
(48, '当前招聘管理', 'icon-hrjobmIssue', 'app/hrm/hire.do?action=hrmJobIndex', '_menu_mod_hrm_jobhire_cmgr', '', 45, 0),
(49, '公司人才库', 'icon-hrjobmProfile', 'app/hrm/archive.do?action=hrmJobResumeIndex', '_menu_mod_hrm_jobhire_develop', '', 45, 1),
(50, '招聘入职', 'icon-hrjobreg', 'app/hrm/entry.do?action=hrmPageEntryIndex', '_menu_mod_hrm_entry', '', 46, 0),
(51, '员工档案', 'icon-hrstaffmProfile', 'app/hrm/employee.do?action=hrmEmployeeDocIndex', '_menu_mod_hrm_emp_archive', '', 46, 1),
(52, '新项目支出管理', 'icon-finmproject', 'javascript:void(0);', '_menu_mod_fina_project', '', 5, 0),
(53, '新项目支出申请', 'icon-finmprojectApply', 'app/finan/project.do?action=pageFinaProjectIndex', '_menu_mod_fina_project_apply', '', 52, 0),
(54, '新项目审批记录', 'icon-finmprojectRecords', 'app/finan/project.do?action=pageFinaProjectRecords', '_menu_mod_fina_project_records', '', 52, 1);

-- --------------------------------------------------------

--
-- 資料表格式： `app_message_entity`
--

CREATE TABLE IF NOT EXISTS `app_message_entity` (
  `msg_id` bigint(20) NOT NULL auto_increment,
  `msg_subject` varchar(150) NOT NULL COMMENT '消息标题',
  `msg_content` text NOT NULL COMMENT '消息内容',
  `sender_id` bigint(20) NOT NULL COMMENT '发送者ID',
  `sender_name` varchar(120) NOT NULL COMMENT '发送者姓名',
  `msg_type` tinyint(4) default NULL COMMENT '消息类型',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  PRIMARY KEY  (`msg_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='短消息' AUTO_INCREMENT=183 ;

--
-- 列出以下資料庫的數據： `app_message_entity`
--

INSERT INTO `app_message_entity` (`msg_id`, `msg_subject`, `msg_content`, `sender_id`, `sender_name`, `msg_type`, `send_time`) VALUES
(131, '[待我审批] 罗佳驹 发起的任务委托 `任务1` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 发起的任务委托 `任务1` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务时间：</b> 2012-08-31 --- 2012-09-01</div>\r\n	<div><b>任务描述：</b> </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=27&op=audit'', \r\n			''task_view_27'',  \r\n			''查看‘任务1’任务委托内容'',\r\n			{width: 1080, height: 380})">点击查看任务委托详细</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-31 17:01:32'),
(132, '[任务发起] 罗佳驹 发起任务 “任务1 ” 审批通过，负责人为：罗佳驹', '<div style="line-height: 25px;">\r\n	<div>罗佳驹发起任务 “任务1” 已审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 罗佳驹</div>\r\n	<div><b>任务时间：</b> 2012-08-31 --- 2012-09-01 </div>\r\n	<div><b>任务参与人：</b>  </div>\r\n	<div><b>审批人：</b> 罗佳驹 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/task.do?action=dialogTaskPage&id=27&op=view'', \r\n			''task_view_27'',  \r\n			''`任务1`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-31 17:01:48'),
(133, '[待我审批] 罗佳驹 发起的任务委托 `任务2` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 发起的任务委托 `任务2` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务时间：</b> 2012-09-03 --- 2012-09-05</div>\r\n	<div><b>任务描述：</b> </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=28&op=audit'', \r\n			''task_view_28'',  \r\n			''查看‘任务2’任务委托内容'',\r\n			{width: 1080, height: 380})">点击查看任务委托详细</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-31 17:02:18'),
(134, '[任务发起] 罗佳驹 发起任务 “任务2 ” 审批通过，负责人为：罗佳驹', '<div style="line-height: 25px;">\r\n	<div>罗佳驹发起任务 “任务2” 已审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 罗佳驹</div>\r\n	<div><b>任务时间：</b> 2012-09-03 --- 2012-09-05 </div>\r\n	<div><b>任务参与人：</b>  </div>\r\n	<div><b>审批人：</b> 罗佳驹 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/task.do?action=dialogTaskPage&id=28&op=view'', \r\n			''task_view_28'',  \r\n			''`任务2`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-31 17:02:29'),
(135, '[待我审批] 周碧英 提交的 `其他日常支出` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 周碧英 提交的 `其他日常支出` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b>  车费</div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=12&op=view'', \r\n			''approval_finan_12'',  \r\n			''查看‘周碧英’ 费用支出申请单-FE20120905111834'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 25, '周碧英', 2, '2012-09-05 11:18:34'),
(136, '[待我审批] 周碧英 提交的 `其他日常支出` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 周碧英 提交的 `其他日常支出` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> 餐费</div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=13&op=view'', \r\n			''approval_finan_13'',  \r\n			''查看‘周碧英’ 费用支出申请单-FE20120905112134'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 25, '周碧英', 2, '2012-09-05 11:21:34'),
(137, '[待我审批] 林菁菁 发起的任务委托 `核对` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 林菁菁 发起的任务委托 `核对` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务时间：</b> 2012-09-05 --- 2012-09-19</div>\r\n	<div><b>任务描述：</b> 1234566</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=29&op=audit'', \r\n			''task_view_29'',  \r\n			''查看‘核对’任务委托内容'',\r\n			{width: 1080, height: 380})">点击查看任务委托详细</a></div>\r\n</div>', 21, '林菁菁', 2, '2012-09-05 11:32:24'),
(138, '[待我审批] leo 提交的 `业务招待费` 有待审批', '<div style="line-height: 25px;">\r\n	<div> leo 提交的 `业务招待费` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> 餐费</div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=14&op=view'', \r\n			''approval_finan_14'',  \r\n			''查看‘leo’ 费用支出申请单-FE20120905113722'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 38, 'leo', 2, '2012-09-05 11:37:22'),
(139, '[待我审批] leo 提交的 `业务招待费` 有待审批', '<div style="line-height: 25px;">\r\n	<div> leo 提交的 `业务招待费` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> 教师节日礼品</div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=15&op=view'', \r\n			''approval_finan_15'',  \r\n			''查看‘leo’ 费用支出申请单-FE20120905113831'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 38, 'leo', 2, '2012-09-05 11:38:31'),
(140, '[待我审批] leo 提交的 `房租合同` 有待审批', '<div style="line-height: 25px;">\r\n	<div> leo 提交的 `房租合同` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/contract.do?action=diaglogFinaContractPage&id=5&op=view'', \r\n			''approval_finan_5'',  \r\n			''查看‘leo’ 合同申请单-FC20120905113905'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 38, 'leo', 2, '2012-09-05 11:39:05'),
(141, '[待我审批] leo 提交的 `离职申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> leo 提交的 `离职申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> 因本人。。。。。特申请离职</div>\r\n	<div><b>申请时间：</b> 2012-09-30</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=13&op=view'', \r\n			''approval_hrm_13'',  \r\n			''查看‘leo’人资申请单-HRM20120905114235'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 38, 'leo', 2, '2012-09-05 11:42:35'),
(142, '[会议发起] 会议 “000 ”已发起，请及时参加', '<div style="line-height: 25px;">\r\n	<div>[会议发起] 会议“000 ”已发起，请及时参加.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>会议时间：</b> 2012-09-05 08：00---2012-09-06\r\n 08：00</div>\r\n	<div><b>会议地址：</b> 杭州 </div>\r\n	<div><b>会议发起人：</b> 林菁菁 </div>\r\n	<div><b>会议联系人：</b> 林菁菁 </div>\r\n	<div><b>联系电话：</b> 13968155954 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/conference.do?action=conferenceDetail&id=10&op=view'', \r\n			''conference_view_10'',  \r\n			''`000`会议详情'',\r\n			{width: 1150, height: 450})">点击查看会议详细</a></div>\r\n</div>', 21, '林菁菁', 2, '2012-09-05 11:42:42'),
(143, '[待我审批] leo 提交的 `晋升申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> leo 提交的 `晋升申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> 因本人。。。。。特此申请！</div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=14&op=view'', \r\n			''approval_hrm_14'',  \r\n			''查看‘leo’人资申请单-HRM20120905114326'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 38, 'leo', 2, '2012-09-05 11:43:26'),
(144, '[会议调整] 会议 “000 ”已调整，请及时参加', '<div style="line-height: 25px;">\r\n	<div>[会议调整] 会议“000 ”已调整,请及时参加</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>会议时间：</b> 2012-09-06 08：00---2012-09-07\r\n 08：00</div>\r\n	<div><b>会议地址：</b> 杭州 </div>\r\n	<div><b>会议发起人：</b> 林菁菁 </div>\r\n	<div><b>会议联系人：</b> 林菁菁 </div>\r\n	<div><b>联系电话：</b> 13968155954 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/conference.do?action=conferenceDetail&id=10&op=view'', \r\n			''conference_view_10'',  \r\n			''`000`会议详情'',\r\n			{width: 1150, height: 450})">点击查看会议详细</a></div>\r\n</div>', 21, '林菁菁', 2, '2012-09-05 11:43:32'),
(145, '[待我审批] leo 提交的 `转正申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> leo 提交的 `转正申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-30</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=15&op=view'', \r\n			''approval_hrm_15'',  \r\n			''查看‘leo’人资申请单-HRM20120905114347'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 38, 'leo', 2, '2012-09-05 11:43:47'),
(146, '[待我审批] leo 提交的 `调动申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> leo 提交的 `调动申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-07</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=16&op=view'', \r\n			''approval_hrm_16'',  \r\n			''查看‘leo’人资申请单-HRM20120905114409'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 38, 'leo', 2, '2012-09-05 11:44:10'),
(147, '[会议结束] 会议“000 ”已结束，请查看会议总结', '<div style="line-height: 25px;">\r\n	<div>[会议结束] 会议“000 ”已结束，请查看会议总结.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>会议时间：</b> 2012-09-06 08：00---2012-09-07\r\n 08：00</div>\r\n	<div><b>会议地址：</b> 杭州 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/conference.do?action=conferenceDetail&id=10&op=view'', \r\n			''conference_view_10'',  \r\n			''`000`会议详情'',\r\n			{width: 1150, height: 450})">点击查看会议详细</a></div>\r\n</div>', 21, '林菁菁', 2, '2012-09-05 11:45:24'),
(148, '[待我审批] 刘苗芳 发起的任务委托 `9月市场计划` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 刘苗芳 发起的任务委托 `9月市场计划` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务时间：</b> 2012-09-05 --- 2012-09-13</div>\r\n	<div><b>任务描述：</b> 嘎哈地方回家想蒋经国就啊哈的合同集团军儿童节</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=30&op=audit'', \r\n			''task_view_30'',  \r\n			''查看‘9月市场计划’任务委托内容'',\r\n			{width: 1080, height: 380})">点击查看任务委托详细</a></div>\r\n</div>', 24, '刘苗芳', 2, '2012-09-05 11:46:39'),
(149, '[我的申请] leo 申请的 `离职申请审批` 审批不通过', '<div style="line-height: 25px;">\r\n	<div> leo 于 2012-09-30 所申请的 `离职申请审批` 审批不通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>审批人：</b> 刘苗芳</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=13&op=view'', \r\n			''myapplication_13'',  \r\n			''查看‘leo’人资申请单-HRM20120905114235'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 24, '刘苗芳', 2, '2012-09-05 11:47:53'),
(150, '[我的申请] leo 申请的 `转正申请审批` 审批退回', '<div style="line-height: 25px;">\r\n	<div> leo 于 2012-09-30 所申请的 `转正申请审批` 审批退回.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>审批人：</b> 刘苗芳</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=15&op=view'', \r\n			''myapplication_15'',  \r\n			''查看‘leo’人资申请单-HRM20120905114347'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 24, '刘苗芳', 2, '2012-09-05 11:48:17'),
(151, '[待我审批] 王五 发起的任务委托 `例会` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 王五 发起的任务委托 `例会` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务时间：</b> 2012-09-05 --- 2012-09-06</div>\r\n	<div><b>任务描述：</b> 请各位抓紧时间系统测试，不管有无问题，都将反馈意见发至13858056931@139.com</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=31&op=audit'', \r\n			''task_view_31'',  \r\n			''查看‘例会’任务委托内容'',\r\n			{width: 1080, height: 380})">点击查看任务委托详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:49:02'),
(152, '[待我审批] 王五 提交的 `调动申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 王五 提交的 `调动申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=17&op=view'', \r\n			''approval_hrm_17'',  \r\n			''查看‘王五’人资申请单-HRM20120905115010'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:50:10'),
(153, '[待我审批] 王五 提交的 `离职申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 王五 提交的 `离职申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-30</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=18&op=view'', \r\n			''approval_hrm_18'',  \r\n			''查看‘王五’人资申请单-HRM20120905115036'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:50:36'),
(154, '[待我审批] 王五 提交的新闻 `系统测试` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 王五 提交的新闻 `系统测试` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请时间：</b> 2012-09-05 11:51:18</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin.do?action=adminPageEntryDetail&id=11&op=view'', \r\n			''news_view_11'',  \r\n			''查看‘系统测试’新闻内容'',\r\n			{width: 900, height: 500})">点击查看新闻详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:51:18'),
(155, '[待我审批] 王五 发布的招聘岗位 `市场专员` 有待审批\r\n', '<div style="line-height: 25px;">\r\n	<div> 王五 发布的招聘岗位 `市场专员` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>岗位工作地点：</b> 杭州</div>\r\n	<div><b>岗位发布时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/hrm/hire.do?action=hrmPageJobDetail&id=18'', \r\n			''job_view_18'',  \r\n			''查看‘市场专员’岗位'',\r\n			{width: 960, height: 420})">点击查看岗位详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:54:50'),
(156, '[待我审批] 王五 发布的招聘岗位 `行政` 有待审批\r\n', '<div style="line-height: 25px;">\r\n	<div> 王五 发布的招聘岗位 `行政` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>岗位工作地点：</b> </div>\r\n	<div><b>岗位发布时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/hrm/hire.do?action=hrmPageJobDetail&id=19'', \r\n			''job_view_19'',  \r\n			''查看‘行政’岗位'',\r\n			{width: 960, height: 420})">点击查看岗位详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:55:06'),
(157, '[招聘管理] 王五 发布的招聘岗位 `市场专员` 审批通过, 审批人: 王五', '<div style="line-height: 25px;">\r\n	<div> 王五 发布的招聘岗位 `市场专员` 审批通过 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>审批人：</b> 王五</div>\r\n	<div><b>审批时间：</b> 2012-09-05 11:55:28</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/hrm/hire.do?action=hrmPageJobDetail&id=18&op=edit'', \r\n			''job_view_18'',  \r\n			''查看‘市场专员’岗位'',\r\n			{width: 960, height: 420})">点击查看岗位详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:55:28'),
(158, '[待我审批] 王五 发布的招聘岗位 `市场专员` 有待审批\r\n', '<div style="line-height: 25px;">\r\n	<div> 王五 发布的招聘岗位 `市场专员` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>岗位工作地点：</b> 杭州</div>\r\n	<div><b>岗位发布时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/hrm/hire.do?action=hrmPageJobDetail&id=18'', \r\n			''job_view_18'',  \r\n			''查看‘市场专员’岗位'',\r\n			{width: 960, height: 420})">点击查看岗位详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:55:41'),
(159, '[招聘管理] 王五 发布的招聘岗位 `市场专员` 审批通过, 审批人: 王五', '<div style="line-height: 25px;">\r\n	<div> 王五 发布的招聘岗位 `市场专员` 审批通过 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>审批人：</b> 王五</div>\r\n	<div><b>审批时间：</b> 2012-09-05 11:55:50</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/hrm/hire.do?action=hrmPageJobDetail&id=18&op=edit'', \r\n			''job_view_18'',  \r\n			''查看‘市场专员’岗位'',\r\n			{width: 960, height: 420})">点击查看岗位详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:55:50'),
(160, '[招聘管理] 王五 发布的招聘岗位 `行政` 审批通过, 审批人: 王五', '<div style="line-height: 25px;">\r\n	<div> 王五 发布的招聘岗位 `行政` 审批通过 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>审批人：</b> 王五</div>\r\n	<div><b>审批时间：</b> 2012-09-05 11:56:32</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/hrm/hire.do?action=hrmPageJobDetail&id=19&op=edit'', \r\n			''job_view_19'',  \r\n			''查看‘行政’岗位'',\r\n			{width: 960, height: 420})">点击查看岗位详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 11:56:32'),
(161, '[待我审批] 王五 提交的 `业务招待费` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 王五 提交的 `业务招待费` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=16&op=view'', \r\n			''approval_finan_16'',  \r\n			''查看‘王五’ 费用支出申请单-FE20120905120032'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 12:00:32'),
(162, '[待我审批] 杨琪 提交的新闻 `中秋节` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 杨琪 提交的新闻 `中秋节` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请时间：</b> 2012-09-05 01:35:13</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin.do?action=adminPageEntryDetail&id=12&op=view'', \r\n			''news_view_12'',  \r\n			''查看‘中秋节’新闻内容'',\r\n			{width: 900, height: 500})">点击查看新闻详细</a></div>\r\n</div>', 27, '杨琪', 2, '2012-09-05 13:35:13'),
(163, '[待我审批] 罗佳驹 提交的 `业务招待费` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 提交的 `业务招待费` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-07</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=17&op=view'', \r\n			''approval_finan_17'',  \r\n			''查看‘罗佳驹’ 费用支出申请单-FE20120905134243'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 27, '杨琪', 2, '2012-09-05 13:42:43'),
(164, '[待我审批] 罗佳驹 提交的 `房租合同` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 提交的 `房租合同` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-06</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/contract.do?action=diaglogFinaContractPage&id=6&op=view'', \r\n			''approval_finan_6'',  \r\n			''查看‘罗佳驹’ 合同申请单-FC20120905134321'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 27, '杨琪', 2, '2012-09-05 13:43:21'),
(165, '[我的新闻] 杨琪 提交的新闻 `中秋节` 审批通过, 审批人: ljx', '<div style="line-height: 25px;">\r\n	<div> 杨琪 提交的新闻 `中秋节` 审批通过 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>审批人：</b> ljx</div>\r\n	<div><b>审批时间：</b> 2012-09-05 01:44:08</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin.do?action=adminPageEntryDetail&id=12&op=readonly'', \r\n			''news_view_12'',  \r\n			''查看‘中秋节’新闻内容'',\r\n			{width: 900, height: 500})">点击查看新闻详细</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:44:08'),
(166, '[我的新闻] 王五 提交的新闻 `系统测试` 审批通过, 审批人: ljx', '<div style="line-height: 25px;">\r\n	<div> 王五 提交的新闻 `系统测试` 审批通过 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>审批人：</b> ljx</div>\r\n	<div><b>审批时间：</b> 2012-09-05 01:44:22</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin.do?action=adminPageEntryDetail&id=11&op=readonly'', \r\n			''news_view_11'',  \r\n			''查看‘系统测试’新闻内容'',\r\n			{width: 900, height: 500})">点击查看新闻详细</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:44:22'),
(167, '[待我审批] 王五 提交的 `离职申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 王五 提交的 `离职申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-30</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=18&op=view'', \r\n			''approval_hrm_18'',  \r\n			''查看‘王五’人资申请单-HRM20120905115036'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:44:38'),
(168, '[任务发起] 王五 发起任务 “例会 ” 审批通过，负责人为：王五', '<div style="line-height: 25px;">\r\n	<div>王五发起任务 “例会” 已审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 王五</div>\r\n	<div><b>任务时间：</b> 2012-09-05 --- 2012-09-06 </div>\r\n	<div><b>任务参与人：</b> 王五,leo,林立,罗佳驹,刘苗芳,周碧英,张三,许玉凤,林锦贤,王伟平,梅杰,林菁菁,杨琪,蒋晓萍,程聪,何滨,ljx,苏斯翔 </div>\r\n	<div><b>审批人：</b> ljx </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/task.do?action=dialogTaskPage&id=31&op=view'', \r\n			''task_view_31'',  \r\n			''`例会`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:44:51'),
(169, '[待我审批] ljx 提交的 `转正申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> ljx 提交的 `转正申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-13</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=19&op=view'', \r\n			''approval_hrm_19'',  \r\n			''查看‘ljx’人资申请单-HRM20120905134557'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:45:57'),
(170, '[待我审批] ljx 提交的 `转正申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> ljx 提交的 `转正申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-13</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=19&op=view'', \r\n			''approval_hrm_19'',  \r\n			''查看‘ljx’人资申请单-HRM20120905134557'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:46:11'),
(171, '[任务发起] 林菁菁 发起任务 “核对 ” 审批通过，负责人为：林菁菁', '<div style="line-height: 25px;">\r\n	<div>林菁菁发起任务 “核对” 已审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 林菁菁</div>\r\n	<div><b>任务时间：</b> 2012-09-05 --- 2012-09-19 </div>\r\n	<div><b>任务参与人：</b> 蒋晓萍,周碧英,王伟平 </div>\r\n	<div><b>审批人：</b> ljx </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/task.do?action=dialogTaskPage&id=29&op=view'', \r\n			''task_view_29'',  \r\n			''`核对`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:46:30'),
(172, '[任务发起] 刘苗芳 发起任务 “9月市场计划 ” 审批通过，负责人为：刘苗芳', '<div style="line-height: 25px;">\r\n	<div>刘苗芳发起任务 “9月市场计划” 已审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 刘苗芳</div>\r\n	<div><b>任务时间：</b> 2012-09-05 --- 2012-09-13 </div>\r\n	<div><b>任务参与人：</b> leo,程聪,刘苗芳 </div>\r\n	<div><b>审批人：</b> ljx </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/task.do?action=dialogTaskPage&id=30&op=view'', \r\n			''task_view_30'',  \r\n			''`9月市场计划`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:46:35'),
(173, '[待我审批] 罗佳驹 提交的 `工资薪金、福利费支出` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 提交的 `工资薪金、福利费支出` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-07</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=18&op=view'', \r\n			''approval_finan_18'',  \r\n			''查看‘罗佳驹’ 费用支出申请单-FE20120905135253'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:52:53'),
(174, '[待我审批] 罗佳驹 提交的 `房租合同` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 提交的 `房租合同` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-13</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/contract.do?action=diaglogFinaContractPage&id=7&op=view'', \r\n			''approval_finan_7'',  \r\n			''查看‘罗佳驹’ 合同申请单-FC20120905135324'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 36, 'ljx', 2, '2012-09-05 13:53:24'),
(175, '[任务完成申请] 任务 “例会” 完成申请待审批', '\r\n<div style="line-height: 25px;">\r\n	<div>任务 “例会” 已提交完成申请, 有待审批.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 王五</div>\r\n	<div><b>任务时间：</b> 2012-09-05 --- 2012-09-06 </div>\r\n	<div><b>申请完成时间：</b> 2012-09-14 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/task.do?action=dialogAuditPage&taskId=31&type=1'', \r\n			''task_applyview_31'',  \r\n			''`例会`任务详情'',\r\n			{width: 555, height: 445})">点击进入到任务完成审批审批窗口</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 13:54:47'),
(176, '[待我审批] ljx 提交的 `转正申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> ljx 提交的 `转正申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-13</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=19&op=view'', \r\n			''approval_hrm_19'',  \r\n			''查看‘ljx’人资申请单-HRM20120905134557'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 13:59:27'),
(177, '[待我审批] 刘苗芳 提交的 `业务招待费` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 刘苗芳 提交的 `业务招待费` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=19&op=view'', \r\n			''approval_finan_19'',  \r\n			''查看‘刘苗芳’ 费用支出申请单-FE20120905145058'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 24, '刘苗芳', 2, '2012-09-05 14:50:58'),
(178, '[待我审批] 刘苗芳 提交的 `其他日常支出` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 刘苗芳 提交的 `其他日常支出` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-06</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=20&op=view'', \r\n			''approval_finan_20'',  \r\n			''查看‘刘苗芳’ 费用支出申请单-FE20120905145138'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 24, '刘苗芳', 2, '2012-09-05 14:51:38'),
(179, '[待我审批] 刘苗芳 提交的 `房租合同` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 刘苗芳 提交的 `房租合同` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-09-05</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/contract.do?action=diaglogFinaContractPage&id=8&op=view'', \r\n			''approval_finan_8'',  \r\n			''查看‘刘苗芳’ 合同申请单-FC20120905145222'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 24, '刘苗芳', 2, '2012-09-05 14:52:22'),
(180, '[任务完成] 任务 “例会” 已完成, 完成时间为: 2012-09-14', '\r\n<div style="line-height: 25px;">\r\n	<div>任务 “例会” 所提交完成申请，审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 王五</div>\r\n	<div><b>任务时间：</b> 2012-09-05 --- 2012-09-06 </div>\r\n	<div><b>申请完成时间：</b> 2012-09-14 </div>\r\n	<div><b>审批人：</b> 王五 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/task.do?action=dialogTaskPage&id=31&op=view'', \r\n			''task_applyview_31'',  \r\n			''`例会`任务详情'',\r\n			{width: 750, height: 530})">点击查看任务完成审批详情</a></div>\r\n</div>', 39, '王五', 2, '2012-09-05 14:57:04'),
(181, '[待我审批] 程聪 提交的 `转正申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 程聪 提交的 `转正申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> 申请实例</div>\r\n	<div><b>申请时间：</b> 2012-10-02</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=20&op=view'', \r\n			''approval_hrm_20'',  \r\n			''查看‘程聪’人资申请单-HRM20120905162914'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 29, '程聪', 2, '2012-09-05 16:29:14'),
(182, '[待我审批] 程聪 提交的 `工资薪金、福利费支出` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 程聪 提交的 `工资薪金、福利费支出` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> 费用申请实例</div>\r\n	<div><b>申请时间：</b> 2012-09-13</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=21&op=view'', \r\n			''approval_finan_21'',  \r\n			''查看‘程聪’ 费用支出申请单-FE20120905163103'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 29, '程聪', 2, '2012-09-05 16:31:03');

-- --------------------------------------------------------

--
-- 資料表格式： `app_message_in`
--

CREATE TABLE IF NOT EXISTS `app_message_in` (
  `receive_id` bigint(20) NOT NULL auto_increment,
  `msg_id` bigint(20) NOT NULL COMMENT '短消息ID',
  `user_id` bigint(20) NOT NULL COMMENT '接收用户ID',
  `user_name` varchar(64) NOT NULL COMMENT '接收用户姓名',
  `flag_read` tinyint(4) NOT NULL default '0' COMMENT '阅读标记, 1=已读, 0=未读',
  `flag_del` tinyint(4) NOT NULL default '0' COMMENT '删除标记, 1=已删, 0=未删',
  `receiv_time` datetime NOT NULL COMMENT '接收时间',
  PRIMARY KEY  (`receive_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='收件箱' AUTO_INCREMENT=369 ;

--
-- 列出以下資料庫的數據： `app_message_in`
--

INSERT INTO `app_message_in` (`receive_id`, `msg_id`, `user_id`, `user_name`, `flag_read`, `flag_del`, `receiv_time`) VALUES
(268, 131, 19, '罗佳驹', 1, 0, '2012-08-31 17:01:32'),
(269, 131, 36, 'ljx', 0, 0, '2012-08-31 17:01:32'),
(270, 132, 19, '罗佳驹', 0, 0, '2012-08-31 17:01:48'),
(271, 133, 19, '罗佳驹', 1, 0, '2012-08-31 17:02:18'),
(272, 133, 36, 'ljx', 0, 0, '2012-08-31 17:02:18'),
(273, 134, 19, '罗佳驹', 0, 0, '2012-08-31 17:02:29'),
(274, 137, 19, '罗佳驹', 0, 0, '2012-09-05 11:32:24'),
(275, 137, 36, 'ljx', 0, 0, '2012-09-05 11:32:24'),
(276, 140, 20, '梅杰', 0, 0, '2012-09-05 11:39:05'),
(277, 141, 24, '刘苗芳', 0, 0, '2012-09-05 11:42:35'),
(278, 142, 21, '林菁菁', 1, 0, '2012-09-05 11:42:42'),
(279, 142, 25, '周碧英', 1, 0, '2012-09-05 11:42:42'),
(280, 142, 26, '蒋晓萍', 0, 0, '2012-09-05 11:42:42'),
(281, 143, 32, '蔡晓喻', 0, 0, '2012-09-05 11:43:26'),
(282, 143, 34, '冯毓', 0, 0, '2012-09-05 11:43:26'),
(283, 144, 21, '林菁菁', 1, 0, '2012-09-05 11:43:32'),
(284, 144, 25, '周碧英', 1, 0, '2012-09-05 11:43:32'),
(285, 144, 26, '蒋晓萍', 0, 0, '2012-09-05 11:43:32'),
(286, 145, 24, '刘苗芳', 0, 0, '2012-09-05 11:43:47'),
(287, 147, 21, '林菁菁', 1, 0, '2012-09-05 11:45:24'),
(288, 147, 25, '周碧英', 0, 0, '2012-09-05 11:45:24'),
(289, 147, 26, '蒋晓萍', 0, 0, '2012-09-05 11:45:24'),
(290, 148, 19, '罗佳驹', 0, 0, '2012-09-05 11:46:39'),
(291, 148, 36, 'ljx', 0, 0, '2012-09-05 11:46:39'),
(292, 149, 38, 'leo', 0, 0, '2012-09-05 11:47:53'),
(293, 150, 38, 'leo', 0, 0, '2012-09-05 11:48:17'),
(294, 151, 19, '罗佳驹', 0, 0, '2012-09-05 11:49:02'),
(295, 151, 36, 'ljx', 1, 0, '2012-09-05 11:49:02'),
(296, 152, 19, '罗佳驹', 0, 0, '2012-09-05 11:50:10'),
(297, 153, 36, 'ljx', 1, 0, '2012-09-05 11:50:36'),
(298, 154, 32, '蔡晓喻', 0, 0, '2012-09-05 11:51:18'),
(299, 154, 19, '罗佳驹', 0, 0, '2012-09-05 11:51:18'),
(300, 154, 36, 'ljx', 1, 0, '2012-09-05 11:51:18'),
(301, 154, 34, '冯毓', 0, 0, '2012-09-05 11:51:18'),
(302, 155, 19, '罗佳驹', 0, 0, '2012-09-05 11:54:50'),
(303, 155, 39, '王五', 1, 0, '2012-09-05 11:54:50'),
(304, 156, 19, '罗佳驹', 0, 0, '2012-09-05 11:55:06'),
(305, 156, 39, '王五', 1, 0, '2012-09-05 11:55:06'),
(306, 157, 39, '王五', 1, 0, '2012-09-05 11:55:28'),
(307, 158, 19, '罗佳驹', 0, 0, '2012-09-05 11:55:41'),
(308, 158, 39, '王五', 1, 0, '2012-09-05 11:55:41'),
(309, 159, 39, '王五', 0, 1, '2012-09-05 11:55:50'),
(310, 160, 39, '王五', 0, 1, '2012-09-05 11:56:32'),
(311, 162, 32, '蔡晓喻', 0, 0, '2012-09-05 13:35:13'),
(312, 162, 19, '罗佳驹', 0, 0, '2012-09-05 13:35:13'),
(313, 162, 36, 'ljx', 1, 0, '2012-09-05 13:35:13'),
(314, 162, 34, '冯毓', 0, 0, '2012-09-05 13:35:13'),
(315, 164, 20, '梅杰', 0, 0, '2012-09-05 13:43:21'),
(316, 165, 27, '杨琪', 0, 0, '2012-09-05 13:44:08'),
(317, 166, 39, '王五', 0, 0, '2012-09-05 13:44:22'),
(318, 167, 39, '王五', 1, 0, '2012-09-05 13:44:38'),
(319, 168, 39, '王五', 1, 0, '2012-09-05 13:44:51'),
(320, 168, 38, 'leo', 0, 0, '2012-09-05 13:44:51'),
(321, 168, 37, '林立', 0, 0, '2012-09-05 13:44:51'),
(322, 168, 19, '罗佳驹', 0, 0, '2012-09-05 13:44:52'),
(323, 168, 24, '刘苗芳', 0, 0, '2012-09-05 13:44:52'),
(324, 168, 25, '周碧英', 0, 0, '2012-09-05 13:44:52'),
(325, 168, 40, '张三', 0, 0, '2012-09-05 13:44:52'),
(326, 168, 22, '许玉凤', 0, 0, '2012-09-05 13:44:52'),
(327, 168, 41, '林锦贤', 0, 0, '2012-09-05 13:44:52'),
(328, 168, 23, '王伟平', 0, 0, '2012-09-05 13:44:52'),
(329, 168, 20, '梅杰', 0, 0, '2012-09-05 13:44:52'),
(330, 168, 21, '林菁菁', 0, 0, '2012-09-05 13:44:52'),
(331, 168, 27, '杨琪', 0, 0, '2012-09-05 13:44:52'),
(332, 168, 26, '蒋晓萍', 0, 0, '2012-09-05 13:44:52'),
(333, 168, 29, '程聪', 0, 0, '2012-09-05 13:44:52'),
(334, 168, 28, '何滨', 0, 0, '2012-09-05 13:44:52'),
(335, 168, 36, 'ljx', 0, 0, '2012-09-05 13:44:52'),
(336, 168, 30, '苏斯翔', 0, 0, '2012-09-05 13:44:52'),
(337, 169, 36, 'ljx', 0, 0, '2012-09-05 13:45:57'),
(338, 170, 36, 'ljx', 0, 0, '2012-09-05 13:46:11'),
(339, 171, 21, '林菁菁', 0, 0, '2012-09-05 13:46:30'),
(340, 171, 26, '蒋晓萍', 0, 0, '2012-09-05 13:46:30'),
(341, 171, 25, '周碧英', 0, 0, '2012-09-05 13:46:30'),
(342, 171, 23, '王伟平', 0, 0, '2012-09-05 13:46:30'),
(343, 172, 24, '刘苗芳', 0, 0, '2012-09-05 13:46:35'),
(344, 172, 38, 'leo', 0, 0, '2012-09-05 13:46:35'),
(345, 172, 29, '程聪', 0, 0, '2012-09-05 13:46:35'),
(346, 174, 20, '梅杰', 0, 0, '2012-09-05 13:53:24'),
(347, 175, 39, '王五', 1, 0, '2012-09-05 13:54:47'),
(348, 176, 36, 'ljx', 0, 0, '2012-09-05 13:59:27'),
(349, 179, 20, '梅杰', 0, 0, '2012-09-05 14:52:22'),
(350, 180, 39, '王五', 1, 0, '2012-09-05 14:57:04'),
(351, 180, 38, 'leo', 0, 0, '2012-09-05 14:57:04'),
(352, 180, 37, '林立', 0, 0, '2012-09-05 14:57:04'),
(353, 180, 19, '罗佳驹', 0, 0, '2012-09-05 14:57:04'),
(354, 180, 24, '刘苗芳', 0, 0, '2012-09-05 14:57:04'),
(355, 180, 25, '周碧英', 0, 0, '2012-09-05 14:57:04'),
(356, 180, 40, '张三', 0, 0, '2012-09-05 14:57:04'),
(357, 180, 22, '许玉凤', 0, 0, '2012-09-05 14:57:04'),
(358, 180, 41, '林锦贤', 0, 0, '2012-09-05 14:57:04'),
(359, 180, 23, '王伟平', 0, 0, '2012-09-05 14:57:04'),
(360, 180, 20, '梅杰', 0, 0, '2012-09-05 14:57:04'),
(361, 180, 21, '林菁菁', 0, 0, '2012-09-05 14:57:04'),
(362, 180, 27, '杨琪', 0, 0, '2012-09-05 14:57:04'),
(363, 180, 26, '蒋晓萍', 0, 0, '2012-09-05 14:57:04'),
(364, 180, 29, '程聪', 0, 0, '2012-09-05 14:57:04'),
(365, 180, 28, '何滨', 0, 0, '2012-09-05 14:57:04'),
(366, 180, 36, 'ljx', 0, 0, '2012-09-05 14:57:04'),
(367, 180, 30, '苏斯翔', 0, 0, '2012-09-05 14:57:04'),
(368, 181, 24, '刘苗芳', 0, 0, '2012-09-05 16:29:14');

-- --------------------------------------------------------

--
-- 資料表格式： `app_process_definition`
--

CREATE TABLE IF NOT EXISTS `app_process_definition` (
  `def_id` bigint(20) NOT NULL auto_increment,
  `type_id` bigint(20) default NULL COMMENT '流程分类ID',
  `def_name` varchar(256) default NULL COMMENT '流程名称',
  `def_description` varchar(250) default NULL COMMENT '流程描述',
  `filter_poset` bigint(20) default NULL COMMENT '过滤职位',
  `def_trigger` varchar(120) default NULL COMMENT '条件',
  `createtime` datetime default NULL COMMENT '创建时间',
  PRIMARY KEY  (`def_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程定义' AUTO_INCREMENT=84 ;

--
-- 列出以下資料庫的數據： `app_process_definition`
--

INSERT INTO `app_process_definition` (`def_id`, `type_id`, `def_name`, `def_description`, `filter_poset`, `def_trigger`, `createtime`) VALUES
(1, 7, '0 < 支出费用 <= 3000', '', 0, 'x > 0 && x <= 3000', '2012-08-28 15:53:07'),
(3, 7, '支出费用 >3000', '', 0, 'x > 3000', '2012-08-28 15:52:51'),
(4, 8, '0 < 合同费用 <= 1000', '', 0, 'x > 0 && x <= 1000', '2012-07-15 14:30:52'),
(5, 8, '1000 < 合同费用 <= 10000', '', 0, 'x > 1000 && x <= 10000', '2012-07-15 21:01:38'),
(6, 3, '转正申请审批-总经理', '转正申请审批-总经理', 1, NULL, '2012-07-26 12:34:00'),
(7, 3, '转正申请审批-总部主管', '转正申请审批-总部主管', 2, NULL, '2012-07-26 12:34:15'),
(8, 3, '转正申请审批-校区主管', '转正申请审批-校区主管', 4, NULL, '2012-07-26 12:35:19'),
(9, 3, '转正申请审批-校区校长', '转正申请审批-校区校长', 3, NULL, '2012-07-26 12:37:52'),
(10, 4, '调动申请审批-总经理(in)', '调动申请审批-总经理(in)', 1, 'x == 0', '2012-07-26 12:38:45'),
(11, 4, '调动申请审批-总经理(out)', '调动申请审批-总经理(out)', 1, 'x == 1', '2012-07-26 12:38:46'),
(12, 4, '调动申请审批-总部主管(in)', '调动申请审批-总部主管(in)', 2, 'x == 0', '2012-07-26 12:45:16'),
(13, 4, '调动申请审批-总部主管(out)', '调动申请审批-总部主管(out)', 2, 'x == 1', '2012-07-26 12:45:16'),
(14, 4, '调动申请审批-校区主管(in)', '调动申请审批-校区主管(in)', 4, 'x == 0', '2012-07-26 12:45:49'),
(15, 4, '调动申请审批-校区主管(out)', '调动申请审批-校区主管(out)', 4, 'x == 1', '2012-07-26 12:45:49'),
(16, 4, '调动申请审批-校区校长(in)', '调动申请审批-校区校长(in)', 3, 'x == 0', '2012-07-26 12:46:28'),
(17, 4, '调动申请审批-校区校长(out)', '调动申请审批-校区校长(out)', 3, 'x == 1', '2012-07-26 12:46:28'),
(18, 8, '合同费用 > 10000', '', NULL, 'x >10000', '2012-07-26 14:41:44'),
(19, 4, '调动申请审批-总部主管职位(in)', '调动申请审批-总部主管职位(in)', 8, 'x == 0', '2012-08-03 16:20:46'),
(20, 4, '调动申请审批-总部主管职位(out)', '调动申请审批-总部主管职位(out)', 8, 'x == 1', '2012-08-03 16:20:46'),
(21, 3, '转正申请审批-基本岗位（总部）', '转正申请审批-基本岗位（总部）', 12, NULL, '2012-08-07 14:44:12'),
(22, 3, '转正申请审批-基本岗位（校区）', '转正申请审批-基本岗位（校区）', 13, NULL, '2012-08-07 14:44:33'),
(23, 3, '转正申请审批-总经办职位', '转正申请审批-总经办职位', 11, NULL, '2012-08-07 14:44:53'),
(24, 3, '转正申请审批-总部主管', '转正申请审批-总部主管', 10, NULL, '2012-08-07 14:45:24'),
(25, 3, '转正申请审批-校区主管（校区）', '转正申请审批-校区主管（校区）', 14, NULL, '2012-08-07 14:46:18'),
(26, 4, '调动申请审批-基本岗位（总部）(in)', '调动申请审批-基本岗位（总部）(in)', 12, 'x == 0', '2012-08-07 14:48:54'),
(27, 4, '调动申请审批-基本岗位（总部）(out)', '调动申请审批-基本岗位（总部）(out)', 12, 'x == 1', '2012-08-07 14:48:54'),
(28, 4, '调动申请审批-基本岗位（校区）(in)', '调动申请审批-基本岗位（校区）(in)', 13, 'x == 0', '2012-08-07 14:49:49'),
(29, 4, '调动申请审批-基本岗位（校区）(out)', '调动申请审批-基本岗位（校区）(out)', 13, 'x == 1', '2012-08-07 14:49:49'),
(30, 4, '调动申请审批-总经办职位(in)', '调动申请审批-总经办职位(in)', 11, 'x == 0', '2012-08-07 14:50:31'),
(31, 4, '调动申请审批-总经办职位(out)', '调动申请审批-总经办职位(out)', 11, 'x == 1', '2012-08-07 14:50:31'),
(32, 4, '调动申请审批-总部主管(in)', '调动申请审批-总部主管(in)', 10, 'x == 0', '2012-08-07 14:51:06'),
(33, 4, '调动申请审批-总部主管(out)', '调动申请审批-总部主管(out)', 10, 'x == 1', '2012-08-07 14:51:06'),
(34, 4, '调动申请审批-校区主管（校区）(in)', '调动申请审批-校区主管（校区）(in)', 14, 'x == 0', '2012-08-07 14:51:52'),
(35, 4, '调动申请审批-校区主管（校区）(out)', '调动申请审批-校区主管（校区）(out)', 14, 'x == 1', '2012-08-07 14:51:52'),
(51, 9, '支出费用 >1200', '', NULL, 'x >1200', '2012-08-28 16:50:32'),
(52, 9, '800 < 支出费用 <= 1200', '', NULL, 'x > 800 && x <= 1200', '2012-08-28 16:50:36'),
(53, 9, '500 < 支出费用 <=800', '', NULL, 'x > 500 && x <= 800', '2012-08-28 16:50:39'),
(54, 9, '0 < 支出费用 <=500', '', NULL, 'x > 0 && x <= 500', '2012-08-28 16:50:42'),
(55, 10, '支出费用 > 3000', '', NULL, 'x >3000', '2012-08-28 16:51:30'),
(56, 10, '2000 < 支出费用 <=3000', '', NULL, 'x>2000 && x<=3000', '2012-08-28 16:52:10'),
(57, 10, '1000 < 支出费用 <=2000', '', NULL, 'x >1000 && x<=2000', '2012-08-28 16:52:41'),
(58, 10, '0 < 支出费用 <=1000', '', NULL, 'x>0 && x<=1000', '2012-08-28 16:53:20'),
(59, 11, '支出费用 >=4000', '', NULL, 'x >=4000', '2012-08-28 17:24:10'),
(60, 11, '3000 < 支出费用 < 4000', '', NULL, 'x >3000 && x <4000', '2012-08-28 17:24:54'),
(61, 11, '2000 < 支出费用 <=3000', '', NULL, 'x > 2000 && x <=3000', '2012-08-28 17:25:30'),
(62, 11, '1000 < 支出费用 <=2000', '', NULL, 'x >1000 && x <=2000', '2012-08-28 17:33:55'),
(63, 11, '0 < 支出费用 <=1000', '', NULL, 'x >0 && x<=1000', '2012-08-28 17:34:26'),
(64, 12, '支出费用 >0', '', NULL, 'x >0', '2012-08-28 17:45:57'),
(65, 13, '支出费用 >2000', '', NULL, 'x >2000', '2012-08-28 17:48:10'),
(66, 13, '1500 < 支出费用 <=2000', '', NULL, 'x >1500 && x<=2000', '2012-08-28 17:48:49'),
(67, 13, '1000 <支出费用 <= 1500', '', NULL, 'x >1000 && x<=1500', '2012-08-28 17:49:22'),
(68, 13, '0< 支出费用 <=1000', '', NULL, 'x >0 && x <=1000', '2012-08-28 17:50:16'),
(69, 5, '晋升申请审批-基本岗位（总部）(in)', '晋升申请审批-基本岗位（总部）(in)', 12, 'x == 0', '2012-08-28 21:04:57'),
(70, 5, '晋升申请审批-基本岗位（总部）(out)', '晋升申请审批-基本岗位（总部）(out)', 12, 'x == 1', '2012-08-28 21:04:57'),
(71, 5, '晋升申请审批-基本岗位（校区）(in)', '晋升申请审批-基本岗位（校区）(in)', 13, 'x == 0', '2012-08-28 21:07:23'),
(72, 5, '晋升申请审批-基本岗位（校区）(out)', '晋升申请审批-基本岗位（校区）(out)', 13, 'x == 1', '2012-08-28 21:07:23'),
(73, 5, '晋升申请审批-总经办职位(in)', '晋升申请审批-总经办职位(in)', 11, 'x == 0', '2012-08-28 21:17:07'),
(74, 5, '晋升申请审批-总经办职位(out)', '晋升申请审批-总经办职位(out)', 11, 'x == 1', '2012-08-28 21:17:07'),
(75, 5, '晋升申请审批-总部主管(in)', '晋升申请审批-总部主管(in)', 10, 'x == 0', '2012-08-28 21:17:46'),
(76, 5, '晋升申请审批-总部主管(out)', '晋升申请审批-总部主管(out)', 10, 'x == 1', '2012-08-28 21:17:46'),
(77, 5, '晋升申请审批-校区主管（校区）(in)', '晋升申请审批-校区主管（校区）(in)', 14, 'x == 0', '2012-08-28 21:19:04'),
(78, 5, '晋升申请审批-校区主管（校区）(out)', '晋升申请审批-校区主管（校区）(out)', 14, 'x == 1', '2012-08-28 21:19:04'),
(79, 6, '离职申请审批-基本岗位（总部）', '离职申请审批-基本岗位（总部）', 12, NULL, '2012-08-28 21:21:11'),
(80, 6, '离职申请审批-基本岗位（校区）', '离职申请审批-基本岗位（校区）', 13, NULL, '2012-08-28 21:22:49'),
(81, 6, '离职申请审批-总经办职位', '离职申请审批-总经办职位', 11, NULL, '2012-08-28 21:23:52'),
(82, 6, '离职申请审批-总部主管', '离职申请审批-总部主管', 10, NULL, '2012-08-28 21:24:10'),
(83, 6, '离职申请审批-校区主管（校区）', '离职申请审批-校区主管（校区）', 14, NULL, '2012-08-28 21:24:37');

-- --------------------------------------------------------

--
-- 資料表格式： `app_process_form`
--

CREATE TABLE IF NOT EXISTS `app_process_form` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=145 ;

--
-- 列出以下資料庫的數據： `app_process_form`
--

INSERT INTO `app_process_form` (`form_id`, `form_no`, `type_id`, `task_name`, `task_from`, `task_next`, `seq_sn`, `task_type`, `to_rolenames`, `to_distnames`, `to_depnames`, `to_posnames`, `to_usernames`, `audit_rolenames`, `audit_distnames`, `audit_depnames`, `audit_usernames`, `audit_posnames`, `to_userids`, `to_roleids`, `to_distids`, `to_depids`, `to_posids`, `audit_userids`, `audit_roleids`, `audit_distids`, `audit_depids`, `audit_posids`, `audit_date`, `audit_state`, `audit_comments`) VALUES
(76, 'FE20120905111834', 13, NULL, NULL, NULL, 1, 1, NULL, NULL, '财务部', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(77, 'FE20120905111834', 13, NULL, NULL, NULL, 1, 2, NULL, NULL, '财务部', '财务', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '25', '38', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(78, 'FE20120905111834', 13, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(79, 'FE20120905112134', 13, NULL, NULL, NULL, 1, 1, NULL, NULL, '财务部', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(80, 'FE20120905112134', 13, NULL, NULL, NULL, 1, 2, NULL, NULL, '财务部', '财务', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '25', '38', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(81, 'FE20120905112134', 13, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(82, 'FE20120905113722', 9, NULL, NULL, NULL, 1, 1, NULL, NULL, '市场部', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(83, 'FE20120905113722', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '财务部', '财务', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '25', '38', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(84, 'FE20120905113722', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(85, 'FE20120905113831', 9, NULL, NULL, NULL, 1, 1, NULL, NULL, '市场部', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(86, 'FE20120905113831', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '财务部', '财务', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '25', '38', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(87, 'FE20120905113831', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(88, 'FE20120905113831', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '行政部', '行政总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '24', '44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(89, 'FE20120905113831', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '财务部', '财务总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '17', '39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(90, 'FE20120905113831', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(91, 'FC20120905113905', 8, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '副总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '13', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(95, 'HRM20120905114326', 5, NULL, NULL, NULL, 1, 2, NULL, NULL, '行政部', '行政主管', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4', '20', '30', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(96, 'HRM20120905114326', 5, NULL, NULL, NULL, 2, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4', '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(97, 'HRM20120905114326', 5, NULL, NULL, NULL, 3, 5, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4', '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(98, 'HRM20120905114326', 5, NULL, NULL, NULL, 4, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4', '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(99, 'HRM20120905114347', 3, NULL, NULL, NULL, 1, 3, NULL, NULL, '市场部', '市场总监', NULL, NULL, '杭州总部', '市场部', '刘苗芳', '市场总监', NULL, NULL, NULL, '16', '14', '24', NULL, '1', '16', '14', '2012-09-05 11:48:16', 4, ''),
(100, 'HRM20120905114347', 3, NULL, NULL, NULL, 1, 4, NULL, NULL, '行政部', '行政总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '24', '44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(101, 'HRM20120905114347', 3, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(102, 'HRM20120905114409', 4, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3', '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(103, 'HRM20120905114409', 4, NULL, NULL, NULL, 2, 5, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3', '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(104, 'HRM20120905114409', 4, NULL, NULL, NULL, 3, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3', '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(105, 'HRM20120905115010', 4, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(106, 'HRM20120905115036', 6, NULL, NULL, NULL, 1, 4, NULL, NULL, '行政部', '行政总监', NULL, NULL, '杭州总部', '行政部', 'ljx', '行政总监', NULL, NULL, NULL, '24', '44', '36', NULL, '1', '24', '44', '2012-09-05 13:44:38', 2, ''),
(107, 'HRM20120905115036', 6, NULL, NULL, NULL, 2, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(108, 'FE20120905120032', 9, NULL, NULL, NULL, 1, 1, NULL, NULL, '人资部', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(109, 'FE20120905120032', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '财务部', '财务', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '25', '38', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(110, 'FE20120905120032', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(111, 'FE20120905120032', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '行政部', '行政总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '24', '44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(112, 'FE20120905120032', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '财务部', '财务总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '17', '39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(113, 'FE20120905134243', 9, NULL, NULL, NULL, 1, 1, NULL, NULL, '总经办', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(114, 'FE20120905134243', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '财务部', '财务', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '25', '38', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(115, 'FE20120905134243', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(116, 'FE20120905134243', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '行政部', '行政总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '24', '44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(117, 'FE20120905134243', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '财务部', '财务总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '17', '39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(118, 'FE20120905134243', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(119, 'FC20120905134321', 8, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '副总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '13', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(120, 'HRM20120905134557', 3, NULL, NULL, NULL, 1, 4, NULL, NULL, '行政部', '行政总监', NULL, NULL, '杭州总部', '行政部', 'ljx', '行政总监', NULL, NULL, NULL, '24', '44', '36', NULL, '1', '24', '44', '2012-09-05 13:46:11', 2, ''),
(121, 'HRM20120905134557', 3, NULL, NULL, NULL, 1, 4, NULL, NULL, '人资部', '人资总监', NULL, NULL, '杭州总部', '人资部', '王五', '人资总监', NULL, NULL, NULL, '26', '46', '39', NULL, '1', '26', '46', '2012-09-05 13:59:27', 2, ''),
(122, 'HRM20120905134557', 3, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(123, 'FE20120905135253', 7, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(124, 'FE20120905135253', 7, NULL, NULL, NULL, 1, 4, NULL, NULL, '人资部', '人资总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '26', '46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(125, 'FE20120905135253', 7, NULL, NULL, NULL, 1, 4, NULL, NULL, '财务部', '财务总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '17', '39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(126, 'FC20120905135324', 8, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '副总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '13', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(127, 'FE20120905145058', 9, NULL, NULL, NULL, 1, 1, NULL, NULL, '市场部', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(128, 'FE20120905145058', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '财务部', '财务', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '25', '38', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(129, 'FE20120905145058', 9, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(130, 'FE20120905145058', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '行政部', '行政总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '24', '44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(131, 'FE20120905145058', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '财务部', '财务总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '17', '39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(132, 'FE20120905145058', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(133, 'FE20120905145138', 13, NULL, NULL, NULL, 1, 1, NULL, NULL, '市场部', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(134, 'FE20120905145138', 13, NULL, NULL, NULL, 1, 2, NULL, NULL, '财务部', '财务', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '25', '38', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(135, 'FE20120905145138', 13, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(136, 'FC20120905145222', 8, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '副总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '13', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(137, 'FC20120905145222', 8, NULL, NULL, NULL, 1, 4, NULL, NULL, '财务部', '财务总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '17', '39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(138, 'HRM20120905162914', 3, NULL, NULL, NULL, 1, 3, NULL, NULL, '市场部', '市场总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '16', '14', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(139, 'HRM20120905162914', 3, NULL, NULL, NULL, 1, 4, NULL, NULL, '行政部', '行政总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '24', '44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(140, 'HRM20120905162914', 3, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(141, 'FE20120905163103', 7, NULL, NULL, NULL, 1, 2, NULL, NULL, '校区办', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '27', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(142, 'FE20120905163103', 7, NULL, NULL, NULL, 1, 4, NULL, NULL, '人资部', '人资总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '26', '46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(143, 'FE20120905163103', 7, NULL, NULL, NULL, 1, 4, NULL, NULL, '财务部', '财务总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '17', '39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(144, 'FE20120905163103', 7, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表格式： `app_process_history`
--

CREATE TABLE IF NOT EXISTS `app_process_history` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=25 ;

--
-- 列出以下資料庫的數據： `app_process_history`
--

INSERT INTO `app_process_history` (`history_id`, `form_no`, `type_id`, `task_name`, `task_from`, `task_next`, `task_type`, `seq_sn`, `to_rolenames`, `to_distnames`, `to_depnames`, `to_posnames`, `to_usernames`, `audit_rolenames`, `audit_distnames`, `audit_depnames`, `audit_usernames`, `audit_posnames`, `to_userids`, `to_roleids`, `to_distids`, `to_depids`, `to_posids`, `audit_userids`, `audit_roleids`, `audit_distids`, `audit_depids`, `audit_posids`, `audit_date`, `audit_state`, `audit_comments`) VALUES
(20, 'HRM20120905114235', 6, NULL, NULL, NULL, 3, NULL, NULL, NULL, '市场部', '市场总监', NULL, NULL, '杭州总部', '市场部', '刘苗芳', '市场总监', NULL, NULL, NULL, '16', '14', '24', NULL, '1', '16', '14', '2012-09-05 11:47:53', 3, ''),
(21, 'HRM20120905114347', 3, NULL, NULL, NULL, 3, NULL, NULL, NULL, '市场部', '市场总监', NULL, NULL, '杭州总部', '市场部', '刘苗芳', '市场总监', NULL, NULL, NULL, '16', '14', '24', NULL, '1', '16', '14', '2012-09-05 11:48:16', 4, ''),
(22, 'HRM20120905115036', 6, NULL, NULL, NULL, 4, NULL, NULL, NULL, '行政部', '行政总监', NULL, NULL, '杭州总部', '行政部', 'ljx', '行政总监', NULL, NULL, NULL, '24', '44', '36', NULL, '1', '24', '44', '2012-09-05 13:44:38', 2, ''),
(23, 'HRM20120905134557', 3, NULL, NULL, NULL, 4, NULL, NULL, NULL, '行政部', '行政总监', NULL, NULL, '杭州总部', '行政部', 'ljx', '行政总监', NULL, NULL, NULL, '24', '44', '36', NULL, '1', '24', '44', '2012-09-05 13:46:11', 2, ''),
(24, 'HRM20120905134557', 3, NULL, NULL, NULL, 4, NULL, NULL, NULL, '人资部', '人资总监', NULL, NULL, '杭州总部', '人资部', '王五', '人资总监', NULL, NULL, NULL, '26', '46', '39', NULL, '1', '26', '46', '2012-09-05 13:59:27', 2, '');

-- --------------------------------------------------------

--
-- 資料表格式： `app_process_task`
--

CREATE TABLE IF NOT EXISTS `app_process_task` (
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
  KEY `def_id` (`def_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程任务设置' AUTO_INCREMENT=213 ;

--
-- 列出以下資料庫的數據： `app_process_task`
--

INSERT INTO `app_process_task` (`task_id`, `def_id`, `task_name`, `task_from`, `task_next`, `seq_sn`, `to_rolenames`, `to_depnames`, `to_posnames`, `to_usernames`, `to_userids`, `to_roleids`, `to_depids`, `to_posids`, `comments`, `task_type`) VALUES
(1, 18, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(2, 5, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(3, 4, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(4, 19, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(6, 20, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(7, 21, NULL, NULL, NULL, 1, NULL, '发展部,人资部,教研部,行政部,运营部,总经办,市场部,财务部', '财务总监,总经理,市场总监,发展总监,人资总监,教务总监,运营总监,行政总监', NULL, NULL, NULL, '26,27,22,23,24,15,17,16', '49,46,42,40,44,39,14,26', NULL, 3),
(8, 22, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(9, 23, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(10, 24, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(11, 24, NULL, NULL, NULL, 1, NULL, '人资部', '人资总监', NULL, NULL, NULL, '26', '46', NULL, 4),
(12, 25, NULL, NULL, NULL, 1, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(13, 26, NULL, NULL, NULL, 1, NULL, '发展部,人资部,教研部,行政部,运营部,总经办,市场部,财务部', '财务总监,总经理,市场总监,发展总监,人资总监,教务总监,运营总监,行政总监', NULL, NULL, NULL, '26,27,22,23,24,15,17,16', '49,46,42,40,44,39,14,26', NULL, 3),
(14, 27, NULL, NULL, NULL, 1, NULL, '发展部,人资部,教研部,行政部,运营部,总经办,市场部,财务部', '财务总监,总经理,市场总监,发展总监,人资总监,教务总监,运营总监,行政总监', NULL, NULL, NULL, '26,27,22,23,24,15,17,16', '49,46,42,40,44,39,14,26', NULL, 3),
(17, 29, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(18, 30, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(19, 31, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(20, 32, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(23, 34, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(41, 3, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(42, 3, NULL, NULL, NULL, 1, NULL, '人资部', '人资总监', NULL, NULL, NULL, '26', '46', NULL, 4),
(44, 1, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(45, 53, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(46, 52, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(47, 51, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(48, 51, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(49, 18, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(50, 21, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(51, 21, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(52, 1, NULL, NULL, NULL, 1, NULL, '人资部', '人资总监', NULL, NULL, NULL, '26', '46', NULL, 4),
(53, 1, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(54, 3, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(55, 3, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(56, 54, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(57, 54, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(58, 54, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(59, 53, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(60, 53, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(61, 53, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(62, 52, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(63, 52, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(64, 52, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(65, 52, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(66, 51, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(67, 51, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(68, 51, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(69, 51, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(70, 58, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(71, 58, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(72, 58, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(73, 57, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(74, 57, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(75, 57, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(76, 57, NULL, NULL, NULL, 1, NULL, '发展部', '发展总监', NULL, NULL, NULL, '27', '49', NULL, 4),
(77, 56, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(78, 56, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(79, 56, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(80, 56, NULL, NULL, NULL, 1, NULL, '发展部', '发展总监', NULL, NULL, NULL, '27', '49', NULL, 4),
(81, 56, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(82, 55, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(83, 55, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(84, 55, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(85, 55, NULL, NULL, NULL, 1, NULL, '发展部', '发展总监', NULL, NULL, NULL, '27', '49', NULL, 4),
(86, 55, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(87, 55, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(88, 63, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(89, 63, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(90, 63, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(91, 62, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(92, 62, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(93, 62, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(94, 62, NULL, NULL, NULL, 1, NULL, '发展部', '区长', NULL, NULL, NULL, '27', '53', NULL, 4),
(95, 61, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(96, 61, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(97, 61, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(98, 61, NULL, NULL, NULL, 1, NULL, '发展部', '区长', NULL, NULL, NULL, '27', '53', NULL, 4),
(99, 61, NULL, NULL, NULL, 1, NULL, '市场部', '市场总监', NULL, NULL, NULL, '16', '14', NULL, 4),
(100, 60, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(101, 60, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(102, 60, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(103, 60, NULL, NULL, NULL, 1, NULL, '发展部', '区长', NULL, NULL, NULL, '27', '53', NULL, 4),
(104, 60, NULL, NULL, NULL, 1, NULL, '市场部', '市场总监', NULL, NULL, NULL, '16', '14', NULL, 4),
(105, 60, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(106, 59, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(107, 59, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(108, 59, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(109, 59, NULL, NULL, NULL, 1, NULL, '发展部', '区长', NULL, NULL, NULL, '27', '53', NULL, 4),
(110, 59, NULL, NULL, NULL, 1, NULL, '市场部', '市场总监', NULL, NULL, NULL, '16', '14', NULL, 4),
(111, 59, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(112, 59, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(113, 64, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(114, 64, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(115, 64, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(116, 64, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(117, 68, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(118, 68, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(119, 68, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(120, 67, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(121, 67, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(122, 67, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(123, 67, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(124, 66, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(125, 66, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(126, 66, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(127, 66, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(128, 66, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(129, 65, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(130, 65, NULL, NULL, NULL, 1, NULL, '财务部', '财务', NULL, NULL, NULL, '25', '38', NULL, 2),
(131, 65, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(132, 65, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(133, 65, NULL, NULL, NULL, 1, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(134, 65, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(135, 22, NULL, NULL, NULL, 1, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(136, 22, NULL, NULL, NULL, 1, NULL, '发展部,人资部,教研部,行政部,运营部,总经办,市场部,财务部', '财务总监,总经理,市场总监,发展总监,人资总监,教务总监,运营总监,行政总监', NULL, NULL, NULL, '26,27,22,23,24,15,17,16', '49,46,42,40,44,39,14,26', NULL, 3),
(137, 22, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(138, 24, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(139, 25, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(140, 25, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(141, 25, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(142, 26, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(143, 26, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(144, 27, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(153, 27, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(154, 27, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(155, 28, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(156, 28, NULL, NULL, NULL, 1, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(157, 28, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(158, 29, NULL, NULL, NULL, 1, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(159, 29, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(160, 29, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(161, 29, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(162, 32, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(163, 33, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(165, 33, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(166, 33, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(167, 35, NULL, NULL, NULL, 1, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(168, 35, NULL, NULL, NULL, 2, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(169, 35, NULL, NULL, NULL, 3, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(170, 69, NULL, NULL, NULL, 1, NULL, '发展部,人资部,教研部,行政部,运营部,总经办,市场部,财务部', '财务总监,总经理,市场总监,发展总监,人资总监,教务总监,运营总监,行政总监', NULL, NULL, NULL, '26,27,22,23,24,15,17,16', '49,46,42,40,44,39,14,26', NULL, 3),
(171, 69, NULL, NULL, NULL, 2, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(172, 69, NULL, NULL, NULL, 3, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(173, 70, NULL, NULL, NULL, 1, NULL, '发展部,人资部,教研部,行政部,运营部,总经办,市场部,财务部', '财务总监,总经理,市场总监,发展总监,人资总监,教务总监,运营总监,行政总监', NULL, NULL, NULL, '26,27,22,23,24,15,17,16', '49,46,42,40,44,39,14,26', NULL, 3),
(174, 70, NULL, NULL, NULL, 2, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(175, 70, NULL, NULL, NULL, 3, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(176, 70, NULL, NULL, NULL, 4, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(177, 71, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(178, 71, NULL, NULL, NULL, 2, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(179, 71, NULL, NULL, NULL, 3, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(180, 72, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(181, 72, NULL, NULL, NULL, 2, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(182, 72, NULL, NULL, NULL, 3, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(184, 72, NULL, NULL, NULL, 4, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(185, 72, NULL, NULL, NULL, 5, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(186, 73, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(187, 74, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(188, 75, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(189, 75, NULL, NULL, NULL, 2, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(190, 76, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(191, 76, NULL, NULL, NULL, 2, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(192, 76, NULL, NULL, NULL, 3, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(193, 77, NULL, NULL, NULL, 1, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(194, 77, NULL, NULL, NULL, 2, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(195, 78, NULL, NULL, NULL, 1, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(196, 78, NULL, NULL, NULL, 2, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(197, 78, NULL, NULL, NULL, 3, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(198, 78, NULL, NULL, NULL, 4, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(199, 79, NULL, NULL, NULL, 1, NULL, '发展部,人资部,教研部,行政部,运营部,总经办,市场部,财务部', '财务总监,总经理,市场总监,发展总监,人资总监,教务总监,运营总监,行政总监', NULL, NULL, NULL, '26,27,22,23,24,15,17,16', '49,46,42,40,44,39,14,26', NULL, 3),
(200, 79, NULL, NULL, NULL, 2, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(201, 79, NULL, NULL, NULL, 3, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(202, 80, NULL, NULL, NULL, 1, NULL, '校区办,教务部,财务部,咨询部,行政部', '咨询主管,行政主管,校长,教务主管,财务', NULL, NULL, NULL, '19,18,25,20,21', '30,54,27,38,33', NULL, 1),
(203, 80, NULL, NULL, NULL, 2, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(204, 80, NULL, NULL, NULL, 3, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(205, 80, NULL, NULL, NULL, 4, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(206, 81, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(207, 82, NULL, NULL, NULL, 1, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(208, 82, NULL, NULL, NULL, 2, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(209, 83, NULL, NULL, NULL, 1, NULL, '行政部', '行政主管', NULL, NULL, NULL, '20', '30', NULL, 2),
(210, 83, NULL, NULL, NULL, 2, NULL, '校区办', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(211, 83, NULL, NULL, NULL, 3, NULL, '行政部', '行政总监', NULL, NULL, NULL, '24', '44', NULL, 4),
(212, 83, NULL, NULL, NULL, 4, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4);

-- --------------------------------------------------------

--
-- 資料表格式： `app_process_type`
--

CREATE TABLE IF NOT EXISTS `app_process_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '流程分类名',
  `type_key` varchar(64) default NULL COMMENT '流程分类KEY',
  `type_desc` varchar(250) default NULL COMMENT '流程分类描述',
  `type_slug` varchar(64) NOT NULL COMMENT '分类类别',
  `type_parent` bigint(20) default NULL COMMENT '流程父分类',
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程分类' AUTO_INCREMENT=16 ;

--
-- 列出以下資料庫的數據： `app_process_type`
--

INSERT INTO `app_process_type` (`type_id`, `type_name`, `type_key`, `type_desc`, `type_slug`, `type_parent`) VALUES
(1, '费用支出申请审批', 'PROCESS_PAYMENT', NULL, 'finance', NULL),
(2, '合同申请审批', 'PROCESS_CONTRACT', NULL, 'finance', NULL),
(3, '转正申请审批', 'PROCESS_MEMBER_BERGULAR', NULL, 'hrm', NULL),
(4, '调动申请审批', 'PROCESS_MEMBER_TRANSFER', NULL, 'hrm', NULL),
(5, '晋升申请审批', 'PROCESS_MEMBER_PROMOTION', NULL, 'hrm', NULL),
(6, '离职申请审批', 'PROCESS_MEMBER_FAIRWELL', NULL, 'hrm', NULL),
(7, '工资薪金、福利费支出', 'PROCESS_SALARY_PAYMENT', '非常规性工资支出、发放福利（包括咨询部奖金）应审批', 'finance', 1),
(8, '房租合同', 'PROCESS_HOUSE_RENT', '房租合同', 'finance', 2),
(9, '业务招待费', 'PROCESS_ENTERTAINMENT_CHARGES', '用于业务及相关活动的应酬费用，如餐费、礼品费等', 'finance', 1),
(10, '场地租赁、装修、办公家具设备采购支出', 'PROCESS_HOUSE_RENT', '场地租赁、装修、办公家具采购、办公设备采购支出', 'finance', 1),
(11, '市场、广告费用', 'PROCESS_ADVERTISE_PAYMENT', '', 'finance', 1),
(12, '办公用品、日用品支出', 'PROCESS_OFFICE_SUPPLIES', '', 'finance', 1),
(13, '其他日常支出', 'PROCESS_OTHERS_PAYMENT', '', 'finance', 1),
(14, '新项目-高考志愿填报咨询', 'PROCESS_GAOKAO_CONSULT', '', 'finance', 1),
(15, '新项目申请审批', 'PROCESS_PROJECT', NULL, 'finance', NULL);

-- --------------------------------------------------------

--
-- 資料表格式： `app_role`
--

CREATE TABLE IF NOT EXISTS `app_role` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='角色表' AUTO_INCREMENT=74 ;

--
-- 列出以下資料庫的數據： `app_role`
--

INSERT INTO `app_role` (`role_id`, `role_name`, `role_key`, `role_desc`, `role_status`, `role_rights`, `role_type`, `role_edit`) VALUES
(7, '基础权限（总部）', 'ROLE_EMPLOYEE_HEADOFFICE', '基础权限（总部）', 1, '_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_PERSONAL_APPLICATION_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_ADMIN_PASSWORD_CHANGE,_FUNCKEY_PERSONAL_APPLICATION_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD', 0, 1),
(8, '基础权限(校区)', 'ROLE_EMPLOYEE_SCHOOL', '基础权限(校区)', 1, '_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD', 1, 1),
(9, '管理员', 'ROLE_ADMIN', '', 1, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_MYVIEW_DATA_LOAD,_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_TASK_MYVIEW,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_PERSONAL_APPROVAL_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT,_FUNCKEY_ADMIN_TASK_DATA_LOAD,_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,_FUNCKEY_ADMIN_ATTENDANCE_DATA_LOAD,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_DATA_LOAD,_FUNCKEY_ADMIN_DOC_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_DATA_LOAD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE,_FUNCKEY_HRM_ENTRY_OP_QUALIFY,_FUNCKEY_HRM_EMPLOYEE_REMOVE,_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_EMPLOYEE_ADD,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_DATA_LOAD,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET,_FUNCKEY_SYSTEM_DELETE_DICTIONARY,_FUNCKEY_SYSTEM_ADD_DICTIONARY,_FUNCKEY_SYSTEM_EDIT_DICTIONARY,_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE,_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD,_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT,_FUNCKEY_SYSTEM_DELETE_WORK_TIME,_FUNCKEY_SYSTEM_ADD_WORK_CONTENT,_FUNCKEY_SYSTEM_ADD_WORK_TIME,_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT,_FUNCKEY_SYSTEM_EDIT_WORK_TIME,_FUNCKEY_FLOW_HRM_PROCESS_REMOVE,_FUNCKEY_FLOW_HRM_PROCESS_REFRESH,_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE,_FUNCKEY_FLOW_HRM_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_APPROVE,_FUNCKEY_FLOW_FINAN_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REMOVE,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_ADD,_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_ADD,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_EDIT,_FUNCKEY_SYSTEM_SCHOOL_POSET_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_POSET_ADD,_FUNCKEY_SYSTEM_SCHOOL_POSET_EDIT,_FUNCKEY_SYSTEM_ROLE_REMOVE,_FUNCKEY_SYSTEM_ROLE_VIEW,_FUNCKEY_SYSTEM_ROLE_ADD,_FUNCKEY_SYSTEM_ROLE_EDIT,_FUNCKEY_SYSTEM_MENU_FUNC_REMOVE,_FUNCKEY_SYSTEM_MENU_FUNC_REFRESH,_FUNCKEY_SYSTEM_MENU_FUNC_ADD,_FUNCKEY_SYSTEM_MENU_FUNC_EDIT,_FUNCKEY_SYSTEM_MENU_REFRESH,_FUNCKEY_SYSTEM_MENU_ADD,_FUNCKEY_SYSTEM_MENU_EDIT,', 0, 1),
(14, '校区管理员', 'ROLE_SCHOOL_ADMIN', '', 1, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_MYVIEW,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT,_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE,_FUNCKEY_HRM_ENTRY_OP_QUALIFY,_FUNCKEY_HRM_EMPLOYEE_REMOVE,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_EMPLOYEE_ADD,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET,_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE,_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD,_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT,_FUNCKEY_SYSTEM_DELETE_WORK_TIME,_FUNCKEY_SYSTEM_ADD_WORK_CONTENT,_FUNCKEY_SYSTEM_ADD_WORK_TIME,_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT,_FUNCKEY_SYSTEM_EDIT_WORK_TIME', 1, 1),
(22, '新闻发布与管理（总部）', 'ROLE_ADMIN_NEWS_PUBLISH', '新闻发布与管理（总部）', 1, '_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_EDIT,', 0, 1),
(23, '新闻审批与管理（总部）', 'ROLE_ADMIN_NEWS_APPROVE', '', 1, '_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD', 0, 1),
(24, '新闻查看(查看)', 'ROLE_PERSONAL_NEWS_READ', '', 1, '_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,', 0, 1),
(26, '任务审批与管理（总部）', 'ROLE_ADMIN_TASK_APPROVE', '对发起的任务是否通过进行审批', 1, '_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT,', 0, 1),
(27, '任务发起与管理（总部）', 'ROLE_PERSONAL_TASK_PUBLISH', '', 1, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_MYVIEW,', 0, 1),
(28, '任务查看', 'ROLE_PERSONAL_TASK_READ', '查看用户所负责或参与的任务', 1, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_VIEW,', 0, 1),
(29, '工作安排添加导入', 'ROLE_ADMIN_WORKPLAN_ADD', '', 1, '_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE', 0, 1),
(30, '工作安排调整', 'ROLE_ADMIN_WORKPLAN_ADJUST', '工作安排调整、编辑、删除', 1, '_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,', 0, 1),
(31, '工作安排查看', 'ROLE_ADMIN_WORKPLAN_READ', '工作安排查看', 1, '_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE', 0, 1),
(32, '员工考勤操作', 'ROLE_ADMIN_ATTENDANCE_MANAGE', '员工考勤的打卡、出差、请假、旷工等操作', 1, '_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,_FUNCKEY_ADMIN_ATTENDANCE_DATA_LOAD,', 0, 1),
(33, '文档上传与管理', 'ROLE_ADMIN_DOC_UPLOAD', '', 1, '_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_EDIT,_FUNCKEY_ADMIN_DOC_DATA_LOAD', 0, 1),
(34, '文档查看下载', 'ROLE_PERSONAL_DOC_DOWNLOAD', '', 1, '_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,', 0, 1),
(35, '会议发起与管理', 'ROLE_PERSONAL_CONFERENCE_MANAGE', '会议发起、调整、取消、激活', 1, '_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE', 0, 1),
(36, '会议总结', 'ROLE_PERSONAL_CONFERENCE_SUMMARY', '会议总结', 1, '_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,', 0, 1),
(37, '会议查看', 'ROLE_PERSONAL_CONFERENCE_READ', '查看所参加的会议', 1, '_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,', 0, 1),
(38, '岗位管理-发布岗位', 'ROLE_ADMIN_HRM_JOB_PUBLISH', '发布岗位', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW', 0, 1),
(39, '岗位管理-发布审批', 'ROLE_ADMIN_HRM_JOB_APPROVE', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_JOBAPPROVAL_ROOT,_FUNCKEY_JOBAPPROVAL_SUBNODE,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW', 0, 1),
(41, '岗位管理-管理权限', 'ROLE_ADMIN_HRM_JOB_MANAGE', '岗位编辑、应聘控制', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW', 0, 1),
(42, '入职安排-信息查看', 'ROLE_ADMIN_HRM_ONBOARD_REVIEW', '简历查看、面试查看', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,', 0, 1),
(43, '入职安排-入职安排', 'ROLE_ADMIN_HRM_ONBOARD', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,', 0, 1),
(44, '招聘安排-页面查看', 'ROLE_ADMIN_HRM_RECRUIT_REVIEW', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,', 0, 1),
(45, '招聘安排-招聘安排', 'ROLE_ADMIN_HRM_RECRUITING', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER', 0, 1),
(46, '招聘安排-录用淘汰', 'ROLE_ADMIN_HRM_RECRUIT_RESULT', '录用、淘汰、未到操作', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,', 0, 1),
(48, '公司人才库-删除', 'ROLE_ADMIN_HRM_ARCHIVE_RESUME_REMOVE', '', 1, '_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE,', 0, 1),
(49, '公司人才库-查看', 'ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW', '', 1, '_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW', 0, 1),
(50, '招聘入职-入职处理', 'ROLE_ADMIN_HRM_ENTRY_OP_ONBOARD', '', 1, '_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE,', 0, 1),
(51, '招聘入职-考察处理', 'ROLE_ADMIN_HRM_ENTRY_OP_QUALIFY', '', 1, '_FUNCKEY_HRM_ENTRY_OP_QUALIFY', 0, 1),
(52, '员工档案-添加', 'ROLE_ADMIN_HRM_EMPLOYEE_ADD', '', 1, '_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_ADD,', 0, 1),
(53, '员工档案-删除', 'ROLE_ADMIN_HRM_EMPLOYEE_DELETE', '', 1, '_FUNCKEY_HRM_EMPLOYEE_REMOVE,', 0, 1),
(54, '员工档案-查看', 'ROLE_ADMIN_HRM_EMPLOYEE_VIEW', '', 1, '_FUNCKEY_HRM_EMPLOYEE_VIEW,', 0, 1),
(55, '人力发展-审批', 'ROLE_ADMIN_HRM_DEVELOP_APPROVE', '流程审批', 1, '_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_APPROVE,', 0, 1),
(56, '人力发展-审批记录查看', 'ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA', '', 1, '_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,', 0, 1),
(57, '人力发展-落实操作', 'ROLE_ADMIN_HRM_DEVELOP_FINALIZE', '主要是针对员工, 转正、晋升、离职、调动等状态转换操作.', 1, '_FUNCKEY_HRM_DEVELOP_FINALIZE,', 0, 1),
(58, '财务-费用支出申请', 'ROLE_ADMIN_FINAN_EXPENSE_APPLY', '', 1, '_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,', 0, 1),
(59, '财务-费用支出审核', 'ROLE_ADMIN_FINAN_EXPENSE_APPROVE', '', 1, '_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW', 0, 1),
(60, '财务-合同申请', 'ROLE_ADMIN_FINAN_CONTRACT_APPLY', '', 1, '_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW', 0, 1),
(61, '财务-合同审批', 'ROLE_ADMIN_FINAN_CONTRACT_APPROVE', '', 1, '_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,', 0, 1),
(62, '用户管理', 'ROLE_ADMIN_ACCOUNT_MANAGE', '', 1, '_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET,_FUNCKEY_ADMIN_ACCOUNT_DATA_LOAD', 0, 1),
(63, '系统日志', 'ROLE_ADMIN_SYSTEM_LOG', '', 1, '_FUNCKEY_ADMIN_SYSLOG_VIEW,', 0, 1),
(64, '系统设置', 'ROLE_ADMIN_SYSTEM_MANAGE', '', 1, '_FUNCKEY_SYSTEM_DELETE_DICTIONARY,_FUNCKEY_SYSTEM_ADD_DICTIONARY,_FUNCKEY_SYSTEM_EDIT_DICTIONARY,_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE,_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD,_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT,_FUNCKEY_SYSTEM_DELETE_WORK_TIME,_FUNCKEY_SYSTEM_ADD_WORK_CONTENT,_FUNCKEY_SYSTEM_ADD_WORK_TIME,_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT,_FUNCKEY_SYSTEM_EDIT_WORK_TIME,_FUNCKEY_FLOW_HRM_PROCESS_REMOVE,_FUNCKEY_FLOW_HRM_PROCESS_REFRESH,_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE,_FUNCKEY_FLOW_HRM_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_APPROVE,_FUNCKEY_FLOW_FINAN_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REMOVE,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_ADD,_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_ADD,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_EDIT,_FUNCKEY_SYSTEM_SCHOOL_POSET_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_POSET_ADD,_FUNCKEY_SYSTEM_SCHOOL_POSET_EDIT,_FUNCKEY_SYSTEM_ROLE_REMOVE,_FUNCKEY_SYSTEM_ROLE_VIEW,_FUNCKEY_SYSTEM_ROLE_ADD,_FUNCKEY_SYSTEM_ROLE_EDIT,_FUNCKEY_SYSTEM_MENU_FUNC_REMOVE,_FUNCKEY_SYSTEM_MENU_FUNC_REFRESH,_FUNCKEY_SYSTEM_MENU_FUNC_ADD,_FUNCKEY_SYSTEM_MENU_FUNC_EDIT,_FUNCKEY_SYSTEM_MENU_REFRESH,_FUNCKEY_SYSTEM_MENU_ADD,_FUNCKEY_SYSTEM_MENU_EDIT,', 0, 1),
(67, '测试账号', 'ROLE_TEST', '', 1, '_FUNCKEY_ADMIN_PASSWORD_CHANGE,', 0, 1),
(68, '校区办管理权限', 'ROLE_SCHOOL_HEADMASTER', '', 1, '_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_PERSONAL_APPROVAL_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_DATA_LOAD,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_DATA_LOAD,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_DOC_DATA_LOAD,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_ADMIN_ACCOUNT_DATA_LOAD', 1, 1),
(69, '校区行政管理权限', 'ROLE_SCHOOL_CLERICAL_MANAGE', '', 1, '_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,_FUNCKEY_ADMIN_ATTENDANCE_DATA_LOAD,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_DATA_LOAD,_FUNCKEY_ADMIN_DOC_EDIT,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_ATTENDANCE_DATA_LOAD,_FUNCKEY_ADMIN_DOC_DATA_LOAD', 1, 1),
(70, '校区财务管理权限', 'ROLE_SCHOOL_FINANCE_MANAGE', '', 1, '_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD', 1, 1),
(71, '校区人资管理权限', 'ROLE_SCHOOL_HR_MANAGE', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_JOBAPPROVAL_SUBNODE,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_DATA_LOAD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE,_FUNCKEY_HRM_ENTRY_OP_QUALIFY,_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_EMPLOYEE_ADD,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_ENTRY_DATA_LOAD,_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD', 1, 1),
(72, '片区办管理权限', 'ROLE_AREA_MANAGE', '', 1, '_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_MYVIEW_DATA_LOAD,_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_PERSONAL_APPROVAL_DATA_LOAD,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,', 2, 1),
(73, '基础审批权限', 'ROLE_BASIC_APPROVE', '面试等基础审批权限', 1, '_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,', 0, 1);

-- --------------------------------------------------------

--
-- 資料表格式： `app_role_dac`
--

CREATE TABLE IF NOT EXISTS `app_role_dac` (
  `role_id` bigint(20) NOT NULL,
  `stg_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`role_id`,`stg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限组的数据权限';

--
-- 列出以下資料庫的數據： `app_role_dac`
--

INSERT INTO `app_role_dac` (`role_id`, `stg_id`) VALUES
(7, 47),
(7, 48),
(7, 49),
(7, 50),
(7, 101),
(7, 144),
(7, 151),
(8, 47),
(8, 48),
(8, 49),
(8, 50),
(8, 101),
(9, 23),
(9, 24),
(9, 25),
(9, 26),
(9, 35),
(9, 36),
(9, 37),
(9, 38),
(9, 47),
(9, 48),
(9, 49),
(9, 50),
(9, 55),
(9, 56),
(9, 57),
(9, 58),
(9, 63),
(9, 64),
(9, 65),
(9, 66),
(9, 67),
(9, 68),
(9, 69),
(9, 70),
(9, 71),
(9, 72),
(9, 73),
(9, 74),
(9, 75),
(9, 76),
(9, 77),
(9, 78),
(9, 79),
(9, 80),
(9, 81),
(9, 82),
(9, 83),
(9, 84),
(9, 85),
(9, 86),
(9, 87),
(9, 88),
(9, 89),
(9, 90),
(9, 95),
(9, 96),
(9, 97),
(9, 98),
(9, 99),
(9, 100),
(9, 101),
(9, 102),
(9, 103),
(9, 104),
(9, 105),
(9, 106),
(9, 107),
(9, 108),
(9, 109),
(9, 110),
(9, 127),
(9, 128),
(9, 129),
(9, 130),
(9, 135),
(9, 136),
(9, 137),
(9, 138),
(9, 139),
(9, 140),
(9, 141),
(9, 142),
(9, 143),
(23, 107),
(23, 108),
(23, 109),
(32, 71),
(32, 72),
(32, 73),
(32, 74),
(32, 75),
(32, 76),
(32, 77),
(32, 78),
(33, 79),
(33, 80),
(33, 81),
(35, 68),
(38, 83),
(39, 83),
(39, 85),
(39, 86),
(41, 83),
(41, 85),
(41, 86),
(62, 128),
(62, 129),
(62, 130),
(68, 23),
(68, 24),
(68, 25),
(68, 26),
(68, 47),
(68, 48),
(68, 49),
(68, 50),
(68, 63),
(68, 64),
(68, 65),
(68, 66),
(68, 67),
(68, 68),
(68, 69),
(68, 71),
(68, 73),
(68, 74),
(68, 79),
(68, 80),
(68, 81),
(68, 83),
(68, 85),
(68, 86),
(68, 95),
(68, 96),
(68, 98),
(68, 99),
(68, 101),
(68, 102),
(68, 107),
(68, 108),
(68, 109),
(68, 128),
(68, 129),
(68, 130),
(69, 71),
(69, 73),
(69, 74),
(69, 75),
(69, 76),
(69, 77),
(69, 79),
(69, 80),
(69, 81),
(69, 107),
(69, 108),
(69, 109),
(69, 152),
(69, 154),
(69, 155),
(70, 99),
(70, 101),
(70, 102),
(70, 149),
(70, 150),
(70, 151),
(71, 83),
(71, 85),
(71, 86),
(71, 87),
(71, 88),
(71, 89),
(71, 95),
(71, 96),
(71, 98),
(72, 23),
(72, 24),
(72, 25),
(72, 26),
(72, 35),
(72, 36),
(72, 37),
(72, 38),
(72, 47),
(72, 48),
(72, 49),
(72, 50),
(72, 63),
(72, 64),
(72, 65),
(72, 66),
(72, 67),
(72, 68),
(72, 69),
(72, 70),
(72, 83),
(72, 84),
(72, 85),
(72, 86),
(72, 99),
(72, 100),
(72, 101),
(72, 102);

-- --------------------------------------------------------

--
-- 資料表格式： `app_role_func`
--

CREATE TABLE IF NOT EXISTS `app_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`role_id`,`func_id`),
  KEY `role_id` (`role_id`),
  KEY `app_role_func_ibfk_2` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

--
-- 列出以下資料庫的數據： `app_role_func`
--

INSERT INTO `app_role_func` (`role_id`, `func_id`) VALUES
(7, 32),
(7, 33),
(7, 35),
(7, 36),
(7, 73),
(7, 78),
(7, 88),
(7, 89),
(7, 90),
(7, 91),
(7, 98),
(7, 99),
(7, 106),
(7, 143),
(7, 144),
(7, 145),
(7, 154),
(7, 155),
(7, 160),
(7, 161),
(8, 32),
(8, 33),
(8, 35),
(8, 36),
(8, 37),
(8, 73),
(8, 78),
(8, 88),
(8, 89),
(8, 90),
(8, 91),
(8, 98),
(8, 99),
(8, 106),
(8, 143),
(8, 144),
(8, 145),
(8, 154),
(8, 155),
(9, 5),
(9, 6),
(9, 7),
(9, 8),
(9, 9),
(9, 10),
(9, 11),
(9, 12),
(9, 13),
(9, 14),
(9, 15),
(9, 16),
(9, 17),
(9, 18),
(9, 19),
(9, 20),
(9, 21),
(9, 22),
(9, 23),
(9, 24),
(9, 25),
(9, 26),
(9, 27),
(9, 28),
(9, 29),
(9, 30),
(9, 31),
(9, 32),
(9, 33),
(9, 34),
(9, 35),
(9, 36),
(9, 37),
(9, 38),
(9, 39),
(9, 40),
(9, 41),
(9, 42),
(9, 43),
(9, 44),
(9, 45),
(9, 46),
(9, 47),
(9, 48),
(9, 49),
(9, 50),
(9, 51),
(9, 52),
(9, 53),
(9, 54),
(9, 55),
(9, 56),
(9, 57),
(9, 58),
(9, 59),
(9, 60),
(9, 61),
(9, 62),
(9, 63),
(9, 64),
(9, 65),
(9, 66),
(9, 67),
(9, 68),
(9, 69),
(9, 70),
(9, 71),
(9, 72),
(9, 73),
(9, 74),
(9, 75),
(9, 76),
(9, 77),
(9, 78),
(9, 79),
(9, 80),
(9, 81),
(9, 82),
(9, 83),
(9, 84),
(9, 85),
(9, 86),
(9, 87),
(9, 88),
(9, 89),
(9, 90),
(9, 91),
(9, 92),
(9, 93),
(9, 94),
(9, 95),
(9, 96),
(9, 97),
(9, 98),
(9, 99),
(9, 100),
(9, 101),
(9, 102),
(9, 103),
(9, 104),
(9, 105),
(9, 106),
(9, 107),
(9, 108),
(9, 109),
(9, 110),
(9, 111),
(9, 112),
(9, 113),
(9, 114),
(9, 115),
(9, 116),
(9, 117),
(9, 119),
(9, 120),
(9, 121),
(9, 122),
(9, 123),
(9, 124),
(9, 125),
(9, 126),
(9, 127),
(9, 128),
(9, 129),
(9, 130),
(9, 131),
(9, 132),
(9, 133),
(9, 134),
(9, 135),
(9, 136),
(9, 137),
(9, 138),
(9, 139),
(9, 140),
(9, 141),
(9, 142),
(9, 143),
(9, 144),
(9, 145),
(9, 146),
(9, 147),
(9, 148),
(9, 149),
(9, 150),
(9, 151),
(9, 152),
(9, 153),
(9, 154),
(9, 155),
(9, 156),
(9, 159),
(14, 5),
(14, 6),
(14, 7),
(14, 8),
(14, 9),
(14, 10),
(14, 11),
(14, 12),
(14, 13),
(14, 14),
(14, 15),
(14, 16),
(14, 17),
(14, 18),
(14, 19),
(14, 20),
(14, 21),
(14, 22),
(14, 23),
(14, 24),
(14, 25),
(14, 26),
(14, 27),
(14, 28),
(14, 29),
(14, 30),
(14, 31),
(14, 32),
(14, 33),
(14, 34),
(14, 35),
(14, 36),
(14, 37),
(14, 38),
(14, 39),
(14, 73),
(14, 74),
(14, 75),
(14, 76),
(14, 77),
(14, 78),
(14, 79),
(14, 80),
(14, 81),
(14, 82),
(14, 83),
(14, 84),
(14, 85),
(14, 86),
(14, 87),
(14, 88),
(14, 89),
(14, 90),
(14, 91),
(14, 92),
(14, 93),
(14, 94),
(14, 95),
(14, 96),
(14, 97),
(14, 98),
(14, 99),
(14, 102),
(14, 103),
(14, 104),
(14, 105),
(14, 106),
(14, 107),
(14, 108),
(14, 109),
(14, 110),
(14, 111),
(14, 112),
(14, 113),
(14, 114),
(14, 119),
(14, 120),
(14, 121),
(14, 122),
(14, 123),
(14, 124),
(14, 125),
(14, 126),
(14, 127),
(14, 128),
(14, 129),
(14, 130),
(14, 131),
(14, 132),
(14, 133),
(14, 134),
(14, 135),
(14, 136),
(14, 137),
(14, 138),
(22, 127),
(22, 128),
(22, 129),
(23, 128),
(23, 130),
(23, 131),
(23, 132),
(23, 156),
(24, 143),
(26, 92),
(26, 93),
(26, 94),
(26, 95),
(27, 79),
(27, 80),
(27, 81),
(27, 82),
(27, 85),
(27, 86),
(28, 78),
(28, 83),
(28, 84),
(29, 109),
(29, 112),
(30, 110),
(30, 111),
(30, 113),
(31, 114),
(32, 109),
(32, 110),
(32, 111),
(32, 112),
(32, 113),
(32, 114),
(32, 149),
(32, 150),
(33, 133),
(33, 134),
(33, 135),
(33, 151),
(34, 144),
(35, 102),
(35, 103),
(35, 104),
(35, 105),
(35, 106),
(35, 107),
(36, 106),
(36, 108),
(37, 106),
(38, 5),
(38, 6),
(38, 7),
(38, 139),
(39, 5),
(39, 13),
(39, 139),
(39, 163),
(41, 5),
(41, 7),
(41, 8),
(41, 139),
(42, 9),
(42, 10),
(42, 11),
(43, 9),
(43, 12),
(44, 14),
(44, 15),
(44, 16),
(45, 14),
(45, 20),
(46, 14),
(46, 17),
(46, 18),
(46, 19),
(48, 22),
(49, 21),
(50, 23),
(50, 24),
(51, 25),
(52, 26),
(52, 29),
(53, 27),
(54, 28),
(55, 31),
(55, 96),
(56, 31),
(56, 97),
(57, 30),
(58, 32),
(58, 33),
(59, 34),
(59, 38),
(60, 35),
(60, 36),
(61, 37),
(61, 39),
(62, 136),
(62, 137),
(62, 138),
(62, 159),
(63, 162),
(64, 40),
(64, 41),
(64, 42),
(64, 43),
(64, 44),
(64, 45),
(64, 46),
(64, 47),
(64, 48),
(64, 49),
(64, 50),
(64, 51),
(64, 52),
(64, 53),
(64, 54),
(64, 55),
(64, 56),
(64, 57),
(64, 58),
(64, 59),
(64, 60),
(64, 61),
(64, 62),
(64, 63),
(64, 64),
(64, 65),
(64, 66),
(64, 67),
(64, 68),
(64, 69),
(64, 70),
(64, 71),
(64, 72),
(64, 100),
(64, 101),
(64, 115),
(64, 116),
(64, 117),
(64, 119),
(64, 120),
(64, 121),
(64, 122),
(64, 123),
(64, 124),
(64, 125),
(64, 126),
(65, 5),
(65, 6),
(65, 7),
(65, 8),
(65, 9),
(65, 10),
(65, 11),
(65, 12),
(65, 13),
(65, 14),
(65, 15),
(65, 16),
(65, 17),
(65, 18),
(65, 19),
(65, 20),
(65, 21),
(65, 22),
(65, 23),
(65, 24),
(65, 25),
(65, 26),
(65, 27),
(65, 28),
(65, 29),
(65, 30),
(65, 31),
(65, 32),
(65, 33),
(65, 34),
(65, 35),
(65, 36),
(65, 37),
(65, 38),
(65, 39),
(65, 40),
(65, 41),
(65, 42),
(65, 43),
(65, 44),
(65, 45),
(65, 46),
(65, 47),
(65, 48),
(65, 49),
(65, 50),
(65, 51),
(65, 52),
(65, 53),
(65, 54),
(65, 55),
(65, 56),
(65, 57),
(65, 58),
(65, 59),
(65, 60),
(65, 61),
(65, 62),
(65, 63),
(65, 64),
(65, 65),
(65, 66),
(65, 67),
(65, 68),
(65, 69),
(65, 70),
(65, 71),
(65, 72),
(65, 73),
(65, 74),
(65, 75),
(65, 76),
(65, 77),
(65, 78),
(65, 79),
(65, 80),
(65, 81),
(65, 82),
(65, 83),
(65, 84),
(65, 85),
(65, 86),
(65, 87),
(65, 88),
(65, 89),
(65, 90),
(65, 91),
(65, 92),
(65, 93),
(65, 94),
(65, 95),
(65, 96),
(65, 97),
(65, 98),
(65, 99),
(65, 100),
(65, 101),
(65, 102),
(65, 103),
(65, 104),
(65, 105),
(65, 106),
(65, 107),
(65, 108),
(65, 109),
(65, 110),
(65, 111),
(65, 112),
(65, 113),
(65, 114),
(65, 115),
(65, 116),
(65, 117),
(65, 119),
(65, 120),
(65, 121),
(65, 122),
(65, 123),
(65, 124),
(65, 125),
(65, 126),
(65, 127),
(65, 128),
(65, 129),
(65, 130),
(65, 131),
(65, 132),
(65, 133),
(65, 134),
(65, 135),
(65, 136),
(65, 137),
(65, 138),
(67, 161),
(68, 5),
(68, 6),
(68, 8),
(68, 9),
(68, 10),
(68, 11),
(68, 14),
(68, 15),
(68, 16),
(68, 17),
(68, 18),
(68, 19),
(68, 21),
(68, 28),
(68, 29),
(68, 30),
(68, 31),
(68, 32),
(68, 33),
(68, 34),
(68, 35),
(68, 36),
(68, 37),
(68, 38),
(68, 39),
(68, 73),
(68, 74),
(68, 75),
(68, 76),
(68, 77),
(68, 87),
(68, 88),
(68, 89),
(68, 90),
(68, 91),
(68, 96),
(68, 97),
(68, 98),
(68, 99),
(68, 102),
(68, 103),
(68, 104),
(68, 105),
(68, 106),
(68, 107),
(68, 108),
(68, 114),
(68, 128),
(68, 130),
(68, 131),
(68, 132),
(68, 133),
(68, 136),
(68, 137),
(68, 138),
(68, 139),
(68, 140),
(68, 141),
(68, 143),
(68, 144),
(68, 145),
(68, 146),
(68, 147),
(68, 149),
(68, 151),
(68, 153),
(68, 154),
(68, 155),
(68, 156),
(68, 159),
(69, 109),
(69, 110),
(69, 111),
(69, 112),
(69, 113),
(69, 114),
(69, 127),
(69, 128),
(69, 129),
(69, 130),
(69, 131),
(69, 132),
(69, 133),
(69, 134),
(69, 135),
(69, 147),
(69, 149),
(69, 150),
(69, 151),
(69, 156),
(70, 32),
(70, 33),
(70, 34),
(70, 35),
(70, 36),
(70, 37),
(70, 38),
(70, 39),
(70, 154),
(70, 155),
(71, 5),
(71, 6),
(71, 7),
(71, 8),
(71, 9),
(71, 10),
(71, 11),
(71, 12),
(71, 13),
(71, 14),
(71, 15),
(71, 16),
(71, 17),
(71, 18),
(71, 19),
(71, 20),
(71, 21),
(71, 23),
(71, 24),
(71, 25),
(71, 26),
(71, 28),
(71, 29),
(71, 30),
(71, 31),
(71, 96),
(71, 97),
(71, 139),
(71, 152),
(71, 153),
(72, 6),
(72, 30),
(72, 31),
(72, 32),
(72, 33),
(72, 34),
(72, 35),
(72, 36),
(72, 37),
(72, 38),
(72, 39),
(72, 73),
(72, 74),
(72, 75),
(72, 76),
(72, 77),
(72, 78),
(72, 80),
(72, 81),
(72, 87),
(72, 88),
(72, 89),
(72, 90),
(72, 91),
(72, 96),
(72, 97),
(72, 98),
(72, 99),
(72, 102),
(72, 103),
(72, 104),
(72, 105),
(72, 106),
(72, 107),
(72, 108),
(72, 139),
(72, 140),
(72, 141),
(72, 142),
(72, 143),
(72, 144),
(72, 145),
(72, 146),
(72, 154),
(73, 74),
(73, 75),
(73, 76),
(73, 77),
(73, 87);

-- --------------------------------------------------------

--
-- 資料表格式： `app_role_menu`
--

CREATE TABLE IF NOT EXISTS `app_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单';

--
-- 列出以下資料庫的數據： `app_role_menu`
--

INSERT INTO `app_role_menu` (`role_id`, `menu_id`) VALUES
(7, 3),
(7, 4),
(7, 5),
(7, 6),
(7, 7),
(7, 9),
(7, 25),
(7, 29),
(7, 30),
(7, 32),
(7, 33),
(7, 34),
(7, 35),
(7, 37),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(8, 7),
(8, 9),
(8, 25),
(8, 29),
(8, 30),
(8, 32),
(8, 33),
(8, 34),
(8, 35),
(8, 37),
(9, 3),
(9, 4),
(9, 5),
(9, 6),
(9, 7),
(9, 8),
(9, 9),
(9, 10),
(9, 11),
(9, 12),
(9, 13),
(9, 14),
(9, 15),
(9, 16),
(9, 17),
(9, 18),
(9, 19),
(9, 20),
(9, 21),
(9, 22),
(9, 23),
(9, 24),
(9, 25),
(9, 26),
(9, 27),
(9, 28),
(9, 29),
(9, 30),
(9, 31),
(9, 32),
(9, 33),
(9, 34),
(9, 35),
(9, 36),
(9, 37),
(9, 38),
(9, 39),
(9, 40),
(9, 41),
(9, 42),
(9, 43),
(9, 44),
(9, 45),
(9, 46),
(9, 47),
(9, 48),
(9, 49),
(9, 50),
(9, 51),
(14, 3),
(14, 4),
(14, 5),
(14, 6),
(14, 7),
(14, 8),
(14, 9),
(14, 10),
(14, 12),
(14, 17),
(14, 18),
(14, 19),
(14, 25),
(14, 26),
(14, 27),
(14, 28),
(14, 29),
(14, 30),
(14, 31),
(14, 32),
(14, 33),
(14, 34),
(14, 35),
(14, 36),
(14, 37),
(14, 38),
(14, 39),
(14, 40),
(14, 41),
(14, 42),
(14, 43),
(14, 44),
(14, 45),
(14, 46),
(14, 47),
(14, 48),
(14, 49),
(14, 50),
(14, 51),
(22, 17),
(22, 39),
(23, 17),
(23, 39),
(24, 3),
(24, 33),
(26, 17),
(26, 40),
(27, 3),
(27, 4),
(28, 3),
(28, 4),
(29, 17),
(29, 41),
(29, 43),
(30, 17),
(30, 41),
(30, 43),
(31, 17),
(31, 41),
(31, 43),
(32, 17),
(32, 41),
(32, 43),
(32, 44),
(33, 17),
(33, 42),
(34, 3),
(34, 34),
(35, 3),
(35, 32),
(36, 3),
(36, 32),
(37, 3),
(37, 32),
(38, 8),
(38, 45),
(38, 48),
(39, 8),
(39, 45),
(39, 48),
(41, 8),
(41, 45),
(41, 48),
(42, 8),
(42, 45),
(42, 48),
(43, 8),
(43, 45),
(43, 48),
(44, 8),
(44, 45),
(44, 48),
(45, 8),
(45, 45),
(45, 48),
(46, 8),
(46, 45),
(46, 48),
(48, 8),
(48, 45),
(48, 49),
(49, 8),
(49, 45),
(49, 49),
(50, 8),
(50, 46),
(50, 50),
(51, 8),
(51, 46),
(51, 50),
(52, 8),
(52, 46),
(52, 51),
(53, 8),
(53, 46),
(53, 51),
(54, 8),
(54, 46),
(54, 51),
(55, 8),
(55, 47),
(56, 8),
(56, 47),
(57, 8),
(57, 47),
(58, 5),
(58, 6),
(58, 7),
(59, 5),
(59, 6),
(59, 7),
(59, 28),
(60, 5),
(60, 29),
(60, 30),
(61, 5),
(61, 29),
(61, 30),
(61, 31),
(62, 9),
(62, 26),
(63, 9),
(63, 27),
(64, 10),
(64, 11),
(64, 12),
(64, 13),
(64, 14),
(64, 15),
(64, 16),
(64, 18),
(64, 19),
(64, 20),
(64, 21),
(64, 22),
(64, 23),
(64, 24),
(65, 3),
(65, 4),
(65, 5),
(65, 6),
(65, 7),
(65, 8),
(65, 9),
(65, 10),
(65, 11),
(65, 12),
(65, 13),
(65, 14),
(65, 15),
(65, 16),
(65, 17),
(65, 18),
(65, 19),
(65, 20),
(65, 21),
(65, 22),
(65, 23),
(65, 24),
(65, 25),
(65, 26),
(65, 27),
(65, 28),
(65, 29),
(65, 30),
(65, 31),
(65, 32),
(65, 33),
(65, 34),
(65, 35),
(65, 36),
(65, 37),
(65, 38),
(65, 39),
(65, 40),
(65, 41),
(65, 42),
(65, 43),
(65, 44),
(65, 45),
(65, 46),
(65, 47),
(65, 48),
(65, 49),
(65, 50),
(65, 51),
(67, 9),
(67, 25),
(68, 3),
(68, 4),
(68, 5),
(68, 6),
(68, 7),
(68, 8),
(68, 9),
(68, 17),
(68, 26),
(68, 28),
(68, 29),
(68, 30),
(68, 31),
(68, 32),
(68, 33),
(68, 34),
(68, 35),
(68, 36),
(68, 37),
(68, 38),
(68, 39),
(68, 41),
(68, 42),
(68, 43),
(68, 45),
(68, 46),
(68, 47),
(68, 48),
(68, 49),
(68, 51),
(69, 17),
(69, 39),
(69, 41),
(69, 42),
(69, 43),
(69, 44),
(70, 5),
(70, 6),
(70, 7),
(70, 28),
(70, 29),
(70, 30),
(70, 31),
(71, 8),
(71, 45),
(71, 46),
(71, 47),
(71, 48),
(71, 49),
(71, 50),
(71, 51),
(72, 3),
(72, 4),
(72, 5),
(72, 6),
(72, 7),
(72, 8),
(72, 28),
(72, 29),
(72, 30),
(72, 31),
(72, 32),
(72, 33),
(72, 34),
(72, 35),
(72, 36),
(72, 37),
(72, 38),
(72, 45),
(72, 47),
(72, 48),
(73, 3),
(73, 36);

-- --------------------------------------------------------

--
-- 資料表格式： `app_school_department`
--

CREATE TABLE IF NOT EXISTS `app_school_department` (
  `dep_id` bigint(20) NOT NULL auto_increment,
  `dep_no` varchar(32) NOT NULL COMMENT '部门编号',
  `dep_name` varchar(128) NOT NULL COMMENT '部门名称',
  `dep_desc` varchar(256) default NULL COMMENT '部门描述',
  `dep_eqlevel` tinyint(4) default '-1' COMMENT '对口级别, -1=无, 0=总部, 1=校区, 2=片区',
  `dep_eqid` bigint(20) default NULL COMMENT '对口部门',
  `dep_orgtype` tinyint(4) NOT NULL COMMENT '部门结构类型 0=总部, 1=校区, 2=片区',
  PRIMARY KEY  (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='学校部门设置' AUTO_INCREMENT=29 ;

--
-- 列出以下資料庫的數據： `app_school_department`
--

INSERT INTO `app_school_department` (`dep_id`, `dep_no`, `dep_name`, `dep_desc`, `dep_eqlevel`, `dep_eqid`, `dep_orgtype`) VALUES
(15, '1', '总经办', '', 0, 15, 0),
(16, '2', '市场部', '', 0, 16, 0),
(17, '3', '财务部', '', 0, 17, 0),
(18, '1', '校区办', '', 0, 15, 1),
(19, '5', '教务部', '', 0, 23, 1),
(20, '6', '行政部', '', 0, 24, 1),
(21, '2', '咨询部', '', 0, 16, 1),
(22, '4', '运营部', '', 0, 22, 0),
(23, '5', '教研部', '', 0, 23, 0),
(24, '6', '行政部', '', 0, 24, 0),
(25, '5', '财务部', '', 0, 17, 1),
(26, '7', '人资部', '', 0, 26, 0),
(27, '8', '发展部', '', 0, 27, 0),
(28, '1', '片区办', '', 0, 27, 2);

-- --------------------------------------------------------

--
-- 資料表格式： `app_school_department_position`
--

CREATE TABLE IF NOT EXISTS `app_school_department_position` (
  `pos_id` bigint(20) NOT NULL auto_increment,
  `pos_name` varchar(150) NOT NULL COMMENT '岗位名称',
  `pos_desc` varchar(250) default NULL COMMENT '岗位描述',
  `pos_leadership` tinyint(4) default '1' COMMENT '是否领导, 0=是, 1=不是',
  `dep_id` bigint(20) NOT NULL COMMENT '部门ID',
  `pos_roleRights` text COMMENT '岗位角色权限',
  PRIMARY KEY  (`pos_id`),
  KEY `dep_id` (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='部门岗位' AUTO_INCREMENT=57 ;

--
-- 列出以下資料庫的數據： `app_school_department_position`
--

INSERT INTO `app_school_department_position` (`pos_id`, `pos_name`, `pos_desc`, `pos_leadership`, `dep_id`, `pos_roleRights`) VALUES
(13, '副总经理', '', 0, 15, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_RECRUIT_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_EMPLOYEE_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_HRM_DEVELOP_FINALIZE,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE,ROLE_BASIC_APPROVE'),
(14, '市场总监', '', 0, 16, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(15, '市场专员', '', 1, 16, 'ROLE_EMPLOYEE_HEADOFFICE'),
(17, '财务专员', '', 1, 17, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(25, '校区行政', '', 1, 20, 'ROLE_EMPLOYEE_SCHOOL'),
(26, '总经理', '', 0, 15, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_RECRUIT_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_EMPLOYEE_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE,ROLE_BASIC_APPROVE'),
(27, '校长', '', 0, 18, 'ROLE_SCHOOL_HEADMASTER'),
(28, '会计', '', 1, 17, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(29, '美工设计', '', 1, 16, 'ROLE_EMPLOYEE_HEADOFFICE'),
(30, '行政主管', '', 0, 20, 'ROLE_EMPLOYEE_SCHOOL,ROLE_SCHOOL_CLERICAL_MANAGE'),
(33, '教务主管', '', 0, 19, 'ROLE_EMPLOYEE_SCHOOL'),
(34, '教务助理', '', 1, 19, 'ROLE_EMPLOYEE_SCHOOL'),
(35, '教师', '', 1, 19, 'ROLE_EMPLOYEE_SCHOOL'),
(36, '学科组长', '', 1, 19, 'ROLE_EMPLOYEE_SCHOOL'),
(37, '市场专员', '', 1, 21, 'ROLE_EMPLOYEE_SCHOOL'),
(38, '财务', '', 1, 25, 'ROLE_EMPLOYEE_SCHOOL,ROLE_SCHOOL_FINANCE_MANAGE'),
(39, '财务总监', '', 0, 17, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(40, '运营总监', '', 0, 22, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(41, '运营专员', '', 1, 22, 'ROLE_EMPLOYEE_HEADOFFICE'),
(42, '教务总监', '', 0, 23, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE,ROLE_BASIC_APPROVE'),
(43, '教务专员', '', 1, 23, 'ROLE_EMPLOYEE_HEADOFFICE'),
(44, '行政总监', '', 0, 24, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_ADMIN_NEWS_APPROVE,ROLE_PERSONAL_NEWS_READ,ROLE_ADMIN_TASK_APPROVE,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_WORKPLAN_ADD,ROLE_ADMIN_WORKPLAN_ADJUST,ROLE_ADMIN_WORKPLAN_READ,ROLE_ADMIN_ATTENDANCE_MANAGE,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(45, '行政专员', '', 1, 24, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_WORKPLAN_ADD,ROLE_ADMIN_WORKPLAN_ADJUST,ROLE_ADMIN_WORKPLAN_READ,ROLE_ADMIN_ATTENDANCE_MANAGE,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD'),
(46, '人资总监', '', 0, 26, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_JOB_APPROVE,ROLE_ADMIN_HRM_JOB_MANAGE,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ONBOARD,ROLE_ADMIN_HRM_RECRUIT_REVIEW,ROLE_ADMIN_HRM_RECRUITING,ROLE_ADMIN_HRM_RECRUIT_RESULT,ROLE_ADMIN_HRM_ARCHIVE_RESUME_REMOVE,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_ENTRY_OP_ONBOARD,ROLE_ADMIN_HRM_ENTRY_OP_QUALIFY,ROLE_ADMIN_HRM_EMPLOYEE_ADD,ROLE_ADMIN_HRM_EMPLOYEE_DELETE,ROLE_ADMIN_HRM_EMPLOYEE_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_HRM_DEVELOP_FINALIZE,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE,ROLE_BASIC_APPROVE'),
(47, '人资专员', '', 1, 26, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ONBOARD,ROLE_ADMIN_HRM_RECRUIT_REVIEW,ROLE_ADMIN_HRM_RECRUITING,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_ENTRY_OP_ONBOARD,ROLE_ADMIN_HRM_EMPLOYEE_ADD,ROLE_ADMIN_HRM_EMPLOYEE_VIEW,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA'),
(48, '校长助理', '', 1, 18, 'ROLE_EMPLOYEE_SCHOOL'),
(49, '发展总监', '', 0, 27, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(50, '发展专员', '', 1, 27, 'ROLE_EMPLOYEE_HEADOFFICE'),
(51, '咨询师', '', 1, 21, 'ROLE_EMPLOYEE_SCHOOL'),
(52, '学管师', '', 1, 19, 'ROLE_EMPLOYEE_SCHOOL'),
(53, '区长', '', 0, 27, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(54, '咨询主管', '', 0, 21, 'ROLE_EMPLOYEE_SCHOOL'),
(55, '行政人资主管', '', 0, 20, 'ROLE_EMPLOYEE_SCHOOL,ROLE_SCHOOL_CLERICAL_MANAGE,ROLE_SCHOOL_HR_MANAGE'),
(56, '区长', '', 0, 28, 'ROLE_AREA_MANAGE');

-- --------------------------------------------------------

--
-- 資料表格式： `app_school_department_position_role`
--

CREATE TABLE IF NOT EXISTS `app_school_department_position_role` (
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY  (`pos_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位权限';

--
-- 列出以下資料庫的數據： `app_school_department_position_role`
--

INSERT INTO `app_school_department_position_role` (`pos_id`, `role_id`) VALUES
(14, 7),
(14, 22),
(14, 24),
(14, 27),
(14, 28),
(14, 33),
(14, 34),
(14, 35),
(14, 36),
(14, 37),
(14, 38),
(14, 42),
(14, 49),
(14, 55),
(14, 56),
(14, 58),
(14, 59),
(14, 60),
(14, 61),
(15, 7),
(17, 7),
(17, 58),
(17, 59),
(17, 60),
(17, 61),
(25, 8),
(26, 7),
(26, 22),
(26, 24),
(26, 27),
(26, 28),
(26, 33),
(26, 34),
(26, 35),
(26, 36),
(26, 37),
(26, 38),
(26, 42),
(26, 44),
(26, 49),
(26, 54),
(26, 55),
(26, 56),
(26, 58),
(26, 59),
(26, 60),
(26, 61),
(26, 73),
(27, 68),
(28, 7),
(28, 58),
(28, 59),
(28, 60),
(28, 61),
(29, 7),
(30, 8),
(30, 69),
(33, 8),
(34, 8),
(35, 8),
(36, 8),
(37, 8),
(39, 7),
(39, 22),
(39, 24),
(39, 27),
(39, 28),
(39, 33),
(39, 34),
(39, 35),
(39, 36),
(39, 37),
(39, 38),
(39, 42),
(39, 49),
(39, 55),
(39, 56),
(39, 58),
(39, 59),
(39, 60),
(39, 61),
(40, 7),
(40, 22),
(40, 24),
(40, 27),
(40, 28),
(40, 33),
(40, 34),
(40, 35),
(40, 36),
(40, 37),
(40, 38),
(40, 42),
(40, 49),
(40, 55),
(40, 56),
(40, 58),
(40, 59),
(40, 60),
(40, 61),
(41, 7),
(42, 7),
(42, 22),
(42, 24),
(42, 27),
(42, 28),
(42, 33),
(42, 34),
(42, 35),
(42, 36),
(42, 37),
(42, 38),
(42, 42),
(42, 49),
(42, 55),
(42, 56),
(42, 58),
(42, 59),
(42, 60),
(42, 61),
(42, 73),
(43, 7),
(44, 7),
(44, 22),
(44, 23),
(44, 24),
(44, 26),
(44, 27),
(44, 28),
(44, 29),
(44, 30),
(44, 31),
(44, 32),
(44, 33),
(44, 34),
(44, 35),
(44, 36),
(44, 37),
(44, 38),
(44, 42),
(44, 49),
(44, 55),
(44, 56),
(44, 58),
(44, 59),
(44, 60),
(44, 61),
(45, 7),
(45, 22),
(45, 28),
(45, 29),
(45, 30),
(45, 31),
(45, 32),
(45, 33),
(45, 34),
(46, 7),
(46, 22),
(46, 24),
(46, 27),
(46, 28),
(46, 33),
(46, 34),
(46, 35),
(46, 36),
(46, 37),
(46, 38),
(46, 39),
(46, 41),
(46, 42),
(46, 43),
(46, 44),
(46, 45),
(46, 46),
(46, 48),
(46, 49),
(46, 50),
(46, 51),
(46, 52),
(46, 53),
(46, 54),
(46, 55),
(46, 56),
(46, 57),
(46, 58),
(46, 59),
(46, 60),
(46, 61),
(46, 73),
(47, 7),
(47, 38),
(47, 42),
(47, 43),
(47, 44),
(47, 45),
(47, 49),
(47, 50),
(47, 52),
(47, 54),
(47, 56),
(48, 8),
(49, 7),
(49, 22),
(49, 24),
(49, 27),
(49, 28),
(49, 33),
(49, 34),
(49, 35),
(49, 36),
(49, 37),
(49, 38),
(49, 42),
(49, 49),
(49, 55),
(49, 56),
(49, 58),
(49, 59),
(49, 60),
(49, 61),
(50, 7),
(51, 8),
(52, 8),
(53, 7),
(53, 22),
(53, 24),
(53, 27),
(53, 28),
(53, 33),
(53, 34),
(53, 35),
(53, 36),
(53, 37),
(53, 38),
(53, 42),
(53, 49),
(53, 55),
(53, 56),
(53, 58),
(53, 59),
(53, 60),
(53, 61),
(54, 8),
(55, 8),
(55, 69),
(55, 71),
(56, 72);

-- --------------------------------------------------------

--
-- 資料表格式： `app_school_district`
--

CREATE TABLE IF NOT EXISTS `app_school_district` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='校区设置' AUTO_INCREMENT=11 ;

--
-- 列出以下資料庫的數據： `app_school_district`
--

INSERT INTO `app_school_district` (`district_id`, `district_no`, `district_name`, `district_type`, `district_address`, `district_phone`, `district_parent`) VALUES
(1, '0000', '杭州总部', 0, '', '', NULL),
(3, '0001', '绍兴解放路校区', 1, '', '', 1),
(4, '0002', '绍兴迪荡校区', 1, '德清', '', 1),
(5, '0003', '柯桥校区', 1, '', '', 1),
(6, '0004', '嘉兴校区', 1, '', '', 1),
(7, '0005', '湖州校区', 1, '', '', 1),
(8, '0006', '萧山校区', 1, '', '', 1),
(9, '0007', '德清校区', 1, '', '', 1),
(10, '0008', '萧绍片区', 2, '', '', 1);

-- --------------------------------------------------------

--
-- 資料表格式： `app_school_posets`
--

CREATE TABLE IF NOT EXISTS `app_school_posets` (
  `poset_id` bigint(20) NOT NULL auto_increment COMMENT '职位岗位ID',
  `poset_name` varchar(64) NOT NULL COMMENT '职位岗位名称',
  PRIMARY KEY  (`poset_id`),
  UNIQUE KEY `poset_name` (`poset_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='职位岗位' AUTO_INCREMENT=15 ;

--
-- 列出以下資料庫的數據： `app_school_posets`
--

INSERT INTO `app_school_posets` (`poset_id`, `poset_name`) VALUES
(12, '基本岗位（总部）'),
(13, '基本岗位（校区）'),
(11, '总经办职位'),
(10, '总部主管'),
(14, '校区主管（校区）');

-- --------------------------------------------------------

--
-- 資料表格式： `app_school_posets_terms`
--

CREATE TABLE IF NOT EXISTS `app_school_posets_terms` (
  `poset_id` bigint(20) NOT NULL COMMENT '职位岗位ID',
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY  (`poset_id`,`pos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职位与岗位关系表';

--
-- 列出以下資料庫的數據： `app_school_posets_terms`
--

INSERT INTO `app_school_posets_terms` (`poset_id`, `pos_id`) VALUES
(10, 14),
(10, 39),
(10, 40),
(10, 42),
(10, 44),
(10, 46),
(11, 13),
(11, 26),
(12, 15),
(12, 17),
(12, 28),
(12, 29),
(12, 41),
(12, 43),
(13, 25),
(13, 34),
(13, 35),
(13, 36),
(13, 37),
(13, 38),
(14, 27),
(14, 30),
(14, 33);

-- --------------------------------------------------------

--
-- 資料表格式： `app_system_config`
--

CREATE TABLE IF NOT EXISTS `app_system_config` (
  `config_id` bigint(20) NOT NULL auto_increment,
  `config_key` varchar(64) NOT NULL COMMENT 'Key',
  `config_name` varchar(64) NOT NULL COMMENT '配置名称',
  `config_desc` varchar(256) default NULL COMMENT '配置描述',
  `type_name` varchar(32) NOT NULL COMMENT '所属分类名称',
  `data_type` smallint(6) NOT NULL COMMENT '数据类型            1=varchar            2=intger            3=decimal            4=datetime            5=time            ',
  `data_value` varchar(64) default NULL COMMENT '数据值',
  PRIMARY KEY  (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置,用于系统的全局配置' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_system_config`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_system_dictionary`
--

CREATE TABLE IF NOT EXISTS `app_system_dictionary` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- 列出以下資料庫的數據： `app_system_dictionary`
--

INSERT INTO `app_system_dictionary` (`id`, `name`, `value`, `type`, `level`, `sequence`, `extra_value`, `creation_date`, `modified_date`) VALUES
(1, '人资文档', '人资文档', 'docType', '总部文档', 0, '123456', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, '行政文档', '行政文档', 'docType', '总部文档', 0, '456789', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, '新闻', '新闻', 'news', '公司总部新闻', 1, '', '2012-07-26 13:22:31', '2012-07-26 13:22:31'),
(4, '通知', '通知', 'news', '公司总部新闻', 2, '', '2012-07-26 13:22:44', '2012-07-26 13:22:44'),
(5, '校区新闻', '校区新闻', 'news', '分校区新闻', 0, '', '2012-07-26 13:22:52', '2012-07-26 13:22:52'),
(6, '校区通知', '校区通知', 'news', '分校区新闻', 0, '', '2012-07-26 13:23:02', '2012-07-26 13:23:02'),
(7, '任务类型1', '任务类型1', 'task', NULL, 0, '', '2012-07-26 13:23:20', '2012-07-26 13:23:20'),
(8, '任务类型2', '任务类型2', 'task', NULL, 0, '', '2012-07-26 13:23:26', '2012-07-26 13:23:26'),
(9, '年度会议', '年度会议', 'conference', '公司级别会议', 0, '', '2012-07-26 13:23:55', '2012-07-26 13:23:55'),
(10, '月度会议', '月度会议', 'conference', '公司级别会议', 0, '', '2012-07-26 13:24:11', '2012-07-26 13:24:11'),
(11, '周例会', '周例会', 'conference', '校区级别会议', 0, '', '2012-07-26 13:24:19', '2012-07-26 13:24:19'),
(12, '教学讨论会', '教学讨论会', 'conference', '校区级别会议', 0, '', '2012-07-26 13:24:35', '2012-07-26 13:24:35'),
(13, '1星', '1星', 'teacher', NULL, 0, '', '2012-07-26 13:25:23', '2012-07-26 13:25:23'),
(14, '2星', '2星', 'teacher', NULL, 0, '', '2012-07-26 13:25:29', '2012-07-26 13:25:29'),
(15, '3星', '3星', 'teacher', NULL, 0, '', '2012-07-26 13:25:35', '2012-07-26 13:25:35'),
(16, '1星', '1星', 'counselor', NULL, 0, '', '2012-07-26 13:29:44', '2012-07-26 13:29:44'),
(17, '2星', '2星', 'counselor', NULL, 0, '', '2012-07-26 13:29:49', '2012-07-26 13:29:49'),
(18, '3星', '3星', 'counselor', NULL, 0, '', '2012-07-26 13:29:55', '2012-07-26 13:29:55');

-- --------------------------------------------------------

--
-- 資料表格式： `app_system_log`
--

CREATE TABLE IF NOT EXISTS `app_system_log` (
  `log_id` bigint(20) NOT NULL auto_increment,
  `user_name` varchar(120) NOT NULL COMMENT '用户名',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  `detail` text COMMENT '操作详细说明',
  `ip` varchar(128) default NULL COMMENT '登录IP',
  `cost` bigint(20) default NULL COMMENT '操作耗时',
  PRIMARY KEY  (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统日志' AUTO_INCREMENT=604 ;

--
-- 列出以下資料庫的數據： `app_system_log`
--

INSERT INTO `app_system_log` (`log_id`, `user_name`, `user_id`, `createtime`, `operation`, `detail`, `ip`, `cost`) VALUES
(571, '管理员', 1, '2012-08-31 16:50:33', '登录', '用户通过身份验证进入系统', '218.108.223.168', 24),
(572, '管理员', 1, '2012-09-04 12:02:01', '登录', '用户通过身份验证进入系统', '115.229.138.12', 26),
(573, '管理员', 1, '2012-09-04 19:14:11', '登录', '用户通过身份验证进入系统', '218.108.222.65', 23),
(574, '管理员', 1, '2012-09-04 19:14:57', '登录', '用户通过身份验证进入系统', '218.108.222.65', 32),
(575, '管理员', 1, '2012-09-04 21:37:57', '登录', '用户通过身份验证进入系统', '183.140.202.120', 33),
(576, '管理员', 1, '2012-09-04 21:43:45', '登录', '用户通过身份验证进入系统', '218.108.222.65', 27),
(577, '管理员', 1, '2012-09-04 22:28:52', '登录', '用户通过身份验证进入系统', '218.108.222.65', 39),
(578, '管理员', 1, '2012-09-05 11:02:34', '登录', '用户通过身份验证进入系统', '122.234.50.110', 50),
(579, '周碧英', 25, '2012-09-05 11:10:58', '登录', '用户通过身份验证进入系统', '122.234.50.110', 52),
(580, '林菁菁', 21, '2012-09-05 11:11:25', '登录', '用户通过身份验证进入系统', '122.234.50.110', 91),
(581, '刘苗芳', 24, '2012-09-05 11:14:28', '登录', '用户通过身份验证进入系统', '122.234.50.110', 79),
(582, '林菁菁', 21, '2012-09-05 11:15:47', '登录', '用户通过身份验证进入系统', '122.234.50.110', 110),
(583, '周碧英', 25, '2012-09-05 11:16:37', '登录', '用户通过身份验证进入系统', '122.234.50.110', 49),
(584, '刘苗芳', 24, '2012-09-05 11:31:48', '登录', '用户通过身份验证进入系统', '122.234.50.110', 70),
(585, '刘苗芳', 24, '2012-09-05 11:35:36', '登录', '用户通过身份验证进入系统', '122.234.50.110', 97),
(586, 'leo', 38, '2012-09-05 11:35:37', '登录', '用户通过身份验证进入系统', '122.234.50.110', 39),
(587, '周碧英', 25, '2012-09-05 11:44:06', '登录', '用户通过身份验证进入系统', '122.234.50.110', 43),
(588, '王五', 39, '2012-09-05 11:45:21', '登录', '用户通过身份验证进入系统', '122.234.50.110', 133),
(589, '管理员', 1, '2012-09-05 12:25:12', '登录', '用户通过身份验证进入系统', '218.108.223.233', 28),
(590, '杨琪', 27, '2012-09-05 13:15:14', '登录', '用户通过身份验证进入系统', '122.234.50.110', 66),
(591, '程聪', 29, '2012-09-05 13:42:36', '登录', '用户通过身份验证进入系统', '122.234.50.110', 47),
(592, 'ljx', 36, '2012-09-05 13:43:57', '登录', '用户通过身份验证进入系统', '122.234.50.110', 123),
(593, '王五', 39, '2012-09-05 13:54:35', '登录', '用户通过身份验证进入系统', '122.234.50.110', 120),
(594, '程聪', 29, '2012-09-05 14:39:38', '登录', '用户通过身份验证进入系统', '122.234.50.110', 38),
(595, 'leo', 38, '2012-09-05 14:47:11', '登录', '用户通过身份验证进入系统', '122.234.50.110', 35),
(596, '刘苗芳', 24, '2012-09-05 14:48:36', '登录', '用户通过身份验证进入系统', '122.234.50.110', 95),
(597, '王五', 39, '2012-09-05 14:56:44', '登录', '用户通过身份验证进入系统', '122.234.50.110', 98),
(598, '管理员', 1, '2012-09-05 15:00:58', '登录', '用户通过身份验证进入系统', '122.234.50.110', 26),
(599, '程聪', 29, '2012-09-05 16:27:07', '登录', '用户通过身份验证进入系统', '122.234.50.110', 63),
(600, '刘苗芳', 24, '2012-09-05 16:42:15', '登录', '用户通过身份验证进入系统', '122.234.50.110', 77),
(601, '管理员', 1, '2012-09-05 22:27:46', '登录', '用户通过身份验证进入系统', '218.108.223.233', 28),
(602, '管理员', 1, '2012-09-05 23:54:38', '登录', '用户通过身份验证进入系统', '218.108.223.233', 25),
(603, '管理员', 1, '2012-09-06 12:06:24', '登录', '用户通过身份验证进入系统', '127.0.0.1', 1094);

-- --------------------------------------------------------

--
-- 資料表格式： `app_system_work_content`
--

CREATE TABLE IF NOT EXISTS `app_system_work_content` (
  `cnt_id` bigint(20) unsigned NOT NULL auto_increment COMMENT '工作内容ID',
  `item_name` varchar(120) default NULL COMMENT '选项名称',
  `item_value` varchar(120) default NULL COMMENT '选项值',
  `meto` varchar(250) default NULL COMMENT '工作内容说明',
  `district_id` bigint(20) NOT NULL COMMENT '校区ID',
  `update_time` datetime default NULL COMMENT '修改时间',
  PRIMARY KEY  (`cnt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统工作内容设置' AUTO_INCREMENT=11 ;

--
-- 列出以下資料庫的數據： `app_system_work_content`
--

INSERT INTO `app_system_work_content` (`cnt_id`, `item_name`, `item_value`, `meto`, `district_id`, `update_time`) VALUES
(4, '行政', '行政', '', 1, '2012-07-26 12:47:43'),
(5, '教学', '教学', '', 1, '2012-07-26 12:48:11'),
(6, '校区行政', '校区行政', '', 3, '2012-07-26 12:48:48'),
(7, '教学', '教学', '', 3, '2012-07-26 12:48:57'),
(8, '咨询', '咨询', '', 3, '2012-07-26 12:49:08'),
(9, '教学', '教学', '', 4, '2012-07-26 12:49:32'),
(10, '咨询', '咨询', '', 4, '2012-07-26 12:49:38');

-- --------------------------------------------------------

--
-- 資料表格式： `app_system_work_template`
--

CREATE TABLE IF NOT EXISTS `app_system_work_template` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='工作模板设置' AUTO_INCREMENT=19 ;

--
-- 列出以下資料庫的數據： `app_system_work_template`
--

INSERT INTO `app_system_work_template` (`work_tpl_id`, `work_day`, `worktm_id`, `district_id`, `staff_id`, `staff_name`, `enable`, `template_id`, `workcnt_id`) VALUES
(12, '周一', 4, 1, 20, '梅杰', '1', 1, 4),
(13, '周一', 4, 1, 19, '罗佳驹', '1', 1, 4),
(14, '周二', 4, 1, 25, '周碧英', '0', 1, 4),
(15, '周二', 4, 1, 40, '张三', '0', 1, 4),
(16, '周二', 4, 1, 21, '林菁菁', '0', 1, 4),
(17, '周二', 4, 1, 37, '林立', '0', 1, 4),
(18, '周二', 4, 1, 26, '蒋晓萍', '0', 1, 4);

-- --------------------------------------------------------

--
-- 資料表格式： `app_system_work_time`
--

CREATE TABLE IF NOT EXISTS `app_system_work_time` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='工作时间设置' AUTO_INCREMENT=10 ;

--
-- 列出以下資料庫的數據： `app_system_work_time`
--

INSERT INTO `app_system_work_time` (`worktm_id`, `item_name`, `work_stime`, `work_etime`, `meto`, `adjust_days`, `template_id`, `district_id`, `update_time`) VALUES
(4, '早班', '8:30', '17:30', '', '周一,周二,周三,周四,周五', 1, 1, '2012-07-26 12:50:09'),
(5, '周末早班', '9:00', '17:00', '', '周六,周日', 1, 1, '2012-07-26 12:50:45'),
(6, '晚班', '18:30', '21:00', '', '周一,周二,周三,周四,周五', 1, 1, '2012-07-26 12:51:13'),
(7, '统班', '8:30', '20:30', '', '周一,周二,周三,周四,周五,周六,周日', 2, 1, '2012-07-26 12:52:02'),
(8, '早班', '8:00', '17:00', '', '周一,周二,周三,周四,周五,周六,周日', 1, 3, '2012-07-26 13:19:14'),
(9, '晚班', '18:40', '21:00', '', '周一,周二,周三,周四,周五,周六,周日', 1, 3, '2012-07-26 13:19:47');

-- --------------------------------------------------------

--
-- 資料表格式： `app_user`
--

CREATE TABLE IF NOT EXISTS `app_user` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表' AUTO_INCREMENT=42 ;

--
-- 列出以下資料庫的數據： `app_user`
--

INSERT INTO `app_user` (`user_id`, `username`, `password`, `fullname`, `email`, `dep_id`, `pos_id`, `district_id`, `emp_id`, `phone`, `mobile`, `fax`, `address`, `zip`, `photo`, `status`, `del_flag`, `logon_lastip`, `logon_lastime`) VALUES
(1, 'admin', 'EnLjjIJbi/0cC5I/37fNMi9OR654kEHf7z3k1Le4wt4=', '管理员', 'csx@jee-soft.cn', NULL, 26, 1, 19, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '127.0.0.1', '2012-09-06 12:06:24'),
(19, '00001001', 'ro+N+ETeTFw+SYrc4TnIzXuXWwO93mUJgr0ArrsNPfk=', '罗佳驹', NULL, 15, 26, 1, 19, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.119.191.43', '2012-08-31 11:45:38'),
(20, '00001002', 'YtwP6mUL0cqp45wC4yCgaYVYKkKWE4LUtMn1mqljowc=', '梅杰', NULL, 15, 13, 1, 20, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.119.191.43', '2012-08-31 11:07:37'),
(21, '00003001', 'mxA4ujFL57JAzeke5W87Cujn+35uwD+aKrCuNK4f+6A=', '林菁菁', NULL, 17, 39, 1, 21, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.50.110', '2012-09-05 11:15:47'),
(22, '00004001', 'p0TBRM7B1PaLy7I3j+aXC7xeOeBwzBU7pF6IxMFGLOg=', '许玉凤', NULL, 22, 40, 1, 22, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '0:0:0:0:0:0:0:1', '2012-08-31 00:58:20'),
(23, '00005001', 'B4aIJZIEodZjpMtGatbKbo46E2vBzRJBFmJPmW2frYI=', '王伟平', NULL, 23, 42, 1, 23, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '0:0:0:0:0:0:0:1', '2012-08-30 20:58:01'),
(24, '00002001', '/4xWL9bhPAve03Tu5HeR7T0U6Qsmy6eYjLtZM4aAcFs=', '刘苗芳', NULL, 16, 14, 1, 24, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.50.110', '2012-09-05 16:42:15'),
(25, '00003002', 'CqfBdfhjcLbqOIDd62kTxYiDhAbXBkgFrv8eH8/fpQw=', '周碧英', NULL, 17, 28, 1, 25, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.50.110', '2012-09-05 11:44:06'),
(26, '00003003', '8t8/A0jkYHUyLfiJtVydFhZ0Q/X2xuJ1LGJUPHLs4Zk=', '蒋晓萍', NULL, 17, 17, 1, 26, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL),
(27, '00006001', 'AdR3o6rcgoyXwyqu2QCIn/IbWgsYIfDIbybGB7ESK+k=', '杨琪', NULL, 24, 45, 1, 27, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.50.110', '2012-09-05 13:15:14'),
(28, '00005002', 'VmQ2dhyZSxuzomLV9mx1T+y2Fl7rkdxAxIkbDN7dWT4=', '何滨', NULL, 23, 43, 1, 28, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.54.76', '2012-08-31 16:28:18'),
(29, '00002002', 'VH4xR+A+M04zzSSzxg3T2osRhsB1+1gJYxVjJ38uk4E=', '程聪', NULL, 16, 29, 1, 29, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.50.110', '2012-09-05 16:27:07'),
(30, '00005003', 'yFKhbyaKjjizMHXNo0w0Kp45bl/g3/5fRBNJKMmq8t0=', '苏斯翔', NULL, 23, 43, 1, 30, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '0:0:0:0:0:0:0:1', '2012-08-01 11:22:01'),
(31, '00066001', 'rfm23G77+wfY8xG9pX4eAfGkp4XWzHxVXuy1HIyOApU=', '俞柏红', NULL, 20, 25, 8, 31, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '0:0:0:0:0:0:0:1', '2012-07-31 19:58:00'),
(32, '00076001', 'anI9MmTiyrzAeGYpjdEtqIbc4+5HsOweg6X7o1JNQjA=', '蔡晓喻', NULL, 20, 30, 9, 32, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.119.191.43', '2012-08-29 15:33:38'),
(33, '00056001', '5Rsppf8nmetp92hxvHFFEXJtj7V8d4z1CYA/bHSaXfM=', '章荷英', NULL, 20, 25, 7, 33, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.119.191.43', '2012-08-29 15:37:10'),
(34, '00046001', '3pnDrR8cXanV8I/+PMniD+bMPmu4AFZjmRF+SCA73yQ=', '冯毓', NULL, 20, 30, 6, 34, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.119.191.43', '2012-08-29 14:35:12'),
(35, '00036001', 'XmV3a5D8g46S/4qJugvbYAy4y1z6wF+b1tzU3C/37P4=', '陈蕾红', NULL, 20, 25, 5, 35, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL),
(36, '00006002', 'gfbTaJlUYHQ1K6VFo1nJ+W4jxm7NEPtO9Kl3H4xm070=', 'ljx', NULL, 24, 44, 1, 36, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.50.110', '2012-09-05 13:43:57'),
(37, '00003004', '8JxP5z5ukGlNHehkcTvpwUFoej2ycC+LHDt785I/Cos=', '林立', NULL, 17, 16, 1, 37, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.118.54.30', '2012-08-03 16:38:24'),
(38, '00002003', 'o6jZ7Lxg57/kkJH9OePxJ3cC1T/2LlIqSvl7nktA2a0=', 'leo', NULL, 16, 15, 1, 38, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.50.110', '2012-09-05 14:47:11'),
(39, '00007001', '43SR/pN08G7VG7blZRqCJsvH0v4A17O1NR3jj1D+03I=', '王五', NULL, 26, 46, 1, 39, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.50.110', '2012-09-05 14:56:44'),
(40, '00003005', 'gwb9fKCRirZHqclTiCgzuDLoeKkLyXSzq4r1ThhP+lw=', '张三', NULL, 17, 17, 1, 40, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.119.191.43', '2012-08-31 11:11:11'),
(41, '00003006', 'APY8VbC/IsTmZfudWjDiVuA0IGmEh1T/JNJEnzhwKYo=', '林锦贤', NULL, 24, 45, 1, 41, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表格式： `app_user_role`
--

CREATE TABLE IF NOT EXISTS `app_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限表';

--
-- 列出以下資料庫的數據： `app_user_role`
--


-- --------------------------------------------------------

--
-- Structure for view `app_admin_attendance_view`
--
DROP TABLE IF EXISTS `app_admin_attendance_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `app_admin_attendance_view` AS select _utf8'attendance' AS `origin`,`app_admin_attendance`.`attend_id` AS `attendance_view_id`,`app_admin_attendance`.`work_date` AS `work_date`,`app_admin_attendance`.`work_time` AS `work_time`,`app_admin_attendance`.`offtime_shour` AS `offtime_shour`,`app_admin_attendance`.`offtime_ehour` AS `offtime_ehour`,`app_admin_attendance`.`offtime_smin` AS `offtime_smin`,`app_admin_attendance`.`offtime_emin` AS `offtime_emin`,`app_admin_attendance`.`staff_id` AS `staff_id`,`app_admin_attendance`.`staff_name` AS `staff_name`,`app_admin_attendance`.`work_type` AS `work_type`,`app_admin_attendance`.`work_status` AS `work_status`,`app_admin_attendance`.`leave_type` AS `leave_type`,`app_admin_attendance`.`staff_behalf_name` AS `staff_behalf_name`,`app_admin_attendance`.`staff_behalf_id` AS `staff_behalf_id`,`app_admin_attendance`.`meto` AS `meto`,`app_admin_attendance`.`attendance_result` AS `attendance_result`,`app_admin_attendance`.`exception` AS `exception`,`app_admin_attendance`.`dep_id` AS `dep_id`,`app_admin_attendance`.`district_id` AS `district_id` from `app_admin_attendance` union select _utf8'arrange' AS `origin`,`app_admin_workarrange`.`work_id` AS `attendance_view_id`,`app_admin_workarrange`.`work_date` AS `work_date`,concat(`app_system_work_time`.`work_stime`,_utf8'-',`app_system_work_time`.`work_etime`) AS `work_time`,NULL AS `offtime_shour`,NULL AS `offtime_ehour`,NULL AS `offtime_smin`,NULL AS `offtime_emin`,`app_admin_workarrange`.`staff_id` AS `staff_id`,`app_admin_workarrange`.`staff_name` AS `staff_name`,`app_admin_workarrange`.`work_type` AS `work_type`,_utf8'0' AS `work_status`,NULL AS `leave_type`,NULL AS `staff_behalf_name`,NULL AS `staff_behalf_id`,NULL AS `meto`,_utf8'1' AS `attendance_result`,_utf8'0' AS `exception`,`app_admin_workarrange`.`dep_id` AS `dep_id`,`app_admin_workarrange`.`district_id` AS `district_id` from (`app_admin_workarrange` join `app_system_work_time`) where (isnull(`app_admin_workarrange`.`attend_id`) and (`app_admin_workarrange`.`work_time` = `app_system_work_time`.`worktm_id`));

--
-- 備份資料表限制
--

--
-- 資料表限制 `app_admin_doc`
--
ALTER TABLE `app_admin_doc`
  ADD CONSTRAINT `PK_author` FOREIGN KEY (`author_id`) REFERENCES `app_user` (`user_id`),
  ADD CONSTRAINT `PK_dcoType` FOREIGN KEY (`type_dicid`) REFERENCES `app_system_dictionary` (`id`),
  ADD CONSTRAINT `PK_department` FOREIGN KEY (`doc_postDepId`) REFERENCES `app_school_department` (`dep_id`),
  ADD CONSTRAINT `PK_district` FOREIGN KEY (`doc_postDistrictId`) REFERENCES `app_school_district` (`district_id`),
  ADD CONSTRAINT `PK_file` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`),
  ADD CONSTRAINT `PK_level` FOREIGN KEY (`doc_level_id`) REFERENCES `app_admin_doc_level` (`id`);

--
-- 資料表限制 `app_hrm_resume_file`
--
ALTER TABLE `app_hrm_resume_file`
  ADD CONSTRAINT `app_hrm_resume_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`);

--
-- 資料表限制 `app_process_definition`
--
ALTER TABLE `app_process_definition`
  ADD CONSTRAINT `app_process_definition_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_process_type` (`type_id`);

--
-- 資料表限制 `app_process_task`
--
ALTER TABLE `app_process_task`
  ADD CONSTRAINT `app_process_task_ibfk_1` FOREIGN KEY (`def_id`) REFERENCES `app_process_definition` (`def_id`) ON DELETE CASCADE;

  
ALTER TABLE `app_hrm_hire_job` CHANGE `hjob_visible_districtid` `hjob_visible_districtid` VARCHAR( 120 ) NULL DEFAULT NULL COMMENT '可见范围'