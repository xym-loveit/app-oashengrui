package org.shengrui.oa.web.action.system;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.captcha.Captcha;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.service.system.ServiceAppUser;
import org.shengrui.oa.web.action.BaseAppAction;
import org.springframework.security.AuthenticationManager;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.util.StringUtils;

import cn.trymore.core.util.UtilApp;
import cn.trymore.core.util.UtilString;

/**
 * The action for system login.
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysLoginAction
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(sysLoginAction.class);
	
	/**
	 * The key for remember me.
	 */
	private static final String KEY_RememberMe = "RememberAppUser";
	
	/**
	 * The key for spring security cookie
	 */
	private static final String KEY_SPRING_SECURITY_COOKIE = "SPRING_SECURITY_REMEMBER_ME_COOKIE";
	
	/**
	 * The login parameter for user name
	 */
	private static final String PARAM_USER_NAME = "username";
	
	/**
	 * The login parameter for user password
	 */
	private static final String PARAM_USER_PWD = "password";
	
	/**
	 * The parameter for the checking code.
	 */
	private static final String PARAM_CHECKCODE = "checkCode";
	
	/**
	 * The service for application user.
	 */
	private ServiceAppUser serviceAppUser;
	
	/**
	 * The spring security authentication manager
	 */
	@Resource(name="authenticationManager")
	private AuthenticationManager authenticationManager;
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * User logon.
	 */
	public ActionForward actionLogon (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		StringBuffer msgBuffer = new StringBuffer();
		
		try
		{
			String userName = request.getParameter(PARAM_USER_NAME);
			String userPwd = request.getParameter(PARAM_USER_PWD);
			
			String checkCode = request.getParameter(PARAM_CHECKCODE);
			Captcha localCaptcha = (Captcha) request.getSession().getAttribute("simpleCaptcha");
			
			if (localCaptcha == null)
			{
				msgBuffer.append("请刷新验证码再登录!");
			}
			else
			{
				if (!localCaptcha.isCorrect(checkCode))
				{
					msgBuffer.append("验证码不正确, 请尝试刷新更换验证码再做尝试!");
				}
				else
				{
					if (UtilString.isNotEmpty(userName))
					{
						ModelAppUser user = this.serviceAppUser.findByUserName(userName);
						if (user != null)
						{
							if (user.getStatus().equals(ModelAppUser.EUserStatus.FROZEN.getValue()))
							{
								msgBuffer.append("账号已被冻结, 请联系管理员进行解冻操作!");
							}
							else
							{
								String encodedPwd = UtilString.encryptSha256(userPwd);
								if (user.getPassword().equalsIgnoreCase(encodedPwd))
								{
									// 更新用戶最後登录时间和IP地址
									String reqIp = UtilApp.getRequetIpAddr(request);
									user.setLastLogonIP(reqIp);
									user.setLastLogonTime(new Date());
									this.serviceAppUser.save(user);
									
									// stores the authentication to spring security
									UsernamePasswordAuthenticationToken authToken = 
										new UsernamePasswordAuthenticationToken(userName, userPwd);
									
									SecurityContext securityContext = SecurityContextHolder.getContext();
									securityContext.setAuthentication(this.authenticationManager.authenticate(authToken));
									
									SecurityContextHolder.setContext(securityContext);
									request.getSession().setAttribute("SPRING_SECURITY_LAST_USERNAME", userName);
									
									String rememberMe = request.getParameter("_spring_security_remember_me");
									if (rememberMe != null && "on".equalsIgnoreCase(rememberMe))
									{
										String digest = DigestUtils.md5Hex(userName + ":" + userPwd + ":" + KEY_RememberMe);
										String cookieValue = new String(Base64.encodeBase64(digest.getBytes()));
										response.addCookie(this.makeValidCookie(request, cookieValue));
									}
									
									return ajaxPrint(response, this.getSuccessCallback("登录成功."));
								}
								else
								{
									msgBuffer.append("输入的密码不正确!");
								}
							}
						}
						else
						{
							msgBuffer.append("用户不能存在!");
						}
					}
				}
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when logon.", e);
			msgBuffer.append(e.getMessage());
		}
		
		return ajaxPrint(response, this.getErrorCallback(msgBuffer.toString()));
	}
	
	/**
	 * Generates an valid cookie.
	 * 
	 * @param request
	 * @param cookieValue
	 * @return
	 */
	private Cookie makeValidCookie (HttpServletRequest request, String cookieValue)
	{
		Cookie localCookie = new Cookie(KEY_SPRING_SECURITY_COOKIE, cookieValue);
		
		localCookie.setMaxAge(157680000);
		
		if (StringUtils.hasLength(request.getContextPath()))
		{
			localCookie.setPath(request.getContextPath());
		}
		else
		{
			localCookie.setPath("/");
		}
		
		return localCookie;
	}
	
	public void setAuthenticationManager(AuthenticationManager authenticationManager)
	{
		this.authenticationManager = authenticationManager;
	}

	public AuthenticationManager getAuthenticationManager()
	{
		return authenticationManager;
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}

	public void setServiceAppUser(ServiceAppUser serviceAppUser)
	{
		this.serviceAppUser = serviceAppUser;
	}

	public ServiceAppUser getServiceAppUser()
	{
		return serviceAppUser;
	}
	
}
