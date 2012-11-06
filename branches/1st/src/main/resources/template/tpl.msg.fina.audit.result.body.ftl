<#--财务申请审批结果  - 正文 -->
<div style="line-height: 25px;">
	<div> ${entity.employee.empName} 于 ${(entity.applyDate)?string("yyyy-MM-dd")} 所申请的 `${entity.applyFormType.processTypeName}` 审批<#if state == 2>通过</#if><#if state== 4>退回</#if><#if state== 3>不通过</#if>.</div> 
	<div>------------------------------------------------------------------</div>
	<div><b>审批人：</b> ${procForm.auditUserNames}</div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/finan/${type}.do?action=diaglogFina<#if type = "contract">Contract<#else>Expense</#if>Page&id=${entity.id}&op=view', 
			'fina_view_${entity.id}',  
			'查看‘${entity.employee.empName}’财务申请单-${procForm.applyFormNo}',
			{width: 1150, height: 640})">点击查看申请单详细</a></div>
</div>