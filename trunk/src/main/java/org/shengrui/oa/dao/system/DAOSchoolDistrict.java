package org.shengrui.oa.dao.system;

import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

public interface DAOSchoolDistrict
extends DAOGeneric<ModelSchoolDistrict>
{
	/**
	 * 
	 * @param districtNo
	 * @return
	 * @throws DAOException
	 */
	ModelSchoolDistrict getDistrictByNo(String districtNo) throws DAOException;
	
	ModelSchoolDistrict getDistrictByName(String districtName) throws DAOException;
	
}
