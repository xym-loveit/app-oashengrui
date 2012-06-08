package org.shengrui.oa.web.action.hrm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.trymore.core.web.action.BaseAction;

/**
 * The Human Resource Management web action.
 * 
 * @author Jeccy.Zhao
 * 
 */
public class HrmAction extends BaseAction {

	/**
	 * <b>[WebAction]</b> <br/>
	 * 岗位发布与管理
	 */
	public ActionForward hrmJobIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
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
	 * The presentation for hrm entry new action.
	 */
	public ActionForward hrmPageJobDetail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		request.setAttribute("op", request.getParameter("op"));

		return mapping.findForward("hrm.page.job.detail");
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 入职安排与管理
	 */
	public ActionForward hrmPageJobEntryIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		return mapping.findForward("hrm.page.job.entry.index");
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 入职安排新增/修改
	 */
	public ActionForward hrmPageJobEntryDetail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		if (request.getParameter("op") != null) {
			request.setAttribute("op", request.getParameter("op"));
		}

		return mapping.findForward("hrm.page.job.entry.detail");
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 招聘安排与管理
	 */
	public ActionForward hrmPageJobOfferIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		return mapping.findForward("hrm.page.job.offer.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 入职安排新增/修改
	 */
	public ActionForward hrmPageJobOfferDetail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		if (request.getParameter("op") != null) {
			request.setAttribute("op", request.getParameter("op"));
		}

		return mapping.findForward("hrm.page.job.offer.detail");
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 面试记录
	 */
	public ActionForward hrmPageJobOfferInterviewIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		return mapping.findForward("hrm.page.job.offer.interview.index");
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 人才库管理
	 */
	public ActionForward hrmJobResumeIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		return mapping.findForward("hrm.page.job.resume.index");
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 简历查看
	 */
	public ActionForward hrmJobResumeDetail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		request.setAttribute("op", request.getParameter("op"));
		return mapping.findForward("hrm.page.job.resume.detail");
	}
}
