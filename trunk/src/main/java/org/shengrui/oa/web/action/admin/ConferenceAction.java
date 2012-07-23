package org.shengrui.oa.web.action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelConference;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilBean;
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
	 * 我的会议
	 */
	public ActionForward myConferenceIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			ModelConference formInfo = (ModelConference) form;
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelConference> conferences =
					this.serviceConference.getPaginationByEntity(formInfo, pagingBean);
			
			request.setAttribute("conferences", conferences);
			request.setAttribute("conferenceForm", formInfo);
			
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
				if (confInfo != null && confInfo.getDistrict() != null)
				{
					ModelSchoolDistrict district = confInfo.getDistrict();
					request.setAttribute("departments", 
							this.getDepartmentByOrganization(district.getDistrictType().toString()));
				}
				
				request.setAttribute("conference", confInfo);
			}
			
			request.setAttribute("districts", this.getAllDistricts());
			request.setAttribute("op", request.getParameter("op"));
	
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
}
