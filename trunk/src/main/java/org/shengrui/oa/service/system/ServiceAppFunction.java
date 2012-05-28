package org.shengrui.oa.service.system;

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
}
