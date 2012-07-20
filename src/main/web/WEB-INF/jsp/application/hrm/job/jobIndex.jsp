<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	.opdisabled {text-decoration: line-through; color: #DDD; line-height: 21px;}
</style>

<form id="pagerForm" method="post" action="app/hrm/hire.do?action=hrmJobIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/hrm/hire.do?action=hrmJobIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>招聘校区：</label>
						<select class="combox" name="jobHireDistrict.id" id="combox_district_jindex" style="width:120px" ref="combox_dept_jindex" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
							<option value="-1">所有校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${hireJobForm ne null && hireJobForm.jobHireDistrict ne null && hireJobForm.jobHireDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>招聘部门：</label>
						<select class="combox" id="combox_dept_jindex" name="jobHireDepartment.id" defOPKey="所有部门" defOPVal="-1" style="width:108px;">
							<option value="-1">所有部门</option>
							<logic:present name="departments">
								<logic:iterate name="departments" id="entity">
									<option value="${entity.id}" ${hireJobForm ne null && hireJobForm.jobHireDepartment ne null && hireJobForm.jobHireDepartment.id eq entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						岗位名称：<input type="text"  name="jobHireTitle" value="${hireJobForm ne null ? hireJobForm.jobHireTitle : ''}"/>
					</td>
					<td>
						<label>招聘状态：</label>
						<select class="combox" name="isOpen" id="entry_status">
							<option value="-1">所有</option>
							<option value="1" ${hireJobForm ne null && hireJobForm.isOpen eq 1 ? 'selected="selected"' : ''}>招聘中</option>
							<option value="0" ${hireJobForm ne null && hireJobForm.isOpen eq 0 ? 'selected="selected"' : ''}>已关闭</option>
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
<div class="pageContent">
	<div class="panelBar">
		<c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.functionRights eq '__ALL' || tm:inRange(sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.functionRights, '_FUNCKEY_JOBAPPROVAL_SUBNODE', ',') || tm:inRange(sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.functionRights, '_FUNCKEY_JOBAPPROVAL_ROOT', ',')}">
			<ul class="toolBar" style="float:right">
				<li><a treeicon="icon-edit" class="icon" href="app/hrm/hire.do?action=hrmPageJobApprovalIndex" target="navTab" rel="hr_approval"><span class="icon-edit">待我审批</span></a></li>
			</ul>
		</c:if>
		<ul class="toolBar">
			<li><a class="add" href="app/hrm/hire.do?action=hrmPageJobDetail" target="dialog" title="岗位发布" width="960" height="500" rel="dia_hr_entryadd"><span>添加</span></a></li>
			<li class="line">line</li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">岗位名称</th>
				<th align="center">招聘人数</th>
				<th align="center">应聘人数</th>
				<th align="center">招聘校区</th>
				<th align="center">招聘部门</th>
				<th align="center">招聘范围</th>
				<th align="center">审批状态</th>
				<th align="center">招聘状态</th>
				<th align="center">岗位详细</th>
				<th align="center">编辑</th>
				<th align="center">应聘控制</th>
				<th align="center">入职安排</th>
				<th align="center">招聘安排</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="hireJobs">
				<logic:iterate name="hireJobs" property="items" id="entity">
					<tr target="sid" rel="${entity.id}">
						<td>${entity.jobHireTitle}</td>
						<td>${entity.jobHireCount}</td>
						<td>${fn:length(entity.jobHireIssues)}</td>
						<td>${entity.jobHireDistrict ne null ? entity.jobHireDistrict.districtName : ''}</td>
						<td>${entity.jobHireDepartment ne null ? entity.jobHireDepartment.depName : ''}</td>
						<td>${entity.jobHireRange eq 1 ? '内外兼招' : (entity.jobHireRange eq 2 ? '外部招聘' : (entity.jobHireRange eq 3 ? '内部招聘' : ''))}</td>
						<td>${entity.status eq 1 ? '待校区审批' : (entity.status eq 2 ? '待总部审批' : (entity.status eq 3 ? '审核退回' : (entity.status eq 4 ? '审核通过' : '未知')))}</td>
						<td>
							<c:choose>
								<c:when test="${entity.status eq 0 || entity.status eq 2}">
									——
								</c:when>
								<c:when test="${entity.status eq 1}">
									${entity.isOpen eq 0 ? '已关闭' : '招聘中'}
								</c:when>
							</c:choose>
						</td>
						<td><a class="oplink" href="app/hrm/hire.do?action=hrmPageJobDetail&id=${entity.id}&op=view" target="dialog" title="岗位详细" width="930" height="500">详细</a></td>
						<td>
							<c:choose>
								<c:when test="${entity.status eq 2}">
									<a class="oplink" href="app/hrm/hire.do?action=hrmPageJobDetail&id=${entity.id}&op=edit" target="dialog" title="编辑岗位" width="930" height="500">编辑</a>
								</c:when>
								<c:otherwise>
									<label class="opdisabled">编辑</label>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${entity.status eq 0 || entity.status eq 2}">
									<label class="opdisabled">关闭</label>
								</c:when>
								<c:when test="${entity.status eq 1}">
									<c:choose>
										<c:when test="${entity.isOpen eq 0}">
											<a class="oplink" href="app/hrm/hire.do?action=actionJobOpenControl&jobId=${entity.id}&state=1" target="ajaxTodo" title="确定要开启该岗位应聘吗?">开启</a>
										</c:when>
										<c:when test="${entity.isOpen eq null || entity.isOpen eq 1}">
											<a class="oplink" href="app/hrm/hire.do?action=actionJobOpenControl&jobId=${entity.id}&state=0" target="ajaxTodo" title="确定要关闭该岗位应聘吗?">关闭</a>
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${entity.isOpen eq 0}">
								</c:when>
								<c:when test="${entity.status ne 4}">
									<label class="opdisabled">入职安排</label>
								</c:when>
								<c:otherwise>
									<a class="oplink" href="app/hrm/hire.do?action=hrmPageJobEntryIndex&jobId=${entity.id}" target="navTab" title="入职安排-'${entity.jobHireTitle}'" rel="hrm_jobplan_entry${entity.id}">入职安排</a>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${entity.isOpen eq 0}">
								</c:when>
								<c:when test="${entity.status ne 4}">
									<label class="opdisabled">招聘安排</label>
								</c:when>
								<c:otherwise>
									<a class="oplink" href="app/hrm/hire.do?action=hrmPageJobOfferIndex&jobId=${entity.id}" target="navTab" title="招聘安排-'${entity.jobHireTitle}'" rel="hrm_jobpln_hire_${entity.id}">招聘安排</a>
								</c:otherwise>
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