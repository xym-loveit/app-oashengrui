<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	#tblexp td.banner {line-height: ${op eq null || op ne 'view' ? '35px' : '25px'};font-size: 18px; font-weight: bold; text-align: center; margin: 0;}
	#tblexp td.field {background-color: #CFDBEC; line-height: ${op eq null || op ne 'view' ? '35px' : '25px'}; text-align: center; margin: 0; width: 120px; font-size: 9pt;}
	#tblexp input.textInput {float:none;margin: 5px; width: 80px;}
</style>

<script>
	$(function(){
		<c:if test="${op eq null || op ne 'view'}">
		//加载上传组件入口文件
		KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
			var ru = new RenderUploader('#jp_DFE_UploaderBtn', '#jp_DFE_UploaderQueue',{
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
				,restoreHook:"#jp_DFE_UploaderRestore"
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
<c:if test="${(op eq null || op ne 'view') && (entity ne null && fn:length(entity.attachFiles) gt 0)}">
<script type="text/uploader-restore" id="jp_DFE_UploaderRestore">
${tm:fileRestore(entity['attachFiles'])}
</script>
</c:if>

<table id="tblexp" cellpadding="0" cellspacing="0" width="98%" border="1" style="border-collapse: collapse; border-color: #797979; margin: 0 auto;">
	<tr>
		<td width="${op eq null || op ne 'view' ? '72%' : '100%'}" colspan="10" class="banner">员工离职申请单</td>
	</tr>
	<tr>
		<td class='field'>申请人</td>
		<td>
			<input id="inputEmpId" name="employee.id" value="${entity ne null ? entity.employee.id : employee.id}" type="hidden"/>
			<input class="required" name="employee.empName" style="width: 87%;" type="text" readonly value="${entity ne null ? entity.employee.empName : employee.empName}" />
		</td>
		<td class='field'>性别</td>
		<td><input name="sex" style="width: 87%;" readonly class="required textInput" format="yyyy-MM-dd" type="text" value="${entity ne null ? (entity.employee.resume.sex eq 1 ? '男' : '女') : (employee.resume.sex eq 1 ? '男' : '女')}" /></td>
		<td class='field'>出生日期</td>
		<td>
			<input name="birthdate" style="width: 87%;" readonly type="text" value="<c:choose><c:when test='${entity ne null}'><fmt:formatDate  value='${entity.employee.birthdate}' pattern='yyyy-MM-dd' /></c:when><c:otherwise><fmt:formatDate  value='${employee.birthdate}' pattern='yyyy-MM-dd' /></c:otherwise></c:choose>"/>
			<input id="inputEmpDisId" name="emp.districtId" value="" type="hidden"/>
		</td>
		<td class='field'>联系电话</td>
		<td><input name="phoneNo" class="required phone" style="width: 87%;" type="text" value="${entity ne null ? entity.employee.phoneNo : employee.phoneNo}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
	</tr>
	<tr>
		<td class='field'>所属校区</td>
		<td colspan="3"><input name="districtName" type="text" readonly style="width: 96%" value="${entity ne null ? entity.fromDistrict.districtName : employee.employeeDistrict.districtName}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/><input type="hidden" name="fromDistrictId" value="${entity ne null ? entity.fromDistrict.id : employee.employeeDistrict.id}" /></td>
		<td class='field'>所属部门</td>
		<td><input name="depName" type="text" readonly style="width: 87%;" value="${entity ne null ? entity.fromDepartment.depName : employee.employeeDepartment.depName}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/><input type="hidden" name="fromDepId" value="${entity ne null ? entity.fromDepartment.id : employee.employeeDepartment.id}" /></td>
		<td class='field'>岗位</td>
		<td colspan="2">
			<input name="posName" readonly class="required" style="width: 87%;" type="text" value="${entity ne null ? entity.fromPosition.positionName : employee.employeePosition.positionName}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/><input type="hidden" name="fromPosId" value="${entity ne null ? entity.fromPosition.id : employee.employeePosition.id}" />
		</td>
	</tr>
	<tr>
		<td class='field'>到岗日期</td>
		<td colspan="3"><input name="onboardTime" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required" type="text" style="width: 96%" value="<c:choose><c:when test='${entity ne null}'><fmt:formatDate  value='${entity.employee.onboardDate}' pattern='yyyy-MM-dd' /></c:when><c:otherwise><fmt:formatDate  value='${employee.onboardDate}' pattern='yyyy-MM-dd' /></c:otherwise></c:choose>"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>申请日期</td>
		<td colspan="3"><input name="applyDate" type="text" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required" style="width: 96%;" value="<c:choose><c:when test='${entity ne null}'><fmt:formatDate  value='${entity.applyDate}' pattern='yyyy-MM-dd' /></c:when><c:otherwise></c:otherwise></c:choose>"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
	</tr>
	<tr>
		<td class='field'>请辞报告</td>
		<td colspan="8"><textarea name="comments" rows="1" style="width: 98%; height: 120px; margin: 5px;" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>>${entity ne null ? entity.comments : ''}</textarea></td>
	</tr>
	<tr>
		<td class='field'>附件</td>
		<td colspan="8" style="padding: 5px;">
			<div>
				<c:choose>
					<c:when test="${op eq null || op ne 'view'}">
						<!-- 上传按钮，组件配置请写在data-config内 -->
						<a id="jp_DFE_UploaderBtn" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件 </a>
						<!-- 文件上传队列 -->
						<ul id="jp_DFE_UploaderQueue"></ul>
						<div id="J_Panel" class="event-panel"></div>
						<input type="hidden" name="fileUrls" id="fileUrls" />
						<input type="hidden" name="fileIds" id="fileIds" />
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${entity ne null && fn:length(entity.attachFiles) gt 0}">
								<ul>
									<logic:iterate name="entity" property="attachFiles" id="file">
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

<!-- 审批状态 -->
<%@ include file="../data/dataFormProcess.jsp" %>
