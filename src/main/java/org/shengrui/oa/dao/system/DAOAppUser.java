package org.shengrui.oa.dao.system;

import org.shengrui.oa.model.system.ModelAppUser;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The repository for application user
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOAppUser
extends DAOGeneric<ModelAppUser>
{
	
	/**
	 * Obtains the user with the specified user name.
	 * 
	 * @param userName
	 *           the user name
	 * @return user entity if existed with the name; null returned otherwise.
	 * @throws DAOException
	 */
	ModelAppUser findByUserName (String userName) throws DAOException;
	
}
