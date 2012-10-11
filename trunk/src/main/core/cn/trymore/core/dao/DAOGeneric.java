/*
 * Copyright (c) 2010-2012 Zhao.Xiang<z405656232x@163.com> Holding Limited.
 * All rights reserved.
 * 
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package cn.trymore.core.dao;

import java.util.List;
import java.util.Map;
import java.io.Serializable;

import org.hibernate.criterion.DetachedCriteria;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.model.ModelBase;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The base repository
 * 
 * @author Jeccy.Zhao
 *
 * @param <T> Generic object
 */
public interface DAOGeneric<T extends ModelBase> 
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
	 * Get object by identity id.
	 * 
	 * @param id Identity of object
	 * @return Object
	 */
	T get(Serializable id) 
			throws DAOException;
	
	/**
	 * Get all of available objects
	 * 
	 * @return all available objects
	 * @throws DAOException
	 */
	List<T> getAll()
			throws DAOException;
	
	/**
	 * Get all of available objects
	 * 
	 * @param filter
	 *                the query will be applied only when it's true
	 * @return all available objects
	 * @throws DAOException
	 */
	List<T> getAll(final boolean filter)
			throws DAOException;
	
	/**
	 * Flushes current session
	 * 
	 * @throws DAOException
	 */
	void flush()
			throws DAOException;
	
	/**
	 * Merges the object from database
	 * 
	 * @param domain
	 *          object to be merged
	 * @return
	 * @throws DAOException
	 */
	T merge(final T domain)
			throws DAOException;
	
	/**
	 * Evicts the object from database
	 * 
	 * @param domain
	 *           object to be evicted
	 * @throws DAOException
	 */
	void evict(final T domain)
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
	int execUpdateByNativeSQL(final String nativeSql)
			throws DAOException;
	
	/**
	 * Executes the specified HQL and returns the affected row count. 
	 * It's already deprecated since the affected identity cannot be returned.
	 * 
	 * @param hql
	 * @param params
	 * @return
	 * @throws DAOException
	 */
	int execUpdateByHQL(final String hql, final Object[] params)
			throws DAOException;
	
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
	 * 
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
	 * Obtains an unique object from database
	 * 
	 * @param hsql
	 *                the HSQL
	 * @param params
	 *                the parameter object list
	 * @return unique object entity
	 * @throws DAOException
	 */
	 Object findUnique (final String hsql,
			 final Object[] params) throws DAOException;
	
	/**
	 * Find object by pagination support
	 * 
	 * @param criteria
	 *                  the query criteria,including condition and the orders
	 * @param pagingBean
	 *                  the paging bean
	 * @return list of objects wrapped by pager
	 * @throws DAOException
	 */
	PaginationSupport<T> findPageByCriteria(final DetachedCriteria criteria, 
				final PagingBean pagingBean) throws DAOException;
	 
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
	
	/**
	 * Obtains the affected number with the specified query filter.
	 * 
	 * @param clas
	 * @param whereCloud
	 * @return
	 * @throws DAOException
	 * @throws ClassNotFoundException
	 */
	@SuppressWarnings("rawtypes")
	int getAffectedNumByQueryFilter (final Class clas, 
			String whereCloud) throws DAOException, ClassNotFoundException;
	
	/**
	 * Obtains the query filter
	 * @return
	 */
	abstract String getQueryFilter();
	
	/**
	 * Sets the query filter
	 * @param query
	 */
	abstract void setQueryFilter (String query);
	
	/**
	 * Obtains affected row count with the specified native SQL.
	 * 
	 * @param sql
	 * @return
	 */
	Integer getCountByNativeSQL( final  String sql);
	
}
