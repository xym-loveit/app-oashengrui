package org.shengrui.oa.model.student;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * 学生报名记录实体类
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelStudentEnrollment
extends ModelBase
{

	private static final long serialVersionUID = -3621262327632677595L;
	
	/**
	 * 报名类型
	 */
	private Short type;
	
	/**
	 * 签约时间
	 */
	private Date signedDate;
	
	/**
	 * 备注 (辅导形式, 报名课程 科目/流失类型 流失原因类型 流失原因描述)
	 */
	private String commet;
	
	/**
	 * 报名课时
	 */
	private Integer lectureHour;
	
	/**
	 * 教师
	 */
	private String lectureMentor;
	
	/**
	 * 学管师
	 */
	private String lectureMaster;
	
	/**
	 * 学生实体类
	 */
	private ModelStudent studentEntity;
	
	public Short getType()
	{
		return type;
	}

	public void setType(Short type)
	{
		this.type = type;
	}

	public Date getSignedDate()
	{
		return signedDate;
	}

	public void setSignedDate(Date signedDate)
	{
		this.signedDate = signedDate;
	}

	public String getCommet()
	{
		return commet;
	}

	public void setCommet(String commet)
	{
		this.commet = commet;
	}

	public Integer getLectureHour()
	{
		return lectureHour;
	}

	public void setLectureHour(Integer lectureHour)
	{
		this.lectureHour = lectureHour;
	}

	public String getLectureMentor()
	{
		return lectureMentor;
	}

	public void setLectureMentor(String lectureMentor)
	{
		this.lectureMentor = lectureMentor;
	}

	public String getLectureMaster()
	{
		return lectureMaster;
	}

	public void setLectureMaster(String lectureMaster)
	{
		this.lectureMaster = lectureMaster;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}

	public void setStudentEntity(ModelStudent studentEntity)
	{
		this.studentEntity = studentEntity;
	}

	public ModelStudent getStudentEntity()
	{
		return studentEntity;
	}
	
}
