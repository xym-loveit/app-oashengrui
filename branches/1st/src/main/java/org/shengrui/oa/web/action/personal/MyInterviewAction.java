package org.shengrui.oa.web.action.personal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;
import org.shengrui.oa.model.hrm.ModelHrmJobHireIssue;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInterview;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.WebActionUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * WebAction: 我做伯乐
 * 
 * @author Jeccy.Zhao
 *
 */
public class MyInterviewAction
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyInterviewAction.class);
	
	/**
	 * The service for job hire interview
	 */
	private ServiceHrmJobHireInterview serviceHrmJobHireInterview;
	
	/**
	 * The service for job hire issue.
	 */
	private ServiceHrmJobHireIssue serviceHrmJobHireIssue;
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 待面试记录
	 */
	public ActionForward pageMyInterviewToDo (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			PagingBean pagingBean = this.getPagingBean(request);
			
			PaginationSupport<ModelHrmJobHireInterview> interviews = 
					this.getMyInterviewsByStatus(
							new Integer[] 
							{ 
								ModelHrmJobHireInterview.EInterviewState.TODO.getValue(), 
								ModelHrmJobHireInterview.EInterviewState.ONGING.getValue()
							}, 
							pagingBean);
			
			request.setAttribute("interviews", interviews);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, interviews);
			
			return mapping.findForward("page.my.interview.index");
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open my interview TODO page.", e);
			return ajaxPrint(response, getErrorCallback(e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 面试历史记录
	 */
	public ActionForward pageMyInterviewHistory (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			PagingBean pagingBean = this.getPagingBean(request);
			
			PaginationSupport<ModelHrmJobHireInterview> interviews = 
					this.getMyInterviewsByStatus(
							new Integer[] 
							{ 
								ModelHrmJobHireInterview.EInterviewState.ABSENCE.getValue(), 
								ModelHrmJobHireInterview.EInterviewState.PASSED.getValue(),
								ModelHrmJobHireInterview.EInterviewState.ELIMINATED.getValue()
							}, 
							pagingBean);
			
			request.setAttribute("interviews", interviews);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, interviews);
			
			// 设置历史查看状态
			request.setAttribute("op", "history");
			
			return mapping.findForward("page.my.interview.index");
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open my interview TODO page.", e);
			
			return ajaxPrint(response, getErrorCallback(e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 面试意见弹框
	 */
	public ActionForward dialogInterviewCommentPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String interviewId = request.getParameter("id");
			if (this.isObjectIdValid(interviewId))
			{
				String issueId = request.getParameter("issueId");
				
				if (this.isObjectIdValid(issueId))
				{
					ModelHrmJobHireIssue jobHireIssue = this.serviceHrmJobHireIssue.get(issueId);
					if (jobHireIssue != null)
					{
						PagingBean pagingBean = this.getPagingBean(request);
						
						PaginationSupport<ModelHrmJobHireInterview> hireJobInterviews =
								this.serviceHrmJobHireInterview.getPaginationByIssueId(issueId, pagingBean);
						
						request.setAttribute("hireJobInterviews", hireJobInterviews);
						request.setAttribute("jobHireIssue", jobHireIssue);
						request.setAttribute("interviewId", interviewId);
						
						// 输出分页信息至客户端
						outWritePagination(request, pagingBean, hireJobInterviews);
						
						return mapping.findForward("dialog.my.interview.comment.page");
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("应聘信息不存在!"));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("需要传入应聘ID才能打开面试窗口."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("非法面试ID信息被传入."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the interview window.", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 面试意见保存
	 */
	public ActionForward actionDoComment (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		try
		{
			String interviewId = request.getParameter("interviewId");
			if (this.isObjectIdValid(interviewId))
			{
				ModelHrmJobHireInterview jobHireInterview = this.serviceHrmJobHireInterview.get(interviewId);
				if (jobHireInterview != null)
				{
					Integer interviewStatus = Integer.parseInt(request.getParameter("interviewStatus"));
					String interviewComments = request.getParameter("interviewComments");
					
					jobHireInterview.setInterviewStatus(interviewStatus);
					jobHireInterview.setInterviewComments(interviewComments);
					
					if (interviewStatus.equals(ModelHrmJobHireInterview.EInterviewState.ABSENCE.getValue()) || 
							interviewStatus.equals(ModelHrmJobHireInterview.EInterviewState.ELIMINATED.getValue()))
					{
						// 当面试被淘汰或者未到时, 设置应聘状态为待处理
						jobHireInterview.getJobHireIssue().setCurrentStatus(ModelHrmJobHireIssue.EJobHireIssueStatus.TODO.getValue());
					}
					else if (interviewStatus.equals(ModelHrmJobHireInterview.EInterviewState.PASSED.getValue()))
					{
						// 当面试被淘汰或者未到时, 设置应聘状态为待安排
						jobHireInterview.getJobHireIssue().setCurrentStatus(ModelHrmJobHireIssue.EJobHireIssueStatus.TOPLAN.getValue());
					}
					
					// 设置面试附件
					this.handleFileAttachments(jobHireInterview, request);
					
					this.serviceHrmJobHireInterview.save(jobHireInterview);
					
					// 推送至客户端, 进行数字提醒更新.
					this.messagePush.pushMessage(
						jobHireInterview.getInterviewer().getEmployee().getId(), 
						WebActionUtil.scriptMessageNotify, 
						WebActionUtil.MENU_ITEM_INTERVIEW_COMMIT.getKey(),
						-1
					);
					
					// 保存后关闭dialog页面并刷新navTab.
					return ajaxPrint(response, 
							getSuccessCallback("面试意见提交成功!", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("当前面试信息不存在!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("非法面试ID信息被传入."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when do save the interview comment.", e);
			
			return ajaxPrint(response, getErrorCallback("面试意见保存失败:" + e.getMessage()));
		}
	}
	
	/**
	 * Obtains my interviews with the specified status.
	 * 
	 * @param status
	 * @return
	 */
	private PaginationSupport<ModelHrmJobHireInterview> getMyInterviewsByStatus (
			Integer[] status, PagingBean pagingBean) throws Exception
	{
		ModelAppUser user = ContextUtil.getCurrentUser();
		if (user != null)
		{
			try
			{
				return this.serviceHrmJobHireInterview.getPaginationByInterviewerAndStatus(
						user.getId(), status, pagingBean);
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when obtaining the interview with owner and status.", e);
				
				throw new Exception(e);
			}
		}
		else
		{
			throw new Exception("用户Session不存在, 请登录后再进行操作.");
		}
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
	
	public ServiceHrmJobHireIssue getServiceHrmJobHireIssue()
	{
		return serviceHrmJobHireIssue;
	}

	public void setServiceHrmJobHireIssue(
			ServiceHrmJobHireIssue serviceHrmJobHireIssue)
	{
		this.serviceHrmJobHireIssue = serviceHrmJobHireIssue;
	}

	public ServiceHrmJobHireInterview getServiceHrmJobHireInterview()
	{
		return serviceHrmJobHireInterview;
	}

	public void setServiceHrmJobHireInterview(ServiceHrmJobHireInterview serviceHrmJobHireInterview)
	{
		this.serviceHrmJobHireInterview = serviceHrmJobHireInterview;
	}
	
}
