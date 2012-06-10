package org.shengrui.oa.model.hrm;

import java.util.Date;
import java.util.Set;

import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelFileAttach;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 应聘面试记录
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmJobHireInterview
extends ModelBase
{
	
	private static final long serialVersionUID = -4204123712636296457L;
	
	/**
	 * 应聘地址
	 */
	private String interviewAddress;
	
	/**
	 * 应聘日期
	 */
	private Date interviewDate;
	
	/**
	 * 面试官
	 */
	private ModelAppUser interviewer = new ModelAppUser();
	
	/**
	 * 面试环节
	 */
	private Integer sessionSN;
	
	/**
	 * 面试备注
	 */
	private String meto;
	
	/**
	 * 面试最后结果状态
	 */
	private Integer interviewStatus;
	
	/**
	 * 面试意见
	 */
	private String interviewComments;
	
	/**
	 * 应聘信息
	 */
	private ModelHrmJobHireIssue jobHireIssue;
	
	/**
	 * 附件
	 */
	private Set<ModelFileAttach> attachFiles;
	
	/**
	 * The enumeration of interview state
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EInterviewState
	{
		TODO(0, "todo"),							// 待面试
		ONGING(1, "onging"),						// 面试中
		PASSED(2, "passed"),						// 面试通过
		ELIMINATED(3, "eliminated"),			// 淘汰 
		ABSENCE(4, "absence");					// 未到
		
		private Integer value;
		private String text;
		
		EInterviewState (Integer value, String text)
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
	
	public void setJobHireIssue(ModelHrmJobHireIssue jobHireIssue)
	{
		this.jobHireIssue = jobHireIssue;
	}

	public ModelHrmJobHireIssue getJobHireIssue()
	{
		return jobHireIssue;
	}

	public void setAttachFiles(Set<ModelFileAttach> attachFiles)
	{
		this.attachFiles = attachFiles;
	}

	public Set<ModelFileAttach> getAttachFiles()
	{
		return attachFiles;
	}

	public String getInterviewAddress()
	{
		return interviewAddress;
	}

	public void setInterviewAddress(String interviewAddress)
	{
		this.interviewAddress = interviewAddress;
	}

	public Date getInterviewDate()
	{
		return interviewDate;
	}

	public void setInterviewDate(Date interviewDate)
	{
		this.interviewDate = interviewDate;
	}

	public ModelAppUser getInterviewer()
	{
		return interviewer;
	}

	public void setInterviewer(ModelAppUser interviewer)
	{
		this.interviewer = interviewer;
	}

	public Integer getSessionSN()
	{
		return sessionSN;
	}

	public void setSessionSN(Integer sessionSN)
	{
		this.sessionSN = sessionSN;
	}

	public String getMeto()
	{
		return meto;
	}

	public void setMeto(String meto)
	{
		this.meto = meto;
	}

	public String getInterviewComments()
	{
		return interviewComments;
	}

	public void setInterviewComments(String interviewComments)
	{
		this.interviewComments = interviewComments;
	}

	public Integer getInterviewStatus()
	{
		return interviewStatus;
	}

	public void setInterviewStatus(Integer interviewStatus)
	{
		this.interviewStatus = interviewStatus;
	}
	
}
