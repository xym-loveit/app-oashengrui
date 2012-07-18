<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;line-height: 21px;}
</style>

<script type="text/javascript">
	function callback_removeRec(id) {
		if ($("#news-" + id).size() > 0) {
			$("#news-" + id).fadeOut("slow");
		}
	}
</script>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin/news.do?action=adminPageEntryIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>新闻类型：</label>
						<select class="combox" name="type" id="news_type">
							<option value="-1">所有类型</option>
							<logic:present name="newsTypes">
								<logic:iterate name="newsTypes" id="newsType">
									<option value="${newsType.id}" ${formNews ne null && formNews.dictionary.id eq newsType.id? 'selected="selected"' : ''}>${newsType.name}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>新闻状态：</label>
						<select class="combox" name="status" id="news_status">
							<option value="-1">所有</option>
							<option value="0" ${formNews ne null && formNews.status eq 0 ? 'selected="selected"' : '' }>草稿</option>
							<option value="1" ${formNews ne null && formNews.status eq 1 ? 'selected="selected"' : '' }>已发布并待审核</option>
							<option value="2" ${formNews ne null && formNews.status eq 2 ? 'selected="selected"' : '' }>审核通过</option>
							<option value="3" ${formNews ne null && formNews.status eq 3 ? 'selected="selected"' : '' }>审批退回</option>
						</select>
					</td>
					<td>
						新闻标题：<input type="text" name="newsSubject" value="${formNews ne null ? formNews.newsSubject : ''}" />
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
	<div class="panelBar">
		<ul class="toolBar" style="float:right">
			<li><a treeicon="icon-edit" class="icon" href="app/admin/news.do?action=adminPageEntryApprovalIndex" target="navTab" rel="admin_entrycheck"><span class="icon-edit">新闻审批和管理</span></a></li>
		</ul>
		<ul class="toolBar">
			<li><a class="add" href="app/admin.do?action=adminPageEntryDetail" target="dialog" title="添加新闻" width="900" height="500" rel="dia_admin_entryadd"><span>添加</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" href="app/admin.do?action=adminOprEntryRemove&id={sid}" target="ajaxTodo" title="确定要删除吗?" callback="hello"><span>删除</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="app/admin.do?action=adminPageEntryDetail&id={sid}" target="dialog" title="修改新闻" width="900" height="500" rel="dia_admin_entryedit{sid}"><span>修改</span></a></li>
			<!--
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
			-->
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">新闻类型</th>
				<th align="center">新闻标题</th>
				<th align="center">状态</th>
				<th align="center">发布校区与部门</th>
				<th align="center">发布时间</th>
				<th align="center">操作</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="news">
				<logic:iterate name="news" property="items" id="news">
					<tr id="news-${news.id}" target="sid" rel="${news.id}">
					<td>${news.dictionary.name}</td>
					<td>${news.newsSubject}</td>
					<td>
					<c:choose>
						<c:when test="${news.status eq null}">
							---
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${news.status eq 0}">
							草稿
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${news.status eq 1}">
							已发布待审核
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${news.status eq 2}">
							审核通过
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${news.status eq 3}">
							<label class="dispose">审批退回</label>
						</c:when>
					</c:choose>
					</td>
					<td>${news.district.districtName} / ${news.department.depName} </td>
					<td><c:if test="${news.updateTime ne null}"><fmt:formatDate value="${news.updateTime}" pattern="yyyy-MM-dd hh:mm:ss" /></c:if></td>
					<td> 
						<a href="app/admin.do?action=adminOprEntryRemove&id=${news.id}" target="ajaxTodo" title="确定要删除吗?" callback="callback_removeRec(${news.id})"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
						<a href="app/admin.do?action=adminPageEntryDetail&id=${news.id}" target="dialog" title="修改新闻" width="900" height="500"><img class="opr" src="resources/images/icons/edit.gif" /></a>
					</td>
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
	</form>
</div>