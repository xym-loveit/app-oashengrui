package org.shengrui.oa.service.flow.impl;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessTask;
import org.shengrui.oa.service.flow.ServiceWorkFlow;

import cn.trymore.core.exception.ServiceException;

public class ServiceWorkFlowImpl
implements ServiceWorkFlow
{
	
	@Override
	public ModelProcessDefinition getProcessDefinitionByDefId(String defId)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ModelProcessTask> getProcessTaskNodesByDefId(String defId)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
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

}
