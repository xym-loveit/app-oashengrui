<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<ul class="tree treeFolder" layoutH="8">
	<li>
		<a id="org_master">${processType.processTypeName}</a>
		<ul>
			<logic:present name="prcessDefs">
				<c:choose>
					<c:when test="${fn:length(prcessDefs) eq 1}">
						<logic:iterate name="prcessDefs" id="entity">
							<li><a id="fdefEntity_${typeSlug}_${entity.id}" class='tparam' param="_var_fdefid" paramRel="${entity.id}" href="app/flow/${typeSlug}.do?action=actionLoadProcessTasks&procDefId=${entity.id}" target="ajax" rel="ajBoxFlowConf_${processType.id}"><c:out value="${entity.filterPoset.posetName}" /></a></li>
						</logic:iterate>
					</c:when>
					<c:when test="${fn:length(prcessDefs) gt 1}">
						<logic:iterate name="prcessDefs" id="entity">
							<li><a id="fdefEntity_${typeSlug}_${entity.id}" class='tparam' param="_var_fdefid" paramRel="${entity.id}" href="app/flow/${typeSlug}.do?action=actionLoadProcessTasks&procDefId=${entity.id}&istran=y" target="ajax" rel="ajBoxFlowConf_${processType.id}">
							${entity.filterPoset.posetName} ${entity.condition eq null ? '' : (entity.condition eq 'x == 0' ? '- 校区内' : (entity.condition eq 'x == 1' ? '- 跨校区' : '- 未知'))}</a></li>
						</logic:iterate>
					</c:when>
				</c:choose>
			</logic:present>
		</ul>
	</li>
</ul>
