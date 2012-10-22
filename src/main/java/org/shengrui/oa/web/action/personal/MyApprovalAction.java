package org.shengrui.oa.web.action.personal;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.finan.ModelFinanProject;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.service.admin.ServiceConferenceInfo;
import org.shengrui.oa.service.admin.ServiceTaskPlan;
import org.shengrui.oa.service.finan.ServiceFinanContract;
import org.shengrui.oa.service.finan.ServiceFinanExpense;
import org.shengrui.oa.service.finan.ServiceFinanProject;
import org.shengrui.oa.service.hrm.ServiceHrmEmployeeDevelop;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo;
import org.shengrui.oa.service.news.ServiceNewsManage;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.WebActionUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.common.Constants;
import cn.trymore.core.exception.ResourceNotGrantedException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * WebAction: 待我审批
 * 
 * @author intern (unknown name)
 * 
 * @Revision:
 * Author       Date        Comments
 * --------------------------------
 * Jeccy.Zhao | 14/09/2012 | Check-style modified and query updated
 *
 */
public class MyApprovalAction
extends BaseAppAction
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyApprovalAction.class);
	
	/**
	 * The service of job hire information
	 */
	@Resource
	protected ServiceHrmJobHireInfo serviceHrmJobHireInfo;
	
	/**
	 * The service of employee development
	 */
	@Resource
	protected ServiceHrmEmployeeDevelop serviceHrmEmployeeDevelop;
	
	/**
	 * The service of conference
	 */
	@Resource
	protected ServiceConferenceInfo serviceConference;
	
	/**
	 * The service of news management
	 */
	@Resource
	protected ServiceNewsManage serviceNewsManage;
	
	/**
	 * The service of task plan
	 */
	@Resource
	protected ServiceTaskPlan serviceTaskPlan;
	
	/**
	 * The service of financial expense
	 */
	@Resource
	protected ServiceFinanExpense serviceFinanExpense;
	
	/**
	 * The service of financial contract
	 */
	@Resource
	protected ServiceFinanContract serviceFinanContract;
	
	/**
	 * The contract service
	 */
	@Resource
	protected ServiceFinanProject serviceFinanProject;
	
	/**
	 * 待我审批
	 * 
	 * */
	public ActionForward pageMyApproval(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response)
	{
		ModelNewsMag newsInfo = (ModelNewsMag) form;
		ModelTaskPlan taskInfo = (ModelTaskPlan) form;
		ModelFinanExpense finanInfo = (ModelFinanExpense) form;
		ModelFinanContract contractInfo = (ModelFinanContract) form;
		ModelHrmJobHireInfo formJobHireInfo = (ModelHrmJobHireInfo) form;
		ModelHrmEmployeeDevelop formEmployee = (ModelHrmEmployeeDevelop) form;
		
		PagingBean pagingBean = this.getPagingBean(request);
		try 
		{
			//新闻发布审批
			PaginationSupport<ModelNewsMag> news = null;
			try
			{
				news = this.serviceNewsManage.getNewsRec(
					newsInfo, 
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_ADMIN_NEWS.getObject().getKey(),
						WebActionUtil.MENU_ITEM_ADMIN_NEWS.getObject().getObject(),
						ModelNewsMag.class, 
						new String[] {
							"(" + Constants.DEFAULT_TABLE_ALIAS_IN_HIBERNATE + ".status = " + ModelNewsMag.newsStatus.TODO_APPROVE.getValue() + ")"
						}
					),
					pagingBean
				);
			}
			catch (ResourceNotGrantedException e)
			{
				LOGGER.error("Approval items of news failed to fetch.", e);
			}
			
			request.setAttribute("news", news);
			
			// 岗位发布审批 (待总部审批)
			PaginationSupport<ModelHrmJobHireInfo> hireJobs = null;
			try
			{
				hireJobs = this.serviceHrmJobHireInfo.getPaginationByEntity(
						formJobHireInfo, 
						this.getModelDataPolicyQuery(
							WebActionUtil.APPROVAL_HRM_JOB_MASTER.getKey(),
							WebActionUtil.APPROVAL_HRM_JOB_MASTER.getObject(),
							ModelHrmJobHireInfo.class, 
							new String[] {
								"("  + Constants.DEFAULT_TABLE_ALIAS_IN_HIBERNATE + ".status = " + ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue() + ")"
							}
						),
						pagingBean
				);
			}
			catch (ResourceNotGrantedException e)
			{
				LOGGER.error("Approval items of jobs against master failed to fetch.", e);
			}
			
			// 岗位发布审批 (待校区审批)
			PaginationSupport<ModelHrmJobHireInfo> hireJobsZone = null;
			try
			{
				hireJobsZone = this.serviceHrmJobHireInfo.getPaginationByEntity(
					formJobHireInfo, 
					this.getModelDataPolicyQuery(
						WebActionUtil.APPROVAL_HRM_JOB_ZOON.getKey(),
						WebActionUtil.APPROVAL_HRM_JOB_ZOON.getObject(),
						ModelHrmJobHireInfo.class, 
						new String[] {
							"("  + Constants.DEFAULT_TABLE_ALIAS_IN_HIBERNATE + ".status = " + ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue() + ")"
						}
					),
					pagingBean
				);
			}
			catch (ResourceNotGrantedException e)
			{
				LOGGER.error("Approval items of jobs against zone failed to fetch.", e);
			}
			
			if (hireJobs == null)
			{
				hireJobs = hireJobsZone;
			}
			else if (hireJobsZone != null)
			{
				hireJobs.getItems().addAll(hireJobsZone.getItems());
			}
			
			request.setAttribute("hireJobs", hireJobs);
			
			//任务委托审批
			PaginationSupport<ModelTaskPlan> task = null;
			try
			{
				task = this.serviceTaskPlan.getTaskPlanApproval(
					taskInfo,
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_ADMIN_TASK.getObject().getKey(),
						WebActionUtil.MENU_ITEM_ADMIN_TASK.getObject().getObject(),
						ModelTaskPlan.class, 
						new String[] {
							"(approval_status = " + ModelTaskPlan.ETaskApprovalStatus.TOAPPROVE.getValue() + " OR approval_status IS NULL)"
						}
					),
					pagingBean
				);
			}
			catch (ResourceNotGrantedException e)
			{
				LOGGER.error("Approval items of task against master failed to fetch.", e);
			}
			
			request.setAttribute("task", task);
			
			//财务审批
			PaginationSupport<ModelFinanExpense> finan = null;
			try
			{
				finan = this.serviceFinanExpense.getfinanApproval(
					finanInfo, 
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_FINA_EXPENSE.getObject().getKey(),
						WebActionUtil.MENU_ITEM_FINA_EXPENSE.getObject().getObject(),
						ModelFinanExpense.class, 
						new String[] {
							"(audit_state IS NULL and cproc_depid = " + 
							ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
							ContextUtil.getCurrentUser().getPositionId() + " and " +
							"(cproc_disid = " + 
								ContextUtil.getCurrentUser().getDistrictId() + "))"
						}, 
						false
					),
					pagingBean
				);
			}
			catch (ResourceNotGrantedException e)
			{
				LOGGER.error("Approval items of financial failed to fetch.", e);
			}
			
			request.setAttribute("finan", finan);
			
			//合同审批
			PaginationSupport<ModelFinanContract> contract = null;
			try
			{
				contract = this.serviceFinanContract.finanContract(
					contractInfo,
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_FINA_CONTRACT.getObject().getKey(),
						WebActionUtil.MENU_ITEM_FINA_CONTRACT.getObject().getObject(),
						ModelFinanContract.class, 
						new String[] {
							"(audit_state IS NULL and cproc_depid = " + 
							ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
							ContextUtil.getCurrentUser().getPositionId() + " and " +
							"(cproc_disid = " + 
								ContextUtil.getCurrentUser().getPositionId() + "))"
						}, 
						false
					),
					pagingBean
				);
			}
			catch (ResourceNotGrantedException e)
			{
				LOGGER.error("Approval items of contract failed to fetch.", e);
			}
			
			request.setAttribute("contract", contract);
			
			//晋升申请审批
			PaginationSupport<ModelHrmEmployeeDevelop> items = null;
			try
			{
				items = this.serviceHrmEmployeeDevelop.getfinanHr(
					formEmployee,
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_HRM_DEVELOP.getObject().getKey(),
						WebActionUtil.MENU_ITEM_HRM_DEVELOP.getObject().getObject(),
						ModelHrmEmployeeDevelop.class, 
						new String[] {
							"(audit_state IS NULL and cproc_depid = " + 
							ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
							ContextUtil.getCurrentUser().getPositionId() + " and " +
							"(cproc_disid = " + 
								ContextUtil.getCurrentUser().getDistrictId() + "))"
						}, 
						false
					),
					pagingBean
				);
			}
			catch (ResourceNotGrantedException e)
			{
				LOGGER.error("Approval items of HRM develop failed to fetch.", e);
			}
			
			request.setAttribute("dataList", items);
			
			// 新项目申请审批
			PaginationSupport<ModelFinanProject> projects = null;
			try
			{
				projects = this.serviceFinanProject.getByQuery(
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_FINA_PROJECT.getObject().getKey(),
						WebActionUtil.MENU_ITEM_FINA_PROJECT.getObject().getObject(),
						ModelFinanProject.class, 
						new String[] {
							"(audit_state IS NULL and cproc_depid = " + 
							ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
							ContextUtil.getCurrentUser().getPositionId() + " and " +
							"(cproc_disid = " + 
								ContextUtil.getCurrentUser().getDistrictId() + "))"
						}, 
						false
					),
					pagingBean
				);
			}
			catch (ResourceNotGrantedException e)
			{
				LOGGER.error("Approval items of projects failed to fetch.", e);
			}
			
			request.setAttribute("projects", projects);
			
			if (request.getParameter("objOut") != null)
			{
				try 
				{
					response.getWriter().write(ObjectToString(news));
					response.getWriter().write(ObjectToString1(task));
					response.getWriter().write(ObjectToString2(finan));
					response.getWriter().write(ObjectToString3(contract));
					response.getWriter().write(ObjectToString4(hireJobs));
					response.getWriter().write(ObjectToString5(items));
					response.getWriter().write(ObjectToString6(projects));
					return null;
				} 
				catch (IOException e) 
				{
					LOGGER.error("Exception raised when writing string to response", e);
				}
			}
			
			request.setAttribute("op", request.getParameter("op"));
		} 
		catch (ServiceException e) 
		{
			LOGGER.error("Exception raised when fetching approval data set", e);
		}
		return mapping.findForward("page.my.approval.index");
	}
	
	/**
	 * 审批记录
	 * 
	 * */
	public ActionForward pageMyApprovalRecord(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response)
	{
		ModelNewsMag newsRec = (ModelNewsMag) form;
		ModelTaskPlan taskRec = (ModelTaskPlan) form;
		ModelFinanExpense finanRec = (ModelFinanExpense) form;
		ModelFinanContract contractRec = (ModelFinanContract) form;
		ModelHrmJobHireInfo formJobHireInfo = (ModelHrmJobHireInfo) form;
		ModelHrmEmployeeDevelop formEmployee = (ModelHrmEmployeeDevelop) form;
		
		PagingBean pagingBean = this.getPagingBean(request);
		try 
		{
			//新闻发布审批
			PaginationSupport<ModelNewsMag> news = 
				this.serviceNewsManage.getNewsApprovalRec(newsRec, pagingBean);
			request.setAttribute("newsinfo", news);
			
			//任务委托审批
			PaginationSupport<ModelTaskPlan> taskInfo =
				this.serviceTaskPlan.getTaskPlanApprovalRec(taskRec, pagingBean);
			request.setAttribute("taskInfo", taskInfo);
			
			//费用支出申请审批
			PaginationSupport<ModelFinanExpense> finanInfo =
				this.serviceFinanExpense.getfinanApprovalRec(finanRec, pagingBean);
			request.setAttribute("finanInfo", finanInfo);
			
			//合同审批
			PaginationSupport<ModelFinanContract> contractInfo = 
				this.serviceFinanContract.finanContractRec(contractRec, pagingBean);
			request.setAttribute("contractInfo", contractInfo);
			
			//岗位发布审批
			PaginationSupport<ModelHrmJobHireInfo> hireJobsInfo = 
				this.serviceHrmJobHireInfo.getPaginationByEntity(formJobHireInfo, pagingBean);
			request.setAttribute("hireJobsInfo", hireJobsInfo);
			
			//晋升申请审批
			PaginationSupport<ModelHrmEmployeeDevelop> items =
				this.serviceHrmEmployeeDevelop.getfinanHrRec(formEmployee, pagingBean);
			request.setAttribute("dataList", items);
		
			request.setAttribute("op", request.getParameter("op"));
		} 
		catch (ServiceException e) 
		{
			LOGGER.error("Exception raised when fetching approval data set", e);
		}
		return mapping.findForward("page.my.approvalReturn.index");
	}
	
	private String ObjectToString(PaginationSupport<ModelNewsMag> list)
	{
		StringBuffer sb =new StringBuffer();
		if(list != null)
		{
			for (ModelNewsMag news : list.getItems()) 
			{
				sb.append("<tr alt='news'><td style=\"display: none;\">");
				sb.append(news.getId()+"</td><td style='text-align:left'>");
				sb.append("["+ news.getDictionary().getName() + "]"+"”" + news.getNewsSubject()+"“"+ "新闻发布审批"+"</td>");
				sb.append("<td>"+news.getUser().getFullName()+"</td><td>");
				sb.append(news.getUpdateTime()+"</td></tr>");
				
			}
			return sb.toString();
		}
		return "";
	}
	
	private String ObjectToString1(PaginationSupport<ModelTaskPlan> list)
	{
		StringBuffer sb =new StringBuffer();
		if(list != null)
		{
			for (ModelTaskPlan task : list.getItems()) 
			{
				sb.append("<tr alt='task'><td style=\"display: none;\">");
				sb.append(task.getId()+"</td><td style='text-align:left'>");
				sb.append("["+task.getTaskType().getName()+"]"+ "”" + task.getTaskName() + "“"+ " 任务委托发布审批"+"</td>");
				sb.append("<td>"+task.getTaskOriginator().getEmpName()+"</td><td>");
				sb.append(task.getCreateTime()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
	private String ObjectToString2(PaginationSupport<ModelFinanExpense> list)
	{
		StringBuffer sb =new StringBuffer();
		if(list != null)
		{
			for (ModelFinanExpense finan : list.getItems()) 
			{
				sb.append("<tr alt='fina-expense'><td style=\"display: none;\">");
				sb.append(finan.getId()+"</td><td style='text-align:left'>");
				sb.append(finan.getEmployee().getEmpName()+" "+ "<label style='color:red;'>"+finan.getEmpDistrict().getDistrictName()+"</label>&nbsp&nbsp&nbsp<label style='color:red;'>"+finan.getApplyAmt()+"</label>");
				sb.append("<td>"+finan.getEmployee().getEmpName()+"</td><td>");
				sb.append(finan.getApplyDate()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
	private String ObjectToString3(PaginationSupport<ModelFinanContract> list)
	{
		StringBuffer sb =new StringBuffer();
		if(list != null)
		{
			for (ModelFinanContract contract : list.getItems()) 
			{
				sb.append("<tr alt='fina-contract'><td style=\"display: none;\">");
				sb.append(contract.getId()+"</td><td style='text-align:left'>");
				sb.append("["+contract.getEmployee().getEmpName()+"]"+" "+ contract.getEmpDistrict().getDistrictName()+" "+contract.getApplyFormType().getProcessTypeName());
				sb.append("<td>"+contract.getEmployee().getEmpName()+"</td><td>");
				sb.append(contract.getApplyDate()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
	private String ObjectToString4(PaginationSupport<ModelHrmJobHireInfo> list)
	{
		StringBuffer sb =new StringBuffer();
		if(list != null)
		{
			for (ModelHrmJobHireInfo hrm : list.getItems()) 
			{
				sb.append("<tr alt='hrm'><td style=\"display: none;\">");
				sb.append(hrm.getId()+"</td><td style='text-align:left'>");
				sb.append("["+ hrm.getJobHireDepartment().getDepName()+" "+ hrm.getJobHireDistrict().getDistrictName()+"]" +"”"+hrm.getJobHireTitle()+"“" +"招聘");
				sb.append("<td>"+hrm.getPostAuthorName()+"</td><td>");
				sb.append(hrm.getPostDate()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
	private String ObjectToString5(PaginationSupport<ModelHrmEmployeeDevelop> list)
	{
		StringBuffer sb =new StringBuffer();
		if(list != null)
		{
			for (ModelHrmEmployeeDevelop entry : list.getItems()) 
			{
				sb.append("<tr alt='hrm'><td style=\"display: none;\">");
				sb.append(entry.getId()+"</td><td style='text-align:left'>");
				sb.append(entry.getEmployee().getEmpName() + entry.getApplyFormType().getProcessTypeName());
				sb.append("<td>"+entry.getEmployee().getEmpName()+"</td><td>");
				sb.append(entry.getApplyDate()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
	private String ObjectToString6(PaginationSupport<ModelFinanProject> list)
	{
		StringBuffer sb =new StringBuffer();
		if(list != null)
		{
			for (ModelFinanProject project : list.getItems()) 
			{
				sb.append("<tr alt='fina-project'><td style=\"display: none;\">");
				sb.append(project.getId()+"</td><td style='text-align:left'>");
				sb.append("["+project.getEmployee().getEmpName()+"]"+" "+ project.getEmpDistrict().getDistrictName()+" "+project.getApplyFormType().getProcessTypeName());
				sb.append("<td>"+project.getEmployee().getEmpName()+"</td><td>");
				sb.append(project.getApplyDate()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
	public ServiceHrmJobHireInfo getServiceHrmJobHireInfo() {
		return serviceHrmJobHireInfo;
	}

	public void setServiceHrmJobHireInfo(ServiceHrmJobHireInfo serviceHrmJobHireInfo) {
		this.serviceHrmJobHireInfo = serviceHrmJobHireInfo;
	}

	public ServiceHrmEmployeeDevelop getServiceHrmEmployeeDevelop() {
		return serviceHrmEmployeeDevelop;
	}

	public void setServiceHrmEmployeeDevelop(
			ServiceHrmEmployeeDevelop serviceHrmEmployeeDevelop) {
		this.serviceHrmEmployeeDevelop = serviceHrmEmployeeDevelop;
	}
	
	public ServiceConferenceInfo getServiceConference() {
		return serviceConference;
	}

	public void setServiceConference(ServiceConferenceInfo serviceConference) {
		this.serviceConference = serviceConference;
	}

	public ServiceTaskPlan getServiceTaskPlan() {
		return serviceTaskPlan;
	}

	public void setServiceTaskPlan(ServiceTaskPlan serviceTaskPlan) {
		this.serviceTaskPlan = serviceTaskPlan;
	}

	public ServiceFinanExpense getServiceFinanExpense() {
		return serviceFinanExpense;
	}

	public void setServiceFinanExpense(ServiceFinanExpense serviceFinanExpense) {
		this.serviceFinanExpense = serviceFinanExpense;
	}

	public ServiceFinanContract getServiceFinanContract() {
		return serviceFinanContract;
	}

	public void setServiceFinanContract(ServiceFinanContract serviceFinanContract) {
		this.serviceFinanContract = serviceFinanContract;
	}
	
	public ServiceNewsManage getServiceNewsManage() {
		return serviceNewsManage;
	}

	public void setServiceNewsManage(ServiceNewsManage serviceNewsManage) {
		this.serviceNewsManage = serviceNewsManage;
	}
	
	public ServiceFinanProject getServiceFinanProject()
	{
		return serviceFinanProject;
	}

	public void setServiceFinanProject(ServiceFinanProject serviceFinanProject)
	{
		this.serviceFinanProject = serviceFinanProject;
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
}
