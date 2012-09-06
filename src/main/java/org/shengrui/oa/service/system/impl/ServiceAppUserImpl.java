package org.shengrui.oa.service.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOAppUser;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.service.system.ServiceAppUser;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The application user service implementation.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceAppUserImpl
extends ServiceGenericImpl<ModelAppUser> implements ServiceAppUser
{
	
	/**
	 * The application user repository
	 */
	private DAOAppUser daoAppUser;
	
	@Override
	public ModelAppUser findByUserName (String userName) throws ServiceException
	{
		try
		{
			return this.daoAppUser.findByUserName(userName);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppUser#findByUserName(java.lang.String)
	 */
	@Override
	public List<ModelAppUser> findByFullName(String fullName) throws ServiceException
	{
		return this.findByFullName(fullName, false);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppUser#findByUserName(java.lang.String, boolean)
	 */
	@Override
	public List<ModelAppUser> findByFullName(String fullName, boolean fetchAll) throws ServiceException
	{
		try
		{
			return this.daoAppUser.findByFullName(fullName, fetchAll);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceAppUser#getUserPagination(org.shengrui.oa.model.system.ModelAppUser, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelAppUser> getUserPagination(
			ModelAppUser entity, PagingBean pagingBean) throws ServiceException
	{
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/**
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias(ModelAppUser entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppUser.class);
		
		if (entity != null)
		{
			if (UtilString.isNotEmpty(entity.getUsername()))
			{
				criteria.add(Restrictions.like("username", entity.getUsername(), MatchMode.ANYWHERE));
			}
			
			if (UtilString.isNotEmpty(entity.getFullName()))
			{
				criteria.add(Restrictions.like("fullName", entity.getFullName(), MatchMode.ANYWHERE));
			}
			
		}
		
		// 过滤已删除的用户账号...
		criteria.add(Restrictions.or(
				Restrictions.eq("delFlag", ModelAppUser.FLAG_UNDEL), 
				Restrictions.isNull("delFlag")));
		
		return criteria;
	}
	
	public ServiceAppUserImpl(DAOAppUser dao)
	{
		super(dao);
		
		this.daoAppUser = dao;
	}

	public void setDaoAppUser(DAOAppUser daoAppUser)
	{
		this.daoAppUser = daoAppUser;
	}

	public DAOAppUser getDaoAppUser()
	{
		return daoAppUser;
	}

	@Override
	public ModelAppUser getPasswordByUserName(String userName)
			throws ServiceException {
		// TODO Auto-generated method stub
		ModelAppUser modelAppUser = null;
		try {
			 modelAppUser =  daoAppUser.getPasswordByUserName(userName);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return modelAppUser;
	}
	
}
