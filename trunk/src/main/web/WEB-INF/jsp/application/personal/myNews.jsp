<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>


<form id="pagerForm" method="post" action="app/admin/news.do?action=adminPageEntryIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>
<div style="width:100%">
<div class="pageContent" style="float:left; width: 45%;margin-left:30px;margin-top:20px;">
	<h1><b>公司新闻</b></h1>
	<hr style="margin-top:10px;"></hr>
	<table class="searchContent" layoutH="138">
	<tr>
		<td>
			<logic:present name="news">
				<logic:iterate name="news" property="items" id="news">
					<tr id="companyNews" target="sid" rel="${news.id}" height="30">
						<td style="color:blue;">
							<c:choose>
								<c:when test="${news.topIndex eq 1 }">[置顶]</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${news.newsLevel eq 0 }">公司新闻</c:when>
							</c:choose>
						</td>
						<td width="30"></td>
						<td>
							<a class="icon" href="app/admin/news.do?action=actionNewsScan&id=${news.id }&op=view" target="dialog" rel="admin_entrycheck" width="900" height="650">${news.newsSubject}</a>
						</td>
						<td width="30"></td>
						<td>(<c:if test="${news.updateTime ne null}"><fmt:formatDate value="${news.updateTime}" pattern="yyyy-MM-dd" /></c:if>)</td>
					</tr>
				</logic:iterate>
			</logic:present>
		</td>
	</tr>
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

<div class="pageContent" style="float:left; width:45%;margin-left:30px;margin-top:20px;">
	<h1><b>校区新闻</b></h1>
	<hr style="margin-top:10px;"></hr>
	<table class="searchContent" layoutH="138">
	<tr>
		<td>
			<logic:present name="newsdistrict">
				<logic:iterate name="newsdistrict" property="items" id="newsdistrict">
					<tr id="companyNews" target="sid" rel="${newsdistrict.id}" height="30">
						<td style="color:blue;">
							<c:choose>
								<c:when test="${news.topIndex eq 1 }">[置顶]</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${newsdistrict.newsLevel eq 1 }">校区新闻</c:when>
							</c:choose>
						</td>
						<td width="30"></td>
						<td><a href="app/admin/news.do?action=actionNewsScan&id=${newsdistrict.id }"&op=view" target="dialog" width="900" height="650" title="新闻详细"><span>${newsdistrict.newsSubject}</span></a></td>
						<td width="30"></td>
						<td>(<c:if test="${newsdistrict.updateTime ne null}"><fmt:formatDate value="${newsdistrict.updateTime}" pattern="yyyy-MM-dd" /></c:if>)</td>
					</tr>
				</logic:iterate>
			</logic:present>
		</td>
	</tr>
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