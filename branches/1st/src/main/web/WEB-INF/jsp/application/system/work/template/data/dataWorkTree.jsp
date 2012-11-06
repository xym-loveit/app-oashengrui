<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	// 高亮显示选中的菜单项, 供功能菜单联动选择
	function dep_activated(id) {
		var uroot = $("#dentity_" + id).parent().parent().parent();
		uroot.find("div.selected").removeClass("selected");
		$("#dentity_" + id).parent().addClass("selected");
	}
</script>
<ul class="tree treeFolder" layoutH="8">
	<c:if test="${district ne null}">
		<li class="expand"><a id="org_master"><c:out value="${district.districtName}" /></a>
			<ul>
				<c:forEach items="${departments}" var="entity">
			    	 <li><a id="dentity_${entity.id}" class='tparam' param="_var_departId" paramRel="${entity.id}"><c:out value="${entity.depName }" /></a></li>
				</c:forEach>
			   </ul>
			</li>
	</c:if>
</ul>
