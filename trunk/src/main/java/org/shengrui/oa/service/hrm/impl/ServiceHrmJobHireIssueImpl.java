package org.shengrui.oa.service.hrm.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.hrm.DAOHrmJobHireIssue;
import org.shengrui.oa.model.hrm.ModelHrmJobHireIssue;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class ServiceHrmJobHireIssueImpl
extends ServiceGenericImpl<ModelHrmJobHireIssue> implements ServiceHrmJobHireIssue
{

	private DAOHrmJobHireIssue daoHrmJobHireIssue;
	
	public ServiceHrmJobHireIssueImpl(DAOHrmJobHireIssue dao)
	{
		super(dao);
		
		this.daoHrmJobHireIssue = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue#getPaginationByJobId(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmJobHireIssue> getPaginationByJobId(
			String jobId, PagingBean pagingBean) throws ServiceException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmJobHireIssue.class);
		criteria.createCriteria("jobHire").add(Restrictions.eq("id", jobId));
		return this.getAll(criteria, pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue#getPaginationByUser(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmJobHireIssue> getPaginationByUser (String userId, 
			PagingBean pagingBean) throws ServiceException
	{
		if (UtilString.isNotEmpty(userId))
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmJobHireIssue.class);
			criteria.createCriteria("candidate").add(Restrictions.eq("id", userId));
			criteria.addOrder(Order.desc("applyDateTime"));
			return this.getAll(criteria, pagingBean);
		}
		return null;
	}
	
	public void getNumHireEntry() 
	{
		// SELECT count(*) as count FROM `app_hrm_hire_issue` h left join `app_hrm_hire_entries` e on h.hissue_id = e.issue_id WHERE e.cstatus = 1
	}
	
	public void getNumHireIssue()
	{
		// SELECT count(*) as count FROM `app_hrm_hire_issue` h left join `app_hrm_hire_interviews` i on h.hissue_id = i.hissue_id WHERE (h.current_status = 1 or (i.state = 1 or i.interview_date >= '2012-09-10 00:00:00'))
	}

	public void setDaoHrmJobHireIssue(DAOHrmJobHireIssue daoHrmJobHireIssue)
	{
		this.daoHrmJobHireIssue = daoHrmJobHireIssue;
	}

	public DAOHrmJobHireIssue getDaoHrmJobHireIssue()
	{
		return daoHrmJobHireIssue;
	}

}
