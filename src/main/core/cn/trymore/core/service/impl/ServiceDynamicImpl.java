package cn.trymore.core.service.impl;

import java.io.Serializable;
import java.util.List;

import cn.trymore.core.dao.DAODynamic;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceDynamic;

/**
 * The dynamic base service
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceDynamicImpl
implements ServiceDynamic
{
	/**
	 * The dynamic repository
	 */
	private DAODynamic daoDynamic;
	
	/**
	 * The default constructor
	 */
	public ServiceDynamicImpl()
	{
		
	}
	
	/**
	 * The sole constructor
	 * 
	 * @param paramDynamicDao
	 */
	public ServiceDynamicImpl(DAODynamic paramDynamicDao)
	{
		this.daoDynamic = paramDynamicDao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#save(java.lang.Object)
	 */
	@Override
	public Object save(Object paramObject) throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#merge(java.lang.Object)
	 */
	@Override
	public Object merge(Object paramObject) throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#get(java.io.Serializable)
	 */
	@Override
	public Object get(Serializable paramSerializable) throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#remove(java.io.Serializable)
	 */
	@Override
	public void remove(Serializable paramSerializable) throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#remove(java.lang.Object)
	 */
	@Override
	public void remove(Object paramObject) throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#evict(java.lang.Object)
	 */
	@Override
	public void evict(Object paramObject) throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#getAll()
	 */
	@Override
	public List<Object> getAll() throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}

	public DAODynamic getDaoDynamic()
	{
		return daoDynamic;
	}

	public void setDaoDynamic(DAODynamic daoDynamic)
	{
		this.daoDynamic = daoDynamic;
	}
	
}
