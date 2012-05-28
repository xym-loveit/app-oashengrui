package cn.trymore.core.web.action;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForward;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.util.MessageResources;

import cn.trymore.core.common.Constants;
import cn.trymore.core.exception.WebException;
import cn.trymore.core.model.ModelUser;
import cn.trymore.core.util.UtilString;

/**
 * Base web action, covers the basic web handles. 
 * And also most of the entry entity operations
 * are included in the base action since everything is entry models based on the
 * application structure.
 * 
 * @author  Jeccy.Zhao
 *
 */
public class BaseAction 
extends DispatchAction
{
	
	/**
	 * The default action page on success
	 */
	protected final String ACTION_PAGE_SUCCESS = "success";
	
	/**
	 * The default action page on failure
	 */
	protected final String ACTION_PAGE_FAILURE = "fail";
	
	/**
	 * The default action page on error
	 */
	protected final String ACTION_PAGE_ERROR = "error";
	
	/**
	 * The AJAX response entity
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	protected static class AjaxResponse
	{
		public AjaxResponse()
		{
		}
		public static final String RESPONSE_ERROR = "{\"statusCode\":\"300\", \"message\":\"操作失败\"}";
		public static final String RESPONSE_SUCCESS = "{\"statusCode\":\"200\", \"message\":\"操作成功\"}";
	}
	
	/**
	 * Obtains the current user from session
	 * 
	 * @param request
	 *          the HTTP servlet request
	 * @return the user entity model 
	 */
	protected ModelUser getCurrentUser (HttpServletRequest request)
	{
		return (ModelUser) request.getSession().getAttribute(
				Constants.DefaultUsrParamSessionHolder);
	}
	
	/**
	 * Clears the current user from session
	 * 
	 * @param request
	 *          the HTTP servlet request
	 * @param account
	 *          the account entity model
	 */
	protected void setCurrentUser (HttpServletRequest request, ModelUser account)
	{
		request.getSession().setAttribute(Constants.DefaultUsrParamSessionHolder, account);
	}
	
	/**
	 * Clears the current user from session
	 * 
	 * @param request
	 *          the HTTP servlet request
	 */
	protected void clearCurrentUser (HttpServletRequest request)
	{
		request.getSession().setAttribute(Constants.DefaultUsrParamSessionHolder, null);
	}
	
	
	/**
	 * Returns the referred URL with the specified request
	 * 
	 * @param request
	 *          the httpServlet request
	 * @return the referred link
	 */
	protected String getRefererUrl(HttpServletRequest request)
	{
		return request.getHeader("REFERER") != null ? request.getHeader("REFERER") : null;
	}
	
	/**
	 * Returns the host URL with the specified request
	 * 
	 * @param request
	 *           the httpServlet request
	 * @return the host URL
	 */
	protected String getHostUrl (HttpServletRequest request) 
	{
		if (request != null) 
		{
			String path = request.getContextPath();  
			String basePath = request.getScheme()+"://"+request.getServerName()+
				(request.getServerPort() == 80 ? "" : (":"+request.getServerPort())) +path+"/";
			return basePath;
		}
		return null;
	}
	
	/**
	 * Returns true if the request contains "AJAX" parameter key
	 * 
	 * @param request
	 *          the httpServlet request
	 * @return true if the request contains "AJAX" parameter key; false otherwise
	 */
	protected boolean isAjaxReq(HttpServletRequest request)
	{
		return request.getParameter(Constants.DefaultAjaxParamFlag) != null;
	}
	
	/**
	 * Prints the message to response
	 * 
	 * @param response
	 *           the httpServlet response
	 * @param message
	 *           the message to be printed
	 * @return an empty action forward
	 */
	protected ActionForward ajaxPrint(HttpServletResponse response,
			String message) throws WebException
	{
		try
		{
			response.getWriter().write(message);
			return null;
		} 
		catch (IOException e)
		{
			throw new WebException("Ajax print message failed:" + message, e);
		}
	}
	
	/**
	 * Obtains the message from i18n resource file
	 * 
	 * @param request
	 *          the httpServlet request
	 * @param key
	 *          the key value of message
	 * @return message text
	 */
	protected String getMessageFromResource(HttpServletRequest request,String key)
	{
		return getMessageFromResource(request,key,null,null);
	}
	
	/**
	 * Obtains the message from i18n resource file
	 * 
	 * @param request
	 *          the httpServlet request
	 * @param key
	 *          the key value of message
	 * @param args
	 *          the arguments to be injected into message
	 * @return message text
	 */
	protected String getMessageFromResource(HttpServletRequest request,
			String key, Object[] args)
	{
		return getMessageFromResource(request,key,args,null);
	}
	
	/**
	 * Obtains the message from i18n resource file
	 * 
	 * @param request
	 *          the httpServlet request
	 * @param key
	 *          the key value of message
	 * @param args
	 *          the arguments to be injected into message
	 * @param cfgKey
	 *          the configured key value of message
	 * @return message text
	 */
	protected String getMessageFromResource(HttpServletRequest request,
			String key, Object[] args, String cfgKey)
	{
		MessageResources rs = cfgKey != null ? getResources(request, cfgKey) : getResources(request);
		return rs != null ? (args == null ? rs.getMessage(key) : rs.getMessage(key, args)): "";
	}
	
	/**
	 * Obtains all of the requested parameters
	 * 
	 * @param request
	 *         the http servlet request
	 * @return all of requested parameters
	 */
	protected Map<String, String> getAllRequestParameters (HttpServletRequest request)
	{
		Map<String, String> parameters = new HashMap<String, String>();
		
		if (request != null)
		{
			Enumeration<String> paramNames = request.getParameterNames();
			
			while(paramNames.hasMoreElements())
			{
				String paramName = (String)paramNames.nextElement();
				String paramValue = request.getParameter(paramName);
				
				if (!parameters.containsKey(paramName))
				{
					parameters.put(paramName, paramValue);
				}
			}
		}
		
		return parameters;
	}
	
	/**
	 * Obtains the request query string from the request
	 * 
	 * @param request
	 *           the HTTP servlet request
	 * @param excludes
	 *           the excluded parameters
	 * @return
	 */
	protected String getRequestQueryString (HttpServletRequest request, String[] excludes)
	{
		return this.getRequestQueryString(request, excludes, true);
	}
	
	/**
	 * Obtains the request query string from the request
	 * 
	 * @param request
	 *           the HTTP servlet request
	 * @param excludes
	 *           the excluded parameters
	 * @param paramOutput
	 *           the parameter will be printed out if set as true; false otherwise
	 * @return
	 */
	protected String getRequestQueryString (HttpServletRequest request, String[] excludes, boolean paramOutprint)
	{
		Map<String, String> parameters = this.getAllRequestParameters(request);
		if (parameters != null && parameters.size() > 0)
		{
			StringBuilder builder = new StringBuilder();
			boolean paramAppended = false;
			
			List<String> excludeParams = excludes != null ? Arrays.asList(excludes) : null;
			
			for (Map.Entry<String, String> parameter : parameters.entrySet())
			{
				String paramName = parameter.getKey();
				String paramValue = parameter.getValue();
				
				if (paramOutprint)
				{
					request.setAttribute(paramName, paramValue);
				}
				
				if (excludes == null || (!excludeParams.contains(paramName)))
				{
					if (paramAppended)
					{
						builder.append("&");
					}
					
					if (UtilString.isNotEmpty(paramName))
					{
						builder.append(paramName);
						builder.append("=");
						builder.append(paramValue);
						
						paramAppended = true;
					}
				}
			}
			
			String queryString = builder.toString();
			
			return UtilString.isNotEmpty(queryString) ? queryString : null;
		}
		
		return null;
	}
	
}
