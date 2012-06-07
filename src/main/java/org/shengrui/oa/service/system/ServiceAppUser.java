package org.shengrui.oa.service.system;

import org.shengrui.oa.model.system.ModelAppUser;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The application user service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceAppUser
extends ServiceGeneric<ModelAppUser>
{
	/**
	 * Obtains user with the specified user name.
	 * 
	 * @param userName
	 *            the user name
	 * @return user entity if existed with the specified user name; null returned otherwise.
	 * @throws ServiceException
	 */
	ModelAppUser findByUserName (String userName) throws ServiceException;
}
