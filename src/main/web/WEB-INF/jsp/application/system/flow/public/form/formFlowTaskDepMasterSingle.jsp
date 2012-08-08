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
		$("select[id^=cmb_]").unbind("change");
		$("select[id^=cmb_]").bind("change", function(){
			var id = $(this).attr("id");
			var ele_posName = $("#" + id + "_name");
			if (ele_posName.size() > 0) {
				ele_posName.val($(this).find("option").filter(":selected").text());
			}
		});
		
		<logic:present name="procTask">
			$.each($("select[id^=cmb_]"), function(){
				var id = $(this).attr("id");
				var ele_posName = $("#" + id + "_name");
				if (ele_posName.size() > 0) {
					ele_posName.val($(this).find("option").filter(":selected").text());
				}
			});
		</logic:present>
	});
</script>

<logic:present name="deps">
	<logic:iterate name="deps" id="dep">
		<c:if test="${dep.key eq 0}">
			<div style="overflow:hidden; margin-bottom: 10px;">
				<div style="margin-bottom: 10px;"><b>请选择部门：</b></div>
				<div>
					<input type="hidden" name="depName" value="" id="cmb_posId_ms_name" />
					<select name="depId" class="combox" id="cmb_depId_ms" ref="cmb_posId_ms" refUrl="app/base.do?action=actionLoadPositionByDepartment&depId={value}">
						<option value="-1">请选择部门</option>
						<logic:iterate name="dep" property="value" id="entity">
							<option value="${entity.id}" ${procTask ne null && tm:inRange(procTask.toDepartmentIds, entity.id, ',') ? "selected='selected'" : ""}>${entity.depName}</option>
						</logic:iterate>
					</select>
				</div>
			</div>
			
			<div style="overflow:hidden; clear:both">
				<div style="margin-bottom: 10px;"><b>请选择岗位：</b></div>
				<div>
					<input type="hidden" name="posName" value="" id="cmb_posId_ms_name" />
					<select name="posId" class="combox" id="cmb_posId_ms" defOPKey="请选择岗位" defOPVal="">
						<option value="-1">请选择岗位</option>
						<logic:present name="pos">
							<logic:iterate name="pos" id="entity">
								<option value="${entity.id}" ${procTask ne null && tm:inRange(procTask.toPositionIds, entity.id, ',') ? "selected='selected'" : ""}>${entity.positionName}</option>
							</logic:iterate>
						</logic:present>
					</select>
				</div>
			</div>
		</c:if>
	</logic:iterate>
	<input type="hidden" name="procTaskId" value="${procTask ne null ? procTask.id : -1}" />
</logic:present>
