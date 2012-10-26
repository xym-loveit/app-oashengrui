package org.shengrui.oa.web.action.personal;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.model.info.ModelShortMessage;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.hrm.ServiceHrmEmployeeDevelop;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.WebActionUtil;
import org.shengrui.oa.web.action.flow.FlowBaseAction;

import cn.trymore.core.bean.PairObject;
import cn.trymore.core.util.UtilBean;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * WebAction: 我的申请
 * 
 * @author Jeccy.Zhao
 *
 */
public class MyFormApplicationAction
extends FlowBaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyFormApplicationAction.class);
	
	/**
	 * The employee develop service
	 */
	private ServiceHrmEmployeeDevelop serviceHrmEmployeeDevelop;
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我的申请
	 */
	public ActionForward pageMyApplicationIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelHrmEmployeeDevelop> items =
					this.serviceHrmEmployeeDevelop.getEmployeeDevelopInfoPagination(
							null, ContextUtil.getCurrentUser().getEmployeeId(), pagingBean, false);
			
			request.setAttribute("dataList", items);
			
			// 首页我的申请加载视图渲染...
			if (request.getParameter("objOut") != null)
			{
				response.getWriter().write(ObjectToString(items));
				return null;
			}
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, items);
			
		} 
		catch (Exception e)
		{
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		return mapping.findForward("page.my.application.form.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我要申请
	 */
	public ActionForward dialogApplicationFormPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			List<ModelProcessType> procTypes = this.serviceProcessType.getTypesBySlug("hrm", true);
			if (procTypes == null)
			{
				return ajaxPrint(response, getErrorCallback("人资申请流程类型不存在..."));
			}
			
			request.setAttribute("types", procTypes);
			
			String formId = request.getParameter("formId");
			if (UtilString.isNotEmpty(formId))
			{
				if (this.isObjectIdValid(formId))
				{
					ModelHrmEmployeeDevelop entity = this.serviceHrmEmployeeDevelop.get(formId);
					if (entity != null)
					{
						request.setAttribute("formId", formId);
						request.setAttribute("entity", entity);
						request.setAttribute("procTypeId", entity.getApplyFormType().getId());
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("人资申请ID(" + formId + ")数据不存在...."));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("非法人资申请ID(" + formId + ")被传入...."));
				}
			}
			else
			{
				ModelProcessType procType = this.serviceProcessType.getTypesByKey(PROCESS_MEMBER_BERGULAR);
				if (procType != null)
				{
					request.setAttribute("procTypeId", procType.getId());
				}
				else
				{
					LOGGER.warn("The process type of member be regular does not exist...");
				}
			}
			
			request.setAttribute("op", request.getParameter("op"));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch expense detail.", e);
		}
		
		return mapping.findForward("dialog.my.application.form");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 加载表单
	 */
	public ActionForward actionLoadTemplatePage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String procTypeId = request.getParameter("procTypeId");
			
			if (this.isObjectIdValid(procTypeId))
			{
				ModelProcessType procType = this.serviceProcessType.get(procTypeId);
				if (procType != null)
				{
					ModelAppUser user = ContextUtil.getCurrentUser();
					
					if (user != null && user.getEmployee() != null)
					{
						request.setAttribute("employee", user.getEmployee());
						
						if(processKeyAlias.containsKey(procType.getProcessTypeKey()))
						{
							// 获取人资申请单
							String formId = request.getParameter("formId");
							if (UtilString.isNotEmpty(formId))
							{
								if (this.isObjectIdValid(formId))
								{
									ModelHrmEmployeeDevelop entity = this.serviceHrmEmployeeDevelop.get(formId);
									if (entity != null)
									{
										request.setAttribute("entity", entity);
										request.setAttribute("procTypeId", procTypeId);
									}
									else
									{
										return ajaxPrint(response, getErrorCallback("人资申请ID(" + formId + ")数据不存在...."));
									}
								}
								else
								{
									return ajaxPrint(response, getErrorCallback("非法人资申请ID(" + formId + ")被传入...."));
								}
							}
							
							request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
							request.setAttribute("op", request.getParameter("op"));
							
							return mapping.findForward(
									"tpl.my.application.form." + processKeyAlias.get(procType.getProcessTypeKey()));
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("申请类型Key不合法(key:" + procType.getProcessTypeKey() + ")...."));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("您需要先登录或者必须是个员工身份..."));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("申请类型(id:" + procTypeId + ")不存在...."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("请传入合法的申请类型ID...."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when loading the template form page.", e);
			return ajaxPrint(response, getErrorCallback(":" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 保存申请
	 */
	public ActionForward actionSaveApplication (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			ModelProcessForm procForm = null;
			String applyFormTypeId = request.getParameter("applyFormTypeId");
			
			if (UtilString.isNotEmpty(applyFormTypeId))
			{
				ModelProcessType procTypeEntity = this.serviceProcessType.get(applyFormTypeId);
				
				if (procTypeEntity != null)
				{
					ModelHrmEmployeeDevelop formEntity = (ModelHrmEmployeeDevelop) form;
					ModelHrmEmployeeDevelop entity = null;
					
					boolean isCreation = formEntity.getId() == null;
					
					if (isCreation)
					{
						// 创建
						entity = formEntity;
						entity.setFormNo(AppUtil.genFormNo("HRM"));
					}
					else
					{
						// 编辑重新提交.
						entity = this.serviceHrmEmployeeDevelop.get(formEntity.getId());
						
						formEntity.setProcessHistory(null);
						UtilBean.copyNotNullProperties(entity, formEntity);
						entity.setApplyDate(formEntity.getApplyDate());
					}
					
					if (entity.getEmployee() != null && entity.getEmployee().getId() != null)
					{
						ModelHrmEmployee employee = this.serviceHrmEmployee.get(entity.getEmployee().getId());
						if (employee != null)
						{
							entity.setEmployee(employee);
							entity.setApplyFormType(procTypeEntity);
							entity.setEntryId(Integer.valueOf(ContextUtil.getCurrentUser().getEmployeeId()));
							entity.setEntryDateTime(new Date());
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("员工(id:" + entity.getEmployee().getId() + ")数据不存在...."));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("员工ID未传入...."));
					}
						
					// 收集原校区等原数据
					this.collectParameters(entity, 
							request.getParameter("fromDistrictId"), 
							request.getParameter("fromDepId"), 
							request.getParameter("fromPosId"), true);
					
					// 收集目的校区等目的数据
					boolean isTransfer = this.existsInstanceInAndOut(procTypeEntity.getProcessTypeKey());
					if (isTransfer)
					{
						this.collectParameters(entity, 
								request.getParameter("toDistrictId"), 
								request.getParameter("toDepId"), 
								request.getParameter("toPosId"), false);
					}
						
					if (isCreation)
					{
						// 进入流程...
						ModelSchoolDepartmentPosition filterPosition =  entity.getToPosition();
						if (entity.getToPosition() == null)
						{
							filterPosition = entity.getFromPosition();
						}
						
						Object condValue = null;
						if (isTransfer)
						{
							ModelSchoolDistrict distDistrict = entity.getToDistrict();
							if (entity.getToDistrict() == null)
							{
								distDistrict = entity.getFromDistrict();
							}
							
							if (entity.getEmployee().getEmployeeDistrict().getId().equals(distDistrict.getId()))
							{
								// 校区内
								condValue = 0;
							}
							else
							{
								// 跨校区
								condValue = 1;
							}
						}
						
						procForm = this.serviceWorkFlow.doStartProcess(
								entity.getApplyFormType().getId(), 
								filterPosition,
								entity.getToDistrict(),
								condValue, 
								entity.getFormNo(), 
								entity.getEmployee());
						
						if (procForm != null)
						{
							entity.setCurrentProcDepId(procForm.getToDepartmentIds());
							entity.setCurrentProcPosId(procForm.getToPositionIds());
							entity.setCurrentProcDistrictId(procForm.getToDistrictIds());
						}
						else
						{
							// 流程尚未开始就已经结束. (很有可能是所有审批节点都无法触及)
						}
					}
					else
					{
						// 重置流程...
						procForm = this.serviceWorkFlow.resetProcess(entity.getFormNo());
						entity.setAuditState(ModelProcessForm.EProcessFormStatus.RETURNED.getValue());
					}
					
					// 设置附件
					this.handleFileAttachments(entity, request);
					
					this.serviceHrmEmployeeDevelop.save(entity);
						
					if (procForm != null)
					{
						// 短消息通知审批人
						Map<String, Object> params = new HashMap<String, Object>();
						params.put("entity", entity);
						params.put("procForm", procForm);
						
						String districtId = null;
						if (UtilString.isNotEmpty(procForm.getToDistrictIds()))
						{
							districtId = procForm.getToDistrictIds();
						}
						else
						{
							// 主要适用于转正申请/离职申请, 本校区的审批过滤.
							districtId = entity.getEmployee().getEmployeeDistrict().getId();
						}
						
						List<ModelHrmEmployee> employees = this.serviceHrmEmployee.getByOrganization(
							districtId, procForm.getToDepartmentIds(), procForm.getToPositionIds());
						
						StringBuilder builder = new StringBuilder();
						for (int i = 0, size = employees.size(); i <  size; i++)
						{
							ModelHrmEmployee employee = employees.get(i);
							
							// ensures specified district equals the district of employee.
							if (entity.getCurrentProcDistrictId() == null || 
									entity.getCurrentProcDistrictId().equals(employee.getEmployeeDistrict().getId()))
							{
								builder.append(employee.getId());
								builder.append(",");
							}
						}
						
						this.sendMessage("my.approval.audit.hrm", 
							params, new Object[] {
								builder.toString()
							}, 
							ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
						);
						
						// 推送数据至客户端...
						this.messagePush.pushMessage(builder.toString(), 
							WebActionUtil.scriptMessageNotify, 
							WebActionUtil.MENU_ITEM_HRM_DEVELOP.getKey() + "," + 
								WebActionUtil.MENU_KEY_APPROVAL_TODO, 
							1
						);
					}
						
					// 保存成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("人资申请保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("人资申请类型(id:" + applyFormTypeId + ")不存在...."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需传入人资申请类型ID...."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving form application", e);
			return ajaxPrint(response, getErrorCallback("人资申请保存失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 环节申请审批
	 */
	public  ActionForward actionApproveProcess(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		String formId = request.getParameter("formId");
		String procFormId = request.getParameter("id");
		String procFormState = request.getParameter("state");
		String procFormComments = request.getParameter("comments");
		
		ModelProcessForm formEntity = null;
		
		if (UtilString.isNotEmpty(procFormId, procFormState))
		{
			if (this.isObjectIdValid(procFormId))
			{
				try
				{
					PairObject<Boolean, ModelProcessForm> result = this.serviceWorkFlow.proceed(
							procFormId, Integer.parseInt(procFormState), procFormComments);
					
					// 更新业务表中的状态...
					String formNo = request.getParameter("formNo");
					formEntity = this.serviceProcessForm.get(procFormId);
					
					if (!UtilString.isNotEmpty(formNo))
					{
						if (formEntity != null)
						{
							formNo = formEntity.getApplyFormNo();
						}
					}
					
					if (formNo == null)
					{
						return ajaxPrint(response, getErrorCallback("审批失败: 申请单号不存在或者非法..."));
					}
				
					ModelHrmEmployeeDevelop entity = this.serviceHrmEmployeeDevelop.getByFormNo(formNo);
					if (entity == null)
					{
						return ajaxPrint(response, getErrorCallback("审批单不存在..."));
					}
					else if (entity.getApplyForm() == null || entity.getApplyForm().size() == 0)
					{
						entity.setAuditState(Integer.parseInt(procFormState));
					}
					
					if (result.getRight() == null)
					{
						// 审批结束, 审批退回/不通过/通过
						entity.setCurrentProcDepId(null);
						entity.setCurrentProcPosId(null);
					}
					else
					{
						ModelProcessForm procForm = result.getRight();
						entity.setCurrentProcDepId(procForm.getToDepartmentIds());
						entity.setCurrentProcPosId(procForm.getToPositionIds());
						entity.setCurrentProcDistrictId(procForm.getToDistrictIds());
					}
					
					this.serviceHrmEmployeeDevelop.save(entity);
					
					if (result.getLeft())
					{
						// 短消息通知申请人...
						Map<String, Object> params = new HashMap<String, Object>();
						params.put("entity", entity);
						params.put("state", Integer.valueOf(procFormState));
						params.put("procForm", formEntity);
						params.put("formId", formId);
						
						if (result.getRight() == null)
						{
							// 审批结束, 审批退回/不通过/通过
							this.sendMessage("my.application.audit", 
								params, new Object[] {
									entity.getEmployee().getId()
								}, 
								ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
							);
							
						}
						else
						{
							List<ModelHrmEmployee> employees = this.serviceHrmEmployee.getByOrganization(
									result.getRight().getToDistrictIds(), result.getRight().getToDepartmentIds(), result.getRight().getToPositionIds());
							
							StringBuilder builder = new StringBuilder();
							for (int i = 0, size = employees.size(); i <  size; i++)
							{
								ModelHrmEmployee employee = employees.get(i);
								builder.append(employee.getId());
								builder.append(",");
							}
							
							// 通知下一个审批环节的审批人
							this.sendMessage("my.approval.audit.hrm", 
								params, new Object[] {
									builder.toString()
								}, 
								ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
							);
							
							// 服务器推送至下一个审批环节的审批人客户端.
							this.messagePush.pushMessage(builder.toString(), 
								WebActionUtil.scriptMessageNotify, 
								WebActionUtil.MENU_ITEM_HRM_DEVELOP.getKey() + "," + 
									WebActionUtil.MENU_KEY_APPROVAL_TODO, 
								1
							);
							
							builder = null;
						}
						
						if (formEntity != null)
						{
							List<ModelHrmEmployee> preAuditors = this.serviceHrmEmployee.getByDepartmentAndPosition(
									formEntity.getToDepartmentIds(), formEntity.getToPositionIds());
							
							StringBuilder sb = new StringBuilder();
							for (int i = 0, size = preAuditors.size(); i <  size; i++)
							{
								ModelHrmEmployee employee = preAuditors.get(i);
								sb.append(employee.getId());
								sb.append(",");
							}
							
							// 服务器推送至前一个环节审批人的客户端, 待办提醒数字减1
							this.messagePush.pushMessage(sb.toString(), 
								WebActionUtil.scriptMessageNotify, 
								WebActionUtil.MENU_ITEM_HRM_DEVELOP.getKey() + "," + 
									WebActionUtil.MENU_KEY_APPROVAL_TODO, 
								-1
							);
							
							sb = null;
						}
						
						return ajaxPrint(response, 
								getSuccessCallback("审批成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("审批失败."));
					}
				}
				catch (Exception e)
				{
					return ajaxPrint(response, getErrorCallback("人资申请失败:" + e.getMessage()));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入合法的申请流程ID..."));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传入申请流程ID..."));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 申请表单删除
	 */
	public ActionForward actionRemoveApplication(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		String id = request.getParameter("id");
		
		if (this.isObjectIdValid(id))
		{
			try
			{
				ModelHrmEmployeeDevelop entity = this.serviceHrmEmployeeDevelop.get(id);
				if (entity != null)
				{
					this.serviceHrmEmployeeDevelop.remove(entity);
					
					return ajaxPrint(response, 
							getSuccessCallback("申请单移除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("申请单移除失败, 实体不存在id-" + id));
				}
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when removing employee develop application entity.", e);
				return ajaxPrint(response, getErrorCallback("申请单移除失败:" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("申请单移除失败, 非法实体ID被传入:" + id));
		}
		
	}
	
	/**
	 * 
	 * @param entity
	 * @param paramDistrictId
	 * @param paramDepId
	 * @param paramPosId
	 * @param from
	 * @return
	 * @throws Exception
	 */
	private void collectParameters (ModelHrmEmployeeDevelop entity, 
			String paramDistrictId, String paramDepId, String paramPosId, boolean from) throws Exception
	{
		if (UtilString.isNotEmpty(paramDistrictId, paramDepId, paramPosId))
		{
			// 校区参数收集
			if (this.isObjectIdValid(paramDistrictId))
			{
				ModelSchoolDistrict district = this.serviceSchoolDistrict.get(paramDistrictId);
				if (district != null)
				{
					if (from)
					{
						entity.setFromDistrict(district);
					}
					else
					{
						entity.setToDistrict(district);
					}
				}
				else
				{
					throw new Exception("校区ID(" + paramDistrictId + ")不存在...");
				}
			}
			else
			{
				throw new Exception("需传入合法的校区ID参数值, " + paramDistrictId + "被传入...");
			}
			
			// 部门参数收集
			if (this.isObjectIdValid(paramDepId))
			{
				ModelSchoolDepartment department = this.serviceSchoolDepartment.get(paramDepId);
				if (department != null)
				{
					if (from)
					{
						entity.setFromDepartment(department);
					}
					else
					{
						entity.setToDepartment(department);
					}
				}
				else
				{
					throw new Exception("部门ID(" + paramDepId + ")不存在...");
				}
			}
			else
			{
				throw new Exception("需传入合法的部门ID参数值, " + paramDepId + "被传入...");
			}
			
			// 岗位参数收集
			if (this.isObjectIdValid(paramPosId))
			{
				ModelSchoolDepartmentPosition position = this.serviceSchoolDepartmentPosition.get(paramPosId);
				if (position != null)
				{
					if (from)
					{
						entity.setFromPosition(position);
					}
					else
					{
						entity.setToPosition(position);
					}
				}
				else
				{
					throw new Exception("岗位ID(" + paramPosId + ")不存在...");
				}
			}
			else
			{
				throw new Exception("需传入合法的岗位ID参数值, " + paramPosId + "被传入...");
			}
		}
	}
	
	/**
	 * 
	 * @param list
	 * @return
	 * @author unkonw
	 */
	private String ObjectToString(PaginationSupport<ModelHrmEmployeeDevelop> list)
	{
		StringBuffer sb =new StringBuffer();
		if(list != null)
		{
			for (ModelHrmEmployeeDevelop application : list.getItems()) 
			{ 
				sb.append("<tr><td style=\"display: none;\">");
				sb.append(application.getId()+"</td><td>");
				sb.append(application.getApplyFormType().getProcessTypeName()+"</td>");
				sb.append("<td>"+application.getEmployee().getEmpName()+"</td><td>");
				sb.append(intToString(application.getAuditState())+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
	/**
	 * 
	 * @param status
	 * @return
	 * @author unknown
	 */
	private String intToString(Integer status)
	{
		String statu="";
		if(null==status)
		{
			statu="未开始";
		}
		else if(1==status.intValue())
		{
			statu="进行";
		}
		else if(2 == status.intValue())
		{
			statu = "审批通过";
		}
		else if(3 == status.intValue())
		{
			statu = "审批未通过";
		}
		else if(4 == status.intValue())
		{
			statu = "审批退回";
		}
		return statu;
	}
	
	
	public static Logger getLogger()
	{
		return LOGGER;
	}

	public ServiceHrmEmployeeDevelop getServiceHrmEmployeeDevelop()
	{
		return serviceHrmEmployeeDevelop;
	}

	public void setServiceHrmEmployeeDevelop(ServiceHrmEmployeeDevelop serviceHrmEmployeeDevelop)
	{
		this.serviceHrmEmployeeDevelop = serviceHrmEmployeeDevelop;
	}
	
}
