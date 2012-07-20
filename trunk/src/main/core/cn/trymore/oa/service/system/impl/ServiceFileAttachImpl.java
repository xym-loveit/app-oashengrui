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
