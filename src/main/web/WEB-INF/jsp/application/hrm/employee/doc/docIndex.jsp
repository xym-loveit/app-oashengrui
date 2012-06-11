<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	ul.infoshow {padding:5px 0 0 5px; overflow:auto; width: 80%;}
	ul.infoshow li {line-height: 30px; float:left; margin-right: 15px;}
	.opdisabled {text-decoration: line-through; color: #DDD; line-height: 21px;}
	td.ongoing {background-color: #99FF99; color: #333;}
	td.finished {background-color: #ddd;}
</style>

<form id="pagerForm" method="post" action="app/hrm/employee.do?action=hrmEmployeeDocIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/hrm/employee.do?action=hrmEmployeeDocIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>所在校区：</label>
						<select class="combox" name="entryDistrict.id" id="combox_district_eindex" style="width:100px">
							<option value="-1">所有校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${formEntry ne null && formEntry.entryDistrict ne null && formEntry.entryDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>姓名：</label>
						<input type="text"  name="fullName" value=""/>
					</td>
					<td>
						<label>在职状态：</label>
						<select class="combox" name="onboardStatus" style="width:108px;">
							<option value="-1">所有</option>
							<option value="0">试用</option>
							<option value="1">正式</option>
							<option value="2">离职</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<label>合同到期时间：</label>
						<input type="text"  name="contractEndDate" class="date textInput" value=""/>
					</td>
					<td>
						<label>待转正时间：</label>
						<input type="text"  name="positiveDate" class="date textInput" value=""/>
					</td>
					<td></td>
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
<div class="unitBox" id="jbsxBox">
	<div class="pageContent">
		<div class="panelBar">
			<ul class="toolBar">
				<li><a class="add" href="app/hrm/hire.do?action=hrmPageJobDetail" target="dialog" title="导入员工信息" width="930" height="500" rel="dia_hr_entryadd"><span>导入员工信息</span></a></li>
				<li class="line">line</li>
			</ul>
		</div>
		<table class="table" width="100%" layoutH="115">
			<thead>
				<tr>
					<th align="center">姓名</th>
					<th align="center">所在校区</th>
					<th align="center">所在部门</th>
					<th align="center">岗位</th>
					<th align="center">出生日期</th>
					<th align="center">联系电话</th>
					<th align="center">短号</th>
					<th align="center">待转正时间</th>
					<th align="center">合同到期时间</th>
					<th align="center">在职状态</th>
					<th align="center">删除</th>
					<th align="center">详细</th>
				</tr>
			</thead>
			<tbody>
				<logic:present name="entries">
					<logic:iterate name="entries" property="items" id="entity">
						<tr target="entry_id" rel="${entity.id}">
							<td>${entity.jobHireIssue.resume.fullName}</td>
							<td>${entity.entryDistrict ne null ? entity.entryDistrict.districtName : ''}</td>
							<td>${entity.entryDepartment ne null ? entity.entryDepartment.depName : ''}</td>
							<td>${entity.entryPosition ne null ? entity.entryPosition.positionName : ''}</td>
							<td>${entity.jobHireIssue.resume.mobilePhone}</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td><a class="oplink" href="app/hrm/employee.do?action=hrmEmployeeDocIndex&id=1&op=view" target="dialog" title="详细" width="930" height="500">详细</a></td>
						</tr>
					</logic:iterate>
				</logic:present>
			</tbody>
		</table>
		
		<!-- Pagination -->
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
</div>