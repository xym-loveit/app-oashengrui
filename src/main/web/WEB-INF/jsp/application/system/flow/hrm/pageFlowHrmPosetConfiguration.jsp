<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="pageContent bor" style="float:left; width: 250px;">
	<div class="toggleCollapse noborder">
		<h2>流程类型-${processType.processTypeName}</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh" href="app/flow.do?action=actionLoadProcessRootType&typeSlug=${typeSlug}" target="ajax" rel="ajBoxFlowDefTree_${processType.id}" title="刷新" rel="dia_admin_entryadd" callback="dep_refresh()"><span>刷新</span></a></li>
			<li class="line">line</li>
		</ul>
	</div>
	
	<div id="ajBoxFlowDefTree_${processType.id}">
		<%@ include file="data/dataFlowDefinitionTree.jsp" %>
	</div>
</div>

<div class="pageContent bol" style="margin-left: 260px;">
	<div class="toggleCollapse noborder">
		<h2>流程节点配置</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh uvar" href="app/flow/${typeSlug}.do?action=actionLoadProcessTypes&procDefId={_var_fdefid}" warn="请从左侧选择流程定义!" target="ajax" rel="ajBoxMenuFunc" title="刷新" rel="dia_admin_entryadd"><span>刷新</span></a></li>
			<li class="line">line</li>
			<li><a class="add" href="app/flow/${typeSlug}.do?action=dialogFlowTaskConfigurationPage&procDefId={_var_fdefid}" mask="true" warn="请从左侧选择流程定义" target="dialog" title="添加流程节点" width="215" height="400" rel="dia_flowtask_add_${processType.id}"><span>添加流程节点</span></a></li>
			<li class="line">line</li>
		</ul>
	</div>
	<div id="ajBoxFlowConf_${processType.id}">
		<%@ include file="../public/data/dataFlowTaskList.jsp" %>
	</div>
</div>
