<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<c:if test="${page_type ne null}">
<form id="pagerForm" method="post" action="app/personal/task.do?action=dialogAuditRecords&taskId=${taskPlan.id}">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>
</c:if>

<div class="pageContent">
	<table class="table" width="100%" layoutH="${page_type eq null ? 225 : 50}">
		<thead>
			<tr>
				<th align="center">申请类型</th>
				<th align="center">意向时间</th>
				<th align="center">申请备注</th>
				<th align="center">申请时间</th>
				<th align="center">审批结果</th>
				<th align="center">确认时间</th>
				<th align="center">审批意见</th>
				<th align="center">审批时间</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="dataList">
				<logic:iterate name="dataList" property="items" id="entity">
					<tr>
						<td>${entity.taskApplyType eq 1 ? '完成申请' : '延期申请'}</td>
						<td><fmt:formatDate value="${entity.taskApplyFinalizedDate}" pattern="yyyy-MM-dd" /></td>
						<td>${entity.taskApplyMeto}</td>
						<td><fmt:formatDate value="${entity.taskApplyDate}" pattern="yyyy-MM-dd" /></td>
						<td>${entity.taskAuditState eq 1 ? '通过' : '不通过'}</td>
						<td><c:if test="${entity.taskAuditFinalizedDate ne null}"><fmt:formatDate value="${entity.taskAuditFinalizedDate}" pattern="yyyy-MM-dd" /></c:if></td>
						<td>${entity.taskAuditMeto}</td>
						<td><fmt:formatDate value="${entity.taskAuditTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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
			<span>条，共${pagingBean ne null ? pagingBean.totalItems - 1 : 0}条</span>
		</div>	
		<div class="pagination" targetType="navTab" totalCount="${pagingBean ne null ? pagingBean.totalItems : 0}" numPerPage="${pagingBean ne null ? pagingBean.pageSize : 20}" pageNumShown="${pagingBean ne null ? pagingBean.pageNumShown : 10}" currentPage="${pagingBean ne null ? pagingBean.currentPage : 1}"></div>
	</div>
</div>