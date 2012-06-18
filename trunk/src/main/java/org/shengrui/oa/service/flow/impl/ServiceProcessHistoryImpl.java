package org.shengrui.oa.service.flow.impl;

import org.shengrui.oa.dao.flow.DAOProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.service.flow.ServiceProcessHistory;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceProcessHistoryImpl
extends ServiceGenericImpl<ModelProcessHistory> implements ServiceProcessHistory
{
	
	private DAOProcessHistory daoProcessHistory;
	
	public ServiceProcessHistoryImpl(DAOProcessHistory dao)
	{
		super(dao);
		this.daoProcessHistory = dao;
	}

	public void setDaoProcessHistory(DAOProcessHistory daoProcessHistory)
	{
		this.daoProcessHistory = daoProcessHistory;
	}

	public DAOProcessHistory getDaoProcessHistory()
	{
		return daoProcessHistory;
	}

}
