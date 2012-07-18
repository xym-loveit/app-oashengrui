<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
districtId = "-1";
function content_refresh () {
    $("#ajBoxDepPos").loadUrl("app/system/work/base.do?action=pageWorkBaseContent&districtId="+districtId, {}, function(){
       $.pdialog.closeCurrent();
    });
}
$(function(){districtId = $("#districtId").val();});
</script>

<div class="pageContent">
	<form method="post" action="app/system/work/base.do?action=actionSaveBaseWorkContent" class="pageForm required-validate" onsubmit="return validateCallback(this, content_refresh);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="5" cellpadding="5" class="dform">
				<tr>
					<td>选项名称：</td>
					<td><input name="itemName" type="text" size="30" value="${baseWorkContent ne null ? baseWorkContent.itemName : ''}" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>选项值：</td>
					<td><input name="itemValue" type="text" size="30" value="${baseWorkContent ne null ? baseWorkContent.itemValue : ''}" class="required" style="width: 88%" /></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">选项说明：</td>
					<td><textarea rows="2" cols="40" name="meto" class="textInput" style="width: 88%">${baseWorkContent ne null ? baseWorkContent.meto : ''}</textarea></td>
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
		<input type="hidden" name="id" value="${baseWorkContent ne null ? baseWorkContent.id : '-1'}" />
		<input type="hidden" id="districtId" name="baseWorkDistrict.id" value="${baseWorkContent ne null ? baseWorkContent.baseWorkDistrict.id : '-1'}" />
	</form>
<div>
		