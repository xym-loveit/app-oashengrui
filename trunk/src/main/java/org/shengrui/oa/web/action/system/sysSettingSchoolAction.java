package org.shengrui.oa.web.action.system;

import java.lang.reflect.Field;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelAppRole;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.system.ServiceSchoolDistrict;
import org.springframework.beans.BeanUtils;

import com.google.gson.FieldNamingStrategy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.log.LogAnnotation;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 系统设置 - 学校设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysSettingSchoolAction
extends sysSettingBaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(sysSettingSchoolAction.class);
	
	/**
	 * The school district service
	 */
	@Resource
	private ServiceSchoolDistrict serviceSchoolDistrict;
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-校区设置
	 */
	public ActionForward pageSchoolDistrictIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		ModelSchoolDistrict formSchoolDistrict = (ModelSchoolDistrict) form;
		
		try
		{
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelSchoolDistrict> districts = 
					serviceSchoolDistrict.getSchoolDistrictPagination(formSchoolDistrict, pagingBean);
			
			request.setAttribute("districts", districts);
			request.setAttribute("districtForm", formSchoolDistrict);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, districts);
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch the school districts.", e);
		}
		
		return mapping.findForward("page.sys.setting.school.district.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-校区配置弹框页面
	 */
	public ActionForward dialogSchoolDistrictPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String districtId = request.getParameter("districtId");
			if (this.isObjectIdValid(districtId))
			{
				// 校区更新操作
				ModelSchoolDistrict district = this.serviceSchoolDistrict.get(districtId);
				if (district != null)
				{
					request.setAttribute("district", district);
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("校区不存在!"));
				}
			}
			
			request.setAttribute("district.list", this.serviceSchoolDistrict.getAll());
			
			return mapping.findForward("dialog.sys.setting.school.district.page");
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch menu function entity!", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败,原因:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置 - 校区设置 - 唯一性检测校区编号
	 */
	public ActionForward actionUniqueCheckDistrictNo (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String districtNo = request.getParameter("districtNo");
		if (UtilString.isNotEmpty(districtNo))
		{
			try
			{
				ModelSchoolDistrict entity = this.serviceSchoolDistrict.getDistrictByNo(districtNo);
				if (entity == null)
				{
					ajaxPrint(response, AJAX_RESPONSE_TRUE);
				}
			} 
			catch (ServiceException e)
			{
				ajaxPrint(response, AJAX_RESPONSE_FALSE);
			}
		}
		
		return null;
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 *  学校设置-校区配置保存
	 */
	public ActionForward actionSaveDistrict (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			String rootDistrictId = request.getParameter("rootId");
			
			ModelSchoolDistrict formModelSchoolDistrict = (ModelSchoolDistrict) form;
			ModelSchoolDistrict entity = null;
			
			boolean isCreation = !this.isObjectIdValid(formModelSchoolDistrict.getId());
			
			if (!isCreation)
			{
				// 更新
				entity = this.serviceSchoolDistrict.get(formModelSchoolDistrict.getId());
				if (entity != null)
				{
					// 用表单输入的值覆盖实体中的属性值
					BeanUtils.copyProperties(formModelSchoolDistrict, entity, 
							new String[] {"districtParent"});
				}
				else
				{
					return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
				}
			}
			else
			{
				// 新建
				entity = formModelSchoolDistrict;
			}
			
			// 倘若父级别更换, 则进行更新
			if (UtilString.isNotEmpty(rootDistrictId))
			{
				if (entity.getDistrictParent() == null || 
						(entity.getDistrictParent() != null && !entity.getDistrictParent().getId().equals(rootDistrictId)))
				{
					// 获取父级别校区
					ModelSchoolDistrict rootDistrict = this.serviceSchoolDistrict.get(rootDistrictId);
					
					if (rootDistrict != null)
					{
						entity.setDistrictParent(rootDistrict);
					}
				}
			}
			else
			{
				entity.setDistrictParent(null);
			}
			
			this.serviceSchoolDistrict.save(entity);
			
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
					getSuccessCallback("校区保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		} 
		catch (ServiceException e)
		{
			LOGGER.error("It failed to save the school district item entity!", e);
			
			return ajaxPrint(response, getErrorCallback("校区保存失败."));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-校区配置删除
	 */
	@LogAnnotation(description="删除校区")
	public ActionForward actionRemoveDistrict (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String districtId = request.getParameter("districtId");
			if (this.isObjectIdValid(districtId))
			{
				// 删除
				 this.serviceSchoolDistrict.remove(districtId);
				 
				 return ajaxPrint(response, 
							getSuccessCallbackAndReloadCurrent("校区删除成功."));
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("校区删除失败,原因:非法校区ID(" + districtId + ")被传递"));
			}
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch menu function entity!", e);
			return ajaxPrint(response, getErrorCallback("校区删除失败,原因:" + e.getMessage()));
		}
	}
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-部门岗位设置
	 */
	public ActionForward pageSchoolDepartmentIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		// 获取所有部门列表
		this.getAllDepartments(request, false);
		
		return mapping.findForward("page.sys.setting.dep.index");
	}
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-部门岗位设置 - 部门配置弹框页面
	 */
	public ActionForward dialogSchoolDepartmentPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String depId = request.getParameter("depId");
		if (this.isObjectIdValid(depId))
		{
			try
			{
				// 部门更新
				ModelSchoolDepartment department = this.serviceSchoolDepartment.get(depId);
				if (department != null)
				{
					request.setAttribute("department", department);
					
					if (department.getDepEquivalentLevel() != null)
					{
						request.setAttribute("branches", 
								this.getDepartmentByOrganization(department.getDepEquivalentLevel().toString()));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("部门不存在!"));
				}
			}
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when fetching department with id:" + depId, e);
			}
		}
		
		return mapping.findForward("dialog.sys.setting.dep.page");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-部门岗位设置 - 刷新部门列表页面
	 */
	public ActionForward actionLoadDepartmentTree (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		// 获取所有部门列表
		this.getAllDepartments(request, false);
		
		return mapping.findForward("data.sys.setting.dep.tree");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-部门岗位设置 - 加载岗位角色列表页面
	 */
	public ActionForward actionLoadDepartmentPrivilegeTree (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			// 获取部门信息
			String depId = request.getParameter("depId");
			if (this.isObjectIdValid(depId))
			{
				ModelSchoolDepartment department = this.serviceSchoolDepartment.get(depId);
				if (department != null)
				{
					request.setAttribute("roles", 
							this.getRolesByType(department.getDepEquivalentLevel()));
					
					request.setAttribute("department", department);
					
					// 获取岗位信息
					String posId = request.getParameter("posId");
					if (this.isObjectIdValid(posId))
					{
						ModelSchoolDepartmentPosition position =this.serviceSchoolDepartmentPosition.get(posId);
						if (position != null)
						{
							request.setAttribute("position", position);
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("岗位不存在."));
						}
					}
					
					return mapping.findForward("dialog.sys.setting.dep.position.role");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("部门不存在."));
				}
			}
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when loading department privilege!", e);
		}
		
		return ajaxPrint(response, getErrorCallback("数据加载失败, 请再次尝试!"));
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-部门岗位设置 - 刷新部门对应的岗位列表页面
	 */
	public ActionForward actionLoadDepartmentPosition (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String depId = request.getParameter("depId");
		
		if (UtilString.isNotEmpty(depId))
		{
			try
			{
				request.setAttribute("positions", this.serviceSchoolDepartmentPosition.getPositionByDepartmentId(depId));
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when loading the positions list with department id:" + depId, e);
			}
		}
		
		return mapping.findForward("data.sys.setting.dep.position");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-部门岗位设置 - 根据结构类型刷新部门对应的列表
	 */
	public ActionForward actionLoadDepartmentByOrg (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		if (UtilString.isNotEmpty(request.getParameter("depEquivalentLevel")))
		{
			List<ModelSchoolDepartment> departments = 
				this.getDepartmentByOrganization(request.getParameter("depEquivalentLevel"));
			
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
	 *  学校设置-部门岗位设置 - 部门保存
	 */
	public ActionForward actionSaveDepartment (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelSchoolDepartment formModelSchoolDepartment = (ModelSchoolDepartment) form;
			ModelSchoolDepartment entity = null;
			
			boolean isCreation = !this.isObjectIdValid(formModelSchoolDepartment.getId());
			
			if (!isCreation)
			{
				// 更新
				entity = this.serviceSchoolDepartment.get(formModelSchoolDepartment.getId());
				if (entity != null)
				{
					// 用表单输入的值覆盖实体中的属性值
					BeanUtils.copyProperties(formModelSchoolDepartment, entity, 
							new String[] {"depEquivalentBranch", "positions"});
				}
				else
				{
					return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
				}
			}
			else
			{
				// 新建
				entity = formModelSchoolDepartment;
			}
			
			String depBranchId = request.getParameter("depBranchId");
			
			// 倘若对口部门更换, 则进行相应更新
			if (UtilString.isNotEmpty(depBranchId))
			{
				if (entity.getDepEquivalentBranch() == null || 
						(entity.getDepEquivalentBranch() != null && !entity.getDepEquivalentBranch().getId().equals(depBranchId)))
				{
					// 获取对口部门
					ModelSchoolDepartment depBranch = this.serviceSchoolDepartment.get(depBranchId);
					
					if (depBranch != null)
					{
						entity.setDepEquivalentBranch(depBranch);
					}
				}
			}
			else
			{
				entity.setDepEquivalentBranch(null);
			}
			
			this.serviceSchoolDepartment.save(entity);
			
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
					getSuccessCallback("部门保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		} 
		catch (ServiceException e)
		{
			LOGGER.error("It failed to save the school department item entity!", e);
			
			return ajaxPrint(response, getErrorCallback("部门保存失败."));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 *  学校设置-部门岗位设置 - 部门删除
	 */
	public ActionForward actionRemoveDepartment (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String depId = request.getParameter("depId");
		
		if (UtilString.isNotEmpty(depId))
		{
			try
			{
				this.serviceSchoolDepartment.remove(depId);
				
				return ajaxPrint(response, 
						getSuccessCallbackAndReloadCurrent("部门删除成功."));
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when remove the department entity with id:" + depId, e);
			}
		}
		
		return ajaxPrint(response, getErrorCallback("部门删除失败."));
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 学校设置-部门岗位设置 - 部门岗位弹框页面
	 */
	public ActionForward dialogSchoolDepartmentPositionPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String posId = request.getParameter("posId");
			if (this.isObjectIdValid(posId))
			{
				// 职位更新
				ModelSchoolDepartmentPosition position = this.serviceSchoolDepartmentPosition.get(posId);
				if (position != null)
				{
					request.setAttribute("position", position);
					return mapping.findForward("dialog.sys.setting.dep.position.page");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("职位不存在!"));
				}
			}
			else
			{
				String depId = request.getParameter("depId");
				if (this.isObjectIdValid(depId))
				{
					// 获取岗位对应的部门
					ModelSchoolDepartment department = this.serviceSchoolDepartment.get(depId);
					if (department != null)
					{
						request.setAttribute("department", department);
						return mapping.findForward("dialog.sys.setting.dep.position.page");
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("部门不存在!"));
					}
				} 
			}
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetching position entity.", e);
		}
		
		return ajaxPrint(response, getErrorCallback("加载数据异常, 请再一次尝试!"));
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 *  学校设置-部门岗位设置 - 部门岗位保存
	 */
	public ActionForward actionSaveDepartmentPosition (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String depId = request.getParameter("depId");
			
			ModelSchoolDepartmentPosition formMPosition = (ModelSchoolDepartmentPosition) form;
			ModelSchoolDepartmentPosition entity = null;
			String originalPositionRights = null;
			
			if (this.isObjectIdValid(depId))
			{
				ModelSchoolDepartment department = this.serviceSchoolDepartment.get(depId);
				if (department != null)
				{
					boolean isPositionEdit = this.isObjectIdValid(formMPosition.getId());
					
					if (isPositionEdit)
					{
						// 更新
						entity = this.serviceSchoolDepartmentPosition.get(formMPosition.getId());
						if (entity != null)
						{
							originalPositionRights = entity.getPositionRoleRights();
							
							// 用表单输入的值覆盖实体中的属性值
							BeanUtils.copyProperties(formMPosition, entity, 
									new String[] {"department"});
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("岗位不存在!"));
						}
					}
					else
					{
						// 新建
						entity = formMPosition;
					}
					
					entity.setDepartment(department);
					
					// 设置权限清单
					String positionRights = request.getParameter("dePrivileges.keys");
					if (!isPositionEdit || !positionRights.equals(originalPositionRights))
					{
						entity.getRoles().clear();
						String[] arrayOfRoleRights = positionRights.split("[,]");
						for (int i = 0; i < arrayOfRoleRights.length; i++)
						{
							ModelAppRole modelAppRole = this.serviceAppRole.getRoleByKey(arrayOfRoleRights[i]);
							if (modelAppRole == null)
							{
								continue;
							}
							entity.getRoles().add(modelAppRole);
						}
					}
					
					this.serviceSchoolDepartmentPosition.save(entity);
					
					// 保存成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("岗位保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("部门不存在!"));
				}
			}
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when saving the department position.", e);
			ajaxPrint(response, getErrorCallback("岗位保存失败."));
		}
		
		return null;
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 *  学校设置-部门岗位设置 - 部门岗位删除
	 */
	public ActionForward actionRemoveDepartmentPosition (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String posId = request.getParameter("posId");
		
		if (UtilString.isNotEmpty(posId))
		{
			try
			{
				this.serviceSchoolDepartmentPosition.remove(posId);
				
				return ajaxPrint(response, 
						getSuccessCallbackAndReloadCurrent("岗位删除成功."));
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when remove the department position entity with id:" + posId, e);
			}
		}
		
		return ajaxPrint(response, getErrorCallback("岗位删除失败."));
	}
	
	public ServiceSchoolDistrict getServiceSchoolDistrict()
	{
		return serviceSchoolDistrict;
	}

	public void setServiceSchoolDistrict(ServiceSchoolDistrict serviceSchoolDistrict)
	{
		this.serviceSchoolDistrict = serviceSchoolDistrict;
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}

}
