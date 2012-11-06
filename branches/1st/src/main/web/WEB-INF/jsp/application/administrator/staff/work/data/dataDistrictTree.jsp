<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function(){
		$.each($("a[id^=mtask_depentity_]"), function(){
			$(this).unbind("click");
			$(this).bind("click", function(){
				var depId = $(this).attr("depId");
				var districtId = $(this).attr("districtId");
				generic_ajax_op("app/base.do?action=actionLoadEmployeeByDepAndDistrict", "{'districtId':'" + districtId + "', 'depId':'" + depId + "'}", (function(){
					$("#background,#progressBar").show();
				}), (function(rsp_msg){
					if (rsp_msg) {
						var json_obj = eval('(' + rsp_msg + ')');
						$('#staffs').manifest('add', json_obj);
						$("#background,#progressBar").hide();
					  };
					}
				));
			});
		});
	});
</script>

<ul class="tree treeFolder">
	<c:if test="${district ne null}">
		<li class="expand"><a id="org_master"><c:out value="${district.districtName}" /></a>
			<ul>
				<c:forEach items="${departments}" var="entity">
			    	 <li><a id="mtask_depentity_${entity.id}" depId="${entity.id }" districtId="${district.id }" href="app/base.do?action=actionLoadEmployeeByDepAndDistrict&districtId=${district.id}&depId=${entity.id}" callback="dep_activated(${entity.id});" target="ajax"><c:out value="${entity.depName}" /></a></li>
				</c:forEach>
			   </ul>
			</li>
	</c:if>
</ul>

