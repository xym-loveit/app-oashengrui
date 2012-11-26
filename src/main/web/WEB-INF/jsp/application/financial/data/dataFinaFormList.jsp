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

<table class="table" width="100%" layoutH="${recordPage eq null ? 142 : 148}">
	<thead>
		<tr>
			<th align="center">申请单号</th>
			<th align="center">申请类型</th>
			<th align="center">申请人</th>
			<th align="center">申请金额</th>
			<th align="center">所属校区</th>
			<th align="center">所属部门</th>
			<th align="center">申请时间</th>
			<th align="center">审批状态</th>
			<th align="center">审批环节</th>
			<th align="center">审批结果</th>
			<th align="center">审批记录</th>
			<th align="center">查看</th>
			<th align="center">编辑</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="dataList">
			<logic:iterate name="dataList" property="items" id="entity">
				<tr target="entry_id" rel="${entity.id}">
					<td>${entity.formNo}</td>
					<td>${entity.applyFormType.processTypeName}</td>
					<td>${entity.employee ne null ? entity.employee.empName : ''}</td>
					<td>${entity.applyAmt}</td>
					<td>${entity.empDistrict ne null ? entity.empDistrict.districtName : ''}</td>
					<td class="${entity.empDepartment ne null && entity.empDepartment.delFlag eq 1 ? 'delflag' : ''}">${entity.empDepartment ne null ? entity.empDepartment.depName : ''}</td>
					<td><fmt:formatDate  value="${entity.entryDateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
					<c:choose>
						<c:when test="${entity.applyForm eq null || fn:length(entity.applyForm) == 0}"><td style="background-color: #ddd">审批结束</td></c:when>
						<c:otherwise><td style="background-color: #FFBD5A">审批中</td></c:otherwise>
					</c:choose>
					<td>
						<c:choose>
							<c:when test="${entity.applyForm eq null || fn:length(entity.applyForm) == 0}">---</c:when>
							<c:otherwise>
								<c:if test="${entity.currentProcessForm ne null}">
									<c:choose>
										<c:when test="${entity.currentProcessForm.toUserNames ne null}">审批人`${entity.currentProcessForm.toUserNames}`</c:when>
										<c:otherwise>
											${entity.currentProcessForm.toDepartmentNames}-${entity.currentProcessForm.toPositionNames}
											<c:choose>
												<c:when test="${entity.currentProcessForm.taskType eq 1 || entity.currentProcessForm.taskType eq 2}">(校区)</c:when>
												<c:when test="${entity.currentProcessForm.taskType eq 3 || entity.currentProcessForm.taskType eq 4}">(总部)</c:when>
												<c:when test="${entity.currentProcessForm.taskType eq 6 || entity.currentProcessForm.taskType eq 7 || entity.currentProcessForm.taskType eq 8}">(片区)</c:when>
												<c:otherwise>未知</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${entity.applyForm ne null && fn:length(entity.applyForm) > 0}">
								<c:choose>
									<c:when test="${entity.finalState eq 4}">审批退回</c:when>
									<c:otherwise>---</c:otherwise>
								</c:choose>
							</c:when>
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
							<c:when test="${PAGE_TYPE eq 'FE'}">
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_FINAN_EXPENSE_VIEW')}">
										<a class="oplink" href="app/finan/expense.do?action=diaglogFinaExpensePage&id=${entity.id}&view=audit" target="dialog" title="查看‘${entity.employee.empName}’费用申请单-${entity.formNo} 审批记录" width="600" height="320" rel="dia_finexp_audit_${entity.id}">审批记录</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${PAGE_TYPE eq 'FC'}">
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_FINAN_CONTRACT_VIEW')}">
										<a class="oplink" href="app/finan/contract.do?action=diaglogFinaContractPage&id=${entity.id}&view=audit" target="dialog" title="查看‘${entity.employee.empName}’合同申请单-${entity.formNo} 审批记录" width="600" height="320" rel="dia_fincontract_audit_${entity.id}">审批记录</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${PAGE_TYPE eq 'FP'}">
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_FINAN_PROJECT_VIEW')}">
										<a class="oplink" href="app/finan/project.do?action=diaglogFinaProjectPage&id=${entity.id}&view=audit" target="dialog" title="查看‘${entity.employee.empName}’新项目申请单-${entity.formNo} 审批记录" width="600" height="320" rel="dia_finproject_audit_${entity.id}">审批记录</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
								</c:choose>
							</c:when>	
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${PAGE_TYPE eq 'FE'}">
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_FINAN_EXPENSE_VIEW')}">
										<a class="oplink" href="app/finan/expense.do?action=diaglogFinaExpensePage&id=${entity.id}&op=view" target="dialog" title="查看‘${entity.employee.empName}’费用申请单-${entity.formNo}" width="1150" height="640" rel="dia_finexp_view_${entity.id}">详细</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${PAGE_TYPE eq 'FC'}">
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_FINAN_CONTRACT_VIEW')}">
										<a class="oplink" href="app/finan/contract.do?action=diaglogFinaContractPage&id=${entity.id}&op=view" target="dialog" title="查看‘${entity.employee.empName}’合同申请单-${entity.formNo}" width="1150" height="640" rel="dia_fincontract_view_${entity.id}">详细</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${PAGE_TYPE eq 'FP'}">
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_FINAN_PROJECT_VIEW')}">
										<a class="oplink" href="app/finan/project.do?action=diaglogFinaProjectPage&id=${entity.id}&op=view" target="dialog" title="查看‘${entity.employee.empName}’新项目申请单-${entity.formNo}" width="1150" height="640" rel="dia_finproject_view_${entity.id}">详细</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
								</c:choose>
							</c:when>	
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${entity.finalState eq 4}">
								<c:choose>
									<c:when test="${PAGE_TYPE eq 'FE' && tm:ifGranted('_FUNCKEY_FINAN_EXPENSE_APPLY')}">
										<a class="oplink" href="app/finan/expense.do?action=diaglogFinaExpensePage&id=${entity.id}&op=edit" target="dialog" title="财务申请单编辑" width="1150" height="500" rel="dia_finexp_edit">编辑</a>
									</c:when>
									<c:when test="${PAGE_TYPE eq 'FC' && tm:ifGranted('_FUNCKEY_FINAN_CONTRACT_APPLY')}">
										<a class="oplink" href="app/finan/contract.do?action=diaglogFinaContractPage&id=${entity.id}&op=edit" target="dialog" title="合同申请单编辑" width="1150" height="500" rel="dia_fincta_edit">编辑</a>
									</c:when>
									<c:when test="${PAGE_TYPE eq 'FP' && tm:ifGranted('_FUNCKEY_FINAN_PROJECT_APPLY')}">
										<a class="oplink" href="app/finan/project.do?action=diaglogFinaProjectPage&id=${entity.id}&op=edit" target="dialog" title="新项目申请单编辑" width="1150" height="500" rel="dia_finprj_edit">编辑</a>
									</c:when>
									<c:otherwise>---</c:otherwise>
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