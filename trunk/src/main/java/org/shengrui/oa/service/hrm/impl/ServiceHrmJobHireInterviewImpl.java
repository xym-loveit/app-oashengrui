package org.shengrui.oa.service.hrm.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.hrm.DAOHrmJobHireInterview;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInterview;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class ServiceHrmJobHireInterviewImpl
extends ServiceGenericImpl<ModelHrmJobHireInterview> implements ServiceHrmJobHireInterview
{
	private DAOHrmJobHireInterview daoHrmJobHireInterview;
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireInterview#getPaginationByIssueId(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmJobHireInterview> getPaginationByIssueId(
			String issueId, PagingBean pagingBean) throws ServiceException
	{
		if (UtilString.isNotEmpty(issueId))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmJobHireInterview.class);
			criteria.createCriteria("jobHireIssue").add(Restrictions.eq("id", issueId));
			return this.getAll(criteria, pagingBean);
		}
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireInterview#getEntityByIssueIdAndSessionNo(java.lang.String, java.lang.Integer)
	 */
	@Override
	public ModelHrmJobHireInterview getByIssueAndSessionNo (String issueId,
			Integer sessionNo) throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmJobHireInterview.class);
			criteria.add(Restrictions.eq("sessionSN", sessionNo));
			criteria.createCriteria("jobHireIssue").add(Restrictions.eq("id", issueId));
			
			List<ModelHrmJobHireInterview> result = 
					this.daoHrmJobHireInterview.getListByCriteria(criteria);
			
			return result != null && result.size() > 0 ? result.get(0) : null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/**
	 * 
	 * @param entity
	 * @return
	 */
	protected DetachedCriteria getCriterias (ModelHrmJobHireInterview entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmJobHireInterview.class);
		
		if (entity != null)
		{
			// TODO.
		}
		
		return criteria;
	}
	
	public ServiceHrmJobHireInterviewImpl(DAOHrmJobHireInterview dao)
	{
		super(dao);
		
		this.setDaoHrmJobHireInterview(dao);
	}

	public void setDaoHrmJobHireInterview(DAOHrmJobHireInterview daoHrmJobHireInterview)
	{
		this.daoHrmJobHireInterview = daoHrmJobHireInterview;
	}

	public DAOHrmJobHireInterview getDaoHrmJobHireInterview()
	{
		return daoHrmJobHireInterview;
	}

}
