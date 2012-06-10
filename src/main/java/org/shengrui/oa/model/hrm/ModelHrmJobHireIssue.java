package org.shengrui.oa.model.hrm;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 岗位应聘信息
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmJobHireIssue
extends ModelBase
{
	
	private static final long serialVersionUID = -4204123712636296457L;
	
	/**
	 * 当前状态
	 */
	private Integer currentStatus;
	
	/**
	 * 最终处理结果
	 */
	private Integer finalResult;
	
	/**
	 * 申请时间
	 */
	private Date applyDateTime;
	
	/**
	 * 应聘岗位
	 */
	private ModelHrmJobHireInfo jobHire;
	
	/**
	 * 应聘简历
	 */
	private ModelHrmResume resume;
	
	/**
	 * 应聘面试记录
	 */
	private Set<ModelHrmJobHireInterview> interviews;
	
	/**
	 * 面试结果
	 */
	private Map<String, Integer> interviewStates;
	
	/**
	 * The enumeration of job hire issue status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EJobHireIssueStatus
	{
		TODO(0, "tohandle"),						// 待处理
		TOPLAN(1, "toplan"),							// 待安排
		ARRANGED(2, "arranged"),					// 已安排
		INTERVIEWING(3, "interviewing"),		// 面试中
		FINISHED(4, "finished");						// 已结束
		
		private Integer value;
		private String text;
		
		EJobHireIssueStatus (Integer value, String text)
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
	
	public void setJobHire(ModelHrmJobHireInfo jobHire)
	{
		this.jobHire = jobHire;
	}
	
	public ModelHrmJobHireInfo getJobHire()
	{
		return jobHire;
	}

	public void setResume(ModelHrmResume resume)
	{
		this.resume = resume;
	}

	public ModelHrmResume getResume()
	{
		return resume;
	}

	public void setInterviews(Set<ModelHrmJobHireInterview> interviews)
	{
		this.interviews = interviews;
	}

	public Set<ModelHrmJobHireInterview> getInterviews()
	{
		return interviews;
	}

	public Integer getCurrentStatus()
	{
		return currentStatus;
	}

	public void setCurrentStatus(Integer currentStatus)
	{
		this.currentStatus = currentStatus;
	}

	public Integer getFinalResult()
	{
		return finalResult;
	}

	public void setFinalResult(Integer finalResult)
	{
		this.finalResult = finalResult;
	}

	public Date getApplyDateTime()
	{
		return applyDateTime;
	}

	public void setApplyDateTime(Date applyDateTime)
	{
		this.applyDateTime = applyDateTime;
	}
	
	/**
	 * 获取每个面试环节的面试状态
	 * 
	 * @return
	 */
	public Map<String, Integer> getInterviewStates()
	{
		if (interviewStates == null && this.interviews != null && this.interviews.size() > 0)
		{
			interviewStates = new HashMap<String, Integer>();
			
			for (ModelHrmJobHireInterview interview : interviews)
			{
				interviewStates.put(interview.getSessionSN().toString(), interview.getInterviewStatus());
			}
		}
		
		return interviewStates;
	}

	public void setInterviewStates(Map<String, Integer> interviewStates)
	{
		this.interviewStates = interviewStates;
	}
}
