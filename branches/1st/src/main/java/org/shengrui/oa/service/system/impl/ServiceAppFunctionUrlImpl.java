package org.shengrui.oa.service.system.impl;

import org.shengrui.oa.dao.system.DAOAppFunctionUrl;
import org.shengrui.oa.model.system.ModelAppFunctionUrl;
import org.shengrui.oa.service.system.ServiceAppFunctionUrl;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The application function URL service
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceAppFunctionUrlImpl
extends ServiceGenericImpl<ModelAppFunctionUrl> implements ServiceAppFunctionUrl
{
	
	/**
	 * The application function URL repository
	 */
	private DAOAppFunctionUrl daoAppFuncUrl;
	
	/**
	 * The sole constructor
	 * 
	 * @param dao
	 */
	public ServiceAppFunctionUrlImpl (DAOAppFunctionUrl dao)
	{
		super(dao);
		
		this.daoAppFuncUrl = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppFunctionUrl#getByPathAndFuncId(java.lang.String, java.lang.String)
	 */
	public ModelAppFunctionUrl getByPathAndFuncId(String urlPath, 
			String funcId) throws ServiceException
	{
		try
		{
			return this.daoAppFuncUrl.getByPathAndFuncId(urlPath, funcId);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}

	public DAOAppFunctionUrl getDaoAppFuncUrl()
	{
		return daoAppFuncUrl;
	}

	public void setDaoAppFuncUrl(DAOAppFunctionUrl daoAppFuncUrl)
	{
		this.daoAppFuncUrl = daoAppFuncUrl;
	}
}
