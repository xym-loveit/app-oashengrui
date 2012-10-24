package org.shengrui.oa.model.hrm;

import org.shengrui.oa.model.base.ModelBaseAuditHistory;

/**
 * Model: 岗位审核历史数据
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmJobHireInfoAuditHistory
extends ModelBaseAuditHistory
{

	/**
	 * UID
	 */
	private static final long serialVersionUID = -8125449605078727625L;
	
	/**
	 * 岗位实体
	 */
	private ModelHrmJobHireInfo entity;

	public void setEntity(ModelHrmJobHireInfo entity)
	{
		this.entity = entity;
	}

	public ModelHrmJobHireInfo getEntity()
	{
		return entity;
	}
	
}
