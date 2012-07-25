<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	.opdisabled {text-decoration: line-through; color: #DDD; line-height: 21px;}
</style>

<form id="pagerForm" method="post" action="app/system/log.do?action=actionLoadLogPage"">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/system/log.do?action=actionLoadLogPage"" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>所属功能：</label>
						<select class="combox" name="exeOperation" id="combox_operation" style="width:120px">
							<option value="">所有</option>
							<option value="登录" ${logInfo ne null && logInfo.exeOperation == '登录'? 'selected="selected"' : ''}>登录</option>
						</select>
					</td>
					<td>
						<label>所属校区：</label>
						<select class="combox" name="districtId" id="combox_district_jindex" style="width:120px">
							<option value="-1">所有校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${logInfo ne null && logInfo.districtId ne null && logInfo.districtId eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						时间：<input type="text" name="startTime" class="date" value="${logInfo ne null ? logInfo.startTime:'' }" /> - <input type="text" name="endTime" class="date" value="${logInfo ne null ? logInfo.endTime:'' }" />
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

	<table class="table" width="100%"  layoutH="115">
		<thead>
			<tr>
				<th align="center">账号</th>
				<th align="center">姓名</th>
				<th align="center">所属校区</th>
				<th align="center">所属部门</th>
				<th align="center">操作功能</th>
				<th align="center">操作详细</th>
				<th align="center">操作IP</th>
				<th align="center">操作时间</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="logs">
				<logic:iterate name="logs" property="items" id="entity">
					<tr target="sid" rel="${entity.id}">
						<td>${entity.user.username}</td>
						<td>${entity.user.fullName}</td>
						<td>${entity.user.district.districtName }</td>
						<td>${entity.user.department.depName }</td>
						<td>${entity.exeOperation }</td>
						<td>${entity.detail}</td>
						<td>${entity.ip }</td>
						<td><fmt:formatDate value="${entity.createtime}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
