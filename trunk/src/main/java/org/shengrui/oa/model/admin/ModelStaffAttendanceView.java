package org.shengrui.oa.model.admin;

import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.acl.AclFilterAnnotation;

/**
 * @author tank
 *
 */
public class ModelStaffAttendanceView extends ModelStaffAttendance {

	private static final long serialVersionUID = 1414275885329827174L;
	/**
	 * 数据权限过滤
	 */
	@AclFilterAnnotation(
		fieldNames ={"district_id", "dep_id", "staff_id"}, 
		fieldTypes ={AppUtil.DATA_POLICY_DISTRICT, AppUtil.DATA_POLICY_DEPARTMENT, AppUtil.DATA_POLICY_PERSONAL}
	)
	private String aclFilterFields;
	
	/**
	 * @return the aclFilterFields
	 */
	public String getAclFilterFields() {
		return aclFilterFields;
	}

	/**
	 * @param aclFilterFields the aclFilterFields to set
	 */
	public void setAclFilterFields(String aclFilterFields) {
		this.aclFilterFields = aclFilterFields;
	}

	/**
	 * 联合主键
	 */
	private ModelStaffAttendanceViewID attendanceViewId = new ModelStaffAttendanceViewID();

	/**
	 * @return the attendanceViewId
	 */
	public ModelStaffAttendanceViewID getAttendanceViewId() {
		return attendanceViewId;
	}

	/**
	 * @param attendanceViewId the attendanceViewId to set
	 */
	public void setAttendanceViewId(ModelStaffAttendanceViewID attendanceViewId) {
		this.attendanceViewId = attendanceViewId;
	}

}