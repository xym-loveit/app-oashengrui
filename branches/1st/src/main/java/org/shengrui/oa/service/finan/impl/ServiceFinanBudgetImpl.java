package org.shengrui.oa.service.finan.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.shengrui.oa.dao.finan.DAOFinanBudget;
import org.shengrui.oa.dao.system.DAOSchoolDistrict;
import org.shengrui.oa.model.finan.ModelFinanBudget;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.finan.ServiceFinanBudget;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilCollection;
import cn.trymore.core.util.UtilString;

/**
 * 财务预算逻辑接口层实现
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceFinanBudgetImpl
implements ServiceFinanBudget
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(ServiceFinanBudgetImpl.class);
	
	/**
	 * 财务预算数据接口
	 */
	private DAOFinanBudget daoFinanBudget;
	
	/**
	 * 学校校区数据接口
	 */
	private DAOSchoolDistrict daoSchoolDistrict;
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanBudget#get(java.lang.String, java.util.Date)
	 */
	@Override
	public List<ModelFinanBudget> get(String districtId, Date budgetYearAndMonth)
			throws ServiceException
	{
		try
		{
			// 获取校区数据
			List<ModelSchoolDistrict> districts = null;
			if (UtilString.isNotEmpty(districtId))
			{
				districts = this.daoSchoolDistrict.getAll();
			}
			else
			{
				ModelSchoolDistrict district = this.daoSchoolDistrict.get(districtId);
				if (district != null)
				{
					districts = new ArrayList<ModelSchoolDistrict>();
					districts.add(district);
				}
			}
			
			// 构建校区预算数据
			if (UtilCollection.isNotEmpty(districts))
			{
				List<ModelFinanBudget> budgets = new ArrayList<ModelFinanBudget>();
				for (ModelSchoolDistrict district : districts)
				{
					ModelFinanBudget budget = this.daoFinanBudget.find(
							district.getId(), budgetYearAndMonth);
					if (budget != null)
					{
						budgets.add(budget);
					}
					else
					{
						// 填补未设置的校区预算
						budget = new ModelFinanBudget();
						budget.setBudgetDistrict(district);
						budget.setBudgetYearAndMonth(budgetYearAndMonth);
						budgets.add(budget);
					}
				}
				
				return budgets;
			}
			
			return null;
		}
		catch (Exception e)
		{
			throw new ServiceException("District budgets fetch failed.", e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanBudget#resetBudget(java.lang.String, java.util.Date)
	 */
	@Override
	public boolean resetBudget(String districtId, Date budgetYearAndMonth)
			throws ServiceException
	{
		try
		{
			if (UtilString.isNotEmpty(districtId) && budgetYearAndMonth != null)
			{
				ModelFinanBudget budget = this.daoFinanBudget.find(
						districtId, budgetYearAndMonth);
				if (budget != null)
				{
					budget.setBudgetItems(null);
					budget.setBudgetTotalAmount(null);
					this.daoFinanBudget.saveOrUpdate(budget);
				}
				
				return true;
			}
			
			return false;
		}
		catch (Exception e)
		{
			throw new ServiceException ("Budget resets failed.", e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanBudget#saveOrUpdate(org.shengrui.oa.model.finan.ModelFinanBudget)
	 */
	@Override
	public boolean saveOrUpdate(ModelFinanBudget entity)
			throws ServiceException
	{
		try
		{
			this.daoFinanBudget.saveOrUpdate(entity);
			return true;
		} 
		catch (DAOException e)
		{
			throw new ServiceException ("Budget saves or updates failed.", e);
		}
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}

	public void setDaoFinanBudget(DAOFinanBudget daoFinanBudget)
	{
		this.daoFinanBudget = daoFinanBudget;
	}

	public DAOFinanBudget getDaoFinanBudget()
	{
		return daoFinanBudget;
	}

	public void setDaoSchoolDistrict(DAOSchoolDistrict daoSchoolDistrict)
	{
		this.daoSchoolDistrict = daoSchoolDistrict;
	}

	public DAOSchoolDistrict getDaoSchoolDistrict()
	{
		return daoSchoolDistrict;
	}

}
