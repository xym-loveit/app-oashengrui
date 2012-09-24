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
	var ru = new RenderUploader('#j_J_UploaderBtnEmployee', '#j_J_UploaderQueueEmployee',{
		 //服务器端配置
		serverConfig:{
			//处理上传的服务器端脚本路径
			action:"file-upload",
			data: {
				"test" : "a"
			}
		},
		authConfig:{
			require:[true,"必须至少上传一个文件！"],
			max:[1, "最多上传{max}个文件！"],
			// maxSize:[1000, "文件大小为{size}，文件太大！"],
			allowRepeat:[false, "该文件已经存在！"],
            allowExts:[{desc:"xls", ext:"*.xls"}, '只支持xls格式的文件上传！']
		},
		// 文件域
		name:"Filedata",
		//用于放服务器端返回的url的隐藏域
		urlsInputName:"fileUrls"
		<c:if test="${entity ne null && fn:length(entity.attachFiles) gt 0}">
		// 用于数据展现
		,restoreHook:"#jp_J_UploaderRestoreEmployee"
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
<script type="text/uploader-restore" id="jp_J_UploaderRestoreEmployee">
${tm:fileRestore(entity['attachFiles'])}
</script>
<div>
	<div style="float:left; width:60px;height:100px;margin-top:10px;"><label>导入文件：</label></div>
	<div style="float:left; width:330px;height:100px">
		<form method="post" action="app/hrm/employee/import.do?action=actionEmployeeImport" id="formImport" class="pageForm required-validate" onsubmit="return validateCallback(this);" style="overflow: visible">
			<a id="j_J_UploaderBtnEmployee" class="uploader-button" href="javascript:void(0);">请选择员工信息文件 </a>
			<ul id="j_J_UploaderQueueEmployee"></ul>
			<div id="J_Panel" class="event-panel"></div>
			<input type="hidden" name="fileUrls" id="fileUrls" />
			<input type="hidden" name="fileIds" id="fileIds" />
			<div class="buttonActive" style="margin-left:50px;margin-top:20px;" width="300"><div class="buttonContent"  style="float:right;"><button id="import" type="submit">信息导入</button></div></div>
		</form>
	</div>
</div>