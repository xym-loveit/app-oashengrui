package org.shengrui.oa.service.finan.impl;

import org.hibernate.criterion.DetachedCriteria;
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
		
		this.daoFinanExpense = dao;
	}
	
	
	public void setdaoFinanExpense(DAOFinanExpense daoFinanExpense)
	{
		this.daoFinanExpense = daoFinanExpense;
	}

	public DAOFinanExpense getdaoFinanExpense()
	{
		return daoFinanExpense;
	}
	

	@Override
	public PaginationSupport<ModelFinanExpense> getFinanExpenseInfoPagination(
			ModelFinanExpense entity, PagingBean pagingBean)
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
	private DetachedCriteria getCriterias(ModelFinanExpense entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanExpense.class);

		if (entity != null)
		{
			if (entity.getApplyFormType() > -1)
			{
				criteria.add(Restrictions.eq("applyFormType", entity.getApplyFormType()));
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
