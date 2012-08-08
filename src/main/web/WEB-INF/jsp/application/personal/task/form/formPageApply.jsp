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

<form method="post" action="app/personal/task.do?action=actionSaveTaskApply" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<!-- SearchBar -->
	<div class="pageHeader">
		<table cellspacing="10" cellpadding="10" style="border-spacing:12; width:100%">
			<tr>
				<td nowrap style="width:60px">申请类型：</td>
				<td>
					<input type="text" class="required" style="width: 96%" value="${applyType eq 1 ? '完成申请' : '延期申请'}" readonly />
				</td>
			</tr>
			<tr>
				<td nowrap style="width:60px">申请时间：</td>
				<td>
					<input type="text" class="date required" style="width: 96%" name="applyDate" value="<fmt:formatDate  value='${today}' pattern='yyyy-MM-dd' />"/>
				</td>
				<td nowrap style="width:60px">申请${applyType eq 1 ? '完成' : '延期'}时间：</td>
				<td>
					<input type="text" class="date required" style="width: 96%" name="finalizedDate"/>
				</td>
			</tr>
			<tr>
				<td nowrap style="vertical-align: top;">${applyType eq 1 ? '完成描述' : '延期原因'}：</td>
				<td colspan="4" >
					<textarea name="meto" rows="2" style="width:99%"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="right"><div class="buttonActive" style="float:right"><div class="buttonContent"><button type="submit">提交申请</button></div></div></td>
			</tr>
		</table>
	</div>
	
	<!-- 审批记录 -->
	<%@ include file="../data/dataTaskAuditRecords.jsp" %>
	
	<input type="hidden" name="applyType" value="${applyType}" />
	<input type="hidden" name="taskId" value="${entity.id}" />
</form>
