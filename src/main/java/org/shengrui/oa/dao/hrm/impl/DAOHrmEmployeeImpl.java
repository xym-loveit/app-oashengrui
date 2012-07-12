package org.shengrui.oa.dao.hrm.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.hrm.DAOHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.util.UtilString;

public class DAOHrmEmployeeImpl
extends DAOGenericImpl<ModelHrmEmployee> implements DAOHrmEmployee
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.hrm.DAOHrmEmployee#findByFullName(java.lang.String, boolean)
	 */
	@Override
	public List<ModelHrmEmployee> findByFullName(String fullName,
			boolean fetchAll) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployee.class);
		if (UtilString.isNotEmpty(fullName) || fetchAll)
		{
			criteria.add(Restrictions.like("empName", fullName, MatchMode.ANYWHERE));
		}
		return this.getListByCriteria(criteria);
	}

}
