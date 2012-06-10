package org.shengrui.oa.service.hrm.impl;

import org.shengrui.oa.dao.hrm.DAOHrmArchive;
import org.shengrui.oa.model.hrm.ModelHrmArchive;
import org.shengrui.oa.service.hrm.ServiceHrmArchive;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class ServiceHrmArchiveImpl
extends ServiceGenericImpl<ModelHrmArchive> implements ServiceHrmArchive
{
	
	private DAOHrmArchive daoHrmArchive;
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.hrm.ServiceHrmArchive#getPagination(org.shengrui.oa.model.hrm.ModelHrmArchive, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmArchive> getPaginationByEntity (ModelHrmArchive entity, 
			PagingBean pagingBean) throws ServiceException
	{
		try
		{
			return this.daoHrmArchive.getPagination(entity, pagingBean);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}

	public ServiceHrmArchiveImpl(DAOHrmArchive dao)
	{
		super(dao);
		
		this.daoHrmArchive = dao;
	}

	public DAOHrmArchive getDaoHrmArchive()
	{
		return daoHrmArchive;
	}

	public void setDaoHrmArchive(DAOHrmArchive daoHrmArchive)
	{
		this.daoHrmArchive = daoHrmArchive;
	}
	
}
