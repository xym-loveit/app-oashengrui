package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmEmployeeRoadMap;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.service.hrm.ServiceHrmEmployeeRoadMap;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceHrmEmployeeRoadMapImpl
extends ServiceGenericImpl<ModelHrmJobHireEntry> implements ServiceHrmEmployeeRoadMap
{
	
	private DAOHrmEmployeeRoadMap daoHrmEmployeeRoadMap;
	
	public ServiceHrmEmployeeRoadMapImpl(DAOHrmEmployeeRoadMap dao)
	{
		super(dao);
		
		this.daoHrmEmployeeRoadMap = dao;
	}

	public void setDaoHrmEmployeeRoadMap(DAOHrmEmployeeRoadMap daoHrmEmployeeRoadMap)
	{
		this.daoHrmEmployeeRoadMap = daoHrmEmployeeRoadMap;
	}

	public DAOHrmEmployeeRoadMap getDaoHrmEmployeeRoadMap()
	{
		return daoHrmEmployeeRoadMap;
	}

}
