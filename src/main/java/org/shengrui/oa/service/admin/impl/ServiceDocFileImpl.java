package org.shengrui.oa.service.admin.impl;

import org.shengrui.oa.dao.admin.DAODocFile;
import org.shengrui.oa.model.admin.ModelDocFile;
import org.shengrui.oa.service.admin.ServiceDocFile;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation for doc file information.
 * 
 * @author Tang
 *
 */
public class ServiceDocFileImpl
extends ServiceGenericImpl<ModelDocFile> implements ServiceDocFile
{
	private DAODocFile daoDocFile;
	
	public ServiceDocFileImpl(DAODocFile dao) {
		super(dao);
		this.daoDocFile = dao;
	}
	

	public DAODocFile getDaoDocFile() {
		return daoDocFile;
	}

	public void setDaoDocFile(DAODocFile daoDocFile) {
		this.daoDocFile = daoDocFile;
	}

}
