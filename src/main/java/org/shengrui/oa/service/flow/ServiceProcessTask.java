package org.shengrui.oa.service.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessTask;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service for process task nodes.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceProcessTask
extends ServiceGeneric<ModelProcessTask>
{
	/**
	 * Obtains the sorted task nodes 
	 * with the specified process definition id. 
	 *  
	 * @param defId
	 *          the process definition id
	 * @return list of process task nodes.
	 * @throws ServiceException
	 */
	List<ModelProcessTask> getProcessTaskNodesByDefId (String defId) throws ServiceException;
	
	/**
	 * Obtains list of task nodes that started with the specified offset.
	 * 
	 * @param seqOffset
	 *          the process task sequence offset 
	 * @return list of process task nodes
	 * @throws ServiceException
	 */
	List<ModelProcessTask> getProcessTaskNodesByOffset (int seqOffset) throws ServiceException;
	
	/**
	 * Returns true if the process task with the specified sequence index last one
	 * 
	 * @param seq
	 *         the process task sequence index
	 * @return true if process task with the sequence index last one.
	 * @throws ServiceException
	 */
	boolean isProcessTaskLastOne (int seq) throws ServiceException;
}
