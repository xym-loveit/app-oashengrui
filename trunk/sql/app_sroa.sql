-- phpMyAdmin SQL Dump
-- version 3.4.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 05 月 28 日 23:47
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
-- 表的结构 `app_department`
--

CREATE TABLE IF NOT EXISTS `app_department` (
  `dep_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(128) NOT NULL COMMENT '部门名称',
  `dep_desc` varchar(256) DEFAULT NULL COMMENT '部门描述',
  `dep_level` int(11) NOT NULL COMMENT '层次',
  `parent_id` bigint(20) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL COMMENT '路径',
  `phone` varchar(64) DEFAULT NULL,
  `fax` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `app_department`
--

INSERT INTO `app_department` (`dep_id`, `dep_name`, `dep_desc`, `dep_level`, `parent_id`, `path`, `phone`, `fax`) VALUES
(1, '信息部门', '维护系统', 2, 0, '0.1.', NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_dictionary`
--

CREATE TABLE IF NOT EXISTS `app_dictionary` (
  `dic_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(64) NOT NULL,
  `item_value` varchar(128) NOT NULL,
  `item_desc` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`dic_id`)
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
  `ext` varchar(32) DEFAULT NULL COMMENT '扩展名',
  `file_type` varchar(32) NOT NULL COMMENT '附件类型            如：邮件附件',
  `note` varchar(1024) DEFAULT NULL COMMENT '说明',
  `creator` varchar(32) NOT NULL COMMENT '上传者',
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
  PRIMARY KEY (`func_id`),
  UNIQUE KEY `func_key` (`func_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='功能表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_function_url`
--

CREATE TABLE IF NOT EXISTS `app_function_url` (
  `url_id` int(11) NOT NULL AUTO_INCREMENT,
  `func_id` int(11) NOT NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY (`url_id`),
  KEY `FK_FU_R_AFN` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='功能URL' AUTO_INCREMENT=1 ;

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
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_title` varchar(50) NOT NULL COMMENT '菜单名称',
  `menu_icon` varchar(20) DEFAULT NULL COMMENT '菜单图标',
  `menu_url` varchar(100) NOT NULL COMMENT '菜单链接',
  `menu_desc` varchar(100) DEFAULT NULL COMMENT '菜单描述',
  `menu_parent` int(11) DEFAULT NULL COMMENT '父菜单',
  `menu_order` int(11) DEFAULT NULL COMMENT '菜单项顺序',
  PRIMARY KEY (`menu_id`),
  KEY `menu_parent` (`menu_parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单' AUTO_INCREMENT=1 ;

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
-- 表的结构 `app_process_type`
--

CREATE TABLE IF NOT EXISTS `app_process_type` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(128) NOT NULL COMMENT '流程分类名',
  `parent_id` bigint(20) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程分类' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `app_role`
--

CREATE TABLE IF NOT EXISTS `app_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` int(120) NOT NULL COMMENT '角色名称',
  `role_desc` int(150) DEFAULT NULL COMMENT '角色描述',
  `role_status` smallint(11) NOT NULL COMMENT '角色状态',
  `role_rights` text COMMENT '权限功能列表',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表' AUTO_INCREMENT=1 ;

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

-- --------------------------------------------------------

--
-- 表的结构 `app_role_menu`
--

CREATE TABLE IF NOT EXISTS `app_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单';

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
  `user_name` int(11) NOT NULL COMMENT '用户名',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统日志' AUTO_INCREMENT=1 ;

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
  `accession_time` datetime NOT NULL COMMENT '入职时间',
  `status` smallint(6) NOT NULL COMMENT '状态\r\n            1=激活\r\n            0=禁用\r\n            2=离职\r\n            ',
  `education` varchar(64) DEFAULT NULL,
  `fullname` varchar(50) NOT NULL,
  `delFlag` smallint(6) NOT NULL COMMENT '0=未删除\r\n            1=删除',
  PRIMARY KEY (`user_id`),
  KEY `FK_AU_R_DPT` (`dep_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `app_user`
--

INSERT INTO `app_user` (`user_id`, `username`, `title`, `password`, `email`, `dep_id`, `position`, `phone`, `mobile`, `fax`, `address`, `zip`, `photo`, `accession_time`, `status`, `education`, `fullname`, `delFlag`) VALUES
(-1, 'system', 1, '0', '152@163.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2009-12-18 00:00:00', 0, NULL, '系统', 1),
(1, 'admin', 1, 'a4ayc/80/OGda4BO/1o/V0etpOqiLx1JwB5S3beHW0s=', 'csx@jee-soft.cn', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2009-12-18 00:00:00', 1, NULL, '超级管理员', 0),
(2, 'csx', 1, '9uCh4qxBlFqap/+KiqoM68EqO8yYGpKa1c+BCgkOEa4=', '111@hotmail.com', 1, '', '', '', '', '', '', '', '2010-05-03 00:00:00', 1, NULL, 'cwx', 0);

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
  ADD CONSTRAINT `app_role_func_ibfk_2` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`),
  ADD CONSTRAINT `app_role_func_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`);

--
-- 限制表 `app_user`
--
ALTER TABLE `app_user`
  ADD CONSTRAINT `app_user_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `app_department` (`dep_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
