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

package cn.trymore.core.bean;

import java.io.Serializable;

/**
 * The pair bean object.
 * 
 * @author Jeccy.Zhao
 *
 * @param <T>
 * @param <K>
 */
public class PairObject<T,K> implements Serializable 
{
	
	private static final long serialVersionUID = 3823490598416805324L;
	
	private T left;
	private K right;
	
	public PairObject() 
	{ 
		
	}
	
	public PairObject(T left, K right)
	{
		this.left = left;
		this.right = right;
	}
	
	public void setLeft(T left) 
	{
		this.left = left;
	}
	public T getLeft() 
	{
		return left;
	}
	public void setRight(K right) 
	{
		this.right = right;
	}
	public K getRight() 
	{
		return right;
	}
	
	@Override
	public String toString () 
	{
		return "(" + left + ": " + right + ")";
	}
	
}
