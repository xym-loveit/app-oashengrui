package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartment;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;

public class DAOWorkTemplateImpl
extends DAOGenericImpl<ModelSchoolDepartment> implements DAOSchoolDepartment
{
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOSchoolDepartment#getDepartmentByOrganization(java.lang.Integer)
	 */
	@Override
	public List<ModelSchoolDepartment> getDepartmentByOrganization(
			Integer orgType) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelSchoolDepartment.class);
		
		if (orgType != null)
		{
			criteria.add(Restrictions.eq("depOrgType", orgType));
		}
		
		return this.getListByCriteria(criteria);
	}

}
