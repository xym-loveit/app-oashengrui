<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">

function initATags(_box) {
    var $p = $(_box || document);

    // navTab
    $("a[target=navTab]", $p).each(function(){
        $(this).click(function(event){
            var $this = $(this);
            var title = $this.attr("title") || $this.text();
            var tabid = $this.attr("rel") || "_blank";
            var fresh = eval($this.attr("fresh") || "true");
            var external = eval($this.attr("external") || "false");
            var url = unescape($this.attr("href")).replaceTmById($(event.target).parents(".unitBox:first"));
            
            // added by Jeccy.Zhao on 2012-05-24
            var show_icon = $this.attr("treeicon") ? ($(this).attr("treeicon") + " icon") : 
                                ($this.parent().parent().attr("treeicon") ? $this.parent().parent().attr("treeicon") + " icon" : ""); 
            
            DWZ.debug(url);
            if (!url.isFinishedTm()) {
                alertMsg.error($this.attr("warn") || DWZ.msg("alertSelectMsg"));
                return false;
            }
            navTab.openTab(tabid, url,{title:title, fresh:fresh, external:external, icon:show_icon});

            event.preventDefault();
        });
    });
    
    //dialogs
    $("a[target=dialog]", $p).each(function(){
        $(this).click(function(event){
            var $this = $(this);
            var title = $this.attr("title") || $this.text();
            var rel = $this.attr("rel") || "_blank";
            var options = {};
            var w = $this.attr("width");
            var h = $this.attr("height");
            if (w) options.width = w;
            if (h) options.height = h;
            options.max = eval($this.attr("max") || "false");
            options.mask = eval($this.attr("mask") || "false");
            options.maxable = eval($this.attr("maxable") || "true");
            options.minable = eval($this.attr("minable") || "true");
            options.fresh = eval($this.attr("fresh") || "true");
            options.resizable = eval($this.attr("resizable") || "true");
            options.drawable = eval($this.attr("drawable") || "true");
            options.close = eval($this.attr("close") || "");
            options.param = $this.attr("param") || "";

            var url = unescape($this.attr("href")).replaceTmById($(event.target).parents(".unitBox:first"));
            DWZ.debug(url);
            if (!url.isFinishedTm()) {
                // added by Jeccy.Zhao on 05/31/2012, aims to double check the variable from current panel
                url = url.replaceTmById($(navTab.getCurrentPanel()));
                if (!url.isFinishedTm()) {
                    alertMsg.error($this.attr("warn") || DWZ.msg("alertSelectMsg"));
                    return false;
                }
            }
            $.pdialog.open(url, rel, title, options);
            
            return false;
        });
    });
    
    // ajax
    $("a[target=ajax]", $p).each(function(){
        $(this).click(function(event){
            var $this = $(this);
            var rel = $this.attr("rel");
            var callback = $this.attr("callback");
            if (rel) {
                // revised by Jeccy.Zhao on 09/08/2012, current panel should be pointed out.
                var $rel = $(navTab.getCurrentPanel()).find("#"+rel);
                // modified by Jeccy.Zhao
                var url = $this.attr("href");
                if ($this.hasClass("uvar")) {
                    url = unescape(url).replaceTmById($(navTab.getCurrentPanel()));
                    if (!url.isFinishedTm()) {
                        alertMsg.error($this.attr("warn") || DWZ.msg("alertSelectMsg"));
                        return false;
                    }
                }
                $rel.loadUrl(url, {}, [function(){
                    $rel.find("[layoutH]").layoutH();
                }, callback]);
            }

            event.preventDefault();
        });
    });
}

$(function(){
	
	//我的任务
	$.post("app/personal/task.do?action=pageTaskIndex&objOut&numPerPage=5",{},function(data){
		$("#idx_tb_task").html(data);
		var size=$('#idx_tb_task tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#idx_tb_task tr').eq(i).find('td').eq(0).html();
	  		var value=$('#idx_tb_task tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/personal/task.do?action=dialogTaskPage&id='+id+'&op=view" title="任务`' + value + '`-查看" target="dialog" rel="dsk_task_' + id + '" width="750" height="530">'+value+'</a>';
			$('#idx_tb_task tr').eq(i).find('td').eq(1).html(result);
	  	}
		
		initATags($("#idx_tb_task"));
	},'text');
	
	//待我审批
	$.post("app/personal/approval.do?action=pageMyApproval&objOut&numPerPage=5",{},function(data){
		$("#idx_tb_approval").html(data);
		var size=$('#idx_tb_approval tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#idx_tb_approval tr').eq(i).find('td').eq(0).html();
	  		var value=$('#idx_tb_approval tr').eq(i).find('td').eq(1).html();
			
			result = '';
			
			type = $($('#idx_tb_approval tr').eq(i)).attr("alt");
			if (type == "news") {
				result='<a href="app/admin.do?action=adminPageEntryDetail&id='+id+'&op=view" target="dialog" width="900" height="500" rel="dsk_approval_news_'+id+'">'+value+'</a>';
			} else if (type == "task") {
				result='<a href="app/admin/task.do?action=dialogTaskPage&id='+id+'&op=audit" target="dialog" width="1080" height="380" rel="dsk_approval_task_'+id+'">'+value+'</a>';
			} else if (type == "fina-expense") {
				result='<a href="app/finan/expense.do?action=diaglogFinaExpensePage&id='+id+'&op=view" target="dialog" width="1150" height="640" rel="dsk_approval_fexp_'+id+'">'+value+'</a>';
			} else if (type == "fina-contract") {
				result='<a href="app/finan/contract.do?action=diaglogFinaContractPage&id='+id+'&op=view" target="dialog" width="1150" height="640" rel="dsk_approval_fctr_'+id+'">'+value+'</a>';
			} else if (type == "hrm") {
				result='<a href="app/personal/application_form.do?action=dialogApplicationFormPage&formId='+id+'&op=view" target="dialog" width="1150" height="640" rel="dsk_approval_hrm_'+id+'">'+value+'</a>';
			} else if (type == "job") {
				result='<a href="app/hrm/hire.do?action=hrmPageJobDetail&id='+id+'&op=audit" target="dialog" width="960" height="420" rel="dsk_approval_job_'+id+'">'+value+'</a>';
			} else if (type == "fina-project") {
				result='<a href="app/finan/project.do?action=diaglogFinaProjectPage&id='+id+'&op=view" target="dialog" width="1150" height="640" rel="dsk_approval_fprj_'+id+'">'+value+'</a>';
			}
			$('#idx_tb_approval tr').eq(i).find('td').eq(1).html(result);
	  	}
		
		initATags($("#idx_tb_approval"));
	},'text');
	
	//我的申请
	$.post("app/personal/application_form.do?action=pageMyApplicationIndex&objOut&numPerPage=5",{},function(data){
		$("#idx_tb_application").html(data);
		var size=$('#idx_tb_application tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#idx_tb_application tr').eq(i).find('td').eq(0).html();
	  		var value=$('#idx_tb_application tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/personal/application_form.do?action=dialogApplicationFormPage&formId='+id+'&op=view" title="查看申请单`'+value+'`" height="640" width="1150" rel="dsk_application_'+id+'" target="dialog">'+value+'</a>';
			$('#idx_tb_application tr').eq(i).find('td').eq(1).html(result);
	  	}
		
		initATags($("#idx_tb_application"));
	},'text');
	
	//我的信息
	$.post("app/message.do?action=pageMessageReceivedIndex&objOut&numPerPage=5",{},function(data){
		$("#idx_tb_message").html(data);
		var size=$('#idx_tb_message tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#idx_tb_message tr').eq(i).find('td').eq(0).html();
	  		var mId=$('#idx_tb_message tr').eq(i).find('td').eq(1).html();
	  		var value=$('#idx_tb_message tr').eq(i).find('td').eq(2).html();
	  		result='<a href="app/message.do?action=dialogMessagePage&msgId='+mId+'&msgInId='+id+'" title="查看消息" height="380" width="640" target="dialog" rel="dsk_msg_'+id+'">'+value+'</a>';
			$('#idx_tb_message tr').eq(i).find('td').eq(2).html(result);
	  	}
		
		initATags($("#idx_tb_message"));
	},'text');
	
	//我的会议
	$.post("app/personal/conference.do?action=myConferenceIndex&objOut&numPerPage=5",{},function(data){
		$("#idx_tb_conference").html(data);
		var size=$('#idx_tb_conference tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#idx_tb_conference tr').eq(i).find('td').eq(0).html();
	  		var value=$('#idx_tb_conference tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/personal/conference.do?action=conferenceDetail&id='+id+'&op=view" height="450" width="1150" title="查看会议`'+value+'`" target="dialog" rel="dsk_confer_'+id+'">'+value+'</a>';
			$('#idx_tb_conference tr').eq(i).find('td').eq(1).html(result);
	  	}
		
		initATags($("#idx_tb_conference"));
	},'text');
	
	
	//我的新闻
	$.post("app/personal/news.do?action=pageMyNews&objOut&numPerPage=5",{},function(data){
		$("#idx_tb_news").html(data);
		var size=$('#idx_tb_news tr').size();
	  	for(i=0;i<size;i++){
	  		var value=$('#idx_tb_news tr').eq(i).find('td').eq(2).html();
	  		var id=$('#idx_tb_news tr').eq(i).find('td').eq(0).html();
	  		result='<a href="app/admin/news.do?action=actionNewsScan&id='+id+'" height="500" width="900" title="查看新闻`'+value+'`" target="dialog" rel="dsk_news_'+id+'">'+value+'</a>';
			$('#idx_tb_news tr').eq(i).find('td').eq(2).html(result);
	  	}
		
		initATags($("#idx_tb_news"));
	},'text');
	
	
	//我的文档
	$.post("app/personal/doc.do?action=pageMyDoc&objOut&numPerPage=5",{},function(data){
		$("#idx_tb_doc").html(data)
		var size=$('#idx_tb_doc tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#idx_tb_doc tr').eq(i).find('td').eq(0).html();
	  		var doc_path = $('#idx_tb_doc tr').eq(i).find('td').eq(1).attr("alt");
			var doc_name = $('#idx_tb_doc tr').eq(i).find('td').eq(1).html();
			var doc_type = $('#idx_tb_doc tr').eq(i).find('td').eq(2).html();
			// value=$('#idx_tb_doc tr').eq(i).find('td').eq(1).html();
	  		var result='<a href="file-download?path=' + doc_path + '" target="_blank" height="380" width="850" title="文档`'+doc_name+'`下载" rel="dsk_doc_'+id+'">'+doc_name+'</a>';
			$('#idx_tb_doc tr').eq(i).find('td').eq(1).html(result);
	  	}
		
		initATags($("#idx_tb_doc"));
	},'text');
	
	$.post("app/personal/jobapplication.do?action=pageJobOnHiring&objOut&numPerPage=5",{},function(data){
		$("#idx_tb_jobs").html(data)
		var size=$('#idx_tb_jobs tr').size();
	  	for(i=0;i<size;i++){
	  		var id=$('#idx_tb_jobs tr').eq(i).find('td').eq(0).html();
	  		var value=$('#idx_tb_jobs tr').eq(i).find('td').eq(1).html();
	  		result='<a href="app/hrm/hire.do?action=hrmPageJobResume&jobId='+id+'&source=1" target="dialog" height="460" width="830" title="我要应聘`'+value+'`" rel="dsk_application_'+id+'">'+value+'</a>';
			$('#idx_tb_jobs tr').eq(i).find('td').eq(1).html(result);
	  	}
		
		initATags($("#idx_tb_jobs"));
	},'text');
	
});
//-->
</script>
<div class="pageContent" layoutH="42" style="padding:5px" width="100%">
	<!--<div class="sortDrag x-panel x-panel-right" width="100">-->
	<div class="x-panel x-panel-left " width="45%">
		<div class="panel" minH="60">
			<h1><span class="icon-mymsg icon">个人消息<label style="float:right;margin-top:9px;"><a title="我的短消息" rel="nav_msg" href="app/message.do?action=pageMessageReceivedIndex" target="navTab">更多>></a></label></span></h1>
	        <div>
	          <table class="table" width="100%" id="idx_msg">
		       <thead>
			    <tr>
			      <th style="display: none;"></th>
			      <th style="display: none;"></th>
				 <th align="center">发送标题</th>
				 <th align="center">发送人</th>
				 <th align="center">发送时间</th>
			   </tr>
		     </thead>
		     <tbody id="idx_tb_message"></tbody>
		    </table>
		    </div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-myconference icon">我的会议<label style="float:right;margin-top:9px;"><a title="我的会议" rel="_menu_mod_personal_conference" href="app/personal/conference.do?action=myConferenceIndex" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%" id="idx_conference">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">会议名称</th>
				<th align="center">开始时间</th>
				<th align="center">状态</th>
			</tr>
		</thead>
		<tbody id="idx_tb_conference">
		</tbody>
		</table>
			</div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-mynews icon">我的新闻<label style="float:right;margin-top:9px;"><a title="我的新闻" rel="_menu_mod_personal_news" href="app/personal/news.do?action=pageMyNews" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%" id="idx_news">
		<thead>
			<tr>
				<th style="display: none;"></th>
				<th align="center">新闻类型</th>
				<th align="center">新闻标题</th>
				<th align="center">发布时间</th>
			</tr>
		</thead>
		<tbody id="idx_tb_news"></tbody>
		</table>
			</div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-hrjobreg icon">我要应聘<label style="float:right;margin-top:9px;"><a title="我要应聘" rel="_menu_mod_personal_jobreg" href="app/personal/jobapplication.do?action=pageJobOnHiring" target="navTab">更多>></a></label></span></h1>
			<div>
				<table class="table" width="100%" id="idx_jobs">
					<thead>
						<tr>
							<th style="display: none;"></th>
							<th align="center">岗位名称</th>
							<th align="center">招聘校区</th>
							<th align="center">截止时间</th>
						</tr>
					</thead>
					<tbody id="idx_tb_jobs">
					</tbody>
				</table>
			</div>
		</div>
		
	</div>
	
	<div class="x-panel x-panel-right">
		
		<div class="panel" minH="60">
			<h1><span class="icon-myapproval icon">待我审批<label style="float:right;margin-top:9px;"><a title="待我审批" rel="_menu_mod_personal_approval" href="app/personal/approval.do?action=pageMyApproval" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%" id="idx_approval">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">申请内容描述</th>
				<th align="center">申请人姓名</th>
				<th align="center">申请时间</th>
			</tr>
		</thead>
		<tbody id="idx_tb_approval">
		</tbody>
		</table>
			</div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-myplan icon">我的任务<label style="float:right;margin-top:9px;"><a title="我的任务" rel="_menu_mod_personal_mytask" href="app/personal/task.do?action=pageTaskIndex" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%" id="idx_mytask">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">任务名称</th>
				<th align="center">任务状态</th>
				<th align="center">发起人</th>
			</tr>
		</thead>
		<tbody id="idx_tb_task">
			</tbody>
		</table>
		</div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-myapply icon">我的申请<label style="float:right;margin-top:9px;"><a title="我的申请" rel="_menu_mod_personal_apply" href="app/personal/application_form.do?action=pageMyApplicationIndex" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%" id="idx_myapply">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">申请类型</th>
				<th align="center">申请人</th>
				<th align="center">审批状态</th>
			</tr>
		</thead>
		<tbody id="idx_tb_application">
		</tbody>
		</table>
			</div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-infodoc icon">我的文档<label style="float:right;margin-top:9px;"><a title="文档下载区" rel="_menu_mod_personal_doc" href="app/personal/doc.do?action=pageMyDoc" target="navTab">更多>></a></label></span></h1>
			<div>
			<table class="table" width="100%" id="idx_infodoc">
		<thead>
			<tr>
			    <th style="display: none;"></th>
				<th align="center">文档名称</th>
				<th align="center">文档类型</th>
				<th align="center">文档时间</th>
			</tr>
		</thead>
		<tbody id="idx_tb_doc"></tbody>
		</table>
			</div>
		</div>
		
	</div>
	
</div>


	

