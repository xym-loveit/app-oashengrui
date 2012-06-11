package org.shengrui.oa.service.hrm.impl;

<<<<<<< .mine
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
=======
import org.hibernate.criterion.DetachedCriteria;
>>>>>>> .r69
import org.shengrui.oa.dao.hrm.DAOHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.service.hrm.ServiceHrmEmployee;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
<<<<<<< .mine
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
=======
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
>>>>>>> .r69

public class ServiceHrmEmployeeImpl
extends ServiceGenericImpl<ModelHrmEmployee> implements ServiceHrmEmployee
{
	
	private DAOHrmEmployee daoHrmEmployee;
	
	public ServiceHrmEmployeeImpl(DAOHrmEmployee dao)
	{
		super(dao);
		
		this.daoHrmEmployee = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmEmployee#getPagination(org.shengrui.oa.model.hrm.ModelHrmEmployee, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmEmployee> getPagination(
			ModelHrmEmployee entity, PagingBean pagingBean)
			throws ServiceException
	{
		return this.getAll(this.getCriteria(entity), pagingBean);
	}
	
	/**
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriteria (ModelHrmEmployee entity)
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
//			if (entity.getJobHireDistrict() != null && UtilString.isNotEmpty(entity.getJobHireDistrict().getId()))
//			{
//				criteria.createCriteria("jobHireDistrict").add(Restrictions.eq("id", entity.getJobHireDistrict().getId()));
//			}
//			
//			if (entity.getJobHireDepartment() != null && UtilString.isNotEmpty(entity.getJobHireDepartment().getId()))
//			{
//				criteria.createCriteria("jobHireDepartment").add(Restrictions.eq("id", entity.getJobHireDepartment().getId()));
//			}
//			
//			if (UtilString.isNotEmpty(entity.getJobHireTitle()))
//			{
//				criteria.add(Restrictions.like("jobHireTitle", entity.getJobHireTitle(), MatchMode.ANYWHERE));
//			}
//			
//			if (entity.getIsOpen() != null && entity.getIsOpen() > -1)
//			{
//				criteria.add(Restrictions.eq("isOpen", entity.getIsOpen()));
//			}
		}
		return criteria;
	}

}
