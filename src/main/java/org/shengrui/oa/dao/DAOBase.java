package org.shengrui.oa.dao;

import java.util.List;
import java.util.Map;
import java.io.Serializable;

import org.hibernate.criterion.DetachedCriteria;
import org.shengrui.oa.common.DAOException;
import org.shengrui.oa.model.ModelBase;
import org.shengrui.oa.web.component.pagination.PaginationSupport;

/**
 * The base repository
 * 
 * @author Jeccy.Zhao
 *
 * @param <T> Generic object
 */
public interface DAOBase<T extends ModelBase> 
{
	
	/**
	 * Save or Update the object in database
	 * 
	 * @param domain Object to be saved of updated
	 */
	String saveOrUpdate(final T domain) 
			throws DAOException;
	
	/**
	 * Remove the object from database
	 * 
	 * @param domain Object to be deleted
	 */
	String remove(final T domain) 
			throws DAOException;
	
	/**
	 * Get object by identity
	 * 
	 * @param id Identity of object
	 * @return Object
	 */
	T get(Serializable id) 
			throws DAOException;
	
	/**
	 * Obtains objects with the specified native SQL
	 * 
	 * @param nativeSql
	 *          the native SQL string
	 * @return list of objects
	 */
	List<Object> findListByNativeSQL(final String nativeSql) 
			throws DAOException;
	
	/**
	 * Obtains objects with the specified native SQL, 
	 * and converted as the given CLAZ afterwards. 
	 * 
	 * @param nativeSql
	 *          the native SQL string
	 * @param claz
	 *          the target class
	 * @return list of objects
	 */
	@SuppressWarnings("rawtypes")
	List findListByNativeSQL(final String nativeSql, final Class<?> claz)
			throws DAOException;
	
	/**
	 * Get object list by HSQL query 
	 * 
	 * @param hsql
	 *         the HSQL string
	 * @return list of objects
	 */
	List<T> findListByHSQL(final String hsql)
			throws DAOException;
	
	/**
	 * Find object list by named query in mapping file
	 * 
	 * @param query
	 *          the named query
	 * @return list of objects
	 */
	List<T> findListByNamedQuery(final String query)
			throws DAOException;
	
	/**
	 * Executes the specified native SQL and returns the affected row count. 
	 * It's already deprecated since the affected identity cannot be returned.
	 * 
	 * @param nativeSql
	 *          the native SQL string
	 * @return the affected row count
	 */
	/*
	@deprecated: since the affected identity cannot be returned
	int execUpdateByNativeSQL(final String nativeSql)
			throws DAOException;
	*/
	
	/**
	 * Get object list by query criteria
	 * 
	 * @param criteria 
	 *          the query criteria,including condition and the orders
	 * @return list of objects
	 */
	List<T> getListByCriteria(final DetachedCriteria criteria)
			throws DAOException;
	
	/**
	 * Get object list by query criteria
	 * @param criteria 
	 *          the query criteria,including condition and the orders
	 * @param firstResult
	 *          the first index
	 * @param maxResult
	 *          the end index
	 * @return list of objects
	 */
	List<T> getListByCriteria(final DetachedCriteria criteria,
			int firstResult,int maxResult) throws DAOException;
	
	/**
	 * Find object by pagination support
	 * 
	 * @param criteria 
	 *           the query criteria,including condition and the orders
	 * @param pageSize 
	 *           the size of page to show
	 * @param startIndex 
	 *           the start index to search
	 * @return list of objects wrapped by pager
	 */
	PaginationSupport<T> findPageByCriteria(final DetachedCriteria criteria,
			int pageSize,int startIndex) throws DAOException;
	
	/**
	 * 
	 * @param objectClass
	 * @param params
	 * @param pageSize
	 * @param startIndex
	 * @return
	 * @throws DAOException
	 */
	PaginationSupport<T> queryFieldsListForPaging(final Class<?> objectClass, 
			Map<String, List<Object>> params, int pageSize, int startIndex) throws DAOException;
	
	/**
	 * 
	 * @param objectClass
	 * @param params
	 * @param returnFields
	 * @param pageSize
	 * @param startIndex
	 * @return
	 */
	PaginationSupport<T> queryFieldsListForPaging(final String objectClassName, 
			Map<String, List<Object>> params, int pageSize, int startIndex) throws DAOException, ClassNotFoundException;
}
