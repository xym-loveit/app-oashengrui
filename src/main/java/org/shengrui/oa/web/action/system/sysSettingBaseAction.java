package org.shengrui.oa.web.action.system;

import javax.annotation.Resource;

import org.shengrui.oa.service.system.ServiceAppFunction;
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
	
}
