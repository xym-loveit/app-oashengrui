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
	function dep_refresh () {
		//$("#ajBoxMenuTree").loadUrl("app/flow.do?action=actionLoadProcessRootType&typeSlug=${typeSlug}", {}, function(){
			if ($("#_var_ftypeid", $(navTab.getCurrentPanel())).size() > 0) {
				$("#_var_ftypeid", $(navTab.getCurrentPanel())).remove();
			}
		//});
		
		//$("#ajBoxMenuFunc").loadUrl("app/flow.do?action=actionLoadDepartmentPosition", {}, function(){
		//});
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

<div class="pageContent bor" style="float:left; width: 220px;">
	<div class="toggleCollapse noborder">
		<h2>${typeSlug eq 'finance' ? '财务' : ( typeSlug eq 'hrm' ? '人资' : '')}审批类型</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh" href="app/flow/${typeSlug}.do?action=actionLoadProcessRootType&typeSlug=${typeSlug}" target="ajax" rel="ajBoxFlowTree_finance" title="刷新" rel="dia_admin_entryadd" callback="dep_refresh()"><span>刷新</span></a></li>
		</ul>
	</div>
	
	<div id="ajBoxFlowTree_hrm">
		<%@ include file="../public/data/dataFlowTypeTree.jsp" %>
	</div>
</div>

<div class="pageContent bol" style="margin-left: 230px;">
	<div class="toggleCollapse noborder">
		<h2>职位审批流程配置</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh uvar" href="app/flow/${typeSlug}.do?action=actionLoadProcessTypes&rootTypeId={_var_ftypeid}" warn="请从左侧选择审批类型!" target="ajax" rel="ajBoxMenuFunc" title="刷新" rel="dia_admin_entryadd"><span>刷新</span></a></li>
		</ul>
	</div>
	<div id="ajBoxFlowType_hrm">
		<%@ include file="data/dataFlowPosetList.jsp" %>
	</div>
</div>
