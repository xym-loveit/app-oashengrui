package org.shengrui.oa.service.flow.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.flow.DAOProcessTask;
import org.shengrui.oa.model.flow.ModelProcessTask;
import org.shengrui.oa.service.flow.ServiceProcessTask;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

public class ServiceProcessTaskImpl
extends ServiceGenericImpl<ModelProcessTask> implements ServiceProcessTask
{
	/**
	 * The process task repository.
	 */
	private DAOProcessTask daoProcessTask;
	
	public ServiceProcessTaskImpl(DAOProcessTask dao)
	{
		super(dao);
		this.daoProcessTask = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessTask#getProcessTaskNodesByDefId(java.lang.String)
	 */
	@Override
	public List<ModelProcessTask> getProcessTaskNodesByDefId (String defId) throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessTask.class);
			criteria.createCriteria("processDefinition").add(Restrictions.eq("id", defId));
			return this.daoProcessTask.getListByCriteria(criteria);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	public void setDaoProcessTask(DAOProcessTask daoProcessTask)
	{
		this.daoProcessTask = daoProcessTask;
	}

	public DAOProcessTask getDaoProcessTask()
	{
		return daoProcessTask;
	}

}
