package org.shengrui.oa.web.action.financial;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.finan.ModelFinanExpense;

import cn.trymore.core.exception.ServiceException;
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
			String op = request.getParameter("op");
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelFinanExpense> employeeExpenseInfo =
					this.serviceFinanExpense.getFinanExpenseInfoPagination(employeeExpenseForm, pagingBean);
			
			request.setAttribute("employeeExpenseInfo", employeeExpenseInfo);
			request.setAttribute("employeeExpenseForm", employeeExpenseForm);
			
			// 获取所有校区, 用于搜索查询使用
//			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			if("viewprogress".equals(op)){
				request.setAttribute("op", op);
			}
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, employeeExpenseInfo);
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
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
			String expenseId = request.getParameter("id");
			if (this.isObjectIdValid(expenseId))
			{
				ModelFinanExpense expenseInfo = this.serviceFinanExpense.get(expenseId);
				if (expenseInfo != null)
				{
					request.setAttribute("employeeExpenseEntry", expenseInfo);
				}
				request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
				request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
			}
			else
			{
				LOGGER.error("需要传入费用申请ID参数.");
			}
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch expense detail.", e);
		}
		return mapping.findForward("finan.page.expense.detail");
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务申请修改
	 */
	public ActionForward actionFinanExpenseSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String expenseId = request.getParameter("id");
			if (this.isObjectIdValid(expenseId))
			{
				ModelFinanExpense expenseInfo = this.serviceFinanExpense.get(expenseId);
				if (expenseInfo != null)
				{
					this.serviceFinanExpense.save(expenseInfo);
					
					return ajaxPrint(response, 
							getSuccessCallback("费用申请保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("费用申请记录不存在:id-" + expenseId));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入费用申请ID参数."));
			}
			
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when delete expense document.", e);
			return ajaxPrint(response, getErrorCallback("费用申请保存失败:" + e.getMessage()));
		}
	}
}