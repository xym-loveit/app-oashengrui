package org.shengrui.oa.model.hrm;

import java.util.Date;

import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 入职信息
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmJobHireEntry
extends ModelBase
{

	private static final long serialVersionUID = 6907070615463442502L;
	
	/**
	 * 应聘信息
	 */
	private ModelHrmJobHireIssue jobHireIssue;
	
	/**
	 * 入职校区
	 */
	private ModelSchoolDistrict entryDistrict = new ModelSchoolDistrict();
	
	/**
	 * 入职部门
	 */
	private ModelSchoolDepartment entryDepartment;
	
	/**
	 * 入职岗位
	 */
	private ModelSchoolDepartmentPosition entryPosition;
	
	/**
	 * 负责人
	 */
	private ModelAppUser entryCharger;
	
	/**
	 * 当前状态
	 */
	private Integer currentStatus;
	
	/**
	 * 最终入职状态
	 */
	private Integer finalStatus;
	
	/**
	 * 安排入职时间
	 */
	private Date entryPlanDate;
	
	/**
	 * 实际入职时间
	 */
	private Date entryActDate;
	
	/**
	 * 考察结果状态
	 */
	private Integer inspectStatus;
	
	/**
	 * The enumeration of job hire entry current status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EHireEntryCStatus
	{
		TODO(1, "toplan"),				// 待安排
		ARRANGED(2, "arranged");		// 已安排
		
		private Integer value;
		private String text;
		
		EHireEntryCStatus (Integer value, String text)
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
	 * The enumeration of job hire entry final status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EHireEntryFStatus
	{
		TODO(0, "todo"),							// 待入职
		ONBOARD(1, "onboard"),				// 已入职
		OUTOFBOARD(2, "outofboard");		// 未到岗
		
		private Integer value;
		private String text;
		
		EHireEntryFStatus (Integer value, String text)
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
	 * The enumeration of job hire entry inspect status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EHireEntryInspectStatus
	{
		INSPECTING(0, "todo"),					// 考察中
		PASSED(1, "onboard"),					// 考察通过
		UNQUALIFIED(2, "unqualified");		// 考察不通过
		
		private Integer value;
		private String text;
		
		EHireEntryInspectStatus (Integer value, String text)
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
	
	public ModelHrmJobHireIssue getJobHireIssue()
	{
		return jobHireIssue;
	}

	public void setJobHireIssue(ModelHrmJobHireIssue jobHireIssue)
	{
		this.jobHireIssue = jobHireIssue;
	}

	public Integer getCurrentStatus()
	{
		return currentStatus;
	}

	public void setCurrentStatus(Integer currentStatus)
	{
		this.currentStatus = currentStatus;
	}

	public Integer getFinalStatus()
	{
		return finalStatus;
	}

	public void setFinalStatus(Integer finalStatus)
	{
		this.finalStatus = finalStatus;
	}

	public ModelSchoolDistrict getEntryDistrict()
	{
		return entryDistrict;
	}

	public void setEntryDistrict(ModelSchoolDistrict entryDistrict)
	{
		this.entryDistrict = entryDistrict;
	}

	public ModelSchoolDepartment getEntryDepartment()
	{
		return entryDepartment;
	}

	public void setEntryDepartment(ModelSchoolDepartment entryDepartment)
	{
		this.entryDepartment = entryDepartment;
	}

	public ModelSchoolDepartmentPosition getEntryPosition()
	{
		return entryPosition;
	}

	public void setEntryPosition(ModelSchoolDepartmentPosition entryPosition)
	{
		this.entryPosition = entryPosition;
	}

	public ModelAppUser getEntryCharger()
	{
		return entryCharger;
	}

	public void setEntryCharger(ModelAppUser entryCharger)
	{
		this.entryCharger = entryCharger;
	}

	public Date getEntryPlanDate()
	{
		return entryPlanDate;
	}

	public void setEntryPlanDate(Date entryPlanDate)
	{
		this.entryPlanDate = entryPlanDate;
	}

	public Date getEntryActDate()
	{
		return entryActDate;
	}

	public void setEntryActDate(Date entryActDate)
	{
		this.entryActDate = entryActDate;
	}

	public Integer getInspectStatus()
	{
		return inspectStatus;
	}

	public void setInspectStatus(Integer inspectStatus)
	{
		this.inspectStatus = inspectStatus;
	}
	
}
