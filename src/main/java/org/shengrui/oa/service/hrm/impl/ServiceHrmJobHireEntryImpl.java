package org.shengrui.oa.service.hrm.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.hrm.DAOHrmJobHireEntry;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireEntry;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class ServiceHrmJobHireEntryImpl
extends ServiceGenericImpl<ModelHrmJobHireEntry> implements ServiceHrmJobHireEntry
{
	
	private DAOHrmJobHireEntry daoHrmJobHireEntry;
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireEntry#getPaginationByJobId(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmJobHireEntry> getPaginationByJobId (String jobId, 
			PagingBean pagingBean) throws ServiceException
	{
		if (UtilString.isNotEmpty(jobId))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmJobHireEntry.class);
			criteria.createCriteria("jobHireIssue").createCriteria("jobHire").add(Restrictions.eq("id", jobId));
			return this.getAll(criteria, pagingBean);
		}
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireEntry#getPaginationByEntity(org.shengrui.oa.model.hrm.ModelHrmJobHireEntry, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmJobHireEntry> getPaginationByEntity (ModelHrmJobHireEntry entity, 
			PagingBean pagingBean) throws ServiceException
	{
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/**
	 * Obtains the criterias with the specified entity.
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias (ModelHrmJobHireEntry entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmJobHireEntry.class);
		
		if (entity != null)
		{
			if (entity.getFinalStatus() != null && entity.getFinalStatus() > -1)
			{
				criteria.add(Restrictions.eq("finalStatus", entity.getFinalStatus()));
			}
			
			if (entity.getInspectStatus() != null && entity.getInspectStatus() > -1)
			{
				criteria.add(Restrictions.eq("inspectStatus", entity.getInspectStatus()));
			}
			
			if (entity.getEntryDistrict() != null && entity.getEntryDistrict().getId() != null)
			{
				criteria.createCriteria("entryDistrict").add(Restrictions.eq("id", entity.getEntryDistrict().getId()));
			}
			
			if (entity.getCurrentStatus() != null && entity.getCurrentStatus() > -1)
			{
				criteria.add(Restrictions.eq("currentStatus", entity.getCurrentStatus()));
			}
			
		}
		
		return criteria;
	}
	
	public ServiceHrmJobHireEntryImpl(DAOHrmJobHireEntry dao)
	{
		super(dao);
		
		this.daoHrmJobHireEntry = dao;
	}

	public DAOHrmJobHireEntry getDaoHrmJobHireEntry()
	{
		return daoHrmJobHireEntry;
	}

	public void setDaoHrmJobHireEntry(DAOHrmJobHireEntry daoHrmJobHireEntry)
	{
		this.daoHrmJobHireEntry = daoHrmJobHireEntry;
	}

}
