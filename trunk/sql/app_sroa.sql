-- phpMyAdmin SQL Dump
-- version 3.4.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 08 月 27 日 23:21
-- 服务器版本: 5.5.17
-- PHP 版本: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `app_sroa`
--

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_attendance`
--

CREATE TABLE IF NOT EXISTS `app_admin_attendance` (
  `attend_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '考勤ID',
  `work_date` date NOT NULL COMMENT '工作日期',
  `work_time` varchar(64) NOT NULL COMMENT '工作时间',
  `offtime_shour` varchar(11) DEFAULT NULL COMMENT '实际下班时间 - 打卡小时 (上)',
  `offtime_ehour` varchar(11) DEFAULT NULL COMMENT '实际下班时间 - 打卡分钟 (上)',
  `offtime_smin` varchar(11) DEFAULT NULL COMMENT '实际下班时间 - 打卡小时 (下)',
  `offtime_emin` varchar(11) DEFAULT NULL COMMENT '实际下班时间 - 打卡分钟 (下)',
  `staff_id` bigint(20) NOT NULL COMMENT '员工ID',
  `staff_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `work_type` tinyint(4) NOT NULL COMMENT '上班类型, 1=正常上班,2=调休加班, 3=带薪加班, 4=倍薪加班',
  `work_status` tinyint(4) NOT NULL COMMENT '上班状态， 0=在岗, 1=出差, 2=请假',
  `leave_type` char(1) DEFAULT NULL COMMENT '请假类型',
  `staff_behalf_name` varchar(64) DEFAULT NULL COMMENT '代班员工姓名',
  `staff_behalf_id` bigint(20) DEFAULT NULL COMMENT '代班员工ID',
  `meto` varchar(250) DEFAULT NULL COMMENT '说明 (请假说明, 旷工说明)',
  `attendance_result` char(1) DEFAULT NULL COMMENT '考勤结果,1:按时,2:迟到,3:早退,4:迟到早退',
  `exception` char(1) DEFAULT NULL COMMENT '数据是否异常,0:正常,1:异常',
  `dep_id` bigint(20) DEFAULT NULL COMMENT '员工所在部门ID',
  `district_id` bigint(20) DEFAULT NULL COMMENT '员工所在校区ID',
  PRIMARY KEY (`attend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-员工考勤' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 替换视图以便查看 `app_admin_attendance_view`
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
,`work_status` varchar(4)
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
-- 表的结构 `app_admin_conference`
--

CREATE TABLE IF NOT EXISTS `app_admin_conference` (
  `conference_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `conference_name` varchar(45) DEFAULT NULL,
  `conference_level` varchar(45) DEFAULT NULL,
  `district_id` bigint(20) DEFAULT NULL,
  `depart_id` bigint(20) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `start_day` date DEFAULT NULL,
  `start_hour` varchar(45) DEFAULT NULL,
  `start_minute` varchar(45) DEFAULT NULL,
  `end_day` date DEFAULT NULL,
  `end_hour` varchar(45) DEFAULT NULL,
  `end_minute` varchar(45) DEFAULT NULL,
  `attendances` text,
  `count` int(11) DEFAULT NULL,
  `contactor` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `content` text,
  `status` char(1) DEFAULT NULL COMMENT '1:已发起,2:已结束,3:已取消',
  `sponsor` bigint(20) DEFAULT NULL COMMENT '发起者',
  `summary` text,
  `conference_type` bigint(20) DEFAULT NULL,
  `attendances_ids` varchar(200) DEFAULT NULL COMMENT '参会人员ID',
  PRIMARY KEY (`conference_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='会议表' AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_doc`
--

CREATE TABLE IF NOT EXISTS `app_admin_doc` (
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
  `file_id` bigint(20) DEFAULT NULL COMMENT '附件id',
  PRIMARY KEY (`doc_id`),
  KEY `PK_range` (`doc_VisiableRange_id`),
  KEY `PK_level` (`doc_level_id`),
  KEY `PK_district` (`doc_postDistrictId`),
  KEY `PK_department` (`doc_postDepId`),
  KEY `PK_author` (`author_id`),
  KEY `PK_dcoType` (`type_dicid`),
  KEY `PK_file` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-文档' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_doc_level`
--

CREATE TABLE IF NOT EXISTS `app_admin_doc_level` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `level_name` varchar(100) DEFAULT NULL COMMENT '文档级别名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='文档级别' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_admin_doc_level`
--

INSERT INTO `app_admin_doc_level` (`id`, `level_name`) VALUES
(1, '公司级别'),
(2, '校区级别'),
(3, '校区部门级别'),
(4, '总部对口部门级别');

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_doc_visiable_range`
--

CREATE TABLE IF NOT EXISTS `app_admin_doc_visiable_range` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `visiable_name` varchar(100) DEFAULT NULL COMMENT '文档范围名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='文档范围' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_admin_doc_visiable_range`
--

INSERT INTO `app_admin_doc_visiable_range` (`id`, `visiable_name`) VALUES
(1, '所有校区'),
(2, '设置个人可见'),
(3, '杭州总部'),
(4, '萧山校区');

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_news`
--

CREATE TABLE IF NOT EXISTS `app_admin_news` (
  `news_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_dicid` bigint(20) NOT NULL COMMENT '新闻类型id (来自系统字典)',
  `news_subject` varchar(128) NOT NULL COMMENT '新闻标题',
  `news_content` text NOT NULL COMMENT '新闻内容',
  `author_id` bigint(20) NOT NULL COMMENT '新闻作者ID',
  `author_name` varchar(120) NOT NULL COMMENT '新闻作者名',
  `news_level` tinyint(4) NOT NULL COMMENT '新闻级别, 0=公司新闻, 1=校区新闻',
  `district_visible` bigint(20) DEFAULT NULL COMMENT '可见校区',
  `district_post` bigint(20) NOT NULL COMMENT '发布校区',
  `dep_post` bigint(20) NOT NULL COMMENT '发布部门',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '最后更新时间',
  `top_index` int(11) DEFAULT NULL COMMENT '置顶序号',
  `status` smallint(6) NOT NULL COMMENT '0=草稿, 1=已发布并待审核, 2=审核通过, 3=审批退回',
  `auditor` bigint(20) DEFAULT NULL COMMENT '审批人',
  `audit_time` datetime DEFAULT NULL COMMENT '审批时间',
  PRIMARY KEY (`news_id`),
  KEY `type_id` (`type_dicid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻' AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `app_admin_news`
--

INSERT INTO `app_admin_news` (`news_id`, `type_dicid`, `news_subject`, `news_content`, `author_id`, `author_name`, `news_level`, `district_visible`, `district_post`, `dep_post`, `createtime`, `updateTime`, `top_index`, `status`, `auditor`, `audit_time`) VALUES
(4, 3, 'news1', 'test<br />', 1, 'admin', 0, NULL, 1, 15, '2012-08-23 11:25:49', '2012-08-23 11:25:49', 0, 1, NULL, NULL),
(5, 3, 'news2', '', 1, 'admin', 0, NULL, 3, 18, '2012-08-23 11:26:17', '2012-08-23 11:26:17', 0, 1, NULL, NULL),
(6, 3, 'new3', 'news3<br />', 21, '00003001', 0, NULL, 1, 15, '2012-08-23 13:04:49', '2012-08-23 13:04:49', 0, 1, NULL, NULL),
(7, 3, 'news111', '', 1, 'admin', 0, NULL, 1, 15, '2012-08-23 15:47:32', '2012-08-23 15:47:32', 0, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_news_file`
--

CREATE TABLE IF NOT EXISTS `app_admin_news_file` (
  `news_id` bigint(20) NOT NULL COMMENT '新闻ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY (`news_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻文件关联表';

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_task`
--

CREATE TABLE IF NOT EXISTS `app_admin_task` (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_dicid` bigint(20) NOT NULL COMMENT '任务类型Id (来自系统字典)',
  `task_name` varchar(120) NOT NULL COMMENT '任务名称',
  `task_originator` bigint(20) NOT NULL COMMENT '任务发起人',
  `task_charger` bigint(20) NOT NULL COMMENT '任务负责人',
  `task_charger_depid` bigint(20) DEFAULT NULL COMMENT '任务负责人所属部门ID',
  `task_charger_disid` bigint(20) DEFAULT NULL COMMENT '任务负责人所属校区ID',
  `task_planStartDate` date NOT NULL COMMENT '任务计划开始时间',
  `task_planEndDate` date NOT NULL COMMENT '任务计划终止时间',
  `task_actualFinishDate` date DEFAULT NULL COMMENT '任务实际完成时间',
  `task_desc` text COMMENT '任务描述',
  `task_participant_ids` varchar(120) DEFAULT NULL COMMENT '任务参与人ID列表',
  `task_participant_names` varchar(250) DEFAULT NULL COMMENT '任务参与人名称列表',
  `task_status` tinyint(4) DEFAULT NULL COMMENT '任务状态',
  `approval_status` tinyint(4) DEFAULT NULL COMMENT '审批状态',
  `auditor` bigint(20) DEFAULT NULL COMMENT '审批人',
  `audit_time` datetime DEFAULT NULL COMMENT '审批时间',
  `create_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY (`task_id`),
  KEY `approval_status` (`approval_status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托' AUTO_INCREMENT=18 ;

--
-- 转存表中的数据 `app_admin_task`
--

INSERT INTO `app_admin_task` (`task_id`, `type_dicid`, `task_name`, `task_originator`, `task_charger`, `task_charger_depid`, `task_charger_disid`, `task_planStartDate`, `task_planEndDate`, `task_actualFinishDate`, `task_desc`, `task_participant_ids`, `task_participant_names`, `task_status`, `approval_status`, `auditor`, `audit_time`, `create_time`) VALUES
(14, 7, 'task1', 19, 20, 15, 1, '2012-08-23', '2012-08-24', NULL, '', '19,20', '罗佳驹,梅杰', NULL, 2, 21, '2012-08-23 11:51:07', '2012-08-23 11:35:25'),
(15, 7, 'task2', 19, 19, 15, 1, '2012-08-23', '2012-08-23', NULL, '12123', '29,24', '程聪,刘苗芳', 2, 2, 19, '2012-08-23 16:29:14', '2012-08-23 12:01:01'),
(16, 7, 'task3', 19, 19, 15, 1, '2012-08-23', '2012-08-27', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2012-08-23 16:33:36'),
(17, 7, 'task4', 19, 19, 15, 1, '2012-08-07', '2012-08-09', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2012-08-23 16:36:02');

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_task_file`
--

CREATE TABLE IF NOT EXISTS `app_admin_task_file` (
  `task_id` bigint(20) NOT NULL COMMENT '任务ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY (`task_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托文件关联表';

--
-- 转存表中的数据 `app_admin_task_file`
--

INSERT INTO `app_admin_task_file` (`task_id`, `file_id`) VALUES
(16, 58);

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_task_participants`
--

CREATE TABLE IF NOT EXISTS `app_admin_task_participants` (
  `task_id` bigint(20) NOT NULL,
  `emp_id` bigint(20) NOT NULL,
  PRIMARY KEY (`task_id`,`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务参与人';

--
-- 转存表中的数据 `app_admin_task_participants`
--

INSERT INTO `app_admin_task_participants` (`task_id`, `emp_id`) VALUES
(14, 19),
(14, 20),
(15, 24),
(15, 29);

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_task_tracks`
--

CREATE TABLE IF NOT EXISTS `app_admin_task_tracks` (
  `track_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) NOT NULL COMMENT '任务ID',
  `task_applyTime` date NOT NULL COMMENT '申请时间',
  `task_applyType` tinyint(4) NOT NULL COMMENT '申请类型',
  `task_applyFinalTime` date NOT NULL COMMENT '申请完成时间/延期时间',
  `task_applyMeto` text COMMENT '申请描述',
  `task_auditState` tinyint(4) DEFAULT NULL COMMENT '审批状态',
  `task_auditFinalTime` date DEFAULT NULL COMMENT '审批确认完成/延期时间',
  `task_auditMeto` text COMMENT '审批描述',
  `task_auditTime` datetime DEFAULT NULL COMMENT '审批时间',
  `auditor` bigint(20) DEFAULT NULL COMMENT '审批人',
  PRIMARY KEY (`track_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='任务委托审批记录' AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `app_admin_task_tracks`
--

INSERT INTO `app_admin_task_tracks` (`track_id`, `task_id`, `task_applyTime`, `task_applyType`, `task_applyFinalTime`, `task_applyMeto`, `task_auditState`, `task_auditFinalTime`, `task_auditMeto`, `task_auditTime`, `auditor`) VALUES
(12, 15, '2012-08-23', 0, '2012-08-24', '123', 1, '2012-08-23', '', '2012-08-23 16:31:27', 19);

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_workarrange`
--

CREATE TABLE IF NOT EXISTS `app_admin_workarrange` (
  `work_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '工作ID',
  `work_date` date NOT NULL COMMENT '工作日期',
  `work_time` bigint(20) NOT NULL COMMENT '工作时间',
  `staff_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `staff_id` bigint(20) NOT NULL COMMENT '员工ID',
  `work_type` int(5) DEFAULT NULL COMMENT '上班类型',
  `work_content` bigint(20) DEFAULT NULL COMMENT '工作内容',
  `district_id` bigint(20) DEFAULT NULL COMMENT '员工所在校区',
  `attend_id` bigint(20) DEFAULT NULL COMMENT '对应的考勤记录',
  `dep_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`work_id`),
  KEY `PK_user` (`staff_id`),
  KEY `PK_type` (`work_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-工作安排' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_worktype`
--

CREATE TABLE IF NOT EXISTS `app_admin_worktype` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL COMMENT '工作类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_admin_worktype`
--

INSERT INTO `app_admin_worktype` (`id`, `type`) VALUES
(1, '正常上班'),
(2, '调休加班'),
(3, '带薪加班'),
(4, '倍薪加班');

-- --------------------------------------------------------

--
-- 表的结构 `app_conference_file`
--

CREATE TABLE IF NOT EXISTS `app_conference_file` (
  `conference_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  PRIMARY KEY (`conference_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会议文件';

-- --------------------------------------------------------

--
-- 表的结构 `app_file_attach`
--

CREATE TABLE IF NOT EXISTS `app_file_attach` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='附件' AUTO_INCREMENT=59 ;

--
-- 转存表中的数据 `app_file_attach`
--

INSERT INTO `app_file_attach` (`file_id`, `file_name`, `file_path`, `createtime`, `file_ext`, `file_type`, `note`, `creator`, `creator_id`, `file_bytes`, `del_flag`) VALUES
(56, '123.txt', 'others/201208/e1f0382e83114625a11e9a8675a41de6.txt', '2012-08-23 14:44:20', 'txt', 'others', '18.0 bytes', 'Unknow', NULL, 18, 0),
(57, '123.txt', 'others/201208/6f748df172d44439bed769f424458fc9.txt', '2012-08-23 16:10:00', 'txt', 'others', '18.0 bytes', 'Unknow', NULL, 18, 0),
(58, '123.txt', 'others/201208/46e60b47022c4ee0bc79e160de01cb03.txt', '2012-08-23 16:33:34', 'txt', 'others', '18.0 bytes', 'Unknow', NULL, 18, 0);

-- --------------------------------------------------------

--
-- 表的结构 `app_finan_contract`
--

CREATE TABLE IF NOT EXISTS `app_finan_contract` (
  `contract_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_form_no` varchar(120) NOT NULL COMMENT '申请单号',
  `apply_form_type` bigint(20) NOT NULL COMMENT '合同申请类型',
  `emp_id` bigint(20) NOT NULL COMMENT '经办人 (申请人)',
  `emp_district` bigint(20) NOT NULL COMMENT '员工所属校区',
  `emp_dep` bigint(20) NOT NULL COMMENT '员工所属部门',
  `emp_phone_no` varchar(24) NOT NULL COMMENT '员工联系电话',
  `apply_date` date NOT NULL COMMENT '申请时间',
  `comments` text COMMENT '合同事项说明',
  `apply_amt` double NOT NULL COMMENT '合同总金额',
  `contract_no` varchar(120) DEFAULT NULL COMMENT '合同编号',
  `contract_parties` varchar(120) DEFAULT NULL COMMENT '合同签约方',
  `contract_parties_contact` varchar(120) DEFAULT NULL COMMENT '合同签约方联系方式',
  `pay_method` varchar(150) DEFAULT NULL COMMENT '付款方式',
  `audit_state` tinyint(4) DEFAULT NULL COMMENT '审核状态, 1=审核中, 2=审核通过 3=审核不通过, 4=审核被退回...',
  `entry_id` bigint(20) NOT NULL COMMENT '录入人员',
  `entry_datetime` datetime NOT NULL COMMENT '录入时间',
  `cproc_depid` bigint(20) DEFAULT NULL COMMENT '当前审批环节部门ID',
  `cproc_posid` bigint(20) DEFAULT NULL COMMENT '当前审批岗位ID',
  PRIMARY KEY (`contract_id`),
  KEY `apply_form_no` (`apply_form_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='合同申请' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_finan_contract`
--

INSERT INTO `app_finan_contract` (`contract_id`, `apply_form_no`, `apply_form_type`, `emp_id`, `emp_district`, `emp_dep`, `emp_phone_no`, `apply_date`, `comments`, `apply_amt`, `contract_no`, `contract_parties`, `contract_parties_contact`, `pay_method`, `audit_state`, `entry_id`, `entry_datetime`, `cproc_depid`, `cproc_posid`) VALUES
(4, 'FC20120823131534', 8, 19, 1, 15, '13575747066', '2012-08-23', '', 100, '', '123', '123123123', '', NULL, 1, '2012-08-23 13:15:34', NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_finan_expense`
--

CREATE TABLE IF NOT EXISTS `app_finan_expense` (
  `expense_id` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `audit_state` bigint(20) DEFAULT NULL COMMENT '审核状态, 1=审核中, 2=审核通过 3=审核不通过, 4=审核被退回...',
  `entry_id` bigint(20) DEFAULT NULL,
  `entry_datetime` datetime DEFAULT NULL,
  `cproc_depid` bigint(20) DEFAULT NULL COMMENT '当前审批环节部门ID',
  `cproc_posid` bigint(20) DEFAULT NULL COMMENT '当前审批岗位ID',
  PRIMARY KEY (`expense_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_finan_expense`
--

INSERT INTO `app_finan_expense` (`expense_id`, `apply_form_no`, `apply_form_type`, `apply_date`, `comments`, `emp_id`, `emp_district`, `emp_dep`, `emp_phone_no`, `apply_amt`, `payer`, `contract_no`, `attach_count`, `audit_advance`, `asset_no`, `amt_receiver`, `amt_receiver_contact`, `pay_method`, `bank`, `account_name`, `account_no`, `status`, `audit_state`, `entry_id`, `entry_datetime`, `cproc_depid`, `cproc_posid`) VALUES
(1, 'FE20120823131329', 7, '2012-08-23', '', 19, 1, 15, '13575747066', 100, NULL, '', '', NULL, '', '12', '1231213', 0, '', '', '', NULL, 3, 1, '2012-08-23 13:13:29', NULL, NULL),
(2, 'FE20120823145140', 9, '2012-08-23', '', 25, 1, 17, '057188321763', 123, NULL, '133123', '', NULL, '', '12', '12323213', 1, '23', '132', '1223', NULL, 4, 25, '2012-08-23 14:51:40', NULL, NULL),
(3, 'FE20120823150120', 7, '2012-08-23', '123', 21, 1, 17, '13968155954', 100, NULL, '', '', NULL, '', '123', '123123213', 0, '', '', '', NULL, 2, 1, '2012-08-23 15:01:20', NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_function`
--

CREATE TABLE IF NOT EXISTS `app_function` (
  `func_id` int(11) NOT NULL AUTO_INCREMENT,
  `func_key` varchar(60) NOT NULL COMMENT '功能key',
  `func_name` varchar(120) NOT NULL COMMENT '功能名称',
  `func_icon` varchar(32) DEFAULT NULL COMMENT '功能显示图片',
  `func_desc` varchar(150) DEFAULT NULL COMMENT '功能描述',
  `menu_id` bigint(20) NOT NULL COMMENT '所属菜单',
  `strategy_ids` varchar(120) DEFAULT NULL COMMENT '功能数据权限ID集合',
  PRIMARY KEY (`func_id`),
  UNIQUE KEY `func_key` (`func_key`),
  KEY `menu_id` (`menu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能表' AUTO_INCREMENT=160 ;

--
-- 转存表中的数据 `app_function`
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
(13, '_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL', '岗位管理-岗位审批', '', '对发布的岗位进行审批操作.', 48, NULL),
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
(159, '_FUNCKEY_ADMIN_ACCOUNT_DATA_LOAD', '用户数据加载', '', '', 26, '5,4,2,1');

-- --------------------------------------------------------

--
-- 表的结构 `app_function_strategy`
--

CREATE TABLE IF NOT EXISTS `app_function_strategy` (
  `stg_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '功能数据权限id',
  `func_id` bigint(20) DEFAULT NULL COMMENT '功能id',
  `stg_type` tinyint(4) NOT NULL COMMENT '数据策略类型',
  PRIMARY KEY (`stg_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能数据权限' AUTO_INCREMENT=144 ;

--
-- 转存表中的数据 `app_function_strategy`
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
(103, 155, 5),
(104, 155, 4),
(105, 155, 1),
(106, 155, 2),
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
(135, 147, 1),
(136, 147, 2),
(137, 147, 5),
(138, 147, 4),
(139, 148, 1),
(140, 148, 4),
(141, 148, 5),
(142, 148, 3),
(143, 148, 2);

-- --------------------------------------------------------

--
-- 表的结构 `app_function_url`
--

CREATE TABLE IF NOT EXISTS `app_function_url` (
  `url_id` int(11) NOT NULL AUTO_INCREMENT,
  `func_id` int(11) DEFAULT NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY (`url_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能URL' AUTO_INCREMENT=346 ;

--
-- 转存表中的数据 `app_function_url`
--

INSERT INTO `app_function_url` (`url_id`, `func_id`, `url_path`) VALUES
(21, 5, 'app/hrm/hire.do?action=hrmPageJobDetail'),
(24, 8, 'app/hrm/hire.do?action=actionJobOpenControl'),
(25, 10, 'app/hrm/hire.do?action=hrmPageJobResume'),
(26, 11, 'app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex'),
(28, 9, 'app/hrm/hire.do?action=hrmPageJobEntryIndex'),
(30, 12, 'app/hrm/hire.do?action=actionJobEntrySave'),
(31, 12, 'app/hrm/hire.do?action=hrmPageJobEntryDetail'),
(32, 13, 'app/hrm/hire.do?action=hrmPageJobApprovalIndex'),
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
(285, 128, 'app/admin/news.do?action=adminPageEntryApprovalIndex'),
(286, 129, 'app/admin.do?action=adminOprEntryRemove'),
(287, 130, 'app/admin.do?action=adminPageEntryDetail'),
(288, 131, 'app/admin.do?action=adminOprEntryFirst'),
(289, 132, 'app/admin.do?action=adminPageEntryDetail'),
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
(318, 143, 'app/personal/news.do?action=pageMyNews'),
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
(336, 155, 'app/finan/contract.do?action=pageFinaContractIndex'),
(337, 156, 'app/admin/news.do?action=adminPageEntryApprovalIndex'),
(342, 159, 'app/system/account.do?action=pageAccountIndex'),
(344, 147, 'app/admin/news.do?action=adminPageEntryIndex'),
(345, 148, 'app/admin/task.do?action=pageTaskDelegateIndex');

-- --------------------------------------------------------

--
-- 表的结构 `app_global_type`
--

CREATE TABLE IF NOT EXISTS `app_global_type` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(128) NOT NULL COMMENT '名称',
  `type_parent` bigint(20) DEFAULT NULL COMMENT '父节点',
  `type_key` varchar(64) NOT NULL COMMENT '节点的分类Key',
  `type_desc` varchar(150) DEFAULT NULL COMMENT '分类描述',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总分类表  用于显示树层次结构的分类 可以允许任何层次结构' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_archive`
--

CREATE TABLE IF NOT EXISTS `app_hrm_archive` (
  `archive_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `job_id` bigint(20) NOT NULL COMMENT '应聘岗位ID',
  `archive_source` tinyint(4) NOT NULL COMMENT '来源',
  `archive_star` tinyint(4) NOT NULL COMMENT '评定星级',
  PRIMARY KEY (`archive_id`),
  KEY `job_id` (`job_id`),
  KEY `resume_id` (`resume_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='公司人才库' AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_employee`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee` (
  `emp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_no` varchar(64) NOT NULL COMMENT '员工编号',
  `dep_id` bigint(20) NOT NULL COMMENT '员工所在部门ID',
  `district_id` bigint(20) NOT NULL COMMENT '员工所在校区ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `position_id` bigint(20) DEFAULT NULL COMMENT '岗位',
  `birthdate` date DEFAULT NULL COMMENT '出生日期',
  `phone_no` varchar(64) DEFAULT NULL COMMENT '电话',
  `short_no` varchar(64) DEFAULT NULL COMMENT '短号',
  `office_phone` varchar(64) DEFAULT NULL COMMENT '办公室电话',
  `urgency_contacts` varchar(64) DEFAULT NULL COMMENT '紧急联系人联系方式',
  `positive_due_date` date DEFAULT NULL COMMENT '待转正日期',
  `contract_end_date` date DEFAULT NULL COMMENT '合同到期日期',
  `onboard_status` bigint(20) DEFAULT NULL COMMENT '在职状态',
  `teacher_star` bigint(20) DEFAULT NULL,
  `consult_star` bigint(20) DEFAULT NULL,
  `teach_class` varchar(120) DEFAULT NULL,
  `teach_subject` varchar(120) DEFAULT NULL,
  `resume_id` bigint(20) DEFAULT NULL COMMENT '简历',
  `status` char(10) DEFAULT NULL COMMENT '员工状态',
  `onboard_date` date DEFAULT NULL COMMENT '到岗日期',
  `entry_id` bigint(20) DEFAULT NULL COMMENT '录入人员',
  `entry_datetime` datetime DEFAULT NULL COMMENT '录入日期',
  `bankNo` varchar(30) DEFAULT NULL COMMENT '银行账号',
  PRIMARY KEY (`emp_id`),
  UNIQUE KEY `emp_no` (`emp_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工档案表' AUTO_INCREMENT=39 ;

--
-- 转存表中的数据 `app_hrm_employee`
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
(34, '00046001', 20, 6, '冯毓', 30, NULL, '15858332937', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 53, NULL, '2011-12-08', 1, '2012-07-31 13:21:08', NULL),
(35, '00036001', 20, 5, '陈蕾红', 25, NULL, '13626868497', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 54, NULL, '2011-11-09', 1, '2012-07-31 13:21:50', NULL),
(36, '00006002', 24, 1, 'ljx', 44, NULL, '28056121', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 55, NULL, '2012-07-31', 1, '2012-07-31 21:37:38', NULL),
(37, '00003004', 17, 1, '林立', 16, NULL, '28056121', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 28, NULL, '2012-08-03', 19, '2012-08-03 16:37:55', NULL),
(38, '00002003', 16, 1, 'leo', 15, NULL, '123123123', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 60, NULL, '2012-08-24', 19, '2012-08-23 16:04:32', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_employee_develop`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee_develop` (
  `develop_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_form_no` varchar(120) NOT NULL COMMENT '人资审批流程',
  `apply_form_type` bigint(20) NOT NULL COMMENT '人资申请类型',
  `apply_date` date NOT NULL COMMENT '申请时间',
  `comments` longtext COMMENT '申请报告',
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `onboard_date` date DEFAULT NULL COMMENT '到岗日期',
  `from_district` bigint(20) DEFAULT NULL COMMENT '原校区',
  `from_dep` bigint(20) DEFAULT NULL COMMENT '原部门',
  `from_position` bigint(20) DEFAULT NULL COMMENT '原岗位',
  `to_district` bigint(20) DEFAULT NULL COMMENT '申请校区',
  `to_department` bigint(20) DEFAULT NULL COMMENT '申请部门',
  `to_position` bigint(20) DEFAULT NULL COMMENT '申请岗位',
  `status` char(1) DEFAULT NULL,
  `audit_state` bigint(20) DEFAULT NULL,
  `op_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '操作状态, 0=未操作, 1=已操作 ',
  `entry_id` bigint(20) DEFAULT NULL,
  `entry_datetime` datetime DEFAULT NULL COMMENT '录入时间',
  `cproc_depid` bigint(20) DEFAULT NULL COMMENT '当前审批环节部门ID',
  `cproc_posid` bigint(20) DEFAULT NULL COMMENT '当前审批岗位ID',
  PRIMARY KEY (`develop_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='人资申请' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_hrm_employee_develop`
--

INSERT INTO `app_hrm_employee_develop` (`develop_id`, `apply_form_no`, `apply_form_type`, `apply_date`, `comments`, `emp_id`, `onboard_date`, `from_district`, `from_dep`, `from_position`, `to_district`, `to_department`, `to_position`, `status`, `audit_state`, `op_state`, `entry_id`, `entry_datetime`, `cproc_depid`, `cproc_posid`) VALUES
(3, 'HRM20120823131913', 4, '2012-08-23', '', 21, NULL, 1, 17, 39, 1, 15, 13, NULL, NULL, 0, 21, '2012-08-23 13:19:13', NULL, NULL),
(4, 'HRM20120823143646', 3, '2012-08-23', '12323', 25, NULL, 1, 17, 28, NULL, NULL, NULL, NULL, NULL, 0, 25, '2012-08-23 14:36:46', NULL, NULL),
(5, 'HRM20120823143752', 3, '2012-08-23', '', 25, NULL, 1, 17, 28, NULL, NULL, NULL, NULL, NULL, 0, 25, '2012-08-23 14:37:52', NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_employee_profile`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee_profile` (
  `profile_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `status` tinyint(4) NOT NULL COMMENT '员工状态',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工基本信息表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_employee_roadmap`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee_roadmap` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工历程' AUTO_INCREMENT=39 ;

--
-- 转存表中的数据 `app_hrm_employee_roadmap`
--

INSERT INTO `app_hrm_employee_roadmap` (`roadmap_id`, `emp_id`, `orginal_depid`, `orginal_districtid`, `orginal_positionid`, `dst_depid`, `dst_districtid`, `dst_positionid`, `type`, `date`) VALUES
(18, 19, 15, 1, 26, NULL, NULL, NULL, 1, '2009-07-01 00:00:00'),
(19, 20, 15, 1, 13, NULL, NULL, NULL, 1, '2009-07-01 00:00:00'),
(20, 21, 17, 1, 16, NULL, NULL, NULL, 1, '2010-07-01 00:00:00'),
(21, 22, 22, 1, 18, NULL, NULL, NULL, 1, '2011-05-01 00:00:00'),
(22, 23, 23, 1, 20, NULL, NULL, NULL, 1, '2009-07-01 00:00:00'),
(23, 24, 16, 1, 14, NULL, NULL, NULL, 1, '2009-07-01 00:00:00'),
(24, 25, 17, 1, 28, NULL, NULL, NULL, 1, '2011-08-23 00:00:00'),
(25, 26, 17, 1, 17, NULL, NULL, NULL, 1, '2011-09-19 00:00:00'),
(26, 27, 24, 1, 23, NULL, NULL, NULL, 1, '2012-05-01 00:00:00'),
(27, 28, 23, 1, 21, NULL, NULL, NULL, 1, '2012-04-05 00:00:00'),
(28, 29, 16, 1, 29, NULL, NULL, NULL, 1, '2012-05-07 00:00:00'),
(29, 30, 23, 1, 21, NULL, NULL, NULL, 1, '2012-05-01 00:00:00'),
(30, 31, 20, 8, 25, NULL, NULL, NULL, 1, '2011-10-19 00:00:00'),
(31, 32, 20, 9, 30, NULL, NULL, NULL, 1, '2012-05-31 00:00:00'),
(32, 33, 20, 7, 25, NULL, NULL, NULL, 1, '2011-04-01 00:00:00'),
(33, 34, 20, 6, 30, NULL, NULL, NULL, 1, '2011-12-08 00:00:00'),
(34, 35, 20, 5, 25, NULL, NULL, NULL, 1, '2011-11-09 00:00:00'),
(35, 36, 24, 1, 22, NULL, NULL, NULL, 1, '2012-07-31 00:00:00'),
(36, 19, 15, 1, 26, 16, 1, 14, 3, '2012-08-03 16:27:00'),
(37, 37, 17, 1, 16, NULL, NULL, NULL, 1, '2012-08-03 16:37:55'),
(38, 38, 16, 1, 15, NULL, NULL, NULL, 1, '2012-08-23 16:04:32');

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_entries`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_entries` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工入职安排表' AUTO_INCREMENT=17 ;

--
-- 转存表中的数据 `app_hrm_hire_entries`
--

INSERT INTO `app_hrm_hire_entries` (`entry_id`, `issue_id`, `district_id`, `dep_id`, `position_id`, `charger_id`, `plan_date`, `act_date`, `inspect_status`, `cstatus`, `fstatus`) VALUES
(16, 29, 1, 16, 15, 19, '2012-08-24 16:07:55', '2012-08-24 16:09:16', 1, 2, 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_interviews`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_interviews` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='招聘面试' AUTO_INCREMENT=16 ;

--
-- 转存表中的数据 `app_hrm_hire_interviews`
--

INSERT INTO `app_hrm_hire_interviews` (`hw_id`, `hissue_id`, `interview_address`, `interview_date`, `interviewer_id`, `meto`, `session_sn`, `state`, `comments`) VALUES
(15, 29, '111', '2012-08-23 15:15:49', 19, '', 1, 2, '');

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_interviews_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_interviews_file` (
  `interview_id` bigint(20) NOT NULL COMMENT '面试ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY (`interview_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='面试附件';

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_issue`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_issue` (
  `hissue_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `hjob_id` bigint(20) NOT NULL COMMENT '应聘职位ID',
  `hjobentry_id` bigint(20) DEFAULT NULL COMMENT '入职数据ID',
  `current_status` tinyint(4) NOT NULL COMMENT '当前状态',
  `final_result` tinyint(4) DEFAULT NULL COMMENT '最终处理结果',
  `user_id` bigint(20) DEFAULT NULL COMMENT '应聘者ID, 主要用于存员工申请 (包含自我申请, 推荐他人)',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY (`hissue_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='当前招聘' AUTO_INCREMENT=30 ;

--
-- 转存表中的数据 `app_hrm_hire_issue`
--

INSERT INTO `app_hrm_hire_issue` (`hissue_id`, `resume_id`, `hjob_id`, `hjobentry_id`, `current_status`, `final_result`, `user_id`, `apply_time`) VALUES
(29, 60, 12, NULL, 4, 1, 1, '2012-08-23 15:58:46');

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_job`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_job` (
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
  `entry_id` bigint(20) DEFAULT NULL COMMENT '岗位发布人员ID',
  `entry_time` datetime DEFAULT NULL COMMENT '岗位发布时间',
  PRIMARY KEY (`hjob_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='招聘岗位发布' AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `app_hrm_hire_job`
--

INSERT INTO `app_hrm_hire_job` (`hjob_id`, `job_title`, `hjob_districtid`, `hjob_depid`, `hjob_range`, `hjob_visible_districtid`, `end_date`, `hjob_count`, `hjob_condition`, `hjob_address`, `hjob_responsibility`, `hjob_salary`, `reg_fullname`, `reg_date`, `modify_fullname`, `modify_date`, `check_fullname`, `check_opinion`, `check_date`, `status`, `memo`, `isopen`, `entry_id`, `entry_time`) VALUES
(4, '校区总监', 3, 18, 1, NULL, '2012-07-26 00:00:00', 1, '', '', '', '', '管理员', '2012-07-26 13:43:27', NULL, NULL, NULL, NULL, NULL, 4, NULL, 1, NULL, NULL),
(5, '教师', 1, 16, 1, NULL, '2012-07-31 00:00:00', 10, '', '', '', '', '管理员', '2012-07-26 14:05:40', NULL, NULL, NULL, NULL, NULL, 4, NULL, 1, NULL, NULL),
(6, 'teat', 1, 15, 1, 3, '2012-07-24 00:00:00', 12, '', '213', '321', '', '管理员', '2012-07-29 03:02:37', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL),
(7, '行政助理', 1, 24, 1, NULL, '2012-08-02 00:00:00', 2, '', '', '', '', '管理员', '2012-07-31 14:56:59', NULL, NULL, NULL, NULL, NULL, 4, NULL, 1, NULL, NULL),
(8, 'test', 1, 15, 1, NULL, '2012-07-31 00:00:00', 2, '', '', '', '', '管理员', '2012-07-31 16:23:54', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL),
(9, 'abcd', 1, 15, 1, NULL, '2012-08-15 00:00:00', 12, '', '', '', '', '管理员', '2012-08-06 22:11:39', NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, 1, '2012-08-05 19:28:02'),
(10, 'admin_job', 1, 15, 1, NULL, '2012-08-06 00:00:00', 12, '', '', '', '', '管理员', '2012-08-06 22:15:57', NULL, NULL, NULL, NULL, NULL, 4, NULL, 1, 1, '2012-08-06 22:15:44'),
(11, 'test2', 1, 15, 1, NULL, '2012-08-29 00:00:00', 1, '', '', '', '', '管理员', '2012-08-23 15:56:06', NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, 1, '2012-08-23 13:11:16'),
(12, 'job123', 1, 15, 1, NULL, '2012-08-31 00:00:00', 2, '', '', '', '', '管理员', '2012-08-23 15:55:04', NULL, NULL, NULL, NULL, NULL, 4, NULL, 1, 1, '2012-08-23 15:54:39'),
(13, 'job111', 1, 15, 1, NULL, '2012-08-23 00:00:00', 2, '', '123', '', '', '管理员', '2012-08-23 15:57:18', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 1, '2012-08-23 15:56:46');

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_job_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_job_file` (
  `hjob_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  PRIMARY KEY (`hjob_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招聘岗位附件';

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_resume`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resume` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='简历管理' AUTO_INCREMENT=61 ;

--
-- 转存表中的数据 `app_hrm_resume`
--

INSERT INTO `app_hrm_resume` (`resume_id`, `emp_id`, `fullname`, `age`, `birthday`, `address`, `marriage`, `zip`, `sex`, `phone`, `mobile`, `email`, `hobby`, `religion`, `party`, `nationality`, `race`, `birthPlace`, `eduCollege`, `eduDegree`, `eduMajor`, `teacher_major`, `teacher_cert`, `startWorkDate`, `idNo`, `photo`, `status`, `memo`, `registor`, `regTime`, `workCase`, `trainCase`, `projectCase`, `en_level`, `cn_level`, `source`) VALUES
(20, 6, '罗家驹', NULL, NULL, '', 1, NULL, 1, NULL, '12345678', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(21, 7, '张三', NULL, NULL, '', 1, NULL, 1, NULL, '11223223', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(22, 8, '李四', NULL, NULL, '', 1, NULL, 1, NULL, '12321123', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(23, 9, '王五', NULL, NULL, '', 1, NULL, 1, NULL, '1222222', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(24, 10, '赵六', NULL, NULL, '', 1, NULL, 1, NULL, '11111111', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(25, 11, '钱七', NULL, NULL, '', 1, NULL, 1, NULL, '1234512', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(26, 12, '孙八', NULL, NULL, '', 1, NULL, 1, NULL, '123212312', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(27, 13, '周九', NULL, NULL, '', 1, NULL, 1, NULL, '12312132', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(28, 37, '林立', NULL, NULL, '', 1, NULL, 1, NULL, '28056121', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2),
(29, 14, '教师1', NULL, NULL, '', 1, NULL, 1, NULL, '28056121', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(32, NULL, 'test', NULL, NULL, '', 1, NULL, 1, NULL, '12421', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(33, 15, 'test2', NULL, NULL, '', 1, NULL, 1, NULL, '121321321', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(34, 16, 'test3', NULL, NULL, '', 1, NULL, 1, NULL, '112312321', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(35, 17, 'test4', NULL, NULL, '', 1, NULL, 1, NULL, '12312312', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(36, 18, 'test5', NULL, NULL, '', 1, NULL, 1, NULL, '121321321', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(37, 19, '罗佳驹', NULL, '1984-10-12 00:00:00', '杭州市拱墅区湖墅南路', 1, NULL, 1, NULL, '13575747066', '13575747066@139.com', NULL, NULL, 1, NULL, NULL, '', '浙江大学', 1, '', 1, 2, NULL, '330682198410120030 ', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(38, 20, '梅杰', NULL, '1985-01-08 00:00:00', '杭州市浙大路38号', 1, NULL, 1, NULL, '13777845267', '13777845267@139.com', NULL, NULL, 1, NULL, NULL, '', '浙江大学', 1, '', 1, 1, NULL, '330523198501085618', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(39, 21, '林菁菁', NULL, '1984-03-26 00:00:00', '杭州市西湖区九莲新村', 1, NULL, 2, NULL, '13968155954', '13968155954@139.com', NULL, NULL, 1, NULL, NULL, '上虞', '浙江大学', 1, '', 1, 1, NULL, '330682198403265944', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(40, 22, '许玉凤', NULL, '1982-10-01 00:00:00', '', 1, NULL, 2, NULL, '13968032442', '', NULL, NULL, 1, NULL, NULL, '安徽', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(41, 23, '王伟平', NULL, '1986-10-09 00:00:00', '', 1, NULL, 1, NULL, '13758194262', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(42, 24, '刘苗芳', NULL, NULL, '', 1, NULL, 2, NULL, '0571-88071385', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(43, 25, '周碧英', NULL, NULL, '', 1, NULL, 2, NULL, '0571-88321763', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(44, 26, '蒋晓萍', NULL, NULL, '', 1, NULL, 2, NULL, '0571-88321763', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(45, 27, '杨琪', NULL, NULL, '', 1, NULL, 1, NULL, '0571-88313621', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(46, 28, '何滨', NULL, NULL, '', 1, NULL, 1, NULL, '0571-88071385', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(47, 29, '程聪', NULL, NULL, '', 1, NULL, 1, NULL, '15068789653', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(48, 30, '苏斯翔', NULL, NULL, '', 1, NULL, 2, NULL, '13858056931', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(49, 31, '俞柏红', NULL, NULL, '', 1, NULL, 2, NULL, '0571-82652282', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(50, 32, '蔡晓喻', NULL, NULL, '', 1, NULL, 2, NULL, '15005725156', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(51, 33, '章荷英', NULL, NULL, '', 1, NULL, 2, NULL, '13735168660', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(52, NULL, '章荷英', NULL, NULL, '', 1, NULL, 2, NULL, '13735168660', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(53, 34, '冯毓', NULL, NULL, '', 1, NULL, 2, NULL, '15858332937', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(54, 35, '陈蕾红', NULL, NULL, '', 1, NULL, 1, NULL, '13626868497', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(55, 36, 'ljx', NULL, NULL, '', 1, NULL, 1, NULL, '28056121', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(56, NULL, '赵祥', NULL, NULL, '方家花苑', 1, NULL, 1, NULL, '13588064354', 'z405656232x@163.com', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2),
(57, NULL, '宇智波斑', NULL, NULL, '', 1, NULL, 1, NULL, '13588064354', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(58, NULL, '阿毛', NULL, NULL, '', 1, NULL, 1, NULL, '124124', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(59, NULL, '阿狗', NULL, NULL, '', 1, NULL, 1, NULL, '12421', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(60, 38, 'leo', NULL, NULL, '', 1, NULL, 1, NULL, '123123123', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2);

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_resume_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resume_file` (
  `file_id` bigint(20) NOT NULL,
  `resum_id` bigint(20) NOT NULL,
  PRIMARY KEY (`file_id`,`resum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历附件';

-- --------------------------------------------------------

--
-- 表的结构 `app_menu`
--

CREATE TABLE IF NOT EXISTS `app_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_title` varchar(120) NOT NULL COMMENT '菜单名称',
  `menu_icon` varchar(64) DEFAULT NULL COMMENT '菜单图标',
  `menu_url` varchar(120) NOT NULL COMMENT '菜单链接',
  `menu_key` varchar(64) NOT NULL COMMENT '菜单key',
  `menu_desc` varchar(100) DEFAULT NULL COMMENT '菜单描述',
  `menu_parent` int(11) DEFAULT NULL COMMENT '父菜单',
  `menu_order` int(11) DEFAULT NULL COMMENT '菜单项顺序',
  PRIMARY KEY (`menu_id`),
  UNIQUE KEY `menu_key` (`menu_key`),
  KEY `menu_parent` (`menu_parent`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统菜单' AUTO_INCREMENT=52 ;

--
-- 转存表中的数据 `app_menu`
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
(51, '员工档案', 'icon-hrstaffmProfile', 'app/hrm/employee.do?action=hrmEmployeeDocIndex', '_menu_mod_hrm_emp_archive', '', 46, 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_message_entity`
--

CREATE TABLE IF NOT EXISTS `app_message_entity` (
  `msg_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `msg_subject` varchar(150) NOT NULL COMMENT '消息标题',
  `msg_content` text NOT NULL COMMENT '消息内容',
  `sender_id` bigint(20) NOT NULL COMMENT '发送者ID',
  `sender_name` varchar(120) NOT NULL COMMENT '发送者姓名',
  `msg_type` tinyint(4) DEFAULT NULL COMMENT '消息类型',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  PRIMARY KEY (`msg_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='短消息' AUTO_INCREMENT=39 ;

--
-- 转存表中的数据 `app_message_entity`
--

INSERT INTO `app_message_entity` (`msg_id`, `msg_subject`, `msg_content`, `sender_id`, `sender_name`, `msg_type`, `send_time`) VALUES
(20, '[任务发起] 罗佳驹 发起任务 “task1 ” 审批通过，负责人为：梅杰', '<div style="line-height: 25px;">\r\n	<div>罗佳驹发起任务 “task1” 已审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 梅杰</div>\r\n	<div><b>任务时间：</b> 2012-08-23 --- 2012-08-24 </div>\r\n	<div><b>任务参与人：</b> 罗佳驹,梅杰 </div>\r\n	<div><b>审批人：</b> 林菁菁 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=14&op=view'', \r\n			''task_view_14'',  \r\n			''`task1`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 21, '林菁菁', 2, '2012-08-23 11:51:09'),
(21, '[待我审批] 00003001 提交的新闻 `new3` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 00003001 提交的新闻 `new3` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请时间：</b> 2012-08-23 01:04:49</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin.do?action=adminPageEntryDetail&id=6&op=view'', \r\n			''news_view_6'',  \r\n			''查看‘new3’新闻内容'',\r\n			{width: 900, height: 500})">点击查看新闻详细</a></div>\r\n</div>', 21, '林菁菁', 2, '2012-08-23 13:04:50'),
(22, '[待我审批] 罗佳驹 提交的 `工资薪资支出` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 提交的 `工资薪资支出` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-08-23</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=1&op=view'', \r\n			''approval_finan_1'',  \r\n			''查看‘罗佳驹’ 费用支出申请单-FE20120823131329'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 13:13:30'),
(23, '[待我审批] 罗佳驹 提交的 `房租合同` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 提交的 `房租合同` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-08-23</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/contract.do?action=diaglogFinaContractPage&id=4&op=view'', \r\n			''approval_finan_4'',  \r\n			''查看‘罗佳驹’ 合同申请单-FC20120823131534'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 13:15:34'),
(24, '[待我审批] 林菁菁 提交的 `调动申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 林菁菁 提交的 `调动申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-08-23</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=3&op=view'', \r\n			''approval_hrm_3'',  \r\n			''查看‘林菁菁’人资申请单-HRM20120823131913'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 21, '林菁菁', 2, '2012-08-23 13:19:14'),
(25, '[待我审批] 周碧英 提交的 `转正申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 周碧英 提交的 `转正申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> 12323</div>\r\n	<div><b>申请时间：</b> 2012-08-23</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=4&op=view'', \r\n			''approval_hrm_4'',  \r\n			''查看‘周碧英’人资申请单-HRM20120823143646'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 25, '周碧英', 2, '2012-08-23 14:36:46'),
(26, '[待我审批] 周碧英 提交的 `转正申请审批` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 周碧英 提交的 `转正申请审批` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-08-23</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/application_form.do?action=dialogApplicationFormPage&formId=5&op=view'', \r\n			''approval_hrm_5'',  \r\n			''查看‘周碧英’人资申请单-HRM20120823143752'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 25, '周碧英', 2, '2012-08-23 14:37:52'),
(27, '[待我审批] 周碧英 提交的 `员工薪资` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 周碧英 提交的 `员工薪资` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> </div>\r\n	<div><b>申请时间：</b> 2012-08-23</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=2&op=view'', \r\n			''approval_finan_2'',  \r\n			''查看‘周碧英’ 费用支出申请单-FE20120823145140'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 25, '周碧英', 2, '2012-08-23 14:51:40'),
(28, '[待我审批] 林菁菁 提交的 `工资薪资支出` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 林菁菁 提交的 `工资薪资支出` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请内容描述：</b> 123</div>\r\n	<div><b>申请时间：</b> 2012-08-23</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/finan/expense.do?action=diaglogFinaExpensePage&id=3&op=view'', \r\n			''approval_finan_3'',  \r\n			''查看‘林菁菁’ 费用支出申请单-FE20120823150120'',\r\n			{width: 1150, height: 640})">点击查看申请单详细</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 15:01:20'),
(29, '[待我审批] admin 提交的新闻 `news111` 有待审批', '<div style="line-height: 25px;">\r\n	<div> admin 提交的新闻 `news111` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>申请时间：</b> 2012-08-23 03:47:32</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin.do?action=adminPageEntryDetail&id=7&op=view'', \r\n			''news_view_7'',  \r\n			''查看‘news111’新闻内容'',\r\n			{width: 900, height: 500})">点击查看新闻详细</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 15:47:32'),
(30, '[我做伯乐] leo 应聘 `job123`岗位, 进入面试环节\r\n', '<div style="line-height: 25px;">\r\n	<div> leo 应聘 `job123`岗位, 进入面试环节, 请注意面试安排.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>面试时间：</b> 2012-08-23 15:15:49</div>\r\n	<div><b>面试地址：</b> 111</div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/interview.do?action=dialogInterviewCommentPage&id=15&issueId=29'', \r\n			''interview_view_15'',  \r\n			''`leo - job123`面试意见'',\r\n			{width: 555, height: 445})">点击进入我的伯乐</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 15:59:37'),
(31, '[任务审批退回] 罗佳驹 发起任务 “task2” 审批退回', '\r\n<div style="line-height: 25px;">\r\n	<div>罗佳驹发起任务 “task2” 审批被退回.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 罗佳驹</div>\r\n	<div><b>任务时间：</b> 2012-08-23 --- 2012-08-24 </div>\r\n	<div><b>任务参与人：</b> 程聪,刘苗芳 </div>\r\n	<div><b>审批人：</b> 罗佳驹 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=15&op=view'', \r\n			''task_view_15'',  \r\n			''`task2`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 16:28:09'),
(32, '[任务审批退回] 罗佳驹 发起任务 “task2” 审批退回', '\r\n<div style="line-height: 25px;">\r\n	<div>罗佳驹发起任务 “task2” 审批被退回.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 罗佳驹</div>\r\n	<div><b>任务时间：</b> 2012-08-23 --- 2012-08-24 </div>\r\n	<div><b>任务参与人：</b> 程聪,刘苗芳 </div>\r\n	<div><b>审批人：</b> 罗佳驹 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=15&op=view'', \r\n			''task_view_15'',  \r\n			''`task2`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 16:28:10'),
(33, '[任务发起] 罗佳驹 发起任务 “task2 ” 审批通过，负责人为：罗佳驹', '<div style="line-height: 25px;">\r\n	<div>罗佳驹发起任务 “task2” 已审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 罗佳驹</div>\r\n	<div><b>任务时间：</b> 2012-08-23 --- 2012-08-24 </div>\r\n	<div><b>任务参与人：</b> 程聪,刘苗芳 </div>\r\n	<div><b>审批人：</b> 罗佳驹 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=15&op=view'', \r\n			''task_view_15'',  \r\n			''`task2`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 16:29:14'),
(34, '[任务发起] 罗佳驹 发起任务 “task2 ” 审批通过，负责人为：罗佳驹', '<div style="line-height: 25px;">\r\n	<div>罗佳驹发起任务 “task2” 已审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 罗佳驹</div>\r\n	<div><b>任务时间：</b> 2012-08-23 --- 2012-08-24 </div>\r\n	<div><b>任务参与人：</b> 程聪,刘苗芳 </div>\r\n	<div><b>审批人：</b> 罗佳驹 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=15&op=view'', \r\n			''task_view_15'',  \r\n			''`task2`任务详情'',\r\n			{width: 750, height: 530})">点击进入到任务查看界面</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 16:29:14'),
(35, '[任务延期申请] 任务 “task2” 延期申请待审批', '\r\n<div style="line-height: 25px;">\r\n	<div>任务 “task2” 已提交延期申请, 有待审批.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 罗佳驹</div>\r\n	<div><b>任务时间：</b> 2012-08-23 --- 2012-08-24 </div>\r\n	<div><b>申请延期时间：</b> 2012-08-24 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/task.do?action=dialogAuditPage&taskId=15&type=0'', \r\n			''task_applyview_15'',  \r\n			''`task2`任务详情'',\r\n			{width: 555, height: 445})">点击进入到任务延期审批审批窗口</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 16:29:37'),
(36, '[任务延期] 任务 “task2” 已延期, 延期时间为: 2012-08-23', '\r\n<div style="line-height: 25px;">\r\n	<div>任务 “task2” 所提交延期申请，审批通过.</div> \r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务负责人：</b> 罗佳驹</div>\r\n	<div><b>任务时间：</b> 2012-08-23 --- 2012-08-23 </div>\r\n	<div><b>申请延期时间：</b> 2012-08-24 </div>\r\n	<div><b>审批人：</b> 罗佳驹 </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/personal/task.do?action=dialogAuditRecords&taskId=15'', \r\n			''task_applyview_15'',  \r\n			''`task2`任务详情'',\r\n			{width: 900, height: 300})">点击进入到任务延期审批审批窗口</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 16:31:27'),
(37, '[待我审批] 罗佳驹 发起的任务委托 `task3` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 发起的任务委托 `task3` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务时间：</b> 2012-08-23 --- 2012-08-27</div>\r\n	<div><b>任务描述：</b> </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=16&op=audit'', \r\n			''task_view_16'',  \r\n			''查看‘task3’任务委托内容'',\r\n			{width: 1080, height: 380})">点击查看任务委托详细</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 16:33:36'),
(38, '[待我审批] 罗佳驹 发起的任务委托 `task4` 有待审批', '<div style="line-height: 25px;">\r\n	<div> 罗佳驹 发起的任务委托 `task4` 有待审批 </div>\r\n	<div>------------------------------------------------------------------</div>\r\n	<div><b>任务时间：</b> 2012-08-07 --- 2012-08-09</div>\r\n	<div><b>任务描述：</b> </div>\r\n	<div><b>详情点击：</b><a href="javascript:void(0);" \r\n		onclick="parent.$.pdialog.open(\r\n			''app/admin/task.do?action=dialogTaskPage&id=17&op=audit'', \r\n			''task_view_17'',  \r\n			''查看‘task4’任务委托内容'',\r\n			{width: 1080, height: 380})">点击查看任务委托详细</a></div>\r\n</div>', 19, '罗佳驹', 2, '2012-08-23 16:36:02');

-- --------------------------------------------------------

--
-- 表的结构 `app_message_in`
--

CREATE TABLE IF NOT EXISTS `app_message_in` (
  `receive_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `msg_id` bigint(20) NOT NULL COMMENT '短消息ID',
  `user_id` bigint(20) NOT NULL COMMENT '接收用户ID',
  `user_name` varchar(64) NOT NULL COMMENT '接收用户姓名',
  `flag_read` tinyint(4) NOT NULL DEFAULT '0' COMMENT '阅读标记, 1=已读, 0=未读',
  `flag_del` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标记, 1=已删, 0=未删',
  `receiv_time` datetime NOT NULL COMMENT '接收时间',
  PRIMARY KEY (`receive_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='收件箱' AUTO_INCREMENT=93 ;

--
-- 转存表中的数据 `app_message_in`
--

INSERT INTO `app_message_in` (`receive_id`, `msg_id`, `user_id`, `user_name`, `flag_read`, `flag_del`, `receiv_time`) VALUES
(47, 20, 20, '梅杰', 1, 0, '2012-08-23 11:51:09'),
(48, 20, 19, '罗佳驹', 1, 0, '2012-08-23 11:51:09'),
(49, 21, 19, '罗佳驹', 1, 0, '2012-08-23 13:04:50'),
(50, 21, 20, '梅杰', 0, 0, '2012-08-23 13:04:50'),
(51, 21, 21, '林菁菁', 1, 0, '2012-08-23 13:04:50'),
(52, 21, 32, '蔡晓喻', 0, 0, '2012-08-23 13:04:50'),
(53, 21, 34, '冯毓', 0, 0, '2012-08-23 13:04:50'),
(54, 21, 36, 'ljx', 0, 0, '2012-08-23 13:04:50'),
(55, 22, 20, '梅杰', 0, 0, '2012-08-23 13:13:30'),
(56, 23, 20, '梅杰', 1, 0, '2012-08-23 13:15:34'),
(57, 24, 19, '罗佳驹', 1, 0, '2012-08-23 13:19:14'),
(58, 25, 19, '罗佳驹', 0, 0, '2012-08-23 14:36:46'),
(59, 26, 19, '罗佳驹', 0, 0, '2012-08-23 14:37:52'),
(60, 27, 20, '梅杰', 1, 0, '2012-08-23 14:51:40'),
(61, 28, 20, '梅杰', 1, 0, '2012-08-23 15:01:20'),
(62, 29, 19, '罗佳驹', 0, 0, '2012-08-23 15:47:32'),
(63, 29, 20, '梅杰', 0, 0, '2012-08-23 15:47:32'),
(64, 29, 21, '林菁菁', 0, 0, '2012-08-23 15:47:32'),
(65, 29, 32, '蔡晓喻', 0, 0, '2012-08-23 15:47:32'),
(66, 29, 34, '冯毓', 0, 0, '2012-08-23 15:47:32'),
(67, 29, 36, 'ljx', 0, 0, '2012-08-23 15:47:32'),
(68, 30, 19, '罗佳驹', 1, 0, '2012-08-23 15:59:37'),
(69, 31, 19, '罗佳驹', 0, 0, '2012-08-23 16:28:09'),
(70, 32, 19, '罗佳驹', 0, 0, '2012-08-23 16:28:10'),
(71, 33, 19, '罗佳驹', 0, 0, '2012-08-23 16:29:14'),
(72, 33, 29, '程聪', 0, 0, '2012-08-23 16:29:14'),
(73, 34, 19, '罗佳驹', 0, 0, '2012-08-23 16:29:14'),
(74, 33, 24, '刘苗芳', 0, 0, '2012-08-23 16:29:14'),
(75, 34, 29, '程聪', 0, 0, '2012-08-23 16:29:14'),
(76, 34, 24, '刘苗芳', 0, 0, '2012-08-23 16:29:14'),
(77, 35, 19, '罗佳驹', 0, 0, '2012-08-23 16:29:37'),
(78, 36, 19, '罗佳驹', 0, 0, '2012-08-23 16:31:27'),
(79, 36, 29, '程聪', 0, 0, '2012-08-23 16:31:27'),
(80, 36, 24, '刘苗芳', 0, 0, '2012-08-23 16:31:27'),
(81, 37, 19, '罗佳驹', 0, 0, '2012-08-23 16:33:36'),
(82, 37, 20, '梅杰', 0, 0, '2012-08-23 16:33:36'),
(83, 37, 21, '林菁菁', 0, 0, '2012-08-23 16:33:36'),
(84, 37, 32, '蔡晓喻', 0, 0, '2012-08-23 16:33:36'),
(85, 37, 34, '冯毓', 0, 0, '2012-08-23 16:33:36'),
(86, 37, 36, 'ljx', 0, 0, '2012-08-23 16:33:36'),
(87, 38, 19, '罗佳驹', 0, 0, '2012-08-23 16:36:02'),
(88, 38, 20, '梅杰', 0, 0, '2012-08-23 16:36:02'),
(89, 38, 21, '林菁菁', 0, 0, '2012-08-23 16:36:02'),
(90, 38, 32, '蔡晓喻', 0, 0, '2012-08-23 16:36:02'),
(91, 38, 34, '冯毓', 0, 0, '2012-08-23 16:36:02'),
(92, 38, 36, 'ljx', 0, 0, '2012-08-23 16:36:02');

-- --------------------------------------------------------

--
-- 表的结构 `app_process_definition`
--

CREATE TABLE IF NOT EXISTS `app_process_definition` (
  `def_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) DEFAULT NULL COMMENT '流程分类ID',
  `def_name` varchar(256) DEFAULT NULL COMMENT '流程名称',
  `def_description` varchar(250) DEFAULT NULL COMMENT '流程描述',
  `filter_poset` bigint(20) DEFAULT NULL COMMENT '过滤职位',
  `def_trigger` varchar(120) DEFAULT NULL COMMENT '条件',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`def_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程定义' AUTO_INCREMENT=54 ;

--
-- 转存表中的数据 `app_process_definition`
--

INSERT INTO `app_process_definition` (`def_id`, `type_id`, `def_name`, `def_description`, `filter_poset`, `def_trigger`, `createtime`) VALUES
(1, 7, '0 < 支出费用 <= 1000', '', 0, 'x > 0 && x <= 1000', '2012-06-29 14:50:40'),
(2, 7, '1000 < 支出费用 <= 10000', '', 0, 'x > 1000 && x <= 10000', '2012-06-29 14:51:15'),
(3, 7, '支出费用 >10000', '', 0, 'x > 10000', '2012-06-29 15:00:28'),
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
(36, 5, '晋升申请审批-基本岗位（总部）(in)', '晋升申请审批-基本岗位（总部）(in)', 12, 'x == 0', '2012-08-07 15:04:38'),
(37, 5, '晋升申请审批-基本岗位（总部）(out)', '晋升申请审批-基本岗位（总部）(out)', 12, 'x == 1', '2012-08-07 15:04:38'),
(38, 5, '晋升申请审批-基本岗位（校区）(in)', '晋升申请审批-基本岗位（校区）(in)', 13, 'x == 0', '2012-08-07 15:05:20'),
(39, 5, '晋升申请审批-基本岗位（校区）(out)', '晋升申请审批-基本岗位（校区）(out)', 13, 'x == 1', '2012-08-07 15:05:20'),
(40, 5, '晋升申请审批-总经办职位(in)', '晋升申请审批-总经办职位(in)', 11, 'x == 0', '2012-08-07 15:05:52'),
(41, 5, '晋升申请审批-总经办职位(out)', '晋升申请审批-总经办职位(out)', 11, 'x == 1', '2012-08-07 15:05:52'),
(42, 5, '晋升申请审批-总部主管(in)', '晋升申请审批-总部主管(in)', 10, 'x == 0', '2012-08-07 15:06:21'),
(43, 5, '晋升申请审批-总部主管(out)', '晋升申请审批-总部主管(out)', 10, 'x == 1', '2012-08-07 15:06:21'),
(44, 5, '晋升申请审批-校区主管（校区）(in)', '晋升申请审批-校区主管（校区）(in)', 14, 'x == 0', '2012-08-07 15:15:49'),
(45, 5, '晋升申请审批-校区主管（校区）(out)', '晋升申请审批-校区主管（校区）(out)', 14, 'x == 1', '2012-08-07 15:15:49'),
(46, 6, '离职申请审批-基本岗位（总部）', '离职申请审批-基本岗位（总部）', 12, NULL, '2012-08-07 15:16:17'),
(47, 6, '离职申请审批-基本岗位（校区）', '离职申请审批-基本岗位（校区）', 13, NULL, '2012-08-07 15:16:30'),
(48, 6, '离职申请审批-总经办职位', '离职申请审批-总经办职位', 11, NULL, '2012-08-07 15:16:45'),
(49, 6, '离职申请审批-总部主管', '离职申请审批-总部主管', 10, NULL, '2012-08-07 15:16:57'),
(50, 6, '离职申请审批-校区主管（校区）', '离职申请审批-校区主管（校区）', 14, NULL, '2012-08-07 15:17:15'),
(51, 9, '薪资 >10000', '', NULL, 'x >10000', '2012-08-07 15:23:13'),
(52, 9, '1000 < 薪资 <= 10000', '', NULL, 'x > 1000 && x <= 10000', '2012-08-07 15:24:19'),
(53, 9, '0 < 薪资 <=1000', '', NULL, 'x > 0 && x <= 1000', '2012-08-07 15:24:53');

-- --------------------------------------------------------

--
-- 表的结构 `app_process_form`
--

CREATE TABLE IF NOT EXISTS `app_process_form` (
  `form_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_no` varchar(120) NOT NULL COMMENT '流程申请单号',
  `type_id` bigint(20) NOT NULL COMMENT '流程类型',
  `task_name` varchar(128) DEFAULT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) DEFAULT NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) DEFAULT NULL COMMENT '跳转节点, 跳转至下一任务',
  `seq_sn` int(11) NOT NULL COMMENT '序列编号',
  `task_type` tinyint(4) NOT NULL COMMENT '任务类型',
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
  `audit_state` smallint(6) DEFAULT NULL COMMENT '审核状态, 1=审核中, 2=审核通过 3=审核不通过, 4=审核被退回...',
  `audit_comments` text COMMENT '审核意见',
  PRIMARY KEY (`form_id`),
  KEY `form_no` (`form_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=29 ;

--
-- 转存表中的数据 `app_process_form`
--

INSERT INTO `app_process_form` (`form_id`, `form_no`, `type_id`, `task_name`, `task_from`, `task_next`, `seq_sn`, `task_type`, `to_rolenames`, `to_distnames`, `to_depnames`, `to_posnames`, `to_usernames`, `audit_rolenames`, `audit_distnames`, `audit_depnames`, `audit_usernames`, `audit_posnames`, `to_userids`, `to_roleids`, `to_distids`, `to_depids`, `to_posids`, `audit_userids`, `audit_roleids`, `audit_distids`, `audit_depids`, `audit_posids`, `audit_date`, `audit_state`, `audit_comments`) VALUES
(21, 'HRM20120803162335', 4, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '副总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '13', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(22, 'HRM20120803162335', 4, NULL, NULL, NULL, 2, 4, NULL, NULL, '行政部', '行政总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '24', '22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 'FC20120823131534', 8, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '副总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '13', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(25, 'HRM20120823131913', 4, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(26, 'HRM20120823143646', 3, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(27, 'HRM20120823143752', 3, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '26', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(28, 'FE20120823145140', 9, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '副总经理', NULL, NULL, '杭州总部', '总经办', '梅杰', '副总经理', NULL, NULL, NULL, '15', '13', '20', NULL, '1', '15', '13', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_process_history`
--

CREATE TABLE IF NOT EXISTS `app_process_history` (
  `history_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_no` varchar(120) NOT NULL COMMENT '流程申请单号',
  `type_id` bigint(20) NOT NULL COMMENT '流程类型',
  `task_name` varchar(128) DEFAULT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) DEFAULT NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) DEFAULT NULL COMMENT '跳转节点, 跳转至下一任务',
  `task_type` tinyint(4) DEFAULT NULL COMMENT '任务类型',
  `seq_sn` int(11) DEFAULT NULL COMMENT '序列编号',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `app_process_history`
--

INSERT INTO `app_process_history` (`history_id`, `form_no`, `type_id`, `task_name`, `task_from`, `task_next`, `task_type`, `seq_sn`, `to_rolenames`, `to_distnames`, `to_depnames`, `to_posnames`, `to_usernames`, `audit_rolenames`, `audit_distnames`, `audit_depnames`, `audit_usernames`, `audit_posnames`, `to_userids`, `to_roleids`, `to_distids`, `to_depids`, `to_posids`, `audit_userids`, `audit_roleids`, `audit_distids`, `audit_depids`, `audit_posids`, `audit_date`, `audit_state`, `audit_comments`) VALUES
(4, 'FC20120803161623', 8, NULL, NULL, NULL, 4, NULL, NULL, NULL, '总经办', '副总经理', NULL, NULL, '杭州总部', '总经办', '梅杰', '副总经理', NULL, NULL, NULL, '15', '13', '20', NULL, '1', '15', '13', '2012-08-03 16:17:26', 2, ''),
(6, 'HRM20120803162615', 4, NULL, NULL, NULL, 4, NULL, NULL, NULL, '总经办', '副总经理', NULL, NULL, '杭州总部', '总经办', '梅杰', '副总经理', NULL, NULL, NULL, '15', '13', '20', NULL, '1', '15', '13', '2012-08-03 16:26:46', 2, ''),
(7, 'FE20120823150120', 7, NULL, NULL, NULL, 4, NULL, NULL, NULL, '总经办', '副总经理', NULL, NULL, '杭州总部', '总经办', '梅杰', '副总经理', NULL, NULL, NULL, '15', '13', '20', NULL, '1', '15', '13', '2012-08-23 15:11:42', 2, 'test'),
(8, 'FE20120823131329', 7, NULL, NULL, NULL, 4, NULL, NULL, NULL, '总经办', '副总经理', NULL, NULL, '杭州总部', '总经办', '梅杰', '副总经理', NULL, NULL, NULL, '15', '13', '20', NULL, '1', '15', '13', '2012-08-23 15:31:16', 3, ''),
(9, 'FE20120823145140', 9, NULL, NULL, NULL, 4, NULL, NULL, NULL, '总经办', '副总经理', NULL, NULL, '杭州总部', '总经办', '梅杰', '副总经理', NULL, NULL, NULL, '15', '13', '20', NULL, '1', '15', '13', '2012-08-23 15:31:34', 4, '');

-- --------------------------------------------------------

--
-- 表的结构 `app_process_task`
--

CREATE TABLE IF NOT EXISTS `app_process_task` (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `def_id` bigint(20) DEFAULT NULL COMMENT '所属流程定义ID',
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
  PRIMARY KEY (`task_id`),
  KEY `def_id` (`def_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程任务设置' AUTO_INCREMENT=51 ;

--
-- 转存表中的数据 `app_process_task`
--

INSERT INTO `app_process_task` (`task_id`, `def_id`, `task_name`, `task_from`, `task_next`, `seq_sn`, `to_rolenames`, `to_depnames`, `to_posnames`, `to_usernames`, `to_userids`, `to_roleids`, `to_depids`, `to_posids`, `comments`, `task_type`) VALUES
(1, 18, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(2, 5, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(3, 4, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(4, 19, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(6, 20, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(7, 21, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(8, 22, NULL, NULL, NULL, 1, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(9, 23, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(10, 24, NULL, NULL, NULL, 1, NULL, '人资部', '人资总监', NULL, NULL, NULL, '26', '46', NULL, 4),
(11, 24, NULL, NULL, NULL, 2, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(12, 25, NULL, NULL, NULL, 1, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(13, 26, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(14, 27, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(15, 27, NULL, NULL, NULL, 2, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(16, 28, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(17, 29, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(18, 30, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(19, 31, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(20, 32, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(21, 33, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(22, 33, NULL, NULL, NULL, 2, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(23, 34, NULL, NULL, NULL, 1, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(24, 35, NULL, NULL, NULL, 1, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '27', NULL, 2),
(25, 35, NULL, NULL, NULL, 2, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '27', NULL, 5),
(26, 36, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(27, 37, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(28, 38, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(29, 39, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(30, 40, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(31, 41, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(32, 42, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(33, 43, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(34, 44, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(35, 45, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(36, 46, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(37, 47, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(38, 48, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(39, 49, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(40, 50, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(41, 3, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(42, 3, NULL, NULL, NULL, 2, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(43, 2, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(44, 1, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(45, 53, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(46, 52, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '26', NULL, 4),
(47, 51, NULL, NULL, NULL, 1, NULL, '总经办', '副总经理', NULL, NULL, NULL, '15', '13', NULL, 4),
(48, 51, NULL, NULL, NULL, 2, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(49, 18, NULL, NULL, NULL, 2, NULL, '财务部', '财务总监', NULL, NULL, NULL, '17', '39', NULL, 4),
(50, 21, NULL, NULL, NULL, 2, NULL, '发展部', '区长', NULL, NULL, NULL, '27', '53', NULL, 4);

-- --------------------------------------------------------

--
-- 表的结构 `app_process_type`
--

CREATE TABLE IF NOT EXISTS `app_process_type` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(128) NOT NULL COMMENT '流程分类名',
  `type_key` varchar(64) DEFAULT NULL COMMENT '流程分类KEY',
  `type_desc` varchar(250) DEFAULT NULL COMMENT '流程分类描述',
  `type_slug` varchar(64) NOT NULL COMMENT '分类类别',
  `type_parent` bigint(20) DEFAULT NULL COMMENT '流程父分类',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程分类' AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `app_process_type`
--

INSERT INTO `app_process_type` (`type_id`, `type_name`, `type_key`, `type_desc`, `type_slug`, `type_parent`) VALUES
(1, '费用支出申请审批', 'PROCESS_PAYMENT', NULL, 'finance', NULL),
(2, '合同申请审批', 'PROCESS_CONTRACT', NULL, 'finance', NULL),
(3, '转正申请审批', 'PROCESS_MEMBER_BERGULAR', NULL, 'hrm', NULL),
(4, '调动申请审批', 'PROCESS_MEMBER_TRANSFER', NULL, 'hrm', NULL),
(5, '晋升申请审批', 'PROCESS_MEMBER_PROMOTION', NULL, 'hrm', NULL),
(6, '离职申请审批', 'PROCESS_MEMBER_FAIRWELL', NULL, 'hrm', NULL),
(7, '工资薪资支出', 'PROCESS_SALARY_PAYMENT', '支付给员工薪资的审批类型...', 'finance', 1),
(8, '房租合同', 'PROCESS_HOUSE_RENT', '房租合同', 'finance', 2),
(9, '员工薪资', 'PROCESS_EMP_PAYROLL', '', 'finance', 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_role`
--

CREATE TABLE IF NOT EXISTS `app_role` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='角色表' AUTO_INCREMENT=73 ;

--
-- 转存表中的数据 `app_role`
--

INSERT INTO `app_role` (`role_id`, `role_name`, `role_key`, `role_desc`, `role_status`, `role_rights`, `role_type`, `role_edit`) VALUES
(7, '基础权限（总部）', 'ROLE_EMPLOYEE_HEADOFFICE', '基础权限（总部）', 1, '_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD', 0, 1),
(8, '基础权限(校区)', 'ROLE_EMPLOYEE_SCHOOL', '基础权限(校区)', 1, '_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD', 1, 1),
(9, '管理员', 'ROLE_ADMIN', '', 1, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_MYVIEW_DATA_LOAD,_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_TASK_MYVIEW,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_PERSONAL_APPROVAL_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT,_FUNCKEY_ADMIN_TASK_DATA_LOAD,_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,_FUNCKEY_ADMIN_ATTENDANCE_DATA_LOAD,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_DATA_LOAD,_FUNCKEY_ADMIN_DOC_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_DATA_LOAD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE,_FUNCKEY_HRM_ENTRY_OP_QUALIFY,_FUNCKEY_HRM_EMPLOYEE_REMOVE,_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_EMPLOYEE_ADD,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_DATA_LOAD,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET,_FUNCKEY_SYSTEM_DELETE_DICTIONARY,_FUNCKEY_SYSTEM_ADD_DICTIONARY,_FUNCKEY_SYSTEM_EDIT_DICTIONARY,_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE,_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD,_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT,_FUNCKEY_SYSTEM_DELETE_WORK_TIME,_FUNCKEY_SYSTEM_ADD_WORK_CONTENT,_FUNCKEY_SYSTEM_ADD_WORK_TIME,_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT,_FUNCKEY_SYSTEM_EDIT_WORK_TIME,_FUNCKEY_FLOW_HRM_PROCESS_REMOVE,_FUNCKEY_FLOW_HRM_PROCESS_REFRESH,_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE,_FUNCKEY_FLOW_HRM_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_APPROVE,_FUNCKEY_FLOW_FINAN_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REMOVE,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_ADD,_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_ADD,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_EDIT,_FUNCKEY_SYSTEM_SCHOOL_POSET_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_POSET_ADD,_FUNCKEY_SYSTEM_SCHOOL_POSET_EDIT,_FUNCKEY_SYSTEM_ROLE_REMOVE,_FUNCKEY_SYSTEM_ROLE_VIEW,_FUNCKEY_SYSTEM_ROLE_ADD,_FUNCKEY_SYSTEM_ROLE_EDIT,_FUNCKEY_SYSTEM_MENU_FUNC_REMOVE,_FUNCKEY_SYSTEM_MENU_FUNC_REFRESH,_FUNCKEY_SYSTEM_MENU_FUNC_ADD,_FUNCKEY_SYSTEM_MENU_FUNC_EDIT,_FUNCKEY_SYSTEM_MENU_REFRESH,_FUNCKEY_SYSTEM_MENU_ADD,_FUNCKEY_SYSTEM_MENU_EDIT,', 0, 1),
(14, '校区管理员', 'ROLE_SCHOOL_ADMIN', '', 1, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_MYVIEW,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT,_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE,_FUNCKEY_HRM_ENTRY_OP_QUALIFY,_FUNCKEY_HRM_EMPLOYEE_REMOVE,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_EMPLOYEE_ADD,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET,_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE,_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD,_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT,_FUNCKEY_SYSTEM_DELETE_WORK_TIME,_FUNCKEY_SYSTEM_ADD_WORK_CONTENT,_FUNCKEY_SYSTEM_ADD_WORK_TIME,_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT,_FUNCKEY_SYSTEM_EDIT_WORK_TIME', 1, 1),
(22, '新闻发布与管理（总部）', 'ROLE_ADMIN_NEWS_PUBLISH', '新闻发布与管理（总部）', 1, '_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_EDIT', 0, 1),
(23, '新闻审批与管理（总部）', 'ROLE_ADMIN_NEWS_APPROVE', '', 1, '_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP', 0, 1),
(24, '新闻查看(查看)', 'ROLE_PERSONAL_NEWS_READ', '', 1, '', 0, 1),
(26, '任务审批与管理（总部）', 'ROLE_ADMIN_TASK_APPROVE', '对发起的任务是否通过进行审批', 1, '_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT', 0, 1),
(27, '任务发起与管理（总部）', 'ROLE_PERSONAL_TASK_PUBLISH', '', 1, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_MYVIEW', 0, 1),
(28, '任务查看', 'ROLE_PERSONAL_TASK_READ', '查看用户所负责或参与的任务', 1, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_VIEW', 0, 1),
(29, '工作安排添加导入', 'ROLE_ADMIN_WORKPLAN_ADD', '', 1, '_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE', 0, 1),
(30, '工作安排调整', 'ROLE_ADMIN_WORKPLAN_ADJUST', '工作安排调整、编辑、删除', 1, '_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE', 0, 1),
(31, '工作安排查看', 'ROLE_ADMIN_WORKPLAN_READ', '工作安排查看', 1, '_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE', 0, 1),
(32, '员工考勤操作', 'ROLE_ADMIN_ATTENDANCE_MANAGE', '员工考勤的打卡、出差、请假、旷工等操作', 1, '', 0, 1),
(33, '文档上传与管理', 'ROLE_ADMIN_DOC_UPLOAD', '', 1, '_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_EDIT', 0, 1),
(34, '文档查看下载', 'ROLE_PERSONAL_DOC_DOWNLOAD', '', 1, '', 0, 1),
(35, '会议发起与管理', 'ROLE_PERSONAL_CONFERENCE_MANAGE', '会议发起、调整、取消、激活', 1, '_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE', 0, 1),
(36, '会议总结', 'ROLE_PERSONAL_CONFERENCE_SUMMARY', '会议总结', 1, '_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE', 0, 1),
(37, '会议查看', 'ROLE_PERSONAL_CONFERENCE_READ', '查看所参加的会议', 1, '_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE', 0, 1),
(38, '岗位管理-发布岗位', 'ROLE_ADMIN_HRM_JOB_PUBLISH', '发布岗位', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT', 0, 1),
(39, '岗位管理-发布审批', 'ROLE_ADMIN_HRM_JOB_APPROVE', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW', 0, 1),
(41, '岗位管理-管理权限', 'ROLE_ADMIN_HRM_JOB_MANAGE', '岗位编辑、应聘控制', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL', 0, 1),
(42, '入职安排-信息查看', 'ROLE_ADMIN_HRM_ONBOARD_REVIEW', '简历查看、面试查看', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY', 0, 1),
(43, '入职安排-入职安排', 'ROLE_ADMIN_HRM_ONBOARD', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY', 0, 1),
(44, '招聘安排-页面查看', 'ROLE_ADMIN_HRM_RECRUIT_REVIEW', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER', 0, 1),
(45, '招聘安排-招聘安排', 'ROLE_ADMIN_HRM_RECRUITING', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER', 0, 1),
(46, '招聘安排-录用淘汰', 'ROLE_ADMIN_HRM_RECRUIT_RESULT', '录用、淘汰、未到操作', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER', 0, 1),
(48, '公司人才库-删除', 'ROLE_ADMIN_HRM_ARCHIVE_RESUME_REMOVE', '', 1, '_FUNCKEY_HRM_ARCHIVE_RESUME_REMOVE', 0, 1),
(49, '公司人才库-查看', 'ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW', '', 1, '_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW', 0, 1),
(50, '招聘入职-入职处理', 'ROLE_ADMIN_HRM_ENTRY_OP_ONBOARD', '', 1, '_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE', 0, 1),
(51, '招聘入职-考察处理', 'ROLE_ADMIN_HRM_ENTRY_OP_QUALIFY', '', 1, '_FUNCKEY_HRM_ENTRY_OP_QUALIFY', 0, 1),
(52, '员工档案-添加', 'ROLE_ADMIN_HRM_EMPLOYEE_ADD', '', 1, '_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_ADD', 0, 1),
(53, '员工档案-删除', 'ROLE_ADMIN_HRM_EMPLOYEE_DELETE', '', 1, '_FUNCKEY_HRM_EMPLOYEE_REMOVE', 0, 1),
(54, '员工档案-查看', 'ROLE_ADMIN_HRM_EMPLOYEE_VIEW', '', 1, '_FUNCKEY_HRM_EMPLOYEE_VIEW', 0, 1),
(55, '人力发展-审批', 'ROLE_ADMIN_HRM_DEVELOP_APPROVE', '流程审批', 1, '_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_APPROVE', 0, 1),
(56, '人力发展-审批记录查看', 'ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA', '', 1, '_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,', 0, 1),
(57, '人力发展-落实操作', 'ROLE_ADMIN_HRM_DEVELOP_FINALIZE', '主要是针对员工, 转正、晋升、离职、调动等状态转换操作.', 1, '_FUNCKEY_HRM_DEVELOP_FINALIZE', 0, 1),
(58, '财务-费用支出申请', 'ROLE_ADMIN_FINAN_EXPENSE_APPLY', '', 1, '_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY', 0, 1),
(59, '财务-费用支出审核', 'ROLE_ADMIN_FINAN_EXPENSE_APPROVE', '', 1, '_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW', 0, 1),
(60, '财务-合同申请', 'ROLE_ADMIN_FINAN_CONTRACT_APPLY', '', 1, '_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW', 0, 1),
(61, '财务-合同审批', 'ROLE_ADMIN_FINAN_CONTRACT_APPROVE', '', 1, '_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW', 0, 1),
(62, '用户管理', 'ROLE_ADMIN_ACCOUNT_MANAGE', '', 1, '_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET', 0, 1),
(63, '系统日志', 'ROLE_ADMIN_SYSTEM_LOG', '', 1, '', 0, 1),
(64, '系统设置', 'ROLE_ADMIN_SYSTEM_MANAGE', '', 1, '_FUNCKEY_SYSTEM_DELETE_DICTIONARY,_FUNCKEY_SYSTEM_ADD_DICTIONARY,_FUNCKEY_SYSTEM_EDIT_DICTIONARY,_FUNCKEY_SYSTEM_TEMPLATE_ACTIVATE,_FUNCKEY_SYSTEM_TEMPLATE_WORK_ADD,_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT,_FUNCKEY_SYSTEM_DELETE_WORK_TIME,_FUNCKEY_SYSTEM_ADD_WORK_CONTENT,_FUNCKEY_SYSTEM_ADD_WORK_TIME,_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT,_FUNCKEY_SYSTEM_EDIT_WORK_TIME,_FUNCKEY_FLOW_HRM_PROCESS_REMOVE,_FUNCKEY_FLOW_HRM_PROCESS_REFRESH,_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE,_FUNCKEY_FLOW_HRM_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_APPROVE,_FUNCKEY_FLOW_FINAN_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REMOVE,_FUNCKEY_FLOW_FINAN_PROC_TYPE_REFRESH,_FUNCKEY_FLOW_FINAN_PROC_TYPE_ADD,_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_ADD,_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_POS_EDIT,_FUNCKEY_SYSTEM_SCHOOL_DEP_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_DEP_REFRESH,_FUNCKEY_SYSTEM_SCHOOL_DEP_ADD,_FUNCKEY_SYSTEM_SCHOOL_DEP_EDIT,_FUNCKEY_SYSTEM_SCHOOL_POSET_REMOVE,_FUNCKEY_SYSTEM_SCHOOL_POSET_ADD,_FUNCKEY_SYSTEM_SCHOOL_POSET_EDIT,_FUNCKEY_SYSTEM_ROLE_REMOVE,_FUNCKEY_SYSTEM_ROLE_VIEW,_FUNCKEY_SYSTEM_ROLE_ADD,_FUNCKEY_SYSTEM_ROLE_EDIT,_FUNCKEY_SYSTEM_MENU_FUNC_REMOVE,_FUNCKEY_SYSTEM_MENU_FUNC_REFRESH,_FUNCKEY_SYSTEM_MENU_FUNC_ADD,_FUNCKEY_SYSTEM_MENU_FUNC_EDIT,_FUNCKEY_SYSTEM_MENU_REFRESH,_FUNCKEY_SYSTEM_MENU_ADD,_FUNCKEY_SYSTEM_MENU_EDIT,', 0, 1),
(67, '测试账号', 'ROLE_TEST', '', 1, '_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE,_FUNCKEY_PERSONAL_TASK_ACCOMPLISH,_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW,_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE,_FUNCKEY_PERSONAL_TASK_POSTPONE,_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_MYVIEW_DATA_LOAD,_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_TASK_MYVIEW,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_PERSONAL_APPROVAL_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_TASK_REMOVE,_FUNCKEY_ADMIN_TASK_APPROVE,_FUNCKEY_ADMIN_TASK_VIEW,_FUNCKEY_ADMIN_TASK_EDIT,_FUNCKEY_ADMIN_TASK_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_ADMIN_TASK_DATA_LOAD', 0, 1),
(68, '校区办管理权限', 'ROLE_SCHOOL_HEADMASTER', '', 1, '_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_PERSONAL_APPROVAL_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_DATA_LOAD,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_ADMIN_ACCOUNT_LOCK,_FUNCKEY_ADMIN_ACCOUNT_ACTIVE,_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_DOC_DATA_LOAD,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_ADMIN_ACCOUNT_DATA_LOAD', 1, 1),
(69, '校区行政管理权限', 'ROLE_SCHOOL_CLERICAL_MANAGE', '', 1, '_FUNCKEY_ADMIN_NEWS_DELETE,_FUNCKEY_ADMIN_NEWS_ADD,_FUNCKEY_ADMIN_NEWS_APPROVING,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_APPROVE,_FUNCKEY_ADMIN_NEWS_TOP,_FUNCKEY_ADMIN_NEWS_EDIT,_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE,_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE,_FUNCKEY_ADMIN_ADD_WORK_ARRANGE,_FUNCKEY_ADMIN_EDIT_WORK_ARRANGE,_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE,_FUNCKEY_ADMIN_ATTENDANCE_DATA_LOAD,_FUNCKEY_ADMIN_DOC_ADD,_FUNCKEY_ADMIN_DOC_REMOVE,_FUNCKEY_ADMIN_DOC_DATA_LOAD,_FUNCKEY_ADMIN_DOC_EDIT,_FUNCKEY_ADMIN_NEWS_APPROVE_DATA_LOAD,_FUNCKEY_ADMIN_NEWS_DATA_LOAD,_FUNCKEY_ADMIN_WORK_ARRANGE_DATA_LOAD,_FUNCKEY_ADMIN_ATTENDANCE_DATA_LOAD,_FUNCKEY_ADMIN_DOC_DATA_LOAD', 1, 1),
(70, '校区财务管理权限', 'ROLE_SCHOOL_FINANCE_MANAGE', '', 1, '_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD', 1, 1),
(71, '校区人资管理权限', 'ROLE_SCHOOL_HR_MANAGE', '', 1, '_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_ENTRY,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_JOBHIRE_JOB_APPROVAL,_FUNCKEY_HRM_JOBHIRE_JOB_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_EDIT,_FUNCKEY_HRM_JOBHIRE_JOB_OPENCTRL,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ENTILE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_ABSENCE,_FUNCKEY_HRM_JOBHIRE_JOB_EMP_ELIMINATE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_ARRANGE,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_RESUME_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER_INTERVIEW_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_OFFER,_FUNCKEY_HRM_ARCHIVE_RESUME_VIEW,_FUNCKEY_HRM_ENTRY_OP_ONBOARD,_FUNCKEY_HRM_ENTRY_OP_ABSENCE,_FUNCKEY_HRM_ENTRY_OP_QUALIFY,_FUNCKEY_HRM_EMPLOYEE_UPDATE,_FUNCKEY_HRM_EMPLOYEE_VIEW,_FUNCKEY_HRM_EMPLOYEE_ADD,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_ENTRY_DATA_LOAD,_FUNCKEY_HRM_EMPLOYEE_DATA_LOAD', 1, 1),
(72, '片区办管理权限', 'ROLE_AREA_MANAGE', '', 1, '_FUNCKEY_PERSONAL_TASK_ADD,_FUNCKEY_PERSONAL_TASK_EDIT,_FUNCKEY_PERSONAL_TASK_VIEW,_FUNCKEY_PERSONAL_TASK_MYVIEW_DATA_LOAD,_FUNCKEY_PERSONAL_TASK_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_CANCEL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_DATA_LOAD,_FUNCKEY_PERSONAL_CONFERENCE_SUMMARY_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_VIEW_MY_INITIAL_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ACTIVATE_CONFERENCE,_FUNCKEY_PERSONAL_CONFERENCE_ADJUST_CONFERENCE,_FUNCKEY_PERSONAL_NEWS_DATA_LOAD,_FUNCKEY_PERSONAL_DOCS_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_APPLY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_RECOMMEND,_FUNCKEY_PERSONAL_JOBAPPLY_DATA_LOAD,_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY,_FUNCKEY_PERSONAL_JOBAPPLY_JOB_VIEW,_FUNCKEY_PERSONAL_JOBAPPLY_RESUME_VIEW,_FUNCKEY_PERSONAL_INTERVIEW_HISTORY,_FUNCKEY_PERSONAL_INTERVIEW_COMMIT,_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW,_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW,_FUNCKEY_PERSONAL_APPLICATION_POST,_FUNCKEY_PERSONAL_APPLICATION_VIEW,_FUNCKEY_PERSONAL_APPROVAL_DATA_LOAD,_FUNCKEY_HRM_JOBHIRE_JOB_LIST_VIEW,_FUNCKEY_HRM_JOBHIRE_JOB_POST,_FUNCKEY_HRM_DEVELOP_VIEWDATA,_FUNCKEY_HRM_DEVELOP_FINALIZE,_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS,_FUNCKEY_HRM_DEVELOP_APPROVE,_FUNCKEY_FINAN_EXPENSE_APPROVE,_FUNCKEY_FINAN_EXPENSE_DATA_LOAD,_FUNCKEY_FINAN_EXPENSE_VIEW,_FUNCKEY_FINAN_EXPENSE_APPLY,_FUNCKEY_FINAN_EXPENSE_RECORD_VIEW,_FUNCKEY_FINAN_CONTRACT_DATA_LOAD,_FUNCKEY_FINAN_CONTRACT_APPROVE,_FUNCKEY_FINAN_CONTRACT_APPLY,_FUNCKEY_FINAN_CONTRACT_VIEW,_FUNCKEY_FINAN_CONTRACT_RECORD_VIEW,', 2, 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_role_dac`
--

CREATE TABLE IF NOT EXISTS `app_role_dac` (
  `role_id` bigint(20) NOT NULL,
  `stg_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`stg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限组的数据权限';

--
-- 转存表中的数据 `app_role_dac`
--

INSERT INTO `app_role_dac` (`role_id`, `stg_id`) VALUES
(7, 23),
(7, 47),
(7, 65),
(7, 101),
(7, 105),
(7, 135),
(8, 23),
(8, 47),
(8, 48),
(8, 49),
(8, 50),
(8, 65),
(8, 101),
(8, 105),
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
(67, 23),
(67, 24),
(67, 25),
(67, 26),
(67, 35),
(67, 36),
(67, 37),
(67, 38),
(67, 47),
(67, 48),
(67, 49),
(67, 50),
(67, 55),
(67, 56),
(67, 57),
(67, 58),
(67, 63),
(67, 64),
(67, 65),
(67, 66),
(67, 67),
(67, 68),
(67, 69),
(67, 70),
(67, 107),
(67, 108),
(67, 135),
(67, 138),
(67, 139),
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
(68, 104),
(68, 105),
(68, 106),
(68, 107),
(68, 108),
(68, 109),
(68, 128),
(68, 129),
(68, 130),
(68, 135),
(68, 136),
(68, 138),
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
(69, 135),
(69, 136),
(69, 138),
(70, 99),
(70, 101),
(70, 102),
(70, 104),
(70, 105),
(70, 106),
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
(72, 102),
(72, 103),
(72, 104),
(72, 105),
(72, 106);

-- --------------------------------------------------------

--
-- 表的结构 `app_role_func`
--

CREATE TABLE IF NOT EXISTS `app_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`,`func_id`),
  KEY `role_id` (`role_id`),
  KEY `app_role_func_ibfk_2` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

--
-- 转存表中的数据 `app_role_func`
--

INSERT INTO `app_role_func` (`role_id`, `func_id`) VALUES
(7, 32),
(7, 34),
(7, 35),
(7, 37),
(7, 73),
(7, 78),
(7, 88),
(7, 89),
(7, 90),
(7, 91),
(7, 98),
(7, 99),
(7, 106),
(7, 127),
(7, 140),
(7, 141),
(7, 143),
(7, 144),
(7, 145),
(7, 147),
(7, 154),
(7, 155),
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
(8, 140),
(8, 141),
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
(23, 130),
(23, 131),
(23, 132),
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
(33, 133),
(33, 134),
(33, 135),
(35, 102),
(35, 103),
(35, 104),
(35, 105),
(35, 106),
(35, 107),
(36, 102),
(36, 106),
(36, 108),
(37, 106),
(38, 5),
(38, 6),
(38, 7),
(39, 5),
(39, 13),
(41, 5),
(41, 7),
(41, 8),
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
(67, 73),
(67, 74),
(67, 75),
(67, 76),
(67, 77),
(67, 78),
(67, 79),
(67, 80),
(67, 81),
(67, 82),
(67, 83),
(67, 84),
(67, 85),
(67, 86),
(67, 87),
(67, 88),
(67, 89),
(67, 90),
(67, 91),
(67, 92),
(67, 93),
(67, 94),
(67, 95),
(67, 98),
(67, 99),
(67, 102),
(67, 103),
(67, 104),
(67, 105),
(67, 106),
(67, 107),
(67, 108),
(67, 127),
(67, 128),
(67, 129),
(67, 130),
(67, 131),
(67, 132),
(67, 140),
(67, 141),
(67, 142),
(67, 143),
(67, 144),
(67, 145),
(67, 146),
(67, 147),
(67, 148),
(67, 156),
(68, 5),
(68, 6),
(68, 8),
(68, 9),
(68, 10),
(68, 11),
(68, 13),
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
(72, 155);

-- --------------------------------------------------------

--
-- 表的结构 `app_role_menu`
--

CREATE TABLE IF NOT EXISTS `app_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单';

--
-- 转存表中的数据 `app_role_menu`
--

INSERT INTO `app_role_menu` (`role_id`, `menu_id`) VALUES
(7, 3),
(7, 4),
(7, 5),
(7, 6),
(7, 7),
(7, 9),
(7, 17),
(7, 28),
(7, 29),
(7, 30),
(7, 31),
(7, 32),
(7, 33),
(7, 34),
(7, 35),
(7, 37),
(7, 39),
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
(46, 46),
(46, 48),
(46, 49),
(46, 50),
(46, 51),
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
(52, 45),
(52, 46),
(52, 48),
(52, 49),
(52, 50),
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
(56, 45),
(56, 46),
(56, 47),
(56, 48),
(56, 49),
(56, 50),
(56, 51),
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
(67, 3),
(67, 4),
(67, 17),
(67, 32),
(67, 33),
(67, 34),
(67, 35),
(67, 36),
(67, 37),
(67, 38),
(67, 39),
(67, 40),
(67, 41),
(67, 43),
(67, 44),
(68, 3),
(68, 4),
(68, 5),
(68, 6),
(68, 7),
(68, 8),
(68, 9),
(68, 17),
(68, 25),
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
(72, 9),
(72, 25),
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
(72, 48);

-- --------------------------------------------------------

--
-- 表的结构 `app_school_department`
--

CREATE TABLE IF NOT EXISTS `app_school_department` (
  `dep_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dep_no` varchar(32) NOT NULL COMMENT '部门编号',
  `dep_name` varchar(128) NOT NULL COMMENT '部门名称',
  `dep_desc` varchar(256) DEFAULT NULL COMMENT '部门描述',
  `dep_eqlevel` tinyint(4) DEFAULT '-1' COMMENT '对口级别, -1=无, 0=总部, 1=校区, 2=片区',
  `dep_eqid` bigint(20) DEFAULT NULL COMMENT '对口部门',
  `dep_orgtype` tinyint(4) NOT NULL COMMENT '部门结构类型 0=总部, 1=校区, 2=片区',
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='学校部门设置' AUTO_INCREMENT=29 ;

--
-- 转存表中的数据 `app_school_department`
--

INSERT INTO `app_school_department` (`dep_id`, `dep_no`, `dep_name`, `dep_desc`, `dep_eqlevel`, `dep_eqid`, `dep_orgtype`) VALUES
(15, '1', '总经办', '', 0, NULL, 0),
(16, '2', '市场部', '', 0, 15, 0),
(17, '3', '财务部', '', 0, 15, 0),
(18, '1', '校区办', '', 0, 15, 1),
(19, '5', '教务部', '', 0, 23, 1),
(20, '6', '行政部', '', 0, 24, 1),
(21, '2', '咨询部', '', 0, 16, 1),
(22, '4', '运营部', '', 0, 15, 0),
(23, '5', '教研部', '', 0, 15, 0),
(24, '6', '行政部', '', 0, 15, 0),
(25, '5', '财务部', '', 0, 17, 1),
(26, '7', '人资部', '', 0, 15, 0),
(27, '8', '发展部', '', 0, 15, 0),
(28, '1', '片区办', '', 0, 27, 2);

-- --------------------------------------------------------

--
-- 表的结构 `app_school_department_position`
--

CREATE TABLE IF NOT EXISTS `app_school_department_position` (
  `pos_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pos_name` varchar(150) NOT NULL COMMENT '岗位名称',
  `pos_desc` varchar(250) DEFAULT NULL COMMENT '岗位描述',
  `pos_leadership` tinyint(4) DEFAULT '1' COMMENT '是否领导, 0=是, 1=不是',
  `dep_id` bigint(20) NOT NULL COMMENT '部门ID',
  `pos_roleRights` text COMMENT '岗位角色权限',
  PRIMARY KEY (`pos_id`),
  KEY `dep_id` (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='部门岗位' AUTO_INCREMENT=57 ;

--
-- 转存表中的数据 `app_school_department_position`
--

INSERT INTO `app_school_department_position` (`pos_id`, `pos_name`, `pos_desc`, `pos_leadership`, `dep_id`, `pos_roleRights`) VALUES
(13, '副总经理', '', 0, 15, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_RECRUIT_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_EMPLOYEE_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_HRM_DEVELOP_FINALIZE,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(14, '市场总监', '', 0, 16, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(15, '市场专员', '', 1, 16, 'ROLE_EMPLOYEE_HEADOFFICE'),
(17, '财务专员', '', 1, 17, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(25, '校区行政', '', 1, 20, 'ROLE_EMPLOYEE_SCHOOL'),
(26, '总经理', '', 0, 15, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_SYSTEM_MANAGE'),
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
(42, '教务总监', '', 0, 23, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(43, '教务专员', '', 1, 23, 'ROLE_EMPLOYEE_HEADOFFICE'),
(44, '行政总监', '', 0, 24, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_ADMIN_NEWS_APPROVE,ROLE_PERSONAL_NEWS_READ,ROLE_ADMIN_TASK_APPROVE,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_WORKPLAN_ADD,ROLE_ADMIN_WORKPLAN_ADJUST,ROLE_ADMIN_WORKPLAN_READ,ROLE_ADMIN_ATTENDANCE_MANAGE,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
(45, '行政专员', '', 1, 24, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_WORKPLAN_ADD,ROLE_ADMIN_WORKPLAN_ADJUST,ROLE_ADMIN_WORKPLAN_READ,ROLE_ADMIN_ATTENDANCE_MANAGE,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD'),
(46, '人资总监', '', 0, 26, 'ROLE_EMPLOYEE_HEADOFFICE,ROLE_ADMIN_NEWS_PUBLISH,ROLE_PERSONAL_NEWS_READ,ROLE_PERSONAL_TASK_PUBLISH,ROLE_PERSONAL_TASK_READ,ROLE_ADMIN_DOC_UPLOAD,ROLE_PERSONAL_DOC_DOWNLOAD,ROLE_PERSONAL_CONFERENCE_MANAGE,ROLE_PERSONAL_CONFERENCE_SUMMARY,ROLE_PERSONAL_CONFERENCE_READ,ROLE_ADMIN_HRM_JOB_PUBLISH,ROLE_ADMIN_HRM_JOB_APPROVE,ROLE_ADMIN_HRM_JOB_MANAGE,ROLE_ADMIN_HRM_ONBOARD_REVIEW,ROLE_ADMIN_HRM_ONBOARD,ROLE_ADMIN_HRM_RECRUIT_REVIEW,ROLE_ADMIN_HRM_RECRUITING,ROLE_ADMIN_HRM_RECRUIT_RESULT,ROLE_ADMIN_HRM_ARCHIVE_RESUME_REMOVE,ROLE_ADMIN_HRM_ARCHIVE_RESUME_VIEW,ROLE_ADMIN_HRM_ENTRY_OP_ONBOARD,ROLE_ADMIN_HRM_ENTRY_OP_QUALIFY,ROLE_ADMIN_HRM_EMPLOYEE_ADD,ROLE_ADMIN_HRM_EMPLOYEE_DELETE,ROLE_ADMIN_HRM_EMPLOYEE_VIEW,ROLE_ADMIN_HRM_DEVELOP_APPROVE,ROLE_ADMIN_HRM_DEVELOP_VIEWAPPROVA,ROLE_ADMIN_HRM_DEVELOP_FINALIZE,ROLE_ADMIN_FINAN_EXPENSE_APPLY,ROLE_ADMIN_FINAN_EXPENSE_APPROVE,ROLE_ADMIN_FINAN_CONTRACT_APPLY,ROLE_ADMIN_FINAN_CONTRACT_APPROVE'),
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
-- 表的结构 `app_school_department_position_role`
--

CREATE TABLE IF NOT EXISTS `app_school_department_position_role` (
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`pos_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位权限';

--
-- 转存表中的数据 `app_school_department_position_role`
--

INSERT INTO `app_school_department_position_role` (`pos_id`, `role_id`) VALUES
(13, 7),
(13, 22),
(13, 24),
(13, 27),
(13, 28),
(13, 33),
(13, 34),
(13, 35),
(13, 36),
(13, 37),
(13, 38),
(13, 42),
(13, 44),
(13, 49),
(13, 54),
(13, 55),
(13, 56),
(13, 57),
(13, 58),
(13, 59),
(13, 60),
(13, 61),
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
(27, 68),
(28, 7),
(28, 58),
(28, 59),
(28, 60),
(28, 61),
(29, 7),
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
-- 表的结构 `app_school_district`
--

CREATE TABLE IF NOT EXISTS `app_school_district` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='校区设置' AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `app_school_district`
--

INSERT INTO `app_school_district` (`district_id`, `district_no`, `district_name`, `district_type`, `district_address`, `district_phone`, `district_parent`) VALUES
(1, '0000', '杭州总部', 0, '', '', NULL),
(3, '0001', '绍兴解放路校区', 1, '', '', 10),
(4, '0002', '绍兴迪荡校区', 1, '德清', '', 1),
(5, '0003', '柯桥校区', 1, '', '', 1),
(6, '0004', '嘉兴校区', 1, '', '', 1),
(7, '0005', '湖州校区', 1, '', '', 1),
(8, '0006', '萧山校区', 1, '', '', 1),
(9, '0007', '德清校区', 1, '', '', 1),
(10, '0008', '萧绍片区', 2, '', '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_school_posets`
--

CREATE TABLE IF NOT EXISTS `app_school_posets` (
  `poset_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '职位岗位ID',
  `poset_name` varchar(64) NOT NULL COMMENT '职位岗位名称',
  PRIMARY KEY (`poset_id`),
  UNIQUE KEY `poset_name` (`poset_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='职位岗位' AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `app_school_posets`
--

INSERT INTO `app_school_posets` (`poset_id`, `poset_name`) VALUES
(12, '基本岗位（总部）'),
(13, '基本岗位（校区）'),
(11, '总经办职位'),
(10, '总部主管'),
(14, '校区主管（校区）');

-- --------------------------------------------------------

--
-- 表的结构 `app_school_posets_terms`
--

CREATE TABLE IF NOT EXISTS `app_school_posets_terms` (
  `poset_id` bigint(20) NOT NULL COMMENT '职位岗位ID',
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`poset_id`,`pos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职位与岗位关系表';

--
-- 转存表中的数据 `app_school_posets_terms`
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
-- 表的结构 `app_system_config`
--

CREATE TABLE IF NOT EXISTS `app_system_config` (
  `config_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(64) NOT NULL COMMENT 'Key',
  `config_name` varchar(64) NOT NULL COMMENT '配置名称',
  `config_desc` varchar(256) DEFAULT NULL COMMENT '配置描述',
  `type_name` varchar(32) NOT NULL COMMENT '所属分类名称',
  `data_type` smallint(6) NOT NULL COMMENT '数据类型            1=varchar            2=intger            3=decimal            4=datetime            5=time            ',
  `data_value` varchar(64) DEFAULT NULL COMMENT '数据值',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置,用于系统的全局配置' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_system_dictionary`
--

CREATE TABLE IF NOT EXISTS `app_system_dictionary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `value` varchar(200) NOT NULL,
  `type` varchar(200) NOT NULL,
  `level` varchar(200) DEFAULT NULL COMMENT '级别',
  `sequence` int(11) NOT NULL DEFAULT '0',
  `extra_value` varchar(200) DEFAULT NULL,
  `creation_date` datetime DEFAULT '0000-00-00 00:00:00',
  `modified_date` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- 转存表中的数据 `app_system_dictionary`
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
-- 表的结构 `app_system_log`
--

CREATE TABLE IF NOT EXISTS `app_system_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(120) NOT NULL COMMENT '用户名',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  `detail` text COMMENT '操作详细说明',
  `ip` varchar(128) DEFAULT NULL COMMENT '登录IP',
  `cost` bigint(20) DEFAULT NULL COMMENT '操作耗时',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统日志' AUTO_INCREMENT=292 ;

--
-- 转存表中的数据 `app_system_log`
--

INSERT INTO `app_system_log` (`log_id`, `user_name`, `user_id`, `createtime`, `operation`, `detail`, `ip`, `cost`) VALUES
(1, '管理员', 1, '2012-07-26 11:50:42', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 240),
(3, '管理员', 1, '2012-07-26 13:50:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 37),
(5, '管理员', 1, '2012-07-26 14:08:47', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 40),
(7, '管理员', 1, '2012-07-26 14:10:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 60),
(8, '管理员', 1, '2012-07-26 14:56:08', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 79),
(9, '管理员', 1, '2012-07-27 09:28:51', '登录', '用户通过身份验证进入系统', '127.0.0.1', 656),
(10, '管理员', 1, '2012-07-27 09:28:51', '登录', '用户通过身份验证进入系统', '127.0.0.1', 203),
(11, '管理员', 1, '2012-07-27 12:27:15', '登录', '用户通过身份验证进入系统', '127.0.0.1', 297),
(12, '管理员', 1, '2012-07-27 12:27:15', '登录', '用户通过身份验证进入系统', '127.0.0.1', 1266),
(13, '管理员', 1, '2012-07-27 14:34:01', '登录', '用户通过身份验证进入系统', '127.0.0.1', 875),
(15, '管理员', 1, '2012-07-28 09:47:03', '登录', '用户通过身份验证进入系统', '127.0.0.1', 110),
(20, '管理员', 1, '2012-07-28 09:57:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 78),
(23, '管理员', 1, '2012-07-28 10:09:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 3773),
(25, '管理员', 1, '2012-07-28 11:35:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 42),
(26, '管理员', 1, '2012-07-28 11:36:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 78),
(27, '管理员', 1, '2012-07-28 11:38:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 75),
(28, '管理员', 1, '2012-07-28 11:39:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 82),
(31, '管理员', 1, '2012-07-28 22:40:26', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 406),
(32, '管理员', 1, '2012-07-28 22:42:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 94),
(33, '管理员', 1, '2012-07-29 00:48:10', '登录', '用户通过身份验证进入系统', '127.0.0.1', 83),
(34, '管理员', 1, '2012-07-29 02:34:00', '登录', '用户通过身份验证进入系统', '127.0.0.1', 233),
(35, '管理员', 1, '2012-07-29 03:26:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 63),
(36, '管理员', 1, '2012-07-29 16:53:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 240),
(37, '管理员', 1, '2012-07-29 21:42:54', '登录', '用户通过身份验证进入系统', '127.0.0.1', 70),
(38, '管理员', 1, '2012-07-29 21:52:26', '登录', '用户通过身份验证进入系统', '127.0.0.1', 261),
(39, '管理员', 1, '2012-07-30 12:16:02', '登录', '用户通过身份验证进入系统', '127.0.0.1', 1235),
(40, '管理员', 1, '2012-07-30 12:16:04', '登录', '用户通过身份验证进入系统', '127.0.0.1', 156),
(43, '管理员', 1, '2012-07-30 14:19:35', '登录', '用户通过身份验证进入系统', '127.0.0.1', 704),
(44, '管理员', 1, '2012-07-31 02:46:11', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 247),
(47, '管理员', 1, '2012-07-31 10:36:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 48),
(48, '管理员', 1, '2012-07-31 10:37:08', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 45),
(50, '管理员', 1, '2012-07-31 11:23:36', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 69),
(51, '管理员', 1, '2012-07-31 11:26:05', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 48),
(53, '管理员', 1, '2012-07-31 11:27:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 38),
(55, '管理员', 1, '2012-07-31 11:34:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 50),
(57, '管理员', 1, '2012-07-31 11:40:24', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 68),
(59, '管理员', 1, '2012-07-31 12:13:55', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 59),
(60, '周碧英', 25, '2012-07-31 13:22:31', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 82),
(61, '管理员', 1, '2012-07-31 13:22:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 40),
(62, '许玉凤', 22, '2012-07-31 13:23:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 51),
(63, '杨琪', 27, '2012-07-31 13:23:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 66),
(64, '管理员', 1, '2012-07-31 13:53:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 101),
(65, '杨琪', 27, '2012-07-31 13:58:48', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 88),
(66, '管理员', 1, '2012-07-31 14:06:02', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 50),
(67, '罗佳驹', 19, '2012-07-31 14:20:50', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 47),
(68, '俞柏红', 31, '2012-07-31 14:22:06', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 61),
(69, '管理员', 1, '2012-07-31 14:22:26', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 41),
(70, '俞柏红', 31, '2012-07-31 14:24:23', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 65),
(71, '俞柏红', 31, '2012-07-31 14:25:43', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 59),
(72, '管理员', 1, '2012-07-31 14:27:46', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 72),
(73, '俞柏红', 31, '2012-07-31 14:44:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 49),
(74, '管理员', 1, '2012-07-31 14:55:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 36),
(75, '杨琪', 27, '2012-07-31 14:57:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 56),
(76, '管理员', 1, '2012-07-31 15:02:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 38),
(77, '杨琪', 27, '2012-07-31 15:05:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 57),
(78, '杨琪', 27, '2012-07-31 15:05:21', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 48),
(79, '管理员', 1, '2012-07-31 15:10:36', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 254),
(80, '杨琪', 27, '2012-07-31 15:10:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 46),
(81, '管理员', 1, '2012-07-31 15:12:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 43),
(82, '杨琪', 27, '2012-07-31 15:18:12', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 76),
(83, '管理员', 1, '2012-07-31 15:18:46', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 37),
(84, '杨琪', 27, '2012-07-31 15:19:44', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 76),
(85, '管理员', 1, '2012-07-31 15:21:17', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 62),
(86, '杨琪', 27, '2012-07-31 15:22:44', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 55),
(87, '管理员', 1, '2012-07-31 15:27:36', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 776),
(88, '杨琪', 27, '2012-07-31 15:36:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 70),
(89, '管理员', 1, '2012-07-31 15:36:37', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 82),
(90, '杨琪', 27, '2012-07-31 15:37:29', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 74),
(91, '管理员', 1, '2012-07-31 15:38:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 54),
(92, '俞柏红', 31, '2012-07-31 15:39:38', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 58),
(93, '管理员', 1, '2012-07-31 15:39:54', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 48),
(94, '俞柏红', 31, '2012-07-31 15:40:27', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 65),
(95, '管理员', 1, '2012-07-31 16:14:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 41),
(96, '罗佳驹', 19, '2012-07-31 16:15:02', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 55),
(97, '俞柏红', 31, '2012-07-31 16:15:43', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 73),
(98, '管理员', 1, '2012-07-31 16:18:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 61),
(99, '俞柏红', 31, '2012-07-31 19:58:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 481),
(100, '罗佳驹', 19, '2012-07-31 19:58:51', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 77),
(101, '管理员', 1, '2012-07-31 19:59:04', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 52),
(102, '管理员', 1, '2012-07-31 20:11:05', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 46),
(103, '管理员', 1, '2012-07-31 20:22:03', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 108),
(104, '管理员', 1, '2012-07-31 21:15:04', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 178),
(105, 'ljx', 36, '2012-07-31 21:38:22', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 64),
(106, '杨琪', 27, '2012-07-31 21:40:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 135),
(107, '苏斯翔', 30, '2012-07-31 21:42:55', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 111),
(108, '管理员', 1, '2012-07-31 22:14:30', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 296),
(109, '管理员', 1, '2012-08-01 11:08:37', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 1446),
(110, 'ljx', 36, '2012-08-01 11:17:55', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 246),
(111, '苏斯翔', 30, '2012-08-01 11:22:01', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 53),
(112, '杨琪', 27, '2012-08-01 11:22:51', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 54),
(113, 'ljx', 36, '2012-08-01 11:24:37', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 64),
(114, '杨琪', 27, '2012-08-01 11:25:50', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 83),
(115, '管理员', 1, '2012-08-01 11:33:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 57),
(116, 'ljx', 36, '2012-08-01 11:40:31', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 49),
(117, '管理员', 1, '2012-08-01 11:42:09', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 98),
(118, 'ljx', 36, '2012-08-01 13:50:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 87),
(119, '管理员', 1, '2012-08-01 13:52:10', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 48),
(120, 'ljx', 36, '2012-08-01 13:53:08', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 91),
(121, '管理员', 1, '2012-08-01 13:53:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 53),
(122, '管理员', 1, '2012-08-01 16:54:12', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 388),
(123, 'ljx', 36, '2012-08-01 16:55:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 155),
(124, '管理员', 1, '2012-08-01 17:09:14', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 72),
(125, 'ljx', 36, '2012-08-01 17:38:43', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 72),
(126, '管理员', 1, '2012-08-01 17:41:57', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 59),
(127, 'ljx', 36, '2012-08-01 17:56:31', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 69),
(128, '管理员', 1, '2012-08-01 19:51:36', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 320),
(129, 'ljx', 36, '2012-08-01 19:53:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 105),
(130, '管理员', 1, '2012-08-01 19:55:05', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 77),
(131, '管理员', 1, '2012-08-02 16:43:04', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 1091),
(132, '梅杰', 20, '2012-08-02 17:01:07', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 206),
(133, '管理员', 1, '2012-08-02 17:40:09', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 41),
(134, '管理员', 1, '2012-08-02 17:42:34', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 50),
(135, '罗佳驹', 19, '2012-08-02 17:43:27', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 61),
(136, '管理员', 1, '2012-08-02 17:46:15', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 50),
(137, '罗佳驹', 19, '2012-08-02 17:46:48', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 54),
(138, '罗佳驹', 19, '2012-08-02 17:47:06', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 84),
(139, '管理员', 1, '2012-08-02 17:53:44', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 145),
(140, '管理员', 1, '2012-08-02 20:51:01', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 409),
(141, 'ljx', 36, '2012-08-02 20:51:47', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 143),
(142, '管理员', 1, '2012-08-02 20:59:01', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 77),
(143, '管理员', 1, '2012-08-02 21:30:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 107),
(144, '管理员', 1, '2012-08-02 22:51:48', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 99),
(145, '管理员', 1, '2012-08-03 08:36:01', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 1858),
(146, '管理员', 1, '2012-08-03 08:40:12', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 49),
(147, '梅杰', 20, '2012-08-03 09:36:07', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 263),
(148, '管理员', 1, '2012-08-03 09:36:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 68),
(149, '管理员', 1, '2012-08-03 10:09:50', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 303),
(150, 'ljx', 36, '2012-08-03 12:05:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 90),
(151, '管理员', 1, '2012-08-03 12:08:07', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 66),
(152, 'ljx', 36, '2012-08-03 12:08:54', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 62),
(153, '管理员', 1, '2012-08-03 12:09:22', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 70),
(154, 'ljx', 36, '2012-08-03 12:10:03', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 105),
(155, '管理员', 1, '2012-08-03 12:25:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 307),
(156, '管理员', 1, '2012-08-03 13:00:04', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 858),
(157, '管理员', 1, '2012-08-03 14:01:21', '登录', '用户通过身份验证进入系统', '125.118.54.30', 40),
(158, '管理员', 1, '2012-08-03 14:02:05', '登录', '用户通过身份验证进入系统', '125.118.54.30', 39),
(159, '管理员', 1, '2012-08-03 14:02:40', '登录', '用户通过身份验证进入系统', '125.118.54.30', 35),
(160, '管理员', 1, '2012-08-03 16:13:17', '登录', '用户通过身份验证进入系统', '125.118.54.30', 37),
(161, '梅杰', 20, '2012-08-03 16:17:10', '登录', '用户通过身份验证进入系统', '125.118.54.30', 49),
(162, '管理员', 1, '2012-08-03 16:21:03', '登录', '用户通过身份验证进入系统', '125.118.54.30', 26),
(163, '梅杰', 20, '2012-08-03 16:24:07', '登录', '用户通过身份验证进入系统', '125.118.54.30', 37),
(164, '管理员', 1, '2012-08-03 16:25:19', '登录', '用户通过身份验证进入系统', '125.118.54.30', 33),
(165, '梅杰', 20, '2012-08-03 16:26:32', '登录', '用户通过身份验证进入系统', '125.118.54.30', 34),
(166, '管理员', 1, '2012-08-03 16:27:54', '登录', '用户通过身份验证进入系统', '125.118.54.30', 28),
(167, '罗佳驹', 19, '2012-08-03 16:28:07', '登录', '用户通过身份验证进入系统', '125.118.54.30', 36),
(168, '林立', 37, '2012-08-03 16:38:24', '登录', '用户通过身份验证进入系统', '125.118.54.30', 37),
(169, '管理员', 1, '2012-08-03 16:38:58', '登录', '用户通过身份验证进入系统', '125.118.54.30', 25),
(170, '杨琪', 27, '2012-08-05 19:20:15', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 84),
(171, '杨琪', 27, '2012-08-05 19:20:53', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 178),
(172, '管理员', 1, '2012-08-05 19:22:33', '登录', '用户通过身份验证进入系统', '127.0.0.1', 12),
(173, '管理员', 1, '2012-08-05 19:34:29', '登录', '用户通过身份验证进入系统', '127.0.0.1', 212),
(174, '杨琪', 27, '2012-08-05 19:36:54', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 74),
(175, '管理员', 1, '2012-08-06 21:40:48', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 325),
(176, '梅杰', 20, '2012-08-06 22:16:22', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 171),
(177, '梅杰', 20, '2012-08-06 22:17:50', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 21),
(178, '梅杰', 20, '2012-08-06 22:23:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 16),
(179, '管理员', 1, '2012-08-06 22:38:07', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 72),
(180, '管理员', 1, '2012-08-06 22:44:28', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 310),
(181, '管理员', 1, '2012-08-06 22:47:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 263),
(182, '管理员', 1, '2012-08-08 13:51:01', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 173),
(183, '管理员', 1, '2012-08-08 14:42:46', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 40),
(184, '管理员', 1, '2012-08-22 14:32:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 267),
(185, '管理员', 1, '2012-08-22 14:37:36', '登录', '用户通过身份验证进入系统', '127.0.0.1', 183),
(186, '管理员', 1, '2012-08-22 15:59:55', '登录', '用户通过身份验证进入系统', '127.0.0.1', 147),
(187, '管理员', 1, '2012-08-22 16:55:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 149),
(188, '管理员', 1, '2012-08-22 17:31:10', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 93),
(189, '林菁菁', 21, '2012-08-22 18:19:31', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 102),
(190, '管理员', 1, '2012-08-22 19:30:52', '登录', '用户通过身份验证进入系统', '127.0.0.1', 200),
(191, '罗佳驹', 19, '2012-08-22 19:34:19', '登录', '用户通过身份验证进入系统', '127.0.0.1', 95),
(192, '管理员', 1, '2012-08-22 19:35:20', '登录', '用户通过身份验证进入系统', '127.0.0.1', 53),
(193, '罗佳驹', 19, '2012-08-22 19:36:02', '登录', '用户通过身份验证进入系统', '127.0.0.1', 193),
(194, '罗佳驹', 19, '2012-08-22 19:39:31', '登录', '用户通过身份验证进入系统', '127.0.0.1', 208),
(195, '管理员', 1, '2012-08-22 19:43:29', '登录', '用户通过身份验证进入系统', '127.0.0.1', 241),
(196, '梅杰', 20, '2012-08-22 19:44:44', '登录', '用户通过身份验证进入系统', '127.0.0.1', 193),
(197, '管理员', 1, '2012-08-22 19:51:25', '登录', '用户通过身份验证进入系统', '127.0.0.1', 44),
(198, '管理员', 1, '2012-08-22 20:22:36', '登录', '用户通过身份验证进入系统', '127.0.0.1', 210),
(199, '管理员', 1, '2012-08-22 20:35:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 158),
(200, '管理员', 1, '2012-08-22 20:41:20', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 215),
(201, '管理员', 1, '2012-08-22 20:45:51', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 157),
(202, '管理员', 1, '2012-08-22 20:49:44', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 167),
(203, '梅杰', 20, '2012-08-22 20:50:18', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 234),
(204, '管理员', 1, '2012-08-22 20:59:35', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 188),
(205, '管理员', 1, '2012-08-22 21:07:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 175),
(206, '管理员', 1, '2012-08-22 21:34:18', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 142),
(207, '梅杰', 20, '2012-08-22 21:35:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 281),
(208, '管理员', 1, '2012-08-22 21:35:46', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 74),
(209, '管理员', 1, '2012-08-23 09:34:30', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 2938),
(210, '梅杰', 20, '2012-08-23 11:25:09', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 206),
(211, '管理员', 1, '2012-08-23 11:25:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 46),
(212, '梅杰', 20, '2012-08-23 11:26:38', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 48),
(213, '管理员', 1, '2012-08-23 11:27:42', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 61),
(214, '梅杰', 20, '2012-08-23 11:33:03', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 151),
(215, '管理员', 1, '2012-08-23 11:33:29', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 61),
(216, '梅杰', 20, '2012-08-23 11:36:47', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 63),
(217, '林菁菁', 21, '2012-08-23 11:37:11', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 191),
(218, '管理员', 1, '2012-08-23 11:47:36', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 133),
(219, '梅杰', 20, '2012-08-23 11:48:43', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 62),
(220, '林菁菁', 21, '2012-08-23 11:49:23', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 58),
(221, '罗佳驹', 19, '2012-08-23 11:51:25', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 52),
(222, '管理员', 1, '2012-08-23 11:57:56', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 47),
(223, '林菁菁', 21, '2012-08-23 12:02:32', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 91),
(224, '管理员', 1, '2012-08-23 12:03:30', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 43),
(225, '林菁菁', 21, '2012-08-23 12:05:39', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 67),
(226, '管理员', 1, '2012-08-23 12:11:08', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 44),
(227, '管理员', 1, '2012-08-23 13:03:29', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 423),
(228, '林菁菁', 21, '2012-08-23 13:03:59', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 111),
(229, '管理员', 1, '2012-08-23 13:05:43', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 97),
(230, '梅杰', 20, '2012-08-23 13:13:59', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 151),
(231, '管理员', 1, '2012-08-23 13:14:42', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 58),
(232, '梅杰', 20, '2012-08-23 13:15:52', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 145),
(233, '管理员', 1, '2012-08-23 13:17:00', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 57),
(234, '林菁菁', 21, '2012-08-23 13:18:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 124),
(235, '管理员', 1, '2012-08-23 13:28:43', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 158),
(236, '管理员', 1, '2012-08-23 13:36:28', '登录', '用户通过身份验证进入系统', '122.234.53.66', 26),
(237, '管理员', 1, '2012-08-23 13:54:02', '登录', '用户通过身份验证进入系统', '218.108.223.218', 90),
(238, '许玉凤', 22, '2012-08-23 14:05:42', '登录', '用户通过身份验证进入系统', '122.234.53.66', 75),
(239, '罗佳驹', 19, '2012-08-23 14:07:00', '登录', '用户通过身份验证进入系统', '122.234.53.66', 51),
(240, '管理员', 1, '2012-08-23 14:07:59', '登录', '用户通过身份验证进入系统', '122.234.53.66', 35),
(241, '蔡晓喻', 32, '2012-08-23 14:09:29', '登录', '用户通过身份验证进入系统', '122.234.53.66', 133),
(242, '章荷英', 33, '2012-08-23 14:12:11', '登录', '用户通过身份验证进入系统', '122.234.53.66', 53),
(243, '冯毓', 34, '2012-08-23 14:14:43', '登录', '用户通过身份验证进入系统', '122.234.53.66', 135),
(244, '管理员', 1, '2012-08-23 14:35:27', '登录', '用户通过身份验证进入系统', '122.234.53.66', 28),
(245, '周碧英', 25, '2012-08-23 14:36:14', '登录', '用户通过身份验证进入系统', '122.234.53.66', 48),
(246, '周碧英', 25, '2012-08-23 14:41:53', '登录', '用户通过身份验证进入系统', '122.234.53.66', 52),
(247, '周碧英', 25, '2012-08-23 14:43:40', '登录', '用户通过身份验证进入系统', '122.234.53.66', 41),
(248, '周碧英', 25, '2012-08-23 14:48:25', '登录', '用户通过身份验证进入系统', '122.234.53.66', 40),
(249, '周碧英', 25, '2012-08-23 14:53:12', '登录', '用户通过身份验证进入系统', '122.234.53.66', 48),
(250, '刘苗芳', 24, '2012-08-23 14:53:54', '登录', '用户通过身份验证进入系统', '122.234.53.66', 55),
(251, '刘苗芳', 24, '2012-08-23 14:55:19', '登录', '用户通过身份验证进入系统', '122.234.53.66', 56),
(252, '刘苗芳', 24, '2012-08-23 14:56:25', '登录', '用户通过身份验证进入系统', '122.234.53.66', 65),
(253, '刘苗芳', 24, '2012-08-23 14:57:19', '登录', '用户通过身份验证进入系统', '122.234.53.66', 78),
(254, '刘苗芳', 24, '2012-08-23 14:58:13', '登录', '用户通过身份验证进入系统', '122.234.53.66', 65),
(255, '管理员', 1, '2012-08-23 15:00:13', '登录', '用户通过身份验证进入系统', '122.234.53.66', 25),
(256, '梅杰', 20, '2012-08-23 15:01:39', '登录', '用户通过身份验证进入系统', '122.234.53.66', 65),
(257, '管理员', 1, '2012-08-23 15:03:05', '登录', '用户通过身份验证进入系统', '122.234.53.66', 27),
(258, '梅杰', 20, '2012-08-23 15:06:59', '登录', '用户通过身份验证进入系统', '122.234.53.66', 33),
(259, '管理员', 1, '2012-08-23 15:07:14', '登录', '用户通过身份验证进入系统', '122.234.53.66', 32),
(260, '管理员', 1, '2012-08-23 15:08:43', '登录', '用户通过身份验证进入系统', '122.234.53.66', 30),
(261, '梅杰', 20, '2012-08-23 15:09:24', '登录', '用户通过身份验证进入系统', '122.234.53.66', 34),
(262, '管理员', 1, '2012-08-23 15:09:41', '登录', '用户通过身份验证进入系统', '122.234.53.66', 28),
(263, '梅杰', 20, '2012-08-23 15:10:45', '登录', '用户通过身份验证进入系统', '122.234.53.66', 141),
(264, '管理员', 1, '2012-08-23 15:32:15', '登录', '用户通过身份验证进入系统', '122.234.53.66', 28),
(265, '周碧英', 25, '2012-08-23 15:32:56', '登录', '用户通过身份验证进入系统', '122.234.53.66', 43),
(266, '管理员', 1, '2012-08-23 15:39:37', '登录', '用户通过身份验证进入系统', '122.234.53.66', 28),
(267, '罗佳驹', 19, '2012-08-23 15:59:57', '登录', '用户通过身份验证进入系统', '122.234.53.66', 112),
(268, '管理员', 1, '2012-08-23 16:01:12', '登录', '用户通过身份验证进入系统', '122.234.53.66', 24),
(269, '罗佳驹', 19, '2012-08-23 16:03:04', '登录', '用户通过身份验证进入系统', '122.234.53.66', 124),
(270, 'leo', 38, '2012-08-23 16:05:26', '登录', '用户通过身份验证进入系统', '122.234.53.66', 38),
(271, '管理员', 1, '2012-08-23 16:06:06', '登录', '用户通过身份验证进入系统', '122.234.53.66', 24),
(272, 'leo', 38, '2012-08-23 16:19:54', '登录', '用户通过身份验证进入系统', '122.234.53.66', 40),
(273, '管理员', 1, '2012-08-23 16:20:26', '登录', '用户通过身份验证进入系统', '122.234.53.66', 26),
(274, '管理员', 1, '2012-08-24 12:28:38', '登录', '用户通过身份验证进入系统', '122.234.51.218', 49),
(275, '管理员', 1, '2012-08-24 14:19:54', '登录', '用户通过身份验证进入系统', '122.234.51.218', 86),
(276, '管理员', 1, '2012-08-24 14:43:23', '登录', '用户通过身份验证进入系统', '122.234.51.218', 24),
(277, '管理员', 1, '2012-08-24 15:24:09', '登录', '用户通过身份验证进入系统', '122.234.51.218', 31),
(278, '管理员', 1, '2012-08-24 15:59:12', '登录', '用户通过身份验证进入系统', '122.234.51.218', 25),
(279, '管理员', 1, '2012-08-27 13:21:10', '登录', '用户通过身份验证进入系统', '218.108.223.68', 91),
(280, '管理员', 1, '2012-08-27 13:44:17', '登录', '用户通过身份验证进入系统', '122.234.54.158', 41),
(281, '管理员', 1, '2012-08-27 13:49:25', '登录', '用户通过身份验证进入系统', '122.234.54.158', 29),
(282, '管理员', 1, '2012-08-27 15:00:47', '登录', '用户通过身份验证进入系统', '125.119.190.41', 24),
(283, '罗佳驹', 19, '2012-08-27 15:04:20', '登录', '用户通过身份验证进入系统', '125.119.190.41', 67),
(284, '管理员', 1, '2012-08-27 15:04:37', '登录', '用户通过身份验证进入系统', '125.119.190.41', 25),
(285, '梅杰', 20, '2012-08-27 15:05:15', '登录', '用户通过身份验证进入系统', '125.119.190.41', 102),
(286, '罗佳驹', 19, '2012-08-27 15:05:55', '登录', '用户通过身份验证进入系统', '125.119.190.41', 31),
(287, '管理员', 1, '2012-08-27 15:06:11', '登录', '用户通过身份验证进入系统', '125.119.190.41', 30),
(288, '管理员', 1, '2012-08-27 15:07:40', '登录', '用户通过身份验证进入系统', '125.119.190.41', 27),
(289, '管理员', 1, '2012-08-27 15:08:31', '登录', '用户通过身份验证进入系统', '125.119.190.41', 25),
(290, '管理员', 1, '2012-08-27 17:15:09', '登录', '用户通过身份验证进入系统', '125.119.190.41', 26),
(291, '管理员', 1, '2012-08-27 18:56:41', '登录', '用户通过身份验证进入系统', '183.140.206.26', 21);

-- --------------------------------------------------------

--
-- 表的结构 `app_system_work_content`
--

CREATE TABLE IF NOT EXISTS `app_system_work_content` (
  `cnt_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '工作内容ID',
  `item_name` varchar(120) DEFAULT NULL COMMENT '选项名称',
  `item_value` varchar(120) DEFAULT NULL COMMENT '选项值',
  `meto` varchar(250) DEFAULT NULL COMMENT '工作内容说明',
  `district_id` bigint(20) NOT NULL COMMENT '校区ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`cnt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统工作内容设置' AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `app_system_work_content`
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
-- 表的结构 `app_system_work_template`
--

CREATE TABLE IF NOT EXISTS `app_system_work_template` (
  `work_tpl_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '工作模板ID',
  `work_day` varchar(20) DEFAULT NULL COMMENT '工作日期',
  `worktm_id` bigint(20) DEFAULT NULL COMMENT '工作时间ID',
  `district_id` bigint(20) DEFAULT NULL COMMENT '校区ID',
  `staff_id` bigint(20) DEFAULT NULL COMMENT '员工ID',
  `staff_name` varchar(60) DEFAULT NULL COMMENT '员工姓名',
  `enable` char(1) DEFAULT '0' COMMENT '该模板是否启用',
  `template_id` bigint(20) DEFAULT NULL COMMENT '模板ID',
  `workcnt_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`work_tpl_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='工作模板设置' AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `app_system_work_template`
--

INSERT INTO `app_system_work_template` (`work_tpl_id`, `work_day`, `worktm_id`, `district_id`, `staff_id`, `staff_name`, `enable`, `template_id`, `workcnt_id`) VALUES
(12, '周一', 4, 1, 20, '梅杰', '1', 1, 4),
(13, '周一', 4, 1, 19, '罗佳驹', '1', 1, 4);

-- --------------------------------------------------------

--
-- 表的结构 `app_system_work_time`
--

CREATE TABLE IF NOT EXISTS `app_system_work_time` (
  `worktm_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '工作时间ID',
  `item_name` varchar(120) DEFAULT NULL COMMENT '选项名称',
  `work_stime` varchar(20) DEFAULT NULL COMMENT '工作开始时间',
  `work_etime` varchar(20) DEFAULT NULL COMMENT '工作结束时间',
  `meto` varchar(250) DEFAULT NULL COMMENT '说明',
  `adjust_days` varchar(120) DEFAULT NULL COMMENT '适用天数',
  `template_id` bigint(20) DEFAULT NULL COMMENT '模板ID',
  `district_id` bigint(20) NOT NULL COMMENT '校区ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`worktm_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='工作时间设置' AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `app_system_work_time`
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
-- 表的结构 `app_user`
--

CREATE TABLE IF NOT EXISTS `app_user` (
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
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '删除标记, 1=已删除, 0=未删除',
  `logon_lastip` varchar(64) DEFAULT NULL COMMENT '最后登录IP',
  `logon_lastime` datetime DEFAULT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`user_id`),
  KEY `FK_AU_R_DPT` (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表' AUTO_INCREMENT=39 ;

--
-- 转存表中的数据 `app_user`
--

INSERT INTO `app_user` (`user_id`, `username`, `password`, `fullname`, `email`, `dep_id`, `pos_id`, `district_id`, `emp_id`, `phone`, `mobile`, `fax`, `address`, `zip`, `photo`, `status`, `del_flag`, `logon_lastip`, `logon_lastime`) VALUES
(1, 'admin', 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=', '管理员', 'csx@jee-soft.cn', NULL, 26, 1, 19, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '183.140.206.26', '2012-08-27 18:56:41'),
(19, '00001001', 'ro+N+ETeTFw+SYrc4TnIzXuXWwO93mUJgr0ArrsNPfk=', '罗佳驹', NULL, 15, 26, 1, 19, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.119.190.41', '2012-08-27 15:05:55'),
(20, '00001002', 'YtwP6mUL0cqp45wC4yCgaYVYKkKWE4LUtMn1mqljowc=', '梅杰', NULL, 15, 13, 1, 20, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.119.190.41', '2012-08-27 15:05:15'),
(21, '00003001', 'mxA4ujFL57JAzeke5W87Cujn+35uwD+aKrCuNK4f+6A=', '林菁菁', NULL, 17, 39, 1, 21, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '0:0:0:0:0:0:0:1', '2012-08-23 13:18:41'),
(22, '00004001', 'p0TBRM7B1PaLy7I3j+aXC7xeOeBwzBU7pF6IxMFGLOg=', '许玉凤', NULL, 22, 40, 1, 22, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.53.66', '2012-08-23 14:05:42'),
(23, '00005001', 'B4aIJZIEodZjpMtGatbKbo46E2vBzRJBFmJPmW2frYI=', '王伟平', NULL, 23, 42, 1, 23, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '218.108.223.245', '2012-08-07 15:52:37'),
(24, '00002001', '/4xWL9bhPAve03Tu5HeR7T0U6Qsmy6eYjLtZM4aAcFs=', '刘苗芳', NULL, 16, 14, 1, 24, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.53.66', '2012-08-23 14:58:13'),
(25, '00003002', 'CqfBdfhjcLbqOIDd62kTxYiDhAbXBkgFrv8eH8/fpQw=', '周碧英', NULL, 17, 28, 1, 25, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.53.66', '2012-08-23 15:32:56'),
(26, '00003003', '8t8/A0jkYHUyLfiJtVydFhZ0Q/X2xuJ1LGJUPHLs4Zk=', '蒋晓萍', NULL, 17, 17, 1, 26, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL),
(27, '00006001', 'AdR3o6rcgoyXwyqu2QCIn/IbWgsYIfDIbybGB7ESK+k=', '杨琪', NULL, 24, 45, 1, 27, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '0:0:0:0:0:0:0:1', '2012-08-01 11:25:50'),
(28, '00005002', 'VmQ2dhyZSxuzomLV9mx1T+y2Fl7rkdxAxIkbDN7dWT4=', '何滨', NULL, 23, 43, 1, 28, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL),
(29, '00002002', 'VH4xR+A+M04zzSSzxg3T2osRhsB1+1gJYxVjJ38uk4E=', '程聪', NULL, 16, 29, 1, 29, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL),
(30, '00005003', 'yFKhbyaKjjizMHXNo0w0Kp45bl/g3/5fRBNJKMmq8t0=', '苏斯翔', NULL, 23, 43, 1, 30, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '0:0:0:0:0:0:0:1', '2012-08-01 11:22:01'),
(31, '00066001', 'rfm23G77+wfY8xG9pX4eAfGkp4XWzHxVXuy1HIyOApU=', '俞柏红', NULL, 20, 25, 8, 31, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '0:0:0:0:0:0:0:1', '2012-07-31 19:58:00'),
(32, '00076001', 'anI9MmTiyrzAeGYpjdEtqIbc4+5HsOweg6X7o1JNQjA=', '蔡晓喻', NULL, 20, 30, 9, 32, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.53.66', '2012-08-23 14:09:29'),
(33, '00056001', '5Rsppf8nmetp92hxvHFFEXJtj7V8d4z1CYA/bHSaXfM=', '章荷英', NULL, 20, 25, 7, 33, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.53.66', '2012-08-23 14:12:11'),
(34, '00046001', '3pnDrR8cXanV8I/+PMniD+bMPmu4AFZjmRF+SCA73yQ=', '冯毓', NULL, 20, 30, 6, 34, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.53.66', '2012-08-23 14:14:43'),
(35, '00036001', 'XmV3a5D8g46S/4qJugvbYAy4y1z6wF+b1tzU3C/37P4=', '陈蕾红', NULL, 20, 25, 5, 35, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL),
(36, '00006002', 'gfbTaJlUYHQ1K6VFo1nJ+W4jxm7NEPtO9Kl3H4xm070=', 'ljx', NULL, 24, 44, 1, 36, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '218.108.223.245', '2012-08-07 15:45:57'),
(37, '00003004', '8JxP5z5ukGlNHehkcTvpwUFoej2ycC+LHDt785I/Cos=', '林立', NULL, 17, 16, 1, 37, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '125.118.54.30', '2012-08-03 16:38:24'),
(38, '00002003', 'o6jZ7Lxg57/kkJH9OePxJ3cC1T/2LlIqSvl7nktA2a0=', 'leo', NULL, 16, 15, 1, 38, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '122.234.53.66', '2012-08-23 16:19:54');

-- --------------------------------------------------------

--
-- 表的结构 `app_user_role`
--

CREATE TABLE IF NOT EXISTS `app_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限表';

-- --------------------------------------------------------

--
-- 视图结构 `app_admin_attendance_view`
--
DROP TABLE IF EXISTS `app_admin_attendance_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `app_admin_attendance_view` AS select 'attendance' AS `origin`,`app_admin_attendance`.`attend_id` AS `attendance_view_id`,`app_admin_attendance`.`work_date` AS `work_date`,`app_admin_attendance`.`work_time` AS `work_time`,`app_admin_attendance`.`offtime_shour` AS `offtime_shour`,`app_admin_attendance`.`offtime_ehour` AS `offtime_ehour`,`app_admin_attendance`.`offtime_smin` AS `offtime_smin`,`app_admin_attendance`.`offtime_emin` AS `offtime_emin`,`app_admin_attendance`.`staff_id` AS `staff_id`,`app_admin_attendance`.`staff_name` AS `staff_name`,`app_admin_attendance`.`work_type` AS `work_type`,`app_admin_attendance`.`work_status` AS `work_status`,`app_admin_attendance`.`leave_type` AS `leave_type`,`app_admin_attendance`.`staff_behalf_name` AS `staff_behalf_name`,`app_admin_attendance`.`staff_behalf_id` AS `staff_behalf_id`,`app_admin_attendance`.`meto` AS `meto`,`app_admin_attendance`.`attendance_result` AS `attendance_result`,`app_admin_attendance`.`exception` AS `exception`,`app_admin_attendance`.`dep_id` AS `dep_id`,`app_admin_attendance`.`district_id` AS `district_id` from `app_admin_attendance` union select 'arrange' AS `origin`,`app_admin_workarrange`.`work_id` AS `attendance_view_id`,`app_admin_workarrange`.`work_date` AS `work_date`,concat(`app_system_work_time`.`work_stime`,'-',`app_system_work_time`.`work_etime`) AS `work_time`,NULL AS `offtime_shour`,NULL AS `offtime_ehour`,NULL AS `offtime_smin`,NULL AS `offtime_emin`,`app_admin_workarrange`.`staff_id` AS `staff_id`,`app_admin_workarrange`.`staff_name` AS `staff_name`,`app_admin_workarrange`.`work_type` AS `work_type`,'0' AS `work_status`,NULL AS `leave_type`,NULL AS `staff_behalf_name`,NULL AS `staff_behalf_id`,NULL AS `meto`,'1' AS `attendance_result`,'0' AS `exception`,`app_admin_workarrange`.`dep_id` AS `dep_id`,`app_admin_workarrange`.`district_id` AS `district_id` from (`app_admin_workarrange` join `app_system_work_time`) where (isnull(`app_admin_workarrange`.`attend_id`) and (`app_admin_workarrange`.`work_time` = `app_system_work_time`.`worktm_id`));

--
-- 限制导出的表
--

--
-- 限制表 `app_admin_doc`
--
ALTER TABLE `app_admin_doc`
  ADD CONSTRAINT `PK_author` FOREIGN KEY (`author_id`) REFERENCES `app_user` (`user_id`),
  ADD CONSTRAINT `PK_dcoType` FOREIGN KEY (`type_dicid`) REFERENCES `app_system_dictionary` (`id`),
  ADD CONSTRAINT `PK_department` FOREIGN KEY (`doc_postDepId`) REFERENCES `app_school_department` (`dep_id`),
  ADD CONSTRAINT `PK_district` FOREIGN KEY (`doc_postDistrictId`) REFERENCES `app_school_district` (`district_id`),
  ADD CONSTRAINT `PK_file` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`),
  ADD CONSTRAINT `PK_level` FOREIGN KEY (`doc_level_id`) REFERENCES `app_admin_doc_level` (`id`);

--
-- 限制表 `app_hrm_resume_file`
--
ALTER TABLE `app_hrm_resume_file`
  ADD CONSTRAINT `app_hrm_resume_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`);

--
-- 限制表 `app_process_definition`
--
ALTER TABLE `app_process_definition`
  ADD CONSTRAINT `app_process_definition_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_process_type` (`type_id`);

--
-- 限制表 `app_process_task`
--
ALTER TABLE `app_process_task`
  ADD CONSTRAINT `app_process_task_ibfk_1` FOREIGN KEY (`def_id`) REFERENCES `app_process_definition` (`def_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
