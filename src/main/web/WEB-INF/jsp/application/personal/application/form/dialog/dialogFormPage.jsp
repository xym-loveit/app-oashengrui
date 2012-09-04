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
	
		$("#hrm_apply_type").unbind("change");
		$("#hrm_apply_type").bind("change", function(){
			var task_type = $(this).find("option").filter(":selected").attr("value");
			if (task_type != "") {
				if ($.pdialog._current) {
					$($.pdialog._current.find("#form_box")).loadUrl("app/personal/application_form.do?action=actionLoadTemplatePage<c:if test='${formId ne null}'>&formId=${formId}</c:if><c:if test='${op ne null}'>&op=${op}</c:if>&procTypeId=" + task_type, {}, function(){
						
					});
				}
			} else {
				$("#form_box").html("");
			}
		});
		
		<logic:present name="procTypeId">
			if ($.pdialog._current) {
				$($.pdialog._current.find("#form_box")).loadUrl("app/personal/application_form.do?action=actionLoadTemplatePage&procTypeId=${procTypeId}<c:if test='${formId ne null}'>&formId=${formId}</c:if><c:if test='${op ne null}'>&op=${op}</c:if>", {}, function(){
				});
			}
		</logic:present>
		
	});
</script>

<div class="pageContent">
	<form method="post" action="app/personal/application_form.do?action=actionSaveApplication" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<c:if test="${entity.applyForm eq null || fn:length(entity.applyForm) == 0}">
			<p align="center" style="display:none" id='tophrm_title'>人资申请"${entity.formNo}"-审批流程表单</p>
			<div align='right' style='margin:5px 10px 0px 0px;'>
				<a class='btn_print' title="点击打印" href="javascript:print_export('#hrm_print_wrapper','#tophrm_title');">打印</a>
			</div>
		</c:if>
		<div class="pageFormContent" id="hrm_print_wrapper" layoutH="56" style="border-top: none">
			<div style="padding: 0px; border-bottom: 1px dotted #999; margin: 0 10px 15px 10px; overflow: auto; clear: both;">
				<c:choose>
					<c:when test="${op ne null && op eq 'view'}"><span style="float:left; color:#FF7300; line-height: 18px;">所选人资申请类型：<b>${entity.applyFormType.processTypeName}</b></span></c:when>
					<c:otherwise>
						<span style="float:left; color:#FF7300; line-height: 18px;">人资申请类型：</span>
						<select class="combox required" name="applyFormTypeId" id="hrm_apply_type">
							<option value="">请选择申请类型</option>
							<logic:present name="types">
								<logic:iterate name="types" id="typeEntity">
									<option value="${typeEntity.id}" ${((procTypeId ne null && procTypeId eq typeEntity.id) || (entity ne null && entity.applyFormType ne null && entity.applyFormType.id eq typeEntity.id)) ? "selected='selected'" : ""}>${typeEntity.processTypeName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</c:otherwise>
				</c:choose>
			</div>
			
			<!-- 申请单 -->
			<div id="form_box"></div>
			
		</div>
		
		<div class="formBar">
			<ul>
				<c:if test="${op eq null || op ne 'view'}">
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交申请</button></div></div></li>
				</c:if>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${entity ne null ? entity.id : -1}" />
	</form>
</div>