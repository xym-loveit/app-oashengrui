package org.shengrui.oa.model.finan;

/**
 * Model: 财务合同申请
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelFinanContract
extends ModelFinanBase
{

	private static final long serialVersionUID = -8811440104989696141L;

	/**
	 * 合同编号
	 */
	private String contractNo;
	
	/**
	 * 合同签约方
	 */
	private String contractParties;
	
	/**
	 * 合同签约方联系方式
	 */
	private String contractPartiesContact;
	
	/**
	 * 付款方式
	 */
	private String payMethod;

	public String getContractNo()
	{
		return contractNo;
	}

	public void setContractNo(String contractNo)
	{
		this.contractNo = contractNo;
	}

	public String getContractParties()
	{
		return contractParties;
	}

	public void setContractParties(String contractParties)
	{
		this.contractParties = contractParties;
	}

	public String getContractPartiesContact()
	{
		return contractPartiesContact;
	}

	public void setContractPartiesContact(String contractPartiesContact)
	{
		this.contractPartiesContact = contractPartiesContact;
	}

	public String getPayMethod()
	{
		return payMethod;
	}

	public void setPayMethod(String payMethod)
	{
		this.payMethod = payMethod;
	}
	
}
