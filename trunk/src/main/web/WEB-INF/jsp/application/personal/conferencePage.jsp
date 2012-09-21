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
					data:{file_type:"conference_attach"}
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
			
			var ru_1 = new RenderUploader('#jp_J_UploaderBtn_1', '#jp_J_UploaderQueue_1',{
				 //服务器端配置
				serverConfig:{
					//处理上传的服务器端脚本路径
					action:"file-upload",
					data:{file_type:"conference_process"}
				},
				// 文件域
				name:"Filedata",
				//用于放服务器端返回的url的隐藏域
				urlsInputName:"fileUrls_1"
				<c:if test="${conference ne null && fn:length(conference.attachFiles) gt 0}">
				// 用于数据展现
				,restoreHook:"#jp_J_UploaderRestore_1"
				</c:if>
			});
			
			ru_1.on('init', function (ev) {
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
		
		$('#conferene_attendances').manifest({
			// Use each location's full name as the display text.
			formatDisplay: function (data, $item, $mpItem) {
				return data.empName;
			},
			// Use each location's ID as the value to be submitted.
			formatValue: function (data, $value, $item, $mpItem) {
				return data.id;
			},
			onRemove: function(data, $item){
				var count = $('#attendances_count').val();
				if(count == "" || count == null) count = 0;
				$('#attendances_count').val(parseInt(count)-1);
			},
			valuesName: 'empid',
			marcoPolo: {
				url: 'app/base.do?action=lookupEmployeeByName',
				formatItem: function (data) {
				  return '"' + data.empName + '" (' + data.districtName + '-' + data.depName + ')';
				},
				onSelect: function (data, $item){
					var flag = false;
					$.each($("input[id^=empid]"), function(){
						if($(this).val() == data.id){
							flag = true;
						}
					});
					if(!flag){
						var count = $('#attendances_count').val();
						if(count == "" || count == null) count = 0;
						$('#attendances_count').val(1+parseInt(count));
					}
				}, 
				param: 'fullName'
			}
		});
		<c:if test="${conference ne null && attendance_name_show ne null}">
		json =${attendance_name_show} ;
		$('#conferene_attendances').manifest("add",
				json);
		</c:if>
	});
	
</script>

<!--- 生成需要展现文件的JSON -->
<c:if test="${(op eq null || op ne 'view') && (conference ne null && conference.id ne null && fn:length(conference.attachFiles) gt 0)}">
<script type="text/uploader-restore" id="jp_J_UploaderRestore">
${tm:fileRestoreByType(conference['attachFiles'],"conference_attach")}
</script>

<script type="text/uploader-restore" id="jp_J_UploaderRestore_1">
${tm:fileRestoreByType(conference['attachFiles'],"conference_process")}
</script>
</c:if>
<!--  ${attendance_name_show ne null ? attendance_name_show:'no persions'} -->
<div class="pageContent">
	<form method="post" action="app/personal/conference.do?action=actionConferenceSave" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="float: right; width: 200px;">
				<div class="accordion">
					<div class="accordionHeader">
						<h2><span>icon</span>按校区</h2>
					</div>
					<div class="accordionContent" style="height: 260px;">
						<%@ include file="conference/data/dataDistrictTree.jsp"%>
					</div>
					<div class="accordionHeader">
						<h2><span>icon</span>按部门</h2>
					</div>
					<div class="accordionContent" style="height: 260px;">
						<%@ include file="conference/data/dataDepartmentTree.jsp"%>
					</div>
				</div>
			</div>
			
			<div style="margin-right: 220px">
				<table cellspacing="10" cellpadding="10" style="border-spacing:15; border-collapse:collapse;" border="1" id="tbljob">
					<tr>
						<td nowrap class="field">会议名称：</td>
						<td colspan="5"><input name="conferenceName" type="text" class="required" value="${conference ne null && conference.id ne null ? conference.conferenceName : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
						<td nowrap class="field">会议级别：</td>
						<td style="padding: 5px;">
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<select class="combox" name="level" id="combox_level" style="width:120px" ref="combox_cof_type" refUrl="app/base.do?action=actionLoadByTypeAndLevel&type=conference&level={value}">
										<c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.districtType ne 1}">
											<option value="">请选择会议级别</option>
											<option value="公司级别会议" ${conference.level ne null && conference.level eq '公司级别会议' ? 'selected="selected"':'' }>公司级别会议</option>
										</c:if>
										<option value="校区级别会议" ${conference.level ne null && conference.level eq '校区级别会议' ? 'selected="selected"':'' }>校区级别会议</option>
									</select>
								</c:when>
								<c:otherwise>
									<input type="text"  value="${conference.level }" readonly />
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td nowrap class="field">会议类型：</td>
						<td style="padding: 5px;">
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<select class="combox" name="type.id" id="combox_cof_type" defOPKey="请选择会议类型" defOPVal="" style="width:120px">
										<logic:present name="conferenceType">
											<logic:iterate name="conferenceType" id="entity">
												<option value="${entity.id}" ${conference ne null && conference.id ne null && conference.type ne null && conference.type.id eq entity.id ? 'selected="selected"' : ''}>${entity.name}</option>
											</logic:iterate>
										</logic:present>
									</select>
								</c:when>
								<c:otherwise>
									<input type="text"  value="${conference.type.name }" readonly />
								</c:otherwise>
							</c:choose>
						</td>
						<td nowrap class="field">发布校区：</td>
						<td style="padding: 5px;">
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<select class="combox" name="district.id" id="combox_district" style="width:120px" ref="combox_dept" refUrl="app/base.do?action=actionLoadDepartmentByOrg&districtId={value}">
										<option value="">请选择校区</option>
										<logic:present name="districts">
											<logic:iterate name="districts" id="district">
											
											<c:choose>
											<c:when test="${op eq 'edit'}">
												<option value="${district.id}" ${conference ne null && conference.id ne null && conference.district ne null && conference.district.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
											</c:when>
											<c:otherwise>
												<option value="${district.id}" ${currentDistrictId ne null && currentDistrictId eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
											</c:otherwise>
											</c:choose>
											
											</logic:iterate>
										</logic:present>
									</select>
								</c:when>
								<c:otherwise>
									<input type="text"  value="${conference ne null && conference.id ne null && conference.district ne null ? conference.district.districtName : ''}" readonly />
								</c:otherwise>
							</c:choose>
						</td>
						<td nowrap class="field">发布部门：</td>	
						<td style="padding: 5px;">
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<select class="combox" name="department.id" id="combox_dept" defOPKey="请选择部门" defOPVal="" style="width:120px">
										
										<logic:present name="select_departments">
											<logic:iterate name="select_departments" id="entity">
											<c:choose>
											<c:when test="${op eq 'edit'}">
												<option value="${entity.id}" ${conference ne null && conference.id ne null && conference.department ne null && conference.department.id eq entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
											</c:when>
											<c:otherwise>
												<option value="${entity.id}" ${currentDepId ne null && currentDepId eq entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
											</c:otherwise>
											</c:choose>
											</logic:iterate>
										</logic:present>
									</select>
								</c:when>
								<c:otherwise>
									<input name="department.id" type="text"  value="${conference ne null && conference.id ne null && conference.department ne null ? conference.department.depName : ''}" readonly />
								</c:otherwise>
							</c:choose>
						</td>
						<td nowrap class="field">会议地址：</td>
						<td style="width: 120px; padding: 5px;"><input name="address" class="textInput required" value="${conference ne null ? conference.address : '' }" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					</tr>
					<tr>
						<td class="field">开始时间：</td>
						<td style=" padding: 5px;" colspan='3'>
							<input name="startDay" class="${op ne null && op eq 'view' ? '' : 'date'} textInput required" style="width:70px;float:left;margin:0" value="<fmt:formatDate value="${conference.startDay}" type="date" pattern="yyyy-MM-dd"/>"  ${op ne null && op eq 'view' ? 'readonly' : ''}/>
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<select name="startHour" style="margin-left:5px;float:none">
										<option value="08" ${conference ne null && conference.id ne null && conference.startHour eq '08' ? 'selected="selected"':'' }>08</option>
										<option value="09" ${conference ne null && conference.id ne null && conference.startHour eq '09' ? 'selected="selected"':'' }>09</option>
										<option value="10" ${conference ne null && conference.id ne null && conference.startHour eq '10' ? 'selected="selected"':'' }>10</option>
										<option value="11" ${conference ne null && conference.id ne null && conference.startHour eq '11' ? 'selected="selected"':'' }>11</option>
										<option value="12" ${conference ne null && conference.id ne null && conference.startHour eq '12' ? 'selected="selected"':'' }>12</option>
										<option value="13" ${conference ne null && conference.id ne null && conference.startHour eq '13' ? 'selected="selected"':'' }>13</option>
										<option value="14" ${conference ne null && conference.id ne null && conference.startHour eq '14' ? 'selected="selected"':'' }>14</option>
										<option value="15" ${conference ne null && conference.id ne null && conference.startHour eq '15' ? 'selected="selected"':'' }>15</option>
										<option value="16" ${conference ne null && conference.id ne null && conference.startHour eq '16' ? 'selected="selected"':'' }>16</option>
										<option value="17" ${conference ne null && conference.id ne null && conference.startHour eq '17' ? 'selected="selected"':'' }>17</option>
										<option value="18" ${conference ne null && conference.id ne null && conference.startHour eq '18' ? 'selected="selected"':'' }>18</option>
										<option value="19" ${conference ne null && conference.id ne null && conference.startHour eq '19' ? 'selected="selected"':'' }>19</option>
										<option value="20" ${conference ne null && conference.id ne null && conference.startHour eq '20' ? 'selected="selected"':'' }>20</option>
										<option value="21" ${conference ne null && conference.id ne null && conference.startHour eq '21' ? 'selected="selected"':'' }>21</option>
										<option value="22" ${conference ne null && conference.id ne null && conference.startHour eq '22' ? 'selected="selected"':'' }>22</option>
									</select>
								</c:when>
								<c:otherwise>
									<input type="text" value="${conference.startHour}" style="width:50px;float;none;margin:0" readonly />
								</c:otherwise>
							</c:choose>
						<strong>:</strong>
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<select name="startMinute" style="margin-left:5px;float:none">
										<option value="00" ${conference ne null && conference.id ne null && conference.startMinute eq '00' ? 'selected="selected"':''}>00</option>
										<option value="10" ${conference ne null && conference.id ne null && conference.startMinute eq '10' ? 'selected="selected"':''}>10</option>
										<option value="20" ${conference ne null && conference.id ne null && conference.startMinute eq '20' ? 'selected="selected"':''}>20</option>
										<option value="30" ${conference ne null && conference.id ne null && conference.startMinute eq '30' ? 'selected="selected"':''}>30</option>
										<option value="40" ${conference ne null && conference.id ne null && conference.startMinute eq '40' ? 'selected="selected"':''}>40</option>
										<option value="50" ${conference ne null && conference.id ne null && conference.startMinute eq '50' ? 'selected="selected"':''}>50</option>
									</select>
								</c:when>
								<c:otherwise>
									<input type="text" value="${conference.startMinute}" style="width:50px;float:none;margin:0" readonly />
								</c:otherwise>
							</c:choose>
						</td>
						<td class="field">结束时间：</td>
						<td style=" padding: 5px;" colspan="3">
							<input name="endDay" class="${op ne null && op eq 'view' ? '' : 'date'} textInput required" style="width:70px;float:left;margin:0" value="<fmt:formatDate value="${conference.endDay}" type="date" pattern="yyyy-MM-dd"/>" ${op ne null && op eq 'view' ? 'readonly' : ''}/>
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<select name="endHour" style="margin-left:5px;float:none">
										<option value="08" ${conference ne null && conference.id ne null && conference.endHour eq '08' ? 'selected="selected"':'' }>08</option>
										<option value="09" ${conference ne null && conference.id ne null && conference.endHour eq '09' ? 'selected="selected"':'' }>09</option>
										<option value="10" ${conference ne null && conference.id ne null && conference.endHour eq '10' ? 'selected="selected"':'' }>10</option>
										<option value="11" ${conference ne null && conference.id ne null && conference.endHour eq '11' ? 'selected="selected"':'' }>11</option>
										<option value="12" ${conference ne null && conference.id ne null && conference.endHour eq '12' ? 'selected="selected"':'' }>12</option>
										<option value="13" ${conference ne null && conference.id ne null && conference.endHour eq '13' ? 'selected="selected"':'' }>13</option>
										<option value="14" ${conference ne null && conference.id ne null && conference.endHour eq '14' ? 'selected="selected"':'' }>14</option>
										<option value="15" ${conference ne null && conference.id ne null && conference.endHour eq '15' ? 'selected="selected"':'' }>15</option>
										<option value="16" ${conference ne null && conference.id ne null && conference.endHour eq '16' ? 'selected="selected"':'' }>16</option>
										<option value="17" ${conference ne null && conference.id ne null && conference.endHour eq '17' ? 'selected="selected"':'' }>17</option>
										<option value="18" ${conference ne null && conference.id ne null && conference.endHour eq '18' ? 'selected="selected"':'' }>18</option>
										<option value="19" ${conference ne null && conference.id ne null && conference.endHour eq '19' ? 'selected="selected"':'' }>19</option>
										<option value="20" ${conference ne null && conference.id ne null && conference.endHour eq '20' ? 'selected="selected"':'' }>20</option>
										<option value="21" ${conference ne null && conference.id ne null && conference.endHour eq '21' ? 'selected="selected"':'' }>21</option>
										<option value="22" ${conference ne null && conference.id ne null && conference.endHour eq '22' ? 'selected="selected"':'' }>22</option>
									</select>
								</c:when>
								<c:otherwise>
									<input type="text" value="${conference.endHour}" style="width:50px;float:none;margin:0" readonly />
								</c:otherwise>
							</c:choose>
						<strong>:</strong>
							<c:choose>
								<c:when test="${op eq null || op ne 'view'}">
									<select name="endMinute" style="margin-left:5px;float:none">
										<option value="00" ${conference ne null && conference.id ne null && conference.endMinute eq '00' ? 'selected="selected"':''}>00</option>
										<option value="10" ${conference ne null && conference.id ne null && conference.endMinute eq '10' ? 'selected="selected"':''}>10</option>
										<option value="20" ${conference ne null && conference.id ne null && conference.endMinute eq '20' ? 'selected="selected"':''}>20</option>
										<option value="30" ${conference ne null && conference.id ne null && conference.endMinute eq '30' ? 'selected="selected"':''}>30</option>
										<option value="40" ${conference ne null && conference.id ne null && conference.endMinute eq '40' ? 'selected="selected"':''}>40</option>
										<option value="50" ${conference ne null && conference.id ne null && conference.endMinute eq '50' ? 'selected="selected"':''}>50</option>
									</select>
								</c:when>
								<c:otherwise>
									<input type="text" value="${conference.endMinute}" style="width:50px;float:none;margin:0" readonly />
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="field">参会人员：</td>
						<td colspan="5"><input id="conferene_attendances" name="attendances" type="text" style="width: 100%;${op ne null && op eq 'view' ? 'display:none': ''}" /></td>
						<td class="field">参会人数：</td>
						<td><input id="attendances_count" type="text" name="count" value="${conference ne null && conference.id ne null ? conference.count : '' }" style="width:70px;float:left;margin:0" ${op ne null && op eq 'view' ? 'readonly' : ''}/>人	</td>
					</tr>
					<tr>
						<td class="field">联系人：</td>
						<td colspan="3">
						<!--input name="contactor" type="text" value="${conference ne null ? conference.contactor : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''} /-->
						<input id="inputEmpId" name="emp.id" value="" type="hidden"/>
						<input class="required" name="emp.fullName" type="text" value="${conference ne null && conference.id ne null ? conference.contactor : ''}" <c:choose><c:when test="${op ne null && op eq 'view'}">readonly</c:when> <c:otherwise>postField="fullName" suggestFields="fullName,phoneNo" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" </c:otherwise></c:choose>/>
						</td>
						<td class="field" style="vertical-align: top;">联系电话：</td>
						<td colspan="3"><input name="emp.phoneNo" type="text" value="${conference ne null && conference.id ne null ? conference.phone : ''}"  ${op ne null && op eq 'view' ? 'readonly' : ''} /></td>
					</tr>
					<tr>
						<td class="field" style="vertical-align: top;">会议内容：</td>
						<td colspan="7"><textarea name="content" rows="3" ${op ne null && op eq 'view' ? 'readonly' : ''}>${conference ne null ? conference.content : ''}</textarea></td>
					</tr>
					<c:if test="${conference ne null && conference.id ne null}">
						<tr>
							<td class="field" style="vertical-align: top;">会议总结：</td>
							<td colspan="7"><textarea rows="3" ${op ne null && op eq 'view' ? 'readonly' : ''}>${conference ne null ? conference.summary : ''}</textarea></td>
						</tr>
					</c:if>
					<tr>
						<td class="field" style="vertical-align: top;">会议议程：</td>
						<td colspan="7" style="padding: 5px;">
							<div>
								<c:choose>
									<c:when test="${op eq null || op ne 'view'}">
										<!-- 上传按钮，组件配置请写在data-config内 -->
										<a id="jp_J_UploaderBtn_1" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件 </a>
										<!-- 文件上传队列 -->
										<ul id="jp_J_UploaderQueue_1"></ul>
										<div id="J_Panel" class="event-panel"></div>
										<input type="hidden" name="fileUrls_1" id="fileUrls_1" />
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${conference ne null && conference.id ne null && fn:length(conference.attachFiles) gt 0}">
												<ul>
													<logic:iterate name="conference" property="attachFiles" id="file">
														<c:if test="${file.fileType eq 'conference_process' }">
															<li class="item_file"><a title="点击下载`${file.fileName}`文件" href="file-download?path=${file.filePath}" target="_blank">${file.fileName}</a></li>
														</c:if>
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
					<c:if test="${op ne null && op eq 'view'  && (conference ne null && conference.id ne null && conference.summary ne null) }">
					<tr>
						<td class="field" style="vertical-align: top;">会议记录：</td>
						<td colspan="7" style="padding: 5px;">
							<div>
								<ul>
									<logic:iterate name="conference" property="attachFiles" id="file">
										<c:if test="${file.fileType eq 'conference_summary' }">
											<li class="item_file"><a title="点击下载`${file.fileName}`文件" href="file-download?path=${file.filePath}" target="_blank">${file.fileName}</a></li>
										</c:if>
									</logic:iterate>
								</ul>
							</div>
							<!--<a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="上传附件">上传附件</a>-->
						</td>
					</tr>
					</c:if>
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
											<c:when test="${conference ne null && conference.id ne null && fn:length(conference.attachFiles) gt 0}">
												<ul>
													<logic:iterate name="conference" property="attachFiles" id="file">
														<c:if test="${file.fileType eq 'conference_attach' }">
															<li class="item_file"><a title="点击下载`${file.fileName}`文件" href="file-download?path=${file.filePath}" target="_blank">${file.fileName}</a></li>
														</c:if>
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
		</div>
		<div class="formBar">
			<ul>
				<c:if test="${conference ne null && conference.id ne null && conference.status eq '1'}">
					<a target="dialog" href="app/message.do?action=dialogMessagePage" mask="true" width="880" height="400" class="buttonActive"><span>参加反馈</span></a>
				</c:if>
				<c:choose>
					<c:when test="${op eq 'edit'}">
						<li><div class="buttonActive"><div class="buttonContent"><button type="submit">会议调整</button></div></div></li>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${conference eq null || conference.id eq null}">
								<li><div class="buttonActive"><div class="buttonContent"><button type="submit">会议发起</button></div></div></li>
							</c:when>
						</c:choose>
					</c:otherwise>
				</c:choose>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${conference ne null && conference.id ne null ? conference.id : '-1'}" />
		<input type="hidden" name="status" value="${conference ne null && conference.id ne null ? conference.status : '1' }" />
	</form>
</div>