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

package cn.trymore.core.security;

import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.shengrui.oa.model.system.ModelAppRole;
import org.shengrui.oa.service.system.ServiceAppRole;

/**
 * The security data source component
 * 
 * @author Jeccy.Zhao
 *
 */
public class SecurityDataSource
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(SecurityDataSource.class);
	
	/**
	 * The application role service
	 */
	private ServiceAppRole serviceAppRole;
	
	/**
	 * The anonymous URLs
	 */
	private Set<String> anonymousUrls = null;
	
	/**
	 * The public URLs
	 */
	private Set<String> publicUrls = null;
	
	/**
	 * Returns the security data source
	 * 
	 * @return
	 */
	public Map<String, Set<String>> getDataSource()
	{
		try
		{
			Map<String, Set<String>> localHashMap = this.serviceAppRole.getSecurityDataSource();
			localHashMap.put(ModelAppRole.ROLE_ANONYMOUS, this.anonymousUrls);
			localHashMap.put(ModelAppRole.ROLE_PUBLIC, this.publicUrls);
			return localHashMap;
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetching the security data source.", e);
		}
		
		return null;
	}
	
	public ServiceAppRole getServiceAppRole()
	{
		return serviceAppRole;
	}

	public void setServiceAppRole(ServiceAppRole serviceAppRole)
	{
		this.serviceAppRole = serviceAppRole;
	}

	public Set<String> getAnonymousUrls()
	{
		return anonymousUrls;
	}

	public void setAnonymousUrls(Set<String> anonymousUrls)
	{
		this.anonymousUrls = anonymousUrls;
	}

	public Set<String> getPublicUrls()
	{
		return publicUrls;
	}

	public void setPublicUrls(Set<String> publicUrls)
	{
		this.publicUrls = publicUrls;
	}
	
}
