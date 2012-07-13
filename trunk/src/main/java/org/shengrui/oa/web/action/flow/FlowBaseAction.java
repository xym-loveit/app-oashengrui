package org.shengrui.oa.web.action.flow;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessTask;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.service.flow.ServiceProcessDefinition;
import org.shengrui.oa.service.flow.ServiceProcessForm;
import org.shengrui.oa.service.flow.ServiceProcessTask;
import org.shengrui.oa.service.flow.ServiceProcessType;
import org.shengrui.oa.service.flow.ServiceWorkFlow;
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
	protected ServiceProcessType serviceProcessType;
	
	/**
	 * The process definition service
	 */
	@Resource
	protected ServiceProcessDefinition serviceProcessDefinition;
	
	/**
	 * The process task service
	 */
	@Resource
	protected ServiceProcessTask serviceProcessTask; 
	
	/**
	 * The process form service
	 */
	@Resource
	protected ServiceProcessForm serviceProcessForm;
	
	/**
	 * The work flow service
	 */
	@Resource
	protected ServiceWorkFlow serviceWorkFlow;

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
	 * 加载工作流任务列表
	 */
	public  ActionForward actionLoadProcessTasks (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		String procDefId = request.getParameter("procDefId");
		if (this.isObjectIdValid(procDefId))
		{
			try
			{
				ModelProcessDefinition procDefEntity = this.serviceProcessDefinition.get(procDefId);
				if (procDefEntity != null)
				{
					request.setAttribute("processDef", procDefEntity);
					return mapping.findForward("data.sys.setting.flow.task.list");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("流程定义(" + procDefId + ")不能存在..."));
				}
			}
			catch (Exception e)
			{
				return ajaxPrint(response, getErrorCallback("加载流程定义数据失败:" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传入合法的流程定义ID..."));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 根据类型加载工作流节点表单
	 */
	public  ActionForward actionLoadProcessTaskFormPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String paramProcTaskType = request.getParameter("processTaskType");
		
		if (UtilString.isNotEmpty(paramProcTaskType) && UtilString.isNumeric(paramProcTaskType))
		{
			Integer procTaskType = Integer.parseInt(paramProcTaskType);
			
			// 判断传入的节点类型是否合法
			if (this.isProcessTaskTypeAccepted(procTaskType))
			{
				String procTaskTypeText = this.getProcessTaskTypeDescByValue(procTaskType);
				if (procTaskTypeText != null)
				{
					// 返回所有部门列表
					request.setAttribute("deps", this.getAllDepartments(request, true));
					
					String procTaskId = request.getParameter("procTaskId");
					if (UtilString.isNotEmpty(procTaskId))
					{
						if (this.isObjectIdValid(procTaskId))
						{
							try
							{
								ModelProcessTask procTaskEntity = this.serviceProcessTask.get(procTaskId);
								if (procTaskEntity != null)
								{
									request.setAttribute("procTask", procTaskEntity);
									
									// 获取某部门对应的岗位列表
									if (procTaskEntity.getProcessTaskType().equals(ModelProcessTask.EProcessTaskType.OWNER_DEPS_SINGLE.getValue()) || 
											procTaskEntity.getProcessTaskType().equals(ModelProcessTask.EProcessTaskType.MASTER_DEPS_SINGLE.getValue()))
									{
										request.setAttribute("pos", this.getPositionByDepartment(procTaskEntity.getToDepartmentIds()));
									}
								}
								else
								{
									return ajaxPrint(response, getErrorCallback("流程节点未找到..."));
								}
							}
							catch (Exception e)
							{
								return ajaxPrint(response, getErrorCallback("加载流程节点数据失败:" + e.getMessage()));
							}
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("需要传入合法的流程节点ID..."));
						}
					}
					
					// 根据所选择的节点类型返回对应的表单数据
					return mapping.findForward("form.flow.task.type." + 
							this.getProcessTaskTypeDescByValue(procTaskType));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("系统错误, 流程节点类型描述未进行配置..."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("未知的工作流节点类型被传入..."));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("工作流节点类型未指定或者非法类型被传入..."));
		}
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
	 * 流程配置页面
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward pageFlowConfigure (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String procTypeId = request.getParameter("procTypeId");
		if (this.isObjectIdValid(procTypeId))
		{
			try
			{
				ModelProcessType procTypeEntity = this.serviceProcessType.get(procTypeId);
				if (procTypeEntity != null)
				{
					request.setAttribute("processType", procTypeEntity);
					return mapping.findForward("page.sys.flow.configuration");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("指定的流程类型不存在..."));
				}
			}
			catch (Exception e)
			{
				return ajaxPrint(response, getErrorCallback("数据加载失败..." + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传递合法的配置流程类型ID..."));
		}
	}
	
	/**
	 * 工作流节点配置弹框页面
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward dialogFlowTaskConfigurationPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String procDefId = request.getParameter("procDefId");
		if (this.isObjectIdValid(procDefId))
		{
			try
			{
				ModelProcessDefinition procDefEntity = this.serviceProcessDefinition.get(procDefId);
				if (procDefEntity != null)
				{
					request.setAttribute("processDef", procDefEntity);
					
					String procTaskId = request.getParameter("procTaskId");
					if (!UtilString.isNotEmpty(procTaskId))
					{
						// 返回所有部门列表
						request.setAttribute("deps", this.getAllDepartments(request, true));
						
						// 默认返回本账号对应的校区部门表单数据
						request.setAttribute("taskType", ModelProcessTask.EProcessTaskType.OWNER_DEPS_AGAINST.getValue());
					}
					else
					{
						if (this.isObjectIdValid(procTaskId))
						{
							ModelProcessTask procTaskEntity = this.serviceProcessTask.get(procTaskId);
							if (procTaskEntity != null)
							{
								request.setAttribute("procTask", procTaskEntity);
								request.setAttribute("taskType", procTaskEntity.getProcessTaskType());
							}
							else
							{
								return ajaxPrint(response, getErrorCallback("流程节点未找到..."));
							}
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("需要传入合法的流程节点ID..."));
						}
					}
					
					return mapping.findForward("dialog.sys.flow.task.configuration");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("流程定义(" + procDefId + ")不能存在..."));
				}
			}
			catch (Exception e)
			{
				return ajaxPrint(response, getErrorCallback("加载流程定义数据失败:" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传入合法的流程定义ID..."));
		}
		
	}
	
	/**
	 * 流程触发条件弹框页面
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward dialogFlowDefConditionPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String procTypeId = request.getParameter("procTypeId");
		if (this.isObjectIdValid(procTypeId))
		{
			try
			{
				ModelProcessType procTypeEntity = this.serviceProcessType.get(procTypeId);
				if (procTypeEntity != null)
				{
					request.setAttribute("processType", procTypeEntity);
					
					String procDefId = request.getParameter("procDefId");
					if (this.isObjectIdValid(procDefId))
					{
						ModelProcessDefinition procDefEntity = this.serviceProcessDefinition.get(procDefId);
						if (procDefEntity != null)
						{
							request.setAttribute("processDef", procDefEntity);
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("指定的流程定义不存在..."));
						}
					}
					
					return mapping.findForward("dialog.sys.flow.definition.condition");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("指定的流程类型不存在..."));
				}
			}
			catch (Exception e)
			{
				return ajaxPrint(response, getErrorCallback("数据加载失败..." + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传递合法的配置流程类型ID..."));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 保存工作流定义
	 */
	public ActionForward actionSaveProcessDefinition (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String procTypeId = request.getParameter("procTypeId");
		String procDefId = request.getParameter("id");
		String procDefName = request.getParameter("processDefName");
		String procDefDesc = request.getParameter("processDefDesc");
		String procDefCond = request.getParameter("condition");
		
		boolean result = 
			this.doSaveProcessDefinition(procTypeId, procDefId, procDefName, procDefCond, procDefDesc);
		
		if (result)
		{
			// 保存成功后, Dialog进行关闭
			return ajaxPrint(response, 
					getSuccessCallback("流程定义保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("流程定义保存失败..."));
		}
		
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 保存工作流节点
	 */
	public ActionForward actionSaveProcessTask (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String procDefId = request.getParameter("procDefId");
		if (this.isObjectIdValid(procDefId))
		{
			try
			{
				ModelProcessDefinition procDefEntity = this.serviceProcessDefinition.get(procDefId);
				if (procDefEntity != null)
				{
					String procTaskType = request.getParameter("processTaskType");
					
					if (UtilString.isNotEmpty(procTaskType) && 
							this.isProcessTaskTypeAccepted(Integer.parseInt(procTaskType)))
					{
						ModelProcessTask procTaskEntity = null;
						
						String procTaskId = request.getParameter("procTaskId");
						boolean isCreation = procTaskId == null || Integer.parseInt(procTaskId) <= 0;
						
						if (isCreation)
						{
							procTaskEntity = new ModelProcessTask();
							
							// 设置节点步骤序列号
							procTaskEntity.setSortCode(
									procDefEntity.getProcessTasks() != null ? procDefEntity.getProcessTasks().size() + 1 : 1);
						}
						else
						{
							procTaskEntity = this.serviceProcessTask.get(procTaskId);
							if (procTaskEntity == null)
							{
								return ajaxPrint(response, 
										getErrorCallback("流程节点(" + procTaskId + ")不存在..."));
							}
						}
						
						// 根据参数前缀获取对应的数组参数数据
						Map<String, List<String>> paramValues = 
								this.getAllRequestParameters(request, new String[] { "depId", "depName", "posId", "posName"} );
						
						if (paramValues != null && paramValues.size() > 0)
						{
							procTaskEntity.setToDepartmentIds(
									UtilString.join(paramValues.get("depId"), ","));
							procTaskEntity.setToDepartmentNames(
									UtilString.join(paramValues.get("depName"), ","));
							procTaskEntity.setToPositionIds(
									UtilString.join(paramValues.get("posId"), ","));
							procTaskEntity.setToPositionNames(
									UtilString.join(paramValues.get("posName"), ","));
						}
						
						procTaskEntity.setProcessTaskType(Integer.parseInt(procTaskType));
						
						procTaskEntity.setProcessDefinition(procDefEntity);
						
						this.serviceProcessTask.save(procTaskEntity);
						
						// 保存成功后, Dialog进行关闭
						return ajaxPrint(response, 
								getSuccessCallback("流程定义保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
						
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("流程任务类型不合法..."));
					}
					
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("流程定义(" + procDefId + ")不能存在..."));
				}
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when saving the process task entity...", e);
				return ajaxPrint(response, getErrorCallback("加载流程定义数据失败:" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传入合法的流程定义ID..."));
		}
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 移除工作流节点
	 */
	public ActionForward actionRemoveProcessTask (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String procTaskId = request.getParameter("procTaskId");
		if (this.isObjectIdValid(procTaskId))
		{
			try
			{
				ModelProcessTask entity = this.serviceProcessTask.get(procTaskId);
				if (entity != null)
				{
					// 更新其他节点的步骤序列号
					Integer procSeq = entity.getSortCode();
					List<ModelProcessTask> slibingProcTasks = this.serviceProcessTask.getProcessTaskNodesByOffset(procSeq);
					if (slibingProcTasks != null && slibingProcTasks.size() > 0)
					{
						for (ModelProcessTask slibingProcTask : slibingProcTasks)
						{
							slibingProcTask.setSortCode(slibingProcTask.getSortCode() - 1);
							
							// TODO: 这里是否可以考虑实现为batch update?
							this.serviceProcessTask.save(slibingProcTask);
						}
					}
					
					// 移除节点
					this.serviceProcessTask.remove(entity);
					
					// 保存成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("流程节点移除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("流程节点(" + procTaskId + ")不能存在..."));
				}
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when removing the process task entity.", e);
				return ajaxPrint(response, getErrorCallback("移除流程节点数据失败:" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传入合法的流程节点ID...")); 
		}
	}
	
	/**
	 * 保存流程定义
	 * 
	 * @param processTypeId
	 * @param id
	 * @param processDefName
	 * @param condition
	 * @param processDefDesc
	 * @return
	 */
	protected boolean doSaveProcessDefinition (String processTypeId, 
			String id, String processDefName, String condition, String processDefDesc)
	{
		if (UtilString.isNotEmpty(id) && this.isObjectIdValid(processTypeId))
		{
			try
			{
				ModelProcessType procTypeEntity = this.serviceProcessType.get(processTypeId);
				if (procTypeEntity != null)
				{
					ModelProcessDefinition procDefEntity = null;
					boolean isCreation = Integer.parseInt(id) <= 0;

					if (isCreation)
					{
						// 新建
						procDefEntity = new ModelProcessDefinition();
					}
					else
					{
						// 修改
						procDefEntity = this.serviceProcessDefinition.get(id);
						if (procDefEntity == null)
						{
							LOGGER.error("The process definition entity does not exist with id:" + id);
						}
					}
					
					procDefEntity.setCondition(condition);
					procDefEntity.setProcessDefDesc(processDefDesc);
					procDefEntity.setProcessDefName(processDefName);
					procDefEntity.setProcessType(procTypeEntity);
					procDefEntity.setCreateTime(new Date());
					procDefEntity.setFilterPositionNames("test");
					
					this.serviceProcessDefinition.save(procDefEntity);
					
					return true;
				}
				else
				{
					LOGGER.error("The process entity does not exist with id:" + processTypeId);
				}
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when obtaining the process type entity", e);
			}
		}
		
		return false;
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
	 * 判断流程节点类型是否合法.
	 * 
	 * @param processTaskType
	 * @return
	 */
	protected boolean isProcessTaskTypeAccepted (Integer processTaskType)
	{
		if (processTaskType != null)
		{
			return processTaskType.equals(ModelProcessTask.EProcessTaskType.OWNER_DEPS_AGAINST.getValue()) || 
					processTaskType.equals(ModelProcessTask.EProcessTaskType.OWNER_DEPS_SINGLE.getValue()) ||
					processTaskType.equals(ModelProcessTask.EProcessTaskType.MASTER_DEPS_AGAINST.getValue()) ||
					processTaskType.equals(ModelProcessTask.EProcessTaskType.MASTER_DEPS_SINGLE.getValue());
		}
		
		return false;
	}
	
	/**
	 * 根据流程节点类型值获取流程节点描述
	 * 
	 * @param processTaskType
	 * @return
	 */
	protected String getProcessTaskTypeDescByValue (Integer processTaskType)
	{
		if (processTaskType != null)
		{
			if (processTaskType.equals(ModelProcessTask.EProcessTaskType.OWNER_DEPS_AGAINST.getValue()))
			{
				return ModelProcessTask.EProcessTaskType.OWNER_DEPS_AGAINST.getText();
			}
			else if (processTaskType.equals(ModelProcessTask.EProcessTaskType.OWNER_DEPS_SINGLE.getValue()))
			{
				return ModelProcessTask.EProcessTaskType.OWNER_DEPS_SINGLE.getText();
			}
			else if (processTaskType.equals(ModelProcessTask.EProcessTaskType.MASTER_DEPS_AGAINST.getValue()))
			{
				return ModelProcessTask.EProcessTaskType.MASTER_DEPS_AGAINST.getText();
			}
			else if (processTaskType.equals(ModelProcessTask.EProcessTaskType.MASTER_DEPS_SINGLE.getValue()))
			{
				return ModelProcessTask.EProcessTaskType.MASTER_DEPS_SINGLE.getText();
			}
		}
		
		return null;
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

	public void setServiceProcessDefinition(ServiceProcessDefinition serviceProcessDefinition)
	{
		this.serviceProcessDefinition = serviceProcessDefinition;
	}

	public ServiceProcessDefinition getServiceProcessDefinition()
	{
		return serviceProcessDefinition;
	}

	public ServiceProcessTask getServiceProcessTask()
	{
		return serviceProcessTask;
	}

	public void setServiceProcessTask(ServiceProcessTask serviceProcessTask)
	{
		this.serviceProcessTask = serviceProcessTask;
	}
	
	public ServiceWorkFlow getServiceWorkFlow()
	{
		return serviceWorkFlow;
	}

	public void setServiceWorkFlow(ServiceWorkFlow serviceWorkFlow)
	{
		this.serviceWorkFlow = serviceWorkFlow;
	}
	
	public ServiceProcessForm getServiceProcessForm()
	{
		return serviceProcessForm;
	}

	public void setServiceProcessForm(ServiceProcessForm serviceProcessForm)
	{
		this.serviceProcessForm = serviceProcessForm;
	}
}
