package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmJobHireInterview;
import org.shengrui.oa.model.hrm.ModelHrmJobHireIssue;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInterview;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceHrmJobHireInterviewImpl
extends ServiceGenericImpl<ModelHrmJobHireIssue> implements ServiceHrmJobHireInterview
{
	private DAOHrmJobHireInterview daoHrmJobHireInterview;
	
	public ServiceHrmJobHireInterviewImpl(DAOHrmJobHireInterview dao)
	{
		super(dao);
		
		this.setDaoHrmJobHireInterview(dao);
	}

	public void setDaoHrmJobHireInterview(DAOHrmJobHireInterview daoHrmJobHireInterview)
	{
		this.daoHrmJobHireInterview = daoHrmJobHireInterview;
	}

	public DAOHrmJobHireInterview getDaoHrmJobHireInterview()
	{
		return daoHrmJobHireInterview;
	}

}
