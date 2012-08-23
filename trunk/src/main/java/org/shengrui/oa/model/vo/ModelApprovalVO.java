package org.shengrui.oa.model.vo;

public class ModelApprovalVO
{
	/**
	 * 审批功能项Key
	 */
	private String approvalFuncKey;
	
	/**
	 * 审批操作链接
	 */
	private String approvalURI;
	
	/**
	 * The sole constructor.
	 * 
	 * @param approvalFuncKey
	 * @param approvalURI
	 */
	public ModelApprovalVO (String approvalFuncKey, String approvalURI)
	{
		this.approvalURI = approvalURI;
		this.approvalFuncKey = approvalFuncKey;
	}

	public void setApprovalURI(String approvalURI)
	{
		this.approvalURI = approvalURI;
	}

	public String getApprovalURI()
	{
		return approvalURI;
	}

	public void setApprovalFuncKey(String approvalFuncKey)
	{
		this.approvalFuncKey = approvalFuncKey;
	}

	public String getApprovalFuncKey()
	{
		return approvalFuncKey;
	}
	
}
