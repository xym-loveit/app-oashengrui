package org.shengrui.oa.model.hrm;

import java.util.Date;

import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 员工履历
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmEmployeeRoadMap
extends ModelBase
{

	private static final long serialVersionUID = 7147905758297757123L;
	
	/**
	 * 员工
	 */
	private ModelHrmEmployee employee;
	
	/**
	 * 原校区
	 */
	private ModelSchoolDistrict orginalDistrict;
	
	/**
	 * 原部门
	 */
	private ModelSchoolDepartment orginalDepartment;
	
	/**
	 * 原岗位
	 */
	private ModelSchoolDepartmentPosition orginalDepartmentPosition;
	
	/**
	 * 目的校区
	 */
	private ModelSchoolDistrict dstDistrict;
	
	/**
	 * 目的部门
	 */
	private ModelSchoolDepartment dstDepartment;
	
	/**
	 * 目的岗位
	 */
	private ModelSchoolDepartmentPosition dstDepartmentPosition;
	
	/**
	 * 发生类型
	 */
	private Integer type;
	
	/**
	 * 发生时间
	 */
	private Date date;
	
	/**
	 * The enumeration of interview state
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum ERoadMapType
	{
		ONBOARD(1, "onboard"),							// 入职
		BEREGULAR (2, "beregular"),						// 转正
		TRANSFER(3, "transfer"),							// 调动
		FAIRWELL(4, "fairwell"),								// 离职
		FIRED(5, "fired"),										// 辞退
		PROMOTION(6, "promotion");						// 晋升
		
		private Integer value;
		private String text;
		
		ERoadMapType (Integer value, String text)
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
	
	public ModelHrmEmployee getEmployee()
	{
		return employee;
	}

	public void setEmployee(ModelHrmEmployee employee)
	{
		this.employee = employee;
	}

	public ModelSchoolDistrict getOrginalDistrict()
	{
		return orginalDistrict;
	}

	public void setOrginalDistrict(ModelSchoolDistrict orginalDistrict)
	{
		this.orginalDistrict = orginalDistrict;
	}

	public ModelSchoolDepartment getOrginalDepartment()
	{
		return orginalDepartment;
	}

	public void setOrginalDepartment(ModelSchoolDepartment orginalDepartment)
	{
		this.orginalDepartment = orginalDepartment;
	}

	public ModelSchoolDepartmentPosition getOrginalDepartmentPosition()
	{
		return orginalDepartmentPosition;
	}

	public void setOrginalDepartmentPosition(
			ModelSchoolDepartmentPosition orginalDepartmentPosition)
	{
		this.orginalDepartmentPosition = orginalDepartmentPosition;
	}

	public ModelSchoolDistrict getDstDistrict()
	{
		return dstDistrict;
	}

	public void setDstDistrict(ModelSchoolDistrict dstDistrict)
	{
		this.dstDistrict = dstDistrict;
	}

	public ModelSchoolDepartment getDstDepartment()
	{
		return dstDepartment;
	}

	public void setDstDepartment(ModelSchoolDepartment dstDepartment)
	{
		this.dstDepartment = dstDepartment;
	}

	public ModelSchoolDepartmentPosition getDstDepartmentPosition()
	{
		return dstDepartmentPosition;
	}

	public void setDstDepartmentPosition(
			ModelSchoolDepartmentPosition dstDepartmentPosition)
	{
		this.dstDepartmentPosition = dstDepartmentPosition;
	}

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public Date getDate()
	{
		return date;
	}

	public void setDate(Date date)
	{
		this.date = date;
	}
	
}
