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
				<li treeicon="icon-adminnews"><a href="demo_page1.html" target="navTab" rel="demo_page1">新闻发布与管理</a></li>
				<li treeicon="icon-admintask"><a href="demo_page1.html" target="navTab" rel="demo_page2">任务委托管理</a></li>
				<li treeicon="icon-admindutyStaff"><a>员工考勤管理</a>
					<ul>
						<li treeicon="icon-admindutyArrange"><a href="demo_page1.html" target="navTab" rel="demo_page2">工作安排</a></li>
						<li treeicon="icon-adminduty"><a href="demo_page1.html" target="navTab" rel="demo_page2">员工考勤</a></li>
					</ul>
				</li>
				<li treeicon="icon-infoshared"><a href="demo_page5.html" target="navTab" rel="demo_page5">文档上传与管理</a></li>
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
						<li treeicon="icon-hrjobmIssue"><a href="demo_page1.html" target="navTab" rel="demo_page2">当前招聘管理</a></li>
						<li treeicon="icon-hrjobmProfile"><a href="demo_page1.html" target="navTab" rel="demo_page2">公司人才库</a></li>
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
				<li treeicon="icon-sysmusr"><a href="demo_page1.html" target="navTab" rel="demo_page1">用户管理</a></li>
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
						<li treeicon="icon-setflowmhr"><a href="demo_page1.html" target="navTab" rel="demo_page2">人资审批流程设置</a></li>
						<li treeicon="icon-setflowmfin"><a href="demo_page1.html" target="navTab" rel="demo_page2">财务审批流程设置</a></li>
					</ul>
				</li>
				<li treeicon="icon-setorg"><a>学校设置</a>
					<ul>
						<li treeicon="icon-setorgDep"><a href="demo_page1.html" target="navTab" rel="demo_page2">校区设置</a></li>
						<li treeicon="icon-setorgRepo"><a href="demo_page1.html" target="navTab" rel="demo_page2">部门岗位设置</a></li>
						<li treeicon="icon-setorgBricks"><a href="demo_page1.html" target="navTab" rel="demo_page2">岗位权限设置</a></li>
					</ul>
				</li>
				<li treeicon="icon-setrole"><a href="demo_page1.html" target="navTab" rel="demo_page1">权限组配置</a></li>
			</ul>
		</div>
		
		<!--
		<div class="accordionHeader">
			<h2><span id="menu-desktop">Folder</span>我的桌面</h2>
		</div>
		<div class="accordionContent">
			<ul class="tree treeFolder">
				<li><a href="tabsPage.html" target="navTab">主框架面板</a>
					<ul>
						<li><a href="main.html" target="navTab" rel="main">我的主页</a></li>
						<li><a href="http://www.baidu.com" target="navTab" rel="page1">页面一(外部页面)</a></li>
						<li><a href="demo_page2.html" target="navTab" rel="external" external="true">iframe navTab页面</a></li>
						<li><a href="demo_page1.html" target="navTab" rel="page1" fresh="false">替换页面一</a></li>
						<li><a href="demo_page2.html" target="navTab" rel="page2">页面二</a></li>
						<li><a href="demo_page4.html" target="navTab" rel="page3" title="页面三（自定义标签名）">页面三</a></li>
						<li><a href="demo_page4.html" target="navTab" rel="page4" fresh="false">测试页面（fresh="false"）</a></li>
						<li><a href="w_editor.html" target="navTab">表单提交会话超时</a></li>
						<li><a href="demo/common/ajaxTimeout.html" target="navTab">navTab会话超时</a></li>
						<li><a href="demo/common/ajaxTimeout.html" target="dialog">dialog会话超时</a></li>
						<li><a href="index_menu.html" target="_blank">横向导航条</a></li>
					</ul>
				</li>
				
				<li><a>常用组件</a>
					<ul>
						<li><a href="w_panel.html" target="navTab" rel="w_panel">面板</a></li>
						<li><a href="w_tabs.html" target="navTab" rel="w_tabs">选项卡面板</a></li>
						<li><a href="w_dialog.html" target="navTab" rel="w_dialog">弹出窗口</a></li>
						<li><a href="w_alert.html" target="navTab" rel="w_alert">提示窗口</a></li>
						<li><a href="w_list.html" target="navTab" rel="w_list">CSS表格容器</a></li>
						<li><a href="demo_page1.html" target="navTab" rel="w_table">表格容器</a></li>
						<li><a href="w_removeSelected.html" target="navTab" rel="w_table">表格数据库排序+批量删除</a></li>
						<li><a href="w_tree.html" target="navTab" rel="w_tree">树形菜单</a></li>
						<li><a href="w_accordion.html" target="navTab" rel="w_accordion">滑动菜单</a></li>
						<li><a href="w_editor.html" target="navTab" rel="w_editor">编辑器</a></li>
						<li><a href="w_datepicker.html" target="navTab" rel="w_datepicker">日期控件</a></li>
						<li><a href="demo/database/db_widget.html" target="navTab" rel="db">suggest+lookup+主从结构</a></li>
						<li><a href="demo/database/treeBringBack.html" target="navTab" rel="db">tree查找带回</a></li>
						<li><a href="demo/sortDrag/1.html" target="navTab" rel="sortDrag">单个sortDrag示例</a></li>
						<li><a href="demo/sortDrag/2.html" target="navTab" rel="sortDrag">多个sortDrag示例</a></li>
					</ul>
				</li>
						
				<li><a>表单组件</a>
					<ul>
						<li><a href="w_validation.html" target="navTab" rel="w_validation">表单验证</a></li>
						<li><a href="w_button.html" target="navTab" rel="w_button">按钮</a></li>
						<li><a href="w_textInput.html" target="navTab" rel="w_textInput">文本框/文本域</a></li>
						<li><a href="w_combox.html" target="navTab" rel="w_combox">下拉菜单</a></li>
						<li><a href="w_checkbox.html" target="navTab" rel="w_checkbox">多选框/单选框</a></li>
						<li><a href="demo_upload.html" target="navTab" rel="demo_upload">iframeCallback表单提交</a></li>
						<li><a href="w_resources/js/uploadify/.html" target="navTab" rel="w_resources/js/uploadify/">resources/js/uploadify/多文件上传</a></li>
					</ul>
				</li>
				<li><a>组合应用</a>
					<ul>
						<li><a href="demo/pagination/layout1.html" target="navTab" rel="pagination1">局部刷新分页1</a></li>
						<li><a href="demo/pagination/layout2.html" target="navTab" rel="pagination2">局部刷新分页2</a></li>
					</ul>
				</li>
				<li><a href="resources/js/dwz/dwz.frag.xml" target="navTab" external="true">resources/js/dwz/dwz.frag.xml</a></li>
			</ul>
		</div>
		<div class="accordionHeader">
			<h2><span>Folder</span>典型页面</h2>
		</div>
		<div class="accordionContent">
			<ul class="tree treeFolder treeCheck">
				<li><a href="demo_page1.html" target="navTab" rel="demo_page1">查询我的客户</a></li>
				<li><a href="demo_page1.html" target="navTab" rel="demo_page2">表单查询页面</a></li>
				<li><a href="demo_page4.html" target="navTab" rel="demo_page4">表单录入页面</a></li>
				<li><a href="demo_page5.html" target="navTab" rel="demo_page5">有文本输入的表单</a></li>
				<li><a href="javascript:;">有提示的表单输入页面</a>
					<ul>
						<li><a href="javascript:;">页面一</a></li>
						<li><a href="javascript:;">页面二</a></li>
					</ul>
				</li>
				<li><a href="javascript:;">选项卡和图形的页面</a>
					<ul>
						<li><a href="javascript:;">页面一</a></li>
						<li><a href="javascript:;">页面二</a></li>
					</ul>
				</li>
				<li><a href="javascript:;">选项卡和图形切换的页面</a></li>
				<li><a href="javascript:;">左右两个互动的页面</a></li>
				<li><a href="javascript:;">列表输入的页面</a></li>
				<li><a href="javascript:;">双层栏目列表的页面</a></li>
			</ul>
		</div>
		<div class="accordionHeader">
			<h2><span>Folder</span>流程演示</h2>
		</div>
		<div class="accordionContent">
			<ul class="tree">
				<li><a href="newPage1.html" target="dialog" rel="dlg_page">列表</a></li>
				<li><a href="newPage1.html" target="dialog" rel="dlg_page2">列表</a></li>
			</ul>
		</div>
		-->
	</div>
</div>