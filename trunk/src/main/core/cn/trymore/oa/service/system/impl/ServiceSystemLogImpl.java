package cn.trymore.oa.service.system.impl;

import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.oa.dao.system.DAOSystemLog;
import cn.trymore.oa.model.system.ModelSystemLog;
import cn.trymore.oa.service.system.ServiceSystemLog;

public class ServiceSystemLogImpl
extends ServiceGenericImpl<ModelSystemLog> implements ServiceSystemLog
{
	private DAOSystemLog daoSystemLog;
	
	public ServiceSystemLogImpl (DAOSystemLog dao)
	{
		super(dao);
		this.daoSystemLog = dao;
	}
	
	public DAOSystemLog getDaoSystemLog()
	{
		return daoSystemLog;
	}

	public void setDaoSystemLog(DAOSystemLog daoSystemLog)
	{
		this.daoSystemLog = daoSystemLog;
	}
}
