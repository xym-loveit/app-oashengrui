<#--待我审批(岗位发布) - 正文 -->
<div style="line-height: 25px;">
	<div> ${entity.postAuthorName} 发布的招聘岗位 `${entity.jobHireTitle}` 有待审批 </div>
	<div>------------------------------------------------------------------</div>
	<div><b>岗位工作地点：</b> ${entity.jobHireAddress}</div>
	<div><b>岗位发布时间：</b> ${(entity.postDate)?string("yyyy-MM-dd")}</div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/hrm/hire.do?action=hrmPageJobDetail&id=${entity.id}', 
			'job_view_${entity.id}',  
			'查看‘${entity.jobHireTitle}’岗位',
			{width: 960, height: 420})">点击查看岗位详细</a></div>
</div>