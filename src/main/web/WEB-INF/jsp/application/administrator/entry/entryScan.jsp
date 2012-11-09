<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
	.head p {text-align:center; height:20px;margin-top:10px;}
	.color {color:blue;}
	.news {text-align:center;}
	.newsDetail .newsContent p{margin-top:40px;}
	.newsDetail .newsContent{margin:auto;}
</style>

<script>
$(function(){
//加载上传组件入口文件
KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
	var ru = new RenderUploader('#j_J_UploaderBtnNews', '#j_J_UploaderQueueNews',{
		 //服务器端配置
		serverConfig:{
			//处理上传的服务器端脚本路径
			action:"file-upload",
			data: {
				"test" : "a"
			}
		},
		// 文件域
		name:"Filedata",
		//用于放服务器端返回的url的隐藏域
		urlsInputName:"fileUrls"
		<c:if test="${newsScanInfo ne null && fn:length(newsScanInfo.attachFiles) gt 0}">
		// 用于数据展现
		,restoreHook:"#jp_J_UploaderRestoreNews"
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
});
</script>

<!--- 生成需要展现文件的JSON -->
<c:if test="${(op eq null || op ne 'view') && (news ne null && fn:length(news.attachFiles) gt 0)}">
<script type="text/uploader-restore" id="jp_J_UploaderRestoreNews">
${tm:fileRestore(newsScanInfo['attachFiles'])}
</script>
</c:if>

<body>
	<div class="buttonActive">
		<div class="buttonContent">
			<button class="close" value="关闭">返回</button>
		</div>
	</div>
	<div class="head">
		<p><b style="font-size: 16px;">${newsScanInfo.newsSubject}</b></p>
	</div>
	<hr style="margin-top:10px;"></hr>
	<div class="newsinfo">
		<table class="news" width="%100" style="margin:auto">
			<tr>
				<td>
					<label><span class="color">新闻类型：</span> ${newsScanInfo.dictionary.name}</label>
				</td>
				<td width="30"></td>
				<td>
					<label><span class="color">发布校区：</span> ${newsScanInfo.district.districtName }</label>
				</td>
				<td width="30"></td>
				<td>
					<label><span class="color">发布部门：  </span>${newsScanInfo.department.depName}</label>
				</td>
				<td width="30"></td>
				<td>
					<label><span class="color">发布时间：</span> <c:if test="${newsScanInfo.updateTime ne null}"><fmt:formatDate value="${newsScanInfo.updateTime}" pattern="yyyy-MM-dd HH:mm" /></c:if></label>
				</td>
			</tr>
		</table>
	</div>
	<div class="newsDetail" style="overflow: auto;">
		<table class="newsContent" cellspacing="10" cellpadding="10" style="border-spacing:12">
			<tr>
				<td colspan="5">
					<c:choose>
						<c:when test="${op eq null || op ne 'view'}">
							<textarea class="editor" name="newsContent" rows="15" cols="95">${newsScanInfo.newsContent }</textarea>
						</c:when>
						<c:otherwise>
							<textarea class="editor" name="newsContent" rows="15" cols="95" readonly>${newsScanInfo.newsContent }</textarea>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</div>
	<div style="margin-top: 20px;">
		<table>
			<tr>
				<td style="vertical-align: top; border-bottom: 1px solid #ccc; padding-bottom: 5px;">附件区：</td>
			</tr>
			<tr>
				<td colspan="7">
					<div>
						<c:choose>
							<c:when test="${op eq null || op ne 'view'}">
								<!-- 上传按钮，组件配置请写在data-config内 -->
								<a id="j_J_UploaderBtnNews" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件 </a>
								<!-- 文件上传队列 -->
								<ul id="j_J_UploaderQueueNews"></ul>
								<div id="J_Panel" class="event-panel"></div>
								<input type="hidden" name="fileUrls" id="fileUrls" />
								<input type="hidden" name="fileIds" id="fileIds" />
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${newsScanInfo ne null && fn:length(newsScanInfo.attachFiles) gt 0}">
										<ul>
											<logic:iterate name="newsScanInfo" property="attachFiles" id="file">
												<li class="item_file" style="line-height: 20px;"><a title="点击下载`${file.fileName}`文件" href="file-download?path=${file.filePath}" target="_blank">${file.fileName}</a></li>
											</logic:iterate>
										</ul>
									</c:when>
									<c:otherwise>暂未上传任何附件..</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</div>
					<!--<a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="上传附件">上传附件</a>-->
				</td>
			</tr>
		</table>
	</div>
</body>
</html>