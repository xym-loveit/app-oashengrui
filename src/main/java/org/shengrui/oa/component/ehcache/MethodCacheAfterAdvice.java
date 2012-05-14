package org.shengrui.oa.component.ehcache;

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
