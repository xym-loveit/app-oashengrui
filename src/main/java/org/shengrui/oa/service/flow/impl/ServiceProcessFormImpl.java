package org.shengrui.oa.service.flow.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.flow.DAOProcessForm;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.service.flow.ServiceProcessForm;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;

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
	public ModelProcessForm getPreviousProcessForm(String formId)
			throws ServiceException
	{
		try
		{
			ModelProcessForm procForm = this.daoProcessForm.get(formId);
			
			if (procForm == null)
			{
				throw new ServiceException("The process form does not exist with id:" + formId);
			}
			
			if (!this.isFormNodeFirstOne(procForm.getSortCode()))
			{
				List<ModelProcessForm> preForms = this.getFormNodesByOffset(procForm.getSortCode(), false);
				if (preForms != null && preForms.size() > 0)
				{
					return preForms.get(preForms.size() - 1);
				}
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
	public ModelProcessForm getNextProcessForm(String formId)
			throws ServiceException
	{
		try
		{
			ModelProcessForm procForm = this.daoProcessForm.get(formId);
			
			if (procForm == null)
			{
				throw new ServiceException("The process form does not exist with id:" + formId);
			}
			
			if (!this.isFormNodeLastOne(procForm.getSortCode()))
			{
				List<ModelProcessForm> nextForms = this.getFormNodesByOffset(procForm.getSortCode(), true);
				if (nextForms != null && nextForms.size() > 0)
				{
					return nextForms.get(0);
				}
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
	 * @see org.shengrui.oa.service.flow.ServiceProcessForm#removeFormByNo(java.lang.String)
	 */
	@Override
	public boolean removeFormByNo(String formNo) throws ServiceException
	{
		if (UtilString.isNotEmpty(formNo))
		{
			try
			{
				return this.daoProcessForm.execUpdateByHQL("delete ModelProcessForm as form where form.applyFormNo = ?", new Object[] {formNo}) > 0;
			} 
			catch (DAOException e)
			{
				throw new ServiceException("Exception raised when removing the form entities with no:" + formNo, e);
			}
		}
		
		return false;
	}
	
	/**
	 * Obtains list of form nodes that started with the specified offset.
	 * 
	 * @param seqOffset
	 *                     the process task sequence offset 
	 * @param isGreaterThan
	 *                     the flag of greater than
	 * @return list of process form nodes
	 * @throws ServiceException
	 */
	private List<ModelProcessForm> getFormNodesByOffset(int seqOffset, boolean isGreaterThan)
			throws ServiceException
	{
		try
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessForm.class);
			
			if (isGreaterThan) 
			{
				criteria.add(Restrictions.gt("sortCode", seqOffset));
			}
			else
			{
				criteria.add(Restrictions.lt("sortCode", seqOffset));
			}
			
			return this.daoProcessForm.getListByCriteria(criteria);
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/**
	 * Returns true if the process form with the specified sequence index last one
	 * 
	 * @param seq
	 *         the process task sequence index
	 * @return true if process form with the sequence index last one.
	 * @throws ServiceException
	 */
	private boolean isFormNodeLastOne(int seq) throws ServiceException
	{
		try
		{
			return this.getFormNodesByOffset(seq, true) == null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	/**
	 * Returns true if the process form with the specified sequence index as first one
	 * 
	 * @param seq
	 *         the process task sequence index
	 * @return true if process form with the sequence index as first one.
	 * @throws ServiceException
	 */
	private boolean isFormNodeFirstOne(int seq) throws ServiceException
	{
		try
		{
			return this.getFormNodesByOffset(seq, false) == null;
		}
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}
	
	public void setDaoProcessForm(DAOProcessForm daoProcessForm)
	{
		this.daoProcessForm = daoProcessForm;
	}

	public DAOProcessForm getDaoProcessForm()
	{
		return daoProcessForm;
	}

}
