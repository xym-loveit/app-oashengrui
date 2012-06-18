package cn.trymore.oa.service.system.impl;

import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.oa.dao.system.DAOFileAttach;
import cn.trymore.oa.model.system.ModelFileAttach;
import cn.trymore.oa.service.system.ServiceFileAttach;

public class ServiceFileAttachImpl
extends ServiceGenericImpl<ModelFileAttach> implements ServiceFileAttach
{
	
	private DAOFileAttach daoFileAttach;
	
	public ServiceFileAttachImpl(DAOFileAttach dao)
	{
		super(dao);
		this.daoFileAttach = dao;
	}

	public void setDaoFileAttach(DAOFileAttach daoFileAttach)
	{
		this.daoFileAttach = daoFileAttach;
	}

	public DAOFileAttach getDaoFileAttach()
	{
		return daoFileAttach;
	}

}
