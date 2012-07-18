package org.shengrui.oa.service.flow.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.flow.DAOProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.service.flow.ServiceProcessDefinition;
import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;

public class ServiceProcessDefinitionImpl
extends ServiceGenericImpl<ModelProcessDefinition> implements ServiceProcessDefinition
{
	
	private DAOProcessDefinition daoProcessDefinition;
	
	public ServiceProcessDefinitionImpl(DAOProcessDefinition dao)
	{
		super(dao);
		
		this.daoProcessDefinition = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessDefinition#getProcessDefinitionByType(java.lang.String)
	 */
	@Override
	public List<ModelProcessDefinition> getProcessDefinitionByType (String processTypeId) 
			throws ServiceException
	{
		return this.getProcessDefinition(processTypeId, null, null);
	}

	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessDefinition#getProcessDefinition(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public List<ModelProcessDefinition> getProcessDefinition(String processTypeId,
			String filterPositions, Object condParamValue) throws ServiceException
	{
		if (UtilString.isNotEmpty(processTypeId))
		{
			try
			{
				DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessDefinition.class);
				criteria.createCriteria("processType").add(Restrictions.eq("id", processTypeId));
				
				if (UtilString.isNotEmpty(filterPositions))
				{
					criteria.add(Restrictions.in("filterPositionNames", filterPositions.split(",")));
				}
				
				List<ModelProcessDefinition> entities =
					this.daoProcessDefinition.getListByCriteria(criteria);
				
				if (condParamValue != null && entities != null)
				{
					for (int i = entities.size() - 1; i >= 0; i--)
					{
						ModelProcessDefinition entity = entities.get(i);
						
						if (!AppUtil.isCondExprSatisfied(
								entity.getCondition(), condParamValue))
						{
							entities.remove(i);
						}
					}
				}
				
				return entities;
			}
			catch (Exception e)
			{
				throw new ServiceException(e);
			}
		}
		
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceProcessDefinition#getProcessDefinitionFilterByPoset(java.lang.String)
	 */
	@Override
	public List<ModelProcessDefinition> getProcessDefinitionFilterByPoset(
			String procTypeId, String posetId) throws ServiceException
	{
		if (UtilString.isNotEmpty(procTypeId))
		{
			try
			{
				DetachedCriteria criteria = DetachedCriteria.forClass(ModelProcessDefinition.class);
				
				if (UtilString.isNotEmpty(posetId))
				{
					criteria.createCriteria("filterPoset").add(Restrictions.eq("id", posetId));
				}
				
				criteria.createCriteria("processType").add(Restrictions.eq("id", procTypeId));
				
				return this.daoProcessDefinition.getListByCriteria(criteria);
			}
			catch (Exception e)
			{
				throw new ServiceException(e);
			}
		}
		return null;
	}
	
	public void setDaoProcessDefinition(DAOProcessDefinition daoProcessDefinition)
	{
		this.daoProcessDefinition = daoProcessDefinition;
	}

	public DAOProcessDefinition getDaoProcessDefinition()
	{
		return daoProcessDefinition;
	}

}
