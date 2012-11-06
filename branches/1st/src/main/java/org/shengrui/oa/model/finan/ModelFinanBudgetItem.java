package org.shengrui.oa.model.finan;

import org.shengrui.oa.model.flow.ModelProcessType;

import cn.trymore.core.model.ModelBase;

/**
 * 具体费用类型预算实体类
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelFinanBudgetItem
extends ModelBase
{
	/**
	 * UID
	 */
	private static final long serialVersionUID = 4880979449680296771L;

	/**
	 * 财务费用预算类型
	 */
	private ModelProcessType budgetType;
	
	/**
	 * 预算额(元)
	 */
	private Double budgetAmount;
	
	/**
	 * 所属预算实体
	 */
	private ModelFinanBudget ownerEntity;

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

	public ModelFinanBudget getOwnerEntity()
	{
		return ownerEntity;
	}

	public void setOwnerEntity(ModelFinanBudget ownerEntity)
	{
		this.ownerEntity = ownerEntity;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}
	
}
