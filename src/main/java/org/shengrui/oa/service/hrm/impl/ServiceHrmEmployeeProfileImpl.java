package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmEmployeeProfile;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.service.hrm.ServiceHrmEmployeeProfile;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceHrmEmployeeProfileImpl
extends ServiceGenericImpl<ModelHrmJobHireEntry> implements ServiceHrmEmployeeProfile
{
	
	private DAOHrmEmployeeProfile daoHrmEmployeeProfile;
	
	public ServiceHrmEmployeeProfileImpl(DAOHrmEmployeeProfile dao)
	{
		super(dao);
		
		this.daoHrmEmployeeProfile = dao;
	}

	public void setDaoHrmEmployeeProfile(DAOHrmEmployeeProfile daoHrmEmployeeProfile)
	{
		this.daoHrmEmployeeProfile = daoHrmEmployeeProfile;
	}

	public DAOHrmEmployeeProfile getDaoHrmEmployeeProfile()
	{
		return daoHrmEmployeeProfile;
	}

}
