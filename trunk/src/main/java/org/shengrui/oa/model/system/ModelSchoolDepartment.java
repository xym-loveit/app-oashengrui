package org.shengrui.oa.model.system;

import java.util.Set;

import org.shengrui.oa.util.AppUtil;

import com.google.gson.annotations.Expose;

import cn.trymore.core.acl.AclFilterAnnotation;
import cn.trymore.core.model.ModelBase;

/**
 * Model: 部门管理
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelSchoolDepartment
extends ModelBase
{

	private static final long serialVersionUID = 6580519840409552397L;
	
	/**
	 * 部门编号
	 */
	@Expose
	protected String depNo;
	
	/**
	 * 部门名称
	 */
	@Expose
	protected String depName;
	
	/**
	 * 部门描述
	 */
	@Expose
	protected String depDesc;
	
	/**
	 * 部门结构类型
	 */
	@Expose
	protected Integer depOrgType;
	
	/**
	 * 对口级别
	 */
	@Expose
	protected Integer depEquivalentLevel;
	
	/**
	 * 对口部门
	 */
	@Expose
	protected transient ModelSchoolDepartment depEquivalentBranch;
	
	/**
	 * 岗位职位
	 */
	@Expose
	protected Set<ModelSchoolDepartmentPosition> positions;
	
	/**
	 * 数据权限过滤
	 */
	@AclFilterAnnotation(
		fieldNames ={"dep_id"}, 
		fieldTypes ={AppUtil.DATA_POLICY_DEPARTMENT}
	)
	protected String aclFilterFields;
	
	public String getDepName()
	{
		return depName;
	}

	public void setDepName(String depName)
	{
		this.depName = depName;
	}

	public String getDepDesc()
	{
		return depDesc;
	}

	public void setDepDesc(String depDesc)
	{
		this.depDesc = depDesc;
	}
	
	public String getDepNo()
	{
		return depNo;
	}

	public void setDepNo(String depNo)
	{
		this.depNo = depNo;
	}
	
	public ModelSchoolDepartment getDepEquivalentBranch()
	{
		return depEquivalentBranch;
	}

	public void setDepEquivalentBranch(ModelSchoolDepartment depEquivalentBranch)
	{
		this.depEquivalentBranch = depEquivalentBranch;
	}
	
	public Integer getDepEquivalentLevel()
	{
		return depEquivalentLevel;
	}

	public void setDepEquivalentLevel(Integer depEquivalentLevel)
	{
		this.depEquivalentLevel = depEquivalentLevel;
	}
	
	public Set<ModelSchoolDepartmentPosition> getPositions()
	{
		return positions;
	}

	public void setPositions(Set<ModelSchoolDepartmentPosition> positions)
	{
		this.positions = positions;
	}
	
	public Integer getDepOrgType()
	{
		return depOrgType;
	}

	public void setDepOrgType(Integer depOrgType)
	{
		this.depOrgType = depOrgType;
	}
}
