package cn.trymore.core.service.impl;

import java.io.Serializable;
import java.util.List;

import org.apache.log4j.Logger;

import cn.trymore.core.dao.DAODynamic;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceDynamic;

/**
 * The implementation of dynamic base service
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceDynamicImpl
implements ServiceDynamic
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(ServiceDynamicImpl.class);
	
	/**
	 * The dynamic repository
	 */
	private DAODynamic daoDynamic;
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#save(java.lang.Object)
	 */
	@Override
	public Object save(Object paramObject) throws ServiceException
	{
		try
		{
			this.daoDynamic.save(paramObject);
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
		}
		
		return paramObject;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#merge(java.lang.Object)
	 */
	@Override
	public Object merge(Object paramObject) throws ServiceException
	{
		try
		{
			this.daoDynamic.merge(paramObject);
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
		}
		
		return paramObject;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#get(java.io.Serializable)
	 */
	@Override
	public Object get(Serializable paramSerializable) throws ServiceException
	{
		try
		{
			return this.daoDynamic.get(paramSerializable);
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#remove(java.io.Serializable)
	 */
	@Override
	public void remove(Serializable paramSerializable) throws ServiceException
	{
		remove(get(paramSerializable));
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#remove(java.lang.Object)
	 */
	@Override
	public void remove(Object paramObject) throws ServiceException
	{
		try
		{
			this.daoDynamic.remove(paramObject);
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#evict(java.lang.Object)
	 */
	@Override
	public void evict(Object paramObject) throws ServiceException
	{
		try
		{
			this.daoDynamic.evict(paramObject);
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceDynamic#getAll()
	 */
	@Override
	public List<Object> getAll() throws ServiceException
	{
		try
		{
			return this.daoDynamic.getAll();
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
		}
	}

	public DAODynamic getDaoDynamic()
	{
		return daoDynamic;
	}

	public void setDaoDynamic(DAODynamic daoDynamic)
	{
		this.daoDynamic = daoDynamic;
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}
	
}
