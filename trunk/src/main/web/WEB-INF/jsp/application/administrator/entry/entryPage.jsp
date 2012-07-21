<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script>
$(function(){
	$("#pass").unbind("click");
	$("#pass").bind("click", function() { 
		$("#formAction").val("0");
		$("#formnews").submit();
	});
	
	$("#return").unbind("click");
	$("#return").bind("click", function() { 
		$("#formAction").val("1");
		$("#formnews").submit();
	});
	
	$("#approval").unbind("click");
	$("#approval").bind("click", function() { 
		$("#formadd").val("2");
		$("#formnews").submit();
		return false;
	});
	
	$("#save").unbind("click");
	$("#save").bind("click", function() { 
		$("#formadd").val("3");
		$("#formnews").submit();
		return false;
	});

	//加载上传组件入口文件
	KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
		var ru = new RenderUploader('#jp_J_UploaderBtnNews', '#jp_J_UploaderQueueNews',{
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
			<c:if test="${news ne null && fn:length(news.attachFiles) gt 0}">
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
${tm:fileRestore(news['attachFiles'])}
</script>
</c:if>
<div class="pageContent">
	<form method="post" action="app/admin/news.do?action=actionNewsEditOrSave" id="formnews" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>新闻标题：</td>
					<td colspan="5"><input name="newsSubject" type="text" size="30" value="${news.newsSubject}" style="width:100%"/></td>
				</tr>
				<tr>
					<td>新闻级别：</td>
					<td>
						<select class="combox" name="newsLevel" id="entry_level" style="width:150px">
							<option value="">所有</option>
							<option value="0" ${news ne null && news.newsLevel eq 0 ? 'selected="selected"' : '' }>公司新闻</option>
							<option value="1" ${news ne null && news.newsLevel eq 1 ? 'selected="selected"' : '' }>校区新闻</option>
						</select>
					</td>
					<td>可见校区：</td>
					<td>
						<c:choose>
							<c:when test="${op ne 'opp'}">
								<select class="combox" name="districtVisible" style="width:120px" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<option value="-1">所有校区</option>
									<logic:present name="districts">
										<logic:iterate name="districts" id="district">
											<option value="${district.id}" ${news ne null && news.newsDistrictVisible ne null && news.newsDistrictVisible.id eq district.id? 'selected="selected"' : ''}>${district.districtName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>新闻类别：</td>
					<td>
						<select class="combox" name="typeDicid" id="news_type1" style="width:150px">
							<option value="">所有</option>
						  	<logic:present name="newsTypes">
								<logic:iterate name="newsTypes" id="newsType">
									<option value="${newsType.id}" ${news ne null && news.dictionary.id eq newsType.id? 'selected="selected"' : ''}>${newsType.name}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>发布校区：</td>
					<td>
						<c:choose>
							<c:when test="${op ne 'opp'}">
								<select class="combox" name="districtPost" style="width:120px" ref="combox_department1" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<option value="-1">所有校区</option>
									<logic:present name="districts">
										<logic:iterate name="districts" id="districtPublic">
											<option value="${districtPublic.id}" ${news ne null && news.district.id eq districtPublic.id ? 'selected="selected"' : ''}>${districtPublic.districtName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
						</c:choose>
					</td>
					<td>发布部门：</td>
					<td>
						<c:choose>
							<c:when test="${op ne 'opp'}">
								<select class="combox" name="depPost" id="combox_department1" style="width:120px" efOPKey="请选择部门" defOPVal="">
									<option value="-1">所有部门</option>
									<logic:present name="departments">
										<logic:iterate name="departments" id="department">
											<option value="${department.id}" ${news ne null && news.department ne null && news.department.id eq department.id ?'selected="selected"' : ''}>${department.depName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
						</c:choose>	
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top">新闻内容：</td>
					<td colspan="5"><textarea class="editor" name="newsContent" rows="15" cols="80">${news.newsContent }</textarea></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">附件区：</td>
					<td colspan="7">
						<div>
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<!-- 上传按钮，组件配置请写在data-config内 -->
									<a id="jp_J_UploaderBtnNews" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件 </a>
									<!-- 文件上传队列 -->
									<ul id="jp_J_UploaderQueueNews"></ul>
									<div id="J_Panel" class="event-panel"></div>
									<input type="hidden" name="fileUrls" id="fileUrls" />
									<input type="hidden" name="fileIds" id="fileIds" />
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${news ne null && fn:length(news.attachFiles) gt 0}">
											<ul>
												<logic:iterate name="news" property="attachFiles" id="file">
													<li class="item_file"><a title="点击下载`${file.fileName}`文件" href="uploads/${file.filePath}" target="_blank">${file.fileName}</a></li>
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
		<div class="formBar">
			<ul>
				<!--<li><a class="buttonActive" href="javascript:;"><span>保存</span></a></li>-->
				<logic:present name="op">
					<logic:equal name="op" value="view">
						<li><div class="buttonActive"><div class="buttonContent"><button id="pass" type="submit">通过</button></div></div></li>
						<li><div class="buttonActive"><div class="buttonContent"><button id="return" type="submit">退回</button></div></div></li>
						<li><div class="buttonActive"><div class="buttonContent"><a class="icon" href="app/admin/news.do?action=actionNewsScan&id=${news.id }&op=view" target="dialog" rel="admin_entrycheck" width="900" height="650"><button>预览</button></a></div></div></li>
					</logic:equal>
				</logic:present>
				<logic:notPresent name="op">
					<li><div class="buttonActive"><div class="buttonContent"><button id="approval" type="submit">提交审核</button></div></div></li>
					<li><div class="buttonActive"><div class="buttonContent"><button id="save" type="submit">保存草稿</button></div></div></li>
				</logic:notPresent>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<c:if test="${news ne null}">
			<input type="hidden" id="formAction" name="formAction" value="" />
		</c:if>
		<c:if test="${news eq null}">
			<input type="hidden" id="formadd" name="formadd" value="" />
		</c:if>
		<input type="hidden" name="id" value="${news ne null ? news.id : '-1'}" />
	<!--  	<input type="hidden" name="status" value="${news.status}" />
		<input type="hidden" name="op" value="view" /> -->
	</form>
</div>