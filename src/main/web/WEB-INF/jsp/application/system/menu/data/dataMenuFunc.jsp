<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<table class="table" width="100%" layoutH="8">
	<thead>
		<tr>
			<th align="center">功能名称</th>
			<th align="center">功能键值</th>
			<th align="center">功能描述 </th>
			<th align="center">编辑</th>
			<th align="center">删除</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="menuFuncs">
			<logic:iterate name="menuFuncs" id="entity">
				<tr target="funcid" rel="${entity.id}">
					<td>${entity.funcName}</td>
					<td>${entity.funcKey}</td>
					<td>${entity.funcDesc}</td>
					<td>
						<a href="app/admin.do?action=adminPageStaffAttendanceOnPunch&id=1" class="oplink" target="dialog" title="菜单功能编辑" width="550" height="250" rel="admin_dutypunch-1">编辑</a>
					</td>
					<td>
						<a href="app/admin.do?action=adminPageStaffAttendanceOnPunch&id=1" class="oplink" target="dialog" title="菜单功能删除" width="550" height="250" rel="admin_dutypunch-1">删除</a>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>