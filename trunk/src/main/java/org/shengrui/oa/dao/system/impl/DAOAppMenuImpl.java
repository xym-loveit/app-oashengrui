package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOAppMenu;
import org.shengrui.oa.model.system.ModelAppMenu;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.util.UtilString;

public class DAOAppMenuImpl
extends DAOGenericImpl<ModelAppMenu> implements DAOAppMenu
{
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppMenu#getMenuByKey(java.lang.String)
	 */
	@Override
	public ModelAppMenu getMenuByKey(String menuKey) throws DAOException
	{
		if(UtilString.isNotEmpty(menuKey))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppMenu.class);
			criteria.add(Restrictions.eq("menuKey", menuKey));
			List<ModelAppMenu> result = getListByCriteria(criteria);
			
			return result != null && result.size() > 0 ? result.get(0) : null;
		}
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppMenu#getAllRootMenus()
	 */
	@Override
	public List<ModelAppMenu> getAllRootMenus() throws DAOException
	{
		return this.findListByNamedQuery("menu.all.root");
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppMenu#getMenusByParentId(java.lang.String)
	 */
	@Override
	public List<ModelAppMenu> getMenusByParentId(String parentId)
			throws DAOException
	{
		if(UtilString.isNotEmpty(parentId))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppMenu.class);
			criteria.createCriteria("menuParent").add(Restrictions.eq("id", parentId));
			return getListByCriteria(criteria);
		}
		return null;
	}

}
