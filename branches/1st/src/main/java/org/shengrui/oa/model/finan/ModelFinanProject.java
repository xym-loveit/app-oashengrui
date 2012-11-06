package org.shengrui.oa.model.finan;

import org.shengrui.oa.model.hrm.ModelHrmEmployee;

/**
 * Model: 新项目申请支出
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelFinanProject
extends ModelFinanBase
{
	
	private static final long serialVersionUID = 1105248447754966701L;
	
	/**
	 * 所属项目
	 */
	private String projectCatalog;
	
	/**
	 * 项目负责人
	 */
	private ModelHrmEmployee projectOwner = new ModelHrmEmployee();
	
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
	 * 附件张数
	 */
	private String attachCount;
	
	/**
	 * 供应商姓名
	 */
	private String supplierName;
	
	/**
	 * 供应商联系方式
	 */
	private String supplierContact;
	
	public String getProjectCatalog()
	{
		return projectCatalog;
	}

	public void setProjectCatalog(String projectCatalog)
	{
		this.projectCatalog = projectCatalog;
	}

	public ModelHrmEmployee getProjectOwner()
	{
		return projectOwner;
	}

	public void setProjectOwner(ModelHrmEmployee projectOwner)
	{
		this.projectOwner = projectOwner;
	}

	public String getSupplierName()
	{
		return supplierName;
	}

	public void setSupplierName(String supplierName)
	{
		this.supplierName = supplierName;
	}

	public String getSupplierContact()
	{
		return supplierContact;
	}

	public void setSupplierContact(String supplierContact)
	{
		this.supplierContact = supplierContact;
	}

	public String getAttachCount()
	{
		return attachCount;
	}

	public void setAttachCount(String attachCount)
	{
		this.attachCount = attachCount;
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
