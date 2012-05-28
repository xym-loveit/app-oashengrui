package org.shengrui.oa.web.action.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.trymore.core.web.action.BaseAction;

/**
 * 系统设置 - 学校设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysSettingDepartmentAction
extends BaseAction
{
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-校区设置
	 */
	public ActionForward pageDepCampusZoneIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.dep.campusZone.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-部门岗位设置
	 */
	public ActionForward pageDepPositionIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.dep.position.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-岗位权限设置
	 */
	public ActionForward pageDepPositionPrivilege (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.dep.position.privilege");
	}
}
