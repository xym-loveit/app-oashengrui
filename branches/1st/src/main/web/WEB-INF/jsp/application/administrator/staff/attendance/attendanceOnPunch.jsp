<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	$(function(){
		var hours = "";
		for(var i = 0 ; i < 24 ; i++)
		{
			if(i<10)
			 	hours += "<option value='0"+i+"'>0"+i+"</option>";
			 else
				hours += "<option value='"+i+"'>"+i+"</option>";
		}
		$("#amh").html(hours);
		$("#pmh").html(hours);
		var minutes = "";
		for(var i = 0 ; i < 60 ; i++)
		{
			if(i<10)
				minutes += "<option value='0"+i+"'>0"+i+"</option>";
			 else
				minutes += "<option value='"+i+"'>"+i+"</option>";
		}
		$("#amm").html(minutes);
		$("#pmm").html(minutes);
	});
</script>
<!-- Body -->	
<div class="pageContent">
	<form onsubmit="return validateCallback(this, dialogAjaxDone);" action="app/admin/attendance/operation.do?action=actionPuchOnHand" method="post">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>
						<label>员工姓名：</label><input name="staffName" type="text" readonly value="${staffAttendance ne null ? staffAttendance.staffName:'' }" />
					</td>
				</tr>
				<tr>
					<td>
						<label>工作日期：</label><input name="workDate" type="text" readonly value="<fmt:formatDate value="${staffAttendance.workDate }" type="date" pattern="yyyy-MM-dd"/>" />
					</td>
				</tr>
				<tr>
					<td>
						<label>工作时间：</label><input name="workTime" type="text" value="${staffAttendance.workTime }" readonly />
					</td>
				</tr>
				<tr>
					<td>
						<label>打卡：</label>
						<select id="amh" class="combox" name="offtimeShour"></select>
						<b class="symbol">：</b>
						<select id="amm" class="combox" name="offtimeSmin"></select> 
						<b class="symbol">-</b>
						<select id="pmh" class="combox" name="offtimeEhour"></select>
						<b class="symbol">：</b>
						<select id="pmm" class="combox" name="offtimeEmin"></select>
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">打卡</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="staffId" value="${staffAttendance ne null?staffAttendance.staffId:'' }" />
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
		<c:if test="${staffAttendance ne null && staffAttendance.districtId }">
			<input type="hidden" name="districtId" value="${staffAttendance.districtId }" />
		</c:if>
		<c:if test="${staffAttendance ne null && staffAttendance.depId }">
			<input type="hidden" name="depId" value="${staffAttendance.depId }" />
		</c:if>
		<input type="hidden" name="id" value="${staffAttendance ne null && staffAttendance.attendanceViewId ne null && staffAttendance.attendanceViewId.origin eq 'attendance' ? staffAttendance.attendanceViewId.viewId : '-1' }" />
		<input type="hidden" name="arrang_id" value="${staffAttendance ne null && staffAttendance.attendanceViewId ne null && staffAttendance.attendanceViewId.origin eq 'arrange' ? staffAttendance.attendanceViewId.viewId : '-1' }"/>
	</form>
</div>