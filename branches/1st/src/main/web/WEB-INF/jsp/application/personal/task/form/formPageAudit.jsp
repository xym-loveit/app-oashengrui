<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
</style>

<script>
	$(function(){
		
	});
</script>

<form method="post" action="app/personal/task.do?action=actionSaveTaskApproval" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<!-- SearchBar -->
	<div class="pageHeader">
		
		<table cellspacing="10" cellpadding="10" style="border-spacing:12; width:50%; float: left;">
			<tr>
				<td nowrap style="width:60px">申请时间：</td>
				<td>
					<input type="text" class="required" style="width: 96%" name="applyDate" value="<fmt:formatDate  value='${trackForm.taskApplyDate}' pattern='yyyy-MM-dd' />" readonly />
				</td>
			</tr>
			<tr>
				<td nowrap style="width:60px">申请${auditType eq 1 ? '完成在' : '延期到'}：</td>
				<td>
					<input type="text" class="required" style="width: 96%" name="applyDate" value="<fmt:formatDate value='${trackForm.taskApplyFinalizedDate}' pattern='yyyy-MM-dd' />" readonly />
				</td>
			</tr>
			<tr>
				<td nowrap style="vertical-align: top;">${auditType eq 1 ? '完成描述' : '延期原因'}：</td>
				<td colspan="4" >
					<textarea name="meto" rows="2" style="width:99%" readonly >${trackForm.taskApplyMeto}</textarea>
				</td>
			</tr>
		</table>
		
		<table cellspacing="10" cellpadding="10" style="border-spacing:12; width:50%; float: left;">
			<tr>
				<td nowrap style="width:60px">审批结果：</td>
				<td>
					<input type="radio" name="taskAuditState" value="1" checked="checked" />通过&nbsp;
					<input type="radio" name="taskAuditState" value="0" />不通过
				</td>
			</tr>
			<tr>
				<td nowrap style="width:60px">确认${auditType eq 1 ? '完成到' : '延期到'}：</td>
				<td>
					<input type="text" class="date required" style="width: 96%" name="taskAuditFinalizedDate" value="<fmt:formatDate value='${trackForm.taskApplyFinalizedDate}' pattern='yyyy-MM-dd' />"/>
				</td>
			</tr>
			<tr>
				<td nowrap style="vertical-align: top;">审批意见：</td>
				<td colspan="4" >
					<textarea name="auditMeto" rows="2" style="width:99%"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="right"><div class="buttonActive" style="float:right"><div class="buttonContent"><button type="submit">确定</button></div></div></td>
			</tr>
		</table>
		
	</div>
	
	<input type="hidden" name="auditType" value="${auditType}" /> 
	<input type="hidden" name="trackId" value="${trackForm.id}" />
	<input type="hidden" name="taskId" value="${entity.id}" />
	
	
	<!-- 审批记录 -->
	<%@ include file="../data/dataTaskAuditRecords.jsp" %>
	

</form>
