package org.shengrui.oa.model.hrm;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.system.ModelFileAttach;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

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
	private ModelSchoolDistrict jobHireVisibleDistrict;
	
	/**
	 * 应聘记录
	 */
	private Set<ModelHrmJobHireIssue> jobHireIssues = new HashSet<ModelHrmJobHireIssue>();
	
	/**
	 * 附件
	 */
	private Set<ModelFileAttach> attachFiles;
	
	/**
	 * The enumeration of job hire approval status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EJobHireStatus
	{
		TODO(0, "todo"),				// 未审核
		APPROVED(1, "approved"),	// 审核通过
		DENIED(2, "denied");			// 审核未通过
		
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

	public ModelSchoolDistrict getJobHireVisibleDistrict()
	{
		return jobHireVisibleDistrict;
	}

	public void setJobHireVisibleDistrict(ModelSchoolDistrict jobHireVisibleDistrict)
	{
		this.jobHireVisibleDistrict = jobHireVisibleDistrict;
	}

	public Set<ModelFileAttach> getAttachFiles()
	{
		return attachFiles;
	}

	public void setAttachFiles(Set<ModelFileAttach> attachFiles)
	{
		this.attachFiles = attachFiles;
	}

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
	
}
