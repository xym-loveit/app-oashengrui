<#--任务完成申请/延期申请审批不通过 - 正文 -->

<div style="line-height: 25px;">
	<div>任务 “${entity.task.taskName}” 所提交<#if entity.taskApplyType = 1>完成<#else>延期</#if>申请，审批不通过.</div> 
	<div>------------------------------------------------------------------</div>
	<div><b>任务负责人：</b> ${entity.task.taskCharger.empName}</div>
	<div><b>任务时间：</b> ${(entity.task.taskPlannedStartDate)?string("yyyy-MM-dd")} --- ${(entity.task.taskPlannedEndDate)?string("yyyy-MM-dd")} </div>
	<div><b>申请<#if entity.taskApplyType = 1>完成<#else>延期</#if>时间：</b> ${entity.taskApplyFinalizedDate?string("yyyy-MM-dd")} </div>
	<div><b>审批人：</b> ${entity.taskAuditor.empName} </div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/personal/task.do?action=dialogAuditRecords&taskId=${entity.task.id}', 
			'task_applyview_${entity.task.id}',  
			'`${entity.task.taskName}`任务详情',
			{width: 900, height: 300})">点击进入到任务<#if entity.taskApplyType = 1>完成<#else>延期</#if>审批审批窗口</a></div>
</div>