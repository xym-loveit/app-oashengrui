package org.shengrui.oa.dao.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelAppDictionary;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The application dictionary repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOAppDictionary
extends DAOGeneric<ModelAppDictionary>
{
	/**
	 * 
	 * @param itemName
	 * @return
	 * @throws DAOException
	 */
	List<ModelAppDictionary> getByItemName (String itemName) throws DAOException;
	
}
