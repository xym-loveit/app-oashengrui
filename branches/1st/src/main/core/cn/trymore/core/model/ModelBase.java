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

package cn.trymore.core.model;

import java.util.Date;
import java.util.Set;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.struts.action.ActionForm;

import cn.trymore.core.struts.BeanDateConnverter;
import cn.trymore.oa.model.system.ModelFileAttach;

import com.google.gson.annotations.Expose;

/**
 * The base model
 * 
 * @author Jeccy.Zhao
 *
 */
public abstract class ModelBase 
extends ActionForm
{
	/**
	 * The serial version UID
	 */
	private static final long serialVersionUID = -240826378108165136L;
	
	/**
	 * The model identity
	 */
	@Expose
	protected String id = null;
	
	/**
	 * The attachment files,
	 * 
	 * <pre>
	 * <b>Reminder:</b>
	 * Just take it into use when necessary 
	 * since not all of entities has property of attachment. 
	 * </pre>
	 * 
	 */
	private Set<ModelFileAttach> attachFiles;
	
	static
	{
		ConvertUtils.register(new BeanDateConnverter(), Date.class);
	}
	
	public String getId()
	{
		return id;
	}
	
	public void setId(String id)
	{
		this.id = (id == null || Integer.parseInt(id) <= 0) ? null : id;
	}

	public void setAttachFiles(Set<ModelFileAttach> attachFiles)
	{
		this.attachFiles = attachFiles;
	}

	public Set<ModelFileAttach> getAttachFiles()
	{
		return attachFiles;
	}
}
