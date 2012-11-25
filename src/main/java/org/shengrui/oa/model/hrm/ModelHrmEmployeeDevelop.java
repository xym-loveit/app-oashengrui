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
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.acl.AclFilterAnnotation;
import cn.trymore.core.model.ModelBase;
import cn.trymore.core.util.UtilCollection;

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
	 * 操作状态, 0=未操作, 1=已操作
	 */
	private Integer operationState = 0;
	
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
	
	/**
	 * 审批状态 (临时变量, 主要用于记录状态过滤...)
	 */
	protected Integer[] condAuditStates;
	
	/**
	 * 申请类型ID (临时变量, 主要用于页面上的搜索...)
	 */
	protected Integer applyFormTypeId;
	
	/**
	 * 申请类型ID (临时变量, 主要用于页面上的搜索...)
	 */
	protected Integer empDistrictId;
	
	/**
	 * 最终审批结果 (仅用于前端页面显示...)
	 */
	protected Integer finalState;
	
	/**
	 * 最新审批结果 (仅用于前端页面显示...)
	 */
	protected Integer latestAuditState;
	
	/**
	 * 当前审批校区ID, 主要用于待办审批提醒.
	 */
	protected String currentProcDistrictId;
	
	/**
	 * 当前审批人ID (个人审批环节), 主要用于待办审批提醒
	 */
	protected String currentProcUserId;
	
	/**
	 * 当前审批部门ID, 主要用于待办审批提醒.
	 */
	protected String currentProcDepId;
	
	/**
	 * 当前审批岗位ID, 主要用于待办审批提醒.
	 */
	protected String currentProcPosId;

	/**
	 * 数据权限过滤
	 */
	@AclFilterAnnotation(
		fieldNames ={"from_district", "from_dep", "emp_id"}, 
		fieldTypes ={AppUtil.DATA_POLICY_DISTRICT, AppUtil.DATA_POLICY_DEPARTMENT, AppUtil.DATA_POLICY_PERSONAL}
	)
	private String aclFilterFields;

	
	/**
	 * The enumeration of operation state
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EOperationState
	{
		BEREGULAR(1, "beregular"),					// 转正
		TRANSFER (2, "transfer"),					// 调动
		PROMOTION(3, "promotion"),				// 晋升
		FAIRWELL(4, "fairwell");						// 辞职
		
		private Integer value;
		private String text;
		
		EOperationState (Integer value, String text)
		{
			this.value = value;
			this.text = text;
		}
		
		public Integer getValue(){
			return value;
		}
		
		public String getText()
		{
			return this.text;
		}
	}
	
	
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
	
	public Integer[] getCondAuditStates()
	{
		return condAuditStates;
	}

	public void setCondAuditStates(Integer[] condAuditStates)
	{
		this.condAuditStates = condAuditStates;
	}
	
	public Integer getApplyFormTypeId()
	{
		return applyFormTypeId;
	}

	public void setApplyFormTypeId(Integer applyFormTypeId)
	{
		this.applyFormTypeId = applyFormTypeId;
	}

	public Integer getEmpDistrictId()
	{
		return empDistrictId;
	}

	public void setEmpDistrictId(Integer empDistrictId)
	{
		this.empDistrictId = empDistrictId;
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
	
	/**
	 * Obtains the final audit state.
	 * 
	 * @return
	 */
	public Integer getFinalState()
	{
		if (this.finalState == null)
		{
			
			if (this.applyForm != null && this.applyForm.size() > 0)
			{
				ModelProcessForm[] forms = new ModelProcessForm[this.applyForm.size()];
				this.applyForm.toArray(forms);
				
				for (int i = forms.length - 1 ; i >= 0; i--)
				{
					ModelProcessForm form = forms[i];
					if (form.getAuditState() != null)
					{
						this.finalState = form.getAuditState();
						break;
					}
				}
			}
			else if (this.getProcessHistory() != null && this.getProcessHistory().size() > 0)
			{
				ModelProcessHistory[] forms = new ModelProcessHistory[this.processHistory.size()];
				this.processHistory.toArray(forms);
				
				ModelProcessHistory procLast = forms[this.processHistory.size() - 1];
				this.finalState = procLast.getAuditState();
			}
		}
		
		return this.finalState;
	}
	
	/**
	 * Obtains the latest audit state.
	 * 
	 * @return
	 */
	public Integer getLatestAuditState()
	{
		if (this.getProcessHistory() != null && this.getProcessHistory().size() > 0)
		{
			ModelProcessHistory[] forms = new ModelProcessHistory[this.processHistory.size()];
			this.processHistory.toArray(forms);
			
			ModelProcessHistory procLast = forms[this.processHistory.size() - 1];
			this.latestAuditState = procLast.getAuditState();
		}
		
		return this.latestAuditState;
	}

	public Integer getOperationState()
	{
		return operationState;
	}

	public void setOperationState(Integer operationState)
	{
		this.operationState = operationState;
	}

	public String getCurrentProcDepId()
	{
		return currentProcDepId;
	}

	public void setCurrentProcDepId(String currentProcDepId)
	{
		this.currentProcDepId = currentProcDepId;
	}

	public String getCurrentProcPosId()
	{
		return currentProcPosId;
	}

	public void setCurrentProcPosId(String currentProcPosId)
	{
		this.currentProcPosId = currentProcPosId;
	}

	public String getAclFilterFields()
	{
		return aclFilterFields;
	}

	public void setAclFilterFields(String aclFilterFields)
	{
		this.aclFilterFields = aclFilterFields;
	}
	
	public String getCurrentProcDistrictId()
	{
		return currentProcDistrictId;
	}

	public void setCurrentProcDistrictId(String currentProcDistrictId)
	{
		this.currentProcDistrictId = currentProcDistrictId;
	}
	
	public String getCurrentProcUserId()
	{
		return currentProcUserId;
	}

	public void setCurrentProcUserId(String currentProcUserId)
	{
		this.currentProcUserId = currentProcUserId;
	}
	
	/**
	 * 获取当前用户最后一次的审批时间
	 * @return
	 */
	public Date getMyLastAuditTime()
	{
		if (UtilCollection.isNotEmpty(this.processHistory))
		{
			Object[] lstAuditHistories = this.processHistory.toArray();
			for (int i = lstAuditHistories.length - 1; i >=0 ; i--)
			{
				Object obj = lstAuditHistories[i];
				if (obj instanceof ModelProcessHistory)
				{
					if (String.valueOf(ContextUtil.getCurrentUserId()).equals(
							((ModelProcessHistory) obj).getAuditUserIds()))
					{
						return ((ModelProcessHistory) obj).getAuditDate();
					}
				}
			}
		}
		return null;
	}
	
}
