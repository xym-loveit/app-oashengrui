package org.shengrui.oa.service.admin.impl;

import org.shengrui.oa.dao.admin.DAODocLevel;
import org.shengrui.oa.model.admin.ModelDocLevel;
import org.shengrui.oa.service.admin.ServiceDocLevel;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation for job hire information.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceDocLevelImpl
extends ServiceGenericImpl<ModelDocLevel> implements ServiceDocLevel
{
	public ServiceDocLevelImpl( DAODocLevel dao) {
		super(dao);
		this.daoDocLevel=dao;
	}

	private DAODocLevel daoDocLevel;

	public DAODocLevel getDaoDocLevel() {
		return daoDocLevel;
	}

	public void setDaoDocLevel(DAODocLevel daoDocLevel) {
		this.daoDocLevel = daoDocLevel;
	}
	
}
