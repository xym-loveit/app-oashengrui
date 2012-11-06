package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOSchoolDistrict;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;

public class DAOSchoolDistrictImpl
extends DAOGenericImpl<ModelSchoolDistrict> implements DAOSchoolDistrict
{
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOSchoolDistrict#getDistrictByNo(java.lang.String)
	 */
	@Override
	public ModelSchoolDistrict getDistrictByNo(String districtNo)
			throws DAOException
	{
		String str = "from ModelSchoolDistrict sd where sd.districtNo=?";
		return (ModelSchoolDistrict) findUnique(str, new Object[] { districtNo });
	}

	@Override
	public ModelSchoolDistrict getDistrictByName(String districtName)
			throws DAOException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelSchoolDistrict.class);
		criteria.add(Restrictions.eq("districtName", districtName));
		@SuppressWarnings("unchecked")
		List<ModelSchoolDistrict> list = getHibernateTemplate().findByCriteria(criteria);
		return list != null && list.size() >0 ?list.get(0) : null;
	}

}
