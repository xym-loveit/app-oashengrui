package org.shengrui.oa.model.admin;

/**
 * @author tank
 *
 */
public class ModelStaffAttendanceView extends ModelStaffAttendance {

	private static final long serialVersionUID = 1414275885329827174L;
	
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