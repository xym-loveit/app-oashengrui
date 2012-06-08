-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 08, 2012 at 05:37 PM
-- Server version: 5.0.91
-- PHP Version: 5.2.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `app_sroa`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_dictionary`
--

CREATE TABLE IF NOT EXISTS `app_dictionary` (
  `dic_id` bigint(20) NOT NULL auto_increment,
  `item_name` varchar(64) NOT NULL COMMENT '字典名称',
  `item_value` varchar(128) NOT NULL COMMENT '字典值',
  `item_desc` varchar(256) default NULL COMMENT '字典描述',
  `sn` int(11) default NULL COMMENT '序号',
  `global_type` bigint(20) NOT NULL COMMENT '字典所属类型',
  PRIMARY KEY  (`dic_id`),
  KEY `global_type` (`global_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_dictionary`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_file_attach`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_file_attach`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_function`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能表' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `app_function`
--

INSERT INTO `app_function` (`func_id`, `func_key`, `func_name`, `func_icon`, `func_desc`, `menu_id`) VALUES
(1, '_FUNCKEY_myplan_edit', '编辑任务', 'icon-btnedit', '', 4),
(2, '_FUNCKEY_myplan_del', '删除任务', 'icon-btndel', '', 4);

-- --------------------------------------------------------

--
-- Table structure for table `app_function_url`
--

CREATE TABLE IF NOT EXISTS `app_function_url` (
  `url_id` int(11) NOT NULL auto_increment,
  `func_id` int(11) NOT NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY  (`url_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能URL' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `app_function_url`
--

INSERT INTO `app_function_url` (`url_id`, `func_id`, `url_path`) VALUES
(3, 1, 'aefew'),
(4, 2, 'sdewr');

-- --------------------------------------------------------

--
-- Table structure for table `app_global_type`
--

CREATE TABLE IF NOT EXISTS `app_global_type` (
  `protype_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '名称',
  `type_path` varchar(64) default NULL COMMENT '路径',
  `type_depth` int(11) NOT NULL COMMENT '层次',
  `type_parent` bigint(20) default NULL COMMENT '父节点',
  `type_nodekey` varchar(64) NOT NULL COMMENT '节点的分类Key',
  `type_catkey` varchar(64) NOT NULL COMMENT '节点分类的Key，如产品分类Key为PT',
  `type_sn` int(11) NOT NULL COMMENT '序号',
  PRIMARY KEY  (`protype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总分类表  用于显示树层次结构的分类 可以允许任何层次结构' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_global_type`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_archive`
--

CREATE TABLE IF NOT EXISTS `app_hrm_archive` (
  `archive_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `apply_depname` bigint(20) NOT NULL COMMENT '应聘部门',
  `apply_districtname` bigint(20) NOT NULL COMMENT '应聘校区',
  `apply_posname` bigint(20) NOT NULL COMMENT '应聘岗位',
  `archive_source` tinyint(4) NOT NULL COMMENT '来源',
  `archive_star` tinyint(4) NOT NULL COMMENT '评定星级',
  PRIMARY KEY  (`archive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司人才库' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_hrm_archive`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_employee`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee` (
  `emp_id` bigint(20) NOT NULL auto_increment,
  `emp_no` varchar(64) NOT NULL COMMENT '员工编号',
  `dep_id` bigint(20) NOT NULL COMMENT '员工所在部门ID',
  `district_id` bigint(20) NOT NULL COMMENT '员工所在校区ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  PRIMARY KEY  (`emp_id`),
  UNIQUE KEY `emp_no` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工档案表' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_hrm_employee`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_employee_profile`
--

CREATE TABLE IF NOT EXISTS `app_hrm_employee_profile` (
  `profile_id` bigint(20) NOT NULL auto_increment,
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `status` tinyint(4) NOT NULL COMMENT '员工状态',
  PRIMARY KEY  (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工基本信息表' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_hrm_employee_profile`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_employee_roadmap`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工历程' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_hrm_employee_roadmap`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_entries`
--

CREATE TABLE IF NOT EXISTS `app_hrm_entries` (
  `entry_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `dep_id` bigint(20) NOT NULL COMMENT '入职部门ID',
  `district_id` bigint(20) NOT NULL COMMENT '入职校区ID',
  PRIMARY KEY  (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工入职安排表' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_hrm_entries`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_hire_interviews`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_interviews` (
  `hw_id` bigint(20) NOT NULL auto_increment,
  `hissue_id` bigint(20) NOT NULL COMMENT '应聘ID',
  `interview_address` int(11) NOT NULL COMMENT '面试地址',
  `interview_date` datetime NOT NULL COMMENT '面试时间',
  `interviewer_id` bigint(20) NOT NULL COMMENT '面试官ID',
  `meto` int(250) default NULL COMMENT '面试备注',
  `step` tinyint(4) NOT NULL COMMENT '当前面试环节',
  `status` tinyint(4) NOT NULL COMMENT '面试状态',
  `comments` varchar(150) default NULL COMMENT '面试意见',
  PRIMARY KEY  (`hw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招聘面试' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_hrm_hire_interviews`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_hire_interviews_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_interviews_file` (
  `interview_id` bigint(20) NOT NULL COMMENT '面试ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`interview_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='面试附件';

--
-- Dumping data for table `app_hrm_hire_interviews_file`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_hire_issue`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_issue` (
  `hissue_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `hjob_id` bigint(20) NOT NULL COMMENT '应聘职位ID',
  `current_status` tinyint(4) NOT NULL COMMENT '当前状态',
  `final_status` tinyint(4) NOT NULL COMMENT '最终处理结果',
  PRIMARY KEY  (`hissue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='当前招聘' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_hrm_hire_issue`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_hire_job`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire_job` (
  `hjob_id` bigint(20) NOT NULL auto_increment,
  `job_title` varchar(128) NOT NULL COMMENT '招聘岗位名称',
  `hjob_district` int(11) NOT NULL COMMENT '招聘校区',
  `hjob_dep` int(11) NOT NULL COMMENT '招聘部门',
  `hjob_range` tinyint(4) NOT NULL COMMENT '招聘范围',
  `hjob_visible` tinyint(4) NOT NULL COMMENT '可见范围',
  `end_date` datetime NOT NULL COMMENT '结束时间',
  `hjob_count` int(11) NOT NULL COMMENT '招聘人数',
  `hjob_condition` varchar(1024) default NULL COMMENT '招聘要求(条件)',
  `hjob_address` varchar(150) NOT NULL COMMENT '工作地点',
  `hjob_salary` text COMMENT '薪资福利',
  `attach_file` varchar(64) default NULL COMMENT '附件区',
  `reg_fullname` varchar(128) NOT NULL COMMENT '登记人姓名',
  `reg_date` datetime NOT NULL COMMENT '登记时间',
  `modify_fullname` varchar(32) default NULL COMMENT '变更人姓名',
  `modify_date` datetime default NULL COMMENT '变更时间',
  `check_fullname` varchar(32) default NULL COMMENT '审核人姓名',
  `check_opinion` varchar(512) default NULL COMMENT '审核意见',
  `check_date` datetime default NULL COMMENT '审批时间',
  `status` smallint(6) NOT NULL COMMENT '状态            1=通过审核            0=未审核            2=审核不通过',
  `memo` varchar(1024) default NULL COMMENT '备注',
  PRIMARY KEY  (`hjob_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招聘岗位发布' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_hrm_hire_job`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_resume`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resume` (
  `resume_id` bigint(20) NOT NULL auto_increment,
  `fullname` varchar(64) NOT NULL,
  `age` int(11) default NULL,
  `birthday` datetime default NULL,
  `address` varchar(128) default NULL,
  `zip` varchar(32) default NULL,
  `sex` varchar(32) default NULL,
  `position` varchar(64) default NULL,
  `phone` varchar(64) default NULL,
  `mobile` varchar(64) default NULL,
  `email` varchar(128) default NULL,
  `hobby` varchar(256) default NULL,
  `religion` varchar(128) default NULL,
  `party` varchar(128) default NULL,
  `nationality` varchar(32) default NULL,
  `race` varchar(32) default NULL,
  `birthPlace` varchar(128) default NULL,
  `eduCollege` varchar(128) default NULL,
  `eduDegree` varchar(128) default NULL,
  `eduMajor` varchar(128) default NULL,
  `startWorkDate` datetime default NULL,
  `idNo` varchar(64) default NULL,
  `photo` varchar(128) default NULL,
  `status` varchar(64) default NULL COMMENT '状态\r\n            \r\n            通过\r\n            未通过\r\n            准备安排面试\r\n            面试通过\r\n            \r\n            ',
  `memo` varchar(1024) default NULL,
  `registor` varchar(64) default NULL,
  `regTime` datetime default NULL,
  `workCase` text,
  `trainCase` text,
  `projectCase` text,
  PRIMARY KEY  (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历管理' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_hrm_resume`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_hrm_resume_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resume_file` (
  `file_id` bigint(20) NOT NULL,
  `resum_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`file_id`,`resum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历附件';

--
-- Dumping data for table `app_hrm_resume_file`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_menu`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统菜单' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `app_menu`
--

INSERT INTO `app_menu` (`menu_id`, `menu_title`, `menu_icon`, `menu_url`, `menu_key`, `menu_desc`, `menu_parent`, `menu_order`) VALUES
(3, '我的工作区', 'icon-desktop', 'javascript:void(0);', '_menu_mod_personal', '', NULL, 0),
(4, '我的任务', 'icon-myplan', 'javascript:void(0);', '_menu_mod_personal_mytask', 'test0', 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `app_news`
--

CREATE TABLE IF NOT EXISTS `app_news` (
  `news_id` bigint(20) NOT NULL auto_increment,
  `type_id` bigint(20) NOT NULL COMMENT '新闻类型id',
  `news_subject` varchar(128) NOT NULL COMMENT '新闻标题',
  `news_content` text NOT NULL,
  `news_author` varchar(32) NOT NULL COMMENT '新闻作者',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '最后更新时间',
  `status` smallint(6) NOT NULL COMMENT '            0=待审核            1=审核通过',
  PRIMARY KEY  (`news_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_news`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_news_type`
--

CREATE TABLE IF NOT EXISTS `app_news_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` int(11) NOT NULL COMMENT '新闻类型',
  `sn` int(11) NOT NULL,
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻类型' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_news_type`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_process_definition`
--

CREATE TABLE IF NOT EXISTS `app_process_definition` (
  `def_id` bigint(20) NOT NULL auto_increment,
  `type_id` bigint(20) NOT NULL COMMENT '流程分类ID',
  `def_name` varchar(256) NOT NULL COMMENT '流程名称',
  `def_description` varchar(1024) NOT NULL COMMENT '流程描述',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY  (`def_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程定义' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_process_definition`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_process_form`
--

CREATE TABLE IF NOT EXISTS `app_process_form` (
  `form_id` bigint(20) NOT NULL auto_increment,
  `activity_name` varchar(128) NOT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) default NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) default NULL COMMENT '跳转节点, 跳转至下一任务',
  `form_status` smallint(6) default NULL COMMENT '0=进入任务 1=完成 2=取消',
  `comments` text COMMENT '意见',
  PRIMARY KEY  (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_process_form`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_process_task`
--

CREATE TABLE IF NOT EXISTS `app_process_task` (
  `task_id` bigint(20) NOT NULL auto_increment,
  `def_id` bigint(20) NOT NULL COMMENT '所属流程定义ID',
  `task_name` varchar(128) NOT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) default NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) default NULL COMMENT '跳转节点, 跳转至下一任务',
  `role_names` varchar(2000) default NULL,
  `dep_names` varchar(2000) default NULL,
  `user_names` varchar(2000) default NULL,
  `user_ids` varchar(2000) default NULL COMMENT '用户IDS 格式如下，以方便使用like操作 ,1,2,',
  `role_ids` varchar(2000) default NULL COMMENT '角色IDS 格式如下，以方便使用like操作 ,1,2,',
  `dep_ids` varchar(2000) default NULL COMMENT '部门IDS 格式如下，以方便使用like操作 ,1,2,',
  `comments` text COMMENT '意见',
  PRIMARY KEY  (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程任务设置' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_process_task`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_process_type`
--

CREATE TABLE IF NOT EXISTS `app_process_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '流程分类名',
  `type_key` varchar(64) default NULL COMMENT '流程分类KEY',
  `type_desc` varchar(250) default NULL COMMENT '流程分类描述',
  `type_slug` varchar(64) NOT NULL COMMENT '分类类别',
  `type_parent` bigint(20) default NULL COMMENT '流程父分类',
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程分类' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `app_process_type`
--

INSERT INTO `app_process_type` (`type_id`, `type_name`, `type_key`, `type_desc`, `type_slug`, `type_parent`) VALUES
(1, '费用支出申请审批', 'PROCESS_PAYMENT', NULL, 'finance', NULL),
(2, '合同申请审批', 'PROCESS_CONTRACT', NULL, 'finance', NULL),
(3, '转正申请审批', 'PROCESS_MEMBER_BERGULAR', NULL, 'hrm', NULL),
(4, '调动申请审批', 'PROCESS_MEMBER_TRANSFER', NULL, 'hrm', NULL),
(5, '晋升申请审批', 'PROCESS_MEMBER_PROMOTION', NULL, 'hrm', NULL),
(6, '离职申请审批', 'PROCESS_MEMBER_FAIRWELL', NULL, 'hrm', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_role`
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
-- Dumping data for table `app_role`
--

INSERT INTO `app_role` (`role_id`, `role_name`, `role_key`, `role_desc`, `role_status`, `role_rights`, `role_type`, `role_edit`) VALUES
(1, '超级管理员', 'ROLE_SUPER', NULL, 1, '__ALL', 0, 0),
(5, '校长', 'ROLE_MASTER', 'teset', 1, '_FUNCKEY_myplan_edit', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_role_func`
--

CREATE TABLE IF NOT EXISTS `app_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`func_id`),
  KEY `role_id` (`role_id`),
  KEY `app_role_func_ibfk_2` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

--
-- Dumping data for table `app_role_func`
--

INSERT INTO `app_role_func` (`role_id`, `func_id`) VALUES
(5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_role_menu`
--

CREATE TABLE IF NOT EXISTS `app_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单';

--
-- Dumping data for table `app_role_menu`
--

INSERT INTO `app_role_menu` (`role_id`, `menu_id`) VALUES
(5, 3),
(5, 4);

-- --------------------------------------------------------

--
-- Table structure for table `app_school_department`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='学校部门设置' AUTO_INCREMENT=10 ;

--
-- Dumping data for table `app_school_department`
--

INSERT INTO `app_school_department` (`dep_id`, `dep_no`, `dep_name`, `dep_desc`, `dep_eqlevel`, `dep_eqid`, `dep_orgtype`) VALUES
(1, '0', '人资部', '', 0, NULL, 1),
(7, '0', '人资部32', '', 0, NULL, 0),
(9, '0', '人资部', '', 0, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_school_department_position`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `app_school_department_position`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_school_department_position_role`
--

CREATE TABLE IF NOT EXISTS `app_school_department_position_role` (
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY  (`pos_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位权限';

--
-- Dumping data for table `app_school_department_position_role`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_school_district`
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
-- Dumping data for table `app_school_district`
--

INSERT INTO `app_school_district` (`district_id`, `district_no`, `district_name`, `district_type`, `district_address`, `district_phone`, `district_parent`) VALUES
(1, '0000', '杭州总部', 0, '', '', NULL),
(3, '0001', '萧山校区', 1, '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_system_config`
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
-- Dumping data for table `app_system_config`
--


-- --------------------------------------------------------

--
-- Table structure for table `app_system_log`
--

CREATE TABLE IF NOT EXISTS `app_system_log` (
  `log_id` bigint(20) NOT NULL auto_increment,
  `user_name` varchar(120) NOT NULL COMMENT '用户名',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  PRIMARY KEY  (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统日志' AUTO_INCREMENT=43 ;

--
-- Dumping data for table `app_system_log`
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
(42, 'test', 1, '2012-06-08 01:07:23', '进入权限组配置页面');

-- --------------------------------------------------------

--
-- Table structure for table `app_user`
--

CREATE TABLE IF NOT EXISTS `app_user` (
  `user_id` bigint(20) NOT NULL auto_increment COMMENT '主键',
  `username` varchar(128) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `fullname` varchar(64) NOT NULL COMMENT '用户姓名',
  `email` varchar(128) NOT NULL COMMENT '邮件',
  `dep_id` bigint(20) default NULL COMMENT '所属部门',
  `pos_id` bigint(20) default NULL COMMENT '职位',
  `district_id` bigint(20) default NULL COMMENT '用户所在校区',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `app_user`
--

INSERT INTO `app_user` (`user_id`, `username`, `password`, `fullname`, `email`, `dep_id`, `pos_id`, `district_id`, `phone`, `mobile`, `fax`, `address`, `zip`, `photo`, `status`, `logon_lastip`, `logon_lastime`) VALUES
(1, 'admin', 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=', '卡卡西', 'csx@jee-soft.cn', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, '127.0.0.1', '2012-06-08 12:35:54'),
(2, 'csx', '9uCh4qxBlFqap/+KiqoM68EqO8yYGpKa1c+BCgkOEa4=', '斩不刀', '111@hotmail.com', 1, NULL, 3, '', '', '', '', '', '', 0, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_user_role`
--

CREATE TABLE IF NOT EXISTS `app_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限表';

--
-- Dumping data for table `app_user_role`
--


--
-- Constraints for dumped tables
--

--
-- Constraints for table `app_function_url`
--
ALTER TABLE `app_function_url`
  ADD CONSTRAINT `app_function_url_ibfk_1` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`);

--
-- Constraints for table `app_hrm_resume_file`
--
ALTER TABLE `app_hrm_resume_file`
  ADD CONSTRAINT `app_hrm_resume_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`);

--
-- Constraints for table `app_news`
--
ALTER TABLE `app_news`
  ADD CONSTRAINT `app_news_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_news_type` (`type_id`);

--
-- Constraints for table `app_process_definition`
--
ALTER TABLE `app_process_definition`
  ADD CONSTRAINT `app_process_definition_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_process_type` (`type_id`);

--
-- Constraints for table `app_role_func`
--
ALTER TABLE `app_role_func`
  ADD CONSTRAINT `app_role_func_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`),
  ADD CONSTRAINT `app_role_func_ibfk_2` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`);
