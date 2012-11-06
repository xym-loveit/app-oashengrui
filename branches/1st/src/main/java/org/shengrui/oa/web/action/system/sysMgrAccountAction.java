package org.shengrui.oa.web.action.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.service.system.ServiceAppUser;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The web action for account manager
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysMgrAccountAction
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(sysMgrAccountAction.class);
	
	/**
	 * The service for application user
	 */
	private ServiceAppUser serviceAppUser;
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 系统管理 - 用户管理
	 */
	public ActionForward pageAccountIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelAppUser formUser = (ModelAppUser) form;
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelAppUser> roles = this.serviceAppUser.getUserPagination(formUser, pagingBean);
			
			request.setAttribute("users", roles);
			request.setAttribute("userForm", formUser);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, roles);
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all users.", e);
		}
		
		return mapping.findForward("page.sys.mgr.account.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 系统管理 - 用户状态保存操作
	 */
	public ActionForward actionUserStateChange (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			Integer status = Integer.parseInt(request.getParameter("status"));
			String userId = request.getParameter("userId");
			
			if (this.isObjectIdValid(userId))
			{
				ModelAppUser user = this.serviceAppUser.get(userId);
				if (user != null)
				{
					user.setStatus(status);
					this.serviceAppUser.save(user);
					
					if (status == ModelAppUser.EUserStatus.ACTIVATED.getValue())
					{
						return ajaxPrint(response, getSuccessCallbackAndReloadCurrent("账号已经被成功激活."));
					}
					else
					{
						return ajaxPrint(response, getSuccessCallbackAndReloadCurrent("账号已经被冻结."));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("用户不存在!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("传递的用户ID参数非法!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the user state change dialog.", e);
		}
		
		return ajaxPrint(response, getErrorCallback("加载数据异常, 请再一次尝试!"));
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 系统管理 - 用户密码重置操作
	 */
	public ActionForward actionUserPwdReset (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String userId = request.getParameter("userId");
			
			if (this.isObjectIdValid(userId))
			{
				ModelAppUser user = this.serviceAppUser.get(userId);
				if (user != null)
				{
					user.setPassword(UtilString.encryptSha256(user.getUsername()));
					this.serviceAppUser.save(user);
					
					return ajaxPrint(response, getSuccessCallbackAndReloadCurrent("账号密码已经被重置."));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("用户不存在!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("传递的用户ID参数非法!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the user state change dialog.", e);
		}
		
		return ajaxPrint(response, getErrorCallback("加载数据异常, 请再一次尝试!"));
	}
	
	/**
	 * Opens dialog for the minor changes against user. 
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param forwardPath
	 * @return
	 */
	protected ActionForward openDialogPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, String forwardPath)
	{
		try
		{
			String userId = request.getParameter("userId");
			if (this.isObjectIdValid(userId))
			{
				ModelAppUser user = this.serviceAppUser.get(userId);
				if (user != null)
				{
					request.setAttribute("user", user);
					return mapping.findForward(forwardPath);
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("用户不存在!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("传递的用户ID参数非法!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the user state change dialog.", e);
		}
		
		return ajaxPrint(response, getErrorCallback("加载数据异常, 请再一次尝试!"));
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}

	public ServiceAppUser getServiceAppUser()
	{
		return serviceAppUser;
	}

	public void setServiceAppUser(ServiceAppUser serviceAppUser)
	{
		this.serviceAppUser = serviceAppUser;
	}
	
}
