package org.shengrui.oa.service.hrm.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import org.shengrui.oa.dao.hrm.DAOHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.service.hrm.ServiceHrmEmployee;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The implementation of employee service.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceHrmEmployeeImpl
extends ServiceGenericImpl<ModelHrmEmployee> implements ServiceHrmEmployee
{
	/**
	 * The employee repository
	 */
	private DAOHrmEmployee daoHrmEmployee;
	
	public ServiceHrmEmployeeImpl(DAOHrmEmployee dao)
	{
		super(dao);
		
		this.daoHrmEmployee = dao;
	}
	
	/**
	 * 
	 * @param entity
	 * @return
	 */
	protected DetachedCriteria getCriteria (ModelHrmEmployee entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployee.class);
		
		// TODO Criteria conditions needed here.
		
		return criteria;
	}
	
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmEmployee#findByFullName(java.lang.String)
	 */
	@Override
	public List<ModelHrmEmployee> findByFullName(String fullName)
			throws ServiceException
	{
		return this.findByFullName(fullName, false);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmEmployee#findByFullName(java.lang.String, boolean)
	 */
	@Override
	public List<ModelHrmEmployee> findByFullName(String fullName,
			boolean fetchAll) throws ServiceException
	{
		try
		{
			return this.daoHrmEmployee.findByFullName(fullName, fetchAll);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmEmployee#getEmployeeInfoPagination(org.shengrui.oa.model.hrm.ModelHrmEmployee, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmEmployee> getEmployeeInfoPagination(
			ModelHrmEmployee entity, PagingBean pagingBean)
			throws ServiceException
	{
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias(ModelHrmEmployee entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployee.class);
		
		if (entity != null)
		{
			if (entity.getEmployeeDistrict() != null && entity.getEmployeeDistrict().getId() != null)
			{
				criteria.createCriteria("employeeDistrict").add(Restrictions.eq("id", entity.getEmployeeDistrict().getId()));
			}
			
			if (UtilString.isNotEmpty(entity.getEmpName()))
			{
				criteria.add(Restrictions.like("empName", entity.getEmpName(), MatchMode.ANYWHERE));
			}
			
			if (entity.getOnboardStatus() != null && entity.getOnboardStatus() > -1)
			{
				criteria.add(Restrictions.eq("onboardStatus", entity.getOnboardStatus()));
			}
			
			if (entity.getContractEndDate() != null)
			{
				criteria.add(Restrictions.le("contractEndDate", entity.getContractEndDate()));
			}
			
			if (entity.getPositiveDueDate() != null)
			{
				criteria.add(Restrictions.le("positiveDueDate", entity.getPositiveDueDate()));
			}
		}
		
		// criteria.add(Restrictions.eq("status", "Y"));
		
		return criteria;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmEmployee#getEmployeeByDistrictIdAndDeptId(org.shengrui.oa.model.hrm.ModelHrmEmployee)
	 */
	@Override
	public List<ModelHrmEmployee> getEmployeeByDistrictIdAndDeptId(
			ModelHrmEmployee entity) throws ServiceException 
	{
		
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployee.class);
		
		if (entity != null)
		{
			if (entity.getEmployeeDistrict() != null && entity.getEmployeeDistrict().getId() != null)
			{
				criteria.createCriteria("employeeDistrict").add(Restrictions.eq("id", entity.getEmployeeDistrict().getId()));
			}
			
			if (UtilString.isNotEmpty(entity.getEmpName()))
			{
				criteria.createCriteria("employeeDepartment").add(Restrictions.eq("id", entity.getEmployeeDepartment().getId()));
			}
		}
		
		try 
		{
			return this.daoHrmEmployee.getListByCriteria(criteria);
		} 
		catch (DAOException e) 
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmEmployee#getEmployeeByDistrictIdAndDeptId(java.lang.String, java.lang.String)
	 */
	@Override
	public List<ModelHrmEmployee> getEmployeeByDistrictIdAndDeptId(String depId, 
			String districtId) throws ServiceException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployee.class);
		
		criteria.createCriteria("employeeDistrict").add(Restrictions.eq("id", districtId));
		criteria.createCriteria("employeeDepartment").add(Restrictions.eq("id", depId));
		
		try 
		{
			return this.daoHrmEmployee.getListByCriteria(criteria);
		} 
		catch (DAOException e) 
		{
			throw new ServiceException(e);
		}	
	}

	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmEmployee#getEmployeeAmoutByDistrictIdAndDepId(java.lang.String, java.lang.String)
	 */
	@Override
	public int getEmployeeAmoutByDistrictIdAndDepId (String districtId, 
			String depId) throws ServiceException
	{
		try
		{
			List<Object> result = this.daoHrmEmployee.findListByNativeSQL(
					"SELECT COUNT(*) FROM app_hrm_employee WHERE dep_id=" + depId + " AND district_id =" + districtId);
			
			return result != null && result.size() > 0 ? Integer.valueOf(result.get(0).toString()) : 0;
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
		}
	}
	
	public void setDaoHrmEmployee(DAOHrmEmployee daoHrmEmployee)
	{
		this.daoHrmEmployee = daoHrmEmployee;
	}

	public DAOHrmEmployee getDaoHrmEmployee()
	{
		return daoHrmEmployee;
	}

	@Override
	public ModelHrmEmployee getEmployeeByEmpNo(String empNo)
			throws ServiceException {
		try {
			return this.daoHrmEmployee.getEmployeeByEmpNo(empNo);
		} catch (DAOException e) {
			throw new ServiceException(e);
		}
	}
}
