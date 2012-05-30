<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function(){
		$("#menu_icon").keyup(function(){
			$(".diaMicon").removeAttr("class").addClass("diaMicon " + $(this).val());
		});
	});
</script>

<div class="pageContent">
	<form method="post" action="app/system/menu.do?action=actionSaveMenuItem" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<tr>
					<td>菜单名称：</td>
					<td><input name="menuTitle" type="text" size="30" value="" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>菜单标识：</td>
					<td><input name="menuKey" type="text" size="30" value="" class="required" style="width: 88%" remote="app/system/menu.do?action=actionUniqueCheckMenuKey"/></td>
				</tr>
				<tr>
					<td>菜单链接：</td>
					<td><input name="menuUrl" type="text" size="30" value="javascript:void(0);" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>菜单图标：</td>
					<td>
						<input id="menu_icon" name="menuIcon" type="text" size="30" value=""  style="width: 88%"/>
						<span class="diaMicon"></span>
					</td>
				</tr>
				<tr>
					<td>父菜单：</td>
					<td>
						<input name="root.menuKey" type="hidden" size="30" value="0" style="width: 88%" readonly/>
						<input name="root.menuTitle" type="text" size="30" value="" style="width: 88%" readonly/>
						<a class="btnLook" href="app/system/menu.do?action=actionLoadMenuItemTree&lookup" lookupGroup="root" width="476" height="404" rel="menu_lookup">菜单目录</a>
					</td>
				</tr>
				<tr>
					<td>菜单序号：</td>
					<td><input name="menuOrder" type="text" size="30" value="0"  class="required number" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>菜单描述：</td>
					<td><textarea rows="2" cols="40" name="menuDesc" class="textInput" style="width: 88%"></textarea></td>
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
		