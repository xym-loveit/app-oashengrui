package org.shengrui.oa.web.action.hrm;

import javax.annotation.Resource;

import org.shengrui.oa.service.hrm.ServiceHrmArchive;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireEntry;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInfo;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireInterview;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue;
import org.shengrui.oa.service.hrm.ServiceHrmResume;
import org.shengrui.oa.web.action.BaseAppAction;

/**
 * The base action for Human Resource Management(HRM).
 * 
 * @author Jeccy.Zhao
 *
 */
public class BaseHrmAction
extends BaseAppAction
{
	/**
	 * The job hire service.
	 */
	@Resource
	protected ServiceHrmJobHireInfo serviceHrmJobHireInfo;
	
	/**
	 * The resume service.
	 */
	@Resource
	protected ServiceHrmResume serviceHrmResume;
	
	/**
	 * The job hire issue service.
	 */
	@Resource
	protected ServiceHrmJobHireIssue serviceHrmJobHireIssue;
	
	/**
	 * The job interview service.
	 */
	@Resource
	protected ServiceHrmJobHireInterview serviceHrmJobHireInterview;
	
	/**
	 * The archive service.
	 */
	@Resource
	protected ServiceHrmArchive serviceHrmArchive;
	
	/**
	 * The entry service.
	 */
	@Resource
	protected ServiceHrmJobHireEntry serviceHrmJobHireEntry;
	
	public ServiceHrmJobHireInfo getServiceHrmJobHireInfo()
	{
		return serviceHrmJobHireInfo;
	}

	public void setServiceHrmJobHireInfo(ServiceHrmJobHireInfo serviceHrmJobHireInfo)
	{
		this.serviceHrmJobHireInfo = serviceHrmJobHireInfo;
	}

	public ServiceHrmResume getServiceHrmResume()
	{
		return serviceHrmResume;
	}

	public void setServiceHrmResume(ServiceHrmResume serviceHrmResume)
	{
		this.serviceHrmResume = serviceHrmResume;
	}

	public ServiceHrmJobHireIssue getServiceHrmJobHireIssue()
	{
		return serviceHrmJobHireIssue;
	}

	public void setServiceHrmJobHireIssue(ServiceHrmJobHireIssue serviceHrmJobHireIssue)
	{
		this.serviceHrmJobHireIssue = serviceHrmJobHireIssue;
	}

	public ServiceHrmJobHireInterview getServiceHrmJobHireInterview()
	{
		return serviceHrmJobHireInterview;
	}

	public void setServiceHrmJobHireInterview(ServiceHrmJobHireInterview serviceHrmJobHireInterview)
	{
		this.serviceHrmJobHireInterview = serviceHrmJobHireInterview;
	}

	public ServiceHrmArchive getServiceHrmArchive()
	{
		return serviceHrmArchive;
	}

	public void setServiceHrmArchive(ServiceHrmArchive serviceHrmArchive)
	{
		this.serviceHrmArchive = serviceHrmArchive;
	}
	
	public ServiceHrmJobHireEntry getServiceHrmJobHireEntry()
	{
		return serviceHrmJobHireEntry;
	}

	public void setServiceHrmJobHireEntry(ServiceHrmJobHireEntry serviceHrmJobHireEntry)
	{
		this.serviceHrmJobHireEntry = serviceHrmJobHireEntry;
	}
}
