<#--面试安排 - 正文 -->
<div style="line-height: 25px;">
	<div> ${entity.jobHireIssue.resume.fullName} 应聘 `${entity.jobHireIssue.jobHire.jobHireTitle}`岗位, 进入面试环节, 请注意面试安排.</div> 
	<div>------------------------------------------------------------------</div>
	<div><b>面试时间：</b> ${(entity.interviewDate)?string("yyyy-MM-dd HH:mm:ss")}</div>
	<div><b>面试地址：</b> ${entity.interviewAddress}</div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/personal/interview.do?action=dialogInterviewCommentPage&id=${entity.id}&issueId=${entity.jobHireIssue.id}', 
			'interview_view_${entity.id}',  
			'`${entity.jobHireIssue.resume.fullName} - ${entity.jobHireIssue.jobHire.jobHireTitle}`面试意见',
			{width: 555, height: 445})">点击进入我的伯乐</a></div>
</div>