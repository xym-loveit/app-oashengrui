package org.shengrui.oa.service.admin.impl;

import org.shengrui.oa.dao.admin.DAOTaskPlanAuditHistory;
import org.shengrui.oa.model.admin.ModelTaskPlanAuditHistory;
import org.shengrui.oa.service.admin.ServiceTaskPlanAuditHistory;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The service implementation of task plan audit history.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceTaskPlanAuditHistoryImpl
extends ServiceGenericImpl<ModelTaskPlanAuditHistory> implements ServiceTaskPlanAuditHistory
{
	
	private DAOTaskPlanAuditHistory daoTaskPlanAuditHistory;
	
	public ServiceTaskPlanAuditHistoryImpl(DAOTaskPlanAuditHistory dao)
	{
		super(dao);
		this.daoTaskPlanAuditHistory = dao;
	}

	public void setDaoTaskPlanAuditHistory(DAOTaskPlanAuditHistory daoTaskPlanAuditHistory)
	{
		this.daoTaskPlanAuditHistory = daoTaskPlanAuditHistory;
	}

	public DAOTaskPlanAuditHistory getDaoTaskPlanAuditHistory()
	{
		return daoTaskPlanAuditHistory;
	}

}
