package org.shengrui.oa.model.system;

import java.util.HashSet;
import java.util.Set;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 角色模型
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAppRole
extends ModelBase
{
	
	private static final long serialVersionUID = -5327640691910365819L;
	
	/**
	 * 公共角色
	 */
	public static String ROLE_PUBLIC = "ROLE_PUBLIC";
	
	/**
	 * 匿名角色
	 */
	public static String ROLE_ANONYMOUS = "ROLE_ANONYMOUS";
	
	/**
	 * 超级管理员的角色ID
	 */
	public static final Long SUPER_ROLEID = Long.valueOf(-1L);
	
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
	 * 角色描述
	 */
	@Expose
	private String roleDesc;

	/**
	 * 角色状态
	 */
	@Expose
	private Short roleStatus;
	
	/**
	 * 角色拥有的功能字符串列表
	 */
	@Expose
	private String roleRights;
	
	/**
	 * 角色拥有的功能Model集合
	 */
	private Set<ModelAppFunction> functions = new HashSet<ModelAppFunction>();
	
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

	public Short getRoleStatus()
	{
		return roleStatus;
	}

	public void setRoleStatus(Short roleStatus)
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
	
}
