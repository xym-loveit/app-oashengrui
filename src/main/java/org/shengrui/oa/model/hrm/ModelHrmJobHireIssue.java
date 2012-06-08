package org.shengrui.oa.model.hrm;

import java.util.Set;

import cn.trymore.core.model.ModelBase;

public class ModelHrmJobHireIssue
extends ModelBase
{
	
	private static final long serialVersionUID = -4204123712636296457L;
	
	private ModelHrmJobHire jobHire;
	
	private ModelHrmResume resume;
	
	private Set<ModelHrmJobHireInterview> interviews;
	
	private Integer status;
	
	public void setJobHire(ModelHrmJobHire jobHire)
	{
		this.jobHire = jobHire;
	}
	
	public ModelHrmJobHire getJobHire()
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

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public Integer getStatus()
	{
		return status;
	}
	
}
