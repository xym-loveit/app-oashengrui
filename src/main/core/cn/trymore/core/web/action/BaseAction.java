package cn.trymore.core.web.action;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForward;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.util.MessageResources;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.service.system.ServiceAppMenu;
import org.shengrui.oa.service.system.ServiceAppRole;

import cn.trymore.core.common.Constants;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

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
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(BaseAction.class);
	
	/**
	 * The default action page on success
	 */
	protected static final String ACTION_PAGE_SUCCESS = "success";
	
	/**
	 * The default action page on failure
	 */
	protected static final String ACTION_PAGE_FAILURE = "fail";
	
	/**
	 * The default action page on error
	 */
	protected static final String ACTION_PAGE_ERROR = "error";
	
	/**
	 * The default response for remote succeed operations
	 */
	protected static final String AJAX_RESPONSE_TRUE = "true";
	
	/**
	 * The default response for remote failed operations
	 */
	protected static final String AJAX_RESPONSE_FALSE = "false";
	
	/**
	 * The success status code
	 */
	protected static final int STATUS_CODE_SUCCESS = 200;
	
	/**
	 * The error status code
	 */
	protected static final int STATUS_CODE_ERROR = 300;
	
	/**
	 * The none callback type
	 */
	protected static final String CALLBACK_TYPE_NONE = "";
	
	/**
	 * The forward callback type
	 */
	protected static final String CALLBACK_TYPE_FORWARD = "forward";
	
	/**
	 * The forward confirmation callback type
	 */
	protected static final String CALLBACK_TYPE_FORWARD_CONFIRM = "forwardConfirm";

	/**
	 * The close current navTab or dialog callback type
	 */
	protected static final String CALLBACK_TYPE_CLOSE = "closeCurrent";
	
	/**
	 * The reload callback type
	 */
	protected static final String CALLBACK_TYPE_RELOAD = "reload";
	
	/**
	 * The current navtabId
	 */
	protected static final String CURRENT_NAVTABID = "navTabIdCurrent";
	
	/**
	 * The paging size parameter
	 */
	protected static final String PAGING_PARAM_PAGESIZE = "numPerPage";
	
	/**
	 * The paging number parameter
	 */
	protected static final String PAGING_PARAM_PAGENUM = "pageNum";
	
	/**
	 * The field name for option key
	 */
	protected static final String FIELD_OPTION_KEY = "__optionKey";
	
	/**
	 * The field name for option value
	 */
	protected static final String FIELD_OPTION_VALUE = "__optionValue";
	
	/**
	 * The AJAXDONE callback JSON string
	 */
	protected final String DWZ_CALLBACK_AJAXDONE_JSON = "{" +
			"\"statusCode\"   : \"#statusCode#\"," +
			" \"message\"      : \"#message#\", " +
			"\"navTabId\"      : \"#navTabId#\"," +
			" \"forwardUrl\"    : \"#forwardUrl#\", " +
			"\"callbackType\" : \"#callbackType#\"," +
			"\"formClear\"      : \"#formClear#\"}";
	
	/**
	 * The application menu service.
	 */
	@Resource
	protected ServiceAppMenu serviceAppMenu;
	
	/**
	 * The application role service
	 */
	@Resource
	protected ServiceAppRole serviceAppRole;
	
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
	protected Object getCurrentUser (HttpServletRequest request)
	{
		return request.getSession().getAttribute(
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
	protected void setCurrentUser (HttpServletRequest request, Object account)
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
			String message) //throws WebException
	{
		try
		{
			response.getWriter().write(message);
		} 
		catch (IOException e)
		{
			// do nothing here.
			// throw new WebException("Ajax print message failed:" + message, e);
		}
		
		return null;
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
	
	/**
	 * 
	 * @param message
	 * @return
	 */
	protected String getSuccessCallback (String message)
	{
		return  getSuccessCallback(message, CALLBACK_TYPE_CLOSE, null, null, true);
	}
	
	/**
	 * 
	 * @param message
	 * @param navTabId
	 * @return
	 */
	protected String getSuccessCallbackAndReloadCurrent (String message)
	{
		return  getSuccessCallback(message, CALLBACK_TYPE_RELOAD, CURRENT_NAVTABID, null, true);
	}
	
	/**
	 * 
	 * @param message
	 * @param callbackType
	 * @param navTabId
	 * @param forwardURL
	 * @return
	 */
	protected String getSuccessCallback (String message, String callbackType, String navTabId, String forwardURL, boolean formClear)
	{
		return generateCallbackJson(STATUS_CODE_SUCCESS, message, callbackType, navTabId, forwardURL, formClear);
	}
	
	/**
	 * 
	 * @param message
	 * @return
	 */
	protected String getErrorCallback (String message)
	{
		return  getErrorCallback(message, CALLBACK_TYPE_NONE, null, null, true);
	}
	
	/**
	 * 
	 * @param message
	 * @param callbackType
	 * @param navTabId
	 * @param forwardURL
	 * @return
	 */
	protected String getErrorCallback (String message, String callbackType, String navTabId, String forwardURL, boolean formClear)
	{
		return generateCallbackJson(STATUS_CODE_ERROR, message, callbackType, navTabId, forwardURL, formClear);
	}
	
	/**
	 * Generates the callback JSON string regarding to the callback JSON template,
	 * it looks like, <br/>
	 * 
	 *{"statusCode":"200", "message":"操作成功", "navTabId":"navNewsLi", "forwardUrl":"", "callbackType":"closeCurrent"}
	 *
	 * @param statusCode
	 * @param message
	 * @param callbackType
	 * @param navTabId
	 * @param forwardURL
	 * @return
	 */
	private String generateCallbackJson (Integer statusCode, 
			String message, String callbackType, String navTabId, String forwardURL, boolean formClear)
	{
		String callbackJson = DWZ_CALLBACK_AJAXDONE_JSON;
		
		callbackJson = callbackJson.replace("#statusCode#", 
				statusCode != null ? statusCode.toString() : "");
		
		callbackJson = callbackJson.replace("#message#", 
				UtilString.isNotEmpty(message) ? message : "");
		
		callbackJson = callbackJson.replace("#callbackType#", 
				UtilString.isNotEmpty(callbackType) ? callbackType : "");
		
		callbackJson = callbackJson.replace("#navTabId#", 
				UtilString.isNotEmpty(navTabId) ? navTabId : "");
		
		callbackJson = callbackJson.replace("#forwardUrl#", 
				((CALLBACK_TYPE_FORWARD.equals(callbackType) || CALLBACK_TYPE_FORWARD_CONFIRM.equals(callbackType)) && UtilString.isNotEmpty(forwardURL)) ? forwardURL : "");
		
		callbackJson = callbackJson.replace("#formClear#", 
				formClear ? "true" : "false");
		
		return callbackJson;
	}
	
	/**
	 * Returns true if the specified entity id valid.
	 * 
	 * @param entityId
	 *          the entity object id.
	 * @return true if id valid; false otherwise.
	 */
	protected boolean isObjectIdValid (String entityId)
	{
		if (UtilString.isNotEmpty(entityId))
		{
			try
			{
				return Integer.parseInt(entityId) > 0;
			}
			catch (Exception e)
			{
				// do nothing here.
			}
		}
		
		return false;
	}
	
	/**
	 * Obtains the paging bean from request
	 * 
	 * @param request
	 * @return
	 */
	protected PagingBean getPagingBean (HttpServletRequest request)
	{
		try
		{
			return new PagingBean(
					Integer.parseInt(request.getParameter(PAGING_PARAM_PAGENUM)), 
					Integer.parseInt(request.getParameter(PAGING_PARAM_PAGESIZE)));
		}
		catch (Exception e)
		{
			return new PagingBean(0, PagingBean.DEFAULT_PAGE_SIZE);
		}
	}
	
	/**
	 * Writes pagination to response entity.
	 * 
	 * @param request
	 * @param pagingBean
	 * @param pagingData
	 */
	@SuppressWarnings("rawtypes")
	protected void outWritePagination (HttpServletRequest request, 
			PagingBean pagingBean, PaginationSupport pagingData)
	{
		if (pagingBean == null)
		{
			pagingBean = new PagingBean();
		}
		
		if (pagingData != null && pagingData.getItemCount() > 0)
		{
			pagingBean.setTotalItems(pagingData.getTotalCount());
			pagingBean.setCurrentPage(pagingData.getCurrentPage());
			pagingBean.setTotalPages(pagingData.getTotalPage());
		}
		
		request.setAttribute("pagingBean", pagingBean);
		
	}
	
	/**
	 * 获取父菜单列表
	 * 
	 * @param request
	 * @return
	 */
	protected List<ModelAppMenu> getRootMenus(HttpServletRequest request)
	{
		List<ModelAppMenu> result = null;
		
		if (request.getParameter("lookup") != null)
		{
			request.setAttribute("lookup", true);
		}
		
		try
		{
			result = this.serviceAppMenu.getAllRootMenus();
			request.setAttribute("rootMenus", result);
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch the root menus.", e);
		}
		
		return result;
	}
	
	public ServiceAppMenu getServiceAppMenu()
	{
		return serviceAppMenu;
	}

	public void setServiceAppMenu(ServiceAppMenu serviceAppMenu)
	{
		this.serviceAppMenu = serviceAppMenu;
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
