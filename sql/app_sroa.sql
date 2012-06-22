/*
MySQL Data Transfer
Source Host: localhost
Source Database: app_sroa
Target Host: localhost
Target Database: app_sroa
Date: 6/22/2012 10:43:04 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for app_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `app_dictionary`;
CREATE TABLE `app_dictionary` (
  `dic_id` bigint(20) NOT NULL auto_increment,
  `item_name` varchar(64) NOT NULL COMMENT '字典名称',
  `item_value` varchar(128) NOT NULL COMMENT '字典值',
  `item_desc` varchar(256) default NULL COMMENT '字典描述',
  `sn` int(11) default NULL COMMENT '序号',
  `global_type` bigint(20) NOT NULL COMMENT '字典所属类型',
  PRIMARY KEY  (`dic_id`),
  KEY `global_type` (`global_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典';

-- ----------------------------
-- Table structure for app_file_attach
-- ----------------------------
DROP TABLE IF EXISTS `app_file_attach`;
CREATE TABLE `app_file_attach` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件';

-- ----------------------------
-- Table structure for app_function
-- ----------------------------
DROP TABLE IF EXISTS `app_function`;
CREATE TABLE `app_function` (
  `func_id` int(11) NOT NULL auto_increment,
  `func_key` varchar(60) NOT NULL COMMENT '功能key',
  `func_name` varchar(120) NOT NULL COMMENT '功能名称',
  `func_icon` varchar(32) default NULL COMMENT '功能显示图片',
  `func_desc` varchar(150) default NULL COMMENT '功能描述',
  `menu_id` bigint(20) NOT NULL COMMENT '所属菜单',
  PRIMARY KEY  (`func_id`),
  UNIQUE KEY `func_key` (`func_key`),
  KEY `menu_id` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='功能表';

-- ----------------------------
-- Table structure for app_function_url
-- ----------------------------
DROP TABLE IF EXISTS `app_function_url`;
CREATE TABLE `app_function_url` (
  `url_id` int(11) NOT NULL auto_increment,
  `func_id` int(11) NOT NULL,
  `url_path` varchar(120) NOT NULL COMMENT '功能链接',
  PRIMARY KEY  (`url_id`),
  KEY `func_id` (`func_id`),
  CONSTRAINT `app_function_url_ibfk_1` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='功能URL';

-- ----------------------------
-- Table structure for app_global_type
-- ----------------------------
DROP TABLE IF EXISTS `app_global_type`;
CREATE TABLE `app_global_type` (
  `protype_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '名称',
  `type_path` varchar(64) default NULL COMMENT '路径',
  `type_depth` int(11) NOT NULL COMMENT '层次',
  `type_parent` bigint(20) default NULL COMMENT '父节点',
  `type_nodekey` varchar(64) NOT NULL COMMENT '节点的分类Key',
  `type_catkey` varchar(64) NOT NULL COMMENT '节点分类的Key，如产品分类Key为PT',
  `type_sn` int(11) NOT NULL COMMENT '序号',
  PRIMARY KEY  (`protype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总分类表  用于显示树层次结构的分类 可以允许任何层次结构';

-- ----------------------------
-- Table structure for app_hrm_archive
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_archive`;
CREATE TABLE `app_hrm_archive` (
  `archive_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `job_id` bigint(20) NOT NULL COMMENT '应聘岗位ID',
  `archive_source` tinyint(4) NOT NULL COMMENT '来源',
  `archive_star` tinyint(4) NOT NULL COMMENT '评定星级',
  PRIMARY KEY  (`archive_id`),
  KEY `job_id` (`job_id`),
  KEY `resume_id` (`resume_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='公司人才库';

-- ----------------------------
-- Table structure for app_hrm_employee
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_employee`;
CREATE TABLE `app_hrm_employee` (
  `emp_id` bigint(20) NOT NULL auto_increment,
  `emp_no` varchar(64) NOT NULL COMMENT '员工编号',
  `dep_id` bigint(20) NOT NULL COMMENT '员工所在部门ID',
  `district_id` bigint(20) NOT NULL COMMENT '员工所在校区ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `position_id` bigint(20) default NULL COMMENT '岗位',
  `birthdate` date default NULL COMMENT '出生日期',
  `phone_no` varchar(64) default NULL COMMENT '电话',
  `short_no` varchar(64) default NULL COMMENT '短号',
  `positive_due_date` date default NULL COMMENT '待转正日期',
  `contract_end_date` date default NULL COMMENT '合同到期日期',
  `onboard_status` bigint(20) default NULL COMMENT '在职状态',
  `teacher_star` bigint(20) default NULL,
  `consult_star` bigint(20) default NULL,
  `teach_class` varchar(120) default NULL,
  `teach_subject` varchar(120) default NULL,
  `resume_id` bigint(20) default NULL COMMENT '简历',
  `status` char(1) default NULL COMMENT '员工状态',
  `entry_id` bigint(20) default NULL COMMENT '录入人员',
  `entry_datetime` datetime default NULL COMMENT '录入日期',
  PRIMARY KEY  (`emp_id`),
  UNIQUE KEY `emp_no` (`emp_no`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='员工档案表';

-- ----------------------------
-- Table structure for app_hrm_employee_develop
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_employee_develop`;
CREATE TABLE `app_hrm_employee_develop` (
  `develop_id` bigint(20) default NULL,
  `apply_form_no` varchar(120) default NULL COMMENT '人资审批流程',
  `apply_form_type` bigint(20) default NULL,
  `apply_date` date default NULL,
  `comments` longtext,
  `emp_id` bigint(20) default NULL COMMENT '员工ID',
  `from_district` bigint(20) default NULL,
  `from_dep` bigint(20) default NULL,
  `from_position` bigint(20) default NULL,
  `status` char(1) default NULL,
  `audit_state` bigint(20) default NULL,
  `entry_id` bigint(20) default NULL,
  `entry_datetime` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for app_hrm_employee_profile
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_employee_profile`;
CREATE TABLE `app_hrm_employee_profile` (
  `profile_id` bigint(20) NOT NULL auto_increment,
  `emp_id` bigint(20) NOT NULL COMMENT '员工ID',
  `emp_name` varchar(64) NOT NULL COMMENT '员工姓名',
  `status` tinyint(4) NOT NULL COMMENT '员工状态',
  PRIMARY KEY  (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工基本信息表';

-- ----------------------------
-- Table structure for app_hrm_employee_roadmap
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_employee_roadmap`;
CREATE TABLE `app_hrm_employee_roadmap` (
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='员工历程';

-- ----------------------------
-- Table structure for app_hrm_hire_entries
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_entries`;
CREATE TABLE `app_hrm_hire_entries` (
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='员工入职安排表';

-- ----------------------------
-- Table structure for app_hrm_hire_interviews
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_interviews`;
CREATE TABLE `app_hrm_hire_interviews` (
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='招聘面试';

-- ----------------------------
-- Table structure for app_hrm_hire_interviews_file
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_interviews_file`;
CREATE TABLE `app_hrm_hire_interviews_file` (
  `interview_id` bigint(20) NOT NULL COMMENT '面试ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY  (`interview_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='面试附件';

-- ----------------------------
-- Table structure for app_hrm_hire_issue
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_issue`;
CREATE TABLE `app_hrm_hire_issue` (
  `hissue_id` bigint(20) NOT NULL auto_increment,
  `resume_id` bigint(20) NOT NULL COMMENT '简历ID',
  `hjob_id` bigint(20) NOT NULL COMMENT '应聘职位ID',
  `current_status` tinyint(4) NOT NULL COMMENT '当前状态',
  `final_result` tinyint(4) default NULL COMMENT '最终处理结果',
  `user_id` bigint(20) default NULL COMMENT '应聘者ID, 主要用于存员工申请 (包含自我申请, 推荐他人)',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY  (`hissue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='当前招聘';

-- ----------------------------
-- Table structure for app_hrm_hire_job
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_hire_job`;
CREATE TABLE `app_hrm_hire_job` (
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='招聘岗位发布';

-- ----------------------------
-- Table structure for app_hrm_resume
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_resume`;
CREATE TABLE `app_hrm_resume` (
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='简历管理';

-- ----------------------------
-- Table structure for app_hrm_resume_file
-- ----------------------------
DROP TABLE IF EXISTS `app_hrm_resume_file`;
CREATE TABLE `app_hrm_resume_file` (
  `file_id` bigint(20) NOT NULL,
  `resum_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`file_id`,`resum_id`),
  CONSTRAINT `app_hrm_resume_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `app_file_attach` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简历附件';

-- ----------------------------
-- Table structure for app_menu
-- ----------------------------
DROP TABLE IF EXISTS `app_menu`;
CREATE TABLE `app_menu` (
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='系统菜单';

-- ----------------------------
-- Table structure for app_news
-- ----------------------------
DROP TABLE IF EXISTS `app_news`;
CREATE TABLE `app_news` (
  `news_id` bigint(20) NOT NULL auto_increment,
  `type_id` bigint(20) NOT NULL COMMENT '新闻类型id',
  `news_subject` varchar(128) NOT NULL COMMENT '新闻标题',
  `news_content` text NOT NULL,
  `news_author` varchar(32) NOT NULL COMMENT '新闻作者',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '最后更新时间',
  `status` smallint(6) NOT NULL COMMENT '            0=待审核            1=审核通过',
  PRIMARY KEY  (`news_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `app_news_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_news_type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻';

-- ----------------------------
-- Table structure for app_news_type
-- ----------------------------
DROP TABLE IF EXISTS `app_news_type`;
CREATE TABLE `app_news_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` int(11) NOT NULL COMMENT '新闻类型',
  `sn` int(11) NOT NULL,
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻类型';

-- ----------------------------
-- Table structure for app_process_definition
-- ----------------------------
DROP TABLE IF EXISTS `app_process_definition`;
CREATE TABLE `app_process_definition` (
  `def_id` bigint(20) NOT NULL auto_increment,
  `type_id` bigint(20) NOT NULL COMMENT '流程分类ID',
  `def_name` varchar(256) NOT NULL COMMENT '流程名称',
  `def_description` varchar(1024) NOT NULL COMMENT '流程描述',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY  (`def_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `app_process_definition_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `app_process_type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程定义';

-- ----------------------------
-- Table structure for app_process_form
-- ----------------------------
DROP TABLE IF EXISTS `app_process_form`;
CREATE TABLE `app_process_form` (
  `form_id` bigint(20) NOT NULL auto_increment,
  `form_no` varchar(120) NOT NULL COMMENT '流程申请单号',
  `type_id` bigint(20) NOT NULL COMMENT '流程类型',
  `task_name` varchar(128) NOT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) default NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) default NULL COMMENT '跳转节点, 跳转至下一任务',
  `seq_sn` int(11) NOT NULL COMMENT '序列编号',
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
  PRIMARY KEY  (`form_id`),
  KEY `form_no` (`form_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据';

-- ----------------------------
-- Table structure for app_process_history
-- ----------------------------
DROP TABLE IF EXISTS `app_process_history`;
CREATE TABLE `app_process_history` (
  `history_id` bigint(20) NOT NULL auto_increment,
  `form_no` varchar(120) NOT NULL COMMENT '流程申请单号',
  `type_id` bigint(20) NOT NULL COMMENT '流程类型',
  `task_name` varchar(128) NOT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) default NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) default NULL COMMENT '跳转节点, 跳转至下一任务',
  `seq_sn` int(11) NOT NULL COMMENT '序列编号',
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='流程表单, 存储保存在运行中的流程表单数据';

-- ----------------------------
-- Table structure for app_process_task
-- ----------------------------
DROP TABLE IF EXISTS `app_process_task`;
CREATE TABLE `app_process_task` (
  `task_id` bigint(20) NOT NULL auto_increment,
  `def_id` bigint(20) NOT NULL COMMENT '所属流程定义ID',
  `task_name` varchar(128) NOT NULL COMMENT '活动或任务名称',
  `task_from` varchar(64) default NULL COMMENT '该任务来自由哪一任务跳转过来，目的是为了查到该任务的上一任务，方便任务驳回',
  `task_next` varchar(64) default NULL COMMENT '跳转节点, 跳转至下一任务',
  `seq_sn` int(11) NOT NULL COMMENT '序列编号',
  `to_rolenames` varchar(250) default NULL,
  `to_depnames` varchar(250) default NULL,
  `to_posnames` varchar(250) default NULL COMMENT '部门名称集合',
  `to_usernames` varchar(250) default NULL,
  `to_userids` varchar(250) default NULL COMMENT '用户IDS 格式如下，以方便使用like操作 ,1,2,',
  `to_roleids` varchar(250) default NULL COMMENT '角色IDS 格式如下，以方便使用like操作 ,1,2,',
  `to_depids` varchar(250) default NULL COMMENT '部门IDS 格式如下，以方便使用like操作 ,1,2,',
  `to_posids` varchar(250) default NULL COMMENT '岗位ID集合, 易于操作',
  `comments` text COMMENT '意见',
  PRIMARY KEY  (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程任务设置';

-- ----------------------------
-- Table structure for app_process_type
-- ----------------------------
DROP TABLE IF EXISTS `app_process_type`;
CREATE TABLE `app_process_type` (
  `type_id` bigint(20) NOT NULL auto_increment,
  `type_name` varchar(128) NOT NULL COMMENT '流程分类名',
  `type_key` varchar(64) default NULL COMMENT '流程分类KEY',
  `type_desc` varchar(250) default NULL COMMENT '流程分类描述',
  `type_slug` varchar(64) NOT NULL COMMENT '分类类别',
  `type_parent` bigint(20) default NULL COMMENT '流程父分类',
  PRIMARY KEY  (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='流程分类';

-- ----------------------------
-- Table structure for app_role
-- ----------------------------
DROP TABLE IF EXISTS `app_role`;
CREATE TABLE `app_role` (
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for app_role_func
-- ----------------------------
DROP TABLE IF EXISTS `app_role_func`;
CREATE TABLE `app_role_func` (
  `role_id` int(11) NOT NULL,
  `func_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`func_id`),
  KEY `role_id` (`role_id`),
  KEY `app_role_func_ibfk_2` (`func_id`),
  CONSTRAINT `app_role_func_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`),
  CONSTRAINT `app_role_func_ibfk_2` FOREIGN KEY (`func_id`) REFERENCES `app_function` (`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

-- ----------------------------
-- Table structure for app_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `app_role_menu`;
CREATE TABLE `app_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单';

-- ----------------------------
-- Table structure for app_school_department
-- ----------------------------
DROP TABLE IF EXISTS `app_school_department`;
CREATE TABLE `app_school_department` (
  `dep_id` bigint(20) NOT NULL auto_increment,
  `dep_no` varchar(32) NOT NULL COMMENT '部门编号',
  `dep_name` varchar(128) NOT NULL COMMENT '部门名称',
  `dep_desc` varchar(256) default NULL COMMENT '部门描述',
  `dep_eqlevel` tinyint(4) default '-1' COMMENT '对口级别, -1=无, 0=总部, 1=校区, 2=片区',
  `dep_eqid` bigint(20) default NULL COMMENT '对口部门',
  `dep_orgtype` tinyint(4) NOT NULL COMMENT '部门结构类型 0=总部, 1=校区, 2=片区',
  PRIMARY KEY  (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='学校部门设置';

-- ----------------------------
-- Table structure for app_school_department_position
-- ----------------------------
DROP TABLE IF EXISTS `app_school_department_position`;
CREATE TABLE `app_school_department_position` (
  `pos_id` bigint(20) NOT NULL auto_increment,
  `pos_name` varchar(150) NOT NULL COMMENT '岗位名称',
  `pos_desc` varchar(250) default NULL COMMENT '岗位描述',
  `pos_leadership` tinyint(4) default '1' COMMENT '是否领导, 0=是, 1=不是',
  `dep_id` bigint(20) NOT NULL COMMENT '部门ID',
  `pos_roleRights` varchar(500) default NULL COMMENT '岗位角色权限',
  PRIMARY KEY  (`pos_id`),
  KEY `dep_id` (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='部门岗位';

-- ----------------------------
-- Table structure for app_school_department_position_role
-- ----------------------------
DROP TABLE IF EXISTS `app_school_department_position_role`;
CREATE TABLE `app_school_department_position_role` (
  `pos_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY  (`pos_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门岗位权限';

-- ----------------------------
-- Table structure for app_school_district
-- ----------------------------
DROP TABLE IF EXISTS `app_school_district`;
CREATE TABLE `app_school_district` (
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='校区设置';

-- ----------------------------
-- Table structure for app_system_config
-- ----------------------------
DROP TABLE IF EXISTS `app_system_config`;
CREATE TABLE `app_system_config` (
  `config_id` bigint(20) NOT NULL auto_increment,
  `config_key` varchar(64) NOT NULL COMMENT 'Key',
  `config_name` varchar(64) NOT NULL COMMENT '配置名称',
  `config_desc` varchar(256) default NULL COMMENT '配置描述',
  `type_name` varchar(32) NOT NULL COMMENT '所属分类名称',
  `data_type` smallint(6) NOT NULL COMMENT '数据类型            1=varchar            2=intger            3=decimal            4=datetime            5=time            ',
  `data_value` varchar(64) default NULL COMMENT '数据值',
  PRIMARY KEY  (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置,用于系统的全局配置';

-- ----------------------------
-- Table structure for app_system_log
-- ----------------------------
DROP TABLE IF EXISTS `app_system_log`;
CREATE TABLE `app_system_log` (
  `log_id` bigint(20) NOT NULL auto_increment,
  `user_name` varchar(120) NOT NULL COMMENT '用户名',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `operation` varchar(512) NOT NULL COMMENT '执行操作',
  PRIMARY KEY  (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Table structure for app_user
-- ----------------------------
DROP TABLE IF EXISTS `app_user`;
CREATE TABLE `app_user` (
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='app_user\r\n用户表';

-- ----------------------------
-- Table structure for app_user_role
-- ----------------------------
DROP TABLE IF EXISTS `app_user_role`;
CREATE TABLE `app_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限表';

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `app_function` VALUES ('1', '_FUNCKEY_myplan_edit', '编辑任务', 'icon-btnedit', '', '4');
INSERT INTO `app_function` VALUES ('2', '_FUNCKEY_myplan_del', '删除任务', 'icon-btndel', '', '4');
INSERT INTO `app_function_url` VALUES ('3', '1', 'aefew');
INSERT INTO `app_function_url` VALUES ('4', '2', 'sdewr');
INSERT INTO `app_hrm_archive` VALUES ('1', '7', '2', '2', '3');
INSERT INTO `app_hrm_archive` VALUES ('2', '8', '2', '5', '2');
INSERT INTO `app_hrm_archive` VALUES ('3', '9', '2', '2', '1');
INSERT INTO `app_hrm_employee` VALUES ('3', '0001012061241011', '9', '3', 'Manie', '1', null, '13588064354', null, null, null, '1', '3', '4', 'A,A1,A3,A5,B1,B3', 'A,A1,A3,B,B2,B6,C7,C8', '16', null, '1', '2012-06-12 16:10:11');
INSERT INTO `app_hrm_employee` VALUES ('4', '0001112061243222', '12', '3', 'Charotte', '2', null, '13588064354', null, null, null, '1', '1', '1', '', 'A2,B2', '18', null, '1', '2012-06-12 16:32:22');
INSERT INTO `app_hrm_employee` VALUES ('5', '0001012061244839', '9', '3', 'Chonticha', '1', null, '13588064354', null, null, null, '2', null, null, null, null, '19', null, '1', '2012-06-12 16:48:39');
INSERT INTO `app_hrm_employee_develop` VALUES ('1', '1', '1', '2012-06-19', '1weqeqw', '3', '1', '11', '1', 'Y', '1', '1', null);
INSERT INTO `app_hrm_employee_roadmap` VALUES ('1', '3', '9', '3', '1', null, null, null, '1', '2012-06-12 16:10:11');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('2', '4', '12', '3', '2', null, null, null, '1', '2012-06-12 16:32:22');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('3', '5', '9', '3', '1', null, null, null, '1', '2012-06-12 16:48:39');
INSERT INTO `app_hrm_employee_roadmap` VALUES ('4', '5', '9', '3', '1', null, null, null, '2', '2012-06-12 16:48:52');
INSERT INTO `app_hrm_hire_entries` VALUES ('1', '8', '3', '9', '1', '2', '2012-06-10 10:00:00', '2012-06-13 05:35:29', '2', '2', '2');
INSERT INTO `app_hrm_hire_entries` VALUES ('5', '16', '3', '9', '1', '1', '2012-06-15 00:00:00', '2012-06-12 16:10:02', '0', '2', '1');
INSERT INTO `app_hrm_hire_entries` VALUES ('6', '17', '3', '9', '1', '1', '2012-06-15 15:12:51', '2012-06-14 16:05:51', '0', '2', '1');
INSERT INTO `app_hrm_hire_entries` VALUES ('7', '18', '3', '12', '2', '1', '2012-06-15 16:31:47', '2012-06-12 16:32:07', '1', '2', '1');
INSERT INTO `app_hrm_hire_entries` VALUES ('8', '19', '3', '9', '1', '1', '2012-06-13 00:00:00', '2012-06-15 00:00:00', '1', '2', '1');
INSERT INTO `app_hrm_hire_interviews` VALUES ('5', '6', '杭州总部', '2012-06-13 14:34:56', '1', '', '1', '2', '建议通过...');
INSERT INTO `app_hrm_hire_interviews` VALUES ('6', '7', '杭州总部', '2012-06-20 15:34:57', '2', '', '1', '3', null);
INSERT INTO `app_hrm_hire_interviews` VALUES ('7', '8', '杭州总部', '2012-06-13 14:34:56', '2', '', '1', '0', null);
INSERT INTO `app_hrm_hire_interviews` VALUES ('8', '9', '杭州总部', '2012-06-15 23:32:04', '1', '', '1', '3', '不合适...');
INSERT INTO `app_hrm_hire_interviews` VALUES ('9', '9', '杭州总部', '2012-06-21 23:35:07', '1', '', '2', '4', '这人坚决不要, 信用度太低啊..');
INSERT INTO `app_hrm_hire_interviews` VALUES ('10', '9', '杭州总部', '2012-06-13 00:00:00', '1', '', '3', '3', '烦不烦啊... ');
INSERT INTO `app_hrm_hire_interviews` VALUES ('11', '10', '杭州电子科技大学', '2012-06-28 23:42:19', '1', '', '1', '2', '');
INSERT INTO `app_hrm_hire_interviews` VALUES ('12', '10', '杭州电子科技大学', '2012-06-07 00:00:00', '1', '', '2', '3', '');
INSERT INTO `app_hrm_hire_interviews` VALUES ('13', '11', '萧山校区', '2012-06-15 15:00:00', '1', '', '1', '2', '表现很优异啊, 建议直接录取...');
INSERT INTO `app_hrm_hire_issue` VALUES ('6', '6', '2', '3', null, null, '2012-06-10 14:34:39');
INSERT INTO `app_hrm_hire_issue` VALUES ('7', '7', '2', '4', '2', null, '2012-06-10 15:34:45');
INSERT INTO `app_hrm_hire_issue` VALUES ('8', '8', '2', '4', '1', null, '2012-06-10 22:51:23');
INSERT INTO `app_hrm_hire_issue` VALUES ('9', '9', '2', '4', '2', null, '2012-06-11 23:31:55');
INSERT INTO `app_hrm_hire_issue` VALUES ('10', '10', '2', '0', null, null, '2012-06-11 23:42:01');
INSERT INTO `app_hrm_hire_issue` VALUES ('11', '11', '2', '4', '1', null, '2012-06-12 13:45:20');
INSERT INTO `app_hrm_hire_issue` VALUES ('12', '12', '2', '4', '1', '1', '2012-06-12 13:50:57');
INSERT INTO `app_hrm_hire_issue` VALUES ('13', '13', '2', '4', '1', '1', '2012-06-12 14:13:17');
INSERT INTO `app_hrm_hire_issue` VALUES ('14', '14', '2', '4', '1', '1', '2012-06-12 14:15:06');
INSERT INTO `app_hrm_hire_issue` VALUES ('15', '15', '2', '4', '1', '1', '2012-06-12 14:16:21');
INSERT INTO `app_hrm_hire_issue` VALUES ('16', '16', '2', '4', '1', '1', '2012-06-12 14:19:51');
INSERT INTO `app_hrm_hire_issue` VALUES ('17', '17', '2', '4', '1', '1', '2012-06-12 14:36:15');
INSERT INTO `app_hrm_hire_issue` VALUES ('18', '18', '2', '4', '1', '1', '2012-06-12 16:31:21');
INSERT INTO `app_hrm_hire_issue` VALUES ('19', '19', '2', '4', '1', '1', '2012-06-12 16:48:04');
INSERT INTO `app_hrm_hire_job` VALUES ('1', '技术总监', '3', '1', '2', null, '2012-06-18 00:00:00', '1', '', '杭州', 'test', '', null, null, null, null, null, null, null, '0', null, null);
INSERT INTO `app_hrm_hire_job` VALUES ('2', '产品经理', '1', '7', '1', null, '2012-06-19 00:00:00', '5', '', '杭州电子科技大学', '', '', null, null, null, null, '卡卡西', null, '2012-06-09 12:34:23', '1', null, '1');
INSERT INTO `app_hrm_hire_job` VALUES ('3', 'test', '3', '12', '1', null, '2012-06-15 00:00:00', '21', '', '', '', '', '卡卡西', '2012-06-13 16:39:34', null, null, null, null, null, '4', null, null);
INSERT INTO `app_hrm_resume` VALUES ('6', null, '佐助', null, null, '火影村', '1', null, '1', null, '13588064354', '火影@163.com', null, null, '1', null, null, '非人类', '', '1', '', '1', '1', null, '362412312412', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('7', null, '大和', null, null, '', '1', null, '1', null, '13512456013', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('8', null, '鸣人', null, null, '', '1', null, '1', null, '13512456013', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('9', null, '大和2', null, null, '', '1', null, '1', null, '13512456013', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('10', null, '品冠', null, null, '', '1', null, '1', null, '13845671203', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('11', null, 'Vincent', null, null, '', '2', null, '1', null, '13512456013', '', null, null, '2', null, null, '', '', '2', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '4', '6', '2');
INSERT INTO `app_hrm_resume` VALUES ('12', null, 'Jeth', null, null, '', '1', null, '1', null, '0608943125232', '', null, null, '1', null, null, '菲律宾', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '2');
INSERT INTO `app_hrm_resume` VALUES ('13', null, 'Gino.P', null, null, '', '1', null, '1', null, '0608943125232', '', null, null, '1', null, null, '菲律宾', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('14', null, 'Gino.M', null, null, '', '1', null, '1', null, '0608943125232', '', null, null, '1', null, null, '菲律宾', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '2');
INSERT INTO `app_hrm_resume` VALUES ('15', null, 'Xavier', null, null, '', '1', null, '1', null, '0608943125232', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('16', null, 'Manie', null, null, '', '1', null, '1', null, '13588064354', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('17', null, 'Gian', null, null, '', '1', null, '1', null, '13588064354', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('18', '4', 'Charotte', null, null, '', '1', null, '1', null, '13588064354', '', null, null, '1', null, null, '', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_hrm_resume` VALUES ('19', '5', 'Chonticha', null, null, '', '1', null, '1', null, '13588064354', '', null, null, '1', null, null, '泰国', '', '1', '', '1', '1', null, '', null, null, null, null, null, null, null, null, '1', '1', '0');
INSERT INTO `app_menu` VALUES ('3', '我的工作区', 'icon-desktop', 'javascript:void(0);', '_menu_mod_personal', '', null, '0');
INSERT INTO `app_menu` VALUES ('4', '我的任务', 'icon-myplan', 'javascript:void(0);', '_menu_mod_personal_mytask', 'test0', '3', '0');
INSERT INTO `app_process_form` VALUES ('1', '1', '1', '1', '1', '1', '1', '1', null, '行政部', '人事主管', '1', '1', null, '11', '11', '1', '1', '1', null, '1', '1', '1', '11', null, '1', '1', '2012-06-22 21:03:28', '1', '11');
INSERT INTO `app_process_history` VALUES ('1', '1', '1', '11', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '11', '11', '11', '11', '1', '1', '1', '11', '11', '11', '1', '1', '0000-00-00 00:00:00', '1', null);
INSERT INTO `app_process_type` VALUES ('1', '费用支出申请审批', 'PROCESS_PAYMENT', null, 'finance', null);
INSERT INTO `app_process_type` VALUES ('2', '合同申请审批', 'PROCESS_CONTRACT', null, 'finance', null);
INSERT INTO `app_process_type` VALUES ('3', '转正申请审批', 'PROCESS_MEMBER_BERGULAR', null, 'hrm', null);
INSERT INTO `app_process_type` VALUES ('4', '调动申请审批', 'PROCESS_MEMBER_TRANSFER', null, 'hrm', null);
INSERT INTO `app_process_type` VALUES ('5', '晋升申请审批', 'PROCESS_MEMBER_PROMOTION', null, 'hrm', null);
INSERT INTO `app_process_type` VALUES ('6', '离职申请审批', 'PROCESS_MEMBER_FAIRWELL', null, 'hrm', null);
INSERT INTO `app_role` VALUES ('1', '超级管理员', 'ROLE_SUPER', null, '1', '__ALL', '0', '0');
INSERT INTO `app_role` VALUES ('5', '校长', 'ROLE_MASTER', 'teset', '1', '_FUNCKEY_myplan_edit', '1', '1');
INSERT INTO `app_role_func` VALUES ('5', '1');
INSERT INTO `app_role_menu` VALUES ('5', '3');
INSERT INTO `app_role_menu` VALUES ('5', '4');
INSERT INTO `app_school_department` VALUES ('7', '0', '人资部', '', '0', null, '0');
INSERT INTO `app_school_department` VALUES ('9', '0', '人资部', '', '0', null, '1');
INSERT INTO `app_school_department` VALUES ('10', '1', '总经办', '', '0', null, '0');
INSERT INTO `app_school_department` VALUES ('11', '1', '行政部', '', '0', null, '0');
INSERT INTO `app_school_department` VALUES ('12', '1', '行政部', '', '0', null, '1');
INSERT INTO `app_school_department_position` VALUES ('1', '人事主管', '', '0', '9', '');
INSERT INTO `app_school_department_position` VALUES ('2', '行政主管', '', '0', '12', '');
INSERT INTO `app_school_district` VALUES ('1', '0000', '杭州总部', '0', '', '', null);
INSERT INTO `app_school_district` VALUES ('3', '0001', '萧山校区', '1', '', '', '1');
INSERT INTO `app_system_log` VALUES ('1', 'test', '1', '2012-06-02 17:48:55', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('2', 'test', '1', '2012-06-04 18:41:12', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('3', 'test', '1', '2012-06-04 18:41:14', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('4', 'test', '1', '2012-06-04 18:41:27', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('5', 'test', '1', '2012-06-05 00:07:06', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('6', 'test', '1', '2012-06-05 01:49:47', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('7', 'test', '1', '2012-06-05 01:51:06', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('8', 'test', '1', '2012-06-05 01:51:08', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('9', 'test', '1', '2012-06-05 01:51:09', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('10', 'test', '1', '2012-06-05 01:51:20', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('11', 'test', '1', '2012-06-05 14:23:42', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('12', 'test', '1', '2012-06-05 17:22:27', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('13', 'test', '1', '2012-06-05 20:34:34', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('14', 'test', '1', '2012-06-05 20:34:39', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('15', 'test', '1', '2012-06-05 20:35:10', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('16', 'test', '1', '2012-06-05 20:37:54', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('17', 'test', '1', '2012-06-06 22:04:42', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('18', 'test', '1', '2012-06-06 22:08:14', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('19', 'test', '1', '2012-06-06 22:09:23', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('20', 'test', '1', '2012-06-07 00:01:04', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('21', 'test', '1', '2012-06-07 19:40:29', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('22', 'test', '1', '2012-06-07 21:09:28', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('23', 'test', '1', '2012-06-07 21:09:41', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('24', 'test', '1', '2012-06-07 23:05:20', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('25', 'test', '1', '2012-06-07 23:10:57', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('26', 'test', '1', '2012-06-07 23:11:14', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('27', 'test', '1', '2012-06-07 23:11:53', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('28', 'test', '1', '2012-06-07 23:12:09', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('29', 'test', '1', '2012-06-07 23:12:32', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('30', 'test', '1', '2012-06-07 23:13:31', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('31', 'test', '1', '2012-06-07 23:14:23', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('32', 'test', '1', '2012-06-07 23:14:56', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('33', 'test', '1', '2012-06-07 23:16:18', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('34', 'test', '1', '2012-06-07 23:16:52', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('35', 'test', '1', '2012-06-07 23:16:54', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('36', 'test', '1', '2012-06-08 00:06:08', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('37', 'test', '1', '2012-06-08 00:06:10', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('38', 'test', '1', '2012-06-08 00:21:08', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('39', 'test', '1', '2012-06-08 00:21:36', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('40', 'test', '1', '2012-06-08 00:21:41', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('41', 'test', '1', '2012-06-08 00:22:04', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('42', 'test', '1', '2012-06-08 01:07:23', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('43', 'test', '1', '2012-06-09 12:02:01', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('44', 'test', '1', '2012-06-10 23:37:22', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('45', 'test', '1', '2012-06-10 23:37:25', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('46', 'test', '1', '2012-06-10 23:37:28', '进入权限组配置页面');
INSERT INTO `app_system_log` VALUES ('47', 'test', '1', '2012-06-20 21:32:49', '进入权限组配置页面');
INSERT INTO `app_user` VALUES ('1', 'admin', 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=', '卡卡西', 'csx@jee-soft.cn', null, null, '1', null, null, null, null, null, null, null, '1', '127.0.0.1', '2012-06-22 22:36:48');
INSERT INTO `app_user` VALUES ('2', 'csx', '9uCh4qxBlFqap/+KiqoM68EqO8yYGpKa1c+BCgkOEa4=', '斩不刀', '111@hotmail.com', '1', null, '3', null, '', '', '', '', '', '', '0', '', null);
INSERT INTO `app_user` VALUES ('3', '0001012061241011', 'QGpDSgQ2on/ITC1MlNeed0CREM5MDxeCejn3iFEhLGk=', 'Manie', null, '9', '1', '3', '3', null, null, null, null, null, null, '1', null, null);
INSERT INTO `app_user` VALUES ('4', '0001112061243222', 'DnOH9eQngdjBAPlv4OAAtxF1BJdvw3DiTFece8c7PD8=', 'Charotte', null, '12', '2', '3', '4', null, null, null, null, null, null, '1', null, null);
INSERT INTO `app_user` VALUES ('5', '0001012061244839', '1pB+T6eAui2DtQe83R0qWFGgwWGmY5HB2cuU4vgLHl4=', 'Chonticha', null, '9', '1', '3', '5', null, null, null, null, null, null, '1', null, null);
