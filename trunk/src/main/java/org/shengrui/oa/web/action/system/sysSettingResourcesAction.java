package org.shengrui.oa.web.action.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.trymore.core.web.action.BaseAction;

/**
 * 系统设置 - 资源设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysSettingResourcesAction
extends BaseAction
{
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-列表展现
	 */
	public ActionForward pageMenuIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.res.menu.list");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 菜单设置-菜单详细页面
	 */
	public ActionForward pageMenuDetail (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.res.menu.deail");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 功能设置-列表展现
	 */
	public ActionForward pageFuncIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.res.func.list");
	}
	
}
