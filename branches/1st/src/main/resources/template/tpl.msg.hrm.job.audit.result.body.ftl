<#--招聘管理(岗位发布审批) - 正文 -->
<div style="line-height: 25px;">
	<div> ${entity.postAuthorName} 发布的招聘岗位 `${entity.jobHireTitle}` 审批<#if entity.status == 4>通过<#else>被退回</#if> </div>
	<div>------------------------------------------------------------------</div>
	<div><b>审批人：</b> ${entity.auditor}</div>
	<div><b>审批时间：</b> ${(entity.auditDate)?string("yyyy-MM-dd hh:mm:ss")}</div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/hrm/hire.do?action=hrmPageJobDetail&id=${entity.id}&op=edit', 
			'job_view_${entity.id}',  
			'查看‘${entity.jobHireTitle}’岗位',
			{width: 960, height: 420})">点击查看岗位详细</a></div>
</div>