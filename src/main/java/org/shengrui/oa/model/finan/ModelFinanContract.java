package org.shengrui.oa.model.finan;

import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.acl.AclFilterAnnotation;

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

	/**
	 * 数据权限过滤
	 */
	@AclFilterAnnotation(
		fieldNames ={"emp_district", "emp_dep", "entry_id"}, 
		fieldTypes ={AppUtil.DATA_POLICY_DISTRICT, AppUtil.DATA_POLICY_DEPARTMENT, AppUtil.DATA_POLICY_PERSONAL}
	)
	private String aclFilterFields;
	
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
