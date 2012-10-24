package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmJobHireInfoAuditHistory;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfoAuditHistory;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInfoAuditHistory;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The service implementation of HRM job audit history.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceHrmJobHireInfoAuditHistoryImpl
extends ServiceGenericImpl<ModelHrmJobHireInfoAuditHistory> implements ServiceHrmJobHireInfoAuditHistory
{
	
	private DAOHrmJobHireInfoAuditHistory daoHrmJobHireInfoAuditHistory;
	
	public ServiceHrmJobHireInfoAuditHistoryImpl(DAOHrmJobHireInfoAuditHistory dao)
	{
		super(dao);
		
		this.dao = daoHrmJobHireInfoAuditHistory;
	}

	public void setDaoHrmJobHireInfoAuditHistory(
			DAOHrmJobHireInfoAuditHistory daoHrmJobHireInfoAuditHistory)
	{
		this.daoHrmJobHireInfoAuditHistory = daoHrmJobHireInfoAuditHistory;
	}

	public DAOHrmJobHireInfoAuditHistory getDaoHrmJobHireInfoAuditHistory()
	{
		return daoHrmJobHireInfoAuditHistory;
	}

}
