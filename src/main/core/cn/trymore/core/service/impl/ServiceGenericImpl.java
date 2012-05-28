package cn.trymore.core.service.impl;

import java.util.List;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.model.ModelBase;
import cn.trymore.core.service.ServiceGeneric;

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
	 * The repository
	 */
	protected DAOGeneric<T> dao = null;
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceBase#save(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public T save(T paramT)
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceBase#merge(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public T merge(T paramT)
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceBase#evict(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public void evict(T paramT)
	{
		// TODO Auto-generated method stub
		
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceBase#get(java.lang.String)
	 */
	@Override
	public T get(String paramPK)
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceBase#getAll()
	 */
	@Override
	public List<T> getAll()
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceBase#remove(java.lang.String)
	 */
	@Override
	public void remove(String paramPK)
	{
		// TODO Auto-generated method stub
		
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceBase#remove(cn.trymore.core.model.ModelBase)
	 */
	@Override
	public void remove(T paramT)
	{
		// TODO Auto-generated method stub
		
	}
	
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.core.service.ServiceBase#flush()
	 */
	@Override
	public void flush()
	{
		// TODO Auto-generated method stub
		
	}
	
}
