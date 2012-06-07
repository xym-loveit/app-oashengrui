package cn.trymore.core.util;

import javax.servlet.ServletContext;

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
	
	public static ServletContext getServletContext()
	{
		return servletContext;
	}

	public static void setServletContext(ServletContext servletContext)
	{
		UtilApp.servletContext = servletContext;
	}
}
