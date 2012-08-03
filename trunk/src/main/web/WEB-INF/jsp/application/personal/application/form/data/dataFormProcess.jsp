<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<style>
	.color_block {width: 16px; height: 16px;}
	.audit  {background-color: #DDDDDD} /* 审核未到达 */
	.audit0 {background-color: #688}	/* 审核忽略 */
	.audit1 {background-color: #FF7300} /* 审核中 */
	.audit2 {background-color: #9FEA7B} /* 审核通过 */
	.audit3 {background-color: #DA251C} /* 审核未通过 */
	.audit4 {background-color: #DAB177} /* 审核退回 */
	
</style>

<script>
	<c:if test="${tm:ifGranted('_FUNCKEY_HRM_DEVELOP_APPROVE')}">
	$(function(){
		$("a[id^=auditPost]").unbind("click");
		$("a[id^=auditPost]").click(function(){
			var id = $(this).attr("id").substr("auditPost".length);
			var form_ele = $("#auditForm"+id);
			if (form_ele.size() > 0) {
				if (form_ele.find("input[type=radio]").filter(":checked").size() == 0) {
					alert("请选择审批状态...");
					return;
				} else {
					var state = form_ele.find("input[type=radio]").filter(":checked").attr("value");
					var comments = form_ele.find("textarea").val();
					alertMsg.confirm("您确定进行该环节的审批操作么?", {
						okCall: function(){
							$.post("app/personal/application_form.do?action=actionApproveProcess", {"id": id, "state": state, "comments": comments, "formNo": "${entity.formNo}", "catkey": "${CATKEY}"}, function(){
								// 重新加载当前的navTab
								navTab.reload(navTab.getCurrentTabUrl(), {navTabId: navTab.getCurrentTabId()});
								// 重新加载当前弹框页面数据
								if ($.pdialog._current != null) {
									$.pdialog.reload("app/personal/application_form.do?action=dialogApplicationFormPage&formId=${entity.id}&op=view")
								}
							}, "json");
						}
					});
				}
			}
		});
	});
	</c:if>
</script>

<div>
	<!-- 审批状态 -->
	<c:if test="${op ne null && op eq 'view'}">
		<div style="padding: 10px 0px; border-bottom: 1px dotted #999; margin: 0 10px 15px 10px; overflow: auto; clear: both;">
			<div style="color:#FF7300; line-height: 18px;">${entity.applyForm eq null || fn:length(entity.applyForm) == 0 ? '历史审批记录' : '审批流程'}：</div>
		</div>
		<table id="tblexp" cellpadding="0" cellspacing="0" width="98%" border="1" style="border-collapse: collapse; border-color: #797979; margin: 0 auto;">
			<c:choose>
				<c:when test="${entity.applyForm eq null || fn:length(entity.applyForm) == 0}">
					<logic:present name="entity" property="processHistory">
						<logic:iterate name="entity" property="processHistory" id="entity">
							<tr>
								<td width="15%" class="audit${entity.auditState}" style="line-height: 35px;">
									${entity.toDepartmentNames}-${entity.toPositionNames ne null ? entity.toPositionNames : '未知'}
									<c:choose>
										<c:when test="${entity.taskType eq 1 || entity.taskType eq 2}">(校区)</c:when>
										<c:when test="${entity.taskType eq 3 || entity.taskType eq 4}">(总部)</c:when>
										<c:otherwise>(未知)</c:otherwise>
									</c:choose>
									审批
								</td>
								<td style="padding:0 5px;">
									<c:choose>
										<c:when test="${entity.auditState eq 1}">
											<table style="padding:5px 0; width:100%;" cellpadding="0" cellspacing="0" id="auditForm${entity.id}">
												<tr>
													<td width="90%"><textarea style="width: 99%; height: 40px;"></textarea></td>
													<td rowspan="2"><a class="button" id="auditPost${entity.id}" href="javascript:void(0);" style="margin-left:10px;"><span>审核提交</span></a></td>
												</tr>
												<tr>
													<td align="right">
														<input type="radio" name="auditState${entity.id}" id="auditState${entity.id}_2" value="2" />通过 
														<input type="radio" name="auditState${entity.id}" id="auditState${entity.id}_3" value="3" />不通过 
														<input type="radio" name="auditState${entity.id}" id="auditState${entity.id}_4" value="4" />退回 
													</td>
												</tr>
											</table>
										</c:when>
										<c:otherwise>${entity.auditState ne null ? entity.auditIdea : ''}</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</logic:iterate>
					</logic:present>
				</c:when>
				<c:otherwise>
					<logic:present name="entity" property="applyForm">
						<logic:iterate name="entity" property="applyForm" id="entity">
							<tr>
								<td width="18%" class="audit${entity.auditState}" style="line-height: 35px;">
									${entity.toDepartmentNames}-${entity.toPositionNames ne null ? entity.toPositionNames : '未知'}
									<c:choose>
										<c:when test="${entity.taskType eq 1 || entity.taskType eq 2}">(校区)</c:when>
										<c:when test="${entity.taskType eq 3 || entity.taskType eq 4}">(总部)</c:when>
										<c:when test="${entity.taskType eq 5}">(调动/晋升校区)</c:when>
										<c:otherwise>未知</c:otherwise>
									</c:choose>
									审批
								</td>
								<td style="padding:0 5px;">
									<c:choose>
										<c:when test="${entity.auditState eq 1}">
											<c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.positionId eq entity.toPositionIds && tm:ifGranted('_FUNCKEY_HRM_DEVELOP_APPROVE')}">
												<c:if test="${entity.toDistrictIds eq null || sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.districtId eq entity.toDistrictIds}">
													<table style="padding:5px 0; width:100%;" cellpadding="0" cellspacing="0" id="auditForm${entity.id}">
														<tr>
															<td width="90%"><textarea style="width: 99%; height: 40px;"></textarea></td>
															<td rowspan="2"><a class="button" id="auditPost${entity.id}" href="javascript:void(0);" style="margin-left:10px;"><span>审核提交</span></a></td>
														</tr>
														<tr>
															<td align="right">
																<input type="radio" name="auditState${entity.id}" id="auditState${entity.id}_2" value="2" />通过 
																<input type="radio" name="auditState${entity.id}" id="auditState${entity.id}_3" value="3" />不通过 
																<input type="radio" name="auditState${entity.id}" id="auditState${entity.id}_4" value="4" />退回 
															</td>
														</tr>
													</table>
												</c:if>
											</c:if>
										</c:when>
										<c:otherwise>${entity.auditState ne null ? (entity.auditState eq 0 ? '由于无法触及该节点,流程略过...' : entity.auditIdea) : ''}</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</logic:iterate>
					</logic:present>
				</c:otherwise>
			</c:choose>
		</table>
		<div align="right" class="box" style="margin:15px 10px;float:right; clear:both;">
			<ul>
				<li style="float:left; line-height: 14px; margin-right:8px;">
					<label class='color_block audit1' style='float:left; width:16px; height:16px; padding:0; display: inline-block;'></label>
					<span class='text' style="padding:0 2px;">正在进行的环节</span>
				</li>
				<li style="float:left; line-height: 14px; margin-right:8px;">
					<label class='color_block audit2' style='float:left; width:16px; height:16px; padding:0; display: inline-block;'></label>
					<span class='text' style="padding:0 2px;">审批通过的环节</span>
				</li>
				<li style="float:left; line-height: 14px; margin-right:8px;">
					<label class='color_block audit3' style='float:left; width:16px; height:16px; padding:0; display: inline-block;'></label>
					<span class='text' style="padding:0 2px;">审批未通过的环节</span>
				</li>
				<li style="float:left; line-height: 14px; margin-right:8px;">
					<label class='color_block audit4' style='float:left; width:16px; height:16px; padding:0; display: inline-block;'></label>
					<span class='text' style="padding:0 2px;">审批被退回的环节</span>
				</li>
				<li style="float:left; line-height: 14px; margin-right:8px;">
					<label class='color_block audit' style='float:left; width:16px; height:16px; padding:0; display: inline-block;'></label>
					<span class='text' style="padding:0 2px;">还未触及的环节</span>
				</li>
				<li style="float:left; line-height: 14px; margin-right:8px;">
					<label class='color_block audit0' style='float:left; width:16px; height:16px; padding:0; display: inline-block;'></label>
					<span class='text' style="padding:0 2px;">被略过的环节</span>
				</li>
			</ul>
			<b class="clear"></b>
		</div>
	</c:if>
</div>
