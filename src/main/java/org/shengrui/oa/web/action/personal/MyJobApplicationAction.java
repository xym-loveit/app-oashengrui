package org.shengrui.oa.web.action.personal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;
import org.shengrui.oa.model.hrm.ModelHrmJobHireIssue;
import org.shengrui.oa.model.hrm.ModelHrmResume;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * WebAction: 我要申请
 * 
 * @author Jeccy.Zhao
 *
 */
public class MyJobApplicationAction
extends BaseAppAction
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyJobApplicationAction.class);
	
	/**
	 * The service for job hire information.
	 */
	private ServiceHrmJobHireInfo serviceHrmJobHireInfo;
	
	/**
	 * The service for job hire issue.
	 */
	private ServiceHrmJobHireIssue serviceHrmJobHireIssue;
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 当前招聘
	 */
	public ActionForward pageJobOnHiring (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			PagingBean pagingBean = this.getPagingBean(request);
			
			// 过滤正在招聘中的岗位.
			ModelHrmJobHireInfo entity = new ModelHrmJobHireInfo();
			entity.setIsOpen(ModelHrmJobHireInfo.EJobHireOpen.OPEN.getValue());
			
			PaginationSupport<ModelHrmJobHireInfo> jobHireInfos = 
					 this.serviceHrmJobHireInfo.getPaginationByEntity(entity, pagingBean);
			
			request.setAttribute("entity.list", jobHireInfos);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, jobHireInfos);
			
			// 获取应聘记录, 主要用于标注"应聘","推荐"状态
			PaginationSupport<ModelHrmJobHireIssue> myJobApplications = 
					 this.serviceHrmJobHireIssue.getPaginationByUser(ContextUtil.getCurrentUser().getId(), pagingBean);
			if (myJobApplications != null && myJobApplications.getItemCount() > 0)
			{
				// 封装内部推荐及内部应聘Map
				Map<String, Map<String, Boolean>> applicationMap = new HashMap<String, Map<String,Boolean>>();
				applicationMap.put(ModelHrmResume.EResumeSource.APPLY_INNER.getValue().toString(), 
						new HashMap<String, Boolean>());
				
				// Q: 不可以进行重复推荐?
				//applicationMap.put(ModelHrmResume.EResumeSource.APPLY_RECOMMEND.toString(), 
				//		new HashMap<String, Boolean>());
				
				List<ModelHrmJobHireIssue> applications = myJobApplications.getItems();
				for (ModelHrmJobHireIssue application : applications)
				{
					if (applicationMap.containsKey(application.getResume().getSource().toString()))
					{
						ModelHrmJobHireInfo jobInfo = application.getJobHire();
						if (jobInfo != null )
						{
							applicationMap.get(application.getResume().getSource().toString()).put(jobInfo.getId(), true);
						}
					}
				}
				
				request.setAttribute("myJobApplications", applicationMap);
			}
			
			return mapping.findForward("page.my.jobapplication.index");
			
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the jobs under hiring page.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我的历史应聘
	 */
	public ActionForward pageMyHistoryJobApplication (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelAppUser user = ContextUtil.getCurrentUser();
			if (user != null)
			{
				PagingBean pagingBean = this.getPagingBean(request);
				
				PaginationSupport<ModelHrmJobHireIssue> jobHireIssues = 
						 this.serviceHrmJobHireIssue.getPaginationByUser(user.getId(), pagingBean);
				
				request.setAttribute("entity.list", jobHireIssues);
				
				// 设置历史查看状态
				request.setAttribute("op", "history");
				
				// 输出分页信息至客户端
				outWritePagination(request, pagingBean, jobHireIssues);
				
				return mapping.findForward("page.my.jobapplication.index");
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("用户会话不存在!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the jobs under hiring page.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}

	public ServiceHrmJobHireInfo getServiceHrmJobHireInfo()
	{
		return serviceHrmJobHireInfo;
	}

	public void setServiceHrmJobHireInfo(ServiceHrmJobHireInfo serviceHrmJobHireInfo)
	{
		this.serviceHrmJobHireInfo = serviceHrmJobHireInfo;
	}

	public ServiceHrmJobHireIssue getServiceHrmJobHireIssue()
	{
		return serviceHrmJobHireIssue;
	}

	public void setServiceHrmJobHireIssue(ServiceHrmJobHireIssue serviceHrmJobHireIssue)
	{
		this.serviceHrmJobHireIssue = serviceHrmJobHireIssue;
	}
	
}
