package org.shengrui.oa.web.action.financial;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.flow.ModelProcessType;

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
		return mapping.findForward("fina.application.list.index");
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
		return mapping.findForward("dialog.fina.expense.application.page");
	}
	
}
