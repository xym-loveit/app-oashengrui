package org.shengrui.oa.web.action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.web.action.personal.MyTaskPlanAction;

import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 
 * 任务委托管理
 * 
 * @author Jeccy.Zhao
 *
 */
public class AdminTaskAction
extends MyTaskPlanAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(AdminTaskAction.class);

	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 任务委托管理
	 */
	public ActionForward pageTaskDelegateIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelTaskPlan formEntity = (ModelTaskPlan) form;
			
			request.setAttribute("taskTypes", this.serviceAppDictionary.getByType(DIC_KEY_TASK_TYPE));
				
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelTaskPlan> items =
					this.serviceTaskPlan.getPaginationByEntity(formEntity, null, null, pagingBean);
			
			request.setAttribute("dataList", items);
			request.setAttribute("formEntity", formEntity);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, items);
			
			return mapping.findForward("admin.page.task.index");
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
}
