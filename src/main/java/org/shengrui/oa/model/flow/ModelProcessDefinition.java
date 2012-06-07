package org.shengrui.oa.model.flow;

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
	 * 触发条件
	 */
	@Expose
	private String condition;
	
	/**
	 * 工作流类型
	 */
	@Expose
	private ModelProcessType processType;

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
	
}
