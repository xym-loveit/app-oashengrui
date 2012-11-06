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
		if ($("#ddistrict-" + id).size() > 0) {
			$("#ddistrict-" + id).fadeOut("slow");
		}
	}
</script>

<form id="pagerForm" method="post" action="app/system/school/district.do?action=pageSchoolDistrictIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/system/school/district.do?action=pageSchoolDistrictIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>所属校区名称：</label>
						<input type="text" name="districtName" rel="pagerForm" value="${districtForm ne null ? districtForm.districtName : ''}" />
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
			<c:if test="${tm:ifGranted('_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_ADD')}">
			<li><a class="add" href="app/system/school/district.do?action=dialogSchoolDistrictPage" target="dialog" title="添加校区" mask="true" width="504" height="348" rel="dia_sys_school_districtadd"><span>添加校区</span></a></li>
			</c:if>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">序号</th>
				<th align="center">校区名称</th>
				<th align="center">校区编号</th>
				<th align="center">校区类型</th>
				<th align="center">上级结构</th>
				<th align="center">校区地址</th>
				<th align="center">联系电话</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="districts">
				<logic:iterate name="districts" property="items" id="district" indexId="idx">
					<tr id="ddistrict-${district.id}">
						<td>${idx+1}</td>
						<td>${district.districtName}</td>
						<td>${district.districtNo}</td>
						<td>${district.districtType == 0 ? '总部' : (district.districtType == 1 ? '校区' : (district.districtType == 2 ? '片区' : '/'))}</td>
						<td>${district.districtParent ne null ? district.districtParent.districtName : '/'}</td>
						<td>${district.districtAddress}</td>
						<td>${district.districtPhone}</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_EDIT')}">
									<a href="app/system/school/district.do?action=dialogSchoolDistrictPage&districtId=${district.id}" target="dialog" title="校区编辑" class="oplink" width="504" height="348" rel="sysmgr_roleedit_${idx}">编辑</a>
								</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_SYSTEM_SCHOOL_DISTRICT_REMOVE')}">
									<a href="app/system/school/district.do?action=actionRemoveDistrict&districtId=${district.id}" target="ajaxTodo" title="确定删除该校区吗？" class="oplink" callback="callback_roleRemove(${district.id})">删除</a>
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
		
	</form>
</div>