<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript">
	function loadVocation(){
		var url = "app/admin/attendance/operation.do?action=actionCalculateVocation&staffId="+$("#staffId").val()+"&leaveType="+$("#annual_type").val()+"&staffName="+$("#staffName").val();
		$("#vocation").loadUrl(url,{},function(){});
	}
</script>
<!-- Body -->	
<div class="pageContent">
	<form onsubmit="return validateCallback(this, dialogAjaxDone);" action="app/admin/attendance/operation.do?action=actionArrangeOnLeave" method="post">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td><label>员工姓名：</label></td>
					<td>
						<input name="staffName" id="staffName" type="text" readonly value="${staffAttendance ne null ? staffAttendance.staffName:'' }" />
					</td>
					<td><label>工作日期：</label></td>
					<td>
						<input name="workDate" type="text" readonly value="<fmt:formatDate value="${staffAttendance.workDate }" type="date" pattern="yyyy-MM-dd"/>" />
					</td>
				</tr>
				<tr>
					<td><label>工作时间：</label></td>
					<td>
						<input name="workTime" type="text" value="${staffAttendance.workTime }" readonly />
					</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td><label>请假类型：</label></td>
					<td>
						<select id="annual_type" class="combox" name="leaveType" onchange="loadVocation()">
							<option value="-1" selected="selected">请选择</option>
							<option value="1">病假（非带薪）</option>
							<option value="2">事假（非带薪）</option>
							<option value="3">年休假（带薪）</option>
							<option value="4">调休假（带薪）</option>
							<option value="5">其他（带薪）</option>
						</select>
					</td>
					<td style="color:red" id="vocation" colspan="2"></td>
				</tr>
				<tr>
					<td>
						<label>代班人：</label>
					</td>
					<td>
						<input id="inputEmpId" name="emp.id" value="" type="hidden"/>
						<input class="required" name="emp.fullName" type="text" value="${conference ne null ? conference.contactor : ''}" <c:choose><c:when test="${op ne null && op eq 'view'}">readonly</c:when> <c:otherwise>postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" </c:otherwise></c:choose>/>
					</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td>
						<label>请假说明：</label>
					</td>
					<td colspan="2">
						<textarea rows="2" cols="40" name="meto" class="textInput"></textarea>
					</td>
					<td></td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">员工请假</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<c:if test="${staffAttendance ne null && staffAttendance.offtimeShour ne null}">
			<input type="hidden" name="offtimeShour" value="${staffAttendance.offtimeShour }" />
		</c:if>
		<c:if test="${staffAttendance ne null && staffAttendance.offtimeSmin ne null}">
			<input type="hidden" name="offtimeSmin" value="${staffAttendance.offtimeSmin }" />
		</c:if>
		<c:if test="${staffAttendance ne null && staffAttendance.offtimeEhour ne null}">
			<input type="hidden" name="offtimeEhour" value="${staffAttendance.offtimeEhour }" />
		</c:if>
		<c:if test="${staffAttendance ne null && staffAttendance.offtimeEmin ne null}">
			<input type="hidden" name="offtimeEmin" value="${staffAttendance.offtimeEmin }" />
		</c:if>
		<input type="hidden" id="staffId" name="staffId" value="${staffAttendance ne null?staffAttendance.staffId:'' }" />
		<input type="hidden" name="workType" value="${staffAttendance ne null?staffAttendance.workType:'' }" />
		<input type="hidden" name="workStatus" value="${staffAttendance ne null?staffAttendance.workStatus:'' }" />
		<c:if test="${staffAttendance ne null && staffAttendance.leaveType ne null}">
			<input type="hidden" name="leaveType" value="${staffAttendance.leaveType }" />
		</c:if>
		<c:if test="${staffAttendance ne null && staffAttendance.staffBehalfId ne null}">
			<input type="hidden" name="staffBehalfId" value="${staffAttendance.staffBehalfId }" />
		</c:if>
		<c:if test="${staffAttendance ne null && staffAttendance.staffBehalfName ne null }">
			<input type="hidden" name="staffBehalfName" value="${staffAttendance.staffBehalfName }" />
		</c:if>
		<input type="hidden" name="meto" value="${staffAttendance ne null?staffAttendance.meto:'' }" />
		<c:if test="${staffAttendance ne null && staffAttendance.attendanceResult }">
			<input type="hidden" name="attendanceResult" value="${staffAttendance.attendanceResult }" />
		</c:if>
		<c:if test="${staffAttendance ne null && staffAttendance.exception }">
			<input type="hidden" name="exception" value="${staffAttendance.exception }" />
		</c:if>
		<c:if test="${staffAttendance ne null && staffAttendance.districtId ne null }">
			<input type="hidden" name="districtId" value="${staffAttendance.districtId }" />
		</c:if>
		<c:if test="${staffAttendance ne null && staffAttendance.depId ne null }">
			<input type="hidden" name="depId" value="${staffAttendance.depId }" />
		</c:if>
		<input type="hidden" name="id" value="${staffAttendance ne null && staffAttendance.attendanceViewId ne null && staffAttendance.attendanceViewId.origin eq 'attendance' ? staffAttendance.attendanceViewId.viewId : '-1' }" />
		<input type="hidden" name="arrang_id" value="${staffAttendance ne null && staffAttendance.attendanceViewId ne null && staffAttendance.attendanceViewId.origin eq 'arrange' ? staffAttendance.attendanceViewId.viewId : '-1' }"/>
	</form>
</div>