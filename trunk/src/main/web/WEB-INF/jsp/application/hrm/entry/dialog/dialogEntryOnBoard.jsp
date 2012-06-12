<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.fblue {color: blue;}
	.fred {color: red;}
</style>

<div class="pageContent">
	<form method="post" action="app/hrm/entry.do?action=actionEntrySave" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="line-height: 25px;">
				您确定对'<span class="fblue">${jobHireEntry ne null ? jobHireEntry.jobHireIssue.resume.fullName : ''}</span>'进行入职处理并<span class="fred">进入7天考察期</span>吗？
			</div>
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>入职负责人：</td>
					<td>
						<input id="inputOrg1" name="charger.id" value="${jobHireEntry.entryCharger ne null ? jobHireEntry.entryCharger.id : -1}" type="hidden"/>
						<input class="required" name="charger.fullName" style="width:170px" type="text" postField="fullName" suggestFields="fullName" 
							suggestUrl="app/hrm/hire.do?action=lookupUserByName" lookupGroup="charger" value="${jobHireEntry.entryCharger ne null ? jobHireEntry.entryCharger.fullName : ''}"/>
					</td>
					<td>实际入职时间：</td>
					<td><input name="entryActDate" class="date textInput required" format="yyyy-MM-dd HH:mm:ss" style="width:170px"/></td>
				</tr>
				<tr>
					<td>入职校区</td>
					<td>
						<select class="combox required" name="entryDistrictId" id="combox_district_in" style="width:150px" ref="combox_dept_in" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
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
						<select class="combox required" name="entryDepartmentId" id="combox_dept_in" defOPKey="请选择部门" defOPVal="" style="width:150px" ref="combox_position_in" refUrl="app/hrm/hire.do?action=actionLoadPositionByDepartment&depId={value}">
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
						<select class="combox required" name="entryPositionId" id="combox_position_in" defOPKey="请选择岗位" defOPVal="" style="width:150px">
							<option value="">请选择岗位</option>
							<logic:present name="positions">
								<logic:iterate name="positions" id="entity">
									<option value="${entity.id}" ${jobHireEntry ne null && jobHireEntry.entryPosition ne null && jobHireEntry.entryPosition.id eq entity.id ? 'selected="selected"' : ''}>${entity.positionName}</option>
								</logic:iterate>
							</logic:present>
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
		<input type="hidden" name="op" value="board" />
		<input type="hidden" name="state" value="1" />
	</form>
</div>