package org.shengrui.oa.model.hrm;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 人资申请
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmEmployeeApply
extends ModelBase
{

	private static final long serialVersionUID = -8811440104989696141L;
	
	/**
	 * 员工档案
	 */
	private ModelHrmEmployee employee = new ModelHrmEmployee();
	
	/**
	 * 人资申请ID
	 */
	private int applyId;
	
	/**
	 * 人资审批流程
	 */
	private int applyForm;
	
	/**
	 * 人资申请日期
	 */
	private Date applyDate;
	
	/**
	 * 申请备注
	 */
	private String applyComments;
	
	/**
	 * 申请部门ID
	 */
	private ModelSchoolDepartment applyDepartment = new ModelSchoolDepartment();
	
	/**
	 * 申请校区ID
	 */
	private ModelSchoolDistrict applyDistrict = new ModelSchoolDistrict();
	
	/**
	 * 申请岗位ID
	 */
	private ModelSchoolDepartmentPosition applyPosition = new ModelSchoolDepartmentPosition();
	
	/**
	 * 申请状态
	 */
	private String status;
	
	/**
	 * 录入人员
	 */
	private int entryId;
	
	/**
	 * 录入日期
	 */
	private Date entryDateTime;

	public ModelHrmEmployee getEmployee() {
		return employee;
	}

	public void setEmployee(ModelHrmEmployee employee) {
		this.employee = employee;
	}

	public int getApplyId() {
		return applyId;
	}

	public void setApplyId(int applyId) {
		this.applyId = applyId;
	}

	public int getApplyForm() {
		return applyForm;
	}

	public void setApplyForm(int applyFormId) {
		this.applyForm = applyFormId;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public String getApplyComments() {
		return applyComments;
	}

	public void setApplyComments(String applyComments) {
		this.applyComments = applyComments;
	}

	public ModelSchoolDepartment getApplyDepartment() {
		return applyDepartment;
	}

	public void setApplyDepartment(ModelSchoolDepartment applyDepartment) {
		this.applyDepartment = applyDepartment;
	}

	public ModelSchoolDistrict getApplyDistrict() {
		return applyDistrict;
	}

	public void setApplyDistrict(ModelSchoolDistrict applyDistrict) {
		this.applyDistrict = applyDistrict;
	}

	public ModelSchoolDepartmentPosition getApplyPosition() {
		return applyPosition;
	}

	public void setApplyPosition(ModelSchoolDepartmentPosition applyPosition) {
		this.applyPosition = applyPosition;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getEntryId() {
		return entryId;
	}

	public void setEntryId(int entryId) {
		this.entryId = entryId;
	}

	public Date getEntryDateTime() {
		return entryDateTime;
	}

	public void setEntryDateTime(Date entryDateTime) {
		this.entryDateTime = entryDateTime;
	}
	
	
	
	
}
