package org.shengrui.oa.model.finan;

import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.acl.AclFilterAnnotation;

/**
 * Model: 财务费用支出
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelFinanExpense
extends ModelFinanBase
{

	private static final long serialVersionUID = -8811440104989696141L;
	
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
	 * 数据权限过滤
	 */
	@AclFilterAnnotation(
		fieldNames ={"emp_district", "emp_dep", "entry_id"}, 
		fieldTypes ={AppUtil.DATA_POLICY_DISTRICT, AppUtil.DATA_POLICY_DEPARTMENT, AppUtil.DATA_POLICY_PERSONAL}
	)
	private String aclFilterFields;
	
	
	public Integer getPayer()
	{
		return payer;
	}

	public void setPayer(Integer payer)
	{
		this.payer = payer;
	}

	public String getContractNo()
	{
		return contractNo;
	}

	public void setContractNo(String contractNo)
	{
		this.contractNo = contractNo;
	}

	public String getAttachCount()
	{
		return attachCount;
	}

	public void setAttachCount(String attachCount)
	{
		this.attachCount = attachCount;
	}

	public Integer getAuditAdvance()
	{
		return auditAdvance;
	}

	public void setAuditAdvance(Integer auditAdvance)
	{
		this.auditAdvance = auditAdvance;
	}

	public String getAssetNo()
	{
		return assetNo;
	}

	public void setAssetNo(String assetNo)
	{
		this.assetNo = assetNo;
	}

	public String getAmtReceiver()
	{
		return amtReceiver;
	}

	public void setAmtReceiver(String amtReceiver)
	{
		this.amtReceiver = amtReceiver;
	}

	public String getAmtReceiverContact()
	{
		return amtReceiverContact;
	}

	public void setAmtReceiverContact(String amtReceiverContact)
	{
		this.amtReceiverContact = amtReceiverContact;
	}

	public Integer getPayMethod()
	{
		return payMethod;
	}

	public void setPayMethod(Integer payMethod)
	{
		this.payMethod = payMethod;
	}

	public String getBank()
	{
		return bank;
	}

	public void setBank(String bank)
	{
		this.bank = bank;
	}

	public String getAccountName()
	{
		return accountName;
	}

	public void setAccountName(String accountName)
	{
		this.accountName = accountName;
	}

	public String getAccountNo()
	{
		return accountNo;
	}

	public void setAccountNo(String accountNo)
	{
		this.accountNo = accountNo;
	}
	
}
