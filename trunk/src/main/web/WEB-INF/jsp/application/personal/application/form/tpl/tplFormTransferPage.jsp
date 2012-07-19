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
		<td width="${op eq null || op ne 'view' ? '72%' : '100%'}" colspan="10" class="banner">员工调动申请单</td>
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
			<input name="birthdate" style="width: 87%;" readonly type="text" value="${entity ne null ? entity.employee.birthdate : employee.birthdate}"/>
			<input id="inputEmpDisId" name="emp.districtId" value="" type="hidden"/>
		</td>
		<td class='field'>联系电话</td>
		<td><input name="phoneNo" class="required phone" style="width: 87%;" type="text" value="${entity ne null ? entity.employee.phoneNo : employee.phoneNo}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
	</tr>
	<tr>
		<td class='field'>拟调出校区</td>
		<td colspan="3"><input name="districtName" type="text" readonly style="width: 96%" value="${entity ne null ? entity.fromDistrict.districtName : employee.employeeDistrict.districtName}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/><input type="hidden" name="fromDistrictId" value="${entity ne null ? entity.fromDistrict.id : employee.employeeDistrict.id}" /></td>
		<td class='field'>调出部门</td>
		<td><input name="depName" type="text" readonly style="width: 87%;" value="${entity ne null ? entity.fromDepartment.depName : employee.employeeDepartment.depName}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/><input type="hidden" name="fromDepId" value="${entity ne null ? entity.fromDepartment.id : employee.employeeDepartment.id}" /></td>
		<td class='field'>原岗位</td>
		<td colspan="2">
			<input name="posName" readonly class="required" style="width: 87%;" type="text" value="${entity ne null ? entity.fromPosition.positionName : employee.employeePosition.positionName}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/><input type="hidden" name="fromPosId" value="${entity ne null ? entity.fromPosition.id : employee.employeePosition.id}" />
		</td>
	</tr>
	<tr>
		
		<td>拟调入校区</td>
		<td colspan="3">
			<c:choose>
				<c:when test="${(op ne null && op eq 'view') && (entity ne null && entity.toDistrict ne null)}">
					<input name="toDistrictName" type="text" readonly style="width: 96%" value="${entity.toDistrict.districtName" readonly /><input type="hidden" name="toDistrictId" value="${entity.fromDistrict.id}" />
				</c:when>
				<c:otherwise>
					<select class="combox required" name="toDistrictId" id="combox_district_in" style="width:150px" ref="combox_dept_in" refUrl="app/base.do?action=actionLoadDepartmentByOrg&districtId={value}">
						<option value="">请选择校区</option>
						<logic:present name="districts">
							<logic:iterate name="districts" id="district">
								<option value="${district.id}">${district.districtName}</option>
							</logic:iterate>
						</logic:present>
					</select>
				</c:otherwise>
			</c:choose>
		</td>
		<td>调入部门</td>
		<td>
			<c:choose>
				<c:when test="${(op ne null && op eq 'view') && (entity ne null && entity.toDepartment ne null)}">
					<input name="toDistrictName" type="text" readonly style="width: 96%" value="${entity.toDepartment.depName" readonly /><input type="hidden" name="toDepId" value="${entity.toDepartment.id}" />
				</c:when>
				<c:otherwise>
					<select class="combox required" name="toDepId" id="combox_dept_in" defOPKey="请选择部门" defOPVal="" style="width:150px" ref="combox_position_in" refUrl="app/base.do?action=actionLoadPositionByDepartment&depId={value}">
						<option value="">请选择部门</option>
						<logic:present name="departments">
							<logic:iterate name="departments" id="entity">
								<option value="${entity.id}">${entity.depName}</option>
							</logic:iterate>
						</logic:present>
					</select>
				</c:otherwise>
			</c:choose>
		</td>
				
		<td>申请岗位</td>
		<td colspan="2">
			<c:choose>
				<c:when test="${(op ne null && op eq 'view') && (entity ne null && entity.toDepartment ne null)}">
					<input name="toPosName" type="text" readonly style="width: 96%" value="${entity.toPosition.positionName" readonly /><input type="hidden" name="toPosId" value="${entity.toPosition.id}" />
				</c:when>
				<c:otherwise>
					<select class="combox required" name="toPosId" id="combox_position_in" defOPKey="请选择岗位" defOPVal="" style="width:150px">
						<option value="">请选择岗位</option>
						<logic:present name="positions">
							<logic:iterate name="positions" id="entity">
								<option value="${entity.id}">${entity.positionName}</option>
							</logic:iterate>
						</logic:present>
					</select>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<td class='field'>申请日期</td>
		<td colspan="7"><input name="applyDate" type="text" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required" style="width: 96%;" value="${entity ne null ? entity.applyDate : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
	</tr>
	<tr>
		<td class='field'>请调报告</td>
		<td colspan="8"><textarea name="comments" rows="1" style="width: 98%; height: 120px; margin: 5px;" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>>${entity ne null ? entity.comments : ''}</textarea></td>
	</tr>
</table>

<!-- 审批状态 -->
<%@ include file="../data/dataFormProcess.jsp" %>
