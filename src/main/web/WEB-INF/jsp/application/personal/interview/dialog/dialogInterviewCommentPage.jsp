<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
</style>

<script>
	
	$(function(){
		
		<c:if test="${op eq null || op ne 'view'}">
		//加载上传组件入口文件
		KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
			var ru = new RenderUploader('#dicp_J_UploaderBtn', '#dicp_J_UploaderQueue',{
				 //服务器端配置
				serverConfig:{
					//处理上传的服务器端脚本路径
					action:"file-upload"
				},
				// 文件域
				name:"Filedata",
				//用于放服务器端返回的url的隐藏域
				urlsInputName:"fileUrls",
				//验证配置
				authConfig: {
					max:[1, "最多上传{max}个文件！"],
					allowRepeat:[false, "该文件已经存在！"]
				}
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

<form method="post" action="app/personal/interview.do?action=actionDoComment" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<!-- SearchBar -->
	<div class="pageHeader">
		<table cellspacing="10" cellpadding="10" style="border-spacing:12; width:100%">
			<tr>
				<td nowrap style="width:60px">面试意见：</td>
				<td>
					<input type="radio" name="interviewStatus" value="2" checked="checked" />建议通过&nbsp;
					<input type="radio" name="interviewStatus" value="3" />建议淘汰&nbsp;
					<input type="radio" name="interviewStatus" value="4" />未到现场
				</td>
			</tr>
			<tr>
				<td nowrap style="vertical-align: top;">面试说明：</td>
				<td>
					<textarea name="interviewComments" rows="2" style="width:100%"></textarea>
				</td>
			</tr>
			<tr>
				<td nowrap style="vertical-align: top;">面试附件：</td>
				<td>
					<div>
						<span style="float:right;line-height:20px">(最多只能上传1个文件...)</span>
						<!-- 上传按钮，组件配置请写在data-config内 -->
						<a id="dicp_J_UploaderBtn" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件</a>
						<!-- 文件上传队列 -->
						<ul id="dicp_J_UploaderQueue"></ul>
						<div id="J_Panel" class="event-panel"></div>
						<input type="hidden" name="fileUrls" id="fileUrls" />
						<input type="hidden" name="fileIds" id="fileIds" />
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right"><div class="buttonActive" style="float:right"><div class="buttonContent"><button type="submit">意见提交</button></div></div></td>
			</tr>
		</table>
	</div>

	<div class="pageContent">
		<table class="table" width="100%" layoutH="225">
			<thead>
				<tr>
					<th align="center">面试官姓名</th>
					<th align="center">面试环节</th>
					<th align="center">面试时间</th>
					<th align="center">建议结果</th>
					<th align="center" width="30%">备注信息</th>
					<th align="center">附件</th>
				</tr>
			</thead>
			<tbody>
				<logic:present name="hireJobInterviews">
					<logic:iterate name="hireJobInterviews" property="items" id="entity">
						<c:if test="${interviewId ne entity.id}">
							<tr target="interview_id" rel="${entity.id}">
								<td>${entity.interviewer.fullName}</td>
								<td>${entity.sessionSN eq 1 ? '一面' : (entity.sessionSN eq 2 ? '二面' : (entity.sessionSN eq 3 ? '三面' : '未知'))}</td>
								<td><fmt:formatDate  value="${entity.interviewDate}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
								<td class="iflag-${entity.interviewStatus}">${entity.interviewStatus eq 0 ? '待面试' : (entity.interviewStatus eq 1 ? '面试' : (entity.interviewStatus eq 2 ? '通过' : (entity.interviewStatus eq 3 ? '淘汰' : (entity.interviewStatus eq 4 ? '未到' : ''))))}</td>
								<td>${entity.interviewComments}</td>
								<td><!--<a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="ajaxdo" title="下载附件">下载</a>--></td>
							</tr>
						</c:if>
					</logic:iterate>
				</logic:present>
			</tbody>
		</table>

		<!-- Pagination -->
		<div class="panelBar">
			<div class="pages">
				<span>显示</span>
				<select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
					<option value="20" ${pagingBean ne null && pagingBean.pageSize eq 20 ? 'selected="selected"' : ''}>20</option>
					<option value="50" ${pagingBean ne null && pagingBean.pageSize eq 50 ? 'selected="selected"' : ''}>50</option>
					<option value="100" ${pagingBean ne null && pagingBean.pageSize eq 100 ? 'selected="selected"' : ''}>100</option>
					<option value="200" ${pagingBean ne null && pagingBean.pageSize eq 200 ? 'selected="selected"' : ''}>200</option>
				</select>
				<span>条，共${pagingBean ne null ? pagingBean.totalItems - 1 : 0}条</span>
			</div>	
			<div class="pagination" targetType="navTab" totalCount="${pagingBean ne null ? pagingBean.totalItems : 0}" numPerPage="${pagingBean ne null ? pagingBean.pageSize : 20}" pageNumShown="${pagingBean ne null ? pagingBean.pageNumShown : 10}" currentPage="${pagingBean ne null ? pagingBean.currentPage : 1}"></div>
		</div>
	</div>
	<input type="hidden" name="interviewId" value="${interviewId ne null ? interviewId : -1}" />
</form>
