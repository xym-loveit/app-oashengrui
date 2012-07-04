<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<script>
	$(function(){
		$("select[id^=posId_]").unbind("change");
		$("select[id^=posId_]").bind("change", function(){
			var id = $(this).attr("id");
			var ele_posName = $("#" + id + "_name");
			if (ele_posName.size() > 0) {
				ele_posName.val($(this).find("option").filter(":selected").text());
			}
		});
		
		<logic:present name="procTask">
			$.each($("select[id^=posId_]"), function(){
				var id = $(this).attr("id");
				var ele_posName = $("#" + id + "_name");
				if (ele_posName.size() > 0) {
					ele_posName.val($(this).find("option").filter(":selected").text());
				}
			});
		</logic:present>
	});
</script>

<div style="margin-bottom: 15px;"><b>部门部门列表：</b></div>

<logic:present name="deps">
	<logic:iterate name="deps" id="dep">
		<c:if test="${dep.key eq 0}">
			<logic:iterate name="dep" property="value" id="entity">
				<div style="clear:both; margin-bottom: 10px; overflow: hidden">
					<span style="float:left;line-height:20px">${entity.depName}：</span>
					<input type="hidden" name="depName_${entity.id}" value="${entity.depName}" />
					<input type="hidden" name="depId_${entity.id}" value="${entity.id}" />
					<input type="hidden" name="posName_${entity.id}" value="" id="posId_${entity.id}_name" />
					
					<select name="posId_${entity.id}" class="combox" id="posId_${entity.id}">
						<option value="-1">请选择岗位</option>
						<logic:present name="entity" property="positions">
							<logic:iterate name="entity" property="positions" id="position">
								<option value="${position.id}" ${procTask ne null && tm:inRange(procTask.toPositionIds, position.id, ',') ? 'selected="selected"' : ''}>${position.positionName}</option>
							</logic:iterate>
						</logic:present>
					</select>
				</div>
			</logic:iterate>
		</c:if>
	</logic:iterate>
	<input type="hidden" name="procTaskId" value="${procTask ne null ? procTask.id : -1}" />
</logic:present>
