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

package cn.trymore.core.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.model.ModelBase;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

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
	 * Get all of available objects
	 * 
	 * @param filter
	 *                the query will be applied only when it's true.
	 * @return all available objects
	 * @throws ServiceException
	 */
	List<T> getAll(final boolean filter) throws ServiceException;
	
	/**
	 * Obtains all entities with pagination
	 * 
	 * @param criteria
	 *           query criteria
	 * @param pagingBean
	 *           paging bean object
	 * @return pagination of entities
	 * @throws ServiceException
	 */
	PaginationSupport<T> getAll(final DetachedCriteria criteria,
			final PagingBean pagingBean) throws ServiceException;
	
	/**
	 * Obtains all entities with pagination
	 * 
	 * @param criteria
	 *           query criteria
	 * @param pagingBean
	 *           paging bean object
	 * @return pagination of entities
	 * @throws ServiceException
	 */
	PaginationSupport<T> getAll(final DetachedCriteria criteria,
			final PagingBean pagingBean, final boolean dataFilter) throws ServiceException;
	
	/**
	 * Obtains entities with pagination by the specified native SQL 
	 * 
	 * @param nativeSql
	 *          native SQL
	 * @param pagingBean
	 *          paging bean object
	 * @return entities with pagination
	 * @throws ServiceException
	 */
	PaginationSupport<T> getByQuery (final String nativeSql, 
			final PagingBean pagingBean) throws ServiceException;
	
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
	 * 
	 * @throws ServiceException
	 */
	void flush() throws ServiceException;
	
	/**
	 * Obtains affected entity row count with the specified query
	 * 
	 * @param clas
	 *          entity object
	 * @param whereCloud
	 *          native SQL query
	 * @return affected entity row count
	 * @throws ServiceException
	 */
	@SuppressWarnings("rawtypes")
	int getAffectedNumByQuery (final Class clas, 
			String whereCloud);
	
	/**
	 * Obtains affected entity row count with the specified native query
	 * 
	 * @param clas
	 *          entity object
	 * @param whereCloud
	 *          native SQL query
	 * @return affected entity row count
	 * @throws ServiceException
	 */
	int getAffectedNumByQuery (final String nativeSql, 
			String whereCloud);
}
