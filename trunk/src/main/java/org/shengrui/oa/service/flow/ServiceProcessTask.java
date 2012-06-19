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
	 * @return
	 * @throws ServiceException
	 */
	List<ModelProcessTask> getProcessTaskNodesByDefId (String defId) throws ServiceException;
}
