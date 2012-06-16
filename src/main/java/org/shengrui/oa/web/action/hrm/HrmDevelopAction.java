package org.shengrui.oa.web.action.hrm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeApply;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 人力资源发展
 * 
 * @author Jeccy.Zhao
 *
 */
public class HrmDevelopAction
extends BaseHrmAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(HrmDevelopAction.class);
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 人力资源发展管理
	 */
	public ActionForward hrmEmployeeDevelopIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			ModelHrmEmployeeApply employeeDevelopForm = (ModelHrmEmployeeApply) form;
			String op = request.getParameter("op");
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelHrmEmployeeApply> employeeDevelopInfo =
					this.serviceHrmEmployeeDevelop.getEmployeeDevelopInfoPagination(employeeDevelopForm, pagingBean);
			
			request.setAttribute("employeeDevelopInfo", employeeDevelopInfo);
			request.setAttribute("employeeDevelopForm", employeeDevelopForm);
			
			// 获取所有校区, 用于搜索查询使用
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			if("viewprogress".equals(op)){
				request.setAttribute("op", op);
			}
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, employeeDevelopInfo);
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all employee documents.", e);
		}
		
		return mapping.findForward("hrm.page.employee.develop.index");
	}

}
