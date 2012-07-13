package org.shengrui.oa.web.action.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

/**
 *工作安排设置-工作模板设置
 * 
 * @author Tang
 *
 */
public class sysSettingWorkAction
extends sysSettingBaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(sysSettingWorkAction.class);
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 工作安排设置-工作模板设置
	 */
	public ActionForward pageWorkTemplateIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		System.out.println("进入工作安排模板设置");
		
		return mapping.findForward("page.sys.setting.work.template.index");
	}
	

	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 工作安排设置-工作基础设置
	 */
	public ActionForward pageWorkBaseIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		System.out.println("进入工作基础设置");
		
		//获得校区信息
        List<ModelSchoolDistrict> districts=this.getAllDistricts();
        request.setAttribute("districts", districts);
		
		return mapping.findForward("page.sys.setting.work.base.index");
	}
	
	

	public static Logger getLogger()
	{
		return LOGGER;
	}

}
