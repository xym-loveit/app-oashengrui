package org.shengrui.oa.service.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.service.system.ServiceSchoolDepartment;

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
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolDepartment#getDepartmentByName(java.lang.String)
	 */
	@Override
	public ModelSchoolDepartment getDepartmentByName(String departmentName)
			throws ServiceException 
	{
		try 
		{
			return daoSchoolDepartment.getDepartmentByName(departmentName);
		} 
		catch (Exception e) 
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolDepartment#getDepartmentByName(java.lang.String, java.lang.Integer)
	 */
	@Override
	 public ModelSchoolDepartment getDepartmentByName(String departmentName, 
			 Integer districtType) throws ServiceException
	{
		try
		{
			 DetachedCriteria criteria = DetachedCriteria.forClass(ModelSchoolDepartment.class);
			 
			 criteria.add(Restrictions.eq("depName", departmentName));
			 criteria.add(Restrictions.eq("depOrgType", districtType));
			 
			 List<ModelSchoolDepartment> result = this.daoSchoolDepartment.getListByCriteria(criteria);
			 
			 return result != null && result.size() > 0 ? result.get(0) : null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
		 
	}
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolDepartment#getDepartmentIdsByName(java.lang.String)
	 */
	@Override
	public List<Object> getDepartmentIdsByName (String departmentName) throws ServiceException
	{
		try
		{
			return this.daoSchoolDepartment.getDepartmentIdsByName(departmentName);
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
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

}
