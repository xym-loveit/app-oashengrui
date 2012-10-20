package org.shengrui.oa.service.admin.impl;

import org.hibernate.Hibernate;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.Type;
import org.shengrui.oa.dao.admin.DAOTaskPlan;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.service.admin.ServiceTaskPlan;
import org.shengrui.oa.util.UtilDateTime;

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
				if (entity.getTaskStatus().equals(ModelTaskPlan.ETaskStatus.DONE.getValue()))
				{
					// 已完成
					criteria.add(Restrictions.eq("taskStatus", entity.getTaskStatus()));
				}
				else
				{
					if (entity.getTaskStatus().equals(ModelTaskPlan.ETaskStatus.NOTSTART.getValue()))
					{
						// 未开始
						criteria.add(Restrictions.or(
								Restrictions.isNull("taskStatus"),
								Restrictions.ne("taskStatus", ModelTaskPlan.ETaskStatus.DONE.getValue())
						));
						criteria.add(Restrictions.sqlRestriction(
								"task_planStartDate > ?", UtilDateTime.nowDateString(), Hibernate.STRING));
					}
					else if (entity.getTaskStatus().equals(ModelTaskPlan.ETaskStatus.ONGOING.getValue()))
					{
						// 进行中
						criteria.add(Restrictions.or(
								Restrictions.isNull("taskStatus"),
								Restrictions.ne("taskStatus", ModelTaskPlan.ETaskStatus.DONE.getValue())
						));
						criteria.add(Restrictions.sqlRestriction(
								"task_planStartDate <= ? and task_planEndDate >= ? ", 
								new Object[] {UtilDateTime.nowDateString(), UtilDateTime.nowDateString()}, 
								new Type[] {Hibernate.STRING, Hibernate.STRING}));
					}
					else if (entity.getTaskStatus().equals(ModelTaskPlan.ETaskStatus.POSTPONED.getValue()))
					{
						// 已延期
						criteria.add(Restrictions.or(
								Restrictions.isNull("taskStatus"),
								Restrictions.ne("taskStatus", ModelTaskPlan.ETaskStatus.DONE.getValue())
						));
						criteria.add(Restrictions.sqlRestriction(
								"task_planEndDate < ?", UtilDateTime.nowDateString(), Hibernate.STRING));
					} 
				}
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
							Restrictions.sqlRestriction("task_charger = ?", Integer.valueOf(empId), Hibernate.INTEGER), 
							Restrictions.sqlRestriction("FIND_IN_SET(?, `task_participant_ids`) > 0", empId, Hibernate.STRING)));
				}
			}
		}
		
		return criteria;
	}

	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.admin.ServiceTaskPlan#getTaskPlanApproval(org.shengrui.oa.model.admin.ModelTaskPlan, java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelTaskPlan> getTaskPlanApproval(ModelTaskPlan entity, 
			String query, PagingBean pagingBean) throws ServiceException 
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelTaskPlan.class);
		criteria.add(Restrictions.isNull("auditStatus"));
		
		if (UtilString.isNotEmpty(query))
		{
			if (query.trim().toLowerCase().startsWith("and"))
			{
				query = query.toLowerCase().replaceFirst("and", "");
			}
			
			criteria.add(Restrictions.sqlRestriction(query));
		}
		
		return this.getAll(criteria, pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.admin.ServiceTaskPlan#getTaskPlanApprovalRec(org.shengrui.oa.model.admin.ModelTaskPlan, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelTaskPlan> getTaskPlanApprovalRec(ModelTaskPlan entity, 
			PagingBean pagingBean) throws ServiceException 
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelTaskPlan.class);
		criteria.add(Restrictions.in("auditStatus", new Integer[]{2,3,4}));
		return this.getAll(criteria, pagingBean);
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
