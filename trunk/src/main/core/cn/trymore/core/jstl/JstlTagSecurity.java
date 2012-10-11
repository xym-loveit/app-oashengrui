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

package cn.trymore.core.jstl;

import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.util.UtilString;

/**
 * The JSTL tag to control resources access, i.e. URL access.
 * 
 * @author Jeccy.Zhao
 *
 */
public class JstlTagSecurity
{
	/**
	 * Returns true if the specified menu key granted on
	 * the current user which polled out from session.
	 * 
	 * @param menuKey
	 *          the menu key
	 * @return
	 */
	public static boolean ifMenuGranted (String menuKey)
	{
		ModelAppUser user = ContextUtil.getCurrentUser();
		if (user != null)
		{
			// 管理员角色
			if (user.isSuerUser())
			{
				return true;
			}
			
			return user.getMenuKeys() != null && user.getMenuKeys().contains(menuKey);
		}
		return false;
	}
	
	/**
	 * Returns true if the specified function key granted on
	 * the current user which polled out from session.
	 * 
	 * @param funcKeys
	 *          the function keys, multi function key separated with ,
	 * @return
	 */
	public static boolean ifGranted (String funcKeys)
	{
		ModelAppUser user = ContextUtil.getCurrentUser();
		if (user != null)
		{
			// 管理员角色
			if (user.isSuerUser())
			{
				return true;
			}
			
			if (UtilString.isNotEmpty(user.getFunctionRights()))
			{
				String[] arrayFuncKeys = funcKeys.split(",");
				for (String funcKey : arrayFuncKeys)
				{
					if (JstlTagString.inRange(user.getFunctionRights(), funcKey, ","))
					{
						return true;
					}
				}
			}
		}
		return false;
	}
}
