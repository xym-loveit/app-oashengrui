package org.shengrui.oa.model.flow;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 工作流步骤
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelProcessTask
extends ModelBase
{

	private static final long serialVersionUID = 47999607445249175L;
	
	/**
	 * 工作流定义
	 */
	private ModelProcessDefinition processDefinition;
	
	/**
	 * 工作流任务名
	 */
	private String processTaskName;
	
	/**
	 * 上游工作流
	 */
	private ModelProcessTask processTaskFrom;
	
	/**
	 * 下游工作流
	 */
	private ModelProcessTask processTaskNext;
	
	/**
	 * 工作流类型
	 */
	private Integer processTaskType;
	
	/**
	 * 待审核部门名称
	 */
	private String toDepartmentNames;
	
	/**
	 * 待审核部门ID
	 */
	private String toDepartmentIds;
	
	/**
	 * 待审核用户名称
	 */
	private String toUserNames;
	
	/**
	 * 待审核用户ID
	 */
	private String toUserIds;
	
	/**
	 * 待审核角色名称
	 */
	private String toRoleNames;
	
	/**
	 * 待审核角色ID
	 */
	private String toRoleIds;
	
	/**
	 * 排序码
	 */
	private Integer sortCode;
	
	/**
	 * 工作流步骤描述
	 */
	private String processTaskComments;

	public ModelProcessDefinition getProcessDefinition()
	{
		return processDefinition;
	}

	public void setProcessDefinition(ModelProcessDefinition processDefinition)
	{
		this.processDefinition = processDefinition;
	}

	public String getProcessTaskName()
	{
		return processTaskName;
	}

	public void setProcessTaskName(String processTaskName)
	{
		this.processTaskName = processTaskName;
	}

	public ModelProcessTask getProcessTaskFrom()
	{
		return processTaskFrom;
	}

	public void setProcessTaskFrom(ModelProcessTask processTaskFrom)
	{
		this.processTaskFrom = processTaskFrom;
	}

	public ModelProcessTask getProcessTaskNext()
	{
		return processTaskNext;
	}

	public void setProcessTaskNext(ModelProcessTask processTaskNext)
	{
		this.processTaskNext = processTaskNext;
	}

	public Integer getSortCode()
	{
		return sortCode;
	}

	public void setSortCode(Integer sortCode)
	{
		this.sortCode = sortCode;
	}

	public String getProcessTaskComments()
	{
		return processTaskComments;
	}

	public void setProcessTaskComments(String processTaskComments)
	{
		this.processTaskComments = processTaskComments;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}

	public String getToDepartmentNames()
	{
		return toDepartmentNames;
	}

	public void setToDepartmentNames(String toDepartmentNames)
	{
		this.toDepartmentNames = toDepartmentNames;
	}

	public String getToDepartmentIds()
	{
		return toDepartmentIds;
	}

	public void setToDepartmentIds(String toDepartmentIds)
	{
		this.toDepartmentIds = toDepartmentIds;
	}

	public String getToUserNames()
	{
		return toUserNames;
	}

	public void setToUserNames(String toUserNames)
	{
		this.toUserNames = toUserNames;
	}

	public String getToUserIds()
	{
		return toUserIds;
	}

	public void setToUserIds(String toUserIds)
	{
		this.toUserIds = toUserIds;
	}

	public String getToRoleNames()
	{
		return toRoleNames;
	}

	public void setToRoleNames(String toRoleNames)
	{
		this.toRoleNames = toRoleNames;
	}

	public String getToRoleIds()
	{
		return toRoleIds;
	}

	public void setToRoleIds(String toRoleIds)
	{
		this.toRoleIds = toRoleIds;
	}

	public void setProcessTaskType(Integer processTaskType)
	{
		this.processTaskType = processTaskType;
	}

	public Integer getProcessTaskType()
	{
		return processTaskType;
	}
	
}
