<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	a.oplink  {color: blue; text-decoration: underline;}
</style>

<form id="pagerForm" method="post" action="app/admin.do?action=adminPageStaffAttendance">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>
<script type="text/javascript">
	function hello(rsp_msg) {
		alert(rsp_msg.message);
	}
</script>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin/attendance.do?action=adminPageStaffAttendance" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						员工姓名：<input type="text" name="staffName" value="${formStaffAttendance ne null ? formStaffAttendance.staffName : ''}" />
					</td>
					<td>
						<label>上班状态：</label>
						<select class="combox" name="workType" id="workType">
							<option value="">所有</option>
							<option value="1" ${formStaffAttendance ne null && formStaffAttendance.workType eq '1' ? 'selected="selected"':'' }>在岗</option>
							<option value="2" ${formStaffAttendance ne null && formStaffAttendance.workType eq '2' ? 'selected="selected"':'' }>出差</option>
							<option value="0" ${formStaffAttendance ne null && formStaffAttendance.workType eq '0' ? 'selected="selected"':'' }>请假</option>
						</select>
					</td>
					<td>
						<label>考勤结果：</label>
						<select class="combox" name="attendanceResult" id="attendanceResult">
							<option value="">所有</option>
							<option value="1" ${formStaffAttendance ne null && formStaffAttendance.attendanceResult eq '1' ? 'selected="selected"':'' }>按时</option>
							<option value="2" ${formStaffAttendance ne null && formStaffAttendance.attendanceResult eq '2' ? 'selected="selected"':'' }>迟到</option>
							<option value="3" ${formStaffAttendance ne null && formStaffAttendance.attendanceResult eq '3' ? 'selected="selected"':'' }>早退</option>
							<option value="4" ${formStaffAttendance ne null && formStaffAttendance.attendanceResult eq '4' ? 'selected="selected"':'' }>旷工</option>
						</select>
					</td>
					<td>
						上班时间：<input type="text" class="date textInput" name="startWorkDate">${formStaffAttendance.startWorkDate}</input> - <input name="endWorkDate" type="text" class="date textInput" value="${formStaffAttendance ne null ? formStaffAttendance.endWorkDate : ''}" />
					</td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
				</ul>
			</div>
		</div>
	</form>
</div>

<!-- Body -->	
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="确定要导入考勤数据吗?"><span>导入考勤数据</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">工作日期</th>
				<th align="center">工作时间</th>
				<th align="center">姓名</th>
				<th align="center">上班类型</th>
				<th align="center">实际上下班时间</th>
				<th align="center">上班状态</th>
				<th align="center">代班人</th>
				<th align="center">考勤结果</th>
				<th align="center">异常数据</th>
				<th align="center">手动打卡</th>
				<th align="center">出差安排</th>
				<th align="center">请假</th>
				<th align="center">旷工</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="staffAttendances">
		       <logic:iterate name="staffAttendances" property="items" id="entity">
			      <tr target="sid" rel="${entity.id}">
					<td><fmt:formatDate value="${entity.workDate}" type="date" pattern="yyyy-MM-dd"/></td>
					<td>${entity.workTime}</td>
					<td>${entity.staffName}</td>
					<td><c:if test="${entity.workType==0}">正常上班</c:if><c:if test="${entity.workType==1 }">带薪上班</c:if></td>
					<td>${entity.offtimeShour}:${entity.offtimeSmin} - ${entity.offtimeEhour}:${entity.offtimeEmin}</td>
					<td><c:if test="${entity.workStatus==0}">在岗</c:if><c:if test="${entity.workStatus==1}">出差</c:if><c:if test="${entity.workStatus==2}">请假</c:if></td>
					<td>${entity.staffBehalfName ne null ? entity.staffBehalfName : "-"}</td>
					<td>${entity.attendanceResult}</td>
					<td></td>
					<td><a href="app/admin.do?action=adminPageStaffAttendanceOnPunch&id=2" class="oplink" target="dialog" title="员工考勤-打卡" width="550" height="250" rel="admin_dutypunch-2">打卡</a></td>
				    <td><a href="app/admin.do?action=adminPageStaffAttendanceOnTravel&id=2" class="oplink" target="dialog" title="员工考勤-出差安排" width="350" height="220" rel="admin_dutytravel-2">出差安排</a></td>
					<td><a href="app/admin.do?action=adminPageStaffAttendanceOnLeave&id=2" class="oplink" target="dialog" title="员工考勤-请假" width="550" height="320" rel="admin_dutyleave-2">请假</a></td>
					<td><a href="app/admin.do?action=adminPageStaffAttendanceOnAbsence&id=2" class="oplink" target="dialog" title="员工考勤-旷工" width="550" height="300" rel="admin_dutyabsence-2">旷工</a></td>
				</tr>
			</logic:iterate>
		  </logic:present>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
				<option value="20" ${pagingBean ne null && pagingBean.pageSize eq 20 ? 'selected="selected"' : ''}>20</option>
				<option value="50" ${pagingBean ne null && pagingBean.pageSize eq 50 ? 'selected="selected"' : ''}>50</option>
				<option value="100" ${pagingBean ne null && pagingBean.pageSize eq 100 ? 'selected="selected"' : ''}>100</option>
				<option value="200" ${pagingBean ne null && pagingBean.pageSize eq 200 ? 'selected="selected"' : ''}>200</option>
			</select>
			<span>条，共${pagingBean ne null ? pagingBean.totalItems : 0}条</span>
		</div>
		<div class="pagination" targetType="navTab" totalCount="${pagingBean ne null ? pagingBean.totalItems : 0}" numPerPage="${pagingBean ne null ? pagingBean.pageSize : 20}" pageNumShown="${pagingBean ne null ? pagingBean.pageNumShown : 10}" currentPage="${pagingBean ne null ? pagingBean.currentPage : 1}"></div>
	</div>
</div>