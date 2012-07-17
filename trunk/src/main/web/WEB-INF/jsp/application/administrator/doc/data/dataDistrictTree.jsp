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

<logic:present name="lookup">
	<div class="pageContent">
	<div class="pageFormContent" layoutH="58">
</logic:present>

<ul class="tree treeFolder" layoutH="8">
	<c:if test="${districts ne null}">
		<c:forEach items="${districts}" var="entity">
			<li class="expand"><a id="org_master"><c:out value="${entity.districtName}" /></a>
			   <ul>
			    <c:if test="${deps ne null}">
		           <c:forEach items="${deps}" var="dep_entity">
			         <li class="expand"><a id="org_master"><c:out value="${dep_entity.depName}" /></a>
			         </li>
		          </c:forEach>
	            </c:if>
			   </ul>
			</li>
		</c:forEach>
	</c:if>
</ul>

<logic:present name="lookup">
	</div>
	<div class="formBar">
	<ul>
		<li>
		<div class="button">
		<div class="buttonContent">
		<button class="close" type="button">关闭</button>
		</div>
		</div>
		</li>
	</ul>
	</div>
	</div>
</logic:present>
