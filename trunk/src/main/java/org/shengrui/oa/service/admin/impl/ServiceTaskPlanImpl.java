package org.shengrui.oa.service.admin.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOTaskPlan;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.service.admin.ServiceTaskPlan;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 
 * @author x36zhao
 *
 */
public class ServiceTaskPlanImpl
extends ServiceGenericImpl<ModelTaskPlan> implements ServiceTaskPlan
{
	/**
	 * The task plan repository
	 */
	private DAOTaskPlan daoTaskPlan;
	
	/**
	 * The constructor.
	 * 
	 * @param dao
	 */
	public ServiceTaskPlanImpl(DAOGeneric<ModelTaskPlan> dao)
	{
		super(dao);
		
		this.dao = daoTaskPlan;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.admin.ServiceTaskPlan#getByUser(org.shengrui.oa.model.hrm.ModelHrmEmployee, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelTaskPlan> getByUser(
			ModelHrmEmployee employee, PagingBean pagingBean)
			throws ServiceException
	{
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.admin.ServiceTaskPlan#getPaginationByEntity(org.shengrui.oa.model.admin.ModelTaskPlan, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelTaskPlan> getPaginationByEntity(
			ModelTaskPlan entity, PagingBean pagingBean)
			throws ServiceException
	{
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/**
	 * Obtains the criteria with the specified entity.
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias (ModelTaskPlan entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelTaskPlan.class);
		
		if (entity != null)
		{
			if (entity.getTaskStatus() != null)
			{
				criteria.add(Restrictions.eq("taskStatus", entity.getTaskStatus()));
			}
			
			if (entity.getAuditStatus() != null)
			{
				criteria.add(Restrictions.eq("auditStatus", entity.getAuditStatus()));
			}
			
		}
		
		return criteria;
	}

	public void setDaoTaskPlan(DAOTaskPlan daoTaskPlan)
	{
		this.daoTaskPlan = daoTaskPlan;
	}

	public DAOTaskPlan getDaoTaskPlan()
	{
		return daoTaskPlan;
	}
}
