package org.shengrui.oa.service.system.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.shengrui.oa.dao.system.DAOAppRole;
import org.shengrui.oa.model.system.ModelAppFunction;
import org.shengrui.oa.model.system.ModelAppFunctionUrl;
import org.shengrui.oa.model.system.ModelAppRole;
import org.shengrui.oa.service.system.ServiceAppRole;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation of service of application role
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceAppRoleImpl
extends ServiceGenericImpl<ModelAppRole> implements ServiceAppRole
{
	
	/**
	 * The repository of application role.
	 */
	private DAOAppRole daoAppRole;
	
	/**
	 * The sole constructor 
	 * 
	 * @param dao
	 */
	public ServiceAppRoleImpl(DAOAppRole dao)
	{
		super(dao);
		
		this.setDaoAppRole(dao);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppRole#getRoleByName(java.lang.String)
	 */
	@Override
	public ModelAppRole getRoleByName(String roleName) throws ServiceException
	{
		try
		{
			return this.daoAppRole.getRoleByName(roleName);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppRole#getSecurityDataSource()
	 */
	@Override
	public Map<String, Set<String>> getSecurityDataSource() throws ServiceException
	{
		Map<String, Set<String>> securityRoleData = new HashMap<String, Set<String>>();
		
		List<ModelAppRole> roles = this.getAll();
		if (roles != null)
		{
			for (ModelAppRole role : roles)
			{
				Set<String> setRoleFuncs = new TreeSet<String>();
				
				if (role.getFunctions() != null && role.getFunctions().size() > 0)
				{
					for (ModelAppFunction func : role.getFunctions())
					{
						for (ModelAppFunctionUrl url : func.getFuncURLs())
						{
							setRoleFuncs.add(url.getUrlPath());
						}
					}
				}
				
				securityRoleData.put(role.getRoleName(), setRoleFuncs);
			}
		}
		
		return securityRoleData;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppRole#getRoleByKey(java.lang.String)
	 */
	@Override
	public ModelAppRole getRoleByKey (String roleKey) throws ServiceException
	{
		try
		{
			return this.daoAppRole.getRoleByKey(roleKey);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	public DAOAppRole getDaoAppRole()
	{
		return daoAppRole;
	}

	public void setDaoAppRole(DAOAppRole daoAppRole)
	{
		this.daoAppRole = daoAppRole;
	}
	
}
