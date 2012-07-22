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
					action:"file-upload"
				},
				// 文件域
				name:"Filedata",
				//用于放服务器端返回的url的隐藏域
				urlsInputName:"fileUrls"
				<c:if test="${jobHire ne null && fn:length(jobHire.attachFiles) gt 0}">
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

<!--- 生成需要展现文件的JSON -->
<c:if test="${(op eq null || op ne 'view') && (conference ne null && fn:length(conference.attachFiles) gt 0)}">
<script type="text/uploader-restore" id="jp_J_UploaderRestore">
${tm:fileRestore(conference['attachFiles'])}
</script>
</c:if>

<div class="pageContent">
	<form method="post" action="app/personal/conference.do?action=actionConferenceSave" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:15; border-collapse:collapse;" border="1" id="tbljob">
				<tr>
					<td nowrap class="field">会议名称：</td>
					<td colspan="5"><input name="jobHireTitle" type="text" class="required" value="${jobHire ne null ? jobHire.jobHireTitle : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td nowrap class="field">会议级别：</td>
					<td style="padding: 5px;">
						<c:choose>
							<c:when test="${op eq null || op ne 'view'}">
								<select class="combox" name="level" id="combox_level" style="width:120px">
									<option value="">请选择会议级别</option>
								</select>
							</c:when>
							<c:otherwise>
								<input name="level" type="text"  value="" readonly />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td nowrap class="field">会议类型：</td>
					<td style="padding: 5px;">
						<c:choose>
							<c:when test="${op eq null || op ne 'view'}">
								<select class="combox" name="type" id="combox_type" defOPKey="请选择会议类型" defOPVal="" style="width:120px">
									<option value="">请选择会议类型</option>
								</select>
							</c:when>
							<c:otherwise>
								<input name="type" type="text"  value="" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap class="field">发布校区：</td>
					<td style="padding: 5px;">
						<c:choose>
							<c:when test="${op eq null || op ne 'view'}">
								<select class="combox" name="district.id" id="combox_district" style="width:120px" ref="combox_dept" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<option value="">请选择校区</option>
									<logic:present name="districts">
										<logic:iterate name="districts" id="district">
											<option value="${district.id}" ${jobHire ne null && jobHire.jobHireDistrict ne null && jobHire.jobHireDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
							<c:otherwise>
								<input name="district.id" type="text"  value="${jobHire ne null && jobHire.jobHireDistrict ne null ? jobHire.jobHireDistrict.districtName : ''}" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap class="field">发布部门：</td>	
					<td style="padding: 5px;">
						<c:choose>
							<c:when test="${op eq null || op ne 'view'}">
								<select class="combox" name="department.id" id="combox_dept" defOPKey="请选择部门" defOPVal="" style="width:120px">
									<option value="">请选择部门</option>
									<logic:present name="departments">
										<logic:iterate name="departments" id="entity">
											<option value="${entity.id}" ${jobHire ne null && jobHire.jobHireDepartment ne null && jobHire.jobHireDepartment.id eq entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
							<c:otherwise>
								<input name="department.id" type="text"  value="${jobHire ne null && jobHire.jobHireDepartment ne null ? jobHire.jobHireDepartment.depName : ''}" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap class="field">会议地址：</td>
					<td style="width: 120px; padding: 5px;"><input name="address" class="textInput required" value=""/></td>
				</tr>
				<tr>
					<td class="field">开始时间：</td>
					<td colspan="2" style="width: 120px; padding: 5px;">
					<input name="startDay" class="textInput required" style="width:70px;float:left;margin:0" value=""/>
					<select name="startHour">
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
					</select>-<select name="startMinute">
					<option value="00">00</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
					</select>
					</td>
					<td class="field">结束时间：</td>
					<td colspan="2" style="width: 120px; padding: 5px;">
					<input name="jobHireEndDate" class="textInput required" style="width:70px;float:left;margin:0" value=""/>
					<select name="startHour">
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
					</select>-<select name="startMinute">
					<option value="00">00</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
					</select>
					</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td class="field">参会人员：</td>
					<td colspan="5"><input name="attendances" type="text"  class="required" value="${jobHire ne null ? jobHire.jobHireCount : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td class="field">参会人数：</td>
					<td><input type="text" name="count" value="" style="width:70px;float:left;margin:0" />人	</td>
				</tr>
				<tr>
					<td class="field">联系人：</td>
					<td colspan="2"><input name="contactor" type="text" value="${jobHire ne null ? jobHire.jobHireAddress : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''} /></td>
					<td class="field" style="vertical-align: top;">联系电话：</td>
					<td colspan="2"><input name="phone" type="text" /></td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td class="field" style="vertical-align: top;">会议内容：</td>
					<td colspan="7"><textarea name="content" rows="3" ${op ne null && op eq 'view' ? 'readonly' : ''}>${jobHire ne null ? jobHire.jobHireCondition : ''}</textarea></td>
				</tr>
				<tr>
					<td class="field" style="vertical-align: top;">附件区：</td>
					<td colspan="7" style="padding: 5px;">
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
								<c:otherwise>
									<c:choose>
										<c:when test="${conference ne null && fn:length(conference.attachFiles) gt 0}">
											<ul>
												<logic:iterate name="conference" property="attachFiles" id="file">
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
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">发起会议</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<c:if test="${jobHire ne null}">
			<input type="hidden" id="formAction" name="formAction" value="" />
		</c:if>
		<input type="hidden" name="id" value="${jobHire ne null ? jobHire.id : '-1'}" />
	</form>
</div>