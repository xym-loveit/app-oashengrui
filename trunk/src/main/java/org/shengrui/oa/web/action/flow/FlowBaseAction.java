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
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilString;

/**
 * 工作流基本设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class FlowBaseAction
extends BaseAppAction
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
		
		try
		{
			// 这里考虑ProcessType内的字段属性不多, 因此并没有做action-mapping关联
			String id = request.getParameter("id");
			String rootTypeId = request.getParameter("rootTypeId");
			String processTypeName = request.getParameter("processTypeName");
			String processTypeKey = request.getParameter("processTypeKey");
			String processTypeDesc = request.getParameter("processTypeDesc");
			String processTypeSlug = request.getParameter("processTypeSlug");
			
			ModelProcessType entity = null;
			ModelProcessType entityParent = null;
			
			if (UtilString.isNotEmpty(rootTypeId))
			{
				// 验证父审批类型
				entityParent = this.serviceProcessType.get(rootTypeId);
				if (entityParent == null)
				{
					return ajaxPrint(response, getErrorCallback("父审批类型不存在..."));
				}
				
				boolean isCreation = Integer.parseInt(id) <= 0;
				
				if (!isCreation)
				{
					// 编辑
					entity = this.serviceProcessType.get(id);
					if (entity == null)
					{
						return ajaxPrint(response, getErrorCallback("进行编辑的审批类型不存在..."));
					}
				}
				else
				{
					// 新建
					entity = new ModelProcessType();
				}
				
				entity.setProcessTypeDesc(processTypeDesc);
				entity.setProcessTypeName(processTypeName);
				entity.setProcessTypeKey(processTypeKey);
				entity.setProcessTypeSlug(processTypeSlug);
				entity.setProcessTypeParent(entityParent);
				
				this.serviceProcessType.save(entity);
				
				// 保存成功后, Dialog进行关闭
				return ajaxPrint(response, 
						getSuccessCallback("审批类型保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要指定父审批类型..."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving the process type:" + e);
		}
		
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
		try
		{
			String rootTypeId = request.getParameter("rootTypeId");
			if (UtilString.isNotEmpty(rootTypeId))
			{
				ModelProcessType rootType = this.serviceProcessType.get(rootTypeId);
				if (rootType != null)
				{
					request.setAttribute("rootProcessType", rootType);
					
					String processTypeId = request.getParameter("id");
					if (UtilString.isNotEmpty(processTypeId))
					{
						ModelProcessType entity = this.serviceProcessType.get(processTypeId);
						if (entity == null)
						{
							return ajaxPrint(response, getErrorCallback("进行编辑的审批类型不存在..."));
						}
						request.setAttribute("processType", entity);
					}
					
					return mapping.findForward("dialog.sys.setting.flow.type");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("指定的父审批类型不存在..."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要指定审批类型..."));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when loading the dialog page for workflow type creation:" + e);
			return ajaxPrint(response, getErrorCallback("数据加载失败..." + e.getMessage()));
		}
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
