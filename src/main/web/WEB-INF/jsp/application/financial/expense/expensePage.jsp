<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	#tblexp td.banner {line-height: 45px;font-size: 18px; font-weight: bold; text-align: center; margin: 0;}
	#tblexp td.field {background-color: #CFDBEC; line-height: 45px; text-align: center; margin: 0; width: 120px; font-size: 9pt;}
	#tblexp input.textInput {float:none;margin: 5px; width: 70px;}
</style>

<div class="pageContent">
	<form method="post" action="app/finan/financial.do?action=actionFinanExpenseSave" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="padding: 10px 0px; border-bottom: 1px dotted #999; margin: 0 10px 15px 10px; overflow: auto; clear: both;">
				<span style="float:left; color:#FF7300; line-height: 18px;">请选择费用支出类型：</span>
				<select class="combox" name="applyFormTypeId" id="expense_type">
					<option value="">请选择申请类型</option>
					<logic:present name="types">
						<logic:iterate name="types" id="entity">
							<option value="${entity.id}" ${department ne null && department.depEquivalentBranch ne null && department.depEquivalentBranch.id eq entity.id ? "selected='selected'" : ""}>${entity.processTypeName}</option>
						</logic:iterate>
					</logic:present>
				</select>
			</div>
			<table id="tblexp" cellpadding="0" cellspacing="0" width="98%" border="1" style="border-collapse: collapse; border-color: #797979; margin: 0 auto;">
				<tr>
					<td width="72%" colspan="10" class="banner">费用支出申请单</td>
					<td align="center" class="banner">填写说明</td>
				</tr>
				<tr>
					<td class='field'>经办人</td>
					<td><input name="empName" type="text" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.employee.empName : ''}"/></td>
					<td class='field'>日期</td>
					<td><input name="applyDate" type="text" value="<c:if test='${employeeExpenseEntry ne null}'><fmt:formatDate value='${employeeExpenseEntry.applyDate}' pattern='yyyy-MM-dd' /></c:if>"></td>
					<td class='field'>所属校区</td>
					<td><input name="fromDistrict" type="text" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.empDistrict.districtName : ''}"/></td>
					<td class='field'>所属部门</td>
					<td><input name="fromDepartment" type="text" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.empDepartment.depName : ''}"/></td>
					<td class='field'>联系电话</td>
					<td><input name="empPhoneNo" type="text" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.empPhoneNo : ''}"/></td>
					<td rowspan="6" style="line-height: 20px; padding: 0 4px;">业务招待费指用于业务及相关活动的应酬费用，如餐费、礼品费等。</td>
				</tr>
				<tr>
					<td class='field'>费用说明</td>
					<td colspan="9"><textarea name="comments" rows="1" style="width: 98%; height: 80px; margin: 5px;">${employeeExpenseEntry ne null ? employeeExpenseEntry.comments : ''}</textarea></td>
				</tr>
				<tr>
					<td class='field'>支出金额</td>
					<td colspan="3"><input name="applyAmt"  type="text" style="width: 200px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.applyAmt : ''}" />￥小写</td>
					<td colspan="3"><input type="text" style="color: #ddd;width: 200px" value="${employeeExpenseEntry ne null ? '' : '根据小写自动生成'}" />￥大写</td>
					<td class='field'>付款方</td>
					<td colspan="2">
						<input type="radio" value="0" name="payer" ${employeeExpenseEntry ne null && employeeExpenseEntry.payer eq 0 ? 'checked="checked"': ''}/> 本校区
						<input type="radio" value="1" name="payer" ${employeeExpenseEntry ne null && employeeExpenseEntry.payer eq 1 ? 'checked="checked' : ''}/> 总部
					</td>
				</tr>
				<tr>
					<td class='field'>合同编号</td>
					<td colspan="4"><input name="contractNo"  type="text" style="width: 320px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.contractNo : ''}" /></td>
					<td class='field'>附件张数</td>
					<td><input name="attachCount" type="text" style="" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.attachCount : ''}" /></td>
					<td class='field'>是否已事前审批</td>
					<td colspan="2">
						<input type="radio" value="1" name="auditAdvance" ${employeeExpenseEntry ne null && employeeExpenseEntry.auditAdvance eq 1 ? 'checked="checked"' : ''}/> 是
						<input type="radio" value="0" name="auditAdvance" ${employeeExpenseEntry ne null && employeeExpenseEntry.auditAdvance eq 0 ? 'checked="checked"' : ''}/> 否
					</td>
				</tr>
				<tr>
					<td class='field'>固定资产编号</td>
					<td colspan="4"><input name="assetNo"  type="text" style="width: 320px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.assetNo : ''}" /></td>
					<td class='field'>收款方姓名</td>
					<td><input name="amtReceiver" type="text" style="" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.amtReceiver : ''}" /></td>
					<td class='field'>收款方联系方式</td>
					<td colspan="2">
						<input name="amtReceiverContact" type="text" style="width: 157px;" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.amtReceiverContact : ''}" />
					</td>
				</tr>
				<tr>
					<td class='field'>付款方式</td>
					<td colspan="2">
						<input type="radio" value="0" name="payMethod" ${employeeExpenseEntry ne null && employeeExpenseEntry.payMethod eq 0 ? 'checked="checked"' : ''}/> 现金
						<input type="radio" value="1" name="payMethod" ${employeeExpenseEntry ne null && employeeExpenseEntry.payMethod eq 1 ? 'checked="checked"' : ''}/> 转账
					</td>
					<td class='field'>开户银行</td>
					<td><input name="bank" type="text" style="" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.bank : ''}" /></td>
					<td class='field'>账户名</td>
					<td><input name="accountName" type="text" style="" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.accountName : ''}" /></td>
					<td class='field'>账号</td>
					<td colspan="2">
						<input name="accountNo" type="text" style="width: 157px;" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.accountNo : ''}" />
					</td>
				</tr>
			</table>
			
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

<%--
	<tr>
		<td>本部门意见：</td>
		<td colspan="8"><textarea name="comments" rows="1" style="width: 100%">${employeeExpenseEntry.applyForm ne null ? employeeExpenseEntry.applyForm.auditIdea : ''}</textarea></td>
		<td></td>
	</tr>
	<tr>
		<td>人资部意见：</td>
		<td colspan="8"><textarea name="comments" rows="1" style="width: 100%">${employeeExpenseEntry.applyForm ne null ? employeeExpenseEntry.applyForm.auditIdea : ''}</textarea></td>
		<td></td>
	</tr>
	<tr>
		<td>校区意见：</td>
		<td colspan="8"><textarea name="comments" rows="1" style="width: 100%">${employeeExpenseEntry.applyForm ne null ? employeeExpenseEntry.applyForm.auditIdea : ''}</textarea></td>
		<td></td>
	</tr>
	<tr>
		<td>总部意见：</td>
		<td colspan="8"><textarea name="comments" rows="1" style="width: 100%">${employeeExpenseEntry ne null ? employeeExpenseEntry.applyForm.auditIdea : ''}</textarea></td>
		<td></td>
	</tr>
</table>
--%>