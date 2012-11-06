package org.shengrui.oa.service.flow.impl;

import java.util.List;

import org.shengrui.oa.dao.flow.DAOProcessType;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.service.flow.ServiceProcessType;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceProcessTypeImpl
extends ServiceGenericImpl<ModelProcessType> implements ServiceProcessType
{
	
	private DAOProcessType daoProcessType;
	
	public ServiceProcessTypeImpl(DAOProcessType dao)
	{
		super(dao);
		this.setDaoProcessType(dao);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessType#getTypesByKey(java.lang.String)
	 */
	@Override
	public ModelProcessType getTypesByKey(String typeKey)
			throws ServiceException
	{
		try
		{
			return this.daoProcessType.getTypesByKey(typeKey);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessType#getTypesBySlug(java.lang.String)
	 */
	@Override
	public List<ModelProcessType> getTypesBySlug(String slugName)
			throws ServiceException
	{
		return this.getTypesBySlug(slugName, true);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessType#getTypesBySlug(java.lang.String, boolean)
	 */
	@Override
	public List<ModelProcessType> getTypesBySlug(String slugName,
			boolean onlyRootNode) throws ServiceException
	{
		try
		{
			return this.daoProcessType.getTypesBySlug(slugName, onlyRootNode);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}

	public DAOProcessType getDaoProcessType()
	{
		return daoProcessType;
	}

	public void setDaoProcessType(DAOProcessType daoProcessType)
	{
		this.daoProcessType = daoProcessType;
	}

}
