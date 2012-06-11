package org.shengrui.oa.service.hrm.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.shengrui.oa.dao.hrm.DAOHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.service.hrm.ServiceHrmEmployee;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
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

}
