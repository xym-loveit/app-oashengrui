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
 * @author Tang
 *
 */
public class DAOAppDictionaryImpl
extends DAOGenericImpl<ModelAppDictionary> implements DAOAppDictionary
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppDictionary#getByName(java.lang.String)
	 */
	public ModelAppDictionary getByName (String name) 
			throws DAOException
	{
		if(UtilString.isNotEmpty(name))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppDictionary.class);
			criteria.add(Restrictions.eq("name", name));
			
			return this.getListByCriteria(criteria).get(0);
		}
		return null;
	}
	
	@Override
	public List<ModelAppDictionary> getByType(String type) throws DAOException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppDictionary.class);
		criteria.add(Restrictions.eq("type", type));
		
		return this.getListByCriteria(criteria);
	}
	
}
