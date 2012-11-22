<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form id="pagerForm" method="post" action="app/personal/addressBook.do?action=addressBookInfo">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/personal/addressBook.do?action=addressBookInfo" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>姓名：</td>
					<td><input type="text" name="empName" value="${empName ne null ? empName : ''}">
					</td>
					<td><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></td>
				</tr>
			</table>
		</div>
		<input type="hidden" name="depId" value="${depId ne null ? depId : ''}" />
		<input type="hidden" name="districtId" value="${districtId ne null ? districtId : ''}" />
	</form>
</div>

<div layoutH="128">
	<table class="list" style="border-spacing: 12; width: 100%;" cellspacing="10" cellpadding="10" >
		<thead>
			<tr>
				<th align="center" style="width:80px">姓名</th>
				<th align="center" style="width:80px">校区</th>
				<th align="center" style="width:80px">部门</th>
				<th align="center">电子邮箱</th>
				<th align="center" style="width:100px">办公电话</th>
				<th align="center" style="width:70px">短号</th>
				<th align="center" style="width:100px">手机号码</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="empInfo">
				<logic:iterate name="empInfo" property="items" id="empInfo">
					<tr>
						<td>${empInfo.empName }</td>
						<td align="center">${empInfo.employeeDistrict.districtName }</td>
						<td align="center" class="${empInfo.employeeDepartment.delFlag eq 1 ? 'delflag' : ''}">${empInfo.employeeDepartment.depName }</td>
						<td>${empInfo.resume.email }</td>
						<td align="center">${empInfo.officePhone }</td>
						<td align="center">${empInfo.shortNo }</td>
						<td align="center">${empInfo.phoneNo }</td>
					</tr>
				</logic:iterate>
			</logic:present>
		</tbody>
	</table>
</div>

<div class="panelBar">
	<div class="pages">
		<span>显示</span>
		<select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value}})">
			<option value="20" ${pagingBean ne null && pagingBean.pageSize eq 20 ? 'selected="selected"' : ''}>20</option>
			<option value="50" ${pagingBean ne null && pagingBean.pageSize eq 50 ? 'selected="selected"' : ''}>50</option>
			<option value="100" ${pagingBean ne null && pagingBean.pageSize eq 100 ? 'selected="selected"' : ''}>100</option>
			<option value="200" ${pagingBean ne null && pagingBean.pageSize eq 200 ? 'selected="selected"' : ''}>200</option>
		</select>
		<span>条，共${pagingBean ne null ? pagingBean.totalItems : 0}条</span>
	</div>
	
	<div class="pagination" targetType="navTab" totalCount="${pagingBean ne null ? pagingBean.totalItems : 0}" numPerPage="${pagingBean ne null ? pagingBean.pageSize : 20}" pageNumShown="${pagingBean ne null ? pagingBean.pageNumShown : 10}" currentPage="${pagingBean ne null ? pagingBean.currentPage : 1}"></div>
</div>
