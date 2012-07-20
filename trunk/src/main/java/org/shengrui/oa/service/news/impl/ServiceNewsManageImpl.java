package org.shengrui.oa.service.news.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.news.DAONewsManage;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.service.news.ServiceNewsManage;

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

	@Override
	public PaginationSupport<ModelNewsMag> getPaginationByNews(
			ModelNewsMag news, PagingBean pagingBean) throws ServiceException
	{
		return this.getAll(this.getCriteria(news), pagingBean);
		
	}
	
	private DetachedCriteria getCriteria(ModelNewsMag news)
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
		
		}
		criteria.addOrder(Order.desc("updateTime"));
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
		return this.getAll(criteria, pagingBean);
	}

	@Override
	public PaginationSupport<ModelNewsMag> getDistrictNews(ModelNewsMag news,
			PagingBean pagingBean) throws ServiceException {
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelNewsMag.class);
		criteria.add(Restrictions.eq("newsLevel", 1));
		return this.getAll(criteria, pagingBean);
	}

}
