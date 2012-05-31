package org.shengrui.oa.service.system;

import org.shengrui.oa.model.system.ModelAppFunctionUrl;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The application function URL service
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceAppFunctionUrl
extends ServiceGeneric<ModelAppFunctionUrl>
{
	
	/**
	 * 
	 * @param urlPath
	 * @param funcId
	 * @return
	 * @throws ServiceException
	 */
	ModelAppFunctionUrl getByPathAndFuncId(String urlPath, 
			String funcId) throws ServiceException;
	
}
