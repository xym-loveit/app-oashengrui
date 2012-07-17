package org.shengrui.oa.dao.system;

import org.shengrui.oa.model.system.ModelSchoolPositionSet;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The school position set repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOSchoolPositionSet
extends DAOGeneric<ModelSchoolPositionSet>
{
	/**
	 * Obtains position set entity with the specified position set name.
	 * 
	 * @param posetName
	 *           the position set entity name
	 * @return entity of position set
	 * @throws DAOException
	 */
	ModelSchoolPositionSet getByName (String posetName) throws DAOException;
}
