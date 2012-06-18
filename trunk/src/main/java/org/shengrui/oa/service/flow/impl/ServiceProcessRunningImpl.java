package org.shengrui.oa.service.flow.impl;

import org.shengrui.oa.dao.flow.DAOProcessRunning;
import org.shengrui.oa.model.flow.ModelProcessRunning;
import org.shengrui.oa.service.flow.ServiceProcessRunning;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceProcessRunningImpl
extends ServiceGenericImpl<ModelProcessRunning> implements ServiceProcessRunning
{
	
	private DAOProcessRunning daoProcessRunning;
	
	public ServiceProcessRunningImpl(DAOProcessRunning dao)
	{
		super(dao);
		this.daoProcessRunning = dao;
	}

	public void setDaoProcessRunning(DAOProcessRunning daoProcessRunning)
	{
		this.daoProcessRunning = daoProcessRunning;
	}

	public DAOProcessRunning getDaoProcessRunning()
	{
		return daoProcessRunning;
	}

}
