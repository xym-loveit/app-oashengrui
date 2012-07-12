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

<!--<script type="text/javascript">-->
<!--	function dep_refresh (refresh) {-->
<!--		if (refresh) {-->
<!--			$("#ajBoxMenuTree").loadUrl("app/system/school/department.do?action=actionLoadDepartmentTree", {}, function(){-->
<!--				if ($("#_var_depid", $(navTab.getCurrentPanel())).size() > 0) {-->
<!--					$("#_var_depid", $(navTab.getCurrentPanel())).remove();-->
<!--				}-->
<!--			});-->
<!--		} else {-->
<!--			if ($("#_var_depid", $(navTab.getCurrentPanel())).size() > 0) {-->
<!--				$("#_var_depid", $(navTab.getCurrentPanel())).remove();-->
<!--			}-->
<!--		}-->
<!--		-->
<!--		$("#ajBoxMenuFunc").loadUrl("app/system/school/department/position.do?action=actionLoadDepartmentPosition", {}, function(){-->
<!--		});-->
<!--	}-->
<!--	-->
<!--	function callback_funcRemove(id) {-->
<!--		if (id == undefined && $("tr.selected", "#ajBoxMenuFunc").size() > 0) {-->
<!--			id = $("tr.selected", "#ajBoxMenuFunc").attr("rel");-->
<!--		}-->
<!--		if ($("#mfunc-" + id).size() > 0) {-->
<!--			$("#mfunc-" + id).fadeOut("slow");-->
<!--		}-->
<!--	}-->
<!--</script>-->
<div class="pageContent bor" style="float:left; width: 150px;">
	<div class="toggleCollapse noborder">
		<h2>校区列表</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh" href="app/system/school/department.do?action=actionLoadDepartmentTree" target="ajax" rel="ajBoxDepTree" title="刷新" rel="dia_admin_entryadd" callback="dep_refresh()"><span>刷新</span></a></li>
			<li class="line">line</li>
			<li><a class="add" href="app/system/school/department.do?action=dialogSchoolDepartmentPage" mask="true" target="dialog" title="启用模板" width="504" height="339" rel="dia_sysmenu_additem"><span>启用模板</span></a></li>
		</ul>
	</div>
	<div id="ajBoxDepTree">
	    <%@ include file="data/dataWorkTree.jsp" %>
	</div>
</div>

<div class="pageContent bol" style="margin-left: 160px;">
	<div class="toggleCollapse noborder">
		<h2>工作安排设置</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh uvar" href="app/system/school/department/position.do?action=actionLoadDepartmentPosition&depId={_var_depid}" warn="请从左侧选择部门!" target="ajax" rel="ajBoxDepPos" title="刷新" rel="dia_admin_entryadd"><span>刷新</span></a></li>
			<li class="line">line</li>
			<li><a class="add" href="app/system/school/department/position.do?action=dialogSchoolDepartmentPositionPage&depId={_var_depid}" mask="true" warn="请从左侧选择部门!" target="dialog" title="添加新模板" width="504" height="335" rel="dia_admin_entryadd"><span>添加新模板</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" href="app/system/school/department/position.do?action=actionRemoveDepartmentPosition&posId={posId}" target="ajaxTodo" warn="请选择需要删除的模板" title="确定要删除该模板吗?" callback="callback_funcRemove()"><span>删除模板</span></a></li>
		</ul>
	</div>
	<div id="ajBoxDepPos">
	    <%@ include file="data/dataWorkBaseContent.jsp" %>
	</div>
</div>