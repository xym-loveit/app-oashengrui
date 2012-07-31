<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

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
				<tr target="_var_ftypeid_sub" rel="${entity.id}" id="mfunc-${entity.id}">
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
						<c:choose>
							<c:when test="${(typeSlug eq 'hrm' && tm:ifGranted('_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE')) || (typeSlug eq 'finance' && tm:ifGranted('_FUNCKEY_FLOW_FINAN_PROC_APPROVE'))}">
								<a href="app/flow/${typeSlug}.do?action=pageFlowConfigure&procTypeId=${entity.id}" class="oplink" target="navTab" title="流程`${entity.processTypeName}`配置" width="400" height="245" rel="sys_flowEdit-${entity.id}">流程配置</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${(typeSlug eq 'finance' && tm:ifGranted('_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT'))}">
								<a href="app/flow/${typeSlug}.do?action=dialogFlowTypePage&rootTypeId=${entity.processTypeParent.id}&id=${entity.id}" class="oplink" target="dialog" title="审批类型`${entity.processTypeName}`编辑" width="400" height="245" rel="sys_flowEdit-${entity.id}">编辑</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${(typeSlug eq 'finance' && tm:ifGranted('_FUNCKEY_FLOW_FINAN_PROC_TYPE_REMOVE'))}">
								<a href="app/system/school/department/position.do?action=actionRemoveDepartmentPosition&posId=${entity.id}" class="oplink" target="ajaxTodo" title="确定要删除该审批类型吗?" rel="sys_flowDel-${entity.id}" callback="callback_funcRemove(${entity.id})">删除</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>