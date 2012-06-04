package org.shengrui.oa.service.system.impl;

import org.shengrui.oa.dao.system.DAOSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.service.system.ServiceSchoolDepartment;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation of service of school department
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceSchoolDepartmentImpl
extends ServiceGenericImpl<ModelSchoolDepartment> implements ServiceSchoolDepartment
{
	
	private DAOSchoolDepartment daoSchoolDepartment;
	
	public ServiceSchoolDepartmentImpl (DAOSchoolDepartment dao)
	{
		super(dao);
		this.daoSchoolDepartment = dao;
	}

	public DAOSchoolDepartment getDaoSchoolDepartment()
	{
		return daoSchoolDepartment;
	}

	public void setDaoSchoolDepartment(DAOSchoolDepartment daoSchoolDepartment)
	{
		this.daoSchoolDepartment = daoSchoolDepartment;
	}
	
}
