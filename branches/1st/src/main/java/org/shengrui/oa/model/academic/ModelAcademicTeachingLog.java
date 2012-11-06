package org.shengrui.oa.model.academic;

import java.util.Date;

import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.student.ModelStudent;

import cn.trymore.core.model.ModelBase;

/**
 * 教学日志
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAcademicTeachingLog
extends ModelBase
{
	/**
	 * UID
	 */
	private static final long serialVersionUID = 5333856929109773228L;
	
	/**
	 * 学生实体
	 */
	private ModelStudent studentEntity;
	
	/**
	 * 教师实体
	 */
	private ModelHrmEmployee teacherEntity;
	
	/**
	 * 学生就读学校
	 * <pre>
	 * NOTE: 该字段或许可以移除, 学校信息可以从学生类中获取.
	 * </pre>
	 */
	private String school;
	
	/**
	 * 学生就读年级
	 * <pre>
	 * NOTE: 该字段或许可以移除, 学校信息可以从学生类中获取.
	 * </pre>
	 */
	private String grade;
	
	/**
	 * 辅导形式
	 */
	private Short coachType;
	
	/**
	 * 课程名字
	 */
	private String courseName;
	
	/**
	 * 课程学科
	 */
	private String courseSubject;
	
	/**
	 * 上课日期
	 */
	private Date courseDate;
	
	/**
	 * 上课时间
	 */
	private String courseTime;
	
	/**
	 * 状态
	 */
	private Short status;
	
	/**
	 * 教学日志上传时间
	 */
	private Date logUploadTime;

	public ModelStudent getStudentEntity()
	{
		return studentEntity;
	}

	public void setStudentEntity(ModelStudent studentEntity)
	{
		this.studentEntity = studentEntity;
	}

	public ModelHrmEmployee getTeacherEntity()
	{
		return teacherEntity;
	}

	public void setTeacherEntity(ModelHrmEmployee teacherEntity)
	{
		this.teacherEntity = teacherEntity;
	}

	public String getSchool()
	{
		return school;
	}

	public void setSchool(String school)
	{
		this.school = school;
	}

	public String getGrade()
	{
		return grade;
	}

	public void setGrade(String grade)
	{
		this.grade = grade;
	}

	public Short getCoachType()
	{
		return coachType;
	}

	public void setCoachType(Short coachType)
	{
		this.coachType = coachType;
	}

	public String getCourseName()
	{
		return courseName;
	}

	public void setCourseName(String courseName)
	{
		this.courseName = courseName;
	}

	public String getCourseSubject()
	{
		return courseSubject;
	}

	public void setCourseSubject(String courseSubject)
	{
		this.courseSubject = courseSubject;
	}

	public Date getCourseDate()
	{
		return courseDate;
	}

	public void setCourseDate(Date courseDate)
	{
		this.courseDate = courseDate;
	}

	public String getCourseTime()
	{
		return courseTime;
	}

	public void setCourseTime(String courseTime)
	{
		this.courseTime = courseTime;
	}

	public Short getStatus()
	{
		return status;
	}

	public void setStatus(Short status)
	{
		this.status = status;
	}

	public Date getLogUploadTime()
	{
		return logUploadTime;
	}

	public void setLogUploadTime(Date logUploadTime)
	{
		this.logUploadTime = logUploadTime;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}
}
