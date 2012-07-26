-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 07 月 26 日 15:09
-- 服务器版本: 5.0.51
-- PHP 版本: 5.2.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


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
  `attend_id` bigint(20) NOT NULL auto_increment COMMENT '考勤ID',
  `work_date` date NOT NULL COMMENT '工作日期',
  `work_time` varchar(64) NOT NULL COMMENT '工作时间',
  `offtime_shour` int(11) default NULL COMMENT '实际下班时间 - 打卡小时 (上)',
  `offtime_ehour` int(11) default NULL COMMENT '实际下班时间 - 打卡分钟 (上)',
  `offtime_smin` int(11) default NULL COMMENT '实际下班时间 - 打卡小时 (下)',
  `offtime_emin` int(11) default NULL COMMENT '实际下班时间 - 打卡分钟 (下)',
  `staff_id` bigint(20) NOT NULL COMMENT '员工ID',
  `staff_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `work_type` tinyint(4) NOT NULL COMMENT '上班类型, 0=正常上班, 1=带薪上班',
  `work_status` tinyint(4) NOT NULL COMMENT '上班状态， 0=在岗, 1=出差, 2=请假',
  `leave_type` tinyint(4) default NULL COMMENT '请假类型',
  `staff_behalf_name` varchar(64) default NULL COMMENT '代班员工姓名',
  `staff_behalf_id` bigint(20) default NULL COMMENT '代班员工ID',
  `meto` varchar(250) default NULL COMMENT '说明 (请假说明, 旷工说明)',
  `attendance_result` tinyint(4) default NULL COMMENT '考勤结果, 0=按时, 1=迟到, 2=早退, 3=旷工',
  PRIMARY KEY  (`attend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-员工考勤' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `app_admin_attendance`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_admin_conference`
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
  `conference_type` char(1) default NULL,
  `attendances_ids` varchar(200) default NULL COMMENT '参会人员ID',
  PRIMARY KEY  (`conference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会议表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `app_admin_conference`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_admin_doc`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-文档' AUTO_INCREMENT=20 ;

--
-- 转存表中的数据 `app_admin_doc`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_admin_doc_level`
--

CREATE TABLE IF NOT EXISTS `app_admin_doc_level` (
  `id` int(5) NOT NULL auto_increment COMMENT '编号',
  `level_name` varchar(100) default NULL COMMENT '文档级别名称',
  PRIMARY KEY  (`id`)
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
  `id` int(5) NOT NULL auto_increment,
  `visiable_name` varchar(100) default NULL COMMENT '文档范围名称',
  PRIMARY KEY  (`id`)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `app_admin_news`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_admin_news_file`
--

CREATE TABLE IF NOT EXISTS `app_admin_news_file` (
  `news_id` bigint(20) NOT NULL COMMENT '新闻ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`news_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-新闻文件关联表';

--
-- 转存表中的数据 `app_admin_news_file`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_admin_task`
--

CREATE TABLE IF NOT EXISTS `app_admin_task` (
  `task_id` bigint(20) NOT NULL auto_increment,
  `type_dicid` bigint(20) NOT NULL COMMENT '任务类型Id (来自系统字典)',
  `task_name` varchar(120) NOT NULL COMMENT '任务名称',
  `task_originator` bigint(20) NOT NULL COMMENT '任务发起人',
  `task_charger` bigint(20) NOT NULL COMMENT '任务负责人',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_admin_task`
--

INSERT INTO `app_admin_task` (`task_id`, `type_dicid`, `task_name`, `task_originator`, `task_charger`, `task_planStartDate`, `task_planEndDate`, `task_actualFinishDate`, `task_desc`, `task_participant_ids`, `task_participant_names`, `task_status`, `approval_status`, `create_time`) VALUES
(3, 8, 'task1', 6, 6, '2012-07-26', '2012-07-26', '2012-07-26', 'task1', NULL, NULL, 3, 2, '2012-07-26 14:57:32');

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_task_file`
--

CREATE TABLE IF NOT EXISTS `app_admin_task_file` (
  `task_id` bigint(20) NOT NULL COMMENT '任务ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`task_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托文件关联表';

--
-- 转存表中的数据 `app_admin_task_file`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_admin_task_participants`
--

CREATE TABLE IF NOT EXISTS `app_admin_task_participants` (
  `task_id` bigint(20) NOT NULL,
  `emp_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`task_id`,`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务参与人';

--
-- 转存表中的数据 `app_admin_task_participants`
--

INSERT INTO `app_admin_task_participants` (`task_id`, `emp_id`) VALUES
(3, 7),
(3, 14);

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_task_tracks`
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
  PRIMARY KEY  (`track_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='任务委托审批记录' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_admin_task_tracks`
--

INSERT INTO `app_admin_task_tracks` (`track_id`, `task_id`, `task_applyTime`, `task_applyType`, `task_applyFinalTime`, `task_applyMeto`, `task_auditState`, `task_auditFinalTime`, `task_auditMeto`, `task_auditTime`) VALUES
(3, 3, '2012-07-26', 1, '2012-07-27', '', 1, '2012-07-26', '', '2012-07-26 14:58:49');

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_workarrange`
--

CREATE TABLE IF NOT EXISTS `app_admin_workarrange` (
  `work_id` bigint(20) NOT NULL auto_increment COMMENT '工作ID',
  `work_date` date NOT NULL COMMENT '工作日期',
  `work_time` bigint(20) NOT NULL COMMENT '工作时间',
  `staff_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `staff_id` bigint(20) NOT NULL COMMENT '员工ID',
  `work_type` int(5) default NULL COMMENT '上班类型',
  `work_content` bigint(20) default NULL COMMENT '工作内容',
  `district_id` bigint(20) DEFAULT NULL COMMENT '员工所在校区',
  PRIMARY KEY  (`work_id`),
  KEY `PK_user` (`staff_id`),
  KEY `PK_type` (`work_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-工作安排' AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `app_admin_workarrange`
--

INSERT INTO `app_admin_workarrange` (`work_id`, `work_date`, `work_time`, `staff_name`, `staff_id`, `work_type`, `work_content`, `district_id`) VALUES
(3, '2012-07-26', 4, '罗家驹', 6, 1, 4, 1),
(4, '2012-07-30', 4, '罗家驹', 6, 1, 4, 1),
(5, '2012-07-30', 4, '李四', 8, 1, 4, 1),
(6, '2012-07-30', 4, '张三', 7, 1, 4, 1),
(7, '2012-07-30', 6, '张三', 7, 1, 4, 1),
(8, '2012-07-30', 6, '李四', 8, 1, 4, 1),
(9, '2012-07-31', 4, '张三', 7, 1, 4, 1),
(10, '2012-08-01', 4, '李四', 8, 1, 4, 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_admin_worktype`
--

CREATE TABLE IF NOT EXISTS `app_admin_worktype` (
  `id` int(5) NOT NULL auto_increment,
  `type` varchar(50) default NULL COMMENT '工作类型名称',
  PRIMARY KEY  (`id`)
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
  PRIMARY KEY  (`conference_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会议文件';

--
-- 转存表中的数据 `app_conference_file`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_file_attach`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='附件' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `app_file_attach`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_finan_contract`
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
  PRIMARY KEY  (`contract_id`),
  KEY `apply_form_no` (`apply_form_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='合同申请' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_finan_contract`
--

INSERT INTO `app_finan_contract` (`contract_id`, `apply_form_no`, `apply_form_type`, `emp_id`, `emp_district`, `emp_dep`, `emp_phone_no`, `apply_date`, `comments`, `apply_amt`, `contract_no`, `contract_parties`, `contract_parties_contact`, `pay_method`, `audit_state`, `entry_id`, `entry_datetime`) VALUES
(2, 'FC20120726144216', 8, 6, 1, 15, '12345678', '2012-07-26', '', 20000, '', '123', '123123123', '', NULL, 1, '2012-07-26 14:42:16');

-- --------------------------------------------------------

--
-- 表的结构 `app_finan_expense`
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
  PRIMARY KEY  (`expense_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_finan_expense`
--

INSERT INTO `app_finan_expense` (`expense_id`, `apply_form_no`, `apply_form_type`, `apply_date`, `comments`, `emp_id`, `emp_district`, `emp_dep`, `emp_phone_no`, `apply_amt`, `payer`, `contract_no`, `attach_count`, `audit_advance`, `asset_no`, `amt_receiver`, `amt_receiver_contact`, `pay_method`, `bank`, `account_name`, `account_no`, `status`, `audit_state`, `entry_id`, `entry_datetime`) VALUES
(1, 'FE20120726143709', 7, '2012-07-26', 'test', 6, 1, 15, '12345678', 123, NULL, '', '', NULL, '', '123', '1232331', NULL, '123', '3', '2', NULL, 2, 1, '2012-07-26 14:37:09'),
(2, 'FE20120726143834', 7, '2012-07-26', '', 6, 1, 15, '12345678', 2000000, NULL, '', '', NULL, '', '12', '132312312', NULL, '23', '23', '2', NULL, NULL, 1, '2012-07-26 14:38:34');

-- --------------------------------------------------------

--
-- 表的结构 `app_function`
--

CREATE TABLE IF NOT EXISTS `app_function` (
  `func_id` int(11) NOT NULL auto_increment,
  `func_key` varchar(60) NOT NULL COMMENT '功能key',
  `func_name` varchar(120) NOT NULL COMMENT '功能名称',
  `func_icon` varchar(32) default NULL COMMENT '功能显示图片',
  `func_desc` varchar(150) default NULL COMMENT '功能描述',
  `menu_id` bigint(20) NOT NULL COMMENT '所属菜单',
  PRIMARY KEY  (`func_id`),
  UNIQUE KEY `func_key` (`func_key`),
  KEY `menu_id` (`menu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_function`
--

INSERT INTO `app_function` (`func_id`, `func_key`, `func_name`, `func_icon`, `func_desc`, `menu_id`) VALUES
(1, '_FUNCKEY_myplan_edit', '编辑任务', 'icon-btnedit', '', 4),
(2, '_FUNCKEY_myplan_del', '删除任务', 'icon-btndel', '', 4),
(3, '_FUNCKEY_fina_apply', '费用支出申请', '', '', 7),
(4, '_FUNCKEY_fina_form_view', '费用申请查看', '', '', 7);

-- --------------------------------------------------------

--
-- 表的结构 `app_function_url`
--

CREATE TABLE IF NOT EXISTS `app_function_url` (
  `url_id` int(11) NOT NULL auto_increment,
  `func_id` int(11) NOT NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY  (`url_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能URL' AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `app_function_url`
--

INSERT INTO `app_function_url` (`url_id`, `func_id`, `url_path`) VALUES
(3, 1, 'aefew'),
(4, 2, 'sdewr'),
(5, 3, 'app/finan/financial.do?action=FinanExpenseDetail'),
(6, 4, 'app/finan/financial.do?action=FinanExpenseDetail&id=7&op=view');

-- --------------------------------------------------------

--
-- 表的结构 `app_global_type`
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
-- 转存表中的数据 `app_global_type`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_archive`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='公司人才库' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_hrm_archive`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_employee`
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
  `status` char(1) default NULL COMMENT '员工状态',
  `onboard_date` date default NULL COMMENT '到岗日期',
  `entry_id` bigint(20) default NULL COMMENT '录入人员',
  `entry_datetime` datetime default NULL COMMENT '录入日期',
  PRIMARY KEY  (`emp_id`),
  UNIQUE KEY `emp_no` (`emp_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工档案表' AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `app_hrm_employee`
--

INSERT INTO `app_hrm_employee` (`emp_id`, `emp_no`, `dep_id`, `district_id`, `emp_name`, `position_id`, `birthdate`, `phone_no`, `short_no`, `office_phone`, `urgency_contacts`, `positive_due_date`, `contract_end_date`, `onboard_status`, `teacher_star`, `consult_star`, `teach_class`, `teach_subject`, `resume_id`, `status`, `onboard_date`, `entry_id`, `entry_datetime`) VALUES
(6, '00001001', 15, 1, '罗家驹', 6, NULL, '12345678', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 20, NULL, '2012-07-01', 1, '2012-07-26 13:04:13'),
(7, '00002001', 16, 1, '张三', 7, NULL, '11223223', '', '', '', '2012-07-31', '2012-07-31', 2, 1, 1, '', '', 21, NULL, '2012-07-26', 1, '2012-07-26 13:05:37'),
(8, '00003001', 17, 1, '李四', 8, NULL, '12321123', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 22, NULL, '2012-07-26', 1, '2012-07-26 13:06:09'),
(9, '00011001', 18, 3, '王五', 9, NULL, '1222222', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 23, NULL, '2012-07-26', 1, '2012-07-26 13:06:30'),
(10, '00021001', 18, 4, '赵六', 9, NULL, '11111111', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 24, NULL, '2012-07-26', 1, '2012-07-26 13:07:15'),
(11, '00012001', 19, 3, '钱七', 10, NULL, '1234512', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 25, NULL, '2012-07-26', 1, '2012-07-26 13:07:55'),
(12, '00013001', 20, 3, '孙八', 11, NULL, '123212312', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 26, NULL, '2012-07-26', 1, '2012-07-26 13:11:12'),
(13, '00014001', 21, 3, '周九', 12, NULL, '12312132', '', '', '', NULL, NULL, 2, NULL, NULL, NULL, NULL, 27, NULL, '2012-07-26', 1, '2012-07-26 13:11:44'),
(14, '00002002', 16, 1, '教师1', 7, NULL, '28056121', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 29, NULL, '2012-07-26', 1, '2012-07-26 14:07:49');

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_employee_develop`
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
  PRIMARY KEY  (`develop_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='人资申请' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_hrm_employee_develop`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_employee_profile`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee_profile` (
  `profile_id` bigint(20) NOT NULL auto_increment,
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `status` tinyint(4) NOT NULL COMMENT '员工状态',
  PRIMARY KEY  (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工基本信息表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `app_hrm_employee_profile`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_employee_roadmap`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工历程' AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `app_hrm_employee_roadmap`
--

INSERT INTO `app_hrm_employee_roadmap` (`roadmap_id`, `emp_id`, `orginal_depid`, `orginal_districtid`, `orginal_positionid`, `dst_depid`, `dst_districtid`, `dst_positionid`, `type`, `date`) VALUES
(1, 3, 9, 3, 1, NULL, NULL, NULL, 1, '2012-06-12 16:10:11'),
(2, 4, 12, 3, 2, NULL, NULL, NULL, 1, '2012-06-12 16:32:22'),
(3, 5, 9, 3, 1, NULL, NULL, NULL, 1, '2012-06-12 16:48:39'),
(4, 5, 9, 3, 1, NULL, NULL, NULL, 2, '2012-06-12 16:48:52'),
(5, 6, 15, 1, 6, NULL, NULL, NULL, 1, '2012-07-01 00:00:00'),
(6, 7, 16, 1, 7, NULL, NULL, NULL, 1, '2012-07-26 00:00:00'),
(7, 8, 17, 1, 8, NULL, NULL, NULL, 1, '2012-07-26 00:00:00'),
(8, 9, 18, 3, 9, NULL, NULL, NULL, 1, '2012-07-26 00:00:00'),
(9, 10, 18, 4, 9, NULL, NULL, NULL, 1, '2012-07-26 00:00:00'),
(10, 11, 19, 3, 10, NULL, NULL, NULL, 1, '2012-07-26 00:00:00'),
(11, 12, 20, 3, 11, NULL, NULL, NULL, 1, '2012-07-26 00:00:00'),
(12, 13, 21, 3, 12, NULL, NULL, NULL, 1, '2012-07-26 00:00:00'),
(13, 14, 16, 1, 7, NULL, NULL, NULL, 1, '2012-07-26 14:07:49');

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_entries`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工入职安排表' AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `app_hrm_hire_entries`
--

INSERT INTO `app_hrm_hire_entries` (`entry_id`, `issue_id`, `district_id`, `dep_id`, `position_id`, `charger_id`, `plan_date`, `act_date`, `inspect_status`, `cstatus`, `fstatus`) VALUES
(9, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0),
(10, 21, 1, 16, 7, 1, '2012-07-26 00:00:00', '2012-07-26 00:00:00', 0, 2, 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_interviews`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='招聘面试' AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `app_hrm_hire_interviews`
--

INSERT INTO `app_hrm_hire_interviews` (`hw_id`, `hissue_id`, `interview_address`, `interview_date`, `interviewer_id`, `meto`, `session_sn`, `state`, `comments`) VALUES
(14, 20, '教室1', '2012-07-27 00:00:00', 6, '', 1, 2, '很好');

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_interviews_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_interviews_file` (
  `interview_id` bigint(20) NOT NULL COMMENT '面试ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`interview_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='面试附件';

--
-- 转存表中的数据 `app_hrm_hire_interviews_file`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_issue`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_issue` (
  `hissue_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `hjob_id` bigint(20) NOT NULL COMMENT '应聘职位ID',
  `current_status` tinyint(4) NOT NULL COMMENT '当前状态',
  `final_result` tinyint(4) default NULL COMMENT '最终处理结果',
  `user_id` bigint(20) default NULL COMMENT '应聘者ID, 主要用于存员工申请 (包含自我申请, 推荐他人)',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY  (`hissue_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='当前招聘' AUTO_INCREMENT=22 ;

--
-- 转存表中的数据 `app_hrm_hire_issue`
--

INSERT INTO `app_hrm_hire_issue` (`hissue_id`, `resume_id`, `hjob_id`, `current_status`, `final_result`, `user_id`, `apply_time`) VALUES
(20, 28, 4, 4, 1, 1, '2012-07-26 13:44:20'),
(21, 29, 5, 4, 1, 1, '2012-07-26 14:06:11');

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_job`
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
  PRIMARY KEY  (`hjob_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='招聘岗位发布' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_hrm_hire_job`
--

INSERT INTO `app_hrm_hire_job` (`hjob_id`, `job_title`, `hjob_districtid`, `hjob_depid`, `hjob_range`, `hjob_visible_districtid`, `end_date`, `hjob_count`, `hjob_condition`, `hjob_address`, `hjob_responsibility`, `hjob_salary`, `reg_fullname`, `reg_date`, `modify_fullname`, `modify_date`, `check_fullname`, `check_opinion`, `check_date`, `status`, `memo`, `isopen`) VALUES
(4, '校区总监', 3, 18, 1, NULL, '2012-07-26 00:00:00', 1, '', '', '', '', '管理员', '2012-07-26 13:43:27', NULL, NULL, NULL, NULL, NULL, 4, NULL, 1),
(5, '教师', 1, 16, 1, NULL, '2012-07-31 00:00:00', 10, '', '', '', '', '管理员', '2012-07-26 14:05:40', NULL, NULL, NULL, NULL, NULL, 4, NULL, 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire_job_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_job_file` (
  `hjob_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`hjob_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招聘岗位附件';

--
-- 转存表中的数据 `app_hrm_hire_job_file`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_resume`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='简历管理' AUTO_INCREMENT=30 ;

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
(28, NULL, '林立', NULL, NULL, '', 1, NULL, 1, NULL, '28056121', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2),
(29, 14, '教师1', NULL, NULL, '', 1, NULL, 1, NULL, '28056121', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_resume_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resume_file` (
  `file_id` bigint(20) NOT NULL,
  `resum_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`file_id`,`resum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历附件';

--
-- 转存表中的数据 `app_hrm_resume_file`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_menu`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统菜单' AUTO_INCREMENT=52 ;

--
-- 转存表中的数据 `app_menu`
--

INSERT INTO `app_menu` (`menu_id`, `menu_title`, `menu_icon`, `menu_url`, `menu_key`, `menu_desc`, `menu_parent`, `menu_order`) VALUES
(3, '我的工作区', 'icon-desktop', 'javascript:void(0);', '_menu_mod_personal', '', NULL, 0),
(4, '我的任务', 'icon-myplan', 'app/personal/task.do?action=pageTaskIndex', '_menu_mod_personal_mytask', '', 3, 0),
(5, '财务管理', 'icon-financial', 'javascript:void(0);', '_menu_mod_fina', '', NULL, 3),
(6, '费用支出管理', 'icon-finmrmb', 'javascript:void(0);', '_menu_mod_fina_exp_mgr', '', 5, 0),
(7, '费用支出申请', 'icon-finmrmbApply', 'app/finan/financial.do?action=FinanExpenseIndex', '_menu_mod_fina_exp_apply', '', 6, 0),
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
(44, '员工考勤', 'icon-adminduty', 'app/admin/attendance.do?action=adminPageStaffAttendance', '_menu_mod_admin_staff_attendance', '', 41, 1),
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
  `msg_id` bigint(20) NOT NULL auto_increment,
  `msg_subject` varchar(150) NOT NULL COMMENT '消息标题',
  `msg_content` text NOT NULL COMMENT '消息内容',
  `sender_id` bigint(20) NOT NULL COMMENT '发送者ID',
  `sender_name` varchar(120) NOT NULL COMMENT '发送者姓名',
  `msg_type` tinyint(4) default NULL COMMENT '消息类型',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  PRIMARY KEY  (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短消息' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `app_message_entity`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_message_in`
--

CREATE TABLE IF NOT EXISTS `app_message_in` (
  `receive_id` bigint(20) NOT NULL auto_increment,
  `msg_id` bigint(20) NOT NULL COMMENT '短消息ID',
  `user_id` bigint(20) NOT NULL COMMENT '接收用户ID',
  `user_name` varchar(64) NOT NULL COMMENT '接收用户姓名',
  `flag_read` tinyint(4) NOT NULL default '0' COMMENT '阅读标记, 1=已读, 0=未读',
  `flag_del` tinyint(4) NOT NULL default '0' COMMENT '删除标记, 1=已删, 0=未删',
  `receiv_time` datetime NOT NULL COMMENT '接收时间',
  PRIMARY KEY  (`receive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收件箱' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `app_message_in`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_process_definition`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程定义' AUTO_INCREMENT=19 ;

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
(18, 8, '合同费用 > 10000', '', NULL, 'x >10000', '2012-07-26 14:41:44');

-- --------------------------------------------------------

--
-- 表的结构 `app_process_form`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `app_process_form`
--

INSERT INTO `app_process_form` (`form_id`, `form_no`, `type_id`, `task_name`, `task_from`, `task_next`, `seq_sn`, `task_type`, `to_rolenames`, `to_distnames`, `to_depnames`, `to_posnames`, `to_usernames`, `audit_rolenames`, `audit_distnames`, `audit_depnames`, `audit_usernames`, `audit_posnames`, `to_userids`, `to_roleids`, `to_distids`, `to_depids`, `to_posids`, `audit_userids`, `audit_roleids`, `audit_distids`, `audit_depids`, `audit_posids`, `audit_date`, `audit_state`, `audit_comments`) VALUES
(4, 'FE20120726143834', 7, NULL, NULL, NULL, 1, 1, NULL, NULL, '总经办', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(5, 'FE20120726143834', 7, NULL, NULL, NULL, 2, 2, NULL, NULL, '总监室', '校长', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '18', '9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'FE20120726143834', 7, NULL, NULL, NULL, 3, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'FC20120726144216', 8, NULL, NULL, NULL, 1, 4, NULL, NULL, '总经办', '总经理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '15', '6', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_process_history`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_process_history`
--

INSERT INTO `app_process_history` (`history_id`, `form_no`, `type_id`, `task_name`, `task_from`, `task_next`, `task_type`, `seq_sn`, `to_rolenames`, `to_distnames`, `to_depnames`, `to_posnames`, `to_usernames`, `audit_rolenames`, `audit_distnames`, `audit_depnames`, `audit_usernames`, `audit_posnames`, `to_userids`, `to_roleids`, `to_distids`, `to_depids`, `to_posids`, `audit_userids`, `audit_roleids`, `audit_distids`, `audit_depids`, `audit_posids`, `audit_date`, `audit_state`, `audit_comments`) VALUES
(2, 'FE20120726143709', 7, NULL, NULL, NULL, 1, NULL, NULL, NULL, '总经办', NULL, NULL, NULL, NULL, NULL, '管理员', NULL, NULL, NULL, NULL, '15', NULL, '1', NULL, NULL, NULL, NULL, '2012-07-26 14:39:07', 2, '');

-- --------------------------------------------------------

--
-- 表的结构 `app_process_task`
--

CREATE TABLE IF NOT EXISTS `app_process_task` (
  `task_id` bigint(20) NOT NULL auto_increment,
  `def_id` bigint(20) NOT NULL COMMENT '所属流程定义ID',
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
  PRIMARY KEY  (`task_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程任务设置' AUTO_INCREMENT=38 ;

--
-- 转存表中的数据 `app_process_task`
--

INSERT INTO `app_process_task` (`task_id`, `def_id`, `task_name`, `task_from`, `task_next`, `seq_sn`, `to_rolenames`, `to_depnames`, `to_posnames`, `to_usernames`, `to_userids`, `to_roleids`, `to_depids`, `to_posids`, `comments`, `task_type`) VALUES
(13, 7, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(14, 6, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(15, 8, NULL, NULL, NULL, 1, NULL, '总监室,教务部,市场部,人资部', '市场部主管,人资部主管,校长,教务部主管', NULL, NULL, NULL, '19,18,20,21', '11,12,9,10', NULL, 1),
(16, 8, NULL, NULL, NULL, 2, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '9', NULL, 2),
(17, 8, NULL, NULL, NULL, 3, NULL, '总经办,教务部,人资部', '人资部主管,总经理,教务部主管', NULL, NULL, NULL, '15,17,16', '8,7,6', NULL, 3),
(18, 9, NULL, NULL, NULL, 1, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '9', NULL, 2),
(19, 9, NULL, NULL, NULL, 2, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(20, 11, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(21, 10, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(22, 12, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(23, 13, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(24, 14, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(25, 15, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(26, 16, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(27, 17, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(28, 3, NULL, NULL, NULL, 1, NULL, '总监室,教务部,市场部,人资部', '市场部主管,人资部主管,校长,教务部主管', NULL, NULL, NULL, '19,18,20,21', '11,12,9,10', NULL, 1),
(29, 3, NULL, NULL, NULL, 2, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '9', NULL, 2),
(30, 3, NULL, NULL, NULL, 3, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(31, 2, NULL, NULL, NULL, 1, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '9', NULL, 2),
(32, 1, NULL, NULL, NULL, 1, NULL, '总监室,教务部,市场部,人资部', '市场部主管,人资部主管,校长,教务部主管', NULL, NULL, NULL, '19,18,20,21', '11,12,9,10', NULL, 1),
(33, 5, NULL, NULL, NULL, 1, NULL, '总监室,教务部,市场部,人资部', '市场部主管,人资部主管,校长,教务部主管', NULL, NULL, NULL, '19,18,20,21', '11,12,9,10', NULL, 1),
(34, 5, NULL, NULL, NULL, 2, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '9', NULL, 2),
(35, 5, NULL, NULL, NULL, 3, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4),
(36, 4, NULL, NULL, NULL, 1, NULL, '总监室', '校长', NULL, NULL, NULL, '18', '9', NULL, 2),
(37, 18, NULL, NULL, NULL, 1, NULL, '总经办', '总经理', NULL, NULL, NULL, '15', '6', NULL, 4);

-- --------------------------------------------------------

--
-- 表的结构 `app_process_type`
--

CREATE TABLE IF NOT EXISTS `app_process_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '流程分类名',
  `type_key` varchar(64) default NULL COMMENT '流程分类KEY',
  `type_desc` varchar(250) default NULL COMMENT '流程分类描述',
  `type_slug` varchar(64) NOT NULL COMMENT '分类类别',
  `type_parent` bigint(20) default NULL COMMENT '流程父分类',
  PRIMARY KEY  (`type_id`)
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='角色表' AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `app_role`
--

INSERT INTO `app_role` (`role_id`, `role_name`, `role_key`, `role_desc`, `role_status`, `role_rights`, `role_type`, `role_edit`) VALUES
(1, '超级管理员', 'ROLE_SUPER', NULL, 1, '__ALL', 0, 0),
(5, '校长', 'ROLE_MASTER', 'teset', 1, '__ALL', 1, 1),
(6, '人资主管', 'ROLE_HR_MASTER', '', 1, '_FUNCKEY_myplan_edit,_FUNCKEY_myplan_del', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_role_func`
--

CREATE TABLE IF NOT EXISTS `app_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`func_id`),
  KEY `role_id` (`role_id`),
  KEY `app_role_func_ibfk_2` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

--
-- 转存表中的数据 `app_role_func`
--

INSERT INTO `app_role_func` (`role_id`, `func_id`) VALUES
(5, 1),
(5, 3),
(5, 4),
(6, 1),
(6, 2);

-- --------------------------------------------------------

--
-- 表的结构 `app_role_menu`
--

CREATE TABLE IF NOT EXISTS `app_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单';

--
-- 转存表中的数据 `app_role_menu`
--

INSERT INTO `app_role_menu` (`role_id`, `menu_id`) VALUES
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(5, 7),
(6, 3),
(6, 4),
(6, 8),
(6, 9),
(6, 25),
(6, 32),
(6, 33),
(6, 34),
(6, 35),
(6, 36),
(6, 37),
(6, 38),
(6, 45),
(6, 46),
(6, 47),
(6, 48),
(6, 49),
(6, 50),
(6, 51);

-- --------------------------------------------------------

--
-- 表的结构 `app_school_department`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='学校部门设置' AUTO_INCREMENT=22 ;

--
-- 转存表中的数据 `app_school_department`
--

INSERT INTO `app_school_department` (`dep_id`, `dep_no`, `dep_name`, `dep_desc`, `dep_eqlevel`, `dep_eqid`, `dep_orgtype`) VALUES
(15, '1', '总经办', '', 0, NULL, 0),
(16, '2', '教务部', '', 0, 15, 0),
(17, '3', '人资部', '', 0, 15, 0),
(18, '1', '总监室', '', 0, 15, 1),
(19, '2', '教务部', '', 0, 16, 1),
(20, '3', '人资部', '', 0, 17, 1),
(21, '4', '市场部', '', 0, NULL, 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_school_department_position`
--

CREATE TABLE IF NOT EXISTS `app_school_department_position` (
  `pos_id` bigint(20) NOT NULL auto_increment,
  `pos_name` varchar(150) NOT NULL COMMENT '岗位名称',
  `pos_desc` varchar(250) default NULL COMMENT '岗位描述',
  `pos_leadership` tinyint(4) default '1' COMMENT '是否领导, 0=是, 1=不是',
  `dep_id` bigint(20) NOT NULL COMMENT '部门ID',
  `pos_roleRights` varchar(500) default NULL COMMENT '岗位角色权限',
  PRIMARY KEY  (`pos_id`),
  KEY `dep_id` (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='部门岗位' AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `app_school_department_position`
--

INSERT INTO `app_school_department_position` (`pos_id`, `pos_name`, `pos_desc`, `pos_leadership`, `dep_id`, `pos_roleRights`) VALUES
(6, '总经理', '', 0, 15, 'ROLE_SUPER'),
(7, '教务部主管', '', 0, 16, 'ROLE_SUPER'),
(8, '人资部主管', '', 0, 17, 'ROLE_SUPER'),
(9, '校长', '', 0, 18, 'ROLE_MASTER'),
(10, '教务部主管', '', 0, 19, 'ROLE_MASTER'),
(11, '人资部主管', '', 0, 20, 'ROLE_MASTER'),
(12, '市场部主管', '', 0, 21, 'ROLE_MASTER');

-- --------------------------------------------------------

--
-- 表的结构 `app_school_department_position_role`
--

CREATE TABLE IF NOT EXISTS `app_school_department_position_role` (
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY  (`pos_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位权限';

--
-- 转存表中的数据 `app_school_department_position_role`
--

INSERT INTO `app_school_department_position_role` (`pos_id`, `role_id`) VALUES
(6, 1),
(7, 1),
(8, 1),
(9, 5),
(10, 5),
(11, 5),
(12, 5);

-- --------------------------------------------------------

--
-- 表的结构 `app_school_district`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='校区设置' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_school_district`
--

INSERT INTO `app_school_district` (`district_id`, `district_no`, `district_name`, `district_type`, `district_address`, `district_phone`, `district_parent`) VALUES
(1, '0000', '杭州总部', 0, '', '', NULL),
(3, '0001', '萧山校区', 1, '', '', 1),
(4, '0002', '德清校区', 1, '德清', '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_school_posets`
--

CREATE TABLE IF NOT EXISTS `app_school_posets` (
  `poset_id` bigint(20) NOT NULL auto_increment COMMENT '职位岗位ID',
  `poset_name` varchar(64) NOT NULL COMMENT '职位岗位名称',
  PRIMARY KEY  (`poset_id`),
  UNIQUE KEY `poset_name` (`poset_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='职位岗位' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_school_posets`
--

INSERT INTO `app_school_posets` (`poset_id`, `poset_name`) VALUES
(1, '总经理'),
(2, '总部主管'),
(4, '校区主管'),
(3, '校区校长');

-- --------------------------------------------------------

--
-- 表的结构 `app_school_posets_terms`
--

CREATE TABLE IF NOT EXISTS `app_school_posets_terms` (
  `poset_id` bigint(20) NOT NULL COMMENT '职位岗位ID',
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY  (`poset_id`,`pos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职位与岗位关系表';

--
-- 转存表中的数据 `app_school_posets_terms`
--

INSERT INTO `app_school_posets_terms` (`poset_id`, `pos_id`) VALUES
(1, 6),
(2, 7),
(2, 8),
(3, 9),
(4, 10),
(4, 11),
(4, 12);

-- --------------------------------------------------------

--
-- 表的结构 `app_system_config`
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
-- 转存表中的数据 `app_system_config`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_system_dictionary`
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
  `log_id` bigint(20) NOT NULL auto_increment,
  `user_name` varchar(120) NOT NULL COMMENT '用户名',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  `detail` text COMMENT '操作详细说明',
  `ip` varchar(128) default NULL COMMENT '登录IP',
  `cost` bigint(20) default NULL COMMENT '操作耗时',
  PRIMARY KEY  (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统日志' AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `app_system_log`
--

INSERT INTO `app_system_log` (`log_id`, `user_name`, `user_id`, `createtime`, `operation`, `detail`, `ip`, `cost`) VALUES
(1, '管理员', 1, '2012-07-26 11:50:42', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 240),
(2, '罗家驹', 6, '2012-07-26 13:49:38', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 153),
(3, '管理员', 1, '2012-07-26 13:50:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 37),
(4, '教师1', 14, '2012-07-26 14:08:16', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 69),
(5, '管理员', 1, '2012-07-26 14:08:47', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 40),
(6, '教师1', 14, '2012-07-26 14:09:41', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 78),
(7, '管理员', 1, '2012-07-26 14:10:13', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 60),
(8, '管理员', 1, '2012-07-26 14:56:08', '登录', '用户通过身份验证进入系统', '0:0:0:0:0:0:0:1', 79);

-- --------------------------------------------------------

--
-- 表的结构 `app_system_work_content`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='工作模板设置' AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `app_system_work_template`
--

INSERT INTO `app_system_work_template` (`work_tpl_id`, `work_day`, `worktm_id`, `district_id`, `staff_id`, `staff_name`, `enable`, `template_id`, `workcnt_id`) VALUES
(1, '周一', 4, 1, 6, '罗家驹', '1', 1, 4),
(2, '周一', 4, 1, 8, '李四', '1', 1, 4),
(3, '周一', 4, 1, 7, '张三', '1', 1, 4),
(4, '周一', 6, 1, 7, '张三', '1', 1, 4),
(5, '周一', 6, 1, 8, '李四', '1', 1, 4),
(6, '周二', 4, 1, 7, '张三', '1', 1, 4),
(7, '周三', 4, 1, 8, '李四', '1', 1, 4),
(8, '周一', 8, 3, 9, '王五', '1', 1, 4),
(9, '周二', 8, 3, 11, '钱七', '1', 1, 4),
(10, '周三', 8, 3, 12, '孙八', '1', 1, 4),
(11, '周四', 8, 3, 13, '周九', '1', 1, 4);

-- --------------------------------------------------------

--
-- 表的结构 `app_system_work_time`
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
  `logon_lastip` varchar(64) default NULL COMMENT '最后登录IP',
  `logon_lastime` datetime default NULL COMMENT '最后登录时间',
  PRIMARY KEY  (`user_id`),
  KEY `FK_AU_R_DPT` (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表' AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `app_user`
--

INSERT INTO `app_user` (`user_id`, `username`, `password`, `fullname`, `email`, `dep_id`, `pos_id`, `district_id`, `emp_id`, `phone`, `mobile`, `fax`, `address`, `zip`, `photo`, `status`, `logon_lastip`, `logon_lastime`) VALUES
(1, 'admin', 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=', '管理员', 'csx@jee-soft.cn', NULL, NULL, 1, 6, NULL, NULL, NULL, NULL, NULL, NULL, 1, '0:0:0:0:0:0:0:1', '2012-07-26 14:56:08'),
(6, '00001001', 'ro+N+ETeTFw+SYrc4TnIzXuXWwO93mUJgr0ArrsNPfk=', '罗家驹', NULL, 15, 6, 1, 6, NULL, NULL, NULL, NULL, NULL, NULL, 1, '0:0:0:0:0:0:0:1', '2012-07-26 13:49:37'),
(7, '00002001', '/4xWL9bhPAve03Tu5HeR7T0U6Qsmy6eYjLtZM4aAcFs=', '张三', NULL, 16, 7, 1, 7, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL),
(8, '00003001', 'mxA4ujFL57JAzeke5W87Cujn+35uwD+aKrCuNK4f+6A=', '李四', NULL, 17, 8, 1, 8, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL),
(9, '00011001', '2tMyVUWepJF+o1Kpalod/ZUmdIdc9/xxn7gXiF7+04s=', '王五', NULL, 18, 9, 3, 9, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL),
(10, '00021001', 'CS9RA+lJbBoi5YLkAflKej6BIJ+a4hyCqdHj/Nxrtgo=', '赵六', NULL, 18, 9, 4, 10, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL),
(11, '00012001', 'Rtpi2nASXrbWpy+VYEXnKk+GOId4gKDOBDSVbxCXE6Q=', '钱七', NULL, 19, 10, 3, 11, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL),
(12, '00013001', 'UTjsp+zTkqLY9j2s69wKMq/uOaDLKqxuer5KlRd6Vsg=', '孙八', NULL, 20, 11, 3, 12, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL),
(13, '00014001', 'OUr8Kdc/PqTomMcE3GMTQdLnNH6u5TwEGWa3vRekjd0=', '周九', NULL, 21, 12, 3, 13, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL),
(14, '00002002', 'VH4xR+A+M04zzSSzxg3T2osRhsB1+1gJYxVjJ38uk4E=', '教师1', NULL, 16, 7, 1, 14, NULL, NULL, NULL, NULL, NULL, NULL, 1, '0:0:0:0:0:0:0:1', '2012-07-26 14:09:41');

-- --------------------------------------------------------

--
-- 表的结构 `app_user_role`
--

CREATE TABLE IF NOT EXISTS `app_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限表';

--
-- 转存表中的数据 `app_user_role`
--


--
-- 限制导出的表
--

--
-- 限制表 `app_admin_doc`
--
ALTER TABLE `app_admin_doc`
  ADD CONSTRAINT `PK_file` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`),
  ADD CONSTRAINT `PK_author` FOREIGN KEY (`author_id`) REFERENCES `app_user` (`user_id`),
  ADD CONSTRAINT `PK_dcoType` FOREIGN KEY (`type_dicid`) REFERENCES `app_system_dictionary` (`id`),
  ADD CONSTRAINT `PK_department` FOREIGN KEY (`doc_postDepId`) REFERENCES `app_school_department` (`dep_id`),
  ADD CONSTRAINT `PK_district` FOREIGN KEY (`doc_postDistrictId`) REFERENCES `app_school_district` (`district_id`),
  ADD CONSTRAINT `PK_level` FOREIGN KEY (`doc_level_id`) REFERENCES `app_admin_doc_level` (`id`),
  ADD CONSTRAINT `PK_range` FOREIGN KEY (`doc_VisiableRange_id`) REFERENCES `app_admin_doc_visiable_range` (`id`);

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
-- 限制表 `app_role_func`
--
ALTER TABLE `app_role_func`
  ADD CONSTRAINT `app_role_func_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`),
  ADD CONSTRAINT `app_role_func_ibfk_2` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`);
