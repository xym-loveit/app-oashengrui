package org.shengrui.oa.service.flow.impl;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessTask;
import org.shengrui.oa.service.flow.ServiceProcessDefinition;
import org.shengrui.oa.service.flow.ServiceProcessForm;
import org.shengrui.oa.service.flow.ServiceProcessHistory;
import org.shengrui.oa.service.flow.ServiceProcessTask;
import org.shengrui.oa.service.flow.ServiceWorkFlow;

import cn.trymore.core.exception.ServiceException;

public class ServiceWorkFlowImpl
implements ServiceWorkFlow
{
	/**
	 * The process definition service.
	 */
	private ServiceProcessDefinition serviceProcessDefinition;
	
	/**
	 * The process form service.
	 */
	private ServiceProcessForm serviceProcessForm;
	
	/**
	 * The process task service.
	 */
	private ServiceProcessTask serviceProcessTask;
	
	/**
	 * The process history service.
	 */
	private ServiceProcessHistory serviceProcessHistory;
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#getProcessDefinitionByDefId(java.lang.String)
	 */
	@Override
	public ModelProcessDefinition getProcessDefinitionByDefId(String defId)
			throws ServiceException
	{
		return this.serviceProcessDefinition.get(defId);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#getProcessTaskNodesByDefId(java.lang.String)
	 */
	@Override
	public List<ModelProcessTask> getProcessTaskNodesByDefId(String defId)
			throws ServiceException
	{
		return this.serviceProcessTask.getProcessTaskNodesByDefId(defId);
	}

	@Override
	public ModelProcessTask getPreTask(String taskId) throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelProcessTask getNextTask(String taskId) throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean isProcessInstanceEnded(String taskId)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void jumpToPreTask(String taskId, String comments)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public void completeTask(String taskId) throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doStartProcess(String taskId, String defId)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doEndProcess(String taskId) throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ModelProcessHistory> getProcessHistoriesByFormNo(String formNo)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}

	public void setServiceProcessDefinition(ServiceProcessDefinition serviceProcessDefinition)
	{
		this.serviceProcessDefinition = serviceProcessDefinition;
	}

	public ServiceProcessDefinition getServiceProcessDefinition()
	{
		return serviceProcessDefinition;
	}

	public void setServiceProcessForm(ServiceProcessForm serviceProcessForm)
	{
		this.serviceProcessForm = serviceProcessForm;
	}

	public ServiceProcessForm getServiceProcessForm()
	{
		return serviceProcessForm;
	}

	public void setServiceProcessTask(ServiceProcessTask serviceProcessTask)
	{
		this.serviceProcessTask = serviceProcessTask;
	}

	public ServiceProcessTask getServiceProcessTask()
	{
		return serviceProcessTask;
	}

	public void setServiceProcessHistory(ServiceProcessHistory serviceProcessHistory)
	{
		this.serviceProcessHistory = serviceProcessHistory;
	}

	public ServiceProcessHistory getServiceProcessHistory()
	{
		return serviceProcessHistory;
	}

}
