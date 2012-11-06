package org.shengrui.oa.model.system;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 功能数据权限
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAppFunctionDataStrategy
extends ModelBase
{

	/**
	 * The serial UID
	 */
	private static final long serialVersionUID = 4732133304395931783L;
	
	/**
	 * 数据权限类型
	 */
	private Integer strategyType;
	
	/**
	 * 数据权限对应的菜单功能项
	 */
	private ModelAppFunction function;

	public Integer getStrategyType()
	{
		return strategyType;
	}

	public void setStrategyType(Integer strategyType)
	{
		this.strategyType = strategyType;
	}

	public ModelAppFunction getFunction()
	{
		return function;
	}

	public void setFunction(ModelAppFunction function)
	{
		this.function = function;
	}
	
}
