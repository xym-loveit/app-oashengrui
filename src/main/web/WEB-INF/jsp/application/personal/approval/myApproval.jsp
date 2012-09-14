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
							新闻发布审批
						</td>
						<td style="text-align:left">
							[${news.dictionary.name}] &nbsp&nbsp&nbsp “${news.newsSubject}” &nbsp&nbsp&nbsp 新闻发布审批
						</td>
						<td>${news.user.fullName}</td>
						<td><c:if test="${news.updateTime ne null}"><fmt:formatDate value="${news.updateTime}" pattern="yyyy-MM-dd" /></c:if></td>
						<td><a class="oplink" href="app/admin.do?action=adminPageEntryDetail&id=${news.id }&op=view" target="dialog" width="900" height="500" title="新闻审批" rel="dia_admin_entryapproval-id">审批</a></td>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="hireJobs">
				<logic:iterate id="entity" name="hireJobs" property="items">
					<tr>
					<c:choose><c:when test="${entity.status eq 2}">
						<td>
							岗位发布审批
						</td>
						<td style="text-align:left">
							[${entity.jobHireDistrict.districtName}   ${entity.jobHireDepartment.depName}]&nbsp&nbsp “${entity.jobHireTitle}”&nbsp&nbsp招聘
						</td>
						<td>${entity.postAuthorName}</td>
						<td><c:if test="${entity.postDate ne null}"><fmt:formatDate value="${entity.postDate}" pattern="yyyy-MM-dd"/></c:if></td>
						<td><a class="oplink" href="app/hrm/hire.do?action=hrmPageJobDetail&id=${entity.id}" target="dialog" title="岗位审批" width="930" height="500">审批</a></td>
					</c:when></c:choose>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="task">
				<logic:iterate id="task" name="task" property="items">
					<tr>
					<td>
						任务委托审批
					</td>
					<td style="text-align:left">
						[${task.taskType.name }] &nbsp&nbsp&nbsp “${task.taskName}” &nbsp&nbsp&nbsp 任务委托发布审批
					</td>
					<td>${task.taskOriginator.empName }</td>
					<td><c:if test="${task.createTime ne null}"><fmt:formatDate value="${task.createTime}" pattern="yyyy-MM-dd" /></c:if></td>
					<td><a href="app/admin/task.do?action=dialogTaskPage&id=${task.id}&op=audit" target="dialog" title="任务审批" width="1080" height="380" class="oplink">审批</a></td>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="finan">
				<logic:iterate id="finan" name="finan" property="items">
					<tr>
					<td>
						费用支出申请审批
					</td>
					<td style="text-align:left">
						${finan.employee.empName } &nbsp&nbsp&nbsp <label style="color:red;">${finan.empDistrict.districtName}</label>&nbsp&nbsp&nbsp${finan.applyFormType.processTypeName}&nbsp&nbsp申请&nbsp&nbsp<label style="color:red;">${finan.applyAmt }</label>
					</td>
					<td>${finan.employee.empName }</td>
					<td><c:if test="${finan.applyDate ne null}"><fmt:formatDate value="${finan.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td><a class="oplink" href="app/finan/expense.do?action=diaglogFinaExpensePage&id=${finan.id}&op=view" target="dialog" title="‘${finan.employee.empName}’费用申请单-${finan.formNo}审批" width="1150" height="640">审批</a></td>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="contract">
				<logic:iterate id="contract" name="contract" property="items">
					<tr>
					<td>
						合同申请审批
					</td>
					<td style="text-align:left">
						[${contract.employee.empName }] &nbsp&nbsp&nbsp ${contract.empDistrict.districtName} &nbsp&nbsp&nbsp ${contract.applyFormType.processTypeName}
					</td>
					<td>${contract.employee.empName }</td>
					<td><c:if test="${contract.applyDate ne null}"><fmt:formatDate value="${contract.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td><a class="oplink" href="app/finan/contract.do?action=diaglogFinaContractPage&id=${contract.id}&op=view" target="dialog" title="查看‘${contract.employee.empName}’合同申请单-${contract.formNo}" width="1150" height="640">审批</a></td>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="dataList">
				<logic:iterate id="type" name="dataList" property="items">
					<tr>
					<c:choose><c:when test="${type.applyFormType.id eq 5}">
					<td>
						晋升申请审批
					</td>
					<td style="text-align:left">
						${type.employee.empName} &nbsp&nbsp <label style="color:red;">${type.fromDistrict.districtName }_${type.fromDepartment.depName }_${type.fromPosition.positionName }</label>
						&nbsp&nbsp 晋升 &nbsp&nbsp<label style="color:red;">${type.toDistrict.districtName }_${type.toDepartment.depName }_${type.toPosition.positionName }</label> &nbsp&nbsp申请
					</td>
					<td>${type.employee.empName }</td>
					<td><c:if test="${type.applyDate ne null}"><fmt:formatDate value="${type.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
<td>
						<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${type.id}&op=view" target="dialog" title="查看‘${type.employee.empName}’人资申请单-${type.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${type.id}">审批</a></td>
					</c:when></c:choose>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="dataList">
				<logic:iterate id="type" name="dataList" property="items">
					<tr>
					<c:choose><c:when test="${type.applyFormType.id eq 3}">
					<td>
						转正申请审批
					</td>
					<td style="text-align:left">
						${type.employee.empName} &nbsp&nbsp<label style="color:red;">${type.fromDistrict.districtName }_${type.fromDepartment.depName }_${type.fromPosition.positionName }</label>&nbsp&nbsp转正申请
					</td>
					<td>${type.employee.empName }</td>
					<td><c:if test="${type.applyDate ne null}"><fmt:formatDate value="${type.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td>
						<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${type.id}&op=view" target="dialog" title="查看‘${type.employee.empName}’人资申请单-${type.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${type.id}">审批</a></td>
					</c:when></c:choose>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="dataList">
				<logic:iterate id="type" name="dataList" property="items">
					<tr>
					<c:choose><c:when test="${type.applyFormType.id eq 6}">
					<td>
						离职申请审批
					</td>
					<td style="text-align:left">
						${type.employee.empName} &nbsp&nbsp<label style="color:red;">${type.fromDistrict.districtName }_${type.fromDepartment.depName }_${type.fromPosition.positionName }</label>&nbsp&nbsp离职申请
					</td>
					<td>${type.employee.empName }</td>
					<td><c:if test="${type.applyDate ne null}"><fmt:formatDate value="${type.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td>
						<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${type.id}&op=view" target="dialog" title="查看‘${type.employee.empName}’人资申请单-${type.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${type.id}">审批</a></td>
					</c:when></c:choose>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="dataList">
				<logic:iterate id="type" name="dataList" property="items">
					<tr>
					<c:choose><c:when test="${type.applyFormType.id eq 4}">
					<td>
						调动申请审批
					</td>
					<td style="text-align:left">
						${type.employee.empName}&nbsp&nbsp<label style="color:red;">${type.fromDistrict.districtName }_${type.fromDepartment.depName }_${type.fromPosition.positionName }</label>&nbsp&nbsp调动 &nbsp&nbsp
						<label style="color:red;">${type.toDistrict.districtName }_${type.toDepartment.depName }_${type.toPosition.positionName }</label>&nbsp&nbsp申请
					</td>
					<td>${type.employee.empName }</td>
					<td><c:if test="${type.applyDate ne null}"><fmt:formatDate value="${type.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td>
						<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${type.id}&op=view" target="dialog" title="查看‘${type.employee.empName}’人资申请单-${type.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${type.id}">审批</a></td>
					</c:when></c:choose>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="projects">
				<logic:iterate id="project" name="projects" property="items">
					<tr>
					<td>
						新项目申请审批
					</td>
					<td style="text-align:left">
						[${project.employee.empName }] &nbsp&nbsp&nbsp ${project.empDistrict.districtName} &nbsp&nbsp&nbsp ${project.applyFormType.processTypeName}
					</td>
					<td>${project.employee.empName }</td>
					<td><c:if test="${project.applyDate ne null}"><fmt:formatDate value="${project.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td><a class="oplink" href="app/finan/project.do?action=diaglogFinaProjectPage&id=${project.id}&op=view" target="dialog" title="查看‘${project.employee.empName}’新项目申请单-${project.formNo}" width="1150" height="640" rel="approval_project_${project.id}">审批</a></td>
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