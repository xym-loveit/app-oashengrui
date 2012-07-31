<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<form id="pagerForm" method="post" action="app/personal/approval.do?action=pageMyApprovalReturn">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>
<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin/news.do?action=adminPageEntryIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>审批类型：</label>
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
						申请人：<input type="text" name="newsSubject" value="${formNews ne null ? formNews.newsSubject : ''}" />
					</td>
					<td><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></td>
				</tr>
			</table>
					
		</div>
	</form>
</div>

<!-- Body -->	
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar" style="float:right">
			<li><a treeicon="icon-edit" class="icon" href="app/personal/approval.do?action=pageMyApproval" target="navTab" rel="admin_entrycheck"><span class="icon-edit">返回待我审批列表</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="115">
		<thead>
			<tr>
				<th align="center">审批类型</th>
				<th align="center">申请内容描述</th>
				<th align="center">申请人姓名</th>
				<th align="center">申请时间</th>
				<th align="center" class="thover">详细</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="newsinfo">
				<logic:iterate id="newsinfo" name="newsinfo" property="items">
					<tr>
						<td>
							<c:choose>
								<c:when test="${newsinfo.status eq 2 }">新闻审批通过</c:when>
								<c:when test="${newsinfo.status eq 3 }">新闻审批退回</c:when>
							</c:choose>
						</td>
						<td>
							[${newsinfo.dictionary.name}] &nbsp&nbsp&nbsp “${newsinfo.newsSubject}” &nbsp&nbsp&nbsp<c:choose><c:when test="${newsinfo.status eq 2 }">新闻审批通过</c:when><c:when test="${newsinfo.status eq 3 }">新闻审批退回</c:when></c:choose>
						</td>
						<td>${newsinfo.user.fullName}</td>
						<td><c:if test="${newsinfo.updateTime ne null}"><fmt:formatDate value="${newsinfo.updateTime}" pattern="yyyy-MM-dd" /></c:if></td>
						<td><a class="oplink" href="app/admin/news.do?action=actionNewsScan&id=${newsinfo.id }&op=view" target="dialog" width="900" height="600" title="新闻审批" rel="dia_admin_entryapproval-id">详细</a></td>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="hireJobsInfo">
				<logic:iterate id="hireJobsInfo" name="hireJobsInfo" property="items">
					<tr>
					<c:choose>
								<c:when test="${hireJobsInfo.status eq 2 }">
						<td>
							岗位发布审批通过
							
						</td>
						<td>
							[${hireJobsInfo.jobHireDistrict ne null ? hireJobsInfo.jobHireDistrict.districtName : ''}  ${hireJobsInfo.jobHireDepartment ne null ? hireJobsInfo.jobHireDepartment.depName : ''}] 
							&nbsp&nbsp “${hireJobsInfo.jobHireTitle}”&nbsp&nbsp招聘
						</td>
						<td>${hireJobsInfo.postAuthorName}</td>
						<td><c:if test="${hireJobsInfo.postDate ne null}"><fmt:formatDate value="${hireJobsInfo.postDate}" pattern="yyyy-MM-dd"/></c:if></td>
						<td><a class="oplink" href="app/hrm/hire.do?action=hrmPageJobDetail&id=${hireJobsInfo.id}&op=view" target="dialog" title="岗位详细" width="960" height="420">详细</a></td></c:when></c:choose>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="taskInfo">
				<logic:iterate id="taskInfo" name="taskInfo" property="items">
					<tr>
					<td>
						<c:choose>
							<c:when test="${taskInfo.auditStatus eq 2}">任务审批已通过</c:when>
							<c:when test="${taskInfo.auditStatus eq 3}">任务审批不通过</c:when>
							<c:when test="${taskInfo.auditStatus eq 4}">任务审批已退回</c:when>
						</c:choose>
					</td>
					<td>
						[${taskInfo.taskName }] &nbsp&nbsp&nbsp “${taskInfo.taskName}” &nbsp&nbsp&nbsp
						<c:choose>
							<c:when test="${taskInfo.auditStatus eq 2}">任务审批已通过</c:when>
							<c:when test="${taskInfo.auditStatus eq 3}">任务审批不通过</c:when>
							<c:when test="${taskInfo.auditStatus eq 4}">任务审批已退回</c:when>
						</c:choose>
					</td>
					<td>${taskInfo.taskOriginator.empName }</td>
					<td><c:if test="${taskInfo.createTime ne null}"><fmt:formatDate value="${taskInfo.createTime}" pattern="yyyy-MM-dd" /></c:if></td>
					<td><a href="app/admin/task.do?action=dialogTaskPage&id=${taskInfo.id}&op=view" target="dialog" title="任务‘${taskInfo.taskName}’-查看" width="750" height="530" class="oplink">详细</a></td>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="finanInfo">
				<logic:iterate id="finanInfo" name="finanInfo" property="items">
					<tr>
					<td>
						<c:choose>
							<c:when test="${finanInfo.auditState eq 2}">费用支出审批已通过</c:when>
							<c:when test="${finanInfo.auditState eq 3}">费用支出审批不通过</c:when>
							<c:when test="${finanInfo.auditState eq 4}">费用支出审批已退回</c:when>
						</c:choose>
					</td>
					<td>
						${finanInfo.employee.empName } &nbsp&nbsp&nbsp <label style="color:red;">${finanInfo.empDistrict.districtName}</label> &nbsp&nbsp&nbsp  <label style="color:red;">${finanInfo.applyAmt }</label>
						<c:choose>
							<c:when test="${finanInfo.auditState eq 2}">费用支出审批已通过</c:when>
							<c:when test="${finanInfo.auditState eq 3}">费用支出审批不通过</c:when>
							<c:when test="${finanInfo.auditState eq 4}">费用支出审批已退回</c:when>
						</c:choose>
					</td>
					<td>${finanInfo.employee.empName }</td>
					<td><c:if test="${finanInfo.applyDate ne null}"><fmt:formatDate value="${finanInfo.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td><a class="oplink" href="app/finan/expense.do?action=diaglogFinaExpensePage&id=${finanInfo.id}&op=view" target="dialog" title="查看‘${finanInfo.employee.empName}’合同申请单-${finanInfo.formNo}" width="1150" height="640" >详细</a></td>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="contractInfo">
				<logic:iterate id="contractInfo" name="contractInfo" property="items">
					<tr>
					<td>
						<c:choose>
							<c:when test="${contractInfo.auditState eq 2}">合同审批已通过</c:when>
							<c:when test="${contractInfo.auditState eq 3}">合同审批不通过</c:when>
							<c:when test="${contractInfo.auditState eq 4}">合同审批已退回</c:when>
						</c:choose>
					</td>
					<td>
						${contractInfo.employee.empName } &nbsp&nbsp&nbsp ${contractInfo.empDistrict.districtName} &nbsp&nbsp&nbsp ${contractInfo.applyFormType.processTypeName}
						<c:choose>
							<c:when test="${contractInfo.auditState eq 2}">合同审批已通过</c:when>
							<c:when test="${contractInfo.auditState eq 3}">合同审批不通过</c:when>
							<c:when test="${contractInfo.auditState eq 4}">合同审批已退回</c:when>
						</c:choose>
					</td>
					<td>${contractInfo.employee.empName }</td>
					<td><c:if test="${contractInfo.applyDate ne null}"><fmt:formatDate value="${contractInfo.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td><a class="oplink" href="app/finan/contract.do?action=diaglogFinaContractPage&id=${contractInfo.id}&op=view" target="dialog" title="查看‘${contractInfo.employee.empName}’合同申请单-${contractInfo.formNo}" width="1150" height="640" >详细</a></td>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="dataList">
				<logic:iterate id="type" name="dataList" property="items">
					<tr>
					<c:choose>
								<c:when test="${type.applyFormType.id eq 5 && type.auditState ne 1}">
					<td>
						晋升申请审批
					</td>
					<td>
						${type.employee.empName} &nbsp&nbsp <label style="color:red;">${type.fromDistrict.districtName }_${type.fromDepartment.depName }_${type.fromPosition.positionName }</label>
						&nbsp&nbsp 晋升 &nbsp&nbsp<label style="color:red;">${type.toDistrict.districtName }_${type.toDepartment.depName }_${type.toPosition.positionName }</label> &nbsp&nbsp申请
					</td>
					<td>${type.employee.empName }</td>
					<td><c:if test="${type.applyDate ne null}"><fmt:formatDate value="${type.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
<td>
						<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${type.id}&op=view" target="dialog" title="查看‘${type.employee.empName}’人资申请单-${type.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${type.id}">详细</a></td>
					</td></c:when></c:choose>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="dataList">
				<logic:iterate id="type" name="dataList" property="items">
					<tr>
					<c:choose>
								<c:when test="${type.applyFormType.id eq 3 && type.auditState ne 1}">
					<td>
						转正申请审批
					</td>
					<td>
						${type.employee.empName} &nbsp&nbsp<label style="color:red;">${type.fromDistrict.districtName }_${type.fromDepartment.depName }_${type.fromPosition.positionName }</label>&nbsp&nbsp转正申请
					</td>
					<td>${type.employee.empName }</td>
					<td><c:if test="${type.applyDate ne null}"><fmt:formatDate value="${type.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td>
						<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${type.id}&op=view" target="dialog" title="查看‘${type.employee.empName}’人资申请单-${type.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${type.id}">详细</a></td>
					</td></c:when></c:choose>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="dataList">
				<logic:iterate id="type" name="dataList" property="items">
					<tr>
					<c:choose>
								<c:when test="${type.applyFormType.id eq 6 && type.auditState ne 1}">
					<td>
						离职申请审批
					</td>
					<td>
						${type.employee.empName} &nbsp&nbsp<label style="color:red;">${type.fromDistrict.districtName }_${type.fromDepartment.depName }_${type.fromPosition.positionName }</label>&nbsp&nbsp离职申请
					</td>
					<td>${type.employee.empName }</td>
					<td><c:if test="${type.applyDate ne null}"><fmt:formatDate value="${type.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td>
						<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${type.id}&op=view" target="dialog" title="查看‘${type.employee.empName}’人资申请单-${type.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${type.id}">详细</a></td>
					</td></c:when></c:choose>
					</tr>
				</logic:iterate>
			</logic:present>
			<logic:present name="dataList">
				<logic:iterate id="type" name="dataList" property="items">
					<tr>
					<c:choose>
								<c:when test="${type.applyFormType.id eq 4 && type.auditState ne 1}">
					<td>
						调动申请审批
					</td>
					<td>
						${type.employee.empName}&nbsp&nbsp<label style="color:red;">${type.fromDistrict.districtName }_${type.fromDepartment.depName }_${type.fromPosition.positionName }</label>&nbsp&nbsp调动 &nbsp&nbsp
						<label style="color:red;">${type.toDistrict.districtName }_${type.toDepartment.depName }_${type.toPosition.positionName }</label>&nbsp&nbsp申请
					</td>
					<td>${type.employee.empName }</td>
					<td><c:if test="${type.applyDate ne null}"><fmt:formatDate value="${type.applyDate}" pattern="yyyy-MM-dd" /></c:if></td>
					<td>
						<a class="oplink" href="app/personal/application_form.do?action=dialogApplicationFormPage&formId=${type.id}&op=view" target="dialog" title="查看‘${type.employee.empName}’人资申请单-${type.formNo}" width="1150" height="640" rel="dia_myformapplication_view_${type.id}">详细</a></td>
					</td></c:when></c:choose>
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