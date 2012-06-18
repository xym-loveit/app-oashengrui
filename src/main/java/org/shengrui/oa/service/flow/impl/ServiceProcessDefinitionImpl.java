package org.shengrui.oa.service.flow.impl;

import org.shengrui.oa.dao.flow.DAOProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.service.flow.ServiceProcessDefinition;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceProcessDefinitionImpl
extends ServiceGenericImpl<ModelProcessDefinition> implements ServiceProcessDefinition
{
	
	private DAOProcessDefinition daoProcessDefinition;
	
	public ServiceProcessDefinitionImpl(DAOProcessDefinition dao)
	{
		super(dao);
		
		this.daoProcessDefinition = dao;
	}

	public void setDaoProcessDefinition(DAOProcessDefinition daoProcessDefinition)
	{
		this.daoProcessDefinition = daoProcessDefinition;
	}

	public DAOProcessDefinition getDaoProcessDefinition()
	{
		return daoProcessDefinition;
	}

}
