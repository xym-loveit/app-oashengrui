package org.shengrui.oa.model.base;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 实体审核历史数据
 * <pre>
 * Purpose: 主要用于查询过滤我的审核记录, 新闻审核, 任务审核, 岗位审核.
 * </pre>
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelBaseAuditHistory
extends ModelBase
{

	/**
	 * UID
	 */
	private static final long serialVersionUID = 5842938129040184532L;
	
	/**
	 * 审核人ID
	 */
	private String auditorId;
	
	/**
	 * 审核人姓名
	 */
	private String auditorName;
	
	/**
	 * 审核日期
	 */
	private Date auditDate;

	public String getAuditorId()
	{
		return auditorId;
	}

	public void setAuditorId(String auditorId)
	{
		this.auditorId = auditorId;
	}

	public String getAuditorName()
	{
		return auditorName;
	}

	public void setAuditorName(String auditorName)
	{
		this.auditorName = auditorName;
	}

	public Date getAuditDate()
	{
		return auditDate;
	}

	public void setAuditDate(Date auditDate)
	{
		this.auditDate = auditDate;
	}
	
}
