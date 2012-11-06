<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	a.oplink  {color: blue; text-decoration: underline;}
	
	#workTemplateRow td div{
      display: block;
      height:auto;
      line-height: 21px;
      overflow: hidden;
      white-space: nowrap;
   }
</style>

<form id="pagerForm" method="post" action="app/admin.do?action=adminPageStaffAttendance">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>
<script type="text/javascript">
	function districtChange() {
		$("#formWorkArrangeView").submit();
	}
	
	function refreshCurrentPage(data){
		$('#formWorkTemplate').submit();
	}
</script>

<!-- SearchBar -->
<div class="pageHeader">
	<form id="formWorkArrangeView" onsubmit="return navTabSearch(this);" action="app/admin.do?action=actionViewWorkArrangeByWeek&currentWeek=0" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>所属校区：</label>
						<select class="combox" name="districtId" id="districtId" onchange="districtChange()">
						   <option value="-1">所有</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${districtId ne null && districtId eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						当前时间：${viewWeekBeginDay ne null ? viewWeekBeginDay : '' } - ${viewWeekEndDay ne null ? viewWeekEndDay : '' }
					</td>
				</tr>
			</table>
		</div>
		<div class="panelBar">
			<ul class="toolBar">
				<li><a treeicon="icon-edit" class="icon" href="app/admin.do?action=actionViewWorkArrangeByWeek&currentWeek=0&districtId=${districtId }" target="navTab" rel="admin_workArrange"><span class="icon-edit">本周</span></a></li>
				<li><a treeicon="icon-edit" class="icon" href="app/admin.do?action=actionViewWorkArrangeByWeek&currentWeek=${previewWeek ne null ? previewWeek : '-1' }&districtId=${districtId }" target="navTab" rel="admin_workArrange"><span class="icon-edit">上一周</span></a></li>
				<li><a treeicon="icon-edit" class="icon" href="app/admin.do?action=actionViewWorkArrangeByWeek&currentWeek=${nextWeek ne null ? nextWeek : '1' }&districtId=${districtId }" target="navTab" rel="admin_workArrange"><span class="icon-edit">下一周</span></a></li>
			</ul>
		</div>
	</form>
</div>

<!-- Body -->	
<div class="pageContent" id="view_work_arrange_table">
	<table class="table" width="100%">
	<thead>
		<tr>
			<th align="center">工作时间</th>
			<th align="center">周一(<fmt:formatDate value="${weekDays[1]}" type="date" pattern="yyyy/MM/dd"/>)</th>
			<th align="center">周二(<fmt:formatDate value="${weekDays[2]}" type="date" pattern="yyyy/MM/dd"/>)</th>
			<th align="center">周三(<fmt:formatDate value="${weekDays[3]}" type="date" pattern="yyyy/MM/dd"/>)</th>
			<th align="center">周四(<fmt:formatDate value="${weekDays[4]}" type="date" pattern="yyyy/MM/dd"/>)</th>
			<th align="center">周五(<fmt:formatDate value="${weekDays[5]}" type="date" pattern="yyyy/MM/dd"/>)</th>
			<th align="center">周六(<fmt:formatDate value="${weekDays[6]}" type="date" pattern="yyyy/MM/dd"/>)</th>
			<th align="center">周日(<fmt:formatDate value="${weekDays[7]}" type="date" pattern="yyyy/MM/dd"/>)</th>
		</tr>
	</thead>
	<tbody>
		<tr target="posId" rel="${entity.id}" id="workTemplateRow">
			<td style="word-wrap:break-word">${startWorkTimeWeekAM } - ${endWorkTimeWeekAM }<br/>
				周一 ~周五<br/>
				${startWorkTimeWeekendAM } - ${endWorkTimeWeekendAM }<br/>
				周六~周日
			</td>
			 <td>${staffOnAM[1] }</td>
			<td>${staffOnAM[2] }</td>
			<td>${staffOnAM[3] }</td>
			<td>${staffOnAM[4] }</td>
			<td>${staffOnAM[5] }</td>
			<td>${staffOnAM[6] }</td>
			<td>${staffOnAM[7] }</td>
		</tr>
		<tr target="posId" rel="${entity.id}" id="mfunc-${entity.id}">
		    <td style="word-wrap : break-word">${startWorkTimePM } - ${endWorkTimePM }</td>
			 <td>${staffOnPM[1] }</td>
			<td>${staffOnPM[2] }</td>
			<td>${staffOnPM[3] }</td>
			<td>${staffOnPM[4] }</td>
			<td>${staffOnPM[5] }</td>
			<td>${staffOnPM[6] }</td>
			<td>${staffOnPM[7] }</td>
		</tr>
	</tbody>
</table>
</div>