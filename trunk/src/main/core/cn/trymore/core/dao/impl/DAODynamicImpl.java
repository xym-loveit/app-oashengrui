package cn.trymore.core.dao.impl;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import cn.trymore.core.dao.DAODynamic;
import cn.trymore.core.exception.DAOException;

/**
 * The implementation of base dynamic repository.
 *  
 * @author Jeccy.Zhao
 */
public class DAODynamicImpl
extends HibernateDaoSupport implements DAODynamic
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(DAODynamicImpl.class);
	
	/**
	 * The entity class name
	 */
	private String entityClassName;
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAODynamic#save(java.lang.Object)
	 */
	@Override
	public Object save(Object paramObject) throws DAOException
	{
		getHibernateTemplate().save(entityClassName, paramObject);
		return paramObject;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAODynamic#merge(java.lang.Object)
	 */
	@Override
	public Object merge(Object paramObject) throws DAOException
	{
		getHibernateTemplate().merge(entityClassName, paramObject);
		return paramObject;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAODynamic#get(java.io.Serializable)
	 */
	@Override
	public Object get(Serializable paramSerializable) throws DAOException
	{
		return getHibernateTemplate().load(entityClassName, paramSerializable);
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAODynamic#remove(java.io.Serializable)
	 */
	@Override
	public void remove(Serializable paramSerializable) throws DAOException
	{
		remove(get(paramSerializable));
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAODynamic#remove(java.lang.Object)
	 */
	@Override
	public void remove(Object paramObject) throws DAOException
	{
		getHibernateTemplate().delete(paramObject);
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAODynamic#evict(java.lang.Object)
	 */
	@Override
	public void evict(Object paramObject) throws DAOException
	{
		getHibernateTemplate().evict(paramObject);
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.dao.DAODynamic#getAll()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getAll() throws DAOException
	{
		return (List<Object>)getHibernateTemplate().execute(new HibernateCallback()
		{
			
			@Override
			public Object doInHibernate(Session paramSession) throws HibernateException,
					SQLException
			{
				String str = "from " + DAODynamicImpl.this.entityClassName;
				return paramSession.createQuery(str).list();
			}
		});
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}

	public void setEntityClassName(String entityClassName)
	{
		this.entityClassName = entityClassName;
	}

	public String getEntityClassName()
	{
		return entityClassName;
	}

}
