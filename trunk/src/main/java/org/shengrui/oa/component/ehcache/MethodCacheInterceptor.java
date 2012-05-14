package org.shengrui.oa.component.ehcache;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.ObjectUtils;

public class MethodCacheInterceptor implements InitializingBean, MethodInterceptor 
{

	private final static Logger logger = Logger.getLogger(MethodCacheInterceptor.class);
	
	private Cache cache;
	
	/*
	 * (non-Javadoc)
	 * @see org.springframework.beans.factory.InitializingBean#afterPropertiesSet()
	 */
	public void afterPropertiesSet() throws Exception 
	{
		
	}

	/*
	 * (non-Javadoc)
	 * @see org.aopalliance.intercept.MethodInterceptor#invoke(org.aopalliance.intercept.MethodInvocation)
	 */
	public Object invoke(MethodInvocation invocation) throws Throwable
	{
		String cacheKey = getCacheKey(invocation);
		Element cached = cache.get(cacheKey);
		
		if (cached == null) 
		{  //not hit
			logger.info("Cache not hit for " + invocation);
			//invoke the intercepted method, and put the result into cache
			cached = new Element(cacheKey, invocation.proceed());
			cache.put(cached);
		} 
		else 
		{
			logger.info("Cache hit for " + invocation);
		}
		
		return cached.getValue();
	}
	
	protected String getCacheKey(MethodInvocation invocation)
	{
		String targetClassName = invocation.getThis().getClass().getName();
		String methodName = invocation.getMethod().getName();
		Object[] arguments = invocation.getArguments();
		
		StringBuffer cacheKey = new StringBuffer();
		cacheKey.append(targetClassName).append(".").append(methodName).append("(");
		if (!ObjectUtils.isEmpty(arguments)) 
		{
			for (Object argument : arguments) 
			{
				cacheKey.append(argument).append(",");
			}
			cacheKey.deleteCharAt(cacheKey.length() - 1);
		}
		cacheKey.append(")");
		logger.info(cacheKey.toString());
		return cacheKey.toString();
	}

	public static Logger getLogger() 
	{
		return logger;
	}

	public void setCache(Cache cache)
	{
		this.cache = cache;
	}

	public Cache getCache()
	{
		return cache;
	}

}
