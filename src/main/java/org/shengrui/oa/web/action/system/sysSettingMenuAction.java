package org.shengrui.oa.web.action.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.service.system.ServiceAppFunction;
import org.shengrui.oa.service.system.ServiceAppMenu;
import org.springframework.beans.BeanUtils;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.action.BaseAction;

/**
 * 系统设置 - 资源设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysSettingMenuAction
extends BaseAction
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(sysSettingMenuAction.class);
			
	/**
	 * The application menu service.
	 */
	private ServiceAppMenu serviceAppMenu;
	
	/**
	 * The application function service
	 */
	private ServiceAppFunction serviceAppFunc;
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-列表展现
	 */
	public ActionForward pageMenuIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		this.getRootMenus(request);
		
		return mapping.findForward("page.sys.setting.menu.list");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-添加菜单弹框
	 */
	public ActionForward dialogMenuItemPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("dialog.sys.setting.menu.item");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-添加菜单功能弹框
	 */
	public ActionForward dialogMenuFuncPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("dialog.sys.setting.menu.func");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-加载菜单树型结构
	 */
	public ActionForward actionLoadMenuItemTree (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		if (request.getParameter("lookup") != null)
		{
			request.setAttribute("lookup", true);
		}
		
		this.getRootMenus(request);
		
		return mapping.findForward("data.sys.setting.menu.tree");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-加载菜单功能列表
	 */
	public ActionForward actionLoadMenuFuncList (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String menuId = request.getParameter("menuId");
		if (UtilString.isNotEmpty(menuId))
		{
			try
			{
				request.setAttribute("menuFuncs", this.serviceAppFunc.getByMenuId(menuId));
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when loading the function list with menu id:" + menuId, e);
			}
		}
		
		return mapping.findForward("data.sys.setting.menu.func");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-唯一性检测菜单项标识Key
	 */
	public ActionForward actionUniqueCheckMenuKey (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String menuKey = request.getParameter("menuKey");
		if (UtilString.isNotEmpty(menuKey))
		{
			try
			{
				ModelAppMenu entity = this.serviceAppMenu.getMenuByKey(menuKey);
				if (entity == null)
				{
					ajaxPrint(response, AJAX_RESPONSE_TRUE);
				}
			} 
			catch (ServiceException e)
			{
				ajaxPrint(response, AJAX_RESPONSE_FALSE);
			}
		}
		
		return null;
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-保存菜单项
	 */
	public ActionForward actionSaveMenuItem (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String rootMenuKey = request.getParameter("root.menuKey");
			ModelAppMenu formModelAppMenu = (ModelAppMenu) form;
			ModelAppMenu entity = null;
			
			if (formModelAppMenu.getId() != null)
			{
				// 更新
				entity = this.serviceAppMenu.get(formModelAppMenu.getId());
				if (entity != null)
				{
					// 用表单输入的值覆盖实体中的属性值
					BeanUtils.copyProperties(formModelAppMenu, entity, 
							new String[] {"menuParent", "menuChildren", "functions"});
				}
				else
				{
					return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
				}
			}
			else
			{
				// 新建
				entity = formModelAppMenu;
			}
			
			// 倘若父菜单更换, 则进行更新
			if (UtilString.isNotEmpty(rootMenuKey))
			{
				if (entity.getMenuParent() == null || 
						(entity.getMenuParent() != null && !entity.getMenuParent().getMenuKey().equals(rootMenuKey)))
				{
					// 获取父菜单实体
					ModelAppMenu rootMenu = this.serviceAppMenu.getMenuByKey(rootMenuKey);
					
					if (rootMenu != null)
					{
						entity.setMenuParent(rootMenu);
					}
				}
			}
			else
			{
				entity.setMenuParent(null);
			}
			
			this.serviceAppMenu.save(entity);
			
			ajaxPrint(response, getSuccessCallbackAndReloadCurrent("菜单项保存成功."));
		} 
		catch (ServiceException e)
		{
			e.printStackTrace();
			ajaxPrint(response, getErrorCallback("菜单项保存失败."));
		}
		
		return null;
	}
	
	/**
	 * 获取父菜单列表
	 * 
	 * @param request
	 * @return
	 */
	private List<ModelAppMenu> getRootMenus(HttpServletRequest request)
	{
		List<ModelAppMenu> result = null;
		
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

	public static Logger getLogger()
	{
		return LOGGER;
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
