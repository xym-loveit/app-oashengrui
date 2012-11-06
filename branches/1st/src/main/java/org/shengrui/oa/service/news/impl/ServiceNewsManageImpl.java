package org.shengrui.oa.service.news.impl;

import org.hibernate.Hibernate;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.news.DAONewsManage;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.service.news.ServiceNewsManage;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class ServiceNewsManageImpl
extends ServiceGenericImpl<ModelNewsMag> implements ServiceNewsManage
{
	private DAONewsManage daoNewsManage;
	
	public ServiceNewsManageImpl(DAONewsManage dao)
	{
		super(dao);
		this.daoNewsManage = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.news.ServiceNewsManage#getPaginationByNews(org.shengrui.oa.model.news.ModelNewsMag, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelNewsMag> getPaginationByNews(
			ModelNewsMag news, PagingBean pagingBean) throws ServiceException
	{
		return this.getPaginationByNews(news, false, pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.news.ServiceNewsManage#getPaginationByNews(org.shengrui.oa.model.news.ModelNewsMag, boolean, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelNewsMag> getPaginationByNews(
			ModelNewsMag news, boolean visibility, PagingBean pagingBean) throws ServiceException
	{
		return this.getAll(this.getCriteria(news, visibility), pagingBean);
	}
	
	@Override
	public PaginationSupport<ModelNewsMag> getPaginationFilert(
			ModelNewsMag news, PagingBean pagingBean) throws ServiceException
	{
		boolean statusFiltered = false;
		
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelNewsMag.class);
		if(news != null)
		{
			if(news.getDictionary() !=null && UtilString.isNotEmpty(news.getDictionary().getId()))
			{
				criteria.createCriteria("dictionary").add(Restrictions.eq("id", news.getDictionary().getId()));
			}
			if(news.getSearchStatusCondition() !=null && news.getSearchStatusCondition().length > 0)
			{
				criteria.add(Restrictions.in("status", news.getSearchStatusCondition()));
				statusFiltered = true;
			}
			else
			{
				if (news.getStatus() != null && news.getStatus() > -1)
				{
					criteria.add(Restrictions.eq("status",news.getStatus()));
					statusFiltered = true;
				}
			}
			if(news.getNewsSubject() !=null)
			{
				criteria.add(Restrictions.like("newsSubject", news.getNewsSubject(), MatchMode.ANYWHERE));
			}
			if(news.getDistrict() != null && UtilString.isNotEmpty(news.getDistrict().getId()))
			{
				criteria.createCriteria("district").add(Restrictions.eq("id", news.getDistrict().getId()));
			}
		}
		criteria.addOrder(Order.desc("topIndex"))
				.addOrder(Order.desc("updateTime"));
		
		if (!statusFiltered)
		{
			criteria.add(Restrictions.in("status", new Integer[]{1,2,3}));
		}
		
		return this.getAll(criteria, pagingBean);
	}
	
	private DetachedCriteria getCriteria(ModelNewsMag news, boolean visiblity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelNewsMag.class);
		if(news != null)
		{
			if(news.getDictionary() !=null && UtilString.isNotEmpty(news.getDictionary().getId()))
			{
				criteria.createCriteria("dictionary").add(Restrictions.eq("id", news.getDictionary().getId()));
			}
		
			if(news.getSearchStatusCondition() !=null && news.getSearchStatusCondition().length > 0)
			{
				criteria.add(Restrictions.in("status", news.getSearchStatusCondition()));
			}
			else
			{
				if (news.getStatus() != null && news.getStatus() > -1)
				{
					criteria.add(Restrictions.eq("status", news.getStatus()));
				}
			}
			
			if(news.getNewsSubject() !=null)
			{
				criteria.add(Restrictions.like("newsSubject", news.getNewsSubject(), MatchMode.ANYWHERE));
			}
			
			if(news.getDistrict() != null && UtilString.isNotEmpty(news.getDistrict().getId()))
			{
				criteria.createCriteria("district").add(Restrictions.eq("id", news.getDistrict().getId()));
			}
			
			if (news.getNewsLevel() != null)
			{
				criteria.add(Restrictions.eq("newsLevel", news.getNewsLevel()));
			}
		
		}
		
		// 可见校区过滤...
		if (visiblity)
		{
			criteria.add(Restrictions.sqlRestriction(
					"(district_visible IS NULL OR district_visible = '' OR FIND_IN_SET( ?, `district_visible` ) > 0)", ContextUtil.getCurrentUser().getDistrictId(), Hibernate.STRING));
		}
		
		criteria.addOrder(Order.desc("topIndex"))
				.addOrder(Order.desc("updateTime"));
				
		return criteria;
	}
	
	
	
	@Override
	public void deleteNewsByNewsId(String newsId) throws ServiceException 
	{
		this.remove(newsId);
	}
	
	
	@Override
	public ModelNewsMag updateNews(ModelNewsMag modelNewsMag)
			throws ServiceException
	{
		
		return this.save(modelNewsMag);
		
	}
	
	@Override
	public ModelNewsMag getModelNewsMag(String newsId) throws ServiceException
	{
		
		return this.get(newsId);
		
	}
	
	
	public DAONewsManage getDaoNewsManage() {
		return daoNewsManage;
	}

	public void setDaoNewsManage(DAONewsManage daoNewsManage) {
		this.daoNewsManage = daoNewsManage;
	}

	@Override
	public PaginationSupport<ModelNewsMag> getCompanyNews(
			ModelNewsMag news, PagingBean pagingBean) throws ServiceException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelNewsMag.class);
		criteria.add(Restrictions.eq("newsLevel", 0));
		criteria.add(Restrictions.eq("status", 2));
		criteria.addOrder(Order.desc("topIndex"))
		.addOrder(Order.desc("updateTime"));
		
		// 管理员可以查看所有校区新闻数据
		if (!ContextUtil.getCurrentUser().isSuerUser())
		{
			criteria.add(Restrictions.sqlRestriction(
				"(district_visible IS NULL OR district_visible = '' OR FIND_IN_SET( ?, `district_visible` ) > 0)", ContextUtil.getCurrentUser().getDistrictId(), Hibernate.STRING));
		}
		
		return this.getAll(criteria, pagingBean);
	}

	@Override
	public PaginationSupport<ModelNewsMag> getDistrictNews(ModelNewsMag news,
			PagingBean pagingBean) throws ServiceException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelNewsMag.class);
		criteria.add(Restrictions.eq("newsLevel", 1));
		criteria.add(Restrictions.eq("status", 2));
		criteria.addOrder(Order.desc("topIndex"))
		.addOrder(Order.desc("updateTime"));
		
		// 管理员可以查看所有校区新闻数据
		if (!ContextUtil.getCurrentUser().isSuerUser())
		{
			criteria.add(Restrictions.sqlRestriction(
				"(district_visible IS NULL OR district_visible = '' OR FIND_IN_SET( ?, `district_visible` ) > 0)", ContextUtil.getCurrentUser().getDistrictId(), Hibernate.STRING));
		}
		
		return this.getAll(criteria, pagingBean);
	}

	@Override
	public PaginationSupport<ModelNewsMag> getNewsRec(ModelNewsMag news,
			String query, PagingBean pagingBean) throws ServiceException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelNewsMag.class);
		criteria.add(Restrictions.eq("status", 1));
		
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

	@Override
	public PaginationSupport<ModelNewsMag> getNewsApprovalRec(
			ModelNewsMag news, PagingBean pagingBean) throws ServiceException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelNewsMag.class);
		// criteria.add(Restrictions.in("status",new Integer[]{2,3}));
//				.add(Restrictions.eq("status", 3));
		
		// Added by Jeccy.Zhao on 24/10/2012: 过滤审批人...
		criteria.createCriteria("auditHistory").add(
				Restrictions.eq("auditorId", String.valueOf(ContextUtil.getCurrentUserId())));
		
		return this.getAll(criteria, pagingBean);
	}

}
