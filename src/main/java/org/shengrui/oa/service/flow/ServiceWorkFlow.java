package org.shengrui.oa.service.flow;

import java.util.List;

import org.shengrui.oa.model.process.ModelProcessDefinition;
import org.shengrui.oa.model.process.ModelProcessTask;

import cn.trymore.core.exception.ServiceException;

public interface ServiceWorkFlow
{
	/**
	 * 
	 * @param defId
	 * @return
	 * @throws ServiceException
	 */
	ModelProcessDefinition getProcessDefinitionByDefId (
			String defId) throws ServiceException;
	
	/**
	 * 
	 * @param defId
	 * @return
	 * @throws ServiceException
	 */
	List<ModelProcessTask> getProcessTaskNodesByDefId (
			String defId) throws ServiceException;
	
	/**
	 * 
	 * @param taskId
	 * @return
	 * @throws ServiceException
	 */
	ModelProcessTask getPreTask (
			String taskId) throws ServiceException;
	
	/**
	 * 
	 * @param taskId
	 * @return
	 * @throws ServiceException
	 */
	ModelProcessTask getNextTask (
			String taskId) throws ServiceException;
	
	/**
	 * 
	 * @param taskId
	 * @return
	 * @throws ServiceException
	 */
	boolean isProcessInstanceEnded (
			String taskId) throws ServiceException;
	
	/**
	 * 
	 * @param taskId
	 * @param comments
	 * @throws ServiceException
	 */
	void jumpToPreTask (String taskId,
			String comments) throws ServiceException;
	
	/**
	 * 
	 * @param taskId
	 * @throws ServiceException
	 */
	void completeTask (String taskId) throws ServiceException;
	
	/**
	 * 
	 * @param taskId
	 * @param defId
	 * @throws ServiceException
	 */
	void doStartProcess (String taskId,
			String defId) throws ServiceException;
	
	/**
	 * 
	 * @param taskId
	 * @throws ServiceException
	 */
	void doEndProcess (String taskId) throws ServiceException;
}
