package org.shengrui.oa.model.system;

import java.util.HashSet;
import java.util.Set;

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
	 * 权限功能Key
	 */
	protected String funcKey;
	
	/**
	 * 权限功能名称
	 */
	protected String funcName;
	
	/**
	 * 权限功能显示样式
	 */
	protected String funcIcon;
	
	/**
	 * 权限功能描述
	 */
	protected String funcDesc;
	
	/**
	 * 权限功能所属菜单
	 */
	protected transient ModelAppMenu menu;
	
	/**
	 * 权限功能链接集合
	 */
	protected Set<ModelAppFunctionUrl> funcURLs = new HashSet<ModelAppFunctionUrl>();
	
	/**
	 * 功能数据权限
	 */
	protected Set<ModelAppFunctionDataStrategy> funcDataStrategy = new HashSet<ModelAppFunctionDataStrategy>();
	
	/**
	 * 功能数据权限IDs, 主要用于保存前判断.
	 */
	protected String strategyIds;
	
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
	
	/**
	 * 返回功能URL列表
	 * @return
	 */
	public String getUrls ()
	{
		if (funcURLs != null && funcURLs.size() > 0)
		{
			StringBuilder builder = new StringBuilder();
			int count = 1;
			for (ModelAppFunctionUrl url : funcURLs)
			{
				builder.append(url.getUrlPath());
				if (count < funcURLs.size())
				{
					builder.append("\n");
				}
				count++;
			}
			
			return builder.toString();
		}
		
		return null;
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
	
	public String getFuncDesc()
	{
		return funcDesc;
	}

	public void setFuncDesc(String funcDesc)
	{
		this.funcDesc = funcDesc;
	}
	
	public Set<ModelAppFunctionUrl> getFuncURLs()
	{
		return funcURLs;
	}

	public void setFuncURLs(Set<ModelAppFunctionUrl> funcURLs)
	{
		this.funcURLs = funcURLs;
	}
	
	public Set<ModelAppFunctionDataStrategy> getFuncDataStrategy()
	{
		return funcDataStrategy;
	}

	public void setFuncDataStrategy(
			Set<ModelAppFunctionDataStrategy> funcDataStrategy)
	{
		this.funcDataStrategy = funcDataStrategy;
	}
	
	public String getStrategyIds()
	{
		return strategyIds;
	}

	public void setStrategyIds(String strategyIds)
	{
		this.strategyIds = strategyIds;
	}
}
