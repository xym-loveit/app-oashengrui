package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmEntry;
import org.shengrui.oa.model.hrm.ModelHrmEntry;
import org.shengrui.oa.service.hrm.ServiceHrmEntry;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceHrmEntryImpl
extends ServiceGenericImpl<ModelHrmEntry> implements ServiceHrmEntry
{
	
	private DAOHrmEntry daoHrmEntry;
	
	public ServiceHrmEntryImpl(DAOHrmEntry dao)
	{
		super(dao);
		
		this.daoHrmEntry = dao;
	}

	public void setDaoHrmEntry(DAOHrmEntry daoHrmEntry)
	{
		this.daoHrmEntry = daoHrmEntry;
	}

	public DAOHrmEntry getDaoHrmEntry()
	{
		return daoHrmEntry;
	}

}
