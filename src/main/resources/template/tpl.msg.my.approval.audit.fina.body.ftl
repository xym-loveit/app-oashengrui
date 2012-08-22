<#--待我审批(费用支出/合同申请) - 正文 -->
<div style="line-height: 25px;">
	<div> ${entity.employee.empName} 提交的 `${entity.applyFormType.processTypeName}` 有待审批 </div>
	<div>------------------------------------------------------------------</div>
	<div><b>申请内容描述：</b> ${entity.comments}</div>
	<div><b>申请时间：</b> ${(entity.applyDate)?string("yyyy-MM-dd")}</div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/finan/${type}.do?action=diaglogFina<#if type = "contract">Contract<#else>Expense</#if>Page&id=${entity.id}&op=view', 
			'approval_finan_${entity.id}',  
			'查看‘${entity.employee.empName}’ <#if type = "contract">合同<#else>费用支出</#if>申请单-${entity.formNo}',
			{width: 1150, height: 640})">点击查看申请单详细</a></div>
</div>