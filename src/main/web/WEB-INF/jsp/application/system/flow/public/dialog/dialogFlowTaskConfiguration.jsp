<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script>
	function after_save(json) {
		DWZ.ajaxDone(json);
		var currentPanel = $(navTab.getCurrentPanel());
		if ($("#_var_fdefid", currentPanel).size() > 0) {
			var def_id = $("#_var_fdefid", currentPanel).val();
			// $(navTab.getCurrentPanel())
			$("#ajBoxFlowConf_${processDef.processType.id}").loadUrl("app/flow.do?action=actionLoadProcessTasks&procDefId=" + def_id, {}, function(){
				$.pdialog.closeCurrent();
			});
		}
	}
	
	$(function(){
	
		$("#proc_task_type").unbind("change");
		$("#proc_task_type").bind("change", function(){
			if ($.pdialog._current) {
				var task_type = $(this).find("option").filter(":selected").attr("value");
				$($.pdialog._current.find("#form_box")).loadUrl("app/flow.do?action=actionLoadProcessTaskFormPage&processTaskType=" + task_type, {}, function(){
					
				});
			}
		});
		
		<logic:present name="taskType">
			if ($.pdialog._current) {
				$($.pdialog._current.find("#form_box")).loadUrl("app/flow.do?action=actionLoadProcessTaskFormPage&processTaskType=${taskType}<c:if test='${procTask ne null}'>&procTaskId=${procTask.id}</c:if>", {}, function(){
				});
			}
		</logic:present>
		
	});
</script>

<div class="pageContent">
	<form method="post" action="app/flow/${typeSlug}.do?action=actionSaveProcessTask" class="pageForm required-validate" onsubmit="return validateCallback(this, after_save);">
		<div class="pageFormContent" layoutH="56">
			<div style="border-bottom: 1px solid #eee; overflow: hidden; padding-bottom: 4px;">
				<span style="float:left; line-height: 20px; margin-bottom: 5px;"><b>请选择节点类型：</b></span>
				<select class="combox" name="processTaskType" id="proc_task_type">
					<option value="1" ${taskType ne null && taskType eq 1 ? "selected='selected'" : ""}>本部门(账号所在校区)</option>
					<option value="2" ${taskType ne null && taskType eq 2 ? "selected='selected'" : ""}>某部门(账号所在校区)</option>
					<option value="3" ${taskType ne null && taskType eq 3 ? "selected='selected'" : ""}>总部对口部门</option>
					<option value="4" ${taskType ne null && taskType eq 4 ? "selected='selected'" : ""}>总部某部门</option>
					<c:if test="${typeSlug eq 'hrm' && istran ne null}">
					<option value="5" ${taskType ne null && taskType eq 5 ? "selected='selected'" : ""}>调动/晋升校区</option>
					</c:if>
				</select>
			</div>
			<div id="form_box" style="padding: 10px 0;clear:both">
				
			</div>
		</div>
		<div class="formBar">
			<input type="hidden" name="procDefId" value="${processDef.id}" />
			<input type="hidden" name="procTaskId" value="${procTask ne null ? procTask.id : -1}" />
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
<div>