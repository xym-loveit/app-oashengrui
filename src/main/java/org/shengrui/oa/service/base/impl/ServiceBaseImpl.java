package org.shengrui.oa.service.base.impl;

import org.shengrui.oa.dao.base.DAOBase;
import org.shengrui.oa.service.base.ServiceBase;

import cn.trymore.core.model.ModelBase;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * Base service definition.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceBaseImpl
extends ServiceGenericImpl<ModelBase> implements ServiceBase
{
	/**
	 * The base repository. 
	 */
	private DAOBase daoBase;
	
	public ServiceBaseImpl(DAOBase dao)
	{
		super(dao);
		
		this.daoBase = dao;
	}

	public DAOBase getDaoBase()
	{
		return daoBase;
	}

	public void setDaoBase(DAOBase daoBase)
	{
		this.daoBase = daoBase;
	}

}
