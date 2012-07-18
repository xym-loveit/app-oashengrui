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

<table id="tblexp" cellpadding="0" cellspacing="0" width="98%" border="1" style="border-collapse: collapse; border-color: #797979; margin: 0 auto;">
	<tr>
		<td width="${op eq null || op ne 'view' ? '72%' : '100%'}" colspan="10" class="banner">申请单</td>
	</tr>
	<tr>
		<td class='field'>申请人</td>
		<td>
			<input id="inputEmpId" name="emp.id" value="" type="hidden"/>
			<input class="required" name="emp.fullName" type="text" value="${entity ne null ? entity.employee.empName : ''}" <c:choose><c:when test="${op ne null && op eq 'view'}">readonly</c:when> <c:otherwise>postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" </c:otherwise></c:choose>/>
		</td>
		<td class='field'>性别</td>
		<td><input name="applyDate" class="<c:if test='${op eq null || op ne \'view\'}'>date</c:if> required textInput" format="yyyy-MM-dd" type="text" value="<c:if test='${entity ne null}'><fmt:formatDate value='${entity.applyDate}' pattern='yyyy-MM-dd' /></c:if>" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>></td>
		<td class='field'>出生日期</td>
		<td>
			<input name="emp.districtName" readonly type="text" value="${entity ne null ? entity.empDistrict.districtName : ''}"/>
			<input id="inputEmpDisId" name="emp.districtId" value="" type="hidden"/>
		</td>
		<td class='field'>联系电话</td>
		<td>
			<input name="emp.depName" readonly type="text" value="${entity ne null ? entity.empDepartment.depName : ''}"/>
			<input id="inputEmpDepId" name="emp.depId" value="" type="hidden"/>
		</td>
		<td class='field'>联系电话</td>
		<td><input name="emp.phoneNo" class="required phone" type="text" value="${entity ne null ? entity.empPhoneNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
	</tr>
	<tr>
		<td class='field'>费用说明</td>
		<td colspan="9"><textarea name="comments" rows="1" style="width: 98%; height: 80px; margin: 5px;" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>>${entity ne null ? entity.comments : ''}</textarea></td>
	</tr>
	<tr>
		<td class='field'>支出金额</td>
		<td colspan="3"><input name="applyAmt" class="required number" id="enRMB" type="text" style="width: 80%" value="${entity ne null ? entity.applyAmt : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if> />￥小写</td>
		<td colspan="3"><input id="cnRMB" readonly type="text" style="color: #999999;width: 80%" value="根据小写自动生成" />￥大写</td>
		<td class='field'>付款方</td>
		<td colspan="2">
			<input type="radio" value="0" name="payer" ${entity ne null && entity.payer eq 0 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 本校区
			<input type="radio" value="1" name="payer" ${entity ne null && entity.payer eq 1 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 总部
		</td>
	</tr>
	<tr>
		<td class='field'>合同编号</td>
		<td colspan="4"><input name="contractNo" type="text" style="width: 96%" value="${entity ne null ? entity.contractNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>附件张数</td>
		<td><input name="attachCount" type="text" class="number" style="width: 80%;" value="${entity ne null ? entity.attachCount : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>是否已事前审批</td>
		<td colspan="2">
			<input type="radio" value="1" name="auditAdvance" ${entity ne null && entity.auditAdvance eq 1 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 是
			<input type="radio" value="0" name="auditAdvance" ${entity ne null && entity.auditAdvance eq 0 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 否
		</td>
	</tr>
	<tr>
		<td class='field'>固定资产编号</td>
		<td colspan="4"><input name="assetNo"  type="text" style="width: 96%" value="${entity ne null ? entity.assetNo : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>收款方姓名</td>
		<td><input name="amtReceiver" type="text" class="required" style="width: 80%;" value="${entity ne null ? entity.amtReceiver : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>收款方联系方式</td>
		<td colspan="2">
			<input name="amtReceiverContact" class="required phone" type="text" style="width: 90%;" value="${entity ne null ? entity.amtReceiverContact : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/>
		</td>
	</tr>
	<tr>
		<td class='field'>付款方式</td>
		<td colspan="2">
			<input type="radio" value="0" name="payMethod" ${entity ne null && entity.payMethod eq 0 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 现金
			<input type="radio" value="1" name="payMethod" ${entity ne null && entity.payMethod eq 1 ? 'checked="checked"' : ''} <c:if test="${op ne null && op eq 'view'}">disabled</c:if>/> 转账
		</td>
		<td class='field'>开户银行</td>
		<td><input name="bank" type="text" class="required" style="width: 80%;" value="${entity ne null ? entity.bank : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>账户名</td>
		<td><input name="accountName" class="required" type="text" style="width: 80%;" value="${entity ne null ? entity.accountName : ''}"  <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/></td>
		<td class='field'>账号</td>
		<td colspan="2">
			<input name="accountNo" class="required" type="text" style="width: 90%;" value="${entity ne null ? entity.accountNo : ''}" <c:if test="${op ne null && op eq 'view'}">readonly</c:if>/>
		</td>
	</tr>
</table>

<!-- 审批状态 -->
<%@ include file="../data/dataFormProcess.jsp" %>
