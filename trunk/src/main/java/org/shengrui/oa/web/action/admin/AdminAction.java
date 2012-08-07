package org.shengrui.oa.web.action.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.shengrui.oa.model.admin.ModelAdminWorkArrange;
import org.shengrui.oa.model.admin.ModelStaffAttendance;
import org.shengrui.oa.model.admin.ModelStaffAttendanceView;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.model.system.ModelBaseWorkContent;
import org.shengrui.oa.model.system.ModelBaseWorkTime;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.model.system.ModelWorkTemplate;
import org.shengrui.oa.util.UtilDateTime;
import org.springframework.beans.BeanUtils;
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
	 * 首页显示我的新闻
	 * */
	public ActionForward adminPageEntryIndex1 (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try {
			ModelNewsMag formNews = (ModelNewsMag) form;
			PagingBean pagingBean = this.getPagingBean1(request);
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
			response.getWriter().write(ObjectToString(news));
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("加载新闻发布与管理数据失败:" + e.getMessage()));
		}
		return null;
	}
	
	private String ObjectToString(PaginationSupport<ModelNewsMag> list){
		StringBuffer sb =new StringBuffer();
		if(list != null){
			for (ModelNewsMag news : list.getItems()) {
				sb.append("<tr><td style=\"display: none;\">");
				sb.append(news.getId()+"</td><td>");
				sb.append(news.getDictionary().getName()+"</td>");
				sb.append("<td>"+news.getNewsSubject()+"</td><td>");
				sb.append(news.getUpdateTime()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 新闻发布与管理
	 * @author pyc
	 */
	public ActionForward adminPageEntryIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try {
			ModelNewsMag formNews = (ModelNewsMag) form;
			PagingBean pagingBean = this.getPagingBean(request);
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
			
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("加载新闻发布与管理数据失败:" + e.getMessage()));
		}
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
		ModelNewsMag approvalNews = (ModelNewsMag) form;
		PagingBean pagingBean = this.getPagingBean(request);
		try {
			approvalNews.setDictionary(this.getServiceAppDictionary().get(request.getParameter("newstype")));
			String districtPost = request.getParameter("districtPost");
			approvalNews.setDistrict(this.serviceSchoolDistrict.get(districtPost));
			PaginationSupport<ModelNewsMag> newsInfo = 
				this.serviceNewsManage.getPaginationFilert(approvalNews, pagingBean);
			request.setAttribute("newsInfo", newsInfo);
			request.setAttribute("newsApprove", approvalNews);
			request.setAttribute("newsTypes", this.getServiceAppDictionary().getByType(type));
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			request.setAttribute("op", request.getParameter("op"));
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, newsInfo);
			return mapping.findForward("admin.page.entry.approval.index");
		} catch (Exception e) {
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
				ModelNewsMag modelNewsMag = this.serviceNewsManage.getModelNewsMag(newsId);
				if(modelNewsMag != null && modelNewsMag.getDistrictPost() != null)
				{
					ModelSchoolDistrict district = modelNewsMag.getDistrict();
					request.setAttribute("departments", this.getDepartmentByOrganization(district.getDistrictType().toString()));
				}
				request.setAttribute("news", modelNewsMag);
			}
			request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			request.setAttribute("newsTypes", this.getServiceAppDictionary().getByType(type));
			request.setAttribute("op", request.getParameter("op"));
		} catch (Exception e) {
			e.printStackTrace();
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
		String formAction = request.getParameter("formAction");
		String formadd = request.getParameter("formadd");
		String formedit = request.getParameter("formedit");
		try {
			ModelNewsMag modelNewsMag = (ModelNewsMag) form;
			ModelNewsMag entity = null;
			
			boolean isCreation = !this.isObjectIdValid(modelNewsMag.getId());
			if(!isCreation){
				entity = serviceNewsManage.getModelNewsMag(modelNewsMag.getId());
				if(entity != null && !formedit.equals("") && formadd == null){
					String districtPost = request.getParameter("districtPost");
					entity.setDistrict(this.serviceSchoolDistrict.get(districtPost));
					String districtVisible = request.getParameter("districtVisible");
					entity.setNewsDistrictVisible(this.serviceSchoolDistrict.get(districtVisible));
					String depPost = request.getParameter("depPost");
					entity.setDepartment(this.serviceSchoolDepartment.get(depPost));
					String typeDicid = request.getParameter("typeDicid");
					entity.setDictionary(this.serviceAppDictionary.get(typeDicid));
					entity.setUpdateTime(new Date());
					if(formedit.equals("4"))
					{
						entity.setStatus(1);
					}else{
						entity.setStatus(0);
					}
					// 用表单输入的值覆盖实体中的属性值
					UtilBean.copyNotNullProperties(entity, modelNewsMag);
					this.serviceNewsManage.save(entity);
					return ajaxPrint(response, 
							getSuccessCallback("新闻编辑成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
			}
			else{
				//创建一条新闻
				entity = modelNewsMag;
				modelNewsMag.setDistrict(this.serviceSchoolDistrict.get(request.getParameter("districtPost")));
				modelNewsMag.setNewsDistrictVisible(this.serviceSchoolDistrict.get(request.getParameter("districtVisible")));
				modelNewsMag.setDepartment(this.serviceSchoolDepartment.get(request.getParameter("depPost")));
				if (request.getParameter("typeDicid") == null)
				{
					return ajaxPrint(response, getErrorCallback("新闻类型不存在，请先在数字字典里配置新闻类型，再添加新闻！"));
				}
				else
				{
					modelNewsMag.setDictionary(this.serviceAppDictionary.get(request.getParameter("typeDicid")));
				}
				modelNewsMag.setUser(this.serviceAppUser.findByUserName((String) request.getSession().getAttribute("SPRING_SECURITY_LAST_USERNAME")));
				modelNewsMag.setAuthorName((String) request.getSession().getAttribute("SPRING_SECURITY_LAST_USERNAME"));
				modelNewsMag.setCreatetime(new Date());
				modelNewsMag.setTopIndex(0);
				modelNewsMag.setUpdateTime(new Date());
			}

			//审核
			if(formAction != null)
			{
				if(formAction.equals("0")){
					entity.setStatus(2);
					this.serviceNewsManage.save(entity);
					return ajaxPrint(response, 
							getSuccessCallback("新闻审核通过.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				if(formAction.equals("1")){
					entity.setStatus(3);
					this.serviceNewsManage.save(entity);
					return ajaxPrint(response, 
							getSuccessCallback("新闻审批退回.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}

			}
			//添加
			if(formadd != null){
				if(formadd.equals("2")){
					entity.setStatus(1);
				}
				if(formadd.equals("3")){
					entity.setStatus(0);
				}
			}
			//设置新闻附件
			this.handleFileAttachments(entity, request);
			
			this.serviceNewsManage.save(entity);
			return ajaxPrint(response, 
					getSuccessCallback("新闻添加成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			
		} catch (Exception e) {
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("编辑新闻失败：" + e.getMessage()));
		}
		
	}
	
	/**
	 * 预览新闻
	 * @author pyc
	 * */
	public ActionForward actionNewsScan(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response)
	{
		try
		{
			String newsId = request.getParameter("id");
			ModelNewsMag newsScanInfo = serviceNewsManage.getModelNewsMag(newsId);
			
			request.setAttribute("newsScanInfo", newsScanInfo);
			request.setAttribute("op","view");
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapping.findForward("admin.page.entry.scan");
	}
	
	/**
	 * 新闻置顶
	 * @autho pyc
	 * 
	 * */
	public ActionForward adminOprEntryFirst (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		String id = request.getParameter("id");
		try
		{
			ModelNewsMag newsFirst = this.serviceNewsManage.get(id);
			newsFirst.setUpdateTime(new Date());
			newsFirst.setTopIndex(1);
			serviceNewsManage.save(newsFirst);
		} catch (Exception e) {
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("新闻置顶失败：" + e.getMessage()));
		}
		return ajaxPrint(response, 
				getSuccessCallback("新闻置顶成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
	}
	
	/**
	 * 新闻置顶取消
	 * @author pyc
	 * */
	public ActionForward adminOprEntryRemoveFirst(ActionMapping mapping,ActionForm form,
			HttpServletRequest request, HttpServletResponse response)throws WebException
	{
		String id = request.getParameter("id");
		try {
			ModelNewsMag cancelNewsFst = this.serviceNewsManage.get(id);
			cancelNewsFst.setTopIndex(0);
			cancelNewsFst.setUpdateTime(cancelNewsFst.getCreatetime());
			serviceNewsManage.save(cancelNewsFst);
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("新闻置顶取消失败：" + e.getMessage()));
		}
		
		return ajaxPrint(response, getSuccessCallback("新闻置顶取消成功", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 新闻发布与管理 - 新闻删除操作.
	 * @throws WebException 
	 * @author pyc
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
	 * 员工考勤管理 > 工作安排->编辑工作安排dialog界面
	 * @throws WebException 
	 * @author Tang
	 */
	public ActionForward adminEditStaffWorkArrangeDialog (ActionMapping mapping, ActionForm form,
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
			    request.setAttribute("workTypes", this.getServiceAdminWorkType().getAllWorkTypes());
				//ModelBaseWorkTime baseWorkTime = this.serviceBaseWorkTime.get(workArrange.getWorkTime().getId())
				ModelWorkTemplate enabledTemplate = this.serviceWorkTemplate.getEnabledWorkTemplate(workArrange.getWorkTime().getBaseTimeDistrict().getId());
				List<ModelBaseWorkTime> workTimes = this.serviceBaseWorkTime
		        .getDayWorkTimeByDistrictIdAndTemplateId(workArrange.getWorkTime().getBaseTimeDistrict().getId(),
		              enabledTemplate.getTemplateId());
				ModelBaseWorkContent entity = new ModelBaseWorkContent();
				entity.getBaseWorkDistrict().setId(workArrange.getDistrictId());
				List<ModelBaseWorkContent> workContents = this.serviceBaseWorkContent.getListByCriteria(entity);
				request.setAttribute("workTimes", workTimes);
				request.setAttribute("workContents", workContents);
				return mapping.findForward("admin.dialog.staff.work.arrange.edit");
			}else{
				return ajaxPrint(response,"请求异常");
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch the work arrange!", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败,原因:" + e.getMessage()));
		}
	}
	
	/**
	 * 编辑工作安排
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward adminUpdateWorkArrange(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		//如果有Id传进来，则有可能是编辑或者查看详细,那么去读取详细的工作安排信息
		String id = request.getParameter("id");
		String staffName = request.getParameter("emp.fullName");
		String staffId = request.getParameter("emp.id");
		ModelAdminWorkArrange workArrange = (ModelAdminWorkArrange)form;
		workArrange.getStaff().setId(staffId);
		workArrange.setStaffName(staffName);
		ModelAdminWorkArrange entity = null;
		if (this.isObjectIdValid(id))
		{
			try {
				entity =  this.getServiceAdminWorkArrange().get(id);
				if (entity != null) {
		               // 用表单输入的值覆盖实体中的属性值
		            BeanUtils.copyProperties(workArrange, entity);
		        } else {
		            return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
		        }
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				this.serviceAdminWorkArrange.save(entity);
		         // 保存成功后, Dialog进行关闭
		         return ajaxPrint(response, 
		               getSuccessCallback("添加工作安排成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				LOGGER.error("Exception raised when fetch the work arrange!", e);
				return ajaxPrint(response, getErrorCallback("数据加载失败,原因:" + e.getMessage()));
			}
		}else{
			return ajaxPrint(response,"请求异常");
		}
	}
	
	/**
	 * 添加工作安排(单个&批量)
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward  adminAddStaffWorkArrange(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response){
		ModelAdminWorkArrange entity = (ModelAdminWorkArrange)form;
		// 保存工作人员
		Map<String, List<String>> paramEmpIds = this.getAllRequestParameters(request, new String[] {"empid"});
		if (paramEmpIds != null && paramEmpIds.size() > 0)
		{
			List<String> empIds = paramEmpIds.get("empid");
			List<ModelAdminWorkArrange> list = new ArrayList<ModelAdminWorkArrange>();
			for (String empId : empIds)
			{
				ModelHrmEmployee employee;
				try {
					employee = this.serviceHrmEmployee.get(empId);
					if (employee != null)
					{
						ModelAdminWorkArrange model = new ModelAdminWorkArrange();
						model.getStaff().setId(empId);
						model.setStaffName(employee.getEmpName());
						model.setWorkDate(entity.getWorkDate());
						model.getWorkContent().setId(entity.getWorkContent().getId());
						model.getWorkTime().setId(entity.getWorkTime().getId());
						model.getWorkType().setId(entity.getWorkType().getId());
						model.setDistrictId(entity.getDistrictId());
						list.add(model);
					}
					else
					{
						LOGGER.warn("The employee does not exist with id:" + empId);
						return ajaxPrint(response,"提交的数据异常");
					}
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					return ajaxPrint(response,"提交的数据异常");
				}
			}
			try {
				this.serviceAdminWorkArrange.batchInsert(list);
		         // 保存成功后, Dialog进行关闭
		         return ajaxPrint(response, 
		               getSuccessCallback("添加工作安排成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"提交的数据异常");
			}
		}else{
        	return ajaxPrint(response,"提交的数据异常");
        }
	}
	
	/**
	 * 转到添加工作安排dialog
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws ServiceException
	 */
	
	public ActionForward dialogStaffWorkArrange(ActionMapping mapping, ActionForm form,
			HttpServletRequest request,HttpServletResponse response) throws ServiceException
	{
		//如果有Id传进来，则有可能是编辑或者查看详细,那么去读取详细的工作安排信息
		String id = request.getParameter("id");
//		String districtId = request.getParameter("districtId");
		if (this.isObjectIdValid(id))
		{
			ModelAdminWorkArrange workArrange =  this.getServiceAdminWorkArrange().get(id);
		    request.setAttribute("workArrange", workArrange);
		}
		
		request.setAttribute("op", request.getParameter("op"));

		request.setAttribute("workTypes", this.getServiceAdminWorkType().getAllWorkTypes());
		List<ModelSchoolDistrict> districts=this.serviceSchoolDistrict.getAll();//.getAllDistricts();
        request.setAttribute("districts", districts);
		return mapping.findForward("admin.page.staff.work.arrange.dialog");
	}
	
	/**
	 * 根据校区ID加载部门树
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionLoadDepartmentsByDistrict(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		String districtId = request.getParameter("districtId");
		try {
			ModelSchoolDistrict district = this.serviceSchoolDistrict.get(districtId);
			List<ModelSchoolDepartment> departments = this.serviceSchoolDepartment.getDepartmentByOrganization(district.getDistrictType());
			request.setAttribute("district", district);
			request.setAttribute("departments", departments);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,"请求数据异常");
		}
		return mapping.findForward("admin.page.staff.work.arrange.department");
	}
	
	
	/**
	 * 删除工作安排
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward adminDeleteWorkArrange(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		String id = request.getParameter("id");
		try{
			if(this.isObjectIdValid(id)){
				this.serviceAdminWorkArrange.remove(id);
				return ajaxPrint(
		                  response,
		                  getSuccessCallback("工作安排删除成功.", CALLBACK_TYPE_CLOSE,
		                        CURRENT_NAVTABID, null, false));
			}else{
				return ajaxPrint(response,getErrorCallback("无效的ID"));
			}
		}catch(Exception e){
			return ajaxPrint(response,getErrorCallback("删除工作安排失败"));
		}
	}
	
	/**
	 * 根据日期,工作时间,校区加载已经安排工作的员工
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionLoadArrangedStaffs(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response){
		ModelAdminWorkArrange formWorkArrange = (ModelAdminWorkArrange)form;
		try {
			List<ModelAdminWorkArrange> list = this.serviceAdminWorkArrange.queryByCriteria(formWorkArrange);
			int loop = 1;
			String staffNames = "";
			String staffIds = "";
			for(ModelAdminWorkArrange entity : list){
				staffNames+=entity.getStaffName();
				staffIds+=entity.getStaff().getId();
				if(loop!=list.size()){
					staffNames+=",";
					staffIds+=",";
				}
				loop++;
			}
			request.setAttribute("staffNames", staffNames);
			request.setAttribute("staffIds", staffIds);
			//return ajaxPrint(response,sb.toString());
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			//return ajaxPrint(response,"[]");
		}
		return mapping.findForward("admin.page.staff.work.arrange.staffnames");
	}
	
	/**
	 * 根据校区加载工作内容
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionLoadWorkContent(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		ModelBaseWorkContent entity = new ModelBaseWorkContent();
		entity.getBaseWorkDistrict().setId(request.getParameter("districtId"));
		try {
			List<ModelBaseWorkContent> workContents = this.serviceBaseWorkContent.getListByCriteria(entity);
			request.setAttribute("workContents", workContents);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapping.findForward("admin.page.staff.work.arrange.workcontent");
	}
	
	/**
	 * 根据校区加载工作时间
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionLoadWorkTime(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		try {
			ModelWorkTemplate enabledTemplate = this.serviceWorkTemplate.getEnabledWorkTemplate(request.getParameter("districtId"));
			String templateId = "-1";
			if(enabledTemplate!=null && enabledTemplate.getTemplateId()!=null)
			templateId = enabledTemplate.getTemplateId();
			List<ModelBaseWorkTime> workTimes = this.serviceBaseWorkTime.getDayWorkTimeByDistrictIdAndTemplateId(request.getParameter("districtId"), templateId);
			request.setAttribute("workTimes", workTimes);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapping.findForward("admin.page.staff.work.arrange.worktime");
	}
	/**
	 * 跳转到调整工作dialog
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionAdjustWorkArrangeDialog(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		List<ModelSchoolDistrict> districts;
		try {
			districts = this.serviceSchoolDistrict.getAll();
	        request.setAttribute("districts", districts);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			LOGGER.error("Exception raised when fetch all hire jobs.", e);
		}
		return mapping.findForward("admin.dialog.staff.work.arrange.adjust");
	}
	
	/**
	 * 调整工作安排
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionAdjustWorkArrange(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		String operation = request.getParameter("operations");
		ModelAdminWorkArrange entity = (ModelAdminWorkArrange)form;
		if("remove".equals(operation)){
			try {
				this.serviceAdminWorkArrange.batchRemoveByCriteria(entity);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(
		                  response,
		                  getErrorCallback("调整工作安排失败."+e.getMessage()));
			}
			return ajaxPrint(
	                response,
	                getSuccessCallback("调整工作安排成功.", CALLBACK_TYPE_CLOSE,
	                      CURRENT_NAVTABID, null, false));
		}else if("adjust".equals(operation)){
			String newWorkDate = request.getParameter("newWorkDate");
			String newWorkTime = request.getParameter("newWorkTime");
			entity.getWorkTime().setId(newWorkTime);
			try {
				this.serviceAdminWorkArrange.batchUpdateByCriteria(entity, newWorkDate);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(
		                  response,
		                  getErrorCallback("调整工作安排失败."+e.getMessage()));
			}
			return ajaxPrint(
	                response,
	                getSuccessCallback("调整工作安排成功.", CALLBACK_TYPE_CLOSE,
	                      CURRENT_NAVTABID, null, false));
		}else{
			return ajaxPrint(
	                  response,
	                  getErrorCallback("请求异常"));
		}
	}
	
	/**
	 * 导入模板dialog
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws ServiceException 
	 */
	public ActionForward actionImportDataFromTemplateDialog(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws ServiceException
	{
		List<ModelSchoolDistrict> districts=this.serviceSchoolDistrict.getAll();//.getAllDistricts();
        request.setAttribute("districts", districts);
		return mapping.findForward("admin.dialog.staff.work.arrange.import");
	}
	
	/**
	 * 批量导入
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionImportDataFromTemplate(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String districtId = request.getParameter("districtId");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date sDate = format.parse(startDate);
			Date eDate = format.parse(endDate);
			if(eDate.after(sDate)){
				int days = UtilDateTime.getIntervalDays(sDate, eDate);
				List<Date> allDaysList = UtilDateTime.getDatesDateRange(sDate, eDate);
				int loop = days/7;
				int remain = days%7;
				List<Date> weekDate = new ArrayList<Date>();
				String[] weekDay = {"","","","","","",""};//一周模板顺序
				int firstDayIndex = (UtilDateTime.week2int.get(UtilDateTime.getDateWeekStr(sDate))-1)%7;
				for(int i=0;i<7;i++){
					weekDay[i]=UtilDateTime.int2week.get((i+firstDayIndex)%7);
				}
				for(int i=0;i<loop;i++){
					for(int j=7*i;j<7*(i+1);j++){
						weekDate.add(allDaysList.get(j));
					}
					this.copyByWeek(weekDay, weekDate,districtId);
					weekDate.clear();
				}
				weekDate.clear();
				for(int i=0;i<remain;i++){
					weekDate.add(allDaysList.get(loop*7+i));
				}
				this.copyByWeek(weekDay, weekDate,districtId);
				return ajaxPrint(
		                response,
		                getSuccessCallback("批量导入工作安排成功.", CALLBACK_TYPE_CLOSE,
		                      CURRENT_NAVTABID, null, false));
			}else{
				return  ajaxPrint(response,"非法的时间段");
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			return ajaxPrint(
	                  response,
	                  getErrorCallback("批量导入工作安排失败."+e.getMessage()));
		}
	}
	
	/**
	 * 按周模板批量导入
	 * @param week
	 * @param list
	 */
	public void copyByWeek(String[] week,List<Date> list,String districtId){
		for(int i =0 ; i < (list.size()>7?7:list.size());i++){
			try {
				this.serviceAdminWorkArrange.batchCopyByDay(week[i], UtilDateTime.dateString(list.get(i)),districtId);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	public ActionForward actionViewWorkArrangeByWeek(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		int currentWeek = Integer.parseInt(request.getParameter("currentWeek")!=null?request.getParameter("currentWeek"):"0");
		String districtId = request.getParameter("districtId");
		if(!this.isObjectIdValid(districtId)){
			return ajaxPrint(response,getErrorCallback("请先选择校区"));
		}
		Date currentDay = new Date();
		//几周后的今天
		Date viewWeek = UtilDateTime.addDays(currentDay, currentWeek*7);
		String viewWeekBeginDay = UtilDateTime.currentWeekBeginDate(viewWeek);
		String viewWeekEndDay = UtilDateTime.currentWeekEndDate(viewWeek);
		try {
			List<ModelAdminWorkArrange> list = this.serviceAdminWorkArrange.queryByWeek(UtilDateTime.toDateByPattern(viewWeekBeginDay), UtilDateTime.toDateByPattern(viewWeekEndDay), districtId);
			if(list != null && list.size()> 0){
				Date[] weekDays = { null, null,null, null, null, null, null, null };
				Map<String,Integer> weekDay = new HashMap<String,Integer>();// 一周日期
				for(int i=1;i<=7;i++){
					Date weekDayDateStr = UtilDateTime.addDays(UtilDateTime.toDateByPattern(viewWeekBeginDay), i-1);
					weekDay.put(UtilDateTime.formatDate2Str(weekDayDateStr),i);
					weekDays[i] = weekDayDateStr;
				}
		        String[] zam = { "", "", "", "", "", "", "", "" };//一周中每天白天工作人员 
		        String[] zpm = { "", "", "", "", "", "", "", "" };//一周中每天晚上工作人员
				for(ModelAdminWorkArrange entity : list){
					String workDate = UtilDateTime.formatDate2Str(entity.getWorkDate());
					if(weekDay.containsKey(workDate)){
						int index = weekDay.get(workDate);
						if ("AM".equals(checkWorkTime(entity.getWorkTime().getWorkEtime()))){
							if(!"1".equals(entity.getWorkType().getId())){
				               zam[index] += "<font color=\"yellow\">"+entity.getStaffName() + "</font>,";
							}else{
								zam[index] += entity.getStaffName() + ",";
							}
						}
			            else if ("PM".equals(checkWorkTime(entity.getWorkTime().getWorkEtime())))
			            	if(!"1".equals(entity.getWorkType().getId())){
			            		zpm[index] += "<font color=\"yellow\">"+entity.getStaffName() + "</font>,";
			            	}else{
			            		zpm[index] += entity.getStaffName() + ",";
			            	}
					}
				}

		        for(int i=1;i<8;i++){
		        	if(!"".equals(zam[i])&&zam[i].endsWith(",")){
		        		zam[i] = zam[i].substring(0, zam[i].length()-1);
		        	}
		        	if(!"".equals(zpm[i])&&zpm[i].endsWith(",")){
		        		zpm[i] = zpm[i].substring(0, zpm[i].length()-1);
		        	}
		        }
		        request.setAttribute("staffOnAM", zam);
		        request.setAttribute("staffOnPM", zpm);
		        request.setAttribute("districtId", districtId);
		        request.setAttribute("viewWeekBeginDay", viewWeekBeginDay);
		        request.setAttribute("viewWeekEndDay", viewWeekEndDay);
		        List<ModelSchoolDistrict> districts = this.getAllDistricts();
		        request.setAttribute("districts", districts);
		        request.setAttribute("previewWeek", String.valueOf(currentWeek-1));
		        request.setAttribute("nextWeek", String.valueOf(currentWeek+1));
		        request.setAttribute("weekDays", weekDays);
		        List<ModelBaseWorkTime> dayWorkTimes = this.serviceBaseWorkTime
	               .getDayWorkTimeByDistrictIdAndTemplateId(districtId, this.serviceWorkTemplate.getEnabledWorkTemplate(districtId).getTemplateId());
	         String startWorkTimePM = "";
	         String endWorkTimePM = "";
	         String startWorkTimeWeekAM = "";
	         String endWorkTimeWeekAM = "";
	         String startWorkTimeWeekendAM = "";
	         String endWorkTimeWeekendAM = "";
	         int loop1 = 1;
	         int loop2 = 1;
	         int loop3 = 1;
	         for (ModelBaseWorkTime entity : dayWorkTimes) {
	            if ("PM".equals(checkWorkTime(entity.getWorkStime()))) { // 工作时间在晚上
	               if (loop1 == 1) {
	                  startWorkTimePM = entity.getWorkStime();
	                  endWorkTimePM = entity.getWorkEtime();
	                  loop1++;
	               } else {
	                  if (startWorkTimePM.compareTo(entity.getWorkStime()) > 0) {
	                     startWorkTimePM = entity.getWorkStime();
	                  }
	                  if (endWorkTimePM.compareTo(entity.getWorkEtime()) < 0) {
	                     endWorkTimePM = entity.getWorkEtime();
	                  }
	               }
	            } else { // 工作时间在白天
	               if (entity.getAdjustDays().contains("周六")
	                     || entity.getAdjustDays().contains("周日")) {
	                  if (loop2 == 1) {
	                     startWorkTimeWeekendAM = entity.getWorkStime();
	                     endWorkTimeWeekendAM = entity.getWorkEtime();
	                     loop2++;
	                  } else {
	                     if (startWorkTimeWeekendAM.compareTo(entity
	                           .getWorkStime()) > 0) {
	                        startWorkTimeWeekendAM = entity.getWorkStime();
	                     }
	                     if (endWorkTimeWeekendAM.compareTo(entity
	                           .getWorkEtime()) < 0) {
	                        endWorkTimeWeekendAM = entity.getWorkEtime();
	                     }
	                  }
	               }
	               if (entity.getAdjustDays().contains("周一")
	                     || entity.getAdjustDays().contains("周二")
	                     || entity.getAdjustDays().contains("周三")
	                     || entity.getAdjustDays().contains("周四")
	                     || entity.getAdjustDays().contains("周五")) {
	                  if (loop3 == 1) {
	                     startWorkTimeWeekAM = entity.getWorkStime();
	                     endWorkTimeWeekAM = entity.getWorkEtime();
	                     loop3++;
	                  } else {
	                     if (startWorkTimeWeekAM.compareTo(entity
	                           .getWorkStime()) > 0) {
	                        startWorkTimeWeekAM = entity.getWorkStime();
	                     }
	                     if (endWorkTimeWeekAM.compareTo(entity
	                           .getWorkEtime()) < 0) {
	                        endWorkTimeWeekAM = entity.getWorkEtime();
	                     }
	                  }
	               }
	            }
	         }
	         request.setAttribute("startWorkTimePM", startWorkTimePM);
	         request.setAttribute("endWorkTimePM", endWorkTimePM);
	         request.setAttribute("startWorkTimeWeekAM", startWorkTimeWeekAM);
	         request.setAttribute("endWorkTimeWeekAM", endWorkTimeWeekAM);
	         request.setAttribute("startWorkTimeWeekendAM",
	               startWorkTimeWeekendAM);
	         request.setAttribute("endWorkTimeWeekendAM", endWorkTimeWeekendAM);
			}else{
				return ajaxPrint(response,getErrorCallback("这周没有工作安排"));
			}
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapping.findForward("admin.page.staff.work.arrange.view");
	}
	
	public ActionForward actionViewWorkArrangePage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{

        List<ModelSchoolDistrict> districts = this.getAllDistricts();
        request.setAttribute("districts", districts);
		return mapping.findForward("admin.page.staff.work.arrange.view");
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
		try
		{	
//			ModelStaffAttendance formStaffAttendance = (ModelStaffAttendance) form;
//			request.setAttribute("formStaffAttendance", formStaffAttendance);
//			PagingBean pagingBean = this.getPagingBean(request);
//			PaginationSupport<ModelStaffAttendance> staffAttendances =
//				this.serviceStaffAttendance.getPaginationByEntity(formStaffAttendance, pagingBean);
			ModelStaffAttendanceView formStaffAttendance = (ModelStaffAttendanceView) form;
			request.setAttribute("formStaffAttendance", formStaffAttendance);
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelStaffAttendanceView> staffAttendances =
				this.serviceStaffAttendanceView.getPaginationByEntity(formStaffAttendance, pagingBean);
			request.setAttribute("staffAttendances", staffAttendances);
		
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, staffAttendances);
		
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all hire jobs.", e);
		}
		return mapping.findForward("admin.page.staff.attendance");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 员工考勤 > 打卡Dialog
	 * @throws WebException 
	 */
	public ActionForward adminPageStaffAttendanceOnPunch (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		ModelStaffAttendanceView formInfo = (ModelStaffAttendanceView)form;
		try {
			if(formInfo.getAttendanceViewId()!=null){
				ModelStaffAttendanceView staffAttendance = this.getServiceStaffAttendanceView().getById(formInfo.getAttendanceViewId());
				if(staffAttendance != null)request.setAttribute("staffAttendance", staffAttendance);
				else return ajaxPrint(response,getErrorCallback("请求数据失败"));
			}
		} catch (ServiceException e) {
			return ajaxPrint(response,getErrorCallback("请求数据失败"));
		}
		return mapping.findForward("admin.page.staff.attendance.onpunch");
	}
	
	/**
	 * 手动打卡
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionPuchOnHand(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		ModelStaffAttendance formInfo = (ModelStaffAttendance)form;
		String offSTime = formInfo.getOfftimeShour()+":"+formInfo.getOfftimeSmin();
		String offETime = formInfo.getOfftimeEhour()+":"+formInfo.getOfftimeEmin();
		String[] workTime = formInfo.getWorkTime().split("-");
		if(UtilDateTime.compareTime(offSTime,workTime[0],"HH:mm") && UtilDateTime.compareTime(offETime,workTime[1],"HH:mm")){
			formInfo.setAttendanceResult("早退");
		}else if(!UtilDateTime.compareTime(offSTime,workTime[0],"HH:mm") && !UtilDateTime.compareTime(offETime,workTime[1],"HH:mm")){
			formInfo.setAttendanceResult("迟到");
		}else if(!UtilDateTime.compareTime(offSTime,workTime[0],"HH:mm") && UtilDateTime.compareTime(offETime,workTime[1],"HH:mm")){
			formInfo.setAttendanceResult("迟到早退");
		}else{
			formInfo.setAttendanceResult("按时");
		}
		ModelStaffAttendance entity = null;
		try {
			entity = formInfo;
			this.serviceStaffAttendance.save(entity);
			String arrange_id = request.getParameter("arrang_id");
			if(this.isObjectIdValid(arrange_id)){
				ModelAdminWorkArrange arrange = this.getServiceAdminWorkArrange().get(arrange_id);
				arrange.setAttendanceId(entity.getId());
				this.getServiceAdminWorkArrange().save(arrange);
			}
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
		           getSuccessCallback("手动打卡成功 .", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,getErrorCallback("请求数据失败"));
		} 
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 员工考勤 > 出差安排Dialog
	 * @throws WebException 
	 */
	public ActionForward adminPageStaffAttendanceOnTravel (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		ModelStaffAttendanceView formInfo = (ModelStaffAttendanceView)form;
		try {
			if(formInfo.getAttendanceViewId()!=null){
				ModelStaffAttendanceView staffAttendance = this.getServiceStaffAttendanceView().getById(formInfo.getAttendanceViewId());
				if(staffAttendance != null)request.setAttribute("staffAttendance", staffAttendance);
				else return ajaxPrint(response,getErrorCallback("请求数据失败"));
			}
		} catch (ServiceException e) {
			return ajaxPrint(response,getErrorCallback("请求数据失败"));
		}
		return mapping.findForward("admin.page.staff.attendance.ontravel");
	}
	
	/**
	 * 安排出差
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionArrangeOnTravel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		ModelStaffAttendance formInfo = (ModelStaffAttendance)form;
		formInfo.setWorkStatus("1");
		ModelStaffAttendance entity = null;
		try {
			entity = formInfo;
			this.serviceStaffAttendance.save(entity);
			String arrange_id = request.getParameter("arrang_id");
			if(this.isObjectIdValid(arrange_id)){
				ModelAdminWorkArrange arrange = this.getServiceAdminWorkArrange().get(arrange_id);
				arrange.setAttendanceId(entity.getId());
				this.getServiceAdminWorkArrange().save(arrange);
			}
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
		          getSuccessCallback("安排出差成功 .", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,getErrorCallback("请求数据失败"));
		} 
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 员工考勤管理 > 员工考勤 > 请假Dialog
	 * @throws WebException 
	 */
	public ActionForward adminPageStaffAttendanceOnLeave (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		ModelStaffAttendanceView formInfo = (ModelStaffAttendanceView)form;
		try {
			if(formInfo.getAttendanceViewId()!=null){
				ModelStaffAttendanceView staffAttendance = this.getServiceStaffAttendanceView().getById(formInfo.getAttendanceViewId());
				if(staffAttendance != null)request.setAttribute("staffAttendance", staffAttendance);
				else return ajaxPrint(response,getErrorCallback("请求数据失败"));
			}
		} catch (ServiceException e) {
			return ajaxPrint(response,getErrorCallback("请求数据失败"));
		}
		return mapping.findForward("admin.page.staff.attendance.onleave");
	}
	
	/**
	 * 安排请假
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionArrangeOnLeave(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		ModelStaffAttendance formInfo = (ModelStaffAttendance)form;
		formInfo.setStaffBehalfId(request.getParameter("emp.id"));
		formInfo.setStaffBehalfName(request.getParameter("emp.fullName"));
		formInfo.setWorkStatus("2");
		ModelStaffAttendance entity = null;
		try {
			entity = formInfo;
			this.serviceStaffAttendance.save(entity);
			String arrange_id = request.getParameter("arrang_id");
			if(this.isObjectIdValid(arrange_id)){
				ModelAdminWorkArrange arrange = this.getServiceAdminWorkArrange().get(arrange_id);
				arrange.setAttendanceId(entity.getId());
				this.getServiceAdminWorkArrange().save(arrange);
			}
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
		          getSuccessCallback("请假安排成功 .", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,getErrorCallback("请求数据失败"));
		} 
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
		ModelStaffAttendanceView formInfo = (ModelStaffAttendanceView)form;
		try {
			if(formInfo.getAttendanceViewId()!=null){
				ModelStaffAttendanceView staffAttendance = this.getServiceStaffAttendanceView().getById(formInfo.getAttendanceViewId());
				if(staffAttendance != null)request.setAttribute("staffAttendance", staffAttendance);
				else return ajaxPrint(response,getErrorCallback("请求数据失败"));
			}
		} catch (ServiceException e) {
			return ajaxPrint(response,getErrorCallback("请求数据失败"));
		}
		return mapping.findForward("admin.page.staff.attendance.onabsence");
	}
	
	/**
	 * 标记为旷工
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward actionMarkOnAbsence(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		ModelStaffAttendance formInfo = (ModelStaffAttendance)form;
		formInfo.setStaffBehalfId(request.getParameter("emp.id"));
		formInfo.setStaffBehalfName(request.getParameter("emp.fullName"));
		formInfo.setWorkStatus("3");
		formInfo.setAttendanceResult("旷工");
		ModelStaffAttendance entity = null;
		try {
			entity = formInfo;
			this.serviceStaffAttendance.save(entity);
			String arrange_id = request.getParameter("arrang_id");
			if(this.isObjectIdValid(arrange_id)){
				ModelAdminWorkArrange arrange = this.getServiceAdminWorkArrange().get(arrange_id);
				arrange.setAttendanceId(entity.getId());
				this.getServiceAdminWorkArrange().save(arrange);
			}
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
		          getSuccessCallback("旷工处理成功 .", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,getErrorCallback("请求数据失败"));
		} 
	}
	
	public ActionForward actionCalculateVocation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		ModelStaffAttendance formInfo = (ModelStaffAttendance)form;
		String currentYearStart = UtilDateTime.currentYear()+"-01-01";
		String currentYearEnd = UtilDateTime.currentYear()+"-12-31";
		formInfo.setFilterStart(UtilDateTime.toDateByPattern(currentYearStart));
		formInfo.setFilterEnd(UtilDateTime.toDateByPattern(currentYearEnd));
		int hasUsedVocations = 0;
		try {
			List<ModelStaffAttendance> list = this.getServiceStaffAttendance().getListByCriteria(formInfo);
			if(list != null){
				hasUsedVocations = list.size();
			}
			if("3".equals(formInfo.getLeaveType())){
				ModelHrmEmployee employee = this.getServiceHrmEmployee().getEmployeeByEmpNo(formInfo.getStaffId());
				if(employee!=null){
					int workYears = UtilDateTime.calculateYears(employee.getOnboardDate());
					if(workYears >= 1 && workYears <10){
						int last = 5 - hasUsedVocations;
						request.setAttribute("days", last>0?last:0);
					}else if(workYears >= 10 && workYears <20){
						int last = 10 - hasUsedVocations;
						request.setAttribute("days", last>0?last:0);
					}else if(workYears >= 20){
						int last = 15 - hasUsedVocations;
						request.setAttribute("days", last>0?last:0);
					}else{
						request.setAttribute("days", 0);
					}
				}else{
					request.setAttribute("days", 0);
				}
			}else if ("4".equals(formInfo.getLeaveType())){
				List<ModelAdminWorkArrange> overTimes = this.getServiceAdminWorkArrange().queryCurrentYearWorkArrangById(formInfo.getStaffId(), formInfo.getFilterStart(), UtilDateTime.nowDate());
				int overTimeDays = 0;
				if(overTimes!=null)overTimeDays = overTimes.size();
				request.setAttribute("days", (overTimeDays-hasUsedVocations)>0?(overTimeDays-hasUsedVocations):0);
			}else{
				request.setAttribute("days",hasUsedVocations);
			}
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("leaveType", formInfo.getLeaveType());
		return mapping.findForward("admin.page.staff.attendance.vocation");
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
    

	   public String checkWorkTime(String time) {
	      if (time == null || "".equals(time))
	         return "";
	      String hour = time.substring(0, time.indexOf(":"));
	      if (hour != null && !"".equals(hour)) {
	         if (Integer.parseInt(hour) < 18)
	            return "AM";
	         else
	            return "PM";
	      }
	      return "";
	   }
}
