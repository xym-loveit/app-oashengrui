package org.shengrui.oa.service.finan.impl;

import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.finan.DAOFinanProject;
import org.shengrui.oa.model.finan.ModelFinanProject;
import org.shengrui.oa.service.finan.ServiceFinanProject;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.hibernate.HibernateUtils;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class ServiceFinanProjectImpl
extends ServiceGenericImpl<ModelFinanProject> implements ServiceFinanProject
{
	
	private DAOFinanProject daoFinanProject;
	
	public ServiceFinanProjectImpl(DAOFinanProject dao)
	{
		super(dao);
		this.daoFinanProject = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanProject#getByFormNo(java.lang.String)
	 */
	@Override
	public ModelFinanProject getByFormNo(String formNo) throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanProject.class);
			criteria.add(Restrictions.eq("formNo", formNo));
			
			List<ModelFinanProject> result = this.daoFinanProject.getListByCriteria(criteria, false);
			return result != null && result.size() > 0 ? result.get(0) : null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanProject#getFinanProjectInfoPagination(org.shengrui.oa.model.finan.ModelFinanProject, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelFinanProject> getFinanProjectInfoPagination(
			ModelFinanProject entity, PagingBean pagingBean)
			throws ServiceException
	{
		return getFinanProjectInfoPagination(entity, pagingBean, null);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanProject#getFinanProjectInfoPagination(org.shengrui.oa.model.finan.ModelFinanProject, cn.trymore.core.web.paging.PagingBean, boolean)
	 */
	@Override
	public PaginationSupport<ModelFinanProject> getFinanProjectInfoPagination(
			ModelFinanProject entity, PagingBean pagingBean,
			Boolean isOnApproval) throws ServiceException
	{
		return this.getAll(this.getCriterias(entity, isOnApproval), pagingBean, isOnApproval == null);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanProject#getApprovalRec(cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelFinanProject> getApprovalRec (
			PagingBean pagingBean) throws ServiceException
	{
		
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanProject.class);
		
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
	
	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias(ModelFinanProject entity, 
			Boolean isOnApproval)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanProject.class);

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
		
		if (isOnApproval != null)
		{
			if (isOnApproval)
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
	
	public DAOFinanProject getDaoFinanProject()
	{
		return daoFinanProject;
	}

	public void setDaoFinanProject(DAOFinanProject daoFinanProject)
	{
		this.daoFinanProject = daoFinanProject;
	}

}
