package cn.trymore.core.service.impl;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.model.ModelBase;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The abstract base service
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceGenericImpl<T extends ModelBase>
implements ServiceGeneric<T>
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(ServiceGenericImpl.class);
	
	/**
	 * The generic repository
	 */
	protected DAOGeneric<T> dao;
	
	/**
	 * The constructor with parameter of generic DAO.
	 *  
	 * @param dao
	 */
	public ServiceGenericImpl (DAOGeneric<T> dao)
	{
		this.dao = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#save(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public T save(T domain) throws ServiceException
	{
		try
		{
			dao.saveOrUpdate(domain);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
		
		return domain;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#merge(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public T merge(T domain) throws ServiceException
	{
		try
		{
			dao.merge(domain);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
		
		return domain;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#evict(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public void evict(T domain) throws ServiceException
	{
		try
		{
			dao.evict(domain);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#get(java.lang.String)
	 */
	@Override
	public T get(String id) throws ServiceException
	{
		try
		{
			return dao.get(id);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#getAll()
	 */
	@Override
	public List<T> getAll() throws ServiceException
	{
		try
		{
			return dao.getAll();
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#getAll()
	 */
	@Override
	public PaginationSupport<T> getAll(final DetachedCriteria criteria, 
			final PagingBean pagingBean) throws ServiceException
	{
		try
		{
			return dao.findPageByCriteria(criteria, pagingBean);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#getByQuery(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public PaginationSupport<T> getByQuery (final String nativeSql, 
			final PagingBean pagingBean) throws ServiceException
	{
		try
		{
			Class<T> entityClass = (Class<T>) ((ParameterizedType) getClass()
					.getGenericSuperclass()).getActualTypeArguments()[0];
			
			DetachedCriteria criteria = DetachedCriteria.forClass(entityClass);
			
			if (UtilString.isNotEmpty(nativeSql))
			{
				if (nativeSql.trim().toLowerCase().startsWith("and"))
				{
					criteria.add(Restrictions.sqlRestriction(
							nativeSql.toLowerCase().replaceFirst("and", "")));
				}
				else
				{
					criteria.add(Restrictions.sqlRestriction(nativeSql));
				}
			}
			
			return dao.findPageByCriteria(criteria, pagingBean);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}

	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#remove(java.lang.String)
	 */
	@Override
	public void remove(String id) throws ServiceException
	{
		remove(get(id));
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#remove(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public void remove(T domain) throws ServiceException
	{
		try
		{
			dao.remove(domain);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#flush()
	 */
	@Override
	public void flush() throws ServiceException
	{
		try
		{
			dao.flush();
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#getAffectedNumByQuery(java.lang.Class, java.lang.String)
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public int getAffectedNumByQuery (final Class clas, 
			String whereCloud)
	{
		try
		{
			if (UtilString.isNotEmpty(whereCloud))
			{
				return dao.getAffectedNumByQueryFilter(clas, whereCloud);
			}
			else
			{
				return 0;
			}
		}
		catch (DAOException e)
		{
			LOGGER.error("Affected number cannot be obtained.");
			return 0;
		}
		catch (ClassNotFoundException e)
		{
			LOGGER.error("Entity cannot be found with class:" + clas.getName());
			return 0;
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceGeneric#getAffectedNumByQuery(java.lang.String, java.lang.String)
	 */
	@Override
	public int getAffectedNumByQuery (final String nativeSql, 
			String whereCloud)
	{
		try
		{
			String sql = nativeSql;
			if (UtilString.isNotEmpty(whereCloud))
			{
				sql = sql + " " + whereCloud;
			}
			
			return dao.getCountByNativeSQL(sql);
		}
		catch (Exception e)
		{
			LOGGER.error("Affected number cannot be obtained.");
			return 0;
		}
	}
	
	public DAOGeneric<T> getDao()
	{
		return dao;
	}

	public void setDao(DAOGeneric<T> dao)
	{
		this.dao = dao;
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}
}
