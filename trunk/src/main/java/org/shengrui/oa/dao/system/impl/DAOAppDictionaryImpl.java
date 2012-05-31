package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOAppDictionary;
import org.shengrui.oa.model.system.ModelAppDictionary;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.util.UtilString;

/**
 * The implementation of 
 * application dictionary repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOAppDictionaryImpl
extends DAOGenericImpl<ModelAppDictionary> implements DAOAppDictionary
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppDictionary#getByItemName(java.lang.String)
	 */
	public List<ModelAppDictionary> getByItemName (String itemName) 
			throws DAOException
	{
		if(UtilString.isNotEmpty(itemName))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppDictionary.class);
			criteria.add(Restrictions.eq("itemName", itemName));
			
			return this.getListByCriteria(criteria);
		}
		return null;
	}
}
