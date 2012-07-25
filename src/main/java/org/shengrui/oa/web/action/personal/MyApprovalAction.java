package org.shengrui.oa.web.action.personal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.news.ModelNewsMag;
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
			request.setAttribute("op", request.getParameter("op"));
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapping.findForward("page.my.approvalReturn.index");
	}
	
}
