package org.shengrui.oa.model.system;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * The model of application role
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAppRole
extends ModelBase
{
	
	private static final long serialVersionUID = -5327640691910365819L;
	
	public static String ROLE_PUBLIC = "ROLE_PUBLIC";
	
	public static String ROLE_ANONYMOUS = "ROLE_ANONYMOUS";
	
	public static final Long SUPER_ROLEID = Long.valueOf(-1L);
	
	public static final String SUPER_RIGHTS = "__ALL";
	
	@Expose
	private String roleName;

	@Expose
	private String roleDesc;

	@Expose
	private Short roleStatus;
	
	@Expose
	private String roleRights;
	
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
	
}
