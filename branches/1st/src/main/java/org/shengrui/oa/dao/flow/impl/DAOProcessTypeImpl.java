package org.shengrui.oa.dao.flow.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.flow.DAOProcessType;
import org.shengrui.oa.model.flow.ModelProcessType;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;

public class DAOProcessTypeImpl
extends DAOGenericImpl<ModelProcessType> implements DAOProcessType
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.flow.DAOProcessType#getTypesByKey(java.lang.String)
	 */
	@Override
	public ModelProcessType getTypesByKey(String typeKey) throws DAOException
	{
		String str = "from ModelProcessType pr where pr.processTypeKey=?";
		return (ModelProcessType) findUnique(str, new Object[] { typeKey });
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.flow.DAOProcessType#getTypesBySlug(java.lang.String)
	 */
	@Override
	public List<ModelProcessType> getTypesBySlug(String slugName)
			throws DAOException
	{
		return getTypesBySlug(slugName, true);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.flow.DAOProcessType#getTypesBySlug(java.lang.String, boolean)
	 */
	@Override
	public List<ModelProcessType> getTypesBySlug(String slugName,
			boolean onlyRootNode) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessType.class);
		criteria.add(Restrictions.eq("processTypeSlug", slugName));
		if (onlyRootNode)
		{
			criteria.add(Restrictions.isNull("processTypeParent"));
		}
		return this.getListByCriteria(criteria);
	}

}
