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

package cn.trymore.core.acl;

@SuppressWarnings("rawtypes")
public class DataPolicyEngine
{
	//本地线程，用于存储线程公共对象
	private static ThreadLocal threadLocalSession = new ThreadLocal();
	
	/**
	 * 获取本地执行线程
	 *
	 * @return ThreadLocal 
	 * 
	 */
	public static ThreadLocal getThreadLocalSession() 
	{
		return threadLocalSession;
	}
	
	/**
	 * 获取在线程内设置存储的对象
	 */
	public static Object get() 
	{
		return threadLocalSession.get();
	}
	
	/**
	 * 在线程内设置存储对象
	 */
	@SuppressWarnings("unchecked")
	public static void set(Object obj) 
	{
		threadLocalSession.set(obj);
	}
	
	/**
	 * 移除在线程内设置存储的对象
	 */
	public static void remove() 
	{
		threadLocalSession.remove();
	}
	
}
