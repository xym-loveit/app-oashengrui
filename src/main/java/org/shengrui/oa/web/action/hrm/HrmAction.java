package org.shengrui.oa.web.action.hrm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.web.action.BaseAppAction;


/**
 * The Human Resource Management web action.
 * 
 * @author Jeccy.Zhao
 * 
 */
public class HrmAction extends BaseAppAction {


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
