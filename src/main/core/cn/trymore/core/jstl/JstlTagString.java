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

import java.util.Set;

import cn.trymore.core.util.UtilCollection;
import cn.trymore.core.util.UtilString;

/**
 * 标签库: 切割字符串
 * 
 * @author Jeccy.Zhao
 *
 */
public class JstlTagString 
{
	
	/**
	 * 
	 * @param str
	 * @param searchString
	 * @param split
	 * @return
	 */
	public static boolean inRange(final String str, final String searchString, final String split)
	{
		if (UtilString.isNotEmpty(searchString, str))
		{
			String[] arrayOfString = str.split(split);
			for (String ret : arrayOfString)
			{
				if (ret.equals(searchString))
				{
					return true;
				}
			}
		}
		return false;
	}
	
	/**
	 * 
	 * @param stringSet
	 * @param searchString
	 * @return
	 */
	public static boolean contains(final Set<String> stringSet, final String searchString)
	{
		if (UtilString.isNotEmpty(searchString) && UtilCollection.isNotEmpty(stringSet))
		{
			return stringSet.contains(searchString);
		}
		return false;
	}
	
	/**
	 * 
	 * @param str
	 * @param maxByte
	 * @param endStr
	 * @return
	 */
	public static String subString(String str, int maxByte, String endStr) 
	{
		if (str == null || "".equals(str)) 
		{
			// 如果源字符串为空或null，返回空字符串
			str = "";
		} 
		else 
		{
			// 计算字节长度
			int byteLength = 0;
			
			// 计算字符长度
			int charLength = 0;
			
			for (; charLength < str.length(); charLength++) 
			{
				// 计算每个字符的字节数，每个汉字+2byte，其它+1
				byteLength = (int) str.charAt(charLength) > 256 ? byteLength + 2 : byteLength + 1;

				// 超过最大限制字节时，按当前charLength截取字符串
				if (byteLength > maxByte) 
				{
					// 当前长度减去结尾省略字符串的长度的一半（此处将省略字符串假设为半字节字符）
					charLength = charLength - endStr.length() / 2;
					
					// 截取字符串，加上省略字符串
					str = str.substring(0, charLength > 0 ? charLength : 0) + endStr;
					
					// 跳出循环
					break;
				}
			}
		}
		
		return str;
	}
	
}
