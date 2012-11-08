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
	td.auditstate2 {color: #09A303;}
	td.auditstate3 {color: #DA251C;}
	td.auditstate4 {color: #08223B}
</style>

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
			<th align="center">申请单查看</th>
			<th align="center">申请单编辑</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="dataList">
			<logic:iterate name="dataList" property="items" id="entity">
				<tr target="entry_id" rel="${entity.id}">
					<td>${entity.formNo}</td>
					<td>${entity.applyFormType.processTypeName}</td>
					<td>${entity.employee.empName}</td>
					<td><fmt:formatDate  value="${entity.applyDate}" pattern="yyyy-MM-dd" /></td>
					<c:choose>
						<c:when test="${entity.finalState eq 2 || entity.finalState eq 3}"><td style="background-color: #ddd">审批结束</td></c:when>
						<c:otherwise><td style="background-color: #FFBD5A">审批中</td></c:otherwise>
					</c:choose>
					<td>
						<c:choose>
							<c:when test="${entity.applyForm eq null || fn:length(entity.applyForm) == 0}">---</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${entity.currentProcessForm ne null}">
										${entity.currentProcessForm.toDepartmentNames}-${entity.currentProcessForm.toPositionNames}
										<c:choose>
											<c:when test="${entity.currentProcessForm.taskType eq 1 || entity.currentProcessForm.taskType eq 2}">(校区)</c:when>
											<c:when test="${entity.currentProcessForm.taskType eq 3 || entity.currentProcessForm.taskType eq 4}">(总部)</c:when>
											<c:when test="${entity.currentProcessForm.taskType eq 6 || entity.currentProcessForm.taskType eq 7 || entity.currentProcessForm.taskType eq 8}">(片区)</c:when>
											<c:when test="${entity.currentProcessForm.taskType eq 5}">(调动/晋升校区)</c:when>
											<c:otherwise>未知</c:otherwise>
										</c:choose>                                 
									</c:when>
									<c:otherwise>---</c:otherwise>
								</c:choose>                                            
							</c:otherwise>
						</c:choose>
					</td>
					<td class="auditstate${entity.latestAuditState ne null ? entity.latestAuditState : 0}">
						<c:choose>
							<c:when test="${entity.latestAuditState eq 2}">审批通过</c:when>
							<c:when test="${entity.latestAuditState eq 3}">审批不通过</c:when>
							<c:when test="${entity.latestAuditState eq 4}">审批退回</c:when>
							<c:otherwise>---</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_APPLICATION_VIEW')}">
								<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${entity.id}&view=audit" target="dialog" title="查看‘${entity.employee.empName}’人资申请单-${entity.formNo} 审批记录" width="600" height="320" rel="dia_myformapplication_audit_${entity.id}">审批记录</a></td>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_APPLICATION_VIEW')}">
								<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${entity.id}&op=view" target="dialog" title="查看‘${entity.employee.empName}’人资申请单-${entity.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${entity.id}">详细</a></td>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${entity.finalState eq 4}">
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_APPLICATION_VIEW')}">
										<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${entity.id}" target="dialog" title="编辑‘${entity.employee.empName}’人资申请单-${entity.formNo}" width="1000" height="485" rel="dia_myformapplication_edit_${entity.id}">编辑</a></td>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>---</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>