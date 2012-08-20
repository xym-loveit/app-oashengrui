${entity.taskOriginator.empName}发起任务 “${entity.taskName}” 已审批通过. 
-------------------------------------

任务负责人：	${entity.taskCharger.empName}

任务时间：	${(entity.taskPlannedStartDate)?string("yyyy-MM-dd")}-${(entity.taskPlannedEndDate)?string("yyyy-MM-dd")} 

任务参与人：	${entity.taskParticipantNames!""} 

审批人：		${entity.auditor.empName} 

详情点击：	<a href="${entity.id}" target="dialog" title="`${entity.taskName}`任务详情" rel="task_view_${entity.id}">点击进入到任务查看界面</a>