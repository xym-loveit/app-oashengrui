<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<form id="pagerForm" method="post" action="app/personal/approval.do?action=pageMyApproval">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>
<!-- Body -->	
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar" style="float:right">
			<li><a treeicon="icon-edit" class="icon" href="app/personal/approval.do?action=pageMyApprovalRecord" target="navTab" rel="admin_entrycheck"><span class="icon-edit">审批记录</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="75">
		<thead>
			<tr>
				<th align="center">审批类型</th>
				<th align="center">申请内容描述</th>
				<th align="center">申请人姓名</th>
				<th align="center">申请时间</th>
				<th align="center" class="thover">审批</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="news">
				<logic:iterate id="news" name="news" property="items">
					<tr>
						<td>
							<c:choose>
								<c:when test="${news.status eq 1 }">新闻发布审批</c:when>
							</c:choose>
						</td>
						<td>
							[${news.dictionary.name}] &nbsp&nbsp&nbsp “${news.newsSubject}” &nbsp&nbsp&nbsp<c:choose><c:when test="${news.status eq 1 }">新闻发布审批</c:when></c:choose>
						</td>
						<td>${news.user.fullName}</td>
						<td><c:if test="${news.updateTime ne null}"><fmt:formatDate value="${news.updateTime}" pattern="yyyy-MM-dd hh:mm:ss" /></c:if></td>
						<td><a class="oplink" href="app/admin.do?action=adminPageEntryDetail&id=${news.id }&op=view" target="dialog" width="900" height="500" title="新闻审批" rel="dia_admin_entryapproval-id">审批</a></td>
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