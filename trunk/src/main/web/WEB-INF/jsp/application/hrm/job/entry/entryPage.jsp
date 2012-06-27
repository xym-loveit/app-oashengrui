<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="app/hrm/hire.do?action=actionJobEntrySave" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>应聘者姓名：</td>
					<td colspan="3"><input name="name" type="text" value="${jobHireEntry ne null ? jobHireEntry.jobHireIssue.resume.fullName : ''}" style="width:100%" readonly/></td>
				</tr>
				<tr>
					<td>入职负责人：</td>
					<td>
						<input id="inputOrg1" name="charger.id" value="" type="hidden"/>
						<input class="required" name="charger.fullName" style="width:170px" type="text" postField="fullName" suggestFields="fullName" 
							suggestUrl="app/hrm/hire.do?action=lookupUserByName" lookupGroup="charger"/>
					</td>
					<td>入职时间：</td>
					<td><input name="entryPlanDate" class="date textInput required" format="yyyy-MM-dd HH:mm:ss" style="width:170px"/></td>
				</tr>
				<tr>
					<td>入职校区</td>
					<td>
						<select class="combox required" name="entryDistrictId" id="combox_district" style="width:150px" ref="combox_dept" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
							<option value="">请选择校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${jobHireEntry ne null && jobHireEntry.entryDistrict ne null && jobHireEntry.entryDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>入职部门：</td>
					<td>
						<select class="combox required" name="entryDepartmentId" id="combox_dept" defOPKey="请选择部门" defOPVal="" style="width:150px" ref="combox_position" refUrl="app/hrm/hire.do?action=actionLoadPositionByDepartment&depId={value}">
							<option value="">请选择部门</option>
							<logic:present name="departments">
								<logic:iterate name="departments" id="entity">
									<option value="${entity.id}" ${jobHireEntry ne null && jobHireEntry.entryDepartment ne null && jobHireEntry.entryDepartment.id eq entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
				</tr>
				<tr>
					<td>入职岗位：</td>
					<td>
						<select class="combox required" name="entryPositionId" id="combox_position" defOPKey="请选择岗位" defOPVal="" style="width:150px">
							<option value="">请选择岗位</option>
						</select>
					</td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">入职安排</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="entryId" value="${jobHireEntry ne null ? jobHireEntry.id : -1}" />
	</form>
</div>