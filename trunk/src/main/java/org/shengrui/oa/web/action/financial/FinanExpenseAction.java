package org.shengrui.oa.web.action.financial;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.util.UtilBean;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 财务管理
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
	 * 财务管理
	 */
	public ActionForward FinanExpenseIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			ModelFinanExpense employeeExpenseForm = (ModelFinanExpense) form;
			
			ModelProcessType procType = this.serviceProcessType.getTypesByKey("PROCESS_PAYMENT");
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("费用支出申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelFinanExpense> employeeExpenseInfo =
					this.serviceFinanExpense.getFinanExpenseInfoPagination(employeeExpenseForm, pagingBean);
			
			request.setAttribute("employeeExpenseInfo", employeeExpenseInfo);
			request.setAttribute("employeeExpenseForm", employeeExpenseForm);
			
			// 获取所有校区, 用于搜索查询使用
			// request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, employeeExpenseInfo);
			
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		return mapping.findForward("finan.page.expense.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务申请查看
	 */
	public ActionForward FinanExpenseDetail(ActionMapping mapping, ActionForm form,
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
					request.setAttribute("employeeExpenseEntry", expenseInfo);
				}
			}
			
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
			request.setAttribute("op", request.getParameter("op"));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch expense detail.", e);
		}
		return mapping.findForward("finan.page.expense.detail");
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务申请保存
	 */
	public ActionForward actionFinanExpenseSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			boolean isCreation = false;
			
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
				isCreation = true;
				
				expenseInfo = formEntity;
				expenseInfo.setFormNo(AppUtil.genFormNo(FINAN_FORM_KEY_EXPENSE));
				expenseInfo.setEntryDateTime(new Date());
				expenseInfo.setEntryId(ContextUtil.getCurrentUserId());
				
				String typeId = request.getParameter("applyFormTypeId");
				expenseInfo.setApplyFormType(this.serviceProcessType.get(typeId));
			}
			
			// Only for testing...
			expenseInfo.setEmployee(this.serviceHrmEmployee.get("3"));
			expenseInfo.setEmpDepartment(this.serviceSchoolDepartment.get("9"));
			expenseInfo.setEmpDistrict(this.serviceSchoolDistrict.get("3"));
			
			this.serviceFinanExpense.save(expenseInfo);
			
			if (isCreation)
			{
				// 进入流程...
				this.serviceWorkFlow.doStartProcess(
						expenseInfo.getApplyFormType().getId(), 
						null, 
						expenseInfo.getApplyAmt(), 
						expenseInfo.getFormNo(), 
						expenseInfo.getEmployee());
			}
			
			return ajaxPrint(response, 
					getSuccessCallback("费用申请保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when delete expense document.", e);
			return ajaxPrint(response, getErrorCallback("费用申请保存失败:" + e.getMessage()));
		}
	}
}
