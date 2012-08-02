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
</style>

<script type="text/javascript">
	function reload_taskpage() {
		// 重新加载当前的navTab
		navTab.reload(navTab.getCurrentTabUrl(), {navTabId: navTab.getCurrentTabId()});
	}
</script>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin/task.do?action=pageTaskDelegateIndex" method="post">
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
	<table class="table" width="100%" layoutH="115">
		<thead>
			<tr>
				<th align="center">任务类型</th>
				<th align="center">任务名称</th>
				<th align="center">发责人</th>
				<th align="center">负责人</th>
				<th align="center">任务状态</th>
				<th align="center">发布审批</th>
				<th align="center">剩余时间</th>
				<th align="center">开始时间</th>
				<th align="center">结束时间</th>
				<th align="center">实际完成时间</th>
				<th align="center">审批</th>
				<th align="center">详细</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="dataList">
				<logic:iterate name="dataList" property="items" id="entity">
					<tr target="entry_id" rel="${entity.id}">
						<td>${entity.taskType.name}</td>
						<td>${entity.taskName}</td>
						<td>${entity.taskOriginator.empName}</td>
						<td>${entity.taskCharger.empName}</td>
						<td>
							<c:choose>
								<c:when test="${entity.taskStatus eq null}">未开始</c:when>
								<c:when test="${entity.taskStatus eq 1}">进行中</c:when>
								<c:when test="${entity.taskStatus eq 2}">已延期</c:when>
								<c:when test="${entity.taskStatus eq 3}">已完成</c:when>
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
						<td><fmt:formatDate  value="${entity.taskPlannedStartDate}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate  value="${entity.taskPlannedEndDate}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate value="${entity.taskActualEndDate}" pattern="yyyy-MM-dd" /></td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_TASK_APPROVE')}">
									<c:choose>
										<c:when test="${entity.auditStatus eq null || entity.auditStatus eq 1}">
											<a href="app/admin/task.do?action=dialogTaskPage&id=${entity.id}&op=audit" target="dialog" title="任务审批" width="1080" height="380" class="oplink" rel="admin_taskapproval-${entity.id}">审批</a>
										</c:when>
										<c:otherwise><label class="opdisabled">审批</label></c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_TASK_VIEW')}">
									<a href="app/admin/task.do?action=dialogTaskPage&id=${entity.id}&op=view" target="dialog" title="任务‘${entity.taskName}’-查看" width="750" height="530" class="oplink" rel="admin_taskdetail-${entity.id}">详细</a>
								</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_TASK_EDIT')}">
									<a href="app/admin/task.do?action=dialogTaskPage&id=${entity.id}" target="dialog" title="任务‘${entity.taskName}’-编辑" width="1080" height="380" class="oplink" rel="admin_taskedit-${edit.id}">编辑</a>
								</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_TASK_REMOVE')}">
									<a href="app/admin/task.do?action=actionRemoveTaskPlan&taskId=${entity.id}" target="ajaxToDo" title="确定要删除任务‘${entity.taskName}’吗?" width="900" height="500" class="oplink" callback="reload_taskpage()">删除</a>
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