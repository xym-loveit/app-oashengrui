package org.shengrui.oa.model.finan;

import java.util.Date;

import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

/**
 * 财务预算实体类
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelFinanBudget
extends ModelBase
{
	/**
	 * UID
	 */
	private static final long serialVersionUID = 6949507984438320317L;
	
	/**
	 * 预算所在校区
	 */
	private ModelSchoolDistrict budgetDistrict;
	
	/**
	 * 财务费用预算类型
	 */
	private ModelProcessType budgetType;
	
	/**
	 * 预算额(元)
	 */
	private Double budgetAmount;
	
	/**
	 * 预算月份 (yyyy-MM)
	 */
	private Date budgetYearAndMonth;
	
	public ModelSchoolDistrict getBudgetDistrict()
	{
		return budgetDistrict;
	}

	public void setBudgetDistrict(ModelSchoolDistrict budgetDistrict)
	{
		this.budgetDistrict = budgetDistrict;
	}

	public ModelProcessType getBudgetType()
	{
		return budgetType;
	}

	public void setBudgetType(ModelProcessType budgetType)
	{
		this.budgetType = budgetType;
	}

	public Double getBudgetAmount()
	{
		return budgetAmount;
	}

	public void setBudgetAmount(Double budgetAmount)
	{
		this.budgetAmount = budgetAmount;
	}

	public Date getBudgetYearAndMonth()
	{
		return budgetYearAndMonth;
	}

	public void setBudgetYearAndMonth(Date budgetYearAndMonth)
	{
		this.budgetYearAndMonth = budgetYearAndMonth;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}
	
}
