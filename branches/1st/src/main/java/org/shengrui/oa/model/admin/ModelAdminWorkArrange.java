package org.shengrui.oa.model.admin;

import java.util.Date;

import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelBaseWorkContent;
import org.shengrui.oa.model.system.ModelBaseWorkTime;
import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.acl.AclFilterAnnotation;
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
	protected ModelBaseWorkTime workTime =new ModelBaseWorkTime();

	/**
	 * 员工姓名
	 */
	@Expose
	protected String staffName;

	/**
	 * 员工ID
	 */
	@Expose
	protected ModelAppUser staff = new ModelAppUser();

	/**
	 * 上班类型
	 */
	@Expose
	protected ModelAdminWorkType workType = new ModelAdminWorkType();

	/**
	 * 工作内容
	 */
	@Expose
	protected ModelBaseWorkContent workContent = new ModelBaseWorkContent();

	/**
	 * 员工所属校区
	 */
	protected String districtId;
	
	/**
	 * 员工所在部门
	 */
	protected String depId;
	
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
	 * @return the depId
	 */
	public String getDepId() {
		return depId;
	}

	/**
	 * @param depId the depId to set
	 */
	public void setDepId(String depId) {
		this.depId = depId;
	}

	protected String attendanceId;
	
	/**
	 * @return the attendanceId
	 */
	public String getAttendanceId() {
		return attendanceId;
	}

	/**
	 * @param attendanceId the attendanceId to set
	 */
	public void setAttendanceId(String attendanceId) {
		this.attendanceId = attendanceId;
	}

	/**
	 * @return the districtId
	 */
	public String getDistrictId() {
		return districtId;
	}

	/**
	 * @param districtId the districtId to set
	 */
	public void setDistrictId(String districtId) {
		this.districtId = districtId;
	}

	public Date getWorkDate() {
		return workDate;
	}

	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
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

}
