<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="pageContent">
	<form method="post" action="app/flow.do?action=actionSaveProcessType" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<tr>
					<td>申请类别：</td>
					<td><input name="depName" type="text" size="30" value="${department ne null ? department.depName : ''}" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>类别说明：</td>
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
		