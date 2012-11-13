package org.shengrui.oa.service.finan.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import org.shengrui.oa.dao.finan.DAOFinanContract;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.service.finan.ServiceFinanContract;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class ServiceFinanContractImpl
extends ServiceGenericImpl<ModelFinanContract> implements ServiceFinanContract
{
	
	private DAOFinanContract daoFinanContract;
	
	public ServiceFinanContractImpl(DAOFinanContract dao)
	{
		super(dao);
		this.setDaoFinanContract(dao);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanContract#getByFormNo(java.lang.String)
	 */
	@Override
	public ModelFinanContract getByFormNo(String formNo)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanContract.class);
			criteria.add(Restrictions.eq("formNo", formNo));
			
			List<ModelFinanContract> result = this.daoFinanContract.getListByCriteria(criteria, false);
			return result != null && result.size() > 0 ? result.get(0) : null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanContract#getFinanContractInfoPagination(org.shengrui.oa.model.finan.ModelFinanContract, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelFinanContract> getFinanContractInfoPagination(
			ModelFinanContract entity, PagingBean pagingBean)
			throws ServiceException
	{
		return getFinanContractInfoPagination(entity, pagingBean, null);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanContract#getFinanContractInfoPagination(org.shengrui.oa.model.finan.ModelFinanContract, cn.trymore.core.web.paging.PagingBean, boolean)
	 */
	@Override
	public PaginationSupport<ModelFinanContract> getFinanContractInfoPagination (ModelFinanContract entity, 
			PagingBean pagingBean, Boolean isOnApproval) throws ServiceException
	{
		return this.getAll(this.getCriterias(entity, isOnApproval), pagingBean, isOnApproval == null);
	}

	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias(ModelFinanContract entity, 
			Boolean isOnApproval)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanContract.class);

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
		
		if (isOnApproval != null)
		{
			if (isOnApproval)
			{
				// 过滤审批中的记录
				criteria.add(Restrictions.sqlRestriction(
					"(cproc_depid = " + 
						ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
						ContextUtil.getCurrentUser().getPositionId() + " and " +
						"(cproc_disid = " + 
							ContextUtil.getCurrentUser().getDistrictId() + "))"
					)
				);
			}
			else
			{
				// 过滤审批结束的记录
				criteria.createCriteria("processHistory").add(
						Restrictions.eq("auditUserIds", String.valueOf(ContextUtil.getCurrentUserId())));
			}
		}
		
		criteria.addOrder(Order.desc("applyDate"));
		
		return criteria;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanContract#finanContract(org.shengrui.oa.model.finan.ModelFinanContract, java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelFinanContract> finanContract(ModelFinanContract entity, 
			String query, PagingBean pagingBean) throws ServiceException 
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanContract.class);
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
	 * @see org.shengrui.oa.service.finan.ServiceFinanContract#finanContractRec(org.shengrui.oa.model.finan.ModelFinanContract, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelFinanContract> finanContractRec(ModelFinanContract entity, 
			PagingBean pagingBean) throws ServiceException 
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanContract.class);
		
		/*
		criteria.add(Restrictions.in("auditState", new Integer[]{
				ModelProcessForm.EProcessFormStatus.APPROVED.getValue(),
				ModelProcessForm.EProcessFormStatus.NOTPASSED.getValue(),
				ModelProcessForm.EProcessFormStatus.RETURNED.getValue()}));
		*/
		
		// Added by Jeccy.Zhao on 24/10/2012: 过滤审批人...
		criteria.createCriteria("processHistory").add(
				Restrictions.eq("auditUserIds", String.valueOf(ContextUtil.getCurrentUserId())));
		
		return this.getAll(criteria, pagingBean);
	}
	
	public DAOFinanContract getDaoFinanContract()
	{
		return daoFinanContract;
	}

	public void setDaoFinanContract(DAOFinanContract daoFinanContract)
	{
		this.daoFinanContract = daoFinanContract;
	}
}
