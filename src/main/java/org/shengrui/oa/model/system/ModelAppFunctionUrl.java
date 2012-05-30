package org.shengrui.oa.model.system;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 权限功能URI
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAppFunctionUrl 
extends ModelBase
{
	
	private static final long serialVersionUID = -4529440894418751772L;
	
	/**
	 * 权限Key
	 */
	protected String urlPath;
	
	/**
	 * 功能
	 */
	protected transient ModelAppFunction appFunction;

	/**
	 * 默认构造函数
	 */
	public ModelAppFunctionUrl()
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
	public ModelAppFunctionUrl(String paramUrlPath)
	{
		this.urlPath = paramUrlPath;
	}
	
	public String getUrlPath()
	{
		return urlPath;
	}
	
	public void setUrlPath(String urlPath)
	{
		this.urlPath = urlPath;
	}
	
	public ModelAppFunction getAppFunction()
	{
		return appFunction;
	}
	
	public void setAppFunction(ModelAppFunction appFunction)
	{
		this.appFunction = appFunction;
	}
	
	@Override
	public boolean equals (Object paramObject)
	{
		if (!(paramObject instanceof ModelAppFunctionUrl))
		{
			return false;
		}
		
		ModelAppFunctionUrl localAppFunctionUrl = (ModelAppFunctionUrl)paramObject;
		return new EqualsBuilder()
				.append(this.id, localAppFunctionUrl.id)
					.append(this.urlPath, localAppFunctionUrl.urlPath)
						.isEquals();
	}
	
	@Override
	public String toString()
	{
		return new ToStringBuilder(this)
					.append("urlId", this.id)
						.append("urlPath", this.urlPath).toString();
	}
}
