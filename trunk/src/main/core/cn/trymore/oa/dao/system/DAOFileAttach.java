package cn.trymore.oa.dao.system;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;
import cn.trymore.oa.model.system.ModelFileAttach;

/**
 * The file attachment repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOFileAttach
extends DAOGeneric<ModelFileAttach>
{
	/**
	 * Obtains the file attach entity with the specified file path. 
	 * 
	 * @param filePath
	 *           the file path
	 * @return file attachment entity
	 * @throws DAOException
	 */
	ModelFileAttach getByPath(String filePath) throws DAOException;
	
}
