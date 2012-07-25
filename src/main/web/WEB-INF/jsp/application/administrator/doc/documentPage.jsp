<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	/**
     * 向事件面板添加消息
     * @param evt
     * @param msg
     */
    function addMsg(evt, msg) {
        var $panel = $("#J_Panel");
        $panel.append("<p>事件名称：" + evt.type + "，" + msg + "</p>");
    }

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
		
		KISSY.use('gallery/form/1.2/uploader/queue/base', function (S, Queue) {
			var queue = new Queue();
		})

		//加载上传组件入口文件
		KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
			var ru = new RenderUploader('#J_UploaderBtn', '#J_UploaderQueue',{
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
<div class="pageContent">
<form method="post" action="app/admin/doc.do?action=adminPageDocumentSave"
	class="pageForm required-validate"
	onsubmit="return validateCallback(this, dialogAjaxDone);">
<div class="pageFormContent" layoutH="56">
<div style="float: right; width: 300px;">
<div class="accordion">
<div class="accordionHeader">
<h2><span>icon</span>按校区</h2>
</div>
<div class="accordionContent" style="height: 200px"><%@ include
	file="data/dataDistrictTree.jsp"%></div>
<div class="accordionHeader">
<h2><span>icon</span>按部门</h2>
</div>
<div class="accordionContent"><%@ include
	file="data/dataDepartmentTree.jsp"%></div>
</div>
</div>


<div style="margin-right: 320px">
<table cellspacing="10" cellpadding="10"
	style="border-spacing: 12; width: 100%;">
	<tr>
		<td width="100px;">文档类型：</td>
		<td><select class="combox" id="combox_doc_type" name="type.id"
			style="width: 108px;">
			<logic:present name="docTypes">
				<logic:iterate name="docTypes" id="entity">
					<option value="${entity.id}" ${formDoc ne
						null && formDoc.type ne
						null && formDoc.type.id eq
						entity.id ? 'selected="selected"' : ''}>${entity.value}</option>
				</logic:iterate>
			</logic:present>
		</select></td>
		
		<td>文档级别：</td>
		<td><select class="combox" id="combox_doc_Level"
			name="docLevel.id" style="width: 108px;">
			<logic:present name="docLevels">
				<logic:iterate name="docLevels" id="entity">
					<option value="${entity.id}" ${formDoc ne
						null && formDoc.docLevel ne
						null && formDoc.docLevel.id eq
						entity.id ? 'selected="selected"' : ''}>${entity.levelName}</option>
				</logic:iterate>
			</logic:present>
		</select></td>
	</tr>
	<tr>
		<td>文档名称：</td>
		<td colspan="3"><input type="text" name="docName" style="width: 100%"  value="${formDoc ne null ? formDoc.docName : ''}"/></td>
	</tr>
	<tr>
		<td>文档范围：</td>
		<td colspan="3"><select class="combox" id="combox_doc_range"
			name="docVisiableRange.id" style="width: 108px;">
			<logic:present name="docRanges">
				<logic:iterate name="docRanges" id="entity">
					<option value="${entity.id}" ${formDoc ne
						null && formDoc.docVisiableRange ne
						null && formDoc.docVisiableRange.id eq
						entity.id ? 'selected="selected"' : ''}>${entity.visiableName}</option>
				</logic:iterate>
			</logic:present>
		</select></td>
	</tr>
	<tr>
		<td style="vertical-align: top">文档可见人：</td>
		<td colspan="3"><textarea name="docUserNames" rows="5" cols="60"
			style="width: 100%"  >${formDoc ne null ? formDoc.docUserNames : ''}</textarea></td>
	</tr>
	<tr>
		<td>上传中心：</td>
		<td><select class="combox" id="combox_doc_district"
			name="district.id" style="width: 108px;" ref="combox_doc_dep" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
			<logic:present name="districts">
				<logic:iterate name="districts" id="entity">
					<option value="${entity.id}" ${formDoc ne
						null && formDoc.district ne
						null && formDoc.district.id eq
						entity.id ? 'selected="selected"' : ''}>${entity.districtName}</option>
				</logic:iterate>
			</logic:present>
		</select></td>
		<td>上传部门：</td>
		<td><select class="combox" id="combox_doc_dep" name="department.id"
			style="width: 108px;">
			<option value="">请选择部门</option>
			<logic:present name="deps">
				<logic:iterate name="deps" id="entity">
					<option value="${entity.id}" ${formDoc ne
						null && formDoc.department ne
						null && formDoc.department.id eq
						entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
				</logic:iterate>
			</logic:present>
		</select></td>
	</tr>
	<tr>
<td style="vertical-align: top;">附件区：</td>
					<td colspan="7">
						<!-- Uploader Demo-->
						<div>
							<!-- 上传按钮，组件配置请写在data-config内 -->
							<a id="J_UploaderBtn" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件 </a>
							<!-- 文件上传队列 -->
							<ul id="J_UploaderQueue"></ul>
							<div id="J_Panel" class="event-panel"></div>
							<input type="hidden" name="fileUrls" id="fileUrls" />
							<input type="hidden" name="fileIds" id="fileIds" />
						</div>
						<!--<a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="上传附件">上传附件</a>-->
					</td>
	</tr>
</table>
</div>
</div>
<div class="formBar">
<ul>
	<!--<li><a class="buttonActive" href="javascript:;"><span>保存</span></a></li>-->

	<logic:notPresent name="op">
		<li>
		<div class="buttonActive">
		<div class="buttonContent">
		<button type="submit">文档上传</button>
		</div>
		</div>
		</li>
	</logic:notPresent>

	<li>
	<div class="button">
	<div class="buttonContent">
	<button type="button" class="close">取消</button>
	</div>
	</div>
	</li>
</ul>
</div>
<input type="hidden" name="id" value="${formDoc ne null ? formDoc.id : '-1'}" />

</form>
</div>