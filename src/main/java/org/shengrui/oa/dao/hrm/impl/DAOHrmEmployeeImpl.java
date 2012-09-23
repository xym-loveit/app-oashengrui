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
		return findByFullName(fullName, null, fetchAll);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.hrm.DAOHrmEmployee#findByFullName(java.lang.String, boolean, boolean)
	 */
	@Override
	public List<ModelHrmEmployee> findByFullName (String fullName, 
			String localDistrictId, boolean fetchAll) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployee.class);
		if (UtilString.isNotEmpty(fullName) || fetchAll)
		{
			criteria.add(Restrictions.like("empName", fullName, MatchMode.ANYWHERE));
		}
		
		// 过滤本校区员工
		if (UtilString.isNotEmpty(localDistrictId))
		{
			criteria.createCriteria("employeeDistrict").add(Restrictions.eq("id", localDistrictId));
		}
		
		// 过滤被删除的员工档案
		criteria.add(Restrictions.or(Restrictions.eq("status", "Y"), Restrictions.isNull("status")));
		
		return this.getListByCriteria(criteria);
	}

	@Override
	public ModelHrmEmployee getEmployeeByEmpNo(String empNo)
			throws DAOException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployee.class);
		criteria.add(Restrictions.eq("empNo", empNo));
		
		// 过滤被删除的员工档案
		criteria.add(Restrictions.or(Restrictions.eq("status", "Y"), Restrictions.isNull("status")));
		
		@SuppressWarnings("unchecked")
		List<ModelHrmEmployee> list = getHibernateTemplate().findByCriteria(criteria);
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

}
