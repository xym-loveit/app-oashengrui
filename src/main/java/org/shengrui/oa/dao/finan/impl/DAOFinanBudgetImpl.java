package org.shengrui.oa.dao.finan.impl;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.finan.DAOFinanBudget;
import org.shengrui.oa.model.finan.ModelFinanBudget;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.util.UtilCollection;
import cn.trymore.core.util.UtilString;

/**
 * 财务预算数据接口实现类
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOFinanBudgetImpl
extends DAOGenericImpl<ModelFinanBudget> implements DAOFinanBudget
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(DAOFinanBudgetImpl.class);
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.finan.DAOFinanBudget#resetBudget(java.lang.String, java.util.Date)
	 */
	@Override
	public boolean resetBudget(String districtId, 
			Date budgetYearAndMonth) throws DAOException
	{
		try
		{
			ModelFinanBudget entity = this.find(districtId, budgetYearAndMonth);
			if (entity != null)
			{
				entity.setBudgetItems(null);
				this.saveOrUpdate(entity);
			}
			return true;
		}
		catch (Exception e)
		{
			LOGGER.error(String.format(
				"Resets budget failed: (districtId:%s, budgetYearAndMonth:%s)", 
				districtId, 
				budgetYearAndMonth)
			);
			return false;
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.finan.DAOFinanBudget#find(java.lang.String, java.util.Date)
	 */
	@Override
	public ModelFinanBudget find(String districtId, Date budgetYearAndMonth)
			throws DAOException
	{
		if (UtilString.isNotEmpty(districtId) && budgetYearAndMonth != null)
		{
			DetachedCriteria criteria = DetachedCriteria.forClass(ModelFinanBudget.class);
			criteria.createCriteria("budgetDistrict").add(Restrictions.eq("id", districtId));
			criteria.add(Restrictions.eq("budgetYearAndMonth", budgetYearAndMonth));
			
			List<ModelFinanBudget> result = this.getListByCriteria(criteria);
			
			return UtilCollection.isNotEmpty(result) ? result.get(0) : null;
		}
		
		return null;
	}
	
}
