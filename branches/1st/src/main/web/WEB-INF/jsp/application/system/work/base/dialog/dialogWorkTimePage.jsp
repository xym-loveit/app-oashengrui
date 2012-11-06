<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
districtId = "-1";
function content_refresh () {
    $("#ajBoxDepPos").loadUrl("app/system/work/base/time.do?action=pageWorkBaseTime&districtId="+districtId, {}, function(){
       $.pdialog.closeCurrent();
    });
}
$(function(){districtId = $("#districtId").val();});
</script>

<div class="pageContent">
	<form method="post" action="app/system/work/base/time.do?action=actionSaveBaseWorkTime" class="pageForm required-validate" onsubmit="return validateCallback(this, content_refresh);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="5" cellpadding="5" class="dform">
				<tr>
					<td>选项名称：</td>
					<td><input name="itemName" type="text" size="30" value="${baseWorkTime ne null ? baseWorkTime.itemName : ''}" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>上班时间：</td>
					<td>
					<input name="workStime" type="text" size="30" value="${baseWorkTime ne null ? baseWorkTime.workStime : ''}" class="required" style="width: 42%" />
					-
					<input name="workEtime" type="text" size="30" value="${baseWorkTime ne null ? baseWorkTime.workEtime : ''}" class="required" style="width: 42%;float:none" />
					</td>
				</tr>
				<tr>
				   <td>适用天数</td>
				   <td><input type="checkbox" name="adjustDays" <c:if test='${fn:contains(baseWorkTime.adjustDays,"周一")}'>checked=checked</c:if> value="周一" />周一
				   <input type="checkbox" name="adjustDays" <c:if test='${fn:contains(baseWorkTime.adjustDays,"周二")}'>checked=checked</c:if>  value="周二" />周二
				   <input type="checkbox" name="adjustDays" <c:if test='${fn:contains(baseWorkTime.adjustDays,"周三")}'>checked=checked</c:if> value="周三" />周三
               <input type="checkbox" name="adjustDays" <c:if test='${fn:contains(baseWorkTime.adjustDays,"周四")}'>checked=checked</c:if> value="周四" />周四
               <input type="checkbox" name="adjustDays" <c:if test='${fn:contains(baseWorkTime.adjustDays,"周五")}'>checked=checked</c:if>  value="周五" />周五
               <input type="checkbox" name="adjustDays" <c:if test='${fn:contains(baseWorkTime.adjustDays,"周六")}'>checked=checked</c:if> value="周六" />周六
               <input type="checkbox" name="adjustDays" <c:if test='${fn:contains(baseWorkTime.adjustDays,"周日")}'>checked=checked</c:if> value="周日" />周日</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">选项说明：</td>
					<td><textarea rows="2" cols="40" name="meto" class="textInput" style="width: 88%">${baseWorkTime ne null ? baseWorkTime.meto : ''}</textarea></td>
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
		<input type="hidden" name="id" value="${baseWorkTime ne null ? baseWorkTime.id : '-1'}" />
		<input type="hidden" id="districtId" name="baseTimeDistrict.id" value="${baseWorkTime ne null ? baseWorkTime.baseTimeDistrict.id : '-1'}" />
		<input type="hidden" name="templateId" value="${baseWorkTime ne null ? baseWorkTime.templateId : '-1'}" />
	</form>
<div>
		