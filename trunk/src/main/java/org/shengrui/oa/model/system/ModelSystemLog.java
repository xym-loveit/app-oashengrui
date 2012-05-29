package org.shengrui.oa.model.system;

import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

import cn.trymore.core.model.ModelBase;

/**
 * SystemLog Base Java Bean, base class for the.oa.model, mapped directly to database table
 * 
 * Avoid changing this file if not necessary, will be overwritten. 
 *
 * TODO: add class/table comments
 */
public class ModelSystemLog 
extends ModelBase 
{
	
	private static final long serialVersionUID = -1440779837642485708L;
	
	protected String username;
	
	protected Long userId;
	
	protected Date createtime;
	
	protected String exeOperation;


	/**
	 * Default Empty Constructor for class SystemLog
	 */
	public ModelSystemLog () 
	{
		super();
	}
	
	/**
	 * 用户名	 * @return String
	 * @hibernate.property column="username" type="java.lang.String" length="128" not-null="true" unique="false"
	 */
	public String getUsername() 
	{
		return this.username;
	}
	
	/**
	 * Set the username
	 * @spring.validator type="required"
	 */	
	public void setUsername(String aValue)
	{
		this.username = aValue;
	}	

	/**
	 * 用户ID	 * @return Long
	 * @hibernate.property column="userId" type="java.lang.Long" length="19" not-null="true" unique="false"
	 */
	public Long getUserId() 
	{
		return this.userId;
	}
	
	/**
	 * Set the userId
	 * @spring.validator type="required"
	 */	
	public void setUserId(Long aValue) 
	{
		this.userId = aValue;
	}	

	/**
	 * 执行时间	 * @return java.util.Date
	 * @hibernate.property column="createtime" type="java.util.Date" length="19" not-null="true" unique="false"
	 */
	public Date getCreatetime() 
	{
		return this.createtime;
	}
	
	/**
	 * Set the createtime
	 * @spring.validator type="required"
	 */	
	public void setCreatetime(java.util.Date aValue) 
	{
		this.createtime = aValue;
	}	

	/**
	 * 执行操作	 * @return String
	 * @hibernate.property column="exeOperation" type="java.lang.String" length="512" not-null="true" unique="false"
	 */
	public String getExeOperation() 
	{
		return this.exeOperation;
	}
	
	/**
	 * Set the exeOperation
	 * @spring.validator type="required"
	 */	
	public void setExeOperation(String aValue) 
	{
		this.exeOperation = aValue;
	}	

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) 
	{
		if (!(object instanceof ModelSystemLog)) 
		{
			return false;
		}
		
		ModelSystemLog rhs = (ModelSystemLog) object;
		
		return new EqualsBuilder()
				.append(this.username, rhs.username)
				.append(this.userId, rhs.userId)
				.append(this.createtime, rhs.createtime)
				.append(this.exeOperation, rhs.exeOperation)
				.isEquals();
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() 
	{
		return new ToStringBuilder(this)
				.append("username", this.username) 
				.append("userId", this.userId) 
				.append("createtime", this.createtime) 
				.append("exeOperation", this.exeOperation) 
				.toString();
	}



}
