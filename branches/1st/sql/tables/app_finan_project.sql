-- phpMyAdmin SQL Dump
-- version 3.4.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 09 月 05 日 13:33
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
-- 表的结构 `app_finan_project`
--

CREATE TABLE IF NOT EXISTS `app_finan_project` (
  `project_id` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `attach_count` varchar(120) DEFAULT NULL COMMENT '附件张数',
  `supplier_name` varchar(120) DEFAULT NULL COMMENT '供应商姓名',
  `supplier_contact` varchar(120) DEFAULT NULL COMMENT '供应商联系方式',
  `pay_method` varchar(150) DEFAULT NULL COMMENT '付款方式',
  `bank` varchar(50) DEFAULT NULL COMMENT '开户银行',
  `account_name` varchar(50) DEFAULT NULL COMMENT '账户名',
  `account_no` varchar(50) DEFAULT NULL COMMENT '账号',
  `audit_state` tinyint(4) DEFAULT NULL COMMENT '审核状态, 1=审核中, 2=审核通过 3=审核不通过, 4=审核被退回...',
  `entry_id` bigint(20) NOT NULL COMMENT '录入人员',
  `entry_datetime` datetime NOT NULL COMMENT '录入时间',
  `cproc_depid` bigint(20) DEFAULT NULL COMMENT '当前审批环节部门ID',
  `cproc_posid` bigint(20) DEFAULT NULL COMMENT '当前审批岗位ID',
  PRIMARY KEY (`project_id`),
  KEY `apply_form_no` (`apply_form_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='新项目支出申请' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_finan_project`
--

INSERT INTO `app_finan_project` (`project_id`, `apply_form_no`, `apply_form_type`, `emp_id`, `emp_district`, `emp_dep`, `emp_phone_no`, `apply_date`, `comments`, `apply_amt`, `project_catalog`, `project_owner`, `attach_count`, `supplier_name`, `supplier_contact`, `pay_method`, `bank`, `account_name`, `account_no`, `audit_state`, `entry_id`, `entry_datetime`, `cproc_depid`, `cproc_posid`) VALUES
(4, 'FC20120823131534', 8, 19, 1, 15, '13575747066', '2012-08-23', '', 100, '', 0, NULL, '123', '123123123', '', NULL, NULL, NULL, NULL, 1, '2012-08-23 13:15:34', NULL, NULL),
(5, 'FP20120905125951', 16, 19, 1, 15, '13575747066', '2012-09-13', '3434', 255, '122152', 21, '5', '14123412', '421412412421421', '0', '', '', '', NULL, 1, '2012-09-05 12:59:51', 15, 26);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
