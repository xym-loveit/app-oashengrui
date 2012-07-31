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
	.dgreen {color: green;}
</style>

<form id="pagerForm" method="post" action="app/personal/task.do?action=pageTaskLaunched">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/personal/task.do?action=pageTaskLaunched" method="post" id="searchForm" rel="pagerForm">
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
										null && formEntity.taskType ne
										null && formEntity.taskType.id eq
										entity.id ? 'selected="selected"' : ''}>${entity.value}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>任务状态：</label>
						<select class="combox" name="taskStatus" id="task_status">
							<option value="-1">所有</option>
							<option value="1">进行中</option>
							<option value="2">已延期</option>
							<option value="3">已完成</option>
						</select>
					</td>
					<td>
						任务名称：<input type="text" name="taskName" />
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
			<li><a treeicon="icon-myplan" class="icon" href="app/personal/task.do?action=pageTaskIndex" target="navTab" rel="_menu_mod_personal_mytask"><span class="icon-myplan">我的任务</span></a></li>
		</ul>
		<ul class="toolBar">
			<c:if test="${tm:ifGranted('_FUNCKEY_PERSONAL_TASK_ADD')}">
			<li><a class="add" href="app/personal/task.do?action=dialogTaskPage" target="dialog" title="新建任务" width="1080" height="380" rel="dia_my_taskadd"><span>新建任务</span></a></li>
			</c:if>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">任务类型</th>
				<th align="center">任务名称</th>
				<th align="center">任务负责人</th>
				<th align="center">任务状态</th>
				<th align="center">发布审批</th>
				<th align="center">剩余时间</th>
				<th align="center">开始时间</th>
				<th align="center">结束时间</th>
				<th align="center">实际完成时间</th>
				<th align="center">任务审批</th>
				<th align="center">编辑</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="dataList">
				<logic:iterate name="dataList" property="items" id="entity">
					<tr target="entry_id" rel="${entity.id}">
						<td>${entity.taskType.name}</td>
						<td>${entity.taskName}</td>
						<td>${entity.taskCharger.empName}</td>
						<td>
							<c:choose>
								<c:when test="${entity.taskStatus eq null}">未开始</c:when>
								<c:when test="${entity.taskStatus eq 1}">进行中</c:when>
								<c:when test="${entity.taskStatus eq 2}">已延期</c:when>
								<c:when test="${entity.taskStatus eq 3}">已完成</c:when>
								<c:when test="${entity.taskStatus eq 4}">待延期审批</c:when>
								<c:when test="${entity.taskStatus eq 5}">待完成审批</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${entity.auditStatus eq null || entity.auditStatus eq 1}">待审核</c:when>
								<c:when test="${entity.auditStatus eq 2}">已通过</c:when>
								<c:when test="${entity.auditStatus eq 3}">不通过</c:when>
								<c:when test="${entity.auditStatus eq 4}">已退回</c:when>
								<c:otherwise>未知</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${tm:getIntervalDays(entity.taskPlannedStartDate, entity.taskPlannedEndDate) >= 0}">还剩<b style="color:#3A9D3A; margin: 0 2px;">${tm:getIntervalDays(entity.taskPlannedStartDate, entity.taskPlannedEndDate)}</b>天
								</c:when>
							</c:choose>
						</td>
						<td><fmt:formatDate  value="${entity.taskPlannedStartDate}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate  value="${entity.taskPlannedEndDate}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate value="${entity.taskActualEndDate}" pattern="yyyy-MM-dd" /></td>
						<td>
							<c:choose>
								<c:when test="${entity.taskStatus eq 4}">
									<c:choose>
										<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_TASK_ACCOMPLISH_APPROVE')}">
											<a href="app/personal/task.do?action=dialogAuditPage&taskId=${entity.id}&type=0" target="dialog" title="任务‘${entity.taskName}’-延期审批" width="555" height="445" class="oplink" rel="admin_taskapproval-1">[延期审批]</a>	
										</c:when>
										<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${entity.taskStatus eq 5}">
									<c:choose>
										<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_TASK_POSTPONE_APPROVE')}">
											<a href="app/personal/task.do?action=dialogAuditPage&taskId=${entity.id}&type=1" target="dialog" title="任务‘${entity.taskName}’-完成审批" width="555" height="445" class="oplink" rel="admin_taskapproval-1">[完成审批]</a>
										</c:when>
										<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_TASK_APPROVES_VIEW')}">
											<a href="app/personal/task.do?action=dialogAuditRecords&taskId=${entity.id}" target="dialog" title="任务‘${entity.taskName}’-审批记录" width="900" height="300" class="oplink" rel="admin_taskauditrecords-${entity.id}">[审批记录]</a>
										</c:when>
										<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_TASK_EDIT')}">
									<a href="app/personal/task.do?action=dialogTaskPage&id=${entity.id}" target="dialog" title="任务‘${entity.taskName}’-编辑" width="1080" height="380" class="oplink" rel="personal_taskedit-${edit.id}">编辑</a>
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