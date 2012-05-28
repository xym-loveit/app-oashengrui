package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.shengrui.oa.dao.system.DAOAppFunction;
import org.shengrui.oa.model.system.ModelAppFunction;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;

/**
 * The application function repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOAppFunctionImpl
extends DAOGenericImpl<ModelAppFunction> implements DAOAppFunction
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppFunction#getByKey(java.lang.String)
	 */
	public ModelAppFunction getByKey(String paramFunKey) throws DAOException
	{
		String hsql = "from ModelAppFunction af where af.funKey=?";
		List<ModelAppFunction> result = this.findListByHSQL(hsql);
		
		return result != null && result.size() > 0 ? result.get(0) : null;
	}
	
}
