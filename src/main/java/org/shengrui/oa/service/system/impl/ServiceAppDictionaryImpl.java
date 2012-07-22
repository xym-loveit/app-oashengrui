package org.shengrui.oa.service.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOAppDictionary;
import org.shengrui.oa.model.system.ModelAppDictionary;
import org.shengrui.oa.service.system.ServiceAppDictionary;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The implementation of 
 * application dictionary service.
 * 
 * @author Tang
 *
 */
public class ServiceAppDictionaryImpl
extends ServiceGenericImpl<ModelAppDictionary> implements ServiceAppDictionary
{
	
	/**
	 * The application dictionary repository.
	 */
	private DAOAppDictionary daoAppDict;
	
	/**
	 * The sole constructor.
	 * 
	 * @param dao
	 */
	public ServiceAppDictionaryImpl(DAOAppDictionary dao)
	{
		super(dao);
		this.daoAppDict = dao;
	}
	
	/*
	 * (non-Javadoc)
//	 * @see org.shengrui.oa.service.system.ServiceAppDictionary#getByName(java.lang.String)
	 */
	@Override
	public ModelAppDictionary getByName(String name)
			throws ServiceException
	{
		try
		{
			return this.daoAppDict.getByName(name);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	@Override
	public List<ModelAppDictionary> getByType(String type)
			throws ServiceException
	{
		try
		{
			return daoAppDict.getByType(type);
		} catch (DAOException e) {
			throw new ServiceException(e);
		}
	}
	
	
	public void setDaoAppDict(DAOAppDictionary daoAppDict)
	{
		this.daoAppDict = daoAppDict;
	}

	public DAOAppDictionary getDaoAppDict()
	{
		return daoAppDict;
	}

	@Override
	public PaginationSupport<ModelAppDictionary> getPaginationByCriteria(
			ModelAppDictionary entity, PagingBean pagingBean)
			throws ServiceException {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria
		.forClass(ModelAppDictionary.class);
		if (entity != null) {
			if (entity.getType() != null
			&& !"".equals(entity.getType())) {
				criteria.add(Restrictions.eq("type", entity.getType()));
			}else{
				criteria.add(Restrictions.eq("type", "news"));
			}
		}else{
			criteria.add(Restrictions.eq("type", "news"));
		}
		criteria.addOrder(Order.desc("modifiedDate"));

		return this.getAll(criteria, pagingBean);
	}
}
