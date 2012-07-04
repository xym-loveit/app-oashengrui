<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	function callback_procTaskRemove(wrap_id, procDefId) {
		$("#ajBoxFlowConf_"+wrap_id).loadUrl("app/flow.do?action=actionLoadProcessTasks&procDefId="+procDefId, {}, function(){
		});
	}
</script>

<table class="table" width="100%" layoutH="8">
	<thead>
		<tr>
			<th align="center">步骤</th>
			<th align="center">流程节点类型</th>
			<th align="center">待审批部门</th>
			<th align="center">待审批岗位</th>
			<th align="center">编辑</th>
			<th align="center">删除</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="processDef">
			<logic:iterate name="processDef" property="processTasks" id="entity" indexId="idx">
				<tr target="typeId" rel="${entity.id}" id="mfunc-${entity.id}">
					<td>${idx+1}</td>
					<td>
						<c:choose>
							<c:when test="${entity.processTaskType eq 1}">账号所在校区(本部门)</c:when>
							<c:when test="${entity.processTaskType eq 2}">账号所在校区(某部门)</c:when>
							<c:when test="${entity.processTaskType eq 3 || entity.processTaskType eq 4}">总部部门</c:when>
							<c:otherwise>未知</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${entity.processTaskType eq 1}">校区部门</c:when>
							<c:when test="${entity.processTaskType eq 3}">总部对口部门</c:when>
							<c:when test="${entity.processTaskType eq 2 || entity.processTaskType eq 4}">${entity.toDepartmentNames}</c:when>
							<c:otherwise>未知</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${entity.processTaskType eq 1}">校区岗位</c:when>
							<c:when test="${entity.processTaskType eq 3}">总部对口岗位</c:when>
							<c:when test="${entity.processTaskType eq 2 || entity.processTaskType eq 4}">${entity.toPositionNames}</c:when>
							<c:otherwise>未知</c:otherwise>
						</c:choose>
					</td>
					<td>
						<a href="app/flow.do?action=dialogFlowTaskConfigurationPage&procDefId={_var_fdefid}&procTaskId=${entity.id}" class="oplink" target="dialog" title="流程节点编辑" width="215" height="400" rel="sys_flowTaskEdit-${entity.id}">编辑</a>
					</td>
					<td>
						<a href="app/flow.do?action=actionRemoveProcessTask&procTaskId=${entity.id}" class="oplink" target="ajaxTodo" title="确定要删除该流程节点吗?" rel="sys_flowDel-${entity.id}" callback="callback_procTaskRemove(${entity.processDefinition.processType.id}, ${entity.processDefinition.id})">删除</a>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>