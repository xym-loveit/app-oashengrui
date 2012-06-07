-- phpMyAdmin SQL Dump
-- version 3.4.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 06 月 07 日 10:37
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
-- 表的结构 `app_dictionary`
--

CREATE TABLE IF NOT EXISTS `app_dictionary` (
  `dic_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(64) NOT NULL COMMENT '字典名称',
  `item_value` varchar(128) NOT NULL COMMENT '字典值',
  `item_desc` varchar(256) DEFAULT NULL COMMENT '字典描述',
  `sn` int(11) DEFAULT NULL COMMENT '序号',
  `global_type` bigint(20) NOT NULL COMMENT '字典所属类型',
  PRIMARY KEY (`dic_id`),
  KEY `global_type` (`global_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典' AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件' AUTO_INCREMENT=1 ;

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
  PRIMARY KEY (`func_id`),
  UNIQUE KEY `func_key` (`func_key`),
  KEY `menu_id` (`menu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能表' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_function`
--

INSERT INTO `app_function` (`func_id`, `func_key`, `func_name`, `func_icon`, `func_desc`, `menu_id`) VALUES
(1, '_FUNCKEY_myplan_edit', '编辑任务', 'icon-btnedit', '', 4),
(2, '_FUNCKEY_myplan_del', '删除任务', 'icon-btndel', '', 4);

-- --------------------------------------------------------

--
-- 表的结构 `app_function_url`
--

CREATE TABLE IF NOT EXISTS `app_function_url` (
  `url_id` int(11) NOT NULL AUTO_INCREMENT,
  `func_id` int(11) NOT NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY (`url_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='功能URL' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_function_url`
--

INSERT INTO `app_function_url` (`url_id`, `func_id`, `url_path`) VALUES
(3, 1, 'aefew'),
(4, 2, 'sdewr');

-- --------------------------------------------------------

--
-- 表的结构 `app_global_type`
--

CREATE TABLE IF NOT EXISTS `app_global_type` (
  `protype_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(128) NOT NULL COMMENT '名称',
  `type_path` varchar(64) DEFAULT NULL COMMENT '路径',
  `type_depth` int(11) NOT NULL COMMENT '层次',
  `type_parent` bigint(20) DEFAULT NULL COMMENT '父节点',
  `type_nodekey` varchar(64) NOT NULL COMMENT '节点的分类Key',
  `type_catkey` varchar(64) NOT NULL COMMENT '节点分类的Key，如产品分类Key为PT',
  `type_sn` int(11) NOT NULL COMMENT '序号',
  PRIMARY KEY (`protype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总分类表  用于显示树层次结构的分类 可以允许任何层次结构' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_hire`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire` (
  `hire_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL COMMENT '招聘信息标题',
  `start_date` datetime NOT NULL COMMENT '开始时间',
  `end_date` datetime NOT NULL COMMENT '结束时间',
  `hire_count` int(11) NOT NULL COMMENT '招聘人数',
  `job_name` varchar(128) NOT NULL COMMENT '职位名称',
  `job_condition` varchar(1024) DEFAULT NULL COMMENT '招聘要求(条件)',
  `reg_fullname` varchar(128) NOT NULL COMMENT '登记人姓名',
  `reg_date` datetime NOT NULL COMMENT '登记时间',
  `modify_fullname` varchar(32) DEFAULT NULL COMMENT '变更人姓名',
  `modify_date` datetime DEFAULT NULL COMMENT '变更时间',
  `check_fullname` varchar(32) DEFAULT NULL COMMENT '审核人姓名',
  `check_opinion` varchar(512) DEFAULT NULL COMMENT '审核意见',
  `check_date` datetime DEFAULT NULL COMMENT '审批时间',
  `status` smallint(6) NOT NULL COMMENT '状态            1=通过审核            0=未审核            2=审核不通过',
  `memo` varchar(1024) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`hire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招聘发布' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_resume`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resume` (
  `resume_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(64) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `zip` varchar(32) DEFAULT NULL,
  `sex` varchar(32) DEFAULT NULL,
  `position` varchar(64) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `mobile` varchar(64) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `hobby` varchar(256) DEFAULT NULL,
  `religion` varchar(128) DEFAULT NULL,
  `party` varchar(128) DEFAULT NULL,
  `nationality` varchar(32) DEFAULT NULL,
  `race` varchar(32) DEFAULT NULL,
  `birthPlace` varchar(128) DEFAULT NULL,
  `eduCollege` varchar(128) DEFAULT NULL,
  `eduDegree` varchar(128) DEFAULT NULL,
  `eduMajor` varchar(128) DEFAULT NULL,
  `startWorkDate` datetime DEFAULT NULL,
  `idNo` varchar(64) DEFAULT NULL,
  `photo` varchar(128) DEFAULT NULL,
  `status` varchar(64) DEFAULT NULL COMMENT '状态\r\n            \r\n            通过\r\n            未通过\r\n            准备安排面试\r\n            面试通过\r\n            \r\n            ',
  `memo` varchar(1024) DEFAULT NULL,
  `registor` varchar(64) DEFAULT NULL,
  `regTime` datetime DEFAULT NULL,
  `workCase` text,
  `trainCase` text,
  `projectCase` text,
  PRIMARY KEY (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历管理' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_hrm_resum_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resum_file` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统菜单' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `app_menu`
--

INSERT INTO `app_menu` (`menu_id`, `menu_title`, `menu_icon`, `menu_url`, `menu_key`, `menu_desc`, `menu_parent`, `menu_order`) VALUES
(3, '我的工作区', 'icon-desktop', 'javascript:void(0);', '_menu_mod_personal', '', NULL, 0),
(4, '我的任务', 'icon-myplan', 'javascript:void(0);', '_menu_mod_personal_mytask', 'test0', 3, 0);

-- --------------------------------------------------------

--
-- 表的结构 `app_news`
--

CREATE TABLE IF NOT EXISTS `app_news` (
  `news_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) NOT NULL COMMENT '新闻类型id',
  `news_subject` varchar(128) NOT NULL COMMENT '新闻标题',
  `news_content` text NOT NULL,
  `news_author` varchar(32) NOT NULL COMMENT '新闻作者',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '最后更新时间',
  `status` smallint(6) NOT NULL COMMENT '            0=待审核            1=审核通过',
  PRIMARY KEY (`news_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_news_type`
--

CREATE TABLE IF NOT EXISTS `app_news_type` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_name` int(11) NOT NULL COMMENT '新闻类型',
  `sn` int(11) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻类型' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_process_definition`
--

CREATE TABLE IF NOT EXISTS `app_process_definition` (
  `def_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) NOT NULL COMMENT '流程分类ID',
  `def_name` varchar(256) NOT NULL COMMENT '流程名称',
  `def_description` varchar(1024) NOT NULL COMMENT '流程描述',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`def_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程定义' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_process_form`
--

CREATE TABLE IF NOT EXISTS `app_process_form` (
  `form_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(128) NOT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) DEFAULT NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) DEFAULT NULL COMMENT '跳转节点, 跳转至下一任务',
  `form_status` smallint(6) DEFAULT NULL COMMENT '0=进入任务 1=完成 2=取消',
  `comments` text COMMENT '意见',
  PRIMARY KEY (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_process_task`
--

CREATE TABLE IF NOT EXISTS `app_process_task` (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `def_id` bigint(20) NOT NULL COMMENT '所属流程定义ID',
  `task_name` varchar(128) NOT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) DEFAULT NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) DEFAULT NULL COMMENT '跳转节点, 跳转至下一任务',
  `role_names` varchar(2000) DEFAULT NULL,
  `dep_names` varchar(2000) DEFAULT NULL,
  `user_names` varchar(2000) DEFAULT NULL,
  `user_ids` varchar(2000) DEFAULT NULL COMMENT '用户IDS 格式如下，以方便使用like操作 ,1,2,',
  `role_ids` varchar(2000) DEFAULT NULL COMMENT '角色IDS 格式如下，以方便使用like操作 ,1,2,',
  `dep_ids` varchar(2000) DEFAULT NULL COMMENT '部门IDS 格式如下，以方便使用like操作 ,1,2,',
  `comments` text COMMENT '意见',
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程任务设置' AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='流程分类' AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `app_process_type`
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
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_key` (`role_key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='角色表' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_role`
--

INSERT INTO `app_role` (`role_id`, `role_name`, `role_key`, `role_desc`, `role_status`, `role_rights`, `role_type`) VALUES
(5, '校长', 'ROLE_MASTER', 'teset', 1, '_FUNCKEY_myplan_edit', 1);

-- --------------------------------------------------------

--
-- 表的结构 `app_role_func`
--

CREATE TABLE IF NOT EXISTS `app_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`func_id`),
  KEY `role_id` (`role_id`),
  KEY `app_role_func_ibfk_2` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

--
-- 转存表中的数据 `app_role_func`
--

INSERT INTO `app_role_func` (`role_id`, `func_id`) VALUES
(5, 1);

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
(5, 3),
(5, 4);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='学校部门设置' AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `app_school_department`
--

INSERT INTO `app_school_department` (`dep_id`, `dep_no`, `dep_name`, `dep_desc`, `dep_eqlevel`, `dep_eqid`, `dep_orgtype`) VALUES
(7, '0', '人资部32', '', 0, NULL, 0),
(8, '0', '人资部', '', 0, NULL, 1),
(9, '0', '人资部', '', 0, NULL, 1);

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
  `pos_roleRights` varchar(500) DEFAULT NULL COMMENT '岗位角色权限',
  PRIMARY KEY (`pos_id`),
  KEY `dep_id` (`dep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_school_department_position_role`
--

CREATE TABLE IF NOT EXISTS `app_school_department_position_role` (
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`pos_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位权限';

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='校区设置' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_school_district`
--

INSERT INTO `app_school_district` (`district_id`, `district_no`, `district_name`, `district_type`, `district_address`, `district_phone`, `district_parent`) VALUES
(1, '0000', '杭州总部', 0, '', '', NULL),
(3, '0001', '萧山校区', 1, '', '', 1);

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
-- 表的结构 `app_system_log`
--

CREATE TABLE IF NOT EXISTS `app_system_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(120) NOT NULL COMMENT '用户名',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统日志' AUTO_INCREMENT=21 ;

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
(20, 'test', 1, '2012-06-07 00:01:04', '进入权限组配置页面');

-- --------------------------------------------------------

--
-- 表的结构 `app_user`
--

CREATE TABLE IF NOT EXISTS `app_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(128) NOT NULL COMMENT '用户名',
  `title` smallint(6) NOT NULL COMMENT '1=先生\r\n            0=女士\r\n            小姐',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `email` varchar(128) NOT NULL COMMENT '邮件',
  `dep_id` bigint(20) DEFAULT NULL COMMENT '所属部门',
  `position` varchar(32) DEFAULT NULL COMMENT '职位',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `address` varchar(64) DEFAULT NULL COMMENT '地址',
  `zip` varchar(32) DEFAULT NULL COMMENT '邮编',
  `photo` varchar(128) DEFAULT NULL COMMENT '相片',
  `status` smallint(6) NOT NULL COMMENT '状态\r\n            1=激活\r\n            0=禁用\r\n            2=离职\r\n            ',
  `logon_lastip` varchar(64) NOT NULL COMMENT '最后登录IP',
  `logon_lastime` datetime NOT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`user_id`),
  KEY `FK_AU_R_DPT` (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_user`
--

INSERT INTO `app_user` (`user_id`, `username`, `title`, `password`, `email`, `dep_id`, `position`, `phone`, `mobile`, `fax`, `address`, `zip`, `photo`, `status`, `logon_lastip`, `logon_lastime`) VALUES
(-1, 'system', 1, '0', '152@163.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '', '0000-00-00 00:00:00'),
(1, 'admin', 1, 'a4ayc/80/OGda4BO/1o/V0etpOqiLx1JwB5S3beHW0s=', 'csx@jee-soft.cn', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', '0000-00-00 00:00:00'),
(2, 'csx', 1, '9uCh4qxBlFqap/+KiqoM68EqO8yYGpKa1c+BCgkOEa4=', '111@hotmail.com', 1, '', '', '', '', '', '', '', 1, '', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `app_user_role`
--

CREATE TABLE IF NOT EXISTS `app_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限表';

--
-- 限制导出的表
--

--
-- 限制表 `app_function_url`
--
ALTER TABLE `app_function_url`
  ADD CONSTRAINT `app_function_url_ibfk_1` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`);

--
-- 限制表 `app_hrm_resum_file`
--
ALTER TABLE `app_hrm_resum_file`
  ADD CONSTRAINT `app_hrm_resum_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`);

--
-- 限制表 `app_news`
--
ALTER TABLE `app_news`
  ADD CONSTRAINT `app_news_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_news_type` (`type_id`);

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
