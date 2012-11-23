package org.shengrui.oa.model.hrm;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.acl.AclFilterAnnotation;
import cn.trymore.core.model.ModelBase;
import cn.trymore.core.util.UtilCollection;
import cn.trymore.core.util.UtilString;

/**
 * Model: 招聘岗位
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmJobHireInfo
extends ModelBase
{

	private static final long serialVersionUID = -5556761025806350274L;
	
	/**
	 * 招聘岗位名称
	 */
	private String jobHireTitle;
	
	/**
	 * 工作地点
	 */
	private String jobHireAddress;
	
	/**
	 * 工作职责
	 */
	private String jobHireResponsibility;
	
	/**
	 * 工作任职要求
	 */
	private String jobHireCondition;
	
	/**
	 * 工作薪资福利
	 */
	private String jobHireSalary;
	
	/**
	 * 招聘人数
	 */
	private Integer jobHireCount;
	
	/**
	 * 招聘范围
	 */
	private Integer jobHireRange;
	
	/**
	 * 截止时间
	 */
	private Date jobHireEndDate;
	
	/**
	 * 招聘岗位发布人姓名
	 */
	private String postAuthorName;
	
	/**
	 * 招聘岗位发布时间
	 */
	private Date postDate;
	
	/**
	 * 岗位最后更新者姓名
	 */
	private String lastModifiedAuthorName;
	
	/**
	 * 岗位最后更新时间
	 */
	private Date lastModifiedDate;
	
	/**
	 * 审核人姓名
	 */
	private String auditor;

	/**
	 * 审核时间
	 */
	private Date auditDate;
	
	/**
	 * 审核意见
	 */
	private String auditComments;
	
	/**
	 * 招聘岗位备注
	 */
	private String memo;
	
	/**
	 * 状态
	 */
	private Integer status;
	
	/**
	 * 应聘控制
	 */
	private Integer isOpen;
	
	/**
	 * 招聘部门
	 */
	private ModelSchoolDepartment jobHireDepartment = new ModelSchoolDepartment();
	
	/**
	 * 招聘校区
	 */
	private ModelSchoolDistrict jobHireDistrict = new ModelSchoolDistrict();
	
	/**
	 * 可见校区范围
	 */
	// private ModelSchoolDistrict jobHireVisibleDistrict;
	
	/**
	 * 可见校区范围ID集合.
	 */
	private String jobHireVisibleDistrictIds;
	
	/**
	 * 应聘记录
	 */
	private Set<ModelHrmJobHireIssue> jobHireIssues = new HashSet<ModelHrmJobHireIssue>();
	
	/**
	 * 主要用于多状态集合搜索,超级用户
	 */
	private Integer[] searchStatusCondition;
	
	/**
	 * 岗位发布人员ID
	 */
	private Integer entryId;
	
	/**
	 * 岗位发布时间
	 */
	private Date entryTime;
	
	/**
	 * 数据权限过滤
	 */
	@AclFilterAnnotation(
		fieldNames ={"hjob_districtid", "hjob_depid", "entry_id"}, 
		fieldTypes ={AppUtil.DATA_POLICY_DISTRICT, AppUtil.DATA_POLICY_DEPARTMENT, AppUtil.DATA_POLICY_PERSONAL}
	)
	private String aclFilterFields;
	
	/**
	 * 招聘入职(状态为待安排和面试中)的人员数
	 */
	private int numHireIssue;
	
	/**
	 * 招聘入职(入职安排中状态为待安排人员数)
	 */
	private int numHireEntry;
	
	/**
	 * 审核历史
	 */
	private Set<ModelHrmJobHireInfoAuditHistory> auditHistory;
	
	/**
	 * The enumeration of job hire approval status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EJobHireStatus
	{
		TODO_ZONE(1, "todo_inzone"),	// 待校区审核
		TODO_HEAD(2, "todo_inhead"),	// 待总部审核
		RETURNED(3, "returned"),		// 审核退回
		APPROVED(4, "approved");		// 审核通过
		
		private Integer value;
		private String text;
		
		EJobHireStatus (Integer value, String text)
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
	
	/**
	 * The enumeration of job hire open status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EJobHireOpen
	{
		CLOSED(0, "closed"),		// 关闭
		OPEN(1, "open");			// 开放
		
		private Integer value;
		private String text;
		
		EJobHireOpen (Integer value, String text)
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
	
	public void setJobHireIssues(Set<ModelHrmJobHireIssue> jobHireIssues)
	{
		this.jobHireIssues = jobHireIssues;
	}

	public Set<ModelHrmJobHireIssue> getJobHireIssues()
	{
		return jobHireIssues;
	}

	public String getJobHireTitle()
	{
		return jobHireTitle;
	}

	public void setJobHireTitle(String jobHireTitle)
	{
		this.jobHireTitle = jobHireTitle;
	}

	public String getJobHireAddress()
	{
		return jobHireAddress;
	}

	public void setJobHireAddress(String jobHireAddress)
	{
		this.jobHireAddress = jobHireAddress;
	}

	public String getJobHireResponsibility()
	{
		return jobHireResponsibility;
	}

	public void setJobHireResponsibility(String jobHireResponsibility)
	{
		this.jobHireResponsibility = jobHireResponsibility;
	}

	public String getJobHireCondition()
	{
		return jobHireCondition;
	}

	public void setJobHireCondition(String jobHireCondition)
	{
		this.jobHireCondition = jobHireCondition;
	}

	public String getJobHireSalary()
	{
		return jobHireSalary;
	}

	public void setJobHireSalary(String jobHireSalary)
	{
		this.jobHireSalary = jobHireSalary;
	}

	public Integer getJobHireCount()
	{
		return jobHireCount;
	}

	public void setJobHireCount(Integer jobHireCount)
	{
		this.jobHireCount = jobHireCount;
	}

	public Integer getJobHireRange()
	{
		return jobHireRange;
	}

	public void setJobHireRange(Integer jobHireRange)
	{
		this.jobHireRange = jobHireRange;
	}

	public Date getJobHireEndDate()
	{
		return jobHireEndDate;
	}

	public void setJobHireEndDate(Date jobHireEndDate)
	{
		this.jobHireEndDate = jobHireEndDate;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public ModelSchoolDepartment getJobHireDepartment()
	{
		return jobHireDepartment;
	}

	public void setJobHireDepartment(ModelSchoolDepartment jobHireDepartment)
	{
		this.jobHireDepartment = jobHireDepartment;
	}

	public ModelSchoolDistrict getJobHireDistrict()
	{
		return jobHireDistrict;
	}

	public void setJobHireDistrict(ModelSchoolDistrict jobHireDistrict)
	{
		this.jobHireDistrict = jobHireDistrict;
	}

//	public ModelSchoolDistrict getJobHireVisibleDistrict()
//	{
//		return jobHireVisibleDistrict;
//	}
//
//	public void setJobHireVisibleDistrict(ModelSchoolDistrict jobHireVisibleDistrict)
//	{
//		this.jobHireVisibleDistrict = jobHireVisibleDistrict;
//	}

	public String getPostAuthorName()
	{
		return postAuthorName;
	}

	public void setPostAuthorName(String postAuthorName)
	{
		this.postAuthorName = postAuthorName;
	}

	public Date getPostDate()
	{
		return postDate;
	}

	public void setPostDate(Date postDate)
	{
		this.postDate = postDate;
	}

	public String getLastModifiedAuthorName()
	{
		return lastModifiedAuthorName;
	}

	public void setLastModifiedAuthorName(String lastModifiedAuthorName)
	{
		this.lastModifiedAuthorName = lastModifiedAuthorName;
	}

	public Date getLastModifiedDate()
	{
		return lastModifiedDate;
	}

	public void setLastModifiedDate(Date lastModifiedDate)
	{
		this.lastModifiedDate = lastModifiedDate;
	}

	public String getAuditor()
	{
		return auditor;
	}

	public void setAuditor(String auditor)
	{
		this.auditor = auditor;
	}

	public Date getAuditDate()
	{
		return auditDate;
	}

	public void setAuditDate(Date auditDate)
	{
		this.auditDate = auditDate;
	}

	public String getAuditComments()
	{
		return auditComments;
	}

	public void setAuditComments(String auditComments)
	{
		this.auditComments = auditComments;
	}

	public String getMemo()
	{
		return memo;
	}

	public void setMemo(String memo)
	{
		this.memo = memo;
	}

	public Integer getIsOpen()
	{
		return isOpen;
	}

	public void setIsOpen(Integer isOpen)
	{
		this.isOpen = isOpen;
	}

	public void setSearchStatusCondition(Integer[] searchStatusCondition)
	{
		this.searchStatusCondition = searchStatusCondition;
	}

	public Integer[] getSearchStatusCondition()
	{
		return searchStatusCondition;
	}

	public Integer getEntryId()
	{
		return entryId;
	}

	public void setEntryId(Integer entryId)
	{
		this.entryId = entryId;
	}

	public Date getEntryTime()
	{
		return entryTime;
	}

	public void setEntryTime(Date entryTime)
	{
		this.entryTime = entryTime;
	}

	public String getAclFilterFields()
	{
		return aclFilterFields;
	}

	public void setAclFilterFields(String aclFilterFields)
	{
		this.aclFilterFields = aclFilterFields;
	}
	
	public int getNumHireIssue()
	{
		int num = 0;
		
		if (jobHireIssues != null && jobHireIssues.size() > 0)
		{
			for (ModelHrmJobHireIssue issue : jobHireIssues)
			{
				if (ModelHrmJobHireIssue.EJobHireIssueStatus.TOPLAN.getValue().equals(issue.getCurrentStatus())
						|| issue.isOnInterview())
				{
					num++;
				}
			}
		}
		
		numHireIssue = num;
		
		return numHireIssue;
	}

	public int getNumHireEntry()
	{
		int num = 0;
		
		if (jobHireIssues != null && jobHireIssues.size() > 0)
		{
			for (ModelHrmJobHireIssue issue : jobHireIssues)
			{
				if (issue.getJobHireEntry() != null 
						&& issue.getJobHireEntry().getCurrentStatus().equals(
								ModelHrmJobHireEntry.EHireEntryCStatus.TODO.getValue()))
				{
					num++;
				}
			}
		}
		
		numHireEntry = num;
		
		return numHireEntry;
	}

	public String getJobHireVisibleDistrictIds()
	{
		return UtilString.isNotEmpty(jobHireVisibleDistrictIds) ? jobHireVisibleDistrictIds : null;
	}

	public void setJobHireVisibleDistrictIds(String jobHireVisibleDistrictIds)
	{
		this.jobHireVisibleDistrictIds = jobHireVisibleDistrictIds;
	}

	public void setAuditHistory(Set<ModelHrmJobHireInfoAuditHistory> auditHistory)
	{
		this.auditHistory = auditHistory;
	}

	public Set<ModelHrmJobHireInfoAuditHistory> getAuditHistory()
	{
		return auditHistory;
	}
	
	/**
	 * 获取当前用户最后一次的审批时间
	 * @return
	 */
	public Date getMyLastAuditTime()
	{
		if (UtilCollection.isNotEmpty(this.auditHistory))
		{
			Object[] lstAuditHistories = this.auditHistory.toArray();
			for (int i = lstAuditHistories.length - 1; i >=0 ; i--)
			{
				Object obj = lstAuditHistories[i];
				if (obj instanceof ModelHrmJobHireInfoAuditHistory)
				{
					if (String.valueOf(ContextUtil.getCurrentUserId()).equals(
							((ModelHrmJobHireInfoAuditHistory) obj).getAuditorId()))
					{
						return ((ModelHrmJobHireInfoAuditHistory) obj).getAuditDate();
					}
				}
			}
		}
		return null;
	}
}
