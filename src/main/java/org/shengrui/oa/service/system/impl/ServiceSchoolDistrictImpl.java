package org.shengrui.oa.service.system.impl;

import org.shengrui.oa.dao.system.DAOSchoolDistrict;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.system.ServiceSchoolDistrict;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation of service of school district
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceSchoolDistrictImpl
extends ServiceGenericImpl<ModelSchoolDistrict> implements ServiceSchoolDistrict
{
	
	private DAOSchoolDistrict daoSchoolDistrict;
	
	public ServiceSchoolDistrictImpl (DAOSchoolDistrict dao)
	{
		super(dao);
		this.daoSchoolDistrict = dao;
	}

	public DAOSchoolDistrict getDaoSchoolDistrict()
	{
		return daoSchoolDistrict;
	}

	public void setDaoSchoolDistrict(DAOSchoolDistrict daoSchoolDistrict)
	{
		this.daoSchoolDistrict = daoSchoolDistrict;
	}
	
}
