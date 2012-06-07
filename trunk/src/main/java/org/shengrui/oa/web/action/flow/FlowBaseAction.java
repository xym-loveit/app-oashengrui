package org.shengrui.oa.web.action.flow;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.service.flow.ServiceProcessType;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.action.BaseAction;

/**
 * 工作流基本设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class FlowBaseAction
extends BaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(FlowBaseAction.class);
			
	/**
	 * The process type service
	 */
	@Resource
	private ServiceProcessType serviceProcessType;
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 加载工作流父类别
	 */
	public  ActionForward actionLoadProcessRootType (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String typeSlug = request.getParameter("typeSlug");
		
		if (UtilString.isNotEmpty(typeSlug))
		{
			try
			{
				request.setAttribute("rootTypes", 
						this.getProcessRootTypesBySlug(typeSlug));
			} 
			catch (ServiceException e)
			{
				LOGGER.error("Exception raised when obtain the root types with type:" + typeSlug, e);
			}
		}
		
		request.setAttribute("typeSlug", typeSlug);
		
		return mapping.findForward("data.sys.setting.flow.type.tree");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 加载工作流子类别
	 */
	public  ActionForward actionLoadProcessTypes (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String rootTypeId = request.getParameter("rootTypeId");
		
		if (UtilString.isNotEmpty(rootTypeId))
		{
			try
			{
				request.setAttribute("types", 
						this.getProcessSubTypes(rootTypeId));
			} 
			catch (Exception e)
			{
				LOGGER.error("Exception raised when obtain the sub types with root type:" + rootTypeId, e);
			}
		}
		
		request.setAttribute("rootTypeId", rootTypeId);
		
		return mapping.findForward("data.sys.setting.flow.type.list");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 保存工作流类别
	 */
	public  ActionForward actionSaveProcessType (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return null;
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 删除工作流类别
	 */
	public  ActionForward actionRemoveProcessType (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		return null;
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 流程分类弹框设置页面
	 */
	public ActionForward dialogFlowTypePage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		return mapping.findForward("dialog.sys.setting.flow.type");
	}
	
	/**
	 * 根据归类获取工作流分类列表
	 * 
	 * @param slugName
	 * @return
	 * @throws ServiceException
	 */
	protected List<ModelProcessType> getProcessRootTypesBySlug (
			String slugName) throws ServiceException
	{
		return this.serviceProcessType.getTypesBySlug(slugName);
	}
	
	/**
	 * 根据父工作流ID获取子工作流类型
	 * 
	 * @param rootTypeId
	 * @return
	 * @throws ServiceException
	 */
	protected Set<ModelProcessType> getProcessSubTypes (String rootTypeId) throws Exception
	{
		ModelProcessType rootProcessType = this.serviceProcessType.get(rootTypeId);
		
		if (rootProcessType != null)
		{
			return rootProcessType.getProcessTypeChildren();
		}
		else
		{
			throw new Exception("The root process type does not exist with id:" + rootTypeId);
		}
	}
	
	public ServiceProcessType getServiceProcessType()
	{
		return serviceProcessType;
	}

	public void setServiceProcessType(ServiceProcessType serviceProcessType)
	{
		this.serviceProcessType = serviceProcessType;
	}
	
}
