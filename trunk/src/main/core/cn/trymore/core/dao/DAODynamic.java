package cn.trymore.core.dao;

import java.io.Serializable;
import java.util.List;

import cn.trymore.core.exception.DAOException;

/**
 * The base repository with dynamic object
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAODynamic
{
	/**
	 * 
	 * @param paramObject
	 * @return
	 * @throws DAOException
	 */
	Object save(Object paramObject) throws DAOException;

	/**
	 * 
	 * @param paramObject
	 * @return
	 * @throws DAOException
	 */
	Object merge(Object paramObject) throws DAOException;

	/**
	 * 
	 * @param paramSerializable
	 * @return
	 * @throws DAOException
	 */
	Object get(Serializable paramSerializable) throws DAOException;

	/**
	 * 
	 * @param paramSerializable
	 * @throws DAOException
	 */
	void remove(Serializable paramSerializable) throws DAOException;

	/**
	 * 
	 * @param paramObject
	 * @throws DAOException
	 */
	void remove(Object paramObject) throws DAOException;

	/**
	 * 
	 * @param paramObject
	 * @throws DAOException
	 */
	void evict(Object paramObject) throws DAOException;

	/**
	 * 
	 * @return
	 * @throws DAOException
	 */
	List<Object> getAll() throws DAOException;

}
