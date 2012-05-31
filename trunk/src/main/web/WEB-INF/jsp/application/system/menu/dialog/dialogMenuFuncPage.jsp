<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	function after_save(json) {
		DWZ.ajaxDone(json);
		var currentPanel = $(navTab.getCurrentPanel());
		if ($("#_var_menuid", currentPanel).size() > 0) {
			var menu_id = $("#_var_menuid", currentPanel).val();
			$("#ajBoxMenuFunc").loadUrl("app/system/menu/func.do?action=actionLoadMenuFuncList&menuId=" + menu_id, {}, function(){
				$.pdialog.closeCurrent();
			});
		}
	}
	$(function(){
		$.each($("textarea", $("#formMFunc")), function(){
			$(this).html($(this).text().replace(/<br\/>/g,"\n"));
		})
	});
</script>

<div class="pageContent">
	<form method="post" action="app/system/menu/func.do?action=actionSaveMenuFunc" class="pageForm required-validate" onsubmit="return validateCallback(this, after_save);" id="formMFunc">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<tr>
					<td>所属菜单：</td>
					<td>
						<input name="menuTitle" type="text" size="30" value="${func ne null ? func.menu.menuTitle : menu.menuTitle}" style="width: 88%" readonly/>
						<input name="menuId" type="hidden" size="30" value="${func ne null ? func.menu.id : menu.id}" style="width: 88%" readonly/>
					</td>
				</tr>
				<tr>
					<td>功能名称：</td>
					<td><input name="funcName" type="text" size="30" value="${func ne null ? func.funcName : ''}" class="required" style="width: 88%"/></td>
				</tr>
				<tr>
					<td>功能键值：</td>
					<td><input name="funcKey" type="text" size="30" value="${func ne null ? func.funcKey : ''}" class="required" style="width: 88%" <logic:notPresent name="func">remote="app/system/menu.do?action=actionUniqueCheckMenuFuncKey"</logic:notPresent> ${func ne null ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					<td>功能图标：</td>
					<td>
						<input name="funcIcon" type="text" size="30" value="${func ne null ? func.funcIcon : 'javascript:void(0);'}" style="width: 88%"/>
						<span class="diaMicon ${func ne null ? func.funcIcon : ''}"></span>
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">功能链接：</td>
					<td>
						<textarea rows="2" cols="40" name="urls" class="textInput required" style="width: 88%"><logic:present name="func"><logic:present name="func" property="funcURLs"><logic:iterate name="func" property="funcURLs" id="entity">${entity.urlPath}<br/></logic:iterate></logic:present></logic:present></textarea>
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">功能描述：</td>
					<td>
						<textarea rows="2" cols="40" name="funcDesc" class="textInput" style="width: 88%">${func ne null ? func.funcDesc : ''}</textarea>
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
		<input type="hidden" name="id" value="${func ne null ? func.id : '-1'}" />
	</form>
<div>