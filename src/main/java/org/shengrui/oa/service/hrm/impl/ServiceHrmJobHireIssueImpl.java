package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmJobHireIssue;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceHrmJobHireIssueImpl
extends ServiceGenericImpl<ModelHrmJobHireInterview> implements ServiceHrmJobHireIssue
{
	private DAOHrmJobHireIssue daoHrmJobHireIssue;

	public ServiceHrmJobHireIssueImpl(DAOHrmJobHireIssue dao)
	{
		super(dao);
		
		this.daoHrmJobHireIssue = dao;
	}

	public void setDaoHrmJobHireIssue(DAOHrmJobHireIssue daoHrmJobHireIssue)
	{
		this.daoHrmJobHireIssue = daoHrmJobHireIssue;
	}

	public DAOHrmJobHireIssue getDaoHrmJobHireIssue()
	{
		return daoHrmJobHireIssue;
	}

}
