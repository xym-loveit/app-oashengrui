package org.shengrui.oa.service.system.impl;

import org.shengrui.oa.dao.system.DAOAppUser;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.service.system.ServiceAppUser;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The application user service implementation.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceAppUserImpl
extends ServiceGenericImpl<ModelAppUser> implements ServiceAppUser
{
	
	/**
	 * The application user repository
	 */
	private DAOAppUser daoAppUser;
	
	@Override
	public ModelAppUser findByUserName(String userName) throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	public ServiceAppUserImpl(DAOAppUser dao)
	{
		super(dao);
		
		this.daoAppUser = dao;
	}

	public void setDaoAppUser(DAOAppUser daoAppUser)
	{
		this.daoAppUser = daoAppUser;
	}

	public DAOAppUser getDaoAppUser()
	{
		return daoAppUser;
	}


}
