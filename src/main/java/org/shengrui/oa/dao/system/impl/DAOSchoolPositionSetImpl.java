package org.shengrui.oa.dao.system.impl;

import org.shengrui.oa.dao.system.DAOSchoolPositionSet;
import org.shengrui.oa.model.system.ModelSchoolPositionSet;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;

/**
 * The implementation of school position set repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOSchoolPositionSetImpl
extends DAOGenericImpl<ModelSchoolPositionSet> implements DAOSchoolPositionSet
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOSchoolPositionSet#getByName(java.lang.String)
	 */
	@Override
	public ModelSchoolPositionSet getByName(String posetName)
			throws DAOException
	{
		String str = "from ModelSchoolPositionSet ps where ps.posetName=?";
		return (ModelSchoolPositionSet) findUnique(str, new Object[] { posetName });
	}

}
