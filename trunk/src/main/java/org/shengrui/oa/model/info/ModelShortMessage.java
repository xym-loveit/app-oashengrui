package org.shengrui.oa.model.info;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

public class ModelShortMessage
extends ModelBase
{

	/**
	 * The serial UID
	 */
	private static final long serialVersionUID = -7135021944487009933L;
	
	/**
	 * 消息标题
	 */
	private String subject;
	
	/**
	 * 消息内容
	 */
	private String content;
	
	/**
	 * 发送者
	 */
	private String sender;
	
	/**
	 * 发送者ID
	 */
	private Long senderId;
	
	/**
	 * 消息类型
	 */
	private Integer msgType;
	
	/**
	 * 消息发送时间
	 */
	private Date sendTime;
	
	public String getSubject()
	{
		return subject;
	}

	public void setSubject(String subject)
	{
		this.subject = subject;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public String getSender()
	{
		return sender;
	}

	public void setSender(String sender)
	{
		this.sender = sender;
	}

	public Long getSenderId()
	{
		return senderId;
	}

	public void setSenderId(Long senderId)
	{
		this.senderId = senderId;
	}

	public Integer getMsgType()
	{
		return msgType;
	}

	public void setMsgType(Integer msgType)
	{
		this.msgType = msgType;
	}

	public Date getSendTime()
	{
		return sendTime;
	}

	public void setSendTime(Date sendTime)
	{
		this.sendTime = sendTime;
	}
}
