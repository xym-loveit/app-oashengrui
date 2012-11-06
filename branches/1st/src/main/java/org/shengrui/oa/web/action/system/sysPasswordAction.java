package org.shengrui.oa.web.action.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.util.UtilString;

public class sysPasswordAction 
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(sysPasswordAction.class);
	
	/**
	 * 密码修改页面
	 * @author pyc
	 * */
	public ActionForward changePasswordPage (ActionMapping mapping , ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		
		return mapping.findForward("page.sys.mgr.password.index");
	}
	
	/**
	 * 密码修改
	 * */
	/**
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward changePassword (ActionMapping mapping , ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		ModelAppUser modelAppUser = null;
		String oldPassword = UtilString.encryptSha256(request.getParameter("oldPassword"));
		String newPassword = UtilString.encryptSha256(request.getParameter("newPassword"));
		String confirmPassword = UtilString.encryptSha256(request.getParameter("confirmPassword"));
		// String userName = ContextUtil.getCurrentUser().getFullName(); //(String) request.getSession().getAttribute("SPRING_SECURITY_LAST_USERNAME");
		//根据用户名获取用户密码
		try {
			modelAppUser = ContextUtil.getCurrentUser(); //serviceAppUser.getPasswordByUserName(userName);
			String password = modelAppUser.getPassword();
			//判断输入的原密码是否正确
			if(!oldPassword.equals(UtilString.encryptSha256("")))
			{
				if(!oldPassword.equals(password))
				{
					return ajaxPrint(response, getErrorCallback("您输入原密码有误，请重新输入！"));
				}
			}
			else
			{
					return ajaxPrint(response, getErrorCallback("修改密码时，请输入原密码！"));
			}
			
			//判断输入的新密码和确认密码是否相同
			if(!newPassword.equals(UtilString.encryptSha256("")) && !confirmPassword.equals(UtilString.encryptSha256("")))
			{
				if(!newPassword.equals(confirmPassword))
				{
					return ajaxPrint(response, getErrorCallback("您输入的新密码和确认密码不匹配，请重新输入！"));
				}
			}
			if(newPassword.equals(UtilString.encryptSha256("")))
			{
				return ajaxPrint(response, getErrorCallback("新密码不能为空密码，请重新输入新密码！"));
			}
			if(confirmPassword.equals(UtilString.encryptSha256("")))
			{
				return ajaxPrint(response, getErrorCallback("确认密码不能为空密码，请重新输入确认密码！"));
			}
			modelAppUser.setPassword(confirmPassword);
			this.serviceAppUser.save(modelAppUser);
		} catch (Exception e) {
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("密码修改页面加载失败:" + e.getMessage()));
		}
		return ajaxPrint(response, getSuccessCallback("您的密码已修改成功，请使用新密码重新登录系统！", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
	}
	
}
