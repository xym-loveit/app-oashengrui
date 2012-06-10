package org.shengrui.oa.dao.system;

import java.util.List;

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
	 *                 the user name
	 * @return user entity if existed with the name; null returned otherwise.
	 * @throws DAOException
	 */
	ModelAppUser findByUserName (String userName) throws DAOException;
	
	/**
	 * Obtains the user with the specified user full name.
	 * 
	 * @param userName
	 *                 the user full name
	 * @param fetchAll
	 *                 fetch all if the user full name not given
	 * @return user entity if existed with the name; null returned otherwise.
	 * @throws DAOException
	 */
	List<ModelAppUser> findByFullName (String fullName, boolean fetchAll) throws DAOException;
	
}
