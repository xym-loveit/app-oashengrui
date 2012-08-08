<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	.dgreen {color: green;}
	.opdisabled {text-decoration: line-through; color: #DDD; line-height: 21px;}
</style>

<script type="text/javascript">

</script>

<form id="pagerForm" method="post" action="app/personal/task.do?action=pageTaskIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/personal/task.do?action=pageTaskIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>任务类型：</label>
						<select class="combox" name="taskTypeId" id="my_tasktype">
							<option value="-1">所有</option>
							<logic:present name="taskTypes">
								<logic:iterate name="taskTypes" id="entity">
									<option value="${entity.id}" ${formEntity ne
										null && formEntity.taskTypeId eq
										entity.id ? 'selected="selected"' : ''}>${entity.value}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>任务状态：</label>
						<select class="combox" name="taskStatus" id="task_status">
							<option value="-1" ${formEntity ne null && formEntity.taskStatus eq -1 ? 'selected="selected"' : ''}>所有</option>
							<option value="0" ${formEntity ne null && formEntity.taskStatus eq 0 ? 'selected="selected"' : ''}>未开始</option>
							<option value="1" ${formEntity ne null && formEntity.taskStatus eq 1 ? 'selected="selected"' : ''}>进行中</option>
							<option value="2" ${formEntity ne null && formEntity.taskStatus eq 2 ? 'selected="selected"' : ''}>已延期</option>
							<option value="3" ${formEntity ne null && formEntity.taskStatus eq 3 ? 'selected="selected"' : ''}>已完成</option>
						</select>
					</td>
					<td>
						任务名称：<input type="text" name="taskName" value="${formEntity ne null && formEntity.taskName ne null ? formEntity.taskName : ''}"/>
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
		<ul class="toolBar" style="overflow:hidden">
			<c:if test="${tm:ifGranted('_FUNCKEY_PERSONAL_TASK_MYVIEW')}">
			<li style="float:right"><a treeicon="icon-records" class="icon" href="app/personal/task.do?action=pageTaskLaunched" target="navTab" rel="dmp_workplan"><span class="icon-records">我发起的任务</span></a></li>
			</c:if>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">任务类型</th>
				<th align="center">任务名称</th>
				<th align="center">发起人</th>
				<th align="center">负责/参与</th>
				<th align="center">任务状态</th>
				<th align="center">剩余时间</th>
				<th align="center">开始时间</th>
				<th align="center">结束时间</th>
				<th align="center">实际完成时间</th>
				<th align="center">完成申请</th>
				<th align="center">延期申请</th>
				<th align="center">详细</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="dataList">
				<logic:iterate name="dataList" property="items" id="entity">
					<tr target="entry_id" rel="${entity.id}">
						<td>${entity.taskType.name}</td>
						<td>${entity.taskName}</td>
						<td>${entity.taskCharger.empName}</td>
						<td>${entity.taskCharger.id eq sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employee.id ? '负责' : '参与'}</td>
						<td>
							<c:choose>
								<c:when test="${entity.taskStatus eq null}">${tm:getIntervalDays(today, entity.taskPlannedStartDate) >= 0 ? '未开始' : '进行中'}</c:when>
								<c:when test="${entity.taskStatus eq 1}">进行中</c:when>
								<c:when test="${entity.taskStatus eq 2}">已延期</c:when>
								<c:when test="${entity.taskStatus eq 3}">已完成</c:when>
								<c:when test="${entity.taskStatus eq 4}">待延期审批</c:when>
								<c:when test="${entity.taskStatus eq 5}">待完成审批</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${entity.taskActualEndDate ne null}">
									<c:choose>
										<c:when test="${tm:getIntervalDays(entity.taskActualEndDate, entity.taskPlannedEndDate) >= 0}">
											提前<b style="color:#3A9D3A; margin: 0 2px;">${fn:replace(tm:getIntervalDays(entity.taskActualEndDate, entity.taskPlannedEndDate), '-', '')}</b>天完成
										</c:when>
										<c:otherwise>
											延期<b style="color:red; margin: 0 2px;">${fn:replace(tm:getIntervalDays(entity.taskActualEndDate, entity.taskPlannedEndDate), '-', '')}</b>天完成
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${tm:getIntervalDays(today, entity.taskPlannedEndDate) >= 0}">
									还剩<b style="color:#3A9D3A; margin: 0 2px;">${fn:replace(tm:getIntervalDays(today, entity.taskPlannedEndDate), '-', '')}</b>天
								</c:when>
								<c:otherwise>
									已延期<b style="color:red; margin: 0 2px;">${fn:replace(tm:getIntervalDays(today, entity.taskPlannedEndDate), '-', '')}</b>天
								</c:otherwise>
							</c:choose>
						</td>
						<td><fmt:formatDate value="${entity.taskPlannedStartDate}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate value="${entity.taskPlannedEndDate}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate value="${entity.taskActualEndDate}" pattern="yyyy-MM-dd" /></td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_TASK_ACCOMPLISH')}">
									<c:choose>
										<c:when test="${entity.taskStatus eq 3 || entity.taskStatus eq 5 || entity.taskStatus eq 4}">
											<label class="opdisabled">[完成审请]</label>
										</c:when>
										<c:otherwise>
											<a href="app/personal/task.do?action=dialogApplyPage&id=${entity.id}&type=1" target="dialog" title="任务‘${entity.taskName}’-完成审请" width="555" height="445" class="oplink" rel="my_taskacc-${entity.id}">[完成审请]</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_TASK_POSTPONE')}">
									<c:choose>
										<c:when test="${entity.taskStatus eq 3 || entity.taskStatus eq 5 || entity.taskStatus eq 4}">
											<label class="opdisabled">[延期申请]</label>
										</c:when>
										<c:otherwise>
											<a href="app/personal/task.do?action=dialogApplyPage&id=${entity.id}&type=0" target="dialog" title="任务‘${entity.taskName}’-延期申请" width="555" height="445" class="oplink" rel="my_taskapos-${entity.id}">[延期申请]</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_TASK_VIEW')}">
									<a href="app/personal/task.do?action=dialogTaskPage&id=${entity.id}&op=view" target="dialog" title="任务‘${entity.taskName}’-查看" width="750" height="530" class="oplink" rel="personal_taskedit-${edit.id}">详细</a>
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