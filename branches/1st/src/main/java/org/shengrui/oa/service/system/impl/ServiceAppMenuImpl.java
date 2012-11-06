package org.shengrui.oa.service.system.impl;

import java.util.List;

import org.shengrui.oa.dao.system.DAOAppMenu;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.service.system.ServiceAppMenu;

import cn.trymore.core.exception.ServiceException;
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
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppMenu#getMenuByKey(java.lang.String)
	 */
	public ModelAppMenu getMenuByKey (String menuKey) throws ServiceException
	{
		try
		{
			return this.daoAppMenu.getMenuByKey(menuKey);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppMenu#getAllRootMenus()
	 */
	public List<ModelAppMenu> getAllRootMenus () throws ServiceException
	{
		try
		{
			return this.daoAppMenu.getAllRootMenus();
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
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
