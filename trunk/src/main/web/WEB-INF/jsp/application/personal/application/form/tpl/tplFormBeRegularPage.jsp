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
		<td width="${op eq null || op ne 'view' ? '72%' : '100%'}" colspan="10" class="banner">员工转正申请单</td>
	</tr>
	<tr>
		<td class='field'>申请人</td>
		<td>
			<input id="inputEmpId" name="employee.id" value="${entity ne null ? entity.employee.id : employee.id}" type="hidden"/>
			<input class="required" name="employee.empName" style="width: 87%;" type="text" readonly value="${entity ne null ? entity.employee.empName : employee.empName}" />
		</td>
		<td class='field'>性别</td>
		<td><input name="sex" style="width: 87%;" readonly class="required textInput" format="yyyy-MM-dd" type="text" value="${entity ne null ? (entity.employee.resume.sex eq 1 ? '男' : '女') : (employee.resume.sex eq 1 ? '男' : '女')}" /></td>
		<td class='field'>出生日期</td>
		<td>
			<input name="birthdate" style="width: 87%;" readonly type="text" value="<c:choose><c:when test='${entity ne null}'><fmt:formatDate  value='${entity.employee.birthdate}' pattern='yyyy-MM-dd' /></c:when><c:otherwise><fmt:formatDate  value='${employee.birthdate}' pattern='yyyy-MM-dd' /></c:otherwise></c:choose>"/>
			<input id="inputEmpDisId" name="emp.districtId" value="" type="hidden"/>
		</td>
		<td class='field'>联系电话</td>
		<td><input name="phoneNo" class="required phone" style="width: 87%;" type="text" value="${entity ne null ? entity.employee.phoneNo : employee.phoneNo}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
	</tr>
	<tr>
		<td class='field'>所属校区</td>
		<td colspan="3"><input name="districtName" type="text" readonly style="width: 96%" value="${entity ne null ? entity.fromDistrict.districtName : employee.employeeDistrict.districtName}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/><input type="hidden" name="fromDistrictId" value="${entity ne null ? entity.fromDistrict.id : employee.employeeDistrict.id}" /></td>
		<td class='field'>所属部门</td>
		<td><input name="depName" type="text" readonly style="width: 87%;" value="${entity ne null ? entity.fromDepartment.depName : employee.employeeDepartment.depName}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/><input type="hidden" name="fromDepId" value="${entity ne null ? entity.fromDepartment.id : employee.employeeDepartment.id}" /></td>
		<td class='field'>岗位</td>
		<td colspan="2">
			<input name="posName" readonly class="required" style="width: 87%;" type="text" value="${entity ne null ? entity.fromPosition.positionName : employee.employeePosition.positionName}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/><input type="hidden" name="fromPosId" value="${entity ne null ? entity.fromPosition.id : employee.employeePosition.id}" />
		</td>
	</tr>
	<tr>
		<td class='field'>到岗日期</td>
		<td colspan="3"><input name="onboardTime" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required" type="text" style="width: 96%" value="<c:choose><c:when test='${entity ne null}'><fmt:formatDate  value='${entity.employee.onboardDate}' pattern='yyyy-MM-dd' /></c:when><c:otherwise><fmt:formatDate  value='${employee.onboardDate}' pattern='yyyy-MM-dd' /></c:otherwise></c:choose>"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>申请日期</td>
		<td colspan="3"><input name="applyDate" type="text" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required" style="width: 96%;" value="<c:choose><c:when test='${entity ne null}'><fmt:formatDate  value='${entity.applyDate}' pattern='yyyy-MM-dd' /></c:when><c:otherwise></c:otherwise></c:choose>"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
	</tr>
	<tr>
		<td class='field'>转正申请报告</td>
		<td colspan="8"><textarea name="comments" rows="1" style="width: 98%; height: 120px; margin: 5px;" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>>${entity ne null ? entity.comments : ''}</textarea></td>
	</tr>
</table>

<!-- 审批状态 -->
<%@ include file="../data/dataFormProcess.jsp" %>
