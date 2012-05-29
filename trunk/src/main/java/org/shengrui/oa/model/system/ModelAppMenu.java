package org.shengrui.oa.model.system;

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
	 * 菜单名称
	 */
	protected String menuTitle;
	
	/**
	 * 菜单显示图标样式
	 */
	protected String menuIcon;
	
	/**
	 * 菜单链接
	 */
	protected String menuUrl;
	
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
	protected ModelAppMenu menuParent;

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
	
}
