package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.util.UtilString;

public class DAOSchoolDepartmentPositionImpl
extends DAOGenericImpl<ModelSchoolDepartmentPosition> implements DAOSchoolDepartmentPosition
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOSchoolDepartmentPosition#getPositionByDepartmentId(java.lang.String)
	 */
	@Override
	public List<ModelSchoolDepartmentPosition> getPositionByDepartmentId(
			String departmentId) throws DAOException
	{
		if (UtilString.isNotEmpty(departmentId))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelSchoolDepartmentPosition.class);
			criteria.createCriteria("department").add(Restrictions.eq("id", departmentId));
			return this.getListByCriteria(criteria);
		}
		return null;
	}

	@Override
	public ModelSchoolDepartmentPosition getPositionByName(String positionName)
			throws DAOException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelSchoolDepartmentPosition.class);
		criteria.add(Restrictions.eq("positionName", positionName));
		@SuppressWarnings("unchecked")
		List<ModelSchoolDepartmentPosition> list = getHibernateTemplate().findByCriteria(criteria);
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

}
