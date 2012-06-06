package org.shengrui.oa.model.process;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 工作流当前审核状态
 * 
 * @author x36zhao
 *
 */
public class ModelProcessRunning
extends ModelBase
{

	private static final long serialVersionUID = -8682806328856906713L;
	
	/**
	 * 申请表单编号
	 */
	private String applyFormNo;
	
	/**
	 * 工作流定义
	 */
	private ModelProcessDefinition processDefinition;
	
	/**
	 * 待审核部门名称
	 */
	private String toDepartmentNames;
	
	/**
	 * 待审核部门ID
	 */
	private String toDepartmentIds;
	
	/**
	 * 待审核用户名称
	 */
	private String toUserNames;
	
	/**
	 * 待审核用户ID
	 */
	private String toUserIds;
	
	/**
	 * 待审核角色名称
	 */
	private String toRoleNames;
	
	/**
	 * 待审核角色ID
	 */
	private String toRoleIds;
	
	/**
	 * 审核部门名称
	 */
	private String auditDepartmentNames;
	
	/**
	 * 审核部门ID
	 */
	private String auditDepartmentIds;
	
	/**
	 * 审核用户名称
	 */
	private String auditUserNames;
	
	/**
	 * 审核用户ID
	 */
	private String auditUserIds;
	
	/**
	 * 审核角色名称
	 */
	private String auditRoleNames;
	
	/**
	 * 审核角色ID
	 */
	private String auditRoleIds;
	
	/**
	 * 审核日期
	 */
	private Date auditDate;
	
	/**
	 * 审核意见
	 */
	private String auditIdea;
	
	/**
	 * 审核状态码
	 */
	private String auditState;
	
	/**
	 * 排序码
	 */
	private Integer sortCode;

	public ModelProcessDefinition getProcessDefinition()
	{
		return processDefinition;
	}

	public void setProcessDefinition(ModelProcessDefinition processDefinition)
	{
		this.processDefinition = processDefinition;
	}

	public String getToDepartmentNames()
	{
		return toDepartmentNames;
	}

	public void setToDepartmentNames(String toDepartmentNames)
	{
		this.toDepartmentNames = toDepartmentNames;
	}

	public String getToDepartmentIds()
	{
		return toDepartmentIds;
	}

	public void setToDepartmentIds(String toDepartmentIds)
	{
		this.toDepartmentIds = toDepartmentIds;
	}

	public String getToUserNames()
	{
		return toUserNames;
	}

	public void setToUserNames(String toUserNames)
	{
		this.toUserNames = toUserNames;
	}

	public String getToUserIds()
	{
		return toUserIds;
	}

	public void setToUserIds(String toUserIds)
	{
		this.toUserIds = toUserIds;
	}

	public String getToRoleNames()
	{
		return toRoleNames;
	}

	public void setToRoleNames(String toRoleNames)
	{
		this.toRoleNames = toRoleNames;
	}

	public String getToRoleIds()
	{
		return toRoleIds;
	}

	public void setToRoleIds(String toRoleIds)
	{
		this.toRoleIds = toRoleIds;
	}

	public String getAuditDepartmentNames()
	{
		return auditDepartmentNames;
	}

	public void setAuditDepartmentNames(String auditDepartmentNames)
	{
		this.auditDepartmentNames = auditDepartmentNames;
	}

	public String getAuditDepartmentIds()
	{
		return auditDepartmentIds;
	}

	public void setAuditDepartmentIds(String auditDepartmentIds)
	{
		this.auditDepartmentIds = auditDepartmentIds;
	}

	public String getAuditUserNames()
	{
		return auditUserNames;
	}

	public void setAuditUserNames(String auditUserNames)
	{
		this.auditUserNames = auditUserNames;
	}

	public String getAuditUserIds()
	{
		return auditUserIds;
	}

	public void setAuditUserIds(String auditUserIds)
	{
		this.auditUserIds = auditUserIds;
	}

	public String getAuditRoleNames()
	{
		return auditRoleNames;
	}

	public void setAuditRoleNames(String auditRoleNames)
	{
		this.auditRoleNames = auditRoleNames;
	}

	public String getAuditRoleIds()
	{
		return auditRoleIds;
	}

	public void setAuditRoleIds(String auditRoleIds)
	{
		this.auditRoleIds = auditRoleIds;
	}

	public Date getAuditDate()
	{
		return auditDate;
	}

	public void setAuditDate(Date auditDate)
	{
		this.auditDate = auditDate;
	}

	public String getAuditIdea()
	{
		return auditIdea;
	}

	public void setAuditIdea(String auditIdea)
	{
		this.auditIdea = auditIdea;
	}

	public String getAuditState()
	{
		return auditState;
	}

	public void setAuditState(String auditState)
	{
		this.auditState = auditState;
	}

	public Integer getSortCode()
	{
		return sortCode;
	}

	public void setSortCode(Integer sortCode)
	{
		this.sortCode = sortCode;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}

	public void setApplyFormNo(String applyFormNo)
	{
		this.applyFormNo = applyFormNo;
	}

	public String getApplyFormNo()
	{
		return applyFormNo;
	}
	
}
