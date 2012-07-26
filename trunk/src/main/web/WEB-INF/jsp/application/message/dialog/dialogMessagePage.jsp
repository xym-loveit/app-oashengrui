<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

/*** Manifest ***/

/* Manifest container that wraps the elements and now acts as, and should be
   styled as, the input. */
div.mf_container {
  border: 1px solid #A2BAC0;
  cursor: text;
  display: inline-block;
  padding: 2px;
  width: 100%;
  min-height: 30px;
}

/* Ordered list for displaying selected items. */
div.mf_container ol.mf_list {
  display: inline;
}

/* Selected item, regardless of state (highlighted, selected). */
div.mf_container ol.mf_list li.mf_item {
  border: 1px solid #C0C0C0;
  cursor: pointer;
  display: inline-block;
  margin: 2px;
  padding: 4px 4px 5px;
}

/* Selected item that's highlighted by mouseover. */
div.mf_container ol.mf_list li.mf_item.mf_highlighted {
  background-color: #E0E0E0;
}

/* Selected item that's selected by click or keyboard. */
div.mf_container ol.mf_list li.mf_item.mf_selected {
  background-color: #C0C0C0;
}

/* Remove link. */
div.mf_container ol.mf_list li.mf_item a.mf_remove {
  color: #E0E0E0;
  margin-left: 10px;
  text-decoration: none;
}

/* Remove link that's highlighted. */
div.mf_container ol.mf_list li.mf_item.mf_highlighted a.mf_remove {
  color: #FFFFFF;
}

/* Remove link that's selected. */
div.mf_container ol.mf_list li.mf_item.mf_selected a.mf_remove {
  color: #FFFFFF;
}

/* Actual input, styled to be invisible within the container. */
div.mf_container input.mf_input {
  border: 0;
  font: inherit;
  font-size: 100%;
  margin: 2px;
  outline: none;
  padding: 4px;
}

/*** Marco Polo ***/

/* Ordered list for display results. */
ol.mp_list {
  background-color: #FFFFFF;
  border-left: 1px solid #C0C0C0;
  border-right: 1px solid #C0C0C0;
  overflow: hidden;
  position: absolute;
  width: 498px;
  z-index: 99999;
}

/* Each list item, regardless of success, error, etc. */
ol.mp_list li {
  border-bottom: 1px solid #C0C0C0;
  padding: 4px 4px 5px 9px;
}

/* Each list item from a successful request. */
ol.mp_list li.mp_item {

}

/* Each list item that's selectable. */
ol.mp_list li.mp_selectable {
  cursor: pointer;
}

/* Currently highlighted list item. */
ol.mp_list li.mp_highlighted {
  background-color: #E0E0E0;
}

/* When a request is made that returns zero results. */
ol.mp_list li.mp_no_results {

}

/* When a request is made that doesn't meet the 'minChars' length option. */
ol.mp_list li.mp_min_chars {

}

/* When a request is made that fails during the ajax request. */
ol.mp_list li.mp_error {

}

</style>

<script src="resources/js/jquery/jmainfest/jquery.ui.widget.min.js" type="text/javascript"></script>
<script src="resources/js/jquery/jmainfest/jquery.marcopolo.min.js" type="text/javascript"></script>
<script src="resources/js/jquery/jmainfest/jquery.manifest.js" type="text/javascript"></script>

<script>
	
	$(function(){
		$('#task_participants').manifest({
			// Use each location's full name as the display text.
			formatDisplay: function (data, $item, $mpItem) {
				return data.empName;
			},
			// Use each location's ID as the value to be submitted.
			formatValue: function (data, $value, $item, $mpItem) {
				return data.id;
			},
			<logic:present name="entity" property="taskParticipants">
			values: [{}<logic:iterate name="entity" property="taskParticipants" id="p">,{id: ${p.id}, empName: '${p.empName}'}</logic:iterate>],
			</logic:present>
			valuesName: 'empid'
		});
	});
	
</script>

<div class="pageContent">
	<form id="formRoleFunc" method="post" action="app/system/role.do?action=actionSaveRole" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<logic:notPresent name="msgId">
			<div style="float: right; width: 300px;">
				<div class="accordion">
					<div class="accordionHeader">
						<h2><span>icon</span>按校区</h2>
					</div>
					<div class="accordionContent">
						<%@ include file="../data/dataDistrictTree.jsp"%>
					</div>
					<div class="accordionHeader">
						<h2><span>icon</span>按部门</h2>
					</div>
					<div class="accordionContent">
						<%@ include file="../data/dataDepartmentTree.jsp"%>
					</div>
				</div>
			</div>
			</logic:notPresent>
			
			<div <logic:notPresent name="msgId">style="margin-right: 320px"</logic:notPresent>>
				<table cellspacing="10" cellpadding="10" style="border-spacing: 12; width: 100%;">
					<tr>
						<td style="line-height: 25px;">消息标题：</td>
						<td><input type="text" name="taskName" class="required" style="width:97%;"  value="${entity ne null ? entity.taskName : ''}"/></td>
					</tr>
					<tr>
						<td style="line-height: 25px;">收件人：</td>
						<td><input id="task_participants" type="text" name="participants" style="width: 100%; display: none;" /></td>
					</tr>
					<tr>
						<td style="line-height: 25px;vertical-align: top">任务描述：</td>
						<td><textarea name="taskDescription" rows="5" cols="60"
							style="width: 100%"  >${entity ne null ? entity.taskDescription : ''}</textarea></td>
					</tr>
				</table>
			<div>
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
		