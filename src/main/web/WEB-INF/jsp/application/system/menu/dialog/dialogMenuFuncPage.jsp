<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="app/system/menu.do?action=actionSaveMenuItem" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<tr>
					<td>所属菜单：</td>
					<td>
						<input name="menuTitle" type="text" size="30" value="${menu.menuTitle}" style="width: 88%" readonly/>
						<input name="menuId" type="hidden" size="30" value="${menu.id}" style="width: 88%" readonly/>
					</td>
				</tr>
				<tr>
					<td>功能名称：</td>
					<td><input name="funcName" type="text" size="30" value="" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>功能键值：</td>
					<td><input name="funcKey" type="text" size="30" value="" class="required" style="width: 88%" remote="app/system/menu.do?action=actionUniqueCheckMenuFuncKey"/></td>
				</tr>
				<tr>
					<td>功能图标：</td>
					<td>
						<input name="funcIcon" type="text" size="30" value="javascript:void(0);" style="width: 88%"/>
						<span class="diaMicon"></span>
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">功能链接：</td>
					<td>
						<textarea rows="2" cols="40" name="funcURLs" class="textInput required" style="width: 88%"></textarea>
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">功能描述：</td>
					<td>
						<textarea rows="2" cols="40" name="funcDesc" class="textInput" style="width: 88%"></textarea>
					</td>
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
	</form>
<div>