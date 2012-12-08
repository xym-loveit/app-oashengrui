package org.shengrui.oa.model.hrm;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.util.AppUtil;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;
import cn.trymore.core.acl.AclFilterAnnotation;

/**
 * Model: 员工
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmEmployee
extends ModelBase
{

	private static final long serialVersionUID = -8811440104989696140L;
	
	/**
	 * 员工档案
	 */
	private ModelHrmEmployeeProfile profile;
	
	/**
	 * 员工履历
	 */
	private Set<ModelHrmEmployeeRoadMap> roadMaps = new HashSet<ModelHrmEmployeeRoadMap>();
	
	/**
	 * 员工编号
	 */
	@Expose
	private String empNo;
	
	/**
	 * 部门ID
	 */
	private ModelSchoolDepartment employeeDepartment = new ModelSchoolDepartment();
	
	/**
	 * 校区ID
	 */
	private ModelSchoolDistrict employeeDistrict = new ModelSchoolDistrict();
	
	/**
	 * 员工全名
	 */
	@Expose
	private String empName;
	
	/**
	 * 岗位ID
	 */
	private ModelSchoolDepartmentPosition employeePosition = new ModelSchoolDepartmentPosition();
	
	/**
	 * 出生日期
	 */
	private Date birthdate;
	
	/**
	 * 联系电话
	 */
	private String phoneNo;
	
	/**
	 * 短号
	 */
	private String shortNo;
	
	/**
	 * 办公室电话
	 */
	private String officePhone;
	
	/**
	 * 紧急联系人联系方式
	 */
	private String urgentContact;
	
	/**
	 * 待转正日期
	 */
	private Date positiveDueDate;
	
	/**
	 * 合同到期日期
	 */
	private Date contractEndDate;
	
	/**
	 * 在职状态
	 */
	private Integer onboardStatus;
	
	/**
	 * 教师星级
	 */
	private String teacherStar;
	
	/**
	 * 咨询师星级
	 */
	private String consultStar;
	
	/**
	 * 教授年级
	 */
	private String teachClass;
	
	/**
	 * 教授科目
	 */
	private String teachSubject;
	
	/**
	 * 简历ID
	 */
	private ModelHrmResume resume;
	
	/**
	 * 员工状态
	 */
	private String status;
	
	/**
	 * 录入人员
	 */
	private Integer entryId;
	
	/**
	 * 录入日期
	 */
	private Date entryDateTime;
	
	/**
	 * 入职时间
	 */
	private Date onboardDate;
	
	/**
	 * 银行账号
	 * 
	 * */
	private String bankNo;
	/**
	 * 临时变量...
	 */
	@Deprecated
	private String fullName;
	
	/**
	 * 数据权限过滤
	 */
	@AclFilterAnnotation(
		fieldNames ={"district_id", "dep_id", "entry_id"}, 
		fieldTypes ={AppUtil.DATA_POLICY_DISTRICT, AppUtil.DATA_POLICY_DEPARTMENT, AppUtil.DATA_POLICY_PERSONAL}
	)
	private String aclFilterFields;
	
	/**
	 * The enumeration of interview state
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EOnBoardStatus
	{
		ONINSPECT(1, "oninspect"),						// 试用
		ONREGULAR (2, "onregular"),						// 正式
		FAIRWELL(3, "fairwell"),								// 离职
		FIRED(4, "fired");										// 辞退
		
		private Integer value;
		private String text;
		
		EOnBoardStatus (Integer value, String text)
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
	
	public void setProfile(ModelHrmEmployeeProfile profile)
	{
		this.profile = profile;
	}

	public ModelHrmEmployeeProfile getProfile()
	{
		return profile;
	}

	public void setRoadMaps(Set<ModelHrmEmployeeRoadMap> roadMaps)
	{
		this.roadMaps = roadMaps;
	}

	public Set<ModelHrmEmployeeRoadMap> getRoadMaps()
	{
		return roadMaps;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getShortNo() {
		return shortNo;
	}

	public void setShortNo(String shortNo) {
		this.shortNo = shortNo;
	}

	public Date getPositiveDueDate() {
		return positiveDueDate;
	}

	public void setPositiveDueDate(Date positiveDueDate) {
		this.positiveDueDate = positiveDueDate;
	}

	public Date getContractEndDate() {
		return contractEndDate;
	}

	public void setContractEndDate(Date contractEndDate) {
		this.contractEndDate = contractEndDate;
	}

	public Integer getOnboardStatus() {
		return onboardStatus;
	}

	public void setOnboardStatus(Integer onboardStatus) {
		this.onboardStatus = onboardStatus;
	}

	public ModelHrmResume getResume() {
		return resume;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public ModelSchoolDepartment getEmployeeDepartment() 
	{
		return employeeDepartment;
	}

	public void setEmployeeDepartment(ModelSchoolDepartment employeeDepartment) {
		this.employeeDepartment = employeeDepartment;
	}

	public ModelSchoolDistrict getEmployeeDistrict() 
	{
		return employeeDistrict;
	}

	public void setEmployeeDistrict(ModelSchoolDistrict employeeDistrict) {
		this.employeeDistrict = employeeDistrict;
	}

	public ModelSchoolDepartmentPosition getEmployeePosition() 
	{
		return employeePosition;
	}

	public void setEmployeePosition(ModelSchoolDepartmentPosition employeePosition) {
		this.employeePosition = employeePosition;
	}

	public void setResume(ModelHrmResume resume) {
		this.resume = resume;
	}

	public String getTeachClass() {
		return teachClass;
	}

	public void setTeachClass(String teachClass) {
		this.teachClass = teachClass;
	}

	public String getTeachSubject() {
		return teachSubject;
	}

	public void setTeachSubject(String teachSubject) {
		this.teachSubject = teachSubject;
	}

	public String getTeacherStar() {
		return teacherStar;
	}

	public void setTeacherStar(String teacherStar) {
		this.teacherStar = teacherStar;
	}

	public String getConsultStar() {
		return consultStar;
	}

	public void setConsultStar(String consultStar) {
		this.consultStar = consultStar;
	}

	public Date getOnboardDate()
	{
		return onboardDate;
	}

	public void setOnboardDate(Date onboardDate)
	{
		this.onboardDate = onboardDate;
	}

	public String getFullName()
	{
		return fullName;
	}

	public void setFullName(String fullName)
	{
		this.fullName = fullName;
	}

	public String getOfficePhone()
	{
		return officePhone;
	}

	public void setOfficePhone(String officePhone)
	{
		this.officePhone = officePhone;
	}

	public String getUrgentContact()
	{
		return urgentContact;
	}

	public void setUrgentContact(String urgentContact)
	{
		this.urgentContact = urgentContact;
	}

	public String getBankNo() {
		return bankNo;
	}

	public void setBankNo(String bankNo) {
		this.bankNo = bankNo;
	}

	public void setAclFilterFields(String aclFilterFields)
	{
		this.aclFilterFields = aclFilterFields;
	}

	public String getAclFilterFields()
	{
		return aclFilterFields;
	}
	
	
}
