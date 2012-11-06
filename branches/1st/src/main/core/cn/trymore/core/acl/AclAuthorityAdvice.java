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

package cn.trymore.core.acl;

import java.lang.reflect.Method;

import org.apache.log4j.Logger;
import org.springframework.aop.MethodBeforeAdvice;

import cn.trymore.core.dao.impl.DAOGenericImpl;

/**
 * Advice for access control data.
 * 
 * @author Jeccy.Zhao
 *
 */
public class AclAuthorityAdvice 
implements MethodBeforeAdvice 
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(AclAuthorityAdvice.class);
	
	/**
	 * The data policy query bean
	 */
	private DataPolicyQuery dataPolicyQuery;
			
	/*
	 * (non-Javadoc)
	 * @see org.springframework.aop.MethodBeforeAdvice#before(java.lang.reflect.Method, java.lang.Object[], java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public void before(Method method, Object[] args, Object target)
			throws Throwable
	{
		// LOGGER.debug("The object fetched from data policy threadLocal:" + DataPolicyEngine.get());
		
		if (dataPolicyQuery.isGrantedDataPolicy(DataPolicyEngine.get()))
		{
			String targetClassName = target.getClass().getName();
			if (targetClassName.endsWith("Impl") && targetClassName.indexOf("DAO") > -1)
			{
				DAOGenericImpl repo = (DAOGenericImpl) target;
				Class entityObj = repo.getEntityClass();
				
				String queryFilter = dataPolicyQuery.buildPolicyQuery(entityObj);
				if (queryFilter != null)
				{
					repo.setQueryFilter(queryFilter);
				}
			}
		}
	}

	public void setDataPolicyQuery(DataPolicyQuery dataPolicyQuery)
	{
		this.dataPolicyQuery = dataPolicyQuery;
	}

	public DataPolicyQuery getDataPolicyQuery()
	{
		return dataPolicyQuery;
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}
	
}
