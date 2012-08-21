<#--我的申请被审批 - 正文 -->
<div style="line-height: 25px;">
	<div> ${entity.employee.empName} 于 ${(entity.applyDate)?string("yyyy-MM-dd")} 所申请的 `${entity.applyFormType.processTypeName}` 审批<#if state == 2>通过</#if><#if state== 4>退回</#if><#if state== 3>不通过</#if>.</div> 
	<div>------------------------------------------------------------------</div>
	<div><b>审批人：</b> ${procForm.auditUserNames}</div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/personal/application_form.do?action=dialogApplicationFormPage&formId=${formId}&op=view', 
			'myapplication_${formId}',  
			'查看‘${entity.employee.empName}’人资申请单-${procForm.applyFormNo}',
			{width: 1150, height: 640})">点击查看申请单详细</a></div>
</div>