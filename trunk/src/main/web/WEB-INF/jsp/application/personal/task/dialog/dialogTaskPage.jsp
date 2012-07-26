<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<style>

/*** Manifest ***/

/* Manifest container that wraps the elements and now acts as, and should be
   styled as, the input. */
div.mf_container {
  border: 1px solid #A2BAC0;
  cursor: text;
  display: inline-block;
  padding: 2px;
  width: 100%;
  min-height: 30px;
}

/* Ordered list for displaying selected items. */
div.mf_container ol.mf_list {
  display: inline;
}

/* Selected item, regardless of state (highlighted, selected). */
div.mf_container ol.mf_list li.mf_item {
  border: 1px solid #C0C0C0;
  cursor: pointer;
  display: inline-block;
  margin: 2px;
  padding: 4px 4px 5px;
}

/* Selected item that's highlighted by mouseover. */
div.mf_container ol.mf_list li.mf_item.mf_highlighted {
  background-color: #E0E0E0;
}

/* Selected item that's selected by click or keyboard. */
div.mf_container ol.mf_list li.mf_item.mf_selected {
  background-color: #C0C0C0;
}

/* Remove link. */
div.mf_container ol.mf_list li.mf_item a.mf_remove {
  color: #E0E0E0;
  margin-left: 10px;
  text-decoration: none;
}

/* Remove link that's highlighted. */
div.mf_container ol.mf_list li.mf_item.mf_highlighted a.mf_remove {
  color: #FFFFFF;
}

/* Remove link that's selected. */
div.mf_container ol.mf_list li.mf_item.mf_selected a.mf_remove {
  color: #FFFFFF;
}

/* Actual input, styled to be invisible within the container. */
div.mf_container input.mf_input {
  border: 0;
  font: inherit;
  font-size: 100%;
  margin: 2px;
  outline: none;
  padding: 4px;
}

/*** Marco Polo ***/

/* Ordered list for display results. */
ol.mp_list {
  background-color: #FFFFFF;
  border-left: 1px solid #C0C0C0;
  border-right: 1px solid #C0C0C0;
  overflow: hidden;
  position: absolute;
  width: 498px;
  z-index: 99999;
}

/* Each list item, regardless of success, error, etc. */
ol.mp_list li {
  border-bottom: 1px solid #C0C0C0;
  padding: 4px 4px 5px 9px;
}

/* Each list item from a successful request. */
ol.mp_list li.mp_item {

}

/* Each list item that's selectable. */
ol.mp_list li.mp_selectable {
  cursor: pointer;
}

/* Currently highlighted list item. */
ol.mp_list li.mp_highlighted {
  background-color: #E0E0E0;
}

/* When a request is made that returns zero results. */
ol.mp_list li.mp_no_results {

}

/* When a request is made that doesn't meet the 'minChars' length option. */
ol.mp_list li.mp_min_chars {

}

/* When a request is made that fails during the ajax request. */
ol.mp_list li.mp_error {

}

</style>

<script src="resources/js/jquery/jmainfest/jquery.ui.widget.min.js" type="text/javascript"></script>
<script src="resources/js/jquery/jmainfest/jquery.marcopolo.min.js" type="text/javascript"></script>
<script src="resources/js/jquery/jmainfest/jquery.manifest.js" type="text/javascript"></script>

<script>
	
	$(function(){
		
		$("#task_btnapproval").unbind("click");
		$("#task_btnapproval").bind("click", function() { 
			$("#auditStatus").val("2");
			$("#formTask").submit();
		});
		
		$("#task_btnback").unbind("click");
		$("#task_btnback").bind("click", function() { 
			$("#auditStatus").val("4");
			$("#formTask").submit();
		});
		
		KISSY.use('gallery/form/1.2/uploader/queue/base', function (S, Queue) {
			var queue = new Queue();
		})

		//加载上传组件入口文件
		KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
			var ru = new RenderUploader('#J_UploaderTaskBtn', '#J_UploaderTaskQueue',{
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
				<c:if test="${entity ne null && fn:length(entity.attachFiles) gt 0}">
				// 用于数据展现
				,restoreHook:"#task_J_UploaderRestore"
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
					alert(file_id);
					if (file_id) {
						$("#fileIds").val($("#fileIds").val() == "" ? file_id : ($("#fileIds").val() + "," + file_id));
					}
				});
				
				uploader.on('error', function (ev) {
					alert("文件上传失败:" + ev.result.message);
				});
				
			});
		});
		
		
		$('#task_participants').manifest({
			// Use each location's full name as the display text.
			formatDisplay: function (data, $item, $mpItem) {
				return data.empName;
			},
			// Use each location's ID as the value to be submitted.
			formatValue: function (data, $value, $item, $mpItem) {
				return data.id;
			},
			<logic:present name="entity" property="taskParticipants">
			values: [{}<logic:iterate name="entity" property="taskParticipants" id="p">,{id: ${p.id}, empName: '${p.empName}'}</logic:iterate>],
			</logic:present>
			valuesName: 'empid'
		});
	});
	
</script>

<!--- 生成需要展现文件的JSON -->
<c:if test="${(op eq null || op ne 'view') && (entity ne null && fn:length(entity.attachFiles) gt 0)}">
<script type="text/uploader-restore" id="task_J_UploaderRestore">
${tm:fileRestore(entity['attachFiles'])}
</script>
</c:if>

<div class="pageContent">
	<form method="post" action="app/personal/task.do?action=actionSaveTaskPlan" class="pageForm required-validate" id="formTask" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<c:if test="${op eq null || op ne 'view'}">
			<div style="float: right; width: 300px;">
				<div class="accordion">
					<div class="accordionHeader">
						<h2><span>icon</span>按校区</h2>
					</div>
					<div class="accordionContent">
						<%@ include file="../data/dataDistrictTree.jsp"%>
					</div>
					<div class="accordionHeader">
						<h2><span>icon</span>按部门</h2>
					</div>
					<div class="accordionContent">
						<%@ include file="../data/dataDepartmentTree.jsp"%>
					</div>
				</div>
			</div>
			</c:if>
			
			<div <c:if test="${op eq null || op ne 'view'}">style="margin-right: 320px"</c:if>>
				<table cellspacing="10" cellpadding="10" style="border-spacing: 12; width: 100%;">
					<tr>
						<td style="line-height: 25px;">任务名称：</td>
						<td colspan="3"><input type="text" name="taskName" class="required" style="width:97%;"  value="${entity ne null ? entity.taskName : ''}"/></td>
						<td style="line-height: 25px;">任务类型：</td>
						<td>
							<select class="combox" id="combox_doc_type" class="required" name="taskTypeId">
								<logic:present name="taskTypes">
									<logic:iterate name="taskTypes" id="taskType">
										<option value="${taskType.id}" ${entity ne
											null && entity.taskType ne
											null && entity.taskType.id eq
											taskType.id ? 'selected="selected"' : ''}>${taskType.value}</option>
									</logic:iterate>
								</logic:present>
							</select>
						</td>
					</tr>
					<tr>
						<td style="line-height: 25px;">任务负责人：</td>
						<td>
							<input type="hidden" name="charger.id" style=""  value="${entity ne null && entity.taskCharger ne null ? entity.taskCharger.id : ''}"/>
							<input type="text" name="charger.fullName" class="required" style=""  value="${entity ne null && entity.taskCharger ne null ? entity.taskCharger.empName : ''}" <c:choose><c:when test="${op ne null && op eq 'view'}">readonly</c:when> <c:otherwise>postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="charger" </c:otherwise></c:choose>/>
						</td>
						<td style="line-height: 25px;">任务开始时间：</td>
						<td><input type="text" name="taskPlannedStartDate" class="required date" style="" value="<c:if test='${entity ne null}'><fmt:formatDate  value='${entity.taskPlannedStartDate}' pattern='yyyy-MM-dd' /></c:if>" ll/></td>
						<td style="line-height: 25px;">任务结束时间：</td>
						<td><input type="text" name="taskPlannedEndDate" class="required date" style="" value="<c:if test='${entity ne null}'><fmt:formatDate  value='${entity.taskPlannedEndDate}' pattern='yyyy-MM-dd' /></c:if>"/></td>
					</tr>
					<tr>
						<td style="line-height: 25px;vertical-align: top">任务参与人：</td>
						<td colspan="5"><input id="task_participants" type="text" name="participants" style="width: 100%; display: none;" /></td>
					</tr>
					<tr>
						<td style="line-height: 25px;vertical-align: top">任务描述：</td>
						<td colspan="5"><textarea name="taskDescription" rows="5" cols="60"
							style="width: 100%"  >${entity ne null ? entity.taskDescription : ''}</textarea></td>
					</tr>
					<tr>
						<td style="vertical-align: top;">附件区：</td>
						<td colspan="7">
							<!-- Uploader Demo-->
							<div>
								<!-- 上传按钮，组件配置请写在data-config内 -->
								<a id="J_UploaderTaskBtn" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件 </a>
								<!-- 文件上传队列 -->
								<ul id="J_UploaderTaskQueue"></ul>
								<div id="J_Panel" class="event-panel"></div>
								<input type="hidden" name="fileUrls" id="fileUrls" />
								<input type="hidden" name="fileIds" id="fileIds" />
							</div>
						</td>
					</tr>
				</table>
			</div>
			
			<c:if test="${op ne null && op eq 'view'}">
			<div style="padding: 0 10px;">
				<div style="color:#FF7300; line-height: 35px;">审批记录</div>
				<table width="100%" class="datalst" rules="all" bordercolor="#CCC" style="height: auto;">
					<thead>
						<tr>
							<th align="center">申请类型</th>
							<th align="center">意向时间</th>
							<th align="center">申请备注</th>
							<th align="center">申请时间</th>
							<th align="center">审批结果</th>
							<th align="center">确认时间</th>
							<th align="center">审批意见</th>
							<th align="center">审批时间</th>
						</tr>
					</thead>
					<tbody>
						<logic:present name="entity">
							<logic:iterate name="entity" property="taskTracks" id="track">
								<tr>
									<td>${track.taskApplyType eq 1 ? '完成申请' : '延期申请'}</td>
									<td><fmt:formatDate value="${track.taskApplyFinalizedDate}" pattern="yyyy-MM-dd" /></td>
									<td>${track.taskApplyMeto}</td>
									<td><fmt:formatDate value="${track.taskApplyDate}" pattern="yyyy-MM-dd" /></td>
									<td>${track.taskAuditState eq 1 ? '通过' : '不通过'}</td>
									<td><c:if test="${track.taskAuditFinalizedDate ne null}"><fmt:formatDate value="${track.taskAuditFinalizedDate}" pattern="yyyy-MM-dd" /></c:if></td>
									<td>${track.taskAuditMeto}</td>
									<td><fmt:formatDate value="${track.taskAuditTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								</tr>
							</logic:iterate>
						</logic:present>
					</tbody>
				</table>
			</div>
			</c:if>
			
		</div>
		<div class="formBar">
			<ul>
				<c:choose>
					<c:when test="${op eq 'audit'}">
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit" id="task_btnapproval">通过</button></div></div></li>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit" id="task_btnback">退回</button></div></div></li>
					</c:when>
					<c:when test="${op eq null || op ne 'view'}">
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交审核</button></div></div></li>
					</c:when>
				</c:choose>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
				<input type="hidden" name="id" value="${entity ne null ? entity.id : -1}" />
				<c:if test="${op ne null && op eq 'audit'}">
					<input type="hidden" id="auditStatus" name="auditStatus" value="" />
				</c:if>
			</ul>
		</div>
	</form>
</div>