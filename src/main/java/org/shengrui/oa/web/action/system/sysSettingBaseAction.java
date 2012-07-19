package org.shengrui.oa.web.action.system;

import javax.annotation.Resource;

import org.shengrui.oa.service.system.ServiceAppFunction;
import org.shengrui.oa.service.system.ServiceBaseWorkContent;
import org.shengrui.oa.service.system.ServiceBaseWorkTime;
import org.shengrui.oa.service.system.ServiceWorkTemplate;
import org.shengrui.oa.web.action.BaseAppAction;

/**
 * The base action for system setting.
 * 
 * @author Jeccy.Zhao
 *
 */
public class sysSettingBaseAction
extends BaseAppAction
{
	protected ServiceWorkTemplate serviceWorkTemplate;
	/**
	 * @return the serviceWorkTemplate
	 */
	public ServiceWorkTemplate getServiceWorkTemplate() {
		return serviceWorkTemplate;
	}

	/**
	 * @param serviceWorkTemplate the serviceWorkTemplate to set
	 */
	public void setServiceWorkTemplate(ServiceWorkTemplate serviceWorkTemplate) {
		this.serviceWorkTemplate = serviceWorkTemplate;
	}

	protected ServiceBaseWorkTime serviceBaseWorkTime;
	/**
	 * base work content service
	 */
	@Resource
	protected ServiceBaseWorkContent serviceBaseWorkContent;
	public ServiceBaseWorkTime getServiceBaseWorkTime() {
		return serviceBaseWorkTime;
	}

	public void setServiceBaseWorkTime(ServiceBaseWorkTime serviceBaseWorkTime) {
		this.serviceBaseWorkTime = serviceBaseWorkTime;
	}

	/**
	 * The application function service
	 */
	@Resource
	protected ServiceAppFunction serviceAppFunc;
	
	public ServiceAppFunction getServiceAppFunc()
	{
		return serviceAppFunc;
	}

	public void setServiceAppFunc(ServiceAppFunction serviceAppFunc)
	{
		this.serviceAppFunc = serviceAppFunc;
	}

	/**
	 * @return the serviceBaseWorkContent
	 */
	public ServiceBaseWorkContent getServiceBaseWorkContent() {
		return serviceBaseWorkContent;
	}

	/**
	 * @param serviceBaseWorkContent the serviceBaseWorkContent to set
	 */
	public void setServiceBaseWorkContent(
			ServiceBaseWorkContent serviceBaseWorkContent) {
		this.serviceBaseWorkContent = serviceBaseWorkContent;
	}
	
}
