package org.shengrui.oa.service.admin.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOTaskPlanTrack;
import org.shengrui.oa.model.admin.ModelTaskPlanTrack;
import org.shengrui.oa.service.admin.ServiceTaskPlanTrack;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The task plan track service implementation.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceTaskPlanTrackImpl
extends ServiceGenericImpl<ModelTaskPlanTrack> implements ServiceTaskPlanTrack
{
	/**
	 * The task plan track repository
	 */
	private DAOTaskPlanTrack daoTaskPlanTrack;
	
	public ServiceTaskPlanTrackImpl(DAOTaskPlanTrack dao)
	{
		super(dao);
		
		this.daoTaskPlanTrack  = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.admin.ServiceTaskPlanTrack#getCurrentTrack(java.lang.String)
	 */
	@Override
	public ModelTaskPlanTrack getCurrentTrack (String taskId) throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelTaskPlanTrack.class);
			
			if (UtilString.isNotEmpty(taskId))
			{
				criteria.createCriteria("task").add(Restrictions.eq("id", taskId));
			}
			
			List<ModelTaskPlanTrack> result = this.daoTaskPlanTrack.getListByCriteria(criteria);
			
			int n = result.size();
			return result != null && result.size() > 0 ? result.get(n-1) : null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.admin.ServiceTaskPlanTrack#getPaginationByTaskId(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelTaskPlanTrack> getPaginationByTaskId(
			String taskId, PagingBean pagingBean) throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelTaskPlanTrack.class);
			
			if (UtilString.isNotEmpty(taskId))
			{
				criteria.createCriteria("task").add(Restrictions.eq("id", taskId));
			}
			
			return this.getAll(criteria, pagingBean);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	public DAOTaskPlanTrack getDaoTaskPlanTrack()
	{
		return daoTaskPlanTrack;
	}

	public void setDaoTaskPlanTrack(DAOTaskPlanTrack daoTaskPlanTrack)
	{
		this.daoTaskPlanTrack = daoTaskPlanTrack;
	}

}
