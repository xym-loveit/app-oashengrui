<#--任务审批退回 - 正文 -->

<div style="line-height: 25px;">
	<div>${entity.taskOriginator.empName}发起任务 “${entity.taskName}” 审批被退回.</div> 
	<div>------------------------------------------------------------------</div>
	<div><b>任务负责人：</b> ${entity.taskCharger.empName}</div>
	<div><b>任务时间：</b> ${(entity.taskPlannedStartDate)?string("yyyy-MM-dd")}-${(entity.taskPlannedEndDate)?string("yyyy-MM-dd")} </div>
	<div><b>任务参与人：</b> ${entity.taskParticipantNames!""} </div>
	<div><b>审批人：</b> ${entity.auditor.empName} </div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/admin/task.do?action=dialogTaskPage&id=${entity.id}&op=view', 
			'task_view_${entity.id}',  
			'`${entity.taskName}`任务详情',
			{width: 750, height: 530})">点击进入到任务查看界面</a></div>
</div>