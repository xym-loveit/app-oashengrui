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
	#tblexp td.banner {line-height: ${op eq null || op ne 'view' ? '35px' : '25px'};font-size: 18px; font-weight: bold; text-align: center; margin: 0;}
	#tblexp td.field {background-color: #CFDBEC; line-height: ${op eq null || op ne 'view' ? '35px' : '25px'}; text-align: center; margin: 0; width: 120px; font-size: 9pt;}
	#tblexp input.textInput {float:none;margin: 5px; width: 80px;}
</style>

<script>
	$(function(){
		$("#enRMB").keyup(function(){
			$("#cnRMB").val(Arabia_to_Chinese(this.value));
		});
		
		<logic:present name="entity">
			$("#cnRMB").val(Arabia_to_Chinese("${entity.applyAmt}"));
		</logic:present>
	
	});
</script>

<div class="pageContent">
	<form method="post" action="app/finan/contract.do?action=actionFinanContractFormSave" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="padding: 10px 0px; border-bottom: 1px dotted #999; margin: 0 10px 15px 10px; overflow: auto; clear: both;">
				<c:choose>
					<c:when test="${op ne null && op eq 'view'}"><span style="float:left; color:#FF7300; line-height: 18px;">所选费用支出类型：<b>${entity.applyFormType.processTypeName}</b></span></c:when>
					<c:otherwise>
						<span style="float:left; color:#FF7300; line-height: 18px;">合同类型：</span>
						<select class="combox required" name="applyFormTypeId" id="expense_type">
							<logic:present name="types">
								<logic:iterate name="types" id="typeEntity">
									<option value="${typeEntity.id}" ${entity ne null && entity.applyFormType ne null && entity.applyFormType.id eq typeEntity.id ? "selected='selected'" : ""}>${typeEntity.processTypeName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</c:otherwise>
				</c:choose>
			</div>
			<table id="tblexp" cellpadding="0" cellspacing="0" width="98%" border="1" style="border-collapse: collapse; border-color: #797979; margin: 0 auto;">
				<tr>
					<td width="${op eq null || op ne 'view' ? '72%' : '100%'}" colspan="10" class="banner">合同审批申请单</td>
					<c:if test="${op eq null || op ne 'view'}">
					<td align="center" class="banner">合同说明</td>
					</c:if>
				</tr>
				<tr>
					<td class='field'>经办人</td>
					<td>
						<input id="inputEmpId" name="emp.id" value="" type="hidden"/>
						<input class="required" name="emp.fullName" type="text" value="${entity ne null ? entity.employee.empName : ''}" <c:choose><c:when test="${op ne null && op eq 'view'}">readonly</c:when> <c:otherwise>postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" </c:otherwise></c:choose>/>
					</td>
					<td class='field'>日期</td>
					<td><input name="applyDate" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required textInput" format="yyyy-MM-dd" type="text" value="<c:if test='${entity ne null}'><fmt:formatDate value='${entity.applyDate}' pattern='yyyy-MM-dd' /></c:if>" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>></td>
					<td class='field'>所属校区</td>
					<td>
						<input name="emp.districtName" readonly type="text" value="${entity ne null ? entity.empDistrict.districtName : ''}"/>
						<input id="inputEmpDisId" name="emp.districtId" value="" type="hidden"/>
					</td>
					<td class='field'>所属部门</td>
					<td>
						<input name="emp.depName" readonly type="text" value="${entity ne null ? entity.empDepartment.depName : ''}"/>
						<input id="inputEmpDepId" name="emp.depId" value="" type="hidden"/>
					</td>
					<td class='field'>联系电话</td>
					<td><input name="emp.phoneNo" class="required phone" type="text" value="${entity ne null ? entity.empPhoneNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<c:if test="${op eq null || op ne 'view'}">
					<td rowspan="5" style="line-height: 20px; padding: 0 4px;">业务招待费指用于业务及相关活动的应酬费用，如餐费、礼品费等。</td>
					</c:if>
				</tr>
				<tr>
					<td class='field'>合同事项说明</td>
					<td colspan="9"><textarea name="comments" rows="1" style="width: 98%; height: 80px; margin: 5px;" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>>${entity ne null ? entity.comments : ''}</textarea></td>
				</tr>
				<tr>
					<td class='field'>合同总金额</td>
					<td colspan="4"><input name="applyAmt" class="required number" id="enRMB" type="text" style="width: 83%" value="${entity ne null ? entity.applyAmt : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if> />￥小写</td>
					<td colspan="5"><input id="cnRMB" readonly type="text" style="color: #999999;width: 83%" value="根据小写自动生成" />￥大写</td>
				</tr>
				<tr>
					<td class='field'>合同编号</td>
					<td colspan="4"><input name="contractNo" type="text" style="width: 95%" value="${entity ne null ? entity.contractNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<td class='field'>签约方</td>
					<td><input name="contractParties" type="text" class="required" style="" value="${entity ne null ? entity.contractParties : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<td class='field'>签约方联系方式</td>
					<td colspan="2">
						<input name="contractPartiesContact" class="required phone" type="text" style="width: 157px;" value="${entity ne null ? entity.contractPartiesContact : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/>
					</td>
				</tr>
				<tr>
					<td class='field'>付款方式</td>
					<td colspan="9"><textarea name="payMethod" rows="1" style="width: 98%; height: 80px; margin: 5px;" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>>${entity ne null ? entity.payMethod : ''}</textarea></td>
				</tr>
			</table>
			
			<!-- 审批状态 -->
			<%@ include file="../data/dataFinaFormProcess.jsp" %>
			
		</div>
		
		<div class="formBar">
			<ul>
				<c:if test="${op eq null || op ne 'view'}">
					<c:if test="${tm:ifGranted('_FUNCKEY_FINAN_CONTRACT_APPROVE')}">
						<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交申请</button></div></div></li>
					</c:if>
				</c:if>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${entity ne null ? entity.id : -1}" />
		<input type="hidden" name="page_type" value="FC" />
	</form>
</div>