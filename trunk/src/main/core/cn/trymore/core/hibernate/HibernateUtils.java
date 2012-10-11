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

package cn.trymore.core.hibernate;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;

/**
 * The helper class for Hibernate.
 * 
 * @author Jeccy.Zhao
 *
 */
public class HibernateUtils 
{
	
	/**
	 * QBC中多个OR的查询
	 * @param crit1
	 * @param crit2
	 * @return
	 */
	public static Criterion QBC_OR(Criterion crit1, Criterion crit2)
	{
		if (crit1 == null) 
		{
			return crit2;
		}
		
		if (crit2 == null) 
		{
			return crit1;
		}
		
		return Restrictions.or(crit1, crit2);
	}
	
	/**
	 * QBC中多个AND的查询
	 * @param crit1
	 * @param crit2
	 * @return
	 */
	public static Criterion QBC_AND(Criterion crit1, Criterion crit2)
	{
		if (crit1 == null) 
		{
			return crit2;
		}
		
		if (crit2 == null) 
		{
			return crit1;
		}
		
		return Restrictions.and(crit1, crit2);
	}
	
}
