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

package cn.trymore.core.util;

import org.hibernate.cfg.Configuration;
import org.hibernate.mapping.PersistentClass;
import org.shengrui.oa.model.system.ModelAppUser;

/**
 * Entity helper class, i.e. obtains the mapped entity table name.
 * 
 * @author Jeccy.Zhao
 *
 */
public class UtilEntity
{
	private static Configuration hibernateConf;
	
	private static Configuration getHibernateConf() 
	{
		if (hibernateConf == null)
		{
			hibernateConf = new Configuration();
		}
		
		return hibernateConf;
	}
	
	private static PersistentClass getPersistentClass(Class<?> clazz)
	{
		synchronized (UtilEntity.class)
		{
			PersistentClass pc = getHibernateConf().getClassMapping(clazz.getName());
			if (pc == null) 
			{
				hibernateConf = getHibernateConf().addClass(clazz);
				pc = getHibernateConf().getClassMapping(clazz.getName());  
			}
			return pc;
		}
	}
	
	public static String getTableName(Class<?> clazz)
	{
		return getPersistentClass(clazz).getTable().getName();
	}
	
	public static void main (String[] args)
	{
		System.out.println(UtilEntity.getTableName(ModelAppUser.class));
	}
	
}	
