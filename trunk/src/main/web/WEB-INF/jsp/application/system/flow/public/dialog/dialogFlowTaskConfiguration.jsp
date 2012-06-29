<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	$(function(){
		$("#proc_task_type").unbind("change");
		$("#proc_task_type").bind("change", function(){
			var task_type = $(this).find("option").filter(":selected").attr("value");
			$("#form_box").loadUrl("app/flow.do?action=actionLoadProcessTaskFormPage&processTaskType=" + task_type, {}, function(){
				if ($("#_var_menuid", $(navTab.getCurrentPanel())).size() > 0) {
					$("#_var_menuid", $(navTab.getCurrentPanel())).remove();
				}
			});
		});
	});
</script>

<div class="pageContent">
	<form method="post" action="app/flow.do?action=actionSaveProcessType" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="border-bottom: 1px solid #eee; overflow: hidden; padding-bottom: 4px;">
				<span style="float:left; line-height: 20px;">请选择流程节点类型：</span>
				<select class="combox" name="processTaskType" id="proc_task_type">
					<option value="1" ${department ne null && department.depOrgType eq 0 ? "selected='selected'" : ""}>本部门(账号所在校区)</option>
					<option value="2" ${department ne null && department.depOrgType eq 1 ? "selected='selected'" : ""}>某部门(账号所在校区)</option>
					<option value="3" ${department ne null && department.depOrgType eq 2 ? "selected='selected'" : ""}>总部对口部门</option>
					<option value="4" ${department ne null && department.depOrgType eq 2 ? "selected='selected'" : ""}>总部某部门</option>
				</select>
			</div>
			<div id="form_box" style="padding: 5px 0;">
				
			</div>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
<div>