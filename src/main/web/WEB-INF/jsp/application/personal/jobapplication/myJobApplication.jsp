<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<!-- Body -->	
<div class="pageContent">
	<div class="panelBar">
		<c:if test="${op eq null || op ne 'history'}">
			<ul class="toolBar" style="float:right">
				<c:if test="${tm:ifGranted('_FUNCKEY_PERSONAL_JOBAPPLY_HISTORY')}">
				<li><a treeicon="icon-records" class="icon" href="app/personal/jobapplication.do?action=pageMyHistoryJobApplication&op=history" target="navTab" rel="dmy_jobapplication"><span class="icon-records">我的历史应聘</span></a></li>
				</c:if>
			</ul>
		</c:if>
		<c:if test="${op eq 'history' }">
			<ul class="toolBar" style="float:right">
				<li><a treeicon="icon-hrjobreg" class="icon" href="app/personal/jobapplication.do?action=pageJobOnHiring" target="navTab" rel="_menu_mod_personal_jobreg"><span class="icon-hrjobreg">返回当前招聘</span></a></li>
			</ul>
		</c:if>
	</div>
	
	<%@ include file="data/dataJobList.jsp" %>
	
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