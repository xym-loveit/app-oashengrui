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
import org.shengrui.oa.model.finan.ModelFinanExpense;
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
 * 财务管理 -  费用支出
 * 
 * @author Jeccy.Zhao
 *
 */
public class FinanExpenseAction
extends BaseFinanAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(FinanExpenseAction.class);
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 费用支出申请
	 */
	public ActionForward pageFinaExpenseIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelFinanExpense employeeExpenseForm = (ModelFinanExpense) form;
			
			ModelProcessType procType = this.serviceProcessType.getTypesByKey(PROC_TYPE_FINAN_PAYMENT);
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("费用支出申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelFinanExpense> employeeExpenseInfo =
					this.serviceFinanExpense.getFinanExpenseInfoPagination(employeeExpenseForm, pagingBean);
			
			request.setAttribute("dataList", employeeExpenseInfo);
			request.setAttribute("formEntity", employeeExpenseForm);
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, employeeExpenseInfo);
			
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		request.setAttribute("PAGE_TYPE", FINAN_FORM_KEY_EXPENSE);
		
		return mapping.findForward("fina.application.list.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 费用支出记录
	 */
	public ActionForward pageFinaExpenseRecords(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelFinanExpense employeeExpenseForm = (ModelFinanExpense) form;
			
			ModelProcessType procType = this.serviceProcessType.getTypesByKey(PROC_TYPE_FINAN_PAYMENT);
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("费用支出申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			request.setAttribute("formEntity", employeeExpenseForm);
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		request.setAttribute("currentindex", request.getParameter("currentindex"));
		request.setAttribute("PAGE_TYPE", FINAN_FORM_KEY_EXPENSE);
		
		return mapping.findForward("fina.application.records.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 费用支出记录
	 */
	public ActionForward loadFinaExpenseRecords (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelFinanExpense employeeExpenseForm = (ModelFinanExpense) form;
			
			// 加载审批数据
			boolean isOnApproval = request.getParameter("finished") == null;
			obtainFinaExpenseRecords(employeeExpenseForm, isOnApproval, request);
			
			request.setAttribute("currentindex", request.getParameter("currentindex"));
			request.setAttribute("isOnApproval", isOnApproval);
			request.setAttribute("formEntity", employeeExpenseForm);
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		request.setAttribute("PAGE_TYPE", FINAN_FORM_KEY_EXPENSE);
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
	private PaginationSupport<ModelFinanExpense> obtainFinaExpenseRecords (ModelFinanExpense formEntity, 
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
		PaginationSupport<ModelFinanExpense> employeeExpenseInfo =
				this.serviceFinanExpense.getFinanExpenseInfoPagination(formEntity, pagingBean, isOnApproval);
		
		request.setAttribute("dataList", employeeExpenseInfo);
		
		// 输出分页信息至客户端
		outWritePagination(request, pagingBean, employeeExpenseInfo);
		
		return employeeExpenseInfo;
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务申请查看
	 */
	public ActionForward diaglogFinaExpensePage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelProcessType procType = this.serviceProcessType.getTypesByKey("PROCESS_PAYMENT");
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("费用支出申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			
			String expenseId = request.getParameter("id");
			if (expenseId != null && this.isObjectIdValid(expenseId))
			{
				ModelFinanExpense expenseInfo = this.serviceFinanExpense.get(expenseId);
				if (expenseInfo != null)
				{
					request.setAttribute("entity", expenseInfo);
				}
			}
			
			/*
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
			*/
			
			request.setAttribute("op", request.getParameter("op"));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch expense detail.", e);
		}
		
		request.setAttribute("CATKEY", "expense");
		
		// 审批记录查看
		if ("audit".equalsIgnoreCase(request.getParameter("view")))
		{
			return mapping.findForward("dialog.expense.audit.page");
		}
		
		return mapping.findForward("dialog.fina.expense.application.page");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务费用申请表单保存
	 */
	public ActionForward actionFinanExpenseFormSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelProcessForm procForm = null;
			
			ModelFinanExpense expenseInfo = null;
			ModelFinanExpense formEntity = (ModelFinanExpense) form;
			
			String expenseId = request.getParameter("id");
			if (formEntity.getId() != null)
			{
				// 修改
				if (this.isObjectIdValid(expenseId))
				{
					expenseInfo = this.serviceFinanExpense.get(expenseId);
					if (expenseInfo == null)
					{
						return ajaxPrint(response, getErrorCallback("费用申请记录不存在:id-" + expenseId));
					}
					else
					{
						UtilBean.copyNotNullProperties(expenseInfo, formEntity);
						
						expenseInfo.setApplyDate(formEntity.getApplyDate());
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
				expenseInfo = formEntity;
				expenseInfo.setFormNo(AppUtil.genFormNo(FINAN_FORM_KEY_EXPENSE));
				expenseInfo.setEntryDateTime(new Date());
			}
			
			expenseInfo.setEmployee(
					this.serviceHrmEmployee.get(request.getParameter("emp.id")));
			
			expenseInfo.setEmpDepartment(
					this.serviceSchoolDepartment.get(request.getParameter("emp.depId")));
			
			expenseInfo.setEmpDistrict(
					this.serviceSchoolDistrict.get(request.getParameter("emp.districtId")));
			
			expenseInfo.setEmpPhoneNo(request.getParameter("emp.phoneNo"));
			
			expenseInfo.setAuditState(ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue());
			
			expenseInfo.setEntryId(Integer.valueOf(ContextUtil.getCurrentUser().getEmployeeId()));
			
			String typeId = request.getParameter("applyFormTypeId");
			expenseInfo.setApplyFormType(this.serviceProcessType.get(typeId));
			
			procForm = this.serviceWorkFlow.doStartProcess(
					expenseInfo.getApplyFormType().getId(), 
					null, 
					expenseInfo.getApplyAmt(), 
					expenseInfo.getFormNo(), 
					expenseInfo.getEmployee());
			
			if (procForm != null)
			{
				expenseInfo.setCurrentProcDepId(procForm.getToDepartmentIds());
				expenseInfo.setCurrentProcPosId(procForm.getToPositionIds());
				expenseInfo.setCurrentProcDistrictId(procForm.getToDistrictIds());
			}
			else
			{
				// 流程尚未开始就已经结束. (很有可能是所有审批节点都无法触及)
				this.serviceWorkFlow.doEndProcess(expenseInfo.getFormNo(), true);
			}
			
			// 绑定审批流程节点
			this.bindProcessForm(expenseInfo);
			
			// 设置岗位附件
			this.handleFileAttachments(expenseInfo, request);
						
			this.serviceFinanExpense.save(expenseInfo);
			
			if (procForm != null)
			{
				// 短消息提醒审批人..
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("entity", expenseInfo);
				params.put("procForm", procForm);
				params.put("type", FIANA_CATKEY_EXPENSE);
				
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
					WebActionUtil.MENU_ITEM_FINA_EXPENSE.getKey() + "," +
						WebActionUtil.MENU_KEY_APPROVAL_TODO, 
					1
				);
				
				builder = null;
			}
			
			return ajaxPrint(response, 
					getSuccessCallback("费用申请保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving expense.", e);
			return ajaxPrint(response, getErrorCallback("费用申请保存失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务费用申请表单删除
	 */
	public ActionForward actionFinanExpenseFormRemove(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		String id = request.getParameter("id");
		
		if (this.isObjectIdValid(id))
		{
			try
			{
				ModelFinanExpense entity = this.serviceFinanExpense.get(id);
				if (entity != null)
				{
					this.serviceFinanExpense.remove(entity);
					
					return ajaxPrint(response, 
							getSuccessCallback("费用申请移除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("费用申请移除失败, 实体不存在id-" + id));
				}
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when removing expense entity.", e);
				return ajaxPrint(response, getErrorCallback("费用申请移除失败:" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("费用申请移除失败, 非法实体ID被传入:" + id));
		}
		
	}
}
