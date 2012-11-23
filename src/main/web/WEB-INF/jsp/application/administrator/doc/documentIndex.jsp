<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<script type="text/javascript">
	function callback_roleRemove(id) {
		if ($("#doc_entity-" + id).size() > 0) {
			$("#doc_entity-" + id).fadeOut("slow");
		}
	}
</script>

<form id="pagerForm" method="post" action="app/admin/doc.do?action=adminPageDocumentIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin/doc.do?action=adminPageDocumentIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>文档类型：</label>
						<select class="combox" id="combox_doc_type" name="type.id" style="width:108px;">
							<option value="-1">所有类型</option>
							<logic:present name="docTypes">
								<logic:iterate name="docTypes" id="entity">
									<option value="${entity.id}" ${formDoc ne null && formDoc.type ne null && formDoc.type.id eq entity.id ? 'selected="selected"' : ''}>${entity.value}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>文档名称：</label>
						<input type="text" name="docName" value="${formDoc ne null ? formDoc.docName : ''}"/>
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
		<ul class="toolBar">
		<c:if test="${tm:ifGranted('_FUNCKEY_ADMIN_DOC_ADD')}">
			<li><a class="add" href="app/admin/doc.do?action=adminPageDocumentDetail&op=loading" target="dialog" title="文档上传" width="880" height="540" rel="dia_admin_entryadd"><span>文档上传

</span></a></li>
		</c:if>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">文档类型</th>
				<th align="center">文档名称</th>
				<th align="center">上传时间</th>
				<th align="center">上传校区</th>
				<th align="center">上传部门</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		
		<tbody>
		<logic:present name="docs">
		   <logic:iterate name="docs" property="items" id="entity">
			<tr id="doc_entity-${entity.id}">
			
                <td>${entity.type.value}</td>
                <td>${entity.docName}</td>
                <td>${entity.createTime}</td>
                <td>${entity.district.districtName}</td>
				<td class="${entity.department ne null && entity.department.delFlag eq 1 ? 'delflag' : ''}">${entity.department.depName}</td>
				<td>
				<c:choose>
					<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_DOC_EDIT')}">
						<a href="app/admin/doc.do?action=adminPageDocumentEditDetail&id=${entity.id}" target="dialog" title="文档编辑" class="oplink" width="850" height="380" rel="admin_doc_edit">编辑</a>
					</c:when>
					<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
				</c:choose>

				</td>
				<td>
				<c:choose>
					<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_DOC_REMOVE')}">
						<a href="app/admin/doc.do?action=adminPageDocumentDelete&id=${entity.id}" target="ajaxTodo" title="确定删除该文档吗？" class="oplink"  callback="callback_roleRemove(${entity.id})">删除</a>
					</c:when>
					<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
				</c:choose>
				</td>
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