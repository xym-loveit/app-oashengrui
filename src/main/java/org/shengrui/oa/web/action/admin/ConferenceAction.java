package org.shengrui.oa.web.action.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelConference;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.UtilDateTime;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilBean;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * @author tank
 *
 */
public class ConferenceAction extends BaseAdminAction {
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(ConferenceAction.class);
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 我参加的会议
	 * @throws ParseException 
	 */
	public ActionForward myConferenceIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws ParseException 
	{
		
		try
		{
			ModelConference formInfo = (ModelConference) form;
			//formInfo.setSponsor(ContextUtil.getCurrentUser());
			formInfo.getSponsor().setId(ContextUtil.getCurrentUser().getId());
			formInfo.getSponsor().setFullName(ContextUtil.getCurrentUser().getFullName());
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelConference> conferences =
					this.serviceConference.getPaginationByEntity(formInfo, pagingBean);

			Date now = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			if(conferences!=null){
				for(ModelConference entity : conferences.getItems()){
					if("1".equals(entity.getStatus())){
						String edatetime = format.format(entity.getEndDay())+" "+entity.getEndHour()+":"+entity.getEndMinute()+":00";
						String sdatetime = format.format(entity.getStartDay())+" "+entity.getStartHour()+":"+entity.getStartMinute()+":00";
						Date endDate = format.parse(edatetime);
						Date startDate = format.parse(sdatetime);
						String result = "";
						if(now.before(startDate)){
							result = UtilDateTime.getTimeBetweenDates(now, startDate);
						}
						if(now.after(startDate) && now.before(endDate)){
							result = "会议进行中";
						}
						if(now.after(endDate)){ 
							result = "会议时间已过";
							if(entity.getSummary()==null || UtilString.isNotEmpty(entity.getSummary())){
								result += "<br/><font color=\"red\"请进行会议总结</font>";
							}
						}
						entity.setResult(result);
					}else if("2".equals(entity.getStatus())){
						entity.setResult("会议已取消");
					}else if("3".equals(entity.getStatus())){
						entity.setResult("会议时间已过");
					}
				}
			}
			request.setAttribute("conferences", conferences);
			request.setAttribute("conferenceForm", formInfo);
			request.setAttribute("conferenceType", this.serviceAppDictionary.getByType("conference"));
			// 获取所有校区, 用于搜索查询使用
			//request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, conferences);
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all conferences.", e);
		}
		
		return mapping.findForward("my.page.conference.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 发起新会议dialog页面
	 */
	public ActionForward conferenceDetail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		
		try
		{
			String id = request.getParameter("id");
			
			if (this.isObjectIdValid(id))
			{
				ModelConference confInfo =  this.serviceConference.get(id);
				request.setAttribute("conference", confInfo);
			}

			request.setAttribute("departments", 
					this.getDepartmentByOrganization(String.valueOf(ContextUtil.getCurrentUser().getDistrict().getDistrictType())));
			request.setAttribute("districts", this.getAllDistricts());
			request.setAttribute("op", request.getParameter("op"));
			if(request.getParameter("op")!=null && "edit".equals(request.getParameter("op"))){
				request.setAttribute("conferenceType", this.serviceAppDictionary.getByType("conference"));
			}
			request.setAttribute("currentDistrictId", ContextUtil.getCurrentUser().getDistrict().getId());
			return mapping.findForward("person.page.conference.detail");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch the job hire entity!", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败,原因:" + e.getMessage()));
		}
	}
	

	/**
	 * <b>[WebAction]</b> <br/>
	 * 创建会议
	 */
	public ActionForward actionConferenceSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			ModelConference formInfo = (ModelConference) form;
			ModelConference entity = null;
			if(formInfo.getSponsor().getId() == null){
				formInfo.getSponsor().setId(ContextUtil.getCurrentUser().getId());
			}
			boolean isCreation = !this.isObjectIdValid(formInfo.getId());
			if (!isCreation)
			{
				// 更新
				entity = this.serviceConference.get(formInfo.getId());
				if (entity != null)
				{
					// 用表单输入的值覆盖实体中的属性值
					try
					{
						UtilBean.copyNotNullProperties(entity, formInfo);
						
						// Ensures the end date not null after properties copy.
						if (entity.getContactor() == null)
						{
							entity.setContactor(ContextUtil.getCurrentUser().getFullName());
						}
					} 
					catch (Exception e)
					{
						LOGGER.error("Exception raised when copy bean properties from the form input.", e);
					}
				}
				else
				{
					return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
				}
			}
			else
			{
				// 新建
				entity = formInfo;
			}
			
//			String districtId = request.getParameter("jobHireDistrictId");
//			if (this.isObjectIdValid(districtId) && (entity.getDistrict() == null || 
//					!districtId.equals(entity.getDistrict().getId())))
//			{
//				entity.setDistrict(this.serviceSchoolDistrict.get(districtId));
//			}
//			
//			String depId = request.getParameter("jobHireDepartmentId");
//			if (this.isObjectIdValid(depId) && (entity.getDepartment() == null || 
//					!depId.equals(entity.getDepartment().getId())))
//			{
//				entity.setDepartment(this.serviceSchoolDepartment.get(depId));
//			}
			
			// 设置审批状态
			//this.applyApprovalStatus(entity, isCreation, request);
			
//			entity.setPostDate(new Date());
//			if (ContextUtil.getCurrentUser() != null)
//			{
//				entity.setPostAuthorName(ContextUtil.getCurrentUser().getFullName());
//			}

			// 设置岗位附件
			this.handleFileAttachments(entity, request);
			this.serviceConference.save(entity);
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
					getSuccessCallback("会议保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		} 
		catch (ServiceException e)
		{
			LOGGER.error("It failed to save the school department item entity!", e);
			
			return ajaxPrint(response, getErrorCallback("会议保存失败."));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 我发起的会议
	 * @throws ParseException 
	 */
	public ActionForward myConferences(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws ParseException 
	{
		
		try
		{
			ModelConference formInfo = (ModelConference) form;
			formInfo.getSponsor().setId(ContextUtil.getCurrentUser().getId());
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelConference> conferences =
					this.serviceConference.getPaginationByEntity(formInfo, pagingBean);

			Date now = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			if(conferences !=null){
				for(ModelConference entity : conferences.getItems()){
					if("1".equals(entity.getStatus())){
						String edatetime = format.format(entity.getEndDay())+" "+entity.getEndHour()+":"+entity.getEndMinute()+":00";
						String sdatetime = format.format(entity.getStartDay())+" "+entity.getStartHour()+":"+entity.getStartMinute()+":00";
						Date endDate = format.parse(edatetime);
						Date startDate = format.parse(sdatetime);
						String result = "";
						if(now.before(startDate)){
							result = UtilDateTime.getTimeBetweenDates(now, startDate);
						}
						if(now.after(startDate) && now.before(endDate)){
							result = "会议进行中";
						}
						if(now.after(endDate)){ 
							result = "会议时间已过";
							if(entity.getSummary()==null || UtilString.isNotEmpty(entity.getSummary())){
								result += "<br/><font color=\"red\"请进行会议总结</font>";
							}
						}
						entity.setResult(result);
					}else if("2".equals(entity.getStatus())){
						entity.setResult("会议已取消");
					}else if("3".equals(entity.getStatus())){
						entity.setResult("会议时间已过");
					}
				}
			}
			request.setAttribute("conferences", conferences);
			request.setAttribute("conferenceForm", formInfo);
			request.setAttribute("conferenceType", this.serviceAppDictionary.getByType("conference"));
			request.setAttribute("noSummary", this.serviceConference.getNoSummaryConference());
			
			// 获取所有校区, 用于搜索查询使用
			//request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, conferences);
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all conferences.", e);
		}
		
		return mapping.findForward("my.page.conference.start");
	}
	
	public ActionForward actionCancelConference(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		String id = request.getParameter("id");
		ModelConference entity = null;
		try {
			entity = this.serviceConference.get(id);
			if (entity != null)
			{
				entity.setStatus(ModelConference.ConferenceStatus.CANCEL.getText());
				this.serviceConference.save(entity);
				return ajaxPrint(
		                  response,
		                  getSuccessCallback("会议取消成功.", CALLBACK_TYPE_CLOSE,
		                        CURRENT_NAVTABID, null, false));
			}else{
				return ajaxPrint(response,getErrorCallback("无效的ID"));
			}
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,getErrorCallback("会议取消失败"));
		}
	}
	
	
	public ActionForward actionActivateConference(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		String id = request.getParameter("id");
		ModelConference entity = null;
		try {
			entity = this.serviceConference.get(id);
			if (entity != null)
			{
				entity.setStatus(ModelConference.ConferenceStatus.START.getText());
				this.serviceConference.save(entity);
				return ajaxPrint(
		                  response,
		                  getSuccessCallback("会议激活成功.", CALLBACK_TYPE_CLOSE,
		                        CURRENT_NAVTABID, null, false));
			}else{
				return ajaxPrint(response,getErrorCallback("无效的ID"));
			}
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,getErrorCallback("会议激活失败"));
		}
	}
	
}
