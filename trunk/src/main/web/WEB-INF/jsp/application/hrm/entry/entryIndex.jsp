<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

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

<script>
	function reload_entrypage() {
		// 重新加载当前的navTab
		navTab.reload();
	}
</script>

<form id="pagerForm" method="post" action="app/hrm/entry.do?action=hrmPageEntryIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/hrm/entry.do?action=hrmPageEntryIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>入职校区：</label>
						<select class="combox" name="entryDistrict.id" id="combox_district_eindex" style="width:120px">
							<option value="-1">所有校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${formEntry ne null && formEntry.entryDistrict ne null && formEntry.entryDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>入职状态：</label>
						<select class="combox" name="finalStatus" style="width:108px;">
							<option value="-1">所有</option>
							<option value="0" ${formEntry ne null && formEntry.finalStatus eq 0 ? 'selected="true"' : ''}>待入职</option>
							<option value="1" ${formEntry ne null && formEntry.finalStatus eq 1 ? 'selected="true"' : ''}>已入职</option>
							<option value="2" ${formEntry ne null && formEntry.finalStatus eq 2 ? 'selected="true"' : ''}>未到岗</option>
						</select>
					</td>
					<td>
						<label>考察结果：</label>
						<select class="combox" name="inspectStatus" style="width:108px;">
							<option value="-1">所有</option>
							<option value="0" ${formEntry ne null && formEntry.inspectStatus eq 0 ? 'selected="true"' : ''}>考察中</option>
							<option value="1" ${formEntry ne null && formEntry.inspectStatus eq 1 ? 'selected="true"' : ''}>考察通过</option>
							<option value="2" ${formEntry ne null && formEntry.inspectStatus eq 2 ? 'selected="true"' : ''}>考察不通过</option>
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
		<table class="table" width="100%" layoutH="115">
			<thead>
				<tr>
					<th align="center">姓名</th>
					<th align="center">联系电话</th>
					<th align="center">入职校区</th>
					<th align="center">入职部门</th>
					<th align="center">入职岗位</th>
					<th align="center">入职负责人</th>
					<th align="center">安排入职时间</th>
					<th align="center">入职状态</th>
					<th align="center">实际入职时间</th>
					<th align="center">考察结果</th>
					<th align="center">入职</th>
					<th align="center">未到</th>
					<th align="center">考察期处理</th>
				</tr>
			</thead>
			<tbody>
				<logic:present name="entries">
					<logic:iterate name="entries" property="items" id="entity">
						<tr target="entry_id" rel="${entity.id}">
							<td>${entity.jobHireIssue.resume.fullName}</td>
							<td>${entity.jobHireIssue.resume.mobilePhone}</td>
							<td>${entity.entryDistrict ne null ? entity.entryDistrict.districtName : ''}</td>
							<td>${entity.entryDepartment ne null ? entity.entryDepartment.depName : ''}</td>
							<td>${entity.entryPosition ne null ? entity.entryPosition.positionName : ''}</td>
							<td>${entity.entryCharger ne null ? entity.entryCharger.fullName : ''}</td>
							<td><fmt:formatDate value="${entity.entryPlanDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${entity.finalStatus ne null ? (entity.finalStatus eq 0 ? '待入职' : (entity.finalStatus eq 1 ? '已入职' : '未到岗')) : '---'}</td>
							<td><c:if test="${entity.entryActDate ne null}"><fmt:formatDate value="${entity.entryActDate}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if></td>
							<td>${entity.inspectStatus ne null ? (entity.inspectStatus eq 0 ? '考察中' : (entity.inspectStatus eq 1 ? '考察通过' : '考察不通过')) : '---'}</td>
							<td>
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_HRM_ENTRY_OP_ONBOARD')}">
										<c:choose>
											<c:when test="${entity.finalStatus eq 0}">
												<a class="oplink" href="app/hrm/entry.do?action=dialogEntryBoardPage&entryId=${entity.id}" target="dialog" title="入职操作" width="600" height="240" rel="hrm_entryin_${entity.id}" mask="true" rel="hrm_resumedetail_${entity.id}">入职</a>
											</c:when>
											<c:otherwise>
												<label class="opdisabled">入职</label>
											</c:otherwise>
										</c:choose>
									</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
							</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_HRM_ENTRY_OP_ABSENCE')}">
										<c:choose>
											<c:when test="${entity.finalStatus eq 0}">
												<a class="oplink" href="app/hrm/entry.do?action=dialogEntryFinalize&entryId=${entity.id}&op=outofboard&state=2" target="dialog" title="未到处理" mask="true" rel="hrm_entryabsence_${entity.id}" width="300" height="200">未到</a>
											</c:when>
											<c:otherwise>
												<label class="opdisabled">未到</label>
											</c:otherwise>
										</c:choose>
									</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
							</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_HRM_ENTRY_OP_QUALIFY')}">
										<c:choose>
											<c:when test="${entity.inspectStatus eq 0}">
												<a class="oplink" href="app/hrm/entry.do?action=actionEntrySave&entryId=${entity.id}&op=qualified&state=1&empId=${entity.jobHireIssue.resume.employeeId}" target="ajaxToDo" title="您确定‘${entity.jobHireIssue.resume.fullName}’考察期已经结束并且通过考察吗?" mask="true" rel="hrm_entryqua_${entity.id}" callback="reload_entrypage()">通过</a>
												&nbsp;&nbsp;
												<a class="oplink" href="app/hrm/entry.do?action=dialogEntryFinalize&entryId=${entity.id}&op=qualified&state=2&empId=${entity.jobHireIssue.resume.employeeId}" target="dialog" title="面试记录‘${entity.jobHireIssue.resume.fullName}’" mask="true" rel="hrm_entryqua_${entity.id}" width="300" height="150">未通过</a></td>
											</c:when>
											<c:otherwise>
												<label class="opdisabled">通过</label>
												&nbsp;&nbsp;
												<label class="opdisabled">未通过</label>
											</c:otherwise>
										</c:choose>
									</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
							</c:choose>
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