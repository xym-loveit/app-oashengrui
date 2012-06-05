package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOAppRole;
import org.shengrui.oa.model.system.ModelAppRole;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;

/**
 * The application role repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOAppRoleImpl
extends DAOGenericImpl<ModelAppRole> implements DAOAppRole
{
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppRole#getRoleByName(java.lang.String)
	 */
	@Override
	public ModelAppRole getRoleByName(String roleName) throws DAOException
	{
		String str = "from ModelAppRole ar where ar.roleName=?";
		return (ModelAppRole) findUnique(str, new Object[] { roleName });
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppRole#getRoleByKey(java.lang.String)
	 */
	@Override
	public ModelAppRole getRoleByKey (String roleKey) throws DAOException
	{
		String str = "from ModelAppRole ar where ar.roleKey=?";
		return (ModelAppRole) findUnique(str, new Object[] { roleKey });
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppRole#getRolesByType(java.lang.Integer)
	 */
	@Override
	public List<ModelAppRole> getRolesByType (Integer roleType) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppRole.class);
		if (roleType != null)
		{
			criteria.add(Restrictions.eq("roleType", roleType));
		}
		return this.getListByCriteria(criteria);
	}

}
