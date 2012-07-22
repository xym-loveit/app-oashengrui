-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 07 月 21 日 00:44
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

INSERT INTO `app_admin_doc` (`doc_id`, `type_dicid`, `doc_name`, `doc_level_id`, `doc_VisiableRange_id`, `doc_userNames`, `doc_userIds`, `doc_postDistrictId`, `doc_postDepId`, `author_id`, `create_time`, `file_id`) VALUES
(19, 1, 'sssss', 1, 1, '', NULL, 1, 7, 1, '2012-07-19 23:40:40', 1);

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
  `district_visible` bigint(20) NOT NULL COMMENT '可见校区',
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
  `task_desc` text NOT NULL COMMENT '任务描述',
  `task_participant_ids` varchar(120) default NULL COMMENT '任务参与人ID列表',
  `task_participant_names` varchar(250) default NULL COMMENT '任务参与人名称列表',
  `task_status` tinyint(4) NOT NULL COMMENT '任务状态',
  `approval_status` tinyint(4) default NULL COMMENT '审批状态',
  PRIMARY KEY  (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政管理-任务委托' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `app_admin_task`
--


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
  PRIMARY KEY  (`work_id`),
  KEY `PK_user` (`staff_id`),
  KEY `PK_type` (`work_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='行政管理-工作安排' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_admin_workarrange`
--

INSERT INTO `app_admin_workarrange` (`work_id`, `work_date`, `work_time`, `staff_name`, `staff_id`, `work_type`, `work_content`) VALUES
(1, '2012-07-12', 3, '斩不刀', 2, 1, 3),
(2, '2012-06-13', 4, '唐伯虎', 1, 3, 4);

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

INSERT INTO `app_file_attach` (`file_id`, `file_name`, `file_path`, `createtime`, `file_ext`, `file_type`, `note`, `creator`, `creator_id`, `file_bytes`, `del_flag`) VALUES
(1, '使用说明.txt', 'others\\201207\\606b9c4fbcb64f0591b1a8cb563647dd.txt', '2012-07-19 23:40:38', 'txt', 'others', '1.87 KB', 'Unknow', NULL, 1918, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='合同申请' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `app_finan_contract`
--

INSERT INTO `app_finan_contract` (`contract_id`, `apply_form_no`, `apply_form_type`, `emp_id`, `emp_district`, `emp_dep`, `emp_phone_no`, `apply_date`, `comments`, `apply_amt`, `contract_no`, `contract_parties`, `contract_parties_contact`, `pay_method`, `audit_state`, `entry_id`, `entry_datetime`) VALUES
(1, 'FC20120715211609', 8, 4, 3, 12, '13588064354', '2012-07-15', '', 2450.5, '2351d11311', '41232', '13588064354', 'test', NULL, 1, '2012-07-15 21:16:09');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `app_finan_expense`
--


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

INSERT INTO `app_hrm_archive` (`archive_id`, `resume_id`, `job_id`, `archive_source`, `archive_star`) VALUES
(1, 7, 2, 2, 3),
(2, 8, 2, 5, 2),
(3, 9, 2, 2, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工档案表' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_hrm_employee`
--

INSERT INTO `app_hrm_employee` (`emp_id`, `emp_no`, `dep_id`, `district_id`, `emp_name`, `position_id`, `birthdate`, `phone_no`, `short_no`, `positive_due_date`, `contract_end_date`, `onboard_status`, `teacher_star`, `consult_star`, `teach_class`, `teach_subject`, `resume_id`, `status`, `onboard_date`, `entry_id`, `entry_datetime`) VALUES
(3, '0001012061241011', 9, 3, 'Manie', 1, NULL, '13588064354', NULL, NULL, NULL, 1, 3, 4, 'A,A1,A3,A5,B1,B3', 'A,A1,A3,B,B2,B6,C7,C8', 16, NULL, NULL, 1, '2012-06-12 16:10:11'),
(4, '0001112061243222', 12, 3, 'Charotte', 2, NULL, '13588064354', NULL, NULL, NULL, 1, 1, 1, '', 'A2,B2', 18, NULL, NULL, 1, '2012-06-12 16:32:22'),
(5, '0001012061244839', 9, 3, 'Chonticha', 1, NULL, '13588064354', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, 19, NULL, NULL, 1, '2012-06-12 16:48:39');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工历程' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_hrm_employee_roadmap`
--

INSERT INTO `app_hrm_employee_roadmap` (`roadmap_id`, `emp_id`, `orginal_depid`, `orginal_districtid`, `orginal_positionid`, `dst_depid`, `dst_districtid`, `dst_positionid`, `type`, `date`) VALUES
(1, 3, 9, 3, 1, NULL, NULL, NULL, 1, '2012-06-12 16:10:11'),
(2, 4, 12, 3, 2, NULL, NULL, NULL, 1, '2012-06-12 16:32:22'),
(3, 5, 9, 3, 1, NULL, NULL, NULL, 1, '2012-06-12 16:48:39'),
(4, 5, 9, 3, 1, NULL, NULL, NULL, 2, '2012-06-12 16:48:52');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='员工入职安排表' AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `app_hrm_hire_entries`
--

INSERT INTO `app_hrm_hire_entries` (`entry_id`, `issue_id`, `district_id`, `dep_id`, `position_id`, `charger_id`, `plan_date`, `act_date`, `inspect_status`, `cstatus`, `fstatus`) VALUES
(1, 8, 3, 9, 1, 2, '2012-06-10 10:00:00', '2012-06-13 05:35:29', 2, 2, 2),
(5, 16, 3, 9, 1, 1, '2012-06-15 00:00:00', '2012-06-12 16:10:02', 0, 2, 1),
(6, 17, 3, 9, 1, 1, '2012-06-15 15:12:51', '2012-06-14 16:05:51', 0, 2, 1),
(7, 18, 3, 12, 2, 1, '2012-06-15 16:31:47', '2012-06-12 16:32:07', 1, 2, 1),
(8, 19, 3, 9, 1, 1, '2012-06-13 00:00:00', '2012-06-15 00:00:00', 1, 2, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='招聘面试' AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `app_hrm_hire_interviews`
--

INSERT INTO `app_hrm_hire_interviews` (`hw_id`, `hissue_id`, `interview_address`, `interview_date`, `interviewer_id`, `meto`, `session_sn`, `state`, `comments`) VALUES
(5, 6, '杭州总部', '2012-06-13 14:34:56', 1, '', 1, 2, '建议通过...'),
(6, 7, '杭州总部', '2012-06-20 15:34:57', 2, '', 1, 3, NULL),
(7, 8, '杭州总部', '2012-06-13 14:34:56', 2, '', 1, 0, NULL),
(8, 9, '杭州总部', '2012-06-15 23:32:04', 1, '', 1, 3, '不合适...'),
(9, 9, '杭州总部', '2012-06-21 23:35:07', 1, '', 2, 4, '这人坚决不要, 信用度太低啊..'),
(10, 9, '杭州总部', '2012-06-13 00:00:00', 1, '', 3, 3, '烦不烦啊... '),
(11, 10, '杭州电子科技大学', '2012-06-28 23:42:19', 1, '', 1, 2, ''),
(12, 10, '杭州电子科技大学', '2012-06-07 00:00:00', 1, '', 2, 3, ''),
(13, 11, '萧山校区', '2012-06-15 15:00:00', 1, '', 1, 2, '表现很优异啊, 建议直接录取...');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='当前招聘' AUTO_INCREMENT=20 ;

--
-- 转存表中的数据 `app_hrm_hire_issue`
--

INSERT INTO `app_hrm_hire_issue` (`hissue_id`, `resume_id`, `hjob_id`, `current_status`, `final_result`, `user_id`, `apply_time`) VALUES
(6, 6, 2, 3, NULL, NULL, '2012-06-10 14:34:39'),
(7, 7, 2, 4, 2, NULL, '2012-06-10 15:34:45'),
(8, 8, 2, 4, 1, NULL, '2012-06-10 22:51:23'),
(9, 9, 2, 4, 2, NULL, '2012-06-11 23:31:55'),
(10, 10, 2, 0, NULL, NULL, '2012-06-11 23:42:01'),
(11, 11, 2, 4, 1, NULL, '2012-06-12 13:45:20'),
(12, 12, 2, 4, 1, 1, '2012-06-12 13:50:57'),
(13, 13, 2, 4, 1, 1, '2012-06-12 14:13:17'),
(14, 14, 2, 4, 1, 1, '2012-06-12 14:15:06'),
(15, 15, 2, 4, 1, 1, '2012-06-12 14:16:21'),
(16, 16, 2, 4, 1, 1, '2012-06-12 14:19:51'),
(17, 17, 2, 4, 1, 1, '2012-06-12 14:36:15'),
(18, 18, 2, 4, 1, 1, '2012-06-12 16:31:21'),
(19, 19, 2, 4, 1, 1, '2012-06-12 16:48:04');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='招聘岗位发布' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_hrm_hire_job`
--

INSERT INTO `app_hrm_hire_job` (`hjob_id`, `job_title`, `hjob_districtid`, `hjob_depid`, `hjob_range`, `hjob_visible_districtid`, `end_date`, `hjob_count`, `hjob_condition`, `hjob_address`, `hjob_responsibility`, `hjob_salary`, `reg_fullname`, `reg_date`, `modify_fullname`, `modify_date`, `check_fullname`, `check_opinion`, `check_date`, `status`, `memo`, `isopen`) VALUES
(1, '技术总监', 3, 1, 2, NULL, '2012-06-18 00:00:00', 1, '', '杭州', 'test', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(2, '产品经理', 1, 7, 1, NULL, '2012-06-19 00:00:00', 5, '', '杭州电子科技大学', '', '', NULL, NULL, NULL, NULL, '卡卡西', NULL, '2012-06-09 12:34:23', 1, NULL, 1),
(3, 'test', 3, 12, 1, NULL, '2012-06-15 00:00:00', 21, '', '', '', '', '卡卡西', '2012-06-13 16:39:34', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='简历管理' AUTO_INCREMENT=20 ;

--
-- 转存表中的数据 `app_hrm_resume`
--

INSERT INTO `app_hrm_resume` (`resume_id`, `emp_id`, `fullname`, `age`, `birthday`, `address`, `marriage`, `zip`, `sex`, `phone`, `mobile`, `email`, `hobby`, `religion`, `party`, `nationality`, `race`, `birthPlace`, `eduCollege`, `eduDegree`, `eduMajor`, `teacher_major`, `teacher_cert`, `startWorkDate`, `idNo`, `photo`, `status`, `memo`, `registor`, `regTime`, `workCase`, `trainCase`, `projectCase`, `en_level`, `cn_level`, `source`) VALUES
(6, NULL, '佐助', NULL, NULL, '火影村', 1, NULL, 1, NULL, '13588064354', '火影@163.com', NULL, NULL, 1, NULL, NULL, '非人类', '', 1, '', 1, 1, NULL, '362412312412', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(7, NULL, '大和', NULL, NULL, '', 1, NULL, 1, NULL, '13512456013', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(8, NULL, '鸣人', NULL, NULL, '', 1, NULL, 1, NULL, '13512456013', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(9, NULL, '大和2', NULL, NULL, '', 1, NULL, 1, NULL, '13512456013', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(10, NULL, '品冠', NULL, NULL, '', 1, NULL, 1, NULL, '13845671203', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(11, NULL, 'Vincent', NULL, NULL, '', 2, NULL, 1, NULL, '13512456013', '', NULL, NULL, 2, NULL, NULL, '', '', 2, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 6, 2),
(12, NULL, 'Jeth', NULL, NULL, '', 1, NULL, 1, NULL, '0608943125232', '', NULL, NULL, 1, NULL, NULL, '菲律宾', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2),
(13, NULL, 'Gino.P', NULL, NULL, '', 1, NULL, 1, NULL, '0608943125232', '', NULL, NULL, 1, NULL, NULL, '菲律宾', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(14, NULL, 'Gino.M', NULL, NULL, '', 1, NULL, 1, NULL, '0608943125232', '', NULL, NULL, 1, NULL, NULL, '菲律宾', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2),
(15, NULL, 'Xavier', NULL, NULL, '', 1, NULL, 1, NULL, '0608943125232', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(16, NULL, 'Manie', NULL, NULL, '', 1, NULL, 1, NULL, '13588064354', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(17, NULL, 'Gian', NULL, NULL, '', 1, NULL, 1, NULL, '13588064354', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(18, 4, 'Charotte', NULL, NULL, '', 1, NULL, 1, NULL, '13588064354', '', NULL, NULL, 1, NULL, NULL, '', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(19, 5, 'Chonticha', NULL, NULL, '', 1, NULL, 1, NULL, '13588064354', '', NULL, NULL, 1, NULL, NULL, '泰国', '', 1, '', 1, 1, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0);

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
  `menu_title` varchar(50) NOT NULL COMMENT '菜单名称',
  `menu_icon` varchar(20) default NULL COMMENT '菜单图标',
  `menu_url` varchar(100) NOT NULL COMMENT '菜单链接',
  `menu_key` varchar(64) NOT NULL COMMENT '菜单key',
  `menu_desc` varchar(100) default NULL COMMENT '菜单描述',
  `menu_parent` int(11) default NULL COMMENT '父菜单',
  `menu_order` int(11) default NULL COMMENT '菜单项顺序',
  PRIMARY KEY  (`menu_id`),
  UNIQUE KEY `menu_key` (`menu_key`),
  KEY `menu_parent` (`menu_parent`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统菜单' AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `app_menu`
--

INSERT INTO `app_menu` (`menu_id`, `menu_title`, `menu_icon`, `menu_url`, `menu_key`, `menu_desc`, `menu_parent`, `menu_order`) VALUES
(3, '我的工作区', 'icon-desktop', 'javascript:void(0);', '_menu_mod_personal', '', NULL, 0),
(4, '我的任务', 'icon-myplan', 'javascript:void(0);', '_menu_mod_personal_mytask', 'test0', 3, 0),
(5, '财务管理', 'icon-financial', 'javascript:void(0);', '_menu_mod_fina', '', NULL, 0),
(6, '费用支出管理', 'icon-finmrmb', 'javascript:void(0);', '_menu_mod_fina_exp_mgr', '', 5, 0),
(7, '费用支出申请', 'icon-finmrmbApply', 'app/finan/financial.do?action=FinanExpenseIndex', '_menu_mod_fina_exp_apply', '', 6, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程定义' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_process_definition`
--

INSERT INTO `app_process_definition` (`def_id`, `type_id`, `def_name`, `def_description`, `filter_poset`, `def_trigger`, `createtime`) VALUES
(1, 7, '0 < 支出费用 <= 1000', '', 0, 'x > 0 && x <= 1000', '2012-06-29 14:50:40'),
(2, 7, '1000 < 支出费用 <= 10000', '', 0, 'x > 1000 && x <= 10000', '2012-06-29 14:51:15'),
(3, 7, '支出费用 >10000', '', 0, 'x > 10000', '2012-06-29 15:00:28'),
(4, 8, '0 < 合同费用 <= 1000', '', 0, 'x > 0 && x <= 1000', '2012-07-15 14:30:52'),
(5, 8, '1000 < 合同费用 <= 10000', '', 0, 'x > 1000 && x <= 10000', '2012-07-15 21:01:38');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_process_form`
--

INSERT INTO `app_process_form` (`form_id`, `form_no`, `type_id`, `task_name`, `task_from`, `task_next`, `seq_sn`, `task_type`, `to_rolenames`, `to_distnames`, `to_depnames`, `to_posnames`, `to_usernames`, `audit_rolenames`, `audit_distnames`, `audit_depnames`, `audit_usernames`, `audit_posnames`, `to_userids`, `to_roleids`, `to_distids`, `to_depids`, `to_posids`, `audit_userids`, `audit_roleids`, `audit_distids`, `audit_depids`, `audit_posids`, `audit_date`, `audit_state`, `audit_comments`) VALUES
(1, 'FC20120715211609', 8, NULL, NULL, NULL, 1, 2, NULL, NULL, '人资部', '人事主管', NULL, NULL, NULL, NULL, '???', NULL, NULL, NULL, NULL, '9', '1', '1', NULL, NULL, NULL, NULL, '2012-07-15 21:16:48', 2, '同意...'),
(2, 'FC20120715211609', 8, NULL, NULL, NULL, 2, 1, NULL, NULL, '行政部', '行政主管', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '12', '2', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `app_process_history`
--

INSERT INTO `app_process_history` (`history_id`, `form_no`, `type_id`, `task_name`, `task_from`, `task_next`, `task_type`, `seq_sn`, `to_rolenames`, `to_distnames`, `to_depnames`, `to_posnames`, `to_usernames`, `audit_rolenames`, `audit_distnames`, `audit_depnames`, `audit_usernames`, `audit_posnames`, `to_userids`, `to_roleids`, `to_distids`, `to_depids`, `to_posids`, `audit_userids`, `audit_roleids`, `audit_distids`, `audit_depids`, `audit_posids`, `audit_date`, `audit_state`, `audit_comments`) VALUES
(1, 'FC20120715211609', 8, NULL, NULL, NULL, 2, NULL, NULL, NULL, '人资部', '人事主管', NULL, NULL, NULL, NULL, '???', NULL, NULL, NULL, NULL, '9', '1', '1', NULL, NULL, NULL, NULL, '2012-07-15 21:16:48', 2, '同意...');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程任务设置' AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `app_process_task`
--

INSERT INTO `app_process_task` (`task_id`, `def_id`, `task_name`, `task_from`, `task_next`, `seq_sn`, `to_rolenames`, `to_depnames`, `to_posnames`, `to_usernames`, `to_userids`, `to_roleids`, `to_depids`, `to_posids`, `comments`, `task_type`) VALUES
(1, 1, NULL, NULL, NULL, 1, NULL, '市场部,行政部,总经办,人资部', '部门主管,部门主管,行政主管,人事主管', NULL, NULL, NULL, '13,12,9,14', '1,4,3,2', NULL, 1),
(2, 1, NULL, NULL, NULL, 2, NULL, '人资部', '人事主管', NULL, NULL, NULL, '9', '1', NULL, 2),
(3, 1, NULL, NULL, NULL, 3, NULL, '人资部', '部门主管', NULL, NULL, NULL, '7', '5', NULL, 4),
(4, 1, NULL, NULL, NULL, 4, NULL, '行政部', '行政主管', NULL, NULL, NULL, '12', '2', NULL, 2),
(5, 2, NULL, NULL, NULL, 1, NULL, '行政部', '行政主管', NULL, NULL, NULL, '12', '2', NULL, 2),
(6, 1, NULL, NULL, NULL, 5, NULL, '总经办', '部门主管', NULL, NULL, NULL, '13', '3', NULL, 2),
(7, 1, NULL, NULL, NULL, 6, NULL, '人资部', '部门主管', NULL, NULL, NULL, '7', '5', NULL, 4),
(8, 4, NULL, NULL, NULL, 1, NULL, '行政部', '行政主管', NULL, NULL, NULL, '12', '2', NULL, 2),
(9, 4, NULL, NULL, NULL, 2, NULL, '市场部,行政部,总经办,人资部', '部门主管,部门主管,行政主管,人事主管', NULL, NULL, NULL, '13,12,9,14', '1,4,3,2', NULL, 1),
(10, 4, NULL, NULL, NULL, 3, NULL, '人资部', '部门主管', NULL, NULL, NULL, '7', '5', NULL, 4),
(11, 5, NULL, NULL, NULL, 1, NULL, '人资部', '人事主管', NULL, NULL, NULL, '9', '1', NULL, 2),
(12, 5, NULL, NULL, NULL, 2, NULL, '市场部,行政部,总经办,人资部', '部门主管,部门主管,行政主管,人事主管', NULL, NULL, NULL, '13,12,9,14', '1,4,3,2', NULL, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='角色表' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_role`
--

INSERT INTO `app_role` (`role_id`, `role_name`, `role_key`, `role_desc`, `role_status`, `role_rights`, `role_type`, `role_edit`) VALUES
(1, '超级管理员', 'ROLE_SUPER', NULL, 1, '__ALL', 0, 0),
(5, '校长', 'ROLE_MASTER', 'teset', 1, '_FUNCKEY_myplan_edit,_FUNCKEY_fina_apply,_FUNCKEY_fina_form_view', 1, 1);

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
(5, 4);

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
(5, 7);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='学校部门设置' AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `app_school_department`
--

INSERT INTO `app_school_department` (`dep_id`, `dep_no`, `dep_name`, `dep_desc`, `dep_eqlevel`, `dep_eqid`, `dep_orgtype`) VALUES
(7, '0', '人资部', '', 0, NULL, 0),
(9, '0', '人资部', '', 0, NULL, 1),
(10, '1', '总经办', '', 0, NULL, 0),
(11, '1', '行政部', '', 0, NULL, 0),
(12, '1', '行政部', '', 0, NULL, 1),
(13, '006', '总经办', '', 0, NULL, 1),
(14, '007', '市场部', '', 0, NULL, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='部门岗位' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_school_department_position`
--

INSERT INTO `app_school_department_position` (`pos_id`, `pos_name`, `pos_desc`, `pos_leadership`, `dep_id`, `pos_roleRights`) VALUES
(1, '人事主管', '', 0, 9, ''),
(2, '行政主管', '', 0, 12, 'ROLE_MASTER'),
(3, '部门主管', '', 0, 13, ''),
(4, '部门主管', '', 0, 14, ''),
(5, '部门主管', '', 0, 7, '');

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
(2, 5);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='校区设置' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_school_district`
--

INSERT INTO `app_school_district` (`district_id`, `district_no`, `district_name`, `district_type`, `district_address`, `district_phone`, `district_parent`) VALUES
(1, '0000', '杭州总部', 0, '', '', NULL),
(3, '0001', '萧山校区', 1, '', '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_school_posets`
--

CREATE TABLE IF NOT EXISTS `app_school_posets` (
  `poset_id` bigint(20) NOT NULL auto_increment COMMENT '职位岗位ID',
  `poset_name` varchar(64) NOT NULL COMMENT '职位岗位名称',
  PRIMARY KEY  (`poset_id`),
  UNIQUE KEY `poset_name` (`poset_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职位岗位' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `app_school_posets`
--


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
  `level`  varchar(200) default NULL COMMENT '级别',
  `sequence` int(11) NOT NULL default '0',
  `extra_value` varchar(200) default NULL,
  `creation_date` datetime default '0000-00-00 00:00:00',
  `modified_date` datetime default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_system_dictionary`
--

INSERT INTO `app_system_dictionary` (`id`, `name`, `value`, `type`, `level`, `sequence`, `extra_value`, `creation_date`, `modified_date`) VALUES
(1, '人资文档', '人资文档', 'docType', '总部文档', 0, '123456', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, '行政文档', '行政文档', 'docType', '总部文档', 0, '456789', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `app_system_log`
--

CREATE TABLE IF NOT EXISTS `app_system_log` (
  `log_id` bigint(20) NOT NULL auto_increment,
  `user_name` varchar(120) NOT NULL COMMENT '用户名',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  PRIMARY KEY  (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统日志' AUTO_INCREMENT=56 ;

--
-- 转存表中的数据 `app_system_log`
--

INSERT INTO `app_system_log` (`log_id`, `user_name`, `user_id`, `createtime`, `operation`) VALUES
(1, 'test', 1, '2012-06-02 17:48:55', '进入权限组配置页面'),
(2, 'test', 1, '2012-06-04 18:41:12', '进入权限组配置页面'),
(3, 'test', 1, '2012-06-04 18:41:14', '进入权限组配置页面'),
(4, 'test', 1, '2012-06-04 18:41:27', '进入权限组配置页面'),
(5, 'test', 1, '2012-06-05 00:07:06', '进入权限组配置页面'),
(6, 'test', 1, '2012-06-05 01:49:47', '进入权限组配置页面'),
(7, 'test', 1, '2012-06-05 01:51:06', '进入权限组配置页面'),
(8, 'test', 1, '2012-06-05 01:51:08', '进入权限组配置页面'),
(9, 'test', 1, '2012-06-05 01:51:09', '进入权限组配置页面'),
(10, 'test', 1, '2012-06-05 01:51:20', '进入权限组配置页面'),
(11, 'test', 1, '2012-06-05 14:23:42', '进入权限组配置页面'),
(12, 'test', 1, '2012-06-05 17:22:27', '进入权限组配置页面'),
(13, 'test', 1, '2012-06-05 20:34:34', '进入权限组配置页面'),
(14, 'test', 1, '2012-06-05 20:34:39', '进入权限组配置页面'),
(15, 'test', 1, '2012-06-05 20:35:10', '进入权限组配置页面'),
(16, 'test', 1, '2012-06-05 20:37:54', '进入权限组配置页面'),
(17, 'test', 1, '2012-06-06 22:04:42', '进入权限组配置页面'),
(18, 'test', 1, '2012-06-06 22:08:14', '进入权限组配置页面'),
(19, 'test', 1, '2012-06-06 22:09:23', '进入权限组配置页面'),
(20, 'test', 1, '2012-06-07 00:01:04', '进入权限组配置页面'),
(21, 'test', 1, '2012-06-07 19:40:29', '进入权限组配置页面'),
(22, 'test', 1, '2012-06-07 21:09:28', '进入权限组配置页面'),
(23, 'test', 1, '2012-06-07 21:09:41', '进入权限组配置页面'),
(24, 'test', 1, '2012-06-07 23:05:20', '进入权限组配置页面'),
(25, 'test', 1, '2012-06-07 23:10:57', '进入权限组配置页面'),
(26, 'test', 1, '2012-06-07 23:11:14', '进入权限组配置页面'),
(27, 'test', 1, '2012-06-07 23:11:53', '进入权限组配置页面'),
(28, 'test', 1, '2012-06-07 23:12:09', '进入权限组配置页面'),
(29, 'test', 1, '2012-06-07 23:12:32', '进入权限组配置页面'),
(30, 'test', 1, '2012-06-07 23:13:31', '进入权限组配置页面'),
(31, 'test', 1, '2012-06-07 23:14:23', '进入权限组配置页面'),
(32, 'test', 1, '2012-06-07 23:14:56', '进入权限组配置页面'),
(33, 'test', 1, '2012-06-07 23:16:18', '进入权限组配置页面'),
(34, 'test', 1, '2012-06-07 23:16:52', '进入权限组配置页面'),
(35, 'test', 1, '2012-06-07 23:16:54', '进入权限组配置页面'),
(36, 'test', 1, '2012-06-08 00:06:08', '进入权限组配置页面'),
(37, 'test', 1, '2012-06-08 00:06:10', '进入权限组配置页面'),
(38, 'test', 1, '2012-06-08 00:21:08', '进入权限组配置页面'),
(39, 'test', 1, '2012-06-08 00:21:36', '进入权限组配置页面'),
(40, 'test', 1, '2012-06-08 00:21:41', '进入权限组配置页面'),
(41, 'test', 1, '2012-06-08 00:22:04', '进入权限组配置页面'),
(42, 'test', 1, '2012-06-08 01:07:23', '进入权限组配置页面'),
(43, 'test', 1, '2012-06-09 12:02:01', '进入权限组配置页面'),
(44, 'test', 1, '2012-06-10 23:37:22', '进入权限组配置页面'),
(45, 'test', 1, '2012-06-10 23:37:25', '进入权限组配置页面'),
(46, 'test', 1, '2012-06-10 23:37:28', '进入权限组配置页面'),
(47, 'test', 1, '2012-06-20 21:32:49', '进入权限组配置页面'),
(48, 'test', 1, '2012-06-26 22:49:02', '进入权限组配置页面'),
(49, 'test', 1, '2012-06-30 22:14:12', '进入权限组配置页面'),
(50, 'test', 1, '2012-07-09 21:23:20', '进入权限组配置页面'),
(51, 'test', 1, '2012-07-13 11:10:53', '进入权限组配置页面'),
(52, 'test', 1, '2012-07-13 11:11:21', '进入权限组配置页面'),
(53, 'test', 1, '2012-07-13 11:17:36', '进入权限组配置页面'),
(54, 'test', 1, '2012-07-13 15:35:02', '进入权限组配置页面'),
(55, 'test', 1, '2012-07-15 15:26:30', '进入权限组配置页面');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统工作内容设置' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_system_work_content`
--


-- --------------------------------------------------------

--
-- 表的结构 `app_system_work_template`
--

CREATE TABLE IF NOT EXISTS `app_system_work_template` (
  `work_tpl_id` bigint(20) NOT NULL auto_increment COMMENT '工作模板ID',
  `work_day` varchar(20) default NULL COMMENT '工作日期',
  `worktm_id` bigint(20) default NULL COMMENT '工作时间ID',
  `district_id` bigint(20) default NULL COMMENT '校区ID',
  `staff_id` bigint(20) COMMENT '员工ID',
  `staff_name` varchar(60) COMMENT '员工姓名',
  `enable` char(1) default '0' COMMENT '该模板是否启用',
  `template_id` bigint(20) default NULL COMMENT '模板ID',
  `workcnt_id` bigint(20) default NULL,
  PRIMARY KEY  (`work_tpl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作模板设置';

--
-- 转存表中的数据 `app_system_work_template`
--


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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='工作时间设置' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_system_work_time`
--


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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_user`
--

INSERT INTO `app_user` (`user_id`, `username`, `password`, `fullname`, `email`, `dep_id`, `pos_id`, `district_id`, `emp_id`, `phone`, `mobile`, `fax`, `address`, `zip`, `photo`, `status`, `logon_lastip`, `logon_lastime`) VALUES
(1, 'admin', 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=', '???', 'csx@jee-soft.cn', NULL, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, 1, '0:0:0:0:0:0:0:1', '2012-07-18 19:55:55'),
(2, 'csx', '9uCh4qxBlFqap/+KiqoM68EqO8yYGpKa1c+BCgkOEa4=', '斩不刀', '111@hotmail.com', 1, NULL, 3, NULL, '', '', '', '', '', '', 0, '', NULL),
(3, '0001012061241011', 'QGpDSgQ2on/ITC1MlNeed0CREM5MDxeCejn3iFEhLGk=', 'Manie', NULL, 9, 1, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL),
(4, '0001112061243222', 'DnOH9eQngdjBAPlv4OAAtxF1BJdvw3DiTFece8c7PD8=', 'Charotte', NULL, 12, 2, 3, 4, NULL, NULL, NULL, NULL, NULL, NULL, 1, '0:0:0:0:0:0:0:1', '2012-07-13 11:13:19'),
(5, '0001012061244839', '1pB+T6eAui2DtQe83R0qWFGgwWGmY5HB2cuU4vgLHl4=', 'Chonticha', NULL, 9, 1, 3, 5, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL);

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

CREATE TABLE `app_admin_conference` (
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
  `status` char(1) DEFAULT NULL,
  `sponsor` bigint(20) DEFAULT NULL COMMENT '发起者',
  `summary` text,
  `conference_type` char(1) DEFAULT NULL,
  PRIMARY KEY (`conference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会议表';

CREATE TABLE `app_conference_file` (
  `conference_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  PRIMARY KEY (`conference_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会议文件';


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
