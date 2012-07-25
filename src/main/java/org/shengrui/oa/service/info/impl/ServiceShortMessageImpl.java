package org.shengrui.oa.service.info.impl;

import org.shengrui.oa.dao.info.DAOShortMessage;
import org.shengrui.oa.model.info.ModelShortMessage;
import org.shengrui.oa.service.info.ServiceShortMessage;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The short message service.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceShortMessageImpl
extends ServiceGenericImpl<ModelShortMessage> implements ServiceShortMessage
{
	
	private DAOShortMessage daoShortMessage;
	
	public ServiceShortMessageImpl(DAOShortMessage dao)
	{
		super(dao);
		
		this.daoShortMessage = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.info.ServiceShortMessage#getPaginationByUser(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelShortMessage> getPaginationByUser(
			String senderId, PagingBean pagingBean) throws ServiceException
	{
		try 
		{
			return this.daoShortMessage.getPaginationByUser(senderId, pagingBean);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	public void setDaoShortMessage(DAOShortMessage daoShortMessage)
	{
		this.daoShortMessage = daoShortMessage;
	}

	public DAOShortMessage getDaoShortMessage()
	{
		return daoShortMessage;
	}

}
