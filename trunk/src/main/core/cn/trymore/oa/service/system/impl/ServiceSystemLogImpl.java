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

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
import cn.trymore.oa.dao.system.DAOSystemLog;
import cn.trymore.oa.model.system.ModelSystemLog;
import cn.trymore.oa.service.system.ServiceSystemLog;

/**
 * The system log service implementation
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceSystemLogImpl
extends ServiceGenericImpl<ModelSystemLog> implements ServiceSystemLog
{
	private DAOSystemLog daoSystemLog;
	
	public ServiceSystemLogImpl (DAOSystemLog dao)
	{
		super(dao);
		this.daoSystemLog = dao;
	}
	
	public DAOSystemLog getDaoSystemLog()
	{
		return daoSystemLog;
	}

	public void setDaoSystemLog(DAOSystemLog daoSystemLog)
	{
		this.daoSystemLog = daoSystemLog;
	}

	@Override
	public ModelSystemLog getById(String id) throws ServiceException {
		// TODO Auto-generated method stub
		try {
			this.daoSystemLog.get(id);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
		return null;
	}

	@Override
	public PaginationSupport<ModelSystemLog> getPaginationByEntity(
			ModelSystemLog entity, PagingBean pagingBean)
			throws ServiceException {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria
		.forClass(ModelSystemLog.class);
		if(entity != null){
			if(UtilString.isNotEmpty(entity.getExeOperation()))
				criteria.add(Restrictions.eq("exeOperation", entity.getExeOperation()));
			if(entity.getDistrictId()!=null && UtilString.isNotEmpty(entity.getDistrictId()))
				criteria.createCriteria("user").createCriteria("district").add(Restrictions.eq("id", entity.getDistrictId()));
			if(entity.getStartTime()!=null && UtilString.isNotEmpty(entity.getStartTime()))
				criteria.add(Restrictions.ge("createtime", entity.getStartTime()));
			if(entity.getEndTime()!=null && UtilString.isNotEmpty(entity.getEndTime()))
				criteria.add(Restrictions.le("createtime", entity.getEndTime()));
		}
		return this.getAll(criteria, pagingBean);
	}
}
