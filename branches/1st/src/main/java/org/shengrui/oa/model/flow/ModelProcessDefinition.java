package org.shengrui.oa.model.flow;

import java.util.Date;
import java.util.Set;

import org.shengrui.oa.model.system.ModelSchoolPositionSet;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 工作流定义
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelProcessDefinition
extends ModelBase
{
	
	private static final long serialVersionUID = -5615808491635468543L;
	
	/**
	 * 工作流名称
	 */
	@Expose
	private String processDefName;
	
	/**
	 * 工作流描述
	 */
	@Expose
	private String processDefDesc;
	
	/**
	 * 触发条件
	 */
	@Expose
	private String condition;
	
	/**
	 * 工作流类型
	 */
	@Expose
	private ModelProcessType processType;
	
	/**
	 * 职位, 用于职位申请审批过滤
	 */
	private ModelSchoolPositionSet filterPoset;
	
	/**
	 * 工作流创建时间
	 */
	@Expose
	private Date createTime;
	
	/**
	 * 工作流任务节点
	 */
	private Set<ModelProcessTask> processTasks;
	
	public String getCondition()
	{
		return condition;
	}

	public void setCondition(String condition)
	{
		this.condition = condition;
	}

	public ModelProcessType getProcessType()
	{
		return processType;
	}

	public void setProcessType(ModelProcessType processType)
	{
		this.processType = processType;
	}

	public String getProcessDefName()
	{
		return processDefName;
	}

	public void setProcessDefName(String processDefName)
	{
		this.processDefName = processDefName;
	}

	public String getProcessDefDesc()
	{
		return processDefDesc;
	}

	public void setProcessDefDesc(String processDefDesc)
	{
		this.processDefDesc = processDefDesc;
	}

	public Date getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(Date createTime)
	{
		this.createTime = createTime;
	}

	public void setProcessTasks(Set<ModelProcessTask> processTasks)
	{
		this.processTasks = processTasks;
	}

	public Set<ModelProcessTask> getProcessTasks()
	{
		return processTasks;
	}

	public void setFilterPoset(ModelSchoolPositionSet filterPoset)
	{
		this.filterPoset = filterPoset;
	}

	public ModelSchoolPositionSet getFilterPoset()
	{
		return filterPoset;
	}
	
}
