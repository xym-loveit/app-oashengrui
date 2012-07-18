package org.shengrui.oa.service.hrm.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import org.shengrui.oa.dao.hrm.DAOHrmEmployeeDevelop;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.service.hrm.ServiceHrmEmployeeDevelop;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class ServiceHrmEmployeeDevelopImpl
extends ServiceGenericImpl<ModelHrmEmployeeDevelop> implements ServiceHrmEmployeeDevelop
{
	
	private DAOHrmEmployeeDevelop daoHrmEmployeeDevelop;
	
	public ServiceHrmEmployeeDevelopImpl(DAOHrmEmployeeDevelop dao)
	{
		super(dao);
		
		this.daoHrmEmployeeDevelop = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmEmployeeDevelop#getEmployeeDevelopInfoPagination(org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmEmployeeDevelop> getEmployeeDevelopInfoPagination(
			ModelHrmEmployeeDevelop entity, PagingBean pagingBean)
			throws ServiceException
	{
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmEmployeeDevelop#getByFormNo(java.lang.String)
	 */
	@Override
	public ModelHrmEmployeeDevelop getByFormNo(String formNo)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployeeDevelop.class);
			criteria.add(Restrictions.eq("formNo", formNo));
			
			List<ModelHrmEmployeeDevelop> result = this.daoHrmEmployeeDevelop.getListByCriteria(criteria);
			return result != null && result.size() > 0 ? result.get(0) : null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias(ModelHrmEmployeeDevelop entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployeeDevelop.class);

		if (entity != null)
		{
			if (entity.getApplyFormType() != null && entity.getApplyFormType().getId() != null)
			{
				criteria.createCriteria("applyFormType").add(Restrictions.eq("id", entity.getApplyFormType().getId()));
			}
			
			if (entity.getFromDistrict() != null && entity.getFromDistrict().getId() != null)
			{
				criteria.createCriteria("fromDistrict").add(Restrictions.eq("id", entity.getFromDistrict().getId()));
			}
			
			if (entity.getAuditState() != null && entity.getAuditState() > -1)
			{
				criteria.add(Restrictions.eq("auditState", entity.getAuditState()));
			}
		}
		
		return criteria;
	}
	
	public void setdaoHrmEmployeeDevelop(DAOHrmEmployeeDevelop daoHrmEmployeeDevelop)
	{
		this.daoHrmEmployeeDevelop = daoHrmEmployeeDevelop;
	}

	public DAOHrmEmployeeDevelop getdaoHrmEmployeeDevelop()
	{
		return daoHrmEmployeeDevelop;
	}
}
