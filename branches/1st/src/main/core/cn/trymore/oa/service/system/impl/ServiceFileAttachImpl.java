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

package cn.trymore.oa.service.system.impl;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.oa.dao.system.DAOFileAttach;
import cn.trymore.oa.model.system.ModelFileAttach;
import cn.trymore.oa.service.system.ServiceFileAttach;

/**
 * The implementation of file attachment service.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceFileAttachImpl
extends ServiceGenericImpl<ModelFileAttach> implements ServiceFileAttach
{
	/**
	 * The file attachment repository
	 */
	private DAOFileAttach daoFileAttach;
	
	public ServiceFileAttachImpl(DAOFileAttach dao)
	{
		super(dao);
		this.daoFileAttach = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.oa.service.system.ServiceFileAttach#getByPath(java.lang.String)
	 */
	@Override
	public ModelFileAttach getByPath(String filePath) throws ServiceException
	{
		try
		{
			return this.daoFileAttach.getByPath(filePath);
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
		}
	}
	
	public void setDaoFileAttach(DAOFileAttach daoFileAttach)
	{
		this.daoFileAttach = daoFileAttach;
	}

	public DAOFileAttach getDaoFileAttach()
	{
		return daoFileAttach;
	}

}
