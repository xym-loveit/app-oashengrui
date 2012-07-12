package org.shengrui.oa.service.admin.impl;

import java.util.List;

import org.shengrui.oa.dao.admin.DAOWorkType;
import org.shengrui.oa.model.admin.ModelAdminWorkType;
import org.shengrui.oa.service.admin.ServiceAdminWorkType;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation for work type 
 * 
 * @author Tang
 *
 */
public class ServiceAdminWorkTypeImpl
extends ServiceGenericImpl<ModelAdminWorkType> implements ServiceAdminWorkType
{
	private DAOWorkType daoWorkType;
	
	public ServiceAdminWorkTypeImpl(DAOWorkType dao) 
	{
		super(dao);
		this.daoWorkType = dao;
	}
	
	@Override
	public List<ModelAdminWorkType> getAllWorkTypes() throws ServiceException  
	{
		return this.getAll();
	}


	public DAOWorkType getDaoWorkType() {
		return daoWorkType;
	}

	public void setDaoWorkType(DAOWorkType daoWorkType) {
		this.daoWorkType = daoWorkType;
	}




	

}
