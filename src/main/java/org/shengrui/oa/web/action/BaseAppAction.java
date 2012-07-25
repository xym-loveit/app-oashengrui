package org.shengrui.oa.web.action;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.system.ModelAppRole;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.admin.ServiceConferenceInfo;
import org.shengrui.oa.service.admin.ServiceTaskPlan;
import org.shengrui.oa.service.finan.ServiceFinanContract;
import org.shengrui.oa.service.finan.ServiceFinanExpense;
import org.shengrui.oa.service.hrm.ServiceHrmEmployee;
import org.shengrui.oa.service.info.ServiceInMessage;
import org.shengrui.oa.service.info.ServiceShortMessage;
import org.shengrui.oa.service.news.ServiceNewsManage;
import org.shengrui.oa.service.system.ServiceAppDictionary;
import org.shengrui.oa.service.system.ServiceAppUser;
import org.shengrui.oa.service.system.ServiceSchoolDepartment;
import org.shengrui.oa.service.system.ServiceSchoolDepartmentPosition;
import org.shengrui.oa.service.system.ServiceSchoolDistrict;
import org.shengrui.oa.service.system.ServiceSchoolPositionSet;
import org.shengrui.oa.util.AppUtil;

import com.google.gson.FieldNamingStrategy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import cn.trymore.core.common.Constants;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.model.ModelBase;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.action.BaseAction;
import cn.trymore.oa.model.system.ModelFileAttach;
import cn.trymore.oa.service.system.ServiceFileAttach;
import cn.trymore.oa.service.system.ServiceSystemLog;

/**
 * The base application action.
 * 
 * @author Jeccy.Zhao
 *
 */
public class BaseAppAction
extends BaseAction
{
	protected ServiceSystemLog serviceSystemLog;
	/**
	 * @return the serviceSystemLog
	 */
	public ServiceSystemLog getServiceSystemLog() {
		return serviceSystemLog;
	}

	/**
	 * @param serviceSystemLog the serviceSystemLog to set
	 */
	public void setServiceSystemLog(ServiceSystemLog serviceSystemLog) {
		this.serviceSystemLog = serviceSystemLog;
	}

	protected ServiceConferenceInfo serviceConference;
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(BaseAppAction.class);
			
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
	 * The school district service
	 */
	@Resource
	protected ServiceSchoolDistrict serviceSchoolDistrict;
	
	/**
	 * The school position set service
	 */
	@Resource
	protected ServiceSchoolPositionSet serviceSchoolPositionSet;
	
	/**
	 * The user service
	 */
	@Resource
	protected ServiceAppUser serviceAppUser;
	
	/**
	 * The employee service
	 */
	@Resource
	protected ServiceHrmEmployee serviceHrmEmployee;
	
	/**
	 * The file attach service
	 */
	@Resource
	protected ServiceFileAttach serviceFileAttach;
	
	protected ServiceNewsManage serviceNewsManage;
	
	protected ServiceAppDictionary serviceAppDictionary;
	
	protected ServiceTaskPlan serviceTaskPlan;
	
	protected ServiceFinanExpense serviceFinanExpense;
	
	protected ServiceFinanContract serviceFinanContract;
	
	/**
	 * The repository of short message
	 */
	protected ServiceShortMessage serviceShortMessage;
	
	/**
	 * The repository of message in
	 */
	protected ServiceInMessage serviceInMessage;
	
	/**
	 * 获取所有校区
	 * 
	 * @return
	 */
	protected List<ModelSchoolDistrict> getAllDistricts()
	{
		try
		{
			return this.serviceSchoolDistrict.getAll();
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetching all school districts", e);
		}
		
		return null;
	}
	
	/**
	 * 根据角色类型获取角色列表
	 * 
	 * @param roleType
	 * @return
	 */
	protected List<ModelAppRole> getRolesByType (Integer roleType)
	{
		if (roleType != null)
		{
			try
			{
				return this.serviceAppRole.getRolesByType(roleType);
			} 
			catch (Exception e)
			{
				LOGGER.error("Exception raised when obtain roles with roleType:" + roleType, e);
			}
		}
		
		return null;
	}
	
	/**
	 * 获取部门列表
	 * 
	 * @param request
	 * @param showPositions
	 * @return
	 */
	protected Map<Integer, List<ModelSchoolDepartment>> getAllDepartments (
			HttpServletRequest request, boolean showPositions)
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
			request.setAttribute("showPositions", showPositions);
			
			return departments;
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch the departments.", e);
		}
		
		return null;
	}
	
	/**
	 * 根据结构类型获取部门列表
	 * 
	 * @param orgId
	 * @return
	 */
	protected List<ModelSchoolDepartment> getDepartmentByOrganization (String orgId)
	{
		try
		{
			return this.serviceSchoolDepartment.getDepartmentByOrganization(Integer.parseInt(orgId));
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when obtain department by organization with id:" + orgId, e);
		}
		return null;
	}
	
	/**
	 * 根据部门ID获取岗位列表
	 * 
	 * @param orgId
	 * @return
	 */
	protected List<ModelSchoolDepartmentPosition> getPositionByDepartment (String depId)
	{
		try
		{
			return this.serviceSchoolDepartmentPosition.getPositionByDepartmentId(depId);
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when obtain positions by department with id:" + depId, e);
		}
		return null;
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-部门岗位设置 - 根据结构类型刷新部门对应的列表
	 */
	public ActionForward actionLoadDepartmentByOrg (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String orgId = request.getParameter("orgId");
		
		if (!UtilString.isNotEmpty(orgId) && UtilString.isNotEmpty(request.getParameter("districtId")))
		{
			try
			{
				ModelSchoolDistrict district = this.serviceSchoolDistrict.get(request.getParameter("districtId"));
				if (district != null)
				{
					orgId = district.getDistrictType() != null ? district.getDistrictType().toString() : null;
				}
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when fetch the district with id.", e);
			}
		}
		
		if (UtilString.isNotEmpty(orgId))
		{
			List<ModelSchoolDepartment> departments = this.getDepartmentByOrganization(orgId);
			
			if (departments != null)
			{
				// 只显示@Expose字段, 并且进行重命名显示
				Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().setFieldNamingStrategy(new FieldNamingStrategy()
				{
					@Override
					public String translateName(Field field)
					{
						if ("id".equals(field.getName()))
						{
							return FIELD_OPTION_VALUE;
						}
						
						if ("depName".equals(field.getName()))
						{
							return FIELD_OPTION_KEY;
						}
						
						return field.getName();
					}
				}).create();
				return ajaxPrint(response, gson.toJson(departments));
			}
		}
		
		return ajaxPrint(response, "[]");
	}
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 根据部门ID刷新岗位列表
	 */
	public ActionForward actionLoadPositionByDepartment (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String depId = request.getParameter("depId");
		
		if (UtilString.isNotEmpty(depId))
		{
			List<ModelSchoolDepartmentPosition> positions = this.getPositionByDepartment(depId);
			if (positions != null)
			{
				// 只显示@Expose字段, 并且进行重命名显示
				Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().setFieldNamingStrategy(new FieldNamingStrategy()
				{
					@Override
					public String translateName(Field field)
					{
						if ("id".equals(field.getName()))
						{
							return FIELD_OPTION_VALUE;
						}
						
						if ("positionName".equals(field.getName()))
						{
							return FIELD_OPTION_KEY;
						}
						
						return field.getName();
					}
				}).create();
				return ajaxPrint(response, gson.toJson(positions));
			}
		}
		
		return ajaxPrint(response, "[]");
	}
	
	/**
	 * 根据用户名搜索用户并自动提示
	 * 
	 * @param userName
	 * @return
	 */
	public ActionForward lookupUserByName (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		String fullName = request.getParameter("fullName");
		
		try
		{
			StringBuilder builder = new StringBuilder();
			List<ModelAppUser> result = this.serviceAppUser.findByFullName(fullName, true);
			if (result != null && result.size() > 0)
			{
				int count = 0;
				for (ModelAppUser user : result)
				{
					count++;
					
					builder.append("{");
					builder.append("\"id\":\"" + user.getId() + "\",");
					builder.append("\"fullName\":\"" + user.getFullName() + "\"");
					builder.append("}");
					
					if (count < result.size())
					{
						builder.append(",");
					}
				}
				String callbackJson = "[" + builder.toString() + "]";
				return ajaxPrint(response, callbackJson);
			}
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when lookup user with full name:" + fullName, e);
		}
		
		return ajaxPrint(response, "[]");
	}
	
	/**
	 * 根据姓名搜索员工并自动提示
	 * 
	 * @param userName
	 * @return
	 */
	public ActionForward lookupEmployeeByName (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		String fullName = request.getParameter("fullName");
		
		try
		{
			StringBuilder builder = new StringBuilder();
			List<ModelHrmEmployee> result = this.serviceHrmEmployee.findByFullName(fullName, true);
			if (result != null && result.size() > 0)
			{
				int count = 0;
				for (ModelHrmEmployee employee : result)
				{
					count++;
					
					builder.append("{");
					
					builder.append("\"id\":\"" + employee.getId() + "\",");
					builder.append("\"fullName\":\"" + employee.getEmpName() + "\",");
					
					if (employee.getEmployeeDepartment() != null)
					{
						builder.append("\"depId\":\"" + employee.getEmployeeDepartment().getId() + "\",");
						builder.append("\"depName\":\"" + employee.getEmployeeDepartment().getDepName() + "\",");
					}
					
					if (employee.getEmployeeDistrict() != null)
					{
						builder.append("\"districtId\":\"" + employee.getEmployeeDistrict().getId() + "\",");
						builder.append("\"districtName\":\"" + employee.getEmployeeDistrict().getDistrictName() + "\",");
					}
					
					if (employee.getEmployeePosition() != null)
					{
						builder.append("\"posId\":\"" + employee.getEmployeePosition().getId() + "\",");
						builder.append("\"posName\":\"" + employee.getEmployeePosition().getPositionName() + "\",");
					}
					
					builder.append("\"phoneNo\":\"" + employee.getPhoneNo() + "\"");
					
					builder.append("}");
					
					if (count < result.size())
					{
						builder.append(",");
					}
				}
				String callbackJson = "[" + builder.toString() + "]";
				return ajaxPrint(response, callbackJson);
			}
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when lookup user with full name:" + fullName, e);
		}
		
		return ajaxPrint(response, "[]");
	}
	
	/**
	 * Handles file attachments
	 * 
	 * @param entity
	 *          the entity that has property of file attachment
	 * @param request
	 */
	protected void handleFileAttachments (ModelBase entity, HttpServletRequest request)
	{
		String fileUrls = request.getParameter(Constants.DefaultFileUrlParam);
		if (entity.getAttachFiles() != null)
		{
			entity.setAttachFiles(null);
		}
		if (UtilString.isNotEmpty(fileUrls))
		{
			if (entity.getAttachFiles() == null)
			{
				entity.setAttachFiles(new HashSet<ModelFileAttach>());
			}
			
			String[] urls = fileUrls.split(",");
			for (String url : urls)
			{
				if (UtilString.isNotEmpty(url))
				{
					try
					{
						ModelFileAttach fileEntity = this.serviceFileAttach.getByPath(url);
						if (fileEntity != null)
						{
							entity.getAttachFiles().add(fileEntity);
						}
					}
					catch (Exception e)
					{
						LOGGER.error("Exception raised when saving file: " + url);
					}
				}
			}
		}
	}
	
	/**
	 * Generates the employee no with the specified school district and department.
	 * 
	 * Rule for employee no:
	 * district_no + department_no + SN
	 * 
	 * @param district
	 *                 the employee district
	 * @param department
	 *                 the employee department
	 * @param startIndex
	 *                 the start index
	 * @return employee no
	 */
	protected String generateEmployeeNo (ModelSchoolDistrict district, 
			ModelSchoolDepartment department, int startIndex) throws Exception
	{
		if (district != null && department != null)
		{
			if (UtilString.isNotEmpty(district.getDistrictNo(), department.getDepNo()))
			{
				StringBuilder builder = new StringBuilder();
				
				// 校区编号
				builder.append(district.getDistrictNo());
				
				// 部门编号
				builder.append(department.getDepNo());
				
				// 追加序号
				builder.append(String.format("%03d", startIndex + 1));
				
				return builder.toString();
			}
			else
			{
				throw new Exception("校区编号或者部门编号不存在...");
			}
		}
		else
		{
			throw new Exception("校区或者部门数据为空...");
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 根据部门ID和校区ID刷新员工列表
	 */
	public ActionForward actionLoadEmployeeByDepAndDistrict (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String depId = request.getParameter("depId");
		String districtId = request.getParameter("districtId");
		
		if (UtilString.isNotEmpty(depId, districtId))
		{
			try
			{
				ModelSchoolDepartment entityDep = this.serviceSchoolDepartment.get(depId);
				ModelSchoolDistrict entityDistrict = this.serviceSchoolDistrict.get(districtId);
				
				if (entityDep != null && entityDistrict != null)
				{
					
					List<ModelHrmEmployee> emps = 
							this.serviceHrmEmployee.getEmployeeByDistrictIdAndDeptId(entityDep.getId(), entityDistrict.getId());
					
					if (emps != null)
					{
						GsonBuilder builder = new GsonBuilder();
						builder.excludeFieldsWithoutExposeAnnotation();
						Gson gson = builder.create();
						return ajaxPrint(response, gson.toJson(emps));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("部门数据或校区数据不存在..."));
				}
				
			}
			catch (Exception e)
			{
				return ajaxPrint(response, getErrorCallback("加载数据失败:" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要指定部门和校区..."));
		}
		
		return null;
	}
	
	/**
	 * 加载校结构图: 校区-部门, 部门-校区
	 * 
	 * @param request
	 * @throws Exception
	 */
	protected void loadOrganizationTree (HttpServletRequest request) throws Exception
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
				
				Map<Integer, Map<String, String>> depSetIds = new HashMap<Integer, Map<String, String>>();
				
				depSetIds.put(AppUtil.EAppSchoolType.HEADQUARTERS.getValue(), 
						new HashMap<String, String>());
				
				depSetIds.put(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue(), 
						new HashMap<String, String>());
				
				depSetIds.put(AppUtil.EAppSchoolType.AREA_SLOT.getValue(), 
						new HashMap<String, String>());
				
				// 总部部门
				List<ModelSchoolDepartment> depMasters = departments.get(AppUtil.EAppSchoolType.HEADQUARTERS.getValue());
				if (depMasters != null)
				{
					for (ModelSchoolDepartment dep : depMasters)
					{
						if (depNames.contains(dep.getDepName()))
						{
							depSetIds.get(AppUtil.EAppSchoolType.HEADQUARTERS.getValue()).put(dep.getDepName(), dep.getId());
						}
					}
				}
				
				// 校区部门
				List<ModelSchoolDepartment> depCampus = departments.get(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue());
				if (depCampus != null)
				{
					for (ModelSchoolDepartment dep : depCampus)
					{
						if (depNames.contains(dep.getDepName()))
						{
							depSetIds.get(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue()).put(dep.getDepName(), dep.getId());
						}
					}
				}
				
				// 片区部门
				List<ModelSchoolDepartment> depSlot = departments.get(AppUtil.EAppSchoolType.AREA_SLOT.getValue());
				if (depSlot != null)
				{
					for (ModelSchoolDepartment dep : depSlot)
					{
						if (depNames.contains(dep.getDepName()))
						{
							depSetIds.get(AppUtil.EAppSchoolType.AREA_SLOT.getValue()).put(dep.getDepName(), dep.getId());
						}
					}
				}
				
				request.setAttribute("depSetIds", depSetIds);
			}
		}
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
	
	public ServiceSchoolDistrict getServiceSchoolDistrict()
	{
		return serviceSchoolDistrict;
	}

	public void setServiceSchoolDistrict(ServiceSchoolDistrict serviceSchoolDistrict)
	{
		this.serviceSchoolDistrict = serviceSchoolDistrict;
	}
	
	public ServiceAppUser getServiceAppUser()
	{
		return serviceAppUser;
	}

	public void setServiceAppUser(ServiceAppUser serviceAppUser)
	{
		this.serviceAppUser = serviceAppUser;
	}

	public void setServiceHrmEmployee(ServiceHrmEmployee serviceHrmEmployee)
	{
		this.serviceHrmEmployee = serviceHrmEmployee;
	}

	public ServiceHrmEmployee getServiceHrmEmployee()
	{
		return serviceHrmEmployee;
	}

	public void setServiceSchoolPositionSet(ServiceSchoolPositionSet serviceSchoolPositionSet)
	{
		this.serviceSchoolPositionSet = serviceSchoolPositionSet;
	}

	public ServiceSchoolPositionSet getServiceSchoolPositionSet()
	{
		return serviceSchoolPositionSet;
	}

	public void setServiceFileAttach(ServiceFileAttach serviceFileAttach)
	{
		this.serviceFileAttach = serviceFileAttach;
	}

	public ServiceFileAttach getServiceFileAttach()
	{
		return serviceFileAttach;
	}

	public ServiceNewsManage getServiceNewsManage() {
		return serviceNewsManage;
	}

	public void setServiceNewsManage(ServiceNewsManage serviceNewsManage) {
		this.serviceNewsManage = serviceNewsManage;
	}

	public ServiceAppDictionary getServiceAppDictionary() {
		return serviceAppDictionary;
	}

	public void setServiceAppDictionary(ServiceAppDictionary serviceAppDictionary) {
		this.serviceAppDictionary = serviceAppDictionary;
	}

	/**
	 * @return the serviceConference
	 */
	public ServiceConferenceInfo getServiceConference() {
		return serviceConference;
	}

	/**
	 * @param serviceConference the serviceConference to set
	 */
	public void setServiceConference(ServiceConferenceInfo serviceConference) {
		this.serviceConference = serviceConference;
	}

	public ServiceTaskPlan getServiceTaskPlan() {
		return serviceTaskPlan;
	}

	public void setServiceTaskPlan(ServiceTaskPlan serviceTaskPlan) {
		this.serviceTaskPlan = serviceTaskPlan;
	}

	public ServiceFinanExpense getServiceFinanExpense() {
		return serviceFinanExpense;
	}

	public void setServiceFinanExpense(ServiceFinanExpense serviceFinanExpense) {
		this.serviceFinanExpense = serviceFinanExpense;
	}

	public ServiceFinanContract getServiceFinanContract() {
		return serviceFinanContract;
	}

	public void setServiceFinanContract(ServiceFinanContract serviceFinanContract) {
		this.serviceFinanContract = serviceFinanContract;
	}

	public ServiceShortMessage getServiceShortMessage()
	{
		return serviceShortMessage;
	}

	public void setServiceShortMessage(ServiceShortMessage serviceShortMessage)
	{
		this.serviceShortMessage = serviceShortMessage;
	}
	
	public ServiceInMessage getServiceInMessage()
	{
		return serviceInMessage;
	}

	public void setServiceInMessage(ServiceInMessage serviceInMessage)
	{
		this.serviceInMessage = serviceInMessage;
	}
	
}
