insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (1,'goodsStockUser','用户帐号','当库存产生警报时，接收消息的人员','行政管理配置',1,'admin','adminConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (2,'codeConfig','验证码','登录时是否需要验证码','验证码配置',2,'1','codeConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (3,'smsMobile','手机短信','流程执行时是否需要短信提醒','手机短信提醒',2,'1','smsConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (4,'deviceName','设备名称','GMS设备名称','手机短信提醒',1,'COM4','smsConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (5,'baudRate','设备波特率','设备波特率','手机短信提醒',1,'9600','smsConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (6,'suggestId','意见接收人ID','意见接收人ID','意见箱配置',1,'1','suggestConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (7,'suggestName','意见接收人','意见接收人','意见箱配置',1,'管理员','suggestConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (8,'dynamicPwd','动态密码','动态密码','动态密码配置',2,'2','dynamicPwdConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (9,'dynamicUri','验证路径','验证路径','动态密码配置',1,'http://www.yoo-e.com/cbsite/authsys/api/','dynamicPwdConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (10,'smsPortUri','端口路径','商品路径','短信端口配置',1,'http://58.63.224.34:8000/smsweb/services/sms','smsPortConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (11,'smsPortUserID','用户ID','用户ID','短信端口配置',1,'','smsPortConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (12,'smsPortAccount','用户账号','用户账号','短信端口配置',1,'','smsPortConfig');

insert into sys_config (CONFIGID, CONFIGKEY, CONFIGNAME, CONFIGDESC, TYPENAME, DATATYPE, DATAVALUE,TYPEKEY)
values (13,'smsPortPwd','用户密码','用户密码','短信端口配置',1,'','smsPortConfig');

insert into department (DEPID, DEPNAME, DEPDESC, DEPLEVEL, PARENTID, PATH, PHONE, FAX)
values (1, '信息部门', '维护系统', 2, 0, '0.1.', '', '');

INSERT INTO app_user (userId,username,password,email,depId,jobId,phone,mobile,fax,address,zip,photo,accessionTime,status,education,fullname,title,delFlag) VALUES 
 (1,'admin','a4ayc/80/OGda4BO/1o/V0etpOqiLx1JwB5S3beHW0s=','csx@jee-soft.cn',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,to_date('2009-12-18','yyyy-mm-dd'),1,NULL,'超级管理员',1,0);

INSERT INTO app_user (userId,username,password,email,depId,jobId,phone,mobile,fax,address,zip,photo,accessionTime,status,education,fullname,title,delFlag) VALUES 
 (-1,'system','0','152@163.com',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,to_date('2009-12-18','yyyy-mm-dd'),0,NULL,'系统',1,1);


insert into mail_folder (FOLDERID, USERID, FOLDERNAME, PARENTID, DEPLEVEL, PATH, ISPUBLIC, FOLDERTYPE)
values (1, null, '收件箱', 0, 1, '0.1.', 1, 1);

insert into mail_folder (FOLDERID, USERID, FOLDERNAME, PARENTID, DEPLEVEL, PATH, ISPUBLIC, FOLDERTYPE)
values (2, null, '发件箱', 0, 1, '0.2.', 1, 2);

insert into mail_folder (FOLDERID, USERID, FOLDERNAME, PARENTID, DEPLEVEL, PATH, ISPUBLIC, FOLDERTYPE)
values (3, null, '草稿箱', 0, 1, '0.3.', 1, 3);

insert into mail_folder (FOLDERID, USERID, FOLDERNAME, PARENTID, DEPLEVEL, PATH, ISPUBLIC, FOLDERTYPE)
values (4, null, '垃圾箱', 0, 1, '0.4.', 1, 4);

insert into app_role (ROLEID, ROLENAME, ROLEDESC, STATUS, RIGHTS, ISDEFAULTIN)
values (-1, '超级管理员', '超级管理员,具有所有权限', 1, '__ALL', 0);

insert into app_role (ROLEID, ROLENAME, ROLEDESC, STATUS, RIGHTS, ISDEFAULTIN)
values (1, '[人事经理]', '管理人事的经理', 1, 'SystemSetting,AppUserView,_AppUserQuery,_AppUserAdd,_AppUserEdit,_AppUserDel,DepartmentView,_DepartmentQuery,_DepartmentAdd,_DepartmentEdit,_DepartmentDel,PublicDocument,NewPublicDocumentForm,Task,NewWorkPlanForm,_NewDepPlan,Personal,PersonalDuty,SignInOffView,ErrandsRegisterView,ErrandsRegisterOutView,DutyManager,Duty,HolidayRecordView,_HolidayRecordQuery,_HolidayRecordAdd,_HolidayRecordEdit,_HolidayRecordDel,DutySectionView,_DutySectonQuery,_DutySectonAdd,_DutySectonEdit,_DutySectonDel,DutySystemView,_DutySystemQuery,_DutySystemAdd,_DutySystemEdit,_DutySystemDel,DutyView,_DutyQuery,_DutyAdd,_DutyEdit,_DutyDel,DutyRegisterView,_DutyRegisterQuery,_DutyRegisterAdd,_DutyRegisterDel', 0);

insert into app_role (ROLEID, ROLENAME, ROLEDESC, STATUS, RIGHTS, ISDEFAULTIN)
values (2, '[行政经理]', '管理行政', 1, 'SystemSetting,PublicDocument,NewPublicDocumentForm,Task,NewWorkPlanForm,_NewDepPlan,Personal,PersonalDuty,SignInOffView,ErrandsRegisterView,ErrandsRegisterOutView,Administrator,GoodManeger,OfficeGoodsManageView,_OfficeGoodsQuery,_OfficeGoodsTypeManage,_OfficeGoodsAdd,_OfficeGoodsEdit,_OfficeGoodsDel,InStockView,_InStockQuery,_InStockAdd,_InStockEdit,_InStockDel,GoodsApplyView,_GoodsApplyQuery,_GoodsApplyAdd,_GoodsApplyEdit,_GoodsApplyDel,CarManeger,CarView,_CarQuery,_CarAdd,_CarEdit,_CarDel,CartRepairView,_CarRepairQuery,_CarRepairAdd,_CarRepairEdit,_CarRepairDel,CarApplyView,_CarApplyQuery,_CarApplyAdd,_CarApplyEdit,_CarApplyDel,FixedAssetsManage,DepreTypeView,_DepreTypeQuery,_DepreTypeAdd,_DepreTypeEdit,_DepreTypeDel,FixedAssetsManageView,_FixedAssetsQuery,_AssetsTypeManage,_FixedAssetsAdd,_FixedAssetsEdit,_FixedAssetsDel,_Depreciate,DepreRecordView,_DepreRecordQuery,BookManager,BookTypeView,_BookTypeQuery,_BookTypeAdd,_BookTypeEdit,_BookTypeDel,BookManageView,_BookQuery,_BookAdd,_BookEdit,_BookDel,BookBorrowView,_BookBorrowQuery,_BookBorrowAdd,_BookBorrowEdit,_BookReturn,_BookBorrowDel,BookReturnView,_BookReturnQuery,_BookReturnAdd,_BookReturnEdit,_BookReturnDel', 0);

insert into app_role (ROLEID, ROLENAME, ROLEDESC, STATUS, RIGHTS, ISDEFAULTIN)
values (3, '[文档管理员]', '管理文档', 1, 'SystemSetting,PublicDocument,NewPublicDocumentForm,DocFolderSharedView,_DocFolderSharedManage,_DocPrivilegeQuery,_DocPrivilegeAdd,_DocPrivilegeEdit,_DocPrivilegeDel,Personal,PersonalDuty,SignInOffView,ErrandsRegisterView,ErrandsRegisterOutView', 0);

insert into app_role (ROLEID, ROLENAME, ROLEDESC, STATUS, RIGHTS, ISDEFAULTIN)
values (4, '[信息管理员]', '管理新闻公告等信息', 1, 'SystemSetting,Task,PlanTypeView,_PlanTypeQuery,_PlanTypeAdd,_PlanTypeEdit,_PlanTypeDel,NewWorkPlanForm,_NewDepPlan,Info,NewsView,_NewsQuery,_NewsAdd,_NewsEdit,_NewsDel,NewsCommentView,_NewsCommentQuery,_NewsCommentDel,NewsTypeView,_NewsTypeQuery,_NewsTypeAdd,_NewsTypeEdit,_NewsTypeDel,NoticeView,_NoticeQuery,_NoticeAdd,_NoticeEdit,_NoticeDel,Personal,PersonalDuty,SignInOffView,ErrandsRegisterView,ErrandsRegisterOutView', 0);

insert into app_role (ROLEID, ROLENAME, ROLEDESC, STATUS, RIGHTS, ISDEFAULTIN)
values (5, '[客户经理]', '管理客户信息', 1, 'SystemSetting,PublicDocument,NewPublicDocumentForm,Task,NewWorkPlanForm,_NewDepPlan,Personal,PersonalDuty,SignInOffView,ErrandsRegisterView,ErrandsRegisterOutView,customer,CustomerView,_CustomerQuery,_CustomerAdd,_CustomerEdit,_CustomerDel,CusLinkmanView,_CusLinkmanQuery,_CusLinkmanAdd,_CusLinkmanEdit,_CusLinkmanDel,CusConnectionView,_CusConnectionQuery,_CusConnectionAdd,_CusConnectionEdit,_CusConnectionDel,ProjectView,_ProjectQuery,_ProjectAdd,_ProjectEdit,_ProjectDel,ContractView,_ContractQuery,_ContractAdd,_ContractEdit,_ContractDel,ProductView,_ProductQuery,_ProductAdd,_ProductEdit,_ProductDel,ProviderView,_ProviderQuery,_ProviderAdd,_ProviderEdit,_ProviderDel', 0);

insert into app_role (ROLEID, ROLENAME, ROLEDESC, STATUS, RIGHTS, ISDEFAULTIN)
values (6, '公文管理', '公文管理', 1, 'Archive,ArchFlowConfView,_ArchFlowConfEdit,ArchiveIssue,ArchiveTypeTempView,_ArchiveTypeTempQuery,_ArchivesTypeAdd,_ArchivesTypeEdit,_ArchivesTypeDel,_ArchivesTempAdd,_ArchivesTempEdit,_ArchviesTempDel,ArchivesDraftView,_AchivesDrafAdd,ArchivesDraftManage,_ArchivesDrafmQuery,_ArchivesDrafmEdit,_ArchivesDrafmDel,ArchivesIssueAudit,_ArchivesIssueQuery,_ArchivesIssueEdit,ArchivesIssueLead,_ArchivesIssueLeadQuery,_ArchivesIssueLeadEdit,ArchivesIssueCharge,_ArchivesIssueChargeQuery,_ArchivesIssueChargeEdit,ArchivesIssueProof,_ArchivesIssueProofQuery,_ArchivesIssueProofEdit,ArchivesDocument,_ArchivesDocumentQuery,ArchivesIssueMonitor,_ArchivesIssueMonitorQuery,_ArchivesIssueHasten,ArchivesIssueManage,_ArchivesIssueManageQuery,ArchivesIssueSearch,_ArchivesIssueSearchQuery,DocHistoryView,_DocHistoryQuery,_DocHistoryDel,ArchiveReceive,ArchivesSignView,_ArchivesSignQuery,_ArchivesSignUp,ArchivesRecView,_ArchivesRecQuery,_ArchivesRecAdd,_ArchivesRecEdit,_ArchivesRecDel,ArchivesHandleView,_ArchivesHandleQuery,LeaderReadView,_LeaderReadQuery,ArchDispatchView,_ArchDispatchQuery,ArchUndertakeView,_ArchUndertakeQuery,ArchivesRecCtrlView,_ArchivesRecCtrlQuery,_ArchivesRecHasten,ArchReadView,_ArchReadQuery,ArchRecTypeView,_ArchRecTypeQuery,_ArchRecTypeAdd,_ArchRecTypeEdit,_ArchRecTypeDel', 0);

insert into user_role (roleId,userId) values(-1,1);

insert into out_mail_folder (folderId,folderName,parentId,depLevel,path,folderType) values(1,'收件箱',0,1,'0.1',1);

insert into out_mail_folder (folderId,folderName,parentId,depLevel,path,folderType) values(2,'发件箱',0,1,'0.2',2);

insert into out_mail_folder (folderId,folderName,parentId,depLevel,path,folderType) values(3,'草稿箱',0,1,'0.3',3);

insert into out_mail_folder (folderId,folderName,parentId,depLevel,path,folderType) values(4,'垃圾箱',0,1,'0.4',4);

/*初始给流程设计的通用表单，方便流程若没有设置流程表单，也可以正常运行*/
insert into form_def (FORMDEFID, FORMTITLE, FORMDESP, DEFHTML, STATUS, FORMTYPE, ISDEFAULT, ISGEN) 
values (1, '通用流程表单', '通用流程表单', '<table class="form-info" cellspacing="1" cellpadding="0" style="width: 878px; height: 478px"><tbody><tr class="tr-info"><td class="td-info" colspan="4" style="text-align: center"><h2>申请事项</h2></td></tr><tr class="tr-info"><td class="td-info" width="20%"><strong>事项标题</strong></td><td class="td-info"><input class="x-form-text x-form-field" width="350" xtype="textfield" isnew="isnew" txtlabel="事项标题" txtvaluetype="varchar" txtisnotnull="1" txtisprimary="0" txtsize="256" style="width: 350px" name="itemSubject" type="text" /></td><td class="td-info" width="10%"><strong>创建时间</strong></td><td class="td-info" width="10%"><input xtype="datefield" txtlabel="创建时间" txtvaluetype="date" txtisnotnull="0" __cfckdate="__cfckdate" txtistoday="1" dateformat="yyyy-MM-dd" name="createtime" type="text" /></td></tr><tr class="tr-info"><td class="td-info"><strong>事项描述</strong></td><td class="td-info" colspan="3"><textarea class="x-form-textarea x-form-field x-column" xtype="fckeditor" txtlabel="事项描述" txtvaluetype="text" txtwidth="600" txtheight="350" isfck="true" style="width: 600px; height: 350px" name="itemDescp"></textarea></td></tr></tbody></table>', 1, 0, 1, 1);

insert into form_table (TABLEID, FORMDEFID, TABLENAME, TABLEKEY, ISMAIN) 
values (1, 1, '通用表单', 'general', 1);

insert into form_field (FIELDID, TABLEID, FIELDNAME, FIELDLABEL, FIELDTYPE, ISREQUIRED, FIELDSIZE, FIELDDSCP, ISPRIMARY, FOREIGNKEY, FOREIGNTABLE, ISLIST, ISQUERY, SHOWFORMAT, ISFLOWTITLE, ISDESIGNSHOW)
values (1, 1, 'entityId', 'ID', 'bigint', 0, null, '', 1, '', '', 1, 1, '', 0, 3);

insert into form_field (FIELDID, TABLEID, FIELDNAME, FIELDLABEL, FIELDTYPE, ISREQUIRED, FIELDSIZE, FIELDDSCP, ISPRIMARY, FOREIGNKEY, FOREIGNTABLE, ISLIST, ISQUERY, SHOWFORMAT, ISFLOWTITLE, ISDESIGNSHOW)
values (2, 1, 'itemDescp', '事项描述', 'text', 0, 4000, '', 0, '', '', 1, 1, '', 0, 1);

insert into form_field (FIELDID, TABLEID, FIELDNAME, FIELDLABEL, FIELDTYPE, ISREQUIRED, FIELDSIZE, FIELDDSCP, ISPRIMARY, FOREIGNKEY, FOREIGNTABLE, ISLIST, ISQUERY, SHOWFORMAT, ISFLOWTITLE, ISDESIGNSHOW)
values (3, 1, 'createtime', '创建时间', 'date', 0, null, '', 0, '', '', 1, 1, 'yyyy-MM-dd', 0, 1);

insert into form_field (FIELDID, TABLEID, FIELDNAME, FIELDLABEL, FIELDTYPE, ISREQUIRED, FIELDSIZE, FIELDDSCP, ISPRIMARY, FOREIGNKEY, FOREIGNTABLE, ISLIST, ISQUERY, SHOWFORMAT, ISFLOWTITLE, ISDESIGNSHOW)
values (4, 1, 'itemSubject', '事项标题', 'varchar', 1, 256, '', 0, '', '', 1, 1, '', 1, 1);

/*
规章制度 : REGULATION (RegulationForm)
全宗分类 : AR_FD (ArchFondForm)
案卷分类 : AR_RL (ArchRollForm)
数据字典 : DIC (DicManager)
文件分类 : AR_RLF (RollFileForm)
流程分类 : FLOW (ProDefinitionForm)
部门计划 : DEPWORKPLAN (DepWorkPlanForm)
个人计划 : PWP (PersonalWorkPlanForm)
发文分类 : ARCHIVES_TYPE (ArchivesDraftWin/发文流程开始结点.vm)
公文模板 : ARC_TEM_TYPE (ArchivesTypeTempView)
收文分类 : ARCHIVES_REC_TYPE (收文流程开始结点.vm)
*/
insert into type_key (typekeyId,typekey,typename,sn)values(1,'REGULATION','规章制度分类',1);
insert into type_key (typekeyId,typekey,typename,sn)values(2,'AR_FD','全宗分类',2);
insert into type_key (typekeyId,typekey,typename,sn)values(3,'AR_RL','案卷分类',3);
insert into type_key (typekeyId,typekey,typename,sn)values(4,'DIC','数据字典分类',4);
insert into type_key (typekeyId,typekey,typename,sn)values(5,'AR_RLF','文件分类',5);
insert into type_key (typekeyId,typekey,typename,sn)values(6,'FLOW','流程分类',6);
insert into type_key (typekeyId,typekey,typename,sn)values(7,'DEPWORKPLAN','部门计划分类',7);

insert into type_key (typekeyId,typekey,typename,sn)values(8,'PWP','个人计划分类',8);
insert into type_key (typekeyId,typekey,typename,sn)values(9,'ARCHIVES_TYPE','发文分类',9);
insert into type_key (typekeyId,typekey,typename,sn)values(10,'ARC_TEM_TYPE','公文模板分类',10);
insert into type_key (typekeyId,typekey,typename,sn)values(11,'ARCHIVES_REC_TYPE','收文分类',11);





insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (1, '北京', 2, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (2, '上海', 2, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (3, '天津', 2, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (4, '重庆', 2, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (5, '河北', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (6, '山西', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (7, '内蒙古', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (8, '辽宁', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (9, '吉林', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (10, '黑龙江', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (11, '江苏', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (12, '浙江', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (13, '安徽', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (14, '福建', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (15, '江西', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (16, '山东', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (17, '河南', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (18, '湖北', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (19, '湖南', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (20, '广东', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (21, '广西', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (22, '海南', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (23, '四川', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (24, '贵州', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (25, '云南', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (26, '西藏', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (27, '陕西', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (28, '甘肃', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (29, '青海', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (30, '宁夏', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (31, '新疆', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (32, '台湾', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (33, '港澳', 1, 0);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (34, '石家庄', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (35, '唐山', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (36, '秦皇岛', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (37, '邯郸', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (38, '邢台', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (39, '保定', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (40, '张家口', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (41, '承德', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (42, '沧州', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (43, '廊坊', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (44, '衡水', 2, 5);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (45, '太原', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (46, '大同', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (47, '阳泉', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (48, '长治', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (49, '晋城', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (50, '朔州', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (51, '晋中', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (52, '运城', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (53, '忻州', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (54, '临汾', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (55, '吕梁', 2, 6);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (56, '呼和浩特', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (57, '包头', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (58, '乌海', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (59, '赤峰', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (60, '通辽', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (61, '鄂尔多斯', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (62, '呼伦贝尔', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (63, '巴彦淖尔', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (64, '乌兰察布', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (65, '兴安', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (66, '锡林郭勒', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (67, '阿拉善', 2, 7);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (68, '沈阳', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (69, '大连', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (70, '鞍山', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (71, '抚顺', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (72, '本溪', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (73, '丹东', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (74, '锦州', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (75, '营口', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (76, '阜新', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (77, '辽阳', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (78, '盘锦', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (79, '铁岭', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (80, '朝阳', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (81, '葫芦岛', 2, 8);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (82, '长春', 2, 9);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (83, '吉林', 2, 9);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (84, '四平', 2, 9);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (85, '辽源', 2, 9);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (86, '通化', 2, 9);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (87, '白山', 2, 9);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (88, '松原', 2, 9);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (89, '白城', 2, 9);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (90, '延边', 2, 9);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (91, '哈尔滨', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (92, '齐齐哈尔', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (93, '鸡西', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (94, '鹤岗', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (95, '双鸭山', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (96, '大庆', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (97, '伊春', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (98, '佳木斯', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (99, '七台河', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (100, '牡丹江', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (101, '黑河', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (102, '绥化', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (103, '大兴安岭', 2, 10);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (104, '南京', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (105, '无锡', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (106, '徐州', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (107, '常州', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (108, '苏州', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (109, '南通', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (110, '连云港', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (111, '淮安', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (112, '盐城', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (113, '扬州', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (114, '镇江', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (115, '泰州', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (116, '宿迁', 2, 11);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (117, '杭州', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (118, '宁波', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (119, '温州', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (120, '嘉兴', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (121, '湖州', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (122, '绍兴', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (123, '金华', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (124, '衢州', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (125, '舟山', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (126, '台州', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (127, '丽水', 2, 12);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (128, '合肥', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (129, '芜湖', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (130, '蚌埠', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (131, '淮南', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (132, '马鞍山', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (133, '淮北', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (134, '铜陵', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (135, '安庆', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (136, '黄山', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (137, '滁州', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (138, '阜阳', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (139, '宿州', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (140, '巢湖', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (141, '六安', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (142, '亳州', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (143, '池州', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (144, '宣城', 2, 13);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (145, '福州', 2, 14);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (146, '厦门', 2, 14);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (147, '莆田', 2, 14);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (148, '三明', 2, 14);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (149, '泉州', 2, 14);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (150, '漳州', 2, 14);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (151, '南平', 2, 14);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (152, '龙岩', 2, 14);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (153, '宁德', 2, 14);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (154, '南昌', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (155, '景德镇', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (156, '萍乡', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (157, '九江', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (158, '新余', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (159, '鹰潭', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (160, '赣州', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (161, '吉安', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (162, '宜春', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (163, '抚州', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (164, '上饶', 2, 15);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (165, '济南', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (166, '青岛', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (167, '淄博', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (168, '枣庄', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (169, '东营', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (170, '烟台', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (171, '潍坊', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (172, '济宁', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (173, '泰安', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (174, '日照', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (175, '莱芜', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (176, '临沂', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (177, '德州', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (178, '聊城', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (179, '滨州', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (180, '菏泽', 2, 16);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (181, '郑州', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (182, '开封', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (183, '洛阳', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (184, '平顶山', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (185, '焦作', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (186, '鹤壁', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (187, '新乡', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (188, '安阳', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (189, '濮阳', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (190, '许昌', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (191, '渭河', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (192, '三门峡', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (193, '南阳', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (194, '商丘', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (195, '信阳', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (196, '周口', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (197, '驻马店', 2, 17);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (198, '武汉', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (199, '黄石', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (200, '襄樊', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (201, '十堰', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (202, '荆州', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (203, '宜昌', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (204, '荆门', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (205, '鄂州', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (206, '孝感', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (207, '黄冈', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (208, '咸宁', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (209, '随州', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (210, '恩施', 2, 18);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (211, '长沙', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (212, '株洲', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (213, '湘潭', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (214, '衡阳', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (215, '邵阳', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (216, '岳阳', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (217, '常德', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (218, '张家界', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (219, '溢阳', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (220, '郴州', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (221, '永州', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (222, '怀化', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (223, '娄底', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (224, '湘西', 2, 19);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (225, '广州', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (226, '深圳', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (227, '珠海', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (228, '汕头', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (229, '韶关', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (230, '佛山', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (231, '江门', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (232, '湛江', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (233, '茂名', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (234, '肇庆', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (235, '惠州', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (236, '梅州', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (237, '汕尾', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (238, '河源', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (239, '阳江', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (240, '清远', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (241, '东莞', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (242, '中山', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (243, '潮州', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (244, '揭阳', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (245, '云浮', 2, 20);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (246, '南宁', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (247, '柳州', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (248, '桂林', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (249, '梧州', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (250, '北海', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (251, '防城港', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (252, '钦州', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (253, '贵港', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (254, '玉林', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (255, '百色', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (256, '贺州', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (257, '河池', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (258, '来宾', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (259, '崇左', 2, 21);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (260, '白沙黎族自治县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (261, '西沙群岛', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (262, '儋州', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (263, '屯昌县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (264, '安定县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (265, '琼中黎族苗族自治县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (266, '昌江黎族自治县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (267, '东方', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (268, '三亚', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (269, '中沙群岛的岛礁及其海域', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (270, '琼海', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (271, '澄迈县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (272, '五指山', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (273, '海口', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (274, '文昌', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (275, '陵水黎族自治县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (276, '保亭黎族苗族自治县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (277, '南沙群岛', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (278, '乐东黎族自治县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (279, '临高县', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (280, '万宁', 2, 22);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (281, '成都', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (282, '自贡', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (283, '攀枝花', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (284, '泸州', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (285, '德阳', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (286, '绵阳', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (287, '广元', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (288, '遂宁', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (289, '内江', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (290, '乐山', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (291, '南充', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (292, '宜宾', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (293, '广安', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (294, '达州', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (295, '眉山', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (296, '雅安', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (297, '巴中', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (298, '资阳', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (299, '阿坝', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (300, '甘孜', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (301, '凉山', 2, 23);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (302, '贵阳', 2, 24);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (303, '六盘水', 2, 24);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (304, '遵义', 2, 24);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (305, '安顺', 2, 24);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (306, '铜仁', 2, 24);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (307, '毕节', 2, 24);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (308, '黔西南', 2, 24);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (309, '黔东南', 2, 24);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (310, '黔南', 2, 24);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (311, '昆明', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (312, '曲靖', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (313, '玉溪', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (314, '保山', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (315, '昭通', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (316, '丽江', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (317, '普洱', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (318, '临沧', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (319, '文山', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (320, '红河', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (321, '西双版纳', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (322, '楚雄', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (323, '大理', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (324, '德宏', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (325, '怒江', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (326, '迪庆', 2, 25);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (327, '拉萨', 2, 26);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (328, '昌都', 2, 26);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (329, '山南', 2, 26);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (330, '日喀则', 2, 26);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (331, '那曲', 2, 26);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (332, '阿里', 2, 26);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (333, '林芝', 2, 26);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (334, '西安', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (335, '铜川', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (336, '宝鸡', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (337, '咸阳', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (338, '渭南', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (339, '延安', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (340, '汉中', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (341, '榆林', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (342, '安康', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (343, '商洛', 2, 27);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (344, '兰州', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (345, '嘉峪关', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (346, '金昌', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (347, '白银', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (348, '天水', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (349, '武威', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (350, '张掖', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (351, '平凉', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (352, '酒泉', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (353, '庆阳', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (354, '定西', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (355, '陇南', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (356, '临夏', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (357, '甘南', 2, 28);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (358, '西宁', 2, 29);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (359, '海东', 2, 29);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (360, '海北', 2, 29);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (361, '黄南', 2, 29);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (362, '海南', 2, 29);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (363, '果洛', 2, 29);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (364, '玉树', 2, 29);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (365, '海西', 2, 29);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (366, '银川', 2, 30);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (367, '石嘴山', 2, 30);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (368, '吴忠', 2, 30);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (369, '固原', 2, 30);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (370, '中卫', 2, 30);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (371, '乌鲁木齐', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (372, '克拉玛依', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (373, '吐鲁番', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (374, '哈密', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (375, '和田', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (376, '阿克苏', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (377, '喀什', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (378, '克孜勒苏柯尔克孜', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (379, '巴音郭楞蒙古', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (380, '昌吉', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (381, '博尔塔拉蒙古', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (382, '伊犁哈萨克', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (383, '塔城', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (384, '阿勒泰', 2, 31);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (385, '台北', 2, 32);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (386, '高雄', 2, 32);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (387, '基隆', 2, 32);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (388, '台中', 2, 32);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (389, '台南', 2, 32);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (390, '新竹', 2, 32);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (391, '香港', 2, 33);

insert into region (REGIONID, REGIONNAME, REGIONTYPE, PARENTID)
values (392, '澳门', 2, 33);




insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (1, '宗教信仰', '佛教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (2, '宗教信仰', '道教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (3, '宗教信仰', '基督宗教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (4, '宗教信仰', '天主教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (5, '宗教信仰', '伊斯兰教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (6, '宗教信仰', '犹太教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (7, '宗教信仰', '孔教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (8, '宗教信仰', '神道教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (9, '宗教信仰', '耆那教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (10, '宗教信仰', '印度教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (11, '宗教信仰', '东正教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (12, '宗教信仰', '新教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (13, '宗教信仰', '锡克教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (14, '宗教信仰', '琐罗亚斯德教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (15, '宗教信仰', '巴哈伊教', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (16, '宗教信仰', '其它', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (17, '民族', '汉族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (18, '民族', '阿昌族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (19, '民族', '白族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (20, '民族', '保安族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (21, '民族', '布朗族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (22, '民族', '布依族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (23, '民族', '朝鲜族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (24, '民族', '达斡族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (25, '民族', '傣族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (26, '民族', '德昂族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (27, '民族', '侗族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (28, '民族', '东乡族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (29, '民族', '独龙族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (30, '民族', '鄂伦春族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (31, '民族', '俄罗斯族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (32, '民族', '鄂温克族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (33, '民族', '高山族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (34, '民族', '仡佬族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (35, '民族', '哈尼族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (36, '民族', '啥萨克族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (37, '民族', '赫哲族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (38, '民族', '回族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (39, '民族', '基诺族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (40, '民族', '京族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (41, '民族', '景颇族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (42, '民族', '柯尔克孜族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (43, '民族', '拉祜族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (44, '民族', '黎族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (45, '民族', '僳僳族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (46, '民族', '珞巴族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (47, '民族', '满族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (48, '民族', '毛南族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (49, '民族', '门巴族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (50, '民族', '蒙古族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (51, '民族', '苗族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (52, '民族', '仫佬族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (53, '民族', '纳西族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (54, '民族', '怒族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (55, '民族', '普米族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (56, '民族', '羌族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (57, '民族', '撒拉族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (58, '民族', '畲族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (59, '民族', '水族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (60, '民族', '塔吉克族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (61, '民族', '塔塔尔族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (62, '民族', '土族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (63, '民族', '土家族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (64, '民族', '佤族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (65, '民族', '维吾尔族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (66, '民族', '乌孜别克族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (67, '民族', '锡伯族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (68, '民族', '瑶族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (69, '民族', '彝族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (70, '民族', '藏族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (71, '民族', '壮族', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (72, '学历', '博士', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (73, '学历', '研究生', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (74, '学历', '本科', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (75, '学历', '大专', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (76, '学历', '中专', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (77, '学历', '初中', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (78, '学历', '小学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (79, '学历', '其它', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (80, '政治面貌', '群众', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (81, '政治面貌', '共青团员', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (82, '政治面貌', '中共党员', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (83, '国籍', '中华人民共和国', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (84, '国籍', '美国', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (85, '国籍', '俄罗斯', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (86, '国籍', '日本', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (87, '国籍', '韩国', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (88, '国籍', '新加波', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (89, '国籍', '马来西亚', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (90, '国籍', '英国', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (91, '国籍', '德国', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (92, '国籍', '意大利', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (93, '国籍', '澳大利亚', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (94, '国籍', '巴西', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (95, '专业', '管理科学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (96, '专业', '信息管理和信息系统', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (97, '专业', '工业工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (98, '专业', '工程管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (99, '专业', '农业经理管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (100, '专业', '工商管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (101, '专业', '市场营销', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (102, '专业', '会计学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (103, '专业', '涉外会计', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (104, '专业', '会计电算化', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (105, '专业', '财政金融', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (106, '专业', '财务管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (107, '专业', '技术经济', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (108, '专业', '文秘', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (109, '专业', '国际商务', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (110, '专业', '物流管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (111, '专业', '行政管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (112, '专业', '公共事业管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (113, '专业', '旅游管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (114, '专业', '宾馆/酒店管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (115, '专业', '人力资源管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (116, '专业', '公共关系学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (117, '专业', '物业管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (118, '专业', '房地产经营管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (119, '专业', '劳动与社会保障', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (120, '专业', '土地资源管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (121, '专业', '图书档案学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (122, '专业', '计算机科学与技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (123, '专业', '计算机应用', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (124, '专业', '计算机信息管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (125, '专业', '计算机网络', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (126, '专业', '电子商务', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (127, '专业', '通信工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (128, '专业', '电气工程及其自动化', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (129, '专业', '软件工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (130, '专业', '自动化', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (131, '专业', '电子信息工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (132, '专业', '电子科学与技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (133, '专业', '电子信息科学与技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (134, '专业', '微电子学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (135, '专业', '光信息科学与技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (136, '专业', '机械设计制造及其自动化', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (137, '专业', '材料成型及控制工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (138, '专业', '工业设计', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (139, '专业', '过程装备与控制工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (140, '专业', '机械电子工程/机电一体化', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (141, '专业', '模具设计与制造', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (142, '专业', '机械制造工艺与设备', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (143, '专业', '测控技术与仪器', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (144, '专业', '热能与动力工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (145, '专业', '核工程与核技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (146, '专业', '电力系统及自动化', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (147, '专业', '制冷与低温技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (148, '专业', '冶金工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (149, '专业', '金属材料工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (150, '专业', '无机非金属料工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (151, '专业', '高分子材料与工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (152, '专业', '材料物理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (153, '专业', '材料化学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (154, '专业', '材料科学与工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (155, '专业', '食品科学与工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (156, '专业', '轻化工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (157, '专业', '包装工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (158, '专业', '印刷工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (159, '专业', '纺织工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (160, '专业', '服装设计与工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (161, '专业', '建筑学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (162, '专业', '城市规划', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (163, '专业', '园林规划与设计', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (164, '专业', '土木工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (165, '专业', '道路与桥梁', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (166, '专业', '建设环境与设备工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (167, '专业', '给水排水工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (168, '专业', '供热通风与空调工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (169, '专业', '工业与民用建筑', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (170, '专业', '室内装潢设计', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (171, '专业', '建筑工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (172, '专业', '工程造价管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (173, '专业', '力学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (174, '专业', '应用力学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (175, '专业', '环境科学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (176, '专业', '生态学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (177, '专业', '环境工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (178, '专业', '安全工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (179, '专业', '制药工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (180, '专业', '交通运输', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (181, '专业', '交通工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (182, '专业', '油气储运工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (183, '专业', '飞行技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (184, '专业', '航海技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (185, '专业', '轮机工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (186, '专业', '汽车工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (187, '专业', '飞行器设计与工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (188, '专业', '飞行器动力工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (189, '专业', '飞行器制造工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (190, '专业', '飞行器环境与生命保障工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (191, '专业', '船舶与海洋工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (192, '专业', '水利水电工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (193, '专业', '水文与水资源工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (194, '专业', '港口航道与海岸工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (195, '专业', '测绘工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (196, '专业', '公安技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (197, '专业', '武器系统与发射工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (198, '专业', '探测制导与控制技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (199, '专业', '弹药工程与爆炸技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (200, '专业', '数学与应用数学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (201, '专业', '信息与计算科学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (202, '专业', '物理学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (203, '专业', '应用物理学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (204, '专业', '化学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (205, '专业', '应用化学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (206, '专业', '化学工程与工艺', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (207, '专业', '精细化工', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (208, '专业', '化工设备与机械', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (209, '专业', '生物工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (210, '专业', '生物医学工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (211, '专业', '生物科学,技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (212, '专业', '天文学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (213, '专业', '地质学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (214, '专业', '宝石鉴定与加工', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (215, '专业', '地理科学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (216, '专业', '地球物理学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (217, '专业', '大气科学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (218, '专业', '海洋科学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (219, '专业', '地矿', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (220, '专业', '石油工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (221, '专业', '经济学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (222, '专业', '国际经济与贸易', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (223, '专业', '财政学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (224, '专业', '金融学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (225, '专业', '经济管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (226, '专业', '经济信息管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (227, '专业', '工业外贸', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (228, '专业', '国际金融', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (229, '专业', '投资经济管理', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (230, '专业', '统计学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (231, '专业', '审计学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (232, '专业', '中国语言文学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (233, '专业', '英语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (234, '专业', '俄语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (235, '专业', '德语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (236, '专业', '法语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (237, '专业', '日语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (238, '专业', '西班牙语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (239, '专业', '阿拉伯语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (240, '专业', '朝鲜语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (241, '专业', '其它外语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (242, '专业', '新闻学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (243, '专业', '广播电视新闻', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (244, '专业', '广告学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (245, '专业', '编辑出版学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (246, '专业', '外贸英语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (247, '专业', '商务英语', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (248, '专业', '音乐,舞蹈,作曲', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (249, '专业', '绘画,艺术设计', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (250, '专业', '戏剧,表演', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (251, '专业', '导演,广播电视编导', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (252, '专业', '戏剧影视文学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (253, '专业', '戏剧影视美术设计', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (254, '专业', '摄影,动画', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (255, '专业', '播音,主持,录音', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (256, '专业', '服装设计', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (257, '专业', '法学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (258, '专业', '马克思主义理论', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (259, '专业', '社会学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (260, '专业', '政治学与行政学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (261, '专业', '国际政治', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (262, '专业', '外交学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (263, '专业', '思想政治教育', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (264, '专业', '公安学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (265, '专业', '经济法', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (266, '专业', '国际经济法', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (267, '专业', '哲学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (268, '专业', '逻辑学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (269, '专业', '宗教学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (270, '专业', '教育学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (271, '专业', '学前教育', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (272, '专业', '体育学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (273, '专业', '基础医学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (274, '专业', '预防医学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (275, '专业', '临床医学与医学技术', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (276, '专业', '口腔医学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (277, '专业', '中医学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (278, '专业', '法医学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (279, '专业', '护理学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (280, '专业', '药学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (281, '专业', '心理学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (282, '专业', '医学检验', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (283, '专业', '植物生产', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (284, '专业', '农学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (285, '专业', '园艺', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (286, '专业', '植物保护学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (287, '专业', '茶学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (288, '专业', '草业科学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (289, '专业', '森林资源', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (290, '专业', '环境生态', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (291, '专业', '园林', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (292, '专业', '动物生产', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (293, '专业', '动物医学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (294, '专业', '水产类', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (295, '专业', '农业工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (296, '专业', '林业工程', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (297, '专业', '历史学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (298, '专业', '考古学', '');

insert into dictionary (DICID, ITEMNAME, ITEMVALUE, DESCP)
values (299, '专业', '博物馆学', '');


