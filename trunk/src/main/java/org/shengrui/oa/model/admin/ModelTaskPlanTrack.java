package org.shengrui.oa.model.admin;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 任务审批记录
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelTaskPlanTrack
extends ModelBase
{

	/**
	 * The serial UID
	 */
	private static final long serialVersionUID = 3272192606185186656L;
	
	/**
	 * 任务实体
	 */
	private ModelTaskPlan task;
	
	/**
	 * 申请时间
	 */
	private Date taskApplyDate;
	
	/**
	 * 申请类型
	 */
	private Integer taskApplyType;
	
	/**
	 * 申请完成/延期时间
	 */
	private Date taskApplyFinalizedDate;
	
	/**
	 * 申请描述
	 */
	private String taskApplyMeto;
	
	/**
	 * 审批结果
	 */
	private Integer taskAuditState;
	
	/**
	 * 审批确定完成/延期日期
	 */
	private Date taskAuditFinalizedDate;
	
	/**
	 * 审批描述
	 */
	private String taskAuditMeto;
	
	/**
	 * 审批时间
	 */
	private Date taskAuditTime;
	
	
	/**
	 * The enumeration of task track apply type
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum ETaskTrackType
	{
		APPLY_POSTONE (0, "APPLY_POSTONE"),				// 延期申请
		APPLY_ACCOMPLISH (1, "APPLY_ACCOMPLISH");		// 完成申请
		
		private Integer value;
		private String text;
		
		ETaskTrackType (Integer value, String text)
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
	 * The enumeration of task track audit state
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum ETaskAuditState
	{
		PASS (1, "PASS"),					// 审批通过
		NOTPASS (0, "NOTPASS");		// 审批未过
		
		private Integer value;
		private String text;
		
		ETaskAuditState (Integer value, String text)
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
	
	public ModelTaskPlan getTask()
	{
		return task;
	}

	public void setTask(ModelTaskPlan task)
	{
		this.task = task;
	}

	public Date getTaskApplyDate()
	{
		return taskApplyDate;
	}

	public void setTaskApplyDate(Date taskApplyDate)
	{
		this.taskApplyDate = taskApplyDate;
	}

	public Integer getTaskApplyType()
	{
		return taskApplyType;
	}

	public void setTaskApplyType(Integer taskApplyType)
	{
		this.taskApplyType = taskApplyType;
	}

	public Date getTaskApplyFinalizedDate()
	{
		return taskApplyFinalizedDate;
	}

	public void setTaskApplyFinalizedDate(Date taskApplyFinalizedDate)
	{
		this.taskApplyFinalizedDate = taskApplyFinalizedDate;
	}

	public String getTaskApplyMeto()
	{
		return taskApplyMeto;
	}

	public void setTaskApplyMeto(String taskApplyMeto)
	{
		this.taskApplyMeto = taskApplyMeto;
	}

	public Integer getTaskAuditState()
	{
		return taskAuditState;
	}

	public void setTaskAuditState(Integer taskAuditState)
	{
		this.taskAuditState = taskAuditState;
	}

	public Date getTaskAuditFinalizedDate()
	{
		return taskAuditFinalizedDate;
	}

	public void setTaskAuditFinalizedDate(Date taskAuditFinalizedDate)
	{
		this.taskAuditFinalizedDate = taskAuditFinalizedDate;
	}

	public String getTaskAuditMeto()
	{
		return taskAuditMeto;
	}

	public void setTaskAuditMeto(String taskAuditMeto)
	{
		this.taskAuditMeto = taskAuditMeto;
	}

	public Date getTaskAuditTime()
	{
		return taskAuditTime;
	}

	public void setTaskAuditTime(Date taskAuditTime)
	{
		this.taskAuditTime = taskAuditTime;
	}

}
