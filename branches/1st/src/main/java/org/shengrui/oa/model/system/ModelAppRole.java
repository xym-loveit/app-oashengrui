package org.shengrui.oa.model.system;

import java.util.HashSet;
import java.util.Set;

import javax.xml.bind.annotation.XmlTransient;

import org.springframework.security.GrantedAuthority;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 角色模型
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAppRole
extends ModelBase implements GrantedAuthority
{
	
	private static final long serialVersionUID = -5327640691910365819L;
	
	/**
	 * 超级管理员
	 */
	public static final String ROLE_SUPER = "ROLE_SUPER";
	
	/**
	 * 公共角色
	 */
	public static final String ROLE_PUBLIC = "ROLE_PUBLIC";
	
	/**
	 * 匿名角色
	 */
	public static final String ROLE_ANONYMOUS = "ROLE_ANONYMOUS";
	
	/**
	 * 超级管理员的角色ID
	 */
	public static final String SUPER_ROLEID = String.valueOf(1L);
	
	/**
	 * 超级权限
	 */
	public static final String SUPER_RIGHTS = "__ALL";
	
	/**
	 * 	角色名称
	 */
	@Expose
	private String roleName;
	
	/**
	 * 	角色名称
	 */
	@Expose
	private String roleKey;
	
	/**
	 * 角色描述
	 */
	@Expose
	private String roleDesc;

	/**
	 * 角色状态
	 */
	@Expose
	private Integer roleStatus = ERoleStatus.UNLOCKED.getValue();
	
	/**
	 * 角色类型
	 */
	@Expose
	private Integer roleType = null;
	
	/**
	 * 角色拥有的功能字符串列表
	 */
	@Expose
	private String roleRights;
	
	/**
	 * 角色是否可修改
	 */
	@Expose
	private Integer roleEditable = 1;
	
	/**
	 * 角色拥有的功能Model集合
	 */
	private Set<ModelAppFunction> functions = new HashSet<ModelAppFunction>();
	
	/**
	 * 角色拥有的菜单集合
	 */
	private Set<ModelAppMenu> menus = new HashSet<ModelAppMenu>();
	
	/**
	 * 角色对应的用户集合
	 */
	@XmlTransient
	private Set<ModelAppUser> users = new HashSet<ModelAppUser>();
	
	/**
	 * 角色拥有的功能数据权限集合
	 */
	private Set<ModelAppFunctionDataStrategy> funcDataPermissions = new HashSet<ModelAppFunctionDataStrategy>();
	
	/**
	 * The enumeration of role status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum ERoleStatus
	{
		LOCKED(0, "locked"),
		UNLOCKED(1, "unlocked");
		
		private Integer value;
		private String text;
		
		ERoleStatus (Integer value, String text)
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
	
	/**
	 * 返回菜单ID列表
	 * @return
	 */
	public String getMenuIds ()
	{
		if (menus != null && menus.size() > 0)
		{
			StringBuilder builder = new StringBuilder();
			int count = 1;
			for (ModelAppMenu menu : menus)
			{
				builder.append(menu.getId());
				if (count < menus.size())
				{
					builder.append(",");
				}
				count++;
			}
			
			return builder.toString();
		}
		
		return null;
	}
	
	/**
	 * 返回功能数据权限ID列表
	 * @return
	 */
	public String getFuncPermIds ()
	{
		if (funcDataPermissions != null && funcDataPermissions.size() > 0)
		{
			StringBuilder builder = new StringBuilder();
			int count = 1;
			for (ModelAppFunctionDataStrategy funcPerm : funcDataPermissions)
			{
				builder.append(funcPerm.getId());
				if (count < funcDataPermissions.size())
				{
					builder.append(",");
				}
				count++;
			}
			
			return builder.toString();
		}
		
		return null;
	}
	
	/**
	 * 返回菜单Key列表
	 * 
	 * @return
	 */
	public Set<String> getMenuKeys ()
	{
		if (menus != null && menus.size() > 0)
		{
			Set<String> menuKeys = new HashSet<String>();
			for (ModelAppMenu menu : menus)
			{
				if (!menuKeys.contains(menu.getMenuKey()))
				{
					menuKeys.add(menu.getMenuKey());
				}
			}
			return menuKeys;
		}
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo(Object arg0)
	{
		return 0;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.springframework.security.GrantedAuthority#getAuthority()
	 */
	@Override
	public String getAuthority()
	{
		return this.roleKey;
	}
	
	public String getRoleName()
	{
		return roleName;
	}

	public void setRoleName(String roleName)
	{
		this.roleName = roleName;
	}

	public String getRoleDesc()
	{
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc)
	{
		this.roleDesc = roleDesc;
	}

	public Integer getRoleStatus()
	{
		return roleStatus;
	}

	public void setRoleStatus(Integer roleStatus)
	{
		this.roleStatus = roleStatus;
	}

	public String getRoleRights()
	{
		return roleRights;
	}

	public void setRoleRights(String roleRights)
	{
		this.roleRights = roleRights;
	}

	public void setFunctions(Set<ModelAppFunction> functions)
	{
		this.functions = functions;
	}

	public Set<ModelAppFunction> getFunctions()
	{
		return functions;
	}

	public void setMenus(Set<ModelAppMenu> menus)
	{
		this.menus = menus;
	}

	public Set<ModelAppMenu> getMenus()
	{
		return menus;
	}

	public void setUsers(Set<ModelAppUser> users)
	{
		this.users = users;
	}

	public Set<ModelAppUser> getUsers()
	{
		return users;
	}
	
	public Integer getRoleType()
	{
		return roleType;
	}

	public void setRoleType(Integer roleType)
	{
		this.roleType = roleType;
	}

	public String getRoleKey()
	{
		return roleKey;
	}

	public void setRoleKey(String roleKey)
	{
		this.roleKey = roleKey;
	}

	public Integer getRoleEditable()
	{
		return roleEditable;
	}

	public void setRoleEditable(Integer roleEditable)
	{
		this.roleEditable = roleEditable;
	}

	public Set<ModelAppFunctionDataStrategy> getFuncDataPermissions()
	{
		return funcDataPermissions;
	}

	public void setFuncDataPermissions(Set<ModelAppFunctionDataStrategy> funcDataPermissions)
	{
		this.funcDataPermissions = funcDataPermissions;
	}
	
}
