<#--新闻发布审批通过 - 正文 -->
<div style="line-height: 25px;">
	<div> ${entity.authorName} 提交的新闻 `${entity.newsSubject}` 审批<#if entity.status == 2>通过<#else>被退回</#if> </div>
	<div>------------------------------------------------------------------</div>
	<div><b>审批人：</b> ${entity.auditor.empName}</div>
	<div><b>审批时间：</b> ${(entity.auditTime)?string("yyyy-MM-dd hh:mm:ss")}</div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/admin.do?action=adminPageEntryDetail&id=${entity.id }&op=view', 
			'news_view_${entity.id}',  
			'查看‘${entity.newsSubject}’新闻内容',
			{width: 900, height: 500})">点击查看新闻详细</a></div>
</div>