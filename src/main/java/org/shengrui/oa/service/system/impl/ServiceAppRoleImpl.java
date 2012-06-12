package org.shengrui.oa.service.system.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOAppRole;
import org.shengrui.oa.model.system.ModelAppFunction;
import org.shengrui.oa.model.system.ModelAppFunctionUrl;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.model.system.ModelAppRole;
import org.shengrui.oa.service.system.ServiceAppRole;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

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
	 * @see org.shengrui.oa.service.system.ServiceAppRole#getRolesByType(java.lang.Integer)
	 */
	@Override
	public List<ModelAppRole> getRolesByType (Integer roleType) throws ServiceException
	{
		try
		{
			return this.daoAppRole.getRolesByType(roleType);
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
				
				// 合并菜单功能项
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
				
				// 合并菜单项
				if (role.getMenus() != null && role.getMenus().size() > 0)
				{
					for (ModelAppMenu menu : role.getMenus())
					{
						if (menu.getMenuUrl().toLowerCase().indexOf("javascript") == -1)
						{
							// 过滤javascript:void(0);这类URL.
							setRoleFuncs.add(menu.getMenuUrl());
						}
					}
				}
				
				securityRoleData.put(role.getRoleKey(), setRoleFuncs);
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
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppRole#getRolePagination(org.shengrui.oa.model.system.ModelAppRole, cn.trymore.core.web.paging.PagingBean)
	 */
	public PaginationSupport<ModelAppRole> getRolePagination (ModelAppRole entity, 
			PagingBean pagingBean) throws ServiceException
	{
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/**
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias(ModelAppRole entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppRole.class);
		
		if (entity != null)
		{
			if (UtilString.isNotEmpty(entity.getRoleName()))
			{
				criteria.add(Restrictions.eq("roleName", entity.getRoleName()));
			}
			
			if (UtilString.isNotEmpty(entity.getRoleKey()))
			{
				criteria.add(Restrictions.eq("roleKey", entity.getRoleKey()));
			}
			
			if (UtilString.isNotEmpty(entity.getRoleDesc()))
			{
				criteria.add(Restrictions.like("roleDesc", entity.getRoleDesc(), MatchMode.ANYWHERE));
			}
			
			if (entity.getRoleType() != null && entity.getRoleType() > -1)
			{
				criteria.add(Restrictions.eq("roleType", entity.getRoleType()));
			}
			
			if (UtilString.isNotEmpty(entity.getRoleRights()))
			{
				criteria.add(Restrictions.like("roleRights", entity.getRoleRights(), MatchMode.ANYWHERE));
			}
		}
		
		return criteria;
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
