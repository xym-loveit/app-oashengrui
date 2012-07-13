package org.shengrui.oa.web.action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelDoc;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.exception.WebException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
/**
 * The administrator doc manage action.
 * 
 * @author  Tang
 *
 */
public class DocManageAction 
extends BaseAdminAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(DocManageAction.class);
	
	@SuppressWarnings("unused")
	private static final String ACTION_FORM_FLAG_APPROVAL = "1";
	
	@SuppressWarnings("unused")
	private static final String ACTION_FORM_FLAG_RETURNED = "2";
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理 & 文档删除操作(传入id则进行删除操作)
	 * @throws WebException 
	 * @throws ServiceException 
	 */
	public ActionForward adminPageDocumentIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException, ServiceException 
	{
		try
		{
			//判断从前台是否传入了id值，如果有，则进行删除操作
			String id=request.getParameter("id");
			if (this.isObjectIdValid(id))
			{
				this.getServiceDocManage().remove(id);
			}
			
			ModelDoc formDoc = (ModelDoc) form;

			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelDoc> docs =
				this.getServiceDocManage().getPaginationByEntity(formDoc, pagingBean);
			
			request.setAttribute("docs", docs);
			request.setAttribute("formDoc", formDoc);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, docs);
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all doc manages.", e);
		}
		
		return mapping.findForward("admin.page.document.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理 - 文档详细页面
	 * @throws WebException 
	 */
	public ActionForward adminPageDocumentDetail (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		return mapping.findForward("admin.page.document.detail");
	}
	

	
}
