<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<table class="table" width="100%" layoutH="8">
	<thead>
		<tr>
			<th align="center">序号</th>
			<th align="center">类别名称</th>
			<th align="center">类别标识</th>
			<th align="center">类别说明</th>
			<th align="center">流程状态</th>
			<th align="center">流程配置</th>
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
						<c:choose>
							<c:when test="${fn:length(entity.processDefinitions) gt 0}">已配置</c:when>
							<c:otherwise>未配置</c:otherwise>
						</c:choose>
					</td>
					<td>
						<a href="app/flow.do?action=dialogFlowTypePage&rootTypeId=${entity.processTypeParent.id}&id=${entity.id}" class="oplink" target="dialog" title="审批类型`${entity.processTypeName}`编辑" width="400" height="245" rel="sys_flowEdit-${entity.id}">流程配置</a>
					</td>
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