package org.shengrui.oa.model.admin;

import java.util.Date;
import java.util.Set;

import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.system.ModelAppDictionary;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelTaskPlan
extends ModelBase
{

	/**
	 * The serial UID
	 */
	private static final long serialVersionUID = 7636072865625421324L;
	
	/**
	 * 任务名称
	 */
	private String taskName;
	
	/**
	 * 任务计划开始时间
	 */
	private Date taskPlannedStartDate;
	
	/**
	 * 任务计划结束时间
	 */
	private Date taskPlannedEndDate;
	
	/**
	 * 任务实际完成时间
	 */
	private Date taskActualEndDate;
	
	/**
	 * 任务类型
	 */
	private ModelAppDictionary taskType;
	
	/**
	 * 任务负责人
	 */
	private ModelHrmEmployee taskCharger;
	
	/**
	 * 任务发起人
	 */
	private ModelHrmEmployee taskOriginator;
	
	/**
	 * 任务参与人
	 */
	private Set<ModelHrmEmployee> taskParticipants;
	
	/**
	 * 任务描述
	 */
	private String taskDescription;
	
	/**
	 * 任务状态
	 */
	private Integer taskStatus;
	
	/**
	 * 任务审批状态
	 */
	private Integer auditStatus;

	public String getTaskName()
	{
		return taskName;
	}

	public void setTaskName(String taskName)
	{
		this.taskName = taskName;
	}

	public Date getTaskPlannedStartDate()
	{
		return taskPlannedStartDate;
	}

	public void setTaskPlannedStartDate(Date taskPlannedStartDate)
	{
		this.taskPlannedStartDate = taskPlannedStartDate;
	}

	public Date getTaskPlannedEndDate()
	{
		return taskPlannedEndDate;
	}

	public void setTaskPlannedEndDate(Date taskPlannedEndDate)
	{
		this.taskPlannedEndDate = taskPlannedEndDate;
	}

	public Date getTaskActualEndDate()
	{
		return taskActualEndDate;
	}

	public void setTaskActualEndDate(Date taskActualEndDate)
	{
		this.taskActualEndDate = taskActualEndDate;
	}

	public ModelAppDictionary getTaskType()
	{
		return taskType;
	}

	public void setTaskType(ModelAppDictionary taskType)
	{
		this.taskType = taskType;
	}

	public ModelHrmEmployee getTaskCharger()
	{
		return taskCharger;
	}

	public void setTaskCharger(ModelHrmEmployee taskCharger)
	{
		this.taskCharger = taskCharger;
	}

	public ModelHrmEmployee getTaskOriginator()
	{
		return taskOriginator;
	}

	public void setTaskOriginator(ModelHrmEmployee taskOriginator)
	{
		this.taskOriginator = taskOriginator;
	}

	public Set<ModelHrmEmployee> getTaskParticipants()
	{
		return taskParticipants;
	}

	public void setTaskParticipants(Set<ModelHrmEmployee> taskParticipants)
	{
		this.taskParticipants = taskParticipants;
	}

	public String getTaskDescription()
	{
		return taskDescription;
	}

	public void setTaskDescription(String taskDescription)
	{
		this.taskDescription = taskDescription;
	}

	public Integer getTaskStatus()
	{
		return taskStatus;
	}

	public void setTaskStatus(Integer taskStatus)
	{
		this.taskStatus = taskStatus;
	}

	public Integer getAuditStatus()
	{
		return auditStatus;
	}

	public void setAuditStatus(Integer auditStatus)
	{
		this.auditStatus = auditStatus;
	}
	
}
