package org.shengrui.oa.model.vo;

public class ModelNotificationVO<K, T>
{
	/**
	 * 通知项所对应的Key值
	 */
	private K key;
	
	/**
	 * 通知项所对应的审批操作链接
	 */
	private T object;
	
	/**
	 * The sole constructor.
	 * 
	 * @param approvalFuncKey
	 * @param approvalURI
	 */
	public ModelNotificationVO (K key, T object)
	{
		this.key = key;
		this.setObject(object);
	}
	
	public K getKey()
	{
		return key;
	}

	public void setKey(K key)
	{
		this.key = key;
	}

	public T getObject()
	{
		return object;
	}

	public void setObject(T object)
	{
		this.object = object;
	}
	
}
