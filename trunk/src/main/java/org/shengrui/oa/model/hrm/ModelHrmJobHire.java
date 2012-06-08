package org.shengrui.oa.model.hrm;

import java.util.Set;

import cn.trymore.core.model.ModelBase;

/**
 * The model for job hire
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmJobHire
extends ModelBase
{

	private static final long serialVersionUID = -5556761025806350274L;
	
	private Set<ModelHrmJobHireIssue> jobHireIssues;

	public void setJobHireIssues(Set<ModelHrmJobHireIssue> jobHireIssues)
	{
		this.jobHireIssues = jobHireIssues;
	}

	public Set<ModelHrmJobHireIssue> getJobHireIssues()
	{
		return jobHireIssues;
	}
	
}
