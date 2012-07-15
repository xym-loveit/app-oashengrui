package org.shengrui.oa.service.finan.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import org.shengrui.oa.dao.finan.DAOFinanContract;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.service.finan.ServiceFinanContract;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
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
			
			List<ModelFinanContract> result = this.daoFinanContract.getListByCriteria(criteria);
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
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias(ModelFinanContract entity)
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
		}
		
		criteria.addOrder(Order.desc("applyDate"));
		
		return criteria;
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
