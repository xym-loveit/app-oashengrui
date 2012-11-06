package cn.trymore.core.web.servlet;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

/**
 * It aims to filter the response header, 
 * like e.g. the cache control. 
 * 
 * @author x36zhao
 *
 */
public class ResponseHeaderFilter
implements Filter
{
	/**
	 * The filter configuration
	 */
	private FilterConfig filterConfig;
	
	/*
	 * (non-Javadoc)
	 * @see javax.servlet.Filter#destroy()
	 */
	@Override
	public void destroy()
	{
		this.filterConfig = null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) throws IOException, ServletException
	{
		HttpServletResponse localHttpServletResponse = (HttpServletResponse)response;
		Enumeration<String> localEnumeration = this.filterConfig.getInitParameterNames();
		while (localEnumeration.hasMoreElements())
		{
			String paramName = localEnumeration.nextElement();
			localHttpServletResponse.addHeader(
					paramName, 
					this.filterConfig.getInitParameter(paramName));
		}
		filterChain.doFilter(request, localHttpServletResponse);
	}
	
	/*
	 * (non-Javadoc)
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	@Override
	public void init(FilterConfig filterConfig) throws ServletException
	{
		this.filterConfig = filterConfig;
	}

}
