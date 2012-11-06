package org.shengrui.oa.service.system.impl;

import java.util.List;

import org.shengrui.oa.dao.system.DAOSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.service.system.ServiceSchoolDepartmentPosition;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation of service of school department position
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceSchoolDepartmentPositionImpl
extends ServiceGenericImpl<ModelSchoolDepartmentPosition> implements ServiceSchoolDepartmentPosition
{
	
	private DAOSchoolDepartmentPosition daoSchoolDepartmentPosition;
	
	public ServiceSchoolDepartmentPositionImpl (DAOSchoolDepartmentPosition dao)
	{
		super(dao);
		this.daoSchoolDepartmentPosition = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolDepartmentPosition#getPositionByDepartmentId(java.lang.String)
	 */
	@Override
	public List<ModelSchoolDepartmentPosition> getPositionByDepartmentId(
			String departmentId) throws ServiceException
	{
		try
		{
			return this.daoSchoolDepartmentPosition.getPositionByDepartmentId(departmentId);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolDepartmentPosition#getPositionByName(java.lang.String)
	 */
	@Override
	public ModelSchoolDepartmentPosition getPositionByName(String positionName)
			throws ServiceException 
	{
		try 
		{
			return daoSchoolDepartmentPosition.getPositionByName(positionName);
		} 
		catch (Exception e) 
		{
			throw new ServiceException(e);
		}
	}
	
	public DAOSchoolDepartmentPosition getDaoSchoolDepartmentPosition()
	{
		return daoSchoolDepartmentPosition;
	}

	public void setDaoSchoolDepartmentPosition(
			DAOSchoolDepartmentPosition daoSchoolDepartmentPosition)
	{
		this.daoSchoolDepartmentPosition = daoSchoolDepartmentPosition;
	}
}
