package org.shengrui.oa.service.info.impl;

import org.shengrui.oa.dao.info.DAOInMessage;
import org.shengrui.oa.model.info.ModelInMessage;
import org.shengrui.oa.model.info.ModelShortMessage;
import org.shengrui.oa.service.info.ServiceInMessage;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The message in service.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceInMessageImpl
extends ServiceGenericImpl<ModelInMessage> implements ServiceInMessage
{
	private DAOInMessage daoInMessage;
	
	public ServiceInMessageImpl(DAOInMessage dao)
	{
		super(dao);
		this.daoInMessage = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.info.ServiceInMessage#getPaginationByUser(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelInMessage> getPaginationByUser(String userId, 
			ModelShortMessage entity, String readFlag, PagingBean pagingBean) throws ServiceException
	{
		try 
		{
			return this.daoInMessage.getPaginationByUser(userId, entity, readFlag, pagingBean);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	public void setDaoInMessage(DAOInMessage daoInMessage)
	{
		this.daoInMessage = daoInMessage;
	}

	public DAOInMessage getDaoInMessage()
	{
		return daoInMessage;
	}
	
}
