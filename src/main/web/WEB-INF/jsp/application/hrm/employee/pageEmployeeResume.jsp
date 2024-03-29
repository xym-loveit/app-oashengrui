<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<%  
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+
		(request.getServerPort() == 80 ? "" : (":"+request.getServerPort())) +path+"/";  
%>

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
	
	#tblresume input.textInput {width: 90%; margin: 5px;}
	#tblresume td.field {
		background-color: #CFDBEC;
		font-size: 9pt;
		line-height: 35px;
		margin: 0;
		text-align: center;
	}
	#tblresume textarea {height: 30px;margin: 5px;width: 98%;}
	
	#pwrap dt, #pwrap dd {float: none; width: auto;}
	#pwrap dl {width: auto; height: auto; float:none}
</style>


<script>
		
	function uploadSuccessQueue(file, serverData){
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setComplete();
		progress.setStatus("成功传输.");
		progress.toggleCancel(false);

		if(serverData != "") {
			var data = eval('(' + serverData + ')');
			if (data.status == 1) {
				$("#photo_val").val(data.data.url);
				$("#emp_photo img").attr("src", "uploads/" + data.data.url);
			} else {
				alert("图片上传失败...");
			}
		}
	}
	
	$(function(){
		
		<c:if test="${op eq null || op ne 'view'}">
		//加载上传组件入口文件
		KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
			
			var ru = new RenderUploader('#rpa_J_UploaderBtn', '#rpa_J_UploaderQueue',{
				 //服务器端配置
				serverConfig:{
					//处理上传的服务器端脚本路径
					action:"file-upload"
				},
				// 文件域
				name:"Filedata",
				//用于放服务器端返回的url的隐藏域
				urlsInputName:"fileUrls"
				<c:if test="${resume ne null && fn:length(resume.attachFiles) gt 0}">
				// 用于数据展现
				,restoreHook:"#rpa_J_UploaderRestore"
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
	
	var settings = {
		flash_url : "resources/js/swfupload/swfupload.swf",
		upload_url: "<%=basePath%>file-upload?noattach",
		file_size_limit : "100 MB",
		file_types : "*.jpg;*.png;*.gif;*.bmp",
		file_types_description : "图片文件",
		file_upload_limit : 100,
		file_queue_limit : 0,
		custom_settings : {
			progressTarget : "fsUploadProgress",
			cancelButtonId : "btnCancel"
		},
		debug: false,

		// Button settings
		button_image_url: "<%=basePath%>resources/js/swfupload/upload.png",
		button_width: "130",
		button_height: "24",
		button_placeholder_id: "r_spanButtonPlaceHolder",
		button_text: '<span class="button">头像上传</span>',
		button_text_style: '.button { text-align: center; font-weight: bold; font-family:"Lucida Grande",Verdana,Arial,"Bitstream Vera Sans",sans-serif; }',
		button_height: "24",
		button_width: "132",
		button_text_top_padding: 2, 
			
		// The event handler functions are defined in handlers.js
		file_queued_handler : fileQueued,
		file_queue_error_handler : fileQueueError,
		file_dialog_complete_handler : fileDialogComplete,
		upload_start_handler : uploadStart,
		upload_progress_handler : uploadProgress,
		upload_error_handler : uploadError,
		upload_success_handler : uploadSuccessQueue,
		upload_complete_handler : uploadComplete,
		queue_complete_handler : queueComplete	// Queue plugin event
	};

	swfu = new SWFUpload(settings);
	
</script>

<!--- 生成需要展现文件的JSON -->
<c:if test="${(op eq null || op ne 'view') && (resume ne null && fn:length(resume.attachFiles) gt 0)}">
<script type="text/uploader-restore" id="rpa_J_UploaderRestore">
${tm:fileRestore(resume['attachFiles'])}
</script>
</c:if>

<div class="pageContent">
	<form method="post" action="app/hrm/employee/data.do?action=actionEmployeeAdd" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="${cat ne null ? 98 : 56}">
			<table width="100%" cellspacing="15" cellpadding="10" style="border-spacing:15; border-collapse:collapse;" border="1" id="tblresume">
				<tr>
					<td nowrap class="field" style="width: 80px;" >姓名：</td>
					<td><input name="fullName" type="text" value="${resume ne null ? resume.fullName : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''} style="" class="required"/></td>
					<td nowrap class="field">籍贯：</td>
					<td><input name="bornPlace" type="text" value="${resume ne null ? resume.bornPlace : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''} style=""/></td>
					<td nowrap class="field">性别：</td>
					<td style="padding: 5px;">
						<select class="combox" name="sex" style="width:60px">
							<option value="1" ${resume ne null && resume.sex eq 1 ? 'selected="selected"' : ''}>男</option>
							<option value="2" ${resume ne null && resume.sex eq 2 ? 'selected="selected"' : ''}>女</option>
						</select>
					</td>
					<td cospan="2" rowspan="15" valign="top" align="center" style="padding: 5px;">
						<div id="pwrap">
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<dl>
										<dt>
											<span id="emp_photo">
												<c:choose>
													<c:when test="${resume ne null && resume.photo ne null}">
														<img src="uploads/${resume.photo}" width="110px" />
														<input type="hidden" name="photo" id="photo_val" value="${resume.photo}"/>
													</c:when>
													<c:otherwise>
														<img src="resources/images/nopic.gif" width="110px"/>
														<input type="hidden" name="photo" id="photo_val" />
													</c:otherwise>
												</c:choose>
											</span>
										</dt>
										<dd>
											<div class="fieldset flash" id="fsUploadProgress" style="height:200px; overflow: auto; display:none;">
												<span class="legend">传输序列</span>
											</div>
											<div id="divStatus" style="padding:5px;font-size:9pt;display:none;">0 个文件已经上传</div>
											<span id="r_spanButtonPlaceHolder"></span><input id="btnCancel" class="button" type="button" value="取消上传" onclick="swfu.cancelQueue();" disabled="disabled" style="display:none" /></dd>
									</dl>
								</c:when>
								<c:otherwise>
									<span id="emp_photo">
										<c:choose>
											<c:when test="${resume ne null && resume.photo ne null}">
												<img src="uploads/${resume.photo}" width="110px" />
												<input type="hidden" name="photo" id="photo_val" value="${resume.photo}"/>
											</c:when>
											<c:otherwise>
												<img src="resources/images/nopic.gif" width="110px"/>
												<input type="hidden" name="photo" id="photo_val" />
											</c:otherwise>
										</c:choose>
									</span>
								</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>
				<tr>
					<td class="field" align="right">所在校区：</td>
					<td style="padding: 5px;">
						<select class="combox required" name="employeeDistrict.id" id="combox_district" style="width:150px" ref="combox_dept" refUrl="app/base.do?action=actionLoadDepartmentByOrg&districtId={value}">
							<option value="">请选择校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${employee ne null && employee.employeeDistrict ne null && employee.employeeDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td class="field" align="right">所在部门：</td>
					<td style="padding: 5px;">
						<select class="combox required" name="employeeDepartment.id" id="combox_dept" defOPKey="请选择部门" defOPVal="" style="width:150px" ref="combox_position" refUrl="app/base.do?action=actionLoadPositionByDepartment&depId={value}">
							<option value="">请选择部门</option>
							<logic:present name="departments">
								<logic:iterate name="departments" id="entity">
									<option value="${entity.id}" ${employee ne null && entity.employeeDepartment ne null && employee.employeeDepartment.id eq department.id ? 'selected="selected"' : ''}>${entity.depName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td class="field" align="right">所在岗位：</td>
					<td style="padding: 5px;">
						<select class="combox required" name="employeePosition.id" id="combox_position" defOPKey="请选择岗位" defOPVal="" style="width:150px">
							<option value="">请选择岗位</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="field">出生日期：</td>
					<td><input name="birthday" class="${op ne null && op eq 'view' ? '' : 'date'} textInput" yearstart="-80" yearend="0" style="" value="<c:if test='${resume ne null && resume.birthday ne null}'><fmt:formatDate value='${resume.birthday}' pattern='yyyy-MM-dd'/></c:if>" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td class="field">婚姻状况：</td>
					<td style="padding: 5px;">
						<select class="combox" name="marriage" style="width:60px">
							<option value="1" ${resume ne null && resume.marriage eq 1 ? 'selected="selected"' : ''}>未婚</option>
							<option value="2" ${resume ne null && resume.marriage eq 2 ? 'selected="selected"' : ''}>已婚</option>
						</select>
					</td>
					<td class="field" align="right">办公电话：</td>
					<td><input name="officePhone" type="text"  value="${employee ne null ? employee.officePhone : ''}" /></td>
				</tr>
				<tr>
					<td class="field">联系电话：</td>
					<td><input class="required" name="mobilePhone" type="text" style="" value="${resume ne null ? resume.mobilePhone : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td class="field">短号：</td>
					<td><input class="" name="shortNo" type="text" style="" value="${employee ne null ? employee.shortNo : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td class="field">紧急联系人：</td>
					<td colspan=""><input class="" name="urgentContact" type="text" style="" value="${employee ne null ? employee.urgentContact : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					
					<td class="field">身份证号：</td>
					<td colspan="3"><input name="identityNo" type="text"  style="" value="${resume ne null ? resume.identityNo : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td class="field">入职时间：</td>
					<td colspan=""><input class="date required" name="onboardDate" type="text" style="" value="${employee ne null ? employee.onboardDate : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					<td class="field">居住地址：</td>
					<td colspan="5"><input name="address" type="text"  style="" value="${resume ne null ? resume.address : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					<td class="field">电子邮箱：</td>
					<td colspan="5"><input name="email" type="text"  style="" value="${resume ne null ? resume.email : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					<td class="field">毕业院校：</td>
					<td><input name="educationCollege" type="text" style="" value="${resume ne null ? resume.educationCollege : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td class="field">专业：</td>
					<td><input name="educationMajority" type="text" style="width:140px" value="${resume ne null ? resume.educationMajority : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td class="field">学历：</td>
					<td style="padding: 5px;">
						<select class="combox" name="educationDegree" style="width:60px">
							<option value="1" ${resume ne null && resume.educationDegree eq 1 ? 'selected="selected"' : ''}>研究生</option>
							<option value="2" ${resume ne null && resume.educationDegree eq 2 ? 'selected="selected"' : ''}>本科生</option>
							<option value="3" ${resume ne null && resume.educationDegree eq 3 ? 'selected="selected"' : ''}>大专</option>
							<option value="4" ${resume ne null && resume.educationDegree eq 4 ? 'selected="selected"' : ''}>其他</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="field">师范专业：</td>
					<td style="padding: 5px;">
						<select class="combox" name="teacherMajority" style="width:60px">
							<option value="1" ${resume ne null && resume.teacherMajority eq 1 ? 'selected="selected"' : ''}>是</option>
							<option value="2" ${resume ne null && resume.teacherMajority eq 2 ? 'selected="selected"' : ''}>否</option>
						</select>
					</td>
					<td class="field" style="width: 80px" >教师资格：</td>
					<td style="padding: 5px;">
						<select class="combox" name="teacherCertifaciton" style="width:60px">
							<option value="1" ${resume ne null && resume.teacherCertifaciton eq 1 ? 'selected="selected"' : ''}>有</option>
							<option value="2" ${resume ne null && resume.teacherCertifaciton eq 2 ? 'selected="selected"' : ''}>无</option>
						</select>
					</td>
					<td nowrap class="field">政治面貌：</td>
					<td style="padding: 5px;">
						<select class="combox" name="party"  style="width:60px">
							<option value="1" ${resume ne null && resume.party eq 1 ? 'selected="selected"' : ''}>群众</option>
							<option value="2" ${resume ne null && resume.party eq 2 ? 'selected="selected"' : ''}>党员</option>
							<option value="3" ${resume ne null && resume.party eq 3 ? 'selected="selected"' : ''}>团员</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="field">外语等级：</td>
					<td style="padding: 5px;">
						<select class="combox" name="englishLevel" style="width:60px">
							<option value="1" ${resume ne null && resume.englishLevel eq 1 ? 'selected="selected"' : ''}>CET-4</option>
							<option value="2" ${resume ne null && resume.englishLevel eq 2 ? 'selected="selected"' : ''}>CET-6</option>
							<option value="3" ${resume ne null && resume.englishLevel eq 3 ? 'selected="selected"' : ''}>专业四级</option>
							<option value="4" ${resume ne null && resume.englishLevel eq 4 ? 'selected="selected"' : ''}>专业八级</option>
							<option value="5" ${resume ne null && resume.englishLevel eq 5 ? 'selected="selected"' : ''}>其他</option>
						</select>
					</td>
					<td class="field">普通话等级：</td>
					<td colspan="3" style="padding: 5px;">
						<select class="combox" name="chineseLevel" style="width:60px">
							<option value="1" ${resume ne null && resume.chineseLevel eq 1 ? 'selected="selected"' : ''}>一级甲等</option>
							<option value="2" ${resume ne null && resume.chineseLevel eq 2 ? 'selected="selected"' : ''}>一级乙等</option>
							<option value="3" ${resume ne null && resume.chineseLevel eq 3 ? 'selected="selected"' : ''}>二级甲等</option>
							<option value="4" ${resume ne null && resume.chineseLevel eq 4 ? 'selected="selected"' : ''}>二级乙等</option>
							<option value="5" ${resume ne null && resume.chineseLevel eq 5 ? 'selected="selected"' : ''}>三级甲等</option>
							<option value="6" ${resume ne null && resume.chineseLevel eq 6 ? 'selected="selected"' : ''}>三级乙等</option>
							<option value="7" ${resume ne null && resume.chineseLevel eq 7 ? 'selected="selected"' : ''}>无</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="field">教育经历：</td>
					<td colspan="5"><textarea rows="1" style=""></textarea></td>
				</tr>
				<tr>
					<td class="field">工作经历：</td>
					<td colspan="5"><textarea rows="1" style=""></textarea></td>
				</tr>
				<tr>
					<td class="field">获奖情况：</td>
					<td colspan="5"><textarea rows="1" style=""></textarea></td>
				</tr>
				<tr>
					<td class="field">兴趣爱好：</td>
					<td colspan="5"><textarea rows="1" style=""></textarea></td>
				</tr>
				<tr>
					<td class="field">简历附件：</td>
					<td colspan="5" style="padding: 5px;">
						<div>
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<!-- 上传按钮，组件配置请写在data-config内 -->
									<a id="rpa_J_UploaderBtn" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件 </a>
									<!-- 文件上传队列 -->
									<ul id="rpa_J_UploaderQueue"></ul>
									<div id="J_Panel" class="event-panel"></div>
									<input type="hidden" name="fileUrls" id="fileUrls" />
									<input type="hidden" name="fileIds" id="fileIds" />
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${resume ne null && fn:length(resume.attachFiles) gt 0}">
											<ul>
												<logic:iterate name="resume" property="attachFiles" id="file">
													<li class="item_file"><a title="点击下载`${file.fileName}`文件" href="file-download?path=${file.filePath}" target="_blank">${file.fileName}</a></li>
												</logic:iterate>
											</ul>
										</c:when>
										<c:otherwise>暂未上传任何附件..</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">添加</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
		<input type="hidden" name="source" value="${source ne null ? source : '0'}" />
		<input type="hidden" name="jobId" value="${jobId ne null ? jobId : '-1'}" />
		<input type="hidden" name="resumeId" value="${resume ne null ? resume.id : -1}" />
		<input type="hidden" name="empId" value="${empId ne null ? empId : -1}" />
	</form>
</div>