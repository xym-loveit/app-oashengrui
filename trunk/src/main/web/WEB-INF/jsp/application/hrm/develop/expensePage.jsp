<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<div class="pageContent">
	<form method="post" action="app/finan/financial.do?action=FinanExpenseDetail" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>经办人：</td>
					<td><input name="employeeName" type="text" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.employee.empName : ''}" style="width:120px" /></td>
					<td>日期：</td>
					<td><input name="applyDate" type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.employee.applyDate : ''}" /></td>
					<td nowrap>所属校区：</td>
					<td><input name="fromDistrict"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.fromDistrict.districtName : ''}" /></td>
					<td nowrap>所属部门：</td>
					<td><input name="fromDepartment"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.fromDepartment.depName : ''}" /></td>
					<td nowrap>联系电话：</td>
					<td><input name="phoneNo"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.employee.phoneNo : ''}" /></td>
				</tr>
				<tr>
					<td>费用说明：</td>
					<td colspan="9"><textarea name="comments" rows="1" style="width: 100%">${employeeExpenseEntry.applyForm ne null ? employeeExpenseEntry.applyForm.comments : ''}</textarea></td>
				</tr>
				<tr>
					<td>支出金额：</td>
					<td><input name="cost"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.cost : ''}" /></td>
					<td> ￥小写</td>
					<td><input type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.cost : ''}" /></td>
					<td> ￥大写</td>
					<td></td>
					<td>付款方：</td>
					<td colspan="3">
						<select class="combox" name="payer.id" id="combox_district_eindex" style="width:108px">
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${employeeExpenseForm ne null && employeeExpenseForm.payer ne null && employeeExpenseForm.payer.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
				</tr>
				<tr>
					<td>合同编号：</td>
					<td><input name="contractNo"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.contractNo : ''}" /></td>
					<td>附件张数：</td>
					<td><input name="attachCount" type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.attachCount : ''}" /></td>
					<td nowrap>是否已事前审批：</td>
					<td colspan="5">
						<select class="combox" name="auditAdvance" style="width:108px;">
							<option value="0" ${employeeExpenseForm ne null && employeeExpenseForm.auditAdvance eq 0 ? 'selected="selected"' : ''}>否</option>
							<option value="1" ${employeeExpenseForm ne null && employeeExpenseForm.auditAdvance eq 1 ? 'selected="selected"' : ''}>是</option>
						</select>
					</td>
				</tr>
				<tr>
					<td nowrap>固定资产编号：</td>
					<td><input name="assetNo"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.assetNo : ''}" /></td>
					<td nowrap>收款方姓名：</td>
					<td><input name="amtReceiver"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.amtReceiver : ''}" /></td>
					<td>收款方联系方式：</td>
					<td colspan="5"><input name="amtReceiverContact"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.amtReceiverContact : ''}" /></td>
				</tr>
				<tr>
					<td>付款方式：</td>
					<td>
						<select class="combox" name="paymethod" style="width:108px;">
							<option value="0" ${employeeExpenseForm ne null && employeeExpenseForm.paymethod eq 0 ? 'selected="selected"' : ''}>现金</option>
							<option value="1" ${employeeExpenseForm ne null && employeeExpenseForm.paymethod eq 1 ? 'selected="selected"' : ''}>转账</option>
						</select>
					</td>
					<td>开户银行：</td>
					<td><input name="bank"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.bank : ''}" /></td>
					<td>账户名：</td>
					<td><input name="accountName"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.accountName : ''}" /></td>
					<td>账号：</td>
					<td colspan="3"><input name="accountNo"  type="text" style="width:120px" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.accountNo : ''}" /></td>
				</tr>
				<tr>
					<td>申请报告：</td>
					<td colspan="8"><textarea name="comments" rows="1" style="width: 100%">${employeeExpenseEntry ne null ? employeeExpenseEntry.comments : ''}</textarea></td>
					<td></td>
				</tr>
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
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${employeeExpenseEntry ne null ? employeeExpenseEntry.id : -1}" />
	</form>
</div>