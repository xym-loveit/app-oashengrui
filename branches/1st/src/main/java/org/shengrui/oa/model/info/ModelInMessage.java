package org.shengrui.oa.model.info;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 收件箱
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelInMessage
extends ModelBase
{

	/**
	 * The serial UID
	 */
	private static final long serialVersionUID = 7499800829767893880L;
	
	/**
	 * 已读标志
	 */
	public static final Integer FLAG_READ = Integer.valueOf(1);
	
	/**
	 * 未读标志
	 */
	public static final Integer FLAG_UNREAD = Integer.valueOf(0);
	
	/**
	 * 已删除标志
	 */
	public static final Integer FLAG_DEL = Integer.valueOf(1);
	
	/**
	 * 未删除标志
	 */
	public static final Integer FLAG_UNDEL = Integer.valueOf(0);
	
	/**
	 * 短消息
	 */
	private ModelShortMessage shortMessage;
	
	/**
	 * 接收用户ID
	 */
	private Long userId;
	
	/**
	 * 接收用户姓名
	 */
	private String userFullName;
	
	/**
	 * 删除标志
	 */
	private Integer delFlag;
	
	/**
	 * 阅读标志
	 */
	private Integer readFlag;
	
	/**
	 * 接收时间
	 */
	private Date receiveTime;
	
	public ModelShortMessage getShortMessage()
	{
		return shortMessage;
	}

	public void setShortMessage(ModelShortMessage shortMessage)
	{
		this.shortMessage = shortMessage;
	}

	public Long getUserId()
	{
		return userId;
	}

	public void setUserId(Long userId)
	{
		this.userId = userId;
	}

	public String getUserFullName()
	{
		return userFullName;
	}

	public void setUserFullName(String userFullName)
	{
		this.userFullName = userFullName;
	}

	public Integer getDelFlag()
	{
		return delFlag;
	}

	public void setDelFlag(Integer delFlag)
	{
		this.delFlag = delFlag;
	}

	public Integer getReadFlag()
	{
		return readFlag;
	}

	public void setReadFlag(Integer readFlag)
	{
		this.readFlag = readFlag;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}

	public void setReceiveTime(Date receiveTime)
	{
		this.receiveTime = receiveTime;
	}

	public Date getReceiveTime()
	{
		return receiveTime;
	}
	
}
