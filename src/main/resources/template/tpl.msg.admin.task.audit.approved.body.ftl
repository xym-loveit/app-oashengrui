<script>
	function openNavTab(tabid, url, title) {
		parent.navTab.openTab(tabid, url, {title:title})
	}
</script>

<div style="line-height: 25px;">
	<div>${entity.taskOriginator.empName}发起任务 “${entity.taskName}” 已审批通过.</div> 
	<div>------------------------------------------------------------------</div>
	<div><b>任务负责人：</b> ${entity.taskCharger.empName}</div>
	<div><b>任务时间：</b> ${(entity.taskPlannedStartDate)?string("yyyy-MM-dd")}-${(entity.taskPlannedEndDate)?string("yyyy-MM-dd")} </div>
	<div><b>任务参与人：</b> ${entity.taskParticipantNames!""} </div>
	<div><b>审批人：</b> ${entity.auditor.empName} </div>
	<div><b>详情点击：</b><a href="javascript:void(0);" onclick="openNavTab( 'task_view_${entity.id}', 'app/admin/task.do?action=dialogTaskPage&id=${entity.id}&op=view', '`${entity.taskName}`任务详情')">点击进入到任务查看界面</a></div>
</div>