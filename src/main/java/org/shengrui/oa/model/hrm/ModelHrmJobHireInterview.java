package org.shengrui.oa.model.hrm;

import java.util.Set;

import org.shengrui.oa.model.system.ModelFileAttach;

import cn.trymore.core.model.ModelBase;

public class ModelHrmJobHireInterview
extends ModelBase
{
	
	private static final long serialVersionUID = -4204123712636296457L;
	
	private ModelHrmJobHireIssue jobHireIssue;
	
	private Set<ModelFileAttach> attachFiles;

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
	
}
