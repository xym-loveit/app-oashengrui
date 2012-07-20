package org.shengrui.oa.model.hrm;

import java.util.Date;
import java.util.Set;

import cn.trymore.core.model.ModelBase;
import cn.trymore.oa.model.system.ModelFileAttach;

/**
 * Model: 应聘简历
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmResume
extends ModelBase
{

	private static final long serialVersionUID = -3713433577264362635L;
	
	/**
	 * 姓名
	 */
	private String fullName;
	
	/**
	 * 性别
	 */
	private Integer sex;
	
	/**
	 * 籍贯
	 */
	private String bornPlace;
	
	/**
	 * 政治面貌
	 */
	private Integer party;
	
	/**
	 * 出生日期
	 */
	private Date birthday;
	
	/**
	 * 联系电话
	 */
	private String mobilePhone;
	
	/**
	 * 婚姻状况
	 */
	private Integer marriage;
	
	/**
	 * 身份证号码
	 */
	private String identityNo;
	
	/**
	 * 居住地址
	 */
	private String address;
	
	/**
	 * 电子邮箱
	 */
	private String email;
	
	/**
	 * 毕业院校
	 */
	private String educationCollege;
	
	/**
	 * 专业
	 */
	private String educationMajority;
	
	/**
	 * 学历
	 */
	private Integer educationDegree;
	
	/**
	 * 师范类专业
	 */
	private Integer teacherMajority;
	
	/**
	 * 教师资格
	 */
	private Integer teacherCertifaciton;
	
	/**
	 * 外语等级
	 */
	private Integer englishLevel;
	
	/**
	 * 普通话等级
	 */
	private Integer chineseLevel;
	
	/**
	 * 员工ID
	 */
	private Integer employeeId;
	
	/**
	 * 附件
	 */
	private Set<ModelFileAttach> attachFiles;
	
	/**
	 * 简历来源
	 */
	private Integer source;
	
	/**
	 * The enumeration of resume source
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EResumeSource
	{
		MANUAL_INPUT(0, "manual_input"),							// 手工输入
		APPLY_INNER(1, "apply_fromInner"),							// 内部申请
		APPLY_RECOMMEND(2, "apply_recommend"),				// 内部推荐
		APPLY_OUTSIDE(3, "apply_fromOut");						// 外部申请
		
		private Integer value;
		private String text;
		
		EResumeSource (Integer value, String text)
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
	
	public String getFullName()
	{
		return fullName;
	}

	public void setFullName(String fullName)
	{
		this.fullName = fullName;
	}

	public Integer getSex()
	{
		return sex;
	}

	public void setSex(Integer sex)
	{
		this.sex = sex;
	}

	public String getBornPlace()
	{
		return bornPlace;
	}

	public void setBornPlace(String bornPlace)
	{
		this.bornPlace = bornPlace;
	}

	public Integer getParty()
	{
		return party;
	}

	public void setParty(Integer party)
	{
		this.party = party;
	}

	public Date getBirthday()
	{
		return birthday;
	}

	public void setBirthday(Date birthday)
	{
		this.birthday = birthday;
	}

	public String getMobilePhone()
	{
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone)
	{
		this.mobilePhone = mobilePhone;
	}

	public Integer getMarriage()
	{
		return marriage;
	}

	public void setMarriage(Integer marriage)
	{
		this.marriage = marriage;
	}

	public String getIdentityNo()
	{
		return identityNo;
	}

	public void setIdentityNo(String identityNo)
	{
		this.identityNo = identityNo;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getEducationCollege()
	{
		return educationCollege;
	}

	public void setEducationCollege(String educationCollege)
	{
		this.educationCollege = educationCollege;
	}

	public String getEducationMajority()
	{
		return educationMajority;
	}

	public void setEducationMajority(String educationMajority)
	{
		this.educationMajority = educationMajority;
	}

	public Integer getEducationDegree()
	{
		return educationDegree;
	}

	public void setEducationDegree(Integer educationDegree)
	{
		this.educationDegree = educationDegree;
	}

	public Integer getTeacherMajority()
	{
		return teacherMajority;
	}

	public void setTeacherMajority(Integer teacherMajority)
	{
		this.teacherMajority = teacherMajority;
	}

	public Integer getTeacherCertifaciton()
	{
		return teacherCertifaciton;
	}

	public void setTeacherCertifaciton(Integer teacherCertifaciton)
	{
		this.teacherCertifaciton = teacherCertifaciton;
	}

	public Integer getEnglishLevel()
	{
		return englishLevel;
	}

	public void setEnglishLevel(Integer englishLevel)
	{
		this.englishLevel = englishLevel;
	}

	public Integer getChineseLevel()
	{
		return chineseLevel;
	}

	public void setChineseLevel(Integer chineseLevel)
	{
		this.chineseLevel = chineseLevel;
	}

	public void setAttachFiles(Set<ModelFileAttach> attachFiles)
	{
		this.attachFiles = attachFiles;
	}

	public Set<ModelFileAttach> getAttachFiles()
	{
		return attachFiles;
	}

	public Integer getSource()
	{
		return source;
	}

	public void setSource(Integer source)
	{
		this.source = source;
	}

	public Integer getEmployeeId()
	{
		return employeeId;
	}

	public void setEmployeeId(Integer employeeId)
	{
		this.employeeId = employeeId;
	}
	
}
