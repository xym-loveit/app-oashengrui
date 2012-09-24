package org.shengrui.oa.dao.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessType;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The repository for process type
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOProcessType
extends DAOGeneric<ModelProcessType>
{
	
	/**
	 * Obtains process type with the specified type key
	 * 
	 * @param typeKey
	 *           the process type key
	 * @return process type entity
	 * @throws DAOException
	 */
	ModelProcessType getTypesByKey (String typeKey) throws DAOException;
	
	/**
	 * Obtains list of process type entities with the specified type slug name.
	 * 
	 * @param slugName
	 *          the process slug name
	 * @return list of process type entities
	 * @throws DAOException
	 */
	List<ModelProcessType> getTypesBySlug (String slugName) throws DAOException;
	
	/**
	 * Obtains list of process type entities with the specified type slug name.
	 * Only root nodes will be returned only if `onlyRootNode` set as true.
	 * 
	 * @param slugName
	 *           the process slug name
	 * @param onlyRootNode
	 *           the flag that whether only root node obtained 
	 * @return list of process type entities
	 * @throws DAOException
	 */
	List<ModelProcessType> getTypesBySlug (String slugName, boolean onlyRootNode) throws DAOException;
}
