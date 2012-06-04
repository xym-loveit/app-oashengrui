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
			if ($("#_var_depid", $(navTab.getCurrentPanel())).size() > 0) {
				$("#_var_depid", $(navTab.getCurrentPanel())).remove();
			}
		});
	}
	
	function callback_funcRemove(id) {
		if (id == undefined && $("tr.selected", "#ajBoxMenuFunc").size() > 0) {
			id = $("tr.selected", "#ajBoxMenuFunc").attr("rel");
		}
		if ($("#mfunc-" + id).size() > 0) {
			$("#mfunc-" + id).fadeOut("slow");
		}
	}
</script>

<div class="pageContent bor" style="float:left; width: 280px;">
	<div class="toggleCollapse noborder">
		<h2>部门列表</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh" href="app/system/school/department.do?action=actionLoadDepartmentTree" target="ajax" rel="ajBoxMenuTree" title="刷新" rel="dia_admin_entryadd" callback="func_refresh();"><span>刷新</span></a></li>
			<li class="line">line</li>
			<li><a class="add" href="app/system/school/department.do?action=dialogSchoolDepartmentPage" mask="true" target="dialog" title="新增部门" width="504" height="339" rel="dia_sysmenu_additem"><span>新增部门</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="app/system/school/department.do?action=dialogSchoolDepartmentPage&depId={_var_depid}" target="dialog" warn="请选择需要修改的部门!" title="修改部门" width="504" height="389" rel="dia_sys_menuitemedit"><span>修改</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" href="app/system/school/department.do?action=actionRemoveDepartment&depId={_var_depid}" target="ajaxTodo" warn="请选择需要删除的部门" title="确定要删除该部门吗?" callback=""><span>删除</span></a></li>
		</ul>
	</div>
	
	<div id="ajBoxMenuTree">
		<%@ include file="data/dataDepartmentTree.jsp" %>
	</div>
</div>

<div class="pageContent bol" style="margin-left: 290px;">
	<div class="toggleCollapse noborder">
		<h2>岗位列表</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh uvar" href="app/system/school/department/position.do?action=actionLoadDepartmentPosition&depId={_var_depid}" warn="请从左侧选择部门!" target="ajax" rel="ajBoxMenuFunc" title="刷新" rel="dia_admin_entryadd"><span>刷新</span></a></li>
			<li class="line">line</li>
			<li><a class="add" href="app/system/school/department/position.do?action=dialogSchoolDepartmentPositionPage&depId={_var_depid}" mask="true" warn="请从左侧选择部门!" target="dialog" title="添加岗位" width="504" height="275" rel="dia_admin_entryadd"><span>添加岗位</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" href="app/system/school/department/position.do?action=actionRemoveDepartmentPosition&posId={posId}" target="ajaxTodo" warn="请选择需要修改的岗位" title="确定要删除该岗位吗?" callback="callback_funcRemove()"><span>删除</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="app/system/school/department/position.do?action=dialogSchoolDepartmentPositionPage&posId={posId}" target="dialog" warn="请选择需要修改的岗位" title="修改岗位" width="504" height="275" rel="dia_sys_menufuncedit"><span>修改</span></a></li>
		</ul>
	</div>
	<div id="ajBoxMenuFunc">
		<%@ include file="data/dataDepartmentPosition.jsp" %>
	</div>
</div>
