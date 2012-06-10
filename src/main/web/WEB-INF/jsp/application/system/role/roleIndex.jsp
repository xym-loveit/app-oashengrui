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

<form id="pagerForm" method="post" action="app/system/role.do?action=pageRoleIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/system/role.do?action=pageRoleIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>角色名称：</label>
						<input type="text" name="roleName" rel="pagerForm" value="${roleForm ne null ? roleForm.roleName : ''}" />
					</td>
					<td>
						<label>角色类型：</label>
						<select class="combox" name="roleType" id="entry_type">
							<option value="-1">所有</option>
							<option value="0" ${roleForm ne null && roleForm.roleType eq 0 ? 'selected="selected"' : ''}>总部</option>
							<option value="1" ${roleForm ne null && roleForm.roleType eq 1 ? 'selected="selected"' : ''}>校区</option>
							<option value="2" ${roleForm ne null && roleForm.roleType eq 2 ? 'selected="selected"' : ''}>片区</option>
						</select>
					</td>
					<td>
						<label>角色描述：</label>
						<input type="text" name="roleDesc" value="${roleForm ne null ? roleForm.roleDesc : ''}" />
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
			<li><a class="add" href="app/system/role.do?action=dialogRolePage" target="dialog" title="添加新权限组" mask="true" width="504" height="348" rel="dia_sys_roleadd"><span>添加新权限组</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">序号</th>
				<th align="center">角色名称</th>
				<th align="center">角色类型</th>
				<th align="center">角色标识符</th>
				<th align="center">角色描述</th>
				<th align="center">详细</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="roles">
				<logic:iterate name="roles" property="items" id="role" indexId="idx">
					<tr id="drole-${role.id}">
						<td>${idx+1}</td>
						<td>${role.roleName}</td>
						<td>${role.roleType == 0 ? '总部' : (role.roleType == 1 ? '校区' : (role.roleType == 2 ? '片区' : '/'))}</td>
						<td>${role.roleKey}</td>
						<td>${role.roleDesc}</td>
						<td>
							<a href="app/system/role.do?action=dialogRolePage&roleId=${role.id}&view" target="dialog" title="权限组详细" class="oplink" width="504" height="348" rel="sysmgr_roleview_${idx}">详细</a>
						</td>
						<td>
							<c:choose>
								<c:when test="${role.roleEditable == 1}">
									<a href="app/system/role.do?action=dialogRolePage&roleId=${role.id}" target="dialog" title="权限组编辑" class="oplink" width="504" height="348" rel="sysmgr_roleedit_${idx}">编辑</a>
								</c:when>
								<c:otherwise>
									<label style="color:#ddd;text-decoration: line-through;" title="不能进行编辑操作">编辑</label>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${role.roleEditable == 1}">
									<a href="app/system/role.do?action=actionRemoveRole&roleId=${role.id}" target="ajaxTodo" title="确定删除该权限组吗？" class="oplink" callback="callback_roleRemove(${role.id})">删除</a>
								</c:when>
								<c:otherwise>
									<label style="color:#ddd;text-decoration: line-through;" title="不能进行删除操作">删除</label>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</logic:iterate>
			</logic:present>
		</tbody>
	</table>
	
	<!-- Pagination -->
	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
				<option value="20" ${pagingBean ne null && pagingBean.pageSize eq 20 ? 'selected="selected"' : ''}>20</option>
				<option value="50" ${pagingBean ne null && pagingBean.pageSize eq 50 ? 'selected="selected"' : ''}>50</option>
				<option value="100" ${pagingBean ne null && pagingBean.pageSize eq 100 ? 'selected="selected"' : ''}>100</option>
				<option value="200" ${pagingBean ne null && pagingBean.pageSize eq 200 ? 'selected="selected"' : ''}>200</option>
			</select>
			<span>条，共${pagingBean ne null ? pagingBean.totalItems : 0}条</span>
		</div>
		
		<div class="pagination" targetType="navTab" totalCount="${pagingBean ne null ? pagingBean.totalItems : 0}" numPerPage="${pagingBean ne null ? pagingBean.pageSize : 20}" pageNumShown="${pagingBean ne null ? pagingBean.pageNumShown : 10}" currentPage="${pagingBean ne null ? pagingBean.currentPage : 1}"></div>

	</div>
		
</div>