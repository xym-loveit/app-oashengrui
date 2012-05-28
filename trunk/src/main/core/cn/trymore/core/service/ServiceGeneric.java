package cn.trymore.core.service;

import java.util.List;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.model.ModelBase;

/**
 * The base service
 * 
 * @author Jeccy.Zhao
 * 
 */
public interface ServiceGeneric<T extends ModelBase>
{
	T save(T paramT) throws ServiceException;

	T merge(T paramT) throws ServiceException;

	void evict(T paramT) throws ServiceException;

	T get(String paramPK) throws ServiceException;

	List<T> getAll() throws ServiceException;

	void remove(String paramPK) throws ServiceException;

	void remove(T paramT) throws ServiceException;

	void flush() throws ServiceException;
}
