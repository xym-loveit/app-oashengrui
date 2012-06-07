package org.shengrui.oa.service.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessType;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

public interface ServiceProcessType
extends ServiceGeneric<ModelProcessType>
{
	
	/**
	 * 
	 * @param typeKey
	 * @return
	 * @throws ServiceException
	 */
	ModelProcessType getTypesByKey (String typeKey) throws ServiceException;
	
	/**
	 * 
	 * @param slugName
	 * @return
	 * @throws ServiceException
	 */
	List<ModelProcessType> getTypesBySlug (String slugName) throws ServiceException;
	
	/**
	 * 
	 * @param slugName
	 * @param onlyRootNode
	 * @return
	 * @throws ServiceException
	 */
	List<ModelProcessType> getTypesBySlug (String slugName, boolean onlyRootNode) throws ServiceException;
	
}
