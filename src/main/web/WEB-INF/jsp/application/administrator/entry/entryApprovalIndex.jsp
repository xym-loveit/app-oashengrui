<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
</style>

<script type="text/javascript">
	function hello(rsp_msg) {
		alert(rsp_msg.message);
	}
	function remove(id) {
		if ($("#newsInfo-" + id).size() > 0) {
			$("#newsInfo-" + id).fadeOut("slow");
		}
	}
	function callback_funcRemove(id) {
		if (id == undefined) {
			id = $("tr.selected").attr("rel");
		}
		if ($("#newsInfo-" + id).size() > 0) {
			$("#newsInfo-" + id).fadeOut("slow");
		}
	}
	
	function refresh(){
		navTab.reload();
	}
</script>
<form id="pagerForm" method="post" action="app/admin/news.do?action=adminPageEntryIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>
<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin/news.do?action=adminPageEntryApprovalIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>新闻类型：</label>
						<select class="combox" name="newstype" id="entry_type_approve">
							<option value="-1">所有类型</option>
							<logic:present name="newsTypes">
								<logic:iterate name="newsTypes" id="newsType">
									<option value="${newsType.id}" ${newsApprove ne null && newsApprove.dictionary.id eq newsType.id? 'selected="selected"' : ''}>${newsType.name}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>新闻状态：</label>
						<select class="combox" name="status" id="entry_status_approve">
							<option value="-1">所有</option>
							<option value="0" ${newsApprove ne null && newsApprove.status eq 0 ? 'selected="selected"' : '' }>草稿</option>
							<option value="1" ${newsApprove ne null && newsApprove.status eq 1 ? 'selected="selected"' : '' }>已发布并待审核</option>
							<option value="2" ${newsApprove ne null && newsApprove.status eq 2 ? 'selected="selected"' : '' }>审核通过</option>
							<option value="3" ${newsApprove ne null && newsApprove.status eq 3 ? 'selected="selected"' : '' }>审批退回</option>
						</select>
					</td>
					<td>
						<label>发布校区：</label>
						<select class="combox" name="districtPost" id="entry_spost">
							<option value="">所有</option>
								<logic:present name="districts">
									<logic:iterate name="districts" id="districtPublic">
										<option value="${districtPublic.id}" ${newsApprove ne null && newsApprove.district.id eq districtPublic.id ? 'selected="selected"' : ''}>${districtPublic.districtName}</option>
									</logic:iterate>
								</logic:present>
						</select>
					</td>
					<td>
						新闻标题：<input type="text" name="newsSubject" value="${newsApprove ne null ? newsApprove.newsSubject : ''}" />
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
			<li><a treeicon="icon-admin" class="icon" href="app/admin/news.do?action=adminPageEntryIndex" target="navTab" rel="admin_entry"><span class="icon-adminnews">新闻发布与管理</span></a></li>
		</ul>
		
		<!--
		<ul class="toolBar">
		<c:choose>
			<c:when test="${tm:ifGranted('_FUNCKE_ADMIN_NEWS_DELETE') }">
				<li><a class="delete" href="app/admin.do?action=adminOprEntryRemove&id={sid}" target="ajaxTodo" title="确定要删除吗?" callback="callback_funcRemove()"><span>删除</span></a></li>
			</c:when>
			<c:otherwise>
				<label class="opdisabled" title="您没有权限进行该操作">---</label>
			</c:otherwise>
		</c:choose>
			<li class="line">line</li>
			<c:if test="${tm:ifGranted('_FUNCKEY_ADMIN_NEWS_EDIT') }">
				<li><a class="edit" href="app/admin.do?action=adminPageEntryDetail&id={sid}" target="dialog" title="修改新闻" width="900" height="500"><span>修改</span></a></li>
			</c:if>
		</ul>
		-->
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">新闻类型</th>
				<th align="center">新闻标题</th>
				<th align="center">状态</th>
				<th align="center">发布校区与部门</th>
				<th align="center">发布时间</th>
				<th align="center">审批</th>
				<th align="center">置顶</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="newsInfo">	
				<logic:iterate name="newsInfo" property="items" id="newsInfo">
						<tr target="sid" rel="${newsInfo.id }" id="newsInfo-${newsInfo.id}">
							<td>${newsInfo.dictionary.name }</td>
							<td><a class="icon" href="app/admin/news.do?action=actionNewsScan&id=${newsInfo.id }&op=view" target="dialog" rel="admin_entrycheck" width="900" height="650">${newsInfo.newsSubject}</a></td>
							<td>
								<c:choose>
									<c:when test="${newsInfo.status eq null}">
										---
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${newsInfo.status eq 0}">
										草稿
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${newsInfo.status eq 1}">
										已发布待审核
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${newsInfo.status eq 2}">
										审核通过
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${newsInfo.status eq 3}">
										<label class="dispose">审批退回</label>
									</c:when>
								</c:choose>
							</td>
							<td>${newsInfo.district.districtName} / ${newsInfo.department.depName}</td>
							<td><c:if test="${newsInfo.updateTime ne null}"><fmt:formatDate value="${newsInfo.updateTime}" pattern="yyyy-MM-dd hh:mm:ss" /></c:if></td>
							<td>
							<c:if test="${tm:ifGranted('_FUNCKEY_ADMIN_NEWS_APPROVING') }">
								<a class="oplink" href="app/admin.do?action=adminPageEntryDetail&id=${newsInfo.id }&op=view" target="dialog" width="900" height="500" title="新闻审批" rel="dia_admin_entryapproval-id">审批</a>
							</c:if>
							</td>
							<td>
							<c:if test="${tm:ifGranted('_FUNCKEY_ADMIN_NEWS_TOP') }">
								<c:choose>
									<c:when test="${newsInfo.topIndex eq 0 }">
										<a class="oplink" href="app/admin.do?action=adminOprEntryFirst&id=${newsInfo.id}" target="ajaxTodo" title="确定要对${newsInfo.newsSubject }置顶么?" callback="refresh()">置顶</a>
								</c:when>
								<c:when test="${newsInfo.topIndex eq 1 }">
										<a class="oplink" href="app/admin.do?action=adminOprEntryRemoveFirst&id=${newsInfo.id }" target="ajaxTodo" title="确定要对${newsInfo.newsSubject }取消置顶么?" callback="refresh()">取消</a>
								</c:when>
								</c:choose>
							</c:if>
							</td>
							<td>
							<c:if test="${tm:ifGranted('_FUNCKEY_ADMIN_NEWS_EDIT') }">
								<a class="oplink" href="app/admin.do?action=adminPageEntryDetail&id=${newsInfo.id }" target="dialog" width="900" height="500" title="新闻编辑" rel="dia_admin_entryedit-id">编辑</a>
							</c:if>
							</td>
							<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKE_ADMIN_NEWS_DELETE') }">
									<a class="oplink" href="app/admin.do?action=adminOprEntryRemove&id=${newsInfo.id }" target="ajaxTodo" title="确定要删除 ${newsInfo.newsSubject}吗?" callback="refresh()">删除</a>
								</c:when>
								<c:otherwise>
									<label class="opdisabled" title="您没有权限进行该操作">---</label>
								</c:otherwise>
							</c:choose>
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
