<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<style>
	a.op_enable {color: blue; text-decoration: underline;}
	a.op_disable {color: #999; text-decoration: underline; cursor: text;}
</style>

<script>
	function callback_finalizeDone() {
		// 重新加载当前的navTab
		navTab.reload(navTab.getCurrentTabUrl(), {navTabId: navTab.getCurrentTabId()});
	}
</script>

<table class="table" width="100%" layoutH="75">
	<thead>
		<tr>
			<th align="center">申请单号</th>
			<th align="center">申请类型</th>
			<th align="center">申请人</th>
			<th align="center">申请时间</th>
			<th align="center">审批状态</th>
			<th align="center">审批环节</th>
			<th align="center">审批结果</th>
			<th align="center">审批记录</th>
			<th align="center">审批详细</th>
			<c:if test="${!isOnApproval}">
			<th align="center">操作</th>
			</c:if>
		</tr>
	</thead>
	<tbody>
		<logic:present name="dataList">
			<logic:iterate name="dataList" property="items" id="entity">
				<tr target="entry_id" rel="${entity.id}">
					<td>${entity.formNo}</td>
					<td>${entity.applyFormType.processTypeName}</td>
					<td>${entity.employee.empName}</td>
					<td><fmt:formatDate  value="${entity.entryDateTime}" pattern="yyyy-MM-dd hh:mm" /></td>
					<c:choose>
						<c:when test="${entity.applyForm eq null || fn:length(entity.applyForm) == 0}"><td style="background-color: #ddd">审批结束</td></c:when>
						<c:otherwise><td style="background-color: #FFBD5A">审批中</td></c:otherwise>
					</c:choose>
					<td>
						<c:choose>
							<c:when test="${entity.applyForm eq null || fn:length(entity.applyForm) == 0}">---</c:when>
							<c:otherwise>
								<c:if test="${entity.currentProcessForm ne null}">
									${entity.currentProcessForm.toDepartmentNames}-${entity.currentProcessForm.toPositionNames}
									<c:choose>
										<c:when test="${entity.currentProcessForm.taskType eq 1 || entity.currentProcessForm.taskType eq 2}">(校区)</c:when>
										<c:when test="${entity.currentProcessForm.taskType eq 3 || entity.currentProcessForm.taskType eq 4}">(总部)</c:when>
										<c:otherwise>未知</c:otherwise>
									</c:choose>
								</c:if>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${entity.applyForm ne null && fn:length(entity.applyForm) > 0}">---</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${entity.auditState eq 2}">审批通过</c:when>
									<c:when test="${entity.auditState eq 3}">审批未通过</c:when>
									<c:when test="${entity.auditState eq 4}">审批退回</c:when>
									<c:otherwise>---</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS')}">
								<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${entity.id}&view=audit" target="dialog" title="查看‘${entity.employee.empName}’人资申请单-${entity.formNo} 审批记录" width="600" height="320" rel="dia_myformapplication_audit_${entity.id}">审批记录</a></td>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_HRM_DEVELOP_VIEWAPPROVALS')}">
								<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${entity.id}&op=view" target="dialog" title="查看‘${entity.employee.empName}’人资申请单-${entity.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${entity.id}">详细</a></td>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<c:if test="${!isOnApproval}">
					<td align="center">
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_HRM_DEVELOP_FINALIZE')}">
								<c:choose>
									<c:when test="${entity.applyFormType.processTypeKey eq 'PROCESS_MEMBER_BERGULAR'}">
										<c:choose>
											<c:when test="${entity.auditState eq 2 && entity.operationState eq 0}"><a target="dialog" href="app/hrm/develop.do?action=actionDevelopFinalize&id=${entity.id}&state=2&op=dialog" class="op_enable" title="确定要进行转正操作吗?" callback="callback_finalizeDone()" mask="true">转正</a></c:when>
											<c:otherwise><a href="javascript:void(0);" class="op_disable">转正</a></c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${entity.applyFormType.processTypeKey eq 'PROCESS_MEMBER_PROMOTION'}">
										<c:choose>
											<c:when test="${entity.auditState eq 2 && entity.operationState eq 0}"><a target="dialog" href="app/hrm/develop.do?action=actionDevelopFinalize&id=${entity.id}&state=6&op=dialog" class="op_enable" title="确定要进行晋升操作吗?" mask="true">晋升</a></c:when>
											<c:otherwise><a href="javascript:void(0);" class="op_disable">晋升</a></c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${entity.applyFormType.processTypeKey eq 'PROCESS_MEMBER_FAIRWELL'}">
										<c:choose>
											<c:when test="${entity.auditState eq 2 && entity.operationState eq 0}"><a target="dialog" href="app/hrm/develop.do?action=actionDevelopFinalize&id=${entity.id}&state=4&op=dialog" class="op_enable" title="确定要进行离职操作吗?" mask="true">离职</a></c:when>
											<c:otherwise><a href="javascript:void(0);" class="op_disable">离职</a></c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${entity.applyFormType.processTypeKey eq 'PROCESS_MEMBER_TRANSFER'}">
										<c:choose>
											<c:when test="${entity.auditState eq 2 && entity.operationState eq 0}"><a target="dialog" href="app/hrm/develop.do?action=actionDevelopFinalize&id=${entity.id}&state=3&op=dialog" class="op_enable" title="点击进行调动操作..." mask="true">调动</a></c:when>
											<c:otherwise><a href="javascript:void(0);" class="op_disable">调动</a></c:otherwise>
										</c:choose>
									</c:when>
								</c:choose>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					</c:if>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>