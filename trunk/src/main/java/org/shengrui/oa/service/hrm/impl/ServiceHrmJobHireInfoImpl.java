package org.shengrui.oa.service.hrm.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.hrm.DAOHrmJobHireInfo;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The implementation for job hire information.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceHrmJobHireInfoImpl
extends ServiceGenericImpl<ModelHrmJobHireInfo> implements ServiceHrmJobHireInfo
{
	/**
	 * The repository for job hire information.
	 */
	private DAOHrmJobHireInfo daoHrmJobHireInfo;
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo#getHireJobPagination(org.shengrui.oa.model.hrm.ModelHrmJobHireInfo, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmJobHireInfo> getHireJobPagination(
			ModelHrmJobHireInfo entity, PagingBean pagingBean)
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
	private DetachedCriteria getCriterias(ModelHrmJobHireInfo entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmJobHireInfo.class);
		
		if (entity != null)
		{
			if (entity.getJobHireDistrict() != null && UtilString.isNotEmpty(entity.getJobHireDistrict().getId()))
			{
				criteria.createCriteria("jobHireDistrict").add(Restrictions.eq("id", entity.getJobHireDistrict().getId()));
			}
			
			if (entity.getJobHireDepartment() != null && UtilString.isNotEmpty(entity.getJobHireDepartment().getId()))
			{
				criteria.createCriteria("jobHireDepartment").add(Restrictions.eq("id", entity.getJobHireDepartment().getId()));
			}
			
			if (UtilString.isNotEmpty(entity.getJobHireTitle()))
			{
				criteria.add(Restrictions.like("jobHireTitle", entity.getJobHireTitle(), MatchMode.ANYWHERE));
			}
			
			if (entity.getIsOpen() != null && entity.getIsOpen() > -1)
			{
				criteria.add(Restrictions.eq("isOpen", entity.getIsOpen()));
			}
		}
		return criteria;
	}
	
	public ServiceHrmJobHireInfoImpl(DAOHrmJobHireInfo dao)
	{
		super(dao);
		
		this.daoHrmJobHireInfo = dao;
	}
	
	public DAOHrmJobHireInfo getDaoHrmJobHireInfo()
	{
		return daoHrmJobHireInfo;
	}

	public void setDaoHrmJobHireInfo(DAOHrmJobHireInfo daoHrmJobHireInfo)
	{
		this.daoHrmJobHireInfo = daoHrmJobHireInfo;
	}

}
