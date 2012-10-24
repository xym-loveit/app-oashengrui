package org.shengrui.oa.service.news.impl;

import org.shengrui.oa.dao.news.DAONewsAuditHistory;
import org.shengrui.oa.model.news.ModelNewsAuditHistory;
import org.shengrui.oa.service.news.ServiceNewsAuditHistory;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The service implementation of news audit history.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceNewsAuditHistoryImpl
extends ServiceGenericImpl<ModelNewsAuditHistory> implements ServiceNewsAuditHistory
{
	
	private DAONewsAuditHistory daoNewsAuditHistory;
	
	public ServiceNewsAuditHistoryImpl(DAONewsAuditHistory dao)
	{
		super(dao);
		this.daoNewsAuditHistory = dao;
	}

	public void setDaoNewsAuditHistory(DAONewsAuditHistory daoNewsAuditHistory)
	{
		this.daoNewsAuditHistory = daoNewsAuditHistory;
	}

	public DAONewsAuditHistory getDaoNewsAuditHistory()
	{
		return daoNewsAuditHistory;
	}

}
