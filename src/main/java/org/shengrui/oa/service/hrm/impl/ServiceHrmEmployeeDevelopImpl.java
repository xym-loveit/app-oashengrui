package org.shengrui.oa.service.hrm.impl;

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
	
	
	public void setdaoHrmEmployeeDevelop(DAOHrmEmployeeDevelop daoHrmEmployeeDevelop)
	{
		this.daoHrmEmployeeDevelop = daoHrmEmployeeDevelop;
	}

	public DAOHrmEmployeeDevelop getdaoHrmEmployeeDevelop()
	{
		return daoHrmEmployeeDevelop;
	}
	

	@Override
	public PaginationSupport<ModelHrmEmployeeDevelop> getEmployeeDevelopInfoPagination(
			ModelHrmEmployeeDevelop entity, PagingBean pagingBean)
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
	private DetachedCriteria getCriterias(ModelHrmEmployeeDevelop entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmEmployeeDevelop.class);

		if (entity != null)
		{
			if (entity.getApplyFormType() > -1)
			{
				criteria.add(Restrictions.eq("applyFormType", entity.getApplyFormType()));
			}
			if (entity.getFromDistrict() != null && entity.getFromDistrict().getId() != null)
			{
				criteria.createCriteria("fromDistrict").add(Restrictions.eq("id", entity.getFromDistrict().getId()));
			}
			if (entity.getAuditState() > -1)
			{
				criteria.add(Restrictions.eq("auditState", entity.getAuditState()));
			}
		}
		
		 criteria.add(Restrictions.eq("status", "Y"));
		
		return criteria;
	}

}
