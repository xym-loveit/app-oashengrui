package org.shengrui.oa.model.hrm;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessType;
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
	private String formNo;
	
	/**
	 * 人资申请类型
	 */
	private ModelProcessType applyFormType;
	
	/**
	 * 人资申请日期
	 */
	private Date applyDate;
	
	/**
	 * 到岗日期
	 */
	private Date onboardDate;
	
	/**
	 * 申请备注
	 */
	private String comments;
	
	/**
	 * 申请部门ID
	 */
	private ModelSchoolDepartment toDepartment;
	
	/**
	 * 申请校区ID
	 */
	private ModelSchoolDistrict toDistrict;
	
	/**
	 * 申请岗位ID
	 */
	private ModelSchoolDepartmentPosition toPosition;
	
	/**
	 * 原部门ID
	 */
	private ModelSchoolDepartment fromDepartment;
	
	/**
	 * 原校区ID
	 */
	private ModelSchoolDistrict fromDistrict;
	
	/**
	 * 原岗位ID
	 */
	private ModelSchoolDepartmentPosition fromPosition;
	
	/**
	 * 申请状态
	 */
	@Deprecated
	protected String status;
	
	/**
	 * 审批状态
	 */
	private Integer auditState;
	
	/**
	 * 录入人员
	 */
	private Integer entryId;
	
	/**
	 * 录入日期
	 */
	private Date entryDateTime;
	
	/**
	 * 审批流程单
	 */
	protected Set<ModelProcessForm> applyForm;
	
	/**
	 * 审批历史
	 */
	private Set<ModelProcessHistory> processHistory = new HashSet<ModelProcessHistory>();
	
	/**
	 * 当前审批环节
	 */
	protected ModelProcessForm currentProcessForm;
	
	public ModelHrmEmployee getEmployee()
	{
		return employee;
	}

	public void setEmployee(ModelHrmEmployee employee)
	{
		this.employee = employee;
	}

	public String getFormNo()
	{
		return formNo;
	}

	public void setFormNo(String formNo)
	{
		this.formNo = formNo;
	}

	public ModelProcessType getApplyFormType()
	{
		return applyFormType;
	}

	public void setApplyFormType(ModelProcessType applyFormType)
	{
		this.applyFormType = applyFormType;
	}

	public Date getApplyDate()
	{
		return applyDate;
	}

	public void setApplyDate(Date applyDate)
	{
		this.applyDate = applyDate;
	}

	public String getComments()
	{
		return comments;
	}

	public void setComments(String comments)
	{
		this.comments = comments;
	}

	public ModelSchoolDepartment getToDepartment()
	{
		return toDepartment;
	}

	public void setToDepartment(ModelSchoolDepartment toDepartment)
	{
		this.toDepartment = toDepartment;
	}

	public ModelSchoolDistrict getToDistrict()
	{
		return toDistrict;
	}

	public void setToDistrict(ModelSchoolDistrict toDistrict)
	{
		this.toDistrict = toDistrict;
	}

	public ModelSchoolDepartmentPosition getToPosition()
	{
		return toPosition;
	}

	public void setToPosition(ModelSchoolDepartmentPosition toPosition)
	{
		this.toPosition = toPosition;
	}

	public ModelSchoolDepartment getFromDepartment()
	{
		return fromDepartment;
	}

	public void setFromDepartment(ModelSchoolDepartment fromDepartment)
	{
		this.fromDepartment = fromDepartment;
	}

	public ModelSchoolDistrict getFromDistrict()
	{
		return fromDistrict;
	}

	public void setFromDistrict(ModelSchoolDistrict fromDistrict)
	{
		this.fromDistrict = fromDistrict;
	}

	public ModelSchoolDepartmentPosition getFromPosition()
	{
		return fromPosition;
	}

	public void setFromPosition(ModelSchoolDepartmentPosition fromPosition)
	{
		this.fromPosition = fromPosition;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public Integer getAuditState()
	{
		return auditState;
	}

	public void setAuditState(Integer auditState)
	{
		this.auditState = auditState;
	}

	public Integer getEntryId()
	{
		return entryId;
	}

	public void setEntryId(Integer entryId)
	{
		this.entryId = entryId;
	}

	public Date getEntryDateTime()
	{
		return entryDateTime;
	}

	public void setEntryDateTime(Date entryDateTime)
	{
		this.entryDateTime = entryDateTime;
	}

	public Set<ModelProcessForm> getApplyForm()
	{
		return applyForm;
	}

	public void setApplyForm(Set<ModelProcessForm> applyForm)
	{
		this.applyForm = applyForm;
	}

	public Set<ModelProcessHistory> getProcessHistory()
	{
		return processHistory;
	}

	public void setProcessHistory(Set<ModelProcessHistory> processHistory)
	{
		this.processHistory = processHistory;
	}

	public Date getOnboardDate()
	{
		return onboardDate;
	}

	public void setOnboardDate(Date onboardDate)
	{
		this.onboardDate = onboardDate;
	}
	
	/**
	 * Obtains the current process form node.
	 * 
	 * @return the process form entity
	 */
	public ModelProcessForm getCurrentProcessForm()
	{
		if (currentProcessForm == null && this.applyForm != null)
		{
			ModelProcessForm[] forms = new ModelProcessForm[this.applyForm.size()];
			this.applyForm.toArray(forms);
			
			for (int i = forms.length - 1 ; i >= 0; i--)
			{
				ModelProcessForm form = forms[i];
				if (form.getAuditState() != null && 
						ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue().equals(form.getAuditState()))
				{
					currentProcessForm = form;
					break;
				}
			}
		}
			
		return currentProcessForm;
	}
}
