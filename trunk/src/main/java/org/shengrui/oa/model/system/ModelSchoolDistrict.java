package org.shengrui.oa.model.system;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 校区设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelSchoolDistrict
extends ModelBase
{

	private static final long serialVersionUID = 1206326112546284444L;
	
	/**
	 * 校区编号
	 */
	private String districtNo;
	
	/**
	 * 校区地址
	 */
	private String districtAddress;
	
	/**
	 * 校区电话
	 */
	private String districtPhone;
	
	/**
	 * 校区类型
	 */
	private Integer districtType;
	
	/**
	 * 校区上级
	 */
	private ModelSchoolDistrict districtParent;
	
	
	public String getDistrictNo()
	{
		return districtNo;
	}

	public void setDistrictNo(String districtNo)
	{
		this.districtNo = districtNo;
	}

	public String getDistrictAddress()
	{
		return districtAddress;
	}

	public void setDistrictAddress(String districtAddress)
	{
		this.districtAddress = districtAddress;
	}

	public String getDistrictPhone()
	{
		return districtPhone;
	}

	public void setDistrictPhone(String districtPhone)
	{
		this.districtPhone = districtPhone;
	}

	public Integer getDistrictType()
	{
		return districtType;
	}

	public void setDistrictType(Integer districtType)
	{
		this.districtType = districtType;
	}

	public ModelSchoolDistrict getDistrictParent()
	{
		return districtParent;
	}

	public void setDistrictParent(ModelSchoolDistrict districtParent)
	{
		this.districtParent = districtParent;
	}
	
}
