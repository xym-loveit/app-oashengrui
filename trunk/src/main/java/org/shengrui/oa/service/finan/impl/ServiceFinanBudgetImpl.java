package org.shengrui.oa.service.finan.impl;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.shengrui.oa.dao.finan.DAOFinanBudget;
import org.shengrui.oa.dao.system.DAOSchoolDistrict;
import org.shengrui.oa.model.finan.ModelFinanBudget;
import org.shengrui.oa.service.finan.ServiceFinanBudget;

import cn.trymore.core.exception.ServiceException;

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
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanBudget#resetBudget(java.lang.String, java.util.Date)
	 */
	@Override
	public boolean resetBudget(String districtId, Date budgetYearAndMonth)
			throws ServiceException
	{
		return false;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.finan.ServiceFinanBudget#saveOrUpdate(org.shengrui.oa.model.finan.ModelFinanBudget)
	 */
	@Override
	public boolean saveOrUpdate(ModelFinanBudget entity)
			throws ServiceException
	{
		return false;
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
