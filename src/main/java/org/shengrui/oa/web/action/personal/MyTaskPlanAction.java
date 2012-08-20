package org.shengrui.oa.web.action.personal;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.admin.ModelTaskPlanTrack;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.info.ModelShortMessage;
import org.shengrui.oa.model.system.ModelAppDictionary;
import org.shengrui.oa.service.admin.ServiceTaskPlan;
import org.shengrui.oa.service.admin.ServiceTaskPlanTrack;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.util.UtilBean;
import cn.trymore.core.util.UtilDate;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

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
	 * The dictionary key for task plan type
	 */
	protected static final String DIC_KEY_TASK_TYPE = "task";
	
	/**
	 * The service of task plan
	 */
	protected ServiceTaskPlan serviceTaskPlan;
	
	/**
	 * The task plan track service
	 */
	protected ServiceTaskPlanTrack serviceTaskPlanTrack;
	
	/**
	 * 首页显示我的任务
	 * */
	public ActionForward pageTaskIndex1 (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			if (ContextUtil.getCurrentUser().getEmployee() == null)
			{
				return ajaxPrint(response, getErrorCallback("您必须具备员工身份才能访问我的任务..."));
			}
			
			ModelTaskPlan formEntity = (ModelTaskPlan) form;
			
			request.setAttribute("taskTypes", this.serviceAppDictionary.getByType(DIC_KEY_TASK_TYPE));
				
			PagingBean pagingBean = this.getPagingBean1(request);
			PaginationSupport<ModelTaskPlan> items =
					this.serviceTaskPlan.getPaginationByEntity(formEntity, ContextUtil.getCurrentUser().getEmployee().getId(), false, pagingBean);
			
			request.setAttribute("list", items);
			request.setAttribute("formEntity", formEntity);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, items);
			response.getWriter().write(ObjectToString(items));
//			return mapping.findForward("page.task.index1");
			return null;
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
	}
	
	private String ObjectToString(PaginationSupport<ModelTaskPlan> list){
		StringBuffer sb =new StringBuffer();
		if(list != null){
			for (ModelTaskPlan task : list.getItems()) {
				sb.append("<tr><td style=\"display: none;\">");
				sb.append(task.getId()+"</td><td>");
				sb.append(task.getTaskName()+"</td>");
				sb.append("<td>"+intToString(task.getTaskStatus())+"</td><td>");
				sb.append(task.getTaskCharger().getEmpName()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	private String intToString(Integer status){
		String statu="";
		if(null==status){
			statu="未开始";
		}else if(1==status.intValue()){
			statu="进行";
		}else if(2 == status.intValue()){
			statu = "已延期";
		}else if(3 == status.intValue()){
			statu = "已完成";
		}else if(4 == status.intValue()){
			statu = "待延期审批";
		}else if(5 == status.intValue()){
			statu = "待完成审批";
		}
		return statu;
	}
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我的任务
	 */
	public ActionForward pageTaskIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			if (ContextUtil.getCurrentUser().getEmployee() == null)
			{
				return ajaxPrint(response, getErrorCallback("您必须具备员工身份才能访问我的任务..."));
			}
			
			ModelTaskPlan formEntity = (ModelTaskPlan) form;
			
			request.setAttribute("taskTypes", this.serviceAppDictionary.getByType(DIC_KEY_TASK_TYPE));
			
			// 过滤显示审批通过的任务数据
			formEntity.setAuditStatus(ModelTaskPlan.ETaskApprovalStatus.APPROVED.getValue());
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelTaskPlan> items =
					this.serviceTaskPlan.getPaginationByEntity(formEntity, ContextUtil.getCurrentUser().getEmployee().getId(), false, pagingBean);
			
			request.setAttribute("dataList", items);
			request.setAttribute("formEntity", formEntity);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, items);
			
			request.setAttribute("today", new Date());
			
			return mapping.findForward("page.task.index");
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我发起的任务
	 */
	public ActionForward pageTaskLaunched (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelTaskPlan formEntity = (ModelTaskPlan) form;
			
			request.setAttribute("taskTypes", this.serviceAppDictionary.getByType(DIC_KEY_TASK_TYPE));
				
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelTaskPlan> items =
					this.serviceTaskPlan.getPaginationByEntity(formEntity, ContextUtil.getCurrentUser().getEmployee().getId(), true, pagingBean);
			
			request.setAttribute("dataList", items);
			request.setAttribute("formEntity", formEntity);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, items);
			
			request.setAttribute("today", new Date());
			
			return mapping.findForward("page.task.launched");
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
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
			List<ModelAppDictionary> taskTypes = this.serviceAppDictionary.getByType(DIC_KEY_TASK_TYPE);
			if (taskTypes != null && taskTypes.size() > 0)
			{
				request.setAttribute("taskTypes", taskTypes);
				
				String taskId = request.getParameter("id");
				if (UtilString.isNotEmpty(taskId) && this.isObjectIdValid(taskId))
				{
					
					ModelTaskPlan taskPlan = this.serviceTaskPlan.get(taskId);
					if (taskPlan != null)
					{
						request.setAttribute("entity", taskPlan);
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("您指定的任务数据不存在..."));
					}
				}
				
				String operation = request.getParameter("op");
				if (operation == null || !"view".equals(operation))
				{
					// 加载校结构图
					this.loadOrganizationTree(request);
				}
				
				request.setAttribute("op", operation);
				
				return mapping.findForward("dialog.task.page");
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("您需要先在系统数据字典中设置添加任务委托类型..."));
			}
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open dialog page for my task creation..", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 任务审批页面 
	 */
	public ActionForward dialogAuditPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String taskId = request.getParameter("taskId");
			if (this.isObjectIdValid(taskId))
			{
				
				ModelTaskPlan taskPlan = this.serviceTaskPlan.get(taskId);
				if (taskPlan != null)
				{
					request.setAttribute("entity", taskPlan);
					
					ModelTaskPlanTrack currentTrackForm = this.serviceTaskPlanTrack.getCurrentTrack(taskId);
					if (currentTrackForm != null)
					{
						request.setAttribute("trackForm", currentTrackForm);
						request.setAttribute("auditType", request.getParameter("type"));
						
						return mapping.findForward("form.task.audit.page");
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("当前不存在任何完成申请或延迟申请数据..."));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("您指定的任务数据不存在..."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入任务Id..."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the audit dialog page..", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 任务申请页面 (完成申请/延迟申请)
	 */
	public ActionForward dialogApplyPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String applyType = request.getParameter("type");
			
			if (UtilString.isNotEmpty(applyType))
			{
				if (Integer.valueOf(applyType).equals(ModelTaskPlanTrack.ETaskTrackType.APPLY_ACCOMPLISH.getValue()) ||
						Integer.valueOf(applyType).equals(ModelTaskPlanTrack.ETaskTrackType.APPLY_POSTONE.getValue()))
				{
					String taskId = request.getParameter("id");
					if (this.isObjectIdValid(taskId))
					{
						
						ModelTaskPlan taskPlan = this.serviceTaskPlan.get(taskId);
						if (taskPlan != null)
						{
							request.setAttribute("entity", taskPlan);
							request.setAttribute("applyType", applyType);
							request.setAttribute("today", new Date());
							
							return mapping.findForward("form.task.apply.page");
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("您指定的任务数据不存在..."));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("需要传入合法的任务Id..."));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("未知的申请类型被传入..."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要指定一种申请类型..."));
			}
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open dialog page for my task creation..", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
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
				entity.setCreateTime(new Date());
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
					
					if (formEntity.getAuditStatus() == null)
					{
						// 提交审核...
						entity.setAuditStatus(null);
						entity.setAuditor(null);
						entity.setAuditTime(null);
					}
					else if (entity.getAuditStatus() != null && 
							ModelTaskPlan.ETaskApprovalStatus.RETURNED.getValue().equals(entity.getAuditStatus()))
					{
						// 修改已退回为待审批状态...
						entity.setAuditStatus(ModelTaskPlan.ETaskApprovalStatus.RETURNED.getValue());
						entity.setAuditTime(new Date());
						entity.setAuditor(ContextUtil.getCurrentUser().getEmployee());
					}
					else if (entity.getAuditStatus() != null && 
							ModelTaskPlan.ETaskApprovalStatus.APPROVED.getValue().equals(entity.getAuditStatus()))
					{
						entity.setAuditTime(new Date());
						entity.setAuditor(ContextUtil.getCurrentUser().getEmployee());
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("需要传入合法的任务ID(" + formEntity.getId() + ")..."));
				}
			}
			
			// 检查任务委托类型是否合法
			String taskTypeId = request.getParameter("taskTypeId");
			if (this.isObjectIdValid(taskTypeId))
			{
				ModelAppDictionary taskType = this.serviceAppDictionary.get(taskTypeId);
				if (taskType != null)
				{
					
					entity.setTaskType(taskType);
					
					String chargerId = request.getParameter("charger.id");
					if (this.isObjectIdValid(chargerId))
					{
						ModelHrmEmployee charger = this.serviceHrmEmployee.get(chargerId);
						if (charger != null)
						{
							
							entity.setTaskCharger(charger);
							
							// 清除任务参与人
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
								List<String> empNames = null;
								for (String empId : empIds)
								{
									ModelHrmEmployee employee = this.serviceHrmEmployee.get(empId);
									if (employee != null)
									{
										entity.getTaskParticipants().add(employee);
										
										if (empNames == null)
										{
											empNames = new ArrayList<String>();
										}
										
										empNames.add(employee.getEmpName());
									}
									else
									{
										LOGGER.warn("The employee does not exist with id:" + empId);
									}
								}
								
								entity.setTaskParticipantIds(UtilString.join(empIds, ","));
								entity.setTaskParticipantNames(UtilString.join(empNames, ","));
								
								empNames = null;
								empIds = null;
							}
							
							// 附件关联保存
							this.handleFileAttachments(entity, request);
							
							// 保存负责人所属的校区和部门ID, 用于数据权限访问过滤
							entity.setTaskChargerDepId(
									Integer.valueOf(entity.getTaskCharger().getEmployeeDepartment().getId()));
							entity.setTaskChargerDisId(
									Integer.valueOf(entity.getTaskCharger().getEmployeeDistrict().getId()));
							
							this.serviceTaskPlan.save(entity);
							
							// 发送短消息给任务负责人...
							if (entity.getAuditStatus() != null)
							{
								Map<String, Object> params = new HashMap<String, Object>();
								params.put("entity", entity);
								
								if (ModelTaskPlan.ETaskApprovalStatus.APPROVED.getValue().equals(
										entity.getAuditStatus()))
								{
									// 审核通过
									this.sendMessage("admin.task.audit.approved", 
										params, new Object[] {
											entity.getTaskCharger().getId(),
											entity.getTaskOriginator().getId(),
											entity.getTaskParticipantIds()
										}, 
										ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
									);
								}
								else if (entity.getAuditStatus() != null && 
										ModelTaskPlan.ETaskApprovalStatus.RETURNED.getValue().equals(entity.getAuditStatus()))
								{
									// 审核被退回
									this.sendMessage("admin.task.audit.returned", 
										params, new Object[] {
											entity.getTaskOriginator().getId()
										}, 
										ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
									);
								}
							}
							
							// 保存成功后, Dialog进行关闭
							return ajaxPrint(response, 
									getSuccessCallback("任务保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("您指定的负责人不存在..."));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("需要传入合法的负责人ID..."));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("您指定的任务委托类型数据不存在..."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入合法的任务委托类型ID..."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving task plan", e);
			return ajaxPrint(response, getErrorCallback("任务保存失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 任务审批记录
	 */
	public ActionForward dialogAuditRecords (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String taskId = request.getParameter("taskId");
			if (!this.isObjectIdValid(taskId))
			{
				return ajaxPrint(response, getErrorCallback("需要传入合法的任务ID..."));
			}
			
			ModelTaskPlan taskPlan = this.serviceTaskPlan.get(taskId);
			if (taskPlan == null)
			{
				return ajaxPrint(response, getErrorCallback("您当前进行任务申请的任务数据不存在..."));
			}
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelTaskPlanTrack> items =
					this.serviceTaskPlanTrack.getPaginationByTaskId(taskId, pagingBean);
			
			request.setAttribute("dataList", items);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, items);
			
			request.setAttribute("taskPlan", taskPlan);
			request.setAttribute("page_type", "audit_records");
			
			return mapping.findForward("data.task.audit.records");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the dialog page of audit records.", e);
			return ajaxPrint(response, getErrorCallback("加载页面失败:" + e.getMessage()));
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
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 任务申请保存
	 */
	public  ActionForward actionSaveTaskApply(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String taskId = request.getParameter("taskId");
			if (!this.isObjectIdValid(taskId))
			{
				return ajaxPrint(response, getErrorCallback("需要传入合法的任务ID..."));
			}
			
			ModelTaskPlan taskPlan = this.serviceTaskPlan.get(taskId);
			if (taskPlan == null)
			{
				return ajaxPrint(response, getErrorCallback("您当前进行任务申请的任务数据不存在..."));
			}
			
			ModelTaskPlanTrack taskTrack = new ModelTaskPlanTrack();
			
			Integer applyType = Integer.valueOf(request.getParameter("applyType"));
			
			taskTrack.setTaskApplyMeto(request.getParameter("meto"));
			taskTrack.setTaskApplyDate(UtilDate.toDate(request.getParameter("applyDate")));
			taskTrack.setTaskApplyFinalizedDate(UtilDate.toDate(request.getParameter("finalizedDate")));
			taskTrack.setTaskApplyType(applyType);
			taskTrack.setTask(taskPlan);
			
			if (ModelTaskPlanTrack.ETaskTrackType.APPLY_ACCOMPLISH.getValue().equals(applyType))
			{
				// 类型: 完成申请
				taskPlan.setTaskStatus(ModelTaskPlan.ETaskStatus.DONE_APPROVING.getValue());
			}
			else if (ModelTaskPlanTrack.ETaskTrackType.APPLY_POSTONE.getValue().equals(applyType))
			{
				// 类型: 延迟申请
				taskPlan.setTaskStatus(ModelTaskPlan.ETaskStatus.POSTPONED_APPROVING.getValue());
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("未知的任务申请类型..."));
			}
			
			this.serviceTaskPlanTrack.save(taskTrack);
			
			// 申请保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
					getSuccessCallback("申请保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));

		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving task apply...", e);
			return ajaxPrint(response, getErrorCallback("任务申请保存失败..."));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 任务审批保存
	 */
	public  ActionForward actionSaveTaskApproval(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String taskId = request.getParameter("taskId");
			if (!this.isObjectIdValid(taskId))
			{
				return ajaxPrint(response, getErrorCallback("需要传入合法的任务ID..."));
			}
			
			ModelTaskPlan taskPlan = this.serviceTaskPlan.get(taskId);
			if (taskPlan == null)
			{
				return ajaxPrint(response, getErrorCallback("您当前进行任务申请的任务数据不存在..."));
			}
			
			String trackId = request.getParameter("trackId");
			if (this.isObjectIdValid(trackId))
			{
				ModelTaskPlanTrack taskTrack = this.serviceTaskPlanTrack.get(trackId);
				if (taskTrack == null)
				{
					return ajaxPrint(response, getErrorCallback("任务申请数据不存在..."));
				}
				else
				{
					taskTrack.setTaskAuditMeto(request.getParameter("auditMeto"));
					
					if (UtilString.isNotEmpty(request.getParameter("taskAuditFinalizedDate")))
					{
						taskTrack.setTaskAuditFinalizedDate(UtilDate.toDate(request.getParameter("taskAuditFinalizedDate")));
					}
					
					taskTrack.setTaskAuditState(Integer.valueOf(request.getParameter("taskAuditState")));
					taskTrack.setTaskAuditTime(new Date());
					
					String auditType = request.getParameter("auditType");
					
					if (ModelTaskPlanTrack.ETaskAuditState.PASS.getValue().equals(taskTrack.getTaskAuditState()))
					{
						// 审核通过
						if (ModelTaskPlanTrack.ETaskTrackType.APPLY_ACCOMPLISH.getValue().equals(Integer.valueOf(auditType)))
						{
							// 完成申请
							taskPlan.setTaskStatus(ModelTaskPlan.ETaskStatus.DONE.getValue());
							taskPlan.setTaskActualEndDate(UtilDate.toDate(request.getParameter("taskAuditFinalizedDate")));
						}
						else if (ModelTaskPlanTrack.ETaskTrackType.APPLY_POSTONE.getValue().equals(Integer.valueOf(auditType)))
						{
							taskPlan.setTaskStatus(ModelTaskPlan.ETaskStatus.POSTPONED.getValue());
							taskPlan.setTaskPlannedEndDate(UtilDate.toDate(request.getParameter("taskAuditFinalizedDate")));
						}
					}
					else if (ModelTaskPlanTrack.ETaskAuditState.NOTPASS.getValue().equals(taskTrack.getTaskAuditState()))
					{
						// 审核未过
						taskPlan.setTaskStatus(ModelTaskPlan.ETaskStatus.ONGOING.getValue());
					}
					
					taskTrack.setTask(taskPlan);
					
					this.serviceTaskPlanTrack.save(taskTrack);
					
					// 保存成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("审批成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需传入合法的任务申请数据Id..."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving task apply...", e);
			return ajaxPrint(response, getErrorCallback("任务申请保存失败..."));
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

	public ServiceTaskPlanTrack getServiceTaskPlanTrack()
	{
		return serviceTaskPlanTrack;
	}

	public void setServiceTaskPlanTrack(ServiceTaskPlanTrack serviceTaskPlanTrack)
	{
		this.serviceTaskPlanTrack = serviceTaskPlanTrack;
	}
	
}
