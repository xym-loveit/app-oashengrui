package org.shengrui.oa.service.system.impl;

import org.shengrui.oa.dao.system.DAOAppFunction;
import org.shengrui.oa.model.system.ModelAppFunction;
import org.shengrui.oa.service.system.ServiceAppFunction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The abstract base service
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceAppFunctionImpl 
extends ServiceGenericImpl<ModelAppFunction> implements ServiceAppFunction
{
	
	private DAOAppFunction daoAppFunction;
	
	public ServiceAppFunctionImpl(DAOAppFunction dao)
	{
		super(dao);
		this.daoAppFunction = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppFunction#getByKey(java.lang.String)
	 */
	@Override
	public ModelAppFunction getByKey(String paramString)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}

	public DAOAppFunction getDaoAppFunction()
	{
		return daoAppFunction;
	}

	public void setDaoAppFunction(DAOAppFunction daoAppFunction)
	{
		this.daoAppFunction = daoAppFunction;
	}
	
}
