package org.shengrui.oa.model.student;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * 学生成绩记录实体类
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelStudentPerformance
extends ModelBase
{

	private static final long serialVersionUID = -7078551425333946388L;
	
	/**
	 * 考试科目
	 */
	private String examinedSubject;
	
	/**
	 * 考试时间
	 */
	private Date examinedDate;
	
	/**
	 * 考试类型
	 */
	private Short examinedType;
	
	/**
	 * 分数
	 */
	private Double score;
	
	/**
	 * 班级排名
	 */
	private Short rankInClass;
	
	/**
	 * 年级排名
	 */
	private Short rankInGrade;
	
	/**
	 * 学生实体类
	 */
	private ModelStudent studentEntity;
	
	public String getExaminedSubject()
	{
		return examinedSubject;
	}

	public void setExaminedSubject(String examinedSubject)
	{
		this.examinedSubject = examinedSubject;
	}

	public Date getExaminedDate()
	{
		return examinedDate;
	}

	public void setExaminedDate(Date examinedDate)
	{
		this.examinedDate = examinedDate;
	}

	public Short getExaminedType()
	{
		return examinedType;
	}

	public void setExaminedType(Short examinedType)
	{
		this.examinedType = examinedType;
	}

	public Double getScore()
	{
		return score;
	}

	public void setScore(Double score)
	{
		this.score = score;
	}

	public Short getRankInClass()
	{
		return rankInClass;
	}

	public void setRankInClass(Short rankInClass)
	{
		this.rankInClass = rankInClass;
	}

	public Short getRankInGrade()
	{
		return rankInGrade;
	}

	public void setRankInGrade(Short rankInGrade)
	{
		this.rankInGrade = rankInGrade;
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
