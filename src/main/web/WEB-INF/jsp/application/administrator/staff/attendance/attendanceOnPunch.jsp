<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
						<select id="ph" class="combox" name="offtimeShour">
							<option selected="selected" value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
						</select>
						<b class="symbol">：</b>
						<select id="pm" class="combox" name="offtimeSmin">
							<option selected="selected" value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="58">58</option>
							<option value="59">59</option>
						</select> 
						<b class="symbol">-</b>
						<select id="th" class="combox" name="offtimeEhour">
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option selected="selected" value="17">17</option>
							<option value="21">21</option>
							<option value="22">22</option>
						</select>
						<b class="symbol">：</b>
						<select id="tm" class="combox" name="offtimeEmin">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option selected="selected" value="40">40</option>
							<option value="58">58</option>
							<option value="59">59</option>
						</select>
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
		<input type="hidden" name="id" value="${staffAttendance ne null && staffAttendance.attendanceViewId ne null && staffAttendance.attendanceViewId.origin eq 'attendance' ? staffAttendance.attendanceViewId.viewId : '-1' }" />
		<input type="hidden" name="arrang_id" value="${staffAttendance ne null && staffAttendance.attendanceViewId ne null && staffAttendance.attendanceViewId.origin eq 'arrange' ? staffAttendance.attendanceViewId.viewId : '-1' }"/>
	</form>
</div>