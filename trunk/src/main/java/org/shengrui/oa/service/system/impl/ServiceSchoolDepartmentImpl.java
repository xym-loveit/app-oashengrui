package org.shengrui.oa.service.system.impl;

import java.util.List;

import org.shengrui.oa.dao.system.DAOSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.service.system.ServiceSchoolDepartment;
import org.springframework.aop.ThrowsAdvice;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
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
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolDepartment#getDepartmentByOrganization(java.lang.Integer)
	 */
	@Override
	public List<ModelSchoolDepartment> getDepartmentByOrganization(
			Integer orgType) throws ServiceException
	{
		try
		{
			return this.daoSchoolDepartment.getDepartmentByOrganization(orgType);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolDepartment#getDistinctDepartmentNames()
	 */
	@Override
	 public List<Object> getDistinctDepartmentNames () throws ServiceException
	 {
		try
		{
			return this.daoSchoolDepartment.findListByNativeSQL("SELECT distinct(dep_name) FROM app_school_department");
		} 
		catch (DAOException e)
		{
			throw new ServiceException (e);
		}
	 }
	
	public DAOSchoolDepartment getDaoSchoolDepartment()
	{
		return daoSchoolDepartment;
	}

	public void setDaoSchoolDepartment(DAOSchoolDepartment daoSchoolDepartment)
	{
		this.daoSchoolDepartment = daoSchoolDepartment;
	}

	@Override
	public ModelSchoolDepartment getDepartmentByName(String departmentName)
			throws ServiceException {
			try {
				return daoSchoolDepartment.getDepartmentByName(departmentName);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				throw new ServiceException(e);
			}
	}

}
