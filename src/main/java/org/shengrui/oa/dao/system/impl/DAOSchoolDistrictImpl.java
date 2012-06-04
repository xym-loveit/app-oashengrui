package org.shengrui.oa.dao.system.impl;

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

}
