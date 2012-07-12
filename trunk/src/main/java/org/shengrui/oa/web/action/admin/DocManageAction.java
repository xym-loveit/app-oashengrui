package org.shengrui.oa.web.action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.web.action.hrm.HrmHireAction;

import cn.trymore.core.exception.WebException;

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
	private static final Logger LOGGER = Logger.getLogger(HrmHireAction.class);
	
	private static final String ACTION_FORM_FLAG_APPROVAL = "1";
	
	private static final String ACTION_FORM_FLAG_RETURNED = "2";
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理
	 * @throws WebException 
	 */
	public ActionForward adminPageDocumentIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
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
