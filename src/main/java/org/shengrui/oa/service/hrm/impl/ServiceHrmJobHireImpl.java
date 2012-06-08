package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmJobHire;
import org.shengrui.oa.model.hrm.ModelHrmJobHire;
import org.shengrui.oa.service.hrm.ServiceHrmJobHire;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceHrmJobHireImpl
extends ServiceGenericImpl<ModelHrmJobHire> implements ServiceHrmJobHire
{
	private DAOHrmJobHire daoHrmJobHire;
	
	public ServiceHrmJobHireImpl(DAOHrmJobHire dao)
	{
		super(dao);
		
		this.daoHrmJobHire = dao;
	}
	
	public DAOHrmJobHire getDaoHrmJobHire()
	{
		return daoHrmJobHire;
	}

	public void setDaoHrmJobHire(DAOHrmJobHire daoHrmJobHire)
	{
		this.daoHrmJobHire = daoHrmJobHire;
	}
}
