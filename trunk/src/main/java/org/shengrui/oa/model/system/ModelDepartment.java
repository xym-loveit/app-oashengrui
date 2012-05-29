package org.shengrui.oa.model.system;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 部门管理
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelDepartment
extends ModelBase
{

	private static final long serialVersionUID = 6580519840409552397L;
	
	/**
	 * 部门名称
	 */
	@Expose
	protected String depName;
	
	/**
	 * 部门描述
	 */
	@Expose
	protected String depDesc;
	
	/**
	 * 部门层次
	 */
	@Expose
	protected Integer depLevel;
	
	/**
	 * 父节点部门ID
	 */
	@Expose
	protected Long depParentId;

	public String getDepName()
	{
		return depName;
	}

	public void setDepName(String depName)
	{
		this.depName = depName;
	}

	public String getDepDesc()
	{
		return depDesc;
	}

	public void setDepDesc(String depDesc)
	{
		this.depDesc = depDesc;
	}

	public Integer getDepLevel()
	{
		return depLevel;
	}

	public void setDepLevel(Integer depLevel)
	{
		this.depLevel = depLevel;
	}

	public Long getDepParentId()
	{
		return depParentId;
	}

	public void setDepParentId(Long depParentId)
	{
		this.depParentId = depParentId;
	}
	
}
