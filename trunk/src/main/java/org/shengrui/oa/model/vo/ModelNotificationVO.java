package org.shengrui.oa.model.vo;

public class ModelNotificationVO
{
	/**
	 * 通知项所对应的Key值
	 */
	private String key;
	
	/**
	 * 通知项所对应的审批操作链接
	 */
	private String uri;
	
	/**
	 * The sole constructor.
	 * 
	 * @param approvalFuncKey
	 * @param approvalURI
	 */
	public ModelNotificationVO (String key, String uri)
	{
		this.key = key;
		this.uri = uri;
	}
	
	public String getKey()
	{
		return key;
	}

	public void setKey(String key)
	{
		this.key = key;
	}

	public String getUri()
	{
		return uri;
	}

	public void setUri(String uri)
	{
		this.uri = uri;
	}
	
}
