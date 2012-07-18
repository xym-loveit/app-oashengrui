<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="app/flow/${typeSlug}.do?action=actionSaveProcessDefinition" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<tr>
					<td>条件名称：</td>
					<td><input name="processDefName" type="text" size="30" value="${processDef ne null ? processDef.processDefName : ''}" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>条件表达式：</td>
					<td><input name="condition" type="text" size="30" value="${processDef ne null ? processDef.condition : ''}" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>条件描述：</td>
					<td><textarea rows="2" cols="40" name="processDefDesc" class="textInput" style="width: 88%">${processDef ne null ? processDef.processDefDesc : ''}</textarea></td>
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
		<input type="hidden" name="id" value="${processDef ne null ? processDef.id : '-1'}" />
		<input type="hidden" name="procTypeId" value="${processType.id}" />
	</form>
<div>