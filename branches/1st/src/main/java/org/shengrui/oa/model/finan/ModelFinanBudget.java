package org.shengrui.oa.model.finan;

import java.util.Date;
import java.util.List;

import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

/**
 * 财务预算实体类
 * 
 * <pre>
 * + tbl_finan_budget
 *    - budget_id
 *    - district_id
 *    - year_and_month
 *    - status
 * + tbl_finan_budget_item
 *     - item_id
 *     - budget_id
 *     - amount
 *     - type
 * </pre>
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
	 * 预算总额(元)
	 */
	private Double budgetTotalAmount;
	
	/**
	 * 预算月份 (yyyy-MM)
	 */
	private Date budgetYearAndMonth;
	
	/**
	 * 所有预算类型的预算额
	 */
	private List<ModelFinanBudgetItem> budgetItems;
	
	public ModelSchoolDistrict getBudgetDistrict()
	{
		return budgetDistrict;
	}

	public void setBudgetDistrict(ModelSchoolDistrict budgetDistrict)
	{
		this.budgetDistrict = budgetDistrict;
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

	public void setBudgetTotalAmount(Double budgetTotalAmount)
	{
		this.budgetTotalAmount = budgetTotalAmount;
	}

	public Double getBudgetTotalAmount()
	{
		return budgetTotalAmount;
	}
	
	public void setBudgetItems(List<ModelFinanBudgetItem> budgetItems)
	{
		this.budgetItems = budgetItems;
	}

	public List<ModelFinanBudgetItem> getBudgetItems()
	{
		return budgetItems;
	}
	
}
