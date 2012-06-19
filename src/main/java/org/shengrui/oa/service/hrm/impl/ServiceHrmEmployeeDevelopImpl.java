package org.shengrui.oa.service.hrm.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import org.shengrui.oa.dao.hrm.DAOHrmEmployeeDevelop;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.service.hrm.ServiceHrmEmployeeDevelop;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;


public class ServiceHrmEmployeeDevelopImpl
extends ServiceGenericImpl<ModelHrmEmployeeDevelop> implements ServiceHrmEmployeeDevelop
{
	
	private DAOHrmEmployeeDevelop daoHrmEmployeeDevelop;
	
	public ServiceHrmEmployeeDevelopImpl(DAOHrmEmployeeDevelop dao)
	{
		super(dao);
		
		this.daoHrmEmployeeDevelop = dao;
	}
	
	/**
	 * 
	 * @param entity
	 * @return
	 */
	protected DetachedCriteria getCriteria (ModelHrmEmployeeDevelop entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployeeDevelop.class);
		
		// TODO Criteria conditions needed here.
		
		return criteria;
	}
	
	public void setdaoHrmEmployeeDevelop(DAOHrmEmployeeDevelop daoHrmEmployeeDevelop)
	{
		this.daoHrmEmployeeDevelop = daoHrmEmployeeDevelop;
	}

	public DAOHrmEmployeeDevelop getdaoHrmEmployeeDevelop()
	{
		return daoHrmEmployeeDevelop;
	}
	

	@Override
	public PaginationSupport<ModelHrmEmployeeDevelop> getEmployeeDevelopInfoPagination(
			ModelHrmEmployeeDevelop entity, PagingBean pagingBean)
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
	private DetachedCriteria getCriterias(ModelHrmEmployeeDevelop entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployeeDevelop.class);
		
		if (entity != null)
		{
		}
		
		 criteria.add(Restrictions.eq("status", "Y"));
		
		return criteria;
	}

}
