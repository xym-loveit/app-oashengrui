package org.shengrui.oa.model.student;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * 学生咨询记录实体类
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelStudentConsult
extends ModelBase
{

	private static final long serialVersionUID = -656873800517167375L;
	
	/**
	 * 咨询类型
	 */
	private Short consultType;
	
	/**
	 * 咨询日期
	 */
	private Date consultDate;
	
	/**
	 * 咨询记录描述
	 */
	private String consultDescription;
	
	/**
	 * 咨询师
	 * 
	 * <pre>
	 * TODO:
	 * 可能需要替换成<code>ModelHrmEmployee</code>关联属性.
	 * </pre>
	 */
	private String consulter;
	
	/**
	 * 学生实体类
	 */
	private ModelStudent studentEntity;
	
	public Short getConsultType()
	{
		return consultType;
	}

	public void setConsultType(Short consultType)
	{
		this.consultType = consultType;
	}

	public Date getConsultDate()
	{
		return consultDate;
	}

	public void setConsultDate(Date consultDate)
	{
		this.consultDate = consultDate;
	}

	public String getConsultDescription()
	{
		return consultDescription;
	}

	public void setConsultDescription(String consultDescription)
	{
		this.consultDescription = consultDescription;
	}

	public String getConsulter()
	{
		return consulter;
	}

	public void setConsulter(String consulter)
	{
		this.consulter = consulter;
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
