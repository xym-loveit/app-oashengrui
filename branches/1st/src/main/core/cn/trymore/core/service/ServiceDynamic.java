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
