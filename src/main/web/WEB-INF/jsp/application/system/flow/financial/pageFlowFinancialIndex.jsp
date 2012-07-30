<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

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
			<c:if test="${(typeSlug eq 'hrm' && tm:ifGranted('_FUNCKEY_FLOW_HRM_TYPE_REFRESH')) || (typeSlug eq 'finance' && tm:ifGranted('_FUNCKEY_FLOW_FINAN_TYPE_REFRESH'))}">
			<li><a class="refresh" href="app/flow.do?action=actionLoadProcessRootType&typeSlug=${typeSlug}" target="ajax" rel="ajBoxFlowTree_finance" title="刷新" rel="dia_admin_entryadd" callback="dep_refresh()"><span>刷新</span></a></li>
			</c:if>
		</ul>
	</div>
	
	<div id="ajBoxFlowTree_finance">
		<%@ include file="../public/data/dataFlowTypeTree.jsp" %>
	</div>
</div>

<div class="pageContent bol" style="margin-left: 230px;">
	<div class="toggleCollapse noborder">
		<h2>申请类别</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<c:if test="${tm:ifGranted('_FUNCKEY_FLOW_FINAN_PROC_TYPE_REFRESH')}">
			<li><a class="refresh uvar" href="app/flow.do?action=actionLoadProcessTypes&rootTypeId={_var_ftypeid}" warn="请从左侧选择审批类型!" target="ajax" rel="ajBoxMenuFunc" title="刷新" rel="dia_admin_entryadd"><span>刷新</span></a></li>
			<li class="line">line</li>
			</c:if>
			<c:if test="${tm:ifGranted('_FUNCKEY_FLOW_FINAN_PROC_TYPE_ADD')}">
			<li><a class="add" href="app/flow.do?action=dialogFlowTypePage&rootTypeId={_var_ftypeid}" mask="true" warn="请从左侧选择审批类型!" target="dialog" title="添加申请类别" width="400" height="245" rel="dia_flowtype_add_${typeSlug}"><span>添加申请类别</span></a></li>
			<li class="line">line</li>
			</c:if>
			<c:if test="${tm:ifGranted('_FUNCKEY_FLOW_FINAN_PROC_TYPE_EDIT')}">
			<li><a class="edit" href="app/flow.do?action=dialogFlowTypePage&rootTypeId={_var_ftypeid}&typeId={typeId}" target="dialog" warn="请选择需要修改的申请类别" title="修改申请类别" width="504" height="335" rel="dia_flowtype_edit_${typeSlug}"><span>修改</span></a></li>
			</c:if>
		</ul>
	</div>
	<div id="ajBoxFlowType_finance">
		<%@ include file="../public/data/dataFlowTypeList.jsp" %>
	</div>
</div>
