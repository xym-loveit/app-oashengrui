<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function(){
		$.each($("a[id^=mtask_disentity_]"), function(){
			$(this).unbind("click");
			$(this).bind("click", function(){
				var depId = $(this).attr("depId");
				var districtId = $(this).attr("districtId");
				generic_ajax_op("app/base.do?action=actionLoadEmployeeByDepAndDistrict", "{'districtId':'" + districtId + "', 'depId':'" + depId + "'}", null, (function(rsp_msg){
					if (rsp_msg) {
						var json_obj = eval('(' + rsp_msg + ')');
						$('#task_participants').manifest('add', json_obj);
					  };
					}
				));
			});
		});
	});
</script>

<ul class="tree treeFolder">
	<c:if test="${departments ne null}">
		<c:forEach items="${departments}" var="entry">
			<c:if test="${entry.key eq 0}">
				<c:forEach items="${entry.value}" var="entity">
					<li class="expand"><a id=""><c:out value="${entity.depName}" /></a>
					   <ul>
						<c:if test="${districts ne null}">
							<c:forEach items="${districts}" var="district">
								<li><a id="mtask_disentity_${district.id}" depId="${entity.id}" districtId="${district.id}" href="app/base.do?action=actionLoadEmployeeByDepAndDistrict&districtId=${district.id}&depId=${entity.id}" target="ajax"><c:out value="${district.districtName}" /></a></li>
							</c:forEach>
						</c:if>
					   </ul>
					</li>
				</c:forEach>
			</c:if>
		</c:forEach>
	</c:if>
</ul>

