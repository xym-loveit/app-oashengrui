package org.shengrui.oa.web.action.personal;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.service.hrm.ServiceHrmEmployeeDevelop;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * WebAction: 待我审批
 * 
 * @author Jeccy.Zhao
 *
 */
public class MyApprovalAction
extends BaseAppAction
{

	protected ServiceHrmJobHireInfo serviceHrmJobHireInfo;
	protected ServiceHrmEmployeeDevelop serviceHrmEmployeeDevelop;
	
	/**
	 * 首页显示待我审批信息
	 * 
	 * */
	public ActionForward pageMyApproval1(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response
	){
		ModelNewsMag newsInfo = (ModelNewsMag) form;
		ModelTaskPlan taskInfo = (ModelTaskPlan) form;
		ModelFinanExpense finanInfo = (ModelFinanExpense) form;
		ModelFinanContract contractInfo = (ModelFinanContract) form;
		ModelHrmJobHireInfo formJobHireInfo = (ModelHrmJobHireInfo) form;
		ModelHrmEmployeeDevelop formEmployee = (ModelHrmEmployeeDevelop) form;
		
		PagingBean pagingBean = this.getPagingBean1(request);
		try {
			//新闻发布审批
			PaginationSupport<ModelNewsMag> news = 
				this.serviceNewsManage.getNewsRec(newsInfo, pagingBean);
			request.setAttribute("news", news);
			//任务委托审批
			PaginationSupport<ModelTaskPlan> task = 
				this.serviceTaskPlan.getTaskPlanApproval(taskInfo,pagingBean);
			request.setAttribute("task", task);
			//财务审批
			PaginationSupport<ModelFinanExpense> finan = 
				this.serviceFinanExpense.getfinanApproval(finanInfo, pagingBean);
			request.setAttribute("finan", finan);
			//合同审批
			PaginationSupport<ModelFinanContract> contract = 
				this.serviceFinanContract.finanContract(contractInfo, pagingBean);
			request.setAttribute("contract", contract);
			//岗位发布审批
			PaginationSupport<ModelHrmJobHireInfo> hireJobs = 
				this.serviceHrmJobHireInfo.getPaginationByEntity(formJobHireInfo, pagingBean);
			request.setAttribute("hireJobs", hireJobs);
			//晋升申请审批
			PaginationSupport<ModelHrmEmployeeDevelop> items =
				this.serviceHrmEmployeeDevelop.getfinanHr(formEmployee, pagingBean);
		    request.setAttribute("dataList", items);
			
			request.setAttribute("op", request.getParameter("op"));
			try {
				response.getWriter().write(ObjectToString(news));
				response.getWriter().write(ObjectToString1(task));
				response.getWriter().write(ObjectToString2(finan));
				response.getWriter().write(ObjectToString3(contract));
				response.getWriter().write(ObjectToString4(hireJobs));
				response.getWriter().write(ObjectToString5(items));
			} catch (IOException e) { 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	private String ObjectToString(PaginationSupport<ModelNewsMag> list){
		StringBuffer sb =new StringBuffer();
		if(list != null){
			for (ModelNewsMag news : list.getItems()) {
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
	private String ObjectToString1(PaginationSupport<ModelTaskPlan> list){
		StringBuffer sb =new StringBuffer();
		if(list != null){
			for (ModelTaskPlan task : list.getItems()) {
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
	private String ObjectToString2(PaginationSupport<ModelFinanExpense> list){
		StringBuffer sb =new StringBuffer();
		if(list != null){
			for (ModelFinanExpense finan : list.getItems()) {
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
	private String ObjectToString3(PaginationSupport<ModelFinanContract> list){
		StringBuffer sb =new StringBuffer();
		if(list != null){
			for (ModelFinanContract contract : list.getItems()) {
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
	private String ObjectToString4(PaginationSupport<ModelHrmJobHireInfo> list){
		StringBuffer sb =new StringBuffer();
		if(list != null){
			for (ModelHrmJobHireInfo hrm : list.getItems()) {
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
	private String ObjectToString5(PaginationSupport<ModelHrmEmployeeDevelop> list){
		StringBuffer sb =new StringBuffer();
		if(list != null){
			for (ModelHrmEmployeeDevelop entry : list.getItems()) {
				sb.append("<tr alt='job'><td style=\"display: none;\">");
				sb.append(entry.getId()+"</td><td style='text-align:left'>");
				sb.append(entry.getEmployee().getEmpName()+"岗位"+StrToString(entry.getApplyFormType().getId()));
				sb.append("<td>"+entry.getEmployee().getEmpName()+"</td><td>");
				sb.append(entry.getApplyDate()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
	private String StrToString(String status){
		String statu="";
		if("3"==status){
			statu="转正申请";
		}else if("4"==status){
			statu="调动申请";
		}else if("5"== status){
			statu="晋升申请";
		}else if("6"== status){
			statu="离职申请";
		}
		return statu;
	}
	
	/**
	 * 待我审批
	 * 
	 * */
	public ActionForward pageMyApproval(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response
	){
		ModelNewsMag newsInfo = (ModelNewsMag) form;
		ModelTaskPlan taskInfo = (ModelTaskPlan) form;
		ModelFinanExpense finanInfo = (ModelFinanExpense) form;
		ModelFinanContract contractInfo = (ModelFinanContract) form;
		ModelHrmJobHireInfo formJobHireInfo = (ModelHrmJobHireInfo) form;
		ModelHrmEmployeeDevelop formEmployee = (ModelHrmEmployeeDevelop) form;
		
		PagingBean pagingBean = this.getPagingBean(request);
		try {
			//新闻发布审批
			PaginationSupport<ModelNewsMag> news = 
				this.serviceNewsManage.getNewsRec(newsInfo, pagingBean);
			request.setAttribute("news", news);
			//任务委托审批
			PaginationSupport<ModelTaskPlan> task = 
				this.serviceTaskPlan.getTaskPlanApproval(taskInfo,pagingBean);
			request.setAttribute("task", task);
			//财务审批
			PaginationSupport<ModelFinanExpense> finan = 
				this.serviceFinanExpense.getfinanApproval(finanInfo, pagingBean);
			request.setAttribute("finan", finan);
			//合同审批
			PaginationSupport<ModelFinanContract> contract = 
				this.serviceFinanContract.finanContract(contractInfo, pagingBean);
			request.setAttribute("contract", contract);
			//岗位发布审批
			PaginationSupport<ModelHrmJobHireInfo> hireJobs = 
				this.serviceHrmJobHireInfo.getPaginationByEntity(formJobHireInfo, pagingBean);
			request.setAttribute("hireJobs", hireJobs);
			//晋升申请审批
			PaginationSupport<ModelHrmEmployeeDevelop> items =
				this.serviceHrmEmployeeDevelop.getfinanHr(formEmployee, pagingBean);
		    request.setAttribute("dataList", items);
			
			request.setAttribute("op", request.getParameter("op"));
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapping.findForward("page.my.approval.index");
	}
	
	/**
	 * 审批记录
	 * 
	 * */
	public ActionForward pageMyApprovalRecord(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response
	){
		ModelNewsMag newsRec = (ModelNewsMag) form;
		ModelTaskPlan taskRec = (ModelTaskPlan) form;
		ModelFinanExpense finanRec = (ModelFinanExpense) form;
		ModelFinanContract contractRec = (ModelFinanContract) form;
		ModelHrmJobHireInfo formJobHireInfo = (ModelHrmJobHireInfo) form;
		ModelHrmEmployeeDevelop formEmployee = (ModelHrmEmployeeDevelop) form;
		
		PagingBean pagingBean = this.getPagingBean(request);
		try {
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
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapping.findForward("page.my.approvalReturn.index");
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
	
}
