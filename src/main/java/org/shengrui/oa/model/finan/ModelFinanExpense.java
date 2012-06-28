package org.shengrui.oa.model.finan;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessHistory;
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
	 * 员工档案
	 */
	private ModelHrmEmployee employee = new ModelHrmEmployee();
	
	/**
	 * 财务费用申请单号
	 */
	private ModelProcessForm applyForm = new ModelProcessForm();
	
	/**
	 * 财务费用申请类型
	 */
	private int applyFormType;
	
	/**
	 * 财务费用申请日期
	 */
	private Date applyDate;
	
	/**
	 * 申请备注
	 */
	private String comments;
	
	private String empPhoneNo;
	private Double applyAmt;
	private int payer = -1;
	private String contractNo;
	private String attachCount;
	private int auditAdvance = -1;
	private String assetNo;
	private String amtReceiver;
	private String amtReceiverContact;
	private int payMethod = -1;
	private String bank;
	private String accountName;
	private String accountNo;
	
	/**
	 * 申请部门ID
	 */
	private ModelSchoolDepartment empDepartment = new ModelSchoolDepartment();
	
	/**
	 * 申请校区ID
	 */
	private ModelSchoolDistrict empDistrict = new ModelSchoolDistrict();
	
	/**
	 * 申请状态
	 */
	private String status;
	
	/**
	 * 审批状态
	 */
	private int auditState = -1;
	
	/**
	 * 录入人员
	 */
	private int entryId = -1;
	
	/**
	 * 录入日期
	 */
	private Date entryDateTime;

	/**
	 * 审批历史
	 */
	private Set<ModelProcessHistory> processHistory = new HashSet<ModelProcessHistory>();
	
	public ModelHrmEmployee getEmployee() {
		return employee;
	}

	public void setEmployee(ModelHrmEmployee employee) {
		this.employee = employee;
	}

	public ModelProcessForm getApplyForm() {
		return applyForm;
	}

	public void setApplyForm(ModelProcessForm applyForm) {
		this.applyForm = applyForm;
	}

	public int getApplyFormType() {
		return applyFormType;
	}

	public void setApplyFormType(int applyFormType) {
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

	public int getAuditState() {
		return auditState;
	}

	public void setAuditState(int auditState) {
		this.auditState = auditState;
	}

	public int getEntryId() {
		return entryId;
	}

	public void setEntryId(int entryId) {
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

	
}
