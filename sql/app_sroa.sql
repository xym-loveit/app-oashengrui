-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: May 31, 2012, 05:13 PM
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
-- 資料表格式： `app_department`
--

CREATE TABLE IF NOT EXISTS `app_department` (
  `dep_id` bigint(20) NOT NULL auto_increment,
  `dep_name` varchar(128) NOT NULL COMMENT '部门名称',
  `dep_desc` varchar(256) default NULL COMMENT '部门描述',
  `dep_level` int(11) NOT NULL COMMENT '层次',
  `parent_id` bigint(20) default NULL,
  `path` varchar(128) default NULL COMMENT '路径',
  `phone` varchar(64) default NULL,
  `fax` varchar(64) default NULL,
  PRIMARY KEY  (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 列出以下資料庫的數據： `app_department`
--

INSERT INTO `app_department` (`dep_id`, `dep_name`, `dep_desc`, `dep_level`, `parent_id`, `path`, `phone`, `fax`) VALUES
(1, '信息部门', '维护系统', 2, 0, '0.1.', NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表格式： `app_dictionary`
--

CREATE TABLE IF NOT EXISTS `app_dictionary` (
  `dic_id` bigint(20) NOT NULL auto_increment,
  `item_name` varchar(64) NOT NULL COMMENT '字典名称',
  `item_value` varchar(128) NOT NULL COMMENT '字典值',
  `item_desc` varchar(256) default NULL COMMENT '字典描述',
  `sn` int(11) default NULL COMMENT '序号',
  PRIMARY KEY  (`dic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_dictionary`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_file_attach`
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
  PRIMARY KEY  (`func_id`),
  UNIQUE KEY `func_key` (`func_key`),
  KEY `menu_id` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='功能表' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_function`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_function_url`
--

CREATE TABLE IF NOT EXISTS `app_function_url` (
  `url_id` int(11) NOT NULL auto_increment,
  `func_id` int(11) NOT NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY  (`url_id`),
  KEY `FK_FU_R_AFN` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='功能URL' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_function_url`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_global_type`
--

CREATE TABLE IF NOT EXISTS `app_global_type` (
  `protype_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '名称',
  `type_path` varchar(64) default NULL COMMENT '路径',
  `type_depth` int(11) NOT NULL COMMENT '层次',
  `type_parentid` bigint(20) default NULL COMMENT '父节点',
  `type_nodekey` varchar(64) NOT NULL COMMENT '节点的分类Key',
  `type_catkey` varchar(64) NOT NULL COMMENT '节点分类的Key，如产品分类Key为PT',
  `type_sn` int(11) NOT NULL COMMENT '序号',
  PRIMARY KEY  (`protype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总分类表  用于显示树层次结构的分类 可以允许任何层次结构' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_global_type`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_hire`
--

CREATE TABLE IF NOT EXISTS `app_hrm_hire` (
  `hire_id` bigint(20) NOT NULL auto_increment,
  `title` varchar(128) NOT NULL COMMENT '招聘信息标题',
  `start_date` datetime NOT NULL COMMENT '开始时间',
  `end_date` datetime NOT NULL COMMENT '结束时间',
  `hire_count` int(11) NOT NULL COMMENT '招聘人数',
  `job_name` varchar(128) NOT NULL COMMENT '职位名称',
  `job_condition` varchar(1024) default NULL COMMENT '招聘要求(条件)',
  `reg_fullname` varchar(128) NOT NULL COMMENT '登记人姓名',
  `reg_date` datetime NOT NULL COMMENT '登记时间',
  `modify_fullname` varchar(32) default NULL COMMENT '变更人姓名',
  `modify_date` datetime default NULL COMMENT '变更时间',
  `check_fullname` varchar(32) default NULL COMMENT '审核人姓名',
  `check_opinion` varchar(512) default NULL COMMENT '审核意见',
  `check_date` datetime default NULL COMMENT '审批时间',
  `status` smallint(6) NOT NULL COMMENT '状态            1=通过审核            0=未审核            2=审核不通过',
  `memo` varchar(1024) default NULL COMMENT '备注',
  PRIMARY KEY  (`hire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招聘发布' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_hrm_hire`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_resume`
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
-- 列出以下資料庫的數據： `app_hrm_resume`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_hrm_resum_file`
--

CREATE TABLE IF NOT EXISTS `app_hrm_resum_file` (
  `file_id` bigint(20) NOT NULL,
  `resum_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`file_id`,`resum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历附件';

--
-- 列出以下資料庫的數據： `app_hrm_resum_file`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_menu`
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
-- 列出以下資料庫的數據： `app_menu`
--

INSERT INTO `app_menu` (`menu_id`, `menu_title`, `menu_icon`, `menu_url`, `menu_key`, `menu_desc`, `menu_parent`, `menu_order`) VALUES
(3, '我的工作区', 'icon-desktop', 'javascript:void(0);', '_menu_mod_personal', '', NULL, 0),
(4, '我的任务', 'icon-myplan', 'javascript:void(0);', '_menu_mod_personal_mytask', '', 3, 0);

-- --------------------------------------------------------

--
-- 資料表格式： `app_news`
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
-- 列出以下資料庫的數據： `app_news`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_news_type`
--

CREATE TABLE IF NOT EXISTS `app_news_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` int(11) NOT NULL COMMENT '新闻类型',
  `sn` int(11) NOT NULL,
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻类型' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_news_type`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_process_definition`
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
-- 列出以下資料庫的數據： `app_process_definition`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_process_form`
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
-- 列出以下資料庫的數據： `app_process_form`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_process_task`
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
-- 列出以下資料庫的數據： `app_process_task`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_process_type`
--

CREATE TABLE IF NOT EXISTS `app_process_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '流程分类名',
  `parent_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程分类' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_process_type`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_role`
--

CREATE TABLE IF NOT EXISTS `app_role` (
  `role_id` int(11) NOT NULL auto_increment,
  `role_name` int(120) NOT NULL COMMENT '角色名称',
  `role_desc` int(150) default NULL COMMENT '角色描述',
  `role_status` smallint(11) NOT NULL COMMENT '角色状态',
  `role_rights` text COMMENT '权限功能列表',
  PRIMARY KEY  (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_role`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_role_func`
--

CREATE TABLE IF NOT EXISTS `app_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`func_id`),
  KEY `role_id` (`role_id`),
  KEY `app_role_func_ibfk_2` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

--
-- 列出以下資料庫的數據： `app_role_func`
--


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
-- 資料表格式： `app_system_log`
--

CREATE TABLE IF NOT EXISTS `app_system_log` (
  `log_id` bigint(20) NOT NULL auto_increment,
  `user_name` int(11) NOT NULL COMMENT '用户名',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  PRIMARY KEY  (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统日志' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `app_system_log`
--


-- --------------------------------------------------------

--
-- 資料表格式： `app_user`
--

CREATE TABLE IF NOT EXISTS `app_user` (
  `user_id` bigint(20) NOT NULL auto_increment COMMENT '主键',
  `username` varchar(128) NOT NULL COMMENT '用户名',
  `title` smallint(6) NOT NULL COMMENT '1=先生\r\n            0=女士\r\n            小姐',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `email` varchar(128) NOT NULL COMMENT '邮件',
  `dep_id` bigint(20) default NULL COMMENT '所属部门',
  `position` varchar(32) default NULL COMMENT '职位',
  `phone` varchar(32) default NULL COMMENT '电话',
  `mobile` varchar(32) default NULL COMMENT '手机',
  `fax` varchar(32) default NULL COMMENT '传真',
  `address` varchar(64) default NULL COMMENT '地址',
  `zip` varchar(32) default NULL COMMENT '邮编',
  `photo` varchar(128) default NULL COMMENT '相片',
  `accession_time` datetime NOT NULL COMMENT '入职时间',
  `status` smallint(6) NOT NULL COMMENT '状态\r\n            1=激活\r\n            0=禁用\r\n            2=离职\r\n            ',
  `education` varchar(64) default NULL,
  `fullname` varchar(50) NOT NULL,
  `delFlag` smallint(6) NOT NULL COMMENT '0=未删除\r\n            1=删除',
  PRIMARY KEY  (`user_id`),
  KEY `FK_AU_R_DPT` (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表' AUTO_INCREMENT=3 ;

--
-- 列出以下資料庫的數據： `app_user`
--

INSERT INTO `app_user` (`user_id`, `username`, `title`, `password`, `email`, `dep_id`, `position`, `phone`, `mobile`, `fax`, `address`, `zip`, `photo`, `accession_time`, `status`, `education`, `fullname`, `delFlag`) VALUES
(-1, 'system', 1, '0', '152@163.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2009-12-18 00:00:00', 0, NULL, '系统', 1),
(1, 'admin', 1, 'a4ayc/80/OGda4BO/1o/V0etpOqiLx1JwB5S3beHW0s=', 'csx@jee-soft.cn', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2009-12-18 00:00:00', 1, NULL, '超级管理员', 0),
(2, 'csx', 1, '9uCh4qxBlFqap/+KiqoM68EqO8yYGpKa1c+BCgkOEa4=', '111@hotmail.com', 1, '', '', '', '', '', '', '', '2010-05-03 00:00:00', 1, NULL, 'cwx', 0);

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


--
-- 備份資料表限制
--

--
-- 資料表限制 `app_function_url`
--
ALTER TABLE `app_function_url`
  ADD CONSTRAINT `app_function_url_ibfk_1` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`);

--
-- 資料表限制 `app_hrm_resum_file`
--
ALTER TABLE `app_hrm_resum_file`
  ADD CONSTRAINT `app_hrm_resum_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`);

--
-- 資料表限制 `app_news`
--
ALTER TABLE `app_news`
  ADD CONSTRAINT `app_news_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_news_type` (`type_id`);

--
-- 資料表限制 `app_process_definition`
--
ALTER TABLE `app_process_definition`
  ADD CONSTRAINT `app_process_definition_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_process_type` (`type_id`);

--
-- 資料表限制 `app_role_func`
--
ALTER TABLE `app_role_func`
  ADD CONSTRAINT `app_role_func_ibfk_2` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`),
  ADD CONSTRAINT `app_role_func_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`);

--
-- 資料表限制 `app_user`
--
ALTER TABLE `app_user`
  ADD CONSTRAINT `app_user_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `app_department` (`dep_id`);
