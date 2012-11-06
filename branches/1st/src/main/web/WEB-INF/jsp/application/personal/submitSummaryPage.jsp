<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
	.item_file {
		background: url("resources/images/icons/fit_icon.png") no-repeat scroll 0 0 transparent;
		padding-left: 16px;
		line-height: 16px;
		margin-top:5px;
	}
	.item_file a {
		color: blue;
		text-decoration: underline;
	}
	#tbljob input.textInput {width: 90%; margin: 5px;}
	#tbljob td.field {
		background-color: #CFDBEC;
		font-size: 9pt;
		line-height: 35px;
		margin: 0;
		text-align: center;
		width: 120px;
	}
	#tbljob textarea {height: 30px;margin: 5px;width: 98%;}
</style>

<script>
	
	$(function(){
		$("#btnapproval").unbind("click");
		$("#btnapproval").bind("click", function() { 
			$("#formAction").val("1");
			$("#formjob").submit();
		});
		
		$("#btnback").unbind("click");
		$("#btnback").bind("click", function() { 
			$("#formAction").val("0");
			$("#formjob").submit();
		});
		
		<c:if test="${op eq null || op ne 'view'}">
		//加载上传组件入口文件
		KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
			var ru = new RenderUploader('#jp_J_UploaderBtn', '#jp_J_UploaderQueue',{
				 //服务器端配置
				serverConfig:{
					//处理上传的服务器端脚本路径
					action:"file-upload",
					data:{file_type:"conference_summary"}
				},
				// 文件域
				name:"Filedata",
				//用于放服务器端返回的url的隐藏域
				urlsInputName:"fileUrls"
				<c:if test="${conference ne null && fn:length(conference.attachFiles) gt 0}">
				// 用于数据展现
				,restoreHook:"#jp_J_UploaderRestore"
				</c:if>
			});
			
			ru.on('init', function (ev) {
				//上传组件实例
				var uploader = ev.uploader;
				//上传按钮实例
				var button = uploader.get('button');
				
				uploader.on('success', function (ev) {
					var feedback = ev.result;
					var file_id = feedback.data.id;
					if (file_id) {
						$("#fileIds").val($("#fileIds").val() == "" ? file_id : ($("#fileIds").val() + "," + file_id));
					}
				});
				
				uploader.on('error', function (ev) {
					alert("文件上传失败:" + ev.result.message);
				});
				
			});
		});
		</c:if>
	});
	
</script>

<div class="pageContent">
	<form method="post" action="app/personal/conference.do?action=actionSubmitSummary" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent">
			<table cellspacing="10" cellpadding="10" style="border-spacing:15; border-collapse:collapse;" border="1" id="tbljob">
				<tr>
					<td class="field" style="vertical-align: top;">会议记录：</td>
					<td style="padding: 5px;">
						<div>
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<!-- 上传按钮，组件配置请写在data-config内 -->
									<a id="jp_J_UploaderBtn" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件 </a>
									<!-- 文件上传队列 -->
									<ul id="jp_J_UploaderQueue"></ul>
									<div id="J_Panel" class="event-panel"></div>
									<input type="hidden" name="fileUrls" id="fileUrls" />
									<input type="hidden" name="fileIds" id="fileIds" />
								</c:when>
							</c:choose>
						</div>
						<!--<a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="上传附件">上传附件</a>-->
					</td>
				</tr>
				<tr>
					<td class="field" style="vertical-align: top;">会议总结：</td>
					<td><textarea name="summary" rows="3"></textarea></td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交总结</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${conference ne null ? conference.id : '-1'}" />
	</form>
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:15; border-collapse:collapse;" border="1" id="tbljob">
				<tr>
					<td nowrap class="field">会议名称：</td>
					<td><input name="conferenceName" type="text" class="required" value="${conference ne null ? conference.conferenceName : ''}" readonly/></td>
					<td nowrap class="field">会议类型：</td>
					<td style="padding: 5px;">
						<input type="text"  value="${conference.type.name }" readonly />
					</td>
					<td nowrap class="field">会议地址：</td>
					<td style="width: 120px; padding: 5px;"><input name="address" class="textInput required" value="${conference ne null ? conference.address : '' }" readonly/></td>
				</tr>
				<tr>
					<td class="field">参会人员：</td>
					<td colspan="5"><input name="attendances" type="text"  class="required" value="${conference ne null ? conference.attendances : ''}" readonly/></td>
				</tr>
				<tr>
					<td class="field" style="vertical-align: top;">会议内容：</td>
					<td colspan="5"><textarea name="content" rows="3" readonly>${conference ne null ? conference.content : ''}</textarea></td>
				</tr>
				</table>
		</div>
</div>