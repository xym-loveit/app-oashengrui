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
						<select class="combox" name="applyFormType" style="width:108px;">
							<option value="-1">所有</option>
							<option value="1" ${employeeExpenseForm ne null && employeeExpenseForm.applyFormType eq 1 ? 'selected="selected"' : ''}>工资薪金支出</option>
							<option value="2" ${employeeExpenseForm ne null && employeeExpenseForm.applyFormType eq 2 ? 'selected="selected"' : ''}>日用品支出</option>
						</select>
					</td>
					<td>
						<label>审批结果：</label>
						<select class="combox" name="auditState" style="width:108px;">
							<option value="-1">所有</option>
							<option value="0" ${employeeExpenseForm ne null && employeeExpenseForm.auditState eq 0 ? 'selected="selected"' : ''}>审批中</option>
							<option value="1" ${employeeExpenseForm ne null && employeeExpenseForm.auditState eq 1 ? 'selected="selected"' : ''}>审批通过</option>
							<option value="2" ${employeeExpenseForm ne null && employeeExpenseForm.auditState eq 2 ? 'selected="selected"' : ''}>审批不通过</option>
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
				<li><a class="add" href="app/finan/financial.do?action=FinanExpenseDetail&op=viewprogress" target="navtab" title="财务申请" width="930" height="500" rel="dia_hr_entryadd"><span>财务申请</span></a></li>
				<li class="line">line</li>
			</ul>
		</div>
		<table class="table" width="100%" layoutH="168">
			<thead>
				<tr>
					<th align="center">申请类型</th>
					<th align="center">申请内容描述</th>
					<th align="center">申请时间</th>
					<th align="center">申请人</th>
					<th align="center">审批状态</th>
					<th align="center">审批环节</th>
					<th align="center">申请单查看</th>
				</tr>
			</thead>
			<tbody>
				<logic:present name="employeeExpenseInfo">
					<logic:iterate name="employeeExpenseInfo" property="items" id="entity">
						<tr target="entry_id" rel="${entity.id}">
							<td>
								<c:choose>
									<c:when test="${entity.applyFormType eq 1}">
										工资薪金支出
									</c:when>
									<c:when test="${entity.applyFormType eq 2}">
										日用品支出
									</c:when>
								</c:choose>
							</td>
							<td>${entity.comments}</td>
							<td><fmt:formatDate  value="${entity.applyDate}" pattern="yyyy-MM-dd" /></td>
							<td>${entity.employee ne null ? entity.employee.empName : ''}</td>
							<td>
								<c:choose>
									<c:when test="${entity.auditState eq 0}">
										审批中
									</c:when>
									<c:when test="${entity.auditState eq 1}">
										审批通过
									</c:when>
									<c:when test="${entity.auditState eq 2}">
										审批未通过
									</c:when>
								</c:choose>
							</td>
							<td><a class="oplink" href="app/finan/financial.do?action=FinanExpenseDetail&id=${entity.id}&op=view" target="dialog" title="查看${entity.employee.empName}晋升申请单" width="930" height="500" rel="hrm_emp_profile_${entity.id}">详细</a></td>
							<td><a class="oplink" href="app/finan/financial.do?action=FinanExpenseDetail&id=${entity.id}&op=view" target="dialog" title="查看${entity.employee.empName}晋升申请单" width="930" height="500" rel="hrm_emp_profile_${entity.id}">详细</a></td>
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