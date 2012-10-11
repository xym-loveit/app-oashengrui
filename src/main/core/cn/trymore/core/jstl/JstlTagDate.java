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

import java.util.Date;

/**
 * 标签库: 时间标签库
 * 
 * Most of the functionalities copy from UtilDateTime
 *
 */
public class JstlTagDate
{
	/**
	 * 获取时间间隔天数
	 * 
	 * @param startday
	 * @param endday
	 * @return
	 */
	public static Integer getIntervalDays(Date startday,Date endday)
	{
		//分别得到两个时间的毫秒数
		long sl=startday.getTime();
		long el=endday.getTime();
	
		long ei=el-sl;
		
		//根据毫秒数计算间隔天数
		return (int)(ei/(1000*60*60*24));
	}
	
	/**
	 * 获取时间间隔秒数
	 * 
	 * @param startday
	 * @param endday
	 * @return
	 */
	public static Integer getIntervalSeconds (Date srcTime, Date dstTime)
	{
		//分别得到两个时间的毫秒数
		long sl=srcTime.getTime();
		long el=dstTime.getTime();
	
		long ei=el-sl;
		
		//根据毫秒数计算间隔秒数
		return (int)(ei/(1000));
	}
}
