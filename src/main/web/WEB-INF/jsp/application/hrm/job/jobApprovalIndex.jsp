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
	<form onsubmit="return navTabSearch(this);" action="app/hrm.do?action=hrmPageJobApprovalIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>招聘校区：</label>
						<select class="combox" name="school" id="entry_school">
							<option value="">所有校区</option>
							<option value="1">临安校区</option>
							<option value="2">柯桥校区</option>
							<option value="3">萧山校区</option>
						</select>
					</td>
					<td>
						<label>招聘部门：</label>
						<select class="combox" name="dept" id="entry_dept">
							<option value="">所有</option>
							<option value="1">教研部</option>
						</select>
					</td>
					<td>
						岗位名称：<input type="text"  name="entry_name"/>
					</td>
					<td>
						<label>招聘状态：</label>
						<select class="combox" name="status" id="entry_status">
							<option value="">所有</option>
							<option value="1">招聘中</option>
							<option value="1">已结束</option>
						</select>
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
			<li><a treeicon="icon-edit" class="icon" href="app/hrm.do?action=hrmJobIndex" target="navTab" rel="hrm_entryIndex"><span class="icon-edit">返回当前招聘</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">岗位名称</th>
				<th align="center">招聘人数</th>
				<th align="center">应聘人数</th>
				<th align="center">招聘校区</th>
				<th align="center">招聘部门</th>
				<th align="center">招聘范围</th>
				<th align="center">总部审批</th>
				<th align="center">招聘状态</th>
				<th align="center">岗位详细</th>
				<th align="center">审批</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid" rel="1">
				<td>产品经理</td>
				<td>2</td>
				<td>20</td>
				<td>杭州总部 总经办</td>
				<td>教研部</td>
				<td>内外兼招</td>
				<td>招聘中</td>
				<td>待审批</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="详细信息" width="900" height="500">详细</a></td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1&op=approval" target="dialog" title="审批并发布" width="900" height="500">审批并发布</a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>产品经理</td>
				<td>2</td>
				<td>20</td>
				<td>杭州总部 总经办</td>
				<td>教研部</td>
				<td>内外兼招</td>
				<td>招聘中</td>
				<td>审批退回</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="详细信息" width="900" height="500">详细</a></td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1&op=approval" target="dialog" title="审批并发布" width="900" height="500"></a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>产品经理</td>
				<td>2</td>
				<td>20</td>
				<td>杭州总部 总经办</td>
				<td>教研部</td>
				<td>内外兼招</td>
				<td>招聘中</td>
				<td>审批通过</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="详细信息" width="900" height="500">详细</a></td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1&op=approval" target="dialog" title="审批并发布" width="900" height="500"></a></td>
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