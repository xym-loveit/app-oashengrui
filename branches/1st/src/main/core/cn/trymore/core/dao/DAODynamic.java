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
