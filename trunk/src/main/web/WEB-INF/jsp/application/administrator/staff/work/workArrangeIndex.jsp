<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
</style>

<script type="text/javascript">
	function hello(rsp_msg) {
		alert(rsp_msg.message);
	}
</script>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin.do?action=adminPageEntryIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						员工姓名：<input type="text" />
					</td>
					<td>
						<label>上班类型：</label>
						<select class="combox" name="status" id="entry_status">
							<option value="">所有</option>
							<option value="1">正常上班</option>
							<option value="2">调休加班</option>
							<option value="3">带薪加班</option>
							<option value="4">倍薪加班</option>
						</select>
					</td>
					<td>
						工作日期：<input type="text" class="date" />
					</td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
				</ul>
			</div>
		</div>
	</form>
</div>

<!-- Body -->	
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar" style="float:right">
			<li><a treeicon="icon-edit" class="icon" href="app/admin.do?action=adminPageEntryApprovalIndex" target="navTab" rel="admin_staffWorkView"><span class="icon-edit">工作安排查看</span></a></li>
		</ul>
		<ul class="toolBar">
			<li><a class="add" href="app/admin.do?action=adminPageEntryDetail" target="dialog" title="添加工作安排" width="900" height="500"><span>添加工作安排</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" href="app/admin.do?action=adminOprEntryRemove&id={sid}" target="ajaxTodo" title="确定要删除吗?" callback="hello"><span>删除</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="app/admin.do?action=adminPageEntryDetail&id={sid}" target="dialog" title="修改工作安排" width="900" height="500"><span>修改</span></a></li>
			<!--
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
			-->
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">工作日期</th>
				<th align="center">工作时间</th>
				<th align="center">姓名</th>
				<th align="center">上班类型</th>
				<th align="center">工作内容</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid" rel="1">
				<td>2012-02-27</td>
				<td>08:30 - 17:30</td>
				<td>王伟平</td>
				<td>正常上班</td>
				<td></td>
				<td><a href="app/admin.do?action=adminPageStaffAttendanceOnPunch&id=1" class="oplink" target="dialog" title="员工工作安排编辑" width="550" height="250" rel="admin_staffWorkEdit-1">编辑</a></td>
				<td><a href="app/admin.do?action=adminPageStaffAttendanceOnTravel&id=1" class="oplink" target="ajaxToDo" title="确定要删除吗？"rel="admin_staffWorkRemove-1">删除</a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>2012-02-27</td>
				<td>08:30 - 17:30</td>
				<td>王伟平</td>
				<td>正常上班</td>
				<td></td>
				<td><a href="app/admin.do?action=adminPageStaffAttendanceOnPunch&id=1" class="oplink" target="dialog" title="员工工作安排编辑" width="550" height="250" rel="admin_staffWorkEdit-2">编辑</a></td>
				<td><a href="app/admin.do?action=adminPageStaffAttendanceOnTravel&id=1" class="oplink" target="ajaxToDo" title="确定要删除吗？">删除</a></td>
			</tr>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
				<option value="200">200</option>
			</select>
			<span>条，共${totalCount}条</span>
		</div>
		
		<div class="pagination" targetType="navTab" totalCount="200" numPerPage="20" pageNumShown="10" currentPage="1"></div>

	</div>
		
	</form>
</div>