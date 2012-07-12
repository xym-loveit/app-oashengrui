package org.shengrui.oa.dao.hrm;

import java.util.List;

import org.shengrui.oa.model.hrm.ModelHrmEmployee;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

public interface DAOHrmEmployee
extends DAOGeneric<ModelHrmEmployee>
{
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
	List<ModelHrmEmployee> findByFullName (String fullName, boolean fetchAll) throws DAOException;
}
