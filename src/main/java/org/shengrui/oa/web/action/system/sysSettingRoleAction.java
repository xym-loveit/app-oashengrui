package org.shengrui.oa.web.action.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.trymore.core.web.action.BaseAction;

/**
 * 系统设置 - 权限组配置
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysSettingRoleAction
extends BaseAction
{
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 权限组配置-列表展现
	 */
	public ActionForward pageRoleIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.role.list");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 权限组配置-详细页面
	 */
	public ActionForward pageRoleDetail (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.role.detail");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 权限组配置-授权功能页面
	 */
	public ActionForward pageRolePrivilege (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.role.privilege");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 权限组配置-权限删除
	 */
	public ActionForward opRoleRemove (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return null;
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 权限组配置-权限保存
	 */
	public ActionForward opRoleSave (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return null;
	}
	
	
}
