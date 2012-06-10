package org.shengrui.oa.web.action.hrm;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;
import org.shengrui.oa.model.hrm.ModelHrmJobHireIssue;
import org.shengrui.oa.model.hrm.ModelHrmResume;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInterview;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue;
import org.shengrui.oa.service.hrm.ServiceHrmResume;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;
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
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(HrmHireAction.class);
			
	/**
	 * The job hire service.
	 */
	private ServiceHrmJobHireInfo serviceHrmJobHireInfo;
	
	/**
	 * The resume service.
	 */
	private ServiceHrmResume serviceHrmResume;
	
	/**
	 * The job hire issue service.
	 */
	private ServiceHrmJobHireIssue serviceHrmJobHireIssue;
	
	/**
	 * The job interview service.
	 */
	private ServiceHrmJobHireInterview serviceJobHireInterview;
	
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
					this.serviceHrmJobHireInfo.getHireJobPagination(formJobHireInfo, pagingBean);
			
			request.setAttribute("hireJobs", hireJobs);
			request.setAttribute("hireJobForm", formJobHireInfo);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, hireJobs);
			
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
			HttpServletResponse response) {
		return mapping.findForward("hrm.page.job.approval.index");
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
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when fetch resume with id:" + resumeId, e);
				return ajaxPrint(response, getErrorCallback("简历获取失败:" + e.getMessage()));
			}
		}
		
		// 输出请求参数至页面.
		this.getRequestQueryString(request, null, true);
		
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
				
				request.setAttribute("jobHire", jobHireInfo);
			}
			
			request.setAttribute("districts", this.getAllDistricts());
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
			}
			
			if (isCreation)
			{
				entity.setStatus(ModelHrmJobHireInfo.EJobHireStatus.TODO.getValue());
				entity.setPostDate(new Date());
				if (ContextUtil.getCurrentUser() != null)
				{
					entity.setPostAuthorName(ContextUtil.getCurrentUser().getFullName());
				}
			}
			
			String districtId = request.getParameter("jobHireDistrictId");
			if (this.isObjectIdValid(districtId) && (entity.getJobHireDistrict() == null || 
					!entity.getJobHireDistrict().getId().equals(districtId)))
			{
				entity.setJobHireDistrict(this.serviceSchoolDistrict.get(districtId));
			}
			
			String depId = request.getParameter("jobHireDepartmentId");
			if (this.isObjectIdValid(depId) && (entity.getJobHireDepartment() == null || 
					!entity.getJobHireDepartment().getId().equals(depId)))
			{
				entity.setJobHireDepartment(this.serviceSchoolDepartment.get(depId));
			}
			
			String districtVisibleId = request.getParameter("jobHireVisibleDistrictId");
			if (this.isObjectIdValid(districtVisibleId) && (entity.getJobHireVisibleDistrict() == null || 
					!entity.getJobHireVisibleDistrict().getId().equals(districtVisibleId)))
			{
				entity.setJobHireVisibleDistrict(this.serviceSchoolDistrict.get(districtVisibleId));
			}
			
			this.serviceHrmJobHireInfo.save(entity);
			
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
					
					// 输出分页信息至客户端
					outWritePagination(request, pagingBean, jobHireIssues);

					return mapping.findForward("hrm.page.job.offer.index");
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
					if (request.getParameter("source") != null && 
							UtilString.isNumeric(request.getParameter("source")))
					{
						formResume.setSource(Integer.parseInt(request.getParameter("source")));
					}

					this.serviceHrmResume.save(formResume);
					
					ModelHrmJobHireIssue jobHireIssue = new ModelHrmJobHireIssue();
					jobHireIssue.setResume(formResume);
					jobHireIssue.setJobHire(jobHireInfo);
					jobHireIssue.setCurrentStatus(ModelHrmJobHireIssue.EJobHireIssueStatus.TOPLAN.getValue());
					jobHireIssue.setApplyDateTime(new Date());
					
					this.serviceHrmJobHireIssue.save(jobHireIssue);
					
					// 保存成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("岗位应聘成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when apply job.", e);
		}
		
		return ajaxPrint(response, getErrorCallback("岗位应聘失败."));
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
				ModelHrmJobHireIssue jobHireIssue = this.serviceHrmJobHireIssue.get(issueId);
				if (jobHireIssue != null)
				{
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
							
							this.serviceJobHireInterview.save(jobHireInterview);
							
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
		return mapping.findForward("hrm.page.job.offer.interview.index");
	}
	
	public ServiceHrmJobHireInfo getServiceHrmJobHireInfo()
	{
		return serviceHrmJobHireInfo;
	}

	public void setServiceHrmJobHireInfo(ServiceHrmJobHireInfo serviceHrmJobHireInfo)
	{
		this.serviceHrmJobHireInfo = serviceHrmJobHireInfo;
	}

	public ServiceHrmResume getServiceHrmResume()
	{
		return serviceHrmResume;
	}

	public void setServiceHrmResume(ServiceHrmResume serviceHrmResume)
	{
		this.serviceHrmResume = serviceHrmResume;
	}

	public ServiceHrmJobHireIssue getServiceHrmJobHireIssue()
	{
		return serviceHrmJobHireIssue;
	}

	public void setServiceHrmJobHireIssue(ServiceHrmJobHireIssue serviceHrmJobHireIssue)
	{
		this.serviceHrmJobHireIssue = serviceHrmJobHireIssue;
	}

	public ServiceHrmJobHireInterview getServiceJobHireInterview()
	{
		return serviceJobHireInterview;
	}

	public void setServiceJobHireInterview(ServiceHrmJobHireInterview serviceJobHireInterview)
	{
		this.serviceJobHireInterview = serviceJobHireInterview;
	}
	
}
