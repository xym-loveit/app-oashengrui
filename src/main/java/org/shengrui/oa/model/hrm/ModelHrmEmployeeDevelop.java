package org.shengrui.oa.model.hrm;

import java.util.Date;

import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 人资发展申请
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmEmployeeDevelop
extends ModelBase
{

	private static final long serialVersionUID = -8811440104989696141L;
	
	/**
	 * 员工档案
	 */
	private ModelHrmEmployee employee = new ModelHrmEmployee();
	
	/**
	 * 人资申请单号
	 */
	private ModelProcessForm applyForm = new ModelProcessForm();
	
	/**
	 * 人资申请类型
	 */
	private int applyFormType;
	
	/**
	 * 人资申请日期
	 */
	private Date applyDate;
	
	/**
	 * 申请备注
	 */
	private String comments;
	
	/**
	 * 申请部门ID
	 */
	private ModelSchoolDepartment fromDepartment = new ModelSchoolDepartment();
	
	/**
	 * 申请校区ID
	 */
	private ModelSchoolDistrict fromDistrict = new ModelSchoolDistrict();
	
	/**
	 * 申请岗位ID
	 */
	private ModelSchoolDepartmentPosition fromPosition = new ModelSchoolDepartmentPosition();
	
	/**
	 * 申请状态
	 */
	private String status;
	
	/**
	 * 审批状态
	 */
	private int auditState;
	
	/**
	 * 录入人员
	 */
	private int entryId = -1;
	
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

	public ModelProcessForm getApplyForm() {
		return applyForm;
	}

	public void setApplyForm(ModelProcessForm applyForm) {
		this.applyForm = applyForm;
	}

	public int getApplyFormType() {
		return applyFormType;
	}

	public void setApplyFormType(int applyFormType) {
		this.applyFormType = applyFormType;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public ModelSchoolDepartment getFromDepartment() {
		return fromDepartment;
	}

	public void setFromDepartment(ModelSchoolDepartment fromDepartment) {
		this.fromDepartment = fromDepartment;
	}

	public ModelSchoolDistrict getFromDistrict() {
		return fromDistrict;
	}

	public void setFromDistrict(ModelSchoolDistrict fromDistrict) {
		this.fromDistrict = fromDistrict;
	}

	public ModelSchoolDepartmentPosition getFromPosition() {
		return fromPosition;
	}

	public void setFromPosition(ModelSchoolDepartmentPosition fromPosition) {
		this.fromPosition = fromPosition;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getAuditState() {
		return auditState;
	}

	public void setAuditState(int auditState) {
		this.auditState = auditState;
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
