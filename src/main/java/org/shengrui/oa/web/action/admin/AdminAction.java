package org.shengrui.oa.web.action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelAdminWorkArrange;
import org.shengrui.oa.web.action.hrm.HrmHireAction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.exception.WebException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The administrator web action.
 * 
 * @author  Jeccy.Zhao
 *
 */
public class AdminAction 
extends BaseAdminAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(HrmHireAction.class);
	
	@SuppressWarnings("unused")
	private static final String ACTION_FORM_FLAG_APPROVAL = "1";
	
	@SuppressWarnings("unused")
	private static final String ACTION_FORM_FLAG_RETURNED = "2";
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 新闻发布与管理
	 */
	public ActionForward adminPageEntryIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("admin.page.entry.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 新闻审批与管理
	 */
	public ActionForward adminPageEntryApprovalIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("admin.page.entry.approval.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The presentation for administrator entry new action.
	 */
	public ActionForward adminPageEntryDetail (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("op", request.getParameter("op"));
		
		return mapping.findForward("admin.page.entry.detail");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 新闻发布与管理 - 新闻删除操作.
	 * @throws WebException 
	 */
	public ActionForward adminOprEntryRemove (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return ajaxPrint(response, AjaxResponse.RESPONSE_SUCCESS);
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 任务委托管理.
	 * @throws WebException 
	 */
	public ActionForward adminPageTaskDelegateIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return mapping.findForward("admin.page.task.delegate.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 工作安排
	 * @throws WebException 
	 * @author Tang
	 */
	public ActionForward adminPageStaffWorkArrange (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		try
		{
			ModelAdminWorkArrange formWorkArrange = (ModelAdminWorkArrange) form;

			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelAdminWorkArrange> workArranges =
					this.serviceAdminWorkArrange.getPaginationByEntity(formWorkArrange, pagingBean);
			
			request.setAttribute("workArranges", workArranges);
			request.setAttribute("formWorkArrange", formWorkArrange);
			
			System.out.println("进入员工考勤管理->工作安排"+workArranges.getItems().get(0).getWorkDate());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, workArranges);
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all hire jobs.", e);
		}
		
		return mapping.findForward("admin.page.staff.work.arrange");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 工作安排->添加工作安排dialog界面
	 * @throws WebException 
	 * @author Tang
	 */
	public ActionForward adminAddStaffWorkArrange (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		try
		{
			//如果有Id传进来，则有可能是编辑或者查看详细,那么去读取详细的工作安排信息
			String id = request.getParameter("id");
			if (this.isObjectIdValid(id))
			{
				ModelAdminWorkArrange workArrange =  this.getServiceAdminWorkArrange().get(id);
			    request.setAttribute("workArrange", workArrange);
			}
			
//			request.setAttribute("districts", this.getAllDistricts());
			request.setAttribute("op", request.getParameter("op"));
	
			request.setAttribute("workTypes", this.getServiceAdminWorkType().getAllWorkTypes());
			return mapping.findForward("admin.page.staff.work.arrange.add");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch the job hire entity!", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败,原因:" + e.getMessage()));
		}
	}
	
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 员工考勤
	 * @throws WebException 
	 */
	public ActionForward adminPageStaffAttendance (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return mapping.findForward("admin.page.staff.attendance");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 员工考勤 > 打卡
	 * @throws WebException 
	 */
	public ActionForward adminPageStaffAttendanceOnPunch (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return mapping.findForward("admin.page.staff.attendance.onpunch");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 员工考勤 > 出差安排
	 * @throws WebException 
	 */
	public ActionForward adminPageStaffAttendanceOnTravel (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return mapping.findForward("admin.page.staff.attendance.ontravel");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 员工考勤 > 请假
	 * @throws WebException 
	 */
	public ActionForward adminPageStaffAttendanceOnLeave (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return mapping.findForward("admin.page.staff.attendance.onleave");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 员工考勤 > 旷工
	 * @throws WebException 
	 */
	public ActionForward adminPageStaffAttendanceOnAbsence (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return mapping.findForward("admin.page.staff.attendance.onabsence");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理
	 * @throws WebException 
	 */
	public ActionForward adminPageDocumentIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return mapping.findForward("admin.page.document.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理 - 文档详细页面
	 * @throws WebException 
	 */
	public ActionForward adminPageDocumentDetail (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return mapping.findForward("admin.page.document.detail");
	}
	
}
