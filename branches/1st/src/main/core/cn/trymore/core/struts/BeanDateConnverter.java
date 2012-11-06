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

package cn.trymore.core.struts;

import org.apache.commons.beanutils.Converter;
import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;

public class BeanDateConnverter
implements Converter
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger logger = Logger.getLogger(BeanDateConnverter.class);
	
	/**
	 * The accepted data format
	 */
	public static final String[] ACCEPT_DATE_FORMATS = { "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd" };
	
	/*
	 * (non-Javadoc)
	 * @see org.apache.commons.beanutils.Converter#convert(java.lang.Class, java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Object convert(Class arg0, Object paramObject)
	{
		logger.debug("conver " + paramObject + " to date object");
		
		String str = paramObject.toString();
		
		try
		{
			return DateUtils.parseDate(str, ACCEPT_DATE_FORMATS);
		}
		catch (Exception localException)
		{
			logger.debug("parse date error:" + localException.getMessage());
		}
		
		return null;
	}
	
}
