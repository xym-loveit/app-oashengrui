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
				$("#addressbook_participants").loadUrl(
					"app/personal/addressBook.do?action=loadEmployeeData", 
					{"depId": depId, "districtId": districtId}, function(){});
				/*
				generic_ajax_op("app/base.do?action=actionLoadEmployeeByDepAndDistrict", "{'districtId':'" + districtId + "', 'depId':'" + depId + "'}", null, (function(rsp_msg){
				if (rsp_msg) {
					var json_obj = eval('(' + rsp_msg + ')');
					$('#addressbook_participants').manifest('add', json_obj);
				  };
				}
				));
				*/
			});
		});
	});
</script>

<ul class="tree treeFolder">
	<c:if test="${districts ne null}">
		<c:forEach items="${districts}" var="entity">
			<li><a id="org_master"><c:out value="${entity.districtName}" /></a>
				<ul>
					<c:choose>
						<c:when test="${entity.districtType eq 0}">
							<c:if test="${departments ne null}">
								<c:forEach items="${departments}" var="entry">
									<c:if test="${entry.key eq 0}">
										<c:forEach items="${entry.value}" var="department">
											<li><a id="mtask_depentity_${department.id}" depId="${department.id}" districtId="${entity.id}" href="app/base.do?action=actionLoadEmployeeByDepAndDistrict&districtId=${entity.id}&depId=${department.id}" callback="dep_activated(${department.id});" target="ajax" ref="addressbook_participants"><c:out value="${department.depName}" /></a></li>
										</c:forEach>
									</c:if>
								</c:forEach>
							</c:if>
						</c:when>
						<c:when test="${entity.districtType eq 1}">
							<c:if test="${departments ne null}">
								<c:forEach items="${departments}" var="entry">
									<c:if test="${entry.key eq 1}">
										<c:forEach items="${entry.value}" var="department">
											<li><a id="mtask_depentity_${department.id}" depId="${department.id}" districtId="${entity.id}" href="app/base.do?action=actionLoadEmployeeByDepAndDistrict&districtId=${entity.id}&depId=${department.id}" callback="dep_activated(${department.id});" target="ajax" ref="addressbook_participants"><c:out value="${department.depName}" /></a></li>
										</c:forEach>
									</c:if>
								</c:forEach>
							</c:if>
						</c:when>
					</c:choose>
			   </ul>
			</li>
		</c:forEach>
	</c:if>
</ul>
