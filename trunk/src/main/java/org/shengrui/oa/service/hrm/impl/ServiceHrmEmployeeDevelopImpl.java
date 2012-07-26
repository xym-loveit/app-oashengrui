package org.shengrui.oa.service.hrm.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import org.shengrui.oa.dao.hrm.DAOHrmEmployeeDevelop;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.service.hrm.ServiceHrmEmployeeDevelop;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
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
			if (entity.getEmployee() != null)
			{
				if (entity.getEmployee().getId() != null)
				{
					criteria.createCriteria("employee").add(Restrictions.eq("id", entity.getEmployee().getId()));
				}
				else if (UtilString.isNotEmpty(entity.getEmployee().getFullName()))
				{
					criteria.createCriteria("employee").add(Restrictions.like("empName", entity.getEmployee().getFullName(), MatchMode.ANYWHERE));
				}
				else if (UtilString.isNotEmpty(entity.getEmployee().getEmpName()))
				{
					criteria.createCriteria("employee").add(Restrictions.like("empName", entity.getEmployee().getEmpName(), MatchMode.ANYWHERE));
				}
			}
			
			if (entity.getApplyFormType() != null)
			{
				criteria.createCriteria("applyFormType").add(Restrictions.eq("id", entity.getApplyFormType().getId()));
			}
			else if (entity.getApplyFormTypeId() != null && entity.getApplyFormTypeId() > -1)
			{
				criteria.createCriteria("applyFormType").add(Restrictions.eq("id", entity.getApplyFormTypeId().toString()));
			}
			
			if (entity.getFromDistrict() != null && entity.getFromDistrict().getId() != null)
			{
				criteria.createCriteria("fromDistrict").add(Restrictions.eq("id", entity.getFromDistrict().getId()));
			}
			else if (entity.getEmpDistrictId() != null && entity.getEmpDistrictId() > -1)
			{
				criteria.createCriteria("fromDistrict").add(Restrictions.eq("id", entity.getEmpDistrictId().toString()));
			}
			
			if (entity.getAuditState() != null && entity.getAuditState() > -1)
			{
				criteria.add(Restrictions.eq("auditState", entity.getAuditState()));
			}
			else if (entity.getCondAuditStates() != null && entity.getCondAuditStates().length > 0)
			{
				if (entity.getCondAuditStates().length == 1 && entity.getCondAuditStates()[0] == null)
				{
					criteria.add(Restrictions.isNull("auditState"));
				}	
				else
				{
					criteria.add(Restrictions.in("auditState", entity.getCondAuditStates()));
				}
			}
		}
		
		criteria.addOrder(Order.desc("applyDate"));
		
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

	@Override
	public PaginationSupport<ModelHrmEmployeeDevelop> finanContract(
			ModelHrmEmployeeDevelop entity, PagingBean pagingBean)
			throws ServiceException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanContract.class);
		criteria.add(Restrictions.isNull("auditState"));
		
		return this.getAll(criteria, pagingBean);
	}

	@Override
	public PaginationSupport<ModelHrmEmployeeDevelop> finanContractRec(
			ModelHrmEmployeeDevelop entity, PagingBean pagingBean)
			throws ServiceException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanContract.class);
		criteria.add(Restrictions.in("auditState", new Integer[]{2,3,4}));
		return this.getAll(criteria, pagingBean);
	}
}
