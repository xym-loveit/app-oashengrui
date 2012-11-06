package org.shengrui.oa.service.system.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOSchoolPositionSet;
import org.shengrui.oa.model.system.ModelSchoolPositionSet;
import org.shengrui.oa.service.system.ServiceSchoolPositionSet;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The school position set implementation.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceSchoolPositionSetImpl
extends ServiceGenericImpl<ModelSchoolPositionSet> implements ServiceSchoolPositionSet
{
	/**
	 * The school position set repository.
	 */
	private DAOSchoolPositionSet daoSchoolPositionSet;
	
	/**
	 * The constructor.
	 * 
	 * @param dao
	 */
	public ServiceSchoolPositionSetImpl(DAOSchoolPositionSet dao)
	{
		super(dao);
		this.daoSchoolPositionSet = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolPositionSet#getByName(java.lang.String)
	 */
	@Override
	public ModelSchoolPositionSet getByName(String posetName)
			throws ServiceException
	{
		try
		{
			return this.daoSchoolPositionSet.getByName(posetName);
		} 
		catch (DAOException e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolPositionSet#getPagination(org.shengrui.oa.model.system.ModelSchoolPositionSet, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelSchoolPositionSet> getPagination(
			ModelSchoolPositionSet entity, PagingBean pagingBean)
			throws ServiceException
	{
		return this.getAll(getCriterias(entity), pagingBean);
	}
	
	/**
	 * Obtains criteria with the specified entity.
	 * 
	 * @param entity
	 *          the school position set entity
	 * @return criteria
	 */
	private DetachedCriteria getCriterias(ModelSchoolPositionSet entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelSchoolPositionSet.class);
		
		if (entity != null)
		{
			if (UtilString.isNotEmpty(entity.getPosetName()))
			{
				criteria.add(Restrictions.like("posetName", entity.getPosetName(), MatchMode.ANYWHERE));
			}
		}
		
		return criteria;
	}
	
	public void setDaoSchoolPositionSet(DAOSchoolPositionSet daoSchoolPositionSet)
	{
		this.daoSchoolPositionSet = daoSchoolPositionSet;
	}

	public DAOSchoolPositionSet getDaoSchoolPositionSet()
	{
		return daoSchoolPositionSet;
	}

}
