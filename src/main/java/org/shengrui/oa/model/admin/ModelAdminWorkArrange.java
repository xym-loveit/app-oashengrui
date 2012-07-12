package org.shengrui.oa.model.admin;

import java.util.Date;

import org.shengrui.oa.model.system.ModelAppUser;

import cn.trymore.core.model.ModelBase;

import com.google.gson.annotations.Expose;

/**
 * Model: 员工工作安排
 * 
 * @author Tang
 * 
 */
public class ModelAdminWorkArrange 
extends ModelBase {

	private static final long serialVersionUID = -2193656028389462983L;

	/**
	 * 工作日期
	 */
	@Expose
	protected Date workDate;

	/**
	 * 工作时间
	 */
	@Expose
	protected String workTime;

	/**
	 * 员工姓名
	 */
	@Expose
	protected String staffName;

	/**
	 * 员工ID
	 */
	@Expose
	protected ModelAppUser staff;

	/**
	 * 上班类型
	 */
	@Expose
	protected ModelAdminWorkType workType;

	/**
	 * 工作内容
	 */
	@Expose
	protected String workContent;

	public Date getWorkDate() {
		return workDate;
	}

	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
	}

	public String getWorkTime() {
		return workTime;
	}

	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}

	public String getStaffName() {
		return staffName;
	}

	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}

	public ModelAppUser getStaff() {
		return staff;
	}

	public void setStaff(ModelAppUser staff) {
		this.staff = staff;
	}

	public ModelAdminWorkType getWorkType() {
		return workType;
	}

	public void setWorkType(ModelAdminWorkType workType) {
		this.workType = workType;
	}

	public String getWorkContent() {
		return workContent;
	}

	public void setWorkContent(String workContent) {
		this.workContent = workContent;
	}

}
