package org.shengrui.oa.web.action.financial;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;

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
		
//		try
//		{
//			ModelHrmEmployeeDevelop employeeDevelopForm = (ModelHrmEmployeeDevelop) form;
//			String op = request.getParameter("op");
//			PagingBean pagingBean = this.getPagingBean(request);
//			PaginationSupport<ModelHrmEmployeeDevelop> employeeDevelopInfo =
//					this.serviceHrmEmployeeDevelop.getEmployeeDevelopInfoPagination(employeeDevelopForm, pagingBean);
//			
//			request.setAttribute("employeeDevelopInfo", employeeDevelopInfo);
//			request.setAttribute("employeeDevelopForm", employeeDevelopForm);
//			
//			// 获取所有校区, 用于搜索查询使用
//			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
//			if("viewprogress".equals(op)){
//				request.setAttribute("op", op);
//			}
//			// 输出分页信息至客户端
//			outWritePagination(request, pagingBean, employeeDevelopInfo);
//			
//		} 
//		catch (ServiceException e)
//		{
//			LOGGER.error("Exception raised when fetch all employee documents.", e);
//		}
		return mapping.findForward("finan.page.expense.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务申请查看
	 */
	public ActionForward FinanExpenseDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
//		try
//		{
//			String developId = request.getParameter("id");
//			if (this.isObjectIdValid(developId))
//			{
//				ModelHrmEmployeeDevelop developInfo = this.serviceHrmEmployeeDevelop.get(developId);
//				if (developInfo != null)
//				{
//					request.setAttribute("employeeDevelopEntry", developInfo);
//				}
//				request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
//				request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
//				request.setAttribute("positions", this.serviceSchoolDepartmentPosition.getAll());
//			}
//			else
//			{
//				LOGGER.error("需要传入人资发展ID参数.");
//			}
//		}
//		catch (ServiceException e)
//		{
//			LOGGER.error("Exception raised when fetch employee development detail.", e);
//		}
		return mapping.findForward("finan.page.expense.detail");
	}

}
