package org.shengrui.oa.web.action.hrm;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.service.flow.ServiceProcessType;

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
	 * The process type service.
	 */
	private ServiceProcessType serviceProcessType;
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 人力资源发展管理
	 */
	public ActionForward hrmEmployeeDevelopIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			ModelHrmEmployeeDevelop employeeDevelopForm = (ModelHrmEmployeeDevelop) form;
			String op = request.getParameter("op");
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelHrmEmployeeDevelop> employeeDevelopInfo =
					this.serviceHrmEmployeeDevelop.getEmployeeDevelopInfoPagination(employeeDevelopForm, pagingBean);
			
			request.setAttribute("employeeDevelopInfo", employeeDevelopInfo);
			request.setAttribute("employeeDevelopForm", employeeDevelopForm);
			
			List<ModelProcessType> procTypes = this.serviceProcessType.getTypesBySlug("hrm", true);
			if (procTypes == null)
			{
				return ajaxPrint(response, getErrorCallback("人资申请流程类型不存在..."));
			}
			
			request.setAttribute("types", procTypes);
			
			// 获取所有校区, 用于搜索查询使用
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			if("viewprogress".equals(op))
			{
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
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 人力资源发展详细信息查看
	 */
	public ActionForward hrmEmployeeDevelopDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String developId = request.getParameter("id");
			if (this.isObjectIdValid(developId))
			{
				ModelHrmEmployeeDevelop developInfo = this.serviceHrmEmployeeDevelop.get(developId);
				if (developInfo != null)
				{
					request.setAttribute("employeeDevelopEntry", developInfo);
				}
				request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
				request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
				request.setAttribute("positions", this.serviceSchoolDepartmentPosition.getAll());
			}
			else
			{
				LOGGER.error("需要传入人资发展ID参数.");
			}
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch employee development detail.", e);
		}
		return mapping.findForward("hrm.page.employee.develop.detail");
	}

	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 人力资源发展调动，离职，晋升，转正
	 */
	public ActionForward hrmEmployeeDevelopFinalize(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String developId = request.getParameter("id");
			if (this.isObjectIdValid(developId))
			{
				ModelHrmEmployeeDevelop developInfo = this.serviceHrmEmployeeDevelop.get(developId);
				if (developInfo != null)
				{
					request.setAttribute("employeeDevelopEntry", developInfo);
				}
				request.setAttribute("op", request.getParameter("op"));
			}
			else
			{
				LOGGER.error("需要传入人资发展ID参数.");
			}
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch employee development detail.", e);
		}
		return mapping.findForward("hrm.page.employee.develop.finalize");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 费用支出记录
	 */
	public ActionForward actionLoadDevelopRecords (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelHrmEmployeeDevelop formEntity = (ModelHrmEmployeeDevelop) form;
			
			// 加载审批数据
			boolean isOnApproval = request.getParameter("finished") == null;
			obtainDevelopRecords(formEntity, isOnApproval, request);
			
			request.setAttribute("formEntity", formEntity);
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		return mapping.findForward("hrm.data.employee.develop.records");
	}
	
	/**
	 * 
	 * @param request
	 * @param onApprovalStatus
	 * @return
	 * @throws ServiceException 
	 */
	private PaginationSupport<ModelHrmEmployeeDevelop> obtainDevelopRecords (ModelHrmEmployeeDevelop formEntity, 
			Boolean isOnApproval, HttpServletRequest request) throws ServiceException
	{
		if (isOnApproval != null && isOnApproval)
		{
			// 审批中
			formEntity.setAuditState(null);
		}
		
		PagingBean pagingBean = this.getPagingBean(request);
		PaginationSupport<ModelHrmEmployeeDevelop> items =
				this.serviceHrmEmployeeDevelop.getEmployeeDevelopInfoPagination(formEntity, pagingBean);
		
		request.setAttribute("dataList", items);
		
		// 输出分页信息至客户端
		outWritePagination(request, pagingBean, items);
		
		return items;
	}
	
	public ServiceProcessType getServiceProcessType()
	{
		return serviceProcessType;
	}

	public void setServiceProcessType(ServiceProcessType serviceProcessType)
	{
		this.serviceProcessType = serviceProcessType;
	}
}
