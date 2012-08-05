package org.shengrui.oa.service.system.impl;

import org.shengrui.oa.dao.system.DAOAppFunctionDataStrategy;
import org.shengrui.oa.model.system.ModelAppFunctionDataStrategy;
import org.shengrui.oa.service.system.ServiceAppFunctionDataStrategy;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The service of function data strategy.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceAppFunctionDataStrategyImpl
extends ServiceGenericImpl<ModelAppFunctionDataStrategy> implements ServiceAppFunctionDataStrategy
{
	
	private DAOAppFunctionDataStrategy daoAppFunctionDataStrategy;
	
	public ServiceAppFunctionDataStrategyImpl(DAOAppFunctionDataStrategy dao)
	{
		super(dao);
		this.daoAppFunctionDataStrategy = dao;
	}

	public DAOAppFunctionDataStrategy getDaoAppFunctionDataStrategy()
	{
		return daoAppFunctionDataStrategy;
	}

	public void setDaoAppFunctionDataStrategy(DAOAppFunctionDataStrategy daoAppFunctionDataStrategy)
	{
		this.daoAppFunctionDataStrategy = daoAppFunctionDataStrategy;
	}

}
