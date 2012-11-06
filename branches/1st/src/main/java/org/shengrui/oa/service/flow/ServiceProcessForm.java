package org.shengrui.oa.service.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessForm;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service for process running.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceProcessForm
extends ServiceGeneric<ModelProcessForm>
{
	/**
	 * Obtains the process form with the specified form no.
	 * 
	 * @param formNo
	 *          the process form no.
	 * @return list of process form entities
	 * @throws ServiceException
	 */
	List<ModelProcessForm> getProcessFormsByFormNo (String formNo) throws ServiceException;
	
	/**
	 * Obtains the current process form with the specified form no.
	 * 
	 * @param formNo
	 *           the process form no.
	 * @return process form entity
	 * @throws ServiceException
	 */
	ModelProcessForm getCurrentProcessForm (String formNo) throws ServiceException;
	
	/**
	 * Obtains the previous process form with the specified form id.
	 * 
	 * @param formId
	 *                 the process form id.
	 * @return process form entity
	 * @throws ServiceException
	 */
	ModelProcessForm getPreviousProcessForm (String formId) throws ServiceException;
	
	/**
	 * Obtains the next process form with the specified form no.
	 * 
	 * @param formId
	 *                   the process form id.
	 * @return process form entity
	 * @throws ServiceException
	 */
	ModelProcessForm getNextProcessForm (String formId) throws ServiceException;
	
	/**
	 * Obtains list of process form entities with the specified process type id.
	 * 
	 * @param processTypeId
	 *           the process type id.
	 * @return list of process form entities with sorted sequence.
	 * @throws ServiceException
	 */
	List<ModelProcessForm> getProcessFormByType (String processTypeId) throws ServiceException;
	
	/**
	 * Returns the process form state, 
	 * if entity not found and it means that the process 
	 * already removed from the process form or transferred to the history. 
	 * 
	 * @param formNo
	 *           the process form no.
	 * @return the process form state.
	 * @throws ServiceException
	 */
	Integer getProcessFormState (String formNo) throws ServiceException;
	
	/**
	 * Removes the form nodes with the specified form no.
	 * 
	 * @param formNo
	 *                 the process form no.
	 * @return true if removal succeed; false otherwise.
	 * @throws ServiceException
	 */
	boolean removeFormByNo (String formNo) throws ServiceException;
	
}
