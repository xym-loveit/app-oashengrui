<#--待我审批(新闻发布审批) - 正文 -->
<div style="line-height: 25px;">
	<div> ${entity.authorName} 提交的新闻 `${entity.newsSubject}` 有待审批 </div>
	<div>------------------------------------------------------------------</div>
	<div><b>申请时间：</b> ${(entity.createtime)?string("yyyy-MM-dd hh:mm:ss")}</div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/admin.do?action=adminPageEntryDetail&id=${entity.id }&op=view', 
			'news_view_${entity.id}',  
			'查看‘${entity.newsSubject}’新闻内容',
			{width: 900, height: 500})">点击查看新闻详细</a></div>
</div>