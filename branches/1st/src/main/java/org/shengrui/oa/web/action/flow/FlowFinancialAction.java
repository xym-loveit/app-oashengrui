package org.shengrui.oa.web.action.flow;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.trymore.core.exception.ServiceException;

/**
 * 工作流设置 - 财务审批流程设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class FlowFinancialAction
extends FlowBaseAction
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(FlowFinancialAction.class);
			
	/**
	 * The slug name for financial process
	 */
	public static final String PROCESS_TYPE_SLUG = "finance";
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 财务审批流程页面
	 */
	public ActionForward pageFlowIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		request.setAttribute("typeSlug", PROCESS_TYPE_SLUG);
		
		try
		{
			request.setAttribute("rootTypes", 
					this.getProcessRootTypesBySlug(PROCESS_TYPE_SLUG));
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when obtain the root types with type:" + PROCESS_TYPE_SLUG, e);
		}
		
		return mapping.findForward("page.sys.setting.flow.financial.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 财务审批流程分类删除
	 */
	public ActionForward actionRemoveFlowType (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return null;
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
}
