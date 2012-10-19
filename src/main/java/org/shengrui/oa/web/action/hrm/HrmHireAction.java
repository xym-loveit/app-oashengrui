package org.shengrui.oa.web.action.hrm;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmArchive;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;
import org.shengrui.oa.model.hrm.ModelHrmJobHireIssue;
import org.shengrui.oa.model.hrm.ModelHrmResume;
import org.shengrui.oa.model.info.ModelShortMessage;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.model.system.ModelAppRole;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.base.ServiceBase;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.WebActionUtil;

import cn.trymore.core.exception.ResourceNotGrantedException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.jstl.JstlTagSecurity;
import cn.trymore.core.util.UtilBean;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 人资管理 - 招聘管理
 * 
 * @author Jeccy.Zhao
 *
 */
public class HrmHireAction
extends BaseHrmAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(HrmHireAction.class);
	
	private static final String ACTION_FORM_FLAG_APPROVAL = "1";
	
	private static final String ACTION_FORM_FLAG_RETURNED = "0";
	
	/**
	 * The service of HRM employee develop.
	 */
	@Resource
	private ServiceBase serviceBase;

	/**
	 * <b>[WebAction]</b> <br/>
	 * 岗位发布与管理
	 */
	public ActionForward hrmJobIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			ModelHrmJobHireInfo formJobHireInfo = (ModelHrmJobHireInfo) form;
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelHrmJobHireInfo> hireJobs =
					this.serviceHrmJobHireInfo.getPaginationByEntity(formJobHireInfo, pagingBean);
			
			request.setAttribute("hireJobs", hireJobs);
			request.setAttribute("hireJobForm", formJobHireInfo);
			
			// 获取所有校区, 用于搜索查询使用
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, hireJobs);
			
			// 判断是否被赋予审批权限
			if (JstlTagSecurity.ifGranted(
				WebActionUtil.APPROVAL_HRM_JOB_MASTER.getKey() + "," + 
				WebActionUtil.APPROVAL_HRM_JOB_ZOON.getKey() + 
				ModelAppRole.SUPER_RIGHTS))
			{
				// 获取岗位审批(待总部审批)数量...
				int numJobOnMaster = 0;
				
				try
				{
					numJobOnMaster = this.serviceBase.getAffectedNumByQuery(ModelHrmJobHireInfo.class, 
						this.getModelDataPolicyQuery(
							WebActionUtil.APPROVAL_HRM_JOB_MASTER.getKey(),
							WebActionUtil.APPROVAL_HRM_JOB_MASTER.getObject(),
							ModelHrmJobHireInfo.class, 
							new String[] {
								"(status = " + ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue() + ")"
							}
						)
					);
				}
				catch (ResourceNotGrantedException e)
				{
					LOGGER.error("Number of job item against master failed to fetch.", e);
				}
				
				
				// 获取岗位审批(待校区审批)数量...
				int numJobOnZone = 0;
				try
				{
					numJobOnZone = this.serviceBase.getAffectedNumByQuery(ModelHrmJobHireInfo.class, 
						this.getModelDataPolicyQuery(
							WebActionUtil.APPROVAL_HRM_JOB_ZOON.getKey(),
							WebActionUtil.APPROVAL_HRM_JOB_ZOON.getObject(),
							ModelHrmJobHireInfo.class, 
							new String[] {
								"(status = " + ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue() + ")"
							}
						)
					);
				}
				catch (ResourceNotGrantedException e)
				{
					LOGGER.error("Numberof job item against zone failed to fetch.", e);
				}
				
				request.setAttribute("numJobsToApproval", numJobOnMaster + numJobOnZone);
			}
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all hire jobs.", e);
		}
		
		return mapping.findForward("hrm.page.job.index");
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 岗位审批与管理
	 */
	public ActionForward hrmPageJobApprovalIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			ModelHrmJobHireInfo formJobHireInfo = (ModelHrmJobHireInfo) form;
			
			if (ContextUtil.getCurrentUser().getFunctionRights().indexOf(ModelAppRole.SUPER_RIGHTS) > -1)
			{
				// 超级管理员, 拥有校区和总部审批双视图
				formJobHireInfo.setSearchStatusCondition(new Integer[] { 
					ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue(),
					ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue(),
				});
			}
			else if (ContextUtil.getCurrentUser().getFunctionRights().indexOf(
					WebActionUtil.APPROVAL_HRM_JOB_MASTER.getKey()) > -1)
			{
				// 总部审批视图
				formJobHireInfo.setStatus(ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue());
			}
			else if (ContextUtil.getCurrentUser().getFunctionRights().indexOf(
					WebActionUtil.APPROVAL_HRM_JOB_ZOON.getKey()) > -1)
			{
				// 校区审批视图 (暂时也适用于片区)
				formJobHireInfo.setStatus(ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue());
			}
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelHrmJobHireInfo> hireJobs =
					this.serviceHrmJobHireInfo.getPaginationByEntity(formJobHireInfo, false, pagingBean);
			
			request.setAttribute("hireJobs", hireJobs);
			request.setAttribute("hireJobForm", formJobHireInfo);
			
			// 获取所有校区, 用于搜索查询使用
			List<ModelSchoolDistrict> districts = this.serviceSchoolDistrict.getAll();
			request.setAttribute("districts", districts);
			
			if (formJobHireInfo.getJobHireDistrict() != null && 
					this.isObjectIdValid(formJobHireInfo.getJobHireDistrict().getId()))
			{
				for (ModelSchoolDistrict district : districts)
				{
					if (district.getId().equals(formJobHireInfo.getJobHireDistrict().getId()))
					{
						// 获取校区对应的部门
						request.setAttribute("departments", 
								this.getDepartmentByOrganization(district.getDistrictType().toString()));
						break;
					}
				}
			}
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, hireJobs);
			
			return mapping.findForward("hrm.page.job.approval.index");
			
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all hire jobs.", e);
			return ajaxPrint(response, getErrorCallback("待我审批岗位分页数据加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 应聘简历
	 */
	public ActionForward hrmPageJobResume(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		String resumeId = request.getParameter("resumeId");
		if (this.isObjectIdValid(resumeId))
		{
			try
			{
				request.setAttribute("resume", this.serviceHrmResume.get(resumeId));
				
				if (request.getParameter("empId") != null)
				{
					ModelHrmEmployee employee = this.serviceHrmEmployee.get(request.getParameter("empId"));
					if (employee != null)
					{
						request.setAttribute("employee", employee);
					}
				}
				
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when fetch resume with id:" + resumeId, e);
				return ajaxPrint(response, getErrorCallback("简历获取失败:" + e.getMessage()));
			}
		}
		
		// 输出请求参数至页面.
		this.getRequestQueryString(request, null, true);
		
		// 内部应聘, 获取员工简历信息...
		String source = request.getParameter("source");
		if (UtilString.isNotEmpty(source) && 
				ModelHrmResume.EResumeSource.APPLY_INNER.getValue().toString().equals(source))
		{
			if (ContextUtil.getCurrentUser().getEmployee() != null)
			{
				try
				{
					request.setAttribute("resume", this.serviceHrmResume.get(
							ContextUtil.getCurrentUser().getEmployee().getResume().getId()));
				} 
				catch (ServiceException e)
				{
					LOGGER.error("Exception raised when openning page of job application.", e);
					return ajaxPrint(response, getErrorCallback("应聘页面打开失败:" + e.getMessage()));
				}
			}
		}
		
		return mapping.findForward("hrm.page.job.resume.detail");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 岗位发布dialog页面
	 */
	public ActionForward hrmPageJobDetail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		
		try
		{
			String id = request.getParameter("id");
			
			if (this.isObjectIdValid(id))
			{
				ModelHrmJobHireInfo jobHireInfo =  this.serviceHrmJobHireInfo.get(id);
				if (jobHireInfo != null && jobHireInfo.getJobHireDistrict() != null)
				{
					ModelSchoolDistrict district = jobHireInfo.getJobHireDistrict();
					request.setAttribute("departments", 
							this.getDepartmentByOrganization(district.getDistrictType().toString()));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("岗位信息(id:" + id + ")不存在..."));
				}
				
				request.setAttribute("jobHire", jobHireInfo);
			}
			
			List<ModelSchoolDistrict> districts = this.serviceSchoolDistrict.getAll(false);
			request.setAttribute("districts", districts);
			
			if (!this.isObjectIdValid(id) && districts.size() > 0)
			{
				// 岗位发布, 选择列表校区头数据获取部门数据...
				request.setAttribute("departments", 
						this.getDepartmentByOrganization(
								String.valueOf(ContextUtil.getCurrentUser().getEmployee().getEmployeeDistrict().getDistrictType())));
				
				// 发布部门, 校区 - 默认显示为当前登录用户.
				ModelHrmJobHireInfo jobHireInfo = new ModelHrmJobHireInfo();
				jobHireInfo.setJobHireDistrict(
						ContextUtil.getCurrentUser().getEmployee().getEmployeeDistrict());
				jobHireInfo.setJobHireDepartment(
						ContextUtil.getCurrentUser().getEmployee().getEmployeeDepartment());
				
				request.setAttribute("jobHire", jobHireInfo);
			}
			
			request.setAttribute("op", request.getParameter("op"));
	
			return mapping.findForward("hrm.page.job.detail");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch the job hire entity!", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败,原因:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 岗位应聘开放控制 - 开启或是关闭
	 */
	public ActionForward actionJobOpenControl(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String state = request.getParameter("state");
			if (UtilString.isNotEmpty(state))
			{
				String jobId = request.getParameter("jobId");
				if (this.isObjectIdValid(jobId))
				{
					ModelHrmJobHireInfo jobHireInfo = this.serviceHrmJobHireInfo.get(jobId);
					if (jobHireInfo != null)
					{
						if (ModelHrmJobHireInfo.EJobHireOpen.OPEN.getValue().toString().equals(state) || 
								ModelHrmJobHireInfo.EJobHireOpen.CLOSED.getValue().toString().equals(state))
						{
							jobHireInfo.setIsOpen(Integer.parseInt(state));
							this.serviceHrmJobHireInfo.save(jobHireInfo);
							
							return ajaxPrint(response, 
									getSuccessCallback("岗位应聘控制成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("非法应聘控制状态被传入:state-" + state));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("岗位不存在:id-" + jobId));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("需要传入岗位ID参数."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要指定应聘控制状态."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when job open control.", e);
			return ajaxPrint(response, getErrorCallback("岗位应聘控制失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 岗位保存页面
	 */
	public ActionForward actionJobSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			ModelHrmJobHireInfo formJobHireInfo = (ModelHrmJobHireInfo) form;
			ModelHrmJobHireInfo entity = null;
			
			boolean isCreation = !this.isObjectIdValid(formJobHireInfo.getId());
			
			if (!isCreation)
			{
				// 更新
				entity = this.serviceHrmJobHireInfo.get(formJobHireInfo.getId());
				if (entity != null)
				{
					// 用表单输入的值覆盖实体中的属性值
					try
					{
						UtilBean.copyNotNullProperties(entity, formJobHireInfo);
						
						// Ensures the end date not null after properties copy.
						if (entity.getJobHireEndDate() == null)
						{
							entity.setJobHireEndDate(formJobHireInfo.getJobHireEndDate());
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
				entity = formJobHireInfo;
				entity.setEntryTime(new Date());
			}
			
			String districtId = request.getParameter("jobHireDistrictId");
			if (this.isObjectIdValid(districtId) && (entity.getJobHireDistrict() == null || 
					!districtId.equals(entity.getJobHireDistrict().getId())))
			{
				entity.setJobHireDistrict(this.serviceSchoolDistrict.get(districtId));
			}
			
			String depId = request.getParameter("jobHireDepartmentId");
			if (this.isObjectIdValid(depId) && (entity.getJobHireDepartment() == null || 
					!depId.equals(entity.getJobHireDepartment().getId())))
			{
				entity.setJobHireDepartment(this.serviceSchoolDepartment.get(depId));
			}
			
//			String districtVisibleId = request.getParameter("jobHireVisibleDistrictId");
//			if (this.isObjectIdValid(districtVisibleId) && (entity.getJobHireVisibleDistrict() == null || 
//					!districtVisibleId.equals(entity.getJobHireVisibleDistrict().getId())))
//			{
//				entity.setJobHireVisibleDistrict(this.serviceSchoolDistrict.get(districtVisibleId));
//			}
			
			// 设置审批状态
			this.applyApprovalStatus(entity, isCreation, request);
			
			entity.setPostDate(new Date());
			if (ContextUtil.getCurrentUser() != null)
			{
				entity.setPostAuthorName(ContextUtil.getCurrentUser().getFullName());
				entity.setEntryId(Integer.valueOf(ContextUtil.getCurrentUser().getEmployee().getId()));
			}
			
			// 设置岗位附件
			this.handleFileAttachments(entity, request);
			
			this.serviceHrmJobHireInfo.save(entity);
			
			// 短消息通知: 岗位审批人 / 岗位发起人
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("entity", entity);
			
			// 获取`待校区审批` or `待总部审批`相关的审批人
			Set<String> auditorIds = this.getUserIdsAgainstGrantedResource(
					ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue().equals(entity.getStatus()) ? 
							WebActionUtil.APPROVAL_HRM_JOB_ZOON : WebActionUtil.APPROVAL_HRM_JOB_MASTER, 
				ModelNewsMag.class, 
				entity.getJobHireDistrict().getId(), 
				entity.getJobHireDepartment().getId()
			);
			
			
			if (ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue().equals(entity.getStatus()) || 
					ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue().equals(entity.getStatus()))
			{
				if (auditorIds != null && auditorIds.size() > 0)
				{
					// 过滤非本校区
					if (ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue().equals(entity.getStatus()))
					{
						Iterator<String> itor = auditorIds.iterator();
						while (itor.hasNext())
						{
							String auditorId = itor.next();
							ModelHrmEmployee employee = this.serviceHrmEmployee.get(auditorId);
							if (employee != null && !employee.getEmployeeDistrict().getId().equals(entity.getJobHireDistrict().getId()))
							{
								itor.remove();
							}
						}
					}
					
					String strIds = UtilString.join(auditorIds, ",");
					if (UtilString.isNotEmpty(strIds))
					{
						this.sendMessage("my.approval.audit.job", 
							params, new Object[] {
								strIds
							}, 
							ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
						);
						
						// 服务器推送至客户端.
						this.messagePush.pushMessage(strIds, 
							WebActionUtil.scriptMessageNotify, 
							WebActionUtil.MENU_KEY_JOB_MGR + "," + 
								WebActionUtil.MENU_KEY_APPROVAL_TODO,
							1
						);
					}
				}
			}
			else if (ModelHrmJobHireInfo.EJobHireStatus.RETURNED.getValue().equals(entity.getStatus()) || 
				ModelHrmJobHireInfo.EJobHireStatus.APPROVED.getValue().equals(entity.getStatus()))
			{
				// 审批被退回 or 审批通过
				this.sendMessage("hrm.job.audit.result", 
					params, new Object[] {
						entity.getEntryId()
					}, 
					ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
				);
				
				String strIds = UtilString.join(auditorIds, ",");
				if (UtilString.isNotEmpty(strIds))
				{
					// 服务器推送至客户端.
					this.messagePush.pushMessage(strIds, 
						WebActionUtil.scriptMessageNotify, 
						WebActionUtil.MENU_KEY_JOB_MGR + "," + 
							WebActionUtil.MENU_KEY_APPROVAL_TODO,
						-1
					);
				}
			}
			
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
					getSuccessCallback("岗位保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		} 
		catch (ServiceException e)
		{
			LOGGER.error("It failed to save the school department item entity!", e);
			
			return ajaxPrint(response, getErrorCallback("岗位保存失败."));
		}
	}
	
	/**
	 * 设置岗位发布审批状态.
	 * 
	 * @param entity
	 * @param isCreation
	 * @param request
	 */
	private void applyApprovalStatus (ModelHrmJobHireInfo entity, 
			boolean isCreation, HttpServletRequest request)
	{
		String formAction = request.getParameter("formAction");
		
		if (entity.getJobHireDistrict().getDistrictType().equals(
				AppUtil.EAppSchoolType.HEADQUARTERS.getValue()))
		{
			// 总部岗位
			if (isCreation || !UtilString.isNotEmpty(formAction))
			{
				// 审批状态为总部审批
				entity.setStatus(ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue());
			}
			else
			{
				if (ACTION_FORM_FLAG_APPROVAL.equals(formAction))
				{
					// 审批状态为审批通过
					entity.setStatus(ModelHrmJobHireInfo.EJobHireStatus.APPROVED.getValue());
					entity.setAuditor(ContextUtil.getCurrentUser().getEmployee().getEmpName());
					entity.setAuditDate(new Date());
				}
				else if (ACTION_FORM_FLAG_RETURNED.equals(formAction))
				{
					// 审批状态为审批退回
					entity.setStatus(ModelHrmJobHireInfo.EJobHireStatus.RETURNED.getValue());
					entity.setAuditor(ContextUtil.getCurrentUser().getEmployee().getEmpName());
					entity.setAuditDate(new Date());
				}
			}
		} 
		else
		{
			// 校区岗位
			if (isCreation || !UtilString.isNotEmpty(formAction))
			{
				// 设置审批状态为校区审批 (适用于片区)
				entity.setStatus(ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue());
			}
			else
			{
				if (entity.getStatus().equals(ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue()))
				{
					// 当前审批状态为总部审批
					if (ACTION_FORM_FLAG_APPROVAL.equals(formAction))
					{
						// 审批状态为提交至总部审批
						entity.setStatus(ModelHrmJobHireInfo.EJobHireStatus.APPROVED.getValue());
						entity.setAuditor(ContextUtil.getCurrentUser().getEmployee().getEmpName());
						entity.setAuditDate(new Date());
					}
					else if (ACTION_FORM_FLAG_RETURNED.equals(formAction))
					{
						// 审批状态为审批退回至校区审批
						entity.setStatus(ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue());
					}
				}
				else if (entity.getStatus().equals(ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue()))
				{
					// 当前审批状态为校区审批
					if (ACTION_FORM_FLAG_APPROVAL.equals(formAction))
					{
						// 审批状态为提交至总部审批
						entity.setStatus(ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue());
					}
					else if (ACTION_FORM_FLAG_RETURNED.equals(formAction))
					{
						// 审批状态为审批退回
						entity.setStatus(ModelHrmJobHireInfo.EJobHireStatus.RETURNED.getValue());
						entity.setAuditor(ContextUtil.getCurrentUser().getEmployee().getEmpName());
						entity.setAuditDate(new Date());
					}
				}
			}
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 岗位入职安排保存
	 */
	public ActionForward actionJobEntrySave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String entryId = request.getParameter("entryId");
			if (this.isObjectIdValid(entryId))
			{
				ModelHrmJobHireEntry jobHireEntry = this.serviceHrmJobHireEntry.get(entryId);
				if (jobHireEntry != null)
				{
					String entryDistrictId = request.getParameter("entryDistrictId");
					String entryDepId = request.getParameter("entryDepartmentId");
					String entryPositionId = request.getParameter("entryPositionId");
					String entryChargerId = request.getParameter("charger.id");
					
					if (UtilString.isNotEmpty(entryDistrictId, entryDepId, entryPositionId, entryChargerId))
					{
						// 设置入职安排状态为'已安排'
						jobHireEntry.setCurrentStatus(ModelHrmJobHireEntry.EHireEntryCStatus.ARRANGED.getValue());
						
						// 设置入职校区
						jobHireEntry.setEntryDistrict(
								this.serviceSchoolDistrict.get(entryDistrictId));
						
						// 设置入职部门
						jobHireEntry.setEntryDepartment(
								this.serviceSchoolDepartment.get(entryDepId));
						
						// 设置入职岗位
						jobHireEntry.setEntryPosition(
								this.serviceSchoolDepartmentPosition.get(entryPositionId));
						
						// 设置负责人
						jobHireEntry.setEntryCharger(
								this.serviceAppUser.get(entryChargerId));
						
						// 设置入职状态为'待入职'
						jobHireEntry.setFinalStatus(ModelHrmJobHireEntry.EHireEntryFStatus.TODO.getValue());
						
						// 设置入职安排时间
						jobHireEntry.setEntryPlanDate(Timestamp.valueOf(request.getParameter("entryPlanDate")));
						
						this.serviceHrmJobHireEntry.save(jobHireEntry);
						
						// 短消息通知入职负责人...
						Map<String, Object> params = new HashMap<String, Object>();
						params.put("entity", jobHireEntry);
						
						this.sendMessage("hrm.job.entryin", 
								params, new Object[] {
									jobHireEntry.getEntryCharger().getEmployee().getId()
								}, 
								ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
							);
						
						// 获取审批人, 用于数据推送.
						Set<String> auditorIds = this.getUserIdsAgainstGrantedResource(
							WebActionUtil.APPROVAL_HRM_ENTRY_ONBOARD, 
							ModelHrmJobHireEntry.class, 
							String.valueOf(jobHireEntry.getEntryDistrict().getId()), 
							String.valueOf(jobHireEntry.getEntryDepartment().getId())
						);
						
						if (auditorIds != null && auditorIds.size() > 0)
						{
							//推送至客户端, 进行菜单项的入职数字提醒.
							this.messagePush.pushMessage(
								UtilString.join(auditorIds, ","), 
								WebActionUtil.scriptMessageNotify, 
								WebActionUtil.MENU_ITEM_HRM_ENTRY.getKey(),
								1
							);
						}
						
						// 保存成功后, Dialog进行关闭
						return ajaxPrint(response, 
								getSuccessCallback("入职安排成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("入职安排所传入的信息不全!"));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("入职安排信息不存在:" + entryId));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("入职安排信息ID非法或者未被传入!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when save the job entry information.", e);
			return ajaxPrint(response, getErrorCallback("入职安排信息保存失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 招聘安排与管理
	 */
	public ActionForward hrmPageJobOfferIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String jobId = request.getParameter("jobId");
			if (this.isObjectIdValid(jobId))
			{
				ModelHrmJobHireInfo jobHireInfo = this.serviceHrmJobHireInfo.get(jobId);
				if (jobHireInfo != null)
				{
					request.setAttribute("jobHireInfo", jobHireInfo);
					
					PagingBean pagingBean = this.getPagingBean(request);
					PaginationSupport<ModelHrmJobHireIssue> jobHireIssues = 
							this.serviceHrmJobHireIssue.getPaginationByJobId(jobId, pagingBean);
					
					request.setAttribute("jobHireIssues", jobHireIssues);
					request.setAttribute("jobId", jobId);
					
					// 输出分页信息至客户端
					outWritePagination(request, pagingBean, jobHireIssues);
					
					request.setAttribute("today", new Date());
					
					return mapping.findForward("hrm.page.job.offer.index");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("岗位(id:" + jobId + ")数据不存在..."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入岗位Id..."));
			}
		}
		catch (Exception e)
		{
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 应聘最终结果处理
	 */
	public ActionForward actionJobIssueFinalize(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String issueId = request.getParameter("issueId");
			String finalizeState = request.getParameter("state");
			
			if (UtilString.isNotEmpty(finalizeState, issueId) && 
					UtilString.isNumeric(finalizeState) && this.isObjectIdValid(issueId))
			{
				ModelHrmJobHireIssue jobHireIssue = this.serviceHrmJobHireIssue.get(issueId);
				if (jobHireIssue != null)
				{
					jobHireIssue.setCurrentStatus(ModelHrmJobHireIssue.EJobHireIssueStatus.FINISHED.getValue());
					jobHireIssue.setFinalResult(Integer.parseInt(finalizeState));
					
					this.serviceHrmJobHireIssue.save(jobHireIssue);
					
					if (ModelHrmJobHireIssue.EJobHireIssueFinalState.HIRED.getValue().equals(Integer.parseInt(finalizeState)))
					{
						// 录用，并生成入职安排
						ModelHrmJobHireEntry jobHireEntry = new ModelHrmJobHireEntry();
						jobHireEntry.setJobHireIssue(jobHireIssue);
						jobHireEntry.setCurrentStatus(ModelHrmJobHireEntry.EHireEntryCStatus.TODO.getValue());
						jobHireEntry.setFinalStatus(ModelHrmJobHireEntry.EHireEntryFStatus.TODO.getValue());
						jobHireEntry.setEntryDepartment(null);
						jobHireEntry.setEntryDistrict(null);
						jobHireEntry.setEntryCharger(null);
						jobHireEntry.setEntryPosition(null);
						
						this.serviceHrmJobHireEntry.save(jobHireEntry);
						
						jobHireIssue.setJobHireEntry(jobHireEntry);
						this.serviceHrmJobHireIssue.save(jobHireIssue);
					}
					else
					{
						// 淘汰或未面试
						String archived = request.getParameter("archived");
						if (UtilString.isNotEmpty(archived))
						{
							// 移入人才库
							String archiveStar = request.getParameter("archiveStar");
							
							ModelHrmArchive hrmArchive = new ModelHrmArchive();
							hrmArchive.setJobHireInfo(jobHireIssue.getJobHire());
							hrmArchive.setResume(jobHireIssue.getResume());
							hrmArchive.setSource(Integer.parseInt(finalizeState));
							hrmArchive.setStarLevel(Integer.parseInt(archiveStar));
							this.serviceHrmArchive.save(hrmArchive);
						}
					}
					
					// 保存成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("处理成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("应聘信息不存在!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("未知处理操作!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when finalize the hire issue.", e);
			return ajaxPrint(response, getErrorCallback("操作失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 简历保存
	 */
	public ActionForward actionEmployeeResumeSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			ModelHrmResume formResume = (ModelHrmResume) form;
			
			String resumeId = request.getParameter("resumeId");
			
			if (UtilString.isNotEmpty(resumeId) && Integer.valueOf(resumeId) > -1)
			{
				ModelHrmResume entity = this.serviceHrmResume.get(resumeId);
				if (entity != null)
				{
					// 重写对象中的属性值...
					UtilBean.copyNotNullProperties(entity, formResume);
					
					// Date类型未被覆写...
					entity.setBirthday(formResume.getBirthday());
					
					// 保存简历附件...
					this.handleFileAttachments(entity, request);
					
					this.serviceHrmResume.save(formResume);
					
					String empId = request.getParameter("empId");
					if (UtilString.isNotEmpty(empId) && this.isObjectIdValid(empId))
					{
						ModelHrmEmployee employee = this.serviceHrmEmployee.get(empId);
						if (employee != null)
						{
							employee.setEmpName(entity.getFullName());
							employee.setBirthdate(entity.getBirthday());
							employee.setPhoneNo(entity.getMobilePhone());
							
							employee.setShortNo(request.getParameter("shortNo"));
							employee.setUrgentContact(request.getParameter("urgentContact"));
							
							this.serviceHrmEmployee.save(employee);
						}
					}
					
					// 保存成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("简历保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("简历(Id:" + resumeId + ")数据不存在..."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入简历Id..."));
			}
			
		}
		catch (Exception e)
		{
			return ajaxPrint(response, getErrorCallback("简历保存失败:" + e.getMessage()));
		}
		
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 岗位应聘申请
	 */
	public ActionForward actionJobApply(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String jobId = request.getParameter("jobId");
			if (this.isObjectIdValid(jobId))
			{
				ModelHrmJobHireInfo jobHireInfo = this.serviceHrmJobHireInfo.get(jobId);
				if (jobHireInfo != null)
				{
					ModelHrmResume formResume = (ModelHrmResume) form;
					ModelHrmResume entity = null;
					
					String source = request.getParameter("source");
					
					if (source == null || !UtilString.isNumeric(source))
					{
						return ajaxPrint(response, getErrorCallback("未知的简历来源!"));
					}
					
					String resumeId = request.getParameter("resumeId");
					if (UtilString.isNotEmpty(resumeId) && this.isObjectIdValid(resumeId))
					{
						entity = this.serviceHrmResume.get(resumeId);
						UtilBean.copyNotNullProperties(entity, formResume);
					}
					else
					{
						entity = formResume;
					}
					
					entity.setSource(Integer.parseInt(source));
					
					// 设置简历附件...
					this.handleFileAttachments(entity, request);
					
					this.serviceHrmResume.save(entity);
					
					ModelHrmJobHireIssue jobHireIssue = new ModelHrmJobHireIssue();
					jobHireIssue.setResume(entity);
					jobHireIssue.setJobHire(jobHireInfo);
					jobHireIssue.setCurrentStatus(ModelHrmJobHireIssue.EJobHireIssueStatus.TOPLAN.getValue());
					jobHireIssue.setApplyDateTime(new Date());
					
					if (Integer.parseInt(source) != ModelHrmResume.EResumeSource.APPLY_OUTSIDE.getValue())
					{
						// 对于外部应聘的来源, 应该不存在员工的推荐或者手工输入这种情况....
						jobHireIssue.setCandidate(ContextUtil.getCurrentUser());
					}
					
					this.serviceHrmJobHireIssue.save(jobHireIssue);
					
					// 保存成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("岗位应聘成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("岗位(id:" + jobId + ")数据不存在..."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入岗位Id..."));
			}
		}
		catch (Exception e)
		{
			return ajaxPrint(response, getErrorCallback("岗位应聘失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 面试安排保存
	 */
	public ActionForward actionJobInterviewPlanSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			ModelHrmJobHireInterview jobHireInterview = (ModelHrmJobHireInterview) form;
			
			String issueId = request.getParameter("issueId");
			if (this.isObjectIdValid(issueId))
			{
				// 查询该应聘记录是否存在
				ModelHrmJobHireIssue jobHireIssue = this.serviceHrmJobHireIssue.get(issueId);
				if (jobHireIssue != null)
				{
					// 查询是否该环节已经被安排
					ModelHrmJobHireInterview sessionView = 
							this.serviceHrmJobHireInterview.getByIssueAndSessionNo(issueId, jobHireInterview.getSessionSN());
					if (sessionView != null)
					{
						return ajaxPrint(response, getErrorCallback("该环节已经被安排!"));
					}
					
					jobHireInterview.setJobHireIssue(jobHireIssue);
					
					if (jobHireInterview.getInterviewer() != null && 
							this.isObjectIdValid(jobHireInterview.getInterviewer().getId()))
					{
						ModelAppUser interviewer = this.serviceAppUser.get(jobHireInterview.getInterviewer().getId());
						if (interviewer != null)
						{
							// 设置当前面试状态为待面试
							jobHireInterview.setInterviewStatus(ModelHrmJobHireInterview.EInterviewState.TODO.getValue());
							
							// 设置当前状态为面试中.
							jobHireInterview.getJobHireIssue().setCurrentStatus(
									ModelHrmJobHireIssue.EJobHireIssueStatus.INTERVIEWING.getValue());
							
							jobHireInterview.setInterviewer(interviewer);
							
							this.serviceHrmJobHireInterview.save(jobHireInterview);
							
							// 短消息通知面试官
							Map<String, Object> params = new HashMap<String, Object>();
							params.put("entity", jobHireInterview);
							this.sendMessage("hrm.interview.arranged", 
								params, new Object[] {
									jobHireInterview.getInterviewer().getEmployee().getId()
								}, 
								ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
							);
							
							// 推送至客户端, 进行数字提醒更新.
							this.messagePush.pushMessage(
								jobHireInterview.getInterviewer().getEmployee().getId(), 
								WebActionUtil.scriptMessageNotify, 
								WebActionUtil.MENU_ITEM_INTERVIEW_COMMIT.getKey(),
								1
							);
							
							return ajaxPrint(response, 
									getSuccessCallback("招聘面试安排成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("面试官不存在:" + jobHireInterview.getInterviewer().getFullName()));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("请指定面试官."));
					}
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("应聘信息不存在."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving the interview plan.", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败:" + e.getMessage()));
		}
		return null;
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 面试招聘安排
	 */
	public ActionForward hrmPageJobOfferInterviewPlan(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		
		try
		{
			String issueId = request.getParameter("issueId");
			if (this.isObjectIdValid(issueId))
			{
				ModelHrmJobHireIssue jobHireIssue = this.serviceHrmJobHireIssue.get(issueId);
				if (jobHireIssue != null)
				{
					request.setAttribute("jobHireIssue", jobHireIssue);
					
					if (request.getParameter("op") != null) 
					{
						request.setAttribute("op", request.getParameter("op"));
					}
					
					return mapping.findForward("hrm.page.job.offer.interview.plan");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("应聘信息不存在."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("非法应聘信息ID被传入."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the dialog of interview plan.", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败:" + e.getMessage()));
		}
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 面试记录
	 */
	public ActionForward hrmPageJobOfferInterviewIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		
		try
		{
			String issueId = request.getParameter("issueId");
			if (this.isObjectIdValid(issueId))
			{
				ModelHrmJobHireIssue hrmJobHireIssue = this.serviceHrmJobHireIssue.get(issueId);
				if (hrmJobHireIssue != null)
				{
					PagingBean pagingBean = this.getPagingBean(request);
					PaginationSupport<ModelHrmJobHireInterview> hireJobInterviews =
							this.serviceHrmJobHireInterview.getPaginationByIssueId(issueId, pagingBean);
					
					request.setAttribute("hireJobInterviews", hireJobInterviews);
					
					// 输出分页信息至客户端
					outWritePagination(request, pagingBean, hireJobInterviews);
					
					return mapping.findForward("hrm.page.job.offer.interview.index");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("应聘信息不存在!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需指定应聘信息才能查看面试记录!"));
			}
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all hire jobs.", e);
			
			return ajaxPrint(response, getErrorCallback("面试分页数据失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 面试记录
	 */
	public ActionForward dialogJobOfferFinalizePage(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String state = request.getParameter("state");
			if (UtilString.isNotEmpty(state))
			{
				String issueId = request.getParameter("issueId");
				if (this.isObjectIdValid(issueId))
				{
					ModelHrmJobHireIssue hrmJobHireIssue = this.serviceHrmJobHireIssue.get(issueId);
					if (hrmJobHireIssue != null)
					{
						request.setAttribute("jobHireIssue", hrmJobHireIssue);
						request.setAttribute("state", state);
						return mapping.findForward("dialog.page.job.offer.finalize");
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("应聘信息不存在!"));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("需指定应聘信息才能进行操作!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("未知应聘操作!"));
			}
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when open the dialog page for job hire operations.", e);
			return ajaxPrint(response, getErrorCallback("应聘操作失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 入职安排与管理
	 */
	public ActionForward hrmPageJobEntryIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String jobId = request.getParameter("jobId");
			if (this.isObjectIdValid(jobId))
			{
				ModelHrmJobHireInfo jobHireInfo = this.serviceHrmJobHireInfo.get(jobId);
				if (jobHireInfo != null)
				{
					request.setAttribute("jobHireInfo", jobHireInfo);
					
					PagingBean pagingBean = this.getPagingBean(request);
					PaginationSupport<ModelHrmJobHireEntry> jobHireEntries = 
							this.serviceHrmJobHireEntry.getPaginationByJobId(jobId, pagingBean);
					
					request.setAttribute("jobHireEntries", jobHireEntries);
					
					// 输出分页信息至客户端
					outWritePagination(request, pagingBean, jobHireEntries);
					
					return mapping.findForward("hrm.page.job.entry.index");
				}
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the job offer page.", e);
		}
		
		return ajaxPrint(response, getErrorCallback("发现异常数据!"));
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 入职安排新增/修改
	 */
	public ActionForward hrmPageJobEntryDetail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		
		try
		{
			String entryId = request.getParameter("entryId");
			if (this.isObjectIdValid(entryId))
			{
				ModelHrmJobHireEntry jobHireEntry = this.serviceHrmJobHireEntry.get(entryId);
				if (jobHireEntry != null)
				{
					request.setAttribute("jobHireEntry", jobHireEntry);
					request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
					request.setAttribute("op", request.getParameter("op"));
					return mapping.findForward("hrm.page.job.entry.detail");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("入职安排信息不存在!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要指定具体的入职信息!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the entry detail page.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
	}
	

	public ServiceBase getServiceBase()
	{
		return serviceBase;
	}

	public void setServiceBase(ServiceBase serviceBase)
	{
		this.serviceBase = serviceBase;
	}
}
