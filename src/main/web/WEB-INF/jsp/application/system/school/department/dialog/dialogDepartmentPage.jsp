<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="pageContent">
	<form method="post" action="app/system/school/department.do?action=actionSaveDepartment" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<tr>
					<td>部门名称：</td>
					<td><input name="depName" type="text" size="30" value="${department ne null ? department.depName : ''}" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>部门编号：</td>
					<td><input name="depNo" type="text" size="30" value="${department ne null ? department.depNo : ''}" class="required" style="width: 88%" /></td>
				</tr>
				<tr>
					<td>部门结构：</td>
					<td>
						<select class="combox" name="depOrgType" id="dialog_depOrgType">
							<option value="0" ${department ne null && department.depOrgType eq 0 ? "selected='selected'" : ""}>总部</option>
							<option value="1" ${department ne null && department.depOrgType eq 1 ? "selected='selected'" : ""}>校区</option>
							<option value="2" ${department ne null && department.depOrgType eq 2 ? "selected='selected'" : ""}>片区</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>对口级别：</td>
					<td>
						<select class="combox" name="depEquivalentLevel" id="dialog_depEquivalentLevel" ref="dialog_depBranch" refUrl="app/system/school/department.do?action=actionLoadDepartmentByOrg&depEquivalentLevel={value}">
							<option value="">请选择</option>
							<option value="0" ${department ne null && department.depEquivalentLevel eq 0 ? "selected='selected'" : ""}>总部</option>
							<option value="1" ${department ne null && department.depEquivalentLevel eq 1 ? "selected='selected'" : ""}>校区</option>
							<option value="2" ${department ne null && department.depEquivalentLevel eq 2 ? "selected='selected'" : ""}>片区</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>对口部门：</td>
					<td>
						<select class="combox" name="depBranchId" id="dialog_depBranch" defOPKey="请选择" defOPVal="">
							<option value="">请选择</option>
							<logic:present name="branches">
								<logic:iterate name="branches" id="entity">
									<option value="${entity.id}" ${department ne null && department.depEquivalentBranch ne null && department.depEquivalentBranch.id eq entity.id ? "selected='selected'" : ""}>${entity.depName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">部门描述：</td>
					<td><textarea rows="2" cols="40" name="depDesc" class="textInput" style="width: 88%">${district ne null ? district.depDesc : ''}</textarea></td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${department ne null ? department.id : '-1'}" />
	</form>
<div>
		