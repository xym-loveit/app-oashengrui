package org.shengrui.oa.service.admin.impl;

import org.hibernate.Hibernate;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOTaskPlan;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.service.admin.ServiceTaskPlan;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
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
	public ServiceTaskPlanImpl(DAOTaskPlan dao)
	{
		super(dao);
		this.daoTaskPlan = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.admin.ServiceTaskPlan#getPaginationByEntity(org.shengrui.oa.model.admin.ModelTaskPlan, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelTaskPlan> getPaginationByEntity(ModelTaskPlan entity, 
			PagingBean pagingBean)
			throws ServiceException
	{
		return this.getPaginationByEntity(entity, null, null, pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.admin.ServiceTaskPlan#getByUser(org.shengrui.oa.model.hrm.ModelHrmEmployee, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelTaskPlan> getPaginationByEntity (ModelTaskPlan entity, String employeeId, 
			Boolean filterByOriginator, PagingBean pagingBean)
			throws ServiceException
	{
		return this.getAll(this.getCriterias(entity, employeeId, filterByOriginator), pagingBean);
	}
	
	
	/**
	 * Obtains the criteria with the specified entity.
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias (ModelTaskPlan entity, String empId, Boolean filterByOriginator)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelTaskPlan.class);
		
		if (entity != null)
		{
			if (entity.getTaskStatus() != null && entity.getTaskStatus() > -1)
			{
				criteria.add(Restrictions.eq("taskStatus", entity.getTaskStatus()));
			}
			
			if (entity.getAuditStatus() != null)
			{
				criteria.add(Restrictions.eq("auditStatus", entity.getAuditStatus()));
			}
			
			if (entity.getTaskCharger() != null)
			{
				criteria.createCriteria("taskCharger").add(Restrictions.eq("id", entity.getTaskCharger().getId()));
			}
			
			if (UtilString.isNotEmpty(entity.getTaskName()))
			{
				criteria.add(Restrictions.like("taskName", entity.getTaskName(), MatchMode.ANYWHERE));
			}
			
			if (entity.getTaskType() != null && entity.getTaskType().getId() != null)
			{
				criteria.createCriteria("taskType").add(Restrictions.eq("id", entity.getTaskType().getId()));
			}
			else if (entity.getTaskTypeId() != null && entity.getTaskTypeId() > -1)
			{
				criteria.createCriteria("taskType").add(Restrictions.eq("id", entity.getTaskTypeId().toString()));
			}
			
			if (UtilString.isNotEmpty(empId))
			{
				if (filterByOriginator)
				{
					criteria.createCriteria("taskOriginator").add(Restrictions.eq("id", empId));
				}
				else
				{
					criteria.add(Restrictions.or(
							Restrictions.sqlRestriction("task_charger = ?", empId, Hibernate.STRING), 
							Restrictions.sqlRestriction("? in (`task_participant_ids`)", empId, Hibernate.STRING)));
				}
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

	@Override
	public PaginationSupport<ModelTaskPlan> getTaskPlanApproval(
			ModelTaskPlan entity, PagingBean pagingBean)
			throws ServiceException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelTaskPlan.class);
		criteria.add(Restrictions.isNull("auditStatus"));
		return this.getAll(criteria, pagingBean);
	}

	@Override
	public PaginationSupport<ModelTaskPlan> getTaskPlanApprovalRec(
			ModelTaskPlan entity, PagingBean pagingBean)
			throws ServiceException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelTaskPlan.class);
		criteria.add(Restrictions.in("auditStatus", new Integer[]{2,3,4}));
		return this.getAll(criteria, pagingBean);
	}
}
