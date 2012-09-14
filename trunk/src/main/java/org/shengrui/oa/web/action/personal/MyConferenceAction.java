package org.shengrui.oa.web.action.personal;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelConference;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.info.ModelShortMessage;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.service.admin.ServiceConferenceInfo;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.UtilDateTime;
import org.shengrui.oa.web.action.BaseAppAction;
import org.shengrui.oa.web.action.admin.ConferenceAction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilBean;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * WebAction: 我的会议
 * 
 * @author Tank.Lee
 *
 */
public class MyConferenceAction
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(ConferenceAction.class);
	
	/**
	 * The service of conference
	 */
	@Resource
	protected ServiceConferenceInfo serviceConference;
	
	/**
	 * 首页显示我的会议
	 * */
	public ActionForward myConferenceIndex1(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws ParseException 
	{
		
		try
		{
			ModelConference formInfo = (ModelConference) form;
			formInfo.getSponsor().setId(ContextUtil.getCurrentUser().getId());
			formInfo.getSponsor().setFullName(ContextUtil.getCurrentUser().getFullName());
			PagingBean pagingBean = this.getPagingBean1(request);
			PaginationSupport<ModelConference> conferences =
					this.serviceConference.getPaginationByEntity(formInfo, pagingBean);

			Date now = new Date();
			if(conferences!=null){
				for(ModelConference entity : conferences.getItems()){
					if("1".equals(entity.getStatus())){
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						String edatetime = format.format(entity.getEndDay())+" "+entity.getEndHour()+":"+entity.getEndMinute()+":00";
						String sdatetime = format.format(entity.getStartDay())+" "+entity.getStartHour()+":"+entity.getStartMinute()+":00";
						format.applyPattern("yyyy-MM-dd HH:mm:ss");
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
			try {
				response.getWriter().write(ObjectToString(conferences));
			} catch (IOException e) { 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all conferences.", e);
		}
		
		return null;
	}
	private String ObjectToString(PaginationSupport<ModelConference> list){
		StringBuffer sb =new StringBuffer();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if(list != null){
			for (ModelConference conference : list.getItems()) { 
				sb.append("<tr><td style=\"display: none;\">");
				sb.append(conference.getId()+"</td><td style='text-align:left'>");
				sb.append(conference.getConferenceName()+"</td>");
				sb.append("<td>"+format.format(conference.getStartDay())+" "+conference.getStartHour()+":"+conference.getStartMinute()+"</td><td>");
				sb.append(ToString(conference.getStatus())+"</td></tr>");
				
			}
			return sb.toString();
		}
		return "";
	}
	private String ToString(String status){
		String statu="";
		if("1"==status){
			statu="已发起";
		}else if("2"==status.toString()){
			statu="已结束";
		}else if("3"== status.toString()){
			statu = "已取消";
		}
		return statu;
	}
	
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
			//formInfo.getSponsor().setId(ContextUtil.getCurrentUser().getId());
			formInfo.getSponsor().setFullName(ContextUtil.getCurrentUser().getFullName());
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelConference> conferences =
					this.serviceConference.getPaginationByEntity(formInfo, pagingBean);

			Date now = new Date();
			if(conferences!=null){
				for(ModelConference entity : conferences.getItems()){
					if("1".equals(entity.getStatus())){
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						String edatetime = format.format(entity.getEndDay())+" "+entity.getEndHour()+":"+entity.getEndMinute()+":00";
						String sdatetime = format.format(entity.getStartDay())+" "+entity.getStartHour()+":"+entity.getStartMinute()+":00";
						format.applyPattern("yyyy-MM-dd HH:mm:ss");
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
//							if(entity.getSummary()==null || !UtilString.isNotEmpty(entity.getSummary())){
//								result += "<br/><font color=\"red\"请进行会议总结</font>";
//							}
						}
						entity.setResult(result);
					}else if("2".equals(entity.getStatus())){
						entity.setResult("会议时间已过");
					}else if("3".equals(entity.getStatus())){
						entity.setResult("会议已取消");
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
				
				String attendance_ids = confInfo.getAttendanceIds();
				String attendance_name_show = "[";
				if(attendance_ids!=null && UtilString.isNotEmpty(attendance_ids)){
					if(attendance_ids.contains(",")){
						String[] ids = attendance_ids.split(",");
						int loop = 1;
						for(String eid : ids){
							ModelHrmEmployee employee = this.serviceHrmEmployee.get(eid);
							if (employee != null)
							{
								attendance_name_show+="{\"id\":\""+employee.getId()+"\",\"empName\":\""+employee.getEmpName()+"\",\"empNo\":\""+employee.getEmpNo()+"\"}";
							}
							else
							{
								LOGGER.warn("The employee does not exist with id:" + eid);
							}
							if(loop < ids.length && employee!=null){
								attendance_name_show += ",";
							}
							loop ++;
						}
					}else{
						ModelHrmEmployee employee = this.serviceHrmEmployee.get(attendance_ids);
						if(employee!=null)attendance_name_show+="{\"id\":\""+employee.getId()+"\",\"empname\":\""+employee.getFullName()+"\"}";
					}
				}
				attendance_name_show +="]";
				request.setAttribute("attendance_name_show", attendance_name_show);
				request.setAttribute("conference", confInfo);
			}

			request.setAttribute("select_departments", 
					this.getDepartmentByOrganization(String.valueOf(ContextUtil.getCurrentUser().getDistrict().getDistrictType())));
			// 获取所有校区
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// added by Jeccy.Zhao on 2012/09/13
			if (!this.isObjectIdValid(id))
			{
				// 会议发布, 选择列表校区头数据获取部门数据...
				request.setAttribute("select_departments", 
						this.getDepartmentByOrganization(
								String.valueOf(ContextUtil.getCurrentUser().getEmployee().getEmployeeDistrict().getDistrictType())));
				
				// 发布部门, 校区 - 默认显示为当前登录用户.
				ModelConference confInfo = new ModelConference();
				confInfo.setDistrict(
						ContextUtil.getCurrentUser().getEmployee().getEmployeeDistrict());
				confInfo.setDepartment(
						ContextUtil.getCurrentUser().getEmployee().getEmployeeDepartment());
				
				request.setAttribute("conference", confInfo);
				
			}
			
			// 获取按校区所有部门列表
			Map<Integer, List<ModelSchoolDepartment>> departments = this.getAllDepartments(request, false);
			
			if (departments != null)
			{
				List<Object> depNames = this.serviceSchoolDepartment.getDistinctDepartmentNames();
				if (depNames != null)
				{
					request.setAttribute("depNames", depNames);
					
					Map<Integer, Map<String, String>> depSetIds = new HashMap<Integer, Map<String, String>>();
					
					depSetIds.put(AppUtil.EAppSchoolType.HEADQUARTERS.getValue(), 
							new HashMap<String, String>());
					
					depSetIds.put(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue(), 
							new HashMap<String, String>());
					
					depSetIds.put(AppUtil.EAppSchoolType.AREA_SLOT.getValue(), 
							new HashMap<String, String>());
					
					// 总部部门
					List<ModelSchoolDepartment> depMasters = departments.get(AppUtil.EAppSchoolType.HEADQUARTERS.getValue());
					if (depMasters != null)
					{
						for (ModelSchoolDepartment dep : depMasters)
						{
							if (depNames.contains(dep.getDepName()))
							{
								depSetIds.get(AppUtil.EAppSchoolType.HEADQUARTERS.getValue()).put(dep.getDepName(), dep.getId());
							}
						}
					}
					
					// 校区部门
					List<ModelSchoolDepartment> depCampus = departments.get(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue());
					if (depCampus != null)
					{
						for (ModelSchoolDepartment dep : depCampus)
						{
							if (depNames.contains(dep.getDepName()))
							{
								depSetIds.get(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue()).put(dep.getDepName(), dep.getId());
							}
						}
					}
					
					// 片区部门
					List<ModelSchoolDepartment> depSlot = departments.get(AppUtil.EAppSchoolType.AREA_SLOT.getValue());
					if (depSlot != null)
					{
						for (ModelSchoolDepartment dep : depSlot)
						{
							if (depNames.contains(dep.getDepName()))
							{
								depSetIds.get(AppUtil.EAppSchoolType.AREA_SLOT.getValue()).put(dep.getDepName(), dep.getId());
							}
						}
					}
					
					request.setAttribute("depSetIds", depSetIds);
					
				}
			}
			request.setAttribute("op", request.getParameter("op"));
			if(request.getParameter("op")!=null && "edit".equals(request.getParameter("op"))){
				request.setAttribute("conferenceType", this.serviceAppDictionary.getByType("conference"));
			}
			request.setAttribute("currentDistrictId", ContextUtil.getCurrentUser().getEmployee().getEmployeeDistrict().getId());
			request.setAttribute("currentDepId", ContextUtil.getCurrentUser().getEmployee().getEmployeeDepartment().getId());
			
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
			if(formInfo.getLevel() == null){
				return ajaxPrint(response,getErrorCallback("请选择会议级别"));
			}
			if(formInfo.getType()==null || formInfo.getType().getId()==null)
			{
				return ajaxPrint(response,getErrorCallback("请选择会议类型"));
			}
			ModelConference entity = null;
			if(formInfo.getSponsor().getId() == null){
				formInfo.getSponsor().setId(ContextUtil.getCurrentUser().getId());
			}
			boolean isCreation = !this.isObjectIdValid(formInfo.getId());
			if (!isCreation)
			{
				// 更新
				String attendances = ContextUtil.getCurrentUser().getFullName();
				String attendanceIds = ContextUtil.getCurrentUser().getId();
				int count = 1;
				// 保存任务参与人
				Map<String, List<String>> paramEmpIds = this.getAllRequestParameters(request, new String[] {"empid"});
				if (paramEmpIds != null && paramEmpIds.size() > 0)
				{
					List<String> empIds = paramEmpIds.get("empid");
					for (String empId : empIds)
					{
						ModelHrmEmployee employee = this.serviceHrmEmployee.get(empId);
						if (employee != null && !empId.equals(ContextUtil.getCurrentUser().getId()))
						{
							attendances+=","+employee.getEmpName();
							attendanceIds+=","+employee.getId();
						}
						else
						{
							LOGGER.warn("The employee does not exist with id:" + empId);
						}
					}
					count+=empIds.size();
				}
				formInfo.setAttendances(attendances);
				formInfo.setAttendanceIds(attendanceIds);
				formInfo.setCount(count);
				String contactor = request.getParameter("emp.fullName");
				if(contactor!=null && !"".equals(contactor)){
					formInfo.setContactor(contactor);
				}
				String phone = request.getParameter("emp.phoneNo");
				if(phone!=null && !"".equals(phone)){
					formInfo.setPhone(phone);
				}
				entity = this.serviceConference.get(formInfo.getId());
				if (entity != null)
				{
					// 用表单输入的值覆盖实体中的属性值
					try
					{
						if(formInfo.getStartDay() == null || formInfo.getEndDay() == null)
						{
							return ajaxPrint(response, getErrorCallback("会议时间不能为空"));
						}
						UtilBean.copyNotNullProperties(entity, formInfo);
						if(entity.getStartDay() == null || entity.getEndDay() == null){
							entity.setStartDay(formInfo.getStartDay());
							entity.setEndDay(formInfo.getEndDay());
						}
						// Ensures the end date not null after properties copy.
						if (entity.getContactor() == null)
						{
							entity.setContactor(ContextUtil.getCurrentUser().getFullName());
						}
						
						if (entity.getSponsor().getFullName() == null)
						{
							entity.setSponsor(ContextUtil.getCurrentUser());
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
				String attendances = ContextUtil.getCurrentUser().getFullName();
				String attendanceIds = ContextUtil.getCurrentUser().getId();
				int count = 1;
				// 保存任务参与人
				Map<String, List<String>> paramEmpIds = this.getAllRequestParameters(request, new String[] {"empid"});
				if (paramEmpIds != null && paramEmpIds.size() > 0)
				{
					List<String> empIds = paramEmpIds.get("empid");
					for (String empId : empIds)
					{
						ModelHrmEmployee employee = this.serviceHrmEmployee.get(empId);
						if (employee != null)
						{
							attendances+=","+employee.getEmpName();
							attendanceIds+=","+employee.getId();
						}
						else
						{
							LOGGER.warn("The employee does not exist with id:" + empId);
						}
					}
					count+=empIds.size();
				}
				formInfo.setAttendances(attendances);
				formInfo.setAttendanceIds(attendanceIds);
				formInfo.setCount(count);
				String contactor = request.getParameter("emp.fullName");
				if(contactor!=null && !"".equals(contactor)){
					formInfo.setContactor(contactor);
				}
				String phone = request.getParameter("emp.phoneNo");
				if(phone!=null && !"".equals(phone)){
					formInfo.setPhone(phone);
				}
				
				//ModelAppUser sponsor;
				//formInfo.setSponsor(sponsor);
				
				
				entity = formInfo;
				entity.setSponsor(ContextUtil.getCurrentUser());
			}

			// 设置会议附件
			this.handleFileAttachments(entity, request);
			this.handleFileAttachments(entity, request, "fileUrls_1");
			this.serviceConference.save(entity);
			
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("entity", entity);
			
			//调整会议，发送消息
			if (!isCreation)
			{
				this.sendMessage("admin.conference.update", 
						params, new Object[] {
							entity.getAttendanceIds()
						}, 
						ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
					);
			
			}
			//发起会议，发送消息
			else
			{
				this.sendMessage("admin.conference.initial", 
						params, new Object[] {
							entity.getAttendanceIds()
						}, 
						ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
					);
				
			}
			
			
			
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
					getSuccessCallback("会议保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		} 
		catch (Exception e)
		{
			LOGGER.error("It failed to save the school department item entity!", e);
			
			return ajaxPrint(response, getErrorCallback("会议保存失败."+ e.getMessage()));
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
			if(conferences !=null){
				for(ModelConference entity : conferences.getItems()){
					if("1".equals(entity.getStatus())){
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						String edatetime = format.format(entity.getEndDay())+" "+entity.getEndHour()+":"+entity.getEndMinute()+":00";
						String sdatetime = format.format(entity.getStartDay())+" "+entity.getStartHour()+":"+entity.getStartMinute()+":00";
						format.applyPattern("yyyy-MM-dd HH:mm:ss");
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
							if(entity.getSummary()==null || !UtilString.isNotEmpty(entity.getSummary())){
								result += "<br/><font color=\"red\">请进行会议总结</font>";
							}
						}
						entity.setResult(result);
					}else if("2".equals(entity.getStatus())){
						entity.setResult("会议时间已过");
					}else if("3".equals(entity.getStatus())){
						entity.setResult("会议已取消");
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
				
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("entity", entity);
				
				//取消会议，发送消息
					this.sendMessage("admin.conference.cancel", 
							params, new Object[] {
								entity.getAttendanceIds()
							}, 
							ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
						);
				
				return ajaxPrint(
		                  response,
		                  getSuccessCallback("会议取消成功.", CALLBACK_TYPE_CLOSE,
		                        CURRENT_NAVTABID, null, false));
			}else{
				return ajaxPrint(response,getErrorCallback("无效的ID"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,getErrorCallback("会议取消失败"+e.getMessage()));
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
				
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("entity", entity);
				//会议激活，发送消息
				this.sendMessage("admin.conference.initial", 
						params, new Object[] {
							entity.getAttendanceIds()
						}, 
						ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
					);
				
				return ajaxPrint(
		                  response,
		                  getSuccessCallback("会议激活成功.", CALLBACK_TYPE_CLOSE,
		                        CURRENT_NAVTABID, null, false));
			}else{
				return ajaxPrint(response,getErrorCallback("无效的ID"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,getErrorCallback("会议激活失败"+e.getMessage()));
		}
	}
	
	public ActionForward actionLoadSubmitSummaryDialog(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		try
		{
			String id = request.getParameter("id");
			
			if (this.isObjectIdValid(id))
			{
				ModelConference confInfo =  this.serviceConference.get(id);
				request.setAttribute("conference", confInfo);
			}
			return mapping.findForward("person.dialog.conference.summary");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch the conference entity!", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败,原因:" + e.getMessage()));
		}
	}
	
	public ActionForward actionSubmitSummary(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		String id = request.getParameter("id");
		ModelConference entity = null;
		try {
			entity = this.serviceConference.get(id);
			if (entity != null)
			{
				// 设置会议附件
				this.handleFileAttachments(entity, request,"fileUrls");
				entity.setStatus(ModelConference.ConferenceStatus.END.getText());
				entity.setSummary(request.getParameter("summary"));
				this.serviceConference.save(entity);
				
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("entity", entity);
				//会议总结，发送消息
				this.sendMessage("admin.conference.complete", 
						params, new Object[] {
							entity.getAttendanceIds()
						}, 
						ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
					);
				
				return ajaxPrint(response, 
						getSuccessCallback("会议总结提交成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			}else{
				return ajaxPrint(response,getErrorCallback("无效的ID"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return ajaxPrint(response,getErrorCallback("会议总结提交失败"+e.getMessage()));
		}
	}
	
	/**
	 * @return the serviceConference
	 */
	public ServiceConferenceInfo getServiceConference() {
		return serviceConference;
	}

	/**
	 * @param serviceConference the serviceConference to set
	 */
	public void setServiceConference(ServiceConferenceInfo serviceConference) {
		this.serviceConference = serviceConference;
	}
}
