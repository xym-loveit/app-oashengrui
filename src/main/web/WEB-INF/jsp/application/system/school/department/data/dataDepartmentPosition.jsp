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
			<th align="center">岗位名称</th>
			<th align="center">岗位说明</th>
			<th align="center">编辑</th>
			<th align="center">删除</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="positions">
			<logic:iterate name="positions" id="entity">
				<tr target="posId" rel="${entity.id}" id="mfunc-${entity.id}">
					<td>${entity.positionName}</td>
					<td>${entity.positionDesc}</td>
					<td>
						<a href="app/system/school/department/position.do?action=dialogSchoolDepartmentPositionPage&posId=${entity.id}" class="oplink" target="dialog" title="岗位编辑" width="504" height="275" rel="sys_menufuncedit-${entity.id}">编辑</a>
					</td>
					<td>
						<a href="app/system/school/department/position.do?action=actionRemoveDepartmentPosition&posId=${entity.id}" class="oplink" target="ajaxTodo" title="岗位删除" width="550" height="250" title="确定要删除该岗位吗?" rel="sys_menufuncdel-${entity.id}" callback="callback_funcRemove(${entity.id})">删除</a>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>