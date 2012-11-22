package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartment;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.model.ModelBase;

public class DAOSchoolDepartmentImpl
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
		
		criteria.add(Restrictions.ne("delFlag", ModelBase.DEL_FLAG));
		
		return this.getListByCriteria(criteria);
	}

	@Override
	public ModelSchoolDepartment getDepartment(String id) throws DAOException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelSchoolDepartment.class);
		criteria.add(Restrictions.eq("id", id));
		criteria.add(Restrictions.ne("delFlag", ModelBase.DEL_FLAG));
		@SuppressWarnings("unchecked")
		List<ModelSchoolDepartment> list = getHibernateTemplate().findByCriteria(criteria);
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public ModelSchoolDepartment getDepartmentByName(String departmentName)
			throws DAOException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelSchoolDepartment.class);
		criteria.add(Restrictions.eq("depName", departmentName));
		criteria.add(Restrictions.ne("delFlag", ModelBase.DEL_FLAG));
		@SuppressWarnings("unchecked")
		List<ModelSchoolDepartment> list = getHibernateTemplate().findByCriteria(criteria);
		return list != null && list.size() > 0 ?list.get(0) : null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOSchoolDepartment#getDepartmentIdsByName(java.lang.String)
	 */
	@Override
	public List<Object> getDepartmentIdsByName(String departmentName)
			throws DAOException
	{
		String nativeSql = "SELECT dep_id FROM app_school_department WHERE dep_name = '" + departmentName + "' AND del_flag != " + ModelBase.DEL_FLAG;
		return this.findListByNativeSQL(nativeSql);
	}

}
