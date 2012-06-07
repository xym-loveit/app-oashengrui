package cn.trymore.core.util;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

/**
 * The application utilities
 * 
 * @author Jeccy.Zhao
 *
 */
public class UtilApp
{
	private static ServletContext servletContext = null;
	
	/**
	 * Returns the absolute path of application.
	 * 
	 * @return absolute path of application
	 */
	public static String getAppAbsolutePath()
	{
		return servletContext.getRealPath("/");
	}
	
	/**
	 * Reloads the security data source
	 */
	public static void reloadSecurityDataSource()
	{
		
	}
	
	/**
	 * Obtains the request IP address.
	 * 
	 * @param request
	 * @return
	 */
	public static String getRequetIpAddr (HttpServletRequest request)
	{
		String ip = request.getHeader("x-forwarded-for");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	public static ServletContext getServletContext()
	{
		return servletContext;
	}

	public static void setServletContext(ServletContext servletContext)
	{
		UtilApp.servletContext = servletContext;
	}
}
