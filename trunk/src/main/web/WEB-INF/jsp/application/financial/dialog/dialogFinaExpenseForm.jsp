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
	#tblexp td.banner {line-height: ${op eq null || op ne 'view' ? '45px' : '30px'};font-size: 18px; font-weight: bold; text-align: center; margin: 0;}
	#tblexp td.field {background-color: #CFDBEC; line-height: ${op eq null || op ne 'view' ? '45px' : '30px'}; text-align: center; margin: 0; width: 120px; font-size: 9pt;}
	#tblexp input.textInput {float:none;margin: 5px; width: 80px;}
</style>

<script>
	$(function(){
		$("#enRMB").keyup(function(){
			$("#cnRMB").val(Arabia_to_Chinese(this.value));
		});
		
		<logic:present name="employeeExpenseEntry">
			$("#cnRMB").val(Arabia_to_Chinese("${employeeExpenseEntry.applyAmt}"));
		</logic:present>
	
	});
</script>

<div class="pageContent">
	<form method="post" action="app/finan/financial.do?action=actionFinanApplicationFormSave" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="padding: 10px 0px; border-bottom: 1px dotted #999; margin: 0 10px 15px 10px; overflow: auto; clear: both;">
				<c:choose>
					<c:when test="${op ne null && op eq 'view'}"><span style="float:left; color:#FF7300; line-height: 18px;">所选费用支出类型：<b>${employeeExpenseEntry.applyFormType.processTypeName}</b></span></c:when>
					<c:otherwise>
						<span style="float:left; color:#FF7300; line-height: 18px;">请选择费用支出类型：</span>
						<select class="combox required" name="applyFormTypeId" id="expense_type">
							<option value="">请选择申请类型</option>
							<logic:present name="types">
								<logic:iterate name="types" id="entity">
									<option value="${entity.id}" ${employeeExpenseEntry ne null && employeeExpenseEntry.applyFormType ne null && employeeExpenseEntry.applyFormType.id eq entity.id ? "selected='selected'" : ""}>${entity.processTypeName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</c:otherwise>
				</c:choose>
			</div>
			<table id="tblexp" cellpadding="0" cellspacing="0" width="98%" border="1" style="border-collapse: collapse; border-color: #797979; margin: 0 auto;">
				<tr>
					<td width="${op eq null || op ne 'view' ? '72%' : '100%'}" colspan="10" class="banner">费用支出申请单</td>
					<c:if test="${op eq null || op ne 'view'}">
					<td align="center" class="banner">填写说明</td>
					</c:if>
				</tr>
				<tr>
					<td class='field'>经办人</td>
					<td>
						<input id="inputEmpId" name="emp.id" value="" type="hidden"/>
						<input class="required" name="emp.fullName" type="text" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.employee.empName : ''}" <c:choose><c:when test="${op ne null && op eq 'view'}">readonly</c:when> <c:otherwise>postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" </c:otherwise></c:choose>/>
					</td>
					<td class='field'>日期</td>
					<td><input name="applyDate" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required textInput" format="yyyy-MM-dd" type="text" value="<c:if test='${employeeExpenseEntry ne null}'><fmt:formatDate value='${employeeExpenseEntry.applyDate}' pattern='yyyy-MM-dd' /></c:if>" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>></td>
					<td class='field'>所属校区</td>
					<td>
						<input name="emp.districtName" readonly type="text" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.empDistrict.districtName : ''}"/>
						<input id="inputEmpDisId" name="emp.districtId" value="" type="hidden"/>
					</td>
					<td class='field'>所属部门</td>
					<td>
						<input name="emp.depName" readonly type="text" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.empDepartment.depName : ''}"/>
						<input id="inputEmpDepId" name="emp.depId" value="" type="hidden"/>
					</td>
					<td class='field'>联系电话</td>
					<td><input name="emp.phoneNo" class="required phone" type="text" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.empPhoneNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<c:if test="${op eq null || op ne 'view'}">
					<td rowspan="6" style="line-height: 20px; padding: 0 4px;">业务招待费指用于业务及相关活动的应酬费用，如餐费、礼品费等。</td>
					</c:if>
				</tr>
				<tr>
					<td class='field'>费用说明</td>
					<td colspan="9"><textarea name="comments" rows="1" style="width: 98%; height: 80px; margin: 5px;" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>>${employeeExpenseEntry ne null ? employeeExpenseEntry.comments : ''}</textarea></td>
				</tr>
				<tr>
					<td class='field'>支出金额</td>
					<td colspan="3"><input name="applyAmt" class="required number" id="enRMB" type="text" style="width: 200px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.applyAmt : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if> />￥小写</td>
					<td colspan="3"><input id="cnRMB" readonly type="text" style="color: #999999;width: 200px" value="根据小写自动生成" />￥大写</td>
					<td class='field'>付款方</td>
					<td colspan="2">
						<input type="radio" value="0" name="payer" ${employeeExpenseEntry ne null && employeeExpenseEntry.payer eq 0 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 本校区
						<input type="radio" value="1" name="payer" ${employeeExpenseEntry ne null && employeeExpenseEntry.payer eq 1 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 总部
					</td>
				</tr>
				<tr>
					<td class='field'>合同编号</td>
					<td colspan="4"><input name="contractNo" type="text" style="width: 320px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.contractNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<td class='field'>附件张数</td>
					<td><input name="attachCount" type="text" class="number" style="" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.attachCount : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<td class='field'>是否已事前审批</td>
					<td colspan="2">
						<input type="radio" value="1" name="auditAdvance" ${employeeExpenseEntry ne null && employeeExpenseEntry.auditAdvance eq 1 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 是
						<input type="radio" value="0" name="auditAdvance" ${employeeExpenseEntry ne null && employeeExpenseEntry.auditAdvance eq 0 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 否
					</td>
				</tr>
				<tr>
					<td class='field'>固定资产编号</td>
					<td colspan="4"><input name="assetNo"  type="text" style="width: 320px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.assetNo : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<td class='field'>收款方姓名</td>
					<td><input name="amtReceiver" type="text" class="required" style="" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.amtReceiver : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<td class='field'>收款方联系方式</td>
					<td colspan="2">
						<input name="amtReceiverContact" class="required phone" type="text" style="width: 157px;" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.amtReceiverContact : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/>
					</td>
				</tr>
				<tr>
					<td class='field'>付款方式</td>
					<td colspan="2">
						<input type="radio" value="0" name="payMethod" ${employeeExpenseEntry ne null && employeeExpenseEntry.payMethod eq 0 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 现金
						<input type="radio" value="1" name="payMethod" ${employeeExpenseEntry ne null && employeeExpenseEntry.payMethod eq 1 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 转账
					</td>
					<td class='field'>开户银行</td>
					<td><input name="bank" type="text" class="required" style="" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.bank : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<td class='field'>账户名</td>
					<td><input name="accountName" class="required" type="text" style="" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.accountName : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
					<td class='field'>账号</td>
					<td colspan="2">
						<input name="accountNo" class="required" type="text" style="width: 157px;" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.accountNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/>
					</td>
				</tr>
			</table>
			
			<!-- 审批状态 -->
			<%@ include file="../data/dataFinaFormProcess.jsp" %>
			
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
		<input type="hidden" name="id" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.id : -1}" />
	</form>
</div>