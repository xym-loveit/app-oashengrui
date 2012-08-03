package org.shengrui.oa.service.admin.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOConferenceInfo;
import org.shengrui.oa.model.admin.ModelConference;
import org.shengrui.oa.service.admin.ServiceConferenceInfo;

import cn.trymore.core.exception.DAOException;
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
			if(entity.getConferenceName() != null && UtilString.isNotEmpty(entity.getConferenceName()))
			{
				criteria.add(Restrictions.like("conferenceName", entity.getConferenceName(), MatchMode.ANYWHERE));
			}
			if (entity.getDistrict() != null && UtilString.isNotEmpty(entity.getDistrict().getId()))
			{
				criteria.createCriteria("district").add(Restrictions.eq("id", entity.getDistrict().getId()));
			}
			
			if (entity.getDepartment() != null && UtilString.isNotEmpty(entity.getDepartment().getId()))
			{
				criteria.createCriteria("department").add(Restrictions.eq("id", entity.getDepartment().getId()));
			}
			
			if (entity.getType() != null && UtilString.isNotEmpty(entity.getType().getId()))
			{
				criteria.createCriteria("type").add(Restrictions.eq("id", entity.getType().getId()));
			}
			
			if (entity.getStatus() != null && UtilString.isNotEmpty(entity.getStatus()))
			{
				criteria.add(Restrictions.eq("status", entity.getStatus()));
			}
			
			if(entity.getStartDay()!=null)
			{
				criteria.add(Restrictions.ge("startDay", entity.getStartDay()));
			}
			if(entity.getEndDay()!=null)
			{
				criteria.add(Restrictions.le("startDay", entity.getEndDay()));
			}
			if(entity.getSponsor()!=null && UtilString.isNotEmpty(entity.getSponsor().getId()))
			{
				criteria.createCriteria("sponsor").add(Restrictions.eq("id", entity.getSponsor().getId()));
			}
			if(entity.getSponsor()!=null && UtilString.isNotEmpty(entity.getSponsor().getFullName()))
			{
				criteria.add(Restrictions.like("attendances", entity.getSponsor().getFullName(), MatchMode.ANYWHERE));
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

	@Override
	public int getNoSummaryConference()
			throws ServiceException {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelConference.class);
		criteria.add(Restrictions.isNull("summary"));
		criteria.add(Restrictions.ne("status", "3"));
		try {
			List<ModelConference> list = this.daoConferenceInfo.getListByCriteria(criteria);
			if(list != null)
				return list.size();
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
		return 0;
	}
}
