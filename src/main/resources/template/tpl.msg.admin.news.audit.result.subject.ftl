<#--新闻发布审批通过 - 标题 -->
[我的新闻] ${entity.authorName} 提交的新闻 `${entity.newsSubject}` 审批<#if entity.status == 2>通过<#else>被退回</#if>, 审批人: ${entity.auditor.empName}