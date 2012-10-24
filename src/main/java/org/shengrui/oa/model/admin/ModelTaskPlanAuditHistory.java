package org.shengrui.oa.model.admin;

import org.shengrui.oa.model.base.ModelBaseAuditHistory;

/**
 * Model: 任务审核历史数据
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelTaskPlanAuditHistory
extends ModelBaseAuditHistory
{

	/**
	 * UID
	 */
	private static final long serialVersionUID = 3676756773856880478L;
	
	/**
	 * 任务实体
	 */
	private ModelTaskPlan entity;
	
	public ModelTaskPlanAuditHistory()
	{
		
	}
	
	public ModelTaskPlanAuditHistory (String id, String name)
	{
		super(id, name);
	}
	
	public void setEntity(ModelTaskPlan entity)
	{
		this.entity = entity;
	}

	public ModelTaskPlan getEntity()
	{
		return entity;
	}
	
}
