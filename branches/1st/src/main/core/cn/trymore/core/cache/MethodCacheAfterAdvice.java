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

package cn.trymore.core.cache;

import java.lang.reflect.Method;
import java.util.List;

import net.sf.ehcache.Cache;

import org.apache.log4j.Logger;
import org.springframework.aop.AfterReturningAdvice;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.CollectionUtils;

public class MethodCacheAfterAdvice implements AfterReturningAdvice, InitializingBean 
{
	
	private final static Logger logger = Logger.getLogger(MethodCacheAfterAdvice.class);
	
	private Cache cache;
	
	/*
	 * (non-Javadoc)
	 * @see org.springframework.aop.AfterReturningAdvice#afterReturning(java.lang.Object, java.lang.reflect.Method, java.lang.Object[], java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	public void afterReturning(Object returnValue, Method method, Object[] args, Object target) throws Throwable
	{
		String targetCacheKeyPrefix = target.getClass().getName() + ".";
		List cachedKeys = cache.getKeys();
		
		if (!CollectionUtils.isEmpty(cachedKeys))
		{
			for (Object cachedKey : cachedKeys) 
			{
				String key = String.valueOf(cachedKey);
				if (key.startsWith(targetCacheKeyPrefix))
				{
					cache.remove(key);
				}
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * @see org.springframework.beans.factory.InitializingBean#afterPropertiesSet()
	 */
	public void afterPropertiesSet() throws Exception 
	{
		
	}

	public void setCache(Cache cache)
	{
		this.cache = cache;
	}

	public Cache getCache() 
	{
		return cache;
	}

	public static Logger getLogger()
	{
		return logger;
	}

}
