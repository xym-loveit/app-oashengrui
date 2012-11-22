package org.shengrui.oa.model.system;

import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.util.AppUtil;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 部门岗位
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelSchoolDepartmentPosition
extends ModelBase
{

	private static final long serialVersionUID = -3781061019657477509L;
	
	/**
	 * 岗位名称
	 */
	@Expose
	private String positionName;
	
	/**
	 * 岗位描述
	 */
	@Expose
	private String positionDesc;
	
	/**
	 * 是否为领导
	 */
	@Expose
	private Integer positionLeadership;
	
	/**
	 * 岗位权限Key集合
	 */
	@Expose
	private String positionRoleRights;
	
	/**
	 * 岗位所属部门
	 */
	private ModelSchoolDepartment department;
	
	/**
	 * 岗位权限
	 */
	private Set<ModelAppRole> roles = new HashSet<ModelAppRole>();
	
	/**
	 * 删除标记
	 */
	private Integer delFlag;
	
	/**
	 * 岗位拥有的数据权限
	 */
	private String dataPermissions = String.valueOf(AppUtil.EDataPermissions.DP_MINE.getValue());
	
	
	/**
	 * The enumeration of department position leadership
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EPositionLeadership
	{
		IS_LEADER  (0, "is_leadership"),		// 领导
		IS_NORMAL (1, "is_normalstaff");		// 普通
		
		private Integer value;
		private String text;
		
		EPositionLeadership (Integer value, String text)
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
	 * 返回岗位权限ID列表
	 * @return
	 */
	public String getPositionRoleIds ()
	{
		if (roles != null && roles.size() > 0)
		{
			StringBuilder builder = new StringBuilder();
			int count = 1;
			for (ModelAppRole role : roles)
			{
				builder.append(role.getId());
				if (count < roles.size())
				{
					builder.append(",");
				}
				count++;
			}
			
			return builder.toString();
		}
		
		return null;
	}
	
	public String getPositionName()
	{
		return positionName;
	}

	public void setPositionName(String positionName)
	{
		this.positionName = positionName;
	}

	public String getPositionDesc()
	{
		return positionDesc;
	}

	public void setPositionDesc(String positionDesc)
	{
		this.positionDesc = positionDesc;
	}

	public ModelSchoolDepartment getDepartment()
	{
		return department;
	}

	public void setDepartment(ModelSchoolDepartment department)
	{
		this.department = department;
	}

	public Integer getPositionLeadership()
	{
		return positionLeadership;
	}

	public void setPositionLeadership(Integer positionLeadership)
	{
		this.positionLeadership = positionLeadership;
	}

	public void setRoles(Set<ModelAppRole> roles)
	{
		this.roles = roles;
	}

	public Set<ModelAppRole> getRoles()
	{
		return roles;
	}

	public void setPositionRoleRights(String positionRoleRights)
	{
		this.positionRoleRights = positionRoleRights;
	}

	public String getPositionRoleRights()
	{
		return positionRoleRights;
	}

	public String getDataPermissions()
	{
		return dataPermissions;
	}

	public void setDataPermissions(String dataPermissions)
	{
		this.dataPermissions = dataPermissions;
	}

	public void setDelFlag(Integer delFlag)
	{
		this.delFlag = delFlag;
	}

	public Integer getDelFlag()
	{
		return delFlag;
	}
	
}
