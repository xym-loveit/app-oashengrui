<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<table class="table" width="100%" layoutH="142">
	<thead>
		<tr>
			<th align="center">申请类型</th>
			<th align="center">申请人</th>
			<th align="center">申请金额</th>
			<th align="center">所属校区</th>
			<th align="center">所属部门</th>
			<th align="center">申请时间</th>
			<th align="center">审批状态</th>
			<th align="center">审批环节</th>
			<th align="center">审批结果</th>
			<th align="center">申请单查看</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="employeeExpenseInfo">
			<logic:iterate name="employeeExpenseInfo" property="items" id="entity">
				<tr target="entry_id" rel="${entity.id}">
					<td>${entity.applyFormType.processTypeName}</td>
					<td>${entity.employee ne null ? entity.employee.empName : ''}</td>
					<td>${entity.applyAmt}</td>
					<td>${entity.empDistrict ne null ? entity.empDistrict.districtName : ''}</td>
					<td>${entity.empDepartment ne null ? entity.empDepartment.depName : ''}</td>
					<td><fmt:formatDate  value="${entity.applyDate}" pattern="yyyy-MM-dd" /></td>
					<td>
						<c:choose>
							<c:when test="${entity.auditState eq 1}">审批中</c:when>
							<c:otherwise>审批结束</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:if test="${entity.currentProcessForm ne null}">
							${entity.currentProcessForm.toDepartmentNames}-${entity.currentProcessForm.toPositionNames}
							<c:choose>
								<c:when test="${entity.currentProcessForm.taskType eq 1 || entity.currentProcessForm.taskType eq 2}">(校区)</c:when>
								<c:when test="${entity.currentProcessForm.taskType eq 3 || entity.currentProcessForm.taskType eq 4}">(总部)</c:when>
								<c:otherwise>未知</c:otherwise>
							</c:choose>
						</c:if>
					</td>
					<td>
						<c:choose>
							<c:when test="${entity.auditState eq 2}">审核通过</c:when>
							<c:when test="${entity.auditState eq 3}">审核未通过</c:when>
							<c:otherwise>---</c:otherwise>
						</c:choose>
					</td>
					<td><a class="oplink" href="app/finan/financial.do?action=FinanExpenseDetail&id=${entity.id}&op=view" target="dialog" title="查看${entity.employee.empName}申请单" width="1100" height="540" rel="dia_finexp_view_${entity.id}">详细</a></td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>
