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
	protected String funcKey;
	
	/**
	 * 权限名称
	 */
	protected String funcName;
	
	/**
	 * 权限显示样式
	 */
	protected String funcIcon;
	
	/**
	 * 权限所属菜单
	 */
	protected transient ModelAppMenu menu;
	
	/**
	 * 默认构造函数
	 */
	public ModelAppFunction()
	{
		
	}
	
	/**
	 * 带参的构造函数
	 * 
	 * @param paramfuncKey
	 *                 the function key
	 * @param paramfuncName
	 *                  the function name
	 */
	public ModelAppFunction(String paramfuncKey, String paramfuncName)
	{
		this.funcKey = paramfuncKey;
		this.funcName = paramfuncName;
	}
	
	public String getFuncKey()
	{
		return funcKey;
	}

	public void setFuncKey(String funcKey)
	{
		this.funcKey = funcKey;
	}

	public String getFuncName()
	{
		return funcName;
	}

	public void setFuncName(String funcName)
	{
		this.funcName = funcName;
	}
	
	public String getFuncIcon()
	{
		return funcIcon;
	}

	public void setFuncIcon(String funcIcon)
	{
		this.funcIcon = funcIcon;
	}
	
	public ModelAppMenu getMenu()
	{
		return menu;
	}

	public void setMenu(ModelAppMenu menu)
	{
		this.menu = menu;
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
					.append(this.funcKey, localAppFunction.funcKey)
						.append(this.funcName, localAppFunction.funcName).isEquals();
	}
	
	@Override
	public String toString()
	{
		return new ToStringBuilder(this)
					.append("functionId", this.id)
						.append("funcKey", this.funcKey)
							.append("funcName", this.funcName).toString();
	}
}
