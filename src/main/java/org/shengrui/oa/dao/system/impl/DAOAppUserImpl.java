package org.shengrui.oa.dao.system.impl;

import org.shengrui.oa.dao.system.DAOAppUser;
import org.shengrui.oa.model.system.ModelAppUser;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;

/**
 * The repository for application user implementation.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOAppUserImpl
extends DAOGenericImpl<ModelAppUser> implements DAOAppUser
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppUser#getUserByName(java.lang.String)
	 */
	@Override
	public ModelAppUser findByUserName(String userName) throws DAOException
	{
		return null;
	}

}
