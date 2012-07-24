package org.shengrui.oa.web.action.personal;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.service.admin.ServiceTaskPlan;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilBean;

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
	 * The service of task plan
	 */
	private ServiceTaskPlan serviceTaskPlan;
	
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
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when open dialog page for my task creation..", e);
		}
		
		return mapping.findForward("dialog.task.page");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 保存任务
	 */
	public  ActionForward actionSaveTaskPlan(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelTaskPlan formEntity = (ModelTaskPlan) form;
			ModelTaskPlan entity = null;
			
			boolean isCreation = formEntity.getId() == null;
			
			if (isCreation)
			{
				// 创建
				entity = formEntity;
				entity.setTaskOriginator(ContextUtil.getCurrentUser().getEmployee());
			}
			else
			{
				if (this.isObjectIdValid(formEntity.getId()))
				{
					entity = this.serviceTaskPlan.get(formEntity.getId());
					
					// 修改
					UtilBean.copyNotNullProperties(entity, formEntity);
					
					entity.setTaskPlannedStartDate(formEntity.getTaskPlannedStartDate());
					entity.setTaskPlannedEndDate(formEntity.getTaskPlannedEndDate());	
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("需要传入合法的任务ID(" + formEntity.getId() + ")..."));
				}
			}
			
			// 清楚任务参与人
			if (entity.getTaskParticipants() == null)
			{
				entity.setTaskParticipants(new HashSet<ModelHrmEmployee>());
			}
			else
			{
				entity.getTaskParticipants().clear();
			}
			
			// 保存任务参与人
			Map<String, List<String>> paramEmpIds = this.getAllRequestParameters(request, new String[] {"empid"});
			if (paramEmpIds != null && paramEmpIds.size() > 0)
			{
				List<String> empIds = paramEmpIds.get("empid");
				for (String empId : empIds)
				{
					ModelHrmEmployee employee = this.serviceHrmEmployee.get(empId);
					if (employee != null)
					{
						entity.getTaskParticipants().add(employee);
					}
					else
					{
						LOGGER.warn("The employee does not exist with id:" + empId);
					}
				}
			}
			
			// 附件关联保存
			this.handleFileAttachments(entity, request);
			
			this.serviceTaskPlan.save(entity);
			
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
					getSuccessCallback("任务保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		}
		catch (Exception e)
		{
			return ajaxPrint(response, getErrorCallback("任务保存失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 删除任务
	 */
	public  ActionForward actionRemoveTaskPlan(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		String taskId = request.getParameter("taskId");
		if (this.isObjectIdValid(taskId))
		{
			try
			{
				ModelTaskPlan entity = this.serviceTaskPlan.get(taskId);
				if (entity != null)
				{
					this.serviceTaskPlan.remove(entity);
					
					// 删除成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("任务删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("您要删除的任务(id:" + taskId + ")不存在.."));
				}
			}
			catch (Exception e)
			{
				return ajaxPrint(response, getErrorCallback("删除失败: " + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback(""));
		}
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}

	public void setServiceTaskPlan(ServiceTaskPlan serviceTaskPlan)
	{
		this.serviceTaskPlan = serviceTaskPlan;
	}

	public ServiceTaskPlan getServiceTaskPlan()
	{
		return serviceTaskPlan;
	}
	
}
