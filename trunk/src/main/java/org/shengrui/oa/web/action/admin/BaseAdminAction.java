package org.shengrui.oa.web.action.admin;

import javax.annotation.Resource;

import org.shengrui.oa.service.admin.ServiceAdminWorkArrange;
import org.shengrui.oa.service.admin.ServiceAdminWorkType;
import org.shengrui.oa.web.action.BaseAppAction;

/**
 * The base action for Human Resource Management(HRM).
 * 
 * @author Tang
 *
 */
public class BaseAdminAction
extends BaseAppAction
{
	/**
	 * The work arrange service.
	 */
	@Resource
	protected ServiceAdminWorkArrange serviceAdminWorkArrange;
	
	@Resource
	protected ServiceAdminWorkType serviceAdminWorkType;

	
	public ServiceAdminWorkType getServiceAdminWorkType() {
		return serviceAdminWorkType;
	}

	public void setServiceAdminWorkType(ServiceAdminWorkType serviceAdminWorkType) {
		this.serviceAdminWorkType = serviceAdminWorkType;
	}

	public ServiceAdminWorkArrange getServiceAdminWorkArrange() {
		return serviceAdminWorkArrange;
	}

	public void setServiceAdminWorkArrange(
			ServiceAdminWorkArrange serviceAdminWorkArrange) {
		this.serviceAdminWorkArrange = serviceAdminWorkArrange;
	}
	


	
}
