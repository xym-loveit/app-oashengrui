package org.shengrui.oa.web.action.personal;

import javax.annotation.Resource;

import org.shengrui.oa.service.admin.ServiceDocFile;
import org.shengrui.oa.service.admin.ServiceDocLevel;
import org.shengrui.oa.service.admin.ServiceDocManage;
import org.shengrui.oa.service.admin.ServiceDocVisiableRange;
import org.shengrui.oa.service.system.ServiceAppDictionary;
import org.shengrui.oa.service.system.ServiceSchoolDepartment;
import org.shengrui.oa.service.system.ServiceSchoolDepartmentPosition;
import org.shengrui.oa.service.system.ServiceSchoolDistrict;
import org.shengrui.oa.web.action.BaseAppAction;

/**
 * The base action for Personal Management.
 * 
 * @author Tang
 *
 */
public class BasePersonalAction
extends BaseAppAction
{
	/**
	 * The work arrange service.
	 */
	@Resource
	protected ServiceDocManage serviceDocManage;
	
	@Resource
	protected ServiceDocFile serviceDocFile;
	
	@Resource
	protected ServiceDocLevel serviceDocLevel;
	
	@Resource
	protected ServiceDocVisiableRange serviceDocVisiableRange;

	@Resource
	protected ServiceAppDictionary serviceAppDictionary;

	public ServiceAppDictionary getServiceAppDictionary() {
		return serviceAppDictionary;
	}

	public void setServiceAppDictionary(ServiceAppDictionary serviceAppDictionary) {
		this.serviceAppDictionary = serviceAppDictionary;
	}

	public ServiceSchoolDistrict getServiceSchoolDistrict() {
		return serviceSchoolDistrict;
	}

	public void setServiceSchoolDistrict(ServiceSchoolDistrict serviceSchoolDistrict) {
		this.serviceSchoolDistrict = serviceSchoolDistrict;
	}

	public ServiceSchoolDepartment getServiceSchoolDepartment() {
		return serviceSchoolDepartment;
	}

	public void setServiceSchoolDepartment(
			ServiceSchoolDepartment serviceSchoolDepartment) {
		this.serviceSchoolDepartment = serviceSchoolDepartment;
	}

	public ServiceSchoolDepartmentPosition getServiceSchoolDepartmentPosition() {
		return serviceSchoolDepartmentPosition;
	}

	public void setServiceSchoolDepartmentPosition(
			ServiceSchoolDepartmentPosition serviceSchoolDepartmentPosition) {
		this.serviceSchoolDepartmentPosition = serviceSchoolDepartmentPosition;
	}

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
	
}
