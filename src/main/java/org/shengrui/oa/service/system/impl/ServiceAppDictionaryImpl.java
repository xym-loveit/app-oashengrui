package org.shengrui.oa.service.system.impl;

import java.util.List;

import org.shengrui.oa.dao.system.DAOAppDictionary;
import org.shengrui.oa.model.system.ModelAppDictionary;
import org.shengrui.oa.service.system.ServiceAppDictionary;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation of 
 * application dictionary service.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceAppDictionaryImpl
extends ServiceGenericImpl<ModelAppDictionary> implements ServiceAppDictionary
{
	
	/**
	 * The application dictionary repository.
	 */
	private DAOAppDictionary daoAppDict;
	
	/**
	 * The sole constructor.
	 * 
	 * @param dao
	 */
	public ServiceAppDictionaryImpl(DAOAppDictionary dao)
	{
		super(dao);
		this.daoAppDict = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppDictionary#getByItemName(java.lang.String)
	 */
	@Override
	public List<ModelAppDictionary> getByItemName(String itemName)
			throws ServiceException
	{
		try
		{
			return this.daoAppDict.getByItemName(itemName);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}

	public void setDaoAppDict(DAOAppDictionary daoAppDict)
	{
		this.daoAppDict = daoAppDict;
	}

	public DAOAppDictionary getDaoAppDict()
	{
		return daoAppDict;
	}

}
