package org.shengrui.oa.web.action.personal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;

/**
 * WebAction: 我的任务
 * 
 * @author Jeccy.Zhao
 *
 */
public class MyTaskPlanAction
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyTaskPlanAction.class);
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我的任务
	 */
	public ActionForward pageTaskIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.task.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我发起的任务
	 */
	public ActionForward pageTaskLaunched (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.task.launched");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 任务详情页面
	 */
	public ActionForward dialogTaskPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			// 获取所有校区
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 获取按校区所有部门列表
			Map<Integer, List<ModelSchoolDepartment>> departments = this.getAllDepartments(request, false);
			
			if (departments != null)
			{
				List<Object> depNames = this.serviceSchoolDepartment.getDistinctDepartmentNames();
				if (depNames != null)
				{
					request.setAttribute("depNames", depNames);
					
					Map<String, String> depSetIds = new HashMap<String, String>();
					
					// 总部部门
					List<ModelSchoolDepartment> depMasters = departments.get(AppUtil.EAppSchoolType.HEADQUARTERS.getValue());
					if (depMasters != null)
					{
						for (ModelSchoolDepartment dep : depMasters)
						{
							if (depNames.contains(dep.getDepName()))
							{
								// depSetIds.put(dep.getDepName(), value)
							}
						}
					}
					
					// 校区部门
					List<ModelSchoolDepartment> depCampus = departments.get(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue());
				}
			}
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when open dialog page for my task creation..", e);
		}
		
		return mapping.findForward("dialog.task.page");
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
	
}
