package org.shengrui.oa.service.hrm.impl;

import java.util.Date;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.hrm.DAOHrmJobHireIssue;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;
import org.shengrui.oa.model.hrm.ModelHrmJobHireIssue;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilDate;
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
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue#getNumHireEntry()
	 */
	@Override
	public int getNumHireEntry()  throws ServiceException
	{
		String sql = "SELECT count(*) as count FROM `app_hrm_hire_issue` h " +
							"LEFT JOIN `app_hrm_hire_entries` e ON h.hissue_id = e.issue_id WHERE e.cstatus = " + ModelHrmJobHireEntry.EHireEntryCStatus.TODO.getValue();
		
		return this.daoHrmJobHireIssue.getCountByNativeSQL(sql);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue#getNumHireIssue()
	 */
	@Override
	public int getNumHireIssue()  throws ServiceException
	{
		String sql = "SELECT count(*) as count FROM `app_hrm_hire_issue` h LEFT JOIN "+
							"`app_hrm_hire_interviews` i ON h.hissue_id = i.hissue_id " +
							"WHERE (h.current_status = " + ModelHrmJobHireIssue.EJobHireIssueStatus.TOPLAN.getValue() + 
								" OR (i.state = " + ModelHrmJobHireInterview.EInterviewState.ONGING.getValue() + 
								" OR i.interview_date >= '" + UtilDate.parseTime(new Date(), "yyyy-MM-dd") + " 00:00:00'))";
		
		return this.daoHrmJobHireIssue.getCountByNativeSQL(sql);
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
