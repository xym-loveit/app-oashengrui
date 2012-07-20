package cn.trymore.oa.service.system;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.oa.model.system.ModelFileAttach;

/**
 * The file attachment service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceFileAttach
extends ServiceGeneric<ModelFileAttach>
{
	
	/**
	 * Obtains the file attach entity with the specified file path. 
	 * 
	 * @param filePath
	 *           the file path
	 * @return file attachment entity
	 * @throws ServiceException
	 */
	ModelFileAttach getByPath (String filePath) throws ServiceException;
	
}
