package org.shengrui.oa.web.action.personal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.web.action.BaseAppAction;

/**
 * WebAction: 我的申请
 * 
 * @author Jeccy.Zhao
 *
 */
public class MyFormApplicationAction
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyFormApplicationAction.class);
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我的申请
	 */
	public ActionForward pageMyApplicationIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return null;
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我要申请
	 */
	public ActionForward dialogApplicationFormPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return null;
	}
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 保存申请
	 */
	public ActionForward actionSaveApplication (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return null;
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
	
}
