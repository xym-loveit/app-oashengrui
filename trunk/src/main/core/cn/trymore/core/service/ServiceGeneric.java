package cn.trymore.core.service;

import java.util.List;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.model.ModelBase;

/**
 * The generic service
 * 
 * @author Jeccy.Zhao
 * 
 */
public interface ServiceGeneric<T extends ModelBase>
{
	/**
	 * Save or Update the object in database
	 * 
	 * @param domain
	 *           object to be saved or updated
	 * @return the object after saving 
	 * @throws ServiceException
	 */
	T save(T domain) throws ServiceException;
	
	/**
	 * Merges the object from database
	 * 
	 * @param domain
	 *          object to be merged
	 * @return the object after merged
	 * @throws ServiceException
	 */
	T merge(T domain) throws ServiceException;
	
	/**
	 * Evicts the object from database
	 * 
	 * @param domain
	 *           object to be evicted
	 * @throws ServiceException
	 */
	void evict(T domain) throws ServiceException;

	/**
	 * Get object by identity id.
	 * 
	 * @param id
	 *         object to be evicted
	 * @return object entity with the specified id
	 * @throws ServiceException
	 */
	T get(String id) throws ServiceException;
	
	/**
	 * Get all of available objects
	 * 
	 * @return all available objects
	 * @throws ServiceException
	 */
	List<T> getAll() throws ServiceException;
	
	/**
	 * Remove the object from database
	 * 
	 * @param id
	 *         the object id
	 * @throws ServiceException
	 */
	void remove(String id) throws ServiceException;
	
	/**
	 * Remove the object from database
	 * 
	 * @param domain
	 *          object to be removed
	 * @throws ServiceException
	 */
	void remove(T domain) throws ServiceException;

	/**
	 * Flushes current database session.
	 * @throws ServiceException
	 */
	void flush() throws ServiceException;
}
