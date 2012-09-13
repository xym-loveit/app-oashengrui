package org.shengrui.oa.service.hrm.impl;

import org.hibernate.Hibernate;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.hrm.DAOHrmJobHireInfo;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo;
import org.shengrui.oa.util.ContextUtil;

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
	public PaginationSupport<ModelHrmJobHireInfo> getPaginationByEntity(
			ModelHrmJobHireInfo entity, PagingBean pagingBean)
			throws ServiceException
	{
		return this.getPaginationByEntity(entity, false, pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo#getPaginationByEntity(org.shengrui.oa.model.hrm.ModelHrmJobHireInfo, boolean, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmJobHireInfo> getPaginationByEntity(
			ModelHrmJobHireInfo entity, boolean visibility,
			PagingBean pagingBean) throws ServiceException
	{
		return this.getAll(this.getCriterias(entity, visibility), pagingBean);
	}
	
	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias(ModelHrmJobHireInfo entity, boolean visiblity)
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
			
			if (entity.getSearchStatusCondition() != null && entity.getSearchStatusCondition().length > 0)
			{
				criteria.add(Restrictions.in("status", entity.getSearchStatusCondition()));
			}
			else
			{
				if (entity.getStatus() != null && entity.getStatus() > -1)
				{
					criteria.add(Restrictions.eq("status", entity.getStatus()));
				}
			}
			
			if (entity.getIsOpen() != null && entity.getIsOpen() > -1)
			{
				if (entity.getIsOpen().equals(ModelHrmJobHireInfo.EJobHireOpen.CLOSED.getValue()))
				{
					criteria.add(Restrictions.or(
							Restrictions.eq("isOpen", entity.getIsOpen()),
							Restrictions.isNull("isOpen")));
				}
				else
				{
					criteria.add(Restrictions.eq("isOpen", entity.getIsOpen()));
				}
			}
		}
		
		// 招聘范围过滤...
		if (visiblity)
		{
			criteria.add(Restrictions.sqlRestriction(
					"(hjob_visible_districtid IS NULL OR hjob_visible_districtid = '' OR FIND_IN_SET( ?, `hjob_visible_districtid` ) > 0)", ContextUtil.getCurrentUser().getDistrictId(), Hibernate.STRING));
		}
		
		criteria.addOrder(Order.desc("jobHireEndDate"));
		
		return criteria;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo#getNumApprovals()
	 */
	@Override
	public int getNumApprovals () throws ServiceException
	{
		String sql = "SELECT count(*) as count FROM ` app_hrm_hire_job` j " +
				"WHERE j.status IN (" + 
					ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue() + "," + 
					ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue() + ")";
		
		return this.daoHrmJobHireInfo.getCountByNativeSQL(sql);
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
