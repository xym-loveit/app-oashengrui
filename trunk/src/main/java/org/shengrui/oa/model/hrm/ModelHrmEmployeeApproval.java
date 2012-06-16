package org.shengrui.oa.model.hrm;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 人资审批
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmEmployeeApproval
extends ModelBase
{

	private static final long serialVersionUID = -8811440104989696142L;
	
	
	/**
	 * 人资审批ID
	 */
	private int approvalId;
	
	/**
	 * 人资审批流程节点
	 */
	private int approvalTaskId;
	
	/**
	 * 人资申请ID
	 */
	private int parentId;
	
	/**
	 * 人资申请日期
	 */
	private Date applyDate;
	
	/**
	 * 审批备注
	 */
	private String approvalComments;
	
	/**
	 * 录入人员
	 */
	private int entryId;
	
	/**
	 * 录入日期
	 */
	private Date entryDateTime;

	public int getApprovalId() {
		return approvalId;
	}

	public void setApprovalId(int approvalId) {
		this.approvalId = approvalId;
	}

	public int getApprovalTaskId() {
		return approvalTaskId;
	}

	public void setApprovalTaskId(int approvalTaskId) {
		this.approvalTaskId = approvalTaskId;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public String getApprovalComments() {
		return approvalComments;
	}

	public void setApprovalComments(String approvalComments) {
		this.approvalComments = approvalComments;
	}
	
	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
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
