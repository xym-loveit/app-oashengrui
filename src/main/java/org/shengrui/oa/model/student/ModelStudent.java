package org.shengrui.oa.model.student;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * 
 * 学生档案实体类。
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelStudent
extends ModelBase
{

	private static final long serialVersionUID = -2331173514664917081L;
	
	/**
	 * 学生姓名
	 */
	private String name;
	
	/**
	 * 学生性别
	 */
	private short sex;
	
	/**
	 * 监护人姓名
	 */
	private String guardian;
	
	/**
	 * 手机号码
	 */
	private String mobilePhone;
	
	/**
	 * 家庭住址
	 */
	private String homeAddress;
	
	/**
	 * 学号
	 */
	private String studentNo;
	
	/**
	 * 出生日期
	 */
	private Date bornDate;
	
	/**
	 * 所在班级
	 */
	private String onClass;
	
	/**
	 * 班主任所授科目
	 */
	private String masterMajority;
	
	/**
	 * 班主任联系方式
	 */
	private String masterContacts;
	
	/**
	 * 父亲姓名
	 */
	private String fatherName;
	
	/**
	 * 父亲手机号码
	 */
	private String fatherMobilePhone;
	
	/**
	 * 父亲工作单位
	 */
	private String fatherWorkUnit;
	
	/**
	 * 父亲QQ号码
	 */
	private String fatherQQ;
	
	/**
	 * 母亲姓名
	 */
	private String motherName;
	
	/**
	 * 母亲手机号码
	 */
	private String motherMobilePhone;
	
	/**
	 * 母亲工作单位
	 */
	private String motherWorkUnit;
	
	/**
	 * 母亲QQ
	 */
	private String motherQQ;
	
	/**
	 * 学习态度
	 */
	private String learningAttitude;
	
	/**
	 * 学习信心
	 */
	private String learningConfidence;
	
	/**
	 * 学习方法
	 */
	private String learningApproach;
	
	/**
	 * 学习知识
	 */
	private String learningKnowledge;
	
	/**
	 * 综合评价
	 */
	private String overAllEvaluation;
	
	/**
	 * 家庭教育
	 */
	private String familyEducation;
	
	/**
	 * 学校教育
	 */
	private String schoolEducation;
	
	/**
	 * 总结
	 */
	private String summary;

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public short getSex()
	{
		return sex;
	}

	public void setSex(short sex)
	{
		this.sex = sex;
	}

	public String getGuardian()
	{
		return guardian;
	}

	public void setGuardian(String guardian)
	{
		this.guardian = guardian;
	}

	public String getMobilePhone()
	{
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone)
	{
		this.mobilePhone = mobilePhone;
	}

	public String getHomeAddress()
	{
		return homeAddress;
	}

	public void setHomeAddress(String homeAddress)
	{
		this.homeAddress = homeAddress;
	}

	public String getStudentNo()
	{
		return studentNo;
	}

	public void setStudentNo(String studentNo)
	{
		this.studentNo = studentNo;
	}

	public Date getBornDate()
	{
		return bornDate;
	}

	public void setBornDate(Date bornDate)
	{
		this.bornDate = bornDate;
	}

	public String getOnClass()
	{
		return onClass;
	}

	public void setOnClass(String onClass)
	{
		this.onClass = onClass;
	}

	public String getFatherName()
	{
		return fatherName;
	}

	public void setFatherName(String fatherName)
	{
		this.fatherName = fatherName;
	}

	public String getFatherMobilePhone()
	{
		return fatherMobilePhone;
	}

	public void setFatherMobilePhone(String fatherMobilePhone)
	{
		this.fatherMobilePhone = fatherMobilePhone;
	}

	public String getFatherWorkUnit()
	{
		return fatherWorkUnit;
	}

	public void setFatherWorkUnit(String fatherWorkUnit)
	{
		this.fatherWorkUnit = fatherWorkUnit;
	}

	public String getFatherQQ()
	{
		return fatherQQ;
	}

	public void setFatherQQ(String fatherQQ)
	{
		this.fatherQQ = fatherQQ;
	}

	public String getMotherName()
	{
		return motherName;
	}

	public void setMotherName(String motherName)
	{
		this.motherName = motherName;
	}

	public String getMotherMobilePhone()
	{
		return motherMobilePhone;
	}

	public void setMotherMobilePhone(String motherMobilePhone)
	{
		this.motherMobilePhone = motherMobilePhone;
	}

	public String getMotherWorkUnit()
	{
		return motherWorkUnit;
	}

	public void setMotherWorkUnit(String motherWorkUnit)
	{
		this.motherWorkUnit = motherWorkUnit;
	}

	public String getMotherQQ()
	{
		return motherQQ;
	}

	public void setMotherQQ(String motherQQ)
	{
		this.motherQQ = motherQQ;
	}

	public String getLearningAttitude()
	{
		return learningAttitude;
	}

	public void setLearningAttitude(String learningAttitude)
	{
		this.learningAttitude = learningAttitude;
	}

	public String getLearningConfidence()
	{
		return learningConfidence;
	}

	public void setLearningConfidence(String learningConfidence)
	{
		this.learningConfidence = learningConfidence;
	}

	public String getLearningApproach()
	{
		return learningApproach;
	}

	public void setLearningApproach(String learningApproach)
	{
		this.learningApproach = learningApproach;
	}

	public String getLearningKnowledge()
	{
		return learningKnowledge;
	}

	public void setLearningKnowledge(String learningKnowledge)
	{
		this.learningKnowledge = learningKnowledge;
	}

	public String getOverAllEvaluation()
	{
		return overAllEvaluation;
	}

	public void setOverAllEvaluation(String overAllEvaluation)
	{
		this.overAllEvaluation = overAllEvaluation;
	}

	public String getFamilyEducation()
	{
		return familyEducation;
	}

	public void setFamilyEducation(String familyEducation)
	{
		this.familyEducation = familyEducation;
	}

	public String getSchoolEducation()
	{
		return schoolEducation;
	}

	public void setSchoolEducation(String schoolEducation)
	{
		this.schoolEducation = schoolEducation;
	}

	public String getSummary()
	{
		return summary;
	}

	public void setSummary(String summary)
	{
		this.summary = summary;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}

	public String getMasterMajority()
	{
		return masterMajority;
	}

	public void setMasterMajority(String masterMajority)
	{
		this.masterMajority = masterMajority;
	}

	public String getMasterContacts()
	{
		return masterContacts;
	}

	public void setMasterContacts(String masterContacts)
	{
		this.masterContacts = masterContacts;
	}
	
}
