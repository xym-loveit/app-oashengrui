package org.shengrui.oa.web.action.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.trymore.core.web.action.BaseAction;

/**
 * 系统设置 - 审批流程配置
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysSettingWorkFlowAction
extends BaseAction
{
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 审批流程配置-财务审批流程配置
	 */
	public ActionForward pageWorkFlowFinancialIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.workflow.financial");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 审批流程配置-人资审批流程配置
	 */
	public ActionForward pageWorkFlowHRIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.sys.setting.workflow.hr");
	}
	
}
