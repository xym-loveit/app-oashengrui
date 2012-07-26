package cn.trymore.core.util;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import cn.trymore.core.web.filter.SecurityInterceptorFilter;

/**
 * The application utilities
 * 
 * @author Jeccy.Zhao
 *
 */
public class UtilApp
implements ApplicationContextAware
{
	private static ServletContext servletContext = null;
	
	/**
	 * The application context, used to fetch the bean object.
	 */
	private static ApplicationContext applicationContext;
	
	/**
	 * Obtains the bean with the specified bean name.
	 * 
	 * @param beanName
	 * @return
	 */
	public static Object getBean(String beanName)
	{
		return applicationContext.getBean(beanName);
	}
	
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
		SecurityInterceptorFilter securityInterceptorFilter = 
			(SecurityInterceptorFilter)getBean("securityInterceptorFilter");
		securityInterceptorFilter.loadDataSource();
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
	
	@Override
	@SuppressWarnings("static-access")
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException
	{
		this.applicationContext = applicationContext;
	}
}
