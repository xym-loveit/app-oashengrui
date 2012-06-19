package org.shengrui.oa.service.flow.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.flow.DAOProcessForm;
import org.shengrui.oa.dao.flow.DAOProcessHistory;
import org.shengrui.oa.dao.flow.DAOProcessTask;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.service.flow.ServiceProcessForm;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The process form service implementation.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceProcessFormImpl
extends ServiceGenericImpl<ModelProcessForm> implements ServiceProcessForm
{
	
	/**
	 * The process form repository
	 */
	private DAOProcessForm daoProcessForm;
	
	/**
	 * The process history repository.
	 */
	private DAOProcessHistory daoProcessHistory;
	
	/**
	 * The process task repository.
	 */
	private DAOProcessTask daoProcessTask;
	
	public ServiceProcessFormImpl(DAOProcessForm dao)
	{
		super(dao);
		this.daoProcessForm = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessForm#getProcessFormsByFormNo(java.lang.String)
	 */
	@Override
	public List<ModelProcessForm> getProcessFormsByFormNo(String formNo)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessForm.class);
			criteria.add(Restrictions.eq("applyFormNo", formNo));
			criteria.addOrder(Order.asc("sortCode"));
			return this.daoProcessForm.getListByCriteria(criteria);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessForm#getCurrentProcessForm(java.lang.String)
	 */
	@Override
	public ModelProcessForm getCurrentProcessForm(String formNo)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessForm.class);
			criteria.add(Restrictions.eq("auditState", ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue()));
			List<ModelProcessForm> result = this.daoProcessForm.getListByCriteria(criteria);
			return result != null && result.size() > 0 ? result.get(0) : null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessForm#getPreviousProcessForm(java.lang.String)
	 */
	@Override
	public ModelProcessForm getPreviousProcessForm(String formNo)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessForm.class);
			criteria.add(Restrictions.eq("auditState", ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue()));
			List<ModelProcessForm> result = this.daoProcessForm.getListByCriteria(criteria);
			if (result != null && result.size() > 0)
			{
				return result.get(0).getPreviousProcess();
			}
			return null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessForm#getNextProcessForm(java.lang.String)
	 */
	@Override
	public ModelProcessForm getNextProcessForm(String formNo)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessForm.class);
			criteria.add(Restrictions.eq("auditState", ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue()));
			List<ModelProcessForm> result = this.daoProcessForm.getListByCriteria(criteria);
			if (result != null && result.size() > 0)
			{
				return result.get(0).getNextProcess();
			}
			return null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessForm#getProcessFormByType(java.lang.String)
	 */
	@Override
	public List<ModelProcessForm> getProcessFormByType(String processTypeId)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessForm.class);
			criteria.createCriteria("processType").add(Restrictions.eq("id", processTypeId));
			criteria.addOrder(Order.asc("sortCode"));
			List<ModelProcessForm> result = this.daoProcessForm.getListByCriteria(criteria);
			return result != null && result.size() > 0 ? result : null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessForm#getProcessFormState(java.lang.String)
	 */
	@Override
	public Integer getProcessFormState(String formNo) throws ServiceException
	{
		if (this.getCurrentProcessForm(formNo) != null)
		{
			return ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue();
		}
		else
		{
			// TODO, It should be fetched from history records.
			return 0;
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessForm#enterProcess(java.lang.String, java.lang.String)
	 */
	@Override
	public boolean enterProcess(String processTypeId, String formNo)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		return false;
	}
	
	public void setDaoProcessForm(DAOProcessForm daoProcessForm)
	{
		this.daoProcessForm = daoProcessForm;
	}

	public DAOProcessForm getDaoProcessForm()
	{
		return daoProcessForm;
	}

	public void setDaoProcessHistory(DAOProcessHistory daoProcessHistory)
	{
		this.daoProcessHistory = daoProcessHistory;
	}

	public DAOProcessHistory getDaoProcessHistory()
	{
		return daoProcessHistory;
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
