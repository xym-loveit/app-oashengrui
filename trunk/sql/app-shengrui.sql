-- phpMyAdmin SQL Dump
-- version 3.4.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 05 月 25 日 09:00
-- 服务器版本: 5.5.17
-- PHP 版本: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `app-shengrui`
--

-- --------------------------------------------------------

--
-- 表的结构 `oa_app_function`
--

CREATE TABLE IF NOT EXISTS `oa_app_function` (
  `func_id` int(11) NOT NULL AUTO_INCREMENT,
  `func_key` varchar(60) NOT NULL COMMENT '功能key',
  `func_name` varchar(120) NOT NULL COMMENT '功能名称',
  PRIMARY KEY (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `oa_app_function_url`
--

CREATE TABLE IF NOT EXISTS `oa_app_function_url` (
  `url_id` int(11) NOT NULL AUTO_INCREMENT,
  `func_id` int(11) NOT NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY (`url_id`),
  KEY `func_id` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `oa_app_menu`
--

CREATE TABLE IF NOT EXISTS `oa_app_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_title` varchar(50) NOT NULL COMMENT '菜单名称',
  `menu_icon` varchar(20) DEFAULT NULL COMMENT '菜单图标',
  `menu_url` varchar(100) NOT NULL COMMENT '菜单链接',
  `menu_desc` varchar(100) DEFAULT NULL COMMENT '菜单描述',
  `menu_parent` int(11) DEFAULT NULL COMMENT '父菜单',
  `menu_order` int(11) DEFAULT NULL COMMENT '菜单项顺序',
  PRIMARY KEY (`menu_id`),
  KEY `menu_parent` (`menu_parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `oa_role_app`
--

CREATE TABLE IF NOT EXISTS `oa_role_app` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` int(120) NOT NULL COMMENT '角色名称',
  `role_desc` int(150) DEFAULT NULL COMMENT '角色描述',
  `role_type` int(11) NOT NULL COMMENT '角色类型',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `oa_role_func`
--

CREATE TABLE IF NOT EXISTS `oa_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`func_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `oa_role_menu`
--

CREATE TABLE IF NOT EXISTS `oa_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `oa_sysoptions`
--

CREATE TABLE IF NOT EXISTS `oa_sysoptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_name` varchar(120) NOT NULL DEFAULT '',
  `option_value` text NOT NULL,
  `option_slug` varchar(120) NOT NULL DEFAULT '',
  `option_extra` varchar(150) DEFAULT NULL,
  `option_visible` int(11) DEFAULT '1',
  `option_ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `option_slug` (`option_slug`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30 ;

--
-- 转存表中的数据 `oa_sysoptions`
--

INSERT INTO `oa_sysoptions` (`id`, `option_name`, `option_value`, `option_slug`, `option_extra`, `option_visible`, `option_ctime`) VALUES
(1, 'optname_fax', '312312', 'contactus', NULL, 1, NULL),
(2, 'optname_email', '', 'contactus', NULL, 1, NULL),
(3, 'optname_address', 'testfeawfewa', 'contactus', NULL, 1, NULL),
(4, 'optname_website', '21321312321', 'contactus', NULL, 1, NULL),
(5, 'optname_zipcode', '12312421', 'contactus', NULL, 1, NULL),
(6, 'optname_phone', '112312', 'contactus', NULL, 1, NULL),
(7, 'optname_company', '杭州美丽实业有限公司', 'contactus', NULL, 1, NULL),
(28, 'optname_advimg', '65858ed354.png', 'adv', 'http://test', 2, '2012-05-06 22:44:20'),
(29, 'optname_advimg', 'fd32b809c8.png', 'adv', 'http://ai', 0, '2012-05-06 22:44:38');

-- --------------------------------------------------------

--
-- 表的结构 `oa_user_role`
--

CREATE TABLE IF NOT EXISTS `oa_user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色';

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
