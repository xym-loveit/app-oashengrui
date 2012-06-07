package org.shengrui.oa.dao.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessType;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

public interface DAOProcessType
extends DAOGeneric<ModelProcessType>
{
	
	/**
	 * 
	 * @param typeKey
	 * @return
	 * @throws DAOException
	 */
	ModelProcessType getTypesByKey (String typeKey) throws DAOException;
	
	/**
	 * 
	 * @param slugName
	 * @return
	 * @throws DAOException
	 */
	List<ModelProcessType> getTypesBySlug (String slugName) throws DAOException;
	
	/**
	 * 
	 * @param slugName
	 * @param onlyRootNode
	 * @return
	 * @throws DAOException
	 */
	List<ModelProcessType> getTypesBySlug (String slugName, boolean onlyRootNode) throws DAOException;
}
