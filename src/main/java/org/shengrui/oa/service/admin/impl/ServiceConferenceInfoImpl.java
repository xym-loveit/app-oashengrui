package org.shengrui.oa.service.admin.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOConferenceInfo;
import org.shengrui.oa.model.admin.ModelConference;
import org.shengrui.oa.service.admin.ServiceConferenceInfo;

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
public class ServiceConferenceInfoImpl
extends ServiceGenericImpl<ModelConference> implements ServiceConferenceInfo
{
	/**
	 * The repository for job hire information.
	 */
	private DAOConferenceInfo daoConferenceInfo;
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo#getHireJobPagination(org.shengrui.oa.model.hrm.ModelHrmJobHireInfo, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelConference> getPaginationByEntity(
			ModelConference entity, PagingBean pagingBean)
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
	private DetachedCriteria getCriterias(ModelConference entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelConference.class);
		
		if (entity != null)
		{
			if (entity.getDistrict() != null && UtilString.isNotEmpty(entity.getDistrict().getId()))
			{
				criteria.createCriteria("district").add(Restrictions.eq("id", entity.getDistrict().getId()));
			}
			
			if (entity.getDepartment() != null && UtilString.isNotEmpty(entity.getDepartment().getId()))
			{
				criteria.createCriteria("department").add(Restrictions.eq("id", entity.getDepartment().getId()));
			}
			
			if (UtilString.isNotEmpty(entity.getType()))
			{
				criteria.add(Restrictions.eq("type", entity.getType()));
			}
			
			if (entity.getStatus() != null)
			{
				criteria.add(Restrictions.eq("status", entity.getStatus()));
			}
			
			if(entity.getStartDay()!=null)
			{
				criteria.add(Restrictions.ge("startDay", entity.getStartDay()));
			}
			if(entity.getEndDay()!=null)
			{
				criteria.add(Restrictions.le("endDay", entity.getEndDay()));
			}
		}
		
		criteria.addOrder(Order.desc("startDay"));
		criteria.addOrder(Order.desc("startHour"));
		criteria.addOrder(Order.desc("startMinute"));
		
		return criteria;
	}
	
	public ServiceConferenceInfoImpl(DAOConferenceInfo dao)
	{
		super(dao);
		
		this.daoConferenceInfo = dao;
	}

	/**
	 * @return the daoConferenceInfo
	 */
	public DAOConferenceInfo getDaoConferenceInfo() {
		return daoConferenceInfo;
	}

	/**
	 * @param daoConferenceInfo the daoConferenceInfo to set
	 */
	public void setDaoConferenceInfo(DAOConferenceInfo daoConferenceInfo) {
		this.daoConferenceInfo = daoConferenceInfo;
	}
}
