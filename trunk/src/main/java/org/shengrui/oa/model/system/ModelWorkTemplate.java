package org.shengrui.oa.model.system;

import cn.trymore.core.model.ModelBase;

/**
 * @author tank
 *
 */
public class ModelWorkTemplate extends ModelBase {

	private static final long serialVersionUID = -2790048549311290646L;
	protected String workDay;
	protected ModelBaseWorkTime workTime = new ModelBaseWorkTime();
	protected ModelBaseWorkContent workContent = new ModelBaseWorkContent();
	protected ModelAppUser staff = new ModelAppUser();
	protected String staffName;
	protected ModelSchoolDistrict district = new ModelSchoolDistrict();
	protected String templateId;
	protected String enable;
	/**
	 * @return the workDay
	 */
	public String getWorkDay() {
		return workDay;
	}
	/**
	 * @param workDay the workDay to set
	 */
	public void setWorkDay(String workDay) {
		this.workDay = workDay;
	}
	/**
	 * @return the workTime
	 */
	public ModelBaseWorkTime getWorkTime() {
		return workTime;
	}
	/**
	 * @param workTime the workTime to set
	 */
	public void setWorkTime(ModelBaseWorkTime workTime) {
		this.workTime = workTime;
	}
	/**
	 * @return the workContent
	 */
	public ModelBaseWorkContent getWorkContent() {
		return workContent;
	}
	/**
	 * @param workContent the workContent to set
	 */
	public void setWorkContent(ModelBaseWorkContent workContent) {
		this.workContent = workContent;
	}
	/**
	 * @return the staff
	 */
	public ModelAppUser getStaff() {
		return staff;
	}
	/**
	 * @param staff the staff to set
	 */
	public void setStaff(ModelAppUser staff) {
		this.staff = staff;
	}
	/**
	 * @return the staffName
	 */
	public String getStaffName() {
		return staffName;
	}
	/**
	 * @param staffName the staffName to set
	 */
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
	/**
	 * @return the district
	 */
	public ModelSchoolDistrict getDistrict() {
		return district;
	}
	/**
	 * @param district the district to set
	 */
	public void setDistrict(ModelSchoolDistrict district) {
		this.district = district;
	}
	/**
	 * @return the templateId
	 */
	public String getTemplateId() {
		return templateId;
	}
	/**
	 * @param templateId the templateId to set
	 */
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	/**
	 * @return the enable
	 */
	public String getEnable() {
		return enable;
	}
	/**
	 * @param enable the enable to set
	 */
	public void setEnable(String enable) {
		this.enable = enable;
	}
}
