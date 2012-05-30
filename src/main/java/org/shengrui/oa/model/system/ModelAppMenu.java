package org.shengrui.oa.model.system;

import java.util.Set;

import org.apache.commons.lang.builder.ToStringBuilder;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 系统菜单模型
 * 
 * @author x36zhao
 *
 */
public class ModelAppMenu
extends ModelBase
{

	private static final long serialVersionUID = -3143630665962191945L;
	
	/**
	 * 默认菜单链接
	 */
	public static final String DEFAULT_MENU_URL = "javascript:void(0)";
	
	/**
	 * 菜单名称
	 */
	protected String menuTitle;
	
	/**
	 * 菜单显示图标样式
	 */
	protected String menuIcon;
	
	/**
	 * 菜单Key
	 */
	protected String menuKey;
	
	/**
	 * 菜单链接
	 */
	protected String menuUrl = DEFAULT_MENU_URL;
	
	/**
	 * 菜单描述
	 */
	protected String menuDesc;
	
	/**
	 * 菜单顺序
	 */
	protected Integer menuOrder = 0;
	
	/**
	 * 父节点菜单
	 */
	protected transient ModelAppMenu menuParent = null;
	
	/**
	 * 子节点菜单
	 */
	protected Set<ModelAppMenu> menuChildren;
	
	/**
	 * 菜单功能表
	 */
	protected Set<ModelAppFunction> functions;
	
	public String getMenuTitle()
	{
		return menuTitle;
	}

	public void setMenuTitle(String menuTitle)
	{
		this.menuTitle = menuTitle;
	}

	public String getMenuIcon()
	{
		return menuIcon;
	}

	public void setMenuIcon(String menuIcon)
	{
		this.menuIcon = menuIcon;
	}

	public String getMenuUrl()
	{
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl)
	{
		this.menuUrl = menuUrl;
	}

	public String getMenuDesc()
	{
		return menuDesc;
	}

	public void setMenuDesc(String menuDesc)
	{
		this.menuDesc = menuDesc;
	}

	public Integer getMenuOrder()
	{
		return menuOrder;
	}

	public void setMenuOrder(Integer menuOrder)
	{
		this.menuOrder = menuOrder;
	}

	public ModelAppMenu getMenuParent()
	{
		return menuParent;
	}

	public void setMenuParent(ModelAppMenu menuParent)
	{
		this.menuParent = menuParent;
	}
	
	public Set<ModelAppMenu> getMenuChildren()
	{
		return menuChildren;
	}

	public void setMenuChildren(Set<ModelAppMenu> menuChildren)
	{
		this.menuChildren = menuChildren;
	}
	
	public String getMenuKey()
	{
		return menuKey;
	}

	public void setMenuKey(String menuKey)
	{
		this.menuKey = menuKey;
	}

	public Set<ModelAppFunction> getFunctions()
	{
		return functions;
	}

	public void setFunctions(Set<ModelAppFunction> functions)
	{
		this.functions = functions;
	}
	
	@Override
	public String toString()
	{
		return new ToStringBuilder(this)
			.append("menuId", this.id)
				.append("menuTitle", this.menuTitle)
					.append("menuKey", this.menuKey).toString();
	}
	
}
