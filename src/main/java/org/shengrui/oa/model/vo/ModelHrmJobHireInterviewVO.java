package org.shengrui.oa.model.vo;

import java.util.Date;

public class ModelHrmJobHireInterviewVO
{
	/**
	 * 面试状态
	 */
	private Integer interviewState;
	
	/**
	 * 面试时间
	 */
	private Date interviewDate;
	
	public ModelHrmJobHireInterviewVO (Integer state, Date date)
	{
		this.interviewState = state;
		this.interviewDate = date;
	}
	
	public void setInterviewState(Integer interviewState)
	{
		this.interviewState = interviewState;
	}
	public Integer getInterviewState()
	{
		return interviewState;
	}
	public void setInterviewDate(Date interviewDate)
	{
		this.interviewDate = interviewDate;
	}
	public Date getInterviewDate()
	{
		return interviewDate;
	}
}
