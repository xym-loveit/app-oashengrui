package org.shengrui.oa.web.action.admin;

import javax.annotation.Resource;

import org.shengrui.oa.service.admin.ServiceAdminWorkArrange;
import org.shengrui.oa.service.admin.ServiceAdminWorkType;
import org.shengrui.oa.service.admin.ServiceDocFile;
import org.shengrui.oa.service.admin.ServiceDocLevel;
import org.shengrui.oa.service.admin.ServiceDocManage;
import org.shengrui.oa.service.admin.ServiceDocVisiableRange;
import org.shengrui.oa.web.action.BaseAppAction;

/**
 * The base action for Admin Management.
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
	
	@Resource
	protected ServiceDocManage serviceDocManage;
	
	@Resource
	protected ServiceDocFile serviceDocFile;
	
	@Resource
	protected ServiceDocLevel serviceDocLevel;
	
	@Resource
	protected ServiceDocVisiableRange serviceDocVisiableRange;

	
	
	
	public ServiceDocManage getServiceDocManage() {
		return serviceDocManage;
	}

	public void setServiceDocManage(ServiceDocManage serviceDocManage) {
		this.serviceDocManage = serviceDocManage;
	}

	public ServiceDocFile getServiceDocFile() {
		return serviceDocFile;
	}

	public void setServiceDocFile(ServiceDocFile serviceDocFile) {
		this.serviceDocFile = serviceDocFile;
	}

	public ServiceDocLevel getServiceDocLevel() {
		return serviceDocLevel;
	}

	public void setServiceDocLevel(ServiceDocLevel serviceDocLevel) {
		this.serviceDocLevel = serviceDocLevel;
	}

	public ServiceDocVisiableRange getServiceDocVisiableRange() {
		return serviceDocVisiableRange;
	}

	public void setServiceDocVisiableRange(
			ServiceDocVisiableRange serviceDocVisiableRange) {
		this.serviceDocVisiableRange = serviceDocVisiableRange;
	}

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
