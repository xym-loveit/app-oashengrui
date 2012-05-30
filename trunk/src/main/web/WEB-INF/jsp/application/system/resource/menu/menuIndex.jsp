<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.noborder {border-left: none; border-right: none; border-top: none;}
</style>

<div class="pageContent bor" style="float:left; width: 200px;">
	<div class="toggleCollapse noborder">
		<h2>菜单项设置</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="app/admin.do?action=adminPageDocumentDetail" target="dialog" title="新建菜单项" width="850" height="380" rel="dia_admin_entryadd"><span>新建菜单项</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="app/admin.do?action=adminPageEntryDetail&id={sid}" target="dialog" title="修改新闻" width="900" height="500" rel="dia_admin_entryedit{sid}"><span>修改</span></a></li>
		</ul>
	</div>
	
	<ul class="tree treeFolder" layoutH="8">
		<li treeicon="icon-desktop"><a href="tabsPage.html" target="navTab"><span>我的工作区</span></a>
			<ul class="">
				<li treeicon="icon-myplan"><a href="app/personal.do?action=pageMyWorkplan" target="navTab" rel="myplan">我的任务</a></li>
				<li treeicon="icon-myconference"><a href="app/personal.do?action=pageMyConference" target="navTab" rel="myconference">我的会议</a></li>
				<li treeicon="icon-mynews"><a href="app/personal.do?action=pageMyNews" target="navTab" rel="mynews">我的新闻</a></li>
				<li treeicon="icon-infodoc"><a href="app/personal.do?action=pageMyDoc" target="navTab" rel="mydoc">文档下载区</a></li>
				<li treeicon="icon-hrjobreg"><a href="demo_page5.html" target="navTab" rel="myjobform">我要应聘</a></li>
				<li treeicon="icon-myinvite"><a href="app/personal.do?action=pageMyBaron" target="navTab" rel="mybaron">我做伯乐</a></li>
				<li treeicon="icon-myapply"><a href="demo_page5.html" target="navTab" rel="myapply">我的申请</a></li>
				<li treeicon="icon-myapproval"><a href="demo_page5.html" target="navTab" rel="mytodo">待我审批</a></li>
			</ul>
		</li>
		<li treeicon="icon-admin"><a href="tabsPage.html" target="navTab"><span>行政管理</span></a>
			<ul>
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
		</li>
	</ul>
</div>

<div class="pageContent bol" style="margin-left: 210px;">
	<div class="toggleCollapse noborder">
		<h2>功能列表</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="app/admin.do?action=adminPageDocumentDetail" target="dialog" title="添加功能" width="850" height="380" rel="dia_admin_entryadd"><span>添加功能</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" href="app/admin.do?action=adminOprEntryRemove&id={sid}" target="ajaxTodo" title="确定要删除吗?" callback="hello"><span>删除</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="app/admin.do?action=adminPageEntryDetail&id={sid}" target="dialog" title="修改新闻" width="900" height="500" rel="dia_admin_entryedit{sid}"><span>修改</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="8">
		<thead>
			<tr>
				<th align="center">文档类型</th>
				<th align="center">文档名称</th>
				<th align="center">上传时间</th>
				<th align="center">上传校区与部门</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="app/admin.do?action=adminOprEntryRemove&id=1" target="ajaxTodo" title="确定要删除吗?" callback="hello"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="修改新闻" width="900" height="500"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>待审批</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td class="dispose">已退回</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>草稿</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
		</tbody>
	</table>
</div>
