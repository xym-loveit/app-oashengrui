package org.shengrui.oa.model.finan;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.model.ModelBase;
import cn.trymore.core.util.UtilCollection;

/**
 * Model: 财务合同申请
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelFinanBase
extends ModelBase
{

	private static final long serialVersionUID = -8811440104989696141L;
	
	/**
	 * 财务合同申请单号
	 */
	protected String formNo;
	
	/**
	 * 财务费用申请类型
	 */
	protected ModelProcessType applyFormType;
	
	/**
	 * 经办人(申请人)
	 */
	protected ModelHrmEmployee employee;
	
	/**
	 * 财务费用申请日期
	 */
	protected Date applyDate;
	
	/**
	 * 所属部门
	 */
	protected ModelSchoolDepartment empDepartment;
	
	/**
	 * 所属校区
	 */
	protected ModelSchoolDistrict empDistrict;
	
	/**
	 * 联系电话
	 */
	protected String empPhoneNo;
	
	/**
	 * 申请说明
	 */
	protected String comments;
	
	/**
	 * 合同总金额
	 */
	protected Double applyAmt;
	
	/**
	 * 申请状态
	 */
	@Deprecated
	protected String status;
	
	/**
	 * 审批状态
	 */
	protected Integer auditState;
	
	/**
	 * 录入人员
	 */
	protected Integer entryId;
	
	/**
	 * 录入日期
	 */
	protected Date entryDateTime;

	/**
	 * 财务费用流程单
	 */
	protected Set<ModelProcessForm> applyForm;
	
	/**
	 * 审批历史
	 */
	protected Set<ModelProcessHistory> processHistory;
	
	/**
	 * 当前审批部门ID, 主要用于待办审批提醒.
	 */
	protected String currentProcDepId;
	
	/**
	 * 当前审批岗位ID, 主要用于待办审批提醒.
	 */
	protected String currentProcPosId;
	
	/**
	 * 当前审批校区ID, 主要用于待办审批提醒.
	 */
	protected String currentProcDistrictId;
	
	/**
	 * 当前审批用户ID (个人审批环节), 主要用于待办审批提醒.
	 */
	protected String currentProcUserId;
	
	/**
	 * 最终审批结果 (仅用于前端页面显示...)
	 */
	protected Integer finalState;
	
	/**
	 * 申请类型ID (临时变量, 主要用于页面上的搜索...)
	 */
	protected Integer applyFormTypeId;
	
	/**
	 * 申请类型ID (临时变量, 主要用于页面上的搜索...)
	 */
	protected Integer empDistrictId;
	
	/**
	 * 审批状态 (临时变量, 主要用于记录状态过滤...)
	 */
	protected Integer[] condAuditStates;
	
	
	/**
	 * 当前审批环节
	 */
	protected ModelProcessForm currentProcessForm;
	
	public ModelProcessType getApplyFormType() 
	{
		return applyFormType;
	}

	public void setApplyFormType(ModelProcessType applyFormType)
	{
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

	public Integer getAuditState() 
	{
		return auditState;
	}
	
	public void setAuditState(Integer auditState) 
	{
		this.auditState = auditState;
	}

	public Integer getEntryId() {
		return entryId;
	}

	public void setEntryId(Integer entryId) {
		this.entryId = entryId;
	}

	public Date getEntryDateTime() {
		return entryDateTime;
	}

	public void setEntryDateTime(Date entryDateTime) {
		this.entryDateTime = entryDateTime;
	}

	public Set<ModelProcessHistory> getProcessHistory() 
	{
		return processHistory;
	}
	
	/**
	 * 获取过滤后的流程审批历史记录.
	 * 
	 * @return
	 */
	public ModelProcessHistory[] getFilteredProcessHistory() 
	{
		if (this.auditState.equals(ModelProcessForm.EProcessFormStatus.APPROVED.getValue()))
		{
			// 审批通过的记录, 历史数据进行过滤只显示最后一次正常的审批记录.
			List<String> idsToRemove = new ArrayList<String>();
			
			ModelProcessHistory[] histories = new ModelProcessHistory[processHistory.size()];
			processHistory.toArray(histories);
			
			boolean abnormalProcess = false;
			for (int i = histories.length - 1; i >= 0; i--)
			{
				ModelProcessHistory history = histories[i];
				
				if (abnormalProcess || (history.getAuditState() == ModelProcessForm.EProcessFormStatus.NOTPASSED.getValue() || 
						history.getAuditState() == ModelProcessForm.EProcessFormStatus.RETURNED.getValue()))
				{
					abnormalProcess = true;
					// 收集需要被过滤的审批数据ID
					idsToRemove.add(history.getId());
				}
			}
			
			if (idsToRemove.size() > 0)
			{
				List<ModelProcessHistory> data = new ArrayList<ModelProcessHistory>(); 
				Iterator<ModelProcessHistory> itor = processHistory.iterator();
				while (itor.hasNext())
				{
					ModelProcessHistory entity = itor.next();
					if (!idsToRemove.contains(entity.getId()))
					{
						data.add(entity);
					}
				}
				idsToRemove.clear();
				
				ModelProcessHistory[] result = new ModelProcessHistory[data.size()];
				data.toArray(result);
				
				return result;
			}
		}
		
		ModelProcessHistory[] result = new ModelProcessHistory[processHistory.size()];
		processHistory.toArray(result);
		
		return result;
	}

	public void setProcessHistory(Set<ModelProcessHistory> processHistory) 
	{
		this.processHistory = processHistory;
	}

	public String getEmpPhoneNo() {
		return empPhoneNo;
	}

	public void setEmpPhoneNo(String empPhoneNo) {
		this.empPhoneNo = empPhoneNo;
	}

	public Double getApplyAmt() {
		return applyAmt;
	}

	public void setApplyAmt(Double applyAmt) {
		this.applyAmt = applyAmt;
	}

	public ModelSchoolDepartment getEmpDepartment() {
		return empDepartment;
	}

	public void setEmpDepartment(ModelSchoolDepartment empDepartment) {
		this.empDepartment = empDepartment;
	}

	public ModelSchoolDistrict getEmpDistrict() {
		return empDistrict;
	}

	public void setEmpDistrict(ModelSchoolDistrict empDistrict) {
		this.empDistrict = empDistrict;
	}

	public void setApplyForm(Set<ModelProcessForm> applyForm)
	{
		this.applyForm = applyForm;
	}

	public Set<ModelProcessForm> getApplyForm()
	{
		return applyForm;
	}

	public void setFormNo(String formNo)
	{
		this.formNo = formNo;
	}

	public String getFormNo()
	{
		return formNo;
	}

	public void setEmployee(ModelHrmEmployee employee)
	{
		this.employee = employee;
	}

	public ModelHrmEmployee getEmployee()
	{
		return employee;
	}

	public void setCurrentProcessForm(ModelProcessForm currentProcessForm)
	{
		this.currentProcessForm = currentProcessForm;
	}
	
	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
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
	
	public Integer[] getCondAuditStates()
	{
		return condAuditStates;
	}

	public void setCondAuditStates(Integer[] condAuditStates)
	{
		this.condAuditStates = condAuditStates;
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
