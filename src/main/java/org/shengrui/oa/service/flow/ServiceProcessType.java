package org.shengrui.oa.service.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessType;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service for process type.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceProcessType
extends ServiceGeneric<ModelProcessType>
{
	
	/**
	 * Obtains the process type with type key.
	 * 
	 * @param typeKey
	 *          the process type key
	 * @return the process type entity
	 * @throws ServiceException
	 */
	ModelProcessType getTypesByKey (String typeKey) throws ServiceException;
	
	/**
	 * Obtains list of process types with the type slug name. 
	 * 
	 * @param slugName
	 *          the process type slug name.
	 * @return list of process types
	 * @throws ServiceException
	 */
	List<ModelProcessType> getTypesBySlug (String slugName) throws ServiceException;
	
	/**
	 * Obtains list of process types with the type slug name.
	 * All types will be returned if `onlyRootNode` set as false.
	 * 
	 * @param slugName
	 *           the process type slug name
	 * @param onlyRootNode
	 *           only root process types returned if set as true.
	 * @return
	 * @throws ServiceException
	 */
	List<ModelProcessType> getTypesBySlug (String slugName, 
			boolean onlyRootNode) throws ServiceException;
	
}
