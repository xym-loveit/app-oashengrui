package org.shengrui.oa.web.action.personal;

import java.util.Date;
import java.util.List;

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
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.hrm.ServiceHrmEmployeeDevelop;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.web.action.flow.FlowBaseAction;

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
					this.serviceHrmEmployeeDevelop.getEmployeeDevelopInfoPagination(null, pagingBean);
			
			request.setAttribute("dataList", items);
			
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
							request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
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
						
						if (entity.getEmployee() != null && entity.getEmployee().getId() != null)
						{
							ModelHrmEmployee employee = this.serviceHrmEmployee.get(entity.getEmployee().getId());
							if (employee != null)
							{
								entity.setEmployee(employee);
								entity.setApplyFormType(procTypeEntity);
								entity.setEntryId(ContextUtil.getCurrentUserId());
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
						
						entity.setFormNo(AppUtil.genFormNo("HRM"));
						
						this.serviceHrmEmployeeDevelop.save(entity);
						
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
							
							this.serviceWorkFlow.doStartProcess(
									entity.getApplyFormType().getId(), 
									filterPosition,
									condValue, 
									entity.getFormNo(), 
									entity.getEmployee());
						}
						
						// 保存成功后, Dialog进行关闭
						return ajaxPrint(response, 
								getSuccessCallback("人资申请保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
					}
					else
					{
						// TODO: 修改操作暂时不用, 后续再补
						return ajaxPrint(response, getErrorCallback("人资申请修改操作暂未实现...."));
					}
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
		String procFormId = request.getParameter("id");
		String procFormState = request.getParameter("state");
		String procFormComments = request.getParameter("comments");
		
		if (UtilString.isNotEmpty(procFormId, procFormState))
		{
			if (this.isObjectIdValid(procFormId))
			{
				try
				{
					boolean result = this.serviceWorkFlow.proceed(
							procFormId, Integer.parseInt(procFormState), procFormComments);
					
					// 更新业务表中的状态...
					String formNo = request.getParameter("formNo");
					if (!UtilString.isNotEmpty(formNo))
					{
						ModelProcessForm formEntity = this.serviceProcessForm.get(procFormId);
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
					if (entity.getApplyForm() == null || entity.getApplyForm().size() == 0)
					{
						entity.setAuditState(Integer.parseInt(procFormState));
						this.serviceHrmEmployeeDevelop.save(entity);
					}
					
					if (result)
					{
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
