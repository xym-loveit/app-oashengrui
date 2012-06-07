<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="sidebar_s">
	<div class="collapse">
		<div class="toggleCollapse"><div></div></div>
	</div>
</div>
<div id="sidebar">
	<div class="toggleCollapse"><h2 class="icon-navigation">主菜单</h2><div>收缩</div></div>
	<div class="accordion" fillSpace="sidebar">
		
		<!-- 个人工作区 -->
		<div class="accordionHeader">
			<h2><span id="menu-desktop">Folder</span>我的工作区</h2>
		</div>
		<div class="accordionContent">
			<ul class="tree treeFolder">
				<li treeicon="icon-myplan"><a href="app/personal.do?action=pageMyWorkplan" target="navTab" rel="myplan">我的任务</a></li>
				<li treeicon="icon-myconference"><a href="app/personal.do?action=pageMyConference" target="navTab" rel="myconference">我的会议</a></li>
				<li treeicon="icon-mynews"><a href="app/personal.do?action=pageMyNews" target="navTab" rel="mynews">我的新闻</a></li>
				<li treeicon="icon-infodoc"><a href="app/personal.do?action=pageMyDoc" target="navTab" rel="mydoc">文档下载区</a></li>
				<li treeicon="icon-hrjobreg"><a href="demo_page5.html" target="navTab" rel="myjobform">我要应聘</a></li>
				<li treeicon="icon-myinvite"><a href="app/personal.do?action=pageMyBaron" target="navTab" rel="mybaron">我做伯乐</a></li>
				<li treeicon="icon-myapply"><a href="demo_page5.html" target="navTab" rel="myapply">我的申请</a></li>
				<li treeicon="icon-myapproval"><a href="demo_page5.html" target="navTab" rel="mytodo">待我审批</a></li>
			</ul>
		</div>
		
		<!-- 行政管理 -->
		<div class="accordionHeader">
			<h2><span id="menu-administrator">Folder</span>行政管理</h2>
		</div>
		<div class="accordionContent">
			<ul class="tree treeFolder">
				<li treeicon="icon-adminnews"><a href="app/admin.do?action=adminPageEntryIndex" target="navTab" rel="admin_entry">新闻发布与管理</a></li>
				<li treeicon="icon-admintask"><a href="app/admin.do?action=adminPageTaskDelegateIndex" target="navTab" rel="admin_task">任务委托管理</a></li>
				<li treeicon="icon-admindutyStaff"><a>员工考勤管理</a>
					<ul>
						<li treeicon="icon-admindutyArrange"><a href="app/admin.do?action=adminPageStaffWorkArrange" target="navTab" rel="admin_workArrange">工作安排</a></li>
						<li treeicon="icon-adminduty"><a href="app/admin.do?action=adminPageStaffAttendance" target="navTab" rel="admin_staffAttendance">员工考勤</a></li>
					</ul>
				</li>
				<li treeicon="icon-infoshared"><a href="app/admin.do?action=adminPageDocumentIndex" target="navTab" rel="admin_doc">文档上传与管理</a></li>
			</ul>
		</div>
		
		<!-- 人资管理 -->
		<div class="accordionHeader">
			<h2><span id="menu-hr">Folder</span>人资管理</h2>
		</div>
		<div class="accordionContent">
			<ul class="tree treeFolder">
				<li treeicon="icon-hrjobm"><a>招聘管理</a>
					<ul>
						<li treeicon="icon-hrjobmIssue"><a href="app/hrm.do?action=hrmJobIndex" target="navTab" rel="hrm_jobIndex">当前招聘管理</a></li>
						<li treeicon="icon-hrjobmProfile"><a href="app/hrm.do?action=hrmArchiveIndex" target="navTab" rel="hrm_archiveIndex">公司人才库</a></li>
					</ul>
				</li>
				<li treeicon="icon-hrstaffm"><a>员工档案管理</a>
					<ul>
						<li treeicon="icon-hrjobreg"><a href="demo_page1.html" target="navTab" rel="demo_page2">招聘入职</a></li>
						<li treeicon="icon-hrstaffmProfile"><a href="demo_page1.html" target="navTab" rel="demo_page2">员工档案</a></li>
					</ul>
				</li>
				<li treeicon="icon-hrmcheck"><a href="demo_page1.html" target="navTab" rel="demo_page1">人力发展管理</a></li>
			</ul>
		</div>
		
		<!-- 财务管理 -->
		<div class="accordionHeader">
			<h2><span id="menu-financial">Folder</span>财务管理</h2>
		</div>
		<div class="accordionContent">
			<ul class="tree treeFolder">
				<li treeicon="icon-finmrmb"><a>费用支出管理</a>
					<ul>
						<li treeicon="icon-finmrmbApply"><a href="demo_page1.html" target="navTab" rel="demo_page2">费用支出申请</a></li>
						<li treeicon="icon-finmrmbApproval"><a href="demo_page1.html" target="navTab" rel="demo_page2">费用支出审批</a></li>
					</ul>
				</li>
				<li treeicon="icon-finmcontracts"><a>合同管理</a>
					<ul>
						<li treeicon="icon-finmcontractsApply"><a href="demo_page1.html" target="navTab" rel="demo_page2">合同审批申请</a></li>
						<li treeicon="icon-finmcontractsRecords"><a href="demo_page1.html" target="navTab" rel="demo_page2">合同审批记录</a></li>
					</ul>
				</li>
			</ul>
		</div>
		
		<!-- 系统管理 -->
		<div class="accordionHeader">
			<h2><span id="menu-system">Folder</span>系统管理</h2>
		</div>
		<div class="accordionContent">
			<ul class="tree treeFolder">
				<li treeicon="icon-sysmpwd"><a href="demo_page1.html" target="navTab" rel="demo_page1">密码修改</a></li>
				<li treeicon="icon-sysmusr"><a href="app/system/account.do?action=pageAccountIndex" target="navTab" rel="sysmgr_account">用户管理</a></li>
				<li treeicon="icon-sysmlogs"><a href="demo_page1.html" target="navTab" rel="demo_page1">系统日志</a></li>
			</ul>
		</div>
		
		<!-- 系统设置 -->
		<div class="accordionHeader">
			<h2><span id="menu-settings">Folder</span>系统设置</h2>
		</div>
		<div class="accordionContent">
			<ul class="tree treeFolder">
				<li treeicon="icon-setdic"><a href="demo_page1.html" target="navTab" rel="demo_page1">数据字典设置</a></li>
				<li treeicon="icon-setaskm"><a>工作安排设置</a>
					<ul>
						<li treeicon="icon-setaskmTpl"><a href="demo_page1.html" target="navTab" rel="demo_page2">工作安排模板设置</a></li>
						<li treeicon="icon-setaskmBase"><a href="demo_page1.html" target="navTab" rel="demo_page2">工作安排基础设置</a></li>
					</ul>
				</li>
				<li treeicon="icon-setflowm"><a>审批流程设置</a>
					<ul>
						<li treeicon="icon-setflowmhr"><a href="demo_page1.html" target="navTab" rel="sysmgr_flow_hrm">人资审批流程设置</a></li>
						<li treeicon="icon-setflowmfin"><a href="app/flow/financial.do?action=pageFlowIndex" target="navTab" rel="sysmgr_flow_financial">财务审批流程设置</a></li>
					</ul>
				</li>
				<li treeicon="icon-setorg"><a>学校设置</a>
					<ul>
						<li treeicon="icon-setorgDep"><a href="app/system/school/district.do?action=pageSchoolDistrictIndex" target="navTab" rel="sysmgr_school_district">校区设置</a></li>
						<li treeicon="icon-setorgRepo"><a href="app/system/school/department.do?action=pageSchoolDepartmentIndex" target="navTab" rel="sysmgr_school_depindex">部门岗位设置</a></li>
						<!--<li treeicon="icon-setorgBricks"><a href="demo_page1.html" target="navTab" rel="demo_page2">岗位权限设置</a></li>-->
					</ul>
				</li>
				<li treeicon="icon-setrole"><a href="app/system/role.do?action=pageRoleIndex" target="navTab" rel="sysmgr_role">权限组配置</a></li>
				<li treeicon="icon-setres"><a href="app/system/menu.do?action=pageMenuIndex" target="navTab" rel="sysmgr_resmenu">菜单设置</a></li>
			</ul>
		</div>
	</div>
</div>