package cn.trymore.core.service;

import java.io.Serializable;
import java.util.List;

import cn.trymore.core.exception.ServiceException;

/**
 * The dynamic service
 * 
 * @author Jeccy.Zhao
 * 
 */
public interface ServiceDynamic
{
	/**
	 * 
	 * @param paramObject
	 * @return
	 * @throws ServiceException
	 */
	Object save(Object paramObject) throws ServiceException;
	
	/**
	 * 
	 * @param paramObject
	 * @return
	 * @throws ServiceException
	 */
	Object merge(Object paramObject) throws ServiceException;
	
	/**
	 * 
	 * @param paramSerializable
	 * @return
	 * @throws ServiceException
	 */
	Object get(Serializable paramSerializable) throws ServiceException;
	
	/**
	 * 
	 * @param paramSerializable
	 * @throws ServiceException
	 */
	void remove(Serializable paramSerializable) throws ServiceException;
	
	/**
	 * 
	 * @param paramObject
	 * @throws ServiceException
	 */
	void remove(Object paramObject) throws ServiceException;
	
	/**
	 * 
	 * @param paramObject
	 * @throws ServiceException
	 */
	void evict(Object paramObject) throws ServiceException;
	
	/**
	 * 
	 * @return
	 * @throws ServiceException
	 */
	List<Object> getAll() throws ServiceException;

}
