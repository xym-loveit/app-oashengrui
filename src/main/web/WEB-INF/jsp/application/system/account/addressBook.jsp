<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>


<form id="pagerForm" method="post" action="app/personal/addressBook.do?action=addressBookInfo">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/personal/addressBook.do?action=addressBookInfo" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						姓名：<input type="text" name="fullName" value="${modelAppUser ne null ? modelAppUser.fullName : ''}">
					</td>
					<td><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></td>
				</tr>

			</table>
		</div>
		
	</form>
</div>

<div class="pageContent">
	<div class="pageFormContent" layoutH="56">
		<div style="float: right; width: 300px;">
			<div class="accordion">
				<div class="accordionHeader">
					<h2><span>icon</span>按校区</h2>
				</div>
				<div class="accordionContent" style="height:380px;">
					<%@ include file="data/dataDistrictTree.jsp"%>
				</div>
				<div class="accordionHeader">
					<h2><span>icon</span>按部门</h2>
				</div>
				<div class="accordionContent" style="height:380px;">
					<%@ include file="data/dataDepartmentTree.jsp"%>
				</div>
			</div>
		</div>

<div style="margin-right: 320px;border:1px solid green" id="addressbook_participants">
	<table class="table" style="border-spacing: 12; width: 100%;"
		layoutH="138" cellspacing="10" cellpadding="10" >
		<thead>
			<tr>
				<th align="center">姓名</th>
				<th align="center">校区</th>
				<th align="center">部门</th>
				<th align="center">电子邮箱</th>
				<th align="center">办公电话</th>
				<th align="center">短号</th>
				<th align="center">手机号码</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="userInfo">
				<logic:iterate name="userInfo" property="items" id="userInfo">
					<tr>
						<td>${userInfo.fullName }</td>
						<td>${userInfo.employee.employeeDistrict.districtName }</td>
						<td>${userInfo.employee.employeeDepartment.depName }</td>
						<td>${userInfo.email }</td>
						<td>${userInfo.employee.officePhone }</td>
						<td>${userInfo.employee.shortNo }</td>
						<td>${userInfo.employee.phoneNo }</td>
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
</div>
</div>

