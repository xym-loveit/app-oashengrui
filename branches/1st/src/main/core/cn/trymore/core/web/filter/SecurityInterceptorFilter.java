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

package cn.trymore.core.web.filter;

import java.io.IOException;
import java.util.Map;
import java.util.Set;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.shengrui.oa.model.system.ModelAppRole;
import org.springframework.security.AccessDeniedException;
import org.springframework.security.Authentication;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import cn.trymore.core.security.SecurityDataSource;
import cn.trymore.core.util.UtilApp;

/**
 * The security intercepter filter
 * 
 * @author Jeccy.Zhao
 *
 */
public class SecurityInterceptorFilter
extends OncePerRequestFilter
{
	
	/**
	 * The URL map for role
	 */
	private Map<String, Set<String>> roleUrlsMap;
	
	/**
	 * The security data source.
	 */
	private SecurityDataSource securityDataSource;
	
	/*
	 * (non-Javadoc)
	 * @see org.springframework.web.filter.OncePerRequestFilter#doFilterInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, javax.servlet.FilterChain)
	 */
	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filter)
			throws ServletException, IOException
	{
		// obtains requested URI
		String requestURI = UtilApp.getRequestURI(request);
		
		requestURI = "/" + requestURI;
		
		boolean isCommonRole = false;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		for (int i = 0, size = auth.getAuthorities().length; i < size; i++)
		{
			if (ModelAppRole.ROLE_SUPER.equals(auth.getAuthorities()[i].getAuthority()))
			{
				isCommonRole = true;
				break;
			}
			
			if (!ModelAppRole.ROLE_PUBLIC.equals(auth.getAuthorities()[i].getAuthority()) || 
					!ModelAppRole.ROLE_ANONYMOUS.equals(auth.getAuthorities()[i].getAuthority()))
			{
				continue;
			}
			
			isCommonRole = true;
		}
		
		// if specified role found
		if (!isCommonRole && !isUrlGrantedRight(requestURI, auth))
		{
			if (this.logger.isDebugEnabled())
			{
				this.logger.debug("Ungranted url:" + requestURI);
			}
			
			throw new AccessDeniedException(
					"Access is denied! Url:" + requestURI + " User:" + SecurityContextHolder.getContext().getAuthentication().getName());
		}
		
		if (this.logger.isDebugEnabled())
		{
			this.logger.debug("pass the url:" + requestURI);
		}
		
		filter.doFilter(request, response);
		
	}
	
	/**
	 * Loads the data source
	 */
	public void loadDataSource()
	{
		this.roleUrlsMap = this.securityDataSource.getDataSource();
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.springframework.web.filter.GenericFilterBean#afterPropertiesSet()
	 */
	@Override
	public void afterPropertiesSet() throws ServletException
	{
		this.loadDataSource();
		if (this.roleUrlsMap == null)
		{
			throw new RuntimeException("没有进行设置系统的权限匹配数据源");
		}
	}
	
	/**
	 * Returns true if the specified URL is granted with right.
	 * 
	 * @param url
	 * @param auth
	 * @return
	 */
	private boolean isUrlGrantedRight(String url, Authentication auth)
	{
		for (GrantedAuthority localGrantedAuthority : auth.getAuthorities())
		{
			Set<String> localSet = this.roleUrlsMap.get(localGrantedAuthority.getAuthority());
			
			if (localSet != null)
			{
				for (String authUrl : localSet)
				{	
					if (url.indexOf(authUrl) > -1)
					{
						return true;
					}
				}
			}
			
			/*
			if (localSet != null && (localSet.contains(url) || localSet.contains("/" + url)))
			{
				return true;
			}
			*/
		}
		
		return false;
	}

	public void setSecurityDataSource(SecurityDataSource securityDataSource)
	{
		this.securityDataSource = securityDataSource;
	}

	public SecurityDataSource getSecurityDataSource()
	{
		return securityDataSource;
	}

	public void setRoleUrlsMap(Map<String, Set<String>> roleUrlsMap)
	{
		this.roleUrlsMap = roleUrlsMap;
	}

	public Map<String, Set<String>> getRoleUrlsMap()
	{
		return roleUrlsMap;
	}
	
}
