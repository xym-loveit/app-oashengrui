package org.shengrui.oa.service.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessTask;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;

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
	 * Jumps to the previous process task node.
	 * 
	 * @param procFormId
	 *                 the process form id
	 * @param comments
	 *                 the audit comments
	 * @throws ServiceException
	 */
	void jumpToPreTask (String procFormId,
			String comments) throws ServiceException;
	
	/**
	 * Jumps to the next process task node.
	 * 
	 * @param procFormId
	 *                  the process form id
	 * @param comments
	 *                  the audit comments
	 * @throws ServiceException
	 */
	void jumpToNextTask (String procFormId, String comments) throws ServiceException;
	
	/**
	 * Completes task
	 * 
	 * @param procFormId
	 *                 the process form id
	 * @param auditState
	 *                 the process audit state
	 * @param comments
	 *                 the process comments
	 * @throws ServiceException
	 */
	void completeTask (String procFormId, 
			Integer auditState, String comments) throws ServiceException;
	
	/**
	 * Do starts the process
	 * 
	 * @param processTypeId
	 *                  the process type id
	 * @param filterPositions
	 *                  the filtered position
	 * @param condParamVal
	 *                  the condition parameter value
	 * @param formNo
	 *                  the application form no
	 * @param employee
	 *                  the employee entity, aims to generate the form entities.
	 * @throws ServiceException
	 */
	void doStartProcess (String processTypeId, 
			String filterPositions, Object condParamVal, String formNo, ModelHrmEmployee employee) throws ServiceException;
	
	/**
	 * Ends the process form nodes with the specified form no.
	 * 
	 * @param procFormNo
	 *                  the process form no.
	 * @throws ServiceException
	 */
	void doEndProcess (String procFormNo) throws ServiceException;
	
	/**
	 * Proceeds task form approval.
	 * 
	 * @param procFormId
	 *                  the process form id
	 * @param procFormState
	 *                  the process form state
	 * @param comments
	 *                  the comments
	 * @throws ServiceException
	 */
	boolean proceed (String procFormId, 
			Integer procFormState, String comments) throws ServiceException;
	
	/**
	 * 
	 * @param formNo
	 * @return
	 * @throws ServiceException
	 */
	List<ModelProcessHistory> getProcessHistoriesByFormNo (String formNo) throws ServiceException;
}