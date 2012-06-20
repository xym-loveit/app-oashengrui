package org.shengrui.oa.model.flow;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 工作流当前审核状态
 * 
 * @author x36zhao
 *
 */
public class ModelProcessForm
extends ModelBase
{

	private static final long serialVersionUID = -8682806328856906713L;
	
	/**
	 * 申请表单编号
	 */
	private String applyFormNo;
	
	/**
	 * 工作流类型
	 */
	private ModelProcessType processType;
	
	/**
	 * 
	 */
	private ModelProcessForm previousProcess;
	
	/**
	 * 
	 */
	private ModelProcessForm nextProcess;
	
	/**
	 * 审核流程名称
	 */
	private String processName;
	
	/**
	 * 待审核部门名称
	 */
	private String toDepartmentNames;
	
	/**
	 * 待审核部门ID
	 */
	private String toDepartmentIds;
	
	/**
	 * 待审核岗位名称
	 */
	private String toPositionNames;
	
	/**
	 * 待审核岗位ID
	 */
	private String toPositionIds;
	
	/**
	 * 待审核区域名称
	 */
	private String toDistrictNames;
	
	/**
	 * 待审核区域ID
	 */
	private String toDistrictIds;
	
	/**
	 * 待审核用户名称
	 */
	private String toUserNames;
	
	/**
	 * 待审核用户ID
	 */
	private String toUserIds;
	
	/**
	 * 待审核角色名称
	 */
	private String toRoleNames;
	
	/**
	 * 待审核角色ID
	 */
	private String toRoleIds;
	
	/**
	 * 审核地区名称
	 */
	private String auditDistrictNames;
	
	/**
	 * 审核地区ID
	 */
	private String auditDistrictIds;
	
	/**
	 * 审核部门名称
	 */
	private String auditDepartmentNames;
	
	/**
	 * 审核部门ID
	 */
	private String auditDepartmentIds;
	
	/**
	 * 审核岗位名称
	 */
	private String auditPositionNames;
	
	/**
	 * 审核岗位ID
	 */
	private String auditPositionIds;
	
	/**
	 * 审核用户名称
	 */
	private String auditUserNames;
	
	/**
	 * 审核用户ID
	 */
	private String auditUserIds;
	
	/**
	 * 审核角色名称
	 */
	private String auditRoleNames;
	
	/**
	 * 审核角色ID
	 */
	private String auditRoleIds;
	
	/**
	 * 审核日期
	 */
	private Date auditDate;
	
	/**
	 * 审核意见
	 */
	private String auditIdea;
	
	/**
	 * 审核状态码
	 */
	private int auditState;
	
	/**
	 * 排序码
	 */
	private Integer sortCode;
	
	/**
	 * The enumeration of interview state
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EProcessFormStatus
	{
		ONAPPROVING(1, "onapproving"),					// 审核中
		APPROVED (2, "approved"),						// 审核通过
		NOTPASSED(3, "notpass"),						// 审核未通过
		RETURNED(4, "returned");						// 审核退回
		
		private Integer value;
		private String text;
		
		EProcessFormStatus (Integer value, String text)
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
	
	public String getToDepartmentNames()
	{
		return toDepartmentNames;
	}

	public void setToDepartmentNames(String toDepartmentNames)
	{
		this.toDepartmentNames = toDepartmentNames;
	}

	public String getToDepartmentIds()
	{
		return toDepartmentIds;
	}

	public void setToDepartmentIds(String toDepartmentIds)
	{
		this.toDepartmentIds = toDepartmentIds;
	}

	public String getToUserNames()
	{
		return toUserNames;
	}

	public void setToUserNames(String toUserNames)
	{
		this.toUserNames = toUserNames;
	}

	public String getToUserIds()
	{
		return toUserIds;
	}

	public void setToUserIds(String toUserIds)
	{
		this.toUserIds = toUserIds;
	}

	public String getToRoleNames()
	{
		return toRoleNames;
	}

	public void setToRoleNames(String toRoleNames)
	{
		this.toRoleNames = toRoleNames;
	}

	public String getToRoleIds()
	{
		return toRoleIds;
	}

	public void setToRoleIds(String toRoleIds)
	{
		this.toRoleIds = toRoleIds;
	}

	public String getAuditDepartmentNames()
	{
		return auditDepartmentNames;
	}

	public void setAuditDepartmentNames(String auditDepartmentNames)
	{
		this.auditDepartmentNames = auditDepartmentNames;
	}

	public String getAuditDepartmentIds()
	{
		return auditDepartmentIds;
	}

	public void setAuditDepartmentIds(String auditDepartmentIds)
	{
		this.auditDepartmentIds = auditDepartmentIds;
	}

	public String getAuditUserNames()
	{
		return auditUserNames;
	}

	public void setAuditUserNames(String auditUserNames)
	{
		this.auditUserNames = auditUserNames;
	}

	public String getAuditUserIds()
	{
		return auditUserIds;
	}

	public void setAuditUserIds(String auditUserIds)
	{
		this.auditUserIds = auditUserIds;
	}

	public String getAuditRoleNames()
	{
		return auditRoleNames;
	}

	public void setAuditRoleNames(String auditRoleNames)
	{
		this.auditRoleNames = auditRoleNames;
	}

	public String getAuditRoleIds()
	{
		return auditRoleIds;
	}

	public void setAuditRoleIds(String auditRoleIds)
	{
		this.auditRoleIds = auditRoleIds;
	}

	public Date getAuditDate()
	{
		return auditDate;
	}

	public void setAuditDate(Date auditDate)
	{
		this.auditDate = auditDate;
	}

	public String getAuditIdea()
	{
		return auditIdea;
	}

	public void setAuditIdea(String auditIdea)
	{
		this.auditIdea = auditIdea;
	}

	public int getAuditState()
	{
		return auditState;
	}

	public void setAuditState(int auditState)
	{
		this.auditState = auditState;
	}

	public Integer getSortCode()
	{
		return sortCode;
	}

	public void setSortCode(Integer sortCode)
	{
		this.sortCode = sortCode;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}

	public void setApplyFormNo(String applyFormNo)
	{
		this.applyFormNo = applyFormNo;
	}

	public String getApplyFormNo()
	{
		return applyFormNo;
	}

	public void setProcessType(ModelProcessType processType)
	{
		this.processType = processType;
	}

	public ModelProcessType getProcessType()
	{
		return processType;
	}

	public void setPreviousProcess(ModelProcessForm previousProcess)
	{
		this.previousProcess = previousProcess;
	}

	public ModelProcessForm getPreviousProcess()
	{
		return previousProcess;
	}

	public void setNextProcess(ModelProcessForm nextProcess)
	{
		this.nextProcess = nextProcess;
	}

	public ModelProcessForm getNextProcess()
	{
		return nextProcess;
	}

	public String getProcessName() {
		return processName;
	}

	public void setProcessName(String processName) {
		this.processName = processName;
	}

	public String getToPositionNames() {
		return toPositionNames;
	}

	public void setToPositionNames(String toPositionNames) {
		this.toPositionNames = toPositionNames;
	}

	public String getToPositionIds() {
		return toPositionIds;
	}

	public void setToPositionIds(String toPositionIds) {
		this.toPositionIds = toPositionIds;
	}

	public String gettoDistrictNames() {
		return toDistrictNames;
	}

	public void settoDistrictNames(String toDistrictNames) {
		this.toDistrictNames = toDistrictNames;
	}

	public String getToDistrictIds() {
		return toDistrictIds;
	}

	public void setToDistrictIds(String toDistrictIds) {
		this.toDistrictIds = toDistrictIds;
	}

	public String getAuditDistrictNames() {
		return auditDistrictNames;
	}

	public void setAuditDistrictNames(String auditDistrictNames) {
		this.auditDistrictNames = auditDistrictNames;
	}

	public String getAuditDistrictIds() {
		return auditDistrictIds;
	}

	public void setAuditDistrictIds(String auditDistrictIds) {
		this.auditDistrictIds = auditDistrictIds;
	}

	public String getAuditPositionNames() {
		return auditPositionNames;
	}

	public void setAuditPositionNames(String auditPositionNames) {
		this.auditPositionNames = auditPositionNames;
	}

	public String getAuditPositionIds() {
		return auditPositionIds;
	}

	public void setAuditPositionIds(String auditPositionIds) {
		this.auditPositionIds = auditPositionIds;
	}
	
	
}
