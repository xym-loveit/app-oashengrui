package org.shengrui.oa.service.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelAppDictionary;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The application dictionary service
 * 
 * @author Tang
 *
 */
public interface ServiceAppDictionary
extends ServiceGeneric<ModelAppDictionary>
{
	/**
	 * 
	 * @param itemName
	 * @return
	 * @throws ServiceException
	 */
	List<ModelAppDictionary> getByName (String name) 
			throws ServiceException;
}
