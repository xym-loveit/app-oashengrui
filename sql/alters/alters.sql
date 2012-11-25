--
-- Added by Jeccy.Zhao on 2012-09-08
--
ALTER TABLE `app_hrm_hire_job` CHANGE `hjob_visible_districtid` `hjob_visible_districtid` VARCHAR( 120 ) NULL DEFAULT NULL COMMENT '可见范围'

--
-- Added by Jeccy.Zhao on 2012-09-09
--
ALTER TABLE `app_admin_news` CHANGE `district_visible` `district_visible` VARCHAR( 120 ) NULL DEFAULT NULL COMMENT '可见校区'

--
-- Added by Jeccy.Zhao on 2012-09-10
--
ALTER TABLE `app_admin_doc` CHANGE `doc_VisiableRange_id` `doc_VisiableRange_id` VARCHAR( 120 ) NULL DEFAULT NULL COMMENT '文档范围'

--
-- Added by Jeccy.Zhao on 2012-09-21
--
ALTER TABLE `app_function` CHANGE `menu_id` `menu_id` BIGINT( 20 ) NULL COMMENT '所属菜单'

--
-- Added by Jeccy.Zhao on 2012-10-19
--
ALTER TABLE `app_hrm_archive` CHANGE `job_id` `job_id` BIGINT( 20 ) NULL COMMENT '应聘岗位ID'
ALTER TABLE `app_hrm_employee_develop` ADD `cproc_disid` BIGINT NULL COMMENT '当前审批校区ID'

--
-- Added by Jeccy.Zhao on 2012-10-20
--
ALTER TABLE `app_finan_contract` ADD `cproc_disid` BIGINT NULL COMMENT '当前审批校区ID'
ALTER TABLE `app_finan_expense` ADD `cproc_disid` BIGINT NULL COMMENT '当前审批校区ID'
ALTER TABLE `app_finan_project` ADD `cproc_disid` BIGINT NULL COMMENT '当前审批校区ID'

--
-- Added by Jeccy.Zhao on 2012-10-26
--
ALTER TABLE `app_school_department_position` CHANGE `dep_id` `dep_id` BIGINT( 20 ) NULL DEFAULT NULL COMMENT '部门ID'

--
-- Added by Jeccy.Zhao on 2012-11-07
--
ALTER TABLE  `app_admin_news_audithistory` CHANGE  `entity_id`  `entity_id` BIGINT( 11 ) NULL;
ALTER TABLE  `app_admin_task_audithistory` CHANGE  `entity_id`  `entity_id` BIGINT( 11 ) NULL;
ALTER TABLE  `app_hrm_hire_job_audithistory` CHANGE  `entity_id`  `entity_id` BIGINT( 11 ) NULL

--
-- Added by Jeccy.Zhao on 2012-11-22
--
ALTER TABLE  `app_school_department` ADD  `del_flag` TINYINT DEFAULT 0 COMMENT  '删除标记. 1=删除,  0=未删除' AFTER  `dep_orgtype`;
ALTER TABLE  `app_school_department_position` ADD  `del_flag` TINYINT DEFAULT 0 COMMENT  '删除标记. 1=删除, 0=未删除' AFTER  `pos_roleRights`;

--
-- Added by Jeccy.Zhao on 2012-11-23
--
ALTER TABLE  `app_process_type` ADD  `type_visibility` TINYINT NULL COMMENT  '类别可见范围. null=全部, 1=总部, 2=校区' AFTER  `type_parent`


--
-- Added by Jeccy.Zhao on 2012-11-24
--
ALTER TABLE  `app_finan_expense` ADD  `cproc_userid` BIGINT NULL COMMENT  '当前审批人, 主要用于个人审批环节' AFTER  `cproc_disid`;
ALTER TABLE  `app_finan_contract` ADD  `cproc_userid` BIGINT NULL COMMENT  '当前审批人, 主要用于个人审批环节' AFTER  `cproc_disid`;
ALTER TABLE  `app_finan_project` ADD  `cproc_userid` BIGINT NULL COMMENT  '当前审批人, 主要用于个人审批环节' AFTER  `cproc_disid`;
ALTER TABLE  `app_hrm_employee_develop` ADD  `cproc_userid` BIGINT NULL COMMENT  '当前审批人, 主要用于个人审批环节' AFTER  `cproc_disid`;

--
-- Added by Jeccy.Zhao on 2012-11-25
--
ALTER TABLE  `app_user` ADD  `role_rights` TEXT NULL COMMENT  '用户拥有的权限Key串' AFTER  `del_flag`;