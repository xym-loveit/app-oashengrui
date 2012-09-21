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

<link rel="stylesheet" type="text/css" href="resources/js/jquery/jmultiselect/jquery.multiselect.css" />
<link rel="stylesheet" type="text/css" href="resources/js/jquery/jmultiselect/jquery-ui.css" />
<script type="text/javascript" src="resources/js/jquery/jmultiselect/jquery-ui.min.js"></script>
<script type="text/javascript" src="resources/js/jquery/jmultiselect/jquery.multiselect.js"></script>
	
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
			return false;
		});
		
		$("#btnback").unbind("click");
		$("#btnback").bind("click", function() { 
			$("#formAction").val("0");
			$("#formjob").submit();
			return false;
		});
		
		multi_visible("combox_districtvisible", "jobHireVisibleDistrictIds");
		
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
				<c:if test="${jobHire ne null && jobHire.id ne null && fn:length(jobHire.attachFiles) gt 0}">
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
<c:if test="${(op eq null || op ne 'view') && (jobHire ne null && fn:length(jobHire.attachFiles) gt 0)}">
<script type="text/uploader-restore" id="jp_J_UploaderRestore">
${tm:fileRestore(jobHire['attachFiles'])}
</script>
</c:if>

<div class="pageContent">
	<form method="post" action="app/hrm/hire.do?action=actionJobSave" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:15; border-collapse:collapse;" border="1" id="tbljob">
				<tr>
					<td nowrap class="field">岗位名称：</td>
					<td><input name="jobHireTitle" type="text" class="required" value="${jobHire ne null ? jobHire.jobHireTitle : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td nowrap class="field">招聘校区：</td>
					<td style="padding: 5px;">
						<c:choose>
							<c:when test="${op eq null || op ne 'view'}">
								<select class="combox" name="jobHireDistrictId" id="combox_district" style="width:120px" ref="combox_dept" refUrl="app/base.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<logic:present name="districts">
										<logic:iterate name="districts" id="district">
											<option value="${district.id}" ${jobHire ne null && jobHire.jobHireDistrict ne null && jobHire.jobHireDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
							<c:otherwise>
								<input name="jobHireDistrictId" type="text"  value="${jobHire ne null && jobHire.jobHireDistrict ne null ? jobHire.jobHireDistrict.districtName : ''}" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap class="field">招聘部门：</td>
					<td style="padding: 5px;">
						<c:choose>
							<c:when test="${op eq null || op ne 'view'}">
								<select class="combox" name="jobHireDepartmentId" id="combox_dept" style="width:120px">
									<logic:present name="departments">
										<logic:iterate name="departments" id="entity">
											<option value="${entity.id}" ${jobHire ne null && jobHire.jobHireDepartment ne null && jobHire.jobHireDepartment.id eq entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
							<c:otherwise>
								<input name="jobHireDepartmentId" type="text"  value="${jobHire ne null && jobHire.jobHireDepartment ne null ? jobHire.jobHireDepartment.depName : ''}" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap class="field">截止时间：</td>
					<td style="width: 120px; padding: 5px;"><input name="jobHireEndDate" class="date textInput required" style="width:70px;float:left;margin:0" value='<logic:present name="jobHire"><fmt:formatDate value="${jobHire.jobHireEndDate}" pattern="yyyy-MM-dd" /></logic:present>' ${op ne null && op eq 'view' ? 'readonly' : ''}/><c:if test="${op eq null || op ne 'view'}"><a class="inputDateButton" href="javascript:;">选择</a></c:if></td>
				</tr>
				<tr>
					<td class="field">招聘范围：</td>
					<td style="padding: 5px;">
						<c:choose>
							<c:when test="${op eq null || op ne 'view'}">
								<select class="combox" name="jobHireRange" id="combox_range" style="width:120px">
									<option value="1" ${jobHire ne null && jobHire.jobHireRange eq 1 ? 'selected="selected"' : ''}>内外兼招</option>
									<option value="2" ${jobHire ne null && jobHire.jobHireRange eq 2 ? 'selected="selected"' : ''}>外部招聘</option>
									<option value="3" ${jobHire ne null && jobHire.jobHireRange eq 3 ? 'selected="selected"' : ''}>内部招聘</option>
								</select>
							</c:when>
							<c:otherwise>
								<input name="jobHireRange" type="text"  value="${jobHire ne null && jobHire.jobHireRange ne null ? (jobHire.jobHireRange eq 1 ? '内外兼招' : (jobHire.jobHireRange eq 2 ? '外部招聘' : '内部招聘')) : ''}" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td class="field">招聘人数：</td>
					<td><input name="jobHireCount" type="text"  class="required" value="${jobHire ne null ? jobHire.jobHireCount : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td class="field">可见范围：</td>
					<td colspan="7" style="padding: 5px;">
						<select class="" multiple="multiple" size="${fn:length(districts) + 1}" name="jobHireVisibleDistrictId" id="combox_districtvisible" style="width:120px">
							<option value="">所有校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${jobHire ne null && jobHire.jobHireVisibleDistrictIds ne null && tm:inRange(jobHire.jobHireVisibleDistrictIds, district.id , ',') ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
						<input type="hidden" name="jobHireVisibleDistrictIds" id="jobHireVisibleDistrictIds" value="${jobHire ne null && jobHire.jobHireVisibleDistrictIds ne null ? jobHire.jobHireVisibleDistrictIds : ''}"/>
					</td>
				</tr>
				<tr>
					<td class="field">工作地点：</td>
					<td colspan="7"><input name="jobHireAddress" type="text" style="width:98%" value="${jobHire ne null ? jobHire.jobHireAddress : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''} /></td>
				</tr>
				<tr>
					<td class="field" style="vertical-align: top;">工作职责：</td>
					<td colspan="7"><textarea name="jobHireResponsibility" rows="3" ${op ne null && op eq 'view' ? 'readonly' : ''}>${jobHire ne null ? jobHire.jobHireResponsibility : ''}</textarea></td>
				</tr>
				<tr>
					<td class="field" style="vertical-align: top;">任职要求：</td>
					<td colspan="7"><textarea name="jobHireCondition" rows="3" ${op ne null && op eq 'view' ? 'readonly' : ''}>${jobHire ne null ? jobHire.jobHireCondition : ''}</textarea></td>
				</tr>
				<tr>
					<td class="field" style="vertical-align: top;">薪酬福利：</td>
					<td colspan="7"><textarea name="jobHireSalary" rows="3" ${op ne null && op eq 'view' ? 'readonly' : ''}>${jobHire ne null ? jobHire.jobHireSalary : ''}</textarea></td>
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
										<c:when test="${jobHire ne null && fn:length(jobHire.attachFiles) gt 0}">
											<ul>
												<logic:iterate name="jobHire" property="attachFiles" id="file">
													<li class="item_file"><a title="点击下载`${file.fileName}`文件" href="file-download?path=${file.filePath}" target="_blank">${file.fileName}</a></li>
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
				<c:if test="${op eq null || op ne 'view'}">
					<c:choose>
						<c:when test="${jobHire ne null && jobHire.id ne null && op ne 'edit'}">
							<c:choose>
								<c:when test="${jobHire.status eq 1}">
									<li><div class="buttonActive"><div class="buttonContent"><button id="btnapproval" type="submit">提交总部审核</button></div></div></li>
									<li><div class="buttonActive"><div class="buttonContent"><button id="btnback" type="submit">退回发布人员</button></div></div></li>
								</c:when>
								<c:when test="${jobHire.status eq 2}">
									<li><div class="buttonActive"><div class="buttonContent"><button id="btnapproval" type="submit">通过并发布</button></div></div></li>
									<li><div class="buttonActive"><div class="buttonContent"><button id="btnback" type="submit">退回</button></div></div></li>
								</c:when>
							</c:choose>
						</c:when>
						<c:otherwise>
							<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交并审核</button></div></div></li>
						</c:otherwise>
					</c:choose>
				</c:if>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<c:if test="${jobHire ne null && jobHire.id ne null}">
			<input type="hidden" id="formAction" name="formAction" value="" />
		</c:if>
		<input type="hidden" name="id" value="${jobHire ne null && jobHire.id ne null ? jobHire.id : '-1'}" />
	</form>
</div>