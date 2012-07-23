package org.shengrui.oa.web.action.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelAdminWorkArrange;
import org.shengrui.oa.model.admin.ModelStaffAttendance;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.model.system.ModelBaseWorkContent;
import org.shengrui.oa.model.system.ModelBaseWorkTime;
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
				this.serviceNewsManage.getPaginationByNews(approvalNews, pagingBean);
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
		try {
			ModelNewsMag modelNewsMag = (ModelNewsMag) form;
			ModelNewsMag entity = null;
			
			boolean isCreation = !this.isObjectIdValid(modelNewsMag.getId());
			if(!isCreation){
				entity = serviceNewsManage.getModelNewsMag(modelNewsMag.getId());
				if(entity != null && formAction =="" && formadd == null){
					String districtPost = request.getParameter("districtPost");
					entity.setDistrict(this.serviceSchoolDistrict.get(districtPost));
					String districtVisible = request.getParameter("districtVisible");
					entity.setNewsDistrictVisible(this.serviceSchoolDistrict.get(districtVisible));
					String depPost = request.getParameter("depPost");
					entity.setDepartment(this.serviceSchoolDepartment.get(depPost));
					String typeDicid = request.getParameter("typeDicid");
					entity.setDictionary(this.serviceAppDictionary.get(typeDicid));
					entity.setUpdateTime(new Date());
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
				modelNewsMag.setDictionary(this.serviceAppDictionary.get(request.getParameter("typeDicid")));
				modelNewsMag.setUser(this.serviceAppUser.findByUserName((String) request.getSession().getAttribute("SPRING_SECURITY_LAST_USERNAME")));
				modelNewsMag.setAuthorName((String) request.getSession().getAttribute("SPRING_SECURITY_LAST_USERNAME"));
				modelNewsMag.setCreatetime(new Date());
				modelNewsMag.setTopIndex(1);
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
			newsFirst.setTopIndex(0);
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
			cancelNewsFst.setTopIndex(1);
			cancelNewsFst.setUpdateTime(cancelNewsFst.getCreatetime());
			serviceNewsManage.save(cancelNewsFst);
		} catch (Exception e) {
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
			
			//System.out.println("进入员工考勤管理->工作安排"+workArranges.getItems().get(0).getWorkDate());
			
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
				List<ModelBaseWorkContent> workContents = this.serviceBaseWorkContent
		        .getAll();
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
		String staffNames = request.getParameter("staffNames");
		String staffIds = request.getParameter("staffIds");
		String[] staffNameArray = null;
		String[] staffIdArray = null;
		ModelAdminWorkArrange entity = (ModelAdminWorkArrange)form;
		if(staffNames!=null && staffIds!=null ){
			if(staffNames.contains(",") || staffIds.contains(",")){
				staffNameArray = staffNames.split(",");
				staffIdArray = staffIds.split(",");
				if(staffNameArray.length != staffIdArray.length){
					return ajaxPrint(response,"提交的数据异常");
				}else{
					List<ModelAdminWorkArrange> list = new ArrayList<ModelAdminWorkArrange>();
					for(int i=0;i<staffNameArray.length;i++){
						ModelAdminWorkArrange model = new ModelAdminWorkArrange();
						model.getStaff().setId(staffIdArray[i]);
						model.setStaffName(staffNameArray[i]);
						model.setWorkDate(entity.getWorkDate());
						model.getWorkContent().setId(entity.getWorkContent().getId());
						model.getWorkTime().setId(entity.getWorkTime().getId());
						model.getWorkType().setId(entity.getWorkType().getId());
						list.add(model);
					}
					try {
						this.serviceAdminWorkArrange.batchInsert(list);
					} catch (ServiceException e) {
						// TODO Auto-generated catch block
						LOGGER.error("Exception raised when add a work arrange!", e);
						return ajaxPrint(response, getErrorCallback("添加工作安排失败,原因:" + e.getMessage()));
					}
			         // 保存成功后, Dialog进行关闭
			         return ajaxPrint(response, 
			               getSuccessCallback("添加工作安排成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
			}else{
				entity.getStaff().setId(staffIds);
				entity.setStaffName(staffNames);
				try {
					this.serviceAdminWorkArrange.save(entity);
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					LOGGER.error("Exception raised when add a work arrange!", e);
					return ajaxPrint(response, getErrorCallback("添加工作安排失败,原因:" + e.getMessage()));
				}
		         // 保存成功后, Dialog进行关闭
		         return ajaxPrint(response, 
		               getSuccessCallback("添加工作安排成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
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
//		ModelWorkTemplate enabledTemplate = this.serviceWorkTemplate.getEnabledWorkTemplate(districtId);
//		List<ModelBaseWorkTime> workTimes = this.serviceBaseWorkTime
//        .getDayWorkTimeByDistrictIdAndTemplateId(districtId,
//              enabledTemplate.getTemplateId());
		List<ModelBaseWorkContent> workContents = this.serviceBaseWorkContent
        .getAll();
//		request.setAttribute("workTimes", workTimes);
		request.setAttribute("workContents", workContents);
		return mapping.findForward("admin.page.staff.work.arrange.dialog");
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
	 * 根据日期和工作时间加载已经安排工作的员工
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
			StringBuffer sb = new StringBuffer();
			sb.append("[");
			for(ModelAdminWorkArrange entity : list){
				sb.append("[\"id\",\"").append(entity.getStaff().getId()).append("\",\"staffName\",\"").append(entity.getStaffName()).append("\"]");
				if(loop!=list.size()){
					sb.append(",");
				}
				loop++;
			}
			sb.append("]");
			System.out.println(sb.toString());
			return ajaxPrint(response,sb.toString());
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,"[]");
		}
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
			ModelStaffAttendance formStaffAttendance = (ModelStaffAttendance) form;

			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelStaffAttendance> staffAttendances =
				this.serviceStaffAttendance.getPaginationByEntity(formStaffAttendance, pagingBean);
		
			request.setAttribute("staffAttendances", staffAttendances);
			request.setAttribute("formStaffAttendance", formStaffAttendance);
		
			//System.out.println("进入员工考勤管理->工作安排"+staffAttendances.getItems().get(0).getWorkDate());
		
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
		String id = request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				ModelStaffAttendance staffAttendance = this.serviceStaffAttendance.get(id);
				request.setAttribute("staffAttendance", staffAttendance);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"请求数据失败");
			}
		}else{
			return ajaxPrint(response,"请求数据失败");
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
		String id = request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				ModelStaffAttendance staffAttendance = (ModelStaffAttendance)form;
				ModelStaffAttendance entity = this.serviceStaffAttendance.get(id);
				if (entity != null) {
		               // 用表单输入的值覆盖实体中的属性值
		            BeanUtils.copyProperties(staffAttendance, entity);
		        } else {
		            return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
		        }
				this.serviceStaffAttendance.save(entity);
			    // 保存成功后, Dialog进行关闭
			    return ajaxPrint(response, 
			           getSuccessCallback("手动打卡成功 .", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"请求数据失败");
			}
		}else{
			return ajaxPrint(response,"数据异常，打卡失败");
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
		String id = request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				ModelStaffAttendance staffAttendance = this.serviceStaffAttendance.get(id);
				request.setAttribute("staffAttendance", staffAttendance);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"请求数据失败");
			}
		}else{
			return ajaxPrint(response,"请求数据失败");
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
		String id = request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				ModelStaffAttendance staffAttendance = (ModelStaffAttendance)form;
				ModelStaffAttendance entity = this.serviceStaffAttendance.get(id);
				if (entity != null) {
		               // 用表单输入的值覆盖实体中的属性值
		            BeanUtils.copyProperties(staffAttendance, entity);
		        } else {
		            return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
		        }
				this.serviceStaffAttendance.save(entity);
			    // 保存成功后, Dialog进行关闭
			    return ajaxPrint(response, 
			           getSuccessCallback("手动打卡成功 .", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"请求数据失败");
			}
		}else{
			return ajaxPrint(response,"数据异常，打卡失败");
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
		String id = request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				ModelStaffAttendance staffAttendance = this.serviceStaffAttendance.get(id);
				request.setAttribute("staffAttendance", staffAttendance);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"请求数据失败");
			}
		}else{
			return ajaxPrint(response,"请求数据失败");
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
		String id = request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				ModelStaffAttendance staffAttendance = (ModelStaffAttendance)form;
				ModelStaffAttendance entity = this.serviceStaffAttendance.get(id);
				if (entity != null) {
		               // 用表单输入的值覆盖实体中的属性值
		            BeanUtils.copyProperties(staffAttendance, entity);
		        } else {
		            return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
		        }
				this.serviceStaffAttendance.save(entity);
			    // 保存成功后, Dialog进行关闭
			    return ajaxPrint(response, 
			           getSuccessCallback("手动打卡成功 .", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"请求数据失败");
			}
		}else{
			return ajaxPrint(response,"数据异常，打卡失败");
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
		String id = request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				ModelStaffAttendance staffAttendance = this.serviceStaffAttendance.get(id);
				request.setAttribute("staffAttendance", staffAttendance);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"请求数据失败");
			}
		}else{
			return ajaxPrint(response,"请求数据失败");
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
		String id = request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				ModelStaffAttendance staffAttendance = (ModelStaffAttendance)form;
				ModelStaffAttendance entity = this.serviceStaffAttendance.get(id);
				if (entity != null) {
		               // 用表单输入的值覆盖实体中的属性值
		            BeanUtils.copyProperties(staffAttendance, entity);
		        } else {
		            return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
		        }
				this.serviceStaffAttendance.save(entity);
			    // 保存成功后, Dialog进行关闭
			    return ajaxPrint(response, 
			           getSuccessCallback("手动打卡成功 .", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"请求数据失败");
			}
		}else{
			return ajaxPrint(response,"数据异常，打卡失败");
		}
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
