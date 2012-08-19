<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>


<script type="text/javascript">
$(function(){
//加载上传组件入口文件
KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
	var ru = new RenderUploader('#j_J_UploaderBtnAttendance', '#j_J_UploaderQueueAttendance',{
		 //服务器端配置
		serverConfig:{
			//处理上传的服务器端脚本路径
			action:"file-upload"
		},
		//验证配置
	    authConfig: {
	        require:[true,"必须至少上传一个文件！"],
	        max:[1, "最多上传{max}个文件！"],
	        allowRepeat:[false, "该文件已经存在！"],
	        allowExts:[
	            {"desc":"xls,xlsx", "ext":"*.xls;*.xlsx"}, "不支持{ext}格式的文件上传！"
	        ]
	    },
		// 文件域
		name:"Filedata",
		//用于放服务器端返回的url的隐藏域
		urlsInputName:"fileUrls"
		<c:if test="${entity ne null && fn:length(entity.attachFiles) gt 0}">
		// 用于数据展现
		,restoreHook:"#jp_J_UploaderRestoreAttendance"
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
<script type="text/uploader-restore" id="jp_J_UploaderRestoreAttendance">
${tm:fileRestore(entity['attachFiles'])}
</script>
<div style="width:500px; height:100px">
	<div style="float:left; width:270px;height:100px">
		<form style="width:500px" method="post" action="app/admin/attendance/operation.do?action=actionImportAttendanceData" id="formImport" class="pageForm required-validate" onsubmit="return validateCallback(this);">
			<table class="searchContent">
				<tr>
					<td><label>所属校区：</label></td>
					<td>
						<select class="combox" name="district.id" id="districtId" onchange="districtChange()">
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${formWorkTemplate ne null && formWorkTemplate.district.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
				</tr>
				<tr>
					<td><label>导入文件：</label></td>
					<td>
						<a id="j_J_UploaderBtnAttendance" class="uploader-button" style="width:90px" href="javascript:void(0);">请选择数据文件 </a>
						<ul id="j_J_UploaderQueueAttendance"></ul>
						<div id="J_Panel" class="event-panel"></div>
						<input type="hidden" name="fileUrls" id="fileUrls" />
						<input type="hidden" name="fileIds" id="fileIds" />
					</td>
				</tr>
			</table>
			<div class="buttonActive" style="margin-left:200px;margin-top:40px;" width="300"><div class="buttonContent"  style="float:right;"><button id="import" type="submit">导入</button></div></div>
		</form>
	</div>
</div>