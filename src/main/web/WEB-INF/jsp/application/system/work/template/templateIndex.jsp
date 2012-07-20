<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
	function districtChange() {
		$("#formWorkTemplate").submit();
	}
	
	function ajaxDialogPost(obj){
		var url = "app/system/work/template.do?action=dialogWorkArrangePage";
		options = {fresh:true};
		$.pdialog.open(url, "sys_chPlanSet", "工作安排",options);
	}
</script>

<!-- SearchBar -->
<div class="pageHeader">
	<form id="formWorkTemplate" onsubmit="return navTabSearch(this);" action="app/system/work/template.do?action=pageWorkTemplateIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>所属校区：</label>
						<select class="combox" name="district.id" id="districtId" onchange="districtChange()">
						   <option value="-1">所有</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${formWorkTemplate ne null && formWorkTemplate.district.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label style="width:150px">请选择您要设置的工作模板：</label>
						<select class="combox" name="templateId" id="template_id"  onchange="districtChange()">
						   <option value="-1">所有</option>
							<option value="1" ${formWorkTemplate ne null && formWorkTemplate.templateId eq '1' ? 'selected="selected"' : ''}>第一套</option>
							<option value="2" ${formWorkTemplate ne null && formWorkTemplate.templateId eq '2' ? 'selected="selected"' : ''}>第二套</option>
							<option value="3" ${formWorkTemplate ne null && formWorkTemplate.templateId eq '3' ? 'selected="selected"' : ''}>第三套</option>
							<option value="4" ${formWorkTemplate ne null && formWorkTemplate.templateId eq '4' ? 'selected="selected"' : ''}>第四套</option>
						</select>
					</td>
					<td>
						当前启用模板：第一套
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>

<!-- Body -->	
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="确定要启用该模板吗?"><span>启用该模板</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%">
	<thead>
		<tr>
			<th align="center">工作时间</th>
			<th align="center">周一<a href="app/system/work/template.do?action=dialogWorkArrangePage&districtId=${formWorkTemplate ne null ? formWorkTemplate.district.id:'-1'}&templateId=${formWorkTemplate.templateId}&workDay=1" class="oplink" target="dialog" title="工作安排" width="755" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周二<a href="app/system/work/template.do?action=dialogWorkArrangePage&districtId=${formWorkTemplate ne null ? formWorkTemplate.district.id:'-1'}&templateId=${formWorkTemplate.templateId}&workDay=2" class="oplink" target="dialog" title="工作安排" width="755" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周三<a href="app/system/work/template.do?action=dialogWorkArrangePage&districtId=${formWorkTemplate ne null ? formWorkTemplate.district.id:'-1'}&templateId=${formWorkTemplate.templateId}&workDay=3" class="oplink" target="dialog" title="工作安排" width="755" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周四<a href="app/system/work/template.do?action=dialogWorkArrangePage&districtId=${formWorkTemplate ne null ? formWorkTemplate.district.id:'-1'}&templateId=${formWorkTemplate.templateId}&workDay=4" class="oplink" target="dialog" title="工作安排" width="755" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周五<a href="app/system/work/template.do?action=dialogWorkArrangePage&districtId=${formWorkTemplate ne null ? formWorkTemplate.district.id:'-1'}&templateId=${formWorkTemplate.templateId}&workDay=5" class="oplink" target="dialog" title="工作安排" width="755" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周六<a href="app/system/work/template.do?action=dialogWorkArrangePage&districtId=${formWorkTemplate ne null ? formWorkTemplate.district.id:'-1'}&templateId=${formWorkTemplate.templateId}&workDay=6" class="oplink" target="dialog" title="工作安排" width="755" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周日<a href="app/system/work/template.do?action=dialogWorkArrangePage&districtId=${formWorkTemplate ne null ? formWorkTemplate.district.id:'-1'}&templateId=${formWorkTemplate.templateId}&workDay=7" class="oplink" target="dialog" title="工作安排" width="755" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
		</tr>
	</thead>
	<tbody>
		<tr target="posId" rel="${entity.id}" id="mfunc-${entity.id}">
			<td style="word-wrap : break-word">${startWorkTimeWeekAM } - ${endWorkTimeWeekAM }<br/>
				周一 ~周五<br/>
				${startWorkTimeWeekendAM } - ${endWorkTimeWeekendAM }<br/>
				周六~周日
			</td>
			 <td style="word-wrap : break-word">${staffOnAM[1] }</td>
			<td style="word-wrap : break-word">${staffOnAM[2] }</td>
			<td style="word-wrap : break-word">${staffOnAM[3] }</td>
			<td style="word-wrap : break-word">${staffOnAM[4] }</td>
			<td style="word-wrap : break-word">${staffOnAM[5] }</td>
			<td style="word-wrap : break-word">${staffOnAM[6] }</td>
			<td style="word-wrap : break-word">${staffOnAM[7] }</td>
		</tr>
		<tr target="posId" rel="${entity.id}" id="mfunc-${entity.id}">
		    <td style="word-wrap : break-word">${startWorkTimePM } - ${endWorkTimePM }</td>
			 <td style="word-wrap : break-word">${staffOnPM[1] }</td>
			<td style="word-wrap : break-word">${staffOnPM[2] }</td>
			<td style="word-wrap : break-word">${staffOnPM[3] }</td>
			<td style="word-wrap : break-word">${staffOnPM[4] }</td>
			<td style="word-wrap : break-word">${staffOnPM[5] }</td>
			<td style="word-wrap : break-word">${staffOnPM[6] }</td>
			<td style="word-wrap : break-word">${staffOnPM[7] }</td>
		</tr>
	</tbody>
</table>
</div>