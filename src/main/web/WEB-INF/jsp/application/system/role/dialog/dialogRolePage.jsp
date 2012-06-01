<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function(){
		$("#menu_icon").keyup(function(){
			$(".diaMicon").removeAttr("class").addClass("diaMicon " + $(this).val());
		});
	});
</script>

<div class="pageContent">
	<form id="formRoleFunc" method="post" action="app/system/role.do?action=actionSaveRole" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<tr>
					<td>角色名称：</td>
					<td><input name="roleName" type="text" size="30" value="${role ne null ? role.roleName : ''}" class="required" style="width: 88%" ${view ne null ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					<td>角色类型：</td>
					<td>
						<logic:notPresent name="view">
						<select class="combox" name="roleType" id="dialog_roleType">
							<option value="0" ${role ne null && role.roleType eq 0 ? "selected='selected'" : ""}>总部</option>
							<option value="1" ${role ne null && role.roleType eq 1 ? "selected='selected'" : ""}>校区</option>
							<option value="2" ${role ne null && role.roleType eq 2 ? "selected='selected'" : ""}>片区</option>
						</select>
						</logic:notPresent>
						<logic:present name="view"><logic:present name="role">${role.roleType == 0 ? '总部' : (role.roleType == 1 ? '校区' : (role.roleType == 2 ? '片区' : '/'))}</logic:present></logic:present>
					</td>
				</tr>
				<tr>
					<td>角色描述：</td>
					<td><input name="roleDesc" type="text" size="30" value="${role ne null ? role.roleDesc : ''}" style="width: 88%" ${view ne null ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">角色功能：</td>
					<td>
						<input name="menuFunc.menuIds" type="hidden" size="30" value="${role ne null ? role.menuIds : ''}" style="width: 88%" readonly/>
						<textarea rows="5" cols="40" name="menuFunc.funcRights" style="width: 88%" readonly>${role ne null ? role.roleRights : ''}</textarea>
						<a class="btnLook" href="app/system/role.do?action=actionLoadAppFuncs&roleId=${role ne null ? role.id : '-1'}<logic:present name='view'>&view</logic:present>" lookupGroup="menuFunc" width="476" height="404" rel="mfunc_lookup">角色功能列表</a>
					</td>
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
		<input type="hidden" name="id" value="${role ne null ? role.id : '-1'}" />
	</form>
<div>
		