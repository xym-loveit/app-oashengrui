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

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * Helper class for annotation scanning.
 * 
 * @author Jeccy.Zhao
 *
 */
public class UtilAnnotation
{
	/**
	 * Obtains list of annotation objects from entity 
	 * 
	 * @param entity
	 * @param annotation
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List<Object> getAnnotationFromEntityFields (Class entity, Class annotation)
	{
		List<Object> objs = null;
		
		Field[] fields = entity.getDeclaredFields();
		if (fields != null)
		{
			for (Field field : fields)
			{
				if (field.isAnnotationPresent(annotation))
				{
					if (objs == null)
					{
						objs = new ArrayList<Object>();
					}
					
					objs.add(field.getAnnotation(annotation));
				}
			}
		}
		
		return objs;
	}
	
	/**
	 * Obtains list of annotation objects from entity 
	 * 
	 * @param entity
	 * @param annotation
	 * @return
	 */
	@SuppressWarnings({"rawtypes" })
	public static Object getSingleAnnotationFromEntity (Class entity, Class annotation)
	{
		List<Object> obj = getAnnotationFromEntityFields(entity, annotation);
		if (obj != null && obj.size() > 0)
		{
			return obj.get(0);
		}
		
		return null;
	}
	
}
