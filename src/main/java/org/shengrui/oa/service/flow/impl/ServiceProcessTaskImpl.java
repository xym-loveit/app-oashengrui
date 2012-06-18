package org.shengrui.oa.service.flow.impl;

import org.shengrui.oa.dao.flow.DAOProcessTask;
import org.shengrui.oa.model.flow.ModelProcessTask;
import org.shengrui.oa.service.flow.ServiceProcessTask;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceProcessTaskImpl
extends ServiceGenericImpl<ModelProcessTask> implements ServiceProcessTask
{
	
	private DAOProcessTask daoProcessTask;
	
	public ServiceProcessTaskImpl(DAOProcessTask dao)
	{
		super(dao);
		this.daoProcessTask = dao;
	}

	public void setDaoProcessTask(DAOProcessTask daoProcessTask)
	{
		this.daoProcessTask = daoProcessTask;
	}

	public DAOProcessTask getDaoProcessTask()
	{
		return daoProcessTask;
	}

}
