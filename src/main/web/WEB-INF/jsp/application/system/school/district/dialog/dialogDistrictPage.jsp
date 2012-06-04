<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="pageContent">
	<form id="formRoleFunc" method="post" action="app/system/school/district.do?action=actionSaveDistrict" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<tr>
					<td>校区名称：</td>
					<td><input name="districtName" type="text" size="30" value="${district ne null ? district.districtName : ''}" class="required" style="width: 88%" ${view ne null ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					<td>校区编号：</td>
					<td><input name="districtNo" type="text" size="30" value="${district ne null ? district.districtNo : ''}" class="required" style="width: 88%" ${district ne null ? 'readonly' : ''} <logic:notPresent name="district">remote="app/system/school/district.do?action=actionUniqueCheckDistrictNo"</logic:notPresent>/></td>
				</tr>
				<tr>
					<td>校区类型：</td>
					<td>
						<select class="combox" name="districtType" id="dialog_districtType">
							<option value="0" ${district ne null && district.districtType eq 0 ? "selected='selected'" : ""}>总部</option>
							<option value="1" ${district ne null && district.districtType eq 1 ? "selected='selected'" : ""}>校区</option>
							<option value="2" ${district ne null && district.districtType eq 2 ? "selected='selected'" : ""}>片区</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>上级结构：</td>
					<td>
						<select class="combox" name="rootId" id="dialog_districtParent">
							<option value="">请选择</option>
							<logic:present name="district.list">
								<logic:iterate name="district.list" id="entity">
									<c:if test="${entity.id ne district.id}">
										<option value="${entity.id}" ${district.districtParent ne null && district.districtParent.id eq entity.id ? 'selected="true"' : ''}>${entity.districtName}</option>
									</c:if>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
				</tr>
				<tr>
					<td>校区地址：</td>
					<td><input name="districtAddress" type="text" size="30" value="${district ne null ? district.districtAddress : ''}" style="width: 88%" ${view ne null ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					<td>联系电话：</td>
					<td><input name="districtPhone" type="text" size="30" value="${district ne null ? district.districtPhone : ''}" style="width: 88%" ${view ne null ? 'readonly' : ''}/></td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<logic:notPresent name="view">
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				</logic:notPresent>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${district ne null ? district.id : '-1'}" />
	</form>
<div>
		