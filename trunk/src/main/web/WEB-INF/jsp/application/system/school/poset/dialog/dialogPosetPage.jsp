<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css" href="resources/js/jquery/jmulti/jquery.multiselect2side.css" />
<script type="text/javascript" src="resources/js/jquery/jmulti/jquery.multiselect2side.js"></script>

<script type="text/javascript">

function form_post(ele_form) {
	if ($("#positionListms2side__sx").size() > 0) {
		var opts = $("#positionListms2side__sx").find("option");
		var posIds = "";
		for (i = 0; i < opts.size(); i++) {
			posIds += $(opts.get(i)).attr("value");
			if (i < opts.size() - 1) {
				posIds += ",";
			}
		}
		$("#posIds").val(posIds);		
		return validateCallback(ele_form, dialogAjaxDone);
	}
}

$(function(){
   $("#positionList").multiselect2side({
	    selectedPosition: 'left',
	    moveOptions: false,
		labelsx: '本职位包括以下岗位',
		labeldx: '配置岗位列表'
   });
});
</script>

<div class="pageContent">
	<form id="formRoleFunc" method="post" action="app/system/school/poset.do?action=actionSavePoset" class="pageForm required-validate" onsubmit="return form_post(this);">
		<div class="pageFormContent" layoutH="56">
			<div style="overflow:auto;">
				<span style="float:left;line-height:18px">职位名称：</span>
				<input name="posetName" type="text" size="30" value="${entity ne null ? entity.posetName : ''}" class="required" style="width: 150px" ${view ne null ? 'readonly' : ''}/>
			</div>
			<div style="margin-top:15px; overflow:hidden; border-top: 1px solid #ddd;">
				<select name="positionList[]" id='positionList' multiple='multiple' size='8' >
					<logic:present name="positions.list">
						<logic:iterate name="positions.list" id="pos">
							<option value="${pos.id}" ${entity ne null && entity.positionIds ne null && entity['positionIds'][pos.id] ? "selected='selected'" : ""}>${pos.department.depName} - ${pos.positionName} (${pos.department.depOrgType eq 0 ? '总部' : (pos.department.depOrgType eq 1 ? '校区' : '片区')})</option>
						</logic:iterate>
					</logic:present>
				</select>
			</div>
			<input type="hidden" name="posIds" id="posIds" />
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
		<input type="hidden" name="id" value="${entity ne null ? entity.id : '-1'}" />
	</form>
<div>
		