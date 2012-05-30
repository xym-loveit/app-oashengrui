package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOAppFunction;
import org.shengrui.oa.model.system.ModelAppFunction;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.util.UtilString;

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
		if(UtilString.isNotEmpty(paramFunKey))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppFunction.class);
			criteria.add(Restrictions.eq("funcKey", paramFunKey));
			
			List<ModelAppFunction> result = this.getListByCriteria(criteria);
			return result != null && result.size() > 0 ? result.get(0) : null;
		}
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppFunction#getByMenuId(java.lang.String)
	 */
	public List<ModelAppFunction> getByMenuId(String menuId) throws DAOException
	{
		if(UtilString.isNotEmpty(menuId))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppFunction.class);
			criteria.createCriteria("menu").add(Restrictions.eq("id", menuId));
			
			return this.getListByCriteria(criteria);
		}
		return null;
	}
	
}
