package org.shengrui.oa.util;

import org.apache.log4j.Logger;
import org.shengrui.oa.model.system.ModelAppUser;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;

/**
 * The context utilities.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ContextUtil
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(ContextUtil.class);
	
	/**
	 * Returns the current user from the context.
	 * 
	 * @return
	 */
	public static ModelAppUser getCurrentUser()
	{
		SecurityContext securityContext = SecurityContextHolder.getContext();
		if (securityContext != null)
		{
			Authentication auth = securityContext.getAuthentication();
			if (auth != null)
			{
				Object principal = auth.getPrincipal();
				if (principal instanceof ModelAppUser)
				{
					return (ModelAppUser) principal;
				}
			}
			else
			{
				LOGGER.warn("WARN: securityContext cannot be lookuped using SecurityContextHolder.");
			}
		}
		
		return null;
	}
	
	/**
	 * Returns the current user id.
	 * 
	 * @return
	 */
	public static String getCurrentUserId()
	{
		ModelAppUser appUser = getCurrentUser();
		if (appUser != null	)
		{
			return appUser.getId();
		}
		return null;
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
	
}
