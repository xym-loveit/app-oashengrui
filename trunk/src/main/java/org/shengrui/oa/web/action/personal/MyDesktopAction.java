package org.shengrui.oa.web.action.personal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.trymore.core.web.action.BaseAction;

/**
 * The index web action, 
 * it consists all of my available functionalities.
 * 
 * @author  Jeccy.Zhao
 *
 */
public class MyDesktopAction 
extends BaseAction
{
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The presentation page action for my work plan
	 */
	public ActionForward pageMyWorkplan (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.my.workplan");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The presentation page action for my work plan
	 */
	public ActionForward pageMyConference (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.my.conference");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The presentation page action for my work plan
	 */
	public ActionForward pageMyNews (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.my.news");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The presentation page action for my work plan
	 */
	public ActionForward pageMyDoc (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.my.doc");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The presentation page action for my work plan
	 */
	public ActionForward pageMyBaron (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.my.baron");
	}
	
}
