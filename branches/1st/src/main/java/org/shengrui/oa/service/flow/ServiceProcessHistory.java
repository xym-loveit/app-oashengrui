package org.shengrui.oa.service.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessHistory;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service for process history.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceProcessHistory
extends ServiceGeneric<ModelProcessHistory>
{
	/**
	 * Obtains list of process histories with the specified process form no. 
	 * 
	 * @param formNo
	 *         the process form no.
	 * @return list of process histories.
	 * @throws ServiceException
	 */
	List<ModelProcessHistory> getProcessHistoryByFormNo (String formNo) throws ServiceException;
	
	/**
	 * Obtains list of process histories with the specified user id.
	 * 
	 * @param userId
	 *          the user id
	 * @return list of process histories
	 * @throws ServiceException
	 */
	List<ModelProcessHistory> getProcessHistoryByUser (String userId) throws ServiceException;
}
