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
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 简历删除
	 */
	public ActionForward actionResumeRemove(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		String archiveId = request.getParameter("id");
		if (this.isObjectIdValid(archiveId))
		{
			try
			{
				ModelHrmArchive archive = this.serviceHrmArchive.get(archiveId);
				if (archive != null)
				{
					this.serviceHrmArchive.remove(archive);
					
					if (archive.getResume() != null)
					{
						archive.getResume().setDelFlag(1);
						this.serviceHrmResume.save(archive.getResume());
					}
					
					// 操作成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("简历信息删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("人才信息(id:" + archiveId + ")不存在..."));
				}
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when removing resume...", e);
				return ajaxPrint(response, getErrorCallback("删除失败:" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传入合法的人才信息ID参数..."));
		}
	}
}
