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
	
	
	/**
	 * The enumeration of message type
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EMessageType
	{
		TYPE_PERSONAL(1, "type_personal"),		// 个人信息
		TYPE_SYSTEM(2, "type_system");			// 系统消息
		
		private Integer value;
		private String text;
		
		EMessageType (Integer value, String text)
		{
			this.value = value;
			this.text = text;
		}
		
		public Integer getValue(){
			return value;
		}
		
		public String getText()
		{
			return this.text;
		}
	}
	
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
