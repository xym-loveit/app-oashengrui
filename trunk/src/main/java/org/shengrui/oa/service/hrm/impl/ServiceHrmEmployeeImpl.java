package org.shengrui.oa.service.hrm.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import org.shengrui.oa.dao.hrm.DAOHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.service.hrm.ServiceHrmEmployee;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilDate;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;


public class ServiceHrmEmployeeImpl
extends ServiceGenericImpl<ModelHrmEmployee> implements ServiceHrmEmployee
{
	
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
	
	public void setDaoHrmEmployee(DAOHrmEmployee daoHrmEmployee)
	{
		this.daoHrmEmployee = daoHrmEmployee;
	}

	public DAOHrmEmployee getDaoHrmEmployee()
	{
		return daoHrmEmployee;
	}
	

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
			if (entity.getEmployeeDistrict() != null && UtilString.isNotEmpty(entity.getEmployeeDistrict().getId()))
			{
				criteria.createCriteria("employeeDistrict").add(Restrictions.eq("id", entity.getEmployeeDistrict().getId()));
			}
			
			if (UtilString.isNotEmpty(entity.getEmpName()))
			{
				criteria.add(Restrictions.like("empName", entity.getEmpName(), MatchMode.ANYWHERE));
			}
			
			if (entity.getOnboardStatus() > -1)
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
		criteria.add(Restrictions.eq("status", "Y"));
		return criteria;
	}

}
