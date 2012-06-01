package org.shengrui.oa.web.action.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.service.system.ServiceAppFunction;
import org.shengrui.oa.service.system.ServiceAppMenu;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.web.action.BaseAction;

public class sysSettingBaseAction
extends BaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(sysSettingBaseAction.class);
	
	/**
	 * The application menu service.
	 */
	protected ServiceAppMenu serviceAppMenu;
	
	/**
	 * The application function service
	 */
	protected ServiceAppFunction serviceAppFunc;
	
	/**
	 * 获取父菜单列表
	 * 
	 * @param request
	 * @return
	 */
	protected List<ModelAppMenu> getRootMenus(HttpServletRequest request)
	{
		List<ModelAppMenu> result = null;
		
		if (request.getParameter("lookup") != null)
		{
			request.setAttribute("lookup", true);
		}
		
		try
		{
			result = this.serviceAppMenu.getAllRootMenus();
			request.setAttribute("rootMenus", result);
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch the root menus.", e);
		}
		
		return result;
	}
	
	public ServiceAppMenu getServiceAppMenu()
	{
		return serviceAppMenu;
	}

	public void setServiceAppMenu(ServiceAppMenu serviceAppMenu)
	{
		this.serviceAppMenu = serviceAppMenu;
	}

	public ServiceAppFunction getServiceAppFunc()
	{
		return serviceAppFunc;
	}

	public void setServiceAppFunc(ServiceAppFunction serviceAppFunc)
	{
		this.serviceAppFunc = serviceAppFunc;
	}
	
	
}
