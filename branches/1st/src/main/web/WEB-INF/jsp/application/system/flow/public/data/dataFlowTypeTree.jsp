<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	// 高亮显示选中
	function ftype_activated(id) {
		var uroot = $("#ftentity_${typeSlug}_" + id).parent().parent().parent();
		uroot.find("div.selected").removeClass("selected");
		$("#ftentity_${typeSlug}_" + id).parent().addClass("selected");
	}
</script>

<ul class="tree treeFolder" layoutH="8">
	<li>
		<a id="org_master">${typeSlug eq 'finance' ? '财务审批类型' : ( typeSlug eq 'hrm' ? '人资审批类型' : '')}</a>
		<ul>
			<c:if test="${rootTypes ne null}">
				<c:forEach items="${rootTypes}" var="entity">
					<c:choose>
						<c:when test="${typeSlug eq 'finance'}">
							<li><a id="ftentity_${typeSlug}_${entity.id}" class='tparam' param="_var_ftypeid" paramRel="${entity.id}" href="app/flow/${typeSlug}.do?action=actionLoadProcessTypes&rootTypeId=${entity.id}" callback="ftype_activated(${entity.id});" target="ajax" rel="ajBoxFlowType_${typeSlug}"><c:out value="${entity.processTypeName}" /></a></li>
						</c:when>
						<c:when test="${typeSlug eq 'hrm'}">
							<li><a id="ftentity_${typeSlug}_${entity.id}" class='tparam' param="_var_htypeid" paramRel="${entity.id}" href="app/flow/${typeSlug}.do?action=actionLoadProcessPosets&rootTypeId=${entity.id}" callback="ftype_activated(${entity.id});" target="ajax" rel="ajBoxFlowType_${typeSlug}"><c:out value="${entity.processTypeName}" /></a></li>
						</c:when>
					</c:choose>
				</c:forEach>
			</c:if>
		</ul>
	</li>
</ul>

