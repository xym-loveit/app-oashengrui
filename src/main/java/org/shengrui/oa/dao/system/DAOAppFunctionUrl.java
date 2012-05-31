package org.shengrui.oa.dao.system;

import org.shengrui.oa.model.system.ModelAppFunctionUrl;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The application function URL repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOAppFunctionUrl
extends DAOGeneric<ModelAppFunctionUrl>
{
	/**
	 * Obtains the function URL entity with the specified path and function id
	 * 
	 * @param urlPath
	 *                 the function key
	 * @param funcId
	 *                 the function id
	 * @return
	 * @throws DAOException
	 */
	ModelAppFunctionUrl getByPathAndFuncId(String urlPath, String funcId) throws DAOException;
	
}
