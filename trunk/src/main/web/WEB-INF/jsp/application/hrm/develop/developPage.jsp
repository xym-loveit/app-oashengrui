<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="app/hrm/develop.do?action=hrmEmployeeDevelopDetail" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>申请人：</td>
					<td><input name="employeeName" type="text" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.employee.empName : ''}" style="width:120px" readonly/></td>
					<td>性别：</td>
					<td><input name="employeeSex" type="text" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.employee.empName : ''}" style="width:120px" readonly/></td>
					<td>出生日期：</td>
					<td><input name="birthdate" class="date textInput" yearstart="-80" yearend="0" style="width:120px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.employee.birthdate : ''}" readonly/></td>
					<td>联系电话：</td>
					<td><input name="phoneNo"  type="text" style="width:120px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.employee.phoneNo : ''}" readonly/></td>
					<td></td>
				</tr>
				<tr>
					<td>原校区：</td>
					<td colspan="2"><input name="fromDistrict"  type="text" style="width:120px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.fromDistrict.districtName : ''}" readonly/></td>
					<td>原部门：</td>
					<td colspan="2"><input name="fromDepartment"  type="text" style="width:120px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.fromDepartment.depName : ''}" readonly/></td>
					<td>原职务：</td>
					<td><input name="fromPosition"  type="text" style="width:120px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.fromPosition.positionName : ''}" readonly/></td>
					<td></td>
				</tr>
				<tr>
					<td>申请校区：</td>
					<td colspan="2">
						<select class="combox required" name="entryDistrictId" id="combox_district" style="width:150px" ref="combox_dept" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
							<option value="">请选择校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${employeeDevelopEntry ne null && employeeDevelopEntry.entryDistrict ne null && employeeDevelopEntry.entryDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>申请部门：</td>
					<td colspan="2">
						<select class="combox required" name="entryDepartmentId" id="combox_dept" defOPKey="请选择部门" defOPVal="" style="width:150px" ref="combox_position" refUrl="app/hrm/hire.do?action=actionLoadPositionByDepartment&depId={value}">
							<option value="">请选择部门</option>
							<logic:present name="departments">
								<logic:iterate name="departments" id="entity">
									<option value="${entity.id}" ${employeeDevelopEntry ne null && employeeDevelopEntry.entryDepartment ne null && employeeDevelopEntry.entryDepartment.id eq entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>申请岗位：</td>
					<td>
						<select class="combox required" name="entryPositionId" id="combox_position" defOPKey="请选择岗位" defOPVal="" style="width:150px">
							<option value="">请选择岗位</option>
						</select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td>申请日期：</td>
					<td colspan="2"><input name="applyDate" class="date textInput" yearstart="-80" yearend="0" style="width:120px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.applyDate : ''}" /></td>
					<td colspan="5"></td>
					<td></td>
				</tr>
				<tr>
					<td>申请报告：</td>
					<td colspan="7"><input name="comments" type="text" style="width:100%" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.comments : ''}" /></td>
					<td></td>
				</tr>
				<tr>
					<td>本部门意见：</td>
					<td colspan="7"><input name="comments" type="text" style="width:100%" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.comments : ''}" /></td>
					<td></td>
				</tr>
				<tr>
					<td>人资部意见：</td>
					<td colspan="7"><input name="comments" type="text" style="width:100%" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.comments : ''}" /></td>
					<td></td>
				</tr>
				<tr>
					<td>校区意见：</td>
					<td colspan="7"><input name="comments" type="text" style="width:100%" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.comments : ''}" /></td>
					<td></td>
				</tr>
				<tr>
					<td>总部意见：</td>
					<td colspan="7"><input name="comments" type="text" style="width:100%" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.comments : ''}" /></td>
					<td></td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">打印</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.id : -1}" />
	</form>
</div>