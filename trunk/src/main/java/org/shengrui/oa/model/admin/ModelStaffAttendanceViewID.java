package org.shengrui.oa.model.admin;

import java.io.Serializable;

/**
 * @author tank
 *
 */
public class ModelStaffAttendanceViewID implements Serializable {

	private static final long serialVersionUID = -3222915103262602894L;
	private String origin;
	private String viewId;
	/**
	 * @return the origin
	 */
	public String getOrigin() {
		return origin;
	}
	/**
	 * @param origin the origin to set
	 */
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	/**
	 * @return the viewId
	 */
	public String getViewId() {
		return viewId;
	}
	/**
	 * @param viewId the viewId to set
	 */
	public void setViewId(String viewId) {
		this.viewId = viewId;
	}
}
