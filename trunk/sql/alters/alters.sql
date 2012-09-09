--
-- Added by Jeccy.Zhao on 2012-09-08
--
ALTER TABLE `app_hrm_hire_job` CHANGE `hjob_visible_districtid` `hjob_visible_districtid` VARCHAR( 120 ) NULL DEFAULT NULL COMMENT '可见范围'

--
-- Added by Jeccy.Zhao on 2012-09-09
--
ALTER TABLE `app_admin_news` CHANGE `district_visible` `district_visible` VARCHAR( 120 ) NULL DEFAULT NULL COMMENT '可见校区'