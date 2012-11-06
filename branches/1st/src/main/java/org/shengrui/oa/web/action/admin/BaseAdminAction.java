package org.shengrui.oa.web.action.admin;

import javax.annotation.Resource;

import org.shengrui.oa.service.admin.ServiceAdminWorkArrange;
import org.shengrui.oa.service.admin.ServiceAdminWorkType;
import org.shengrui.oa.service.admin.ServiceConferenceInfo;
import org.shengrui.oa.service.admin.ServiceDocFile;
import org.shengrui.oa.service.admin.ServiceDocLevel;
import org.shengrui.oa.service.admin.ServiceDocManage;
import org.shengrui.oa.service.admin.ServiceDocVisiableRange;
import org.shengrui.oa.service.admin.ServiceStaffAttendance;
import org.shengrui.oa.service.admin.ServiceStaffAttendanceView;
import org.shengrui.oa.service.news.ServiceNewsManage;
import org.shengrui.oa.service.system.ServiceAppDictionary;
import org.shengrui.oa.service.system.ServiceAppUser;
import org.shengrui.oa.service.system.ServiceBaseWorkContent;
import org.shengrui.oa.service.system.ServiceBaseWorkTime;import org.shengrui.oa.service.system.ServiceSchoolDepartment;
import org.shengrui.oa.service.system.ServiceSchoolDepartmentPosition;
import org.shengrui.oa.service.system.ServiceSchoolDistrict;
import org.shengrui.oa.service.system.ServiceWorkTemplate;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.oa.service.system.ServiceFileAttach;

/**
 * The base action for Admin Management.
 * 
 * @author Tang
 *
 */
public class BaseAdminAction
extends BaseAppAction
{
	protected ServiceConferenceInfo serviceConference;
	protected ServiceWorkTemplate serviceWorkTemplate;
	protected ServiceBaseWorkTime serviceBaseWorkTime;
	
	protected ServiceBaseWorkContent serviceBaseWorkContent;
	@Resource
	protected ServiceStaffAttendance serviceStaffAttendance;
	protected ServiceStaffAttendanceView serviceStaffAttendanceView;
	/**
	 * @return the serviceStaffAttendanceView
	 */
	public ServiceStaffAttendanceView getServiceStaffAttendanceView() {
		return serviceStaffAttendanceView;
	}

	/**
	 * @param serviceStaffAttendanceView the serviceStaffAttendanceView to set
	 */
	public void setServiceStaffAttendanceView(
			ServiceStaffAttendanceView serviceStaffAttendanceView) {
		this.serviceStaffAttendanceView = serviceStaffAttendanceView;
	}

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
	
	@Resource
	protected ServiceAppDictionary serviceAppDictionary;
	
	protected ServiceNewsManage serviceNewsManage;
	
	public ServiceNewsManage getServiceNewsManage() {
		return serviceNewsManage;
	}

	public void setServiceNewsManage(ServiceNewsManage serviceNewsManage) {
		this.serviceNewsManage = serviceNewsManage;
	}

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

	/**
	 * @return the serviceBaseWorkTime
	 */
	public ServiceBaseWorkTime getServiceBaseWorkTime() {
		return serviceBaseWorkTime;
	}

	/**
	 * @param serviceBaseWorkTime the serviceBaseWorkTime to set
	 */
	public void setServiceBaseWorkTime(ServiceBaseWorkTime serviceBaseWorkTime) {
		this.serviceBaseWorkTime = serviceBaseWorkTime;
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

	/**
	 * @return the serviceStaffAttendance
	 */
	public ServiceStaffAttendance getServiceStaffAttendance() {
		return serviceStaffAttendance;
	}

	/**
	 * @param serviceStaffAttendance the serviceStaffAttendance to set
	 */
	public void setServiceStaffAttendance(
			ServiceStaffAttendance serviceStaffAttendance) {
		this.serviceStaffAttendance = serviceStaffAttendance;
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

	public ServiceAppUser getServiceAppUser() {
		return serviceAppUser;
	}
	public ServiceFileAttach getServiceFileAttach() {
		return serviceFileAttach;
	}

	public void setServiceAppUser(ServiceAppUser serviceAppUser) {
		this.serviceAppUser = serviceAppUser;
	}
	public void setServiceFileAttach(ServiceFileAttach serviceFileAttach) {
		this.serviceFileAttach = serviceFileAttach;
	}

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

	/**
	 * @return the serviceConference
	 */
	public ServiceConferenceInfo getServiceConference() {
		return serviceConference;
	}

	/**
	 * @param serviceConference the serviceConference to set
	 */
	public void setServiceConference(ServiceConferenceInfo serviceConference) {
		this.serviceConference = serviceConference;
	}
	
	
}
