package org.shengrui.oa.model.news;

import org.shengrui.oa.model.base.ModelBaseAuditHistory;

/**
 * Model: 新闻审核历史数据
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelNewsAuditHistory
extends ModelBaseAuditHistory
{

	/**
	 * UID
	 */
	private static final long serialVersionUID = -3110371467865357258L;
	
	/**
	 * 新闻实体
	 */
	private ModelNewsMag entity;

	public void setEntity(ModelNewsMag entity)
	{
		this.entity = entity;
	}

	public ModelNewsMag getEntity()
	{
		return entity;
	}

}
