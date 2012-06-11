package org.shengrui.oa.service.hrm.impl;

import org.hibernate.criterion.DetachedCriteria;
<<<<<<< .mine
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import org.hibernate.criterion.DetachedCriteria;

=======
>>>>>>> .r78
import org.shengrui.oa.dao.hrm.DAOHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.service.hrm.ServiceHrmEmployee;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
<<<<<<< .mine

import cn.trymore.core.util.UtilString;
=======
>>>>>>> .r78
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
<<<<<<< .mine

import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
=======
>>>>>>> .r78


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
