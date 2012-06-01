<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	function callback_roleRemove(id) {
		if ($("#drole-" + id).size() > 0) {
			$("#drole-" + id).fadeOut("slow");
		}
	}
</script>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin.do?action=adminPageEntryIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>角色名称：</label>
						<input type="text" />
					</td>
					<td>
						<label>角色类型：</label>
						<select class="combox" name="type" id="entry_type">
							<option value="">所有</option>
							<option value="1">总部</option>
							<option value="2">校区</option>
							<option value="3">片区</option>
						</select>
					</td>
					<td>
						<label>角色描述：</label>
						<input type="text" />
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
		<ul class="toolBar">
			<li><a class="add" href="app/system/role.do?action=dialogRolePage" target="dialog" title="添加新权限组" mask="true" width="504" height="328" rel="dia_sys_roleadd"><span>添加新权限组</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">序号</th>
				<th align="center">角色名称</th>
				<th align="center">角色类型</th>
				<th align="center">角色描述</th>
				<th align="center">详细</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="roles">
				<logic:iterate name="roles" id="role" indexId="idx">
					<tr id="drole-${role.id}">
						<td>${idx+1}</td>
						<td>${role.roleName}</td>
						<td>${role.roleType == 0 ? '总部' : (role.roleType == 1 ? '校区' : (role.roleType == 2 ? '片区' : '/'))}</td>
						<td>${role.roleDesc}</td>
						<td>
							<a href="app/system/role.do?action=dialogRolePage&roleId=${role.id}&view" target="dialog" title="权限组详细" class="oplink" width="504" height="328" rel="sysmgr_roleview_${idx}">详细</a>
						</td>
						<td>
							<a href="app/system/role.do?action=dialogRolePage&roleId=${role.id}" target="dialog" title="权限组编辑" class="oplink" width="504" height="328" rel="sysmgr_roleedit_${idx}">编辑</a>
						</td>
						<td>
							<a href="app/system/role.do?action=actionRemoveRole&roleId=${role.id}" target="ajaxTodo" title="确定删除该权限组吗？" class="oplink" callback="callback_roleRemove(${role.id})">删除</a>
						</td>
					</tr>
				</logic:iterate>
			</logic:present>
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