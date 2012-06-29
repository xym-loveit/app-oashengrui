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
			<th align="center">序号</th>
			<th align="center">节点类型</th>
			<th align="center">待审批部门</th>
			<th align="center">待审批岗位</th>
			<th align="center">编辑</th>
			<th align="center">删除</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="types">
			<logic:iterate name="types" id="entity" indexId="idx">
				<tr target="typeId" rel="${entity.id}" id="mfunc-${entity.id}">
					<td>${idx+1}</td>
					<td>${entity.processTypeName}</td>
					<td>${entity.processTypeKey}</td>
					<td>${entity.processTypeDesc}</td>
					<td>
						<a href="app/flow.do?action=dialogFlowTypePage&rootTypeId=${entity.processTypeParent.id}&id=${entity.id}" class="oplink" target="dialog" title="审批类型`${entity.processTypeName}`编辑" width="400" height="245" rel="sys_flowEdit-${entity.id}">编辑</a>
					</td>
					<td>
						<a href="app/system/school/department/position.do?action=actionRemoveDepartmentPosition&posId=${entity.id}" class="oplink" target="ajaxTodo" title="确定要删除该审批类型吗?" rel="sys_flowDel-${entity.id}" callback="callback_funcRemove(${entity.id})">删除</a>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>