package org.shengrui.oa.model.student;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * 学情研讨
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelStudentAcademicResearch
extends ModelBase
{

	/**
	 * UID
	 */
	private static final long serialVersionUID = -1495725851632046507L;
	
	/**
	 * 研讨时间
	 */
	private Date date;
	
	/**
	 * 研讨地址
	 */
	private String address;
	
	/**
	 * 与会人员
	 */
	private String participates;
	
	/**
	 * 学习方面
	 */
	private String aspectLearning;
	
	/**
	 * 其他方面
	 */
	private String aspectOthers;
	
	/**
	 * 教学方面
	 */
	private String aspectTeaching;
	
	/**
	 * 心理方面
	 */
	private String aspectMentality;
	
	/**
	 * 其他备注
	 */
	private String meto;

	public Date getDate()
	{
		return date;
	}

	public void setDate(Date date)
	{
		this.date = date;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public String getParticipates()
	{
		return participates;
	}

	public void setParticipates(String participates)
	{
		this.participates = participates;
	}

	public String getAspectLearning()
	{
		return aspectLearning;
	}

	public void setAspectLearning(String aspectLearning)
	{
		this.aspectLearning = aspectLearning;
	}

	public String getAspectOthers()
	{
		return aspectOthers;
	}

	public void setAspectOthers(String aspectOthers)
	{
		this.aspectOthers = aspectOthers;
	}

	public String getAspectTeaching()
	{
		return aspectTeaching;
	}

	public void setAspectTeaching(String aspectTeaching)
	{
		this.aspectTeaching = aspectTeaching;
	}

	public String getAspectMentality()
	{
		return aspectMentality;
	}

	public void setAspectMentality(String aspectMentality)
	{
		this.aspectMentality = aspectMentality;
	}

	public String getMeto()
	{
		return meto;
	}

	public void setMeto(String meto)
	{
		this.meto = meto;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}
	
}
