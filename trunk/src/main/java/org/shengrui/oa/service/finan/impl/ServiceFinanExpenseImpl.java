package org.shengrui.oa.service.finan.impl;

import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import org.shengrui.oa.dao.finan.DAOFinanExpense;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.service.finan.ServiceFinanExpense;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.hibernate.HibernateUtils;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
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
		return getFinanExpenseInfoPagination(entity, pagingBean, false);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanExpense#getFinanExpenseInfoPagination(org.shengrui.oa.model.finan.ModelFinanExpense, cn.trymore.core.web.paging.PagingBean, boolean)
	 */
	@Override
	public PaginationSupport<ModelFinanExpense> getFinanExpenseInfoPagination(
			ModelFinanExpense entity, PagingBean pagingBean,
			boolean filterMyApprovals) throws ServiceException
	{
		return this.getAll(this.getCriterias(entity, filterMyApprovals), pagingBean, !filterMyApprovals);
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
			
			List<ModelFinanExpense> result = this.daoFinanExpense.getListByCriteria(criteria, false);
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
	private DetachedCriteria getCriterias(ModelFinanExpense entity, boolean filterMyApprovals)
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
				Criterion criterion = null;
				
				for (Integer state : entity.getCondAuditStates())
				{
					if (state == null)
					{
						criterion = HibernateUtils.QBC_OR(criterion, Restrictions.isNull("auditState"));
					}
					else
					{
						criterion = HibernateUtils.QBC_OR(criterion, Restrictions.eq("auditState", state));
					}
				}
				
				criteria.add(criterion);
			}
		}
		
		if (filterMyApprovals)
		{
			criteria.add(Restrictions.sqlRestriction(
					"(audit_state IS NULL and cproc_depid = " + 
						ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
						ContextUtil.getCurrentUser().getPositionId() + " and " +
						"(cproc_disid = " + 
							ContextUtil.getCurrentUser().getDistrictId() + "))"
					)
				);
		}
		
		criteria.addOrder(Order.desc("applyDate"));
		
		return criteria;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanExpense#getfinanApproval(org.shengrui.oa.model.finan.ModelFinanExpense, java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelFinanExpense> getfinanApproval(ModelFinanExpense entity, 
			String query, PagingBean pagingBean) throws ServiceException 
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanExpense.class);
		criteria.add(Restrictions.isNull("auditState"));
		
		if (UtilString.isNotEmpty(query))
		{
			if (query.trim().toLowerCase().startsWith("and"))
			{
				query = query.toLowerCase().replaceFirst("and", "");
			}
			
			criteria.add(Restrictions.sqlRestriction(query));
		}
		
		return this.getAll(criteria, pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanExpense#getfinanApprovalRec(org.shengrui.oa.model.finan.ModelFinanExpense, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelFinanExpense> getfinanApprovalRec(ModelFinanExpense entity, 
			PagingBean pagingBean) throws ServiceException 
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanExpense.class);
		criteria.add(Restrictions.in("auditState", new Integer[]{2,3,4}));
		return this.getAll(criteria, pagingBean);
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
