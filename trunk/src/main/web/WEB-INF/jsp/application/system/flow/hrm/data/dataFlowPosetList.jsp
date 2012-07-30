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
			<th align="center">职位名称</th>
			<th align="center">流程状态</th>
			<th align="center">流程配置</th>
			<th align="center">配置清空</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="posetList">
			<logic:iterate name="posetList" id="entity" indexId="idx">
				<tr target="typeId" rel="${entity.id}" id="mfunc-${entity.id}">
					<td>${idx+1}</td>
					<td>${entity.posetName}</td>
					<td>
						<c:choose>
							<c:when test="${filteredDefs ne null && fn:length(filteredDefs) gt 0 && filteredDefs[entity.id] ne null}">已配置</c:when>
							<c:otherwise>未配置</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_FLOW_HRM_PROCESS_CONFIGURE')}">
								<a href="app/flow/hrm.do?action=pageFlowPosetConfigure&procTypeId=${rootTypeId}&posetId=${entity.id}" class="oplink" target="navTab" title="流程`${entity.posetName}`配置" width="400" height="245" rel="sys_flowEdit-${entity.id}">流程配置</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_FLOW_HRM_PROCESS_REMOVE')}">
								<a href="app/flow/hrm.do?action=actionFlowCleanup&procTypeId=${rootTypeId}&posetId=${entity.id}" class="oplink" target="ajaxTodo" title="确定要删除该审批类型吗?" rel="sys_flowDel-${entity.id}" callback="callback_funcRemove(${entity.id})">配置清空</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>