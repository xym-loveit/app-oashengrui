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
-- Added by Jeccy.Zhao on 2012-10-22
--

#### FIELD_ALTER
ALTER TABLE `app_hrm_employee` CHANGE `emp_no` `emp_no` VARCHAR( 64 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '员工编号',
CHANGE `dep_id` `dep_id` BIGINT( 20 ) NULL COMMENT '员工所在部门ID',
CHANGE `district_id` `district_id` BIGINT( 20 ) NULL COMMENT '员工所在校区ID',
CHANGE `emp_name` `emp_name` VARCHAR( 64 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '员工姓名';

#### INSERT EMPLOYEE-ACCOUNT FOR ADMIN
INSERT INTO `app_sroa`.`app_hrm_employee` (
`emp_id` ,
`emp_no` ,
`dep_id` ,
`district_id` ,
`emp_name` ,
`position_id` ,
`birthdate` ,
`phone_no` ,
`short_no` ,
`office_phone` ,
`urgency_contacts` ,
`positive_due_date` ,
`contract_end_date` ,
`onboard_status` ,
`teacher_star` ,
`consult_star` ,
`teach_class` ,
`teach_subject` ,
`resume_id` ,
`status` ,
`onboard_date` ,
`entry_id` ,
`entry_datetime` ,
`bankNo`
)
VALUES (
'1', NULL , NULL , NULL , '管理员', NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL
);

#### ADMIN_ACCOUNT_UPDATES
UPDATE `app_sroa`.`app_user` SET 
`emp_id` = 1, 
`dep_id` = NULL ,
`pos_id` = NULL ,
`district_id` = NULL WHERE `app_user`.`user_id` =1;
