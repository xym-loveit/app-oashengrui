package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmResume;
import org.shengrui.oa.model.hrm.ModelHrmResume;
import org.shengrui.oa.service.hrm.ServiceHrmResume;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceHrmResumeImpl
extends ServiceGenericImpl<ModelHrmResume> implements ServiceHrmResume
{
	
	private DAOHrmResume daoHrmResume;
	
	public ServiceHrmResumeImpl(DAOHrmResume dao)
	{
		super(dao);
		
		this.daoHrmResume = dao;
	}

	public void setDaoHrmResume(DAOHrmResume daoHrmResume)
	{
		this.daoHrmResume = daoHrmResume;
	}

	public DAOHrmResume getDaoHrmResume()
	{
		return daoHrmResume;
	}

}
