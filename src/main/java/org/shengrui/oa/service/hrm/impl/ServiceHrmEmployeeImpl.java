package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.service.hrm.ServiceHrmEmployee;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceHrmEmployeeImpl
extends ServiceGenericImpl<ModelHrmJobHireEntry> implements ServiceHrmEmployee
{
	
	private DAOHrmEmployee daoHrmEmployee;
	
	public ServiceHrmEmployeeImpl(DAOHrmEmployee dao)
	{
		super(dao);
		
		this.daoHrmEmployee = dao;
	}

	public void setDaoHrmEmployee(DAOHrmEmployee daoHrmEmployee)
	{
		this.daoHrmEmployee = daoHrmEmployee;
	}

	public DAOHrmEmployee getDaoHrmEmployee()
	{
		return daoHrmEmployee;
	}

}
