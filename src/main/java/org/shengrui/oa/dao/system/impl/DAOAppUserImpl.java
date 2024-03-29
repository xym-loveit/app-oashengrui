package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOAppUser;
import org.shengrui.oa.model.system.ModelAppUser;
import org.springframework.dao.DataAccessException;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.util.UtilString;

/**
 * The repository for application user implementation.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOAppUserImpl
extends DAOGenericImpl<ModelAppUser> implements DAOAppUser, UserDetailsService
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppUser#findByUserName(java.lang.String)
	 */
	@Override
	public ModelAppUser findByUserName (String userName) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppUser.class);
		if (UtilString.isNotEmpty(userName))
		{
			criteria.add(Restrictions.eq("username", userName));
		}
		
		// 过滤已删除的用户账号...
		criteria.add(Restrictions.or(
				Restrictions.eq("delFlag", ModelAppUser.FLAG_UNDEL), 
				Restrictions.isNull("delFlag")));
		
		List<ModelAppUser> result = this.getListByCriteria(criteria);
		
		return result != null && result.size() > 0 ? result.get(0) : null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppUser#getUserByName(java.lang.String)
	 */
	@Override
	public List<ModelAppUser> findByFullName(String fullName, 
			boolean fetchAll) throws DAOException
	{
		return findByFullName(fullName, null, fetchAll);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppUser#findByFullName(java.lang.String, java.lang.String, boolean)
	 */
	@Override
	public List<ModelAppUser> findByFullName(final String fullName, 
			final String localDistrictId, boolean fetchAll) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppUser.class);
		if (UtilString.isNotEmpty(fullName) || fetchAll)
		{
			criteria.add(Restrictions.like("fullName", fullName, MatchMode.ANYWHERE));
		}
		
		// 过滤本校区用户
		if (UtilString.isNotEmpty(localDistrictId))
		{
			criteria.createCriteria("employee").createCriteria("employeeDistrict").add(Restrictions.eq("id", localDistrictId));
		}
		
		
		// 过滤已删除的用户账号...
		criteria.add(Restrictions.or(
				Restrictions.eq("delFlag", ModelAppUser.FLAG_UNDEL), 
				Restrictions.isNull("delFlag")));
		
		return this.getListByCriteria(criteria);
	}
	
	
	
	/*
	 * (non-Javadoc)
	 * @see org.springframework.security.userdetails.UserDetailsService#loadUserByUsername(java.lang.String)
	 */
	@Override
	public UserDetails loadUserByUsername(String userName)
			throws UsernameNotFoundException, DataAccessException
	{
		try
		{
			return this.findByUserName(userName);
		} 
		catch (DAOException e)
		{
			// do nothing..
		}
		
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppUser#getPasswordByUserName(java.lang.String)
	 */
	@Override
	public ModelAppUser getPasswordByUserName(String userName) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAppUser.class);
		criteria.add(Restrictions.eq("username", userName));
		
		// 过滤已删除的用户账号...
		criteria.add(Restrictions.or(
				Restrictions.eq("delFlag", ModelAppUser.FLAG_UNDEL), 
				Restrictions.isNull("delFlag")));
		
		@SuppressWarnings("unchecked")
		List<ModelAppUser> list = getHibernateTemplate().findByCriteria(criteria);
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

}
