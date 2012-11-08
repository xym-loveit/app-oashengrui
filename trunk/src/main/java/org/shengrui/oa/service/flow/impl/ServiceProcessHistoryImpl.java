package org.shengrui.oa.service.flow.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.flow.DAOProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.service.flow.ServiceProcessHistory;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceProcessHistoryImpl
extends ServiceGenericImpl<ModelProcessHistory> implements ServiceProcessHistory
{
	/**
	 * The process history repository
	 */
	private DAOProcessHistory daoProcessHistory;
	
	public ServiceProcessHistoryImpl(DAOProcessHistory dao)
	{
		super(dao);
		this.daoProcessHistory = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessHistory#getProcessHistoryByFormNo(java.lang.String)
	 */
	@Override
	public List<ModelProcessHistory> getProcessHistoryByFormNo(String formNo)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessHistory.class);
			criteria.add(Restrictions.eq("applyFormNo", formNo));
			criteria.addOrder(Order.asc("auditDate"));
			return this.daoProcessHistory.getListByCriteria(criteria);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessHistory#getProcessHistoryByUser(java.lang.String)
	 */
	@Override
	public List<ModelProcessHistory> getProcessHistoryByUser(String userId)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessHistory.class);
			criteria.add(Restrictions.in("auditUserIds", userId.split(",")));
			return this.daoProcessHistory.getListByCriteria(criteria);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}

	public void setDaoProcessHistory(DAOProcessHistory daoProcessHistory)
	{
		this.daoProcessHistory = daoProcessHistory;
	}

	public DAOProcessHistory getDaoProcessHistory()
	{
		return daoProcessHistory;
	}

}
