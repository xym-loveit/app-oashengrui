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

<div class="pageContent bor" style="float:left; width: 240px;">
	<div class="toggleCollapse noborder">
		<h2>菜单项设置</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh" href="app/system/menu.do?action=actionLoadMenuItemTree" target="ajax" rel="ajBoxMenuTree" title="刷新" rel="dia_admin_entryadd"><span>刷新</span></a></li>
			<li class="line">line</li>
			<li><a class="add" href="app/system/menu.do?action=dialogMenuItemPage" mask="true" target="dialog" title="添加菜单项" width="504" height="389" rel="dia_sysmenu_additem"><span>新菜单项</span></a></li>
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
			<li><a class="refresh" href="app/system/menu.do?action=actionLoadMenuFuncList&menuId={menuid}" target="ajax" rel="ajBoxMenuFunc" title="刷新" rel="dia_admin_entryadd"><span>刷新</span></a></li>
			<li class="line">line</li>
			<li><a class="add" href="app/system/menu.do?action=dialogMenuFuncPage" mask="true" target="dialog" title="添加菜单功能" width="504" height="389" rel="dia_admin_entryadd"><span>添加功能</span></a></li>
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
