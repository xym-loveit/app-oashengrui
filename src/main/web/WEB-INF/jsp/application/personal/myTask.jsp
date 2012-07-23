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
	.dgreen {color: green;}
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
						<label>任务类型：</label>
						<select class="combox" name="type" id="task_type">
							<option value="">所有</option>
							<option value="1">公司战略</option>
							<option value="2">公司信息化</option>
						</select>
					</td>
					<td>
						<label>任务状态：</label>
						<select class="combox" name="status" id="task_status">
							<option value="">所有</option>
							<option value="1">未完成</option>
							<option value="2">已完成</option>
						</select>
					</td>
					<td>
						任务名称：<input type="text" />
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
		<ul class="toolBar" style="overflow:hidden">
			<li style="float:right"><a treeicon="icon-records" class="icon" href="app/personal/task.do?action=pageTaskLaunched" target="navTab" rel="dmp_workplan"><span class="icon-records">我发起的任务</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">任务类型</th>
				<th align="center">任务名称</th>
				<th align="center">发起人</th>
				<th align="center">负责/参与</th>
				<th align="center">任务状态</th>
				<th align="center">剩余时间</th>
				<th align="center">开始时间</th>
				<th align="center">结束时间</th>
				<th align="center">实际完成时间</th>
				<th align="center">完成申请</th>
				<th align="center">延期申请</th>
				<th align="center">详细</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid" rel="1">
				<td>公司战略</td>
				<td>整理公司学管部流程</td>
				<td>罗佳驹</td>
				<td>参与</td>
				<td>未开始</td>
				<td>剩余10天</td>
				<td>2012-02-12</td>
				<td>2012-02-22</td>
				<td>2012-02-19</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="任务审批" width="900" height="500" class="oplink" rel="admin_taskapproval-1">审批</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="任务编辑" width="900" height="500" class="oplink" rel="admin_taskedit-1">编辑</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryRemove&id=1" target="ajaxTodo" title="确定要删除吗" width="900" height="500" class="oplink" rel="admin_taskdel-1">删除</a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司战略</td>
				<td>整理公司学管部流程</td>
				<td>罗佳驹</td>
				<td>参与</td>
				<td class='dgreen'>进行中</td>
				<td>剩余10天</td>
				<td>2012-02-12</td>
				<td>2012-02-22</td>
				<td>2012-02-19</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="任务审批" width="900" height="500" class="oplink" rel="admin_taskapproval-2">审批</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="任务编辑" width="900" height="500" class="oplink" rel="admin_taskedit-2">编辑</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryRemove&id=1" target="ajaxTodo" title="确定要删除吗" width="900" height="500" class="oplink" rel="admin_taskdel-2">删除</a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司战略</td>
				<td>整理公司学管部流程</td>
				<td>罗佳驹</td>
				<td>参与</td>
				<td style='color: yellow'>已延期</td>
				<td>剩余10天</td>
				<td>2012-02-12</td>
				<td>2012-02-22</td>
				<td>2012-02-19</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="任务审批" width="900" height="500" class="oplink" rel="admin_taskapproval-3">审批</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="任务编辑" width="900" height="500" class="oplink" rel="admin_taskedit-3">编辑</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryRemove&id=1" target="ajaxTodo" title="确定要删除吗" width="900" height="500" class="oplink" rel="admin_taskdel-3">删除</a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司战略</td>
				<td>整理公司学管部流程</td>
				<td>罗佳驹</td>
				<td>参与</td>
				<td>已完成</td>
				<td>剩余10天</td>
				<td>2012-02-12</td>
				<td>2012-02-22</td>
				<td>2012-02-19</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="任务审批" width="900" height="500" class="oplink" rel="admin_taskapproval-4">审批</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="任务编辑" width="900" height="500" class="oplink" rel="admin_taskedit-4">编辑</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryRemove&id=1" target="ajaxTodo" title="确定要删除吗" width="900" height="500" class="oplink" rel="admin_taskdel-4">删除</a>
				</td>
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