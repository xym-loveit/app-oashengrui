package cn.trymore.core.dao.impl;

import java.util.List;
import java.util.Map;
import java.io.Serializable;
import java.sql.SQLException;
import java.lang.reflect.ParameterizedType;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.model.ModelBase;
import cn.trymore.core.web.paging.PaginationSupport;

/**
 * The implementation of base generic repository.
 *  
 * @param <T> Target domain
 * @author Jeccy.Zhao
 */
public class DAOGenericImpl<T extends ModelBase> 
extends HibernateDaoSupport implements DAOGeneric<T>
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(DAOGenericImpl.class);
			
	/**
	 * The entity class
	 */
	private Class<T> entityClass;
	
	/**
	 * The default constructor
	 */
	@SuppressWarnings("unchecked")
	public DAOGenericImpl()
	{
		entityClass = (Class<T>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.mali.dao.common.BaseDAO#saveOrUpdate(java.lang.Object)
	 */
	public String saveOrUpdate(final T domain)
			throws DAOException
	{
		getHibernateTemplate().saveOrUpdate(domain);
		
		return domain.getId();
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.mali.dao.common.BaseDAO#remove(java.lang.Object)
	 */
	public String remove(final T domain)
			throws DAOException
	{
		String id = domain.getId();
		
		getHibernateTemplate().delete(domain);
		
		return id;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAOGeneric#merge(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public T merge(T domain) throws DAOException
	{
		getHibernateTemplate().merge(domain);
		
		return domain;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAOGeneric#evict(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public void evict(T domain) throws DAOException
	{
		getHibernateTemplate().evict(domain);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.mali.dao.common.BaseDAO#get(java.io.Serializable)
	 */
	@SuppressWarnings("unchecked")
	public T get(Serializable id)
			throws DAOException
	{
		return id != null ? (T)getHibernateTemplate().get(entityClass, id) : null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAOGeneric#getAll()
	 */
	@SuppressWarnings("unchecked")
	public List<T> getAll()
			throws DAOException
	{
		return (List<T>)getHibernateTemplate().execute(new HibernateCallback()
		{
			
			@Override
			public Object doInHibernate(Session paramSession) throws HibernateException,
					SQLException
			{
				String str = "from " + DAOGenericImpl.this.entityClass;
				return paramSession.createQuery(str).list();
			}
		});
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAOGeneric#flush()
	 */
	public void flush()
			throws DAOException
	{
		getHibernateTemplate().flush();
	}

	/*
	 * (non-Javadoc)
	 * @see org.mary.dao.common.BaseDAO#findListByNativeSQL(java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findListByNativeSQL(final String nativeSql)
			throws DAOException
	{
		return getSession().createSQLQuery(nativeSql).list();
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.mary.dao.common.BaseDAO#findListByNativeSQL(java.lang.String, java.lang.Class)
	 */
	@SuppressWarnings("rawtypes")
	public List findListByNativeSQL(final String nativeSql, 
			Class<?> claz) throws DAOException
	{
		return getSession().createSQLQuery(nativeSql).addEntity(claz).list();
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.mary.dao.common.BaseDAO#getListByHSQL(java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public List<T> findListByHSQL(final String hsql)
			throws DAOException
	{
		return (List<T>)getHibernateTemplate().find(hsql);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.mary.dao.common.BaseDAO#findListByNamedQuery(java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public List<T> findListByNamedQuery(final String query)
			throws DAOException
	{
		return (List<T>)getHibernateTemplate().findByNamedQuery(query);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.mary.dao.common.BaseDAO#execUpdateByNativeSQL(java.lang.String)
	 */
	/*
	public int execUpdateByNativeSQL(final String nativeSql)
			throws DAOException
	{
		return getSession().createSQLQuery(nativeSql).executeUpdate();
	}
	*/
	
	/*
	 * (non-Javadoc)
	 * @see org.mali.dao.common.BaseDAO#getListByCriteria(org.hibernate.criterion.DetachedCriteria)
	 */
	@SuppressWarnings("unchecked")
	public List<T> getListByCriteria(final DetachedCriteria criteria)
			throws DAOException
	{
		return (List<T>) getHibernateTemplate().findByCriteria(criteria);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.mali.dao.common.BaseDAO#getListByCriteria(org.hibernate.criterion.DetachedCriteria, int, int)
	 */
	@SuppressWarnings("unchecked")
	public List<T> getListByCriteria(final DetachedCriteria criteria,
			int firstResult,int maxResults) throws DAOException
	{
		return (List<T>)getHibernateTemplate().findByCriteria(criteria, firstResult, maxResults);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.mali.dao.common.BaseDAO#findPageByCriteria(org.hibernate.criterion.DetachedCriteria, int, int)
	 */
	@SuppressWarnings("unchecked")
	public PaginationSupport<T> findPageByCriteria(final DetachedCriteria criteria, 
			final int pageSize, final int startIndex) throws DAOException
	{
		return (PaginationSupport<T>)getHibernateTemplate().execute(new HibernateCallback()
		{
			public Object doInHibernate(Session session) throws HibernateException, SQLException 
			{
				Criteria execCriteria = criteria.getExecutableCriteria(session);
				
				int rowCount = ((Integer)execCriteria.setProjection(Projections.rowCount()).uniqueResult()).intValue();
				execCriteria.setProjection(null);
				execCriteria.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
				execCriteria.setFirstResult(startIndex);
				
				if(pageSize > 0)
				{
					execCriteria.setMaxResults(pageSize);	
				}
				else
				{
					execCriteria.setMaxResults(rowCount);
				}
				List<T> items = execCriteria.list();
				return rowCount > 0 ? new PaginationSupport<T>(items, rowCount, startIndex, 
						pageSize >0 ? pageSize : rowCount) : null;
			}
		});
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.lzcp.dao.DAOBase#queryFieldsListForPaging(java.lang.Class, java.util.Map, int, int)
	 */
	public 	PaginationSupport<T> queryFieldsListForPaging(final Class<?> objectClass, 
			Map<String, List<Object>> params, int pageSize, int startIndex) throws DAOException
	{
		
		DetachedCriteria criteria = DetachedCriteria.forClass(objectClass);
		
		if (params != null && params.size() > 0)
		{
			for (Map.Entry<String, List<Object>> entry : params.entrySet())
			{
				String keyName = entry.getKey();
				List<Object> keyValues = entry.getValue();
				criteria.add(Restrictions.in(keyName, keyValues));
			}
		}
		
		return findPageByCriteria(criteria, pageSize, startIndex);
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.lzcp.dao.DAOBase#queryFieldsListForPaging(java.lang.String, java.util.Map, java.util.List, int, int)
	 */
	public 	PaginationSupport<T> queryFieldsListForPaging(final String objectClassName, 
			Map<String, List<Object>> params, int pageSize, int startIndex) throws DAOException, ClassNotFoundException
	{
		return queryFieldsListForPaging(Class.forName(objectClassName), params, pageSize, startIndex);
	}

	public static Logger getLogger() 
	{
		return LOGGER;
	}
}
