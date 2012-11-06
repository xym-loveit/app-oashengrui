package org.shengrui.oa.service.system.impl;

import java.util.List;

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
	
	/**
	 * The application function repository.
	 */
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
	public ModelAppFunction getByKey(String funcKey)
			throws ServiceException
	{
		try
		{
			return this.daoAppFunction.getByKey(funcKey);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppFunction#getByMenuId(java.lang.String)
	 */
	@Override
	public List<ModelAppFunction> getByMenuId(String menuId)
			throws ServiceException
	{
		try
		{
			return this.daoAppFunction.getByMenuId(menuId);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
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
