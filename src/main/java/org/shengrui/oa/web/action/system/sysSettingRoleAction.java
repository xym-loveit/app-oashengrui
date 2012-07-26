package org.shengrui.oa.web.action.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelAppFunction;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.model.system.ModelAppRole;
import org.shengrui.oa.service.system.ServiceAppRole;
import org.springframework.beans.BeanUtils;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.log.LogAnnotation;
import cn.trymore.core.util.UtilApp;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 系统设置 - 权限组配置
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysSettingRoleAction
extends sysSettingBaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(sysSettingRoleAction.class);
	
	/**
	 * The application role service
	 */
	private ServiceAppRole serviceAppRole;

	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 权限组配置-列表展现
	 */
	@LogAnnotation(description="进入权限组配置页面",type="系统设置")
	public ActionForward pageRoleIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelAppRole formRole = (ModelAppRole) form;
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelAppRole> roles = this.serviceAppRole.getRolePagination(formRole, pagingBean);
			
			request.setAttribute("roles", roles);
			request.setAttribute("roleForm", formRole);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, roles);
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all roles.", e);
		}
		
		return mapping.findForward("page.sys.setting.role.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 权限组配置-角色详细配置展现
	 */
	public ActionForward dialogRolePage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			String roleId = request.getParameter("roleId");
			if (this.isObjectIdValid(roleId))
			{
				// 角色更新操作
				ModelAppRole role = this.serviceAppRole.get(roleId);
				if (role != null)
				{
					request.setAttribute("role", role);
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("权限组不存在!"));
				}
			}
			
			if (request.getParameter("view") != null)
			{
				request.setAttribute("view", "true");
			}
			
			return mapping.findForward("dialog.sys.setting.role.page");
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch menu function entity!", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败,原因:" + e.getMessage()));
		}
		
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-加载系统功能列表
	 */
	public ActionForward actionLoadAppFuncs (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		this.getRootMenus(request);
		
		String roleId = request.getParameter("roleId");
		if (this.isObjectIdValid(roleId))
		{
			try
			{
				request.setAttribute("role", this.serviceAppRole.get(roleId));
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when fetch the role entity with id:" + roleId, e);
			}
		}
		
		if (request.getParameter("view") != null)
		{
			request.setAttribute("view", "true");
		}
		
		return mapping.findForward("dialog.sys.setting.role.appfuncs");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-唯一性检测权限Key
	 */
	public ActionForward actionUniqueCheckRoleKey (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String roleKey = request.getParameter("roleKey");
		if (UtilString.isNotEmpty(roleKey))
		{
			try
			{
				ModelAppRole entity = this.serviceAppRole.getRoleByKey(roleKey);
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
	 * 菜单设置-删除角色
	 */
	@LogAnnotation(description="删除权限组",type="系统设置")
	public ActionForward actionRemoveRole (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			String roleId = request.getParameter("roleId");
			if (this.isObjectIdValid(roleId))
			{
				// 删除
				 this.serviceAppRole.remove(roleId);
				 
				 return ajaxPrint(response, 
							getSuccessCallbackAndReloadCurrent("权限组删除成功."));
			}
			
			return mapping.findForward("dialog.sys.setting.role.page");
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch menu function entity!", e);
			
			return ajaxPrint(response, getErrorCallback("权限组删除失败,原因:" + e.getMessage()));
		}
		
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-保存角色
	 */
	public ActionForward actionSaveRole (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelAppRole formAppRole = (ModelAppRole) form;
			ModelAppRole entity = formAppRole;
		
			boolean isRoleEdit =  this.isObjectIdValid(formAppRole.getId());
			String originalRights = null;
			
			if (isRoleEdit)
			{
				// 更新权限
				entity = this.serviceAppRole.get(formAppRole.getId());
				if (entity != null)
				{
					originalRights = entity.getRoleRights();
					
					// 用表单输入的值覆盖实体中的属性值
					BeanUtils.copyProperties(formAppRole, entity, 
							new String[] {"roleStatus", "functions", "menus", "users"});
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("权限组不存在!"));
				}
			}
			
			// 设置菜单清单
			String roleMenuIds = request.getParameter("menuFunc.menuIds");
			if (!roleMenuIds.equals(entity.getMenuIds()))
			{
				entity.getMenus().clear();
				String[] arrayOfMenuIds = roleMenuIds.split("[,]");
				for (int i = 0; i < arrayOfMenuIds.length; i++)
				{
					ModelAppMenu modelAppMenu = this.serviceAppMenu.get(arrayOfMenuIds[i]);
					if (modelAppMenu == null)
					{
						continue;
					}
					entity.getMenus().add(modelAppMenu);
				}
			}
			
			// 设置功能清单
			String roleMenuRights = request.getParameter("menuFunc.funcRights");
			entity.setRoleRights(roleMenuRights);
			
			if (!isRoleEdit || !roleMenuRights.equals(originalRights))
			{
				entity.getFunctions().clear();
				String[] arrayOfRoleRights = roleMenuRights.split("[,]");
				for (int i = 0; i < arrayOfRoleRights.length; i++)
				{
					ModelAppFunction modelAppFunc = this.serviceAppFunc.getByKey(arrayOfRoleRights[i]);
					if (modelAppFunc == null)
					{
						continue;
					}
					entity.getFunctions().add(modelAppFunc);
				}
			}
			
			this.serviceAppRole.save(entity);
			
			// 重新加载权限数据池
			UtilApp.reloadSecurityDataSource();
			
			return ajaxPrint(response, 
					getSuccessCallback("权限组保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when saving role entity.", e);
			ajaxPrint(response, getErrorCallback("权限组保存失败."));
		}
		
		return null;
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}

	public ServiceAppRole getServiceAppRole()
	{
		return serviceAppRole;
	}

	public void setServiceAppRole(ServiceAppRole serviceAppRole)
	{
		this.serviceAppRole = serviceAppRole;
	}
}
