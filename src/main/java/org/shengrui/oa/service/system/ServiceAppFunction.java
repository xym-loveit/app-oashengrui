package org.shengrui.oa.service.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelAppFunction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The application function service
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceAppFunction
extends ServiceGeneric<ModelAppFunction>
{
	/**
	 * 
	 * @param paramString
	 * @return
	 * @throws ServiceException
	 */
	ModelAppFunction getByKey(String paramString) throws ServiceException;
	
	/**
	 * 
	 * @param menuId
	 * @return
	 * @throws ServiceException
	 */
	List<ModelAppFunction> getByMenuId(String menuId) throws ServiceException;
	
}
