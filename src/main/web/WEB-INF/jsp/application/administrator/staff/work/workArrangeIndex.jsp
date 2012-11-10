<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
</style>

<form id="pagerForm" method="post" action="app/admin.do?action=adminPageStaffWorkArrange">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<script type="text/javascript">
function dep_refresh (refresh) {
	if (refresh) {
		$("#ajBoxMenuTree").loadUrl("app/system/school/department.do?action=actionLoadDepartmentTree", {}, function(){
			if ($("#_var_depid", $(navTab.getCurrentPanel())).size() > 0) {
				$("#_var_depid", $(navTab.getCurrentPanel())).remove();
			}
		});
	} else {
		if ($("#_var_depid", $(navTab.getCurrentPanel())).size() > 0) {
			$("#_var_depid", $(navTab.getCurrentPanel())).remove();
		}
	}
	
	$("#ajBoxMenuFunc").loadUrl("app/system/school/department/position.do?action=actionLoadDepartmentPosition", {}, function(){
	});
}
function callback_funcRemove(id) {
	if ($("#workarrangerow-" + id).size() > 0) {
		$("#workarrangerow-" + id).fadeOut("slow");
	}
}
</script>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin.do?action=adminPageStaffWorkArrange" method="post" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						员工姓名：<input type="text" name="staffName" value="${formWorkArrange ne null ? formWorkArrange.staffName : ''}"/>
					</td>
					<td>
						<label>上班类型：</label>
						<select class="combox" name="workType.id" id="workType">
							<option value="-1">所有类型</option>
							<option value="1" ${formWorkArrange ne null && formWorkArrange.workType.id eq '1'?'selected="selected"':'' }>正常上班</option>
							<option value="2" ${formWorkArrange ne null && formWorkArrange.workType.id eq '2'?'selected="selected"':'' }>调休加班</option>
							<option value="3" ${formWorkArrange ne null && formWorkArrange.workType.id eq '3'?'selected="selected"':'' }>带薪加班</option>
							<option value="4" ${formWorkArrange ne null && formWorkArrange.workType.id eq '4'?'selected="selected"':'' }>倍薪加班</option>
						</select>
					</td>
					<td>
						工作日期：<input type="text" class="date" name="workDate" id="workDate"/>
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
		<c:choose>
			<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_VIEW_WORK_ARRANGE') }">
				<ul class="toolBar" style="float:right">
					<li><a treeicon="icon-edit" class="icon" href="app/admin.do?action=actionViewWorkArrangePage" target="navTab" rel="admin_workArrange"><span class="icon-edit">工作安排查看</span></a></li>
				</ul>
			</c:when>
		</c:choose>
		<ul class="toolBar">
			<c:choose>
				<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_ADD_WORK_ARRANGE') }">
					<li><a class="add" href="app/admin.do?action=dialogStaffWorkArrange&districtId=1" target="dialog" title="添加工作安排" width="600" height="400"><span>添加工作安排</span></a></li>
					<li class="line">line</li>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_IMPORT_WORK_ARRANGE') }">
					<li><a class="add" href="app/admin.do?action=actionImportDataFromTemplateDialog" target="dialog" title="批量工作安排" width="500" height="200"><span>加载模板批量加载安排</span></a></li>
					<li class="line">line</li>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE') }">
					<li><a class="edit" href="app/admin.do?action=actionAdjustWorkArrangeDialog" target="dialog" title="工作安排调整" width="600" height="400"><span>工作安排调整</span></a></li>
				</c:when>
			</c:choose>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">工作日期</th>
				<th align="center">工作时间</th>
				<th align="center">姓名</th>
				<th align="center">上班类型</th>
				<th align="center">工作内容</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
		<logic:present name="workArranges">
		   <logic:iterate name="workArranges" property="items" id="entity">
			<tr target="sid" rel="${entity.id}"  id="workarrangerow-${entity.id}">
				<td><fmt:formatDate value="${entity.workDate}" pattern="yyyy-MM-dd" /></td>
				<td>${entity.workTime.workStime}-${entity.workTime.workEtime }</td>
				<td>${entity.staff.fullName}</td>
				<td <c:if test="${entity.workType.id==3 }">style="background-color:yellow;"</c:if>>${entity.workType.type}</td>
				<td>${entity.workContent.itemName}</td>
				<td>
				<c:choose>
					<c:when test="${entity.attendanceId eq null }">
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_ADJUST_WORK_ARRANGE') }">
								<a href="app/admin.do?action=adminEditStaffWorkArrangeDialog&id=${entity.id}" class="oplink" target="dialog" title="员工工作安排编辑" width="600" height="350" rel="admin_staffWorkEdit-1">编辑</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">编辑</label></c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise><label class="opdisabled" title="考勤处理后已经生效,不能编辑">编辑</label></c:otherwise>
				</c:choose>
				</td>
				<td>
				<c:choose>
					<c:when test="${entity.attendanceId eq null }">
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_REMOVE_WORK_ARRANGE') }">
								<a href="app/admin.do?action=adminDeleteWorkArrange&id=${entity.id}" class="oplink" target="ajaxToDo" title="确定要删除该员工的工作安排吗?"rel="admin_staffWorkRemove-1" callback="callback_funcRemove(${entity.id})">删除</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">删除</label></c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise><label class="opdisabled" title="考勤处理后已经生效,不能删除">删除</label></c:otherwise>
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