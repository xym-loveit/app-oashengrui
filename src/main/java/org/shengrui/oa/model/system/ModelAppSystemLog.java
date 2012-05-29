package org.shengrui.oa.model.system;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 系统日志
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAppSystemLog
extends ModelBase
{

	private static final long serialVersionUID = 2300367476295940125L;
	
	/**
	 * 用户名
	 */
	protected String userName;
	
	/**
	 * 用户ID
	 */
	protected Long userId;
	
	/**
	 * 创建时间
	 */
	protected Date createTime;
	
	/**
	 * 执行操作
	 */
	protected String operation;

	public String getUserName()
	{
		return userName;
	}

	public void setUserName(String userName)
	{
		this.userName = userName;
	}

	public Long getUserId()
	{
		return userId;
	}

	public void setUserId(Long userId)
	{
		this.userId = userId;
	}

	public Date getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(Date createTime)
	{
		this.createTime = createTime;
	}

	public String getOperation()
	{
		return operation;
	}

	public void setOperation(String operation)
	{
		this.operation = operation;
	}
	
}
