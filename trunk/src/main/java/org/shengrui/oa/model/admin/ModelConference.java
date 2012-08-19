package org.shengrui.oa.model.admin;

import java.util.Date;

import org.shengrui.oa.model.system.ModelAppDictionary;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.acl.AclFilterAnnotation;
import cn.trymore.core.model.ModelBase;

public class ModelConference extends ModelBase {

	private static final long serialVersionUID = -1774057513943961691L;

	/**
	 * 会议名称
	 */
	private String conferenceName;
	
	/**
	 * 会议地点
	 */
	private String address;
	
	/**
	 * 会议级别
	 */
	private String level;
	
	/**
	 * 会议类型
	 */
	private ModelAppDictionary type = new ModelAppDictionary();
	
	/**
	 * 开始日期
	 */
	private Date startDay;
	
	/**
	 * 截止日期
	 */
	private Date endDay;
	
	/**
	 * 开始时间hour
	 */
	private String startHour;
	
	/**
	 * 开始时间minute
	 */
	private String startMinute;

	/**
	 * 结束时间hour
	 */
	private String endHour;
	
	/**
	 * 结束时间minute
	 */
	private String endMinute;
	
	/**
	 * 与会者
	 */
	private String attendances;
	
	private String attendanceIds;
	/**
	 * 与会人数
	 */
	private Integer count;
	
	/**
	 * 联系人姓名
	 */
	private String contactor;

	/**
	 * 联系电话
	 */
	private String phone;
	
	/**
	 * 发起者
	 */
	private ModelAppUser sponsor = new ModelAppUser();
	
	/**
	 * 会议内容
	 */
	private String content;
	
	/**
	 * 会议总结
	 */
	private String summary;
	
	private String status;
	
	/**
	 * 部门
	 */
	private ModelSchoolDepartment department = new ModelSchoolDepartment();
	
	/**
	 * 校区
	 */
	private ModelSchoolDistrict district = new ModelSchoolDistrict();
	
	/**
	 * 可见校区范围
	 */
	//private ModelSchoolDistrict visibleDistrict;
	
	/**
	 * 主要用于多状态集合搜索,超级用户
	 */
	private Integer[] searchStatusCondition;
	
	
	/**
	 * 数据权限过滤
	 */
	@AclFilterAnnotation(
		fieldNames ={"district_id", "depart_id", "sponsor"}, 
		fieldTypes ={AppUtil.DATA_POLICY_DISTRICT, AppUtil.DATA_POLICY_DEPARTMENT, AppUtil.DATA_POLICY_PERSONAL}
	)
	private String aclFilterFields;
	
	/**
	 * The enumeration of job hire approval status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum ConferenceStatus
	{
		START("1"),	// 已发起
		END("2"),	// 已结束
		CANCEL("3"),	// 已取消
		PROCESSING("4");	// 进行中
		
		private String text;
		
		ConferenceStatus (String text)
		{
			this.text = text;
		}

		
		public String getText()
		{
			return this.text;
		}
	}
	
	private String result;
	
	/**
	 * @return the result
	 */
	public String getResult() {
		return result;
	}

	/**
	 * @param result the result to set
	 */
	public void setResult(String result) {
		this.result = result;
	}

	/**
	 * @return the conferenceName
	 */
	public String getConferenceName() {
		return conferenceName;
	}

	/**
	 * @param conferenceName the conferenceName to set
	 */
	public void setConferenceName(String conferenceName) {
		this.conferenceName = conferenceName;
	}

	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the level
	 */
	public String getLevel() {
		return level;
	}

	/**
	 * @param level the level to set
	 */
	public void setLevel(String level) {
		this.level = level;
	}

	/**
	 * @return the type
	 */
	public ModelAppDictionary getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(ModelAppDictionary type) {
		this.type = type;
	}

	/**
	 * @return the startDay
	 */
	public Date getStartDay() {
		return startDay;
	}

	/**
	 * @param startDay the startDay to set
	 */
	public void setStartDay(Date startDay) {
		this.startDay = startDay;
	}

	/**
	 * @return the endDay
	 */
	public Date getEndDay() {
		return endDay;
	}

	/**
	 * @param endDay the endDay to set
	 */
	public void setEndDay(Date endDay) {
		this.endDay = endDay;
	}

	/**
	 * @return the startHour
	 */
	public String getStartHour() {
		return startHour;
	}

	/**
	 * @param startHour the startHour to set
	 */
	public void setStartHour(String startHour) {
		this.startHour = startHour;
	}

	/**
	 * @return the startMinute
	 */
	public String getStartMinute() {
		return startMinute;
	}

	/**
	 * @param startMinute the startMinute to set
	 */
	public void setStartMinute(String startMinute) {
		this.startMinute = startMinute;
	}

	/**
	 * @return the endHour
	 */
	public String getEndHour() {
		return endHour;
	}

	/**
	 * @param endHour the endHour to set
	 */
	public void setEndHour(String endHour) {
		this.endHour = endHour;
	}

	/**
	 * @return the endMinute
	 */
	public String getEndMinute() {
		return endMinute;
	}

	/**
	 * @param endMinute the endMinute to set
	 */
	public void setEndMinute(String endMinute) {
		this.endMinute = endMinute;
	}

	/**
	 * @return the attendances
	 */
	public String getAttendances() {
		return attendances;
	}

	/**
	 * @param attendances the attendances to set
	 */
	public void setAttendances(String attendances) {
		this.attendances = attendances;
	}

	/**
	 * @return the attendanceIds
	 */
	public String getAttendanceIds() {
		return attendanceIds;
	}

	/**
	 * @param attendanceIds the attendanceIds to set
	 */
	public void setAttendanceIds(String attendanceIds) {
		this.attendanceIds = attendanceIds;
	}

	/**
	 * @return the count
	 */
	public Integer getCount() {
		return count;
	}

	/**
	 * @param count the count to set
	 */
	public void setCount(Integer count) {
		this.count = count;
	}

	/**
	 * @return the contactor
	 */
	public String getContactor() {
		return contactor;
	}

	/**
	 * @param contactor the contactor to set
	 */
	public void setContactor(String contactor) {
		this.contactor = contactor;
	}

	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * @return the sponsor
	 */
	public ModelAppUser getSponsor() {
		return sponsor;
	}

	/**
	 * @param sponsor the sponsor to set
	 */
	public void setSponsor(ModelAppUser sponsor) {
		this.sponsor = sponsor;
	}

	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @return the summary
	 */
	public String getSummary() {
		return summary;
	}

	/**
	 * @param summary the summary to set
	 */
	public void setSummary(String summary) {
		this.summary = summary;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the department
	 */
	public ModelSchoolDepartment getDepartment() {
		return department;
	}

	/**
	 * @param department the department to set
	 */
	public void setDepartment(ModelSchoolDepartment department) {
		this.department = department;
	}

	/**
	 * @return the district
	 */
	public ModelSchoolDistrict getDistrict() {
		return district;
	}

	/**
	 * @param district the district to set
	 */
	public void setDistrict(ModelSchoolDistrict district) {
		this.district = district;
	}

//	/**
//	 * @return the visibleDistrict
//	 */
//	public ModelSchoolDistrict getVisibleDistrict() {
//		return visibleDistrict;
//	}
//
//	/**
//	 * @param visibleDistrict the visibleDistrict to set
//	 */
//	public void setVisibleDistrict(ModelSchoolDistrict visibleDistrict) {
//		this.visibleDistrict = visibleDistrict;
//	}

	/**
	 * @return the searchStatusCondition
	 */
	public Integer[] getSearchStatusCondition() {
		return searchStatusCondition;
	}

	/**
	 * @param searchStatusCondition the searchStatusCondition to set
	 */
	public void setSearchStatusCondition(Integer[] searchStatusCondition) {
		this.searchStatusCondition = searchStatusCondition;
	}
}
