<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function(){
	//我的任务
	$.post("app/personal/task.do?action=pageTaskIndex1",{},function(data){
		$("#task").html(data);
		var size=$('#task tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#task tr').eq(i).find('td').eq(0).html();
	  		var value=$('#task tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/personal/task.do?action=dialogTaskPage&id='+id+'&op=view" title="任务`' + value + '`-查看" target="dialog" rel="dsk_task_' + id + '" width="750" height="530">'+value+'</a>';
			$('#task tr').eq(i).find('td').eq(1).html(result);
	  	}
		//initATags($("#task"));
	},'text');
	
	//待我审批
	$.post("app/personal/approval.do?action=pageMyApproval1",{},function(data){
		$("#approval").html(data);
		var size=$('#approval tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#approval tr').eq(i).find('td').eq(0).html();
	  		var value=$('#approval tr').eq(i).find('td').eq(1).html();
			
			result = '';
			
			type = $($('#approval tr').eq(i)).attr("alt");
			if (type == "news") {
				result='<a href="app/admin.do?action=adminPageEntryDetail&id='+id+'&op=view" target="dialog" width="900" height="500" rel="dsk_approval_news_'+id+'">'+value+'</a>';
			} else if (type == "task") {
				result='<a href="app/admin/task.do?action=dialogTaskPage&id='+id+'&op=audit" target="dialog" width="1080" height="380" rel="dsk_approval_task_'+id+'">'+value+'</a>';
			} else if (type == "fina-expense") {
				result='<a href="app/finan/expense.do?action=diaglogFinaExpensePage&id='+id+'&op=view" target="dialog" width="1150" height="640" rel="dsk_approval_fexp_'+id+'">'+value+'</a>';
			} else if (type == "fina-contract") {
				result='<a href="app/finan/contract.do?action=diaglogFinaContractPage&id='+id+'&op=view" target="dialog" width="1150" height="640" rel="dsk_approval_fctr_'+id+'">'+value+'</a>';
			} else if (type == "hrm") {
				result='<a href="app/personal/application_form.do?action=dialogApplicationFormPage&formId='+id+'&op=view" target="dialog" width="900" height="500" rel="dsk_approval_hrm_'+id+'">'+value+'</a>';
			} else if (type == "job") {
				result='<a href="app/hrm/hire.do?action=hrmPageJobDetail&id='+id+'&op=audit" target="dialog" width="960" height="420" rel="dsk_approval_job_'+id+'">'+value+'</a>';
			}
			$('#approval tr').eq(i).find('td').eq(1).html(result);
	  	}
	},'text');
	
	//我的申请
	$.post("app/personal/application_form.do?action=pageMyApplicationIndex1",{},function(data){
		$("#application").html(data);
		var size=$('#application tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#application tr').eq(i).find('td').eq(0).html();
	  		var value=$('#application tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/personal/application_form.do?action=dialogApplicationFormPage&formId='+id+'&op=view" title="查看申请单`'+value+'`" height="640" width="1150" rel="dsk_application_'+id+'" target="dialog">'+value+'</a>';
	  	$('#application tr').eq(i).find('td').eq(1).html(result);
	  	}
	},'text');
	
	//我的信息
	$.post("app/message.do?action=pageMessageReceivedIndex1",{},function(data){
		$("#message").html(data);
		var size=$('#message tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#message tr').eq(i).find('td').eq(0).html();
	  		var mId=$('#message tr').eq(i).find('td').eq(1).html();
	  		var value=$('#message tr').eq(i).find('td').eq(2).html();
	  		result='<a href="app/message.do?action=dialogMessagePage&msgId='+mId+'&msgInId='+id+'" title="查看消息" height="380" width="640" target="dialog" rel="dsk_msg_'+id+'">'+value+'</a>';
	  	$('#message tr').eq(i).find('td').eq(2).html(result);
	  	}
	},'text')
	
	//我的会议
	$.post("app/personal/conference.do?action=myConferenceIndex1",{},function(data){
		$("#conference").html(data);
		var size=$('#conference tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#conference tr').eq(i).find('td').eq(0).html();
	  		var value=$('#conference tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/personal/conference.do?action=conferenceDetail&id='+id+'&op=view" height="450" width="1150" title="查看会议`'+value+'`" target="dialog" rel="dsk_confer_'+id+'">'+value+'</a>';
	  	$('#conference tr').eq(i).find('td').eq(1).html(result);
	  	}
	},'text')
	
	//我的新闻
	$.post("app/admin/news.do?action=adminPageEntryIndex1",{},function(data){
		$("#news").html(data);
		var size=$('#news tr').size();
	  	for(i=0;i<size;i++){
	  		var value=$('#news tr').eq(i).find('td').eq(2).html();
	  		var id=$('#news tr').eq(i).find('td').eq(0).html();
	  		result='<a href="app/admin/news.do?action=actionNewsScan&id='+id+'" height="650" width="900" title="查看新闻`'+value+'`" target="dialog" rel="dsk_news_'+id+'">'+value+'</a>';
	  	$('#news tr').eq(i).find('td').eq(2).html(result);
	  	}
	},'text')
	
	//我的文档
	$.post("app/admin/doc.do?action=adminPageDocumentIndex1",{},function(data){
		$("#doc").html(data)
		var size=$('#doc tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#doc tr').eq(i).find('td').eq(0).html();
	  		var value=$('#doc tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/admin/doc.do?action=adminPageDocumentEditDetail&id='+id+'" target="dialog" height="380" width="850" title="文档`'+value+'`-编辑" rel="dsk_doc_'+id+'">'+value+'</a>';
	  	$('#doc tr').eq(i).find('td').eq(1).html(result);
	  	}
	},'text')
});
//-->
</script>
<div class="pageContent" layoutH="42" style="padding:5px" width="100%">
	<!--<div class="sortDrag x-panel x-panel-right" width="100">-->
	<div class="x-panel x-panel-left " width="45%">
		<div class="panel" minH="60">
			<h1><span class="icon-mymsg icon">个人消息<label style="float:right;margin-top:9px;"><a href="app/message.do?action=pageMessageReceivedIndex" target="navTab">更多>></a></label></span></h1>
	        <div>
	          <table class="table" width="100%">
		       <thead>
			    <tr>
			      <th style="display: none;"></th>
			      <th style="display: none;"></th>
				 <th align="center">发送标题</th>
				 <th align="center">发送人</th>
				 <th align="center">发送时间</th>
			   </tr>
		     </thead>
		     <tbody id="message"></tbody>
		    </table>
		    </div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-myconference icon">我的会议<label style="float:right;margin-top:9px;"><a href="app/personal/conference.do?action=myConferenceIndex" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">会议名称</th>
				<th align="center">开始时间</th>
				<th align="center">状态</th>
			</tr>
		</thead>
		<tbody id="conference">
		</tbody>
		</table>
			</div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-mynews icon">我的新闻<label style="float:right;margin-top:9px;"><a href="app/personal/news.do?action=pageMyNews" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%">
		<thead>
			<tr>
				<th style="display: none;"></th>
				<th align="center">新闻类型</th>
				<th align="center">新闻标题</th>
				<th align="center">发布时间</th>
			</tr>
		</thead>
		<tbody id="news"></tbody>
		</table>
			</div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-infodoc icon">我的文档<label style="float:right;margin-top:9px;"><a href="app/personal/doc.do?action=pageMyDoc" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">文档类型</th>
				<th align="center">文档时间</th>
			</tr>
		</thead>
		<tbody id="doc"></tbody>
		</table>
			</div>
		</div>
	</div>
	
	<div class="x-panel x-panel-right">
		
		<div class="panel" minH="60">
			<h1><span class="icon-myapproval icon">待我审批<label style="float:right;margin-top:9px;"><a href="app/personal/approval.do?action=pageMyApproval" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">申请内容描述</th>
				<th align="center">申请人姓名</th>
				<th align="center">申请时间</th>
			</tr>
		</thead>
		<tbody id="approval">
		</tbody>
		</table>
			</div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-myplan icon">我的任务<label style="float:right;margin-top:9px;"><a href="app/personal/task.do?action=pageTaskIndex" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">任务名称</th>
				<th align="center">任务状态</th>
				<th align="center">发起人</th>
			</tr>
		</thead>
		<tbody id="task">
			</tbody>
		</table>
		</div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-myapply icon">我的申请<label style="float:right;margin-top:9px;"><a href="app/personal/application_form.do?action=pageMyApplicationIndex" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">申请类型</th>
				<th align="center">申请人</th>
				<th align="center">审批状态</th>
			</tr>
		</thead>
		<tbody id="application">
		</tbody>
		</table>
			</div>
		</div>
		
	</div>
	
</div>


	

