package org.shengrui.oa.dao.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelAppFunction;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The application function repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOAppFunction
extends DAOGeneric<ModelAppFunction>
{
	/**
	 * Obtains the function entity with the specified key.
	 * 
	 * @param paramFunKey
	 *                 the function key
	 * @return
	 * @throws DAOException
	 */
	ModelAppFunction getByKey(String paramFunKey) throws DAOException;
	
	/**
	 * 
	 * @param menuId
	 * @return
	 * @throws DAOException
	 */
	List<ModelAppFunction> getByMenuId(String menuId) throws DAOException;
}
