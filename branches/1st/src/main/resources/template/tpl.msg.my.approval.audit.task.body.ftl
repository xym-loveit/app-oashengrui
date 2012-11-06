<#--待我审批(任务委托审批) - 正文 -->
<div style="line-height: 25px;">
	<div> ${entity.taskOriginator.empName} 发起的任务委托 `${entity.taskName}` 有待审批 </div>
	<div>------------------------------------------------------------------</div>
	<div><b>任务时间：</b> ${(entity.taskPlannedStartDate)?string("yyyy-MM-dd")} --- ${(entity.taskPlannedEndDate)?string("yyyy-MM-dd")}</div>
	<div><b>任务描述：</b> ${entity.taskDescription}</div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/admin/task.do?action=dialogTaskPage&id=${entity.id}&op=audit', 
			'task_view_${entity.id}',  
			'查看‘${entity.taskName}’任务委托内容',
			{width: 1080, height: 380})">点击查看任务委托详细</a></div>
</div>