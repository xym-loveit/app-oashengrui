package org.shengrui.oa.model.finan;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 财务费用支出
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelFinanExpense
extends ModelBase
{

	private static final long serialVersionUID = -8811440104989696141L;
	
	/**
	 * 财务费用申请单号
	 */
	private String formNo;
	
	/**
	 * 财务费用申请类型
	 */
	private ModelProcessType applyFormType;
	
	/**
	 * 经办人(申请人)
	 */
	private ModelHrmEmployee employee;
	
	/**
	 * 财务费用申请日期
	 */
	private Date applyDate;
	
	/**
	 * 所属部门
	 */
	private ModelSchoolDepartment empDepartment;
	
	/**
	 * 所属校区
	 */
	private ModelSchoolDistrict empDistrict;
	
	/**
	 * 财务费用流程单
	 */
	private Set<ModelProcessForm> applyForm;
	
	/**
	 * 联系电话
	 */
	private String empPhoneNo;
	
	/**
	 * 费用申请备注
	 */
	private String comments;
	
	/**
	 * 支出金额
	 */
	private Double applyAmt;
	
	/**
	 * 付款方, 0=本校区, 1=总部
	 */
	private Integer payer;
	
	/**
	 * 合同编号
	 */
	private String contractNo;
	
	/**
	 * 附件张数
	 */
	private String attachCount;
	
	/**
	 * 是否已事前审批, 0=否, 1=是
	 */
	private Integer auditAdvance;
	
	/**
	 * 固定资产编号
	 */
	private String assetNo;
	
	/**
	 * 收款方姓名
	 */
	private String amtReceiver;
	
	/**
	 * 收款方联系方式
	 */
	private String amtReceiverContact;
	
	/**
	 * 付款方式, 0=现金, 1=转账
	 */
	private Integer payMethod;
	
	/**
	 * 开户银行
	 */
	private String bank;
	
	/**
	 * 账户名
	 */
	private String accountName;
	
	/**
	 * 账号
	 */
	private String accountNo;
	
	/**
	 * 申请状态
	 */
	private String status;
	
	/**
	 * 审批状态
	 */
	private Integer auditState;
	
	/**
	 * 录入人员
	 */
	private Integer entryId;
	
	/**
	 * 录入日期
	 */
	private Date entryDateTime;

	/**
	 * 审批历史
	 */
	private Set<ModelProcessHistory> processHistory = new HashSet<ModelProcessHistory>();
	
	/**
	 * 当前审批环节
	 */
	private ModelProcessForm currentProcessForm;
	
	public ModelProcessType getApplyFormType() 
	{
		return applyFormType;
	}

	public void setApplyFormType(ModelProcessType applyFormType)
	{
		this.applyFormType = applyFormType;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public Integer getAuditState() 
	{
		if (this.auditState == null && this.applyForm != null)
		{
			ModelProcessForm[] forms = new ModelProcessForm[this.applyForm.size()];
			this.applyForm.toArray(forms);
			
			for (int i = forms.length - 1 ; i >= 0; i--)
			{
				ModelProcessForm form = forms[i];
				if (form.getAuditState() != null)
				{
					return form.getAuditState();
				}
			}
		}
		
		return auditState;
	}
	
	public void setAuditState(Integer auditState) 
	{
		this.auditState = auditState;
	}

	public Integer getEntryId() {
		return entryId;
	}

	public void setEntryId(Integer entryId) {
		this.entryId = entryId;
	}

	public Date getEntryDateTime() {
		return entryDateTime;
	}

	public void setEntryDateTime(Date entryDateTime) {
		this.entryDateTime = entryDateTime;
	}

	public Set<ModelProcessHistory> getProcessHistory() {
		return processHistory;
	}

	public void setProcessHistory(Set<ModelProcessHistory> processHistory) {
		this.processHistory = processHistory;
	}

	public String getEmpPhoneNo() {
		return empPhoneNo;
	}

	public void setEmpPhoneNo(String empPhoneNo) {
		this.empPhoneNo = empPhoneNo;
	}

	public Double getApplyAmt() {
		return applyAmt;
	}

	public void setApplyAmt(Double applyAmt) {
		this.applyAmt = applyAmt;
	}

	public int getPayer() {
		return payer;
	}

	public void setPayer(int payer) {
		this.payer = payer;
	}

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public String getAttachCount() {
		return attachCount;
	}

	public void setAttachCount(String attachCount) {
		this.attachCount = attachCount;
	}

	public int getAuditAdvance() {
		return auditAdvance;
	}

	public void setAuditAdvance(int auditAdvance) {
		this.auditAdvance = auditAdvance;
	}

	public String getAssetNo() {
		return assetNo;
	}

	public void setAssetNo(String assetNo) {
		this.assetNo = assetNo;
	}

	public String getAmtReceiver() {
		return amtReceiver;
	}

	public void setAmtReceiver(String amtReceiver) {
		this.amtReceiver = amtReceiver;
	}

	public String getAmtReceiverContact() {
		return amtReceiverContact;
	}

	public void setAmtReceiverContact(String amtReceiverContact) {
		this.amtReceiverContact = amtReceiverContact;
	}

	public int getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(int payMethod) {
		this.payMethod = payMethod;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public ModelSchoolDepartment getEmpDepartment() {
		return empDepartment;
	}

	public void setEmpDepartment(ModelSchoolDepartment empDepartment) {
		this.empDepartment = empDepartment;
	}

	public ModelSchoolDistrict getEmpDistrict() {
		return empDistrict;
	}

	public void setEmpDistrict(ModelSchoolDistrict empDistrict) {
		this.empDistrict = empDistrict;
	}

	public void setApplyForm(Set<ModelProcessForm> applyForm)
	{
		this.applyForm = applyForm;
	}

	public Set<ModelProcessForm> getApplyForm()
	{
		return applyForm;
	}

	public void setFormNo(String formNo)
	{
		this.formNo = formNo;
	}

	public String getFormNo()
	{
		return formNo;
	}

	public void setEmployee(ModelHrmEmployee employee)
	{
		this.employee = employee;
	}

	public ModelHrmEmployee getEmployee()
	{
		return employee;
	}

	public void setCurrentProcessForm(ModelProcessForm currentProcessForm)
	{
		this.currentProcessForm = currentProcessForm;
	}
	
	/**
	 * Obtains the current process form node.
	 * 
	 * @return the process form entity
	 */
	public ModelProcessForm getCurrentProcessForm()
	{
		if (currentProcessForm == null && this.applyForm != null)
		{
			ModelProcessForm[] forms = new ModelProcessForm[this.applyForm.size()];
			this.applyForm.toArray(forms);
			
			for (int i = forms.length - 1 ; i >= 0; i--)
			{
				ModelProcessForm form = forms[i];
				if (form.getAuditState() != null && 
						ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue().equals(form.getAuditState()))
				{
					currentProcessForm = form;
					break;
				}
			}
		}
			
		return currentProcessForm;
	}

	
}
