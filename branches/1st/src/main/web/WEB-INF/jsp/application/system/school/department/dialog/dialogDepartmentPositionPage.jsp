<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	function after_save(json) {
		DWZ.ajaxDone(json);
		var currentPanel = $(navTab.getCurrentPanel());
		if ($("#_var_depid", currentPanel).size() > 0) {
			var dep_id = $("#_var_depid", currentPanel).val();
			$("#ajBoxDepPos").loadUrl("app/system/school/department/position.do?action=actionLoadDepartmentPosition&depId=" + dep_id, {}, function(){
				$.pdialog.closeCurrent();
			});
		}
	}
	$(function(){
		$("#menu_icon").keyup(function(){
			$(".diaMicon").removeAttr("class").addClass("diaMicon " + $(this).val());
		});
	});
</script>

<div class="pageContent">
	<form method="post" action="app/system/school/department/position.do?action=actionSaveDepartmentPosition" class="pageForm required-validate" onsubmit="return validateCallback(this, after_save);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<tr>
					<td>所属部门：</td>
					<td>
						<input name="depName" type="text" size="30" value="${position ne null ? position.department.depName : department.depName}" style="width: 88%" readonly/>
						<input name="depId" type="hidden" size="30" value="${position ne null ? position.department.id : department.id}" style="width: 88%" readonly/>
					</td>
				</tr>
				<tr>
					<td>岗位名称：</td>
					<td><input name="positionName" type="text" size="30" value="${position ne null ? position.positionName : ''}" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>是否领导：</td>
					<td>
						<select class="combox" name="positionLeadership" id="dialog_depPosLS">
							<option value="0" ${position ne null && position.positionLeadership eq 0 ? "selected='selected'" : ""}>是</option>
							<option value="1" ${position ne null && position.positionLeadership eq 1 ? "selected='selected'" : ""}>否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">权限配置：</td>
					<td>
						<input name="dePrivileges.ids" type="hidden" size="30" value="${position ne null ? position.positionRoleIds : ''}" style="width: 88%" readonly/>
						<textarea rows="2" cols="40" name="dePrivileges.keys" style="width: 88%" readonly>${position ne null ? position.positionRoleRights : ''}</textarea>
						<a class="btnLook" href="app/system/school/department/position.do?action=actionLoadDepartmentPrivilegeTree&depId=${department.id}&posId=${position ne null ? position.id : '-1'}" lookupGroup="dePrivileges" width="476" height="404" rel="mdeprivilege_lookup">岗位权限配置</a>
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">岗位描述：</td>
					<td><textarea rows="2" cols="40" name="positionDesc" class="textInput" style="width: 88%">${position ne null ? position.positionDesc : ''}</textarea></td>
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
		<input type="hidden" name="id" value="${position ne null ? position.id : '-1'}" />
	</form>
<div>
		