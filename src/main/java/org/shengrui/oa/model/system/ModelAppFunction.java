package org.shengrui.oa.model.system;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 权限功能
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAppFunction 
extends ModelBase
{
	
	private static final long serialVersionUID = -4529440894418751772L;
	
	/**
	 * 权限Key
	 */
	protected String funKey;
	
	/**
	 * 权限名称
	 */
	protected String funName;
	
	/**
	 * 默认构造函数
	 */
	public ModelAppFunction()
	{
		
	}
	
	/**
	 * 带参的构造函数
	 * 
	 * @param paramFunKey
	 *                 the function key
	 * @param paramFunName
	 *                  the function name
	 */
	public ModelAppFunction(String paramFunKey, String paramFunName)
	{
		this.funKey = paramFunKey;
		this.funName = paramFunName;
	}
	
	public String getFunKey()
	{
		return funKey;
	}

	public void setFunKey(String funKey)
	{
		this.funKey = funKey;
	}

	public String getFunName()
	{
		return funName;
	}

	public void setFunName(String funName)
	{
		this.funName = funName;
	}
	
	@Override
	public boolean equals (Object paramObject)
	{
		if (!(paramObject instanceof ModelAppFunction))
		{
			return false;
		}
		
		ModelAppFunction localAppFunction = (ModelAppFunction)paramObject;
		
		return new EqualsBuilder()
				.append(this.id, localAppFunction.id)
					.append(this.funKey, localAppFunction.funKey)
						.append(this.funName, localAppFunction.funName).isEquals();
	}
	
	@Override
	public String toString()
	{
		return new ToStringBuilder(this)
					.append("functionId", this.id)
						.append("funKey", this.funKey)
							.append("funName", this.funName).toString();
	}
}
