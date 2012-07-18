package org.shengrui.oa.web.action.personal;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.web.action.flow.FlowBaseAction;

/**
 * WebAction: 我的申请
 * 
 * @author Jeccy.Zhao
 *
 */
public class MyFormApplicationAction
extends FlowBaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyFormApplicationAction.class);
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我的申请
	 */
	public ActionForward pageMyApplicationIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return mapping.findForward("page.my.application.form.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 我要申请
	 */
	public ActionForward dialogApplicationFormPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			List<ModelProcessType> procTypes = this.serviceProcessType.getTypesBySlug("hrm", true);
			if (procTypes == null)
			{
				return ajaxPrint(response, getErrorCallback("人资申请流程类型不存在..."));
			}
			
			request.setAttribute("types", procTypes);
			
			String formId = request.getParameter("formId");
			if (formId != null && this.isObjectIdValid(formId))
			{
				// TODO: obtains the form entity..
				request.setAttribute("formId", formId);
			}
			
			request.setAttribute("op", request.getParameter("op"));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch expense detail.", e);
		}
		
		return mapping.findForward("dialog.my.application.form");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 加载表单
	 */
	public ActionForward actionLoadTemplatePage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String procTypeId = request.getParameter("procTypeId");
			
			if (this.isObjectIdValid(procTypeId))
			{
				ModelProcessType procType = this.serviceProcessType.get(procTypeId);
				if (procType != null)
				{
					ModelAppUser user = ContextUtil.getCurrentUser();
					
					if (user != null && user.getEmployee() != null)
					{
						request.setAttribute("employee", user.getEmployee());
						
						if(processKeyAlias.containsKey(procType.getProcessTypeKey()))
						{
							request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
							request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
							
							return mapping.findForward(
									"tpl.my.application.form." + processKeyAlias.get(procType.getProcessTypeKey()));
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("申请类型Key不合法(key:" + procType.getProcessTypeKey() + ")...."));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("您需要先登录或者必须是个员工身份..."));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("申请类型(id:" + procTypeId + ")不存在...."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("请传入合法的申请类型ID...."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when loading the template form page.", e);
			return ajaxPrint(response, getErrorCallback(":" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 保存申请
	 */
	public ActionForward actionSaveApplication (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		
		
		return null;
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
	
}
