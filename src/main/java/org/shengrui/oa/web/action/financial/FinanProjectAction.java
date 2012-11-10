package org.shengrui.oa.web.action.financial;

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
import org.shengrui.oa.model.finan.ModelFinanProject;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.info.ModelShortMessage;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.WebActionUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilBean;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 财务管理 -  新项目支出
 * 
 * @author Jeccy.Zhao
 *
 */
public class FinanProjectAction
extends BaseFinanAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(FinanProjectAction.class);
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 新项目支出申请
	 */
	public ActionForward pageFinaProjectIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelFinanProject employeeProjectForm = (ModelFinanProject) form;
			
			ModelProcessType procType = this.serviceProcessType.getTypesByKey(PROC_TYPE_FINAN_PROJECT);
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("新项目支出申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelFinanProject> employeeExpenseInfo =
					this.serviceFinanProject.getFinanProjectInfoPagination(employeeProjectForm, pagingBean);
			
			request.setAttribute("dataList", employeeExpenseInfo);
			request.setAttribute("formEntity", employeeProjectForm);
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, employeeExpenseInfo);
			
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all financial project documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		request.setAttribute("PAGE_TYPE", FINAN_FORM_KEY_PROJECT);
		
		return mapping.findForward("fina.application.list.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 新项目支出记录
	 */
	public ActionForward pageFinaProjectRecords(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelFinanProject employeeProjectForm = (ModelFinanProject) form;
			
			ModelProcessType procType = this.serviceProcessType.getTypesByKey(PROC_TYPE_FINAN_PROJECT);
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("新项目支出申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			request.setAttribute("formEntity", employeeProjectForm);
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all project documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		request.setAttribute("currentindex", request.getParameter("currentindex"));
		request.setAttribute("PAGE_TYPE", FINAN_FORM_KEY_PROJECT);
		
		return mapping.findForward("fina.application.records.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 新项目支出记录
	 */
	public ActionForward loadFinaProjectRecords (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelFinanProject employeeProjectForm = (ModelFinanProject) form;
			
			// 加载审批数据
			boolean isOnApproval = request.getParameter("finished") == null;
			obtainFinaProjectRecords(employeeProjectForm, isOnApproval, request);
			
			request.setAttribute("currentindex", request.getParameter("currentindex"));
			request.setAttribute("isOnApproval", isOnApproval);
			request.setAttribute("formEntity", employeeProjectForm);
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all project documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		request.setAttribute("PAGE_TYPE", FINAN_FORM_KEY_PROJECT);
		request.setAttribute("recordPage", true);
		
		return mapping.findForward("data.fina.application.records");
	}
	
	/**
	 * 
	 * @param request
	 * @param onApprovalStatus
	 * @return
	 * @throws ServiceException 
	 */
	private PaginationSupport<ModelFinanProject> obtainFinaProjectRecords (ModelFinanProject formEntity, 
			Boolean isOnApproval, HttpServletRequest request) throws ServiceException
	{
		if (isOnApproval != null && isOnApproval)
		{
			// 审批中
			formEntity.setCondAuditStates(new Integer[] {
					null,
					ModelProcessForm.EProcessFormStatus.RETURNED.getValue()
			});
		}
		else
		{
			if (formEntity.getAuditState() != null && formEntity.getAuditState() > -1) 
			{
				formEntity.setAuditState(formEntity.getAuditState());
			}
			else
			{
				formEntity.setCondAuditStates(new Integer[] {
					ModelProcessForm.EProcessFormStatus.APPROVED.getValue(), 
					ModelProcessForm.EProcessFormStatus.NOTPASSED.getValue()
					// ModelProcessForm.EProcessFormStatus.RETURNED.getValue()
				});
			}
		}
		
		PagingBean pagingBean = this.getPagingBean(request);
		PaginationSupport<ModelFinanProject> employeeExpenseInfo =
				this.serviceFinanProject.getFinanProjectInfoPagination(formEntity, pagingBean, isOnApproval);
		
		request.setAttribute("dataList", employeeExpenseInfo);
		
		// 输出分页信息至客户端
		outWritePagination(request, pagingBean, employeeExpenseInfo);
		
		return employeeExpenseInfo;
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务申请查看
	 */
	public ActionForward diaglogFinaProjectPage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelProcessType procType = this.serviceProcessType.getTypesByKey(PROC_TYPE_FINAN_PROJECT);
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("新项目支出申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			
			String projectId = request.getParameter("id");
			if (projectId != null && this.isObjectIdValid(projectId))
			{
				ModelFinanProject projectInfo = this.serviceFinanProject.get(projectId);
				if (projectInfo != null)
				{
					request.setAttribute("entity", projectInfo);
				}
			}
			
			request.setAttribute("op", request.getParameter("op"));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch expense detail.", e);
		}
		
		request.setAttribute("CATKEY", "project");
		
		// 审批记录查看
		if ("audit".equalsIgnoreCase(request.getParameter("view")))
		{
			return mapping.findForward("dialog.expense.audit.page");
		}
		
		request.setAttribute("history", request.getParameter("history"));
		
		return mapping.findForward("dialog.fina.project.application.page");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 新项目费用申请表单保存
	 */
	public ActionForward actionFinanProjectFormSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelProcessForm procForm = null;
			
			ModelFinanProject projectInfo = null;
			ModelFinanProject formEntity = (ModelFinanProject) form;
			
			String projectId = request.getParameter("id");
			if (formEntity.getId() != null)
			{
				// 修改
				if (this.isObjectIdValid(projectId))
				{
					projectInfo = this.serviceFinanProject.get(projectId);
					if (projectInfo == null)
					{
						return ajaxPrint(response, getErrorCallback("新项目费用申请记录不存在:id-" + projectId));
					}
					else
					{
						UtilBean.copyNotNullProperties(projectInfo, formEntity);
						projectInfo.setApplyDate(formEntity.getApplyDate());
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("需要传入合法费用申请ID参数."));
				}
			}
			else
			{
				// 创建
				projectInfo = formEntity;
				projectInfo.setFormNo(AppUtil.genFormNo(FINAN_FORM_KEY_PROJECT));
				projectInfo.setEntryDateTime(new Date());
			}
			
			projectInfo.setEmployee(
					this.serviceHrmEmployee.get(request.getParameter("emp.id")));
			
			projectInfo.setEmpDepartment(
					this.serviceSchoolDepartment.get(request.getParameter("emp.depId")));
			
			projectInfo.setEmpDistrict(
					this.serviceSchoolDistrict.get(request.getParameter("emp.districtId")));
			
			projectInfo.setProjectOwner(
					this.serviceHrmEmployee.get(request.getParameter("projectOwner.id")));
			
			projectInfo.setEmpPhoneNo(
					request.getParameter("emp.phoneNo"));
			
			projectInfo.setEntryId(Integer.valueOf(ContextUtil.getCurrentUser().getEmployeeId()));
			
			projectInfo.setAuditState(ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue());
			
			String typeId = request.getParameter("applyFormTypeId");
			projectInfo.setApplyFormType(this.serviceProcessType.get(typeId));
			
			// 进入流程...
			procForm = this.serviceWorkFlow.doStartProcess(
					projectInfo.getApplyFormType().getId(), 
					null, 
					projectInfo.getApplyAmt(), 
					projectInfo.getFormNo(), 
					projectInfo.getEmployee());
			
			if (procForm != null)
			{
				projectInfo.setCurrentProcDepId(procForm.getToDepartmentIds());
				projectInfo.setCurrentProcPosId(procForm.getToPositionIds());
				projectInfo.setCurrentProcDistrictId(procForm.getToDistrictIds());
			}
			else
			{
				// 流程尚未开始就已经结束. (很有可能是所有审批节点都无法触及)
				this.serviceWorkFlow.doEndProcess(projectInfo.getFormNo(), true);
			}
			
			// 绑定审批流程节点
			this.bindProcessForm(projectInfo);
						
			// 设置附件
			this.handleFileAttachments(projectInfo, request);
						
			this.serviceFinanProject.save(projectInfo);
			
			if (procForm != null)
			{
				// 短消息提醒审批人..
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("entity", projectInfo);
				params.put("procForm", procForm);
				params.put("type", FIANA_CATKEY_PROJECT);
				
				List<ModelHrmEmployee> employees = this.serviceHrmEmployee.getByOrganization(
						procForm.getToDistrictIds(), procForm.getToDepartmentIds(), procForm.getToPositionIds());
				
				StringBuilder builder = new StringBuilder();
				for (int i = 0, size = employees.size(); i <  size; i++)
				{
					ModelHrmEmployee employee = employees.get(i);
					builder.append(employee.getId());
					builder.append(",");
				}
				
				this.sendMessage("my.approval.audit.fina", 
					params, new Object[] {
						builder.toString()
					}, 
					ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
				);
				
				// 服务器推送至客户端
				this.messagePush.pushMessage(builder.toString(), 
					WebActionUtil.scriptMessageNotify, 
					WebActionUtil.MENU_ITEM_FINA_PROJECT.getKey() + "," +
						WebActionUtil.MENU_KEY_APPROVAL_TODO, 
					1
				);
				
				builder = null;
			}
			
			return ajaxPrint(response, 
					getSuccessCallback("新项目费用支出申请保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving expense.", e);
			return ajaxPrint(response, getErrorCallback("新项目费用支出申请保存失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 新项目申请表单删除
	 */
	public ActionForward actionFinanProjectFormRemove(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		String id = request.getParameter("id");
		
		if (this.isObjectIdValid(id))
		{
			try
			{
				ModelFinanProject entity = this.serviceFinanProject.get(id);
				if (entity != null)
				{
					this.serviceFinanProject.remove(entity);
					
					return ajaxPrint(response, 
							getSuccessCallback("新项目申请移除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("新项目申请移除失败, 实体不存在id-" + id));
				}
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when removing project entity.", e);
				return ajaxPrint(response, getErrorCallback("新项目申请移除失败:" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("新项目申请移除失败, 非法实体ID被传入:" + id));
		}
		
	}
	
}
