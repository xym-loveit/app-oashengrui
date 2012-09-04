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
	private ModelHrmEmployee projectOwner;
	
	/**
	 * 附件张数
	 */
	private Integer attachNum;
	
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

	public Integer getAttachNum()
	{
		return attachNum;
	}

	public void setAttachNum(Integer attachNum)
	{
		this.attachNum = attachNum;
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
	
}
