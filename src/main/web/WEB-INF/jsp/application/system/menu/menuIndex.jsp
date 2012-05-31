<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.noborder {border-left: none; border-right: none; border-top: none;}
</style>

<script type="text/javascript">
	function func_refresh () {
		$("#ajBoxMenuFunc").loadUrl("app/system/menu.do?action=actionLoadMenuFuncList", {}, function(){
			if ($("#_var_menuid", $(navTab.getCurrentPanel())).size() > 0) {
				$("#_var_menuid", $(navTab.getCurrentPanel())).remove();
			}
		});
	}
</script>

<div class="pageContent bor" style="float:left; width: 240px;">
	<div class="toggleCollapse noborder">
		<h2>菜单项设置</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh" href="app/system/menu/item.do?action=actionLoadMenuItemTree" target="ajax" rel="ajBoxMenuTree" title="刷新" rel="dia_admin_entryadd" callback="func_refresh();"><span>刷新</span></a></li>
			<li class="line">line</li>
			<li><a class="add" href="app/system/menu/item.do?action=dialogMenuItemPage" mask="true" target="dialog" title="添加菜单项" width="504" height="389" rel="dia_sysmenu_additem"><span>新菜单项</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="app/admin.do?action=adminPageEntryDetail&id={sid}" target="dialog" title="修改新闻" width="900" height="500" rel="dia_admin_entryedit{sid}"><span>修改</span></a></li>
		</ul>
	</div>
	
	<div id="ajBoxMenuTree">
		<%@ include file="data/dataMenuTree.jsp" %>
	</div>
</div>

<div class="pageContent bol" style="margin-left: 250px;">
	<div class="toggleCollapse noborder">
		<h2>菜单功能列表</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh uvar" href="app/system/menu/func.do?action=actionLoadMenuFuncList&menuId={_var_menuid}" warn="请选择菜单项!" target="ajax" rel="ajBoxMenuFunc" title="刷新" rel="dia_admin_entryadd"><span>刷新</span></a></li>
			<li class="line">line</li>
			<li><a class="add" href="app/system/menu/func.do?action=dialogMenuFuncPage&menuId={_var_menuid}" mask="true" warn="请选择菜单项!" target="dialog" title="添加菜单功能" width="504" height="389" rel="dia_admin_entryadd"><span>添加功能</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" href="app/admin.do?action=adminOprEntryRemove&id={sid}" target="ajaxTodo" title="确定要删除吗?" callback="hello"><span>删除</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="app/admin.do?action=adminPageEntryDetail&id={sid}" target="dialog" title="修改新闻" width="900" height="500" rel="dia_admin_entryedit{sid}"><span>修改</span></a></li>
		</ul>
	</div>
	<div id="ajBoxMenuFunc">
		<%@ include file="data/dataMenuFunc.jsp" %>
	</div>
</div>
