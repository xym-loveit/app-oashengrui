package org.shengrui.oa.service.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessTask;
import org.shengrui.oa.model.system.ModelAppUser;

import cn.trymore.core.exception.ServiceException;

/**
 * The service for work flow.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceWorkFlow
{
	/**
	 * Obtains the process definition 
	 * with the specified definition id.
	 * 
	 * @param defId
	 *          the process definition id
	 * @return process definition entity
	 * @throws ServiceException
	 */
	ModelProcessDefinition getProcessDefinitionByDefId (
			String defId) throws ServiceException;
	
	/**
	 * Obtains the process task nodes 
	 * with the specified definition id.
	 * 
	 * @param defId
	 *           the process definition id.
	 * @return list of process task nodes.
	 * @throws ServiceException
	 */
	List<ModelProcessTask> getProcessTaskNodesByDefId (
			String defId) throws ServiceException;
	
	/**
	 * Obtains the previous process task node
	 * with the specified process task id.
	 * 
	 * @param taskId
	 *          the process task id.
	 * @return the process task entity
	 * @throws ServiceException
	 */
	ModelProcessTask getPreTask (
			String taskId) throws ServiceException;
	
	/**
	 * Obtains the next process task node 
	 * with the specified process task id.
	 * 
	 * @param taskId
	 *          the process task id.
	 * @return the process task entity
	 * @throws ServiceException
	 */
	ModelProcessTask getNextTask (
			String taskId) throws ServiceException;
	
	/**
	 * Returns true if the process instance ended.
	 * 
	 * @param taskId
	 *           the process task id
	 * @return true if the process instance ended, false otherwise.
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
	 * Do starts the process
	 * 
	 * @param processTypeId
	 * @param filterPositions
	 * @param condParamVal
	 * @param formNo
	 * @param user
	 * @throws ServiceException
	 */
	void doStartProcess (String processTypeId, 
			String filterPositions, Object condParamVal, String formNo, ModelAppUser user) throws ServiceException;
	
	/**
	 * 
	 * @param taskId
	 * @throws ServiceException
	 */
	void doEndProcess (String taskId) throws ServiceException;
	
	/**
	 * 
	 * @param formNo
	 * @return
	 * @throws ServiceException
	 */
	List<ModelProcessHistory> getProcessHistoriesByFormNo (String formNo) throws ServiceException;
}
