package org.shengrui.oa.web.action.index;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.web.action.BaseAppAction;

/**
 * The index web action, it shows the index page for system.
 * 
 * @author  Jeccy.Zhao
 *
 */
public class IndexAction 
extends BaseAppAction
{
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The index presentation page action.
	 */
	public ActionForward index (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("index");
	}
	
}
