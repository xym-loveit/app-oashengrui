package org.shengrui.oa.web.action.hrm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmArchive;

import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 公司人才库
 * 
 * @author Jeccy.Zhao
 *
 */
public class HrmArchiveAction
extends BaseHrmAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(HrmArchiveAction.class);
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 人才库管理
	 */
	public ActionForward hrmJobResumeIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response)
	{
		
		try
		{
			ModelHrmArchive formArchive = (ModelHrmArchive) form;
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelHrmArchive> archives =
					this.serviceHrmArchive.getPaginationByEntity(formArchive, pagingBean);
			
			request.setAttribute("archives", archives);
			request.setAttribute("formArchive", formArchive);
			
			// 获取所有校区数据
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, archives);
			
			return mapping.findForward("hrm.page.job.resume.index");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("人才库数据数据加载失败:" + e.getMessage()));
		}
	}

	/**
	 * <b>[WebAction]</b> <br/>
	 * 简历查看
	 */
	public ActionForward hrmJobResumeDetail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response)
	{
		request.setAttribute("op", request.getParameter("op"));
		return mapping.findForward("hrm.page.job.resume.detail");
	}
}
