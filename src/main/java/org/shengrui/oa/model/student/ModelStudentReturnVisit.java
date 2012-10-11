package org.shengrui.oa.model.student;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * 学生回访记录实体
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelStudentReturnVisit
extends ModelBase
{

	private static final long serialVersionUID = -8149874400889966351L;
	
	/**
	 * 回访日期
	 */
	private Date visitDate;
	
	/**
	 * 回访人
	 */
	private String vistor;
	
	/**
	 * 学生情况
	 */
	private String studentSituation;
	
	/**
	 * 家长要求
	 */
	private String parentalDemands;
	
	/**
	 * 备注
	 */
	private String comment;

	public Date getVisitDate()
	{
		return visitDate;
	}

	public void setVisitDate(Date visitDate)
	{
		this.visitDate = visitDate;
	}

	public String getVistor()
	{
		return vistor;
	}

	public void setVistor(String vistor)
	{
		this.vistor = vistor;
	}

	public String getStudentSituation()
	{
		return studentSituation;
	}

	public void setStudentSituation(String studentSituation)
	{
		this.studentSituation = studentSituation;
	}

	public String getParentalDemands()
	{
		return parentalDemands;
	}

	public void setParentalDemands(String parentalDemands)
	{
		this.parentalDemands = parentalDemands;
	}

	public String getComment()
	{
		return comment;
	}

	public void setComment(String comment)
	{
		this.comment = comment;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}
	
}
