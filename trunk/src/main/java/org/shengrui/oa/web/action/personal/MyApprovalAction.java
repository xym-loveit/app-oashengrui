package org.shengrui.oa.web.action.personal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
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
		PagingBean pagingBean = this.getPagingBean(request);
		try {
			PaginationSupport<ModelNewsMag> news = 
				this.serviceNewsManage.getNewsRec(newsInfo, pagingBean);
			request.setAttribute("news", news);
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

		return mapping.findForward("page.my.approvalReturn.index");
	}
	
}
