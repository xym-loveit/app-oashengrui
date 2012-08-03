<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function(){
	$.post("app/personal/task.do?action=pageTaskIndex1",{},function(data){
		$("#task").html(data);
		var size=$('#task tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#task tr').eq(i).find('td').eq(0).html();
	  		var value=$('#task tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/personal/task.do?action=dialogTaskPage&id='+id+'" target="dialog">'+value+'</a>';
	  	$('#task tr').eq(i).find('td').eq(1).html(result);
	  	}
	},'text');
	$.post("app/personal/approval.do?action=pageMyApproval1",{},function(data){
		$("#approval").html(data);
		var size=$('#approval tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#approval tr').eq(i).find('td').eq(0).html();
	  		var value=$('#approval tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/admin/task.do?action=dialogTaskPage&id='+id+'&op=audit" target="dialog">'+value+'</a>';
	  	$('#approval tr').eq(i).find('td').eq(1).html(result);
	  	}
	},'text');
	$.post("app/personal/application_form.do?action=pageMyApplicationIndex1",{},function(data){
		$("#application").html(data);
		var size=$('#application tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#application tr').eq(i).find('td').eq(0).html();
	  		var value=$('#application tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/personal/application_form.do?action=dialogApplicationFormPage&formId='+id+'" target="dialog">'+value+'</a>';
	  	$('#application tr').eq(i).find('td').eq(1).html(result);
	  	}
	},'text');
	$.post("app/message.do?action=pageMessageReceivedIndex1",{},function(data){
		$("#message").html(data);
		var size=$('#message tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#message tr').eq(i).find('td').eq(0).html();
	  		var mId=$('#message tr').eq(i).find('td').eq(1).html();
	  		var value=$('#message tr').eq(i).find('td').eq(2).html();
	  		result='<a href="app/message.do?action=dialogMessagePage&msgId='+mId+'&msgInId='+id+'" target="dialog">'+value+'</a>';
	  	$('#message tr').eq(i).find('td').eq(2).html(result);
	  	}
	},'text')
	$.post("app/personal/conference.do?action=myConferenceIndex1",{},function(data){
		$("#conference").html(data);
		var size=$('#conference tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#conference tr').eq(i).find('td').eq(0).html();
	  		var value=$('#conference tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/personal/conference.do?action=conferenceDetail&id='+id+'" target="dialog">'+value+'</a>';
	  	$('#conference tr').eq(i).find('td').eq(1).html(result);
	  	}
	},'text')
	$.post("app/admin/news.do?action=adminPageEntryIndex1",{},function(data){
		$("#news").html(data);
		var size=$('#news tr').size();
	  	for(i=0;i<size;i++){
	  		var value=$('#news tr').eq(i).find('td').eq(2).html();
	  		var id=$('#news tr').eq(i).find('td').eq(0).html();
	  		result='<a href="app/admin/news.do?action=actionNewsScan&id='+id+'" target="dialog">'+value+'</a>';
	  	$('#news tr').eq(i).find('td').eq(2).html(result);
	  	}
	},'text')
	$.post("app/admin/doc.do?action=adminPageDocumentIndex1",{},function(data){
		$("#doc").html(data)
		var size=$('#doc tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#doc tr').eq(i).find('td').eq(0).html();
	  		var value=$('#doc tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/admin/doc.do?action=adminPageDocumentEditDetail&id='+id+'" target="dialog">'+value+'</a>';
	  	$('#doc tr').eq(i).find('td').eq(1).html(result);
	  	}
	},'text')
});
//-->
</script>
<div class="pageContent" layoutH="42" style="padding:5px" width="100%">
	<!--<div class="sortDrag x-panel x-panel-right" width="100">-->
	<div class="x-panel x-panel-left" width="45%">
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


	

