package org.shengrui.oa.service.system.impl;

import org.shengrui.oa.dao.system.DAOAppMenu;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.service.system.ServiceAppMenu;

import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceAppMenuImpl
extends ServiceGenericImpl<ModelAppMenu> implements ServiceAppMenu
{
	private DAOAppMenu daoAppMenu;
	
	public ServiceAppMenuImpl(DAOAppMenu dao)
	{
		super(dao);
		this.daoAppMenu = dao;
	}
	
	public void setDaoAppMenu(DAOAppMenu daoAppMenu)
	{
		this.daoAppMenu = daoAppMenu;
	}

	public DAOAppMenu getDaoAppMenu()
	{
		return daoAppMenu;
	}
}
