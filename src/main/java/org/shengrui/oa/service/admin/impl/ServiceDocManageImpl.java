package org.shengrui.oa.service.admin.impl;

import org.shengrui.oa.dao.admin.DAODocManage;
import org.shengrui.oa.model.admin.ModelDoc;
import org.shengrui.oa.service.admin.ServiceDocManage;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation for doc manage
 * 
 * @author Tang
 *
 */
public class ServiceDocManageImpl
extends ServiceGenericImpl<ModelDoc> implements ServiceDocManage
{

	private DAODocManage daoDocManage;
	
	public ServiceDocManageImpl(DAODocManage dao) {
		super(dao);
		this.daoDocManage=dao;
	}

	
	
	public DAODocManage getDaoDocManage() {
		return daoDocManage;
	}

	public void setDaoDocManage(DAODocManage daoDocManage) {
		this.daoDocManage = daoDocManage;
	}
	
}
