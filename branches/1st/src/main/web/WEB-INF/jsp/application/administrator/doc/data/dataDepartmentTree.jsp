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
				generic_ajax_op("app/base.do?action=actionLoadEmployeeByDepAndDistrict", "{'districtId':'" + districtId + "', 'depId':'" + depId + "'}", (function(){
					$("#background,#progressBar").show();
				}), (function(rsp_msg){
					if (rsp_msg) {
						var json_obj = eval('(' + rsp_msg + ')');
						$('#visiableUserNames').manifest('add', json_obj);
						$("#background,#progressBar").hide();
					  };
					}
				));
			});
		});
	});
</script>

<ul class="tree treeFolder">
	<c:if test="${depNames ne null}">
		<c:forEach items="${depNames}" var="entry">
			<li><a id=""><c:out value="${entry}" /></a>
			   <ul>
				<c:if test="${districts ne null}">
					<c:forEach items="${districts}" var="district">
						<c:if test="${depSetIds[district.districtType][entry] ne null}">
						<li><a id="mtask_disentity_${district.id}" depId="${depSetIds[district.districtType][entry]}" districtId="${district.id}" href="app/base.do?action=actionLoadEmployeeByDepAndDistrict&districtId=${district.id}&depId=${depSetIds[district.districtType][entry]}" target="ajax"><c:out value="${district.districtName}" /></a></li>
						</c:if>
					</c:forEach>
				</c:if>
			   </ul>
			</li>
		</c:forEach>
	</c:if>
</ul>

