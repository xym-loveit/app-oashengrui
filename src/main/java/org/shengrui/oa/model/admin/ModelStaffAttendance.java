package org.shengrui.oa.model.admin;

import java.util.Date;

import org.shengrui.oa.util.AppUtil;

import com.google.gson.annotations.Expose;

import cn.trymore.core.acl.AclFilterAnnotation;
import cn.trymore.core.model.ModelBase;

/**
 * Model 员工考勤
 * 
 * @author tank
 *
 */
/**
 * @author tank
 *
 */
public class ModelStaffAttendance extends ModelBase {

	private static final long serialVersionUID = 5371282777644174654L;
	
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
	 * 实际下班时间 - 打卡小时 (上)
	 */
	@Expose
	protected String offtimeShour;
	
	/**
	 * 实际下班时间 - 打卡小时 (下)
	 */
	@Expose
	protected String offtimeEhour;
	
	/**
	 * 实际下班时间 - 打卡分钟 (上)
	 */
	@Expose
	protected String offtimeSmin;
	
	/**
	 * 实际下班时间 - 打卡分钟 (下)
	 */
	@Expose
	protected String offtimeEmin;
	
	/**
	 * 员工ID
	 */
	@Expose
	protected String staffId;
	
	/**
	 * 员工姓名
	 */
	@Expose
	protected String staffName;
	
	/**
	 * 上班类型
	 */
	@Expose
	protected String workType;
	
	/**
	 * 上班状态
	 */
	@Expose
	protected String workStatus;
	
	/**
	 * 请假类型
	 */
	@Expose
	protected String leaveType;
	
	/**
	 * 代班员工姓名
	 */
	@Expose
	protected String staffBehalfName;
	
	/**
	 * 代班员工ID
	 */
	@Expose
	protected String staffBehalfId;
	
	/**
	 * 说明
	 */
	@Expose
	protected String meto;
	
	/**
	 * 考勤结果
	 */
	@Expose
	protected String attendanceResult;
	
	protected String exception;

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

	/**
	 * 员工所属校区
	 */
	protected String districtId;
	
	/**
	 * 员工所在部门
	 */
	protected String depId;
	
	
	
	/**
	 * @return the exception
	 */
	public String getException() {
		return exception;
	}

	/**
	 * @param exception the exception to set
	 */
	public void setException(String exception) {
		this.exception = exception;
	}

	/**
	 * 用于查询的临时变量
	 */
	protected Date filterStart;
	/**
	 * 用于查询的临时变量
	 */
	protected Date filterEnd;


	/**
	 * @return the filterStart
	 */
	public Date getFilterStart() {
		return filterStart;
	}

	/**
	 * @param filterStart the filterStart to set
	 */
	public void setFilterStart(Date filterStart) {
		this.filterStart = filterStart;
	}

	/**
	 * @return the filterEnd
	 */
	public Date getFilterEnd() {
		return filterEnd;
	}

	/**
	 * @param filterEnd the filterEnd to set
	 */
	public void setFilterEnd(Date filterEnd) {
		this.filterEnd = filterEnd;
	}

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

	public String getOfftimeShour() {
		return offtimeShour;
	}

	public void setOfftimeShour(String offtimeShour) {
		this.offtimeShour = offtimeShour;
	}

	public String getOfftimeEhour() {
		return offtimeEhour;
	}

	public void setOfftimeEhour(String offtimeEhour) {
		this.offtimeEhour = offtimeEhour;
	}

	public String getOfftimeSmin() {
		return offtimeSmin;
	}

	public void setOfftimeSmin(String offtimeSmin) {
		this.offtimeSmin = offtimeSmin;
	}

	public String getOfftimeEmin() {
		return offtimeEmin;
	}

	public void setOfftimeEmin(String offtimeEmin) {
		this.offtimeEmin = offtimeEmin;
	}

	public String getStaffId() {
		return staffId;
	}

	public void setStaffId(String staffId) {
		this.staffId = staffId;
	}

	public String getStaffName() {
		return staffName;
	}

	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}

	public String getWorkType() {
		return workType;
	}

	public void setWorkType(String workType) {
		this.workType = workType;
	}

	public String getWorkStatus() {
		return workStatus;
	}

	public void setWorkStatus(String workStatus) {
		this.workStatus = workStatus;
	}

	public String getLeaveType() {
		return leaveType;
	}

	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}

	public String getStaffBehalfName() {
		return staffBehalfName;
	}

	public void setStaffBehalfName(String staffBehalfName) {
		this.staffBehalfName = staffBehalfName;
	}

	public String getStaffBehalfId() {
		return staffBehalfId;
	}

	public void setStaffBehalfId(String staffBehalfId) {
		this.staffBehalfId = staffBehalfId;
	}

	public String getMeto() {
		return meto;
	}

	public void setMeto(String meto) {
		this.meto = meto;
	}

	public String getAttendanceResult() {
		return attendanceResult;
	}

	public void setAttendanceResult(String attendanceResult) {
		this.attendanceResult = attendanceResult;
	}
}
