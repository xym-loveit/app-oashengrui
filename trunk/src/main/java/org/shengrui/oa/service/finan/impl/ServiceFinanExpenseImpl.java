package org.shengrui.oa.service.finan.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import org.shengrui.oa.dao.finan.DAOFinanExpense;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.service.finan.ServiceFinanExpense;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class ServiceFinanExpenseImpl
extends ServiceGenericImpl<ModelFinanExpense> implements ServiceFinanExpense
{
	
	private DAOFinanExpense daoFinanExpense;
	
	public ServiceFinanExpenseImpl(DAOFinanExpense dao)
	{
		super(dao);
		
		this.setDaoFinanExpense(dao);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanExpense#getFinanExpenseInfoPagination(org.shengrui.oa.model.finan.ModelFinanExpense, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelFinanExpense> getFinanExpenseInfoPagination(
			ModelFinanExpense entity, PagingBean pagingBean)
			throws ServiceException
	{
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanExpense#getByFormNo(java.lang.String)
	 */
	@Override
	public ModelFinanExpense getByFormNo(String formNo) throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanExpense.class);
			criteria.add(Restrictions.eq("formNo", formNo));
			
			List<ModelFinanExpense> result = this.daoFinanExpense.getListByCriteria(criteria);
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
	private DetachedCriteria getCriterias(ModelFinanExpense entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanExpense.class);

		if (entity != null)
		{
			if (entity.getApplyFormType() != null)
			{
				criteria.createCriteria("applyFormType").add(Restrictions.eq("id", entity.getApplyFormType().getId()));
			}
			else if (entity.getApplyFormTypeId() != null && entity.getApplyFormTypeId() > -1)
			{
				criteria.createCriteria("applyFormType").add(Restrictions.eq("id", entity.getApplyFormTypeId().toString()));
			}
			
			if (entity.getEmpDistrict() != null)
			{
				criteria.createCriteria("empDistrict").add(Restrictions.eq("id", entity.getEmpDistrict().getId()));
			}
			else if (entity.getEmpDistrictId() != null && entity.getEmpDistrictId() > -1)
			{
				criteria.createCriteria("empDistrict").add(Restrictions.eq("id", entity.getEmpDistrictId().toString()));
			}
			
			if (entity.getAuditState() != null && entity.getAuditState() > -1)
			{
				criteria.add(Restrictions.eq("auditState", entity.getAuditState()));
			}
			else if (entity.getCondAuditStates() != null && entity.getCondAuditStates().length > 0)
			{
				criteria.add(Restrictions.in("auditState", entity.getCondAuditStates()));
			}
		}
		
		criteria.addOrder(Order.desc("applyDate"));
		
		return criteria;
	}

	public DAOFinanExpense getDaoFinanExpense()
	{
		return daoFinanExpense;
	}



	public void setDaoFinanExpense(DAOFinanExpense daoFinanExpense)
	{
		this.daoFinanExpense = daoFinanExpense;
	}

}
