package org.shengrui.oa.web.action.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.service.system.ServiceAppFunction;
import org.shengrui.oa.service.system.ServiceAppMenu;
import org.shengrui.oa.service.system.ServiceSchoolDepartment;
import org.shengrui.oa.service.system.ServiceSchoolDepartmentPosition;
import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.web.action.BaseAction;

public class sysSettingBaseAction
extends BaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(sysSettingBaseAction.class);
	
	/**
	 * The application menu service.
	 */
	@Resource
	protected ServiceAppMenu serviceAppMenu;
	
	/**
	 * The application function service
	 */
	@Resource
	protected ServiceAppFunction serviceAppFunc;
	
	/**
	 * The school department service
	 */
	@Resource
	protected ServiceSchoolDepartment serviceSchoolDepartment;
	
	/**
	 * The school department position service
	 */
	@Resource
	protected ServiceSchoolDepartmentPosition serviceSchoolDepartmentPosition;
	
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
	
	/**
	 * 获取部门列表
	 * 
	 * @param request
	 * @return
	 */
	protected Map<Integer, List<ModelSchoolDepartment>> getAllDepartments (HttpServletRequest request)
	{
		try
		{
			Map<Integer, List<ModelSchoolDepartment>> departments = 
					new HashMap<Integer, List<ModelSchoolDepartment>>();
			
			// 获取总校部门列表
			departments.put(AppUtil.EAppSchoolType.HEADQUARTERS.getValue(), 
					this.serviceSchoolDepartment.getDepartmentByOrganization(AppUtil.EAppSchoolType.HEADQUARTERS.getValue()));
			
			// 获取校区部门列表
			departments.put(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue(), 
					this.serviceSchoolDepartment.getDepartmentByOrganization(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue()));
			
			// 获取片区部门列表
			departments.put(AppUtil.EAppSchoolType.AREA_SLOT.getValue(), 
					this.serviceSchoolDepartment.getDepartmentByOrganization(AppUtil.EAppSchoolType.AREA_SLOT.getValue()));
			
			request.setAttribute("departments", departments);
			
			return departments;
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch the departments.", e);
		}
		
		return null;
	}
	
	public ServiceAppMenu getServiceAppMenu()
	{
		return serviceAppMenu;
	}

	public void setServiceAppMenu(ServiceAppMenu serviceAppMenu)
	{
		this.serviceAppMenu = serviceAppMenu;
	}

	public ServiceAppFunction getServiceAppFunc()
	{
		return serviceAppFunc;
	}

	public void setServiceAppFunc(ServiceAppFunction serviceAppFunc)
	{
		this.serviceAppFunc = serviceAppFunc;
	}
	
	public ServiceSchoolDepartment getServiceSchoolDepartment()
	{
		return serviceSchoolDepartment;
	}

	public void setServiceSchoolDepartment(ServiceSchoolDepartment serviceSchoolDepartment)
	{
		this.serviceSchoolDepartment = serviceSchoolDepartment;
	}

	public ServiceSchoolDepartmentPosition getServiceSchoolDepartmentPosition()
	{
		return serviceSchoolDepartmentPosition;
	}

	public void setServiceSchoolDepartmentPosition(
			ServiceSchoolDepartmentPosition serviceSchoolDepartmentPosition)
	{
		this.serviceSchoolDepartmentPosition = serviceSchoolDepartmentPosition;
	}
	
}
