package org.shengrui.oa.web.action.hrm;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeRoadMap;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 员工档案
 * 
 * @author Jeccy.Zhao
 *
 */
public class HrmEmployeeAction
extends BaseHrmAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(HrmHireAction.class);
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 员工档案管理
	 */
	public ActionForward hrmEmployeeDocIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			ModelHrmEmployee formEmployeeInfo = (ModelHrmEmployee) form;
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelHrmEmployee> employeeInfo =
					this.serviceHrmEmployee.getEmployeeInfoPagination(formEmployeeInfo, pagingBean);
			
			request.setAttribute("employeeInfo", employeeInfo);
			request.setAttribute("employeeForm", formEmployeeInfo);
			
			// 获取所有校区, 用于搜索查询使用
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, employeeInfo);
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all employee documents.", e);
		}
		
		return mapping.findForward("hrm.page.employee.doc.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 晟睿旅程保存
	 */
	public ActionForward actionRoadMapSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String employeeId = request.getParameter("id");
			String teacherStar = request.getParameter("teacherStar");
			String consultStar = request.getParameter("consultStar");
			String teachClassArray[] = request.getParameterValues("teachClass");
			String teachSubjectArray[] = request.getParameterValues("teachSubject");
			String teachClass = "";
			String teachSubject = "";
			if(teachClassArray!=null){
				for (String tc : teachClassArray)
				{
					if(UtilString.isNotEmpty(teachClass)){
						teachClass += "," + tc;
					}else{
						teachClass = tc;
					}
				}
			}
			if(teachSubjectArray!=null){
				for (String ts : teachSubjectArray)
				{
					if(UtilString.isNotEmpty(teachSubject)){
						teachSubject += "," + ts;
					}else{
						teachSubject = ts;
					}
				}
			}
			if (this.isObjectIdValid(employeeId))
			{
				ModelHrmEmployee employeeInfo = this.serviceHrmEmployee.get(employeeId);
				if (employeeInfo != null)
				{
					employeeInfo.setTeacherStar(Integer.parseInt(teacherStar));
					employeeInfo.setConsultStar(Integer.parseInt(consultStar));
					employeeInfo.setTeachClass(teachClass);
					employeeInfo.setTeachSubject(teachSubject);
					
					ModelHrmEmployee formEntity = (ModelHrmEmployee) form;
					employeeInfo.setPositiveDueDate(formEntity.getPositiveDueDate());
					employeeInfo.setContractEndDate(formEntity.getContractEndDate());
					employeeInfo.setOfficePhone(formEntity.getOfficePhone());
					
					this.serviceHrmEmployee.save(employeeInfo);
					
					return ajaxPrint(response, 
							getSuccessCallback("晟睿旅程保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("员工档案不存在:id-" + employeeId));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入员工ID参数."));
			}
			
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when delete employee document.", e);
			return ajaxPrint(response, getErrorCallback("晟睿旅程保存失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 员工档案详细信息查看
	 */
	public ActionForward hrmEmployeeDocDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String employeeId = request.getParameter("id");
			if (this.isObjectIdValid(employeeId))
			{
				ModelHrmEmployee employeeInfo = this.serviceHrmEmployee.get(employeeId);
				if (employeeInfo != null)
				{
					request.setAttribute("employee", employeeInfo);
				}
			}
			else
			{
				LOGGER.error("需要传入员工ID参数.");
			}
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch employee document detail.", e);
		}
		return mapping.findForward("hrm.page.employee.doc.detail");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 员工档案删除
	 */
	public ActionForward actionEmployeeDelete(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String employeeId = request.getParameter("id");
			if (this.isObjectIdValid(employeeId))
			{
				ModelHrmEmployee employeeInfo = this.serviceHrmEmployee.get(employeeId);
				if (employeeInfo != null)
				{
					employeeInfo.setStatus("N");
					this.serviceHrmEmployee.save(employeeInfo);
					
					return ajaxPrint(response, 
							getSuccessCallback("员工档案删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("员工档案不存在:id-" + employeeId));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入员工ID参数."));
			}
			
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when delete employee document.", e);
			return ajaxPrint(response, getErrorCallback("员工档案删除失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 晟睿旅程
	 */
	public ActionForward hrmEmployeeDocRoadMap(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			String employeeId = request.getParameter("id");
			if (this.isObjectIdValid(employeeId))
			{
				ModelHrmEmployee employeeInfo = this.serviceHrmEmployee.get(employeeId);
				if (employeeInfo != null)
				{
					request.setAttribute("employee", employeeInfo);
					Set<ModelHrmEmployeeRoadMap> roadMap = employeeInfo.getRoadMaps();
					request.setAttribute("roadmap", roadMap);
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入员工ID参数."));
			}
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
			request.setAttribute("positions", this.serviceSchoolDepartmentPosition.getAll());
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch employee document detail.", e);
		}
		
		return mapping.findForward("hrm.page.employee.doc.roadmap");
	}
}
