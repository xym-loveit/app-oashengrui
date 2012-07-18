package org.shengrui.oa.web.action.admin;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelAdminWorkArrange;
import org.shengrui.oa.model.news.ModelNewsMag;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.exception.WebException;
import cn.trymore.core.util.UtilBean;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;



/**
 * The administrator web action.
 * 
 * @author  Tang
 *
 */
public class AdminAction 
extends BaseAdminAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(AdminAction.class);
	
	@SuppressWarnings("unused")
	private static final String ACTION_FORM_FLAG_APPROVAL = "1";
	
	@SuppressWarnings("unused")
	private static final String ACTION_FORM_FLAG_RETURNED = "2";
	
	private static final String type = "news";
	

	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 新闻发布与管理
	 * @author pyc
	 */
	public ActionForward adminPageEntryIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		ModelNewsMag formNews = (ModelNewsMag) form;
		PagingBean pagingBean = this.getPagingBean(request);
		try {
			String id = request.getParameter("type");
			formNews.setDictionary(this.serviceAppDictionary.get(id));
			PaginationSupport<ModelNewsMag> news = 
				this.serviceNewsManage.getPaginationByNews(formNews, pagingBean);
			request.setAttribute("news", news);
			request.setAttribute("formNews", formNews);
			request.setAttribute("newsTypes", this.getServiceAppDictionary().getByType(type));
			
			request.setAttribute("op", request.getParameter("op"));
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, news);
			return mapping.findForward("admin.page.entry.index");
		} catch (Exception e) {
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("加载新闻发布与管理数据失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 新闻审批与管理
	 */
	public ActionForward adminPageEntryApprovalIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		ModelNewsMag formNews = (ModelNewsMag) form;
		PagingBean pagingBean = this.getPagingBean(request);
		try {
			PaginationSupport<ModelNewsMag> news = 
				this.serviceNewsManage.getPaginationByNews(formNews, pagingBean);
			request.setAttribute("news", news);
			request.setAttribute("formNews", formNews);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, news);
			return mapping.findForward("admin.page.entry.approval.index");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println( e.getMessage());
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("加载新闻发布与管理数据失败:" + e.getMessage()));
		}
		
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The presentation for administrator entry new action.
	 * 新闻编辑页面
	 * @author pyc
	 */
	public ActionForward adminPageEntryDetail (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String newsId = request.getParameter("id");
		try {
			if(this.isObjectIdValid(newsId)){
				ModelNewsMag modelNewsMag = serviceNewsManage.getModelNewsMag(newsId);
				
				request.setAttribute("news", modelNewsMag);
			}
			request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
			request.setAttribute("districts", this.getServiceSchoolDistrict().getAll());
			request.setAttribute("newsTypes", this.getServiceAppDictionary().getByType(type));
			
		} catch (Exception e) {
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("进入新闻编辑页面失败 由于：" + e.getMessage())); 
		}
		return mapping.findForward("admin.page.entry.detail");
	}
	
	/**
	 * 编辑新闻
	 * @author pyc
	 * 
	 * */
	public ActionForward actionNewsEditOrSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response)
	{
		try {
			ModelNewsMag modelNewsMag = (ModelNewsMag) form;
			ModelNewsMag entity = null;
			
			boolean isCreation = !this.isObjectIdValid(modelNewsMag.getId());
			if(!isCreation){
				entity = serviceNewsManage.getModelNewsMag(modelNewsMag.getId());
				if(entity != null){
					String districtPost = request.getParameter("districtPost");
					entity.setDistrict(this.serviceSchoolDistrict.get(districtPost));
					String districtVisible = request.getParameter("districtVisible");
					entity.setDistrict(this.serviceSchoolDistrict.get(districtVisible));
					String depPost = request.getParameter("depPost");
					entity.setDepartment(this.serviceSchoolDepartment.get(depPost));
					String typeDicid = request.getParameter("typeDicid");
					entity.setDictionary(this.serviceAppDictionary.get(typeDicid));
					// 用表单输入的值覆盖实体中的属性值
					UtilBean.copyNotNullProperties(entity, modelNewsMag);
				}
			}
			else{
				entity = modelNewsMag;
			}
			String districtPost = request.getParameter("districtPost");
			modelNewsMag.setDistrict(this.serviceSchoolDistrict.get(districtPost));
			String districtVisible = request.getParameter("districtVisible");
			modelNewsMag.setDistrict(this.serviceSchoolDistrict.get(districtVisible));
			String depPost = request.getParameter("depPost");
			modelNewsMag.setDepartment(this.serviceSchoolDepartment.get(depPost));
			String typeDicid = request.getParameter("typeDicid");
			modelNewsMag.setDictionary(this.serviceAppDictionary.get(typeDicid));
			modelNewsMag.setAuthorId(1);
			modelNewsMag.setAuthorName("aaa");
			modelNewsMag.setCreatetime(new Date());
			modelNewsMag.setStatus(1);
			modelNewsMag.setTopIndex(1);
			modelNewsMag.setUpdateTime(new Date());
			serviceNewsManage.save(entity);
			return ajaxPrint(response, 
					getSuccessCallback("新闻编辑成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("编辑新闻失败：" + e.getMessage()));
		}
		
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
		String newsId = request.getParameter("id");
		
		try {
			//删除新闻纪录
			serviceNewsManage.deleteNewsByNewsId(newsId);
			request.setAttribute("id", newsId);
			return ajaxPrint(response, getSuccessCallback("新闻删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false)); 
			
		} catch (Exception e) {
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("删除新闻失败：" + e.getMessage())); 
		}
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
