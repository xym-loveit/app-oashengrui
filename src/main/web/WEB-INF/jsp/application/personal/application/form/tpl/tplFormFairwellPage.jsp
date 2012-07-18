<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	#tblexp td.banner {line-height: ${op eq null || op ne 'view' ? '35px' : '25px'};font-size: 18px; font-weight: bold; text-align: center; margin: 0;}
	#tblexp td.field {background-color: #CFDBEC; line-height: ${op eq null || op ne 'view' ? '35px' : '25px'}; text-align: center; margin: 0; width: 120px; font-size: 9pt;}
	#tblexp input.textInput {float:none;margin: 5px; width: 80px;}
</style>

<table id="tblexp" cellpadding="0" cellspacing="0" width="98%" border="1" style="border-collapse: collapse; border-color: #797979; margin: 0 auto;">
	<tr>
		<td width="${op eq null || op ne 'view' ? '72%' : '100%'}" colspan="10" class="banner">员工离职申请单</td>
	</tr>
	<tr>
		<td class='field'>申请人</td>
		<td>
			<input id="inputEmpId" name="emp.id" value="" type="hidden"/>
			<input class="required" name="emp.fullName" style="width: 87%;" type="text" value="${entity ne null ? entity.employee.empName : ''}" <c:choose><c:when test="${op ne null && op eq 'view'}">readonly</c:when> <c:otherwise>postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" </c:otherwise></c:choose>/>
		</td>
		<td class='field'>性别</td>
		<td><input name="applyDate" style="width: 87%;" class="required textInput" format="yyyy-MM-dd" type="text" value="<c:if test='${entity ne null}'><fmt:formatDate value='${entity.applyDate}' pattern='yyyy-MM-dd' /></c:if>" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>></td>
		<td class='field'>出生日期</td>
		<td>
			<input name="emp.districtName" style="width: 87%;" readonly type="text" value="${entity ne null ? entity.empDistrict.districtName : ''}"/>
			<input id="inputEmpDisId" name="emp.districtId" value="" type="hidden"/>
		</td>
		<td class='field'>联系电话</td>
		<td><input name="emp.phoneNo" class="required phone" style="width: 87%;" type="text" value="${entity ne null ? entity.empPhoneNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
	</tr>
	<tr>
		<td class='field'>所属校区</td>
		<td colspan="3"><input name="contractNo" type="text" style="width: 96%" value="${entity ne null ? entity.contractNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>所属部门</td>
		<td><input name="attachCount" type="text" class="number" style="width: 87%;" value="${entity ne null ? entity.attachCount : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>岗位</td>
		<td colspan="2">
			<input name="emp.phoneNo" class="required phone" style="width: 87%;" type="text" value="${entity ne null ? entity.empPhoneNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/>
		</td>
	</tr>
	<tr>
		<td class='field'>到岗日期</td>
		<td colspan="3"><input name="assetNo" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required" type="text" style="width: 96%" value="${entity ne null ? entity.assetNo : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>申请日期</td>
		<td colspan="3"><input name="amtReceiver" type="text" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required" style="width: 96%;" value="${entity ne null ? entity.amtReceiver : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
	</tr>
	<tr>
		<td class='field'>请辞报告</td>
		<td colspan="8"><textarea name="comments" rows="1" style="width: 98%; height: 120px; margin: 5px;" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>>${entity ne null ? entity.comments : ''}</textarea></td>
	</tr>
</table>

<!-- 审批状态 -->
<%@ include file="../data/dataFormProcess.jsp" %>
