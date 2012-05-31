package org.shengrui.oa.web.action.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelAppFunction;
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
		
		return mapping.findForward("page.sys.setting.menu.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-添加菜单弹框
	 */
	public ActionForward dialogMenuItemPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String menuId = request.getParameter("menuId");
		if (this.isObjectIdValid(menuId))
		{
			try
			{
				// 菜单项更新
				ModelAppMenu menu = this.serviceAppMenu.get(menuId);
				if (menu != null)
				{
					request.setAttribute("menu", menu);
				}
				else
				{
					ajaxPrint(response, getErrorCallback("菜单项不存在!"));
				}
			}
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when fetching menu with id:" + menuId, e);
			}
		}
		
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
		String menuId = request.getParameter("menuId");
		if (this.isObjectIdValid(menuId))
		{
			try
			{
				// 获取功能对应的菜单项
				ModelAppMenu menu = this.serviceAppMenu.get(menuId);
				if (menu != null)
				{
					request.setAttribute("menu", menu);
					
					String funcId = request.getParameter("funcId");
					if (this.isObjectIdValid(funcId))
					{
						// 功能项更新操作
						ModelAppFunction func = this.serviceAppFunc.get(funcId);
						if (func != null)
						{
							request.setAttribute("func", func);
						}
						else
						{
							ajaxPrint(response, getErrorCallback("菜单项不存在!"));
						}
					}
					
					return mapping.findForward("dialog.sys.setting.menu.func");
				}
				else
				{
					ajaxPrint(response, getErrorCallback("菜单项不存在!"));
				}
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when fetch menu entity with id:" + menuId, e);
			}
		}
			
		return ajaxPrint(response, getErrorCallback("加载数据异常, 请再一次尝试!"));
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
	public ActionForward actionUniqueCheckMenuItemKey (ActionMapping mapping, ActionForm form,
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
	 * 菜单设置-唯一性检测菜单功能项标识Key
	 */
	public ActionForward actionUniqueCheckMenuFuncKey (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String funcKey = request.getParameter("funcKey");
		if (UtilString.isNotEmpty(funcKey))
		{
			try
			{
				ModelAppFunction entity = this.serviceAppFunc.getByKey(funcKey);
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
	 * 菜单设置-保存菜单功能项
	 */
	public ActionForward actionSaveMenuFunc (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String menuId = request.getParameter("menuId");
			ModelAppFunction formModelAppFunc = (ModelAppFunction) form;
			ModelAppFunction entity = null;
			
			if (this.isObjectIdValid(menuId))
			{
				ModelAppMenu funcMenu = this.serviceAppMenu.get(menuId);
				if (funcMenu != null)
				{
					if (formModelAppFunc.getId() != null)
					{
						// 更新
						entity = this.serviceAppFunc.get(formModelAppFunc.getId());
						if (entity != null)
						{
							// 用表单输入的值覆盖实体中的属性值
							BeanUtils.copyProperties(formModelAppFunc, entity, 
									new String[] {"menu"});
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("菜单功能项不存在!"));
						}
					}
					else
					{
						// 新建
						entity = new ModelAppFunction();
					}
				}
				
				entity.setMenu(funcMenu);
				this.serviceAppFunc.save(entity);
				
				return ajaxPrint(response, getSuccessCallbackAndReloadCurrent("菜单功能项保存成功."));
			}
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when saving the menu function.", e);
			ajaxPrint(response, getErrorCallback("菜单功能项保存失败."));
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
			
			boolean isCreation = this.isObjectIdValid(formModelAppMenu.getId());
			
			if (!isCreation)
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
			
			if (isCreation)
			{
				// 新建保存成功后, Dialog不进行关闭
				return ajaxPrint(response, 
						getSuccessCallbackAndReloadCurrent("菜单项保存成功."));
			}
			else
			{
				// 编辑保存成功后, Dialog进行关闭
				return ajaxPrint(response, 
						getSuccessCallback("菜单项保存成功.", CALLBACK_TYPE_CLOSE, null, null, false));
			}
		} 
		catch (ServiceException e)
		{
			LOGGER.error("It failed to save the menu item entity!", e);
			
			return ajaxPrint(response, getErrorCallback("菜单项保存失败."));
		}
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
