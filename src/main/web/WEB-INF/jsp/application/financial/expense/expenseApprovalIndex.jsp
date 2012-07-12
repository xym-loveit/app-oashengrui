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

<form id="pagerForm" method="post" action="app/finan/financial.do?action=FinanExpenseIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/finan/financial.do?action=FinanExpenseIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>申请类型：</label>
						<select class="combox" name="applyFormTypeId" style="width:108px;">
							<option value="-1">所有</option>
							<logic:present name="types">
								<logic:iterate name="types" id="entity">
									<option value="${entity.id}" ${department ne null && department.depEquivalentBranch ne null && department.depEquivalentBranch.id eq entity.id ? "selected='selected'" : ""}>${entity.processTypeName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>审批结果：</label>
						<select class="combox" name="auditState" style="width:108px;">
							<option value="-1">所有</option>
							<option value="1" ${employeeExpenseForm ne null && employeeExpenseForm.auditState eq 1 ? 'selected="selected"' : ''}>审批中</option>
							<option value="2" ${employeeExpenseForm ne null && employeeExpenseForm.auditState eq 2 ? 'selected="selected"' : ''}>审批通过</option>
							<option value="3" ${employeeExpenseForm ne null && employeeExpenseForm.auditState eq 3 ? 'selected="selected"' : ''}>审批未通过</option>
							<option value="3" ${employeeExpenseForm ne null && employeeExpenseForm.auditState eq 4 ? 'selected="selected"' : ''}>审批退回</option>
						</select>
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
<div class="unitBox" id="jbsxBox">
	<div class="pageContent">
		<div class="panelBar">
			<ul class="toolBar">
				<li><a class="add" href="app/finan/financial.do?action=FinanExpenseDetail" target="dialog" title="财务申请" width="1100" height="540" rel="dia_finexp_add"><span>财务申请</span></a></li>
				<li class="line">line</li>
			</ul>
		</div>
		<table class="table" width="100%" layoutH="142">
			<thead>
				<tr>
					<th align="center">申请类型</th>
					<th align="center">申请人</th>
					<th align="center">申请金额</th>
					<th align="center">所属校区</th>
					<th align="center">所属部门</th>
					<th align="center">申请时间</th>
					<th align="center">审批状态</th>
					<th align="center">审批环节</th>
					<th align="center">审批结果</th>
					<th align="center">申请单查看</th>
				</tr>
			</thead>
			<tbody>
				<logic:present name="employeeExpenseInfo">
					<logic:iterate name="employeeExpenseInfo" property="items" id="entity">
						<tr target="entry_id" rel="${entity.id}">
							<td>${entity.applyFormType.processTypeName}</td>
							<td>${entity.employee ne null ? entity.employee.empName : ''}</td>
							<td>${entity.applyAmt}</td>
							<td>${entity.empDistrict ne null ? entity.empDistrict.districtName : ''}</td>
							<td>${entity.empDepartment ne null ? entity.empDepartment.depName : ''}</td>
							<td><fmt:formatDate  value="${entity.applyDate}" pattern="yyyy-MM-dd" /></td>
							<td>
								<c:choose>
									<c:when test="${entity.auditState eq 1}">审批中</c:when>
									<c:otherwise>审批结束</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:if test="${entity.currentProcessForm ne null}">
									${entity.currentProcessForm.toDepartmentNames}-${entity.currentProcessForm.toPositionNames}
									<c:choose>
										<c:when test="${entity.currentProcessForm.taskType eq 1 || entity.currentProcessForm.taskType eq 2}">(校区)</c:when>
										<c:when test="${entity.currentProcessForm.taskType eq 3 || entity.currentProcessForm.taskType eq 4}">(总部)</c:when>
										<c:otherwise>未知</c:otherwise>
									</c:choose>
								</c:if>
							</td>
							<td>
								<c:choose>
									<c:when test="${entity.auditState eq 2}">审核通过</c:when>
									<c:when test="${entity.auditState eq 3}">审核未通过</c:when>
									<c:otherwise>---</c:otherwise>
								</c:choose>
							</td>
							<td><a class="oplink" href="app/finan/financial.do?action=FinanExpenseDetail&id=${entity.id}&op=view" target="dialog" title="查看${entity.employee.empName}申请单" width="1100" height="540" rel="dia_finexp_view_${entity.id}">详细</a></td>
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